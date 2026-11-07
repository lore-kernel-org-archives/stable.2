Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794070979;
	b=p921VeHwt7Pda6IDvqNsx6BxRN4xHoFNDmiZ3zZgjjR50taHG0i9A580l4sPnTpxcWvh
	 inOBk47xEjUCBuu5aloqlSLorpADVTnj7s9yZjS8lB7f2rEy839dy18yb1tn7hU7lhcI2
	 InJjvG/tei/B19s03b4oHJ/a3lmzZ5pCyse+0ZVV9rdRAJDVmuL+R4X6KJiF+94cCYD/1
	 i06q6rc5PVeAdzAzYSe6py50YN53mSuK/nuKPECJUXpXHWbWuXalfuYkpLeo2wQozZ5FL
	 1QMNXvEoAnv1CRSzfK+n0Y+8nXeFpzSiOMjaeLxt+IYZrZqoo2xWnvfG0EqmwA8NZuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794070979;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0mX/y4k2TVn6iq3BNEMGtb9KP33DM0c49ZsBCKXcWRg=;
	b=rKSZdxprvsoKasWF/FlqxU7ZQ7+sengih1IW0jGDIBPP+O/x+v5FqWSmlUiHMo8kSfkM
	 Pc3cDiJg90TjieMkbXm1Qayg/ofq1rwFfvTmXdvOdwJjzjN9qHVl5cHCViCV+0V+8We6c
	 wb1YDEoIQUZDoxemUgl7BeEuGEX1DMnftOaHZNGFdCz68vVMbEOnJ7bY+RtBqqPlhQ87g
	 WWwXYJv9+w7rOlFGbpsaU9r5ftmLTQQTBGZ5gIkr497J9nlKNMIJngcR+4NH1X9F3+DDC
	 mzjLXrl/U/GYk960UzqnZZFZqblaGVnZy3RMzjpLm3bmrIjH7rBRK+kVKEnShaoPZkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E/+7iNKI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655CD606A32C;
	Sat,  7 Nov 2026 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E/+7iNKI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F67C1F0089F;
	Sat,  7 Nov 2026 17:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794070979;
	bh=0mX/y4k2TVn6iq3BNEMGtb9KP33DM0c49ZsBCKXcWRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E/+7iNKIdaG5gbWEYpyg2UfFr94ke15gdduH9urZWVzhEh582YL5KB6iGOai6sqe3
	 cZ2PdRf+mJF2g6ww9THusLf2cZDLNNRMGTFPBpci2J/c4LCshj8YzluBSYUG6KsVNu
	 c8kuxuccSBJmLZgvibKE8ERHoZzsyHD5R1LR3gDpJ+Ea1x7KWsqIr7MJmfqby3tBMP
	 2WWa3dKF3mYKz+GOgThScHb95M63t0DMrasydXIByoxJSxcVIlIa1TVhPNKU/OyacN
	 9F6/wup/1n0l1Sy8gR1UVt5JOOiSZYBtsVgVliJPq7wQSJkbwxYZ3fVeBTrCfS8Mrb
	 XKGBtAWP2BOGQ==
Date: Sat, 7 Nov 2026 18:02:53 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: muchun.song@linux.dev, osalvador@suse.de, david@kernel.org,
	akpm@linux-foundation.org, azpijr@gmail.com, lance.yang@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mm: hugetlb: fix GFP mask propagation to CMA
Message-ID: <au9ZvQObSY3y2s2c@localhost.localdomain>
References: <cover.1794046188.git.zhengqi.arch@bytedance.com>
 <61ee04513d6cac32347ebec9b295025b8a1f07ca.1794046188.git.zhengqi.arch@bytedance.com>
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
In-Reply-To: <61ee04513d6cac32347ebec9b295025b8a1f07ca.1794046188.git.zhengqi.arch@bytedance.com>

On Sat, Nov 07, 2026 at 06:30:47PM +0800, Qi Zheng wrote:
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
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

A comment below:

> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -933,9 +933,10 @@ struct page *cma_alloc_frozen(struct cma *cma, unsigned long count,
>  	return __cma_alloc_frozen(cma, count, align, gfp);
>  }
>  
> -struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order)
> +struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order, gfp_t gfp)
>  {
> -	gfp_t gfp = GFP_KERNEL | __GFP_COMP | __GFP_NOWARN;
> +	if (WARN_ON_ONCE(!(gfp & __GFP_COMP)))
> +		return NULL;

I think this needs a comment explaining why we are checking for __GFP_COMP,
because it might not be obvious to the casual reader.
Something like:

 "The only caller of cma_alloc_frozen_compound() is hugetlb, and hugetlb
  constructs its gfp mask via htlb_alloc_mask(), which already sets
  __GFP_COMP. Check here for usecases bypassing htlb_alloc_mask()."


Maybe in the future we do have some other users of this function which are outside
of the hugetlb realm, but if we are propagating the gfp mask down the chain to this
point, we do have to check that those users are also setting __GFP_COMP.
  
 

-- 
Oscar Salvador
SUSE Labs
