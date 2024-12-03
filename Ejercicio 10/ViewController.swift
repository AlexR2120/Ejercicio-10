import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Array para almacenar las reservas
    var salasReservadas: [Reuniones] = []

    // Outlets para los campos de texto
    @IBOutlet weak var reservasTableView: UITableView!
    @IBOutlet weak var nombreSalaTextField: UITextField!
    @IBOutlet weak var nombreReservaTextField: UITextField!
    @IBOutlet weak var personasTextField: UITextField!
    @IBOutlet weak var fechaTextField: UITextField!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            reservasTableView.dataSource = self
            reservasTableView.delegate = self
        }
        
        // Acción para añadir una reserva
        @IBAction func agregarReserva(_ sender: UIButton) {
            guard let nombreSala = nombreSalaTextField.text, !nombreSala.isEmpty,
                  let nombreReserva = nombreReservaTextField.text, !nombreReserva.isEmpty,
                  let personasString = personasTextField.text, let personas = Int(personasString),
                  let fecha = fechaTextField.text, !fecha.isEmpty else {
                print("Por favor, completa todos los campos correctamente.")
                return
            }
            
            // Crear la reserva y añadirla al array
            let nuevaReserva = Reuniones(nombreSala: nombreSala, nombreReserva: nombreReserva, personas: personas, fecha: fecha)
            salasReservadas.append(nuevaReserva)
            
            // Recargar la tabla
            reservasTableView.reloadData()
            
            // Limpiar los campos
            nombreSalaTextField.text = ""
            nombreReservaTextField.text = ""
            personasTextField.text = ""
            fechaTextField.text = ""
        }
        
        // Métodos del UITableViewDataSource
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return salasReservadas.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReservaCell", for: indexPath)
            let reserva = salasReservadas[indexPath.row]
            
            // Configurar la celda con los datos de la reserva
            cell.textLabel?.text = "Sala: \(reserva.nombreSala) - Fecha: \(reserva.fecha)"
            cell.detailTextLabel?.text = "Reservado por \(reserva.nombreReserva) (\(reserva.personas) personas)"
            
            return cell
        }
    }
