Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4219377A9A
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272304; cv=none; b=AdaICu11r5FB69qmdzLA8md8vl7/xaA1E8kkphqlIMVW7xoPHBeHH2WY617TU/MN3zSnwfvEVf6E04pPfpR4oWb3PzaXSIyO/wGg++k8x0vt3BWj3ly/QYYhcb0iYox+3p8CzzZ+ejj7CQNefSNHyVqKTsiZDVVOCz+scLh25lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272304; c=relaxed/simple;
	bh=uy1laicbRsnzBkPWMTvgiZESCrCdy1vwClQXSJA7qgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0/Ic6GQvU0nBOg7p+YYO8E3JivHvnfLS/USLNflGnEfG9Ctc5n7ho764pIstyuvwZs0uoS73TcOxiUge8nGP+ojGJTvXzowlhjolJvw6diYmr1xmTiwVP2cZb9J5h1+gcrv16KPqpLaPpoqJWwRqhwD8BK2Lz62pGjzIAbFmW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izblIimQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izblIimQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1798C1F00A3F;
	Tue,  1 Sep 2026 14:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788272302;
	bh=i9LHhgtxgnd5c+yTQK+ifeDakEHTBbVaOrBUTJZ9HXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=izblIimQ2XxP9lj/IxN68PlilghMGpVhRQ63R46IXINOM0+cWsbuBD+2bphqQDweX
	 nRM1KHtsT2aHCcc4mHudxEmfCusuOIhes9oIsLmssWanvan7hro+fGjtBnXVAbi0ZL
	 xFOI77Y19IIGYVQJIESpb6GEY/48R1M++pJUVzTTtLIW2lAc8h0G3dVfRuxRvmpV4d
	 cHBD2n0rv35xirxZSshTIqoKgHptr3pErL1U4ocxbJoGxnm0P6AYZ3BQUxI3kBdb/U
	 0JfZNgCR+JIe9oJho9qR9cjAjXV5X7JKUWAtYUzY90r5IDSSEWdJPdVOkB7qH0CBgT
	 i7lXBLORCwTVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/5] crypto: virtio - Drop superfluous [as]kcipher_ctx pointer
Date: Tue,  1 Sep 2026 10:18:16 -0400
Message-ID: <20260901141818.1033381-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901141818.1033381-1-sashal@kernel.org>
References: <2026083110-repugnant-jingle-50dd@gregkh>
 <20260901141818.1033381-1-sashal@kernel.org>
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

