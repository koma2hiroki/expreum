extern crate web3;

use web3::futures::Future;

fn main() {
    println!("Hello, world!");

    let (_eloop, transport) = web3::transports::Http::new("http://localhost:8545").unwrap();
    let web3 = web3::Web3::new(transport);
    let version = web3.web3().client_version().wait().unwrap();

    println!("Client Version: {:?}", version);
}
