class C
  attr_reader :subnet, :ticketmaster, :proxy, :axs
  def initialize(subnet,a,b,c,mask)
    @subnet = subnet
    @a = a
    @b = b
    @c = c
    @mask = mask
  end

  def generate_ips!(i)
    @ticketmaster = ticketmaster_ips(i)
    @proxy = proxy_ips(i)
    @axs = @proxy.sample(6)
  end

  private

    def ticketmaster_ips(i)
      ticketmaster_ds(i).map do |d|
        output(d)
      end
    end

    def proxy_ips(i)
      proxy_ds(i).map do |d|
        output(d)
      end
    end

    def ticketmaster_ds(i)
      case i % 2
      when 0 then [4, 6, 8, 11, 19, 20, 23, 27, 29, 31, 33, 38, 40, 42, 45, 47, 49, 51, 52]
      when 1 then [2, 3, 5, 7, 9, 15, 17, 21, 25, 30, 32, 34, 35, 37, 39, 41, 46, 48, 50]
      end
    end

    def proxy_ds(i)
      case i % 4
      when 0 then [66, 69, 71, 73, 76, 79, 82, 84, 87, 89, 92, 95, 97, 100, 102, 104, 106, 108, 111]
      when 1 then [113, 116, 118, 121, 124, 126, 129, 132, 134, 137, 139, 142, 145, 147, 149, 151, 153, 156, 158]
      when 2 then [160, 162, 165, 168, 171, 173, 176, 179, 181, 183, 186, 189, 192, 194, 197, 199, 201, 203, 206]
      when 3 then [209, 212, 215, 218, 221, 224, 226, 228, 230, 233, 235, 238, 240, 242, 244, 246, 248, 251, 253]
      end
    end

    def output(d)
      [[@a,@b,@c,d].join("."),@mask].join(",")
    end

end