Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3732F2777FC
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 03:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786419320; cv=none; b=ER2SQmPqvLcwHut8eRl/B8vPCaJ3TkSUJ+YBxDTcVP6pIiSoOPhGt3qf55sM1K2Ri+pSnkY4HRyZywQesALOwCGMC0OmyJn6iL7Nx42+JRcsCx2j5nlXN37mbeKUlj89aPsNL2f0UUh9VVkBJG23qqBEwcc0mjHdq2z2IqimfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786419320; c=relaxed/simple;
	bh=ATG2zZJZO7nehKSOkGY/6Ezddu0Y2JYaW4sBgTe7PnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n6Hfhqx//KUutbqV17Qudeq5L9+K1suezETJM9YJo2hLBb+zL1lWWkJJT+lgVhY+iPxI/VfVM4g/bsrRXKzy+3ZG9FzsyLmZtdGVoTJ1eKHZVfNMFCX3CAlF2OXEypG9R458TQn1x56PlVvpouVAtwhg1C2mC6yLEf2z3+fGtHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=superbaloo.net; spf=pass smtp.mailfrom=superbaloo.net; dkim=pass (2048-bit key) header.d=superbaloo.net header.i=@superbaloo.net header.b=XeMvtnxN; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=superbaloo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=superbaloo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=superbaloo.net header.i=@superbaloo.net header.b="XeMvtnxN"
Received: by mail-pj2-f8.google.com with SMTP id d9443c01a7336-2d313798bf8so1442475ad.0
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 20:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=superbaloo.net; s=google; t=1786419318; x=1787024118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dp1RK/TSL03/GFQ+qVFH+d7TjYANMQxszFGz4iG/D5c=;
        b=XeMvtnxNLJ0efnzQQp2GFZE8KE3xDhIYD8pqLor3pOqpyI4oeW5uNVPwPcs8VKBI//
         QbFLXI7ev/wLWjgjMODYDg+OxieITsDyKu/CrmY6z0cA7b99Gn+R7Km6elOsk9mLSS5q
         Jnggv83GDzkgfy1BUdysIJ92jgij3YTbyyxRyEcELjwqyrSuE/XJbJ+6cF9Ph3wBT6Wv
         rTFjg56hs66Hm2mdOQkftTJJHauSlvkEAWBu4IQYjhCnMDhQlXcuz4NjawLJ0vqkKW5G
         ZXx2TAeLWxlDyVDLlnl95op4TSkzTCBW4U3KIyjN6l4DgSqDVfxsxc375qhNbokyFxiO
         r0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786419318; x=1787024118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dp1RK/TSL03/GFQ+qVFH+d7TjYANMQxszFGz4iG/D5c=;
        b=FDZAS+TQI6TQOHjFCc+uT9EPYbnAMiRWLTtlsbV2vPnZSzw5NnaZKq62QPCfZxWy/Z
         aPEnmuWRubNTkryLRf1BEGtksN6UsJ5pO5yAeD3kw2jEJpYTyuHv/xaxfm2ggo9aty1Y
         /54LfYwBZZ+ZyaZdO+UY/KV86GeOA/7+zBXizUcSIJeIBf5WF0zlR92t77FZ988Y1NN5
         PjSlUGqhlBkS5VfBrXQTROYl0ZAXXJKNlvVQPfVLwsaEnQ3HzVSL7+hlHbu+s92HZdZw
         bHI5JBSTumjUHz2Vw27wR4s4EyJoZnNE3P2HX5AsF6n/SfoFnXJFF/bhkj9gs8cTnLg0
         WWXA==
X-Forwarded-Encrypted: i=1; AHgh+Rrl1WJkBQd2aZnIXILvqAUyMUZ4NL+OA5rUvFgTMIDc6T43moBp7b0RHUBlWhQrd75h3SLdL2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDpjSaeFreQTxdx1yL1rZ0S+g0hX3CSu6jzmW3HmSLRoEiKZ8N
	b1NCwYCL6rsSGbu41D7SYK3f8pNMgo74USigtDX11sh6ehvIK/rP7QCugY63gEL7F6I=
