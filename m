Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D663DB632
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 20:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788984414; cv=none; b=qbZaTIH2Y5El1FQenYOVNypFHp0Q8tlozvs5S0+G2c5IjFhPsOX+tJkoRuuk4YE9dQggsIi9mfT0V5KqqAPa2xJpuP5GMw2zUst/s+ALQDaVmWP/JeGwgyRezxYPggOF1I/txr2e/dPGwP93jyYKE6SckNrNLuVKzyr4DOFO3eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788984414; c=relaxed/simple;
	bh=YNTA4OcnLeCYFHdR6ck+hqnh43sM8EMSQw1N/izzJNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EaC5y2/cbZno89dpb6Q/6fyP2R92otnuyqkn0XqVSXFPpykqfHSudCW+rmIYYw8e/VKdj62t+Z39ZyPED2p7bAbCD1iS3hpjF/kj444RIuHyCSFzm2rjU08znfhwHhPfyW1Ou20Id6IFscMxZVdpUJR2mEIzSxOBez9XrMzmM0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHENwvjX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHENwvjX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8C21F000FF;
	Wed,  9 Sep 2026 20:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788984413;
	bh=nroZkMC+tTJ/wbrzZzOISEaW7Ftoi8svQZN8PqCmCDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iHENwvjXSds2NHcFMu8l2KeYAHo+xyiCm6G0ovf6prisXAVDA87ShQZEVxZ46qOeM
	 aM4/gwxp2OXZjdwbh3pOq7+WwRnDbD/LObOcvDn7Bqx9ZChH2TN5KuTrK4zWTRl3aZ
	 CerhZT0nT4+iQswfYuaj+BBvmXV8ByZIqKbqJamvaYsxaa6c+iT4p//8ebeo6ZjDoN
	 bRm6ypMCkNTftYqvl+UXgzY6QxQG0j6rPgXHyrKVLYoz7dhXCRZ7eUCbMGcLAOl4A4
	 6VXXzqx1O7sG8obx6/kF59RKZ0+LmOZGk7Vw5vFOWVvnCyGyLAGuzX1qP4pUOoySCF
	 UvYjqXdPZ35TA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Can Peng <pengcan@kylinos.cn>,
	Linus Walleij <linusw@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] hwrng: stm32 - Fix runtime PM cleanup on registration failure
Date: Wed,  9 Sep 2026 16:06:51 -0400
Message-ID: <20260909200651.3597150-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090320-renovator-antiquely-61a9@gregkh>
References: <2026090320-renovator-antiquely-61a9@gregkh>
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
index bc22178f83e83..440c001c746b1 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -156,18 +156,13 @@ static int stm32_rng_probe(struct platform_device *ofdev)
 
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
@@ -209,7 +204,6 @@ static struct platform_driver stm32_rng_driver = {
 		.of_match_table = stm32_rng_match,
 	},
 	.probe = stm32_rng_probe,
-	.remove = stm32_rng_remove,
 };
 
 module_platform_driver(stm32_rng_driver);
-- 
2.53.0

