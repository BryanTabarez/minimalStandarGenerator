class Util
    def self.generateStringData(genData, ndecimals)
        dataStr = Array.new
        genData.each do |number|
            dataStr << "%.#{ndecimals}f" % number
        end
        dataStr
    end
end