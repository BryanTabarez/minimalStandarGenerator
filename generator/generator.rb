# Clase encargada de gestionar las utilidades para la generacion de numeros aleatorios.

class Generator
    
    # Se inicializa el generador especificando la cantidad de números a genererar
    # pAmount cantidad de números a generar
    def initialize(pAmount)
        @pAmount = pAmount
    end

    # Genera numeros aleatorios
    def minimalStandarGenerator(seed)
        data = Array.new
        a = 7.0 ** 5
        c = 0.0
        m = (2.0 ** 31) - 1
        (0..@pAmount - 1).each do |i|
            seed = (a * seed + c) % m
            data << (seed / m)
        end
        data
    end
    # Genera números aleatorios con la función rand() de ruby.
    # @param pAmount Cantidad de numeros a generar.
    # @param pDecimals Decimales de los numeros generados.
    def rubyRandom ()
        @pAmount.times.map{rand()}
    end
end