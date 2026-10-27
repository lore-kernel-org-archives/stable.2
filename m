Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110090;
	b=qNh+bu5hIDOe5ppvIHs5s3VDdC3Kt3cK3k2R6SgfiJSQtybZWeNx/+n/O0KV1IgW+515
	 hGrXRBwwvxtoU/fS8sJQ5RCBLDmNpJWodAaFDHUwf3AiKefQC44HX4+jV+wZiykAiAmw1
	 TLH/S0eo/aWxfethydrbGC+cGn5hMielXUtGrjEjBHR5RqNDlnTqhTbCfAHfiB+HBB5IO
	 A/rd+36rpAENzh7Je1eKWqZsvZEIAze1+8xbZVslfDTrNTEAFLkrTbHloa/hwUpwhdt/t
	 NY9S0rvMUHR2rY+XXUv0ECeq1v3SwBDwH39GtPHtHwpXAxt6w3FOIscGCLOP3+4+JfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110090;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=ghKWXMkIH2dzolfGnd1erZ48txION0oYjZyBjh+JbTk=;
	b=PDuwGQ0T/vX//Z85GBB9itxVsG0lUQoiN0eXrf3MBUGVjK2QqNIqbMYNExwrGf7RaTYq
	 2joF9fMiN93/Mw5fT+smMND5MqgjH4H9OdVIyxsejpUD3Ng+yd2rD4iJmluYbV/Jn0KjC
	 7CXisHD1PZ9Ky64pi3IlvpAeDnP/tIvn53h7GonTjeA+h5cAzwnnPganDwY8ghBTx+SSl
	 z8Z+83PEia+R1mj4RmWztLmYyAahAANYhrFIyP59ZT92ArTBGnwdBo9Ouo5yVG5KCzQTd
	 GB6GsyZJFfW0esDHIoanWexI5+PDuE9Aqa2KwU/iIOszpnrg5/R8Qqi8EA+Ovz1yOCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HR6vK3aV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26608606A33A;
	Tue, 27 Oct 2026 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HR6vK3aV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3DC1F031E5;
	Tue, 27 Oct 2026 14:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793110089;
	bh=ghKWXMkIH2dzolfGnd1erZ48txION0oYjZyBjh+JbTk=;
	h=From:Date:Subject:To:Cc;
	b=HR6vK3aVoKSjQnJFhBYXpdqH4HE06Jk5gidwDe3FlAEYVCN+Zl6+K6aNWTr2rob+2
	 MiuYmUMaEDnswQz9qFj4OClaoeLoVbrZKbNfd/B5kJ2fbN4Dm3tvBKPw4aODS/PN/b
	 9ZI2Bjq0q0fcQbZmMkgdUnlxkX0EbJjU4uqm7HwfO3w4h+9pBzSY3fkzBuFet4uiUv
	 9RbBWl5+Gv94qLyr2yzU4rjwCVGlMBBoMNo/8XJFmukzZVYkxIrrcG4TyEa38H7Gkg
	 fewPznrcr2veKCIwzAg/2Lt30k4uikV/EAVAJm4Mc0TlLFMt47UfeBG8CGJMhyP0hY
	 9rxhBDrp9QL6Q==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 27 Oct 2026 15:08:05 +0100
Subject: [PATCH v2] media: mali-c55: Keep IRQ requested during suspend
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-mali-c55-irq-supend-resume-v2-1-759b3f5b2cfd@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ6CMBCF4auQWTumLaLCynsYFhWmMBEKToVoC
 He3Etcu/7f43gKBhClAkSwgNHPgwccwuwSq1vqGkOvYYJQ5qlyfsbcdY5VlyPLAMI3kaxQKU0+
 YqlumTtYopTVEYBRy/Nrwaxm75fAc5L19zfq7/liT/2NnjQoptS49WOecNpc7iaduP0gD5bquH
 +6Hm+bFAAAA
X-Change-ID: 20260918-mali-c55-irq-supend-resume-30b507a20011
To: Li Youhong <dayou5941@163.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, 
 Nayden Kanchev <nayden.kanchev@arm.com>
Cc: linux-media@vger.kernel.org, stable@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
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

Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
This is essentially my reply with the "proper fix" for:
https://lore.kernel.org/linux-media/20260903025526.2657105-1-dayou5941@163.com/

Keep the Mali-C55 interrupt requested for the driver's lifetime instead
of changing interrupt ownership along with the runtime power state.
Synchronize and disable the IRQ before power-off, and enable it after
power-on. Hold a PM reference until probe installs the IRQ, and stop
runtime PM and drain the IRQ before removing the media entities.

Tested on the Renesas RZ/V2H board with the other in-flight patches
(DTS changes and the TPG enablement) doing full suspend/resume cycles
with wakeup from RTC and NMI and capturing images before and after
the test.

This patch was authored with the assistance of an LLM.
---
Changes in v2:
- Drop the wakeup-source binding patch and all ISP wakeup handling.
- Drop the patch retaining ISP power for wakeup; keep the IRQ lifetime fix.
- Link to v1: https://patch.msgid.link/20260929-mali-c55-irq-supend-resume-v1-0-e3af34afff12@kernel.org
---
 .../media/platform/arm/mali-c55/mali-c55-core.c    | 44 ++++++++++++----------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-core.c b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
index f28e9f4354ac..3c2816b6a96b 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-core.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
@@ -675,8 +675,7 @@ static int __maybe_unused mali_c55_runtime_suspend(struct device *dev)
 {
 	struct mali_c55 *mali_c55 = dev_get_drvdata(dev);
 
-	if (irq_has_action(mali_c55->irqnum))
-		free_irq(mali_c55->irqnum, dev);
+	disable_irq(mali_c55->irqnum);
 	__mali_c55_power_off(mali_c55);
 
 	return 0;
@@ -745,20 +744,9 @@ static int __maybe_unused mali_c55_runtime_resume(struct device *dev)
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
-	}
+	enable_irq(mali_c55->irqnum);
 
-	return ret;
+	return 0;
 }
 
 static const struct dev_pm_ops mali_c55_pm_ops = {
@@ -825,27 +813,42 @@ static int mali_c55_probe(struct platform_device *pdev)
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
+	pm_runtime_put_autosuspend(dev);
+
 	return 0;
 
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
@@ -859,12 +862,13 @@ static void mali_c55_remove(struct platform_device *pdev)
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

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260918-mali-c55-irq-supend-resume-30b507a20011

Best regards,
--  
Linus Walleij <linusw@kernel.org>

