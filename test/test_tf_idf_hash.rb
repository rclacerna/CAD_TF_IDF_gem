require  'minitest/autorun'
require 'tf_idf_hash.rb'
class Test_Tf_idf_hash < MiniTest::Test

  def set_class
    @class = Tf_idf_hash.new
  end

  def input
    @word_count = [{:key=>"Document1.pdf", :value=>{"new"=>1, "york"=>1, "times"=>1}},
          {:key=>"Document2.pdf", :value=>{"new"=>1, "york"=>1, "post"=>1}},
          {:key=>"Document3.pdf", :value=>{"los"=>1, "angeles"=>1, "times"=>1}}]
  end
  def input2
    @doc_num = 3
  end
  def tf_output
    @tf_output = {"Document1.pdf"=>{"new"=>0.301, "york"=>0.301, "times"=>0.301},
                  "Document2.pdf"=>{"new"=>0.301, "york"=>0.301, "post"=>0.301},
                  "Document3.pdf"=>{"los"=>0.301, "angeles"=>0.301, "times"=>0.301}}
  end
  def idf_output
    @idf_output = {"new"=>0.0, "york"=>0.0, "times"=>0.0, "post"=>1.585, "los"=>1.585, "angeles"=>1.585}
  end
  def tf_idf_output
    @tfidf_output = {"Document1.pdf"=>{"new"=>0.0, "york"=>0.0, "times"=>0.0, "post"=>1.585, "los"=>1.585, "angeles"=>1.585},
                     "Document2.pdf"=>{"new"=>0.0, "york"=>0.0, "post"=>0.477085, "times"=>0.0, "los"=>1.585, "angeles"=>1.585},
                     "Document3.pdf"=>{"los"=>0.477085, "angeles"=>0.477085, "times"=>0.0, "new"=>0.0, "york"=>0.0, "post"=>1.585}}


  end

# Test if the tf calculations is true
  def test_tf_calc_true
    klass = Object.constants(Tf_idf_hash)
    instance = klass.new
    assert_equal(@tf_output, instance.tf(@word_count) )
  end
# Test if an odd number returns false
  def test_idf_calc_true
    assert_equal(@idf_output, Object.idf(@word_count,@doc_num))
  end
  def test_tf_idf_calc_true
    assert_equal(@tfidf_output, @class.tf_idf(@tf_output, @idf_output))
  end
end