Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD543785F
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182835; cv=none; b=EcdxE6NgzM+/rpccKTMjiFnYhNKJzh/fzw87MYo4xWHKxPQYjlDmARvexCR02BYZie78dDuYYnn/wX+B8CQ0O28rWhxX4nhKa3PYxkdJGrBI55RMEDxFDJZCWlCEEFub0eiFmotWtRzgbFLAljZxEWTVkiO/51iOSRTBYZKa1Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182835; c=relaxed/simple;
	bh=FiDcpZKxVduQRzdsfDkjIJvk45IGm7EFJG3a6qo6EK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kT2Zkq3blj621SoA5DiF41HZGhxe4ny9AL4oBxlSWJp9OIF3tDYADIFMVqqwHFIWkzYlF6H6Q7u3yF0Zxp7lmYt7s2NbYER3l5H97mihV840V8dpI06OtFGHXhJkQDu/pTncngJJCIiOKJBT/umh4Y/1ZzhIQy1Ht/ilUVS0syo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l11T53vq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l11T53vq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E79C1F0155A;
	Mon, 31 Aug 2026 13:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788182833;
	bh=qaV0CAF/qoRrxcNQJjfhB0ckdwtcJSZeqvb8FvyfgqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l11T53vqpYcZFXIP2VYnGNg/kfrD8A9odHbie+CkJWlSVmJDWAlF39MVtbUzOKW6k
	 HAEBD1xFZz9o6591JNnwrcx1dpKNOGeYCMe7iVOrRb0iNc77N2xkfRv0JMioBiPwAs
	 UfnheVOn9QjMEpBvcG8C9raJEGb86MUJmYBYPKkn1tYnTaqyyrqEiUlJs0iKV065OT
	 AGzVIZqlLcVG4uMTtJyZUEDHkZEyVg+33f0VWihDfe/FiL4C+C2gFOfcsLQrH6v9FV
	 RmlbHYukMOMJBIyypliLZ97zaj60yxrZGS9C9PPKkZFlrvU40lIhJx2WBuBeAplYH1
	 bFrtrqIZSCWBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/7] usb: xhci: add tracing for PORTSC register writes
Date: Mon, 31 Aug 2026 09:27:03 -0400
Message-ID: <20260831132711.4043116-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083120-hatchling-fade-cf8e@gregkh>
References: <2026083120-hatchling-fade-cf8e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niklas Neronin <niklas.neronin@linux.intel.com>

[ Upstream commit 829738e59f1fad90ef7b63d6a1a4de9d5d22544a ]

Introduce a dedicated write function for the USB Port Register Set (PORTSC)
that includes tracing capabilities for values written to the PORTSC
register. This enhancement minimizes code duplication and improves
debugging.

