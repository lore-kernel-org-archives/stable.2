Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C763403EC
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440098; cv=none; b=tfTuQ5xThKwHxqSbnnLlA68pAAzd0kFqnreZgrmI5L6low3MDzGnAOhvKCTPc2p1Dybmdz5Xew61CuYJCaGJjzIzj1cj9f57uEguoSI+pACjND57EcSGcMFvIIX+WHsTY2r+2bq5hArqXYeV7zgUiwVkoIzXq/QkPoE77/HJ/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440098; c=relaxed/simple;
	bh=AanMtR6VohgUZZP6jgepCe3lQNFM2uBSRN2c8hW3VIo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h+ya5r1IHMuypV+QUf2gxaP88r/PpdgYO9yEQ5PUBugzGw8C78KFnXwirdjF3BJRmjfpzS/WOZa67yycJqFenRbPE4HqrHWvoBybjGSjFoNYXaTJ3ZhOpoDxHowiwM+wYkQXBQhsptTzpjuX62lW9pOdxDa9mgzXa4pob9jEVME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xee11Z8/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xee11Z8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620E41F000E9;
	Thu,  3 Sep 2026 12:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788440096;
	bh=5fo4rUmo+jHRkdKrxNKMQygyJpSvE70ZUGV3h76HgAk=;
	h=Subject:To:Cc:From:Date;
	b=xee11Z8/HhqzJwjadHr3jws/E1cSmM4GKmIYt7eB2O2UB7l0C95zB5OsmpuSHvjBM
	 a9m/u4Ht03ydmmluMIZYVF7Y+QuvNI90iZYcIDPKw02vW0Dutm6Zidjhx0pNqRGNgC
	 MIhiZMUj4n1+b6PhAqHCtxoXiGtu4e1jnk8tz5zM=
Subject: FAILED: patch "[PATCH] usb: gadget: at91_udc: drain polled-VBUS timer/work before" failed to apply to 6.6-stable tree
To: fanwu01@zju.edu.cn,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 14:39:18 +0200
Message-ID: <2026090318-vixen-overarch-9359@gregkh>
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
git cherry-pick -x c27d13ce4bab80fbdf6523928071b6c24b37606c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090318-vixen-overarch-9359@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c27d13ce4bab80fbdf6523928071b6c24b37606c Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Sun, 19 Jul 2026 04:28:39 +0000
Subject: [PATCH] usb: gadget: at91_udc: drain polled-VBUS timer/work before
 udc is freed

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

diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
index 5aa360ba4f03..8e5d7fb71549 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -1794,6 +1794,19 @@ static void at91udc_of_init(struct at91_udc *udc, struct device_node *np)
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
@@ -1907,7 +1920,7 @@ static int at91udc_probe(struct platform_device *pdev)
 	}
 	retval = usb_add_gadget_udc(dev, &udc->gadget);
 	if (retval)
-		goto err_unprepare_iclk;
+		goto err_shutdown_vbus;
 	dev_set_drvdata(dev, udc);
 	device_init_wakeup(dev, 1);
 	create_debug_file(udc);
@@ -1915,6 +1928,8 @@ static int at91udc_probe(struct platform_device *pdev)
 	INFO("%s version %s\n", driver_name, DRIVER_VERSION);
 	return 0;
 
+err_shutdown_vbus:
+	at91_udc_shutdown_vbus_timer(udc);
 err_unprepare_iclk:
 	clk_unprepare(udc->iclk);
 err_unprepare_fclk:
@@ -1933,6 +1948,9 @@ static void at91udc_remove(struct platform_device *pdev)
 	DBG("remove\n");
 
 	usb_del_gadget_udc(&udc->gadget);
+
+	at91_udc_shutdown_vbus_timer(udc);
+
 	if (udc->driver) {
 		dev_err(&pdev->dev,
 			"Driver still in use but removing anyhow\n");

