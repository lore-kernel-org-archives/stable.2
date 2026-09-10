Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB69C46F493
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038516; cv=none; b=hR8LszEcjg43chF9D/vHuG3caUcN7DMYshtnwaqsiVWD3WgnBrYJwzE1xqxcFBEN+I616zTsETC4Cb6sHj8hSxQZQCn8NRqW9gy+iqlO2SRBkHhDWOVWj8Mg5qAEve7CU+54fs8T2tyegrpqmm+86mIoWdRlKRc37MZgnW8p3NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038516; c=relaxed/simple;
	bh=m8jnp2Qc13i7gHoGaHJKaWelRocbC+q970Ik/jDdp+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHg9QgK7LFXlTuGpNWkndNRGg0why/GuhPrKgVBOOLiw/X4c0/f13jYQIH2off8dcLgBTuieYFuQc48MWNMAHxQXi5yOmDZmLZRsZdtxAvFEtM6bI3sh2rSnxcPDu0uEnqN3pMjeujNinlKqixAEXzjS8cNkk/selTbL378/lqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5VezVaj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5VezVaj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E6D1F00899;
	Thu, 10 Sep 2026 11:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038514;
	bh=fDpxsXw0y8TO59LSmiBjwYQvHuBFWp328i84QE7wSFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F5VezVajWrY2pr92YUNzO3h13k6Yzqq6FjpMf2aT0MdOVWtAGXRxB14GhClrIl/Y/
	 h/7JBsUqY6DeZR2XSvjIiW3X5utZnvY0p1Y6rTz/ZsYxQnXYXYR2cdfB0W1/WIseP1
	 9Z42cmUYECCVAjPkQjafSTqX3AR+oDC0/43KIQLP5mWx4QjiLvkn8HBvD3UmauAMTA
	 pU+6JM9XeAdqS8egcyoBvDgrdrAzbtyauFEWoglVZwi14PupaohpE7S1saBG8h9s5E
	 JrjZtfwa0YpUnUCJzBoHx0Ube8xtWdIuR4mumHdSoNQGla6ctymxMTV1UoMZtlDBYT
	 JPqbAnwM6vI7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] usb: xhci: refactor xhci_td_cleanup() to return void
Date: Thu, 10 Sep 2026 07:08:29 -0400
Message-ID: <20260910110830.4144529-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910110830.4144529-1-sashal@kernel.org>
References: <2026090811-curler-hatchet-10b9@gregkh>
 <20260910110830.4144529-1-sashal@kernel.org>
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

Stable backport: retain this tree's td->first_trb in the halted-endpoint
diagnostic while changing the early exit to a void return. Keep the
existing last_trb and last_trb_seg field names throughout the cleanup
callers; the upstream TD field renames are not needed here.

Preserve the void-return refactor to provide the xhci_td_cleanup()
context needed by ff44dfb03a293bf30e31f98772a1dd316a6071d1. No functions
are added, and the existing transfer-completion behavior is unchanged.

Stable-dep-of: ff44dfb03a29 ("xhci: fix lost bounce buffers on TDs spanning several ring segments")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 59 +++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 85d68e74e86a8..bdeb67a400d04 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -834,8 +834,8 @@ static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
 	seg->bounce_offs = 0;
 }
 
-static int xhci_td_cleanup(struct xhci_hcd *xhci, struct xhci_td *td,
-			   struct xhci_ring *ep_ring, int status)
+static void xhci_td_cleanup(struct xhci_hcd *xhci, struct xhci_td *td,
+			    struct xhci_ring *ep_ring, int status)
 {
 	struct urb *urb = NULL;
 
@@ -878,8 +878,6 @@ static int xhci_td_cleanup(struct xhci_hcd *xhci, struct xhci_td *td,
 			status = 0;
 		xhci_giveback_urb_in_irq(xhci, td, status);
 	}
-
-	return 0;
 }
 
 
@@ -2273,9 +2271,9 @@ int xhci_is_vendor_info_code(struct xhci_hcd *xhci, unsigned int trb_comp_code)
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
 
@@ -2290,7 +2288,7 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		 * stopped TDs. A stopped TD may be restarted, so don't update
 		 * the ring dequeue pointer or take this TD off any lists yet.
 		 */
-		return 0;
+		return;
 	case COMP_USB_TRANSACTION_ERROR:
 	case COMP_BABBLE_DETECTED_ERROR:
 	case COMP_SPLIT_TRANSACTION_ERROR:
@@ -2316,7 +2314,7 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 				xhci_dbg(xhci, "Already resolving halted ep for 0x%llx\n",
 					 (unsigned long long)xhci_trb_virt_to_dma(
 						 td->start_seg, td->first_trb));
-				return 0;
+				return;
 			}
 			/* endpoint not halted, don't reset it */
 			break;
@@ -2324,7 +2322,7 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		/* Almost same procedure as for STALL_ERROR below */
 		xhci_clear_hub_tt_buffer(xhci, td, ep);
 		xhci_handle_halted_endpoint(xhci, ep, td, EP_HARD_RESET);
-		return 0;
+		return;
 	case COMP_STALL_ERROR:
 		/*
 		 * xhci internal endpoint state will go to a "halt" state for
@@ -2341,7 +2339,7 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 
 		xhci_handle_halted_endpoint(xhci, ep, td, EP_HARD_RESET);
 
-		return 0; /* xhci_handle_halted_endpoint marked td cancelled */
+		return; /* xhci_handle_halted_endpoint marked td cancelled */
 	default:
 		break;
 	}
@@ -2351,7 +2349,7 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	ep_ring->deq_seg = td->last_trb_seg;
 	inc_deq(xhci, ep_ring);
 
-	return xhci_td_cleanup(xhci, td, ep_ring, td->status);
+	xhci_td_cleanup(xhci, td, ep_ring, td->status);
 }
 
 /* sum trb lengths from the first trb up to stop_trb, _excluding_ stop_trb */
@@ -2371,9 +2369,9 @@ static u32 sum_trb_lengths(struct xhci_td *td, union xhci_trb *stop_trb)
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
@@ -2453,7 +2451,7 @@ static int process_ctrl_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		td->urb_length_set = true;
 		td->urb->actual_length = requested - remaining;
 		xhci_dbg(xhci, "Waiting for status stage event\n");
-		return 0;
+		return;
 	}
 
 	/* at status stage */
@@ -2461,15 +2459,15 @@ static int process_ctrl_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
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
@@ -2561,14 +2559,13 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
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
@@ -2589,15 +2586,15 @@ static int skip_isoc_td(struct xhci_hcd *xhci, struct xhci_td *td,
 	ep->ring->deq_seg = td->last_trb_seg;
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
@@ -2643,7 +2640,7 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		td->status = 0;
 
 		xhci_handle_halted_endpoint(xhci, ep, td, EP_SOFT_RESET);
-		return 0;
+		return;
 	default:
 		/* do nothing */
 		break;
@@ -2662,7 +2659,7 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		td->urb->actual_length = 0;
 	}
 
-	return finish_td(xhci, ep, ep_ring, td, trb_comp_code);
+	finish_td(xhci, ep, ep_ring, td, trb_comp_code);
 }
 
 /*
-- 
2.53.0

