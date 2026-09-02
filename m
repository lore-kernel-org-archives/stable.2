Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944A321ABB1
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 00:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309208; cv=none; b=eyuabGnqSY403o3IEaZBgiqy80M7/hkGC6KjXbVgBflgR4kqn0WzLrTA54GLLoVcTIj4Q0k2gOj3LIFLiPqFhzz/ct8sRvYg1U8RKK+Fvps1UEpC+4/UBDUpUoqsPiOKkPU3y9cXExS16N//CZ2UYzQJ6m4NV9iwmgjhSyH7Dxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309208; c=relaxed/simple;
	bh=lc/WvPYKCVXv08EW1LfOi1LQKJ0HIFh7cRQn6B0PMFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhApbMA6UIiG+6+VilSSpGq/gHlZMne7GTHDhbcGpBbJR5mdonRy3SUSRkAzQ5DovVbJ82V8rmzg76HDNMBDyUCqbIaLVcCEPTdQiwa8lxRjQ9SaPeAH/aSOON+fgZsAHV9XKlDR/dROPOGirfGENXP5WQ9q/l9NdqMRHqqToVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNL8sRJ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNL8sRJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC3E1F00A3D;
	Wed,  2 Sep 2026 00:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788309207;
	bh=VLNVj+QaUKEPXp57eMlH6E2K45ohl91NJvq6tEEn7p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FNL8sRJ73D3MPUxpaHLi36nYGD9LGNNsgypExZ/9Xt8qmMgPDvnqVWTRQVoi4Okrx
	 VOlWF8GGQE30s7jeAjh6/SjVmXSJxdU0PyQHyzu7bl7f1RSMmunQYSEmjHAgvcV5Fp
	 tm8QNYwcz/t73xW1CrX+peC8d0uhSP7+qFpUBfxz3d2LzeDIQSn3WTzsWm0srPh3wj
	 /wFe9mW9BTt8S/tnw9Vhs1hmLzdMaq4L8MzAQqBa9NTwUdKaSqbsvzhrIxiJWc7pJL
	 Q/aI6HzBoyeucEVHu28nuq4TlHXnnmSF6U5J97vkVzJjA8+pdfyEystuNYzh9Nx/TJ
	 pnh2xc2o1laEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] crypto: atmel-ecc - clean up and improve ECDH comments
Date: Tue,  1 Sep 2026 20:33:23 -0400
Message-ID: <20260902003324.1792196-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902003324.1792196-1-sashal@kernel.org>
References: <2026083113-trough-translate-08c1@gregkh>
 <20260902003324.1792196-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit 3e84fb698abada239d3e35ed3d52a24dbfda5f6a ]

Improve the kerneldoc for struct atmel_ecdh_ctx by removing the stale
"unsupported curves" wording, since the device only supports a single
curve (P-256), and move the set_secret() constraint to the description.

In atmel_ecdh_set_secret(), clarify that the device generates the
private key, and drop the redundant "only supports NIST P256" comment.

