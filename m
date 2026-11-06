Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793947745;
	b=JpX83hIwDjmUPZ14juBKWU/m70PcSgGSsH2QLVye5XifV21gmvbSADMVh9j+iYHeB3dd
	 1cdjNRV8B4wFz7OWAK6k8M6Fkc8RnVtsmnScn9+PMXYxiYiSp9vwXdLVM9t1g4CP6LiQj
	 7ShPlsN4niG7oqhUpixhk1iVy2zfYlaA27rqtZbbbf3FI+VQBqI7jXzChcs/d8z1QZEav
	 I8HErB4yVSdbnwDNige+4njBlLSUUKZP8Oq6Dl96EdoREbk0MLQoZYGL7S0KEY32Fhg1h
	 0KwmUoGQ8nw/A6SkmJCirh4eUWtZFYnJHiTWABeLGaUxsWqY8houPH4It10h9JBT75w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793947745;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=wu1oQVOgc/20Z0C7YFsmJAp66/PX07S+eX43UkLI+xg=;
	b=KTrJ9kuQIuG3H5vibDHNy6Lmlg6omGUYXLNjTBUFtNoqU4IB5+HXngR7TmItoNqH9sq2
	 5rSL/+90zMIsxn9UrmtSXEKfwuMYaIqumFXVujxHWvp9Sdy7O0Xremce7s+fFLnncRxPA
	 KcRj5dYT81YKnFbYiwswzEUOIhaAKOmWKvm223kXPJBucjS6V/1Pt4BxaN1qln2APyDQH
	 5pl6QNoAibkiA15QmjuKxarlgjRxtLJrDkgozCO7Vvkcu2BEde4eEGPTzNheq/EseX/hP
	 f9GbLJZ4Dunh2FB7yJR6RchDSJqI0k41IgPZ5Xc6ot4PKZAWvyeL4QKWROkFZeyYzfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DCF606A326;
	Fri,  6 Nov 2026 06:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2DCF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 256CE92009E; Fri,  6 Nov 2026 07:49:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 1E1CD92009C;
	Fri,  6 Nov 2026 06:49:02 +0000 (GMT)
Date: Fri, 6 Nov 2026 06:49:02 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Imre Kaloz <kaloz@kernel.org>
cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    linux-mips@vger.kernel.org, Paul Burton <paulburton@kernel.org>, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: mm: Fix the cache error vector jump for XKPHYS
 kernels
In-Reply-To: <20261021185709.22561-1-kaloz@kernel.org>
Message-ID: <alpine.DEB.2.21.2611060611100.17804@angie.orcam.me.uk>
References: <20261021185709.22561-1-kaloz@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 21 Oct 2026, Imre Kaloz wrote:

> diff --git a/arch/mips/mm/cex-gen.S b/arch/mips/mm/cex-gen.S
> index e528583d1331..6989fe274aab 100644
> --- a/arch/mips/mm/cex-gen.S
> +++ b/arch/mips/mm/cex-gen.S
> @@ -37,6 +38,21 @@
>  	nop
>  	nop
>  
> +#if defined(CONFIG_64BIT) && VMLINUX_LOAD_ADDRESS >= XKPHYS && \
> +    VMLINUX_LOAD_ADDRESS < XKSEG

 Not VMLINUX_LOAD_ADDRESS < CKSEG0 to take care of CONFIG_MAPPED_KERNEL?
Of course we'd have to switch caching in the wired TLB entry then too, but 
at least we won't crash outright...

> +	/*
> +	 * An XKPHYS kernel may lie outside the 256MB region a j from the
> +	 * vector reaches, so jump to the handler's uncached XKPHYS address.
> +	 */
> +	PTR_LA	k0, cache_parity_error
> +	PTR_LI	k1, TO_PHYS_MASK
> +	and	k0, k0, k1
> +	PTR_LI	k1, UNCAC_BASE
> +	or	k0, k0, k1
> +	jr	k0
> +	nop

 Given that this runs at ERL, a much shorter sequence could look like:

	LEAF(except_vec2_generic)
0:
	[...]
	PTR_L	k0, %lo(0x100 + (1f - 0b))(zero)
	jr	k0
	 nop
1:
	.quad	cache_parity_error
	[...]
	END(except_vec2_generic)

but I guess it doesn't matter that much as long as we don't overrun the 
exception handler slot, since this is obviously not a hot path.  Still it 
could be considered neater, couldn't it?

  Maciej
