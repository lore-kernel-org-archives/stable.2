Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193916;
	b=nru/Q+MvajoTIUuwDq/zrbWJTqEagupxgVZfSS4N4uEDQZaDdSasV+yrCWYVcm+Hx0nb
	 I95Ka9HwHnvNGSyH5Ib3A+0MMENpgEYzKNHpd4rqZ7IECR3F+n2jLCYV4qJ+nRL59kk+z
	 zwA145cqXqCWgNHGJaIrFjczRx3mrCOjOT3QwvHbD6Cj718h8QM7JeniBUjlhvUMWjLYC
	 TPCNzZIrmwubt4YwbTLJ91Gg57/HxQnlr+ErANnxqNKx5XUm3c6YaMLjwOmDD9csA8lWf
	 NZVP35cA3emboW0iLg0COxvTVKwG8gXY3smvjn2/ZGWqWTDz8nDcFtahjJBaCihwMsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193916;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jo92MTJLSFrdiLCKlw2dcQIkz3CbU6mfsG4dgoBDLvo=;
	b=bHBfIwtUFCQ0Myzsm8VYs9dkUpvYFThhLhOEytWFknLh4Lh8W8k7t/rP5mEJ4Gif1WUl
	 EBPYlZJtDk9wHtD6GcoAMcgQQxhac4hTZCSiWoeGjIXI/gwcbh6Q6lG/zmySCg45jWwvT
	 8hrSjF9dUwFQxfiH1i1kFWjbNd9zK+627ZvFT/Idg22KS2gklbPGr7t6m/1ue83AbYFH1
	 Zu2e8nXtsbk7XDP33C2z1c4BM+jdoF93HvFgchZiMMO+MSc9tD+gZ4sJrVTmF4ppnbkEl
	 3IoTKaUo3K5Xjxj6EvyV2ic4mEQBhhpUyWnnC3K5AFHnI6rfVrxny1Cf/g2HMDGOs8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQCQiLJK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E76460A2602;
	Fri, 20 Nov 2026 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQCQiLJK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CAB1F000CF;
	Fri, 20 Nov 2026 16:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795193915;
	bh=jo92MTJLSFrdiLCKlw2dcQIkz3CbU6mfsG4dgoBDLvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cQCQiLJKxqw3wrRId8vH/Ymgw9qbdKj/u/RTtWFMBy88IE0w+Nt3/QGSb1DCwRvmv
	 rDL9a2QSN5aeZEw3Yh292FgK+TvlXFsBDHYQ7SisCtaLAqwSi7bQgFB9dzQUt0Awf4
	 ddYuZ9aHNMn7nInJPaHOgGz6/+l5K4hUE1iBiwTHfZdRc+24ILDtP+NyXqEGDuzROA
	 aTe5tq50rQP7jzpKqpKC7T0RSqUIlPAznWovCMPuYFn+aB3tn1nnNVydRqgYP9okKx
	 Ma+SDRG0eInBvRh9be8U+qzqyM7MdhoQqbKr/AjohC+C44RYi4uGBnNYLN0P049N/x
	 K/EeaOLjPXVsQ==
Date: Fri, 20 Nov 2026 09:58:32 -0700
From: Keith Busch <kbusch@kernel.org>
To: Zakaria Belkadi <zakaria.belkadi@inria.fr>
Cc: Christoph Hellwig <hch@infradead.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, florence.schadle@ssi.gouv.fr,
	frederic.tronel@centralesupelec.fr, louis.rilling@irisa.fr,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] block: pin user PI pages for writing when ref
 tags are remapped
Message-ID: <awB8OODx0fCFGc5G@kbusch-mbp>
References: <awBnB-55HQ54C1x6@infradead.org>
 <20261120162257.498238-1-zakaria.belkadi@inria.fr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120162257.498238-1-zakaria.belkadi@inria.fr>

On Fri, Nov 20, 2026 at 05:22:57PM +0100, Zakaria Belkadi wrote:
> Christoph, Caleb,
> 
> Thanks to both of you for the review.
> 
> On Fri, Nov 20, 2026 at 07:28:07AM -0800, Christoph Hellwig wrote:
> > I don't think we can just pin memory as writable that wasn't given to
> > us as writable.  So this needs to force bounce buffering, at least when
> > remapping might be required.
> 
> Agreed. I'll keep the PI iterator as ITER_SOURCE. In v2,
> bio_integrity_map_user() will bounce the user PI buffer for REQ_OP_WRITE
> when the integrity profile has BLK_INTEGRITY_REF_TAG. That way the
> block layer can remap the tags in its own copy.

Can avoid bouncing? I think the remapping flags can be tied to the
user's reftag check request.

If BIP_CHECK_REFTAG is set from the user setting IO_INTEGRITY_CHK_REFTAG
on a write, we can map the PI buffer for writing. The user explicitly
asked to have the ref tags checked by the device, and partitions require
remapping them, so they've told the kernel to write to their buffer.

And if the flag isn't set, blk_integrity_prepare() can skip the remap
for that bio because the request asked to not be checked.
