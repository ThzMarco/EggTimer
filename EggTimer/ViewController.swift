

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //Dicionário
    let eggTimes = ["Soft": 3, "Medium": 5, "Hard": 8]
    var secondsRemaining = 0
    var countdownTimer: Timer?
    var audioPlayer: AVAudioPlayer?
    
    
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.progress = 0
        //progressView.isReversed = true
        progressView.transform = CGAffineTransform(scaleX: -1, y: 1) // Inverte a direção de preenchimento da barra de progresso
        
    }

    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        // print(sender.currentTitle)
        
        guard let hardness = sender.currentTitle, let time = eggTimes[hardness] else {
            return
        }
        
        // Animação de escala no botão
          UIView.animate(withDuration: 0.1, animations: {
              sender.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
          }, completion: { (_) in
              UIView.animate(withDuration: 0.3, animations: {
                  sender.transform = CGAffineTransform.identity
              })
          })
        
        secondsRemaining = time
        countdownTimer?.invalidate()
        progressView.progress = 0
        
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            if self.secondsRemaining > 0 {
                self.secondsRemaining -= 1
                let progress = Float(self.secondsRemaining) / Float(time)
                self.progressView.progress = progress
                //print("\(self.secondsRemaining) seconds")
                
            } else {
                timer.invalidate()
                self.playAlarmSound()
                self.showAlert(message: "Está pronto!")
            }
        }
    }
    
    func playAlarmSound() {
            if let soundURL = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                    audioPlayer?.play()
                } catch {
                    print("Erro ao reproduzir o som: \(error)")
                }
            } else {
                print("O arquivo de som 'alarm_sound.mp3' não foi encontrado.")
            }
        }
        
        func showAlert(message: String) {
                let alert = UIAlertController(title: "Contagem Regressiva", message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK ", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            }
      /*  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
            
            if self.secondsRemaining > 0 {
                print ("\(secondsRemaining) seconds")
                secondsRemaining -= 1
            }
            
            else {
                Timer.invalidate()
            }
        }*/
    
        // Imprimir Optional das imagens
        //print(eggTimes [hardness])
        
        // Metódo para não imprimir "Optinal" das imagens
        //let result = eggTimes[hardness]! // Usando opcional para desembrulhar
        
        //print(result)
        
        /* switch hardness {
         case "Soft":
         print("O ovo ainda está claro")
         case "Medium":
         print("O ovo está no ponto")
         case "Hard":
         print("O ovo passou no ponto")
         
         default:
         print("Error")
         */
   //     ---------------------------    //
       /* if hardness == "Soft" {
            print(softTime)
        } else if hardness == "Medium" {
            print(mediumTime)
        } else {
            print(hardTime)
        }
        */
        
    }

