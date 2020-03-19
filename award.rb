# Award = Struct.new(:name, :expires_in, :quality)

class Award 
    attr_accessor :name, :expires_in
    attr_writer :quality

    def initialize(name, expires_in, quality)
        @name = name
        @expires_in = expires_in
        @quality = quality

        enforce_quality_bounds
    end

    def update
        update_expiration
        update_quality
    end

    def update_expiration
        self.expires_in -= 1 unless self.name == "Blue Distinction Plus"
    end

    def update_quality
        return if self.name == "Blue Distinction Plus"

        case self.name
        when 'Blue Star'
            self.quality -= 2
            self.quality -= 2 if expired?
        when 'Blue First'
            self.quality += 1
            self.quality += 1 if expired?
        when 'Blue Compare'
            unless expired?
                self.quality += 1
                self.quality += 1 if self.expires_in < 10
                self.quality += 1 if self.expires_in < 5
            else
                self.quality = 0
            end
        else
            self.quality -= 1
            self.quality -= 1 if expired?
        end

        enforce_quality_bounds
    end

    def quality
        self.name == "Blue Distinction Plus" ? 80 : @quality
    end

    def enforce_quality_bounds
        if self.quality > 50
            self.quality = 50
        elsif self.quality < 0
            self.quality = 0
        end
    end

    def expired? 
        self.expires_in < 0
    end
end



