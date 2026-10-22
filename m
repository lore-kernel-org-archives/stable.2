Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685996;
	b=I7kKgJq1WCAQ57XS0bTRr4LAgBRi/BjNY1vxGXZFF+G56VZ19uqYp3T/DXUceyCa8qL+
	 BQAtEv49+noBiYgetqM8HtWq/IhRuBGZg7ffmfLNhOWbNMMw9v6kmFv8PtvMdkJwLKo54
	 G2619VYe6eGqMbfQJe+upAt+5B8GBvdoCkC9KbxOVpVXBnjN+rVJsj3ktk9h0iswQdlhI
	 HBvu8ohsa6smLVZc6Xebk9trlrCpfe1tojBoahkAXj26Y1/+geR/jVlDey8ZOye2774pA
	 a2TaTIMP+PYI/btuWFFfB2W3lEOZCn+DlaHaUYWfOR3BkMuxX++nR32qUmB4YM0MqJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685996;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=y9vbqmqLcpCnOP8rCU6dU+WcNffa3aBEAiYmP4aZMq8=;
	b=MD0iSeInAJOv6l/poOM5EM7ua8utG1Hdn6QOx3intxNmPCAt7IQXNyIHAAm91jGx0ldQ
	 Iu0QigBAA6GEEcor83/8+J+zK7A9UdHae62YdAtCNRZUcZzOTMbMDUjNdmMSJkdTLiU+r
	 M31ZH3cKGg9kK+C973MlaFsWgziRK2wqHRZB5dkpqFQzrZiAQr0a0A3iepTN5PXCi12F/
	 J4e6WatreovZeAAT9xB0maMsFQnog8nysDWF0W7DgRBfoiL514ZETyw885Da+jW1KD3AL
	 xZS1udHL6PmGoXjgWMMqYCJqBMyDOur+kZnKu2FZ7YJ3SUgewwZaNh6sFWVFIoZfCMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA2C606A31E;
	Thu, 22 Oct 2026 16:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DA2C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 5BFAF92009E; Thu, 22 Oct 2026 18:19:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 5815692009C;
	Thu, 22 Oct 2026 17:19:47 +0100 (BST)
Date: Thu, 22 Oct 2026 17:19:47 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Imre Kaloz <kaloz@kernel.org>
cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    linux-mips@vger.kernel.org, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: c-r4k: Flush the cache error vector before writing
 it uncached
In-Reply-To: <20261021190020.20954-1-kaloz@kernel.org>
Message-ID: <alpine.DEB.2.21.2610221709330.22065@angie.orcam.me.uk>
References: <20261021190020.20954-1-kaloz@kernel.org>
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

> On R10000-class CPUs, a store prefetch while copying the preceding
> vector can leave a dirty line whose write-back overwrites the uncached
> cache error handler. Flush it first in r4k_cache_error_setup() with
> r4k_dma_cache_wback_inv(), as dma_cache_wback_inv() is a no-op on
> coherent systems.
> 
> Fixes: e01402b115cc ("More AP / SP bits for the 34K, the Malta bits and things.  Still wants a little polishing.")

 This is surely not the right commit to pick, as that was merely code 
refactoring and the issue existed before it.

> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index d8aadd3dc057..ae31966ac65b 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -1684,6 +1684,14 @@ static void r4k_cache_error_setup(void)
>  	extern char __weak except_vec2_generic;
>  	extern char __weak except_vec2_sb1;
>  
> +	/*
> +	 * The handler is written uncached. Copying the preceding vector
> +	 * may have left a dirty cached line of it behind, through a store
> +	 * prefetch or a speculative store; write it back and invalidate it
> +	 * first, or its later write-back overwrites the handler.
> +	 */
> +	r4k_dma_cache_wback_inv(ebase + 0x100, 0x80);
> +

 Conceptually this seems right to me, however I think the call ought to be 
moved into set_uncached_handler() itself.  Also since you're repurposing a 
DMA handler, which the removal of CONFIG_DMA_NONCOHERENT wrapping makes so 
obvious, this asks for the function to be renamed.

 Thank you for your submission overall.

  Maciej
