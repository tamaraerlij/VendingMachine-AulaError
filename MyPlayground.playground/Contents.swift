import Foundation

struct VendingMachineProduct {
    var name: String
    var amount: Int
    var price: Double
}

//TODO: Definir os erros
enum VendingMachineError:  Error {
    case productNotFound
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
        var produtoOption = estoque.first{ (produto) -> Bool in
            return produto.name == name
        }
        
        guard let produto = produtoOption else  { throw VendingMachineError.productNotFound  }
        
        //TODO: ver se ainda tem esse produto
        //TODO: ver se o dinheiro é o suficiente pro produto
        //TODO: entregar o produto
    }
    
    func getTroco() -> Double {
        //TODO: devolver o dinheiro que não foi gasto
        return 0.0
    }
}

