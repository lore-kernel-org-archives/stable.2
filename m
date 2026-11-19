Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795078648;
	b=SFpAgVqo/sgSROvpFM0y2ORtTGs1ucv3dWoRb4MkdgDuZixv44UCRJet9W4jynzo5S68
	 mltHd4Y4BUXzYJj6JQSNdhkw+i5N1VyA+3Lp60zmRkqiJ++cx0aYX7cqQZKyoSq0q91vp
	 /7DPMYBeQxi44pRIqnfMztrDOjtc/Yoy66Kyn7hmeCwF+SX7wWUYtyTYPNv2BKUkb6aab
	 vTnwhN6cbeu5nKqMVCEU6JBr7NYNCbjXxejoXFU+WlhU6pZ2C0vpfzMnplaaxhZ1w1YOq
	 5WfkPqhkkFOEaiQVG8Jhtx6k+Y0t1LeaGO0BNlLeV39yKIocIpakxVz2Sg0TA2g2G+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078648;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Mec+5qup+REVZ2ul0shcEpYxGqz5NUS2jA/94J5NrDQ=;
	b=abYHkU0DLKpHETqMS1G36bGTvZh9Q8yeGVgPra52tPL19wquSAG83iag7Z7OJ4Mzew5h
	 CHCMG2TA8SFsaNSaYrXdEPbnpEy3oplQckSExoORPe3gECKVFqV/hdJe//cOOqMrRuj4p
	 xA1GlyKNe2w7jAISX+l/i3KErdkYUvaAn5GUxpY6MCwkEM6Pbfoa9symkwHAtDe7HfTsp
	 MEwv3GUnlBgiCKGdo12GkW2qHw6NYa2UArrHhiqUDSYW6BvVBlHKzOGhnXA7186PQk6Wl
	 VztQrJZNkDVVe66bjWtC6SC7dxveKiVgjY/vyCO3gTbBRRi9R0qVeKFpS+GWdbZ56wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vm5YSH24;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1C5606A337;
	Thu, 19 Nov 2026 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vm5YSH24
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795078648;
	b=EPKdeMKQnMK3ud9ylMDDdHqzAn90hurm5Q3U3sOk90IfIkJYMaMfeQ/HwWCb/OQjpwvL
	 kPB6Sx7Ws2cnJg896U5IZ0vQlIo+PcxxwAEoAgCjt83cYVgTkRS3VZCDn1C/M70wRH077
	 fn60ZLngBU4M0w/F6Iogrv+WQcXUj6aH0vWS89upSpNE2P7b+OScLSB1PkQDa1Gm8NyUK
	 PLXca4ly3QtcL1xZPOst9hfMX5uk2xTFyLi8aHR4IOkT17V+TB9RICX+19LffCqr9XVBD
	 xrKFx9rzAuWwab74jQzGvw+7FvpYdayBKKfFs7vit/ewfUu2fUp9XnQ6jsjdgWsHGfQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795078648;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Mec+5qup+REVZ2ul0shcEpYxGqz5NUS2jA/94J5NrDQ=;
	b=vgDE2EYctO6F1L8DpbOLIjY7mpdEgiafSZOmI+8/bUaAAQp2js972rddwlMfPjGn6Rg7
	 /P4uW+2JFRqGWQZ8ctnXCLhVfZezxep5S18sZj3kBQyIXHOiD7B/wlmX0o8aErmfcE1xp
	 UGH8MdkGEPa2Ev5FfP/fGmz8h5YA5mtqd/Nz2hUjyoKeTw5jJPlARGvNbZNUBhoErqjRI
	 +55g8u942fZiRT31uMWJr/Qv49wjRQxJTMA4dbZ9VoVOW4s0RSiZ8cqM2ppHmyvKLMs4I
	 1n2rcKCzQgnaCpLfHr0PqW8kZBnmU8kVFVXXa1gtwIYlJ6rhPoE7PseIavOqLsmDJBA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8EB331F000C9;
	Thu, 19 Nov 2026 08:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795078647;
	bh=Mec+5qup+REVZ2ul0shcEpYxGqz5NUS2jA/94J5NrDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Vm5YSH24+8o+9If/zb/h2+N6JINa8GpHYS5C7ttdR5sLZBYULbykWaqnFpZqucEPG
	 XYdWn53TpuAYqcRR/dtXtsoTxFcTpkdOpmsTLUXPwmtEGGNIlskxRsvuZco2+V3ZmN
	 Xk60H4IjcEnrl6wd5k9ciVOO4RkqsnDMBsv4auf1j4X2ngXNDqv0CjJkVG4tH5yJDq
	 fFdfxzmu02eGTq3bM4p8tcy3WyHTmtCX0rGCN/LSf0R5NPAx6sXd4zcz8q8QONBq1W
	 nMLkLfezLmdaS17fD+44en1inYsSmbxjhZIFgO4FdZGseo6oO7NUn5LLIn7lXlltyJ
	 wOKS9r+8wwH+g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1C6B94B1DC;
	Thu, 19 Nov 2026 08:57:26 +0000 (UTC)
