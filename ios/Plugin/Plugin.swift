import Foundation
import Capacitor
import CoreBluetooth

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */
typealias JSObject = [String:Any]
typealias JSArray = [JSObject]

extension String {
    public func charCodeAt(index: Int) -> Int {
        return Int((self as NSString).character(at: index))
    }
}

extension StringProtocol {
    var asciiValues: [UInt8] { compactMap(\.asciiValue) }
}

@objc(BluetoothLEClient)
public class BluetoothLEClient: CAPPlugin {
    var bleHandler: BLEHandler?
    var errorNoCharacteristic = "NO_CHARACTERISTICS";
	var errorNoName = "NO_NAME";
	var errorNoServices = "NO_SERVICES";
    var errorNoValue = "NO_VALUE";
	var errorNotAuthorized = "NOT_AUTHORIZED";
	var errorNotEnabled = "NOT_ENABLED";
    /* Fazer pela ordem:
    (OK) 1 - Habilitar (enable)
    (OK) 2 - Scannear (scan)
    (OK) 3 - Scannear com filtro (scan[...])
    4 - Conectar
    5 - Listar servicos
    6 - Listar caracteristicas
    7 - Escrever
    8 - Ler
    */

	func checkInit(){
		if(bleHandler == nil){
			print("INICIANDO BLEHANDLER!");
			bleHandler = BLEHandler();
            bleHandler!.pluginRef = self;
        }
	}

