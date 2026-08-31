Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A432882AB
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181253; cv=none; b=swqy06tLERuTBBnkbIAYb9bW7rTbLWV9xLRADV2zOMMqF1w5S6ocLgdTIGONxOn1u1QP6kCthCAbK87G6B+ACdwn3jNB0whkAcwd7Ak97LUuwm9EMWtmdjnjMXOpMsTte8AK0NObLw61RrjOrGVD1d1a+r/eaFK7amnIfi6ZZr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181253; c=relaxed/simple;
	bh=A7xKUGJMm0TVqtcnix/Dd6gYC915fldtXM/8PO6Yj1Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LyglRCF8h66s38TnhLZkQhVyz0yGjxjXVDSJ9nLw5A79tm3/DhxqaJ3/E8xKxWZkBNbD5s+hfkHpgH8XMlXCXumjs5hchvt6MAWeXbK8BGNa5K02lmkl6BI1fKb8jqoaQFATqAKAFFKEG50zi+H6U0JNN9ski5m/BMff+ZnoL5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iGlC/9CF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iGlC/9CF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77FC1F00A3D;
	Mon, 31 Aug 2026 13:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788181250;
	bh=A1Saoornetm7d0IFuN0DWHigBOK++o+w6T462x34poA=;
	h=Subject:To:Cc:From:Date;
	b=iGlC/9CFAYS3EVz9pKrkM8kQyNzh+rwW+cFXy3TxYrRxhWyZdQA2vL+z8m+hmA2R0
	 BjoKuu9N2Mprh5rerZn0/SxhpDpPnAWJkGkDpnmf1sSwJ0ACWfHGTnbim/BJ+ARkPj
	 rwEKUN7CTKl4ogwJRXK02O3YG48Xzk3XyB9brFsQ=
Subject: FAILED: patch "[PATCH] crypto: qcom-rng - Remove crypto_rng interface" failed to apply to 6.12-stable tree
To: ebiggers@kernel.org,dmitry.baryshkov@oss.qualcomm.com,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 15:00:46 +0200
Message-ID: <2026083146-squatted-debug-8f6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 2ecdf5c9910e20f73639bc322f0518a3439d17c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083146-squatted-debug-8f6e@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2ecdf5c9910e20f73639bc322f0518a3439d17c0 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 8 Jun 2026 17:58:47 +0000
Subject: [PATCH] crypto: qcom-rng - Remove crypto_rng interface

qcom-rng.c exposes the same hardware through two completely separate
interfaces, crypto_rng and hwrng.  However, the implementation of this
is buggy because it permits generation operations from these interfaces
to run concurrently with each other, accessing the same registers.  That
is, qcom_rng_generate() synchronizes with itself but not with
qcom_hwrng_read().  This results in potential repetition of output from
the RNG, output of non-random values, etc.

Fortunately, there's actually no point in hardware RNG drivers
implementing the crypto_rng interface.  It's not actually used by
anything besides the "rng" algorithm type of AF_ALG, which in turn is
not actually used in practice.  Other crypto_rng hardware drivers are
likewise being phased out, leaving just the hwrng support.

Thus, remove it to simplify the code and avoid conflict (and confusion)
with the hwrng interface which is the one that actually matters.

Fixes: f29cd5bb64c2 ("crypto: qcom-rng - Add hw_random interface support")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 216a00bad5d7..eb834d15d614 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -641,7 +641,6 @@ config CRYPTO_DEV_QCOM_RNG
 	tristate "Qualcomm Random Number Generator Driver"
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on HW_RANDOM
-	select CRYPTO_RNG
 	help
 	  This driver provides support for the Random Number
 	  Generator hardware found on Qualcomm SoCs.
diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
index 7058bd98f9e9..4d046caafe5b 100644
--- a/drivers/crypto/qcom-rng.c
+++ b/drivers/crypto/qcom-rng.c
@@ -3,10 +3,8 @@
 //
 // Based on msm-rng.c and downstream driver
 
-#include <crypto/internal/rng.h>
 #include <linux/acpi.h>
 #include <linux/clk.h>
-#include <linux/crypto.h>
 #include <linux/hw_random.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -32,24 +30,15 @@
 #define QCOM_TRNG_QUALITY	1024
 
 struct qcom_rng {
-	struct mutex lock;
 	void __iomem *base;
 	struct clk *clk;
 	struct hwrng hwrng;
-	struct qcom_rng_match_data *match_data;
-};
-
-struct qcom_rng_ctx {
-	struct qcom_rng *rng;
 };
 
 struct qcom_rng_match_data {
-	bool skip_init;
 	bool hwrng_support;
 };
 
-static struct qcom_rng *qcom_rng_dev;
-
 static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
 {
 	unsigned int currsize = 0;
@@ -80,37 +69,6 @@ static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
 	return currsize;
 }
 
-static int qcom_rng_generate(struct crypto_rng *tfm,
-			     const u8 *src, unsigned int slen,
-			     u8 *dstn, unsigned int dlen)
-{
-	struct qcom_rng_ctx *ctx = crypto_rng_ctx(tfm);
-	struct qcom_rng *rng = ctx->rng;
-	int ret;
-
-	ret = clk_prepare_enable(rng->clk);
-	if (ret)
-		return ret;
-
-	mutex_lock(&rng->lock);
-
-	ret = qcom_rng_read(rng, dstn, dlen);
-
-	mutex_unlock(&rng->lock);
-	clk_disable_unprepare(rng->clk);
-
-	if (ret >= 0)
-		ret = 0;
-
-	return ret;
-}
-
-static int qcom_rng_seed(struct crypto_rng *tfm, const u8 *seed,
-			 unsigned int slen)
-{
-	return 0;
-}
-
 static int qcom_hwrng_init(struct hwrng *hwrng)
 {
 	struct qcom_rng *qrng = container_of(hwrng, struct qcom_rng, hwrng);
@@ -132,74 +90,26 @@ static void qcom_hwrng_cleanup(struct hwrng *hwrng)
 	clk_disable_unprepare(qrng->clk);
 }
 
