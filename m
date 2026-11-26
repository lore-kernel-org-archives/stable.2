Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710119;
	b=E1rXBbAa/ZdKI3qoBGDVoQucCkSznUdau/nRlENnQR/01qb4INBLkDxOmti2h8XBMDm8
	 LijxAfl5dbt6wDS4TZ9FtnmPtkNW9vk+PiY+Wy69Mhk5MHyp0tY7sxhO8x3D5BDp6yhZT
	 SQIW/ZMeK6K/KJKNZuemoq532AjzXPf/h0WU1qWR+p2uETHmMmvkK3xI7hkvjxtqx55kQ
	 ovgRlklNbWeVilorQfMdgi9jlt1su63MBOAaqiX3xwU3c0bnLv2nu5xZ9wF/VJqWBjbJg
	 Yr2vFLC3qSWPmaFnEEl/teCdGbwYIyKHwGK65HOZlW8edcrUpBIsm62U0T/YufobaZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710119;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=U2KE+Ehmx4DBSoGEbxJ81KlrqYhu5NtAKHmejrYocmc=;
	b=HHzJEf2AwWEV+v+WAz70EieHnYgwUoeJhCKAPlojVujv6QneRJf2UFYDdsv23KE7C0ni
	 Ibj4KBfvOaUX86pstEbzfu2LQ6W+WJGtqWBApk6F3DUSiwLEBb3PaBBBwrGHy16JiWY+j
	 1ezC8o4J2HG340TJFOknpERX2UMT0KwJH5eBP0npaFRtzEYPmriCnTqvsW+Peyp1iu0c9
	 ly0C5iFLmCL7w4CrmfH7eeFQ9X29CQJ5qYxTrR6K+etlcNTUANIHl/0rVo2vzen/pA6iz
	 bRkaKIhOTJO8b/EVQ7GxK34x0n6y0WucAVwHM4KGqlxMF+4i26N/ySaqXq8hve/tRBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LRLhl2WF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C84606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LRLhl2WF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF001F000C0;
	Thu, 26 Nov 2026 16:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795710119;
	bh=U2KE+Ehmx4DBSoGEbxJ81KlrqYhu5NtAKHmejrYocmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LRLhl2WFPs8EsVbzutkVHLK+uw8yZIToSxkqNukNgfhnNVsUdvM+jr91BFN9U6APX
	 LJejbY7s65OpBx4Ou3bBzGjFTR1W47MeQl2h/fI+T/lyTH32pZ3pK7xmkLFfnZt8xq
	 bITS8518Y/ESxW5S1dVuWDhe+mFOFdilgHD+bY/vNIsebXAlHYY/TwikqQk5O9NB8t
	 wz8AkhfonY/CHbnJArnOSx+NfgorCtB8at4sSsVhv75pPXf2YowcY7t33FW0WFPVZe
	 glNEUtpjjzEvtcyo2lZgBX6iBTcsIVkjWMZKRQsPv9SETU11RZMrap1fKV7rYaCbkF
	 FwA1BDv3oq6Eg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yiyu Zhou <yiyu@yiyuzhou.io>,
	stable <stable@kernel.org>,
	Dennis Wissel <dennis@dsine.de>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] xhci: give back TDs and clean up ep0 after disconnect
Date: Thu, 26 Nov 2026 11:21:56 -0500
Message-ID: <20261126162118.2536749-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126162118.2536749-1-sashal@kernel.org>
References: <2026112543-handcraft-impolite-2d69@gregkh>
 <20261126162118.2536749-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yiyu Zhou <yiyu@yiyuzhou.io>

[ Upstream commit 6895dbdc19d927a2872bd4f111e1911874d5dce4 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 73 ++++++++++++++++++++++++++++++------
 drivers/usb/host/xhci.c      | 13 ++++---
 2 files changed, 69 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index aedb2af01e2f7..2a8585581aa8a 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -65,6 +65,7 @@
 static int queue_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
 			 u32 field1, u32 field2,
 			 u32 field3, u32 field4, bool command_must_succeed);
+static void xhci_kill_endpoint_urbs(struct xhci_hcd *xhci, int slot_id, int ep_index);
 
 /*
  * Returns zero if the TRB isn't in this segment, otherwise it returns the DMA
@@ -955,6 +956,24 @@ static void xhci_giveback_invalidated_tds(struct xhci_hcd *xhci, struct xhci_vir
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
@@ -986,25 +1005,53 @@ static int xhci_handle_halted_endpoint(struct xhci_hcd *xhci,
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
+		}
+	}
+
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
 		}
+		/* hard-reset a halted disconnected ep0 */
+		xhci_dbg(xhci, "Reset and clean up ep0 slot %u after disconnect\n",
+			 slot_id);
+		reset_type = EP_HARD_RESET;
 	}
 
 	if (ep->ep_state & EP_HALTED) {
@@ -1013,6 +1060,9 @@ static int xhci_handle_halted_endpoint(struct xhci_hcd *xhci,
 		return 0;
 	}
 
+	if (reset_type == EP_HARD_RESET)
+		ep->ep_state |= EP_HARD_CLEAR_TOGGLE;
+
 	err = xhci_reset_halted_ep(xhci, slot_id, ep->ep_index, reset_type);
 	if (err)
 		return err;
@@ -1063,8 +1113,9 @@ static int xhci_invalidate_cancelled_tds(struct xhci_hcd *xhci, struct xhci_virt
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
index d6dc696b385ac..c5000b82b1078 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1666,12 +1666,6 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
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
@@ -1681,6 +1675,13 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 
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
-- 
2.53.0

