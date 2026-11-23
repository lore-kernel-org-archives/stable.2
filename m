Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795393883;
	b=zf6WIZNsG7O362at26W6WlrTPcohhTdvopa2OghbGiTyT7/F0UrXyYfzB8ofP5TYy9de
	 k76jeF+SbQkABmnyQUppJ5H0cBrP8JnmwndRvlfVQqNMacQVl/ifuveVdohsXfTBF2WXo
	 WXY26PmS9rETlY3T9oxXZgBA2SUZ+dhaunuKvE1duJsodoqga9Y0wFQoftxN8Q9WehELg
	 +RwdzOp4OKN74/xfVQ/+m/jT/HTi9S/EcNL42x8sVemL9Q9EQhJFIHNxQPWPF9ptDkv03
	 L7imfJcswnErdYdVp72UjnSVcCmyJIauYjHLbHchqnRMGXyHrNzfO1BuBD3eOqov2sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795393883;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=SDBUxlPhjW6BO1LnZPH3b7vj+VNeQjb3oZ27uq+UPLQ=;
	b=GUPtfD4YibG+QlXF91WRToJLIrtgj3UVrXh/zpOOpSP6O/4krouF+zWFjKMCYMGk4n9N
	 LvvL5Y5AS6xw4KXmjpmssaTSD2xBWoMg2xOcf6eBFDPlMFm07mEgh+84zMcpCSVKue0sk
	 kz3vnbPvAFf0Y0pIp4yEOO7ifrKx94naWYUzgAMVTY+bULcOYfukHiKt7PIebnMDWQf7W
	 8t2l2vOdo/aCpsfpnX6sJFJQLjCv9rH3AKizoMCs2xYTs6c1rZyzW8sBTehXUMzQ5ERSY
	 MhPMkZPTfTY39yCuFXHXAWdrv5WM3gA92GUppA1sT7WNHhak4J/dRCBqORyvhtf/5Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jbN3K0Lj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DF5606A31E;
	Mon, 23 Nov 2026 00:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jbN3K0Lj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6A91F000D0;
	Mon, 23 Nov 2026 00:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795393882;
	bh=SDBUxlPhjW6BO1LnZPH3b7vj+VNeQjb3oZ27uq+UPLQ=;
	h=From:Date:Subject:To:Cc;
	b=jbN3K0LjwJjUXuKoLraxYkQ0HL2/B6ASEDs9D89ZefB5uQueSOP99afcSBZSNuIJz
	 1jiXYsB8HzoR81gr9F9AZt+vAKChVcHoQmPOEIhH7MgItTZKDtghxmlfJlW6Z7BkqF
	 6xMqEt6I/Qx7FTnO/Wok0eFjmz97TdINkl4cJC3j5uLFFGuYOvxTMgAtG74TKAMsdv
	 RJo0y1XMOvbdRZlzFFL/K53BNrSSRGfectYCE8XUTawqIJGzdFUlBHBcGj6zTKFBY2
	 oMnctXtvHjLG5mYf6d2+/+KhERZK13yRvtswU2w/WlBbsuET1SPqQCDMrwbuklDmum
	 P8hc4rorNxYFA==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 23 Nov 2026 01:31:18 +0100
Subject: [PATCH v3] media: mali-c55: Keep IRQ requested during suspend
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
Message-Id: <20261123-mali-c55-irq-supend-resume-v3-1-8a933864e7aa@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/33NTQ6CMBBA4as0s2ZMO7UirLyHcVFgqo382QrRE
 O5uIMbEDdu3+N4EkYPnCLmYIPDoo+9ayIVOBJQ3214ZfQW5AJJ0kJk6YmNrj6Ux6MMD49BzW2H
 gODSMWhZGppakVAoSAX1g518rfr4kAm4+PrvwXl+jWuqXpWyLHRVKZG2d3lvnnKLTnUPL9a4LV
 1jckX6WkpRuWoQKU5MV2pmCSlf9WfM8fwDn0CLZEQEAAA==
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
Changes in v3:
- Explain the probe PM reference and drop the threaded IRQ comment.
- Link to v2: https://patch.msgid.link/20261027-mali-c55-irq-supend-resume-v2-1-759b3f5b2cfd@kernel.org

Changes in v2:
- Drop the wakeup-source binding patch and all ISP wakeup handling.
- Drop the patch retaining ISP power for wakeup; keep the IRQ lifetime fix.
- Link to v1: https://patch.msgid.link/20260929-mali-c55-irq-supend-resume-v1-0-e3af34afff12@kernel.org
---
 .../media/platform/arm/mali-c55/mali-c55-core.c    | 40 +++++++++++-----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-core.c b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
index f28e9f4354ac..c8d970b9673e 100644
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
@@ -825,27 +813,38 @@ static int mali_c55_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
+
+	/* Keep the ISP active until its IRQ handler is installed. */
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
@@ -859,12 +858,13 @@ static void mali_c55_remove(struct platform_device *pdev)
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