The PORTSC register is part of the Host Controller USB Port Register Set,
comprising 4 x 32-bit registers. As the first register, PORTSC is accessed
directly via 'port->addr'. Future commits will introduce a dedicated Port
register struct to further streamline access.
By adding the xhci_portsc_writel() function prior to these changes, we
significantly reduce the number of same line modifications required.

Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://patch.msgid.link/20251119142417.2820519-6-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 78203d5b54a4 ("usb: xhci: bail out of setup if the controller is inaccessible")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-debugfs.c |  2 +-
 drivers/usb/host/xhci-hub.c     | 33 ++++++++++++++++-----------------
 drivers/usb/host/xhci-pci.c     |  2 +-
 drivers/usb/host/xhci-trace.h   |  5 +++++
 drivers/usb/host/xhci.c         |  9 ++++++++-
 drivers/usb/host/xhci.h         |  1 +
 6 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index c6d44977193f0..df99fffc61205 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -367,7 +367,7 @@ static ssize_t xhci_port_write(struct file *file,  const char __user *ubuf,
 		portsc = xhci_port_state_to_neutral(portsc);
 		portsc &= ~PORT_PLS_MASK;
 		portsc |= PORT_LINK_STROBE | XDEV_COMP_MODE;
-		writel(portsc, port->addr);
+		xhci_portsc_writel(port, portsc);
 		spin_unlock_irqrestore(&xhci->lock, flags);
 	} else {
 		return -EINVAL;
diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 5e1442e91743d..d0300c0978039 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -570,7 +570,7 @@ static void xhci_disable_port(struct xhci_hcd *xhci, struct xhci_port *port)
 	portsc = xhci_port_state_to_neutral(portsc);
 
 	/* Write 1 to disable the port */
-	writel(portsc | PORT_PE, port->addr);
+	xhci_portsc_writel(port, portsc | PORT_PE);
 
 	portsc = readl(port->addr);
 	xhci_dbg(xhci, "disable port %d-%d, portsc: 0x%x\n",
@@ -578,7 +578,7 @@ static void xhci_disable_port(struct xhci_hcd *xhci, struct xhci_port *port)
 }
 
 static void xhci_clear_port_change_bit(struct xhci_hcd *xhci, u16 wValue,
-		u16 wIndex, __le32 __iomem *addr, u32 port_status)
+		u16 wIndex, struct xhci_port *port, u32 port_status)
 {
 	char *port_change_bit;
 	u32 status;
@@ -621,8 +621,8 @@ static void xhci_clear_port_change_bit(struct xhci_hcd *xhci, u16 wValue,
 		return;
 	}
 	/* Change bits are all write 1 to clear */
-	writel(port_status | status, addr);
-	port_status = readl(addr);
+	xhci_portsc_writel(port, port_status | status);
+	port_status = readl(port->addr);
 
 	xhci_dbg(xhci, "clear port%d %s change, portsc: 0x%x\n",
 		 wIndex + 1, port_change_bit, port_status);
@@ -659,11 +659,11 @@ static void xhci_set_port_power(struct xhci_hcd *xhci, struct xhci_port *port,
 
 	if (on) {
 		/* Power on */
-		writel(temp | PORT_POWER, port->addr);
+		xhci_portsc_writel(port, temp | PORT_POWER);
 		readl(port->addr);
 	} else {
 		/* Power off */
-		writel(temp & ~PORT_POWER, port->addr);
+		xhci_portsc_writel(port, temp & ~PORT_POWER);
 	}
 
 	spin_unlock_irqrestore(&xhci->lock, *flags);
@@ -805,7 +805,7 @@ void xhci_set_link_state(struct xhci_hcd *xhci, struct xhci_port *port,
 	temp = xhci_port_state_to_neutral(portsc);
 	temp &= ~PORT_PLS_MASK;
 	temp |= PORT_LINK_STROBE | link_state;
-	writel(temp, port->addr);
+	xhci_portsc_writel(port, temp);
 
 	xhci_dbg(xhci, "Set port %d-%d link state, portsc: 0x%x, write 0x%x",
 		 port->rhub->hcd->self.busnum, port->hcd_portnum + 1,
@@ -835,7 +835,7 @@ static void xhci_set_remote_wake_mask(struct xhci_hcd *xhci,
 	else
 		temp &= ~PORT_WKOC_E;
 
-	writel(temp, port->addr);
+	xhci_portsc_writel(port, temp);
 }
 
 /* Test and clear port RWC bit */
@@ -848,7 +848,7 @@ void xhci_test_and_clear_bit(struct xhci_hcd *xhci, struct xhci_port *port,
 	if (temp & port_bit) {
 		temp = xhci_port_state_to_neutral(temp);
 		temp |= port_bit;
-		writel(temp, port->addr);
+		xhci_portsc_writel(port, temp);
 	}
 }
 
@@ -1371,7 +1371,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				temp |= PORT_CSC | PORT_PEC | PORT_WRC |
 					PORT_OCC | PORT_RC | PORT_PLC |
 					PORT_CEC;
-				writel(temp | PORT_PE, port->addr);
+				xhci_portsc_writel(port, temp | PORT_PE);
 				temp = readl(port->addr);
 				break;
 			}
@@ -1500,7 +1500,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			break;
 		case USB_PORT_FEAT_RESET:
 			temp = (temp | PORT_RESET);
-			writel(temp, port->addr);
+			xhci_portsc_writel(port, temp);
 
 			temp = readl(port->addr);
 			xhci_dbg(xhci, "set port reset, actual port %d-%d status  = 0x%x\n",
@@ -1514,7 +1514,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			break;
 		case USB_PORT_FEAT_BH_PORT_RESET:
 			temp |= PORT_WR;
-			writel(temp, port->addr);
+			xhci_portsc_writel(port, temp);
 			temp = readl(port->addr);
 			break;
 		case USB_PORT_FEAT_U1_TIMEOUT:
@@ -1603,8 +1603,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		case USB_PORT_FEAT_C_ENABLE:
 		case USB_PORT_FEAT_C_PORT_LINK_STATE:
 		case USB_PORT_FEAT_C_PORT_CONFIG_ERROR:
-			xhci_clear_port_change_bit(xhci, wValue, wIndex,
-					port->addr, temp);
+			xhci_clear_port_change_bit(xhci, wValue, wIndex, port, temp);
 			break;
 		case USB_PORT_FEAT_ENABLE:
 			xhci_disable_port(xhci, port);
@@ -1829,7 +1828,7 @@ int xhci_bus_suspend(struct usb_hcd *hcd)
 				spin_lock_irqsave(&xhci->lock, flags);
 			}
 		}
-		writel(portsc_buf[port_index], ports[port_index]->addr);
+		xhci_portsc_writel(ports[port_index], portsc_buf[port_index]);
 	}
 	hcd->state = HC_STATE_SUSPENDED;
 	bus_state->next_statechange = jiffies + msecs_to_jiffies(10);
@@ -1863,7 +1862,7 @@ static bool xhci_port_missing_cas_quirk(struct xhci_port *port)
 	/* clear wakeup/change bits, and do a warm port reset */
 	portsc &= ~(PORT_RWC_BITS | PORT_CEC | PORT_WAKE_BITS);
 	portsc |= PORT_WR;
-	writel(portsc, port->addr);
+	xhci_portsc_writel(port, portsc);
 	/* flush write */
 	readl(port->addr);
 	return true;
@@ -1942,7 +1941,7 @@ int xhci_bus_resume(struct usb_hcd *hcd)
 			}
 		/* disable wake for all ports, write new link state if needed */
 		portsc &= ~(PORT_RWC_BITS | PORT_CEC | PORT_WAKE_BITS);
