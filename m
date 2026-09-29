Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50D6501298;
	Tue, 29 Sep 2026 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683358; cv=none; b=QLoBq0lRARhNxOx4bcNZBBvgU8iKolnvupMdbfEs8MpzZRBwWH5rGpkzKmfNpwcR8SSQge8HiNlxgtRuj9l4d0HemMzBcRj/FRvG+ijF0YULyBSfwSMgSW/EMFiAtu0Y7IoeyrIk6Kuy/IXNJm5QGbxXRyvpbodLchHzez8+iM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683358; c=relaxed/simple;
	bh=bZy/RGubyMLSz2hQ2/V2wfjVTeFTeEzvGxBps57jw9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZrzRb+J5tNP+Wb0zepbjCRb3z6xZJfLBNnsZ1zLBbDObMxvQD4mWlA8Weqa8pYwa9kIlprSgfY+PoNkIep2rKkjTSTH28ymddYjLVdjUPFjnmafoXdAytqmLYLpwcLbZNjkvEZ2pl8jBnpy2Y/XnusVEmP2DBas+ajViLqacMb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MO8jfLOS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MO8jfLOS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBC11F00893;
	Tue, 29 Sep 2026 12:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790683356;
	bh=sUACMJ+CgbBdLtg8ylZRwdp/VYo9NnOY1Eag9oZOJwM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MO8jfLOSqqRtxYdwPqtfFSz0JfsDHTZ2KnOaU5Ceg9WEjKaiMCoXfD9b5QXPspPeI
	 0fEC+3L+gfUrQn68NKpe42hrjk392BS3S6hireQ60L1vfxAQoD6BCKwJH4A/4ow6C6
	 QB5rbY6H/swHhXkIIbLmBuqJAJ/WZnYHDFG+f2sajvUW4g2OxY1F2bYGt9Fj8uhhnj
	 GFYXG7Jwn2CWe3BuJcDXysLeTfjIcXP0ucZv6fjCygfZ6CAzFkQY4j02rpWbWhVws7
	 YqieDfUOXh9DBYBuhnZ6KiFjHItRCUkTToYZkK0iv2HASSTdd7yDmMH6PrEj9cmAMv
	 nndlXsZYlOITg==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 29 Sep 2026 14:02:25 +0200
Subject: [PATCH 2/3] media: mali-c55: Keep IRQ requested during suspend
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-mali-c55-irq-supend-resume-v1-2-e3af34afff12@kernel.org>
References: <20260929-mali-c55-irq-supend-resume-v1-0-e3af34afff12@kernel.org>
In-Reply-To: <20260929-mali-c55-irq-supend-resume-v1-0-e3af34afff12@kernel.org>
To: Li Youhong <dayou5941@163.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, 
 Nayden Kanchev <nayden.kanchev@arm.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0

The interrupt is currently freed on every runtime suspend and requested
again on runtime resume. Apart from tying interrupt ownership to the
power state rather than to the driver lifetime, this leaves remove to
guess whether an action is installed for the IRQ.

Request the interrupt once during probe and free it during remove.

Disable and synchronize the IRQ before powering the ISP off, and enable
it only after a successful power-on.

Hold a runtime PM reference during probe until the IRQ is installed,
and stop runtime PM and drain the IRQ before unregistering the media
entities during remove.

If firmware marks the ISP as a wakeup source, initialize device wakeup
and enable IRQ wake during system suspend. Disable it again before
resuming the device.

This configures the interrupt controller wake path.

Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 .../media/platform/arm/mali-c55/mali-c55-core.c    | 84 ++++++++++++++++------
 1 file changed, 64 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-core.c b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
