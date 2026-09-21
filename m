Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC124229D0;
	Mon, 21 Sep 2026 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026520; cv=none; b=ppmAtBHTfABmt2q/tg1mDxxzXTsTle8MHLVs2mqMhDdzki7eHPFDpAs5TmixTWpqEf7oRmRKvg7WVlx0+SYjQzkjXBKQyE+IkoAtrTrmM4yFuKcidmJc4NM4WCJTgC0Php33HL8eZtKKyTsaN4cdf4B9YPe8ZC+Q5MbohjJOxUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026520; c=relaxed/simple;
	bh=7fOTAA7ZcmfqwJu/P60o8illbmZgsi/jmWdrzU8wmI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guMKZIE1Q5k+VVyv7eVjs+imyyfO9xwTOOoNsFzjQNiYipJuBfAamu0d/2OynRTDx4Q8M3PF6SlI6pkntASI9yW12WpGumjPqdEj3auC+k7a8AgpCYOuYJJVvynSVyhpPZKOvJBtBLeZ/YSaSsMAnQqK82bz4WbXKUH/smPRwPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpuhC84Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpuhC84Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4801F000FF;
	Mon, 21 Sep 2026 21:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790026519;
	bh=fSi4kTLIQyicDj+2gBx5f5KpFQCapmxSCyy7S7LRq6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IpuhC84YVmWqpY/bCuDYY6ceyL2xyk/KkHPrtnFo9ElVxW1v/kgiMOZauQU7+zk06
	 E/Io7TkC+IF7q79ZWLxrkTG6HPZmobOcI+B1CZ4NoQXi+sXXXqZieLYrAYO5zvja2B
	 zltFXJ0bxInESQm/866GRW3YPqlHA/9cQi6GCZaJn11AUZjK6NrqXA1dLTEhEdRN8/
	 myCbyXLMMHO38q2Fi14jT/FrWo2RwaJy5uLltE3bXvKBH0jQc0PsL9bYhJCEN3+AFr
	 sZ2ljitco0bDbvxbu5Ea+COQ7HSGWTML4+fmikvGda3Ypjz8PuE2M0M4t+AH9mly+f
	 JvhbHnsn4FZuw==
Date: Mon, 21 Sep 2026 14:35:19 -0700
From: Kees Cook <kees@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Anton Vorontsov <anton.vorontsov@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Colin Cross <ccross@android.com>,
	John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] pstore: reject persistent RAM zones too small for
 the buffer header
Message-ID: <202609211431.11176F76@keescook>
References: <20260921202317.70595-1-parri.andrea@gmail.com>
 <20260921202317.70595-3-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921202317.70595-3-parri.andrea@gmail.com>

On Mon, Sep 21, 2026 at 10:23:16PM +0200, Andrea Parri wrote:
> persistent_ram_buffer_map() computes
> 
> 	prz->buffer_size = size - sizeof(struct persistent_ram_buffer);
> 
> without checking that size is large enough to hold the header.  A
> ramoops zone configured with a tiny size (e.g. ramoops.pmsg_size=1)
> underflows buffer_size to a huge value, which defeats every bounds
> check in persistent_ram_write() and persistent_ram_write_user(); a
> write to /dev/pmsg0 then copies user data far past the end of the zone
> and corrupts kernel memory.
> 
> Reject zones that are not larger than the buffer header.
> 
> Fixes: 404a6043385de ("staging: android: persistent_ram: handle reserving and mapping memory")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  fs/pstore/ram_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> index b4ec8009b8dc9..ae941777037b8 100644
> --- a/fs/pstore/ram_core.c
> +++ b/fs/pstore/ram_core.c
> @@ -505,6 +505,12 @@ static int persistent_ram_buffer_map(phys_addr_t start, phys_addr_t size,
>  	prz->paddr = start;
>  	prz->size = size;
>  
> +	if (size <= sizeof(struct persistent_ram_buffer)) {
> +		pr_err("%s: persistent ram zone too small (%#llx bytes)\n",
> +		       prz->label, (unsigned long long)size);
> +		return -EINVAL;
> +	}

Whoops. Luckily it's all system-owner or hardware defined (hardware
probes, and boot params).

I wonder if it should return ENOSPC instead, though?

> +
>  	if (pfn_valid(start >> PAGE_SHIFT))
>  		prz->vaddr = persistent_ram_vmap(start, size, memtype);
>  	else
> -- 
> 2.53.0
> 

Thanks for finding this!

-- 
Kees Cook
