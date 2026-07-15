Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4CE3C9894
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110630; cv=none; b=LMBGDfN9Hja8WsyoWiyr8wIENuhfS4oDpAGpBcnozH34ddo/15700uE+Yt3G7RT0KKFJvp/pohpBH1AE62iIxK3u0/Bdr7oVjgO4CJG2EPVultAGr0fQ6zXSFhuBSp7Ila3H54eeO61sxFK/Wd3WPqbV76zF4l/MEzzIsmwmLp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110630; c=relaxed/simple;
	bh=hJy3VVdYBdo9OmiX/gB88xUDRgWL/u45Lujb48D97Pg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FjgIRO/fh+94Z2S3FTi0A2n52zZ/F3ORKcadLzw1N7A6C7rdSpzw/dYFMpBIjWvEePDrj+m3iN9jnXs1/YUoh9s3CDv8/rH/bTJKOHvkeE1qgSgXvTNXKvOLYw6eGhVYLymRdzc3zy9HU5ueqvgan3kWdDrEwG2jUaeq9gCBxRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0cjtNCNC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0cjtNCNC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7039C1F00A3A;
	Wed, 15 Jul 2026 10:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784110628;
	bh=fePocxgv8ChmLumfRFN2UNSRSzjUN/uvZjpVCupfUuI=;
	h=Subject:To:Cc:From:Date;
	b=0cjtNCNCDsbltHbYbFr6h2YAseUV+FHGNLFfRLomjcpgoev5ws7u2Dsxs7UD/kYZZ
	 BfP1KLdpoY4lZEzptFtRRyPXmek5Qiq7PS2pXVqWcifmFcl6yl9JkvgwTliRAFHiLQ
	 KVP/DcOsnW8rxaatLgcQCzfPkFJp47EVPSGI1Ucc=
Subject: FAILED: patch "[PATCH] crypto: sun4i-ss - Remove insecure and unused rng_alg" failed to apply to 5.15-stable tree
To: ebiggers@kernel.org,clabbe.montjoie@gmail.com,flynnnchen@tencent.com,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 12:16:48 +0200
Message-ID: <2026071548-grumbly-bakery-09f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b2c41fa9dd8fc740c489e060b199165771f268d1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071548-grumbly-bakery-09f9@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b2c41fa9dd8fc740c489e060b199165771f268d1 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 1 Jun 2026 16:07:57 +0000
Subject: [PATCH] crypto: sun4i-ss - Remove insecure and unused rng_alg

Remove sun4i_ss_rng, as it is insecure and unused:

- It has multiple vulnerabilities.  sun4i_ss_prng_seed() is missing
  locking and has a buffer overflow.  sun4i_ss_prng_generate() fails to
  fill the entire buffer with cryptographic random bytes, because it
  rounds the destination length down and also doesn't actually wait for
  the hardware to be ready before pulling bytes from it.

- No user of this code is known.  It's usable only theoretically via the
  "rng" algorithm type of AF_ALG.  But userspace actually just uses the
  actual Linux RNG (/dev/random etc) instead.  And rng_algs don't
  contribute entropy to the actual Linux RNG either.  (This may have
  been confused with hwrng, which does contribute entropy.)

The sun4i_ss_prng_seed() buffer overflow was reported by Tianchu Chen
and discovered by Atuin - Automated Vulnerability Discovery Engine

There's no point in fixing all these vulnerabilities individually when
this is unused code, so let's just remove it.

Fixes: b8ae5c7387ad ("crypto: sun4i-ss - support the Security System PRNG")
Cc: stable@vger.kernel.org
Reported-by: Tianchu Chen <flynnnchen@tencent.com>
Closes: https://lore.kernel.org/r/af749a8447bd7f0e9dd26ca6c87e9c6afecb09d9@linux.dev/
Acked-by: Corentin LABBE <clabbe.montjoie@gmail.com>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index a83d29fed175..f4b8d8f7dbef 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -170,7 +170,6 @@ CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_CRYPTO_DEV_SUN4I_SS=y
-CONFIG_CRYPTO_DEV_SUN4I_SS_PRNG=y
 CONFIG_CRYPTO_DEV_SUN8I_CE=y
 CONFIG_CRYPTO_DEV_SUN8I_SS=y
 CONFIG_DMA_CMA=y
diff --git a/drivers/crypto/allwinner/Kconfig b/drivers/crypto/allwinner/Kconfig
index b8e75210a0e3..06ea0e9fe6f2 100644
--- a/drivers/crypto/allwinner/Kconfig
+++ b/drivers/crypto/allwinner/Kconfig
@@ -24,14 +24,6 @@ config CRYPTO_DEV_SUN4I_SS
 	  To compile this driver as a module, choose M here: the module
 	  will be called sun4i-ss.
 
