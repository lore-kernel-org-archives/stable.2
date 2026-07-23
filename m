Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F88C415F11;
	Thu, 23 Jul 2026 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799993; cv=none; b=EthHmA48uEyditzzD1KRcIcvNiD4ZldyWxaEVWz1DSLWoGiicIW2QHbHCQwZ5kjaU0E744/F1fnIOiWQUokSVZY11OsuRbD55WzksL7wK37NoiEBEj0WV51PT3x0OjKqY56avJvC34ItuI7nYHpJdBbPGjVmXuKQG/ixqpvk50g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799993; c=relaxed/simple;
	bh=I51YcB7e+RTugdi4EcB4Djcjqe67zrc/AJsdTHcGQXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bj/tmroXc4w1RHz/ANa4sBdoWi+UAKpHWRGW5/4GMq0SAqv0YH6hGEM0mXcz6a14uhJDrS08y0/y7UBU8zHsuo1tfd5xT3LFC4LolMDEbsYo86B8ZPeN2MMvIQp96d8JH7JFUeu1nVC/3OLSKjNGVhark7c/fvEfq5qpArT+RYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BORfaAEg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BORfaAEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9451F000E9;
	Thu, 23 Jul 2026 09:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784799991;
	bh=c0op309bUfGA0ctk/Gc5xRw/LObUAXSQRptCHu8HqRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BORfaAEge2bgsh1GovGRFQT20U8KHorncsr/Je6lcz0PutT6rInv5N412OjzzkKk8
	 dhQrpekbotopVTjFwaNQK/reH7peBqOamowxX3NHAnHLDLwo7wRJ4Q0yzqxZ7RGBc2
	 mnhyaTvavdKHoJiG6dIfg2QNSRwlznpF0b+D9ceDuUbf6+Xo2kczew4bwaF278ss/x
	 qDUAHZNmNX+HXAbKw5Acszie/fh7C2yo/oqQHjMHEsnTnAogKclcpNYxJAMETetRyk
	 uAgp9PGUeswlZGJ0oK5alUchC6wY7joT8jWl8zJVNayhioHnJ68Ok8ucNqvwDEYpC1
	 SWGKwaK0Tp5kw==
Date: Thu, 23 Jul 2026 12:46:25 +0300
From: Leon Romanovsky <leon@kernel.org>
To: dhu@x6u.co
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Laight <david.laight.linux@gmail.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Pranjal Shrivastava <praan@google.com>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	stable@vger.kernel.org, jmoroni@google.com, kpberry@google.com,
	chriscli@google.com, viursachi@google.com, xuehaohu@google.com,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk
Message-ID: <20260723094625.GE110966@unreal>
References: <20260623015459.1153884-1-xuehaohu@google.com>
 <20260722233932.3997681-1-dhu@x6u.co>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722233932.3997681-1-dhu@x6u.co>

On Wed, Jul 22, 2026 at 11:39:32PM +0000, dhu@x6u.co wrote:
> From: David Hu <xuehaohu@google.com>
> 
> Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> first entry, resulting in non-page-aligned DMA addresses for all
> subsequent entries.
> 
> While the underlying IOMMU mapping may be contiguous, hardware
> DMA engines often require explicit address alignment (e.g., page,
> cacheline, or storage sector boundaries). Passing unaligned
> addresses and lengths can cause explicit failures in DMA descriptor
> creation or silent data corruption if lower unaligned bits are
> truncated.
> 
> In addition, a non-page-aligned sgl length will trigger an edge case
> in `ib_umem_find_best_pgsz()`. In case of a discontinuity in later
> buffers, we will have a `va` with lowest bit set to 1. That will lead
> to `ib_umem_find_best_pgsz()` always return 0, and break the promise
> to find best page size for the mapping on the NIC side.
> 
> Fix this by splitting the scatterlist by the largest possible page
> aligned chunk within `UINT_MAX` (`ALIGN_DOWN(UINT_MAX, PAGE_SIZE)`).
> This ensures all scatterlist DMA addresses and lengths remain page
> aligned, while minimizing the total number of sgl entries.
> 
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
>  Changes in v3:
>  - Removed the type cast for `min` (David Laight)
>  - Reverted max ent size to be `ALIGN_DOWN(UINT_MAX, PAGE_SIZE)` and
>    updated commit message to reflect that (Jason Gunthorpe)
>  - Updated commit message to reflect that this also fixes an edge case
>    in `ib_umem_find_best_pgsz()`
> 
>  Changes in v2:
>  - Updated commit title and message to reflect the switch to 2G chunks
>  - Switch to using 2G as the max sg entry size as it naturally aligns
>    with most hardware boundaries, while allowing compiler optimizations
>    with bit shifts (David Laight)
>  - Optimized away division calculation for `nent`, and multiplication
>    calculation for sgl address, by dropping the `for` loop in favor of a
>    `while (length)` loop (David Laight)
>  - Dropped `min_t` in favor of `min()` to maintain a strict type
>    checking safety net (David Laight)
> 
>  drivers/dma-buf/dma-buf-mapping.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)

Could you please avoid sending patches as replies? It severely disrupts
the reading flow when using mutt's threaded view.

Regarding the patch,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

Thanks
