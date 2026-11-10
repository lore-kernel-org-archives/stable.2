Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312855;
	b=p/AmIkFy9i6pmPlTbdMWI+NNFV27LWBPHQKl4MU3FGH5d733ASwwwKjdKbr9twKM3zLt
	 ZcQSe6g2KXUhCL3Z8wMd37IGri1t+aFAUf4tmDtP7jmGJcW68J7osDpgyhG9HGelnsD75
	 o3uaUi6Nph5lfzB8JGDyV/dUsbA+BXn2r9Z1m2db8GGAmA/wECtv9XM71F7bLTMwMtl2O
	 91KGZOr9sZV6YrgfeU8OCtklsfLE9e9hpiF98fihvyISV5D/nDWgvSxPYui/yfLpwUtBU
	 f2Qx3fG4YhLcWrmyjKJhvGAPBDb1OQY0r7V3LlQqCgT3eP1O/88SRJ1q+vm5Icxp/vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312855;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zCsxIkfYI3cj+455l3Yy5vHA9u8S4fcmzf0Mmw2ysTo=;
	b=fGaZRbqcyqWJ9qwp4U7P0zveq+sriHLLYnU8EbKsFJbVAeOzhtKERkKTmzPl4dWFyz5z
	 ePPAncBg99y0vjMz8AVppNfFq3NHkak3JWnfgtoeoEctyQOhIO3ERS6Gy8EGj/Dih7Zyi
	 wkhEWp1W1clIvmgZD0p8EH4HU+gYcKQuJZK2X4J3cMxT3NUoljYuwiolxK1tBRcd0EbIq
	 OOxbOalRTqh0sK9VqV98LLPbZmcNcoUXUUJ7WImz3OQR2tTYHMKZUC0USxITKx/uZn2Zp
	 TlJA+W9qltqJbkVblnyHBTpBYf9GySpReyI11TZ7OBXxZT9AjRnL986I1VG7FfrBfoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIotkuS4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87222606A332
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIotkuS4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67451F008A2;
	Tue, 10 Nov 2026 12:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312854;
	bh=zCsxIkfYI3cj+455l3Yy5vHA9u8S4fcmzf0Mmw2ysTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gIotkuS4ilhYTI3OP7V8sdh7/QrK6fx4oJvlXGBHYYu34d1p0twoQEU+Rl+vOVROb
	 4Tdm8GxFsVI1D2opQIMrDxZq88gGUjHpQekthW+lnSNp/4WX0wCl006HA1pPs/zuyL
	 cf4S00WzevvE+MS0Qg9pxxcHTfipJ9mDOMY/IoiFdmhwQNOtCNQPk9+0YdRXGUrrVE
	 mJvu52aKfYO5uiE5wVoU2CyJZuujZMhgKy5UCqbCuDiYS7PxlzsF3I0QWS9wkceSda
	 id92HprYC77bnALfsXr5J3JNXSXmufyZYGF+J0F0xgCN1nCIJbeydm38GeimibBTBd
	 OOfO3S+mSrfFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] crypto: omap - Use new crypto_engine_op interface
Date: Tue, 10 Nov 2026 07:14:08 -0500
Message-ID: <20261110121355.981467-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110121355.981467-1-sashal@kernel.org>
References: <20261107054209-failed-6.1-5d69ed4cd4f9@kernel.org>
 <20261110121355.981467-1-sashal@kernel.org>
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

[ Upstream commit 03906fba750ed468b8ea3484afc650454ce45bcc ]

