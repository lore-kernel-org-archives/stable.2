Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2733524AEA
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572510; cv=none; b=EI/UPUtMeroR68EiavLBs1FUiMkIJ9JZcbH+jJ9xdjqo8bESQVoV2K36gYIqX9BnZLPCW26b3T+V/2cPNSPR4f7Jmbs2LPOtjmZ2PRiSLz5s3zUGKldwgNr7yLBIzjSbOTaVMLcj1Ju3tK75K6a6k5nrlgyYzSolOHfuiOh5RvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572510; c=relaxed/simple;
	bh=FRB8SPJtVe/F/x1jBjatMsYBw+jid6Cf+/owHzQITVc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cwOkZ67B1wiFU4LSoIytXSOyv2cT3pZSC2igDhnyFLSkJOw2P9rO8EaVCXNTiQIdJgrXS0OGuksl72DjQHX4alojI29TV8Dw4roNjE5clAeJE3u7/8n9Px1dCXlfwhZ8K26UdTh7rOsjhsoaUdRL9yWeesivXpYpn44ln6ghiuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1s4BylrV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1s4BylrV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAC01F000FF;
	Wed, 16 Sep 2026 15:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789572502;
	bh=JQNuUu9QoKMt2IFKfP3fRBdcV7Kl2qi3uUEs7uLQXiw=;
	h=Subject:To:Cc:From:Date;
	b=1s4BylrVodmzso00pRMlgc2Py/iFEJ6tp+XOxEvuDNgSRyT8dr/ZLychMoKftZJDH
	 nsvRh1HNkjDgLWQ7SZLeeyNceTIRHpD2J0WmZ2RweorNtyDKrw1EegAqKYnrgPTdh9
	 mjgzm4ash12MKkcKWHrRBv9wM8qMG2gRcpVbaWIM=
Subject: FAILED: patch "[PATCH] EDAC/altera: Use parent device for devres in" failed to apply to 5.10-stable tree
To: dinguyen@kernel.org,bp@alien8.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:16:24 +0100
Message-ID: <2026091624-rethink-safeness-e66f@gregkh>
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
git cherry-pick -x 9868f5c077dfe0b606331f2e782484f91a5789a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091624-rethink-safeness-e66f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