-static int qcom_rng_enable(struct qcom_rng *rng)
-{
-	u32 val;
-	int ret;
-
-	ret = clk_prepare_enable(rng->clk);
-	if (ret)
-		return ret;
-
-	/* Enable PRNG only if it is not already enabled */
-	val = readl_relaxed(rng->base + PRNG_CONFIG);
-	if (val & PRNG_CONFIG_HW_ENABLE)
-		goto already_enabled;
-
-	val = readl_relaxed(rng->base + PRNG_LFSR_CFG);
-	val &= ~PRNG_LFSR_CFG_MASK;
-	val |= PRNG_LFSR_CFG_CLOCKS;
-	writel(val, rng->base + PRNG_LFSR_CFG);
-
-	val = readl_relaxed(rng->base + PRNG_CONFIG);
-	val |= PRNG_CONFIG_HW_ENABLE;
-	writel(val, rng->base + PRNG_CONFIG);
-
-already_enabled:
-	clk_disable_unprepare(rng->clk);
-
-	return 0;
-}
-
-static int qcom_rng_init(struct crypto_tfm *tfm)
-{
-	struct qcom_rng_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	ctx->rng = qcom_rng_dev;
-
-	if (!ctx->rng->match_data->skip_init)
-		return qcom_rng_enable(ctx->rng);
-
-	return 0;
-}
-
-static struct rng_alg qcom_rng_alg = {
-	.generate	= qcom_rng_generate,
-	.seed		= qcom_rng_seed,
-	.seedsize	= 0,
-	.base		= {
-		.cra_name		= "stdrng",
-		.cra_driver_name	= "qcom-rng",
-		.cra_flags		= CRYPTO_ALG_TYPE_RNG,
-		.cra_priority		= 300,
-		.cra_ctxsize		= sizeof(struct qcom_rng_ctx),
-		.cra_module		= THIS_MODULE,
-		.cra_init		= qcom_rng_init,
-	}
-};
-
 static int qcom_rng_probe(struct platform_device *pdev)
 {
+	const struct qcom_rng_match_data *match_data;
 	struct qcom_rng *rng;
 	int ret;
 
+	match_data = device_get_match_data(&pdev->dev);
+	if (match_data == NULL || !match_data->hwrng_support) {
+		dev_info(&pdev->dev, "TRNG support not detected\n");
+		/*
+		 * In this case the driver does nothing except the dev_info(),
+		 * but bind the device anyway to avoid effects on GCC state.
+		 */
+		return 0;
+	}
+
 	rng = devm_kzalloc(&pdev->dev, sizeof(*rng), GFP_KERNEL);
 	if (!rng)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, rng);
-	mutex_init(&rng->lock);
-
 	rng->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rng->base))
 		return PTR_ERR(rng->base);
@@ -208,55 +118,26 @@ static int qcom_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(rng->clk))
 		return PTR_ERR(rng->clk);
 
-	rng->match_data = (struct qcom_rng_match_data *)device_get_match_data(&pdev->dev);
-
-	qcom_rng_dev = rng;
-	ret = crypto_register_rng(&qcom_rng_alg);
-	if (ret) {
-		dev_err(&pdev->dev, "Register crypto rng failed: %d\n", ret);
-		qcom_rng_dev = NULL;
-		return ret;
-	}
-
-	if (rng->match_data->hwrng_support) {
-		rng->hwrng.name = "qcom_hwrng";
-		rng->hwrng.init = qcom_hwrng_init;
-		rng->hwrng.read = qcom_hwrng_read;
-		rng->hwrng.cleanup = qcom_hwrng_cleanup;
-		rng->hwrng.quality = QCOM_TRNG_QUALITY;
-		ret = devm_hwrng_register(&pdev->dev, &rng->hwrng);
-		if (ret) {
-			dev_err(&pdev->dev, "Register hwrng failed: %d\n", ret);
-			qcom_rng_dev = NULL;
-			goto fail;
-		}
-	}
-
+	rng->hwrng.name = "qcom_hwrng";
+	rng->hwrng.init = qcom_hwrng_init;
+	rng->hwrng.read = qcom_hwrng_read;
+	rng->hwrng.cleanup = qcom_hwrng_cleanup;
+	rng->hwrng.quality = QCOM_TRNG_QUALITY;
+	ret = devm_hwrng_register(&pdev->dev, &rng->hwrng);
+	if (ret)
+		dev_err(&pdev->dev, "Register hwrng failed: %d\n", ret);
 	return ret;
-fail:
-	crypto_unregister_rng(&qcom_rng_alg);
-	return ret;
-}
-
-static void qcom_rng_remove(struct platform_device *pdev)
-{
-	crypto_unregister_rng(&qcom_rng_alg);
-
-	qcom_rng_dev = NULL;
 }
 
 static struct qcom_rng_match_data qcom_prng_match_data = {
-	.skip_init = false,
 	.hwrng_support = false,
 };
 
 static struct qcom_rng_match_data qcom_prng_ee_match_data = {
-	.skip_init = true,
 	.hwrng_support = false,
 };
 
 static struct qcom_rng_match_data qcom_trng_match_data = {
-	.skip_init = true,
 	.hwrng_support = true,
 };
 
@@ -276,7 +157,6 @@ MODULE_DEVICE_TABLE(of, qcom_rng_of_match);
 
 static struct platform_driver qcom_rng_driver = {
 	.probe = qcom_rng_probe,
-	.remove =  qcom_rng_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = qcom_rng_of_match,