    @objc func connect (_ call: CAPPluginCall) {
		checkInit();
        let isEnabled: Bool = bleHandler?.isEnabled() ?? false;
		if(!isEnabled){
			call.reject(errorNotEnabled);
		}
        let hasPermissions: Bool = bleHandler?.hasPermissions() ?? false;
		if(!hasPermissions){
			call.reject(errorNotAuthorized);
		}
        let name: String = call.getString("name") ?? "";
        if(name == "" || name == ""){
			CAPLog.print("Deve informar o nome do dispositivo.");
			call.reject(errorNoName);
			return;
        }
        let service = call.getString("service") ?? "";
        if(service == ""){
            CAPLog.print("Deve informar o serviço.");
            call.reject(errorNoServices);
            return ;
        }
        let characteristic = call.getString("characteristic") ?? "";
        if(characteristic == ""){
            CAPLog.print("Deve informar a caracteristica.");
            call.reject(errorNoCharacteristic);
            return ;
        }
        bleHandler?.searchFor(call: call, name: name, service: service, characteristic: characteristic);
    }
    @objc func disableNotifications (_ call: CAPPluginCall) {
        
    }
    @objc func disconnect (_ call: CAPPluginCall) {
        checkInit();
        let isEnabled: Bool = bleHandler?.isEnabled() ?? false;
		if(!isEnabled){
			call.reject(errorNotEnabled);
		}
        let hasPermissions: Bool = bleHandler?.hasPermissions() ?? false;
		if(!hasPermissions){
			call.reject(errorNotAuthorized);
		}
        let name: String = call.getString("name") ?? "";
        if(name == "" || name == ""){
            CAPLog.print("Deve informar o nome do dispositivo.");
            call.reject(errorNoName);
            return;
        }
        let service = call.getString("service") ?? "";
        if(service == ""){
            CAPLog.print("Deve informar o serviço.");
            call.reject(errorNoServices);
            return ;
        }
        let characteristic = call.getString("characteristic") ?? "";
        if(characteristic == ""){
            CAPLog.print("Deve informar a caracteristica.");
            call.reject(errorNoCharacteristic);
            return;
        }
        bleHandler?.disconnect(call: call, name: name, service: service, characteristic: characteristic);
    }
    @objc func discover (_ call: CAPPluginCall) {
        
    }
    @objc func enable (_ call: CAPPluginCall) {
        //checkInit();
        let result: Bool = bleHandler?.isEnabled() ?? false;
        let currentState: String = bleHandler?.currentState() ?? "<UNKNOWN>";
        print("CURRENT STATE: "+currentState);
        if(result){
            call.resolve();
        }else{
            checkInit();
            bleHandler?.setEnableCall(call: call);
            //call.reject(errorNotEnabled);
        }
    }
    @objc func enableNotifications (_ call: CAPPluginCall) {
        let name: String = call.getString("name") ?? "";
        if(name == "" || name == ""){
            CAPLog.print("Deve informar o nome do dispositivo.");
            call.reject(errorNoName);
            return;
        }
        let serviceInt = call.getInt("service") ?? nil;
        if(serviceInt == nil){
            CAPLog.print("Deve informar o serviço.");
            call.reject(errorNoServices);
            return ;
        }
        let service = String(format: "%04X",serviceInt!);
        print("ENABLE NOTIFICATIONS FOR SERVICE: "+service);
        let characteristicInt = call.getInt("characteristic") ?? nil;
        if(characteristicInt == nil){
            CAPLog.print("Deve informar a cara.");
            call.reject(errorNoServices);
            return ;
        }
        let characteristic = String(format: "%04X",characteristicInt!);
        print("ENABLE NOTIFICATIONS FOR CHARACTERISTIC: "+characteristic);
        /*let characteristic = call.getString("characteristic") ?? "";
        if(characteristic == ""){
            CAPLog.print("Deve informar a caracteristica.");
            call.reject(errorNoCharacteristic);
            return;
        }*/
        bleHandler?.enableNotifications(call: call, name: name, service: service, characteristic: characteristic);
    }
    @objc func getCharacteristic (_ call: CAPPluginCall) {
        
    }
    @objc func getCharacteristics (_ call: CAPPluginCall) {
        
    }
    @objc func getService (_ call: CAPPluginCall) {
        
    }
    @objc func getServices (_ call: CAPPluginCall) {
        
    }
    @objc func hasPermissions (_ call: CAPPluginCall) {
        let hasPermissions: Bool = bleHandler?.hasPermissions() ?? false;
        var ret = [String: Any]()
        ret["isAllowed"] = hasPermissions;
        call.resolve(ret);
    }
    @objc func isAvailable (_ call: CAPPluginCall) {
        
    }
    @objc func isConnected(_ call: CAPPluginCall){
        let name: String = call.getString("name") ?? "";
        if(name == "" || name == ""){
            CAPLog.print("Deve informar o nome do dispositivo.");
            call.reject(errorNoName);
            return;
        }
        let service = call.getString("service") ?? "";
        if(service == ""){
            CAPLog.print("Deve informar o serviço.");
            call.reject(errorNoServices);
            return ;
        }
        let characteristic = call.getString("characteristic") ?? "";
        if(characteristic == ""){
            CAPLog.print("Deve informar a caracteristica.");
            call.reject(errorNoCharacteristic);
            return;
        }
        bleHandler?.isConnected(call: call, name: name, service: service, characteristic: characteristic);
    }
    @objc func isEnabled (_ call: CAPPluginCall) {
        checkInit();
        let isEnabled: Bool = bleHandler?.isEnabled() ?? false;
        if(isEnabled){
			var ret = [String: Any]()
			ret["enabled"] = true;
            call.resolve(ret);
        }else{
            call.reject(errorNotEnabled);
        }
    }
    @objc func read (_ call: CAPPluginCall) {
        let name: String = call.getString("name") ?? "";
        if(name == "" || name == ""){
            CAPLog.print("Deve informar o nome do dispositivo.");
            call.reject(errorNoName);
            return;
        }
        let service = call.getString("service") ?? "";
        if(service == ""){
            CAPLog.print("Deve informar o serviço.");
            call.reject(errorNoServices);
            return ;
        }
        let characteristic = call.getString("characteristic") ?? "";
        if(characteristic == ""){
            CAPLog.print("Deve informar a caracteristica.");
            call.reject(errorNoCharacteristic);
            return;
        }
        bleHandler?.read(call: call, name: name, service: service, characteristic: characteristic);
    }
    @objc func readDescriptor (_ call: CAPPluginCall) {
        
    }
    @objc func scan(_ call: CAPPluginCall) {
		call.save();
		print("BLE scan 01");
		checkInit();
		print("BLE scan 02");
        let name: String = call.getString("name") ?? "";
        if(name == "" || name == ""){
            /*CAPLog.print("Deve informar o nome do dispositivo.");
            call.reject(errorNoName);
            return;*/
        }
        let services = call.getArray("services", String.self) ?? [String]()
        if(services.count < 1){
            CAPLog.print("Deve informar os serviços.");
            call.reject(errorNoServices);
            return ;
        }
        let characteristics = call.getArray("characteristics", String.self) ?? [String]()
        if(characteristics.count < 1){
            CAPLog.print("Deve informar as caracteristicas.");
            call.reject(errorNoServices);
            return ;
        }
		bleHandler?.scan(call: call, name: name, service: services[0], characteristic: characteristics[0])
    }
    @objc func write (_ call: CAPPluginCall) {
        let name: String = call.getString("name") ?? "";
        if(name == "" || name == ""){
            CAPLog.print("Deve informar o nome do dispositivo.");
            call.reject(errorNoName);
            return;
        }
        let service = call.getString("service") ?? "";
        if(service == ""){
            CAPLog.print("Deve informar o serviço.");
            call.reject(errorNoServices);
            return ;
        }
        let characteristic = call.getString("characteristic") ?? "";
        if(characteristic == ""){
            CAPLog.print("Deve informar a caracteristica.");
            call.reject(errorNoCharacteristic);
            return;
        }
        let value = call.getString("value") ?? "";
        if(value == ""){
            CAPLog.print("Deve informar o valor.");
            call.reject(errorNoValue);
            return;
        }
        print("RECEBI ISSO PARA ESCREVER: "+value);
        bleHandler?.write(call: call, name: name, service: service, characteristic: characteristic, value: value);
    }
}

