Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795078647;
	b=iSco/73SUZcYPIDmhfKWeQwQZ+o1lxHuzmE26k0ktW8JRPTgjCWvmOG1mH4k0kM8tiQ0
	 LBQ/kjPuyUIbIzWtlZ4t4LzHGNCgza046Z135VbtqYAd9JcO+Tim9Ss/i6l+7PnuIyCEh
	 QDJJKUdJrSnvblblNkjdORq5ELUCT63rh5ZfrPtUWqLcwRoZW5Ox3YubeLENcpFj+I4GI
	 61afz27A6N2RW3NAAaQPNGY4J8ocgWnQqbR7pEIIkkcj/ifXc4ftX/LXM1AD/QIhhlfct
	 rySCGUsijF1/rTnR4V8LuCzjM3UYZFgDAhuDjnL8FMqP71xMSQKD00r6kfscBQkb3rA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078647;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Wu/SrGBKHb2g0yZ5A2/FKkiV01z2oNWIPMVubfpN10E=;
	b=T0+nw84Jhd4TceMTNdXDOwVfv0W7qKvRKXEeNNtyiNKq3n/rmCAkjZEKdKzXBbzzXty+
	 liiVMUr+fS9DsnBkJH9jEI+4myPR3OqRhanRYlPj3R4lDGYHt1O5u2eLwSUQDVAAhw7IT
	 8g2281QPjiOX9owODW/LhfIRes+0tCPpxXXoOxLz/DaqFERhwDggUDpjecediVJCO/xoe
	 LEDFEze057gG2l0RXsoNBCb9NtIWplVC+U76+f5HXxINfxc7hOXzmTNTW4ioGC9tDkToz
	 fv9Oj0g8QOrJ+1+2ZXxThwL9NHcKal8E+PM97+ALPUJBS8gM8ejMfMag90OvpGfoRbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ASxaKRPS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA07D606A32C;
	Thu, 19 Nov 2026 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ASxaKRPS
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795078647;
	b=MFXzGA4M9eub02ANvU0HeSbA+Bdo/p5SMUnIU3d9Xhcl2o7yGewdbv+I8lT9ioldoZdR
	 iq10EyWARgxF9NUPmfLIpqjWjvvP7NWOsbT7RGZImnRxvCjCllfLpRiXpAvofAsnkd6Mn
	 Wajd0PqHS/IZD64V9RIpAUPJnbK2G+pJBdYU/qd8myHcn/eXz3TqxJNMFXoB+p0Rn1RoY
	 nvbkAqUwUwdDKfatDB8RA3D3A1i88Zhupg/tS2fju6zs7lM8oQT5/HrK47uV3Weylb9Fb
	 doaq20Fy7bkQ0i/tArMmgrXu14rKZ1qShLGHkbRVK8JvcwEMj5snzeNvH6B8PPmQ9RQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795078647;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Wu/SrGBKHb2g0yZ5A2/FKkiV01z2oNWIPMVubfpN10E=;
	b=m+hDbWerrRnr29QoDG5WHovj3o0Sa0j6MGvqyLxRUq4UH8ys0WVMhdt2gInIi3k4Uet3
	 QGvaoCBk26HU5/juqlKYjiER2EyO6rUI6n5tji3AJXjIj2oIOESOMd25sf9Sytnu0RyMT
	 WZUiB7nfTBMeJ2koVzQA0tnuhR/ibvD9S0Gt2boekxetgQexPX1DJHp4IpeHUIroUxjy2
	 eUQVlzqQV3sPr7k1ttkmhqQNo4BEFh3zrb0zKYP6nNzNWEJzoIqRzunC+ZjJLb1DChcM+
	 n1ym+KWNWUPR8ZKeGU1aSUppUM3bLPYAM1XnAi+ET382uUnbKz6rqbxvsvt9zK2HEVw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4AE6B1F000C6;
	Thu, 19 Nov 2026 08:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795078647;
	bh=Wu/SrGBKHb2g0yZ5A2/FKkiV01z2oNWIPMVubfpN10E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ASxaKRPSzQnArGjjayEm6ttRiIjE1YdvvvJX/cj8gx4vn6tV8Evc+6m/cJqq67QYe
	 C9sxiTaIF6UH8czLPcAbT4eXPD+Fm9cuq5JvOfFppbFcTOeJRzm1rTYkCZ5qoqb5Fl
	 1EfOj6jvpwQ/3jKA7D2G3kA+Ya2Ju2Nzg9zzyGZ3dZ55Sn4p7VAD+7DYiPqHc1Wwcg
	 mD7aKPkyEXY53PPd0gVWb92/ScovKwxb5d0OlMkxaLcH2W+KQbpNkmjw+JsL7k9ohA
	 9eVd4vDlc63M1HCEY9KAggqUHeNBSC91MhlJBEt+AyANQFlz9JNJNp6l586dvgrscQ
	 gV8Zr2XDvt8/g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CAAFF4B1D2;
	Thu, 19 Nov 2026 08:57:25 +0000 (UTC)
