Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1659267B89
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264617; cv=none; b=CEJNwcoyrsmYb8jutgRVwer65jvARzw6cXhqCiGtLtAZ1hchKjIBWQNFKKUIn9oTAkWWvtNsf0ej4vPagbd1UlWGdOY5ohnnSl1RCNGQtlqYVuPdTbnJjmbE3XPEwMTyExue9sF4+OxxH+Wbkdqfz3KYXbcXNHiuSBigxJ+1gCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264617; c=relaxed/simple;
	bh=uy1laicbRsnzBkPWMTvgiZESCrCdy1vwClQXSJA7qgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnKTiQYf3HT22P5gnZasvVyUnEai8UpINV/okke5XlioyGDrvmDgf4S+zsBcoa8jASnUlGa27+6TfRbJojCG3ZaDjtjm8DonXsBtc1vwrNO4HZnGnyz9w7tw4eEvUarD6hX7EDjCsiwPyWhXeBPu4LDA2YUD/m9EEH0rmpJLp0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNyuFFP9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNyuFFP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7631F00A3D;
	Tue,  1 Sep 2026 12:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788264616;
	bh=i9LHhgtxgnd5c+yTQK+ifeDakEHTBbVaOrBUTJZ9HXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BNyuFFP9YHAJ4ik9XujiqPLyQ/XOjTGlwFzVDKXEVgNTw2FnkJ/oBnbNGJrr+Q+5C
	 qxN4zxafPBXVkxwxmSNSIIvAHGX6lwtxN59snOJ5tRMlglf6QfwPEsEH/zBS1XBlBY
	 ZDdOvb+kjAkeP8sWAizRBNbEbbpQQrk7R0KxOKoZXfr4eXjgOmqQGEP5aY0dG54+I7
	 4V9wou3PI1aBwqkpSlOHIpkbG/C/JElNwBQipI24rrEGNQrQgbqwO4n/gt7ZkG+KyA
	 +J9V1dYN7A3EUQK42/zs0qzAoB4hHAEtDfUHuA971FXwKMh9OdjQ9uyOKVocBnrhBt
	 yMFMfUg/svGYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] crypto: virtio - Drop superfluous [as]kcipher_ctx pointer
Date: Tue,  1 Sep 2026 08:10:11 -0400
Message-ID: <20260901121013.579838-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901121013.579838-1-sashal@kernel.org>
References: <2026083110-catcall-outtakes-9ceb@gregkh>
 <20260901121013.579838-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit dc91d858fb9251b25828ab63ac7220145cef282c ]

The request context virtio_crypto_{akcipher,sym}_request contains a
pointer to the transform context virtio_crypto_[as]kcipher_ctx.

The pointer is superfluous as it can be calculated with the cheap
crypto_akcipher_reqtfm() + akcipher_tfm_ctx() and
crypto_skcipher_reqtfm() + crypto_skcipher_ctx() combos.

Drop the superfluous pointer.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: f77a956f6a19 ("crypto: virtio - bound the akcipher result length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 8 ++++----
 drivers/crypto/virtio/virtio_crypto_skcipher_algs.c | 5 +----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index 48fee07b7e517..6130d14100974 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -36,7 +36,6 @@ struct virtio_crypto_akcipher_ctx {
 
 struct virtio_crypto_akcipher_request {
 	struct virtio_crypto_request base;
-	struct virtio_crypto_akcipher_ctx *akcipher_ctx;
 	struct akcipher_request *akcipher_req;
 	void *src_buf;
 	void *dst_buf;
@@ -213,7 +212,8 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
 static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request *vc_akcipher_req,
 		struct akcipher_request *req, struct data_queue *data_vq)
 {
-	struct virtio_crypto_akcipher_ctx *ctx = vc_akcipher_req->akcipher_ctx;
+	struct crypto_akcipher *atfm = crypto_akcipher_reqtfm(req);
+	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(atfm);
 	struct virtio_crypto_request *vc_req = &vc_akcipher_req->base;
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
 	struct virtio_crypto_op_data_req *req_data = vc_req->req_data;
@@ -273,7 +273,8 @@ static int virtio_crypto_rsa_do_req(struct crypto_engine *engine, void *vreq)
 	struct akcipher_request *req = container_of(vreq, struct akcipher_request, base);
 	struct virtio_crypto_akcipher_request *vc_akcipher_req = akcipher_request_ctx(req);
 	struct virtio_crypto_request *vc_req = &vc_akcipher_req->base;
-	struct virtio_crypto_akcipher_ctx *ctx = vc_akcipher_req->akcipher_ctx;
+	struct crypto_akcipher *atfm = crypto_akcipher_reqtfm(req);
+	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(atfm);
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
 	struct data_queue *data_vq = vc_req->dataq;
 	struct virtio_crypto_op_header *header;
@@ -319,7 +320,6 @@ static int virtio_crypto_rsa_req(struct akcipher_request *req, uint32_t opcode)
 
 	vc_req->dataq = data_vq;
 	vc_req->alg_cb = virtio_crypto_dataq_akcipher_callback;
-	vc_akcipher_req->akcipher_ctx = ctx;
 	vc_akcipher_req->akcipher_req = req;
 	vc_akcipher_req->opcode = opcode;
 
diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
index 487f60e35df19..d3655137a17a9 100644
--- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
@@ -28,7 +28,6 @@ struct virtio_crypto_sym_request {
 
 	/* Cipher or aead */
 	uint32_t type;
-	struct virtio_crypto_skcipher_ctx *skcipher_ctx;
 	struct skcipher_request *skcipher_req;
 	uint8_t *iv;
 	/* Encryption? */
@@ -325,7 +324,7 @@ __virtio_crypto_skcipher_do_req(struct virtio_crypto_sym_request *vc_sym_req,
 		struct data_queue *data_vq)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct virtio_crypto_skcipher_ctx *ctx = vc_sym_req->skcipher_ctx;
+	struct virtio_crypto_skcipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct virtio_crypto_request *vc_req = &vc_sym_req->base;
 	unsigned int ivsize = crypto_skcipher_ivsize(tfm);
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
@@ -481,7 +480,6 @@ static int virtio_crypto_skcipher_encrypt(struct skcipher_request *req)
 
 	vc_req->dataq = data_vq;
 	vc_req->alg_cb = virtio_crypto_dataq_sym_callback;
-	vc_sym_req->skcipher_ctx = ctx;
 	vc_sym_req->skcipher_req = req;
 	vc_sym_req->encrypt = true;
 
@@ -506,7 +504,6 @@ static int virtio_crypto_skcipher_decrypt(struct skcipher_request *req)
 
 	vc_req->dataq = data_vq;
 	vc_req->alg_cb = virtio_crypto_dataq_sym_callback;
-	vc_sym_req->skcipher_ctx = ctx;
 	vc_sym_req->skcipher_req = req;
 	vc_sym_req->encrypt = false;
 
-- 
2.53.0

