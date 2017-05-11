#!/usr/bin/env ruby

# file: rpi_pwm.rb

require 'pinx'
require 'rpi_gpio'


class RPiPwm < PinX


  attr_accessor :duty_cycle, :freq


  def initialize(pin_num, duty_cycle: 100, freq: 100)
    
    super(pin_num)

    @id, @duty_cycle, @freq = pin_num, duty_cycle, freq

    RPi::GPIO.set_numbering :bcm
    RPi::GPIO.setup pin_num, :as => :output

    @pwm = RPi::GPIO::PWM.new(pin_num, freq)
    @pwm.start 0

    at_exit { RPi::GPIO.clean_up pin_num}

  end
  

  def duty_cycle=(val)
    @duty_cycle = val
    @pwm.duty_cycle = val
  end
  
  def freq=(val)
    @freq = val
    @pwm.frequency = val
  end  

  def on(durationx=nil, duration: nil, duty_cycle: @duty_cycle, freq: @freq)

    self.duty_cycle = duty_cycle if duty_cycle
    self.freq = freq if freq
    super(durationx, duration: duration)

  end
    
  alias frequency freq  
  
  protected

  # set val with 0 (off) or 1 (on)
  #
  def set_pin(val)

    @pwm.duty_cycle =  val ? @duty_cycle : 0    
    super(val)
      
  end
  
end