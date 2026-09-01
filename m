Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B23F6C21
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274131; cv=none; b=F7jo9jTmzQ7dcssfboPVhVHWSy/mfJUc3fdMAnGEuiIzzzyDUJ/JfQpbgP6YzU6iDRngkErjwMTkvp8b8OcGbi+Q4e2V91u1dYrt+H58/RMfTudbHi//q0QTXtKuA5htNAN641TE0g/K0EXcpXJtLQCBsoBiCM7jqnAOcaOFxlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274131; c=relaxed/simple;
	bh=0vGdFEtZVFQuP9tUxviHxusWwTzqiNJT6d1vgtjXG7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glkDB+tuct4v+XPwDHRvQ8/XyXg7s6KSt9MnRujWns4AQY1qeO/7V1E7PaIBbPgQ/wbpAOEPgTdqbUWNWZrDoJlOiyDNP/aEK4SIkfy+GgjyBrHEPem5SZ/HR28e2wPGJDpit9Gcu9F05dZWRc37OL6lNguvlrKba/zBcDFf97I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bvl2iLSN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bvl2iLSN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C111F00A3A;
	Tue,  1 Sep 2026 14:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788274130;
	bh=P666X3AAgZ33L+q00uB7DeNIzGRL3K92omhiCfCmdcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bvl2iLSNFUL9Zk7lPp9PnE7YfsrcbpJk2Q1qwAXKXBH3kTU8Tp1N6Is2NHyW222e1
	 yEOJjaw1/NmQOzn9eJrwsmRLKSBrMEeTuM+Ht385L0iylTg8yOtWTUG5m5gEDuP0gC
	 4xiAvcwHZLqhIXRpC1L8zUykjti106KdzmQUaUiJOr8Kl1wAnbJvQhOCa+hpqn5wEv
	 B2/wCYMU4lo6MXkVGbdT6ASd6CcyqLPl5Jq6jFmoBAErWLE9IGKm8XUILGC9UvwAc1
	 cW89vCjyvH+XI0LiUM9Lfc96mqNgRsSQwhfIRJPNhQWUtIS519FuCVz4uXpAc6xHMs
	 yPacLjDCbXiLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] crypto: virtio - Drop superfluous [as]kcipher_req pointer
Date: Tue,  1 Sep 2026 10:48:44 -0400
Message-ID: <20260901144845.1102445-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901144845.1102445-1-sashal@kernel.org>
References: <2026083111-ahoy-glove-a297@gregkh>
 <20260901144845.1102445-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit 62d027fb49c76475c5256ab69059752f42c3730f ]

The request context virtio_crypto_{akcipher,sym}_request contains a
pointer to the [as]kcipher_request itself.

The pointer is superfluous as it can be calculated with container_of().

Drop the superfluous pointer.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: f77a956f6a19 ("crypto: virtio - bound the akcipher result length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 9 ++++-----
 drivers/crypto/virtio/virtio_crypto_skcipher_algs.c | 8 +++-----
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index f110d9a72f6bf..db3817f5ab46e 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -36,7 +36,6 @@ struct virtio_crypto_akcipher_ctx {
 
 struct virtio_crypto_akcipher_request {
 	struct virtio_crypto_request base;
-	struct akcipher_request *akcipher_req;
 	void *src_buf;
 	void *dst_buf;
 	uint32_t opcode;
@@ -68,7 +67,9 @@ static void virtio_crypto_dataq_akcipher_callback(struct virtio_crypto_request *
 {
 	struct virtio_crypto_akcipher_request *vc_akcipher_req =
 		container_of(vc_req, struct virtio_crypto_akcipher_request, base);
-	struct akcipher_request *akcipher_req;
+	struct akcipher_request *akcipher_req =
+		container_of((void *)vc_akcipher_req, struct akcipher_request,
+			     __ctx);
 	int error;
 
 	switch (vc_req->status) {
@@ -87,8 +88,7 @@ static void virtio_crypto_dataq_akcipher_callback(struct virtio_crypto_request *
 		break;
 	}
 
-	akcipher_req = vc_akcipher_req->akcipher_req;
-	/* actual length maybe less than dst buffer */
+	/* actual length may be less than dst buffer */
 	akcipher_req->dst_len = len - sizeof(vc_req->status);
 	sg_copy_from_buffer(akcipher_req->dst, sg_nents(akcipher_req->dst),
 			    vc_akcipher_req->dst_buf, akcipher_req->dst_len);
@@ -320,7 +320,6 @@ static int virtio_crypto_rsa_req(struct akcipher_request *req, uint32_t opcode)
 
 	vc_req->dataq = data_vq;
 	vc_req->alg_cb = virtio_crypto_dataq_akcipher_callback;
-	vc_akcipher_req->akcipher_req = req;
 	vc_akcipher_req->opcode = opcode;
 
 	return crypto_transfer_akcipher_request_to_engine(data_vq->engine, req);
diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
index c93df8a8f67bc..40d8d95a0f7a4 100644
--- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
@@ -31,7 +31,6 @@ struct virtio_crypto_sym_request {
 
 	/* Cipher or aead */
 	uint32_t type;
-	struct skcipher_request *skcipher_req;
 	uint8_t *iv;
 	/* Encryption? */
 	bool encrypt;
@@ -59,7 +58,9 @@ static void virtio_crypto_dataq_sym_callback
 {
 	struct virtio_crypto_sym_request *vc_sym_req =
 		container_of(vc_req, struct virtio_crypto_sym_request, base);
-	struct skcipher_request *ablk_req;
+	struct skcipher_request *ablk_req =
+		container_of((void *)vc_sym_req, struct skcipher_request,
+			     __ctx);
 	int error;
 
 	/* Finish the encrypt or decrypt process */
@@ -79,7 +80,6 @@ static void virtio_crypto_dataq_sym_callback
 			error = -EIO;
 			break;
 		}
-		ablk_req = vc_sym_req->skcipher_req;
 		virtio_crypto_skcipher_finalize_req(vc_sym_req,
 							ablk_req, error);
 	}
@@ -483,7 +483,6 @@ static int virtio_crypto_skcipher_encrypt(struct skcipher_request *req)
 
 	vc_req->dataq = data_vq;
 	vc_req->alg_cb = virtio_crypto_dataq_sym_callback;
-	vc_sym_req->skcipher_req = req;
 	vc_sym_req->encrypt = true;
 
 	return crypto_transfer_skcipher_request_to_engine(data_vq->engine, req);
@@ -507,7 +506,6 @@ static int virtio_crypto_skcipher_decrypt(struct skcipher_request *req)
 
 	vc_req->dataq = data_vq;
 	vc_req->alg_cb = virtio_crypto_dataq_sym_callback;
-	vc_sym_req->skcipher_req = req;
 	vc_sym_req->encrypt = false;
 
 	return crypto_transfer_skcipher_request_to_engine(data_vq->engine, req);
-- 
2.53.0

