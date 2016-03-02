class BasePolicy
  extend Expositor

  def initialize(name)
    @name = name
  end

  def john?
    @name == 'John'
  end

  def jack?
    @name == 'Jack'
  end

  def james?
    @name == 'James'
  end
end

describe 'Expositor included' do
  context 'work for all methods' do
    before do
      class NamingPolicy < BasePolicy;  end
    end

    it { expect(NamingPolicy.john?('John')).to be_truthy }
    it { expect(NamingPolicy.jack?('Jack')).to be_truthy }
    it { expect(NamingPolicy.james?('James')).to be_truthy }
  end

  context 'work only for :only: methods' do
    before do
      class NamingPolicy < BasePolicy
        expose only: %i(john? jack?)
      end
    end

    it { expect(NamingPolicy.john?('John')).to be_truthy }
    it { expect(NamingPolicy.jack?('Jack')).to be_truthy }
    it { expect{NamingPolicy.james?('James')}.to raise_error(NoMethodError,
                          "undefined method `james?' for NamingPolicy:Class") }
  end

  context 'work for all excpet :except: methods' do
    before do
      class NamingPolicy < BasePolicy
        expose except: %i(john?)
      end
    end

    it { expect(NamingPolicy.jack?('Jack')).to be_truthy }
    it { expect(NamingPolicy.james?('James')).to  be_truthy }
    it { expect{NamingPolicy.john?('John')}.to raise_error(NoMethodError,
                            "undefined method `john?' for NamingPolicy:Class") }
  end

  context 'work for :only: and dont work for :except: methods' do
    before do
      class NamingPolicy < BasePolicy
        expose only: %i(jack? john?), except: %i(john?)
      end
    end

    it { expect(NamingPolicy.jack?('Jack')).to be_truthy }
    it { expect{NamingPolicy.john?('John')}.to raise_error(NoMethodError,
                            "undefined method `john?' for NamingPolicy:Class") }
    it { expect{NamingPolicy.james?('James')}.to raise_error(NoMethodError,
                            "undefined method `james?' for NamingPolicy:Class") }
  end
end
