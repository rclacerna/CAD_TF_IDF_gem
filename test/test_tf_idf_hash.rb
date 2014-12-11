# Unit tests for tf_idf_hash
# Ryan Lacerna

require  'minitest/autorun'
require 'tf_idf_hash'
  class Test_Tf_idf_hash < MiniTest::Test

# Test if the tf calculations is true
  def test_tf_calc_true
    @word_count = [{:key=>"Document1.pdf", :value=>{"new"=>1, "york"=>1, "times"=>1}},
                   {:key=>"Document2.pdf", :value=>{"new"=>1, "york"=>1, "post"=>1}},
                   {:key=>"Document3.pdf", :value=>{"los"=>1, "angeles"=>1, "times"=>1}}]
    @doc_num = 3
    tf_output = {"Document1.pdf"=>{"new"=>0.301, "york"=>0.301, "times"=>0.301},
                  "Document2.pdf"=>{"new"=>0.301, "york"=>0.301, "post"=>0.301},
                  "Document3.pdf"=>{"los"=>0.301, "angeles"=>0.301, "times"=>0.301}}
   @class =  Tf_idf_hash.new(@word_count, @doc_num)
   tf = @class.tf
   assert_equal(tf_output, tf)
  end

# test if IDF formula is accurate
  def test_idf_calc_true
    @word_count = [{:key=>"Document1.pdf", :value=>{"new"=>1, "york"=>1, "times"=>1}},
                   {:key=>"Document2.pdf", :value=>{"new"=>1, "york"=>1, "post"=>1}},
                   {:key=>"Document3.pdf", :value=>{"los"=>1, "angeles"=>1, "times"=>1}}]
    @doc_num = 3
    @class =  Tf_idf_hash.new(@word_count, @doc_num)
    idf = @class.idf
    idf_output = {"new"=>0.0, "york"=>0.0, "times"=>0.0, "post"=>1.585, "los"=>1.585, "angeles"=>1.585}
    assert_equal(idf_output, idf)
  end

  # test if TF-IDF formula is accurate
  def test_tf_idf_calc_true
    @class =  Tf_idf_hash.new(@word_count, @doc_num)

    tfidf_output = {"Document1.pdf"=>{"new"=>0.0, "york"=>0.0, "times"=>0.0, "post"=>1.585, "los"=>1.585, "angeles"=>1.585},
                     "Document2.pdf"=>{"new"=>0.0, "york"=>0.0, "post"=>0.477085, "times"=>0.0, "los"=>1.585, "angeles"=>1.585},
                     "Document3.pdf"=>{"los"=>0.477085, "angeles"=>0.477085, "times"=>0.0, "new"=>0.0, "york"=>0.0, "post"=>1.585}}
    idf_output = {"new"=>0.0, "york"=>0.0, "times"=>0.0, "post"=>1.585, "los"=>1.585, "angeles"=>1.585}
    tf_output = {"Document1.pdf"=>{"new"=>0.301, "york"=>0.301, "times"=>0.301},
                  "Document2.pdf"=>{"new"=>0.301, "york"=>0.301, "post"=>0.301},
                  "Document3.pdf"=>{"los"=>0.301, "angeles"=>0.301, "times"=>0.301}}

   tfidf = @class.tf_idf(tf_output, idf_output)
    assert_equal(tfidf_output, tfidf)
  end
end