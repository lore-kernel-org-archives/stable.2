Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871FB378D74
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411419; cv=none; b=hPOIr4ZPuqVQMJdK0X+WOQpSHLE5QKgv8TShfUnh4BtNqnokHhV4fbslIFb14xZrgoFheQEIc6zUBVUHd4LBC3o7QzcceYxMZRwP6II1tswXLgomSh0KEcefhQtDbveeYf/F+mvU4DKJ685xQ8HTI8ItugiQCPNZuQiheOc0yC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411419; c=relaxed/simple;
	bh=9aelhLhEhzCpLMbp6IpoAmA0LjnKSn2i/NZrW4g1HNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMcL+cqZt4+NqPtY/B/Q25D8S2h9Nz0DsxiS8zNFpq0Y1xFk/d4gumt3SgJV6jBwqKkJYo/jhssW07kn6COxtcZy5KPg9CvLvRgZ5p3kDvZqJS1omzuJmVqQ/z/N5JPa5TQAeHc/I8jYgfRy89C4sVGhPw8lAhRWaWIigiOrZDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpXKhrjj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpXKhrjj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE2C1F000E9;
	Sat, 18 Jul 2026 21:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784411417;
	bh=wqV+ExuVrloTw+9rtdqt0VYBVsIBrgk/zhFRmzzI1hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cpXKhrjjIhbwDyADkZMv8gldwEKb0wUL0AWZ+NWgWkPr1vCL55HxF+2l1OR+1Pu+s
	 hPa8ZCn/iG+WfnR24gAP9xypmzeCGOCPBLQwAhlSBjmEDc/+w40GG9JWmDdcuJNOUD
	 m1yXB/k+LfrfP59XsrhXy9IErear88HmMxI6qmyVrVPbh5M7l0mJQA4W+GuSrcIWZV
	 3FjEo/rjQeInHTpfvxCgmiQaD1LJ/WXsMnAN+NCZMZdw3Ox7TYyu8xfqoZG4YlpxFH
	 lfcqRZpTI0fWQNo6XGmunBZ+lO3wWrBq6+2zWLgsJ/5KtRA/AnNJIk+dSaXWiOjML1
	 TwAyNw6ZUObPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ingo Rohloff <ingo.rohloff@lauterbach.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] usb: dwc3: Support USB3340x ULPI PHY high-speed negotiation.
Date: Sat, 18 Jul 2026 17:50:14 -0400
Message-ID: <20260718215015.3447229-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071411-expose-starless-4335@gregkh>
References: <2026071411-expose-starless-4335@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ingo Rohloff <ingo.rohloff@lauterbach.com>

[ Upstream commit a28de63356575612954d4e5d5f48a2488f50e16d ]

The Microchip USB3340x ULPI PHY requires a delay when switching to the
high-speed transmitter. See:
    http://ww1.microchip.com/downloads/en/DeviceDoc/80000645A.pdf
    Module 2 "Device Enumeration Failure with Link IP Systems"

For details on the behavior and fix, refer to the AMD (formerly Xilinx)
forum post: "USB stuck in full speed mode with USB3340 ULPI PHY, ZynqMP."

This patch uses the USB PHY Vendor-ID and Product-ID to detect the
USB3340 PHY and then applies the necessary fix if this PHY is found.

Signed-off-by: Ingo Rohloff <ingo.rohloff@lauterbach.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/20260305121452.54082-2-ingo.rohloff@lauterbach.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: e0f844d9d742 ("usb: dwc3: fix dwc3_readl() and dwc3_writel() calls in dwc3_ulpi_setup()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/core.c | 20 ++++++++++++++++++++
 drivers/usb/dwc3/core.h |  4 ++++
 drivers/usb/dwc3/ulpi.c | 25 +++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a1f99c3b5f3784..6fda6adbca18ae 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -781,6 +781,24 @@ static int dwc3_hs_phy_setup(struct dwc3 *dwc, int index)
 	return 0;
 }
 