X-Gm-Gg: AR+sD11nf+We/NvjPVfKscjLbpghv/mBCAbQx3ggv+f+dbMOkoHdXy0bqnu4j6WQM5c
	xgiAVuJVbdaFKcTqHE8Y6Zv2dK3ePc8deNeG1xg4tpSP99QZ5nlPD17BG0yREQi4c44R+4mmxQL
	KceZaFct+urrld1rGOm1jNj0T1czDjXZLN5UDoYfmrg38hiw+IRQHffX4E2EeQXMDH8NOlnwvQP
	36XMqh8aYcK6W2C6SYYyXcVdiQQQtlPxHdZqBNgWLjMnpMxvMOLkAbqtaJ2N0nWAcTPlODDAPeK
	lxb1TfN2gBGYXBQGo8ScK2aGt/xbpygyGGf0VdXCbhWDyHsTdTPOiuncJBmGAs/Aj8aiG81q35C
	vNbBqF/Hl2LS9poKC4iVWk2r9z/yq3e7gXyDf1ISaTuIY/y2jGbltNWTEh1O3MqO93nln747rWP
	ZwgGp9j0GgluQLeVSxskZTxKjErw1eq4hDou09HtPOsAU7EALSZSVlvdWXy96WLARXjGAKIVozC
	/qKGJWCOI4PUeE4rw351+cifSrLsgXcQENHHkO/wOX+Ofk53VqAFb9v4QnCdAfT
X-Received: by 2002:a05:6a21:490:b0:3cb:b6af:e3a6 with SMTP id adf61e73a8af0-3cc2babb898mr679354637.27.1786419318448;
        Mon, 10 Aug 2026 20:35:18 -0700 (PDT)
Received: from localhost ([2603:800c:21f0:c0:a1af:2e25:d07b:83f9])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-315beb877b4sm56462306eec.19.2026.08.10.20.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 20:35:17 -0700 (PDT)
From: Arthur Gautier <baloo@superbaloo.net>
To: linux-usb@vger.kernel.org
Cc: Arthur Gautier <baloo@superbaloo.net>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] xhci: fix lost bounce buffers on TDs spanning several ring segments
Date: Tue, 11 Aug 2026 03:35:08 +0000
Message-ID: <20260811033508.1050148-1-baloo@superbaloo.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

This is reachable with a USB mass storage device behind xHCI backing a
dm-verity target with 512 byte hash blocks. The device enumerates as
SuperSpeed, so wMaxPacketSize is 1024, while dm-bufio issues one 512 byte
bio per hash block. verity_prefetch_io() makes the block layer merge
hundreds of them into a single request of up to 512 scatterlist entries
of 512 bytes each. At 256 TRBs per ring segment such a TD spans three
segments, and every segment boundary falls on an odd multiple of 512,
i.e. unaligned to wMaxPacketSize. dm-bufio then caches a hash block
holding stale data and dm-verity declares the metadata block corrupted:

  device-mapper: verity: 8:2: metadata block 10850 is corrupted

A reproducer running this under qemu is available at
https://github.com/baloo/xhci-verity

The bounce state (bounce_buf, bounce_dma, bounce_len, bounce_offs)
already lives on the ring segment, so there is nothing extra to track.
Keep the first bounced segment in td->bounce_seg and, on completion,
walk the segments the TD covers from there up to td->end_seg, handling
every segment that still has a pending bounce.

Fixes: f9c589e142d0 ("xhci: TD-fragment, align the unsplittable case with a bounce buffer")
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Arthur Gautier <baloo@superbaloo.net>
---
 drivers/usb/host/xhci-ring.c | 49 +++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 4f98d8269625..4154e84420ac 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -842,21 +842,18 @@ static void xhci_giveback_urb_in_irq(struct xhci_hcd *xhci,
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
@@ -872,10 +869,37 @@ static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
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
+	unsigned int i;
+
+	if (!ring || !td->bounce_seg || !td->urb)
+		return;
+
+	/*
+	 * A TD that spans more than two ring segments crosses several link
+	 * TRBs, and may have been aligned with a bounce buffer at each of
+	 * them. Every bounce buffer lives on the segment whose link TRB it
+	 * was needed for, so walk all segments the TD covers, starting at
+	 * the first one that was bounced.
+	 */
+	seg = td->bounce_seg;
+	for (i = 0; i < ring->num_segs; i++) {
+		if (seg->bounce_len)
+			xhci_unmap_one_bounce_buffer(xhci, ring, td, seg);
+		if (seg == td->end_seg)
+			break;
+		seg = seg->next;
+	}
+}
+
 static void xhci_td_cleanup(struct xhci_hcd *xhci, struct xhci_td *td,
 			    struct xhci_ring *ep_ring, int status)
 {
@@ -3674,8 +3698,15 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 						  &trb_buff_len,
 						  ring->enq_seg)) {
 					send_addr = ring->enq_seg->bounce_dma;
-					/* assuming TD won't span 2 segs */
-					td->bounce_seg = ring->enq_seg;
+					/*
+					 * A TD spanning several segments can be
+					 * bounced once per segment boundary it
+					 * crosses. Remember the first bounced
+					 * segment, the rest are found by walking
+					 * the TD's segments on completion.
+					 */
+					if (!td->bounce_seg)
+						td->bounce_seg = ring->enq_seg;
 				}
 			}
 		}
-- 
2.55.0

