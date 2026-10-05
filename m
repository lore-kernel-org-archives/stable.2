Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246E512CDA5
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195267; cv=none; b=lYdNUFytjz8MdM46nRFFAxTNEckRSPAWKgAWkEbQ+d2E13ytCjamdyFepUb+i1BI4FXZX6YueV/zTvYRN759fOqLDJYrkfjkeYiePLJjH+vDOZheGUFNuFMbXDK3XQDPv4o0CEMExsMdFSW8biKrGDP6F3dO6Ig+BguGWb+ML0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195267; c=relaxed/simple;
	bh=iathQQ25yWPjQcaBHjADZ9MTKxnjEYnLW16GfZxrPB4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=grLkMv4nGdrPmEMG+wXFeggIp3sGMNk0pvxDOGcaBrehESEoV5pMFD5Q8qucgF1hLGoEPO17SHxwG6pfG75OBg36LXmZJfS1XjFTup7gLYFGVxa2MldZI3oU366g4nLqsIilU13Er8fNgkTCpDJ47FQCs1QtEB9W0mkrzRteu34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1njmn0ki; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1njmn0ki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB411F000FF;
	Mon,  5 Oct 2026 10:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791195266;
	bh=HXaz4Bs0/noIUnzHVzSrSmVBJHzI5DsttPa/p1aRY1w=;
	h=Subject:To:Cc:From:Date;
	b=1njmn0kiP7BZxtzGFnimwqNiYW17R/n9fLu4vSebHNRfKGp5m8Rvg6H9Xnh60J5n7
	 eW1OB5XPA+g3WFK0Ey1XIyhE4z7HJsfHdITlGT98J9vmOfASi3V5H6xaGxLxygK5PX
	 ui5J/e6PPsBNTsImXZ4qWnitIzRqxKw+ud6/P840=
Subject: FAILED: patch "[PATCH] serial: 8250_omap: fix wake irq cleared during suspend" failed to apply to 5.15-stable tree
To: k-willis@ti.com,gregkh@linuxfoundation.org,tony.lindgren@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:14:16 +0200
Message-ID: <2026100516-relapsing-marxism-eefc@gregkh>
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
git cherry-pick -x 73f3e6ca7a6a7c952977c7c94f1c6dddebcafa34
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100516-relapsing-marxism-eefc@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 73f3e6ca7a6a7c952977c7c94f1c6dddebcafa34 Mon Sep 17 00:00:00 2001
From: Kendall Willis <k-willis@ti.com>
Date: Tue, 25 Aug 2026 17:06:07 -0500
Subject: [PATCH] serial: 8250_omap: fix wake irq cleared during suspend

The wake irq was cleared in shutdown(), which runs during the suspend
sequence, making it impossible to wake the system via UART.
Move wake irq setup to probe() and teardown to remove() so the irq
remains armed during suspend when the UART is a wakeup source.

Cc: stable@kernel.org
Fixes: 61929cf0169d ("tty: serial: Add 8250-core based omap driver")
Signed-off-by: Kendall Willis <k-willis@ti.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Link: https://patch.msgid.link/20260825-uart-wakeirq-fix-v2-1-0b9fba03d9b6@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 3c7775df27ef..ceecb39fb82d 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -711,12 +711,6 @@ static int omap_8250_startup(struct uart_port *port)
 	struct uart_8250_dma *dma = &priv->omap8250_dma;
 	int ret;
 
-	if (priv->wakeirq) {
-		ret = dev_pm_set_dedicated_wake_irq(port->dev, priv->wakeirq);
-		if (ret)
-			return ret;
-	}
-
 #ifdef CONFIG_PM
 	up->capabilities |= UART_CAP_RPM;
 #endif
@@ -787,7 +781,6 @@ static void omap_8250_shutdown(struct uart_port *port)
 	}
 
 	disable_irq_nosync(port->irq);
-	dev_pm_clear_wake_irq(port->dev);
 
 	serial8250_release_dma(up);
 	up->dma = NULL;
@@ -1588,6 +1581,12 @@ static int omap8250_probe(struct platform_device *pdev)
 
 	priv->wakeirq = irq_of_parse_and_map(np, 1);
 
+	if (priv->wakeirq) {
+		ret = dev_pm_set_dedicated_wake_irq(&pdev->dev, priv->wakeirq);
+		if (ret)
+			goto err;
+	}
+
 	ret = serial8250_register_8250_port(&up);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "unable to register 8250 port\n");
@@ -1603,6 +1602,7 @@ static int omap8250_probe(struct platform_device *pdev)
 
 	return 0;
 err:
+	dev_pm_clear_wake_irq(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	flush_work(&priv->qos_work);
@@ -1625,6 +1625,7 @@ static void omap8250_remove(struct platform_device *pdev)
 	omap_8250_shutdown(&up->port);
 	serial8250_unregister_port(priv->line);
 	priv->line = -ENODEV;
+	dev_pm_clear_wake_irq(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	flush_work(&priv->qos_work);