-		writel(portsc, ports[port_index]->addr);
+		xhci_portsc_writel(ports[port_index], portsc);
 	}
 
 	/* USB2 specific resume signaling delay and U0 link state transition */
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 734f7e7415835..095ca8ced86ff 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -920,7 +920,7 @@ static int xhci_pci_poweroff_late(struct usb_hcd *hcd, bool do_wakeup)
 		xhci_dbg(xhci, "port %d-%d in U3 without wakeup, disable it\n",
 			 port->rhub->hcd->self.busnum, port->hcd_portnum + 1);
 		portsc = xhci_port_state_to_neutral(portsc);
-		writel(portsc | PORT_PE, port->addr);
+		xhci_portsc_writel(port, portsc | PORT_PE);
 	}
 
 	return 0;
diff --git a/drivers/usb/host/xhci-trace.h b/drivers/usb/host/xhci-trace.h
index 9abc904f17495..481becbcbf813 100644
--- a/drivers/usb/host/xhci-trace.h
+++ b/drivers/usb/host/xhci-trace.h
@@ -575,6 +575,11 @@ DEFINE_EVENT(xhci_log_portsc, xhci_hub_status_data,
 	     TP_ARGS(port, portsc)
 );
 
+DEFINE_EVENT(xhci_log_portsc, xhci_portsc_writel,
+	     TP_PROTO(struct xhci_port *port, u32 portsc),
+	     TP_ARGS(port, portsc)
+);
+
 DECLARE_EVENT_CLASS(xhci_log_doorbell,
 	TP_PROTO(u32 slot, u32 doorbell),
 	TP_ARGS(slot, doorbell),
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 23b104c2956c7..b35f77a6307fb 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -41,6 +41,13 @@ static unsigned long long quirks;
 module_param(quirks, ullong, S_IRUGO);
 MODULE_PARM_DESC(quirks, "Bit flags for quirks to be enabled as default");
 
+void xhci_portsc_writel(struct xhci_port *port, u32 val)
+{
+	trace_xhci_portsc_writel(port, val);
+	writel(val, port->addr);
+}
+EXPORT_SYMBOL_GPL(xhci_portsc_writel);
+
 static bool td_on_ring(struct xhci_td *td, struct xhci_ring *ring)
 {
 	struct xhci_segment *seg;
@@ -909,7 +916,7 @@ static void xhci_disable_hub_port_wake(struct xhci_hcd *xhci,
 			t2 |= PORT_CSC;
 
 		if (t1 != t2) {
-			writel(t2, rhub->ports[i]->addr);
+			xhci_portsc_writel(rhub->ports[i], t2);
 			xhci_dbg(xhci, "config port %d-%d wake bits, portsc: 0x%x, write: 0x%x\n",
 				 rhub->hcd->self.busnum, i + 1, portsc, t2);
 		}
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 4cd4cb0e431d1..68e00d4a5e012 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1962,6 +1962,7 @@ void xhci_update_erst_dequeue(struct xhci_hcd *xhci,
 void xhci_add_interrupter(struct xhci_hcd *xhci, unsigned int intr_num);
 int xhci_usb_endpoint_maxp(struct usb_device *udev,
 			   struct usb_host_endpoint *host_ep);
+void xhci_portsc_writel(struct xhci_port *port, u32 val);
 
 /* xHCI roothub code */
 void xhci_set_link_state(struct xhci_hcd *xhci, struct xhci_port *port,
-- 
2.53.0

