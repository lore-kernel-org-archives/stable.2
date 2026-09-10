Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65794BFE97
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044997; cv=none; b=qsXFaa0t6IVSzOkh6Fkm7qdCqLJw5eG+um90qzHh95h1rbj6BWGuBSwPMACoaJHSnLMUGqZdBkDQqqXo9LNtlMRh9tVifHkJ9ZCi74G+aOTnlBRsrQIfc959bajmLR4LXjWLi+XfYnYpuUbSwAzkZzlLlZu6kcDhhlLnlaT6LPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044997; c=relaxed/simple;
	bh=skErG3q+7M6oW1WjM4IPUcXI4v0MyjQf1C+S0QBTSZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gdr3dgUbfCA9mmsmcU0fG8lAs8T+zRIwgQFLTym27Wgd8yjrbSrNA+qnhsebM02RYLR7ogmCXHV3YznosTaa9J192TQlXlyuAeDq00iv+1e6VdDMqG20lJtx8umv4+HVL/kxCsFezVZnUX+8DH81rHwE7B2dX/9jm8n3AHbi+6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i489a3UC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i489a3UC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1A61F00899;
	Thu, 10 Sep 2026 12:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789044995;
	bh=AJVxclbscvRHnnpsmzMBe4bkNaSnsj0LnXGlIeL7lfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i489a3UCBDmIuVCCPdXJy+IIfE2hBJS6Ae2OK5Uq/3X1cL0wiJNSkJrAwHe66AYjw
	 c/8nesYcMgd+hiOYFN+9iRu3qow2jXCD6p0MNxEUMbYKrawMWitDhIs6A7EcHxegID
	 hHkdQi3uG21FU/m7dZPJlEeBviMe/e3dsiMleGWewpt/jOY5hyalovHcfx11Cbbtmm
	 ju9lmfe6tpNe0Mw4E6tfwMYWdZrITokMsIhYBJsQ/tFCvYvxjEDQjPFtAtDLbeAQ41
	 mM1G7VS7ErPg+L8Noauvkteg4e8hdMTYd4BsGZpwDvWgq62ZJM7I1EZSMtPLCJxuVo
	 Ob8OJ+OfNdRyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] usb: xhci: simplify TDs start and end naming scheme in struct 'xhci_td'
Date: Thu, 10 Sep 2026 08:56:30 -0400
Message-ID: <20260910125631.195223-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910125631.195223-1-sashal@kernel.org>
References: <2026090813-undocked-untwist-c0a8@gregkh>
 <20260910125631.195223-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niklas Neronin <niklas.neronin@linux.intel.com>

[ Upstream commit 39b52aae23f54b6bc3649a50c27ca1058d2c2a86 ]

Old names:
 * start_seg - last_trb_seg
 * first_trb - last_trb

New names:
 * start_seg - end_seg
 * start_trb - end_trb

A Transfer Descriptor (TD) in the xhci driver is a data structure that
represents a single transaction to be performed by the USB host controller.
This transaction is defined by TRBs from 'start_trb' in 'start_seg' to
'end_trb' in 'end_seg'.

The terms "start" and "end" were chosen  over "first" and "last" for ease
of searching within the codebase. The ring structure uses 'first_seg' and
'last_seg', while the TD structure uses 'start_seg' and 'end_seg'.

Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20241106101459.775897-24-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Stable adaptation for 6.1:

Keep the existing trb_in_td() interface, TRB free-space accounting, and
transfer-event flow. Apply the member renames to all users in this tree,
including cancellation and mid-TD error handling paths that differ from
upstream, without importing the intervening refactors.

Also make the existing xhci_td_cleanup() return void to match the context
required by target ff44dfb03a293bf30e31f98772a1dd316a6071d1. It previously
returned only zero; preserve that result explicitly in finish_td() and
skip_isoc_td(). No functions are added.

