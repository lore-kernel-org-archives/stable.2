Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A717238E8C9
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116031; cv=none; b=lKZm+pMGh+fYcSLVZlLyw5U492CHHCAcvxCOpE43ZjRMqDYS7mX47hAzIjxvWR37l/hlJzKE/2aJRJXomWVukMN44C0MDCBNOIi7Y9hnpk7ryPt9rB17GF5EO2MW/CNu9eAtxFyrlraJOozzW91NDI+9ZZnHaPKW1l5CuHn6rJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116031; c=relaxed/simple;
	bh=F6H+rAEwAFlvo2vcoaq3mMaDhsIksTBUqphzpxP80WY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnZI06ecKL/oM55jiLws34wr4Rfj21rWP9EluFpno3EPoa/3PKHwie7PEMd4Hjp1YOpyLmg3ibXO7s7n3VYSji+NX12ugysqDrT+i+lI/TvzK2/Q0zhiyPahKEvE4e90jFE8V4RPgMCb9qvRU4MSdr1KRN1rkKSt+Z1SpCuK2vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYadQOo4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYadQOo4"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b9318997so27156165e9.2
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 01:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782116027; x=1782720827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y69DNLtkcPX106ySVX6ZlNH6S9rjQScn7EBr8UTU9k0=;
        b=mYadQOo46NcgaU12CxB9GSPlIIegnCNLdCNhSOyW/I+Xy07v53GHjb50/R+GSFI+uR
         YlfBTbDf95ZxaB/UL/7XxShjkXDQD2vQ09dYUezg8LsqE0eDEIUsFBaQut53YdNbx3eO
         cJYu+JGbxn302NwD1+7xmLweKbs+aIfxkrSyQv2gQHvgLtNUfY5PPhFvCdz0vUe1cvi0
         itW/cqtzbndpD86fPZZMZD03nuRNiJ6g1ijby3UiOPkjZXtsZwdDfCrmpkdXd6SM0zSO
         Gj1NCfGLVSTpe5zsqhmplOlaFb5PhD8s1Jk+ifwjkZhxHZzFqL/da7BZ6D9tFxKu9DZp
         YToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782116027; x=1782720827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y69DNLtkcPX106ySVX6ZlNH6S9rjQScn7EBr8UTU9k0=;
        b=ecdr01WNA6C6OFkHj6XCNElMOr6yLSUQtJEoW36PCnMEvIm4rq5JOYFgFlxJ+F15wd
         LBtTgc8wZjm5n5k6Sw0i5YUujWPhdTLklbvOSgkL2gGj84I0LB+tTZrl7P4kOIC3Lh04
         wHdcrOeTY+u2dhvB7kLW96tBuxCu1APjZgWho63lXpTGOMPx4d4VVBpWjZpnxFJmCwNp
         8mWQ0sIkk6aIaTt+Xdtj7gBE+DpgOZ09x8+cKUmMVGWrExycTZqTNfY24bnniYvCWlQU
         /DKXKP7y8+jU7Ot4paRgRWL1sKf029k2x8qgkjiuHlyocHQEzszVCJ37EvXuRSvV0dOO
         xfUQ==
X-Forwarded-Encrypted: i=1; AFNElJ8CoOOaz1UGex7uQnQf/GANq5HoMWg0CR2sl9wuzmFlEofg54fY6I8Pa1853vi2INkMYtS/1HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeMFMMXofq6UUGf5lvdkjuHZlyutJYum/LcYi4KSfc6bkoJjZy
	ZmAzCuKesU079nWHdoWnRrxTZSXdLPHeZwEv0fQsBKvQiwOgCuceC/IE
X-Gm-Gg: AfdE7cnuoQv6ClDAYwC5Dd0+DSb4lcIy93JsGGWHKmOFmYPGd9zKbAQY1bfqxmiO37R
	ilMgToQ0dNGr657GjEk8C9iJbkTEM20P7Mp1lzz/fikgBLxpXioP/tRKBw9Qm8zvw03IQJMIVKJ
	hR/8V/1DblX7fyzoTLZDRy9KJGAyC30mRISRsebRZg9wdOiHCT/q0S4TIewwDV7HJHP/94SPhtp
	7ps2STNnXVsCMpw3sJayETcCWBXBRUIMgRD8oSTpIuKoxWUe8O+tl/E0Lr8UYbzy61wlM3mjXXX
	c078Qy+KDdMvd+9FGJCEnmFqwYhRuLU7ke45CKJ60XoG6FeYiXUCCCrFCSaV15n5v4x4jmC2JUu
	bXQUdSYoKEgtPPtVSVlMFERJOFSxx256HKwIvp3rMXeYyubzsK5NhbEzMwIXvgA6qqadKQiftHW
	apFL3lnCJvp6P8h1DU4Jj4KOoAL4VXjMUDBgYbVEyhBb3DkoPATw==
