Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708521;
	b=KAp261Xh7EzbqxUf1s8mj0sfQ6cdci6hD1DZRIpaV6HNMt2DWShX8n/kR7rDjECshqBd
	 bcTpYTRXe9dOF12lQ76SsPSdXE85n2nB6xHqRsr8atIp58dSftsgUndXywf8s5Zw/rDWY
	 Javvx+VjbaSAy6R8BXqhCEYWcNU26UJMF85o3zbAJcCVUEsI7FqkQyMhMpLwLHq8T/sRd
	 DqIG/sBXzVO7W+yxUu6k5s20DnpXnx2BpZ8cmtppd0WZwQq4Vnwudf20sROhkAhUZA/F1
	 V3YDJ1LaNosooKYqNwc/IIbK2Ns8OuGC8/iK8PKfTcE0FvhfZVHf14Lw2Gxg0xvOwIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708521;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=DOzzqdK9OoTPF7w8+dGv8CzGaoXQjJup2f2zEoi38v8=;
	b=As9mP6GkUNhKKv+EhMUPhrDcddOfg9GrVRu12SuVvr0gDBY2MUbrILwxrJlXh451KHP9
	 NsAyYivgymOwKrKvpNXgWmCskF2oMafcI0QPpQs98vs/rHXq4q7YOgkgkCDI7R+535kMo
	 WgKeQBJbBWz0UqWuRliQJn2SDHk+kIZJiuMRCiHGqkvVFUF+JK84Iqj3I/64YZRofmyEC
	 v/QKTu+BSYae9iyZGybbhcHXmr/l/Hy2rsrfoJzeFyRuozxMna5JyEVVy3JPRGy3vkG+u
	 fP7fQHwe8OW3qISvggad/9IhqgE0W7A9JQsvQWFFzFg5EbQqk92AAQLg321s/oSoBwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yoBXuWlF;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3409A606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 12:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3409A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yoBXuWlF
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e46e449e8so2505779f8f.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 04:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793708519; x=1794313319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DOzzqdK9OoTPF7w8+dGv8CzGaoXQjJup2f2zEoi38v8=;
        b=yoBXuWlFCJjc54rW/BciP9V4C/Iz9+IJzlIbbe7hZuSoBtjdLCqTfDCfi/N/nmyZLO
         +jQIH2hUVF4vFqcbDJ805ALJEgr1eGd78KYVVxtElnBWg7G/1omKy3DgNw0M0e8m5Ss2
         ySj0oQb3ve7zkTOf2CnlsnGm+esLH4/57XCCTvuMqlp93Tk+0BBlUQSKENmdK0W3OI0i
         aytCAPA1roN5cUvh0Eo/no36dkAyKnqA0fIy1eSCPXcqfeDA00EIt4G8gvfqsNW6hwei
         8/k//emnjOVESjfrRUgzwkUIdoB7IRM4jhVSI5FMv7b1IPPVPlR3q0v6KjqiZKljPrs5
         p4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793708519; x=1794313319;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DOzzqdK9OoTPF7w8+dGv8CzGaoXQjJup2f2zEoi38v8=;
        b=RzyGD6I/bif00vWYOYGlIGom+tVsRBrZQaBrgFjl0E6LDEmzJquZ5ip/0Mnmv35lYY
         Xzw6tjJC/NgqHYVeOab/AKXvZ5STiidbdCFvRss9eeZgLBY0nBmbgxo+3lv9ic2eutDh
         sMbzoN/bC1Sf1t5zS/rG7FmOBpqlWd9hsSWfhKtgug0ZEdJ7ZR884pdBOBz4ZrPjp8Ly
         NBEY5j2OH86kiGdrQjymgv8+Dbk+wUu5Nclo4MmQVpMlZ94+rdeBFgFxH3+LEgu0T1Jq
         XA4hXHD1pum61eTC9Vif22/wsQSOdiSzHKxs4hTz3BeEq6kJE7t6GdzvofebKRou7bgW
         XVMw==
X-Forwarded-Encrypted: i=1; AKwUvBydW6/iqbbl192IAMUd0JZKXpVULfR7w8TDoVnFnP91gHigXOnn7l+ia9su6d1xaDFE1yrjLxg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9D8dJoPyvpC0qv5Mzrjj5zCDnU77n/uL57+LfZ2oQx/E95jpP0
	77AvYU6VKDhAm3eIbZ2XtT6Js8TJC8VrA2x5mnFNApJt4Md2fO1XvzHy
X-Gm-Gg: AYBFou1jFYvn/xJ5mhrsrDxgFYFn6Mt7NKusX64v95kHM0bQncWmG1itGWg15RgcHRl
	nExSZ3BCv179GFu463PeSS74B5VfVjApOstlxSxNWaBWMKKvRfBNxNVYH2S0VN5oEHNAnksi+Pd
	CIxDfymsBbbj2b65kXhGiV3EAIUYO4fM3X7IUAcDNn9Q2FDgXxwQ2Hpb2UJZzJQIyMYGExFJ8KH
	uZJXPFf+lxmthKbUkRIIGsIzmlGMLPxmvJC320DzhfiMYzu4Un3KL/JbcmCkD6AN4SbiBmTN7Rt
	kMl8JK1JYHh+CjRbq1+Yv7jxeQB2InJhDfH1tvNDfYxf+JOxm5QrGMYYgd0C0Qg+jMX6r+iSqMQ
	gJOugnfZNbDyL0yP07NwNPE9a6/7hdbwriA2fv+pQC5iHkIshnM5P5Mu2QhhH8oQy/bVevBJftc
	UEB1Rl3eLB0z5Bh3QsgTvCznZRJHWG/tKlfFZfL4KhCt3oIkyManBMlAFErSxLEx2Rf7uSquzyw
	iQwR5HImBYp1ZUYbIMXwH9sRgDaB9zwXtFU2gBneupgYKUMwEEDejpuNG/0Qr9lTB7Y7cJ9CUJM
	0eXzz4axbvDvHusBaOCaGxw=
