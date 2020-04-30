import Foundation

class VendingMachineProduct {
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
    case color
}
}

extension VendingMachineError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .productNotFound:

            return "Produto não foi encontrado."
        case.productUnavailable:
            return "Produto indisponível."
        case .productStuck:
            return "O produto está em fase de processamento."
        case .insufficientFunds:
            return "Ainda falta dinheiro"
        case .color:
 
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
        guard var produto = produtoOptional else  { throw VendingMachineError.productNotFound }
        
        //TODO: ver se ainda tem esse produto
        guard produto.amount > 0 else { throw VendingMachineError.productUnavailable }
        
        //TODO: ver se o dinheiro é o suficiente pro produto
        guard produto.price <= self.money else { throw VendingMachineError.insufficientFunds }
        
        //TODO: entregar o produto
        self.money += money
        
        let produtoOptional = estoque.first { (produto) -> Bool in
            return produto.name == name
        }
        guard let produto = produtoOptional else { throw VendingMachineError.productNotFound }
        
        guard produto.amount > 0 else { throw VendingMachineError.productUnavailable }
        
        guard produto.price <= self.money else { throw VendingMachineError.insufficientFunds }
 
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
        VendingMachineProduct(name: "Capa", amount: 2, price: 50.00),
        VendingMachineProduct(name: "Fone de ouvido", amount: 5, price: 90.00),
        VendingMachineProduct(name: "Película", amount: 1, price: 50.00)
    ])
    
    do {
        try vendingMachine.getProduct(named: "Capa", with:  40.0)
        try vendingMachine.getProduct(named: "Película", with:  40.0)
    print("Deu certo!")
        
    } catch VendingMachineError.productStuck {
    print("Ainda não deu certo")
        
    } catch {
    print(error.localizedDescription)
}

