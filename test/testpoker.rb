require 'colorize'

class TestPoker
    # Metodo encargado de realizar la prueba de poker con k = pDecimals (2 o 3)
    def self.doPoker(pDecimals, pDataStr, pCriticalValue)
        if pDecimals == 2
            classes = ["2 matches   ", "2 differents"]
            probabilities_poker = [0.1, 0.9] # [10/10**2, 10*9/10**2]
        elsif pDecimals == 3
            classes = ["3 matches       ", "2 matches, 1 dif", "3 differents    "]
            probabilities_poker = [0.01, 0.27, 0.72]
        end
        observedFrecuency = calculateObservedFrecuency(pDecimals, pDataStr)
        expectedFrequecy = Array.new
        # Calcular las frecuencias esperadas
        probabilities_poker.each do |prob_i|
            expectedFrequecy << pDataStr.size*prob_i
        end
        # Se calcula el error ((FE-FO)^2)/FE para cada clase
        chiValues = Array.new
        (0..pDecimals-1).each do |i|
            chiValues << ((expectedFrequecy[i].to_f - observedFrecuency[i].to_f) ** 2) / expectedFrequecy[i].to_f
        end
        # Sumar los valores
        chiResult = chiValues.inject(0, :+)
        printTable(classes, expectedFrequecy, observedFrecuency, chiValues)
        printResultChi(chiResult, pCriticalValue)
    end
    
    # Determina la frecuencia observada para cada clase para K=3 y K=2
    def self.calculateObservedFrecuency(pK, pDataStr)
        observedFrecuency = Array.new(pK, 0)
        pDataStr.each do |data|
            # Cortar parte decimal del dato y mapear a array de enteros
            arr = data.split(".")[1].to_s.split('').map(&:to_i)
            # Determinar frecuencias de cada valor en el array
            freq = arr.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
            # Contar apariciones del elemento más repetido
            i_max = arr.count(arr.max_by { |v| freq[v] })
            observedFrecuency[i_max-1]+=1
        end
        observedFrecuency.reverse
    end
    
    # 
    def self.printTable(classes, fe, fo, errorValues)
        puts "----------------------------|----------------|-------------|-------------"
        puts "Clase                       | FE             | FO          | error       "
        puts "----------------------------|----------------|-------------|-------------"
        errorValues.each_with_index do |error, index|
            puts "%s %21s %20s %20s" % [classes[index], fe[index].to_s, fo[index].to_s, error.round(4).to_s]
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