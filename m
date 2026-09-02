Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247CB476CE9;
	Wed,  2 Sep 2026 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356235; cv=none; b=OGoN+ItwjWC3Q0UggAHktlqhLC1JXu2DQR1gsEsomsYeVohNLH4mR++x1c82bonC0/3wBxguKRJxelzy/c3ZOTT1FdGi27b9v9C8zDvutHrM150BhXBZVjWeknpBFd1gPL4W77q7kQcrTi5ilZ5RXy/vvdZ6yr13i/4EeXBmZaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356235; c=relaxed/simple;
	bh=O4cqBsuXyIq3DmlrPfvvAeFwt8HqIkB5EIMQmeEUJ0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhhVshasamOHPwfjpdOtLD64ql1i29YsSzhhS7tg1aByP/osXPoskz9swBQHhLNcB5OQc+KlwYevn4hD9ukLJKkLY0m0O104s9QXugDj1ztPIuXU5JqKUOTxIPllE0G9TOk+iNbxsynNnsfc21uUDVsxwW/w/EBHle9Xf+SjHbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B50AE68C4E; Wed,  2 Sep 2026 15:37:07 +0200 (CEST)
Date: Wed, 2 Sep 2026 15:37:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] xor: add missing vzeroupper to AVX code
Message-ID: <20260902133706.GA21538@lst.de>
References: <20260831212248.213805-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831212248.213805-1-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 31, 2026 at 02:22:48PM -0700, Eric Biggers wrote:
> Since the AVX optimized XOR code uses YMM registers, execute vzeroupper
> before returning from it.  This is needed to avoid degrading the
> performance of any later SSE code that may happen to be executed.
> 
> Fixes: ea4d26ae24e5 ("raid5: add AVX optimized RAID5 checksumming")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> 
> This didn't get taken through the x86 tree.  Andrew, it seems you're
> taking patches to lib/raid/.  Can you apply this one?

Can we do kernel_avx_{begin,end} instead of having to open code
and document this everywhere, please?

