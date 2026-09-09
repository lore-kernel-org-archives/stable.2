Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199A23C5848
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788983271; cv=none; b=cjEkaZOBdgg1VuaAJJulCmRn2eOTl7JPlSxgPxhuKQ6Gs0e+HSKy/xh9BZY2nr8VE/156aC2+HBoPxlB5rToJVMq/DwAokC/OSAvGQ+uZ1izLKaUzjJK2qmwETz8/7aY41a91foeldg5XWJP/JrIPiSwH8N8Rass1YMuZyId9ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788983271; c=relaxed/simple;
	bh=VEi36kcMdDUPgux9i8Uwx/yAEsgo/Se8mPCzAnM1VFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlnTA6ZV6BM9EBC5WX+GlpqWa9GVS1N9723cbE7YZ6xdBjoX1Bl+/anyYg/qqzQWJX2qekK6UUOEsot8jkcCfC3C5lLDDGYyYRHygZpgZ56gM/j8/2hKo0yyKAzbNUVvC/1Oqt0Vo92EqjIEZscmY/WU4A67tl/Wy+xACAZNJpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahsbDZ8W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahsbDZ8W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111781F000FF;
	Wed,  9 Sep 2026 19:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788983269;
	bh=Ot6Mq2rLqnNlt035lSYV6+sA6Opkce73M/SDRsaozXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ahsbDZ8WkuZHh6xMLO4FfBQmAmblniG+U9oQm2EBGszGPgaxBLSHBz98YtPaXQbtK
	 d00bf7Lz0/opOmeRcsXtParS3awzNPibDa04qUTcTaL3uD1hs7FobnDbs0eQqMl2Oq
	 E6cCpE3QiYjOb47WA5/CxOkVS0xKdOvxyX9C7/HFV+XxgyYn7N79ElnPs64WPzzY6c
	 /INdmlqsFMydSZNaqmsDX3Mxh6Lf1GANdr2HXf5RFsb7Vm+TwSB8aH2CAE4TRmq+LP
	 za4YOs2spROLe06UpK4Rnp254ZTMNAp6wpgFd+QIMO233+a7HctoyMnnli1V78RLJY
	 BfA/OZTrPBiqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Can Peng <pengcan@kylinos.cn>,
	Linus Walleij <linusw@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] hwrng: stm32 - Fix runtime PM cleanup on registration failure
Date: Wed,  9 Sep 2026 15:47:47 -0400
Message-ID: <20260909194747.3582884-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090319-throng-sprain-3ab3@gregkh>
References: <2026090319-throng-sprain-3ab3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
[ adapted to the older driver’s relocated int-returning remove callback and existing err variable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/stm32-rng.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index efb6a9f9a11b5..fcfb0c4cea236 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -159,18 +159,13 @@ static int stm32_rng_probe(struct platform_device *ofdev)
 
 	pm_runtime_set_autosuspend_delay(dev, 100);
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_enable(dev);
+	err = devm_pm_runtime_enable(dev);
+	if (err)
+		return err;
 
 	return devm_hwrng_register(dev, &priv->rng);
 }
 
-static int stm32_rng_remove(struct platform_device *ofdev)
-{
-	pm_runtime_disable(&ofdev->dev);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM
 static int stm32_rng_runtime_suspend(struct device *dev)
 {
@@ -212,7 +207,6 @@ static struct platform_driver stm32_rng_driver = {
 		.of_match_table = stm32_rng_match,
 	},
 	.probe = stm32_rng_probe,
-	.remove = stm32_rng_remove,
 };
 
 module_platform_driver(stm32_rng_driver);
-- 
2.53.0

