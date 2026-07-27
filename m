Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6B1417D72
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159167; cv=none; b=hvrgThxVxeC5bFyTVLUNirf/3mZLNglVf8NWlpQFASYIifObMmy12S83knpUHcVZAby8FRM+OY0AlsWCZJz8Y7srlLYN+DKM6BoqWGpTnr2hEYtzXf7+7rQzPUgZKUKditKeHVDwDRvT4Xvv4RxEIgvcjTaCPT3hvwfVPZ9AdYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159167; c=relaxed/simple;
	bh=tpxMHSMPANC5ohoaePB+ORlrNfikXL4BmtQFbz28dm4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sZRn7TsXze2LxIJ0u2hg339OWMJzrRUggFgb8YsQxE/bLLMM7JuI+p7lJxV6tl4fUCKPnYLdBYj0uzqUjc5uzQBjoel8jDyqh0hUNin71eSTs7EDgugkETRZUbJ9CQVYuM5/HmJnCxv7XmjLUH02VAoL0PlLJlUhKeEZF3IVOuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1WTGSCzb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1WTGSCzb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DBD1F000E9;
	Mon, 27 Jul 2026 13:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785159164;
	bh=9FEMLiNsFDg96G1DB2IP2lRZYrlVN+Z68TQYfNbQZCU=;
	h=Subject:To:Cc:From:Date;
	b=1WTGSCzbsTcSr36/vTBHaQM7XiddPgHL7Nw05F5cPhUiLTH7SfTEPxF9pABXvhmDB
	 nxCi33hBspZF5Vc6GVQR6OtEA6Qm3Dt4noxodW662HN7vbBmjhVxZmz/6kAV7khkQw
	 iEqq1JP47tZBlG9h0KcZPXdCbNLs+2YK1nLhZXyM=
Subject: FAILED: patch "[PATCH] usb: xhci-pci: Limit VIA VL805 DMA addressing to 36 bits" failed to apply to 6.1-stable tree
To: zhangxincheng@ultrarisc.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Jul 2026 15:32:19 +0200
Message-ID: <2026072719-vividly-saddling-1550@gregkh>
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
git cherry-pick -x 1fc50f1ecde39feb4fccdaf4bc71aa6c0eb25c49
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072719-vividly-saddling-1550@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1fc50f1ecde39feb4fccdaf4bc71aa6c0eb25c49 Mon Sep 17 00:00:00 2001
From: Xincheng Zhang <zhangxincheng@ultrarisc.com>
Date: Tue, 30 Jun 2026 09:26:48 +0800
Subject: [PATCH] usb: xhci-pci: Limit VIA VL805 DMA addressing to 36 bits

The VIA VL805/806 xHCI controller advertises AC64, but fails to handle
DMA addresses at or above 0x1000000000. On systems with large amounts of
RAM, this can cause USB device failures when the controller is given DMA
addresses beyond its usable address width.

Do not use XHCI_NO_64BIT_SUPPORT for this controller. That quirk clears
the cached AC64 capability and limits DMA to 32 bits, causing unnecessary
bouncing for addresses between 4GiB and 64GiB and hiding the controller's
real AC64 capability from code that may need to distinguish register
access width from usable DMA address width.

Track the usable DMA address width separately from the AC64 capability.
Initialize the generic xhci->dma_mask_bits field to 64 and let PCI quirks
reduce it for controllers with narrower DMA support. Set VIA VL805/806 to
36 bits so the DMA API only hands it addresses in the range it can handle
while keeping HCCPARAMS1.AC64 visible.

Cc: stable <stable@kernel.org>
Signed-off-by: Xincheng Zhang <zhangxincheng@ultrarisc.com>
Link: https://patch.msgid.link/20260630-xhci-via-dma-fix-v3-1-690dcb8cf75a@ultrarisc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 039c26b241d0..6b3fcba44b08 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -448,6 +448,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == PCI_DEVICE_ID_VIA_VL805) {
 		xhci->quirks |= XHCI_LPM_SUPPORT;
 		xhci->quirks |= XHCI_TRB_OVERFETCH;
+		xhci->dma_mask_bits = 36;
 	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index f44ccee5fa07..091c82ca8ee2 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5466,6 +5466,7 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 	if (xhci->hci_version > 0x100)
 		xhci->hcc_params2 = readl(&xhci->cap_regs->hcc_params2);
 
+	xhci->dma_mask_bits = 64;
 	xhci->max_slots = min(HCS_MAX_SLOTS(hcs_params1), MAX_HC_SLOTS);
 	xhci->max_ports = min(HCS_MAX_PORTS(hcs_params1), MAX_HC_PORTS);
 	/* xhci-plat or xhci-pci might have set max_interrupters already */
@@ -5515,12 +5516,16 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 	if (xhci->quirks & XHCI_NO_64BIT_SUPPORT)
 		xhci->hcc_params &= ~BIT(0);
 
-	/* Set dma_mask and coherent_dma_mask to 64-bits,
-	 * if xHC supports 64-bit addressing */
+	/*
+	 * Set dma_mask and coherent_dma_mask to 64-bits if xHC supports
+	 * 64-bit addressing, unless a controller-specific quirk callback
+	 * limits the usable address width.
+	 */
 	if ((xhci->hcc_params & HCC_64BIT_ADDR) &&
-			!dma_set_mask(dev, DMA_BIT_MASK(64))) {
-		xhci_dbg(xhci, "Enabling 64-bit DMA addresses.\n");
-		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
+	    !dma_set_mask(dev, DMA_BIT_MASK(xhci->dma_mask_bits))) {
+		xhci_dbg(xhci, "Enabling %u-bit DMA addresses.\n",
+			 xhci->dma_mask_bits);
+		dma_set_coherent_mask(dev, DMA_BIT_MASK(xhci->dma_mask_bits));
 	} else {
 		/*
 		 * This is to avoid error in cases where a 32-bit USB
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index d02046a573e4..2d3941b5e1e3 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1526,6 +1526,7 @@ struct xhci_hcd {
 	/* imod_interval in ns (I * 250ns) */
 	u32		imod_interval;
 	u32		page_size;
+	unsigned int	dma_mask_bits;
 	/* MSI-X/MSI vectors */
 	int		nvecs;
 	/* optional clocks */