From: =?utf-8?q?Jordan_DESNO=C3=8BS_via_B4_Relay?= <devnull+jordan.desnoes.francetv.fr@kernel.org>
Date: Thu, 19 Nov 2026 09:57:23 +0100
Subject: [PATCH 6.18.y 1/4] libceph: generalize ceph_x_encrypt_offset() and
 ceph_x_encrypt_buflen()
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
Message-Id: <20261119-aes256k-6-18-y-v1-1-bd5db87da2f5@francetv.fr>
References: <20261119-aes256k-6-18-y-v1-0-bd5db87da2f5@francetv.fr>
In-Reply-To: <20261119-aes256k-6-18-y-v1-0-bd5db87da2f5@francetv.fr>
To: stable@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Xiubo Li <xiubo.li@clyso.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
 ceph-devel@vger.kernel.org, 
 =?utf-8?q?Jordan_DESNO=C3=8BS?= <jordan.desnoes@francetv.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795078645; l=7492;
 i=jordan.desnoes@francetv.fr; s=20261119; h=from:subject:message-id;
 bh=iEzjxOYX3Hdxb7Jo0K8dEmAqF3tW2pOOAN0UWjmvS04=;
 b=Nq0PyRH2pKeQcLEdT4PpQCrya+vi9Ji9E2PkW2zM5AZUPpazBvUAygo4h0AxPnNeSPkgZBht8
 f6+qKQW3WRTBh+DbgE2mBwN92EDDyR8k0KfpITrQ8Ym9U3rde6Easxh
X-Developer-Key: i=jordan.desnoes@francetv.fr; a=ed25519;
 pk=NsqAnHujTt5QBjYGvDgx/bh9SKZzYfCniV8bhRv6vTA=
X-Endpoint-Received: by B4 Relay for jordan.desnoes@francetv.fr/20261119
 with auth_id=1567
X-Original-From: =?utf-8?q?Jordan_DESNO=C3=8BS?= <jordan.desnoes@francetv.fr>
Reply-To: jordan.desnoes@francetv.fr

From: Ilya Dryomov <idryomov@gmail.com>

commit 0ee8bccf7396d50726c9c8dd3135fb64a9fe8426 upstream.

- introduce the notion of a data offset for ceph_x_encrypt_offset()
  to allow for e.g. confounder to be prepended before the encryption
  header in the future.  For CEPH_CRYPTO_AES, the data offset is 0
  (i.e. nothing is prepended).

- adjust ceph_x_encrypt_buflen() accordingly and make it account for
  PKCS#7 padding that is used by CEPH_CRYPTO_AES precisely instead of
  just always adding 16.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
[ Jordan: resolve conflict with 821365487aa5 in __ceph_x_decrypt() ]
Signed-off-by: Jordan DESNOËS <jordan.desnoes@francetv.fr>
---
 net/ceph/auth_x.c | 44 +++++++++++++++++++++++++++++---------------
 net/ceph/crypto.c | 25 +++++++++++++++++++++++++
 net/ceph/crypto.h |  2 ++
 3 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index f805a8133..d1c7b7880 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -44,23 +44,35 @@ static int ceph_x_should_authenticate(struct ceph_auth_client *ac)
 	return !!need;
 }
 
-static int ceph_x_encrypt_offset(void)
+static int __ceph_x_encrypt_offset(const struct ceph_crypto_key *key)
 {
-	return sizeof(u32) + sizeof(struct ceph_x_encrypt_header);
+	return ceph_crypt_data_offset(key) +
+	       sizeof(struct ceph_x_encrypt_header);
 }
 
