Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F3443A7F7
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182838; cv=none; b=H/OLUizQKerV/zcAO+1koE1vi3TVHqo7bHXoWz8KkfgxrUOjzha96znvPmUa4TGMLnfRHZSt2Gfi+u5IxdS6BCS7GmW5xCURkdAJihyaRlG2LSY39xkPiGXMasXc7UJATXg0XDzeyCtPsvaRPcEyRrOrHCWPU5Z2DGAapiFqWE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182838; c=relaxed/simple;
	bh=dzQYButpRgYwLi8BE5Qw9L5FISIKyDD4TI30yiMTi9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0FOjVVbg6nQT1A5osx5rIewBX129fFwg/h52OwlMBb3ScrCxEXDEfXIeyk7dAyUNrNRRCjhnV3xqasGMMXL2I5sm2wNUmFNPcFG0LM7UgskSg8IDES8bID2QrBmc1JtJcEtZaevWDVO0MeMefBSOqdz3WaVDlxqfNNGSecvwCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXjX0fz0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXjX0fz0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59821F00A3F;
	Mon, 31 Aug 2026 13:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788182836;
	bh=DAZ0D1wbg4LiwhrkvZkC41pgrWBdzuVg2fwCPZu3hhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NXjX0fz02B6zS189BMGYBwgxg0/HYlFA/EggsOPyB4n3ta2UBy7d+dpEx/EGIfAGp
	 /1fO+1d6qulNMabTU5+ActHTU66jA2ucI/4fk8bo4hz+blOvqeS9NGQZPonuSruKPu
	 Zc7LVrOyfAy6Rdmkyyg/Mb2yDtuyJ9eNUQzDLtMUtBfa9eriGgdq9A4MNuf5gQXHNK
	 8pqck+uZKVOEHSWLwUaUWaAfBzB3bCbuBv+vOiEzvyEkGpNjGOB2QrQY+s+m3EnMUQ
	 nQm9HvNPE5bGE7YVAaZCnhE9tnj90OAnPfeWejeyHVpAeM+Etdau9f2CQ5qDtCmmk8
	 yswiSWCeNteWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/7] usb: xhci: implement USB Port Register Set struct
Date: Mon, 31 Aug 2026 09:27:06 -0400
Message-ID: <20260831132711.4043116-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831132711.4043116-1-sashal@kernel.org>
References: <2026083120-hatchling-fade-cf8e@gregkh>
 <20260831132711.4043116-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niklas Neronin <niklas.neronin@linux.intel.com>

[ Upstream commit f2469d89a70cc6eb3d8141770995a3b251afa6ff ]

Previously, each port's 'addr' field pointed to the base of the Host
Controller USB Port Register Set, and specific registers were accessed
using macros such as (port->addr + PORTPMSC).

This patch replaces the raw '__le32 __iomem *addr' pointer with a typed
'struct xhci_port_regs __iomem *port_reg' pointer. With this change,
individual registers can be accessed directly through the structure
fields:

Before:
  port->addr
  port->addr + PORTPMSC
  port->addr + PORTLI
  port->addr + PORTHLPMC

After:
  port->port_reg->portsc
  port->port_reg->portpmsc
  port->port_reg->portli
  port->port_reg->porthlpmc

This improves code readability and makes register access more intuitive
by using named struct members instead of pointer arithmetic and macros.

Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://patch.msgid.link/20251119142417.2820519-9-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 78203d5b54a4 ("usb: xhci: bail out of setup if the controller is inaccessible")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-hub.c | 16 ++++++++--------
 drivers/usb/host/xhci-mem.c |  2 +-
 drivers/usb/host/xhci.c     | 29 ++++++++++++++---------------
 drivers/usb/host/xhci.h     |  7 +------
 4 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 2927b8a803278..c4c85312b04c8 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -683,9 +683,9 @@ static void xhci_port_set_test_mode(struct xhci_hcd *xhci,
 
 	/* xhci only supports test mode for usb2 ports */
 	port = xhci->usb2_rhub.ports[wIndex];
-	temp = readl(port->addr + PORTPMSC);
+	temp = readl(&port->port_reg->portpmsc);
 	temp |= test_mode << PORT_TEST_MODE_SHIFT;
-	writel(temp, port->addr + PORTPMSC);
+	writel(temp, &port->port_reg->portpmsc);
 	xhci->test_mode = test_mode;
 	if (test_mode == USB_TEST_FORCE_ENABLE)
 		xhci_start(xhci);
@@ -1288,7 +1288,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				retval = -EINVAL;
 				break;
 			}