index f28e9f4354ac..07267b79801b 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-core.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
@@ -17,6 +17,8 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_wakeup.h>
+#include <linux/property.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -675,8 +677,7 @@ static int __maybe_unused mali_c55_runtime_suspend(struct device *dev)
 {
 	struct mali_c55 *mali_c55 = dev_get_drvdata(dev);
 
-	if (irq_has_action(mali_c55->irqnum))
-		free_irq(mali_c55->irqnum, dev);
+	disable_irq(mali_c55->irqnum);
 	__mali_c55_power_off(mali_c55);
 
 	return 0;
@@ -745,25 +746,41 @@ static int __maybe_unused mali_c55_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	/*
-	 * The driver needs to transfer large amounts of register settings to
-	 * the ISP each frame, using either a DMA transfer or memcpy. We use a
-	 * threaded IRQ to avoid disabling interrupts the entire time that's
-	 * happening.
-	 */
-	ret = request_threaded_irq(mali_c55->irqnum, NULL, mali_c55_isr,
-				   IRQF_ONESHOT, dev_driver_string(dev), dev);
-	if (ret) {
-		__mali_c55_power_off(mali_c55);
-		dev_err(dev, "failed to request irq\n");
+	enable_irq(mali_c55->irqnum);
+
+	return 0;
+}
+
+static int __maybe_unused mali_c55_suspend(struct device *dev)
+{
+	struct mali_c55 *mali_c55 = dev_get_drvdata(dev);
+	int ret;
+
+	if (device_may_wakeup(dev)) {
+		ret = enable_irq_wake(mali_c55->irqnum);
+		if (ret)
+			return ret;
 	}
 
+	ret = pm_runtime_force_suspend(dev);
+	if (ret && device_may_wakeup(dev))
+		disable_irq_wake(mali_c55->irqnum);
+
 	return ret;
 }
 
+static int __maybe_unused mali_c55_resume(struct device *dev)
+{
+	struct mali_c55 *mali_c55 = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(mali_c55->irqnum);
+
+	return pm_runtime_force_resume(dev);
+}
+
 static const struct dev_pm_ops mali_c55_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(mali_c55_suspend, mali_c55_resume)
 	SET_RUNTIME_PM_OPS(mali_c55_runtime_suspend, mali_c55_runtime_resume,
 			   NULL)
 };
@@ -825,27 +842,53 @@ static int mali_c55_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_get_noresume(dev);
 	pm_runtime_enable(&pdev->dev);
 
 	ret = mali_c55_media_frameworks_init(mali_c55);
 	if (ret)
 		goto err_pm_runtime_disable;
 
-	pm_runtime_idle(&pdev->dev);
-
 	mali_c55->irqnum = platform_get_irq(pdev, 0);
 	if (mali_c55->irqnum < 0) {
 		ret = mali_c55->irqnum;
 		goto err_deinit_media_frameworks;
 	}
 
+	/*
+	 * The driver needs to transfer large amounts of register settings to
+	 * the ISP each frame, using either a DMA transfer or memcpy. We use a
+	 * threaded IRQ to avoid disabling interrupts the entire time that's
+	 * happening.
+	 */
+	ret = request_threaded_irq(mali_c55->irqnum, NULL, mali_c55_isr,
+				   IRQF_ONESHOT, dev_driver_string(dev), dev);
+	if (ret) {
+		dev_err(dev, "failed to request irq\n");
+		goto err_deinit_media_frameworks;
+	}
+
+	if (device_property_read_bool(dev, "wakeup-source")) {
+		ret = devm_device_init_wakeup(dev);
+		if (ret) {
+			ret = dev_err_probe(dev, ret,
+					    "failed to initialize wakeup\n");
+			goto err_free_irq;
+		}
+	}
+
+	pm_runtime_put_autosuspend(dev);
+
 	return 0;
 
+err_free_irq:
+	free_irq(mali_c55->irqnum, dev);
 err_deinit_media_frameworks:
 	mali_c55_media_frameworks_deinit(mali_c55);
 err_pm_runtime_disable:
-	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_set_suspended(&pdev->dev);
 	kfree(mali_c55->context.registers);
 err_power_off:
 	__mali_c55_power_off(mali_c55);
@@ -859,12 +902,13 @@ static void mali_c55_remove(struct platform_device *pdev)
 {
 	struct mali_c55 *mali_c55 = platform_get_drvdata(pdev);
 
+	pm_runtime_disable(&pdev->dev);
+	free_irq(mali_c55->irqnum, &pdev->dev);
 	mali_c55_media_frameworks_deinit(mali_c55);
-	if (!pm_runtime_suspended(&pdev->dev)) {
+	if (!pm_runtime_status_suspended(&pdev->dev)) {
 		__mali_c55_power_off(mali_c55);
 		pm_runtime_set_suspended(&pdev->dev);
 	}
-	pm_runtime_disable(&pdev->dev);
 	kfree(mali_c55->context.registers);
 	of_reserved_mem_device_release(&pdev->dev);
 }

-- 
2.55.0

