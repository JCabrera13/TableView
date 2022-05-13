//
//  vListadoTableViewController.swift
//  TableView
//
//  Created by Humberto Pena Valle on 25/04/22.
//

import UIKit

class vListado: UITableViewController
{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isEditing = true;

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lenguajes.count
    }
    
    /*override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celdaNombre", for: indexPath) as! celdaListado
        
        celda.lblNombre.text = lenguajes[indexPath.row].nombre
        celda.lblOrientacion.text = lenguajes[indexPath.row].orientacion
        celda.imgLogo.image = lenguajes[indexPath.row].logo

        return celda
    }*/
    
    //sera el alto de un control.
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60; //siempre debera de ser estatico.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = Bundle.main.loadNibNamed("celdaXib", owner: self)?.first as! celdaXib
        
        celda.lblNombre.text = lenguajes[indexPath.row].nombre
        celda.lblOrientacion.text = lenguajes[indexPath.row].orientacion
        celda.imgLogo.image = lenguajes[indexPath.row].logo

        return celda
    }
    
    //metodo para controlar la celda la cual se quiere modificar.
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete //accion que se quiere hacer.
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    //metodo para remover.
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath){
        let elementoMovido = lenguajes[sourceIndexPath.row]
        lenguajes.remove(at: sourceIndexPath.row)
        lenguajes.insert(elementoMovido, at:destinationIndexPath.row)
        tableView.reloadData();
    }
    
    @IBOutlet weak var btnAgregar: UIBarButtonItem!
    
    @IBAction func agregarElemento(_ sender: UIBarButtonItem) {
        let alerta = UIAlertController(title:"Nuevo", message: "Ingrese el lenguaje", preferredStyle: .alert)
        
        alerta.addTextField()
        {
            (textField) -> Void in
            textField.placeholder = "Nombre"
        }
        alerta.addTextField()
        {
            (textField) -> Void in
            textField.placeholder = "Orientacion"
        }

        let btnCancelar = UIAlertAction(title:"CancelaR", style: .cancel)
        let btnAceptar = UIAlertAction(title:"Aceptar", style: .default)
            {
            _ in let lenguaje = (nombre: alerta.textFields![0].text!,
        orientacion: alerta.textFields![1].text!, logo:
        UIImage(named:"vacio"))
                lenguajes.append(lenguaje);
            self.tableView.reloadData()
            }
        alerta.addAction(btnCancelar)
        alerta.addAction(btnAceptar)
        self.present(alerta, animated: true)

    }
    
    @IBAction func moverElemento(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing;
    
    }
    
    /*func agregarLenguaje(){
        let alerta = UIAlertController(title:"Nuevo", message: "Ingrese el lenguaje", preferredStyle: .alert)
        
        alerta.addTextField()
        {
            (textField) -> Void in
            textField.placeholder = "Nombre"
        }
        alerta.addTextField()
        {
            (textField) -> Void in
            textField.placeholder = "Orientacion"
        }

        let btnCancelar = UIAlertAction(title:"CancelaR", style: .cancel)
        let btnAceptar = UIAlertAction(title:"Aceptar", style: .default)
            {
            _ in let lenguaje = (nombre: alerta.textFields![0].text!,
        orientacion: alerta.textFields![1].text!, logo:
        UIImage(named:"vacio"))
                lenguajes.append(lenguaje);
            self.tableView.reloadData()
            }
        alerta.addAction(btnCancelar)
        alerta.addAction(btnAceptar)
        self.present(alerta, animated: true)
    }*/
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //Clase a la cual pertenecen las acciones UIContextualAction
        let accion1 = UIContextualAction(style: .destructive, title:"Accion 1")
        {
            (action, sourceView, completionHandler) in
            print(action.title!)
        }
        let accion2 = UIContextualAction(style: .normal, title:"accion2")
        {
            (action, sourceView, completionHandler) in
            print(action.title!)
        }
        let acciones = UISwipeActionsConfiguration(actions: [accion1,accion2])
        acciones.performsFirstActionWithFullSwipe = true
        return acciones

    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath:IndexPath) -> UISwipeActionsConfiguration
    {
        //Todas las acciones igual que el anterior, para que se muestre al deslizar a la derecha.
        //Clase a la cual pertenecen las acciones UIContextualAction
        let accion1 = UIContextualAction(style: .destructive, title:"Accion 1")
        {
            (action, sourceView, completionHandler) in
            self.borrarElemento(indexPath)
            print(action.title!)
        }
        let accion2 = UIContextualAction(style: .normal, title:"accion2")
        {
            (action, sourceView, completionHandler) in
            self.agregarLenguajeIndividual(indexPath)
            print(action.title!)
        }
        
        let accion3 = UIContextualAction(style: .normal, title:"accion3")
        {
            (action, sourceView, completionHandler) in
            self.modificarLenguaje(indexPath)
            print(action.title!)
        }
        
        //antes de integrar las acciones se deben de personalizar las acciones
        accion1.image=UIImage(systemName: "trash")
        accion2.backgroundColor = UIColor.systemGreen
        accion2.image=UIImage(systemName: "plus")
        accion3.image=UIImage(systemName: "pencil")
        
        //se programa lo necesario para que se hagsa cada accion.
        let acciones = UISwipeActionsConfiguration(actions: [accion2,accion1,accion3])
        acciones.performsFirstActionWithFullSwipe = true
        return acciones
    }
    
    func agregarLenguajeIndividual(_ indexPath: IndexPath){
        //acciones a realizar
        let alerta = UIAlertController(title:"Nuevo", message: "Ingrese el lenguaje", preferredStyle: .alert)
        
        alerta.addTextField()
        {
            (textField) -> Void in
            textField.placeholder = "Nombre"
        }
        alerta.addTextField()
        {
            (textField) -> Void in
            textField.placeholder = "Orientacion"
        }

        let btnCancelar = UIAlertAction(title:"CancelaR", style: .cancel)
        let btnAceptar = UIAlertAction(title:"Aceptar", style: .default)
            {
            _ in let lenguaje = (nombre: alerta.textFields![0].text!,
        orientacion: alerta.textFields![1].text!, logo:
        UIImage(named:"vacio"))
                lenguajes.insert(lenguaje, at:indexPath.row)
            self.tableView.reloadData()
            }
        alerta.addAction(btnCancelar)
        alerta.addAction(btnAceptar)
        self.present(alerta, animated: true)
    }
    
    func borrarElemento (_ indexPath: IndexPath)
    {
            let alerta = UIAlertController(title: "Atención", message: "Desea eliminar el registro?", preferredStyle:.alert)
            let btnNo = UIAlertAction(title: "No", style: .cancel, handler: nil)
            let btnSi = UIAlertAction(title: "Si", style: .destructive)
            {
                (UIAlertAction) in
                lenguajes.remove (at: indexPath.row)
                //self.tableView.reloadData()
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
            alerta.addAction(btnNo)
            alerta.addAction (btnSi)
            self.present (alerta, animated: true, completion:nil)
    }
    
    func modificarLenguaje(_ indexPath: IndexPath){
        let alerta = UIAlertController(title:"Modificar", message: "Modifique el lenguaje", preferredStyle: .alert)
        
        alerta.addTextField()
        {
            (textField) -> Void in
            textField.placeholder = "Nombre"
        }
        alerta.addTextField()
        {
            (textField) -> Void in
            textField.placeholder = "Orientacion"
        }

        let btnCancelar = UIAlertAction(title:"Cancelar", style: .cancel)
        let btnAceptar = UIAlertAction(title:"Aceptar", style: .default)
            {
            _ in let lenguaje = (nombre: alerta.textFields![0].text!,
        orientacion: alerta.textFields![1].text!, logo:
        UIImage(named:"vacio"))
                
                lenguajes[indexPath.row].nombre = lenguaje.nombre
                lenguajes[indexPath.row].orientacion = lenguaje.orientacion
            self.tableView.reloadData()
            }
        alerta.addAction(btnCancelar)
        alerta.addAction(btnAceptar)
        self.present(alerta, animated: true)

    }
    
    //asgregar datos remotos, faltar si se toca la celda, se habra otra vista.
    
    
    //metodo que dispara al tocar alguna celda.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vista = (storyboard?.instantiateViewController(withIdentifier: "vDetalle")) as! vDetalle
        vista.indice=indexPath.row
        self.navigationController?.pushViewController(vista, animated: true);

    }
    
    
    
    
    
    
    
    
    
    

    
    
    
}
