Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E075E47FAF8;
	Mon, 21 Sep 2026 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987586; cv=none; b=cVY0MOh4zHpxlbNDCfYpvPut4TiLD7iYKcfqkuAGbylKcQxUE/i1RFDxz3eOhWuaYqCNocg7jvsXDVIWsT3uSPVBOjREVITB39y698x9nK2ODLU3gMN5JkPZXxrL3IfjFVLwHIpAB5gbDz6XGDl38SYBicT4dPI3xKOqzP2+i3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987586; c=relaxed/simple;
	bh=YIluRJD+yPFtilWV2ms7LpHMpRmcjeRh8gvTRp2BzVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dRtWDOjlgmGXwyoMGDmJ3kt/17ZIEWV2IuRB35TKB9a83xeESlVYciRfe58AhSG2Fwod0GBWSHses8GBZKYoWQ8rJ9s/ujt3sOXO4wYqbu4oq82OG4ZbFe0Pz8D58sWR4tRg2D2hzq/3nxnkz0gguCYr8NNCoDxU/Lz+epEGgnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKS8pKVz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKS8pKVz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3A5CC4AF09;
	Mon, 21 Sep 2026 10:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789987585;
	bh=YIluRJD+yPFtilWV2ms7LpHMpRmcjeRh8gvTRp2BzVY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WKS8pKVz9tUMH+cpBmxq2sPdPt/pfII0O/95lkWxgwuFD+Dv0Tam23thvUTKfveuU
	 LEAa61QzV9NNfmLy7HqMraFh2LayBY+OxneTPG01zvmrFjdVZxEgnrXmdH0tnFVVYT
	 5iyCMq672gZPdPLeo5w0Z4/UPaGitsNvOnphNBlYc/KrED7OqKkD2Qy1zrt0Mv8098
	 f8a7O5MqSqrMSLaWaO4gpOtLohcinYqdz7bfn4S8f651F/SIbc44TOjptJxZoIvTPY
	 xxs9mkO89D0X/10T85okJ/pR4wUHHeInOdyRePetN98DAvRw5xv2k31F57sL1MYQsE
	 C0SaIHnHpO3uQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F30DC982F7;
	Mon, 21 Sep 2026 10:46:25 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 21 Sep 2026 12:46:24 +0200
Subject: [PATCH v4 3/4] backlight: qcom-wled: Fix unbalanced OVP IRQ enable
 at probe
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-qcom-wled-backlight-v4-3-bab8c7ef73cb@ixit.cz>
References: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
In-Reply-To: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Kiran Gunda <quic_kgunda@quicinc.com>, 
 Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Joel Selvaraj <foss@joelselvaraj.com>, David Heidelberg <david@ixit.cz>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6057; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=TliZA3ecky6AtA5rDK/WH2uUEPyAHUvMci0Rbzp8QCE=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqsQr/FB9ERVSpERl+ROohiulY91N8X4NLk4Dbu
 aZhiikzWrGJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCarEK/wAKCRBgAj/E00kg
 cijDD/4vUflQ26KeZ87eTLHndmBpJcXy9rzAQpHzgroXahbmi9Z2dgAMdZ3+ZXo9zc6xmgcsPCq
 xQO0gTUZWWwtEQANjPaWSGjGNP8gB9EwqhNRBFidmaB9+9AnayHxKLfdivLtQM3cE24xaB7fRtF
 c8OzdYzhVANkUISm08TLj1GGwJk8+f3vefglpObTZRCtzB5opPEbgy+pRiXOZXQ1Zrm+yiTLEg2
 gk2vZ2qC/xKD3Pd+L+QoOU4xm3KzNvBAMLUEQFR3OHRCegS7LncwC18bCQvYohOYpcOOprhyhsU
 rECVDhllkfiQJICeVhuKjnvA2r+m9u5I1jLadeq1UV6i0lQnuP5mQoNpZXXfuLdE01DCQg0TSq9
 VFYmKOBhzx+5WuYXArGALjzxnsYPUCxSmfPw0s2HjUDrAOuuxOiGkEnF1ehzZniLDpXg3MHzpxV
 cQLWxf1YVe2/nFSpmGG+2YWXKq7E2xLl6vOB2ThJjtyDjQ8SUB9S893U/1CKWZnsIGhQbBkUXVF
 d68Jh1cXw6m6v6t41eQKXK0hZ3Gd33FB/vEb/zAACgl087cXdB6bn1a23iGNNPynQQzJjdTXVb+
 obbK8pobuY3zXcEoazvoMgAqqfdxAiwyFXhmu/6jFfwzfnxgvOBb3QcPwWy561ZdQTKzUZpQR83
 D+Yijv9rF1OXmFg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

wled_configure_ovp_irq() derives the initial state of the OVP interrupt
from the hardware:

        /* Keep OVP irq disabled until module is enabled */
        if (!(val & WLED3_CTRL_REG_MOD_EN_MASK))
                disable_irq(wled->ovp_irq);

but wled->brightness, which is what the rest of the driver uses to tell
whether the module is on, is left at zero.

On boards where the bootloader hands the kernel a lit backlight the two
disagree. MOD_EN is already set, so the interrupt is left enabled, while
wled_update_status() still believes the backlight is off and takes

        if (!!brightness != !!wled->brightness)
                rc = wled_module_enable(wled, !!brightness);

