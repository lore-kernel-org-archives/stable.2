Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9D03AE1A9
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980849; cv=none; b=faDxys0oxMmHWqJ4D31bKjX1/NBZP5LSYiJdmd0Ol+Isp4mP4+DNYugyeAoLdPL1BaKiRk8eDQrGgj+JxdBmGTroiBHBdkHnTzfvn36CzIP70yp/+FmLnrR5M8Y1ie9Ph4UBvu0cuj/JP3HSSQyZsdZbqQg/k2Wqgo1gmV1CWQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980849; c=relaxed/simple;
	bh=s5OAEBlmOAyK8sjvMe5V5vkxKin1xIKrl3CA1SYCi4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAO2iXtjmEtz1vM3j5o+82AIEpnjMFSPQGDUf9WWMfiMtxy1TgGA7XbzYfYtoO7DXkvtdFAgX6OpqSTQ4fZYBXSy2iMaIiX7nGZZ2P4yjDAi1BTIkiG5EZkVjPbkcNNRBifGZk+k1i7P5etlMFxwURlw8hgzzZyPO8XEvC430ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rj2oT/3X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rj2oT/3X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAA81F00893;
	Wed,  9 Sep 2026 19:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980847;
	bh=8iXZFvm6tot4m7lOX8KBLFayV7FwxEhxI8R9b/fpp+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rj2oT/3XJcIn59djx/cFWETF6VhmvlNlKl90Md5vnBLd1hgvheM0P+DpZhbjAyyJX
	 +OPpxH86r9xFaoTfqZZn5SGL0FXZa1Wisy4WCXNO4lv7exU5CVFpIAskrZBfwqDrjs
	 aeU/j6NKybrq4m330ZFkEFTDY8JUJV8YQQWQEF1+2HINhsUeX7bGmYXojxYuEzRuKG
	 CGc4qswjuZMnyajJew4eiPnPO0OLw0CFaFHm3qVBfBItJEjK9U4AvxZYFaq/Z/wm72
	 u+cwZkRlB42v55agS+gqgcm68OysNLZ1o7nOu8Ej630b8+o2lBHCzUrNzLfmw0d4qa
	 0MGYO0ZPCb/yA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] hwrng: drivers - Switch back to struct platform_driver::remove()
Date: Wed,  9 Sep 2026 15:07:23 -0400
Message-ID: <20260909190724.3536774-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090318-jester-velocity-118b@gregkh>
References: <2026090318-jester-velocity-118b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

[ Upstream commit d11c8b87a36267a2861b9010ce0393de8ff3d278 ]

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/char/hw_random to use
.remove(), with the eventual goal to drop struct
platform_driver::remove_new(). As .remove() and .remove_new() have the
same prototypes, conversion is done by just changing the structure
member name in the driver initializer.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 1163a476a568 ("hwrng: stm32 - Fix runtime PM cleanup on registration failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/atmel-rng.c      | 2 +-
 drivers/char/hw_random/cctrng.c         | 2 +-
 drivers/char/hw_random/exynos-trng.c    | 2 +-
 drivers/char/hw_random/ingenic-rng.c    | 2 +-
 drivers/char/hw_random/ks-sa-rng.c      | 2 +-
 drivers/char/hw_random/mxc-rnga.c       | 2 +-
 drivers/char/hw_random/n2-drv.c         | 2 +-
 drivers/char/hw_random/npcm-rng.c       | 2 +-
 drivers/char/hw_random/omap-rng.c       | 2 +-
 drivers/char/hw_random/stm32-rng.c      | 2 +-
 drivers/char/hw_random/timeriomem-rng.c | 2 +-
 drivers/char/hw_random/xgene-rng.c      | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/char/hw_random/atmel-rng.c b/drivers/char/hw_random/atmel-rng.c
index e9157255f8513..143406bc69393 100644
--- a/drivers/char/hw_random/atmel-rng.c
+++ b/drivers/char/hw_random/atmel-rng.c
@@ -216,7 +216,7 @@ MODULE_DEVICE_TABLE(of, atmel_trng_dt_ids);
 
 static struct platform_driver atmel_trng_driver = {
 	.probe		= atmel_trng_probe,
-	.remove_new	= atmel_trng_remove,
+	.remove		= atmel_trng_remove,
 	.driver		= {
 		.name	= "atmel-trng",
 		.pm	= pm_ptr(&atmel_trng_pm_ops),
diff --git a/drivers/char/hw_random/cctrng.c b/drivers/char/hw_random/cctrng.c
index 4c50efc464835..4db198849695d 100644
--- a/drivers/char/hw_random/cctrng.c
+++ b/drivers/char/hw_random/cctrng.c
@@ -653,7 +653,7 @@ static struct platform_driver cctrng_driver = {
 		.pm = &cctrng_pm,
 	},
 	.probe = cctrng_probe,
-	.remove_new = cctrng_remove,
+	.remove = cctrng_remove,
 };
 
 module_platform_driver(cctrng_driver);
diff --git a/drivers/char/hw_random/exynos-trng.c b/drivers/char/hw_random/exynos-trng.c
index 9f039fddaee3e..02e207c09e811 100644
--- a/drivers/char/hw_random/exynos-trng.c
+++ b/drivers/char/hw_random/exynos-trng.c
@@ -335,7 +335,7 @@ static struct platform_driver exynos_trng_driver = {
 		.of_match_table = exynos_trng_dt_match,
 	},
 	.probe = exynos_trng_probe,
-	.remove_new = exynos_trng_remove,
+	.remove = exynos_trng_remove,
 };
 
 module_platform_driver(exynos_trng_driver);
diff --git a/drivers/char/hw_random/ingenic-rng.c b/drivers/char/hw_random/ingenic-rng.c
index 2f9b6483c4a12..bbfd662d25a67 100644
--- a/drivers/char/hw_random/ingenic-rng.c
+++ b/drivers/char/hw_random/ingenic-rng.c
@@ -132,7 +132,7 @@ MODULE_DEVICE_TABLE(of, ingenic_rng_of_match);
 
 static struct platform_driver ingenic_rng_driver = {
 	.probe		= ingenic_rng_probe,
-	.remove_new	= ingenic_rng_remove,
+	.remove		= ingenic_rng_remove,
 	.driver		= {
 		.name	= "ingenic-rng",
 		.of_match_table = ingenic_rng_of_match,
diff --git a/drivers/char/hw_random/ks-sa-rng.c b/drivers/char/hw_random/ks-sa-rng.c
index 3c514b4fbc8ae..9e408144a10c1 100644
--- a/drivers/char/hw_random/ks-sa-rng.c
+++ b/drivers/char/hw_random/ks-sa-rng.c
@@ -265,7 +265,7 @@ static struct platform_driver ks_sa_rng_driver = {
 		.of_match_table = ks_sa_rng_dt_match,
 	},
 	.probe		= ks_sa_rng_probe,
-	.remove_new	= ks_sa_rng_remove,
+	.remove		= ks_sa_rng_remove,
 };
 
 module_platform_driver(ks_sa_rng_driver);
diff --git a/drivers/char/hw_random/mxc-rnga.c b/drivers/char/hw_random/mxc-rnga.c
index f01eb95bee314..e3fcb8bcc29bb 100644
--- a/drivers/char/hw_random/mxc-rnga.c
+++ b/drivers/char/hw_random/mxc-rnga.c
@@ -188,7 +188,7 @@ static struct platform_driver mxc_rnga_driver = {
 		.of_match_table = mxc_rnga_of_match,
 	},
 	.probe = mxc_rnga_probe,
-	.remove_new = mxc_rnga_remove,
+	.remove = mxc_rnga_remove,
 };
 
 module_platform_driver(mxc_rnga_driver);
diff --git a/drivers/char/hw_random/n2-drv.c b/drivers/char/hw_random/n2-drv.c
index 1b49e3a86d57b..ea6d5599242f6 100644
--- a/drivers/char/hw_random/n2-drv.c
+++ b/drivers/char/hw_random/n2-drv.c
@@ -858,7 +858,7 @@ static struct platform_driver n2rng_driver = {
 		.of_match_table = n2rng_match,
 	},
 	.probe		= n2rng_probe,
-	.remove_new	= n2rng_remove,
+	.remove		= n2rng_remove,
 };
 
 module_platform_driver(n2rng_driver);
