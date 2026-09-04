Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEC733D6FA
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530427; cv=none; b=Xx87xbp5sPZIz8QXZcPHfosLrxbCWGQbcCGJlwe+6zURPSDxXdmMRiR6/HKAXRiL1XGXGG6jd9l4UrFDQzfpwe8hTQbcQICDl5LA7fumRvrtaHt8ZQl+V70dvFW92yY0A631RnzDkGx7rDq9TKM1eGgieb7J4gjk5IsYntMHkDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530427; c=relaxed/simple;
	bh=6HgbG2OHvaTDzbHC9OTraNwmOxIf8D6xfkHkWGic0+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvE890/GXbkiXg0cj0M00pj4QWNT7pItreOc4kcON4ujiheLsUrhexlN45ZKIOJD3uXTFyRKtH6X3ijDBmNNJ58yLDVyqBkWyami/tC5VdwqrnU7SvTFlrkRr5h+4DvSjgz23faJeaRNvTYTOtziLet9iLlk9AorEz73GwAvi60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6/nZx67; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6/nZx67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B321F00A3F;
	Fri,  4 Sep 2026 14:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788530425;
	bh=FhN81oNWEHIRMLbwMF862nOBBGpzb2CuoAfeoucWN+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d6/nZx67Dm+hF72cL+7ECi30t905bgo7hrH3IxssYpVn1tUD6g2rJEX9EMl5AwKWQ
	 b9Umgin8wR8PGqMgrnpXN9DAQSRBOFC7VpLKqUVm+p5WCKro7rrVUVHQnOEwBvgagz
	 G9w7hFEKnOArMRAuLy1lVLatvTbb1CSJbY/CxfuAZAhrvNuStuNC74EpsSdAq6a5np
	 uK5fBHNGXJwsAkT1vinF6wOl7+xgNaJpPJZd1BhUbR/2FiuEpjJhS1t5Y1nsj0mJDK
	 K70oFBePGrWiAoNUUs0QPiDInhHwOa1qgjyKB0NVZUZl+8tbd9Y3AkKzsptPm32+Uc
	 zWhJRx9GPOKWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] usb: gadget: at91_udc: drain polled-VBUS timer/work before udc is freed
Date: Fri,  4 Sep 2026 10:00:22 -0400
Message-ID: <20260904140022.656875-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904140022.656875-1-sashal@kernel.org>
References: <2026090319-deranged-stage-7532@gregkh>
 <20260904140022.656875-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit c27d13ce4bab80fbdf6523928071b6c24b37606c ]

In polled-VBUS mode (board.vbus_pin && board.vbus_polled), probe arms a
self-restarting cycle: at91_vbus_timer() schedules vbus_timer_work, and
at91_vbus_timer_work() calls at91_vbus_update() and re-arms the timer via
mod_timer(). Both recover the same udc through container_of and dereference
it on every iteration.

Neither teardown path cancels this cycle. udc is devm-allocated, so it is
freed after at91udc_remove() returns, and is likewise freed when probe
fails and devres runs. A timer callback or work item that is pending or
running at either point dereferences the freed udc.

Add at91_udc_shutdown_vbus_timer() and call it from at91udc_remove() and
from the usb_add_gadget_udc() failure path in probe; the remaining probe
error paths fail before the timer is armed. timer_shutdown_sync() waits
for a running callback and clears timer->function, which makes the work
handler's mod_timer() a permanent no-op; cancel_work_sync() then drains
any pending or running work whose re-arm attempt now does nothing. The
timer must be shut down first, since cancelling the work alone would let
the timer re-queue it. The guard mirrors probe: in IRQ mode the timer and
work_struct are never initialized.

This does not require a fault; a normal driver unbind can interleave with
an already queued work item.

This issue was found by an in-house static analysis tool.

Fixes: 4037242c4f5f ("ARM: 6209/3: at91_udc: Add vbus polarity and polling mode")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260719042839.3167094-1-fanwu01@zju.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/at91_udc.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
index c2637bb5a65ae..dfd320eb86732 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -1803,6 +1803,19 @@ static void at91udc_of_init(struct at91_udc *udc, struct device_node *np)
 		udc->caps = match->data;
 }
 
+/*
+ * The work handler re-arms this timer, so shut the timer down before
+ * draining the work; otherwise it restarts the polling cycle.
+ */
+static void at91_udc_shutdown_vbus_timer(struct at91_udc *udc)
+{
+	if (!(udc->board.vbus_pin && udc->board.vbus_polled))
+		return;
+
+	timer_shutdown_sync(&udc->vbus_timer);
+	cancel_work_sync(&udc->vbus_timer_work);
+}
+
 static int at91udc_probe(struct platform_device *pdev)
 {
 	struct device	*dev = &pdev->dev;
@@ -1924,7 +1937,7 @@ static int at91udc_probe(struct platform_device *pdev)
 	}
 	retval = usb_add_gadget_udc(dev, &udc->gadget);
 	if (retval)
-		goto err_unprepare_iclk;
+		goto err_shutdown_vbus;
 	dev_set_drvdata(dev, udc);
 	device_init_wakeup(dev, 1);
 	create_debug_file(udc);
@@ -1932,6 +1945,8 @@ static int at91udc_probe(struct platform_device *pdev)
 	INFO("%s version %s\n", driver_name, DRIVER_VERSION);
 	return 0;
 
+err_shutdown_vbus:
+	at91_udc_shutdown_vbus_timer(udc);
 err_unprepare_iclk:
 	clk_unprepare(udc->iclk);
 err_unprepare_fclk:
@@ -1950,6 +1965,9 @@ static void at91udc_remove(struct platform_device *pdev)
 	DBG("remove\n");
 
 	usb_del_gadget_udc(&udc->gadget);
+
+	at91_udc_shutdown_vbus_timer(udc);
+
 	if (udc->driver) {
 		dev_err(&pdev->dev,
 			"Driver still in use but removing anyhow\n");
-- 
2.53.0

