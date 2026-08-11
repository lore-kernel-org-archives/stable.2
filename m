Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B1037E5E5
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437766; cv=none; b=ONHGKWSMXzeJPFWl1tpp3SEhdV0W9AhT15rmk0aFzzCRsOkhshRVDVPaqGXQjU6jXvPQUKeqCvN+l6cFnpWfpa9TNiYu+hsbYPATdsURLdCKPiwnnd7dwYNmrSO32zE+Urtm5tq0g+juHgFnvGlXIbBLuPD7Khp2YFenk6KfQRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437766; c=relaxed/simple;
	bh=jsxYnbURX4siW2J3lGt08/5sC8j1PoEqPT27NNOP8y8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxLaMIeWVSWlM1R8DfOuvdmtZ3TwVu7jbuNz5u+hUylw/WBSsvqb7UT5Tzref0Y9WL6JA1K+G9B/M9BsBHBUgcRzm8qo61vC/ve6YdpJZA9OmHPkjhwWRvAiiQGRVHK0z9Nb1srZrRpbaM8yQauxvOf/8KPltBNdkiOKxfgWUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvgiYRrD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvgiYRrD"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so20663605e9.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 01:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437763; x=1787042563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vb1CPJySP31EqeRDTO2rfZUYp+PAUBXKUFfyVqbzeFU=;
        b=UvgiYRrDCAWBbTS93bDrWJVvwfFh4CL/alhisCNPdbWZkRzcZ2ReMK32SwYBBh7X73
         em9liWnApTrPdzhMxXS6U9l63mYdCsi6V0PaJPm2blO6xGGklf+m3oQy8lToWdMk5uiV
         gwYM7K3BPnOOXWeY2KnPDC32/5UvfLciogljtnVsIFrLgDGgXxeTr6ldlaNVun9ZyAe6
         kIaob31cqEuNKGnyvJBGinS9UshsK05brfHl4d1yQbMG287KfRr4+R9ix0eGCYS/UiJc
         QGlbHRFG+H/cJCtI29r+V9UsSyRo0S/moD33ik+E10tU52aMH0YeFkJww9AZ4coo33Uk
         zDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437763; x=1787042563;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vb1CPJySP31EqeRDTO2rfZUYp+PAUBXKUFfyVqbzeFU=;
        b=hnG2LrYIB2nBcZVrd1nS3PjhoidKr6wzJ1RfzkCYBqJrpD9JuYdchMNOSEvHLzjWlU
         3CzJRDFPDtUXETNo/L47QxIdSdBDgtMfQqydEQ0NjrH1lt61QowcnqMAaFncTqgG16oa
         Y7GUe2KQiaLRMXUn/56gsCpZ6EMxccwZ+8zuvs46BlpJ8+DfcCuCmDeBElQYzgGTrmBy
         XtvTdzdmS/BHB6Cw5NdHNimE3RpN4Hy5bjdIo25o3fz0Z2lFsOhkAEV58ZhrIM+vrhuj
         9hFxsiOCqu6/NPdDo+MTinIyNkT5BXr2NcSPAQQfirdSrRR3l/E6miP5Nqr/YV5bm6sJ
         Dp9A==
X-Forwarded-Encrypted: i=1; AHgh+RrBTK/J7nYV0p3OKKrgrx6ycc85KiEIfj6LrXo/WWkg7xGvb+v7ytZIgMWp5GheucHX5IPaBSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1fr+6dRJVYkb+YqtlwwzcVF6ZaxI+3QXqDJWzp52LU0W9IbS3
	sp2gxUSwoMOZuTboBlS+N/MF1xo91+wppqdTkxibgmyMxy5c2C3PkaG+ZbNcxQ==