+static void dwc3_ulpi_setup(struct dwc3 *dwc)
+{
+	int index;
+	u32 reg;
+
+	/* Don't do anything if there is no ULPI PHY */
+	if (!dwc->ulpi)
+		return;
+
+	if (dwc->enable_usb2_transceiver_delay) {
+		for (index = 0; index < dwc->num_usb2_ports; index++) {
+			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(index));
+			reg |= DWC3_GUSB2PHYCFG_XCVRDLY;
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(index), reg);
+		}
+	}
+}
+
 /**
  * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
  * @dwc: Pointer to our controller context structure
@@ -1355,6 +1373,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc->ulpi_ready = true;
 	}
 
+	dwc3_ulpi_setup(dwc);
+
 	if (!dwc->phys_ready) {
 		ret = dwc3_core_get_phy(dwc);
 		if (ret)
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index a35b3db1f9f3e7..a39bf284c763f7 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -302,6 +302,7 @@
 #define DWC3_GUSB2PHYCFG_SUSPHY		BIT(6)
 #define DWC3_GUSB2PHYCFG_ULPI_UTMI	BIT(4)
 #define DWC3_GUSB2PHYCFG_ENBLSLPM	BIT(8)
+#define DWC3_GUSB2PHYCFG_XCVRDLY	BIT(9)
 #define DWC3_GUSB2PHYCFG_PHYIF(n)	(n << 3)
 #define DWC3_GUSB2PHYCFG_PHYIF_MASK	DWC3_GUSB2PHYCFG_PHYIF(1)
 #define DWC3_GUSB2PHYCFG_USBTRDTIM(n)	(n << 10)
@@ -1161,6 +1162,8 @@ struct dwc3_glue_ops {
  *	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
  * @dis_split_quirk: set to disable split boundary.
+ * @enable_usb2_transceiver_delay: Set to insert a delay before the
+ *			assertion of the TxValid signal during a HS Chirp.
  * @sys_wakeup: set if the device may do system wakeup.
  * @wakeup_configured: set if the device is configured for remote wakeup.
  * @suspended: set to track suspend event due to U3/L2.
@@ -1403,6 +1406,7 @@ struct dwc3 {
 	unsigned		dis_metastability_quirk:1;
 
 	unsigned		dis_split_quirk:1;
+	unsigned		enable_usb2_transceiver_delay:1;
 	unsigned		async_callbacks:1;
 	unsigned		sys_wakeup:1;
 	unsigned		wakeup_configured:1;
diff --git a/drivers/usb/dwc3/ulpi.c b/drivers/usb/dwc3/ulpi.c
index 57daad15f502da..a256b7f5d78b47 100644
--- a/drivers/usb/dwc3/ulpi.c
+++ b/drivers/usb/dwc3/ulpi.c
@@ -10,10 +10,13 @@
 #include <linux/delay.h>
 #include <linux/time64.h>
 #include <linux/ulpi/regs.h>
+#include <linux/ulpi/driver.h>
 
 #include "core.h"
 #include "io.h"
 
+#define USB_VENDOR_MICROCHIP 0x0424
+
 #define DWC3_ULPI_ADDR(a) \
 		((a >= ULPI_EXT_VENDOR_SPECIFIC) ? \
 		DWC3_GUSB2PHYACC_ADDR(ULPI_ACCESS_EXTENDED) | \
@@ -83,6 +86,26 @@ static const struct ulpi_ops dwc3_ulpi_ops = {
 	.write = dwc3_ulpi_write,
 };
 
+static void dwc3_ulpi_detect_config(struct dwc3 *dwc)
+{
+	struct ulpi *ulpi = dwc->ulpi;
+
+	switch (ulpi->id.vendor) {
+	case USB_VENDOR_MICROCHIP:
+		switch (ulpi->id.product) {
+		case 0x0009:
+			/* Microchip USB3340 ULPI PHY */
+			dwc->enable_usb2_transceiver_delay = true;
+			break;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+}
+
 int dwc3_ulpi_init(struct dwc3 *dwc)
 {
 	/* Register the interface */
@@ -92,6 +115,8 @@ int dwc3_ulpi_init(struct dwc3 *dwc)
 		return PTR_ERR(dwc->ulpi);
 	}
 
+	dwc3_ulpi_detect_config(dwc);
+
 	return 0;
 }
 
-- 
2.53.0

