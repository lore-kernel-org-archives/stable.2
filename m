Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7B041A90B;
	Tue, 11 Aug 2026 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437786; cv=none; b=I2M3nlfFTpNAEItZyvzf4pwcZIFEvQwH1g7f6PdBx3pD8/96irESQ4W6FR7Nr5q485sFp1lhFLMzO+prkseU4XO2km+9zoku9CvxQ52elQQeGHDawYk2OPQ5uDAqEfAw4/Xy2oFfUo7mtE1Py3QN2grSchO1zQPsu24jCwNUDL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437786; c=relaxed/simple;
	bh=fvGpAqoPKNWeTB6K1VOh61RfLFR+Rn98mScWypWgwG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3hoDUOozZgpZTuBhT+HF0Ezl0PDd+eX4pFGuF74KpkCUMPRK/Zbzey+DLPG8+XijkWhk3mjDPlkpazxiaGI0Zhw47q8MZiW1rP+X86LqTsVkFEJ5z6veBZxAWaM6phEMfIxtIvyZ7T7vT63fY7h8oPlG2gtXSdhOaYCMLy51+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kH3n2AsQ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kH3n2AsQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786437784; x=1817973784;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fvGpAqoPKNWeTB6K1VOh61RfLFR+Rn98mScWypWgwG4=;
  b=kH3n2AsQS4g27B9ksZh/R1bk1rH8D0kFqTeyBjWkugsr9taD2aIdb1oz
   ZvzXmGeGO+4oIItfN2c8eNilgb9scxLeDx/4Hi+0XQnSfhFeG67TlAeJx
   rXGvci7ZHGce6RI7r1B2deQ3tpQaQ0y0//19hQMeoxJwyuuh5LYNg+eEU
   yTcSN3mVuIR0YptB8rHw9BpJeVAChl6CVvotwSf0YeY2Q9XWIDGSiGf4e
   iEnDAfgijK78KE7RMEBTeL5+cgT+d03S2qHZBDYQE5TF5GntR1KRypuop
   0rmKuGDBvni7Xd41uFYdGNVDb/L31y0F6sJWv3EezB7uETqDDi+9SErWR
   w==;
X-CSE-ConnectionGUID: oRHbI3/hQ4OuebzGZX01Qw==
X-CSE-MsgGUID: y0bMy3ddTQiqBmhh/KBT8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86724517"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="86724517"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 01:43:04 -0700
X-CSE-ConnectionGUID: Hn3muphfQPCiOlpPf8a16A==
X-CSE-MsgGUID: TY5XEkFrQoSqHEIEkU0E4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="266765886"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.245.8]) ([10.245.245.8])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 01:43:04 -0700
Message-ID: <d6148428-af5b-47f8-996a-6be4ff216b1e@linux.intel.com>
Date: Tue, 11 Aug 2026 11:42:52 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xhci: fix lost bounce buffers on TDs spanning several
 ring segments
To: Arthur Gautier <baloo@superbaloo.net>, linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260811033508.1050148-1-baloo@superbaloo.net>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20260811033508.1050148-1-baloo@superbaloo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/26 06:35, Arthur Gautier wrote:
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
>    device-mapper: verity: 8:2: metadata block 10850 is corrupted
> 
> A reproducer running this under qemu is available at
> https://github.com/baloo/xhci-verity
> 
> The bounce state (bounce_buf, bounce_dma, bounce_len, bounce_offs)
> already lives on the ring segment, so there is nothing extra to track.
> Keep the first bounced segment in td->bounce_seg and, on completion,
> walk the segments the TD covers from there up to td->end_seg, handling
> every segment that still has a pending bounce.
> 

Thanks, nice catch.
I didn't expect bulk TDs spanning three segments.

> Fixes: f9c589e142d0 ("xhci: TD-fragment, align the unsplittable case with a bounce buffer")
> Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Arthur Gautier <baloo@superbaloo.net>
> ---
>   drivers/usb/host/xhci-ring.c | 49 +++++++++++++++++++++++++++++-------
>   1 file changed, 40 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 4f98d8269625..4154e84420ac 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -842,21 +842,18 @@ static void xhci_giveback_urb_in_irq(struct xhci_hcd *xhci,
>   	usb_hcd_giveback_urb(hcd, urb, status);
>   }
>   
> -static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
> -		struct xhci_ring *ring, struct xhci_td *td)
> +static void xhci_unmap_one_bounce_buffer(struct xhci_hcd *xhci,
> +		struct xhci_ring *ring, struct xhci_td *td,
> +		struct xhci_segment *seg)
>   {
>   	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
> -	struct xhci_segment *seg = td->bounce_seg;
>   	struct urb *urb = td->urb;
>   	size_t len;
>   
> -	if (!ring || !seg || !urb)
> -		return;
> -
>   	if (usb_urb_dir_out(urb)) {
>   		dma_unmap_single(dev, seg->bounce_dma, ring->bounce_buf_len,
>   				 DMA_TO_DEVICE);
> -		return;
> +		goto done;
>   	}
>   
>   	dma_unmap_single(dev, seg->bounce_dma, ring->bounce_buf_len,
> @@ -872,10 +869,37 @@ static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
>   		memcpy(urb->transfer_buffer + seg->bounce_offs, seg->bounce_buf,
>   		       seg->bounce_len);
>   	}
> +done:
>   	seg->bounce_len = 0;
>   	seg->bounce_offs = 0;
>   }
>   
> +static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
> +		struct xhci_ring *ring, struct xhci_td *td)
> +{
> +	struct xhci_segment *seg;
> +	unsigned int i;
> +
> +	if (!ring || !td->bounce_seg || !td->urb)
> +		return;
> +
> +	/*
> +	 * A TD that spans more than two ring segments crosses several link
> +	 * TRBs, and may have been aligned with a bounce buffer at each of
> +	 * them. Every bounce buffer lives on the segment whose link TRB it
> +	 * was needed for, so walk all segments the TD covers, starting at
> +	 * the first one that was bounced.
> +	 */
> +	seg = td->bounce_seg;
> +	for (i = 0; i < ring->num_segs; i++) {
> +		if (seg->bounce_len)
> +			xhci_unmap_one_bounce_buffer(xhci, ring, td, seg);
> +		if (seg == td->end_seg)
> +			break;
> +		seg = seg->next;

The ordering above needs tuning.

This could call xhci_unmap_one_bounce_buffer() for a segment bounce buffer that
belongs to a later TD, not the one we are currently handling
  
The solution idea looks good otherwise

Thanks
Mathias

