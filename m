Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483042;
	b=EOl9x2Gi9V2nAY/3ZpceUdYOoCNiLW93/PeJAV2ufkY99VWsLSLjDjDBFELyQlwHsXNt
	 sL4OhmwGhOTuaCweAwYNaZ5lQO+3c0BIDm1IH7KeVdxSRU6FCNkbn3ON9I6trvvKSa5Hv
	 Zbq5ReTWsDwWGb3zbVTj8NFK5y2VMy6exyxYcxAF3UHi1Qw8YGLA4bD7UW3zsn/elmeSk
	 3a1Cuk4LDWPCy2AJNszv5oR2UxmgMSOge95imnFqfxtO7rHOrthTnwhP5AVL4vWGS66uD
	 ehAWpMCQgNuGng9OsJ4DVUxPLIkeqJuiV/KXqDt/JCD0F0R1AbQjDIZUrmm+Ztz+9zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483042;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:From:To:CC:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=8dtoPzgIAyTZmTJOXmbFfXRIYwlyrp1T0CX/jpuE8Sc=;
	b=EwzLFaSheyOLgMiVL4pjEfIt1ekJmCu/nVJDlbEHR69U6tEebaNS4QK8XfvPDcVtojr4
	 aodcFpq5fmM2JJDfcKxAImW7ZpFSngoPYyK/UaYPW+E/V0jdcWjliKJzBJH8q4EQG86KU
	 iAyH6NseKRDGK4oAw7Vuf2wW9iOwiSIw4FBqmgqwZS3ZdCdGPOHFyjHutxWrorkZqHgRi
	 2utqZsK/oaxWggvQi2op5O1bB8I9rMUPHkTGtYoXgrZF9274jeYfjuyxl5cH5o9ee6XwJ
	 aHFWdPmY2foPctXo2uBC3hmPRb6Sl2XCCVWV3ITi7balBvoQOJQfx0jSHrwCVcKNU+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=JsLmb+4T;
	arc=none smtp.remote-ip=113.46.200.222
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AC3606A32E;
	Thu, 12 Nov 2026 11:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5AC3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=JsLmb+4T
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8dtoPzgIAyTZmTJOXmbFfXRIYwlyrp1T0CX/jpuE8Sc=;
	b=JsLmb+4Tk+a7iKdRyTfJwMH5VClwAn5+pSrMX5WFckZNZJu7p1WXAYf11555CnuG5DEsfGp9k
	BeuE9orOg/o9PoYKmww8z59bwTSx0uEfbqY/D9m0WXNHqJpX6Jrt1Xgr1Ehv7eeqGmf6oDtQjc+
	M7ICNe9Jlqzp2nRZ8ChCv3Q=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jQJ8j2WsDzLlSW;
	Thu, 12 Nov 2026 19:30:13 +0800 (CST)
