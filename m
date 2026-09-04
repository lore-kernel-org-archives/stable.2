Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328EC48383F
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530937; cv=none; b=przrii3D7nYb5R+C4tMIgMhzenkXRwkT1vW8s7qiWTXylaSwcBY4TT7yObnlcnnohl2eogsSnLMd1sX9tj6bG/7FlAGty7qnp5B2H6H8cd5eWVU9ZZGDnx4Olmws3zLw8NvLFU/blZoFNw/vD0dXen9sAY6YRdRBGsJDBRdCuw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530937; c=relaxed/simple;
	bh=6HgbG2OHvaTDzbHC9OTraNwmOxIf8D6xfkHkWGic0+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJ77wkHf8Wwu1ffX/L838p8YHLKsdpp0SzQ2MrWKg8gN6WhUUWH7pP9aNS+DkWqrndTiI0o2oxy0vSmOMn1V/3wxLKNfTOVQqaTR91oMf12vElOYQrg5CnX1gEmOwdEoNwQDoBrmp3fdKaqtF1pQVQBX3EmrjU/yccfS8TRoQXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6bALGuE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6bALGuE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739261F00A3E;
	Fri,  4 Sep 2026 14:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788530935;
	bh=FhN81oNWEHIRMLbwMF862nOBBGpzb2CuoAfeoucWN+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c6bALGuEwVFUWRS72K6xZvnfeJXU8GwUYLE+vpdVpsBlG4pr3SdFYX2b80tnms+gv
	 ymmDBBEkdVmxJ14svqSVbyXAXH9eh2dYbAwcxwf6X1kC81Zyz0a1ffgUgCPGgx4TMw
	 sJFxyZFBw+K4QVIjajFQC4o3/DcUlacrAInCBxESPTwigGNmtSpiLmp/LJeIZrJKHy
	 fdl/7JnyeR0CCDmc4JQE0t0//RDnwehH4mvFkJZzoqIGmmhGD5z6XtEtlvSZoE1xFt
	 WpnQHZvnQXgHsqn9EoCo+bfAvU3Hiu4TfeffjZuXxD/o0aXHPoey2ON0iV2lcmy0tq
	 p8Wsk3SR0iYcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] usb: gadget: at91_udc: drain polled-VBUS timer/work before udc is freed
Date: Fri,  4 Sep 2026 10:08:52 -0400
Message-ID: <20260904140852.672483-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904140852.672483-1-sashal@kernel.org>
References: <2026090320-causal-nutrient-ad4a@gregkh>
 <20260904140852.672483-1-sashal@kernel.org>
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