diff --git a/drivers/char/hw_random/npcm-rng.c b/drivers/char/hw_random/npcm-rng.c
index bce8c4829a1f8..9ff00f096f381 100644
--- a/drivers/char/hw_random/npcm-rng.c
+++ b/drivers/char/hw_random/npcm-rng.c
@@ -176,7 +176,7 @@ static struct platform_driver npcm_rng_driver = {
 		.of_match_table = of_match_ptr(rng_dt_id),
 	},
 	.probe		= npcm_rng_probe,
-	.remove_new	= npcm_rng_remove,
+	.remove		= npcm_rng_remove,
 };
 
 module_platform_driver(npcm_rng_driver);
diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index 4914a8720e582..5e8b50f15db75 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -558,7 +558,7 @@ static struct platform_driver omap_rng_driver = {
 		.of_match_table = of_match_ptr(omap_rng_of_match),
 	},
 	.probe		= omap_rng_probe,
-	.remove_new	= omap_rng_remove,
+	.remove		= omap_rng_remove,
 };
 
 module_platform_driver(omap_rng_driver);
diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index 9d041a67c295a..b4d6ffb7dded1 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -565,7 +565,7 @@ static struct platform_driver stm32_rng_driver = {
 		.of_match_table = stm32_rng_match,
 	},
 	.probe = stm32_rng_probe,
-	.remove_new = stm32_rng_remove,
+	.remove = stm32_rng_remove,
 };
 
 module_platform_driver(stm32_rng_driver);
diff --git a/drivers/char/hw_random/timeriomem-rng.c b/drivers/char/hw_random/timeriomem-rng.c
index 65b8260339f5b..7174bfccc7b32 100644
--- a/drivers/char/hw_random/timeriomem-rng.c
+++ b/drivers/char/hw_random/timeriomem-rng.c
@@ -193,7 +193,7 @@ static struct platform_driver timeriomem_rng_driver = {
 		.of_match_table	= timeriomem_rng_match,
 	},
 	.probe		= timeriomem_rng_probe,
-	.remove_new	= timeriomem_rng_remove,
+	.remove		= timeriomem_rng_remove,
 };
 
 module_platform_driver(timeriomem_rng_driver);
diff --git a/drivers/char/hw_random/xgene-rng.c b/drivers/char/hw_random/xgene-rng.c
index 642d13519464c..39acaa503fec1 100644
--- a/drivers/char/hw_random/xgene-rng.c
+++ b/drivers/char/hw_random/xgene-rng.c
@@ -375,7 +375,7 @@ MODULE_DEVICE_TABLE(of, xgene_rng_of_match);
 
 static struct platform_driver xgene_rng_driver = {
 	.probe = xgene_rng_probe,
-	.remove_new = xgene_rng_remove,
+	.remove = xgene_rng_remove,
 	.driver = {
 		.name		= "xgene-rng",
 		.of_match_table = xgene_rng_of_match,
-- 
2.53.0