From: =?utf-8?q?Jordan_DESNO=C3=8BS_via_B4_Relay?= <devnull+jordan.desnoes.francetv.fr@kernel.org>
Date: Thu, 19 Nov 2026 09:57:26 +0100
Subject: [PATCH 6.18.y 4/4] libceph: adapt ceph_x_challenge_blob hashing
 and msgr1 message signing
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261119-aes256k-6-18-y-v1-4-bd5db87da2f5@francetv.fr>
References: <20261119-aes256k-6-18-y-v1-0-bd5db87da2f5@francetv.fr>
In-Reply-To: <20261119-aes256k-6-18-y-v1-0-bd5db87da2f5@francetv.fr>
To: stable@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Xiubo Li <xiubo.li@clyso.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
 ceph-devel@vger.kernel.org, 
 =?utf-8?q?Jordan_DESNO=C3=8BS?= <jordan.desnoes@francetv.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795078645; l=8403;
 i=jordan.desnoes@francetv.fr; s=20261119; h=from:subject:message-id;
 bh=YbUYeUj8xsoc+Mg83NPT9/yh0NXTd4ZQv3ttYwlUU04=;
 b=ARP/3hcT80zMnNvJ3lL7uMvOom4ahH7QD3hyZdIAFbscIRt4xHPsqQp6eVYVFeZTpVXuSI2jf
 9kWJzzsuRZ2DtXo4TThRc7dc1Cm+sAFR/q+u9dlcTTCJHjLorWi3qfR
X-Developer-Key: i=jordan.desnoes@francetv.fr; a=ed25519;
 pk=NsqAnHujTt5QBjYGvDgx/bh9SKZzYfCniV8bhRv6vTA=
X-Endpoint-Received: by B4 Relay for jordan.desnoes@francetv.fr/20261119
 with auth_id=1567
X-Original-From: =?utf-8?q?Jordan_DESNO=C3=8BS?= <jordan.desnoes@francetv.fr>
Reply-To: jordan.desnoes@francetv.fr

From: Ilya Dryomov <idryomov@gmail.com>

commit 8356b4b1103b8c970648c94bab724aa30e42d869 upstream.

The existing approach where ceph_x_challenge_blob is encrypted with the
client's secret key and then the digest derived from the ciphertext is
used for the test doesn't work with CEPH_CRYPTO_AES256KRB5 because the
confounder randomizes the ciphertext: the client and the server get two
different ciphertexts and therefore two different digests.

msgr1 signatures are affected the same way: a digest derived from the
ciphertext for the message's "sigblock" is what becomes a signature and
the two sides disagree on the expected value.