-			port_li = readl(port->addr + PORTLI);
+			port_li = readl(&port->port_reg->portli);
 			status = xhci_get_ext_port_status(temp, port_li);
 			put_unaligned_le32(status, &buf[4]);
 		}
@@ -1520,18 +1520,18 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		case USB_PORT_FEAT_U1_TIMEOUT:
 			if (hcd->speed < HCD_USB3)
 				goto error;
-			temp = readl(port->addr + PORTPMSC);
+			temp = readl(&port->port_reg->portpmsc);
 			temp &= ~PORT_U1_TIMEOUT_MASK;
 			temp |= PORT_U1_TIMEOUT(timeout);
-			writel(temp, port->addr + PORTPMSC);
+			writel(temp, &port->port_reg->portpmsc);
 			break;
 		case USB_PORT_FEAT_U2_TIMEOUT:
 			if (hcd->speed < HCD_USB3)
 				goto error;
-			temp = readl(port->addr + PORTPMSC);
+			temp = readl(&port->port_reg->portpmsc);
 			temp &= ~PORT_U2_TIMEOUT_MASK;
 			temp |= PORT_U2_TIMEOUT(timeout);
-			writel(temp, port->addr + PORTPMSC);
+			writel(temp, &port->port_reg->portpmsc);
 			break;
 		case USB_PORT_FEAT_TEST:
 			/* 4.19.6 Port Test Modes (USB2 Test Mode) */
