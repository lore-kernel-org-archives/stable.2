Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D1A46D095;
	Thu, 10 Sep 2026 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037761; cv=none; b=RuUfyFFJlQZ+ceaTmQCMxSWmRMjOIKeEYkhMhwRzyuioDq/DEk6V8qHTMcsp8gLa5Eg1HXMuexHMIjWjpZfXpkMsyl4XLK/9ctAGYOAQdbTeYiopzNUC+757G/7l/mWLmcX7XqvdcMaYhYnvUrB1/9jJq2XqmkesryKmeUIOYPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037761; c=relaxed/simple;
	bh=xUmNq+h8P5GOEqnP5pSs7V6mHwoQfX21xBNIHagQvog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuZQGK3jU7SPjKRDWl9v6GtxqtQpNt9+5v6c1FobLvx+jqlBC9pAA8QFOZ0LLIBqgCB9JH3zbGhEc431YlW9AGLX2N3NK8BvTZRs+nBDGtwH0p6oy52uX9va0Pu0rdVG0uXIBS5tiynzn0hn21YMjB4s2rs/Um4MdsHBfPPrk+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sc/Krtey; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sc/Krtey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEC91F00893;
	Thu, 10 Sep 2026 10:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789037750;
	bh=i0k/HI/bcvlOdY3uUk2PaTWHvR+HLRCqNH8Ek21Htnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sc/Krteyn26A4LgEQxcaQ3aIGJQrPiYPJoPeNp7tZ/hRMWj3NuGHWMPxFTWsGav5x
	 wptWbvudyVSj5LZah6hldUObO9gJUrw/FqALJrudU8w/ZQ6XvreENhQGhT5jqQCTlL
	 wSmYrFeJXRNV1yMOF7JEX2SjiQFpGARrQ57co0kwAGpS5uPPI5kaqKKFygGvNWIi/k
	 aAVPHnzVr63YkXDJzeXXEFWAGhCbsXdCoT6gg9W8eA4SNsvVlbC0YCx6d/o+PtdzIV
	 qZFNSKXnlpZpABb2WgKchhgOH+kvgIFxRFGXgBTsZ7GiiBy7ulWCz+t5k96ldf1zZR
	 UGrWVYbSz/0Fg==
Date: Thu, 10 Sep 2026 11:55:44 +0100
From: Will Deacon <will@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Christoph Hellwig <hch@lst.de>, Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH 0/2] ARM: preserve DMA_FROM_DEVICE buffer contents
Message-ID: <aqKMsKpYnAZOoKQo@willie-the-truck>
References: <20260910063620.17768-1-kmehltretter@gmail.com>
 <2ea28a17-f36f-4dfb-8e2a-375e7a3a4d6b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ea28a17-f36f-4dfb-8e2a-375e7a3a4d6b@app.fastmail.com>

On Thu, Sep 10, 2026 at 11:14:28AM +0200, Arnd Bergmann wrote:
> On Thu, Sep 10, 2026, at 08:36, Karl Mehltretter wrote:
> > This series prevents a DMA_FROM_DEVICE map from discarding CPU-written
> > buffer contents on non-coherent 32-bit ARM. It is based on
> > v7.3-rc1-324-g986c24e0fe44.
> >
> > ARM currently invalidates these buffers before the device writes them.
> > If the device writes only part of a buffer, discarded dirty cache lines
> > can expose older memory contents in the untouched bytes. A stock USB
> > webcam demonstrated this through usbfs. Short isochronous packets left
> > gaps, and usbfs returned non-zero data to userspace from bytes it had
> > cleared.
> >
> > arm64 changed this handoff from invalidate to clean in 2022 with commit
> > c50f11c6196f ("arm64: mm: Don't invalidate FROM_DEVICE buffers at start
> > of DMA transfer"). Arnd Bergmann's 2023 ARM32 cache-maintenance series
> > left DMA_FROM_DEVICE preservation unresolved [1]. This series keeps the
> > existing ownership hooks.
> 
> I think the main problem here is that we remain inconsistent about the
> rules across CPU architectures, and changing Arm on its own does not
> mean we have a solution if another architecture decides to change it
> in the opposite direction at some point.
> 
> I see this as a tradeoff that can go either way:
> 
> - the current 32-bit Arm approach (also arc, hexagon, microblaze, mips,
>   nios2, openrisc, powerpc32, sh) is obviously faster as it avoids
>   the writeback, but it relies on device drivers to ensure no stale
>   data can leak back into userspace.
> 
> - Will's patch changed arm64 (later copied into riscv) to avoid that
>   risk by adding the overhead out of caution, and avoid having to
>   audit and fix all drivers.

How would you envisage fixing a driver for this? There were two issues
I tried to address by moving from invalidate to clean on arm64:

1. If the DMA transfer didn't write every cacheline in the buffer, then
   we could expose stale data in the gaps.

2. If the buffer has a pre-existing userspace mapping, then we expose
   stale data during the window between the DMA map() call and the DMA
   itself.

Fixing (1) in the driver would presumably require it to walk through the
buffer after the transfer and zero all the gaps, with an appreciation
for the cache writeback granule (!= cacheline size) and then (somehow)
clean those parts back to the PoC. Is that something any drivers attempt
today?

Fixing (2) in the driver would presumably require ruling out the
possibility of a user alias, which sounds hard and possibly ABI breaking
for some drivers (depending on how they manage their buffers).

> If we decide to align with arm64/riscv and take your series, I think
> we need two more parts:
> 
> - actually measure the performance overhead: you already did the
>   work to test this on three separate arm implementations but did
>   not share performance numbers.
>   Can you quantify how much this costs us on the hardware you used?

It's worth noting that many Arm CPUs upgrade invalidate to
clean+invalidate (either due to the micro-architecture, errata or because
of virtualisation).

Will
