Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D611C28E
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203439; cv=none; b=uQw5h14PYCVxjEOAJVTTys61cbtKyudzanTwNL8w6twB7HCYPGzwpoioO92BaCIiX1FS/ewy2Lr3Nw+tGLXkLrJjvEVYmZ3d/ALRKc4Cl4uiWc5Nq/enj+W8y31ll1Xbj52JAXFJlxcnGCdIH+R+yPOJEA0AIxHHSlJ9cEGtEis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203439; c=relaxed/simple;
	bh=9QXIuK5nXrnwP1HU4n6lFW5hRwA1KHrWWZyoaE/cjYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OTv705aD9DOQiYXkqW2GCLSvAr4p69Wn0XPW2q0tlPBDkxxKboqesa5WCWZLj8Uc1ANxNhbz09YK1ZvL0Dv36KPE03d3bwMryebaJbg4lT9z09eSAhlH8IHG24eNbbvRET7MOw6yVXr+Q6adN0LT5Kr8NGZZ9/f2HpVbYCWAE/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=ROXrrkJl; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="ROXrrkJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=xgRzRyjuQ1LDZanjrvArWoKTUMcNpWXnnD
	mYqwE6Q2w=; b=ROXrrkJloXoyCjv6NfsJLZJVYVuQpmWiFKh2zDO+hNrlMq7bVU
	+9NGphjfAFiu3bbK2poPAiLXwn406cYz4jfc/KuBjnf2h9s3r4BtybVi7aciKvtq
	BrUxUNl/o+XiVzjRbdl/kXsrsRmJzjyvyjHJ+5rsdI5jzAFi4gSIkVLN4=
Received: from leopard.. (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnYUICC2hqQZQVAA--.17587S2;
	Tue, 28 Jul 2026 09:50:58 +0800 (CST)
From: Xincheng Zhang <zhangxincheng@ultrarisc.com>
To: stable@vger.kernel.org
Cc: Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10.y] usb: xhci-pci: Limit VIA VL805 DMA addressing to 36 bits
Date: Tue, 28 Jul 2026 09:50:00 +0800
Message-Id: <20260728015000.1460189-1-zhangxincheng@ultrarisc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026072720-wing-whenever-9821@gregkh>
References: <2026072720-wing-whenever-9821@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAnYUICC2hqQZQVAA--.17587S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAryDXF47CrW8Xr4fZFW8Zwb_yoWrGryUpF
	45Xa1UCrs3tF4Sv3Z7Ca1kJa4rJwn3AF98KFyxK3sI9rWayry5WF1xCa4rA3ZrXw4fXr1Y
	qr1vgrW5GFWftaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkY14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r1j6r
	4UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
	AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUb4v3UUUUUU==
X-CM-SenderInfo: x2kd0wp0lquxxhqjq3powut2xlvfhudrp/1tbiAQALDGpZptAABQAWsQ

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
(cherry picked from commit 1fc50f1ecde39feb4fccdaf4bc71aa6c0eb25c49)
---
 drivers/usb/host/xhci-pci.c |  1 +
 drivers/usb/host/xhci.c     | 15 ++++++++++-----
 drivers/usb/host/xhci.h     |  1 +
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 2be84d5e9261..6e87f36afb49 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -302,6 +302,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_LPM_SUPPORT;
 		xhci->quirks |= XHCI_TRB_OVERFETCH;
 		xhci->quirks |= XHCI_EP_CTX_BROKEN_DCS;
+		xhci->dma_mask_bits = 36;
 	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 03de77fbe3af..2cc27dba08e2 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5323,6 +5323,7 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 	if (xhci->hci_version > 0x100)
 		xhci->hcc_params2 = readl(&xhci->cap_regs->hcc_params2);
 
+	xhci->dma_mask_bits = 64;
 	xhci->quirks |= quirks;
 
 	get_quirks(dev, xhci);
@@ -5358,12 +5359,16 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 	if (xhci->quirks & XHCI_NO_64BIT_SUPPORT)
 		xhci->hcc_params &= ~BIT(0);
 
-	/* Set dma_mask and coherent_dma_mask to 64-bits,
-	 * if xHC supports 64-bit addressing */
+	/*
+	 * Set dma_mask and coherent_dma_mask to 64-bits if xHC supports
+	 * 64-bit addressing, unless a controller-specific quirk callback
+	 * limits the usable address width.
+	 */
 	if (HCC_64BIT_ADDR(xhci->hcc_params) &&
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
index 4d4ac8ec614b..8d1c6c59e9e9 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1782,6 +1782,7 @@ struct xhci_hcd {
 	int		event_ring_max;
 	/* 4KB min, 128MB max */
 	int		page_size;
+	unsigned int	dma_mask_bits;
 	/* Valid values are 12 to 20, inclusive */
 	int		page_shift;
 	/* msi-x vectors */
-- 
2.34.1

