Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E379330BB94
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 02:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785205563; cv=none; b=VzQ1XTJ72kzF5Wi3TZulBiPAfnY0Gl5Uh8BRTGgobWeb4I5mKcEO6PqVOWS7ykNiPqvRdOc37rD2td0vTZMismxFB20gXZNlKvtvNFOJEnqUL1dlGlDjdWgY6RBP4F3BAglBlgqzr0+zGlAHBNKJNM1TZpFUuewZ8maTXvotD5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785205563; c=relaxed/simple;
	bh=iiBoxLLX/4EAT/TsycamMSrUdnUuBuhNAMod1gyN+9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PBeP+xqJs0PB9L8hLsz1OabF+4WdtN2CFYVl8hyWuo+5ahrQqRhMEgj+6eNgg8DXhKawWUNAOwmE5FcVGNxY+Q7qFi0RsLR5TcI7m9vFk7pKdOqLEcJv4VGbplNbl5BJsuonYLapuvImaHshvgnqTB/laBJ6i+suaWchKWQXVac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=jijpTMjG; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="jijpTMjG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=+YI72XepuQWEjpXlK++pOCRx+zLrqeeAxz
	uXrsj7O0w=; b=jijpTMjGKWry8jUhbNnEjtHQD/WVqMNLg8rhAx8CPIODU/Z1D/
	pOg/s0Vu5Aq15JxrW6WKzOGNIo0vRMO87KqSlM1l1aT5CKJ3Jnbvc2p1Zr7QvUZE
	4QZAC4xaXXTfTSAHh9ZTaFt+qcfAYoQ8yhqmWyC72qyXBq9IA//lJoedA=
Received: from leopard.. (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDXEEJEE2hqrpQVAA--.17640S2;
	Tue, 28 Jul 2026 10:26:12 +0800 (CST)
From: Xincheng Zhang <zhangxincheng@ultrarisc.com>
To: stable@vger.kernel.org
Cc: Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.15.y] usb: xhci-pci: Limit VIA VL805 DMA addressing to 36 bits
Date: Tue, 28 Jul 2026 10:25:14 +0800
Message-Id: <20260728022514.1501006-1-zhangxincheng@ultrarisc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026072719-striving-fanning-5f1f@gregkh>
References: <2026072719-striving-fanning-5f1f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDXEEJEE2hqrpQVAA--.17640S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAryDXF47CrW8Xr4DJw43ZFb_yoWrXF45pF
	W5Xa1UCrs3tF4Sv3WDCa1kAa4rJ3Z3JF98KFy7K34a939xAFy5WFn7C3WfAFnrWwn3Xr1a
	qr1kW3y5WayfKaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkF14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE-syl42xK
	82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
	C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
	MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
	IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdEfOUUUUU=
X-CM-SenderInfo: x2kd0wp0lquxxhqjq3powut2xlvfhudrp/1tbiAQALDGpZptAABQAZsf

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

Cc: stable@kernel.org
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
index 9c7491ac28f2..f8988f110dcf 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -338,6 +338,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == PCI_DEVICE_ID_VIA_VL805) {
 		xhci->quirks |= XHCI_LPM_SUPPORT;
 		xhci->quirks |= XHCI_TRB_OVERFETCH;
+		xhci->dma_mask_bits = 36;
 	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 0ac438392545..823fe397bfb1 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5398,6 +5398,7 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 	if (xhci->hci_version > 0x100)
 		xhci->hcc_params2 = readl(&xhci->cap_regs->hcc_params2);
 
+	xhci->dma_mask_bits = 64;
 	/* xhci-plat or xhci-pci might have set max_interrupters already */
 	if ((!xhci->max_interrupters) ||
 	    xhci->max_interrupters > HCS_MAX_INTRS(xhci->hcs_params1))
@@ -5438,12 +5439,16 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
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
index ac33baa2b0f8..96519c446778 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1544,6 +1544,7 @@ struct xhci_hcd {
 	int		event_ring_max;
 	/* 4KB min, 128MB max */
 	int		page_size;
+	unsigned int	dma_mask_bits;
 	/* Valid values are 12 to 20, inclusive */
 	int		page_shift;
 	/* msi-x vectors */
-- 
2.34.1

