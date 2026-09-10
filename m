Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C13493D55
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047780; cv=none; b=skn7eIWftfJJR6gj0YQ82mzGJUQGViYm4mKGFnqGgF7ENtX/Zb2kmF6WAaNDtlKJOn2YeYxODYVRDLxoJwZ/WZ/12IESJfU9ROQaiGDLyOpW3GDy/U62DthzYqJL6+MV6D4g0JSwqPSffrmkbiLqsymMOcM4epvYeLypQJpicTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047780; c=relaxed/simple;
	bh=dScUjNnbEkjwufUpsNCSJblcHZUzIblCPApUyRYiJsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/gu/bAmdCfdgE5urF4wUhOi26DMh/P/HLyWa8eEGjepIW5am3V3VppMiFcncKR/AezeNawhbYDx+awiSnsFqAZCSngrnGymLqhromafu4mrwhx6t9rVEIf3rlkwEtDUmeujVqFNabb3Tlp1eiYS45HEswZluoH8O7ySn5kknJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbNwGT+s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbNwGT+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18611F00898;
	Thu, 10 Sep 2026 13:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789047778;
	bh=NAfg43zzSc6yKURf6AqXzEyti4DBfTD4p1Nn8nH5REo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XbNwGT+sM9klRsqkBEv56Sz8PmyiJTXva0wMnmygIp2HF9l/fHM6uuozpH4P4m0a4
	 7bLEqu8zbU236vIp/aaeim6ODC534kHRLavpI6Potr5c7MqZN6zJLIql9uBdnW0kWJ
	 PxCpSqbxPFq79wU/BHKDyPVbTeaMQ1NoUdu59nk5qkHv1R2DGvI3z5F1fT+vvYCOrY
	 XXFZpx3IW6vYl5I3A6+XfulegcCuO0W3rSx8KxIyhmf5QkZlYwxTKPjYuPktztGGbm
	 6mcmhnQ3W8eu3/OE7s2hjuMHntvdwXQu9Ry11osXSyHkT7cuS0cyEAtBr6tEbs2+2u
	 iuUKy9C4WlxXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] usb: xhci: refactor xhci_td_cleanup() to return void
Date: Thu, 10 Sep 2026 09:42:53 -0400
Message-ID: <20260910134254.352939-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910134254.352939-1-sashal@kernel.org>
References: <2026090813-valuables-reuse-daab@gregkh>
 <20260910134254.352939-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niklas Neronin <niklas.neronin@linux.intel.com>

[ Upstream commit 7acfea2866acc6c888f880e28a249bc5ce069ad0 ]

The function is modified to return 'void' instead of an integer since it
invariably returns '0'. Additionally, multiple functions which only
return xhci_td_cleanup() are also refactored to return void.

This change eliminates the need for callers to handle a return value that
does not convey meaningful information and improve code readability, as it
becomes immediately clear that the function does not produce a significant
output.

Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20241106101459.775897-29-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[5.10 backport: keep the existing if-based halt cleanup, stream_id
arguments, last_trb/last_trb_seg fields and num_trbs_free accounting.
Convert only the six existing cleanup/completion functions and their
return statements; the newer upstream halt/cancellation paths are absent
here. This supplies the void xhci_td_cleanup() context required by
ff44dfb03a293bf30e31f98772a1dd316a6071d1 without adding functions.]

Stable-dep-of: ff44dfb03a29 ("xhci: fix lost bounce buffers on TDs spanning several ring segments")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 53 +++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 3e7664a2476db..eeb4d5de682d6 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -771,8 +771,8 @@ static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
 	seg->bounce_offs = 0;
 }
 
-static int xhci_td_cleanup(struct xhci_hcd *xhci, struct xhci_td *td,
-			   struct xhci_ring *ep_ring, int status)
+static void xhci_td_cleanup(struct xhci_hcd *xhci, struct xhci_td *td,
+			    struct xhci_ring *ep_ring, int status)
 {
 	struct urb *urb = NULL;
 
@@ -813,8 +813,6 @@ static int xhci_td_cleanup(struct xhci_hcd *xhci, struct xhci_td *td,
 			status = 0;
 		xhci_giveback_urb_in_irq(xhci, td, status);
 	}
-
-	return 0;
 }
 
 static int xhci_reset_halted_ep(struct xhci_hcd *xhci, unsigned int slot_id,
@@ -2065,9 +2063,9 @@ int xhci_is_vendor_info_code(struct xhci_hcd *xhci, unsigned int trb_comp_code)
 	return 0;
 }
 
