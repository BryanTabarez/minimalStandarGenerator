require 'colorize'

# Clase encargada de realizar las pruebas de bondad
class TestChi
    
    # Metodo encargado de realizar la prueba de chi cuadrado.
    def self.doChiSquareTest(pData, pCriticalValue)
        groupsAmount = Math.sqrt(pData.size).ceil # Número de clases
        incrementInterval = 1.0 / groupsAmount # incremento de intervalos
        # Generar arreglo de intervalos
        limitsArr = 0.0.step(1,incrementInterval).to_a
        dataSorted = pData.sort # ordenar datos
        # calculamos la frecuencia observada para cada intervalo
        observedFrecuency = calculateFrecuency(dataSorted, limitsArr)
        # Calculamos la frecuencia esperada.
        expectedFrequecy = (pData.size / groupsAmount).to_f

        # Se calcula el error ((FE-FO)^2)/FE para cada clase
        chiValues = Array.new()
        observedFrecuency.each do |oF|
            chiValues << ((expectedFrequecy - oF) ** 2) / expectedFrequecy
        end
        # Sumar los valores
        chiResult = chiValues.inject(0, :+)
        
        # Imprimir tabla | Clases | FE | FO | error |
        printTable(limitsArr, expectedFrequecy, observedFrecuency, chiValues)
        printResultChi(chiResult, pCriticalValue)
    end
    
    # Determina la frecuencia observada para cada clase (intervalo)
    # @param pLimits Arreglo de limites.
    # @param pNumbersSorted Arreglo de numeros ordenados.
    def self.calculateFrecuency (pNumbersSorted, pLimits)
        # Variable para recorrer la lista de limites.
        it = 0
        # Inicializar el arreglo
        observedFrecuency = Array.new(pLimits.size-1, 0.0)
        # Recorrer el arreglo de datos ordenados
        pNumbersSorted.each do |number|
           if (number <= pLimits[it+1])
               observedFrecuency[it] += 1
           else
               it += 1
           end
        end
        # Retornamos el array de la frecuencia observada
        observedFrecuency
    end
    
    # Imprimir tabla | Clases | FE | FO | error |
    def self.printTable(intervalArr, fe, fo, errorValues)
        puts "----------------------------|----------------|-------------|-------------"
        puts "Clase                       | FE             | FO          | error"
        puts "----------------------------|----------------|-------------|-------------"
        errorValues.each_with_index do |error, index|
            clases = "%2i. [%.4f-%.4f]" % [index, intervalArr[index], intervalArr[index+1]]
            puts "%s %15s %15s %15s" % [clases, fe.to_s, fo[index].to_s, error.round(4).to_s]
        end
    end
    
    def self.printResultChi(chiResult, pCriticalValue)
        # Pintamos el resultado
        puts "Critical value: #{pCriticalValue.to_s.yellow}"
        puts "Chi square: #{chiResult.to_s.yellow}"
        # Determinamos si el test fallo o no.
        if(chiResult <= pCriticalValue)
            puts "PASS THE TEST.".green
        else
            puts "FAIL THE TEST.".red
        end
    end
    
end