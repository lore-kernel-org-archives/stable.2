Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608456;
	b=LI4Zrkc657mHn8rFsHlgDU3nGj5/qa4UiyOVGgvMQR48b6KshFxJiJd8GbyoGc0JYPdO
	 pqR4XhPpgEPPdrwa3p5k/ztp3DcoP7uSy7qZeoPUo/ejeYfu+iaVNzT7HH8iI4JOJK/kJ
	 rIaEDuVONNnzPi43uzcuopxHs4yyAmCSxtifyj6nbY7ZCtLGhpZa0byfrKFNjtrJpH4dW
	 /eb3XkM2A2kO/jqMHySsEc+MEAp43uFrk7lQpyAh/1dO7fxW6pTYBuJPW6rf9IOx5NBNt
	 ZitFNVETxx61xUZ2lLBUlIjYdXDrjF+7hcK7Vr/xmRHmM23LI7UrJoiGBF1NKxNBTTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608456;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1EeBeH0o1k4+jkE50hUy9xvrhe8xmimnZkM1wO1Zn9k=;
	b=FRIOPQlXK3tF9Si+Qn1NknsF7KhXAo4zR2ztRtalvPiizqzNG14WOTEfRFlOvp+84m0p
	 9qX5K0Ks+fLEeHMNGGe7SCOVeZjz33Y6ZFZOUxQ514RAhhreox46cXKyWURZZTZKlBQuU
	 W2mwhh8Kf4VGJVfyCWeKA8aQeuMS6AyV+37ayrP2v3q69CGvQNa0CBDA2gOS7M16T0DQU
	 S2Qo5bAH9gxapM8xBnJs59cHS0jCdIJ7Sz6H3Nvx+7CydvbUdFVY6sEPttCDFXkMReTNx
	 79K344RnnY2CM9wAYJuEVWW/+uZFlm/QOxC9tmAEeY4VuBYez3DHicHGX/oVcPu9CJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0aB3Q22e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09676606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0aB3Q22e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB531F000C4;
	Wed, 25 Nov 2026 12:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608455;
	bh=1EeBeH0o1k4+jkE50hUy9xvrhe8xmimnZkM1wO1Zn9k=;
	h=Subject:To:Cc:From:Date;
	b=0aB3Q22ergasJf4FR5X3QA4nsjopPDinyjw0Az/kII1zTosCV9ab0DA6bOdUn3Mex
	 e7pRd+OGe/GOFxrzMsKc8hgwPYMRxaq+++SNLQXWFGSYh3A0P2O2RWnJpp/tvEBbrR
	 5M5wp65447MAtRkOzG6QYFyj06jJxJ7CFnJjtSyE=
Subject: FAILED: patch "[PATCH] xhci: give back TDs and clean up ep0 after disconnect" failed to apply to 7.3-stable tree
To: yiyu@yiyuzhou.io,dennis@dsine.de,gregkh@linuxfoundation.org,mathias.nyman@linux.intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:42:43 +0100
Message-ID: <2026112543-handcraft-impolite-2d69@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 6895dbdc19d927a2872bd4f111e1911874d5dce4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112543-handcraft-impolite-2d69@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6895dbdc19d927a2872bd4f111e1911874d5dce4 Mon Sep 17 00:00:00 2001
From: Yiyu Zhou <yiyu@yiyuzhou.io>
Date: Thu, 29 Oct 2026 22:43:24 +0200
Subject: [PATCH] xhci: give back TDs and clean up ep0 after disconnect

Fix a regression in v7.3 introduced by the commits in the Fixes tags.
Those patches avoid endpoint recovery and rapid state changes after
the root port link is lost.

This caused a regression in device enumeration.

It turns out that a subset of USB HID devices briefly disconnect during
enumeration. USB core manages to resuscitate these devices without
reallocating them, and thus continue using the same udev, xhci vdev and
default control endpoint (ep0) of the device.
xhci didn't give back or clean up halted TDs behind disconnected ports
as it assumed that the disconnect cancels all URBs, and drops and frees
all endpoints.

This is not the case, so cancel and give back TDs on halted endpoint
behind disconnected ports, make sure ep0 is cleared and in a proper state
to continue working even after a link error or disconnect is detected.
Also prevent new URBs until device is reset.

