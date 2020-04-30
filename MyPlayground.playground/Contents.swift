import Foundation

struct VendingMachineProduct {
    var name: String
    var amount: Int
    var price: Double
    
    init(name: String, amount: Int, price: Double) {
        self.name = name
        self.amount = amount
        self.price = price
    }
}

//TODO: Definir os erros
enum VendingMachineError: Error {
    case productNotFound
    case productUnavailable
    case insufficientFunds
    case productStuck
}

extension VendingMachineError: LocalizedError {
    var errorDescription: String? {
        
        switch self {
        case .productNotFound:
            return  "não foi"
        case.productUnavailable:
            return "acabou"
        case .insufficientFunds:
            return "produto peso"
        case .productStuck:
            return "falta dinheiro"
        }
    }
}

class VendingMachine {
    private var estoque: [VendingMachineProduct]
    private var money: Double
    
    init(products: [VendingMachineProduct]) {
        self.estoque = products
        self.money = 0
    }
    
    func getProduct(named name: String, with money: Double) throws {
        //TODO: receber o dinheiro e salvar em uma variável
        self.money = money
        
        //TODO: achar o produto que o cliente quer
        let produtoOptional = estoque.first{ (produto) -> Bool in
            return produto.name == name
        }
        guard var produto = produtoOptional else  { throw VendingMachineError.productNotFound  }
        
        //TODO: ver se ainda tem esse produto
        guard produto.amount > 0 else { throw VendingMachineError.productUnavailable }
        
        //TODO: ver se o dinheiro é o suficiente pro produto
        guard produto.price <= self.money else { throw VendingMachineError.insufficientFunds }
        
        //TODO: entregar o produto
        self.money -= produto.price
        produto.amount -= 1
        
        if Int.random(in: 0...100) < 10 {
            throw VendingMachineError.productStuck
        }
    }
    
    func getTroco() -> Double {
        //TODO: devolver o dinheiro que não foi gasto
        let money = self.money
        self.money =  0.0
        
        return money
    }
}
    
    let vendingMachine = VendingMachine(products: [ VendingMachineProduct(name: "Carregador de iPhone", amount: 5, price: 150.00),
        VendingMachineProduct(name: "Funnions", amount: 2, price: 7.00),
        VendingMachineProduct(name: "Umbrella", amount: 5, price: 125.00),
        VendingMachineProduct(name: "Trator", amount: 1, price: 75000.00)
    ])
    
    do {
        try vendingMachine.getProduct(named: "Umbrella", with:  40.0)
        try vendingMachine.getProduct(named: "Funnions", with:  40.0)
    print("deu bom")
    } catch VendingMachineError.productStuck {
    print("deu erro")
    } catch {
    print(error.localizedDescription)
}