struct Device {
	var name: String,
	service: CBUUID,
	characteristic: CBUUID,
	peripheral: CBPeripheral?
}

class BLEHandler: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    var baseUUID = "0000XXXX-0000-1000-8000-00805F9B34FB";
    var calls: [CAPPluginCall] = [];
    var centralManager: CBCentralManager?;
    var connectCall: CAPPluginCall?;
	private var currentOperation: String = "";
    var deviceToDiscover: Device? = nil;
    var disconnectCall: CAPPluginCall?;
    var enableCall: CAPPluginCall?;
    var errorConnectedWrongDevice: String = "NOT_CONNECTED_CORRECT_DEVICE";
	var errorNoCharacteristics: String = "NO_CHARACTERISTICS";
	var errorNoServices: String = "NO_SERVICES";
    var errorNotConnected: String = "NOT_CONNECTED";
	var errorNotFound: String = "NOT_FOUND";
	var errorNotFoundCharacteristic: String = "NOT_FOUND_CHARACTERISTIC";
	var errorNotFoundService: String = "NOT_FOUND_SERVICE";
    var firstByte = "CC";
    var lastByte = "CF";
    var filterServices: [CBUUID]?;
    var myPeripheral: CBPeripheral?;
    var packet: [Int] = [Int]();
    var possibleDevices: [CBPeripheral]? = [];
	//var notificationCall: CAPPluginCall?;
    var readCall: CAPPluginCall?;
    var scanCall: CAPPluginCall?;
    var writeCall: CAPPluginCall?;
	var pluginRef: CAPPlugin?;

    override init(){
        super.init();
        createDelegate();
    }

    func connect(call: CAPPluginCall, identifier: String){
        currentOperation = "connect";
        let peripheralIdentifier: UUID = UUID(uuidString: identifier)!;
        let peripherals: [CBPeripheral] = centralManager?.retrievePeripherals(withIdentifiers: [peripheralIdentifier]) ?? [];
        if(peripherals.count > 0){
            connectCall = call;
            connectCall?.save();
            centralManager?.connect(peripherals[0]);
        }else{
            call.reject("NOT_FOUND");
        }
    }
    
    func currentState() -> String{
        return centralManager?.state.rawValue.description ?? "<UNKNOWN>";
    }

    func disconnect(call: CAPPluginCall, name: String, service: String, characteristic: String){
        currentOperation = "disconnect";
        let connectedPeripherals: [CBPeripheral] = (centralManager?.retrieveConnectedPeripherals(withServices: filterServices ?? []))!
        if(connectedPeripherals.count >= 1){
            let validPeripheral: CBPeripheral? = validatePeripheral(peripherals: connectedPeripherals, name: name, service: service, characteristic: characteristic);
            if(validPeripheral != nil){
                disconnectCall = call;
                disconnectCall?.save();
                centralManager?.cancelPeripheralConnection(validPeripheral!);
                return;
            }
        }else{
            call.resolve();
        }
    }
    
    func discoverServices(call: CAPPluginCall, identifier: String){
        
    }

    func createDelegate(){
        print("createDelegate.");
		centralManager = CBCentralManager(delegate: self, queue: nil);
	}
    //CONECTOU
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        stopScanning();
        switch(currentOperation){
            case "scan":
                break;
            case "searchFor":
                peripheral.delegate = self;
                peripheral.discoverServices(filterServices);
                print("PROCURANDO SERVIÇOS DO DISPOSITIVO: "+(peripheral.name ?? ""));
                break;
            default:
                break;
        }
        /*
        if(currentOperation == "connect"){
            peripheral.delegate = self;
            var servicesUUIDs: [CBUUID] = [];
            if(deviceToDiscover != nil){
                servicesUUIDs.append(deviceToDiscover?.service ?? CBUUID(string: ""));
            }
            peripheral.discoverServices(servicesUUIDs);
        }
        */
	}
    
    //DESCOBRIU DISPOSITIVO
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let name = peripheral.name ?? "";
        switch(currentOperation){
            case "scan":
                break;
            case "searchFor":
                print("PROCURANDO POR DISPOSITIVO: "+deviceToDiscover!.name);
                if(name == deviceToDiscover?.name){
                    myPeripheral = peripheral;
                    centralManager?.connect(peripheral);
                    print("MANDEI CONECTAR COM: "+peripheral.debugDescription);
                }
                break;
            default:
                break;
        }
        /*if(peripheral.name == deviceToDiscover?.name && currentOperation == "scan"){
            if(scanCall != nil){
                peripheral.delegate = self;
                peripheral.discoverServices(filterServices);
                var ret = [String: Any]()
                var device = JSObject();
                device["name"] = peripheral.name;
                device["identifier"] = peripheral.identifier.uuidString;
                ret["devices"] = [device];
                scanCall?.resolve(ret);
                scanCall = nil;
            }
        }else if(currentOperation == "searchFor"){

        }*/
	}
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("didDisconnect...");
        switch(currentOperation){
            case "disconnect":
                if(disconnectCall != nil){
                    disconnectCall?.resolve();
                }
                break;
            default:
                break;
        }
    }
    
	//DESCOBRIU SERVIÇOS
	func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("didDiscoverServices...")
        let services: [CBService] = peripheral.services ?? [];
        var characteristics: [CBUUID] = [];
        if(deviceToDiscover != nil){
            characteristics.append(deviceToDiscover?.characteristic ?? CBUUID(string:""));
        }
        for service in services {
            peripheral.discoverCharacteristics(characteristics, for: service)
        }
        print("NEW SERVICES: "+services.debugDescription);
	}
    
    //MODIFICOU SERVIÇOS
    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
        for invalid in invalidatedServices {
            print("SERVIÇO INVALIDO: "+invalid.debugDescription);
        }
    }
    
	//DESCOBRIU CARACTERISTICAS
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?){
        print("didDiscoverCharacteristicsFor...")
        let characteristics: [CBCharacteristic] = service.characteristics ?? [];
        for characteristic in characteristics {
            print("NEW CHARACTERISTIC: "+characteristic.debugDescription);
            if(characteristic.uuid == deviceToDiscover?.characteristic){
                successConnect();
            }
        }
		//returnConnectionResult(service: service);
	}
    //ESCREVEU CARACTERISTICA
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print("didWriteValueFor...");
        switch(currentOperation){
            case "write":
                if(writeCall != nil){
                    writeCall?.resolve();
                    writeCall = nil;
                    peripheral.readValue(for: characteristic);
                }
                break;
            default:
                break;
        }
    }
    func runClearPacket(){
        self.packet = [Int]();
    }
    func runNotificationCheck(_ eventName: String,_ unsignedBytes: [Int]){
        let expectedFirstByte = Int(self.firstByte, radix: 16);
        let expectedLastByte = Int(self.lastByte, radix: 16);
        //let expectedFirstByte = UInt8(self.firstByte, radix: 16);
        //let expectedLastByte = UInt8(self.lastByte, radix: 16);
        let firstByte = unsignedBytes.first;
        let lastByte = unsignedBytes.last;
        if(expectedFirstByte == firstByte && expectedLastByte == lastByte){
            //IT IS A FULL PACKET, SO NOTIFY IT AND CLEAR IT
            respondNotification(eventName, unsignedBytes);
            runClearPacket();
        }else if(expectedFirstByte == firstByte){
            packet = unsignedBytes;
            //IT IS THE FIRST PART OF A PACKET, SO SET ITS VALUE AND DO NOT NOTIFY
        }else if(expectedLastByte == lastByte){
            respondNotification(eventName, concatArray(packet,unsignedBytes));
            runClearPacket();
        }else {
            packet = concatArray(packet, unsignedBytes);
        }
    }
    func respondNotification(_ eventName: String,_ packet: [Int]){
        pluginRef!.notifyListeners(eventName,data:["value": packet]);
    }
    func concatArray(_ a: [Int],_ b: [Int]) -> [Int]{
        return a + b;
    }
    //ATUALIZOU CARACTERISTICA
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if(error != nil){
            
        }else{
            let dd = characteristic.value!;
            let value = String(data: dd, encoding: String.Encoding.ascii)!;
            var bytes: [Int] = [];
            for (index,_) in value.enumerated() {
                let byte: Int = value.charCodeAt(index: index);
                bytes.append(byte);
            }
            switch(currentOperation){
                case "read":
                    if(readCall != nil){
                        pluginRef!.notifyListeners(characteristic.uuid.uuidString,data:["value": bytes]);
                        var ret = [String: Any]()
                        ret["value"] = bytes;
                        readCall?.resolve(ret);
                        readCall = nil;
                    }/*else if(notificationCall != nil){
                         var ret = [String: Any]()
                        ret["value"] = bytes;
                        notificationCall?.resolve(ret);
                        notificationCall = nil;
                    }*/
                    break;
                default:
                    //print("VAMOS NOTIFICAR DEFAULT: "+characteristic.uuid.uuidString);
                    let eventName = UInt16(characteristic.uuid.uuidString, radix: 16);
                    //print("VAMOS NOTIFICAR INT: "+eventName!.description);
                    print("NOTIFICAR LISTENER "+eventName!.description);
                    runNotificationCheck(eventName!.description,bytes);
                    //pluginRef!.notifyListeners(characteristic.uuid.uuidString,data:["value": bytes]);
                    //pluginRef!.notifyListeners(x!.description,data:["value": bytes]);
                    break;
            }
        }
    }
    //MUDANÇA DE ESTADO
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch (central.state){
            case .unauthorized:
                if #available(iOS 13.0, *) {
                    switch (central.authorization){
                        case .allowedAlways:
                            //OK
                            break;
                        case .denied, .restricted, .notDetermined:
                            let title = "Bluetooth permission is currently disabled for the application. Enable Bluetooth from the application settings.";
                            let message = "";
                            self.openAppOrSystemSettingsAlert(title: title, message: message);
                            break;
                        @unknown default:
                            break;
                    }
                }
				if(enableCall != nil){
					enableCall?.reject("UNAUTHORIZED");
				}
                break;
            case .poweredOn:
                print("IS POWERED ON!");
				if(enableCall != nil){
                    print("VOU AVISAR QUE ESTA LIGADO!");
					var ret = [String: Any]()
                    ret["enabled"] = true;
					enableCall?.resolve(ret);
				}
                break;
            case .unknown, .resetting, .unsupported:
                break;
            case .poweredOff:
                break;
            @unknown default:
                break;
        }
    }

	func enableNotifications(call: CAPPluginCall, name: String, service: String, characteristic: String){
		let connectedPeripherals: [CBPeripheral] = (centralManager?.retrieveConnectedPeripherals(withServices: filterServices ?? []))!
		if(connectedPeripherals.count >= 1){
			let validPeripheral: CBPeripheral? = validatePeripheral(peripherals: connectedPeripherals, name: name, service: service, characteristic: characteristic);
            if(validPeripheral != nil){
                let c: CBCharacteristic? = getCharacteristic(peripheral: validPeripheral, service: service, characteristic: characteristic);
                if(c != nil){
					//PEDIR PARA SER NOTIFICADO
					currentOperation = "read";
					//notificationCall = call;
					//notificationCall?.save();
					validPeripheral?.readValue(for: c!);
                    validPeripheral?.setNotifyValue(true, for: c!);
					call.resolve();
                }
                return;
            }else{
                call.reject(errorConnectedWrongDevice);
                return;
            }
		}
		call.reject(errorNotConnected);
        return;
		/*currentOperation = "read";
        readCall = call;
        readCall?.save();
        let connectedPeripherals: [CBPeripheral] = (centralManager?.retrieveConnectedPeripherals(withServices: filterServices ?? []))!
        if(connectedPeripherals.count >= 1){
            let validPeripheral: CBPeripheral? = validatePeripheral(peripherals: connectedPeripherals, name: name, service: service, characteristic: characteristic);
            if(validPeripheral != nil){
                let c: CBCharacteristic? = getCharacteristic(peripheral: validPeripheral, service: service, characteristic: characteristic);
                if(c != nil){
                    //value.data
                    validPeripheral?.readValue(for: c!);
                }
                return;
            }else{
                call.reject(errorConnectedWrongDevice);
                return;
            }
        }
        call.reject(errorNotConnected);
        return;*/
	}
    
    func getCharacteristic(peripheral: CBPeripheral?, service: String, characteristic: String) -> CBCharacteristic? {
        if(peripheral != nil){
            for s in peripheral?.services ?? [] {
                for c in s.characteristics ?? [] {
                    if(c.uuid.uuidString == characteristic){
                        return c;
                    }
                }
            }
        }
        return nil;
    }

    func hasPermissions() -> Bool {
        if #available(iOS 13.1, *) {
            return CBCentralManager.authorization == .allowedAlways
        } else if #available(iOS 13.0, *) {
            return centralManager?.authorization == .allowedAlways
        }
        // Before iOS 13, Bluetooth permissions are not required
        return true
    }
    
    func isConnected(call: CAPPluginCall, name: String, service: String, characteristic: String){
        currentOperation = "isConnected";
        let connectedPeripherals: [CBPeripheral] = (centralManager?.retrieveConnectedPeripherals(withServices: filterServices ?? []))!
        if(connectedPeripherals.count >= 1){
            let validPeripheral: CBPeripheral? = validatePeripheral(peripherals: connectedPeripherals, name: name, service: service, characteristic: characteristic);
            if(validPeripheral != nil){
                let c: CBCharacteristic? = getCharacteristic(peripheral: validPeripheral, service: service, characteristic: characteristic);
                if(c != nil){
					var ret = [String: Any]()
            		ret["connected"] = true;
                    call.resolve(ret);
                }
                return;
            }else{
                call.reject(errorConnectedWrongDevice);
                return;
            }
        }
        call.reject(errorNotConnected);
        return;
    }

    func isEnabled() -> Bool {
        if(centralManager == nil){
            return false;
        }
        return centralManager?.state == .poweredOn;
    }
    func openAppOrSystemSettingsAlert(title: String, message: String) {
        let alertController = UIAlertController (title: title, message: message, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        //present(alertController, animated: true, completion: nil)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil);
    }
    
    func read(call: CAPPluginCall, name: String, service: String, characteristic: String){
        currentOperation = "read";
        readCall = call;
        readCall?.save();
        let connectedPeripherals: [CBPeripheral] = (centralManager?.retrieveConnectedPeripherals(withServices: filterServices ?? []))!
        if(connectedPeripherals.count >= 1){
            let validPeripheral: CBPeripheral? = validatePeripheral(peripherals: connectedPeripherals, name: name, service: service, characteristic: characteristic);
            if(validPeripheral != nil){
                let c: CBCharacteristic? = getCharacteristic(peripheral: validPeripheral, service: service, characteristic: characteristic);
                if(c != nil){
                    //value.data
                    validPeripheral?.readValue(for: c!);
                }
                return;
            }else{
                call.reject(errorConnectedWrongDevice);
                return;
            }
        }
        call.reject(errorNotConnected);
        return;
    }
	func scan(call: CAPPluginCall, name: String, service: String, characteristic: String){
        print("---     NEW SCAN     ---");
        print("--- NAME: "+name+" ---");
        print("--- SERVICE: "+name+" ---");
        currentOperation = "scan";
		scanCall = call;
		scanCall?.save();
        deviceToDiscover = Device(
            name: name,
            service: to128bitUUID(uuidString: service),
            characteristic: to128bitUUID(uuidString: characteristic),
            peripheral: nil
        );
        stopScanning();
        centralManager?.scanForPeripherals(withServices: [], options: nil);
        perform(#selector(stopScanning), with: nil, afterDelay: 10);
	}
	func searchFor(call: CAPPluginCall, name: String, service: String, characteristic: String){
        print("NEW SCAN");
		currentOperation = "searchFor";
		connectCall = call;
        connectCall?.save();
        deviceToDiscover = Device(
            name: name,
            service: to128bitUUID(uuidString: service),
            characteristic: to128bitUUID(uuidString: characteristic),
            peripheral: nil
        );
        filterServices = [CBUUID(string: service)];
        //let serviceArray: [CBUUID] = [CBUUID(string: service)];
        let connectedPeripherals: [CBPeripheral] = (centralManager?.retrieveConnectedPeripherals(withServices: filterServices ?? []))!
        if(connectedPeripherals.count > 0){
            let validPeripheral: CBPeripheral? = validatePeripheral(peripherals: connectedPeripherals, name: name, service: service, characteristic: characteristic);
            if(validPeripheral != nil){
                print("JA CONECTADO. OK!");
                successConnect();
                return;
            }
        }
        print("NENHUM PERIPHERAL CONECTADO.");
        centralManager?.scanForPeripherals(withServices: []);
	}
    func setEnableCall(call: CAPPluginCall){
        enableCall = call;
        enableCall?.save();
    }
    func successConnect(){
        if(connectCall != nil){
            var ret = [String: Any]()
            ret["connected"] = true;
            connectCall?.resolve(ret);
        }
    }
    @objc func stopScanning(){
        print("STOPSCANNING!");
        if(centralManager != nil){
            print("--- END SCAN ---");
            possibleDevices = [];
            centralManager?.stopScan();
            if(scanCall != nil){
                
            }
        }
    }
    func to128bitUUID(uuidString: String) -> CBUUID{
        if(uuidString.count == 4){
            return CBUUID(string: baseUUID.replacingOccurrences(of: "XXXX", with: uuidString));
        }
        return CBUUID(string: uuidString);
    }
    func validatePeripheral(peripherals: [CBPeripheral], name: String, service: String, characteristic: String) -> CBPeripheral? {
        for peripheral in peripherals {
            if(peripheral.name == name){
                for s in peripheral.services ?? [] {
                    if(s.uuid.uuidString == service){
                        for c in s.characteristics ?? [] {
                            if(c.uuid.uuidString == characteristic){
                                return peripheral;
                            }
                        }
                    }
                }
            }
        }
        return nil;
    }
    func write(call: CAPPluginCall, name: String, service: String, characteristic: String, value: String){
        currentOperation = "write";
        writeCall = call;
        writeCall?.save();
        let connectedPeripherals: [CBPeripheral] = (centralManager?.retrieveConnectedPeripherals(withServices: filterServices ?? []))!
        if(connectedPeripherals.count >= 1){
            let validPeripheral: CBPeripheral? = validatePeripheral(peripherals: connectedPeripherals, name: name, service: service, characteristic: characteristic);
            if(validPeripheral != nil){
                let c: CBCharacteristic? = getCharacteristic(peripheral: validPeripheral, service: service, characteristic: characteristic);
                if(c != nil){
                    //value.data
                    //value.data(using: .utf8)
                    print("AGORA VOU ESCREVER "+value);
                    let data = Data(base64Encoded: value);
                    var iterator = data?.makeIterator();
                    while let next = iterator!.next() {
                        print("NEXT: "+next.description);
                    }
                    validPeripheral?.writeValue(Data(base64Encoded: value) ?? Data(), for: c!, type: .withResponse);
                }
                return;
            }else{
                call.reject(errorConnectedWrongDevice);
                return;
            }
        }
        call.reject(errorNotConnected);
        return;
    }
}
