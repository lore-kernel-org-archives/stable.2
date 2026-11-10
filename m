Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313359;
	b=tmY3tMZVnFgpc+K4FKgcacSswnR/V+GJXoWaXM0DpmY7cHKWJoO85sJwmv3dhJCgHnY9
	 9woO0ROy20z5AaA1Uax4FbBtXJfet2zjmQ9MBcFj8tCSyFi+M8fW6p62kk26BMuSVuonr
	 hxxGvi9IcaXTdX93bypeLdSiFr3yP4XuYjKt0P9Z8eugosxk7PO5ULI0cPw4w3jJid8am
	 uWXiX21isqUmPoSs/R7yXhTn9Gvdu78+hh1bIANb0HoNrXhsUmZ+6uwv1FEQCITzHG6Kb
	 HMS5OUvrtc8VdTbJAxsDkslWVgigrTUBBWynoRwfLGYSFt/Brc5oR08lni593ggdr1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313359;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ioxOZL6maJQZJj7jzeluRodVfyDqFazURqMgZxcRzrw=;
	b=wnRErAnGnqsqsQXLp33k4UuoIo1oTkmd2N3e1CBAyqnXftdrYn39u+zZ8YXcbSZNoyf/
	 tENttuntpuKew5NQiv2XClHmPivufUBxvwEo95yOK6Ix4TuIzckTAx7nMXdxRVknEstd4
	 9hOLisi4isdRA+stP+Qeg0if0qm8v6rXBs8f9h7rmRqAnaG9g/bKLbkLtBlfVZmY8ceXW
	 i3+cMWwT3mUQjWVi4pvdyJ6Dn5350FLUEPm/UB4uO+4YJEVjMcbwebXSgotzmCmtJ8b/P
	 C3ZKJ78gHfgQCbAlp3R9JZlIqUraKBSnF7HUZZfIhffaCHsQkwqy7Ig8WPAFIdYSzTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NFIMJymD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4938E606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NFIMJymD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9E11F008A1;
	Tue, 10 Nov 2026 12:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313359;
	bh=ioxOZL6maJQZJj7jzeluRodVfyDqFazURqMgZxcRzrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NFIMJymDFq5taYwNaCZMPlOdFYf5oz0QV8587W/m5FDfjF0Q0mqoBGqQgs+z6N+vB
	 k/cD94PWkbWbPmLxiW1XmLx4hV+hGq6qMjRQ3SeqqZeNbNXLgZrL65u/Re30IshlWz
	 yNvFW9Kbk7ICLzcP2o/15nDWOx+JFAi2jlBVZN7WXQr/FJDsSETHQC2J9QFmRgBO4+
	 WSm53ayLWPgCSOmE2Zq4SzuCTbdVQclghRCpexbUIU3zXTQp1ZlexCF68pKWugg2Ua
	 lMV8JunB9Su5X3hog761RoZISzE3UTVGjZ87wprG+/j8eqZOWlpMX3g8Cnh26smb8o
	 U0zfrShbXLeDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/6] crypto: omap - Remove prepare/unprepare request
Date: Tue, 10 Nov 2026 07:22:32 -0500
Message-ID: <20261110122229.1112116-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110122229.1112116-1-sashal@kernel.org>
References: <20261107055909-failed-5.15-5d69ed4cd4f9@kernel.org>
 <20261110122229.1112116-1-sashal@kernel.org>
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
index a196bb8b17010..0b8a48137519b 100644
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
index 538aff80869f6..11592833a5afa 100644
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
index 4ec6949a7ca9e..1197a189846b8 100644
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

