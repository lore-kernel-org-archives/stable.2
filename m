Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAE6321F5F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980850; cv=none; b=FT27s/ufdcQA/rauJAHuFIDYB+LVIpS/sRXtAbGzNWlZ4K0ndOEKpeA9RSwJx8lD/hjYZtPT7xgmN2Ce9LzO0dRt8JYQPaPckHYB8HTgyVhlZjBWrIrv2eCIVKRLq4szYcSY4CR6nSvkFrYyuAtyRSvTrNNetEr8H/AyUmm+5zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980850; c=relaxed/simple;
	bh=uvMWJPbQgOjk+fdiCYNjG+pvaBHhduE58wVG15+UqXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aibncGjl7AEBlzHLtn/8nbt+fRPMyt0qLSr8nXr8vP5xtX+oRhj2+GQBUtJT3YrPZ3NMpNHQZmeYiZdgSn19TJ2zR4TOBR4MpCOmySCVWeBgY9wwYzKrY87dsYIOsWeRw7z6nWRLJ7khnCFlHa4w0naKsOCWeYP+Bzdcp0vdRKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xc3bTQy4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xc3bTQy4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A96F1F000FF;
	Wed,  9 Sep 2026 19:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980848;
	bh=5R9nSFMmS4Zvl44jzQweFCiNc3F3c4u9qiWXMSzxiuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xc3bTQy4VHy8ofTpImHRIIS1Pg5TJt2KzrLSL1NKgBIMnTe3k05f+0Qg1v9Fv9mU4
	 7zK8b6Dr6QUxkrtBy/RwjkvErLkCC5p7mBRrM62vsxe+KKFbEctTMTeMUWmzit88de
	 vR/Vg7sa8pB6iw7OIULS7FGHtmA2vdOlTkzQN03givroU453E//5K/ALnAGpJuobE+
	 6KB7p+ITS1RXcPH0uFUMJNCDo98VMNQ+5b5MW8DBYqxwKixCEgHamYlb3xsxtDLShq
	 i735e857a5C3o7DfOlMZQ0gN52iO4j4U5XuKDiDrKl25aECeN8DRdKlEQ++DVfVSWO
	 3JEPhnfzxIUjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Can Peng <pengcan@kylinos.cn>,
	Linus Walleij <linusw@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] hwrng: stm32 - Fix runtime PM cleanup on registration failure
Date: Wed,  9 Sep 2026 15:07:24 -0400
Message-ID: <20260909190724.3536774-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909190724.3536774-1-sashal@kernel.org>
References: <2026090318-jester-velocity-118b@gregkh>
 <20260909190724.3536774-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Can Peng <pengcan@kylinos.cn>

[ Upstream commit 1163a476a568f6c0f852d469c8e4c5a5f805adac ]

stm32_rng_probe() enables autosuspend and runtime PM before registering the
hwrng. If devm_hwrng_register() fails, probe returns with runtime PM left
enabled and autosuspend still selected.

The remove callback also only disables runtime PM and does not undo
pm_runtime_use_autosuspend().

Use devm_pm_runtime_enable() so runtime PM is unwound automatically on
probe failure and driver detach. Since the managed cleanup also disables
runtime PM,drop the remove callback.

Fixes: c6a97c42e399 ("hwrng: stm32 - add support for STM32 HW RNG")
Cc: stable@vger.kernel.org
Signed-off-by: Can Peng <pengcan@kylinos.cn>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[ added the missing int ret declaration in stm32_rng_probe(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/stm32-rng.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index b4d6ffb7dded1..4b3fd3bd039a3 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -366,11 +366,6 @@ static int stm32_rng_init(struct hwrng *rng)
 	return 0;
 }
 
-static void stm32_rng_remove(struct platform_device *ofdev)
-{
-	pm_runtime_disable(&ofdev->dev);
-}
-
 static int __maybe_unused stm32_rng_runtime_suspend(struct device *dev)
 {
 	struct stm32_rng_private *priv = dev_get_drvdata(dev);
@@ -516,6 +511,7 @@ static int stm32_rng_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct stm32_rng_private *priv;
 	struct resource *res;
+	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -553,7 +549,9 @@ static int stm32_rng_probe(struct platform_device *ofdev)
 
 	pm_runtime_set_autosuspend_delay(dev, 100);
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
 
 	return devm_hwrng_register(dev, &priv->rng);
 }
@@ -565,7 +563,6 @@ static struct platform_driver stm32_rng_driver = {
 		.of_match_table = stm32_rng_match,
 	},
 	.probe = stm32_rng_probe,
-	.remove = stm32_rng_remove,
 };
 
 module_platform_driver(stm32_rng_driver);
-- 
2.53.0

