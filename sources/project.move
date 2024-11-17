module OnChainStudentCredentialVerification::CredentialVerification {

    use aptos_framework::signer;

    /// Struct to represent a student's credentials.
    struct Credential has store, key {
        credential_id: u64,  // Unique ID for the credential
        issuer: address,     // Address of the credential issuer
    }

    /// Function to add a credential for a student.
    public fun add_credential(issuer: &signer, student: address, credential_id: u64) {
        // Ensure no duplicate credential is added
        assert!(
            !exists<Credential>(student), 
            1 // Error code 1: Credential already exists
        );

        let credential = Credential {
            credential_id,
            issuer: signer::address_of(issuer),
        };

        move_to(&student, credential);
    }

    /// Function to verify if a credential exists for a student.
    public fun verify_credential(student: address): bool {
        exists<Credential>(student)
    }
}
