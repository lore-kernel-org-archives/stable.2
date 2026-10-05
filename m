Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB4D4734EB
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195270; cv=none; b=Lp5TYyBkDdP1if+pNPWmwKQjQNvDXVaxfH25SCEcYKBJMbUGMO+8qPUEl1Jzx9BMAxAlLSE9+mSo9Owlh4WjHW50freVFD/9aG+YmkbAoSP4sh3jHZxJ5404FnoaIz2LBAymiGu4Y4RVYEX4DYgfXSO6ZS2CYJrYhmdl4JbHziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195270; c=relaxed/simple;
	bh=gWDYNzXEee4hIJbSRF9MWxRyyJGO5+swkKNvnN4LtzE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o9zf/e88QKZ8Pt/rvZDTgmYqhQVgEF6TarYX+XVibmE+aHtRMil10mXLyQ4ZNeuPj5A+7x/dpv8seYpC20C8oRUvsyyeCWXJGUoioahGARruaN7KhYhENmOr2fvOgnteumcTJvbX+tHLwekzGZUFbihMvjKvmVRhVOE0My31rqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SGTdQ3Oq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SGTdQ3Oq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC0B1F000FF;
	Mon,  5 Oct 2026 10:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791195269;
	bh=q/C7UmI8r/SM4U+TkGlG5XxVrHiMMTDQJ2gpESnXLHs=;
	h=Subject:To:Cc:From:Date;
	b=SGTdQ3Oqnsuw7UhcihcmA6v6D0pbiKJJDV66JRSmyMq4r2KGfE+hIVlEkVfpshga3
	 RSWyt72BnlcifseEG7eN/1UHtWrgBfl3tNnfc7GN4noghbzg/PsQ8bQZRHN2fX2s0r
	 P73/50JeFq1EfBd36VK9WsI4Y33vogx58eKM56+o=
Subject: FAILED: patch "[PATCH] serial: 8250_omap: fix wake irq cleared during suspend" failed to apply to 5.10-stable tree
To: k-willis@ti.com,gregkh@linuxfoundation.org,tony.lindgren@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:14:17 +0200
Message-ID: <2026100517-skyward-cadillac-c983@gregkh>
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
git cherry-pick -x 73f3e6ca7a6a7c952977c7c94f1c6dddebcafa34
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100517-skyward-cadillac-c983@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

