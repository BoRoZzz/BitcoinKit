import XCTest
import Cuckoo
import RealmSwift
@testable import WalletKit

class TransactionSaverTests: XCTestCase {

    private var mockRealmFactory: MockRealmFactory!
    private var saver: TransactionSaver!

    private var realm: Realm!
    private var transaction: Transaction!
    private var rawTransaction: String!

    override func setUp() {
        super.setUp()

        mockRealmFactory = MockRealmFactory(configuration: Realm.Configuration())
        saver = TransactionSaver(realmFactory: mockRealmFactory)

        realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "TestRealm"))
        try! realm.write { realm.deleteAll() }

        rawTransaction = "0100000001865c106cd7a90c80e5447f6e2891aaf5a0d11fb29e1a9258dce26da7ef04c028000000004847304402205c54aa165861bf5347683fb078a99188726ee2577e3554d0f77ad7c60a4b072902206f77f42f216e4c64585a60ec76a944fc83278524e5a0dfda31b58f94035d27be01ffffffff01806de7290100000017a914121e63ee09fc7e20b59d144dcce6e2700f6f1a9c8700000000"
        transaction = Transaction.deserialize(Data(hex: rawTransaction)!)

        stub(mockRealmFactory) { mock in
            when(mock.realm.get).thenReturn(realm)
        }
    }

    override func tearDown() {
        mockRealmFactory = nil
        saver = nil
        realm = nil

        super.tearDown()
    }

    func testCreate() {
        try! saver.save(transaction: transaction)
        let realmTransaction = realm.objects(Transaction.self).last!

        assertTransactionEqual(tx1: transaction, tx2: realmTransaction)
    }

    private func assertTransactionEqual(tx1: Transaction, tx2: Transaction) {
        XCTAssertEqual(tx1, tx2)
        XCTAssertEqual(tx1.reversedHashHex, tx2.reversedHashHex)
        XCTAssertEqual(tx1.version, tx2.version)
        XCTAssertEqual(tx1.lockTime, tx2.lockTime)
        XCTAssertEqual(tx1.inputs.count, tx2.inputs.count)
        XCTAssertEqual(tx1.outputs.count, tx2.outputs.count)

        for i in 0..<tx1.inputs.count {
            XCTAssertEqual(tx1.inputs[i].previousOutputTxReversedHex, tx2.inputs[i].previousOutputTxReversedHex)
            XCTAssertEqual(tx1.inputs[i].previousOutputIndex, tx2.inputs[i].previousOutputIndex)
            XCTAssertEqual(tx1.inputs[i].signatureScript, tx2.inputs[i].signatureScript)
            XCTAssertEqual(tx1.inputs[i].sequence, tx2.inputs[i].sequence)
        }

        for i in 0..<tx2.outputs.count {
            assertOutputEqual(out1: tx1.outputs[i], out2: tx2.outputs[i])
        }
    }

    private func assertOutputEqual(out1: TransactionOutput, out2: TransactionOutput) {
        XCTAssertEqual(out1.value, out2.value)
        XCTAssertEqual(out1.lockingScript, out2.lockingScript)
        XCTAssertEqual(out1.index, out2.index)
    }

}