Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DE317D6
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788896725; cv=none; b=MtnTVsXnNOMgFCUkAV2sOAh4wYoBWGsIA/yLtaejMTs9W4N5dxrk48JIDc0IS4l/T/ywoJRxUU+7I89xjrxLyQtCEb/qY/OWaiKvs+IviXp1Bh8toa8CjLvePGhvk2fc4Y5ttfckIbhcYig/RuC8vmrqjnvwsPAEc93dKSTrkGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788896725; c=relaxed/simple;
	bh=s8QmCt6W2pAYq0RioTtFRIlXyNPK+RYb2UiyBeP8ZFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WihzcBug+7cc+zhPt+PHdCoPS+eJn3TslUSOL8y5QkTTDf5WqSe7nwq1n8pfXiI9zB5CxQKKeLh+nZGX1my/PIZM3gaDI2wmb/fOzDjscWvLPRnsJ1HKdpjZAdw8ScGXL89pbDuJe6nVTTldtgkOKCcr2CbRwqSayBGvpVDiU84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5dl9c+4; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5dl9c+4"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-485850cbac3so3276277f8f.3
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 12:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788896722; x=1789501522; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dndx2c2KjNA1GaPuTJPimGICIIByq2fayLQ0ENkklBo=;
        b=G5dl9c+4t6OxlUUbpdNI9N0BmLu0wv+3UmAtWdULRLnaasfjsAkWqGKldPVeihH8cf
         H64SV6w4KwhvuGGgwWTBkADIlXvPtCUE7/p6NWT39URpDnejCxzx2dBPJEYwOOrYHx0+
         Xbyx3CsBIUrAhgDlRHRboyKQ7beqES9BFgUmDket9LgarCYPfOXZQmAyqIVdn9S3YyYI
         HU1KMJFzcz4QnkKpus22HTryBJ1DFZXhcgoTJshcj/nXmTanQctYVcAjEyD0GwKN0Azy
         X2RY1iTuvjeqlrrNG9oiftZ7wwr/7oltjhSQecEZCdAWSWClylnw6ysW8KM8bV7CMaqO
         a1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788896722; x=1789501522;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dndx2c2KjNA1GaPuTJPimGICIIByq2fayLQ0ENkklBo=;
        b=kOH3x4FZ05iTcyB09KTUNwJ9inkhqViV/vM6JlLP9IviONwBfYPlzHQtGlyKsrga2l
         o6m42D7/KXQLnvLpej5Issol5uYNn8kQaFSK8pcDbIUd/S9oVikyumn0hg5z9jLL5V6n
         zqfiFn0L7QUmBG+A9ZqOQFw8oPWqQ2I3zHLeGxoMxnyZ0ZrqRL1gUafE/Fhzo7LW3Zur
         z3VVnknJJGsohLT8DkxzOpsNdygaYSGX+hLNbYlpz1kUfU2DSLpjX93hM9GFPKerCk2h
         UgVJO/X82KGWOY9CQDK9dYnx5R+PgQhTI9eN6h3LaN7/n8PA0rq0/daMJk3iZP+15p83
         rGjQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4l+nM+oRlheAlezD8u1SZnPUmVOBCDE/mWxz4jRpEnOdl6waiVfmkXJRySF8XUPc7UY5h7gw=@vger.kernel.org
X-Gm-Message-State: AFuF++lrOVi2pxpcaB9TokQoT6+A3RjWyYLAjFvyoHON+XyUN5jD5HaB
	v/Lk5LuSkqrKjHBnGfrCJ7HRv6eJSnSKbO467TyfXQZRYHwTpAL141iI
X-Gm-Gg: AYBFou0Bx1SX7W0kra34pMRv1ta7N63/GVnaoLjU1AWXrNxUeXftmP1oPrsEkl6PZ41
	I3xfzMImtoNobnRNUQLgHX2FvIRdykxFeU04o+OZq05Ct/F1yw1SqR/TcccLZ5xw1U2dnlAwPYJ
	412CxIyPI3fT0Gba7Vc8koIMYhCA09MTz93txCWkj8sb6awYuTmVya2x+BpGfAxpOCW73hi2Wpb
	DGitVZWBSY0xI2GX9X/GPOfA5pSJ/Pc29QaY85a1ibFDKsy0qhviinGo3rr1erS0v/dPj6x2by5
	XHgxh0THegTtaKBalkbGLaK0BOwjXcbV1oxPoieT5qoOVT5yLrfXdce9sAz8ub3SETfdlbDk48o
	vouEl93Hta6HOQipn6Q28QdcSXQdx/HaLDaydja0vuhaCV0FYrXCHXnzebbppXMID96wCTxH9Kp
	6J9kBL2ItJVodbllZDz0Kkua85HwEY3BnAZwmrepPZgivOEm6hGNvt926tMpEj0/wVxx2zQQ==
X-Received: by 2002:a05:600c:3b0e:b0:49c:fc6e:a3d5 with SMTP id 5b1f17b1804b1-49cfc6ea726mr273563325e9.20.1788896721310;
        Tue, 08 Sep 2026 12:45:21 -0700 (PDT)
Received: from foxbook (bfg95.neoplus.adsl.tpnet.pl. [83.28.44.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6024a8sm523995475e9.6.2026.09.08.12.45.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 08 Sep 2026 12:45:21 -0700 (PDT)
Date: Tue, 8 Sep 2026 21:45:18 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: <gregkh@linuxfoundation.org>
Cc: baloo@superbaloo.net, mathias.nyman@linux.intel.com,
 <stable@vger.kernel.org>
Subject: [PATCH 5.10-6.12] xhci: fix lost bounce buffers on TDs spanning
 several ring segments
Message-ID: <20260908214518.3de5f5a9.michal.pecio@gmail.com>
In-Reply-To: <2026090810-remold-gleaming-2a4e@gregkh>
References: <2026090810-remold-gleaming-2a4e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

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
(cherry picked from commit ff44dfb03a293bf30e31f98772a1dd316a6071d1)
[Michal: solved context conflict due to xhci_td_cleanup() type]
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---

cherry-picked on 6.12, built and tested with artificial repro on 5.10,
looks like it will work for everything in between.

 drivers/usb/host/xhci-ring.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index a337e1fda33d..67804954e146 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -739,21 +739,18 @@ static void xhci_giveback_urb_in_irq(struct xhci_hcd *xhci,
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
@@ -769,10 +766,29 @@ static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
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
 static int xhci_td_cleanup(struct xhci_hcd *xhci, struct xhci_td *td,
 			   struct xhci_ring *ep_ring, int status)
 {
@@ -3530,7 +3546,7 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 						  &trb_buff_len,
 						  ring->enq_seg)) {
 					send_addr = ring->enq_seg->bounce_dma;
-					/* assuming TD won't span 2 segs */
+					/* TD bounced at least, and last on this seg */
 					td->bounce_seg = ring->enq_seg;
 				}
 			}
-- 
2.48.1