In atmel_ecdh_done() and atmel_ecdh_generate_public_key(), clarify the
truncation comments. Also note that a P-256 public key consists of two
32-byte coordinates in atmel_ecdh_compute_shared_secret(), and remove
the unnecessary fall-through comment and other redundant comments.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: f07a0d251db7 ("crypto: atmel-ecc - avoid stale fallback key after set_secret failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/atmel-ecc.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
index e21466dfd0753..7950e635277a5 100644
--- a/drivers/crypto/atmel-ecc.c
+++ b/drivers/crypto/atmel-ecc.c
@@ -27,15 +27,14 @@ static struct atmel_ecc_driver_data driver_data;
 
 /**
  * struct atmel_ecdh_ctx - transformation context
- * @client     : pointer to i2c client device
- * @fallback   : used for unsupported curves or when user wants to use its own
- *               private key.
- * @public_key : generated when calling set_secret(). It's the responsibility
- *               of the user to not call set_secret() while
- *               generate_public_key() or compute_shared_secret() are in flight.
- * @curve_id   : elliptic curve id
- * @do_fallback: true when the device doesn't support the curve or when the user
- *               wants to use its own private key.
+ * @client: I2C client device
+ * @fallback: ECDH fallback used for caller-provided private keys
+ * @public_key: cached public key for the device-generated private key
+ * @curve_id: elliptic curve id
+ * @do_fallback: true when ECDH operations should use @fallback
+ *
+ * The caller must not invoke set_secret() while generate_public_key()
+ * or compute_shared_secret() are in flight.
  */
 struct atmel_ecdh_ctx {
 	struct i2c_client *client;
@@ -55,7 +54,7 @@ static void atmel_ecdh_done(struct atmel_i2c_work_data *work_data, void *areq,
 	if (status)
 		goto free_work_data;
 
-	/* might want less than we've got */
+	/* copy only as much as requested, capped at 32 bytes */
 	n_sz = min(ATMEL_ECC_NIST_P256_N_SIZE, req->dst_len);
 
 	/* copy the shared secret */
@@ -64,15 +63,15 @@ static void atmel_ecdh_done(struct atmel_i2c_work_data *work_data, void *areq,
 	if (copied != n_sz)
 		status = -EINVAL;
 
-	/* fall through */
 free_work_data:
 	kfree_sensitive(work_data);
 	kpp_request_complete(req, status);
 }
 
 /*
- * A random private key is generated and stored in the device. The device
- * returns the pair public key.
+ * If no private key is provided, generate one in the device and cache
+ * the corresponding public key. The generated private key never leaves
+ * the device.
  */
 static int atmel_ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 				 unsigned int len)
@@ -83,9 +82,7 @@ static int atmel_ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 	struct ecdh params;
 	int ret = -ENOMEM;
 
-	/* free the old public key, if any */
 	kfree(ctx->public_key);
-	/* make sure you don't free the old public key twice */
 	ctx->public_key = NULL;
 
 	if (crypto_ecdh_decode_key(buf, len, &params) < 0) {
@@ -94,7 +91,6 @@ static int atmel_ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 	}
 
 	if (params.key_size) {
-		/* fallback to ecdh software implementation */
 		ctx->do_fallback = true;
 		return crypto_kpp_set_secret(ctx->fallback, buf, len);
 	}
@@ -103,11 +99,6 @@ static int atmel_ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 	if (!cmd)
 		return -ENOMEM;
 
-	/*
-	 * The device only supports NIST P256 ECC keys. The public key size will
-	 * always be the same. Use a macro for the key size to avoid unnecessary
-	 * computations.
-	 */
 	public_key = kmalloc(ATMEL_ECC_PUBKEY_SIZE, GFP_KERNEL);
 	if (!public_key)
 		goto free_cmd;
@@ -120,7 +111,6 @@ static int atmel_ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 	if (ret)
 		goto free_public_key;
 
-	/* save the public key */
 	memcpy(public_key, &cmd->data[RSP_DATA_IDX], ATMEL_ECC_PUBKEY_SIZE);
 	ctx->public_key = public_key;
 
@@ -149,7 +139,7 @@ static int atmel_ecdh_generate_public_key(struct kpp_request *req)
 	if (!ctx->public_key)
 		return -EINVAL;
 
-	/* might want less than we've got */
+	/* copy only as much as requested, capped at 64 bytes */
 	nbytes = min(ATMEL_ECC_PUBKEY_SIZE, req->dst_len);
 
 	/* public key was saved at private key generation */
@@ -175,7 +165,7 @@ static int atmel_ecdh_compute_shared_secret(struct kpp_request *req)
 		return crypto_kpp_compute_shared_secret(req);
 	}
 
-	/* must have exactly two points to be on the curve */
+	/* A P-256 public key must contain two 32-byte coordinates */
 	if (req->src_len != ATMEL_ECC_PUBKEY_SIZE)
 		return -EINVAL;
 
-- 
2.53.0

