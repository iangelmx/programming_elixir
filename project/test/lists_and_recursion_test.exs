defmodule ListsAndRecursionTest do
  use ExUnit.Case
  alias ListsAndRecursion, as: LAR

  doctest ListsAndRecursion

  @test_data1 [1, 2, 3, 4, 5]
  @test_data2 [0, 1, 0, 2, 6]
  @test_data3 [1, 2, 5, 1]
  @test_data4 [9]
  @test_data5 'cat'
  @test_data6 'bizarre'

  test "Test result of Reduce function" do
    simul_output_1 = 15
    simul_output_2 = 0
    simul_output_3 = 1
    simul_output_4 = 81

    assert LAR.reduce(@test_data1, 0, fn a, b -> a + b end) == simul_output_1
    assert LAR.reduce(@test_data2, 0, fn a, b -> a * b end) == simul_output_2
    assert LAR.reduce(@test_data3, 1, &(&1 || &2)) == simul_output_3
    assert LAR.reduce(@test_data4, 1, fn a, b -> a * a * b end) == simul_output_4
  end

  test "Test mapsum function" do
    simul_output_1 = 30
    simul_output_2 = 42
    simul_output_3 = 10
    simul_output_4 = 91

    assert LAR.mapsum(@test_data1, 0, fn a -> a + a end) == simul_output_1
    assert LAR.mapsum(@test_data2, 1, fn a -> a * a end) == simul_output_2
    assert LAR.mapsum(@test_data3, 1, &(&1 || &1)) == simul_output_3
    assert LAR.mapsum(@test_data4, 10, fn a -> a * a end) == simul_output_4
  end

  test "Test caesar function" do
    simul_output_5 = 'hfy'
    simul_output_6 = 'cjabssf'

    assert LAR.caesar(@test_data5, 5) == simul_output_5
    assert LAR.caesar(@test_data6, 1) == simul_output_6
  end
end
