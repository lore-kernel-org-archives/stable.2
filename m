Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D973783D1
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644093; cv=none; b=o2fZ61sc3QPDwyVpqeoqPNnfpviS8D7zb5C0c8q7eupDNizWjAMOhAWMwMN7Q5mYxAwu/veKm1EgyYl7mQ2czSOFJGQOlilQq5YMTxxdki5zeDcSJ1ZXOpyO67N/TCc0neCSJvK1rqVRabMoGpL2y/dPH1myQTVNh2j9FG0yVCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644093; c=relaxed/simple;
	bh=QMdISAhkuBTAbsNKHadP8NXmADrtJp/gPYpzTKqIQkU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Px/9GvIlp+SOxR6B8VKhLT9ZD0yfBFCMC0O8ixGgvQxyQJMGjyxeAL50u6beB7iW7UWX7z2P4vQ06la7jplqahHcWnkRMO3yyAD8B9xJmKIaVBP6gIX0VC1OQohXwgF4rI/rrNP113kNnmqk3WOHsraO+qf+CxS8+4g2yD5I/kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hu0oSYG4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hu0oSYG4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762A01F000E9;
	Tue, 21 Jul 2026 14:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784644092;
	bh=sidrSsZOCGBXID2zts+XkKChx/tYOkyH21OAd05MUa4=;
	h=Subject:To:Cc:From:Date;
	b=hu0oSYG4ZxzpXYuc9niiZt8/KT6P9zemx409nV6ekgVQdWQb1NT1MxwlVxBMqdr1N
	 +k9Td2KkwV7A4VAcPALAkjWCJH1QBP/OVHQALVoA6qYX8y5hMHTDQKNDneQ2kt9map
	 Xb6iDLhmow85cRj53fatXmVWmuRNqjp1YxlIGq4Y=
Subject: FAILED: patch "[PATCH] i3c: mipi-i3c-hci: Fix handling of shared IRQs during early" failed to apply to 6.18-stable tree
To: adrian.hunter@intel.com,Frank.Li@nxp.com,alexandre.belloni@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 16:28:02 +0200
Message-ID: <2026072102-gliding-bloated-dfaa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x c6396b835a5e599c4df656112140f065bb544a24
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072102-gliding-bloated-dfaa@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c6396b835a5e599c4df656112140f065bb544a24 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 6 Mar 2026 09:24:50 +0200
Subject: [PATCH] i3c: mipi-i3c-hci: Fix handling of shared IRQs during early
 initialization

Shared interrupts may fire unexpectedly, including during periods when the
controller is not yet fully initialized. Commit b9a15012a1452
("i3c: mipi-i3c-hci: Add optional Runtime PM support") addressed this issue
for the runtime-suspended state, but the same problem can also occur before
the bus is enabled for the first time.

Ensure the IRQ handler ignores interrupts until initialization is complete
by making consistent use of the existing irq_inactive flag.  The flag is
now set to false immediately before enabling the bus.

To guarantee correct ordering with respect to the IRQ handler, protect
all transitions of irq_inactive with the same spinlock used inside the
handler.

Fixes: b8460480f62e1 ("i3c: mipi-i3c-hci: Allow for Multi-Bus Instances")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260306072451.11131-14-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index b98952d12d7c..d5e91af7d569 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -152,6 +152,9 @@ static int i3c_hci_bus_init(struct i3c_master_controller *m)
 	if (hci->quirks & HCI_QUIRK_RESP_BUF_THLD)
 		amd_set_resp_buf_thld(hci);
 
+	scoped_guard(spinlock_irqsave, &hci->lock)
+		hci->irq_inactive = false;
+
 	/* Enable bus with Hot-Join disabled */
 	reg_set(HC_CONTROL, HC_CONTROL_BUS_ENABLE | HC_CONTROL_HOT_JOIN_CTRL);
 	dev_dbg(&hci->master.dev, "HC_CONTROL = %#x", reg_read(HC_CONTROL));
@@ -184,8 +187,9 @@ void i3c_hci_sync_irq_inactive(struct i3c_hci *hci)
 	int irq = platform_get_irq(pdev, 0);
 
 	reg_write(INTR_SIGNAL_ENABLE, 0x0);
-	hci->irq_inactive = true;
 	synchronize_irq(irq);
+	scoped_guard(spinlock_irqsave, &hci->lock)
+		hci->irq_inactive = true;
 }
 
 static void i3c_hci_bus_cleanup(struct i3c_master_controller *m)
@@ -781,10 +785,11 @@ static int i3c_hci_runtime_resume(struct device *dev)
 
 	mipi_i3c_hci_dat_v1.restore(hci);
 
-	hci->irq_inactive = false;
-
 	hci->io->resume(hci);
 
+	scoped_guard(spinlock_irqsave, &hci->lock)
+		hci->irq_inactive = false;
+
 	/* Enable bus with Hot-Join disabled */
 	reg_set(HC_CONTROL, HC_CONTROL_BUS_ENABLE | HC_CONTROL_HOT_JOIN_CTRL);
 
@@ -975,6 +980,8 @@ static int i3c_hci_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	hci->irq_inactive = true;
+
 	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(&pdev->dev, irq, i3c_hci_irq_handler,
 			       IRQF_SHARED, NULL, hci);