Stable-dep-of: ff44dfb03a29 ("xhci: fix lost bounce buffers on TDs spanning several ring segments")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 92 ++++++++++++++++++------------------
 drivers/usb/host/xhci.c      |  2 +-
 drivers/usb/host/xhci.h      |  6 +--
 3 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 9f9a2a68953a5..c3c005c4da2d2 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -634,8 +634,8 @@ static int xhci_move_dequeue_past_td(struct xhci_hcd *xhci,
 
 	/*
 	 * We want to find the pointer, segment and cycle state of the new trb
-	 * (the one after current TD's last_trb). We know the cycle state at
-	 * hw_dequeue, so walk the ring until both hw_dequeue and last_trb are
+	 * (the one after current TD's end_trb). We know the cycle state at
+	 * hw_dequeue, so walk the ring until both hw_dequeue and end_trb are
 	 * found.
 	 */
 	do {
@@ -645,7 +645,7 @@ static int xhci_move_dequeue_past_td(struct xhci_hcd *xhci,
 			if (td_last_trb_found)
 				break;
 		}
-		if (new_deq == td->last_trb)
+		if (new_deq == td->end_trb)
 			td_last_trb_found = true;
 
 		if (cycle_found && trb_is_link(new_deq) &&
@@ -720,16 +720,16 @@ static void td_to_noop(struct xhci_hcd *xhci, struct xhci_ring *ep_ring,
 		       struct xhci_td *td, bool flip_cycle)
 {
 	struct xhci_segment *seg	= td->start_seg;
-	union xhci_trb *trb		= td->first_trb;
+	union xhci_trb *trb		= td->start_trb;
 
 	while (1) {
 		trb_to_noop(trb, TRB_TR_NOOP);
 
 		/* flip cycle if asked to */
-		if (flip_cycle && trb != td->first_trb && trb != td->last_trb)
+		if (flip_cycle && trb != td->start_trb && trb != td->end_trb)
 			trb->generic.field[3] ^= cpu_to_le32(TRB_CYCLE);
 
-		if (trb == td->last_trb)
+		if (trb == td->end_trb)
 			break;
 
 		next_trb(&seg, &trb);
@@ -802,8 +802,8 @@ static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
 	seg->bounce_offs = 0;
 }
 
-static int xhci_td_cleanup(struct xhci_hcd *xhci, struct xhci_td *td,
-			   struct xhci_ring *ep_ring, int status)
+static void xhci_td_cleanup(struct xhci_hcd *xhci, struct xhci_td *td,
+			    struct xhci_ring *ep_ring, int status)
 {
 	struct urb *urb = NULL;
 
@@ -846,8 +846,6 @@ static int xhci_td_cleanup(struct xhci_hcd *xhci, struct xhci_td *td,
 			status = 0;
 		xhci_giveback_urb_in_irq(xhci, td, status);
 	}
-
-	return 0;
 }
 
 
@@ -973,7 +971,7 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
 		xhci_dbg_trace(xhci, trace_xhci_dbg_cancel_urb,
 			       "Removing canceled TD starting at 0x%llx (dma) in stream %u URB %p",
 			       (unsigned long long)xhci_trb_virt_to_dma(
-				       td->start_seg, td->first_trb),
+				       td->start_seg, td->start_trb),
 			       td->urb->stream_id, td->urb);
 		list_del_init(&td->td_list);
 		ring = xhci_urb_to_transfer_ring(xhci, td->urb);
@@ -993,7 +991,7 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
 		hw_deq &= ~0xf;
 
 		if (td->cancel_status == TD_HALTED ||
-		    trb_in_td(xhci, td->start_seg, td->first_trb, td->last_trb, hw_deq, false)) {
+		    trb_in_td(xhci, td->start_seg, td->start_trb, td->end_trb, hw_deq, false)) {
 			switch (td->cancel_status) {
 			case TD_CLEARED: /* TD is already no-op */
 			case TD_CLEARING_CACHE: /* set TR deq command already queued */
@@ -1083,8 +1081,8 @@ static struct xhci_td *find_halted_td(struct xhci_virt_ep *ep)
 		hw_deq = xhci_get_hw_deq(ep->xhci, ep->vdev, ep->ep_index, 0);
 		hw_deq &= ~0xf;
 		td = list_first_entry(&ep->ring->td_list, struct xhci_td, td_list);
-		if (trb_in_td(ep->xhci, td->start_seg, td->first_trb,
-				td->last_trb, hw_deq, false))
+		if (trb_in_td(ep->xhci, td->start_seg, td->start_trb,
+				td->end_trb, hw_deq, false))
 			return td;
 	}
 	return NULL;
@@ -2342,7 +2340,7 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 			    !list_empty(&td->cancelled_td_list)) {
 				xhci_dbg(xhci, "Already resolving halted ep for 0x%llx\n",
 					 (unsigned long long)xhci_trb_virt_to_dma(
-						 td->start_seg, td->first_trb));
+						 td->start_seg, td->start_trb));
 				return 0;
 			}
 			/* endpoint not halted, don't reset it */
@@ -2377,24 +2375,25 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 
 	/* Update ring dequeue pointer */
 	trbs_freed = xhci_num_trbs_to(ep_ring->deq_seg, ep_ring->dequeue,
-				      td->last_trb_seg, td->last_trb,
+				      td->end_seg, td->end_trb,
 				      ep_ring->num_segs);
 	if (trbs_freed < 0)
 		xhci_dbg(xhci, "Failed to count freed trbs at TD finish\n");
 	else
 		ep_ring->num_trbs_free += trbs_freed;
-	ep_ring->dequeue = td->last_trb;
-	ep_ring->deq_seg = td->last_trb_seg;
+	ep_ring->dequeue = td->end_trb;
+	ep_ring->deq_seg = td->end_seg;
 	inc_deq(xhci, ep_ring);
 
-	return xhci_td_cleanup(xhci, td, ep_ring, td->status);
+	xhci_td_cleanup(xhci, td, ep_ring, td->status);
+	return 0;
 }
 
 /* sum trb lengths from the first trb up to stop_trb, _excluding_ stop_trb */
 static u32 sum_trb_lengths(struct xhci_td *td, union xhci_trb *stop_trb)
 {
 	u32 sum;
-	union xhci_trb *trb = td->first_trb;
+	union xhci_trb *trb = td->start_trb;
 	struct xhci_segment *seg = td->start_seg;
 
 	for (sum = 0; trb != stop_trb; next_trb(&seg, &trb)) {
@@ -2551,7 +2550,7 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		fallthrough;
 	case COMP_ISOCH_BUFFER_OVERRUN:
 		frame->status = -EOVERFLOW;
-		if (ep_trb != td->last_trb)
+		if (ep_trb != td->end_trb)
 			td->error_mid_td = true;
 		break;
 	case COMP_INCOMPATIBLE_DEVICE_ERROR:
@@ -2561,7 +2560,7 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	case COMP_USB_TRANSACTION_ERROR:
 		frame->status = -EPROTO;
 		sum_trbs_for_length = true;
-		if (ep_trb != td->last_trb)
+		if (ep_trb != td->end_trb)
 			td->error_mid_td = true;
 		break;
 	case COMP_STOPPED:
@@ -2595,7 +2594,7 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 
 finish_td:
 	/* Don't give back TD yet if we encountered an error mid TD */
-	if (td->error_mid_td && ep_trb != td->last_trb) {
+	if (td->error_mid_td && ep_trb != td->end_trb) {
 		xhci_dbg(xhci, "Error mid isoc TD, wait for final completion event\n");
 		td->urb_length_set = true;
 		return 0;
@@ -2622,12 +2621,13 @@ static int skip_isoc_td(struct xhci_hcd *xhci, struct xhci_td *td,
 	frame->actual_length = 0;
 
 	/* Update ring dequeue pointer */
-	ep->ring->dequeue = td->last_trb;
-	ep->ring->deq_seg = td->last_trb_seg;
+	ep->ring->dequeue = td->end_trb;
+	ep->ring->deq_seg = td->end_seg;
 	ep->ring->num_trbs_free += td->num_trbs - 1;
 	inc_deq(xhci, ep->ring);
 
-	return xhci_td_cleanup(xhci, td, ep->ring, status);
+	xhci_td_cleanup(xhci, td, ep->ring, status);
+	return 0;
 }
 
 /*
@@ -2651,7 +2651,7 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	case COMP_SUCCESS:
 		ep->err_count = 0;
 		/* handle success with untransferred data as short packet */
-		if (ep_trb != td->last_trb || remaining) {
+		if (ep_trb != td->end_trb || remaining) {
 			xhci_warn(xhci, "WARN Successful completion on short TX\n");
 			xhci_dbg(xhci, "ep %#x - asked for %d bytes, %d bytes untransferred\n",
 				 td->urb->ep->desc.bEndpointAddress,
@@ -2688,7 +2688,7 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		break;
 	}
 
-	if (ep_trb == td->last_trb)
+	if (ep_trb == td->end_trb)
 		td->urb->actual_length = requested - remaining;
 	else
 		td->urb->actual_length =
@@ -2969,7 +2969,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 
 		/* Is this a TRB in the currently executing TD? */
 		ep_seg = trb_in_td(xhci, ep_ring->deq_seg, ep_ring->dequeue,
-				td->last_trb, ep_trb_dma, false);
+				td->end_trb, ep_trb_dma, false);
 
 		/*
 		 * Skip the Force Stopped Event. The event_trb(event_dma) of FSE
@@ -3016,13 +3016,13 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 			    !list_is_last(&td->td_list, &ep_ring->td_list)) {
 				struct xhci_td *td_next = list_next_entry(td, td_list);
 
-				ep_seg = trb_in_td(xhci, td_next->start_seg, td_next->first_trb,
-						   td_next->last_trb, ep_trb_dma, false);
+				ep_seg = trb_in_td(xhci, td_next->start_seg, td_next->start_trb,
+						   td_next->end_trb, ep_trb_dma, false);
 				if (ep_seg) {
 					/* give back previous TD, start handling new */
 					xhci_dbg(xhci, "Missing TD completion event after mid TD error\n");
-					ep_ring->dequeue = td->last_trb;
-					ep_ring->deq_seg = td->last_trb_seg;
+					ep_ring->dequeue = td->end_trb;
+					ep_ring->deq_seg = td->end_seg;
 					inc_deq(xhci, ep_ring);
 					xhci_td_cleanup(xhci, td, ep_ring, td->status);
 					td = td_next;
@@ -3037,7 +3037,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 					"comp_code %u\n", ep_index,
 					trb_comp_code);
 				trb_in_td(xhci, ep_ring->deq_seg,
-					  ep_ring->dequeue, td->last_trb,
+					  ep_ring->dequeue, td->end_trb,
 					  ep_trb_dma, true);
 				return -ESHUTDOWN;
 			}
@@ -3496,7 +3496,7 @@ static int prepare_transfer(struct xhci_hcd *xhci,
 	/* Add this TD to the tail of the endpoint ring's TD list */
 	list_add_tail(&td->td_list, &ep_ring->td_list);
 	td->start_seg = ep_ring->enq_seg;
-	td->first_trb = ep_ring->enqueue;
+	td->start_trb = ep_ring->enqueue;
 
 	return 0;
 }
@@ -3836,8 +3836,8 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 			field &= ~TRB_CHAIN;
 			field |= TRB_IOC;
 			more_trbs_coming = false;
-			td->last_trb = ring->enqueue;
-			td->last_trb_seg = ring->enq_seg;
+			td->end_trb = ring->enqueue;
+			td->end_seg = ring->enq_seg;
 			if (xhci_urb_suitable_for_idt(urb)) {
 				memcpy(&send_addr, urb->transfer_buffer,
 				       trb_buff_len);
@@ -3886,8 +3886,8 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 		ret = prepare_transfer(xhci, xhci->devs[slot_id],
 				       ep_index, urb->stream_id,
 				       1, urb, 1, mem_flags);
-		urb_priv->td[1].last_trb = ring->enqueue;
-		urb_priv->td[1].last_trb_seg = ring->enq_seg;
+		urb_priv->td[1].end_trb = ring->enqueue;
+		urb_priv->td[1].end_seg = ring->enq_seg;
 		field = TRB_TYPE(TRB_NORMAL) | ring->cycle_state | TRB_IOC;
 		queue_trb(xhci, ring, 0, 0, 0, TRB_INTR_TARGET(0), field);
 		urb_priv->td[1].num_trbs++;
@@ -4013,8 +4013,8 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 	}
 
 	/* Save the DMA address of the last TRB in the TD */
-	td->last_trb = ep_ring->enqueue;
-	td->last_trb_seg = ep_ring->enq_seg;
+	td->end_trb = ep_ring->enqueue;
+	td->end_seg = ep_ring->enq_seg;
 
 	/* Queue status TRB - see Table 7 and sections 4.11.2.2 and 6.4.1.2.3 */
 	/* If the device sent data, the status stage is an OUT transfer */
@@ -4301,8 +4301,8 @@ static int xhci_queue_isoc_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 				field |= TRB_CHAIN;
 			} else {
 				more_trbs_coming = false;
-				td->last_trb = ep_ring->enqueue;
-				td->last_trb_seg = ep_ring->enq_seg;
+				td->end_trb = ep_ring->enqueue;
+				td->end_seg = ep_ring->enq_seg;
 				field |= TRB_IOC;
 				if (trb_block_event_intr(xhci, num_tds, i))
 					field |= TRB_BEI;
@@ -4368,14 +4368,14 @@ static int xhci_queue_isoc_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 	/* Use the first TD as a temporary variable to turn the TDs we've queued
 	 * into No-ops with a software-owned cycle bit. That way the hardware
 	 * won't accidentally start executing bogus TDs when we partially
-	 * overwrite them.  td->first_trb and td->start_seg are already set.
+	 * overwrite them.  td->start_trb and td->start_seg are already set.
 	 */
-	urb_priv->td[0].last_trb = ep_ring->enqueue;
+	urb_priv->td[0].end_trb = ep_ring->enqueue;
 	/* Every TRB except the first & last will have its cycle bit flipped. */
 	td_to_noop(xhci, ep_ring, &urb_priv->td[0], true);
 
 	/* Reset the ring enqueue back to the first TRB and its cycle bit. */
-	ep_ring->enqueue = urb_priv->td[0].first_trb;
+	ep_ring->enqueue = urb_priv->td[0].start_trb;
 	ep_ring->enq_seg = urb_priv->td[0].start_seg;
 	ep_ring->cycle_state = start_cycle;
 	ep_ring->num_trbs_free = ep_ring->num_trbs_free_temp;
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 823fe397bfb10..b86d7fd2df789 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1873,7 +1873,7 @@ static int xhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 				urb->ep->desc.bEndpointAddress,
 				(unsigned long long) xhci_trb_virt_to_dma(
 					urb_priv->td[i].start_seg,
-					urb_priv->td[i].first_trb));
+					urb_priv->td[i].start_trb));
 
 	for (; i < urb_priv->num_tds; i++) {
 		td = &urb_priv->td[i];
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 96519c446778d..f06e0cbf479de 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1318,9 +1318,9 @@ struct xhci_td {
 	enum xhci_cancelled_td_status	cancel_status;
 	struct urb		*urb;
 	struct xhci_segment	*start_seg;
-	union xhci_trb		*first_trb;
-	union xhci_trb		*last_trb;
-	struct xhci_segment	*last_trb_seg;
+	union xhci_trb		*start_trb;
+	struct xhci_segment	*end_seg;
+	union xhci_trb		*end_trb;
 	struct xhci_segment	*bounce_seg;
 	/* actual_length of the URB has already been set */
 	bool			urb_length_set;
-- 
2.53.0

