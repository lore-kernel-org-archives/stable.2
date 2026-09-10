Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5810946EF7C
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038514; cv=none; b=uAR7J3rhyRgGjhSqNYF/V7EqMGhZsTNuYWq31i2tAaqreplOXOsHeOFZ+1GZYnRjJgRTxJqeO5xd9DWYYtvwpOYhg+mLj3kMQSUwNe+0qyBmSzD+ikD2pAxwwuxlLpdIyHAMApm4WQygnnjbjsn8fThyGf4MgezufgmgysgGfC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038514; c=relaxed/simple;
	bh=eeval3mlN14BLX+UUyTdBXA7l62Yog8acuj12iWe0rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=he8pXrPSF5aCPVK/OduzC6tKGfErZ3Pbwvw5chDgXZLHrHH9SnLH5oDkqU45Wz5/Y8k8frZBJDhZa4vvT6F17kUGcxr3Wzw3KI/23N2SgbPrNs/4jyOVU1d2ABG08FU/AXM17pPa0omcm+HPS+NDRqDgH1Y0BUWeTCReCnj1n4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBj4LEj7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBj4LEj7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE051F000FF;
	Thu, 10 Sep 2026 11:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038512;
	bh=wAnwLI1JcB1MnyerldDAsVw1QgazkfoB9lQ7rlWyTP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jBj4LEj7VHrbZGmXnZgl8btUYgGmL2SBK3D5itmwwNsc1xe8FLA2Noan2RCYfMzTb
	 k9LCyVN4a9IPGbdhdy3D56rNkTKoveYbNUvfJf6Rp3y2wU5Cwhse77Oc6+99zmJvNe
	 5OB7FRyJ3pN4n+/LKFQDebIBm5UaQpo0B9MRmrKjpndHssUb47TXfTJPWnuPYthUuB
	 POLSrMWTaPm5LtWCXwv/lE9u8ohZDwtzo9dRm0XRt+BfgqvaUU0u7DlZO0g47o02gP
	 4p+pTvTQcowsyAin8pplXmLICZRkE/b1Tq1Rm2lEcnreslnL5PfcSysUxdPlRw2PIP
	 U3FYB3KCouOHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] usb: xhci: Remove unused parameters of next_trb()
Date: Thu, 10 Sep 2026 07:08:27 -0400
Message-ID: <20260910110830.4144529-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090811-curler-hatchet-10b9@gregkh>
References: <2026090811-curler-hatchet-10b9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Pecio <michal.pecio@gmail.com>

[ Upstream commit 6b2eb0621ffb3ee9f3e497b483e8088436bdb07e ]

The function has two parameters which it doesn't use and hasn't ever
used. One caller even puts NULL there, knowing it will work anyway.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20241106101459.775897-3-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: ff44dfb03a29 ("xhci: fix lost bounce buffers on TDs spanning several ring segments")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 2f20faa90b246..486c8afd81706 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -140,10 +140,8 @@ static void trb_to_noop(union xhci_trb *trb, u32 noop_type)
  * TRB is in a new segment.  This does not skip over link TRBs, and it does not
  * effect the ring dequeue or enqueue pointers.
  */
-static void next_trb(struct xhci_hcd *xhci,
-		struct xhci_ring *ring,
-		struct xhci_segment **seg,
-		union xhci_trb **trb)
+static void next_trb(struct xhci_segment **seg,
+			union xhci_trb **trb)
 {
 	if (trb_is_link(*trb)) {
 		*seg = (*seg)->next;
@@ -444,9 +442,9 @@ static int xhci_abort_cmd_ring(struct xhci_hcd *xhci, unsigned long flags)
 	 * avoiding corrupting the command ring pointer in case the command ring
 	 * is stopped by the time the upper dword is written.
 	 */
-	next_trb(xhci, NULL, &new_seg, &new_deq);
+	next_trb(&new_seg, &new_deq);
 	if (trb_is_link(new_deq))
-		next_trb(xhci, NULL, &new_seg, &new_deq);
+		next_trb(&new_seg, &new_deq);
 
 	crcr = xhci_trb_virt_to_dma(new_seg, new_deq);
 	xhci_write_64(xhci, crcr | CMD_RING_ABORT, &xhci->op_regs->cmd_ring);
@@ -694,7 +692,7 @@ static int xhci_move_dequeue_past_td(struct xhci_hcd *xhci,
 		    link_trb_toggles_cycle(new_deq))
 			new_cycle ^= 0x1;
 
-		next_trb(xhci, ep_ring, &new_seg, &new_deq);
+		next_trb(&new_seg, &new_deq);
 
 		/* Search wrapped around, bail out */
 		if (new_deq == ep->ring->dequeue) {
@@ -774,7 +772,7 @@ static void td_to_noop(struct xhci_hcd *xhci, struct xhci_ring *ep_ring,
 		if (trb == td->last_trb)
 			break;
 
-		next_trb(xhci, ep_ring, &seg, &trb);
+		next_trb(&seg, &trb);
 	}
 }
 
@@ -2364,7 +2362,7 @@ static int sum_trb_lengths(struct xhci_hcd *xhci, struct xhci_ring *ring,
 	union xhci_trb *trb = ring->dequeue;
 	struct xhci_segment *seg = ring->deq_seg;
 
-	for (sum = 0; trb != stop_trb; next_trb(xhci, ring, &seg, &trb)) {
+	for (sum = 0; trb != stop_trb; next_trb(&seg, &trb)) {
 		if (!trb_is_noop(trb) && !trb_is_link(trb))
 			sum += TRB_LEN(le32_to_cpu(trb->generic.field[2]));
 	}
-- 
2.53.0

