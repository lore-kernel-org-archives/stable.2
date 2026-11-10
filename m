Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312853;
	b=cAYc+wzW6vWs+9bxMxhBQgZ8TrCkGq7AxSzfqi7S+OF2dRcCLmo4iPUbgaF0aCQd94ew
	 K/NoqigYXt7ft6CuvxgYVFkdhacAH+l1JQTSV0dUC1zuMeiGgneaBj/I6tfYAqvAl9WJ8
	 Ei/KvBpFg3BNzwOTt0KnbzanwDQcS9MgDG181b6GJDuQXVroXYuazTJcfHke++g0pDfx1
	 lHn1Vom8GGc2aGKjIEaX0LorVlETQgaCbt1ouKI2zjHh4ESzvqJBdkYri2vJGcvGvLz7t
	 Vl2rcfo1+Kv6F1VbhOkOv67hh+vZo6qJ3O9YYa0M0LkLQI0ZWdcS+C1yI8yZfkkwIWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312853;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Z10m4QJI9yG3ooYAup19Dl0f+QmDNdCxTIUKPA2jU3M=;
	b=JeTDWZ0Wxap2D5qHSr/kXCu38aDE11k5jr8KftsX2N9TmDAXUVxcix8enuoQxOfq8Z2V
	 vuctKyLhafkS0DqScKFQwWNA92aWYcrqDTIwuvQclBJFjFhRWMN+aQhwyYcCRcN9QvUEE
	 ys3DNNMFUWp+BCcr/TZxSMoDWbtTzsv0Qhclo6aALJ6AYiLE756cFLViFUxe93HcM8/FN
	 YaniM2HBBor/6tZUDM/Lg6OggAfWpq+S1P4LEBiFo3YrHBI/apRDtjRr9+cZzyiOCR0K5
	 hBFJnTWQKcBQ9UwbXEHLT6Yu/W4zNtQpQfoq/9jN7zLcGRK+8V5As2Y0+7WGl0d84fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MbvGbyfG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE83E606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MbvGbyfG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4357F1F008A2;
	Tue, 10 Nov 2026 12:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312852;
	bh=Z10m4QJI9yG3ooYAup19Dl0f+QmDNdCxTIUKPA2jU3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MbvGbyfGOzraElcrlowPNi12AGiT7cCwkTp8Jy4NRk1vIZy2xB4VLhTqN/iUg+xJ6
	 wsAZdbgCeHYaeMBxO1DZRr2384nt7wxfXBf+RdMOPzp8n7dHWVrbhpDNkgRJRuGHIG
	 W4uwuOM1DIebIJWRldZZ/IRRTKuUPpxyUmxAKtUTZ9T90bNsB6OuH8LmXupbZjIJ0o
	 pX5pwG2zQjqg2pGQ6SnnwhXSwRk7+5XX4fWiaQojoSoVxIctao6KPUq3SfGmJ5DZjS
	 WaUmvVvp5uzQYfkq6K31qpdmUEAT8bbQfuvjz99Y1X3S0kKgorFUjARtEaIk9z0WNF
	 F5av4OT7pu49w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] crypto: omap - Remove prepare/unprepare request
Date: Tue, 10 Nov 2026 07:14:06 -0500
Message-ID: <20261110121355.981467-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054209-failed-6.1-5d69ed4cd4f9@kernel.org>
References: <20261107054209-failed-6.1-5d69ed4cd4f9@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit c752c01389673b76c479d53cdd8f37558a0e406b ]

The callbacks for prepare and unprepare request in crypto_engine
is superfluous.  They can be done directly from do_one_request.

