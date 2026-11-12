Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482847;
	b=tjBRWrKATNAkjeWrJrlTrRTc7R25C8CdXAaJag7n9t2ju1UcSxp6warsnZ14t3MqAshm
	 /FZfTNFoTYCbwWBarC0WuLdgiMrkTG4m+GnGueCIvNxZ03LWOjYwlQMDgAZkhjpZwC3ZA
	 W/UFQsgtNsA2Qgl3/sYbK/zBLvorFe2mVgQtCAxQ4G6o0B2vMa/0nCwS+pUo3zdB6/Nr/
	 D6zhD/aT2TMrGCSya5k4a0HdF5rtWUsgBKuj9EaO0+S21fhryHzVIQy0+3f7A0Sy8taXY
	 k5g09GCPXhtGBdg2z8cp0bu0xYtxIiRngN4c+cEkgUJqpoVT0GYBSqMvKp/Y3Rx2KOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482847;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=qS4PUEw5D4i182BvRdf3oEmT2ARm6b9LLZ69zC+a5K8=;
	b=gGm9NfNovyVBCaYVFv6yKb8RWQpTJPR9Ht40FV6IDG0UzjcaxidtSWJCRQXjq4SmmL4P
	 vvi/M57vKGzsqB9v0AMZbq6zBgh3E0xOYBF43lgsxjzPXdynxHxso3FNiuW8/DvFKNRIj
	 4h5oe70WnPbFiJlT432A/Ki/cJsWhwc+v9BQWJFAa2iGV2Ch7dKeznuOvGpaMhSFYtri7
	 gFm0PVPAuarYK+QqoaQsYME+P2bqBKxigHoZ9ccqOoSBuz1Fru+sFwxys4Pk1PjIZCWHC
	 9vg1kwcYDwh6BCciEYfKY7gRzJjk9mVfLuA8grZsMfMsV0Ig02uRiGLwMpxGqn74Qkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=nQLBYvLp;
	arc=none smtp.remote-ip=113.46.200.220
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CC2606DE77;
	Thu, 12 Nov 2026 11:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0CC2606DE77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=nQLBYvLp
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qS4PUEw5D4i182BvRdf3oEmT2ARm6b9LLZ69zC+a5K8=;
	b=nQLBYvLpdp7DfEOKHrVzZVG6Lk5UnxaQfy9h5S0P2Z7RgAV3pGDypQQTJQD+86TQJJdeUX+Eg
	E1C0qHRpqGBP+vJucPe+vcNHIlv+MJVGWcFKZDxe7i6sol/+4PgwUEu+jaaKlbsE5oTTAPrMd0e
	9zuUVuS0Ffv+CG9Ar3n4d1g=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jQJ5V4wwfz12LJQ;
	Thu, 12 Nov 2026 19:27:26 +0800 (CST)
