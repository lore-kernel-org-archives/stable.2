Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA6F46C831
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195264; cv=none; b=upAZ+B4wSNUdx/x9AhCMRAHzgUEouPAWtT0AUaFqbpfoX+3P/NtHtXayGLAni8/EhZYUSeTileVZzBkjEhdIJbxHyPAulK8zlsHytGHxha41VUaEpqzffdQ+r/8QzEpXQ5MTd+Lkz0uQuYYoAKkC28j+GgJwg+VTmyoy3eOJ3xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195264; c=relaxed/simple;
	bh=xronnEzIHqJvoUxqP2LMzcwS5n/JfQiB+BsE/wKNpKA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZlOrQGnk4XmXH6IGxPWCAy0u5/I2Ba2xBs1ItEgsVrf1mtYWuvr5mcAwwQiLv5qig4V3T3sXWz94wgctVwMhMggmpGmXUNH91FJ5Y5FudJ6Umc0HwgoYkujejZVsvMJsHeBal4pWcIPAmhSEIjQLHNO6Un3RrR+PR/CrBPttmM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gb6C2oqq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gb6C2oqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9816E1F000FF;
	Mon,  5 Oct 2026 10:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791195263;
	bh=TRrFDH96SLt/ddLRPl0NTMm6UK6+4wdFCAvDgL3zDLI=;
	h=Subject:To:Cc:From:Date;
	b=Gb6C2oqq1d3ttk+N7kgli9dFk7lk0BwIorMIG1Qbr7I85HSmXgnESUgWcBLsZmJhS
	 GOZUemNLzqvIFASFyrGPGPEPiZZtNO4n1w2b3mDSqsZtN8v59W+N43bPsIgj+blh8F
	 aJEmP7sjE02N/Ip7jnDmSlidKIHvegqZdWsfdLIM=
Subject: FAILED: patch "[PATCH] serial: 8250_omap: fix wake irq cleared during suspend" failed to apply to 6.1-stable tree
To: k-willis@ti.com,gregkh@linuxfoundation.org,tony.lindgren@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:14:15 +0200
Message-ID: <2026100515-elderly-distance-26c5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 73f3e6ca7a6a7c952977c7c94f1c6dddebcafa34
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100515-elderly-distance-26c5@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

