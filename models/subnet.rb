require_relative 'c'

class Subnet
  attr_reader :input, :cs

  TABLE = {
    '30' => {n: 4,     h: 2,     m: '255.255.255.252'},
    '29' => {n: 8,     h: 6,     m: '255.255.255.248'},
    '28' => {n: 16,    h: 14,    m: '255.255.255.240'},
    '27' => {n: 32,    h: 30,    m: '255.255.255.224'},
    '26' => {n: 64,    h: 62,    m: '255.255.255.192'},
    '25' => {n: 128,   h: 126,   m: '255.255.255.128'},    
    '24' => {n: 256,   h: 254,   m: '255.255.255.0'  },
    '23' => {n: 512,   h: 510,   m: '255.255.254.0'  },
    '22' => {n: 1024,  h: 1022,  m: '255.255.252.0'  },
    '21' => {n: 2048,  h: 2046,  m: '255.255.248.0'  },
    '20' => {n: 4096,  h: 4094,  m: '255.255.240.0'  },
    '19' => {n: 8192,  h: 8190,  m: '255.255.224.0'  },
    '18' => {n: 16384, h: 16382, m: '255.255.192.0'  },
    '17' => {n: 32768, h: 32766, m: '255.255.128.0'  },
    '16' => {n: 65536, h: 65534, m: '255.255.0.0'    },
  }

  def initialize(ip)
    match = ip.match(/(?<a>\d{1,3})\.(?<b>\d{1,3})\.(?<c>\d{1,3})\.(?<d>\d{1,3})\s*\/(?<size>\d{2})/)
    @input = ip
    @a = match[:a].to_i
    @b = match[:b].to_i
    @c = match[:c].to_i
    @d = match[:d].to_i
    @size = match[:size]
    @mask = TABLE[@size][:m]
    @cs = generate_class_cs!
  end

  private

    def end_ip
      n = TABLE[@size][:n]
      {
        a: @a,
        b: @b,
        c: @c + ((n - 1) / 256),
        d: @d + ((n - 1) % 256)
      }
    end

    def c_values
      (@c..end_ip[:c])
    end

    def generate_class_cs!
      c_values.map do |c|
        C.new(self,@a,@b,c,@mask)
      end
    end


end