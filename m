Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164905;
	b=Y3CSmRHWo+v2jkDFV26EtMv+qegkI1hBSdHSvjXlcev9xOSZ8n/SheUF0LiaInz7Q2LR
	 WNC6Q9NeqWszm+VKVaDKIlYtQkMFnQk6QqzTftHQSh3RgcffzVc05mTyIPJ1NTR2rVx+n
	 F81nxe61MedR3KtTrnih4cjbZnBFvXGatBHPUY/wES460rRXmaW5LsXEXk2dMai3Mm3c6
	 PkNACHTwgWvcMFxV79+XOZXTkAJUQh22OVhqJHHX5BwzIBhHsdyE3dI/KTyWVDE7LcXW/
	 LtpCQbirP6hAJVYkpIyNd0o18L/QG7/Np9hio/7MAlWjpUeX0h2mUAmPYaDrrleUkJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164905;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=U8QU7D7lH0dsXop+2OtcELI16mRcSojShF4LVc/fwRo=;
	b=RSb+pxyVnn5ir3w75VDXE4Fi/KPW8EYa/U5hQ1EsGuM+snKDWPIdgTAaJgVMqxIoGskR
	 55fPYxearfQptNE+QQOBQNmKoE56woRmYs1FjaZeCo2t6RSE96LlGLRH37HAcEO7Sdy0b
	 fEXvzkzCfQDFnXoGeDK8qQsTH+SEWjZOP5Np1rTPaDmWIkkm5gnuwvMxq5TyLdfhJiw8N
	 jFBVZGTjTCYLi7R+/liPl07BsbNybS3Q/0j2L0sw2blrf4a8BlNN0WQygEynJk2/k3W7o
	 K+i+25GfLYpa3UjagBhb8PNOeqbASERHY3WCVfLDWiHv7YY06NJsCp61K8jkROV12NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R4wnAftC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2569606A32C;
	Fri, 20 Nov 2026 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R4wnAftC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F7D1F000C4;
	Fri, 20 Nov 2026 08:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795164905;
	bh=U8QU7D7lH0dsXop+2OtcELI16mRcSojShF4LVc/fwRo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=R4wnAftCC0fom7S86yQdMLAztpTkJyR+SbOiuZ2Ozzu+sMzSKTikRS4dXiGGcGn9M
	 97yNLrYYZrAXeKUbGLEJR9L3HgIFm7yioS0mdVLWgBYNBLP8AfetQfEOM0fBd0H5b/
	 iB7Oc9q2z/xqDblsboGFRJk3rVqMfc0OHAF+2mh6FYzxDASYeZ9htKMDlTWWFbw/Rb
	 J58CcUgsQcyLs5vPPz6A0TTQMztnjKsHI3uFsSicrPfyUiTXMy0NPBscUhQ4x2HXUq
	 JSbnlY0aXD0LV2uP0Umk63cQVz8de5ciy8NObFo6PTzApXUFpo9vjCfcv21SjUsq4j
	 hFdVFFXN0F7NQ==
Message-ID: <8a43c25e-0828-492b-90cf-beeb72ecdbb3@kernel.org>
Date: Fri, 20 Nov 2026 09:55:00 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: hugetlb: allocate larger early CMA pages first
To: Qi Zheng <qi.zheng@linux.dev>, muchun.song@linux.dev, osalvador@suse.de,
 akpm@linux-foundation.org, fvdl@google.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <20261120074701.48298-1-qi.zheng@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261120074701.48298-1-qi.zheng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/26 08:47, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> With hugetlb_cma_only=1, early HugeTLB CMA allocations follow hstate
> registration order, which can depend on the order of hugepagesz= and
> default_hugepagesz= parameters. cma_reserve_early() advances early_pfn by
> the requested size without aligning the start of each allocation.
> 
> On arm64 with 4 KiB base pages, 32 MiB and 1 GiB pages share a CMA pool
> aligned to 1 GiB. In a 2 GiB CMA range starting at 4 GiB, allocating a
> 32 MiB page followed by a 1 GiB page places the latter at 4 GiB + 32 MiB,
> violating its required 1 GiB physical alignment.
> 
> Simply rounding early_pfn up before the 1 GiB allocation would leave a
> 992 MiB gap and advance the cursor to 6 GiB. cma_activate_area() marks the
> entire prefix below early_pfn as allocated and only frees pageblocks after
> it. The gap would remain reserved with its bitmap bits set, and releasing
> the two HugeTLB folios would not reclaim it, permanently losing 992 MiB
> of usable CMA capacity. An alignment-only fix would therefore also need
> to track and reclaim such gaps.
> 
> The same alignment issue can affect non-LPAR PowerPC64 hash MMU systems
> supporting 16 MiB and 16 GiB pages, with 64 KiB base pages and
> CONFIG_ARCH_FORCE_MAX_ORDER=7. The 16 MiB size then has order 8 and is
> also gigantic, sharing the 16 GiB-aligned CMA pool.
> 
> Allocate early CMA hstates in descending order. Each range starts aligned
> to the largest supported size, so this preserves alignment for subsequent
> smaller allocations without creating gaps.
> 
> Fixes: d2d786714080 ("mm/hugetlb: enable bootmem allocation from CMA areas")
> Cc: stable@vger.kernel.org
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  mm/hugetlb.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4a448c5909d36..d69a9532ad5ef 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4600,6 +4600,22 @@ void __init hugetlb_bootmem_set_nodes(void)
>  		node_set(nid, hugetlb_bootmem_nodes);
>  }
>  
> +/* Return the largest early-CMA hstate below the given order. */
> +static struct hstate *__init hugetlb_next_early_cma_hstate(unsigned int order)
> +{
> +	struct hstate *h, *next = NULL;
> +
> +	for_each_hstate(h) {
> +		if (!hugetlb_early_cma(h) || huge_page_order(h) >= order)
> +			continue;
> +
> +		if (!next || huge_page_order(h) > huge_page_order(next))
> +			next = h;
> +	}
> +
> +	return next;
> +}
> +
>  void __init hugetlb_bootmem_alloc(void)
>  {
>  	struct hstate *h;
> @@ -4615,9 +4631,19 @@ void __init hugetlb_bootmem_alloc(void)
>  	for_each_hstate(h) {
>  		h->next_nid_to_alloc = first_online_node;
>  
> -		if (hstate_is_gigantic(h))
> +		if (hstate_is_gigantic(h) && !hugetlb_early_cma(h))
>  			hugetlb_hstate_alloc_pages(h);
>  	}
> +
> +	/*
> +	 * CMA ranges are aligned to the largest supported size. Allocate larger
> +	 * sizes first to keep the early reservation cursor aligned without gaps.
> +	 */
> +	h = hugetlb_next_early_cma_hstate(MAX_FOLIO_ORDER + 1);
> +	while (h) {
> +		hugetlb_hstate_alloc_pages(h);
> +		h = hugetlb_next_early_cma_hstate(huge_page_order(h));

Was thinking that this could be written in a neater way, but it really can't.
Best we could do is issue a single hugetlb_next_early_cma_hstate().

order = MAX_ORDER - 1;
while (h = hugetlb_next_early_cma_hstate(order)) {
	hugetlb_hstate_alloc_pages(h);
	order = huge_page_order(h);
}

Thanks!

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
