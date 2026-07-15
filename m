Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0822C431483
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110578; cv=none; b=vA4C41ITfs1jYdQUzmnmV/Sov6VAnEzKGRLELSkCKptBPuA2RJgjJDAobneoDYJUYHlaVl9qwOKz82utBdlxNaiapm2IpScLNW3z9Pf6e4W0VM4t+7lQH8nS08hzVGuhM/MOHNe1dZlArgDKx4fIBOh6H3o/77KDJIdcL9YkEAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110578; c=relaxed/simple;
	bh=et9d0BNjmY0Cdk0Nj8cQKOuKtDwIGwQW+8joXypJquE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O0lXH9KOJwwWePJYfG0IZ8BaMeQkVsJR3q1icrDQWTwJR5J9FSKI5BufSWek65Igz+L32B+56UE6zbBGBDAGRA7VZq+hhfNvoZJ42kAKKYYpoJbL6pifD+YdnJCSJxVFK1UqZgeK5MPH4qIkowqZnJpB+VZmPePMJiVzIsZf4jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LC8RVImh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LC8RVImh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F751F00A3D;
	Wed, 15 Jul 2026 10:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784110576;
	bh=IgPBz9SzJCrvQ5mRgoYMydmh7ysKFcfPnCSUOcidYy8=;
	h=Subject:To:Cc:From:Date;
	b=LC8RVImhGVwHtwn4hRpIEElflk06fzXZQx/1nYQPStxhKxTblEWsPY7AT1VIQmpJH
	 KYEV940lFMGTBGy0/TaM8AqrAwfMrpUdV1FzJIu2LvKipDrVfXasBfhPtzLDQEBig3
	 n4M8dbb1DbDHPAvt2t++2sKORun6Thm0NNJI1r7M=
Subject: FAILED: patch "[PATCH] crypto: xilinx-trng - Remove crypto_rng interface" failed to apply to 6.18-stable tree
To: ebiggers@kernel.org,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 12:16:02 +0200
Message-ID: <2026071502-barrier-saint-890d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 32b4d29280ed2a991dc196d5845b892acedc63b8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071502-barrier-saint-890d@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 32b4d29280ed2a991dc196d5845b892acedc63b8 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Sun, 31 May 2026 12:17:35 -0700
Subject: [PATCH] crypto: xilinx-trng - Remove crypto_rng interface

Implementing the crypto_rng interface has no purpose, as it isn't used
in practice.  It's being removed from other drivers too.  Just remove
it.  This leaves hwrng, which is actually used.

Tagging with 'Cc stable' due to the bugs that this removes:

  - xtrng_trng_generate() sometimes returned success even when it didn't
    fill in all the bytes.

  - It was possible for xtrng_trng_generate() and
    xtrng_hwrng_trng_read() to run concurrently and interfere with each
    other, as the locking code in xtrng_hwrng_trng_read() was broken.

Fixes: 8979744aca80 ("crypto: xilinx - Add TRNG driver for Versal")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 4c47ab6bb267..851904fb9ba4 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -703,7 +703,6 @@ config CRYPTO_DEV_XILINX_TRNG
 	tristate "Support for Xilinx True Random Generator"
 	depends on ZYNQMP_FIRMWARE || COMPILE_TEST
 	select CRYPTO_DF80090A
-	select CRYPTO_RNG
 	select HW_RANDOM
 	help
 	  Xilinx Versal SoC driver provides kernel-side support for True Random Number
diff --git a/drivers/crypto/xilinx/xilinx-trng.c b/drivers/crypto/xilinx/xilinx-trng.c
index 43a4832f07e7..a35643baa489 100644
--- a/drivers/crypto/xilinx/xilinx-trng.c
+++ b/drivers/crypto/xilinx/xilinx-trng.c
@@ -6,7 +6,6 @@
 
 #include <linux/bitfield.h>
 #include <linux/clk.h>
-#include <linux/crypto.h>
 #include <linux/delay.h>
 #include <linux/firmware/xlnx-zynqmp.h>
 #include <linux/hw_random.h>
@@ -14,13 +13,11 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <crypto/aes.h>
 #include <crypto/df_sp80090a.h>
 #include <crypto/internal/cipher.h>
-#include <crypto/internal/rng.h>
 
 /* TRNG Registers Offsets */
 #define TRNG_STATUS_OFFSET			0x4U
@@ -60,16 +57,9 @@ struct xilinx_rng {
 	struct device *dev;
 	unsigned char *scratchpadbuf;
 	struct aes_enckey *aeskey;
-	struct mutex lock;	/* Protect access to TRNG device */
 	struct hwrng trng;
 };
 