@@ -1962,7 +1962,7 @@ int xhci_bus_resume(struct usb_hcd *hcd)
 
 	/* poll for U0 link state complete, both USB2 and USB3 */
 	for_each_set_bit(port_index, &bus_state->bus_suspended, BITS_PER_LONG) {
-		sret = xhci_handshake(ports[port_index]->addr, PORT_PLC,
+		sret = xhci_handshake(&ports[port_index]->port_reg->portsc, PORT_PLC,
 				      PORT_PLC, 10 * 1000);
 		if (sret) {
 			xhci_warn(xhci, "port %d-%d resume PLC timeout\n",
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index ea3cfc229cd03..9a6a8d9f37707 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2201,7 +2201,7 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
 		return -ENOMEM;
 
 	for (i = 0; i < num_ports; i++) {
-		xhci->hw_ports[i].addr = &xhci->op_regs->port_regs[i].portsc;
+		xhci->hw_ports[i].port_reg = &xhci->op_regs->port_regs[i];
 		xhci->hw_ports[i].hw_portnum = i;
 
 		init_completion(&xhci->hw_ports[i].rexit_done);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index a4a9bac4ce095..aab2792be76da 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -44,13 +44,13 @@ MODULE_PARM_DESC(quirks, "Bit flags for quirks to be enabled as default");
 void xhci_portsc_writel(struct xhci_port *port, u32 val)
 {
 	trace_xhci_portsc_writel(port, val);
-	writel(val, port->addr);
+	writel(val, &port->port_reg->portsc);
 }
 EXPORT_SYMBOL_GPL(xhci_portsc_writel);
 
 u32 xhci_portsc_readl(struct xhci_port *port)
 {
-	return readl(port->addr);
+	return readl(&port->port_reg->portsc);
 }
 EXPORT_SYMBOL_GPL(xhci_portsc_readl);
 
@@ -4667,7 +4667,7 @@ static int xhci_set_usb2_hardware_lpm(struct usb_hcd *hcd,
 {
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	struct xhci_port **ports;
-	__le32 __iomem	*pm_addr, *hlpm_addr;
+	struct xhci_port_regs __iomem *port_reg;
 	u32		pm_val, hlpm_val, field;
 	unsigned int	port_num;
 	unsigned long	flags;
@@ -4692,9 +4692,8 @@ static int xhci_set_usb2_hardware_lpm(struct usb_hcd *hcd,
 
 	ports = xhci->usb2_rhub.ports;
 	port_num = udev->portnum - 1;
-	pm_addr = ports[port_num]->addr + PORTPMSC;
-	pm_val = readl(pm_addr);
-	hlpm_addr = ports[port_num]->addr + PORTHLPMC;
+	port_reg = ports[port_num]->port_reg;
+	pm_val = readl(&port_reg->portpmsc);
 
 	xhci_dbg(xhci, "%s port %d USB2 hardware LPM\n",
 		 str_enable_disable(enable), port_num + 1);
@@ -4723,30 +4722,30 @@ static int xhci_set_usb2_hardware_lpm(struct usb_hcd *hcd,
 			spin_lock_irqsave(&xhci->lock, flags);
 
 			hlpm_val = xhci_calculate_usb2_hw_lpm_params(udev);
-			writel(hlpm_val, hlpm_addr);
+			writel(hlpm_val, &port_reg->porthlmpc);
 			/* flush write */
-			readl(hlpm_addr);
+			readl(&port_reg->porthlmpc);
 		} else {
 			hird = xhci_calculate_hird_besl(xhci, udev);
 		}
 
 		pm_val &= ~PORT_HIRD_MASK;
 		pm_val |= PORT_HIRD(hird) | PORT_RWE | PORT_L1DS(udev->slot_id);
-		writel(pm_val, pm_addr);
-		pm_val = readl(pm_addr);
+		writel(pm_val, &port_reg->portpmsc);
+		pm_val = readl(&port_reg->portpmsc);
 		pm_val |= PORT_HLE;
-		writel(pm_val, pm_addr);
+		writel(pm_val, &port_reg->portpmsc);
 		/* flush write */
-		readl(pm_addr);
+		readl(&port_reg->portpmsc);
 	} else {
 		pm_val &= ~(PORT_HLE | PORT_RWE | PORT_HIRD_MASK | PORT_L1DS_MASK);
-		writel(pm_val, pm_addr);
+		writel(pm_val, &port_reg->portpmsc);
 		/* flush write */
-		readl(pm_addr);
+		readl(&port_reg->portpmsc);
 		if (udev->usb2_hw_lpm_besl_capable) {
 			spin_unlock_irqrestore(&xhci->lock, flags);
 			xhci_change_max_exit_latency(xhci, udev, 0);
-			readl_poll_timeout(ports[port_num]->addr, pm_val,
+			readl_poll_timeout(&ports[port_num]->port_reg->portsc, pm_val,
 					   (pm_val & PORT_PLS_MASK) == XDEV_U0,
 					   100, 10000);
 			return 0;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 3e586d7e8eda8..13703e7fb5fc0 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -66,11 +66,6 @@ struct xhci_cap_regs {
 	/* Reserved up to (CAPLENGTH - 0x1C) */
 };
 
-#define PORTSC		0
-#define PORTPMSC	1
-#define PORTLI		2
-#define PORTHLPMC	3
-
 /*
  * struct xhci_port_regs - Host Controller USB Port Register Set. xHCI spec 5.4.8
  * @portsc:	Port Status and Control
@@ -1470,7 +1465,7 @@ struct xhci_port_cap {
 };
 
 struct xhci_port {
-	__le32 __iomem		*addr;
+	struct xhci_port_regs __iomem	*port_reg;
 	int			hw_portnum;
 	int			hcd_portnum;
 	struct xhci_hub		*rhub;
-- 
2.53.0

