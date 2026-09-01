Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368E33A6EF1
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264618; cv=none; b=u+KHJUJ3KbuEdp1sDFJ1tMCACy++BLVlqbwO/x7QHp540k+udRWnqmgunLwNdFVWU2S5BnidsA9lmp+BvEOIMoA1V8j5dj5nb5bmtcuFXB36Gn5okPuXfFuetTl2IdLvbf40GvlAA7pxF5Fb2czqOy3G+pn6xP/KrwGH7Rvm4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264618; c=relaxed/simple;
	bh=O7psgw8A/l+i5Vszq8r2uhcc9CVpCwInT1mOjKWAams=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJNeLZOZDWbiJmtG4dq4QSt1Jj+PRyCDq2TX4tvUwegdVa6LqNhHYbzhsKn6FT5uarfxtQI1a2vk+AN4xXnBoFls1jZa2fY6efCEM89GWmmZSNUQjV7iBbSSBKrcoy2U+rMnEMujRUlHIBsdNkr+M/bEoDlYgCi/v99E4V8BI1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9XO+dRR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9XO+dRR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C89B1F00A3F;
	Tue,  1 Sep 2026 12:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788264616;
	bh=6pR0NMMcfahZxaYrY+TZJrwaNkgv+3h7Dk6TJC+YlmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G9XO+dRR4tCxgF5O8rYO6a0Q1WceBmAFWs8lY1E3lT1QYss1sZPOwj0NOMVu0uIuj
	 c6Gj66hpS2h0pS1jTIfvjLpHZeTEYwDoIyB4bEldjiQT35FWhq5Gv/Qhp1quc3qETh
	 VmioKNkepjCXk1267SD5Y0i4uIEyQ5s+H0pH1uVuDv36bBK/vxn+iuAMfadvc5FwSU
	 hEhwnj5qMf/90Foy96ec49/Chw9yrylOv2OAFBk4LU7QmgMINfXCHHJivfpAOeGXj/
	 wvF9Q2vy7Tj59pA+EZIFlsXu0N6IVzDstC6+bT3dTfVzUiFaZ36tvI0OLrwl59y1Ra
	 aTTPS5U/tKi5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] crypto: virtio - Drop superfluous [as]kcipher_req pointer
Date: Tue,  1 Sep 2026 08:10:12 -0400
Message-ID: <20260901121013.579838-3-sashal@kernel.org>
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
index 6130d14100974..e44ae99384573 100644
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
index d3655137a17a9..9efb4ecd2174b 100644
--- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
@@ -28,7 +28,6 @@ struct virtio_crypto_sym_request {
 
 	/* Cipher or aead */
 	uint32_t type;
-	struct skcipher_request *skcipher_req;
 	uint8_t *iv;
 	/* Encryption? */
 	bool encrypt;
@@ -56,7 +55,9 @@ static void virtio_crypto_dataq_sym_callback
 {
 	struct virtio_crypto_sym_request *vc_sym_req =
 		container_of(vc_req, struct virtio_crypto_sym_request, base);
-	struct skcipher_request *ablk_req;
+	struct skcipher_request *ablk_req =
+		container_of((void *)vc_sym_req, struct skcipher_request,
+			     __ctx);
 	int error;
 
 	/* Finish the encrypt or decrypt process */
@@ -76,7 +77,6 @@ static void virtio_crypto_dataq_sym_callback
 			error = -EIO;
 			break;
 		}
-		ablk_req = vc_sym_req->skcipher_req;
 		virtio_crypto_skcipher_finalize_req(vc_sym_req,
 							ablk_req, error);
 	}
@@ -480,7 +480,6 @@ static int virtio_crypto_skcipher_encrypt(struct skcipher_request *req)
 
 	vc_req->dataq = data_vq;
 	vc_req->alg_cb = virtio_crypto_dataq_sym_callback;
-	vc_sym_req->skcipher_req = req;
 	vc_sym_req->encrypt = true;
 
 	return crypto_transfer_skcipher_request_to_engine(data_vq->engine, req);
@@ -504,7 +503,6 @@ static int virtio_crypto_skcipher_decrypt(struct skcipher_request *req)
 
 	vc_req->dataq = data_vq;
 	vc_req->alg_cb = virtio_crypto_dataq_sym_callback;
-	vc_sym_req->skcipher_req = req;
 	vc_sym_req->encrypt = false;
 
 	return crypto_transfer_skcipher_request_to_engine(data_vq->engine, req);
-- 
2.53.0