Use the new crypto_engine_op interface where the callback is stored
in the algorithm object.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 5d69ed4cd4f9 ("crypto: omap-des - fix crypto engine cleanup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/omap-aes-gcm.c |  23 ++-
 drivers/crypto/omap-aes.c     | 216 ++++++++++++++-------------
 drivers/crypto/omap-aes.h     |  15 +-
 drivers/crypto/omap-des.c     | 187 ++++++++++++-----------
 drivers/crypto/omap-sham.c    | 274 +++++++++++++++++-----------------
 5 files changed, 370 insertions(+), 345 deletions(-)

diff --git a/drivers/crypto/omap-aes-gcm.c b/drivers/crypto/omap-aes-gcm.c
index d02363e976e71..c498950402e89 100644
--- a/drivers/crypto/omap-aes-gcm.c
+++ b/drivers/crypto/omap-aes-gcm.c
@@ -7,18 +7,21 @@
  * Copyright (c) 2016 Texas Instruments Incorporated
  */
 
+#include <crypto/aes.h>
+#include <crypto/engine.h>
+#include <crypto/gcm.h>
+#include <crypto/internal/aead.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/skcipher.h>
 #include <linux/errno.h>
-#include <linux/scatterlist.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
-#include <linux/omap-dma.h>
 #include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/omap-dma.h>
 #include <linux/pm_runtime.h>
-#include <crypto/aes.h>
-#include <crypto/gcm.h>
-#include <crypto/scatterwalk.h>
-#include <crypto/skcipher.h>
-#include <crypto/internal/aead.h>
+#include <linux/scatterlist.h>
+#include <linux/string.h>
 
 #include "omap-crypto.h"
 #include "omap-aes.h"
@@ -354,7 +357,7 @@ int omap_aes_4106gcm_setauthsize(struct crypto_aead *parent,
 	return crypto_rfc4106_check_authsize(authsize);
 }
 
-static int omap_aes_gcm_crypt_req(struct crypto_engine *engine, void *areq)
+int omap_aes_gcm_crypt_req(struct crypto_engine *engine, void *areq)
 {
 	struct aead_request *req = container_of(areq, struct aead_request,
 						base);
@@ -379,10 +382,6 @@ static int omap_aes_gcm_crypt_req(struct crypto_engine *engine, void *areq)
 
 int omap_aes_gcm_cra_init(struct crypto_aead *tfm)
 {
-	struct omap_aes_ctx *ctx = crypto_aead_ctx(tfm);
-
-	ctx->enginectx.op.do_one_request = omap_aes_gcm_crypt_req;
-
 	crypto_aead_set_reqsize(tfm, sizeof(struct omap_aes_reqctx));
 
 	return 0;
diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index ad0d8db086db2..ea13312181058 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -33,6 +33,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
+#include <linux/string.h>
 
 #include "omap-crypto.h"
 #include "omap-aes.h"
@@ -638,8 +639,6 @@ static int omap_aes_init_tfm(struct crypto_skcipher *tfm)
 	crypto_skcipher_set_reqsize(tfm, sizeof(struct omap_aes_reqctx) +
 					 crypto_skcipher_reqsize(blk));
 
-	ctx->enginectx.op.do_one_request = omap_aes_crypt_req;
-
 	return 0;
 }
 
@@ -655,68 +654,77 @@ static void omap_aes_exit_tfm(struct crypto_skcipher *tfm)
 
 /* ********************** ALGS ************************************ */
 
-static struct skcipher_alg algs_ecb_cbc[] = {
+static struct skcipher_engine_alg algs_ecb_cbc[] = {
 {
-	.base.cra_name		= "ecb(aes)",
-	.base.cra_driver_name	= "ecb-aes-omap",
-	.base.cra_priority	= 300,
-	.base.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
-				  CRYPTO_ALG_ASYNC |
-				  CRYPTO_ALG_NEED_FALLBACK,
-	.base.cra_blocksize	= AES_BLOCK_SIZE,
-	.base.cra_ctxsize	= sizeof(struct omap_aes_ctx),
-	.base.cra_module	= THIS_MODULE,
-
-	.min_keysize		= AES_MIN_KEY_SIZE,
-	.max_keysize		= AES_MAX_KEY_SIZE,
-	.setkey			= omap_aes_setkey,
-	.encrypt		= omap_aes_ecb_encrypt,
-	.decrypt		= omap_aes_ecb_decrypt,
-	.init			= omap_aes_init_tfm,
-	.exit			= omap_aes_exit_tfm,
+	.base = {
+		.base.cra_name		= "ecb(aes)",
+		.base.cra_driver_name	= "ecb-aes-omap",
+		.base.cra_priority	= 300,
+		.base.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
+					  CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
+		.base.cra_blocksize	= AES_BLOCK_SIZE,
+		.base.cra_ctxsize	= sizeof(struct omap_aes_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= AES_MIN_KEY_SIZE,
+		.max_keysize		= AES_MAX_KEY_SIZE,
+		.setkey			= omap_aes_setkey,
+		.encrypt		= omap_aes_ecb_encrypt,
+		.decrypt		= omap_aes_ecb_decrypt,
+		.init			= omap_aes_init_tfm,
+		.exit			= omap_aes_exit_tfm,
+	},
+	.op.do_one_request = omap_aes_crypt_req,
 },
 {
-	.base.cra_name		= "cbc(aes)",
-	.base.cra_driver_name	= "cbc-aes-omap",
-	.base.cra_priority	= 300,
-	.base.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
-				  CRYPTO_ALG_ASYNC |
-				  CRYPTO_ALG_NEED_FALLBACK,
-	.base.cra_blocksize	= AES_BLOCK_SIZE,
-	.base.cra_ctxsize	= sizeof(struct omap_aes_ctx),
-	.base.cra_module	= THIS_MODULE,
-
-	.min_keysize		= AES_MIN_KEY_SIZE,
-	.max_keysize		= AES_MAX_KEY_SIZE,
-	.ivsize			= AES_BLOCK_SIZE,
-	.setkey			= omap_aes_setkey,
-	.encrypt		= omap_aes_cbc_encrypt,
-	.decrypt		= omap_aes_cbc_decrypt,
-	.init			= omap_aes_init_tfm,
-	.exit			= omap_aes_exit_tfm,
+	.base = {
+		.base.cra_name		= "cbc(aes)",
+		.base.cra_driver_name	= "cbc-aes-omap",
+		.base.cra_priority	= 300,
+		.base.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
+					  CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
+		.base.cra_blocksize	= AES_BLOCK_SIZE,
+		.base.cra_ctxsize	= sizeof(struct omap_aes_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= AES_MIN_KEY_SIZE,
+		.max_keysize		= AES_MAX_KEY_SIZE,
+		.ivsize			= AES_BLOCK_SIZE,
+		.setkey			= omap_aes_setkey,
+		.encrypt		= omap_aes_cbc_encrypt,
+		.decrypt		= omap_aes_cbc_decrypt,
+		.init			= omap_aes_init_tfm,
+		.exit			= omap_aes_exit_tfm,
+	},
+	.op.do_one_request = omap_aes_crypt_req,
 }
 };
 
-static struct skcipher_alg algs_ctr[] = {
+static struct skcipher_engine_alg algs_ctr[] = {
 {
-	.base.cra_name		= "ctr(aes)",
-	.base.cra_driver_name	= "ctr-aes-omap",
-	.base.cra_priority	= 300,
-	.base.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
-				  CRYPTO_ALG_ASYNC |
-				  CRYPTO_ALG_NEED_FALLBACK,
-	.base.cra_blocksize	= 1,
-	.base.cra_ctxsize	= sizeof(struct omap_aes_ctx),
-	.base.cra_module	= THIS_MODULE,
-
-	.min_keysize		= AES_MIN_KEY_SIZE,
-	.max_keysize		= AES_MAX_KEY_SIZE,
-	.ivsize			= AES_BLOCK_SIZE,
-	.setkey			= omap_aes_setkey,
-	.encrypt		= omap_aes_ctr_encrypt,
-	.decrypt		= omap_aes_ctr_decrypt,
-	.init			= omap_aes_init_tfm,
-	.exit			= omap_aes_exit_tfm,
+	.base = {
+		.base.cra_name		= "ctr(aes)",
+		.base.cra_driver_name	= "ctr-aes-omap",
+		.base.cra_priority	= 300,
+		.base.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
+					  CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
+		.base.cra_blocksize	= 1,
+		.base.cra_ctxsize	= sizeof(struct omap_aes_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= AES_MIN_KEY_SIZE,
+		.max_keysize		= AES_MAX_KEY_SIZE,
+		.ivsize			= AES_BLOCK_SIZE,
+		.setkey			= omap_aes_setkey,
+		.encrypt		= omap_aes_ctr_encrypt,
+		.decrypt		= omap_aes_ctr_decrypt,
+		.init			= omap_aes_init_tfm,
+		.exit			= omap_aes_exit_tfm,
+	},
+	.op.do_one_request = omap_aes_crypt_req,
 }
 };
 
@@ -727,46 +735,52 @@ static struct omap_aes_algs_info omap_aes_algs_info_ecb_cbc[] = {
 	},
 };
 
-static struct aead_alg algs_aead_gcm[] = {
+static struct aead_engine_alg algs_aead_gcm[] = {
 {
 	.base = {
-		.cra_name		= "gcm(aes)",
-		.cra_driver_name	= "gcm-aes-omap",
-		.cra_priority		= 300,
-		.cra_flags		= CRYPTO_ALG_ASYNC |
-					  CRYPTO_ALG_KERN_DRIVER_ONLY,
-		.cra_blocksize		= 1,
-		.cra_ctxsize		= sizeof(struct omap_aes_gcm_ctx),
-		.cra_alignmask		= 0xf,
-		.cra_module		= THIS_MODULE,
+		.base = {
+			.cra_name		= "gcm(aes)",
+			.cra_driver_name	= "gcm-aes-omap",
+			.cra_priority		= 300,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize		= 1,
+			.cra_ctxsize		= sizeof(struct omap_aes_gcm_ctx),
+			.cra_alignmask		= 0xf,
+			.cra_module		= THIS_MODULE,
+		},
+		.init		= omap_aes_gcm_cra_init,
+		.ivsize		= GCM_AES_IV_SIZE,
+		.maxauthsize	= AES_BLOCK_SIZE,
+		.setkey		= omap_aes_gcm_setkey,
+		.setauthsize	= omap_aes_gcm_setauthsize,
+		.encrypt	= omap_aes_gcm_encrypt,
+		.decrypt	= omap_aes_gcm_decrypt,
 	},
-	.init		= omap_aes_gcm_cra_init,
-	.ivsize		= GCM_AES_IV_SIZE,
-	.maxauthsize	= AES_BLOCK_SIZE,
-	.setkey		= omap_aes_gcm_setkey,
-	.setauthsize	= omap_aes_gcm_setauthsize,
-	.encrypt	= omap_aes_gcm_encrypt,
-	.decrypt	= omap_aes_gcm_decrypt,
+	.op.do_one_request = omap_aes_gcm_crypt_req,
 },
 {
 	.base = {
-		.cra_name		= "rfc4106(gcm(aes))",
-		.cra_driver_name	= "rfc4106-gcm-aes-omap",
-		.cra_priority		= 300,
-		.cra_flags		= CRYPTO_ALG_ASYNC |
-					  CRYPTO_ALG_KERN_DRIVER_ONLY,
-		.cra_blocksize		= 1,
-		.cra_ctxsize		= sizeof(struct omap_aes_gcm_ctx),
-		.cra_alignmask		= 0xf,
-		.cra_module		= THIS_MODULE,
+		.base = {
+			.cra_name		= "rfc4106(gcm(aes))",
+			.cra_driver_name	= "rfc4106-gcm-aes-omap",
+			.cra_priority		= 300,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize		= 1,
+			.cra_ctxsize		= sizeof(struct omap_aes_gcm_ctx),
+			.cra_alignmask		= 0xf,
+			.cra_module		= THIS_MODULE,
+		},
+		.init		= omap_aes_gcm_cra_init,
+		.maxauthsize	= AES_BLOCK_SIZE,
+		.ivsize		= GCM_RFC4106_IV_SIZE,
+		.setkey		= omap_aes_4106gcm_setkey,
+		.setauthsize	= omap_aes_4106gcm_setauthsize,
+		.encrypt	= omap_aes_4106gcm_encrypt,
+		.decrypt	= omap_aes_4106gcm_decrypt,
 	},
-	.init		= omap_aes_gcm_cra_init,
-	.maxauthsize	= AES_BLOCK_SIZE,
-	.ivsize		= GCM_RFC4106_IV_SIZE,
-	.setkey		= omap_aes_4106gcm_setkey,
-	.setauthsize	= omap_aes_4106gcm_setauthsize,
-	.encrypt	= omap_aes_4106gcm_encrypt,
-	.decrypt	= omap_aes_4106gcm_decrypt,
+	.op.do_one_request = omap_aes_gcm_crypt_req,
 },
 };
 
@@ -1088,8 +1102,8 @@ static int omap_aes_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct omap_aes_dev *dd;
-	struct skcipher_alg *algp;
-	struct aead_alg *aalg;
+	struct skcipher_engine_alg *algp;
+	struct aead_engine_alg *aalg;
 	struct resource res;
 	int err = -ENOMEM, i, j, irq = -1;
 	u32 reg;
@@ -1182,9 +1196,9 @@ static int omap_aes_probe(struct platform_device *pdev)
 			for (j = 0; j < dd->pdata->algs_info[i].size; j++) {
 				algp = &dd->pdata->algs_info[i].algs_list[j];
 
-				pr_debug("reg alg: %s\n", algp->base.cra_name);
+				pr_debug("reg alg: %s\n", algp->base.base.cra_name);
 
-				err = crypto_register_skcipher(algp);
+				err = crypto_engine_register_skcipher(algp);
 				if (err)
 					goto err_algs;
 
@@ -1198,9 +1212,9 @@ static int omap_aes_probe(struct platform_device *pdev)
 		for (i = 0; i < dd->pdata->aead_algs_info->size; i++) {
 			aalg = &dd->pdata->aead_algs_info->algs_list[i];
 
-			pr_debug("reg alg: %s\n", aalg->base.cra_name);
+			pr_debug("reg alg: %s\n", aalg->base.base.cra_name);
 
-			err = crypto_register_aead(aalg);
+			err = crypto_engine_register_aead(aalg);
 			if (err)
 				goto err_aead_algs;
 
@@ -1218,12 +1232,12 @@ static int omap_aes_probe(struct platform_device *pdev)
 err_aead_algs:
 	for (i = dd->pdata->aead_algs_info->registered - 1; i >= 0; i--) {
 		aalg = &dd->pdata->aead_algs_info->algs_list[i];
-		crypto_unregister_aead(aalg);
+		crypto_engine_unregister_aead(aalg);
 	}
 err_algs:
 	for (i = dd->pdata->algs_info_size - 1; i >= 0; i--)
 		for (j = dd->pdata->algs_info[i].registered - 1; j >= 0; j--)
-			crypto_unregister_skcipher(
+			crypto_engine_unregister_skcipher(
 					&dd->pdata->algs_info[i].algs_list[j]);
 
 err_engine:
@@ -1245,7 +1259,7 @@ static int omap_aes_probe(struct platform_device *pdev)
 static int omap_aes_remove(struct platform_device *pdev)
 {
 	struct omap_aes_dev *dd = platform_get_drvdata(pdev);
-	struct aead_alg *aalg;
+	struct aead_engine_alg *aalg;
 	int i, j;
 
 	spin_lock_bh(&list_lock);
@@ -1254,14 +1268,14 @@ static int omap_aes_remove(struct platform_device *pdev)
 
 	for (i = dd->pdata->algs_info_size - 1; i >= 0; i--)
 		for (j = dd->pdata->algs_info[i].registered - 1; j >= 0; j--) {
-			crypto_unregister_skcipher(
+			crypto_engine_unregister_skcipher(
 					&dd->pdata->algs_info[i].algs_list[j]);
 			dd->pdata->algs_info[i].registered--;
 		}
 
 	for (i = dd->pdata->aead_algs_info->registered - 1; i >= 0; i--) {
 		aalg = &dd->pdata->aead_algs_info->algs_list[i];
-		crypto_unregister_aead(aalg);
+		crypto_engine_unregister_aead(aalg);
 		dd->pdata->aead_algs_info->registered--;
 	}
 
diff --git a/drivers/crypto/omap-aes.h b/drivers/crypto/omap-aes.h
index 23d073e87bb8c..0f35c91647648 100644
--- a/drivers/crypto/omap-aes.h
+++ b/drivers/crypto/omap-aes.h
@@ -10,7 +10,6 @@
 #define __OMAP_AES_H__
 
 #include <crypto/aes.h>
-#include <crypto/engine.h>
 
 #define DST_MAXBURST			4
 #define DMA_MIN				(DST_MAXBURST * sizeof(u32))
@@ -93,7 +92,6 @@ struct omap_aes_gcm_result {
 };
 
 struct omap_aes_ctx {
-	struct crypto_engine_ctx enginectx;
 	int		keylen;
 	u32		key[AES_KEYSIZE_256 / sizeof(u32)];
 	u8		nonce[4];
@@ -117,15 +115,15 @@ struct omap_aes_reqctx {
 #define OMAP_AES_CACHE_SIZE	0
 
 struct omap_aes_algs_info {
-	struct skcipher_alg	*algs_list;
-	unsigned int		size;
-	unsigned int		registered;
+	struct skcipher_engine_alg	*algs_list;
+	unsigned int			size;
+	unsigned int			registered;
 };
 
 struct omap_aes_aead_algs {
-	struct aead_alg	*algs_list;
-	unsigned int	size;
-	unsigned int	registered;
+	struct aead_engine_alg		*algs_list;
+	unsigned int			size;
+	unsigned int			registered;
 };
 
 struct omap_aes_pdata {
@@ -218,5 +216,6 @@ int omap_aes_crypt_dma_start(struct omap_aes_dev *dd);
 int omap_aes_crypt_dma_stop(struct omap_aes_dev *dd);
 void omap_aes_gcm_dma_out_callback(void *data);
 void omap_aes_clear_copy_flags(struct omap_aes_dev *dd);
+int omap_aes_gcm_crypt_req(struct crypto_engine *engine, void *areq);
 
 #endif
diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index 7099cbc8fa53d..61288e4c05a33 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -16,27 +16,25 @@
 #define prx(num)  do { } while (0)
 #endif
 
+#include <crypto/engine.h>
+#include <crypto/internal/des.h>
+#include <crypto/internal/skcipher.h>
+#include <crypto/scatterwalk.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
-#include <linux/module.h>
 #include <linux/init.h>
-#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/scatterlist.h>
-#include <linux/dma-mapping.h>
-#include <linux/dmaengine.h>
-#include <linux/pm_runtime.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_address.h>
-#include <linux/io.h>
-#include <linux/crypto.h>
-#include <linux/interrupt.h>
-#include <crypto/scatterwalk.h>
-#include <crypto/internal/des.h>
-#include <crypto/internal/skcipher.h>
-#include <crypto/algapi.h>
-#include <crypto/engine.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/scatterlist.h>
+#include <linux/string.h>
 
 #include "omap-crypto.h"
 
@@ -83,7 +81,6 @@
 #define FLAGS_OUT_DATA_ST_SHIFT	10
 
 struct omap_des_ctx {
-	struct crypto_engine_ctx enginectx;
 	struct omap_des_dev *dd;
 
 	int		keylen;
@@ -99,9 +96,9 @@ struct omap_des_reqctx {
 #define OMAP_DES_CACHE_SIZE	0
 
 struct omap_des_algs_info {
-	struct skcipher_alg	*algs_list;
-	unsigned int		size;
-	unsigned int		registered;
+	struct skcipher_engine_alg	*algs_list;
+	unsigned int			size;
+	unsigned int			registered;
 };
 
 struct omap_des_pdata {
@@ -707,89 +704,97 @@ static int omap_des_cbc_decrypt(struct skcipher_request *req)
 
 static int omap_des_init_tfm(struct crypto_skcipher *tfm)
 {
-	struct omap_des_ctx *ctx = crypto_skcipher_ctx(tfm);
-
 	pr_debug("enter\n");
 
 	crypto_skcipher_set_reqsize(tfm, sizeof(struct omap_des_reqctx));
 
-	ctx->enginectx.op.do_one_request = omap_des_crypt_req;
-
 	return 0;
 }
 
 /* ********************** ALGS ************************************ */
 
-static struct skcipher_alg algs_ecb_cbc[] = {
+static struct skcipher_engine_alg algs_ecb_cbc[] = {
 {
-	.base.cra_name		= "ecb(des)",
-	.base.cra_driver_name	= "ecb-des-omap",
-	.base.cra_priority	= 300,
-	.base.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
-				  CRYPTO_ALG_ASYNC,
-	.base.cra_blocksize	= DES_BLOCK_SIZE,
-	.base.cra_ctxsize	= sizeof(struct omap_des_ctx),
-	.base.cra_module	= THIS_MODULE,
-
-	.min_keysize		= DES_KEY_SIZE,
-	.max_keysize		= DES_KEY_SIZE,
-	.setkey			= omap_des_setkey,
-	.encrypt		= omap_des_ecb_encrypt,
-	.decrypt		= omap_des_ecb_decrypt,
-	.init			= omap_des_init_tfm,
+	.base = {
+		.base.cra_name		= "ecb(des)",
+		.base.cra_driver_name	= "ecb-des-omap",
+		.base.cra_priority	= 300,
+		.base.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
+					  CRYPTO_ALG_ASYNC,
+		.base.cra_blocksize	= DES_BLOCK_SIZE,
+		.base.cra_ctxsize	= sizeof(struct omap_des_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= DES_KEY_SIZE,
+		.max_keysize		= DES_KEY_SIZE,
+		.setkey			= omap_des_setkey,
+		.encrypt		= omap_des_ecb_encrypt,
+		.decrypt		= omap_des_ecb_decrypt,
+		.init			= omap_des_init_tfm,
+	},
+	.op.do_one_request = omap_des_crypt_req,
 },
 {
-	.base.cra_name		= "cbc(des)",
-	.base.cra_driver_name	= "cbc-des-omap",
-	.base.cra_priority	= 300,
-	.base.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
-				  CRYPTO_ALG_ASYNC,
-	.base.cra_blocksize	= DES_BLOCK_SIZE,
-	.base.cra_ctxsize	= sizeof(struct omap_des_ctx),
-	.base.cra_module	= THIS_MODULE,
-
-	.min_keysize		= DES_KEY_SIZE,
-	.max_keysize		= DES_KEY_SIZE,
-	.ivsize			= DES_BLOCK_SIZE,
-	.setkey			= omap_des_setkey,
-	.encrypt		= omap_des_cbc_encrypt,
-	.decrypt		= omap_des_cbc_decrypt,
-	.init			= omap_des_init_tfm,
+	.base = {
+		.base.cra_name		= "cbc(des)",
+		.base.cra_driver_name	= "cbc-des-omap",
+		.base.cra_priority	= 300,
+		.base.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
+					  CRYPTO_ALG_ASYNC,
+		.base.cra_blocksize	= DES_BLOCK_SIZE,
+		.base.cra_ctxsize	= sizeof(struct omap_des_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= DES_KEY_SIZE,
+		.max_keysize		= DES_KEY_SIZE,
+		.ivsize			= DES_BLOCK_SIZE,
+		.setkey			= omap_des_setkey,
+		.encrypt		= omap_des_cbc_encrypt,
+		.decrypt		= omap_des_cbc_decrypt,
+		.init			= omap_des_init_tfm,
+	},
+	.op.do_one_request = omap_des_crypt_req,
 },
 {
-	.base.cra_name		= "ecb(des3_ede)",
-	.base.cra_driver_name	= "ecb-des3-omap",
-	.base.cra_priority	= 300,
-	.base.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
-				  CRYPTO_ALG_ASYNC,
-	.base.cra_blocksize	= DES3_EDE_BLOCK_SIZE,
-	.base.cra_ctxsize	= sizeof(struct omap_des_ctx),
-	.base.cra_module	= THIS_MODULE,
-
-	.min_keysize		= DES3_EDE_KEY_SIZE,
-	.max_keysize		= DES3_EDE_KEY_SIZE,
-	.setkey			= omap_des3_setkey,
-	.encrypt		= omap_des_ecb_encrypt,
-	.decrypt		= omap_des_ecb_decrypt,
-	.init			= omap_des_init_tfm,
+	.base = {
+		.base.cra_name		= "ecb(des3_ede)",
+		.base.cra_driver_name	= "ecb-des3-omap",
+		.base.cra_priority	= 300,
+		.base.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
+					  CRYPTO_ALG_ASYNC,
+		.base.cra_blocksize	= DES3_EDE_BLOCK_SIZE,
+		.base.cra_ctxsize	= sizeof(struct omap_des_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= DES3_EDE_KEY_SIZE,
+		.max_keysize		= DES3_EDE_KEY_SIZE,
+		.setkey			= omap_des3_setkey,
+		.encrypt		= omap_des_ecb_encrypt,
+		.decrypt		= omap_des_ecb_decrypt,
+		.init			= omap_des_init_tfm,
+	},
+	.op.do_one_request = omap_des_crypt_req,
 },
 {
-	.base.cra_name		= "cbc(des3_ede)",
-	.base.cra_driver_name	= "cbc-des3-omap",
-	.base.cra_priority	= 300,
-	.base.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
-				  CRYPTO_ALG_ASYNC,
-	.base.cra_blocksize	= DES3_EDE_BLOCK_SIZE,
-	.base.cra_ctxsize	= sizeof(struct omap_des_ctx),
-	.base.cra_module	= THIS_MODULE,
-
-	.min_keysize		= DES3_EDE_KEY_SIZE,
-	.max_keysize		= DES3_EDE_KEY_SIZE,
-	.ivsize			= DES3_EDE_BLOCK_SIZE,
-	.setkey			= omap_des3_setkey,
-	.encrypt		= omap_des_cbc_encrypt,
-	.decrypt		= omap_des_cbc_decrypt,
-	.init			= omap_des_init_tfm,
+	.base = {
+		.base.cra_name		= "cbc(des3_ede)",
+		.base.cra_driver_name	= "cbc-des3-omap",
+		.base.cra_priority	= 300,
+		.base.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
+					  CRYPTO_ALG_ASYNC,
+		.base.cra_blocksize	= DES3_EDE_BLOCK_SIZE,
+		.base.cra_ctxsize	= sizeof(struct omap_des_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= DES3_EDE_KEY_SIZE,
+		.max_keysize		= DES3_EDE_KEY_SIZE,
+		.ivsize			= DES3_EDE_BLOCK_SIZE,
+		.setkey			= omap_des3_setkey,
+		.encrypt		= omap_des_cbc_encrypt,
+		.decrypt		= omap_des_cbc_decrypt,
+		.init			= omap_des_init_tfm,
+	},
+	.op.do_one_request = omap_des_crypt_req,
 }
 };
 
@@ -947,7 +952,7 @@ static int omap_des_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct omap_des_dev *dd;
-	struct skcipher_alg *algp;
+	struct skcipher_engine_alg *algp;
 	struct resource *res;
 	int err = -ENOMEM, i, j, irq = -1;
 	u32 reg;
@@ -1041,9 +1046,9 @@ static int omap_des_probe(struct platform_device *pdev)
 		for (j = 0; j < dd->pdata->algs_info[i].size; j++) {
 			algp = &dd->pdata->algs_info[i].algs_list[j];
 
-			pr_debug("reg alg: %s\n", algp->base.cra_name);
+			pr_debug("reg alg: %s\n", algp->base.base.cra_name);
 
-			err = crypto_register_skcipher(algp);
+			err = crypto_engine_register_skcipher(algp);
 			if (err)
 				goto err_algs;
 
@@ -1056,7 +1061,7 @@ static int omap_des_probe(struct platform_device *pdev)
 err_algs:
 	for (i = dd->pdata->algs_info_size - 1; i >= 0; i--)
 		for (j = dd->pdata->algs_info[i].registered - 1; j >= 0; j--)
-			crypto_unregister_skcipher(
+			crypto_engine_unregister_skcipher(
 					&dd->pdata->algs_info[i].algs_list[j]);
 
 err_engine:
@@ -1086,7 +1091,7 @@ static int omap_des_remove(struct platform_device *pdev)
 
 	for (i = dd->pdata->algs_info_size - 1; i >= 0; i--)
 		for (j = dd->pdata->algs_info[i].registered - 1; j >= 0; j--)
-			crypto_unregister_skcipher(
+			crypto_engine_unregister_skcipher(
 					&dd->pdata->algs_info[i].algs_list[j]);
 
 	tasklet_kill(&dd->done_task);
diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 2ef92301969f3..4b79d54fd6712 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -13,34 +13,31 @@
 
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
+#include <crypto/engine.h>
+#include <crypto/hmac.h>
+#include <crypto/internal/hash.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
 #include <linux/err.h>
 #include <linux/device.h>
-#include <linux/module.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/init.h>
-#include <linux/errno.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/irq.h>
 #include <linux/io.h>
-#include <linux/platform_device.h>
-#include <linux/scatterlist.h>
-#include <linux/dma-mapping.h>
-#include <linux/dmaengine.h>
-#include <linux/pm_runtime.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/delay.h>
-#include <linux/crypto.h>
-#include <crypto/scatterwalk.h>
-#include <crypto/algapi.h>
-#include <crypto/sha1.h>
-#include <crypto/sha2.h>
-#include <crypto/hash.h>
-#include <crypto/hmac.h>
-#include <crypto/internal/hash.h>
-#include <crypto/engine.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 
 #define MD5_DIGEST_SIZE			16
 
@@ -168,7 +165,6 @@ struct omap_sham_hmac_ctx {
 };
 
 struct omap_sham_ctx {
-	struct crypto_engine_ctx	enginectx;
 	unsigned long		flags;
 
 	/* fallback stuff */
@@ -180,7 +176,7 @@ struct omap_sham_ctx {
 #define OMAP_SHAM_QUEUE_LENGTH	10
 
 struct omap_sham_algs_info {
-	struct ahash_alg	*algs_list;
+	struct ahash_engine_alg	*algs_list;
 	unsigned int		size;
 	unsigned int		registered;
 };
@@ -1353,8 +1349,6 @@ static int omap_sham_cra_init_alg(struct crypto_tfm *tfm, const char *alg_base)
 
 	}
 
-	tctx->enginectx.op.do_one_request = omap_sham_hash_one_req;
-
 	return 0;
 }
 
@@ -1425,15 +1419,15 @@ static int omap_sham_import(struct ahash_request *req, const void *in)
 	return 0;
 }
 
-static struct ahash_alg algs_sha1_md5[] = {
+static struct ahash_engine_alg algs_sha1_md5[] = {
 {
-	.init		= omap_sham_init,
-	.update		= omap_sham_update,
-	.final		= omap_sham_final,
-	.finup		= omap_sham_finup,
-	.digest		= omap_sham_digest,
-	.halg.digestsize	= SHA1_DIGEST_SIZE,
-	.halg.base	= {
+	.base.init		= omap_sham_init,
+	.base.update		= omap_sham_update,
+	.base.final		= omap_sham_final,
+	.base.finup		= omap_sham_finup,
+	.base.digest		= omap_sham_digest,
+	.base.halg.digestsize	= SHA1_DIGEST_SIZE,
+	.base.halg.base	= {
 		.cra_name		= "sha1",
 		.cra_driver_name	= "omap-sha1",
 		.cra_priority		= 400,
@@ -1446,16 +1440,17 @@ static struct ahash_alg algs_sha1_md5[] = {
 		.cra_module		= THIS_MODULE,
 		.cra_init		= omap_sham_cra_init,
 		.cra_exit		= omap_sham_cra_exit,
-	}
+	},
+	.op.do_one_request = omap_sham_hash_one_req,
 },
 {
-	.init		= omap_sham_init,
-	.update		= omap_sham_update,
-	.final		= omap_sham_final,
-	.finup		= omap_sham_finup,
-	.digest		= omap_sham_digest,
-	.halg.digestsize	= MD5_DIGEST_SIZE,
-	.halg.base	= {
+	.base.init		= omap_sham_init,
+	.base.update		= omap_sham_update,
+	.base.final		= omap_sham_final,
+	.base.finup		= omap_sham_finup,
+	.base.digest		= omap_sham_digest,
+	.base.halg.digestsize	= MD5_DIGEST_SIZE,
+	.base.halg.base	= {
 		.cra_name		= "md5",
 		.cra_driver_name	= "omap-md5",
 		.cra_priority		= 400,
@@ -1468,17 +1463,18 @@ static struct ahash_alg algs_sha1_md5[] = {
 		.cra_module		= THIS_MODULE,
 		.cra_init		= omap_sham_cra_init,
 		.cra_exit		= omap_sham_cra_exit,
-	}
+	},
+	.op.do_one_request = omap_sham_hash_one_req,
 },
 {
-	.init		= omap_sham_init,
-	.update		= omap_sham_update,
-	.final		= omap_sham_final,
-	.finup		= omap_sham_finup,
-	.digest		= omap_sham_digest,
-	.setkey		= omap_sham_setkey,
-	.halg.digestsize	= SHA1_DIGEST_SIZE,
-	.halg.base	= {
+	.base.init		= omap_sham_init,
+	.base.update		= omap_sham_update,
+	.base.final		= omap_sham_final,
+	.base.finup		= omap_sham_finup,
+	.base.digest		= omap_sham_digest,
+	.base.setkey		= omap_sham_setkey,
+	.base.halg.digestsize	= SHA1_DIGEST_SIZE,
+	.base.halg.base	= {
 		.cra_name		= "hmac(sha1)",
 		.cra_driver_name	= "omap-hmac-sha1",
 		.cra_priority		= 400,
@@ -1492,17 +1488,18 @@ static struct ahash_alg algs_sha1_md5[] = {
 		.cra_module		= THIS_MODULE,
 		.cra_init		= omap_sham_cra_sha1_init,
 		.cra_exit		= omap_sham_cra_exit,
-	}
+	},
+	.op.do_one_request = omap_sham_hash_one_req,
 },
 {
-	.init		= omap_sham_init,
-	.update		= omap_sham_update,
-	.final		= omap_sham_final,
-	.finup		= omap_sham_finup,
-	.digest		= omap_sham_digest,
-	.setkey		= omap_sham_setkey,
-	.halg.digestsize	= MD5_DIGEST_SIZE,
-	.halg.base	= {
+	.base.init		= omap_sham_init,
+	.base.update		= omap_sham_update,
+	.base.final		= omap_sham_final,
+	.base.finup		= omap_sham_finup,
+	.base.digest		= omap_sham_digest,
+	.base.setkey		= omap_sham_setkey,
+	.base.halg.digestsize	= MD5_DIGEST_SIZE,
+	.base.halg.base	= {
 		.cra_name		= "hmac(md5)",
 		.cra_driver_name	= "omap-hmac-md5",
 		.cra_priority		= 400,
@@ -1516,20 +1513,21 @@ static struct ahash_alg algs_sha1_md5[] = {
 		.cra_module		= THIS_MODULE,
 		.cra_init		= omap_sham_cra_md5_init,
 		.cra_exit		= omap_sham_cra_exit,
-	}
+	},
+	.op.do_one_request = omap_sham_hash_one_req,
 }
 };
 
 /* OMAP4 has some algs in addition to what OMAP2 has */
-static struct ahash_alg algs_sha224_sha256[] = {
-{
-	.init		= omap_sham_init,
-	.update		= omap_sham_update,
-	.final		= omap_sham_final,
-	.finup		= omap_sham_finup,
-	.digest		= omap_sham_digest,
-	.halg.digestsize	= SHA224_DIGEST_SIZE,
-	.halg.base	= {
+static struct ahash_engine_alg algs_sha224_sha256[] = {
+{
+	.base.init		= omap_sham_init,
+	.base.update		= omap_sham_update,
+	.base.final		= omap_sham_final,
+	.base.finup		= omap_sham_finup,
+	.base.digest		= omap_sham_digest,
+	.base.halg.digestsize	= SHA224_DIGEST_SIZE,
+	.base.halg.base	= {
 		.cra_name		= "sha224",
 		.cra_driver_name	= "omap-sha224",
 		.cra_priority		= 400,
@@ -1542,16 +1540,17 @@ static struct ahash_alg algs_sha224_sha256[] = {
 		.cra_module		= THIS_MODULE,
 		.cra_init		= omap_sham_cra_init,
 		.cra_exit		= omap_sham_cra_exit,
-	}
+	},
+	.op.do_one_request = omap_sham_hash_one_req,
 },
 {
-	.init		= omap_sham_init,
-	.update		= omap_sham_update,
-	.final		= omap_sham_final,
-	.finup		= omap_sham_finup,
-	.digest		= omap_sham_digest,
-	.halg.digestsize	= SHA256_DIGEST_SIZE,
-	.halg.base	= {
+	.base.init		= omap_sham_init,
+	.base.update		= omap_sham_update,
+	.base.final		= omap_sham_final,
+	.base.finup		= omap_sham_finup,
+	.base.digest		= omap_sham_digest,
+	.base.halg.digestsize	= SHA256_DIGEST_SIZE,
+	.base.halg.base	= {
 		.cra_name		= "sha256",
 		.cra_driver_name	= "omap-sha256",
 		.cra_priority		= 400,
@@ -1564,17 +1563,18 @@ static struct ahash_alg algs_sha224_sha256[] = {
 		.cra_module		= THIS_MODULE,
 		.cra_init		= omap_sham_cra_init,
 		.cra_exit		= omap_sham_cra_exit,
-	}
+	},
+	.op.do_one_request = omap_sham_hash_one_req,
 },
 {
-	.init		= omap_sham_init,
-	.update		= omap_sham_update,
-	.final		= omap_sham_final,
-	.finup		= omap_sham_finup,
-	.digest		= omap_sham_digest,
-	.setkey		= omap_sham_setkey,
-	.halg.digestsize	= SHA224_DIGEST_SIZE,
-	.halg.base	= {
+	.base.init		= omap_sham_init,
+	.base.update		= omap_sham_update,
+	.base.final		= omap_sham_final,
+	.base.finup		= omap_sham_finup,
+	.base.digest		= omap_sham_digest,
+	.base.setkey		= omap_sham_setkey,
+	.base.halg.digestsize	= SHA224_DIGEST_SIZE,
+	.base.halg.base	= {
 		.cra_name		= "hmac(sha224)",
 		.cra_driver_name	= "omap-hmac-sha224",
 		.cra_priority		= 400,
@@ -1588,17 +1588,18 @@ static struct ahash_alg algs_sha224_sha256[] = {
 		.cra_module		= THIS_MODULE,
 		.cra_init		= omap_sham_cra_sha224_init,
 		.cra_exit		= omap_sham_cra_exit,
-	}
+	},
+	.op.do_one_request = omap_sham_hash_one_req,
 },
 {
-	.init		= omap_sham_init,
-	.update		= omap_sham_update,
-	.final		= omap_sham_final,
-	.finup		= omap_sham_finup,
-	.digest		= omap_sham_digest,
-	.setkey		= omap_sham_setkey,
-	.halg.digestsize	= SHA256_DIGEST_SIZE,
-	.halg.base	= {
+	.base.init		= omap_sham_init,
+	.base.update		= omap_sham_update,
+	.base.final		= omap_sham_final,
+	.base.finup		= omap_sham_finup,
+	.base.digest		= omap_sham_digest,
+	.base.setkey		= omap_sham_setkey,
+	.base.halg.digestsize	= SHA256_DIGEST_SIZE,
+	.base.halg.base	= {
 		.cra_name		= "hmac(sha256)",
 		.cra_driver_name	= "omap-hmac-sha256",
 		.cra_priority		= 400,
@@ -1612,19 +1613,20 @@ static struct ahash_alg algs_sha224_sha256[] = {
 		.cra_module		= THIS_MODULE,
 		.cra_init		= omap_sham_cra_sha256_init,
 		.cra_exit		= omap_sham_cra_exit,
-	}
+	},
+	.op.do_one_request = omap_sham_hash_one_req,
 },
 };
 
-static struct ahash_alg algs_sha384_sha512[] = {
+static struct ahash_engine_alg algs_sha384_sha512[] = {
 {
-	.init		= omap_sham_init,
-	.update		= omap_sham_update,
-	.final		= omap_sham_final,
-	.finup		= omap_sham_finup,
-	.digest		= omap_sham_digest,
-	.halg.digestsize	= SHA384_DIGEST_SIZE,
-	.halg.base	= {
+	.base.init		= omap_sham_init,
+	.base.update		= omap_sham_update,
+	.base.final		= omap_sham_final,
+	.base.finup		= omap_sham_finup,
+	.base.digest		= omap_sham_digest,
+	.base.halg.digestsize	= SHA384_DIGEST_SIZE,
+	.base.halg.base	= {
 		.cra_name		= "sha384",
 		.cra_driver_name	= "omap-sha384",
 		.cra_priority		= 400,
@@ -1637,16 +1639,17 @@ static struct ahash_alg algs_sha384_sha512[] = {
 		.cra_module		= THIS_MODULE,
 		.cra_init		= omap_sham_cra_init,
 		.cra_exit		= omap_sham_cra_exit,
-	}
+	},
+	.op.do_one_request = omap_sham_hash_one_req,
 },
 {
-	.init		= omap_sham_init,
-	.update		= omap_sham_update,
-	.final		= omap_sham_final,
-	.finup		= omap_sham_finup,
-	.digest		= omap_sham_digest,
-	.halg.digestsize	= SHA512_DIGEST_SIZE,
-	.halg.base	= {
+	.base.init		= omap_sham_init,
+	.base.update		= omap_sham_update,
+	.base.final		= omap_sham_final,
+	.base.finup		= omap_sham_finup,
+	.base.digest		= omap_sham_digest,
+	.base.halg.digestsize	= SHA512_DIGEST_SIZE,
+	.base.halg.base	= {
 		.cra_name		= "sha512",
 		.cra_driver_name	= "omap-sha512",
 		.cra_priority		= 400,
@@ -1659,17 +1662,18 @@ static struct ahash_alg algs_sha384_sha512[] = {
 		.cra_module		= THIS_MODULE,
 		.cra_init		= omap_sham_cra_init,
 		.cra_exit		= omap_sham_cra_exit,
-	}
+	},
+	.op.do_one_request = omap_sham_hash_one_req,
 },
 {
-	.init		= omap_sham_init,
-	.update		= omap_sham_update,
-	.final		= omap_sham_final,
-	.finup		= omap_sham_finup,
-	.digest		= omap_sham_digest,
-	.setkey		= omap_sham_setkey,
-	.halg.digestsize	= SHA384_DIGEST_SIZE,
-	.halg.base	= {
+	.base.init		= omap_sham_init,
+	.base.update		= omap_sham_update,
+	.base.final		= omap_sham_final,
+	.base.finup		= omap_sham_finup,
+	.base.digest		= omap_sham_digest,
+	.base.setkey		= omap_sham_setkey,
+	.base.halg.digestsize	= SHA384_DIGEST_SIZE,
+	.base.halg.base	= {
 		.cra_name		= "hmac(sha384)",
 		.cra_driver_name	= "omap-hmac-sha384",
 		.cra_priority		= 400,
@@ -1683,17 +1687,18 @@ static struct ahash_alg algs_sha384_sha512[] = {
 		.cra_module		= THIS_MODULE,
 		.cra_init		= omap_sham_cra_sha384_init,
 		.cra_exit		= omap_sham_cra_exit,
-	}
+	},
+	.op.do_one_request = omap_sham_hash_one_req,
 },
 {
-	.init		= omap_sham_init,
-	.update		= omap_sham_update,
-	.final		= omap_sham_final,
-	.finup		= omap_sham_finup,
-	.digest		= omap_sham_digest,
-	.setkey		= omap_sham_setkey,
-	.halg.digestsize	= SHA512_DIGEST_SIZE,
-	.halg.base	= {
+	.base.init		= omap_sham_init,
+	.base.update		= omap_sham_update,
+	.base.final		= omap_sham_final,
+	.base.finup		= omap_sham_finup,
+	.base.digest		= omap_sham_digest,
+	.base.setkey		= omap_sham_setkey,
+	.base.halg.digestsize	= SHA512_DIGEST_SIZE,
+	.base.halg.base	= {
 		.cra_name		= "hmac(sha512)",
 		.cra_driver_name	= "omap-hmac-sha512",
 		.cra_priority		= 400,
@@ -1707,7 +1712,8 @@ static struct ahash_alg algs_sha384_sha512[] = {
 		.cra_module		= THIS_MODULE,
 		.cra_init		= omap_sham_cra_sha512_init,
 		.cra_exit		= omap_sham_cra_exit,
-	}
+	},
+	.op.do_one_request = omap_sham_hash_one_req,
 },
 };
 
@@ -2148,14 +2154,16 @@ static int omap_sham_probe(struct platform_device *pdev)
 			break;
 
 		for (j = 0; j < dd->pdata->algs_info[i].size; j++) {
+			struct ahash_engine_alg *ealg;
 			struct ahash_alg *alg;
 
-			alg = &dd->pdata->algs_info[i].algs_list[j];
+			ealg = &dd->pdata->algs_info[i].algs_list[j];
+			alg = &ealg->base;
 			alg->export = omap_sham_export;
 			alg->import = omap_sham_import;
 			alg->halg.statesize = sizeof(struct omap_sham_reqctx) +
 					      BUFLEN;
-			err = crypto_register_ahash(alg);
+			err = crypto_engine_register_ahash(ealg);
 			if (err)
 				goto err_algs;
 
@@ -2174,7 +2182,7 @@ static int omap_sham_probe(struct platform_device *pdev)
 err_algs:
 	for (i = dd->pdata->algs_info_size - 1; i >= 0; i--)
 		for (j = dd->pdata->algs_info[i].registered - 1; j >= 0; j--)
-			crypto_unregister_ahash(
+			crypto_engine_unregister_ahash(
 					&dd->pdata->algs_info[i].algs_list[j]);
 err_engine_start:
 	crypto_engine_exit(dd->engine);
@@ -2205,7 +2213,7 @@ static int omap_sham_remove(struct platform_device *pdev)
 	spin_unlock_bh(&sham.lock);
 	for (i = dd->pdata->algs_info_size - 1; i >= 0; i--)
 		for (j = dd->pdata->algs_info[i].registered - 1; j >= 0; j--) {
-			crypto_unregister_ahash(
+			crypto_engine_unregister_ahash(
 					&dd->pdata->algs_info[i].algs_list[j]);
 			dd->pdata->algs_info[i].registered--;
 		}
-- 
2.53.0