X-Gm-Gg: AR+sD1005WQtQdZWHyzEqsGGMvMgV2pSbnMlrgM3nZJEImvqOp6VfqN4RvjcR0o7TsV
	LTMY5oQKqwbjxoJ6pKKrKSmtdsjp/cEtlUqI8Ch+8yG9UoYcqH+WsrL5mNLFMz7Kj23a83EN1V5
	yFCJThH/UUXR1nDDXaoCXD060Lojn8fv1bV32gPO6H4eJ8uGvITqeq8DuQ/rIKMosy78Zsf9o14
	BonD+7n+WsrebrOYszrKKF8qzaUn6cf6Wo08/1g4AHFhTXkILI3VNt9J1XCw84XqVVKwd3VYD+1
	k0dCeJKFSyHT7kv0lzoxdge+7yHE6tSIG9hMOaY7JDEtFIbTB0ysqOORtjzDOkcDrvjLlWXC3TV
	qY5UhEgihBuIsqYjRvlUox1V4bvVNEfdCDQyylSkvvYv2Ezoml1wmIDMJw8j7YQyvtInobxI/0v
	oNdi5x7YLUKbjzbMIg1saT+NImb+bpZwHiIMhZaL8Kf+MHGQhYgTRpg+K5qFMPpMQ9O3qN1J7o
X-Received: by 2002:a05:600c:6085:b0:499:728c:4704 with SMTP id 5b1f17b1804b1-499784649b5mr26865925e9.12.1786437762420;
        Tue, 11 Aug 2026 01:42:42 -0700 (PDT)
Received: from foxbook (bgt135.neoplus.adsl.tpnet.pl. [83.28.83.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499788a5be9sm38950295e9.4.2026.08.11.01.42.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Aug 2026 01:42:42 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:42:37 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Arthur Gautier <baloo@superbaloo.net>
Cc: linux-usb@vger.kernel.org, Mathias Nyman
 <mathias.nyman@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] xhci: fix lost bounce buffers on TDs spanning several
 ring segments
Message-ID: <20260811104237.4500b578.michal.pecio@gmail.com>
In-Reply-To: <20260811033508.1050148-1-baloo@superbaloo.net>
References: <20260811033508.1050148-1-baloo@superbaloo.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 03:35:08 +0000, Arthur Gautier wrote:
> When a TD reaches a link TRB with data that is not aligned to the
> endpoint's wMaxPacketSize, xhci_align_td() stages the unalignable tail
> through the bounce buffer of the ring segment holding that link TRB.
> xhci_unmap_td_bounce_buffer() later unmaps it and, for IN transfers,
> copies the data back into the URB's buffer.
> 
> The enqueue path records the segment that was bounced in td->bounce_seg,
> under the assumption that a TD never spans more than two ring segments.
> That assumption does not hold: a TD large enough to span three or more
> segments crosses several link TRBs and can be bounced at each of them.
> Only the last one survives in td->bounce_seg, so every earlier bounce
> buffer is neither copied back nor DMA unmapped.
> 
> The URB still completes with actual_length equal to the requested length
> and no error, so the transfer looks successful while a wMaxPacketSize
> sized hole in the destination buffer silently keeps its previous
> contents. It also leaks a DMA mapping per dropped bounce.
> 
> This is reachable with a USB mass storage device behind xHCI backing a
> dm-verity target with 512 byte hash blocks. The device enumerates as
> SuperSpeed, so wMaxPacketSize is 1024, while dm-bufio issues one 512 byte
> bio per hash block. verity_prefetch_io() makes the block layer merge
> hundreds of them into a single request of up to 512 scatterlist entries
> of 512 bytes each. At 256 TRBs per ring segment such a TD spans three
> segments, and every segment boundary falls on an odd multiple of 512,
> i.e. unaligned to wMaxPacketSize. dm-bufio then caches a hash block
> holding stale data and dm-verity declares the metadata block corrupted:
> 
>   device-mapper: verity: 8:2: metadata block 10850 is corrupted

Quite nasty, and not everybody uses dm-verify in particular. It seems
corruption could also affect rare FAT filesystems with tiny clusters. 

> A reproducer running this under qemu is available at
> https://github.com/baloo/xhci-verity
> 
> The bounce state (bounce_buf, bounce_dma, bounce_len, bounce_offs)
> already lives on the ring segment, so there is nothing extra to track.
> Keep the first bounced segment in td->bounce_seg and, on completion,
> walk the segments the TD covers from there up to td->end_seg, handling
> every segment that still has a pending bounce.
> 
> Fixes: f9c589e142d0 ("xhci: TD-fragment, align the unsplittable case with a bounce buffer")
> Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
> Cc: stable@vger.kernel.org

Note: you don't need to list here the driver maintainer you are sending
this email to. And no need to *actually* send email to the stable list.

> Signed-off-by: Arthur Gautier <baloo@superbaloo.net>
> ---
>  drivers/usb/host/xhci-ring.c | 49 +++++++++++++++++++++++++++++-------
>  1 file changed, 40 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 4f98d8269625..4154e84420ac 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -842,21 +842,18 @@ static void xhci_giveback_urb_in_irq(struct xhci_hcd *xhci,
>  	usb_hcd_giveback_urb(hcd, urb, status);
>  }
>  
> -static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
> -		struct xhci_ring *ring, struct xhci_td *td)
> +static void xhci_unmap_one_bounce_buffer(struct xhci_hcd *xhci,
> +		struct xhci_ring *ring, struct xhci_td *td,
> +		struct xhci_segment *seg)
>  {
>  	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
> -	struct xhci_segment *seg = td->bounce_seg;
>  	struct urb *urb = td->urb;
>  	size_t len;
>  
> -	if (!ring || !seg || !urb)
> -		return;
> -
>  	if (usb_urb_dir_out(urb)) {
>  		dma_unmap_single(dev, seg->bounce_dma, ring->bounce_buf_len,
>  				 DMA_TO_DEVICE);
> -		return;
> +		goto done;
>  	}
>  
>  	dma_unmap_single(dev, seg->bounce_dma, ring->bounce_buf_len,
> @@ -872,10 +869,37 @@ static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
>  		memcpy(urb->transfer_buffer + seg->bounce_offs, seg->bounce_buf,
>  		       seg->bounce_len);
>  	}
> +done:
>  	seg->bounce_len = 0;
>  	seg->bounce_offs = 0;
>  }
>  
> +static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
> +		struct xhci_ring *ring, struct xhci_td *td)
> +{
> +	struct xhci_segment *seg;
> +	unsigned int i;
> +
> +	if (!ring || !td->bounce_seg || !td->urb)
> +		return;

Tiny optimization nit: !td->bounce_seg is by far the most likely case,
so it could be first. The others guard against bugs and "never happen".

> +
> +	/*
> +	 * A TD that spans more than two ring segments crosses several link
> +	 * TRBs, and may have been aligned with a bounce buffer at each of
> +	 * them. Every bounce buffer lives on the segment whose link TRB it
> +	 * was needed for, so walk all segments the TD covers, starting at
> +	 * the first one that was bounced.
> +	 */

Hmm, AI patch? I think most people would write it like below :)

