# -*- coding: utf-8 -*-
require "chopsticks"
require File.dirname(__FILE__) + '/spec_helper'

describe String, "When display screen," do

  it 'ascii string should be sliced as' do
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ".display_slice(5).should == "ABCDE"
    "ABCDE".display_slice(8).should == "ABCDE   "
    "  ABCDE".display_slice(5).should == "  ABC"
  end

  it 'multibyte string should be sliced as' do
    "あいうえおかきくけこ".display_slice(5).should == "あい "
    "あいうえおかきくけこ".display_slice(6).should == "あいう"
    "あいうえお".display_slice(20).should == "あいうえお          "
    "あいうえお".display_slice(19).should == "あいうえお         "
    "http://あいうえお".display_slice(10).should == "http://あ "
    "http://あいうえお".display_slice(20).should == "http://あいうえお   "
    ("1234567890" * 20 + "1234").display_slice(204).should == "1234567890" * 20 + "1234"
    "Block Rockin’ Codes".display_slice(30).should == "Block Rockin' Codes           "
  end
  
end