Received: from kwepemk300003.china.huawei.com (unknown [7.202.195.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 2CA9E4057F;
	Thu, 12 Nov 2026 19:27:21 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 kwepemk300003.china.huawei.com (7.202.195.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 12 Nov 2026 19:27:20 +0800
Message-ID: <7def88b4-cba5-4e8b-9e68-6069c492b582@huawei.com>
Date: Thu, 12 Nov 2026 19:27:19 +0800
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
Subject: Re: [PATCH v4 3/3] mm: hugetlb: fix GFP mask propagation to CMA
To: Qi Zheng <qi.zheng@linux.dev>, <muchun.song@linux.dev>,
	<osalvador@suse.de>, <david@kernel.org>, <akpm@linux-foundation.org>,
	<azpijr@gmail.com>, <lance.yang@linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Qi Zheng
	<zhengqi.arch@bytedance.com>, <stable@vger.kernel.org>, "Oscar Salvador
 (SUSE)" <osalvador@kernel.org>
References: <cover.1794379433.git.zhengqi.arch@bytedance.com>
 <1c5e8c4ae230dc238a16f2f42d65bffac6244ad3.1794379434.git.zhengqi.arch@bytedance.com>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <1c5e8c4ae230dc238a16f2f42d65bffac6244ad3.1794379434.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk300003.china.huawei.com (7.202.195.93)



On 11/11/2026 2:46 PM, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> cma_alloc_frozen_compound() uses GFP_KERNEL, allowing direct reclaim
> during the first MPOL_PREFERRED_MANY allocation attempt even though
> the caller clears __GFP_DIRECT_RECLAIM.

MPOL_PREFERRED_MANY is only used for the partner allocator. Without your
patches "mm: hugetlb: add CMA support for PMD-sized pages,"
cma_alloc_frozen_compound() is only used for huge page allocations. In
this case, I think we don't need the gfp flag, which is why I hardcoded
it, so there's no need for the Fixes tag; this patch should be part of
your new feature. Maybe I missed something?

> 
> Pass the caller's GFP mask through the helper so CMA respects its
> reclaim constraints when trying the preferred nodes.
> 
> Fixes: 9bda131c6093 ("mm: cma: add cma_alloc_frozen{_compound}()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>
> ---
>   include/linux/cma.h |  2 +-
>   mm/cma.c            | 10 ++++++++--
>   mm/hugetlb_cma.c    |  4 ++--
>   3 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index 8555d38a97b1a..4539ea5f2c4e8 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -53,7 +53,7 @@ extern bool cma_release(struct cma *cma, const struct page *pages, unsigned long
>   
>   struct page *cma_alloc_frozen(struct cma *cma, unsigned long count,
>   		unsigned int align, bool no_warn);
> -struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order);
> +struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order, gfp_t gfp);
>   bool cma_release_frozen(struct cma *cma, const struct page *pages,
>   		unsigned long count);
>   
> diff --git a/mm/cma.c b/mm/cma.c
> index 9ec1d1fd5dff5..a7c47c0e7d070 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -933,9 +933,15 @@ struct page *cma_alloc_frozen(struct cma *cma, unsigned long count,
>   	return __cma_alloc_frozen(cma, count, align, gfp);
>   }
>   
> -struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order)
> +struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order, gfp_t gfp)
>   {
> -	gfp_t gfp = GFP_KERNEL | __GFP_COMP | __GFP_NOWARN;
> +	/*
> +	 * The only caller of cma_alloc_frozen_compound() is hugetlb, and
> +	 * hugetlb constructs its gfp mask via htlb_alloc_mask(), which already
> +	 * sets __GFP_COMP. Check here for usecases bypassing htlb_alloc_mask().
> +	 */
> +	if (WARN_ON_ONCE(!(gfp & __GFP_COMP)))
> +		return NULL;
>   
>   	return __cma_alloc_frozen(cma, 1 << order, order, gfp);
>   }
> diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
> index cd6a64986278a..3e5a30571524a 100644
> --- a/mm/hugetlb_cma.c
> +++ b/mm/hugetlb_cma.c
> @@ -69,14 +69,14 @@ struct folio *hugetlb_cma_alloc_frozen_folio(int order, gfp_t gfp_mask,
>   	}
>   
>   	if (hugetlb_cma[nid] && node_isset(nid, *nmask))
> -		page = cma_alloc_frozen_compound(hugetlb_cma[nid], order);
> +		page = cma_alloc_frozen_compound(hugetlb_cma[nid], order, gfp_mask);
>   
>   	if (!page && !(gfp_mask & __GFP_THISNODE)) {
>   		for_each_node_mask(node, *nmask) {
>   			if (node == nid || !hugetlb_cma[node])
>   				continue;
>   
> -			page = cma_alloc_frozen_compound(hugetlb_cma[node], order);
> +			page = cma_alloc_frozen_compound(hugetlb_cma[node], order, gfp_mask);
>   			if (page)
>   				break;
>   		}