One issue related to the TDs not being given back was seen on a PFU
HHKB Professional HYBRID Type-S keyboard (04fe:0021).
It drops off the bus about 300 ms after its first enumeration, while
usbhid is still probing its third interface. The probe runs in hub_wq,
so the disconnect is not handled until the probe returns.
On a root port the HID descriptor request and its four retries in
hid_get_class_descriptor() each wait for the full 5 second
USB_CTRL_GET_TIMEOUT:

  [57685.006036] usb 3-2: new full-speed USB device number 24 using xhci_hcd
  ...
  [57685.291304] hid-generic 0003:04FE:0021.0017: input,hidraw1: USB HID v1.11 Keyboard [PFU Limited HHKB-Hybrid] on usb-0000:00:14.0-2/input1
  [57711.221083] usbhid 3-2:1.2: can't add hid device: -110
  [57711.221613] usbhid 3-2:1.2: probe with driver usbhid failed with error -110
  [57711.221842] usb 3-2: USB disconnect, device number 24

[mn: merge EP_DROP_PENDING and link_inactive checks in xhci_urb_enqueue(),
 return TDs and clean up ep0 on disconnect, rewrite commit message]

Fixes: 042aad8d0db6 ("xhci: prevent endpoint recovery after roothub disconnect")
Fixes: 7e0ef4332ed9 ("xhci: avoid xHC endpoint changes after disconnect or link error.")
Cc: stable <stable@kernel.org>
Closes: https://lore.kernel.org/all/20261010071811.20483-1-yiyu@yiyuzhou.io/
Closes: https://lore.kernel.org/linux-usb/4MjB9K-2SoiA85WbI9iEig@dsine.de/
Tested-by: Yiyu Zhou <yiyu@yiyuzhou.io>
Tested-by: Dennis Wissel <dennis@dsine.de>
Signed-off-by: Yiyu Zhou <yiyu@yiyuzhou.io>
Co-developed-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://patch.msgid.link/20261029204324.658845-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index c23434001e9c..a1fa188680f5 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -65,6 +65,7 @@
 static int queue_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
 			 u32 field1, u32 field2,
 			 u32 field3, u32 field4, bool command_must_succeed);
