module Multichain
  describe CLI do
    let :subject do
      described_class.new
    end

    context 'version' do
      let :output do
        capture :stdout do
          subject.version
        end
      end

      it 'has a version' do
        expect(output).to match "multichain version #{VERSION}"
      end
    end

    context 'encode a string' do
      let :output do
        capture :stdout do
          Timecop.freeze Time.local 2016, 01, 06 do
            subject.hexify 'http://metrics.theodi.org/metrics/2013-q3-completed-tasks'
          end
        end
      end

      it 'encodes correctly', :vcr do
        expect(output).to match '313435323033383430307c687474703a2f2f6d6574726963732e7468656f64692e6f72672f6d6574726963732f323031332d71332d636f6d706c657465642d7461736b737c7b22416363657074223a226170706c69636174696f6e2f6a736f6e227d7c38343666373565613864366239313136373635383433643563663631326335343539653635316632616337623161393330383437353732643032653637343964'
      end
    end

    context 'decode a string' do
      let :output do
        capture :stdout do
          subject.dehexify '313435323030323030307c687474703a2f2f6d6574726963732e7468656f64692e6f72672f6d6574726963732f323031352d71342d636f6d706c657465642d7461736b732e6a736f6e7c7b22416363657074223a226170706c69636174696f6e2f6a736f6e227d7c32663266313635373862646432623863353835653931316362393232363430666438653531303162336331326163323661383537383633633032663661616563'
        end
      end

      it 'decodes correctly' do
        expect(output).to match '1452002000|http://metrics.theodi.org/metrics/2015-q4-completed-tasks.json|{"Accept":"application/json"}|2f2f16578bdd2b8c585e911cb922640fd8e5101b3c12ac26a857863c02f6aaec'
      end
    end

    context 'verification' do
      let :goodoutput do
        capture :stdout do
          subject.verify '313435323030323131357c687474703a2f2f6d6574726963732e7468656f64692e6f72672f6d6574726963732f6769746875622d746f74616c2d70756c6c2d72657175657374737c7b22416363657074223a226170706c69636174696f6e2f6a736f6e227d7c35616536653931373830626134623962306361653562346239313135623835636633313933613838626439666331316430353231366531316330373762383966'
        end
      end

      it 'verifies an entry', :vcr do
        expect(goodoutput).to match "'http://metrics.theodi.org/metrics/github-total-pull-requests' is verified"
      end

      let :badoutput do
        capture :stdout do
          subject.verify '313435323030323131357c687474703a2f2f6d6574726963732e7468656f64692e6f72672f6d6574726963732f6769746875622d746f74616c2d70756c6c2d72657175657374737c7b22416363657074223a226170706c69636174696f6e2f6a736f6e227d7c35616536653931373830626134623962306361653562346239313135623835636633313933613838626439666331316430353231366531316330373762383'
        end
      end

      it 'does not verify a duff entry', :vcr do
        expect(badoutput).to match "'http://metrics.theodi.org/metrics/github-total-pull-requests' is not verified"
      end
    end

    context 'send URL' do
      let :output do
        capture :stdout do
          Timecop.freeze Time.local 2016, 01, 06 do
            subject.send_url 'stu', 'http://uncleclive.herokuapp.com/multichain'
          end
        end
      end

      it 'sends a URL to a wallet', :vcr do
    #    expect(output).to match "foo"
      end
    end
  end
end
