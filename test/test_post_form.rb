require 'mechanize/test_case'

class PostForm < Mechanize::TestCase
  def test_post_form
    page = @mech.post("http://localhost/form_post",
                        'gender' => 'female'
                      )
    assert(page.links.find { |l| l.text == "gender:female" },
           "gender field missing")
  end

  def test_post_form_json
    page = @mech.post "http://localhost/form_post",
                       'json' => '["&quot;"]'

    assert page.links.find { |l| l.text == 'json:["""]' }
  end

  def test_post_form_multival
    page = @mech.post("http://localhost/form_post",
                       [ ['gender', 'female'],
                         ['gender', 'male']
                       ]
                      )
    assert(page.links.find { |l| l.text == "gender:female" },
           "gender field missing")

    assert(page.links.find { |l| l.text == "gender:male" },
           "gender field missing")

    assert_equal(2, page.links.length)
  end
end
