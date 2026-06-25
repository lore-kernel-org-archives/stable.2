Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693C93E3D90
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782391950; cv=none; b=nhbrWKJnaEImDIoiDmEVISEP6n7PMJH2dRnFoKwjtBgwKgIPVIp1kMHtG7L/8UwG/FzvkIGHcHbECR/VohkyvW10C5/yEzMhHqDxbk3QiOsaGqw71CTQtAKdG6FZ4P+Aw98q2Foch3zydrYsfr2zZIrLTf044gdmvt6gGTlEbws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782391950; c=relaxed/simple;
	bh=I4/vLZbNIvXL0kJhYDPsH5Y/s7E8W60LYat3eRdT/LI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kXM3ap8a0Iw3aCVDa2wpOFfH3kXIr/0Mr1Guz1NPxg6levJrmxDtnP9jhKi+eIPTFIr+FdzuUWr95gNU1MEtQcvCU4a8dphnwdKWTI/rzTpcZCxpsq2J0/ICIJ9zQWDy7K3Tu3C12PaG/HbL2iyuhb2FxuDCN7buPWvO5ORFvts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JAPFC8Sm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JAPFC8Sm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6241F000E9;
	Thu, 25 Jun 2026 12:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782391949;
	bh=VDsmk2QhN5SiCZRnGhoJp0qA+kx+sdX0GNjpFXpEz28=;
	h=Subject:To:Cc:From:Date;
	b=JAPFC8SmgPpUH5HiaBFKJ8No9UQJXqw3G19yrI6A3FaOWMEaGrTsnZg1eEwN/jlDc
	 YEZfbkeQtkatzRdXyx2/uEXrPVNxboUB3/SldLWcf/5DbUt/PdAePI5KBRXbhczQl/
	 ccQoLBQWkoj3LR4KWE5wZd24B8fhvtv3HJVu2i9c=
Subject: FAILED: patch "[PATCH] serial: 8250_dw: unregister 8250 port if" failed to apply to 5.10-stable tree
To: sozdayvek@gmail.com,andriy.shevchenko@linux.intel.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jun 2026 13:46:40 +0100
Message-ID: <2026062540-preaching-monotype-3cc7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 10fc708b4de7f86002d2d735a2dbf3b5b7f65692
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026062540-preaching-monotype-3cc7@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 10fc708b4de7f86002d2d735a2dbf3b5b7f65692 Mon Sep 17 00:00:00 2001
From: Stepan Ionichev <sozdayvek@gmail.com>
Date: Thu, 14 May 2026 19:37:45 +0500
Subject: [PATCH] serial: 8250_dw: unregister 8250 port if
 clk_notifier_register() fails

dw8250_probe() registers the 8250 port via serial8250_register_8250_port()
and then, if the device has a clock, registers a clock notifier. If
clk_notifier_register() fails, probe returns the error but leaves the
8250 port registered. The matching serial8250_unregister_port() lives
in dw8250_remove(), which is not called when probe fails, so the port
slot stays occupied until the device is rebound or the system is
rebooted. The devm-allocated driver data is freed while the port still
references it (via the saved private_data and serial_in/serial_out
callbacks), so any access to that port slot before a rebind is a
use-after-free hazard.

Unregister the port on the clk_notifier_register() error path.

Fixes: cc816969d7b5 ("serial: 8250_dw: Fix common clocks usage race condition")
Cc: stable@vger.kernel.org
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20260514143746.23671-2-sozdayvek@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 55e40c10f46a..2d30a164eeae 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -839,8 +839,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	 */
 	if (data->clk) {
 		err = clk_notifier_register(data->clk, &data->clk_notifier);
-		if (err)
+		if (err) {
+			serial8250_unregister_port(data->data.line);
 			return dev_err_probe(dev, err, "Failed to set the clock notifier\n");
+		}
 		queue_work(system_dfl_wq, &data->clk_work);
 	}
 

