Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E533DD875
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038517; cv=none; b=FIXCKITfP7YDsfc1rhJNplL3EMg2+9V2eyvDVwoqQ/9o28tNwdpbuqM+yUIo3K+KvMq+36bgSNr+oRdWzcE1yoqcjU383TjhuYIBNNa6l5wAI+JP1a9BbC1zGb1sbDNa2OQPWpkChDvFktwBnRfPdvze93T0Vxrwp/it51x1dRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038517; c=relaxed/simple;
	bh=7TwzJe6FDGmWWwoSFpfzcOdvxcI+P95WkZR7aUFLJlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REowk5NzX+ekjpGE6YMbX+E1VDaVNJHQwr4rou2PK1ZApTo0R1dzxtNPOqGKHVp4Axgbyuk7OAMLb4QNxtKxSebGc0x5VKDMhosxv/oB0uccA0mXgmnPjQkXyX6CDEnT16ygPc+jkgJPrREBAk95mI5pxZ6c120Eybql/kLK2OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci+xPNgs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci+xPNgs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84291F000FF;
	Thu, 10 Sep 2026 11:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038515;
	bh=GJijiUrBIJarxwaWDajiZihDEEb/zC60+6bQsKisDFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ci+xPNgszXT+lnKt96Fuz22m+A9LJiE2exrYnZ6PyrS5Bg8570aOY54vDukfdlBXr
	 w6q8iHF3f1WF+CMXmm9VVhEtdIiAwYuZLJQDF6EOTlMn5InacJGpdTWswVIic2UKdc
	 a1e/2nmCvH08HtMkpikIkRAS91trqedRmYTlEiO3K3cX5kxuO8CqzDqKEu3e34NpIG
	 jzjrxHygA4Z63NI9747WqkTM7HZLS5VJOfG12gCxQVIwcTC5z8Y0333XJurVNPItlt
	 u84lRpIC3p8vOu20J74hfBiaQ9oGHimvWQPU9f9KKXS9X1AFs/+Ci0Tdf7ELuYdfSd
	 lBYgwPkk1NYWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arthur Gautier <baloo@superbaloo.net>,
	Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] xhci: fix lost bounce buffers on TDs spanning several ring segments
Date: Thu, 10 Sep 2026 07:08:30 -0400
Message-ID: <20260910110830.4144529-4-sashal@kernel.org>
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

From: Arthur Gautier <baloo@superbaloo.net>

[ Upstream commit ff44dfb03a293bf30e31f98772a1dd316a6071d1 ]

When a TD reaches a link TRB with data that is not aligned to the
endpoint's wMaxPacketSize, xhci_align_td() stages the unalignable tail
through the bounce buffer of the ring segment holding that link TRB.
xhci_unmap_td_bounce_buffer() later unmaps it and, for IN transfers,
copies the data back into the URB's buffer.

The enqueue path records the segment that was bounced in td->bounce_seg,
under the assumption that a TD never spans more than two ring segments.
That assumption does not hold: a TD large enough to span three or more
segments crosses several link TRBs and can be bounced at each of them.
Only the last one survives in td->bounce_seg, so every earlier bounce
buffer is neither copied back nor DMA unmapped.

The URB still completes with actual_length equal to the requested length
and no error, so the transfer looks successful while a wMaxPacketSize
sized hole in the destination buffer silently keeps its previous
contents. It also leaks a DMA mapping per dropped bounce.

Any sufficiently large and fragmented bulk transfer can hit this. It was
found with a USB mass storage device behind xHCI backing a dm-verity
target with 512 byte hash blocks, where the stale data is detected rather
than silently consumed. The device enumerates as SuperSpeed, so
wMaxPacketSize is 1024, while dm-bufio issues one 512 byte bio per hash
block. verity_prefetch_io() makes the block layer merge hundreds of them
into a single request of up to 512 scatterlist entries of 512 bytes each.
At 256 TRBs per ring segment such a TD spans three segments, and every
segment boundary falls on an odd multiple of 512, i.e. unaligned to
wMaxPacketSize. dm-bufio then caches a hash block holding stale data and
dm-verity declares the metadata block corrupted:

  device-mapper: verity: 8:2: metadata block 10850 is corrupted