+static void xhci_kill_endpoint_urbs(struct xhci_hcd *xhci, int slot_id, int ep_index);
 
 /*
  * Returns zero if the TRB isn't in this segment, otherwise it returns the DMA
@@ -962,6 +963,24 @@ static void xhci_giveback_invalidated_tds(struct xhci_hcd *xhci, struct xhci_vir
 	}
 }
 
+static void xhci_cancel_ring_tds(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
+				 struct xhci_ring *ring, int td_status)
+{
+	struct xhci_td *tmp_td;
+	struct xhci_td *td;
+
+	/* Add all TDs on ring to cancelled td list */
+	list_for_each_entry_safe(td, tmp_td, &ring->td_list, td_list) {
+		if (list_empty(&td->cancelled_td_list)) {
+			list_add_tail(&td->cancelled_td_list,
+				      &ep->cancelled_td_list);
+			td->cancel_status = TD_DIRTY;
+			if (!td->status)
+				td->status = td_status;
+		}
+	}
+}
+
 static int xhci_reset_halted_ep(struct xhci_hcd *xhci, unsigned int slot_id,
 				unsigned int ep_index, enum xhci_ep_reset_type reset_type)
 {
@@ -993,33 +1012,64 @@ static int xhci_handle_halted_endpoint(struct xhci_hcd *xhci,
 {
 	struct xhci_port *rhub_port = ep->vdev->rhub_port;
 	unsigned int slot_id = ep->vdev->slot_id;
+	bool disconnected = false;
+	struct xhci_ring *ring;
 	int err;
 
-	/*
-	 * Avoid resetting endpoint if link is inactive or device disconnected.
-	 * Can cause host hang.
-	 * Device will be reset to recover an inactive link, so don't do anything
-	 */
+	/* link is inactive or device disconnected */
 	if (rhub_port->link_inactive || !rhub_port->connected) {
 		ep->ep_state |= EP_DROP_PENDING;
-		return -ENODEV;
+		disconnected = true;
+		if (!td && ep->ep_index != 0) {
+			xhci_kill_endpoint_urbs(xhci, slot_id, ep->ep_index);
+			return -ENODEV;
+		}
 	}
 
-	/* add td to cancelled list and let reset ep handler take care of it */
-	if (reset_type == EP_HARD_RESET) {
-		ep->ep_state |= EP_HARD_CLEAR_TOGGLE;
+	/* Add halted td to cancelled list and let reset ep handler take care of it */
+	if (reset_type == EP_HARD_RESET || disconnected) {
 		if (td && list_empty(&td->cancelled_td_list)) {
 			list_add_tail(&td->cancelled_td_list, &ep->cancelled_td_list);
 			td->cancel_status = TD_HALTED;
+			if (disconnected && !td->status)
+				td->status = -EPROTO;
 		}
 	}
 
+	/*
+	 * Avoid resetting non-ep0 endpoints if link is inactive or device
+	 * disconnected. Can cause host hang.
+	 * Endpoints other than ep0 won't restart before the device is reset or
+	 * the endpoint is dropped, so cancel all TDs, and give back non-ep0 TDs
+	 * now instead of letting them time out. Ep0 can survive a short device
+	 * disconnect during enumeration so reset ep0 normally and clean it up.
+	 */
+	if (disconnected) {
+		ring = td ? xhci_urb_to_transfer_ring(xhci, td->urb) : ep->ring;
+		xhci_cancel_ring_tds(xhci, ep, ring, -ESHUTDOWN);
+		if (ep->ep_index != 0) {
+			xhci_dbg(xhci, "Not resetting ep %u slot %u after disconnect\n",
+				 ep->ep_index, slot_id);
+
+			xhci_process_cancelled_tds(xhci, ep);
+			xhci_kill_endpoint_urbs(xhci, slot_id, ep->ep_index);
+			return -ENODEV;
+		}
+		/* hard-reset a halted disconnected ep0 */
+		xhci_dbg(xhci, "Reset and clean up ep0 slot %u after disconnect\n",
+			 slot_id);
+		reset_type = EP_HARD_RESET;
+	}
+
 	if (ep->ep_state & EP_HALTED) {
 		xhci_dbg(xhci, "Reset ep command for ep_index %d already pending\n",
 			 ep->ep_index);
 		return 0;
 	}
 
+	if (reset_type == EP_HARD_RESET)
+		ep->ep_state |= EP_HARD_CLEAR_TOGGLE;
+
 	err = xhci_reset_halted_ep(xhci, slot_id, ep->ep_index, reset_type);
 	if (err)
 		return err;
@@ -1070,8 +1120,9 @@ static int xhci_invalidate_cancelled_tds(struct xhci_hcd *xhci, struct xhci_virt
 			continue;
 		}
 
-		/* device disconnected or link error, ep will be dropped */
-		if (ep->ep_state & EP_DROP_PENDING) {
+		/* device disconnected or link error, non-ep0 endpoints will be dropped */
+		if (ep->ep_state & EP_DROP_PENDING && ep->ep_index != 0) {
+			td_to_noop(xhci, ep, td, false);
 			td->cancel_status = TD_CLEARED;
 			continue;
 		}
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 30ac1bc4559b..b50a582be1fb 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1665,12 +1665,6 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 		goto free_priv;
 	}
 
-	if (xhci->devs[slot_id]->rhub_port->link_inactive) {
-		xhci_dbg(xhci, "Can't queue urb, port error, link inactive\n");
-		ret = -ENODEV;
-		goto free_priv;
-	}
-
 	if (xhci->xhc_state & XHCI_STATE_DYING) {
 		xhci_dbg(xhci, "Ep 0x%x: URB %p submitted for non-responsive xHCI host.\n",
 			 urb->ep->desc.bEndpointAddress, urb);
@@ -1680,6 +1674,13 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 
 	ep_state = &xhci->devs[slot_id]->eps[ep_index].ep_state;
 
+	if (xhci->devs[slot_id]->rhub_port->link_inactive ||
+	    *ep_state & EP_DROP_PENDING) {
+		xhci_dbg(xhci, "Can't queue urb, port disconnect or link inactive\n");
+		ret = -ENODEV;
+		goto free_priv;
+	}
+
 	if (*ep_state & (EP_GETTING_STREAMS | EP_GETTING_NO_STREAMS)) {
 		xhci_warn(xhci, "WARN: Can't enqueue URB, ep in streams transition state %x\n",
 			  *ep_state);

