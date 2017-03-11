# Clase encargada de realizar las pruebas de bondad?
class Writer
    # Metodo encargado de escribir en un fichero los numeros generados.
    def self.write (pFileName, pData, pDecimals) 
        open(pFileName, 'w') { |file|
            pData.each do |number|
             file.puts "%.#{pDecimals}f" % number
            end
        }
    end
end