For CEPH_CRYPTO_AES256KRB5 (and potential future encryption schemes),
switch to HMAC-SHA256 function keyed in the same way as the existing
encryption.  For CEPH_CRYPTO_AES, everything is preserved as is.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Jordan DESNOËS <jordan.desnoes@francetv.fr>
---
 net/ceph/auth_x.c       | 59 +++++++++++++++++++++++++++++++++++--------------
 net/ceph/crypto.c       | 18 +++++++++++++++
 net/ceph/crypto.h       |  4 ++++
 net/ceph/messenger_v2.c | 14 ++++++------
 4 files changed, 72 insertions(+), 23 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index 966a38264..9350e1a9d 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -558,8 +558,7 @@ static int ceph_x_build_request(struct ceph_auth_client *ac,
 	if (need & CEPH_ENTITY_TYPE_AUTH) {
 		struct ceph_x_authenticate *auth = (void *)(head + 1);
 		void *enc_buf = xi->auth_authorizer.enc_buf;
-		struct ceph_x_challenge_blob *blob = enc_buf +
-					     ceph_x_encrypt_offset(&xi->secret);
+		struct ceph_x_challenge_blob *blob;
 		u64 *u;
 
 		p = auth + 1;
@@ -569,15 +568,29 @@ static int ceph_x_build_request(struct ceph_auth_client *ac,
 		dout(" get_auth_session_key\n");
 		head->op = cpu_to_le16(CEPHX_GET_AUTH_SESSION_KEY);
 
-		/* encrypt and hash */
+		if (xi->secret.type == CEPH_CRYPTO_AES) {
+			blob = enc_buf + ceph_x_encrypt_offset(&xi->secret);
+		} else {
+			BUILD_BUG_ON(SHA256_DIGEST_SIZE + sizeof(*blob) >
+				     CEPHX_AU_ENC_BUF_LEN);
+			blob = enc_buf + SHA256_DIGEST_SIZE;
+		}
+
 		get_random_bytes(&auth->client_challenge, sizeof(u64));
 		blob->client_challenge = auth->client_challenge;
 		blob->server_challenge = cpu_to_le64(xi->server_challenge);
-		ret = ceph_x_encrypt(&xi->secret, 0 /* dummy */,
-				     enc_buf, CEPHX_AU_ENC_BUF_LEN,
-				     sizeof(*blob));
-		if (ret < 0)
-			return ret;
+
+		if (xi->secret.type == CEPH_CRYPTO_AES) {
+			ret = ceph_x_encrypt(&xi->secret, 0 /* dummy */,
+					     enc_buf, CEPHX_AU_ENC_BUF_LEN,
+					     sizeof(*blob));
+			if (ret < 0)
+				return ret;
+		} else {
+			ceph_hmac_sha256(&xi->secret, blob, sizeof(*blob),
+					 enc_buf);
+			ret = SHA256_DIGEST_SIZE;
+		}
 
 		auth->struct_v = 3;  /* nautilus+ */
 		auth->key = 0;
@@ -1065,11 +1078,19 @@ static int calc_signature(struct ceph_x_authorizer *au, struct ceph_msg *msg,
 			__le32 data_crc;
 			__le32 data_len;
 			__le32 seq_lower_word;
-		} __packed *sigblock = enc_buf;
+		} __packed *sigblock;
 		struct {
 			__le64 a, b, c, d;
 		} __packed *penc = enc_buf;
-		int ciphertext_len;
+
+		if (au->session_key.type == CEPH_CRYPTO_AES) {
+			/* no leading len, no ceph_x_encrypt_header */
+			sigblock = enc_buf;
+		} else {
+			BUILD_BUG_ON(SHA256_DIGEST_SIZE + sizeof(*sigblock) >
+				     CEPHX_AU_ENC_BUF_LEN);
+			sigblock = enc_buf + SHA256_DIGEST_SIZE;
+		}
 
 		sigblock->header_crc = msg->hdr.crc;
 		sigblock->front_crc = msg->footer.front_crc;
@@ -1080,12 +1101,18 @@ static int calc_signature(struct ceph_x_authorizer *au, struct ceph_msg *msg,
 		sigblock->data_len = msg->hdr.data_len;
 		sigblock->seq_lower_word = *(__le32 *)&msg->hdr.seq;
 
-		/* no leading len, no ceph_x_encrypt_header */
-		ret = ceph_crypt(&au->session_key, 0 /* dummy */,
-				 true, enc_buf, CEPHX_AU_ENC_BUF_LEN,
-				 sizeof(*sigblock), &ciphertext_len);
-		if (ret)
-			return ret;
+		if (au->session_key.type == CEPH_CRYPTO_AES) {
+			int ciphertext_len; /* unused */
+
+			ret = ceph_crypt(&au->session_key, 0 /* dummy */,
+					 true, enc_buf, CEPHX_AU_ENC_BUF_LEN,
+					 sizeof(*sigblock), &ciphertext_len);
+			if (ret)
+				return ret;
+		} else {
+			ceph_hmac_sha256(&au->session_key, sigblock,
+					 sizeof(*sigblock), enc_buf);
+		}
 
 		*psig = penc->a ^ penc->b ^ penc->c ^ penc->d;
 	}
diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
index b54085d8d..b2067ea6c 100644
--- a/net/ceph/crypto.c
+++ b/net/ceph/crypto.c
@@ -84,6 +84,7 @@ int ceph_crypto_key_prepare(struct ceph_crypto_key *key,
 	case CEPH_CRYPTO_AES:
 		return set_aes_tfm(key);
 	case CEPH_CRYPTO_AES256KRB5:
+		hmac_sha256_preparekey(&key->hmac_key, key->key, key->len);
 		return set_krb5_tfms(key, key_usages, key_usage_cnt);
 	default:
 		return -ENOTSUPP;
@@ -178,6 +179,7 @@ void ceph_crypto_key_destroy(struct ceph_crypto_key *key)
 			key->aes_tfm = NULL;
 		}
 	} else if (key->type == CEPH_CRYPTO_AES256KRB5) {
+		memzero_explicit(&key->hmac_key, sizeof(key->hmac_key));
 		for (i = 0; i < ARRAY_SIZE(key->krb5_tfms); i++) {
 			if (key->krb5_tfms[i]) {
 				crypto_free_aead(key->krb5_tfms[i]);
@@ -436,6 +438,22 @@ int ceph_crypt_buflen(const struct ceph_crypto_key *key, int data_len)
 	}
 }
 
+void ceph_hmac_sha256(const struct ceph_crypto_key *key, const void *buf,
+		      int buf_len, u8 hmac[SHA256_DIGEST_SIZE])
+{
+	switch (key->type) {
+	case CEPH_CRYPTO_NONE:
+	case CEPH_CRYPTO_AES:
+		memset(hmac, 0, SHA256_DIGEST_SIZE);
+		return;
+	case CEPH_CRYPTO_AES256KRB5:
+		hmac_sha256(&key->hmac_key, buf, buf_len, hmac);
+		return;
+	default:
+		BUG();
+	}
+}
+
 static int ceph_key_preparse(struct key_preparsed_payload *prep)
 {
 	struct ceph_crypto_key *ckey;
diff --git a/net/ceph/crypto.h b/net/ceph/crypto.h
index 2c37c54d0..3a2ade15a 100644
--- a/net/ceph/crypto.h
+++ b/net/ceph/crypto.h
@@ -2,6 +2,7 @@
 #ifndef _FS_CEPH_CRYPTO_H
 #define _FS_CEPH_CRYPTO_H
 
+#include <crypto/sha2.h>
 #include <linux/ceph/types.h>
 #include <linux/ceph/buffer.h>
 
@@ -20,6 +21,7 @@ struct ceph_crypto_key {
 	union {
 		struct crypto_sync_skcipher *aes_tfm;
 		struct {
+			struct hmac_sha256_key hmac_key;
 			const struct krb5_enctype *krb5_type;
 			struct crypto_aead *krb5_tfms[3];
 		};
@@ -39,6 +41,8 @@ int ceph_crypt(const struct ceph_crypto_key *key, int usage_slot, bool encrypt,
 	       void *buf, int buf_len, int in_len, int *pout_len);
 int ceph_crypt_data_offset(const struct ceph_crypto_key *key);
 int ceph_crypt_buflen(const struct ceph_crypto_key *key, int data_len);
+void ceph_hmac_sha256(const struct ceph_crypto_key *key, const void *buf,
+		      int buf_len, u8 hmac[SHA256_DIGEST_SIZE]);
 int ceph_crypto_init(void);
 void ceph_crypto_shutdown(void);
 
diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index 4bb238eb8..d5300c662 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -778,9 +778,9 @@ static int setup_crypto(struct ceph_connection *con,
 	return 0;  /* auth_x, secure mode */
 }
 
-static void ceph_hmac_sha256(struct ceph_connection *con,
-			     const struct kvec *kvecs, int kvec_cnt,
-			     u8 hmac[SHA256_DIGEST_SIZE])
+static void con_hmac_sha256(struct ceph_connection *con,
+			    const struct kvec *kvecs, int kvec_cnt,
+			    u8 hmac[SHA256_DIGEST_SIZE])
 {
 	struct hmac_sha256_ctx ctx;
 	int i;
@@ -1437,8 +1437,8 @@ static int prepare_auth_signature(struct ceph_connection *con)
 	if (!buf)
 		return -ENOMEM;
 
-	ceph_hmac_sha256(con, con->v2.in_sign_kvecs, con->v2.in_sign_kvec_cnt,
-			 CTRL_BODY(buf));
+	con_hmac_sha256(con, con->v2.in_sign_kvecs, con->v2.in_sign_kvec_cnt,
+			CTRL_BODY(buf));
 
 	return prepare_control(con, FRAME_TAG_AUTH_SIGNATURE, buf,
 			       SHA256_DIGEST_SIZE);
@@ -2441,8 +2441,8 @@ static int process_auth_signature(struct ceph_connection *con,
 		return -EINVAL;
 	}
 
-	ceph_hmac_sha256(con, con->v2.out_sign_kvecs, con->v2.out_sign_kvec_cnt,
-			 hmac);
+	con_hmac_sha256(con, con->v2.out_sign_kvecs, con->v2.out_sign_kvec_cnt,
+			hmac);
 
 	ceph_decode_need(&p, end, SHA256_DIGEST_SIZE, bad);
 	if (crypto_memneq(p, hmac, SHA256_DIGEST_SIZE)) {

-- 
2.43.0