X-Received: by 2002:a05:600c:8719:b0:492:4c60:bfb8 with SMTP id 5b1f17b1804b1-4924c60bfdemr121648545e9.28.1782116026585;
        Mon, 22 Jun 2026 01:13:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd30078sm274806595e9.7.2026.06.22.01.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 01:13:45 -0700 (PDT)
Date: Mon, 22 Jun 2026 09:13:44 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Hu <xuehaohu@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen
 <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Kevin Tian
 <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com,
 praan@google.com, kpberry@google.com, sashiko-bot <sashiko-bot@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH] dma-buf: Split sgl by largest page-aligned chunk
Message-ID: <20260622091344.794e0d74@pumpkin>
In-Reply-To: <20260621222130.1667453-1-xuehaohu@google.com>
References: <20260621222130.1667453-1-xuehaohu@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Jun 2026 22:21:30 +0000
David Hu <xuehaohu@google.com> wrote:

> Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> first entry, resulting in non-page-aligned DMA addresses for all
> subsequent entries.

How did you find this?
It requires a single buffer over 4GB - seems highly unlikely.


> 
> While the underlying IOMMU mapping may be contiguous, hardware
> DMA engines often require explicit address alignment (e.g., page,
> cacheline, or storage sector boundaries). Passing unaligned
> addresses and lengths can cause explicit failures in DMA descriptor
> creation or silent data corruption if lower unaligned bits are
> truncated.
> 
> Fix this by splitting the scatterlist by the largest possible page
> aligned chunk within `UINT_MAX` (`ALIGN_DOWN(UINT_MAX, PAGE_SIZE)`).
> This ensures all scatterlist DMA addresses and lengths remain page
> aligned and satisfy hardware constraints.

It would almost certainly better to spilt into 2G chunks.
That removes any need for any divisions.

> Page-aligned entries allow the system to cleanly chunk payloads into
> PCIe MaxPayloadSize (MPS) (e.g., 128 bytes, 256 bytes, 512 bytes).
> As a result, this may help reduce TLP fragmentation in P2P transfers
> and alleviate potential congestion within a logical PCIe switch
> partition, especially when Relaxed Ordering is not possible due to
> hardware constraints.
> 
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260609165431.778061F00893@smtp.kernel.org/
> Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hu <xuehaohu@google.com>
> ---
>  drivers/dma-buf/dma-buf-mapping.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
> index 794acff2546a..f2bde38fdb1f 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
> @@ -5,6 +5,9 @@
>   */
>  #include <linux/dma-buf-mapping.h>
>  #include <linux/dma-resv.h>
> +#include <linux/align.h>
> +
> +#define MAX_ENT_SZ ALIGN_DOWN(UINT_MAX, PAGE_SIZE)

>  
>  static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
>  					 dma_addr_t addr)
> @@ -12,9 +15,9 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
>  	unsigned int len, nents;
>  	int i;
>  
> -	nents = DIV_ROUND_UP(length, UINT_MAX);
> +	nents = DIV_ROUND_UP(length, MAX_ENT_SZ);
>  	for (i = 0; i < nents; i++) {

Why not change that to 'while (length) {' to avoid the division above.

> -		len = min_t(size_t, length, UINT_MAX);
> +		len = min_t(size_t, length, MAX_ENT_SZ);

I bet that doesn't need to be min_t()

>  		length -= len;
>  		/*
>  		 * DMABUF abuses scatterlist to create a scatterlist
> @@ -24,7 +27,7 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
>  		 * does not require the CPU list for mapping or unmapping.
>  		 */
>  		sg_set_page(sgl, NULL, 0, 0);
> -		sg_dma_address(sgl) = addr + (dma_addr_t)i * UINT_MAX;
> +		sg_dma_address(sgl) = addr + (dma_addr_t)i * MAX_ENT_SZ;
>  		sg_dma_len(sgl) = len;

Replace the multiply with 'addr += len'.

-- David

>  		sgl = sg_next(sgl);
>  	}
> @@ -41,14 +44,14 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
>  
>  	if (!state || !dma_use_iova(state)) {
>  		for (i = 0; i < nr_ranges; i++)
> -			nents += DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
> +			nents += DIV_ROUND_UP(phys_vec[i].len, MAX_ENT_SZ);
>  	} else {
>  		/*
>  		 * In IOVA case, there is only one SG entry which spans
>  		 * for whole IOVA address space, but we need to make sure
>  		 * that it fits sg->length, maybe we need more.
>  		 */
> -		nents = DIV_ROUND_UP(size, UINT_MAX);
> +		nents = DIV_ROUND_UP(size, MAX_ENT_SZ);
>  	}
>  
>  	return nents;