Move the code into do_one_request and remove the unused callbacks.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 5d69ed4cd4f9 ("crypto: omap-des - fix crypto engine cleanup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/omap-aes-gcm.c | 14 +++++++-------
 drivers/crypto/omap-aes.c     | 19 ++++---------------
 drivers/crypto/omap-des.c     | 19 ++++---------------
 drivers/crypto/omap-sham.c    |  6 ++++--
 4 files changed, 19 insertions(+), 39 deletions(-)

diff --git a/drivers/crypto/omap-aes-gcm.c b/drivers/crypto/omap-aes-gcm.c
index 9f937bdc53a7c..d02363e976e71 100644
--- a/drivers/crypto/omap-aes-gcm.c
+++ b/drivers/crypto/omap-aes-gcm.c
@@ -212,12 +212,10 @@ static int omap_aes_gcm_handle_queue(struct omap_aes_dev *dd,
 	return 0;
 }
 
-static int omap_aes_gcm_prepare_req(struct crypto_engine *engine, void *areq)
+static int omap_aes_gcm_prepare_req(struct aead_request *req,
+				    struct omap_aes_dev *dd)
 {
-	struct aead_request *req = container_of(areq, struct aead_request,
-						base);
 	struct omap_aes_reqctx *rctx = aead_request_ctx(req);
-	struct omap_aes_dev *dd = rctx->dd;
 	struct omap_aes_gcm_ctx *ctx = crypto_aead_ctx(crypto_aead_reqtfm(req));
 	int err;
 
@@ -362,11 +360,15 @@ static int omap_aes_gcm_crypt_req(struct crypto_engine *engine, void *areq)
 						base);
 	struct omap_aes_reqctx *rctx = aead_request_ctx(req);
 	struct omap_aes_dev *dd = rctx->dd;
-	int ret = 0;
+	int ret;
 
 	if (!dd)
 		return -ENODEV;
 
+	ret = omap_aes_gcm_prepare_req(req, dd);
+	if (ret)
+		return ret;
+
 	if (dd->in_sg_len)
 		ret = omap_aes_crypt_dma_start(dd);
 	else
@@ -379,8 +381,6 @@ int omap_aes_gcm_cra_init(struct crypto_aead *tfm)
 {
 	struct omap_aes_ctx *ctx = crypto_aead_ctx(tfm);
 
-	ctx->enginectx.op.prepare_request = omap_aes_gcm_prepare_req;
-	ctx->enginectx.op.unprepare_request = NULL;
 	ctx->enginectx.op.do_one_request = omap_aes_gcm_crypt_req;
 
 	crypto_aead_set_reqsize(tfm, sizeof(struct omap_aes_reqctx));
diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index 67a99c760bc4b..d6fb8676f6cc0 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -426,20 +426,15 @@ static int omap_aes_handle_queue(struct omap_aes_dev *dd,
 	return 0;
 }
 
-static int omap_aes_prepare_req(struct crypto_engine *engine,
-				void *areq)
+static int omap_aes_prepare_req(struct skcipher_request *req,
+				struct omap_aes_dev *dd)
 {
-	struct skcipher_request *req = container_of(areq, struct skcipher_request, base);
 	struct omap_aes_ctx *ctx = crypto_skcipher_ctx(
 			crypto_skcipher_reqtfm(req));
 	struct omap_aes_reqctx *rctx = skcipher_request_ctx(req);
-	struct omap_aes_dev *dd = rctx->dd;
 	int ret;
 	u16 flags;
 
-	if (!dd)
-		return -ENODEV;
-
 	/* assign new request to device */
 	dd->req = req;
 	dd->total = req->cryptlen;
@@ -491,7 +486,8 @@ static int omap_aes_crypt_req(struct crypto_engine *engine,
 	if (!dd)
 		return -ENODEV;
 
-	return omap_aes_crypt_dma_start(dd);
+	return omap_aes_prepare_req(req, dd) ?:
+	       omap_aes_crypt_dma_start(dd);
 }
 
 static void omap_aes_copy_ivout(struct omap_aes_dev *dd, u8 *ivbuf)
@@ -629,11 +625,6 @@ static int omap_aes_ctr_decrypt(struct skcipher_request *req)
 	return omap_aes_crypt(req, FLAGS_CTR);
 }
 
-static int omap_aes_prepare_req(struct crypto_engine *engine,
-				void *req);
-static int omap_aes_crypt_req(struct crypto_engine *engine,
-			      void *req);
-
 static int omap_aes_init_tfm(struct crypto_skcipher *tfm)
 {
 	const char *name = crypto_tfm_alg_name(&tfm->base);
@@ -649,8 +640,6 @@ static int omap_aes_init_tfm(struct crypto_skcipher *tfm)
 	crypto_skcipher_set_reqsize(tfm, sizeof(struct omap_aes_reqctx) +
 					 crypto_skcipher_reqsize(blk));
 
-	ctx->enginectx.op.prepare_request = omap_aes_prepare_req;
-	ctx->enginectx.op.unprepare_request = NULL;
 	ctx->enginectx.op.do_one_request = omap_aes_crypt_req;
 
 	return 0;
diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index f783769ea1107..7099cbc8fa53d 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -522,20 +522,15 @@ static int omap_des_handle_queue(struct omap_des_dev *dd,
 	return 0;
 }
 
-static int omap_des_prepare_req(struct crypto_engine *engine,
-				void *areq)
+static int omap_des_prepare_req(struct skcipher_request *req,
+				struct omap_des_dev *dd)
 {
-	struct skcipher_request *req = container_of(areq, struct skcipher_request, base);
 	struct omap_des_ctx *ctx = crypto_skcipher_ctx(
 			crypto_skcipher_reqtfm(req));
-	struct omap_des_dev *dd = omap_des_find_dev(ctx);
 	struct omap_des_reqctx *rctx;
 	int ret;
 	u16 flags;
 
-	if (!dd)
-		return -ENODEV;
-
 	/* assign new request to device */
 	dd->req = req;
 	dd->total = req->cryptlen;
@@ -590,7 +585,8 @@ static int omap_des_crypt_req(struct crypto_engine *engine,
 	if (!dd)
 		return -ENODEV;
 
-	return omap_des_crypt_dma_start(dd);
+	return omap_des_prepare_req(req, dd) ?:
+	       omap_des_crypt_dma_start(dd);
 }
 
 static void omap_des_done_task(unsigned long data)
@@ -709,11 +705,6 @@ static int omap_des_cbc_decrypt(struct skcipher_request *req)
 	return omap_des_crypt(req, FLAGS_CBC);
 }
 
-static int omap_des_prepare_req(struct crypto_engine *engine,
-				void *areq);
-static int omap_des_crypt_req(struct crypto_engine *engine,
-			      void *areq);
-
 static int omap_des_init_tfm(struct crypto_skcipher *tfm)
 {
 	struct omap_des_ctx *ctx = crypto_skcipher_ctx(tfm);
@@ -722,8 +713,6 @@ static int omap_des_init_tfm(struct crypto_skcipher *tfm)
 
 	crypto_skcipher_set_reqsize(tfm, sizeof(struct omap_des_reqctx));
 
-	ctx->enginectx.op.prepare_request = omap_des_prepare_req;
-	ctx->enginectx.op.unprepare_request = NULL;
 	ctx->enginectx.op.do_one_request = omap_des_crypt_req;
 
 	return 0;
diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index cbeda59c6b191..2ef92301969f3 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -1074,6 +1074,10 @@ static int omap_sham_hash_one_req(struct crypto_engine *engine, void *areq)
 	dev_dbg(dd->dev, "hash-one: op: %u, total: %u, digcnt: %zd, final: %d",
 		ctx->op, ctx->total, ctx->digcnt, final);
 
+	err = omap_sham_prepare_request(engine, areq);
+	if (err)
+		return err;
+
 	err = pm_runtime_resume_and_get(dd->dev);
 	if (err < 0) {
 		dev_err(dd->dev, "failed to get sync: %d\n", err);
@@ -1350,8 +1354,6 @@ static int omap_sham_cra_init_alg(struct crypto_tfm *tfm, const char *alg_base)
 	}
 
 	tctx->enginectx.op.do_one_request = omap_sham_hash_one_req;
-	tctx->enginectx.op.prepare_request = omap_sham_prepare_request;
-	tctx->enginectx.op.unprepare_request = NULL;
 
 	return 0;
 }
-- 
2.53.0

