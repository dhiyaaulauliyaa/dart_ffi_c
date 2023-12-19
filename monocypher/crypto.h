#define MY_EXPORT __attribute__((visibility("default"))) __attribute__((used))
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define X25519_KEY_LEN      (32)
MY_EXPORT extern int signature_eddsa_verification(uint8_t *signature, uint8_t *public_key, uint8_t *message, size_t message_size);
MY_EXPORT extern int xed25519_verify(const uint8_t signature[64],
                    const uint8_t public_key[32],
                    const uint8_t *message, size_t message_size);
MY_EXPORT extern void xed25519_sign(uint8_t signature[64],
                   const uint8_t secret_key[32],
                   const uint8_t random[64],
                   const uint8_t *message, size_t message_size);
MY_EXPORT extern int bike_session(uint8_t *session_id,
             uint8_t *new_signature,
             uint8_t *session_aead_secretkey,
             uint8_t *session_response,
             uint8_t signature[64],
             uint8_t session_request[128],
             int session_request_len,
             uint8_t bike_identity_key[32],
			 uint8_t bike_pairing_key[32]);
MY_EXPORT extern void printarray(uint8_t data[], int len);