-static int ceph_x_encrypt_buflen(int ilen)
+static int ceph_x_encrypt_offset(const struct ceph_crypto_key *key)
 {
-	return ceph_x_encrypt_offset() + ilen + 16;
+	return sizeof(u32) + __ceph_x_encrypt_offset(key);
+}
+
+/*
+ * AES: ciphertext_len | hdr | data... | padding
+ */
+static int ceph_x_encrypt_buflen(const struct ceph_crypto_key *key,
+				 int data_len)
+{
+	int encrypt_len = sizeof(struct ceph_x_encrypt_header) + data_len;
+	return sizeof(u32) + ceph_crypt_buflen(key, encrypt_len);
 }
 
 static int ceph_x_encrypt(struct ceph_crypto_key *secret, void *buf,
 			  int buf_len, int plaintext_len)
 {
-	struct ceph_x_encrypt_header *hdr = buf + sizeof(u32);
+	struct ceph_x_encrypt_header *hdr;
 	int ciphertext_len;
 	int ret;
 
+	hdr = buf + sizeof(u32) + ceph_crypt_data_offset(secret);
 	hdr->struct_v = 1;
 	hdr->magic = cpu_to_le64(CEPHX_ENC_MAGIC);
 
@@ -77,7 +89,7 @@ static int ceph_x_encrypt(struct ceph_crypto_key *secret, void *buf,
 static int __ceph_x_decrypt(struct ceph_crypto_key *secret, void *p,
 			    int ciphertext_len)
 {
-	struct ceph_x_encrypt_header *hdr = p;
+	struct ceph_x_encrypt_header *hdr;
 	int plaintext_len;
 	int ret;
 
@@ -91,6 +103,7 @@ static int __ceph_x_decrypt(struct ceph_crypto_key *secret, void *p,
 		return -EINVAL;
 	}
 
+	hdr = p + ceph_crypt_data_offset(secret);
 	if (le64_to_cpu(hdr->magic) != CEPHX_ENC_MAGIC) {
 		pr_err("%s bad magic\n", __func__);
 		return -EINVAL;
@@ -198,7 +211,7 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	}
 
 	/* blob for me */
-	dp = *p + ceph_x_encrypt_offset();
+	dp = *p + ceph_x_encrypt_offset(secret);
 	ret = ceph_x_decrypt(secret, p, end);
 	if (ret < 0)
 		goto out;
@@ -225,7 +238,7 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	ceph_decode_8_safe(p, end, is_enc, bad);
 	if (is_enc) {
 		/* encrypted */
-		tp = *p + ceph_x_encrypt_offset();
+		tp = *p + ceph_x_encrypt_offset(&th->session_key);
 		ret = ceph_x_decrypt(&th->session_key, p, end);
 		if (ret < 0)
 			goto out;
@@ -317,7 +330,7 @@ static int encrypt_authorizer(struct ceph_x_authorizer *au,
 	p = (void *)(msg_a + 1) + le32_to_cpu(msg_a->ticket_blob.blob_len);
 	end = au->buf->vec.iov_base + au->buf->vec.iov_len;
 
-	msg_b = p + ceph_x_encrypt_offset();
+	msg_b = p + ceph_x_encrypt_offset(&au->session_key);
 	msg_b->struct_v = 2;
 	msg_b->nonce = cpu_to_le64(au->nonce);
 	if (server_challenge) {
@@ -373,7 +386,7 @@ static int ceph_x_build_authorizer(struct ceph_auth_client *ac,
 		goto out_au;
 
 	maxlen = sizeof(*msg_a) + ticket_blob_len +
-		ceph_x_encrypt_buflen(sizeof(*msg_b));
+		ceph_x_encrypt_buflen(&au->session_key, sizeof(*msg_b));
 	dout("  need len %d\n", maxlen);
 	if (au->buf && au->buf->alloc_len < maxlen) {
 		ceph_buffer_put(au->buf);
@@ -512,7 +525,7 @@ static int ceph_x_build_request(struct ceph_auth_client *ac,
 		struct ceph_x_authenticate *auth = (void *)(head + 1);
 		void *enc_buf = xi->auth_authorizer.enc_buf;
 		struct ceph_x_challenge_blob *blob = enc_buf +
-							ceph_x_encrypt_offset();
+					     ceph_x_encrypt_offset(&xi->secret);
 		u64 *u;
 
 		p = auth + 1;
@@ -639,7 +652,7 @@ static int handle_auth_session_key(struct ceph_auth_client *ac, u64 global_id,
 	ceph_decode_need(p, end, len, e_inval);
 	dout("%s connection secret blob len %d\n", __func__, len);
 	if (len > 0) {
-		dp = *p + ceph_x_encrypt_offset();
+		dp = *p + ceph_x_encrypt_offset(&th->session_key);
 		ret = ceph_x_decrypt(&th->session_key, p, *p + len);
 		if (ret < 0)
 			return ret;
@@ -816,7 +829,7 @@ static int decrypt_authorizer_challenge(struct ceph_crypto_key *secret,
 		return ret;
 
 	dout("%s decrypted %d bytes\n", __func__, ret);
-	dp = challenge + sizeof(struct ceph_x_encrypt_header);
+	dp = challenge + __ceph_x_encrypt_offset(secret);
 	dend = dp + ret;
 
 	ceph_decode_skip_8(&dp, dend, e_inval);  /* struct_v */
@@ -863,7 +876,7 @@ static int decrypt_authorizer_reply(struct ceph_crypto_key *secret,
 	u8 struct_v;
 	int ret;
 
-	dp = *p + ceph_x_encrypt_offset();
+	dp = *p + ceph_x_encrypt_offset(secret);
 	ret = ceph_x_decrypt(secret, p, end);
 	if (ret < 0)
 		return ret;
@@ -986,7 +999,8 @@ static int calc_signature(struct ceph_x_authorizer *au, struct ceph_msg *msg,
 			__le32 front_crc;
 			__le32 middle_crc;
 			__le32 data_crc;
-		} __packed *sigblock = enc_buf + ceph_x_encrypt_offset();
+		} __packed *sigblock = enc_buf +
+				       ceph_x_encrypt_offset(&au->session_key);
 
 		sigblock->len = cpu_to_le32(4*sizeof(u32));
 		sigblock->header_crc = msg->hdr.crc;
diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
index 5601732cf..2b98daffe 100644
--- a/net/ceph/crypto.c
+++ b/net/ceph/crypto.c
@@ -285,6 +285,31 @@ int ceph_crypt(const struct ceph_crypto_key *key, bool encrypt,
 	}
 }
 
+int ceph_crypt_data_offset(const struct ceph_crypto_key *key)
+{
+	switch (key->type) {
+	case CEPH_CRYPTO_NONE:
+	case CEPH_CRYPTO_AES:
+		return 0;
+	default:
+		BUG();
+	}
+}
+
+int ceph_crypt_buflen(const struct ceph_crypto_key *key, int data_len)
+{
+	switch (key->type) {
+	case CEPH_CRYPTO_NONE:
+		return data_len;
+	case CEPH_CRYPTO_AES:
+		/* PKCS#7 padding at the end */
+		return data_len + AES_BLOCK_SIZE -
+		       (data_len & (AES_BLOCK_SIZE - 1));
+	default:
+		BUG();
+	}
+}
+
 static int ceph_key_preparse(struct key_preparsed_payload *prep)
 {
 	struct ceph_crypto_key *ckey;
diff --git a/net/ceph/crypto.h b/net/ceph/crypto.h
index a20bad6d1..736ec6d2f 100644
--- a/net/ceph/crypto.h
+++ b/net/ceph/crypto.h
@@ -28,6 +28,8 @@ void ceph_crypto_key_destroy(struct ceph_crypto_key *key);
 /* crypto.c */
 int ceph_crypt(const struct ceph_crypto_key *key, bool encrypt,
 	       void *buf, int buf_len, int in_len, int *pout_len);
+int ceph_crypt_data_offset(const struct ceph_crypto_key *key);
+int ceph_crypt_buflen(const struct ceph_crypto_key *key, int data_len);
 int ceph_crypto_init(void);
 void ceph_crypto_shutdown(void);
 

-- 
2.43.0