on the first backlight update. wled_module_enable() then schedules
wled_ovp_work(), which calls enable_irq() on the already enabled
interrupt:

  Unbalanced enable for IRQ 176
  WARNING: CPU: 0 PID: 160 at kernel/irq/manage.c:774 __enable_irq+0x50/0x80
  Hardware name: Xiaomi Pocophone F1 (DT)
  Workqueue: events wled_ovp_work
  Call trace:
   __enable_irq+0x50/0x80
   enable_irq+0x48/0xa0
   wled_ovp_work+0x18/0x24
   process_one_work+0x1d0/0x350
   worker_thread+0x13c/0x460
   kthread+0x110/0x114
   ret_from_fork+0x10/0x20

The bootloader is not the only way to get there. The readback runs after
wledN_setup(), and wled4_setup() sets MOD_EN itself on the path where the
sink configuration does not already match, as does the tail of
wled_auto_string_detection(), which all three setup paths can reach
through wled_auto_detection_at_init(). A cold-booted board with a dark
panel can therefore reach the same disagreement.

Move the MOD_EN readback into wled_probe() and use it to seed
wled->brightness, so the driver starts out agreeing with the hardware,
and key the OVP interrupt off wled->brightness instead. The first
backlight update then only reprograms the brightness registers and
leaves both the module and the interrupt alone. The OVP interrupt also
stays armed from probe whenever the module is already enabled, rather
than being disabled at probe and only enabled once something writes
brightness.

Note that a backlight update requesting brightness 0 before any non-zero
one now really does turn the module off wherever MOD_EN was already set,
where before it was silently ignored.

wled->brightness is seeded with default-brightness rather than the level
the bootloader actually programmed, so the first update can still step
the brightness. Reading that level back is version specific and is done
in a follow-up, to keep this fix small enough to backport.

Assisted-by: LLM
Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection logic")
Cc: stable@vger.kernel.org
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/video/backlight/qcom-wled.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index f452d328997ad..3ce3bade3b8dd 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -1622,54 +1622,49 @@ static int wled_configure_short_irq(struct wled *wled,
 
 	return rc;
 }
 
 static int wled_configure_ovp_irq(struct wled *wled,
 				  struct platform_device *pdev)
 {
 	int rc;
-	u32 val;
 
 	wled->ovp_irq = platform_get_irq_byname(pdev, "ovp");
 	if (wled->ovp_irq < 0) {
 		dev_dbg(&pdev->dev, "OVP IRQ not found - disabling automatic string detection\n");
 		return 0;
 	}
 
 	rc = devm_request_threaded_irq(wled->dev, wled->ovp_irq, NULL,
 				       wled_ovp_irq_handler, IRQF_ONESHOT,
 				       "wled_ovp_irq", wled);
 	if (rc < 0) {
 		wled->ovp_irq = 0;
 		return 0;
 	}
 
-	rc = regmap_read(wled->regmap, wled->ctrl_addr +
-			 WLED3_CTRL_REG_MOD_EN, &val);
-	if (rc < 0)
-		return rc;
-
-	/* Keep OVP irq disabled until module is enabled */
-	if (!(val & WLED3_CTRL_REG_MOD_EN_MASK))
+	/* Keep the OVP irq disabled until the module is enabled */
+	if (!wled->brightness)
 		disable_irq(wled->ovp_irq);
 
 	return 0;
 }
 
 static const struct backlight_ops wled_ops = {
 	.update_status = wled_update_status,
 };
 
 static int wled_probe(struct platform_device *pdev)
 {
 	struct backlight_properties props;
 	struct backlight_device *bl;
 	struct wled *wled;
 	struct regmap *regmap;
+	u32 mod_en;
 	u32 val;
 	int rc;
 
 	regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!regmap) {
 		dev_err(&pdev->dev, "Unable to get regmap\n");
 		return -EINVAL;
 	}
@@ -1730,27 +1725,42 @@ static int wled_probe(struct platform_device *pdev)
 
 	default:
 		dev_err(wled->dev, "Invalid WLED version\n");
 		break;
 	}
 
 	INIT_DELAYED_WORK(&wled->ovp_work, wled_ovp_work);
 
+	val = WLED_DEFAULT_BRIGHTNESS;
+	of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);
+
+	/*
+	 * The module may already be enabled, either by a bootloader that left
+	 * the backlight lit or by the setup above. Record that, so that the
+	 * first brightness update does not enable an already enabled module,
+	 * and so that the OVP irq is armed from probe rather than from that
+	 * first update.
+	 */
+	rc = regmap_read(wled->regmap, wled->ctrl_addr + WLED3_CTRL_REG_MOD_EN,
+			 &mod_en);
+	if (rc < 0)
+		return rc;
+
+	if (mod_en & WLED3_CTRL_REG_MOD_EN_MASK)
+		wled->brightness = val;
+
 	rc = wled_configure_short_irq(wled, pdev);
 	if (rc < 0)
 		return rc;
 
 	rc = wled_configure_ovp_irq(wled, pdev);
 	if (rc < 0)
 		return rc;
 
-	val = WLED_DEFAULT_BRIGHTNESS;
-	of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);
-
 	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.brightness = val;
 	props.max_brightness = wled->max_brightness;
 	bl = devm_backlight_device_register(&pdev->dev, wled->name,
 					    &pdev->dev, wled,
 					    &wled_ops, &props);
 	return PTR_ERR_OR_ZERO(bl);

-- 
2.55.0


