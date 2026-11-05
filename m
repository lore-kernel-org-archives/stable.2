Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872840;
	b=DgOu6aldr3yj9F0WWiD078QQiISSQ1gemiMqRBMOP2dOcXCJ2CFWbT03DkL+ShUEOPDt
	 83TO4o0LJRapRJ5QcJymf/SxIt5v+xBhprFCj3FTRITvSGxl3XKV7CqinIzoVV29lG2TW
	 Ox576Ja/vULQc4poB0xYtLSeF2nUXkoRbMoTSFQmTyYYq58hczbQo6hYGfEiibRnya4gb
	 dTzqjbX0LztWR4X3fIXNSCzS9rOydX+bIFn23JYtblhxICX3WbPUwmBL3Qlg+1F6beExd
	 ZSZ+S5uEXdAmhFci5JQEIzQTceeTRNvyOrvazIS8Xg9QVapRbCLimyLM63Jaya58K2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872840;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RGrCpm98nfFc36ckFB0Am9EO9qX6FTFJ6f1d4Ty4H3M=;
	b=V0BVgRYKP01fmC4zApPumkNJO0Eupi2JlK3m3s1R7pzTRycxzzvGVVhYKY/2e0tw3yVp
	 t2Ci60Ydmro1IvbItWwgd/iN74VM5fXfANF+YwEnNDVH6lpWGPRWSD3FWLzTvZkYXx4R5
	 PwixIbt2rZGqgkpa0T7TXm6HGTj7aHjOWEqV0xVqmr+IB+0DWDbxVYRohQiaiF/m0U1ll
	 d3jSC7c2h1my9m1xCpMbGMOLxmHwgM1NiTer4+dFaGFYykKSnuLYyhnnMKEyBpw1ETCC+
	 nIuG/dmgOuvHRtvmxvQOQ9UNTU6TdzNNSukR1MxYkzOBEI9IezAI9r8FCZGM7F9eStg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUDo1t7x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409AB606A328;
	Thu,  5 Nov 2026 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUDo1t7x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1A81F000C1;
	Thu,  5 Nov 2026 10:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793872839;
	bh=RGrCpm98nfFc36ckFB0Am9EO9qX6FTFJ6f1d4Ty4H3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bUDo1t7xw8a83rTXWT21nRyRGLwNZUd8Dp4TB6RBQN7XdDXprEUGdVgLXDQONY/Cv
	 S2yeNKkiAmoO1aRdGAyozxT0tcGfC42be3IeZAEpFF3kyRiE6+VOaPAIGlunc2xmZ/
	 gJjQw+E8lxM/hDVylWGVUv2c+F7gSHqKGGozOjFeK5OaUF10QXUBSfNsSQh569z6+e
	 nvi6qn+NBzaUiY0ylV48nmC8XNr81hb6xLwtsCu4wdbbO+0t6ySGZFhPxjpQPvoG2s
	 +E5y3O+JNhI9o9nl8EvRmgMyn416AYrW9c2ChA0xCqlnr/kV9+16xM1q1vB49H5Ht6
	 5GS1Y3dpRgw7Q==
Date: Thu, 5 Nov 2026 11:00:34 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: muchun.song@linux.dev, osalvador@suse.de, david@kernel.org,
	akpm@linux-foundation.org, azpijr@gmail.com, lance.yang@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/4] mm: hugetlb: fix GFP mask propagation to CMA
Message-ID: <auxTwrKCeg7a3hfY@localhost.localdomain>
References: <cover.1793850539.git.zhengqi.arch@bytedance.com>
 <ac2de9b321f68c1025333e92e3ce94beadcb0b6c.1793850539.git.zhengqi.arch@bytedance.com>
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
In-Reply-To: <ac2de9b321f68c1025333e92e3ce94beadcb0b6c.1793850539.git.zhengqi.arch@bytedance.com>

On Thu, Nov 05, 2026 at 12:07:45PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> cma_alloc_frozen_compound() uses GFP_KERNEL, allowing direct reclaim
> during the first MPOL_PREFERRED_MANY allocation attempt even though
> the caller clears __GFP_DIRECT_RECLAIM.
> 
> Pass the caller's GFP mask through the helper so CMA respects its
> reclaim constraints when trying the preferred nodes.
> 
> Fixes: 9bda131c6093 ("mm: cma: add cma_alloc_frozen{_compound}()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
...
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -933,9 +933,9 @@ struct page *cma_alloc_frozen(struct cma *cma, unsigned long count,
>  	return __cma_alloc_frozen(cma, count, align, gfp);
>  }
>  
> -struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order)
> +struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order, gfp_t gfp)
>  {
> -	gfp_t gfp = GFP_KERNEL | __GFP_COMP | __GFP_NOWARN;
> +	gfp |= __GFP_COMP | __GFP_NOWARN;

Do we really need __GFP_COMP | __GFP_NOWARN here?
It is my understanding that all allocations coming from hugetlb are
handled with htlb_alloc_mask(), and that should already provide
__GFP_COMP | __GFP_NOWARN.
We might have needed it when cma_alloc_frozen_compound() constructed its
own mask, but not it gets it from the caller, and that should have been
done via htlb_alloc_mask() up the chain.

So, any reason to have it here now?

 

-- 
Oscar Salvador
SUSE Labs
