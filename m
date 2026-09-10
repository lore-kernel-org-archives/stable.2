Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11AE4BFE97
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044995; cv=none; b=ddMFayyMMz8BRMJh+PPEWPzQwYY9HNij08lF1B5VICBa7iXOKyDPmJjp0waHkzdBTky0hW5sZ+fNmjzBCbxVm/czw377YZTB0vSLrSsYI5Wqb1JL7rFypGAhm8T7GiRDpxuJEwnR0Zc69IPqduJADpNQMUE0fmBXYJldcCO5wC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044995; c=relaxed/simple;
	bh=M43d8k8M7Dp60JNI3f/pAVWeFa4BpL0kpLz+tuSRdg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDdsFg8OJcNtpFXO7eU2C2Vk8HRBE2/QQtsAS51iZlkcVae5E/z8QIUpE6DB2DoKVcwVyaP4VRBX15opy/lg7yfesPV1I+P0b+U9JWbjMKW4HvD06G+KYEYUYaWu2BRfKZ4trXXKjL36tQYzhtm/QDhcOgupvfTIugW+4QVCFUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIuY4iMf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIuY4iMf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351A81F000FF;
	Thu, 10 Sep 2026 12:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789044993;
	bh=nAElvIPwgPI3eSf0IpVHC8zibuY3vAVEVhibAsfOoAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BIuY4iMfvaYmpkc7zE667GYR6D/sIdG6MmsCZZRZNdK/mtEE35wDRn1nsI99q+JET
	 QXtDrNA0BpoP8vcZX4tnW+cAX36l2tBgiGInH4tCoZRuVEvLkt65JlHUm9xYjerSXF
	 /ZtieEOLZApjZYooLmt3RySGERyOs1uk4YSq0pT9/B1F8QWQsBGqF0u4BrO7XWXt6A
	 9CFc2cJMzBJ7sBprUg5XdtQwfbZpaoxY7oAUF5AEFWBZDPdThK5+zAqRvxlUoHGpa+
	 R1Nxigm4VUqzjeHcRq6yrrlgt5mrnM+4ObDp9OZDpU/aRO9DW/G04TpPD23XovpUIp
	 cBRPdqTHrCySg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] usb: xhci: Remove unused parameters of next_trb()
Date: Thu, 10 Sep 2026 08:56:28 -0400
Message-ID: <20260910125631.195223-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090813-undocked-untwist-c0a8@gregkh>
References: <2026090813-undocked-untwist-c0a8@gregkh>
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
index 2d06f54839e0c..04aaa67d68d3b 100644
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
@@ -404,9 +402,9 @@ static int xhci_abort_cmd_ring(struct xhci_hcd *xhci, unsigned long flags)
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
@@ -654,7 +652,7 @@ static int xhci_move_dequeue_past_td(struct xhci_hcd *xhci,
 		    link_trb_toggles_cycle(new_deq))
 			new_cycle ^= 0x1;
 
-		next_trb(xhci, ep_ring, &new_seg, &new_deq);
+		next_trb(&new_seg, &new_deq);
 
 		/* Search wrapped around, bail out */
 		if (new_deq == ep->ring->dequeue) {
@@ -734,7 +732,7 @@ static void td_to_noop(struct xhci_hcd *xhci, struct xhci_ring *ep_ring,
 		if (trb == td->last_trb)
 			break;
 
-		next_trb(xhci, ep_ring, &seg, &trb);
+		next_trb(&seg, &trb);
 	}
 }
 
@@ -2400,7 +2398,7 @@ static int sum_trb_lengths(struct xhci_hcd *xhci, struct xhci_ring *ring,
 	union xhci_trb *trb = ring->dequeue;
 	struct xhci_segment *seg = ring->deq_seg;
 
-	for (sum = 0; trb != stop_trb; next_trb(xhci, ring, &seg, &trb)) {
+	for (sum = 0; trb != stop_trb; next_trb(&seg, &trb)) {
 		if (!trb_is_noop(trb) && !trb_is_link(trb))
 			sum += TRB_LEN(le32_to_cpu(trb->generic.field[2]));
 	}
-- 
2.53.0

