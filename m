Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5ED4E2366
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449977; cv=none; b=WkyW8sSDTVDz2nqsOOXY2j2AD7we+C7hPsW1zUiqfFaBv0mpwlPFUUTSY2J9/ixWAo2HKNu1gi509sJ8GStoTAu2ZpZVgibtqDTPVpNieREK4P0OQgKqhCz/SJ3CPBVgHJ+DN3UVWyvP22Fvhs/Z5YdMqd0miLgsxitkZcZHIuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449977; c=relaxed/simple;
	bh=cxAJVLQKIQMZ4iMOVcVv/ZntJ8sFWF/O3/MQy8EcEuo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QNWcwtQExAg8GgO5RoYGZTuuVeFofWkcypH+/4/LMX7Y8f7IMePmDYm4uS3/VNGlCQGwAPnb/ZeRHN9ax/HCSU+dQwRr2D3FPJWE26Dsx01tJgJ087swPU7BsUbjNt0KOIZTgNj1aEu72qcL0YzcBF8BicslAj/ndSJ7/wGnOlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H6Eee+D9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H6Eee+D9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621C31F000E9;
	Thu,  3 Sep 2026 15:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449975;
	bh=yN1v5Hm7G7I5XfIzgT+Lke+kO3WdkpNBtiIZ1pi5XnE=;
	h=Subject:To:Cc:From:Date;
	b=H6Eee+D9aAd1z1e8FOhGpU1AsAT0IlPKpCau8elWGY69zLxHps4LBEeeFvYIwKhr8
	 0qRBSvSydgUaNOgpqJGnlxdnESpUlIOxThyYDUeHVtcUlAT9T5l1VxXw3zEenmlVkN
	 KbJP/7vpM+BbXAJGfOm2c4CIutjf4kGSj/hKXjBk=
Subject: FAILED: patch "[PATCH] hwrng: stm32 - Fix runtime PM cleanup on registration failure" failed to apply to 5.15-stable tree
To: pengcan@kylinos.cn,herbert@gondor.apana.org.au,linusw@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:12:19 +0200
Message-ID: <2026090319-crinkle-runway-9c5f@gregkh>
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
git cherry-pick -x 1163a476a568f6c0f852d469c8e4c5a5f805adac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090319-crinkle-runway-9c5f@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1163a476a568f6c0f852d469c8e4c5a5f805adac Mon Sep 17 00:00:00 2001
From: Can Peng <pengcan@kylinos.cn>
Date: Sat, 18 Jul 2026 11:29:37 +0800
Subject: [PATCH] hwrng: stm32 - Fix runtime PM cleanup on registration failure

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

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index 9a8c00586ab0..f5bfe54c01dc 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -368,11 +368,6 @@ static int stm32_rng_init(struct hwrng *rng)
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
@@ -590,7 +585,9 @@ static int stm32_rng_probe(struct platform_device *ofdev)
 
 	pm_runtime_set_autosuspend_delay(dev, 100);
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
 
 	return devm_hwrng_register(dev, &priv->rng);
 }
@@ -602,7 +599,6 @@ static struct platform_driver stm32_rng_driver = {
 		.of_match_table = stm32_rng_match,
 	},
 	.probe = stm32_rng_probe,
-	.remove = stm32_rng_remove,
 };
 
 module_platform_driver(stm32_rng_driver);