/* we have the first bounced seg, find and unmap all of them */

The code looks correct, though I would do it differently: store the
last bounce_seg and run the loop from td->start_seg to td->bounce_seg.
This avoids adding the 'if' during enqueue, and still works correctly
if the TD wraps around the whole ring so that end_seg == start_seg.

The driver is never supposed to create such TDs (they break the ring
expansion procedure) but I prefer more robust code if it costs nothing.
Bugs happen, or expansion could theoretically become more flexible.

Regards,
Michal

> +	seg = td->bounce_seg;
> +	for (i = 0; i < ring->num_segs; i++) {
> +		if (seg->bounce_len)
> +			xhci_unmap_one_bounce_buffer(xhci, ring, td, seg);
> +		if (seg == td->end_seg)
> +			break;
> +		seg = seg->next;
> +	}
> +}
> +
>  static void xhci_td_cleanup(struct xhci_hcd *xhci, struct xhci_td *td,
>  			    struct xhci_ring *ep_ring, int status)
>  {
> @@ -3674,8 +3698,15 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
>  						  &trb_buff_len,
>  						  ring->enq_seg)) {
>  					send_addr = ring->enq_seg->bounce_dma;
> -					/* assuming TD won't span 2 segs */
> -					td->bounce_seg = ring->enq_seg;
> +					/*
> +					 * A TD spanning several segments can be
> +					 * bounced once per segment boundary it
> +					 * crosses. Remember the first bounced
> +					 * segment, the rest are found by walking
> +					 * the TD's segments on completion.
> +					 */
> +					if (!td->bounce_seg)
> +						td->bounce_seg = ring->enq_seg;
>  				}
>  			}
>  		}
> -- 
> 2.55.0
> 
