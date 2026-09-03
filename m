Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9FB4E3ED2
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449980; cv=none; b=AbdZa8KOb0Qka+JcP6IzyEiig0N2FUaMVz7Ajk4Zm3BzJn+SdDMErWLyuhOS/Jxews/mLeZZo77O7PcbeLVqhxYUkgA9wB2Fps8fvY//s0xEZflUMDNkyKhC2R2ybPjDiGefTGTmHzz4zl2+heywUsFGmO028bV4aBXKj94Tad8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449980; c=relaxed/simple;
	bh=8ZBz9l+g6igf1t3Bi/GtjmyKRNEorCukaF6IstNrYII=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Waxc/sXI9935OB7nym6Glko35yUASUppUe4de2BY6KNlZmyEhRN3A/2EgMXgW/OVoL3vYhd7oDYtAn4ZpnkEAytkgquvIIj2293oohPLpmehx8F3HXwtPQeqW9P5ZctpGdNxSKE5kaHuyyIfZtuh8HoizsG9WybpIh4w0PkWkL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y8yy/ayv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y8yy/ayv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3786F1F000E9;
	Thu,  3 Sep 2026 15:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449978;
	bh=fJsk70Z2OIs1gwhta+mn6NJBbi1+/uF6Eu7IwD9RM0U=;
	h=Subject:To:Cc:From:Date;
	b=Y8yy/ayvd5bdxVx6cXFX031Fl8qZbm5wWQM7sSLgBmeUMXweAfGvl64VrUnB02QCQ
	 V1/VsOhqCZmEognOPLanUWzQFcfFt3Rrftwx429//oJ1BAwiFysXnugC8vRfSuJi8o
	 TkX7lvQpIfBP6DfVdETGbp5xrg479jOZvzYuYFpE=
Subject: FAILED: patch "[PATCH] hwrng: stm32 - Fix runtime PM cleanup on registration failure" failed to apply to 6.6-stable tree
To: pengcan@kylinos.cn,herbert@gondor.apana.org.au,linusw@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:12:19 +0200
Message-ID: <2026090319-throng-sprain-3ab3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1163a476a568f6c0f852d469c8e4c5a5f805adac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090319-throng-sprain-3ab3@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

