Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57118521207
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572489; cv=none; b=KO4qwVIx7RcQ4287StUf/cWavCBPWkiQpZH/N+XdoLSdrlvw8bDY4vK2bA8QofjF3XoS3LUSJu3q2rV6UDfT+dsITfSXrf5tk34v+KwmzucKwI6TCuPBOer8cR2dVKK5zzjwt9C02iRUoniTkuP0nQ7Rn2y5/0eMpj4UoCrEVEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572489; c=relaxed/simple;
	bh=8WWQ4dPrY59Rm6iKO19jD4EgLh7sjZfWZETZZ5p3+Ko=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ejhViwV69UKzirwMNenDEdbs4J9NZSNW2pqfyV1+SIizCWZuQ3txsXIgcdkYOtju6IBPfNSzdP7RzRHQGf+Z2PRnHkXqQDkj/AYX0X7tnY6UMv2sOwJMC606uCb7yuA0DAtL2BhQBPKWAAEj+nUnuP665X14Q1eSzM95uor1+24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ebYnLyNB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ebYnLyNB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1621F0089B;
	Wed, 16 Sep 2026 15:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789572483;
	bh=Yx0KJZ+2QN/GzNRsWYdj3W4GsGiF+HKqBLf9fBvV+Uk=;
	h=Subject:To:Cc:From:Date;
	b=ebYnLyNBRCiuWCIfW7btUaEvOUlg3WMNR2aNSbhRTRWo6AHw8gE8BF/Op0HYdfQr+
	 yb9o0FEhPYL5XqHhrgUBszpfXlbnd4QWKI1GQgAdAD/p5GT/Emc9PVUeVWQmhHx3rG
	 hQL6XPcZeI60FwiA49iVneG8yzrHxVAhVQJTdT1I=
Subject: FAILED: patch "[PATCH] EDAC/altera: Use parent device for devres in" failed to apply to 7.2-stable tree
To: dinguyen@kernel.org,bp@alien8.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:16:17 +0100
Message-ID: <2026091617-provoke-cupcake-11e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 9868f5c077dfe0b606331f2e782484f91a5789a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091617-provoke-cupcake-11e7@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9868f5c077dfe0b606331f2e782484f91a5789a5 Mon Sep 17 00:00:00 2001
From: Dinh Nguyen <dinguyen@kernel.org>
Date: Wed, 17 Jun 2026 11:43:03 -0500
Subject: [PATCH] EDAC/altera: Use parent device for devres in
 altr_portb_setup()

Anchor the devres group and the devm-managed IRQ requests in altr_portb_setup()
to the actual parent device (device->edac->dev) instead of the embedded struct
device inside the copied per-port altr_edac_device_dev.

This keeps devres_open_group(), devm_request_irq(), devres_remove_group() and
devres_release_group() all referring to the same long-lived device so the
group and the resources allocated inside it are torn down together.

Fixes: 911049845d70 ("EDAC, altera: Add Arria10 SD-MMC EDAC support")
Closes: https://sashiko.dev/#/patchset/20260503212558.2811480-1-dbgh9129%40gmail.com
Assisted-by: LLM
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260617164303.585555-1-dinguyen@kernel.org

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 1d1e2b5ca14c..68846f583eee 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1534,7 +1534,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	altdev = dci->pvt_info;
 	*altdev = *device;
 
-	if (!devres_open_group(&altdev->ddev, altr_portb_setup, GFP_KERNEL))
+	if (!devres_open_group(device->edac->dev, altr_portb_setup, GFP_KERNEL))
 		return -ENOMEM;
 
 	/* Update PortB specific values */
@@ -1562,7 +1562,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 		rc = -ENODEV;
 		goto err_release_group_1;
 	}
-	rc = devm_request_irq(&altdev->ddev, altdev->sb_irq,
+	rc = devm_request_irq(device->edac->dev, altdev->sb_irq,
 			      prv->ecc_irq_handler, IRQF_TRIGGER_HIGH,
 			      ecc_name, altdev);
 	if (rc) {
@@ -1584,7 +1584,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 			rc = -ENODEV;
 			goto err_release_group_1;
 		}
-		rc = devm_request_irq(&altdev->ddev, altdev->db_irq,
+		rc = devm_request_irq(device->edac->dev, altdev->db_irq,
 				      prv->ecc_irq_handler, IRQF_TRIGGER_HIGH,
 				      ecc_name, altdev);
 		if (rc) {
@@ -1604,13 +1604,13 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 
 	list_add(&altdev->next, &altdev->edac->a10_ecc_devices);
 
-	devres_remove_group(&altdev->ddev, altr_portb_setup);
+	devres_remove_group(device->edac->dev, altr_portb_setup);
 
 	return 0;
 
 err_release_group_1:
 	edac_device_free_ctl_info(dci);
-	devres_release_group(&altdev->ddev, altr_portb_setup);
+	devres_release_group(device->edac->dev, altr_portb_setup);
 	edac_printk(KERN_ERR, EDAC_DEVICE,
 		    "%s:Error setting up EDAC device: %d\n", ecc_name, rc);
 	return rc;

