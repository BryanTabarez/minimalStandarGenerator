require_relative 'generator/generator'
require_relative 'fileutils/writer'
require_relative 'test/testchi'
require_relative 'test/testpoker'
require_relative 'util/util'

# Indica la cantidad de decimales de los numeros generados.
DECIMALS = 3
# Prefijo de los ficheros
FILE_PREFIX_GEM = 'out/GEM'
# Prefijo de los ficheros ruby.
FILE_PREFIX_RUBY = 'out/RUBY'
# Postfijo de los ficheros
FILE_POSTFIX = '.txt'
# Solo los necesarios v/p:  31/0.1 y 100/0.1
CHISQUAREDDISTRIBUTION = Hash[1000=>41.4217, 10000=>118.4980]


# n: cantidad de números a generar para el test
def runTest(genData)
    puts "======================================================================"
    puts "PRUEBA CON #{genData.size} DATOS"
    
    criticalValue = CHISQUAREDDISTRIBUTION[genData.size]
    
    puts "CHI CUADRADO"
    TestChi.doChiSquareTest(genData, criticalValue)
    # convertir a strings recortando la cantidad de decimales requerida

    puts "PRUEBA DE POKER CON K = 2"
    dataStr = Util.generateStringData(genData, 2)
    TestPoker.doPoker(2, dataStr, 2.7055)
    
    puts "PRUEBA DE POKER CON K = 3"
    # convertir a strings recortando la cantidad de decimales requerida
    dataStr = Util.generateStringData(genData, 3)
    TestPoker.doPoker(3, dataStr, 4.6052)
end

def main
    # Inicializamos el generador para 1000.
    generator = Generator.new(1000)
    genData = generator.minimalStandarGenerator(Random.rand())
    puts "GENERADOR ESTANDAR MINIMO".blue
    runTest(genData)
    # Escribimos el archivo de numeros generados.
    filename = FILE_PREFIX_GEM + genData.size.to_s + FILE_POSTFIX
    Writer.write(filename, genData, 3)
    
    genData = generator.rubyRandom()
    puts "GENERADOR DEL LENGUAJE (RUBY)".blue
    runTest(genData)
    # Escribimos el archivo de numeros generados.
    filename = FILE_PREFIX_RUBY + genData.size.to_s + FILE_POSTFIX
    Writer.write(filename, genData, 3)
    
    # Inicializamos el generador para 10000.
    generator = Generator.new(10000)
    genData = generator.minimalStandarGenerator(Random.rand())
    runTest(genData)
    # Escribimos el archivo de numeros generados.
    filename = FILE_PREFIX_GEM + genData.size.to_s + FILE_POSTFIX
    Writer.write(filename, genData, 3)
    
    genData = generator.rubyRandom()
    runTest(genData)
    # Escribimos el archivo de numeros generados.
    filename = FILE_PREFIX_RUBY + genData.size.to_s + FILE_POSTFIX
    Writer.write(filename, genData, 3)
    
end


if __FILE__ == $0
    begin
        main()
    end
end
