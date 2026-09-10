Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9999040DB20
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047779; cv=none; b=UlXqKyBVPcpjah1gxqTNhE2pl0aTbTygAmvDwy86DGcZvJ+WsTE2dNEy2WI3A9SIY56OjM3341Ng/KxS85ByfHr23LrAADr4CGYeX/ofS0uIiqqAxztVYkh65M2SdQ0dJhHey4G476UnVgXXxbj4wETO/7GRtgeSr8VqIMwz2o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047779; c=relaxed/simple;
	bh=fra/xZFrIeAAIZok5jvrG+I9ekspsmZQdtFDKAlWPTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dalbkGXFgCP4dIYwM3j0abPmeXBXlq+uGkHxRMUhWoFH7vwpkWlC88JGK45B1uwlspPN9/CObKJ52LspvTMfvm5UzNkhVBQ4+30EBs+9F4IZRKHzpeVWUP8Fw8Nc+82FgUSy7fEahJHQsAAso3oSVpgNW24jpg3fTMQRNvQ4wOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHK2RXn2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHK2RXn2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED35D1F000FF;
	Thu, 10 Sep 2026 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789047777;
	bh=UNJb9NU3JJ50ADUzmWP/OBuAS7LoDfJDWzgQ9IKpg9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oHK2RXn2HaNwJ2xbQoAv4y7FTPUzWyG8aQMPB4PegLKoyOxZ5l6ttJb9RJU9f3NY4
	 O1uLtwecCcV6pmO+oVRb2YdUrTkdMZd96ZflE5olh0T1vjQAQxvqfx05SMKEMXpmF2
	 liGYv1q7TqtDp1+WgTyMge9op9zCRXqJJxy0k97cryjVPc9EH50AqIDF7vwfT64Xs+
	 vhNwamBODTymAePE0x02D+uF7VhMJ6+0/J8mEJiE7TZuBoGbdytimS3NMcQEGHu59H
	 JDr2LfSUp9ftUo5REXhV7TU6h/vZO+x2ga0Hu+xRqaWLdcEI6sUvMnD/zNCu5CVNcG
	 MhnC4XY+AR7wA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] usb: xhci: Fix sum_trb_lengths()
Date: Thu, 10 Sep 2026 09:42:52 -0400
Message-ID: <20260910134254.352939-2-sashal@kernel.org>
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

From: Michal Pecio <michal.pecio@gmail.com>

[ Upstream commit ae71f9b88e5a15fed17a432e21c30ee9463ed1a4 ]

This function is supposed to sum the lengths of all transfer TRBs in
a TD up to a point, but it starts summing at the current dequeue since
it only ever gets called on the first pending TD.

This won't work when there are cancelled TDs at the beginning of the
ring. The function tries to exclude No-Ops from the count, but not all
cancelled TDs are No-Op'ed - not those the HW stopped on.

The absolutely obvious fix is to start counting at the TD's first TRB.
And remove the now-useless 'ring' parameter, and 'xhci' too.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20241106101459.775897-4-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: ff44dfb03a29 ("xhci: fix lost bounce buffers on TDs spanning several ring segments")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 38e118047ff4c..3e7664a2476db 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2111,13 +2111,12 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	return xhci_td_cleanup(xhci, td, ep_ring, td->status);
 }
 
-/* sum trb lengths from ring dequeue up to stop_trb, _excluding_ stop_trb */
-static int sum_trb_lengths(struct xhci_hcd *xhci, struct xhci_ring *ring,
-			   union xhci_trb *stop_trb)
+/* sum trb lengths from the first trb up to stop_trb, _excluding_ stop_trb */
+static u32 sum_trb_lengths(struct xhci_td *td, union xhci_trb *stop_trb)
 {
 	u32 sum;
-	union xhci_trb *trb = ring->dequeue;
-	struct xhci_segment *seg = ring->deq_seg;
+	union xhci_trb *trb = td->first_trb;
+	struct xhci_segment *seg = td->start_seg;
 
 	for (sum = 0; trb != stop_trb; next_trb(&seg, &trb)) {
 		if (!trb_is_noop(trb) && !trb_is_link(trb))
@@ -2308,7 +2307,7 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		goto finish_td;
 
 	if (sum_trbs_for_length)
-		frame->actual_length = sum_trb_lengths(xhci, ep->ring, ep_trb) +
+		frame->actual_length = sum_trb_lengths(td, ep_trb) +
 			ep_trb_len - remaining;
 	else
 		frame->actual_length = requested;
@@ -2392,7 +2391,7 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		goto finish_td;
 	case COMP_STOPPED_LENGTH_INVALID:
 		/* stopped on ep trb with invalid length, exclude it */
-		td->urb->actual_length = sum_trb_lengths(xhci, ep_ring, ep_trb);
+		td->urb->actual_length = sum_trb_lengths(td, ep_trb);
 		goto finish_td;
 	case COMP_USB_TRANSACTION_ERROR:
 		if (xhci->quirks & XHCI_NO_SOFT_RETRY ||
@@ -2414,7 +2413,7 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		td->urb->actual_length = requested - remaining;
 	else
 		td->urb->actual_length =
-			sum_trb_lengths(xhci, ep_ring, ep_trb) +
+			sum_trb_lengths(td, ep_trb) +
 			ep_trb_len - remaining;
 finish_td:
 	if (remaining > requested) {
-- 
2.53.0