Received: from kwepemk300003.china.huawei.com (unknown [7.202.195.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A88440565;
	Thu, 12 Nov 2026 19:30:29 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 kwepemk300003.china.huawei.com (7.202.195.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 12 Nov 2026 19:30:28 +0800
Message-ID: <3ad97d52-9229-4b15-818e-4fcba66a0251@huawei.com>
Date: Thu, 12 Nov 2026 19:30:27 +0800
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
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Qi Zheng <qi.zheng@linux.dev>, <muchun.song@linux.dev>,
	<osalvador@suse.de>, <david@kernel.org>, <akpm@linux-foundation.org>,
	<azpijr@gmail.com>, <lance.yang@linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Qi Zheng
	<zhengqi.arch@bytedance.com>, <stable@vger.kernel.org>, "Oscar Salvador
 (SUSE)" <osalvador@kernel.org>
References: <cover.1794379433.git.zhengqi.arch@bytedance.com>
 <1c5e8c4ae230dc238a16f2f42d65bffac6244ad3.1794379434.git.zhengqi.arch@bytedance.com>
 <7def88b4-cba5-4e8b-9e68-6069c492b582@huawei.com>
Content-Language: en-US
In-Reply-To: <7def88b4-cba5-4e8b-9e68-6069c492b582@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk300003.china.huawei.com (7.202.195.93)



On 11/12/2026 7:27 PM, Kefeng Wang wrote:
> 
> 
> On 11/11/2026 2:46 PM, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> cma_alloc_frozen_compound() uses GFP_KERNEL, allowing direct reclaim
>> during the first MPOL_PREFERRED_MANY allocation attempt even though
>> the caller clears __GFP_DIRECT_RECLAIM.
> 
> MPOL_PREFERRED_MANY is only used for the partner allocator. Without your

Sorry, buddy allocation

> patches "mm: hugetlb: add CMA support for PMD-sized pages,"
> cma_alloc_frozen_compound() is only used for huge page allocations. In

gigantic allocation

> this case, I think we don't need the gfp flag, which is why I hardcoded
> it, so there's no need for the Fixes tag; this patch should be part of
> your new feature. Maybe I missed something?
> 
>>
>> Pass the caller's GFP mask through the helper so CMA respects its
>> reclaim constraints when trying the preferred nodes.
>>
>> Fixes: 9bda131c6093 ("mm: cma: add cma_alloc_frozen{_compound}()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Acked-by: Muchun Song <muchun.song@linux.dev>
>> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
>> Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>
>> ---
>>   include/linux/cma.h |  2 +-
>>   mm/cma.c            | 10 ++++++++--
>>   mm/hugetlb_cma.c    |  4 ++--
>>   3 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/cma.h b/include/linux/cma.h
>> index 8555d38a97b1a..4539ea5f2c4e8 100644
>> --- a/include/linux/cma.h
>> +++ b/include/linux/cma.h
>> @@ -53,7 +53,7 @@ extern bool cma_release(struct cma *cma, const 
>> struct page *pages, unsigned long
>>   struct page *cma_alloc_frozen(struct cma *cma, unsigned long count,
>>           unsigned int align, bool no_warn);
>> -struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int 
>> order);
>> +struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int 
>> order, gfp_t gfp);
>>   bool cma_release_frozen(struct cma *cma, const struct page *pages,
>>           unsigned long count);
>> diff --git a/mm/cma.c b/mm/cma.c
>> index 9ec1d1fd5dff5..a7c47c0e7d070 100644
>> --- a/mm/cma.c
>> +++ b/mm/cma.c
>> @@ -933,9 +933,15 @@ struct page *cma_alloc_frozen(struct cma *cma, 
>> unsigned long count,
>>       return __cma_alloc_frozen(cma, count, align, gfp);
>>   }
>> -struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int 
>> order)
>> +struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int 
>> order, gfp_t gfp)
>>   {
>> -    gfp_t gfp = GFP_KERNEL | __GFP_COMP | __GFP_NOWARN;
>> +    /*
>> +     * The only caller of cma_alloc_frozen_compound() is hugetlb, and
>> +     * hugetlb constructs its gfp mask via htlb_alloc_mask(), which 
>> already
>> +     * sets __GFP_COMP. Check here for usecases bypassing 
>> htlb_alloc_mask().
>> +     */
>> +    if (WARN_ON_ONCE(!(gfp & __GFP_COMP)))
>> +        return NULL;
>>       return __cma_alloc_frozen(cma, 1 << order, order, gfp);
>>   }
>> diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
>> index cd6a64986278a..3e5a30571524a 100644
>> --- a/mm/hugetlb_cma.c
>> +++ b/mm/hugetlb_cma.c
>> @@ -69,14 +69,14 @@ struct folio *hugetlb_cma_alloc_frozen_folio(int 
>> order, gfp_t gfp_mask,
>>       }
>>       if (hugetlb_cma[nid] && node_isset(nid, *nmask))
>> -        page = cma_alloc_frozen_compound(hugetlb_cma[nid], order);
>> +        page = cma_alloc_frozen_compound(hugetlb_cma[nid], order, 
>> gfp_mask);
>>       if (!page && !(gfp_mask & __GFP_THISNODE)) {
>>           for_each_node_mask(node, *nmask) {
>>               if (node == nid || !hugetlb_cma[node])
>>                   continue;
>> -            page = cma_alloc_frozen_compound(hugetlb_cma[node], order);
>> +            page = cma_alloc_frozen_compound(hugetlb_cma[node], 
>> order, gfp_mask);
>>               if (page)
>>                   break;
>>           }
> 