-struct xilinx_rng_ctx {
-	struct xilinx_rng *rng;
-};
-
-static struct xilinx_rng *xilinx_rng_dev;
-
 static void xtrng_readwrite32(void __iomem *addr, u32 mask, u8 value)
 {
 	u32 val;
@@ -245,47 +235,6 @@ static int xtrng_random_bytes_generate(struct xilinx_rng *rng, u8 *rand_buf_ptr,
 	return nbytes;
 }
 
-static int xtrng_trng_generate(struct crypto_rng *tfm, const u8 *src, u32 slen,
-			       u8 *dst, u32 dlen)
-{
-	struct xilinx_rng_ctx *ctx = crypto_rng_ctx(tfm);
-	int ret;
-
-	mutex_lock(&ctx->rng->lock);
-	ret = xtrng_random_bytes_generate(ctx->rng, dst, dlen, true);
-	mutex_unlock(&ctx->rng->lock);
-
-	return ret < 0 ? ret : 0;
-}
-
-static int xtrng_trng_seed(struct crypto_rng *tfm, const u8 *seed, unsigned int slen)
-{
-	return 0;
-}
-
-static int xtrng_trng_init(struct crypto_tfm *rtfm)
-{
-	struct xilinx_rng_ctx *ctx = crypto_tfm_ctx(rtfm);
-
-	ctx->rng = xilinx_rng_dev;
-
-	return 0;
-}
-
-static struct rng_alg xtrng_trng_alg = {
-	.generate = xtrng_trng_generate,
-	.seed = xtrng_trng_seed,
-	.seedsize = 0,
-	.base = {
-		.cra_name = "stdrng",
-		.cra_driver_name = "xilinx-trng",
-		.cra_priority = 300,
-		.cra_ctxsize = sizeof(struct xilinx_rng_ctx),
-		.cra_module = THIS_MODULE,
-		.cra_init = xtrng_trng_init,
-	},
-};
-
 static int xtrng_hwrng_trng_read(struct hwrng *hwrng, void *data, size_t max, bool wait)
 {
 	u8 buf[TRNG_SEC_STRENGTH_BYTES];
@@ -293,12 +242,6 @@ static int xtrng_hwrng_trng_read(struct hwrng *hwrng, void *data, size_t max, bo
 	int ret = -EINVAL, i = 0;
 
 	rng = container_of(hwrng, struct xilinx_rng, trng);
-	/* Return in case wait not set and lock not available. */
-	if (!mutex_trylock(&rng->lock) && !wait)
-		return 0;
-	else if (!mutex_is_locked(&rng->lock) && wait)
-		mutex_lock(&rng->lock);
-
 	while (i < max) {
 		ret = xtrng_random_bytes_generate(rng, buf, TRNG_SEC_STRENGTH_BYTES, wait);
 		if (ret < 0)
@@ -307,8 +250,6 @@ static int xtrng_hwrng_trng_read(struct hwrng *hwrng, void *data, size_t max, bo
 		memcpy(data + i, buf, min_t(int, ret, (max - i)));
 		i += min_t(int, ret, (max - i));
 	}
-	mutex_unlock(&rng->lock);
-
 	return ret;
 }
 
@@ -354,40 +295,24 @@ static int xtrng_probe(struct platform_device *pdev)
 
 	sb_size = crypto_drbg_ctr_df_datalen(TRNG_SEED_LEN_BYTES, AES_BLOCK_SIZE);
 	rng->scratchpadbuf = devm_kzalloc(&pdev->dev, sb_size, GFP_KERNEL);
-	if (!rng->scratchpadbuf) {
-		ret = -ENOMEM;
-		goto end;
-	}
+	if (!rng->scratchpadbuf)
+		return -ENOMEM;
 
 	xtrng_trng_reset(rng->rng_base);
 	ret = xtrng_reseed_internal(rng);
 	if (ret) {
 		dev_err(&pdev->dev, "TRNG Seed fail\n");
-		goto end;
-	}
-
-	xilinx_rng_dev = rng;
-	mutex_init(&rng->lock);
-	ret = crypto_register_rng(&xtrng_trng_alg);
-	if (ret) {
-		dev_err(&pdev->dev, "Crypto Random device registration failed: %d\n", ret);
-		goto end;
+		return ret;
 	}
 
 	ret = xtrng_hwrng_register(&rng->trng);
 	if (ret) {
 		dev_err(&pdev->dev, "HWRNG device registration failed: %d\n", ret);
-		goto crypto_rng_free;
+		return ret;
 	}
 	platform_set_drvdata(pdev, rng);
 
 	return 0;
-
-crypto_rng_free:
-	crypto_unregister_rng(&xtrng_trng_alg);
-
-end:
-	return ret;
 }
 
 static void xtrng_remove(struct platform_device *pdev)
@@ -397,13 +322,11 @@ static void xtrng_remove(struct platform_device *pdev)
 
 	rng = platform_get_drvdata(pdev);
 	xtrng_hwrng_unregister(&rng->trng);
-	crypto_unregister_rng(&xtrng_trng_alg);
 	xtrng_write_multiple_registers(rng->rng_base + TRNG_EXT_SEED_OFFSET, zero,
 				       TRNG_NUM_INIT_REGS);
 	xtrng_write_multiple_registers(rng->rng_base + TRNG_PER_STRNG_OFFSET, zero,
 				       TRNG_NUM_INIT_REGS);
 	xtrng_hold_reset(rng->rng_base);
-	xilinx_rng_dev = NULL;
 }
 
 static const struct of_device_id xtrng_of_match[] = {

