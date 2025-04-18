from web3 import Web3
import Configuration
import logging
logger = logging.getLogger(__name__)
from http.server import HTTPServer, BaseHTTPRequestHandler
import ssl
import time


def main_blockchain(temp):

    try:

        # Connect to a local or remote Ethereum node
        w3 = Web3(Web3.HTTPProvider("http://localhost:7545"))

        if w3.isConnected():
            print("-" * 50)
            print("Connection Successful")
            print("-" * 50)
        else:
            print("Connection Failed")

        # Create a contract object with the address of the smart contract and the ABI
        contract = w3.eth.contract(address=Configuration.contract_address, abi=Configuration.contract_abi)

        # The address of the account that will invoke the function
        sender_address = Configuration.sender_address

        # The private key of the account that will invoke the function
        sender_private_key = Configuration.private_key

        # Estimate the gas required to invoke the function
        gas_estimate = 1000000

        result = contract.functions.getTemperature(1).call()
        print("Temperatura iniziale da contratto: ", result)
        
        transaction = contract.functions.setTemperature(1, temp).buildTransaction({
            #'from': sender_address,
			'chainId' : Configuration.chainID,
            'gas': gas_estimate,
            'gasPrice': w3.toWei("20", "gwei"),
            'nonce': w3.eth.getTransactionCount(sender_address)
        })
        
        # Sign the transaction
        signed_transaction = w3.eth.account.signTransaction(transaction, sender_private_key)

        # Send the transaction
        transaction_hash = w3.eth.sendRawTransaction(signed_transaction.rawTransaction)

        # Wait for the transaction to be mined
        transaction_receipt = w3.eth.waitForTransactionReceipt(transaction_hash)

        # Check if the transaction was successful
        if transaction_receipt["status"] == 1:
            print("Transaction successful")
        else:
            print("Transaction failed")

        result2 = contract.functions.getTemperature(1).call()
        print("Temperatura dopo la transazione: ", result2)
       
        
    except Exception as e:
        logger.error("ERROR: An error occurred: %s" % e)


class HandlerMio(BaseHTTPRequestHandler):

    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        body = self.rfile.read(content_length)
        self.send_response(200)
        self.end_headers()
        temp = body[5:]
        
        try:
            float_temp = int(temp)
            print(float_temp)
            main_blockchain(float_temp)
            time.sleep(20000)
        except ValueError:
            return "Errore"
    

httpd = HTTPServer(('172.20.10.5', 4443), HandlerMio)

httpd.socket = ssl.wrap_socket (httpd.socket, keyfile="./server.key", certfile='./server.crt', server_side=True)


if __name__ == '__main__':
    
    httpd.serve_forever()
    
