#  TF-IDF of files
#  Cloud Application Development module
#  Author: Ryan Lacerna


class Tf_idf_hash
  def initialize(files, doc_num)
    @file = files
    @doc_num = doc_num
  end

  def max_freq
    arr = []
    @file.each do |f|
      arr << f[:value]
      arr2 = []
      val = []
      arr.flat_map(&:entries).group_by(&:first).map{|k,v|
        val << [k, v.map(&:last)]
        values = Hash[val]
        values.each do |key, value|
          @values = value.inject {|sum,n| sum + n}
        end
        arr2 << @values
      }
      arr2 = arr2.sort do |a,b| b <=> a end
      @max = arr2[0]
    end
    @max
  end

  # calculates the idf, idf gives high weights to rare words in the collection of files
  def idf
    word_n_count= []
    @file.each do |hash|
      hash[:value]
      word_n_count << hash[:value]
      val = []
      my_arr = []
      word_n_count.flat_map(&:entries).group_by(&:first).map{|k,v|
        val << [k, v.map(&:last)]
        values = Hash[val]
        values.each do |key, value|                       # gets the key and value in the hash
          @key = key
          value = value.inject {|sum,n| sum + n}         # add all the count values together
          @idf = Math.log2(@doc_num/value).round(4)      # IDF formula
        end
        my_arr << @key << @idf                            # push key and idf values to arr
        @idf = Hash[*my_arr]                              # turns array to a hash table
      }
    end
    @idf
  end

# Term frequency weights, using the term count, we use the tf formula to get the weights
  def tf(max_freq)
    tf_arr = []
    @file.each do |hash|
      @word_n_count= []
      @doc_name = hash[:key]
      hash = hash[:value]                                  # :key => document1.pdf, :value=>{"los"=>1, "angeles"=>1, "times"=>1}
      hash.each do |counts|
        @keys = counts[0]                                  # gets the term
        @tf = Math.log10((counts[1]/max_freq)+1.0).round(3)          # Normalized TF weight formula
        @word_n_count << @keys << @tf                      # puts term keys and TF values
      end
      tf_arr << @doc_name << Hash[*@word_n_count]
      @tf = Hash[*tf_arr]                                 # turn @tf_arr to a hash table
    end
    @tf
  end

# TF * IDF, we multiply the IDF with each TF values in every doc. We also get the Document length here.
  def tf_idf(tf, idf)
    tf_idf_hash =[]
    tf.each do |docname, value|
      arr = []
      new_arr = []
      total_tf_idf = []
      arr << value << idf
      arr.flat_map(&:entries).group_by(&:first).map{|k,v|# we group the TF with IDF values together with each doc with similar words
        new_arr << [k, v.map(&:last)]                    # e.g "new" => [tf,idf]
        val = Hash[new_arr]                              # e.g for each doc : {"los"=>[0.778, 1.585], "angeles"=>[0.0, 1.585], "times"=>[0.778, 0.0], "new"=>[0.0], "york"=>[0.0], "post"=>[1.585]}
        myarr = []                                       # arr to store the values to be injected for DocLength
        val.each do |key, values|                        # gets keys and values
          @key = key
          @tf_idf_values = values.inject{|tf, idf| tf *idf}    # multiplies tf with idf in all words and docs
        end
        total_tf_idf << @key << @tf_idf_values          # shows TF IDF and words associated e.g ["new", 0.0, "york", 0.0, "post", 0.756045, "times", 0.0, "los", 1.585, "angeles", 1.585]
        @answer = Hash[*total_tf_idf]                   # converts the array to hash of key values pairs
      }
      tf_idf_hash << docname << @answer                 # we add the file name as key for the value : {"los"=>1.23313, "angeles"=>0.0, "times"=>0.0, "new"=>0.0, "york"=>0.0, "post"=>1.585}
      @tf_idf = Hash[*tf_idf_hash]                      # converts array to hash
    end
    @tf_idf                                             # {"Document1.pdf"=>{"new"=>0.0, "york"=>0.0, "times"=>0.0, "post"=>1.585, "los"=>1.585, "angeles"=>1.585},
#e.g output "Document2.pdf"=>{"new"=>0.0, "york"=>0.0, "post"=>0.756045, "times"=>0.0, "los"=>1.585, "angeles"=>1.585}, "Document3.pdf"=>{"los"=>1.23313, "angeles"=>0.0, "times"=>0.0, "new"=>0.0, "york"=>0.0, "post"=>1.585}}
  end
end

#
=begin

#------------------Inputs---------------------------------
file = [{:key=>"Document1.pdf", :value=>{"new"=>1, "york"=>1, "times"=>1}},
        {:key=>"Document2.pdf", :value=>{"new"=>1, "york"=>1, "post"=>1}},
        {:key=>"Document3.pdf", :value=>{"los"=>1, "angeles"=>1, "times"=>1}}]
N = 3
#------------------------------------------------------------------

myclass = Tf_idf_hash.new(file, N)
max_freq = myclass.max_freq
my_tf = myclass.tf(max_freq)
my_idf = myclass.idf
my_tf_idf = myclass.tf_idf(my_tf, my_idf)
#my_doc_length = myclass.doc_length(my_tf_idf)
p '---------'
p " TF : #{my_tf}"
p  "IDF : #{my_idf}"
p "TF-IDF : #{my_tf_idf}"
=end