-static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
-		     struct xhci_ring *ep_ring, struct xhci_td *td,
-		     u32 trb_comp_code)
+static void finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
+		      struct xhci_ring *ep_ring, struct xhci_td *td,
+		      u32 trb_comp_code)
 {
 	struct xhci_ep_ctx *ep_ctx;
 
@@ -2080,7 +2078,7 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		 * stopped TDs.  A stopped TD may be restarted, so don't update
 		 * the ring dequeue pointer or take this TD off any lists yet.
 		 */
-		return 0;
+		return;
 	}
 	if (trb_comp_code == COMP_STALL_ERROR ||
 		xhci_requires_manual_halt_cleanup(xhci, ep_ctx,
@@ -2108,7 +2106,7 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		inc_deq(xhci, ep_ring);
 	}
 
-	return xhci_td_cleanup(xhci, td, ep_ring, td->status);
+	xhci_td_cleanup(xhci, td, ep_ring, td->status);
 }
 
 /* sum trb lengths from the first trb up to stop_trb, _excluding_ stop_trb */
@@ -2128,9 +2126,9 @@ static u32 sum_trb_lengths(struct xhci_td *td, union xhci_trb *stop_trb)
 /*
  * Process control tds, update urb status and actual_length.
  */
-static int process_ctrl_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
-		struct xhci_ring *ep_ring,  struct xhci_td *td,
-			   union xhci_trb *ep_trb, struct xhci_transfer_event *event)
+static void process_ctrl_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
+			    struct xhci_ring *ep_ring,  struct xhci_td *td,
+			    union xhci_trb *ep_trb, struct xhci_transfer_event *event)
 {
 	struct xhci_ep_ctx *ep_ctx;
 	u32 trb_comp_code;
@@ -2210,7 +2208,7 @@ static int process_ctrl_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		td->urb_length_set = true;
 		td->urb->actual_length = requested - remaining;
 		xhci_dbg(xhci, "Waiting for status stage event\n");
-		return 0;
+		return;
 	}
 
 	/* at status stage */
@@ -2218,15 +2216,15 @@ static int process_ctrl_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		td->urb->actual_length = requested;
 
 finish_td:
-	return finish_td(xhci, ep, ep_ring, td, trb_comp_code);
+	finish_td(xhci, ep, ep_ring, td, trb_comp_code);
 }
 
 /*
  * Process isochronous tds, update urb packet status and actual_length.
  */
-static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
-		struct xhci_ring *ep_ring, struct xhci_td *td,
-		union xhci_trb *ep_trb, struct xhci_transfer_event *event)
+static void process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
+			    struct xhci_ring *ep_ring, struct xhci_td *td,
+			    union xhci_trb *ep_trb, struct xhci_transfer_event *event)
 {
 	struct urb_priv *urb_priv;
 	int idx;
@@ -2319,14 +2317,13 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	if (td->error_mid_td && ep_trb != td->last_trb) {
 		xhci_dbg(xhci, "Error mid isoc TD, wait for final completion event\n");
 		td->urb_length_set = true;
-		return 0;
+		return;
 	}
-
-	return finish_td(xhci, ep, ep_ring, td, trb_comp_code);
+	finish_td(xhci, ep, ep_ring, td, trb_comp_code);
 }
 
-static int skip_isoc_td(struct xhci_hcd *xhci, struct xhci_td *td,
-			struct xhci_virt_ep *ep, int status)
+static void skip_isoc_td(struct xhci_hcd *xhci, struct xhci_td *td,
+			 struct xhci_virt_ep *ep, int status)
 {
 	struct urb_priv *urb_priv;
 	struct usb_iso_packet_descriptor *frame;
@@ -2348,15 +2345,15 @@ static int skip_isoc_td(struct xhci_hcd *xhci, struct xhci_td *td,
 	ep->ring->num_trbs_free += td->num_trbs - 1;
 	inc_deq(xhci, ep->ring);
 
-	return xhci_td_cleanup(xhci, td, ep->ring, status);
+	xhci_td_cleanup(xhci, td, ep->ring, status);
 }
 
 /*
  * Process bulk and interrupt tds, update urb status and actual_length.
  */
-static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
-		struct xhci_ring *ep_ring, struct xhci_td *td,
-		union xhci_trb *ep_trb, struct xhci_transfer_event *event)
+static void process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
+				 struct xhci_ring *ep_ring, struct xhci_td *td,
+				 union xhci_trb *ep_trb, struct xhci_transfer_event *event)
 {
 	struct xhci_slot_ctx *slot_ctx;
 	u32 trb_comp_code;
@@ -2403,7 +2400,7 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 
 		xhci_handle_halted_endpoint(xhci, ep, ep_ring->stream_id, td,
 					    EP_SOFT_RESET);
-		return 0;
+		return;
 	default:
 		/* do nothing */
 		break;
@@ -2422,7 +2419,7 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		td->urb->actual_length = 0;
 	}
 
-	return finish_td(xhci, ep, ep_ring, td, trb_comp_code);
+	finish_td(xhci, ep, ep_ring, td, trb_comp_code);
 }
 
 /*
-- 
2.53.0