A reproducer running this under qemu is available at
https://github.com/baloo/xhci-verity

The bounce state (bounce_buf, bounce_dma, bounce_len, bounce_offs)
already lives on the ring segment, so there is nothing extra to track.
Keep recording the last bounced segment in td->bounce_seg and, on
completion, walk the segments from td->start_seg up to it, unmapping
every segment that still has a pending bounce.

Stopping at td->bounce_seg rather than td->end_seg matters: a bounce
implies the TD continues past that segment's link TRB, so bounce_seg is
always strictly before end_seg, and a later TD may already have started
in end_seg and been bounced there. Walking that far would copy a foreign
bounce buffer into this URB and unmap it twice. It also keeps the walk
correct if a TD ever wraps the whole ring so that end_seg == start_seg.

[mn: Add ring->num_segs check to prevent unlikely infinite for loop.]

Fixes: f9c589e142d0 ("xhci: TD-fragment, align the unsplittable case with a bounce buffer")
Cc: stable@vger.kernel.org
Suggested-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Arthur Gautier <baloo@superbaloo.net>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://patch.msgid.link/20260831090448.95644-4-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index bdeb67a400d04..7e8a07c1db623 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -800,21 +800,18 @@ static void xhci_giveback_urb_in_irq(struct xhci_hcd *xhci,
 	usb_hcd_giveback_urb(hcd, urb, status);
 }
 
-static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
-		struct xhci_ring *ring, struct xhci_td *td)
+static void xhci_unmap_one_bounce_buffer(struct xhci_hcd *xhci,
+		struct xhci_ring *ring, struct xhci_td *td,
+		struct xhci_segment *seg)
 {
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
-	struct xhci_segment *seg = td->bounce_seg;
 	struct urb *urb = td->urb;
 	size_t len;
 
-	if (!ring || !seg || !urb)
-		return;
-
 	if (usb_urb_dir_out(urb)) {
 		dma_unmap_single(dev, seg->bounce_dma, ring->bounce_buf_len,
 				 DMA_TO_DEVICE);
-		return;
+		goto done;
 	}
 
 	dma_unmap_single(dev, seg->bounce_dma, ring->bounce_buf_len,
@@ -830,10 +827,29 @@ static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
 		memcpy(urb->transfer_buffer + seg->bounce_offs, seg->bounce_buf,
 		       seg->bounce_len);
 	}
+done:
 	seg->bounce_len = 0;
 	seg->bounce_offs = 0;
 }
 
+static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
+		struct xhci_ring *ring, struct xhci_td *td)
+{
+	struct xhci_segment *seg;
+	int i = 0;
+
+	if (!td->bounce_seg || !ring || !td->urb)
+		return;
+
+	/* td->bounce_seg is the last one bounced, unmap them all */
+	for (seg = td->start_seg; i++ < ring->num_segs; seg = seg->next) {
+		if (seg->bounce_len)
+			xhci_unmap_one_bounce_buffer(xhci, ring, td, seg);
+		if (seg == td->bounce_seg)
+			break;
+	}
+}
+
 static void xhci_td_cleanup(struct xhci_hcd *xhci, struct xhci_td *td,
 			    struct xhci_ring *ep_ring, int status)
 {
@@ -3781,7 +3797,7 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 						  &trb_buff_len,
 						  ring->enq_seg)) {
 					send_addr = ring->enq_seg->bounce_dma;
-					/* assuming TD won't span 2 segs */
+					/* TD bounced at least, and last on this seg */
 					td->bounce_seg = ring->enq_seg;
 				}
 			}
-- 
2.53.0