X-Received: by 2002:a05:6000:24c5:b0:48e:6264:c373 with SMTP id ffacd0b85a97d-48e6e4f5798mr31061860f8f.14.1793708519379;
        Tue, 03 Nov 2026 04:21:59 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71bae25dsm22412110f8f.59.2026.11.03.04.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 04:21:58 -0800 (PST)
Message-ID: <b1c86bc9-24e8-4c87-b2a7-2eefbdd96c12@gmail.com>
Date: Tue, 3 Nov 2026 13:21:57 +0100
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
Subject: Re: [PATCH 4/4] mm: hugetlb: respect cpuset restrictions for surplus
 allocations
To: Qi Zheng <qi.zheng@linux.dev>, muchun.song@linux.dev, osalvador@suse.de,
 david@kernel.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org,
 Lance Yang <lance.yang@linux.dev>
References: <cover.1793692578.git.zhengqi.arch@bytedance.com>
 <d1e41a65970ced879715a73ce2607de7ad102fb2.1793692578.git.zhengqi.arch@bytedance.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <d1e41a65970ced879715a73ce2607de7ad102fb2.1793692578.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 9:01 AM, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Gigantic surplus allocations can escape the faulting task's cpuset.
> CMA and the contiguous allocator trust the supplied nodemask without
> checking the current cpuset.
> 
> For example, a shared HugeTLB VMA has MPOL_BIND={0,1}, and T is a
> non-leader thread. With surplus allocation enabled and no eligible free
> HugeTLB folio, the following sequence can occur:
> 
>   CPU0 (cgroup v1 migration)       CPU1 (thread T)
>   -------------------------       ---------------
>   cpuset_attach_task(..., T)
>     T->mems_allowed = {0}
>     /* Non-leader: skip
>        mpol_rebind_mm(). */
>                                   /* Fault; VMA policy is still {0,1}. */
>                                   policy_nodemask()
>                                     /* {0,1} intersects {0}. */
>                                     nodemask = {0,1}
>                                   hugetlb_cma_alloc_frozen_folio()
>                                     /* node0 fails; node1 succeeds. */
> 
> The 1 GiB folio is allocated on node1 despite T being restricted to node0.
> 
> Intersect the interpreted policy with the current cpuset before surplus
> allocation, preserving MPOL_BIND and MPOL_PREFERRED_MANY fallback rules.
> Apply the restriction at the policy-aware entry point to preserve
> per-node pool management semantics.
> 
> If the cpuset changes during allocation, rebuild the mask and revalidate
> any allocated folio against the current constraints. Keep it if it is
> still eligible: freeing an HVO-optimized folio can defer returning its
> range to CMA, so discarding a usable folio can cause a needless allocation
> failure. Only release the folio and allocate again if it is no longer
> eligible.
> 
> Fixes: eb02f14c4a2b ("mm/hugetlb: allow overcommitting gigantic hugepages")
> Cc: stable@vger.kernel.org
> Reported-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  mm/hugetlb.c | 38 +++++++++++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ce9c8e57b8e5c..6fd6e58ace869 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2181,22 +2181,46 @@ struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
>  		gfp_t gfp_mask, struct mempolicy_interpreted *mpoli)
>  {
>  	struct folio *folio = NULL;
> -	nodemask_t *nodemask = mpoli->nodemask;
> +	nodemask_t alloc_nodemask;
> +	unsigned int cpuset_mems_cookie;
> +
> +retry:
> +	cpuset_mems_cookie = read_mems_allowed_begin();
> +	alloc_nodemask = cpuset_current_mems_allowed;
> +	if (mpoli->mode == MPOL_BIND && mpoli->nodemask &&
> +	    nodes_intersects(*mpoli->nodemask, alloc_nodemask))
> +		nodes_and(alloc_nodemask, alloc_nodemask, *mpoli->nodemask);
> +
> +	if (folio) {
> +		if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie)))
> +			goto retry;
> +
> +		if (node_isset(folio_nid(folio), alloc_nodemask))
> +			return folio;
> +
> +		/* Balance free_huge_folio()'s decrement before caller accounting */
> +		lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
> +		free_huge_folio(folio);
> +		folio = NULL;
> +	}

the page allocator only retries when the allocation fails, why does this
need to drop a folio that raced with a cpuset change? retrying only on
!folio would make this whole block go away, with the check at the end as:

        if (!folio &&
            unlikely(read_mems_allowed_retry(cpuset_mems_cookie)))
                goto retry;

>  
>  	if (mpoli->mode == MPOL_PREFERRED_MANY) {
>  		gfp_t gfp = gfp_mask & ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
>  
> +		nodes_and(alloc_nodemask, alloc_nodemask, *mpoli->nodemask);
>  		folio = alloc_surplus_hugetlb_folio(h, gfp, mpoli->nid,
> -						    nodemask);
> +						    &alloc_nodemask);
>  
> -		/* Fallback to all nodes if page==NULL */
> -		nodemask = NULL;
> +		/* Fallback to all nodes allowed by the current cpuset */
> +		alloc_nodemask = cpuset_current_mems_allowed;
>  	}
>  
> -	if (!folio) {
> +	if (!folio)
>  		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, mpoli->nid,
> -						    nodemask);
> -	}
> +						    &alloc_nodemask);
> +
> +	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie)))
> +		goto retry;
>  
>  	return folio;
>  }


-- 
cheers,
jose a. p-a