-config CRYPTO_DEV_SUN4I_SS_PRNG
-	bool "Support for Allwinner Security System PRNG"
-	depends on CRYPTO_DEV_SUN4I_SS
-	select CRYPTO_RNG
-	help
-	  Select this option if you want to provide kernel-side support for
-	  the Pseudo-Random Number Generator found in the Security System.
-
 config CRYPTO_DEV_SUN4I_SS_DEBUG
 	bool "Enable sun4i-ss stats"
 	depends on CRYPTO_DEV_SUN4I_SS
diff --git a/drivers/crypto/allwinner/sun4i-ss/Makefile b/drivers/crypto/allwinner/sun4i-ss/Makefile
index c0a2797d3168..06a9ae81f9f8 100644
--- a/drivers/crypto/allwinner/sun4i-ss/Makefile
+++ b/drivers/crypto/allwinner/sun4i-ss/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_CRYPTO_DEV_SUN4I_SS) += sun4i-ss.o
 sun4i-ss-y += sun4i-ss-core.o sun4i-ss-hash.o sun4i-ss-cipher.o
-sun4i-ss-$(CONFIG_CRYPTO_DEV_SUN4I_SS_PRNG) += sun4i-ss-prng.o
diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c
index 813c4bc6312a..35ef0930e77f 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c
@@ -213,23 +213,6 @@ static struct sun4i_ss_alg_template ss_algs[] = {
 		}
 	}
 },
-#ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_PRNG
-{
-	.type = CRYPTO_ALG_TYPE_RNG,
-	.alg.rng = {
-		.base = {
-			.cra_name		= "stdrng",
-			.cra_driver_name	= "sun4i_ss_rng",
-			.cra_priority		= 300,
-			.cra_ctxsize		= 0,
-			.cra_module		= THIS_MODULE,
-		},
-		.generate               = sun4i_ss_prng_generate,
-		.seed                   = sun4i_ss_prng_seed,
-		.seedsize               = SS_SEED_LEN / BITS_PER_BYTE,
-	}
-},
-#endif
 };
 
 static int sun4i_ss_debugfs_show(struct seq_file *seq, void *v)
@@ -247,14 +230,6 @@ static int sun4i_ss_debugfs_show(struct seq_file *seq, void *v)
 				   ss_algs[i].stat_req, ss_algs[i].stat_opti, ss_algs[i].stat_fb,
 				   ss_algs[i].stat_bytes);
 			break;
-#ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_PRNG
-		case CRYPTO_ALG_TYPE_RNG:
-			seq_printf(seq, "%s %s reqs=%lu tsize=%lu\n",
-				   ss_algs[i].alg.rng.base.cra_driver_name,
-				   ss_algs[i].alg.rng.base.cra_name,
-				   ss_algs[i].stat_req, ss_algs[i].stat_bytes);
-			break;
-#endif
 		case CRYPTO_ALG_TYPE_AHASH:
 			seq_printf(seq, "%s %s reqs=%lu\n",
 				   ss_algs[i].alg.hash.halg.base.cra_driver_name,
@@ -473,15 +448,6 @@ static int sun4i_ss_probe(struct platform_device *pdev)
 				goto error_alg;
 			}
 			break;
-#ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_PRNG
-		case CRYPTO_ALG_TYPE_RNG:
-			err = crypto_register_rng(&ss_algs[i].alg.rng);
-			if (err) {
-				dev_err(ss->dev, "Fail to register %s\n",
-					ss_algs[i].alg.rng.base.cra_name);
-			}
-			break;
-#endif
 		}
 	}
 
@@ -501,11 +467,6 @@ static int sun4i_ss_probe(struct platform_device *pdev)
 		case CRYPTO_ALG_TYPE_AHASH:
 			crypto_unregister_ahash(&ss_algs[i].alg.hash);
 			break;
-#ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_PRNG
-		case CRYPTO_ALG_TYPE_RNG:
-			crypto_unregister_rng(&ss_algs[i].alg.rng);
-			break;
-#endif
 		}
 	}
 error_pm:
@@ -526,11 +487,6 @@ static void sun4i_ss_remove(struct platform_device *pdev)
 		case CRYPTO_ALG_TYPE_AHASH:
 			crypto_unregister_ahash(&ss_algs[i].alg.hash);
 			break;
-#ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_PRNG
-		case CRYPTO_ALG_TYPE_RNG:
-			crypto_unregister_rng(&ss_algs[i].alg.rng);
-			break;
-#endif
 		}
 	}
 
diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c
deleted file mode 100644
index 491fcb7b81b4..000000000000
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c
+++ /dev/null
@@ -1,69 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-#include "sun4i-ss.h"
-
-int sun4i_ss_prng_seed(struct crypto_rng *tfm, const u8 *seed,
-		       unsigned int slen)
-{
-	struct sun4i_ss_alg_template *algt;
-	struct rng_alg *alg = crypto_rng_alg(tfm);
-
-	algt = container_of(alg, struct sun4i_ss_alg_template, alg.rng);
-	memcpy(algt->ss->seed, seed, slen);
-
-	return 0;
-}
-
-int sun4i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
-			   unsigned int slen, u8 *dst, unsigned int dlen)
-{
-	struct sun4i_ss_alg_template *algt;
-	struct rng_alg *alg = crypto_rng_alg(tfm);
-	int i, err;
-	u32 v;
-	u32 *data = (u32 *)dst;
-	const u32 mode = SS_OP_PRNG | SS_PRNG_CONTINUE | SS_ENABLED;
-	size_t len;
-	struct sun4i_ss_ctx *ss;
-	unsigned int todo = (dlen / 4) * 4;
-
-	algt = container_of(alg, struct sun4i_ss_alg_template, alg.rng);
-	ss = algt->ss;
-
-	err = pm_runtime_resume_and_get(ss->dev);
-	if (err < 0)
-		return err;
-
-	if (IS_ENABLED(CONFIG_CRYPTO_DEV_SUN4I_SS_DEBUG)) {
-		algt->stat_req++;
-		algt->stat_bytes += todo;
-	}
-
-	spin_lock_bh(&ss->slock);
-
-	writel(mode, ss->base + SS_CTL);
-
-	while (todo > 0) {
-		/* write the seed */
-		for (i = 0; i < SS_SEED_LEN / BITS_PER_LONG; i++)
-			writel(ss->seed[i], ss->base + SS_KEY0 + i * 4);
-
-		/* Read the random data */
-		len = min_t(size_t, SS_DATA_LEN / BITS_PER_BYTE, todo);
-		readsl(ss->base + SS_TXFIFO, data, len / 4);
-		data += len / 4;
-		todo -= len;
-
-		/* Update the seed */
-		for (i = 0; i < SS_SEED_LEN / BITS_PER_LONG; i++) {
-			v = readl(ss->base + SS_KEY0 + i * 4);
-			ss->seed[i] = v;
-		}
-	}
-
-	writel(0, ss->base + SS_CTL);
-	spin_unlock_bh(&ss->slock);
-
-	pm_runtime_put(ss->dev);
-
-	return 0;
-}
diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h
index 6c5d4aa6453c..f7d1c79ac677 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h
@@ -31,8 +31,6 @@
 #include <crypto/internal/skcipher.h>
 #include <crypto/aes.h>
 #include <crypto/internal/des.h>
-#include <crypto/internal/rng.h>
-#include <crypto/rng.h>
 
 #define SS_CTL            0x00
 #define SS_KEY0           0x04
@@ -62,10 +60,6 @@
 
 /* SS_CTL configuration values */
 
-/* PRNG generator mode - bit 15 */
-#define SS_PRNG_ONESHOT		(0 << 15)
-#define SS_PRNG_CONTINUE	(1 << 15)
-
 /* IV mode for hash */
 #define SS_IV_ARBITRARY		(1 << 14)
 
@@ -94,14 +88,10 @@
 #define SS_OP_3DES		(2 << 4)
 #define SS_OP_SHA1		(3 << 4)
 #define SS_OP_MD5		(4 << 4)
-#define SS_OP_PRNG		(5 << 4)
 
 /* Data end bit - bit 2 */
 #define SS_DATA_END		(1 << 2)
 
-/* PRNG start bit - bit 1 */
-#define SS_PRNG_START		(1 << 1)
-
 /* SS Enable bit - bit 0 */
 #define SS_DISABLED		(0 << 0)
 #define SS_ENABLED		(1 << 0)
@@ -128,9 +118,6 @@
 #define SS_RXFIFO_EMP_INT_ENABLE	(1 << 2)
 #define SS_TXFIFO_AVA_INT_ENABLE	(1 << 0)
 
-#define SS_SEED_LEN 192
-#define SS_DATA_LEN 160
-
 /*
  * struct ss_variant - Describe SS hardware variant
  * @sha1_in_be:		The SHA1 digest is given by SS in BE, and so need to be inverted.
@@ -151,9 +138,6 @@ struct sun4i_ss_ctx {
 	char buf[4 * SS_RX_MAX];/* buffer for linearize SG src */
 	char bufo[4 * SS_TX_MAX]; /* buffer for linearize SG dst */
 	spinlock_t slock; /* control the use of the device */
-#ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_PRNG
-	u32 seed[SS_SEED_LEN / BITS_PER_LONG];
-#endif
 	struct dentry *dbgfs_dir;
 	struct dentry *dbgfs_stats;
 };
@@ -164,7 +148,6 @@ struct sun4i_ss_alg_template {
 	union {
 		struct skcipher_alg crypto;
 		struct ahash_alg hash;
-		struct rng_alg rng;
 	} alg;
 	struct sun4i_ss_ctx *ss;
 	unsigned long stat_req;
@@ -231,6 +214,3 @@ int sun4i_ss_des_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			unsigned int keylen);
 int sun4i_ss_des3_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			 unsigned int keylen);
-int sun4i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
-			   unsigned int slen, u8 *dst, unsigned int dlen);
-int sun4i_ss_prng_seed(struct crypto_rng *tfm, const u8 *seed, unsigned int slen);

