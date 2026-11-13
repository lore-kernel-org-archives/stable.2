Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794542200;
	b=OYhrSxqkINnYlAlqSaIv0qJeQ4e09qocc9jaL6hwfqzGiCf4IUR8gy5Oc70C9AHlTtuL
	 M4lgT1RpKbthjIrWAQ3BGtIU6jNcQtzbZswoMxO7nYv8bHlWqHbAhNEPtwygPdJ6pSv67
	 rXpI4Xfer/EGHlx/cG/hbUxIcyXp/tyTJvt6Aum/8SKmy8LfhfpTFlvgYnarG+12IXaRx
	 FhpByAfBMmQNcbBW1oLe0ISRM5MoQHYqZ6wbnI1EnAUSPOyglvcXHJTWPrHixyw4H7+cx
	 nZ2k5gtZi4ZnZ7vIzm3AmKQeQaf2jLBQFRJ1pxXdSJ4bTNrpM3EB55r2GvAj9gOvi/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794542200;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=c3IsyqkDIWcFoAWUz+a4O451BRWK6BgsPtMgW9Nvv/E=;
	b=M+t+PnvSpF619UsT7ov+tnBG/5jAwjeGWH9ronCjoDK93bhrr8l8mbQzCfyRHvq365F7
	 24YYlH++CSY145GpLnQB2cIjRFHlZ6qDKsr4m7aIkQ00eJUgU+V4L8Xr/tbr7uMR3YYNW
	 oI70jv4J1HQNgFBNUszaHy0/sotRtCdlIkymD+1qm07D6T0TL2BfPbPZn7sOL+9GKianV
	 0XCWz/By/PpwfojDdSC+bXzs7KIw9+DgxdE5Lvj0WSC2wVYAkuekqbz41YBcNyx2BbonT
	 goaWhAC6f/aKwP3Qc8Yu+Ul6MY2Wsi3S343Qv5BFhbsXOQ5vfq/yAerktxrbsJRm63A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=yrjLoZTa;
	arc=none smtp.remote-ip=113.46.200.218
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE74A606A31C;
	Fri, 13 Nov 2026 03:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE74A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=yrjLoZTa
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=c3IsyqkDIWcFoAWUz+a4O451BRWK6BgsPtMgW9Nvv/E=;
	b=yrjLoZTab8mWtUhjvpXJDdI+67sJG0vF3QRBhGDCSAvQnHTaOUj159iBcHJs9yXApHa//OCW3
	BFD4bl5CWqX8S9DyjgNrCIqW+FA2Uybergz+T4pSQZO+W+MlTr27JWcOZU6chYRYuIBJZZsUTxZ
	wQgHHRHZgOtw1tG8GWPL0lw=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4jQk230vZYzpStp;
	Fri, 13 Nov 2026 11:55:55 +0800 (CST)
Received: from kwepemk300003.china.huawei.com (unknown [7.202.195.93])
	by mail.maildlp.com (Postfix) with ESMTPS id B63EB40579;
	Fri, 13 Nov 2026 11:56:35 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 kwepemk300003.china.huawei.com (7.202.195.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 13 Nov 2026 11:56:34 +0800
Message-ID: <9b46d8e0-104e-4659-8dec-67eb6f059dac@huawei.com>
Date: Fri, 13 Nov 2026 11:56:33 +0800
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
	<azpijr@gmail.com>, <lance.yang@linux.dev>, Qi Zheng
	<zhengqi.arch@bytedance.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<stable@vger.kernel.org>, "Oscar Salvador (SUSE)" <osalvador@kernel.org>
References: <cover.1794379433.git.zhengqi.arch@bytedance.com>
 <1c5e8c4ae230dc238a16f2f42d65bffac6244ad3.1794379434.git.zhengqi.arch@bytedance.com>
 <7def88b4-cba5-4e8b-9e68-6069c492b582@huawei.com>
 <1cd3c151-24c2-4fec-8356-99853f8d6971@linux.dev>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <1cd3c151-24c2-4fec-8356-99853f8d6971@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk300003.china.huawei.com (7.202.195.93)



On 11/13/2026 10:30 AM, Qi Zheng wrote:
> 
> 
> On 11/12/26 7:27 PM, Kefeng Wang wrote:
>>
>>
>> On 11/11/2026 2:46 PM, Qi Zheng wrote:
>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>
>>> cma_alloc_frozen_compound() uses GFP_KERNEL, allowing direct reclaim
>>> during the first MPOL_PREFERRED_MANY allocation attempt even though
>>> the caller clears __GFP_DIRECT_RECLAIM.
>>
>> MPOL_PREFERRED_MANY is only used for the partner allocator. Without your
> 
> It's doesn't seem so.
> 
> Gigantic surplus allocations already use MPOL_PREFERRED_MANY, following
> eb02f14c4a2b ("mm/hugetlb: allow overcommitting gigantic hugepages"),
> which predates 9bda131c6093.
> 
> alloc_buddy_hugetlb_folio
> --> MPOL_PREFERRED_MANY
>      --> gfp_t gfp = gfp_mask & ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
>          folio = alloc_surplus_hugetlb_folio(h, gfp, mpoli->nid, nodemask);
>          --> alloc_fresh_hugetlb_folio
>              --> only_alloc_fresh_hugetlb_folio
>                  --> alloc_gigantic_frozen_folio
>                      --> hugetlb_cma_alloc_frozen_folio
>                          --> cma_alloc_frozen_compound
> 
> Before 9bda131c6093, cma_alloc_folio() forwarded the caller's GFP mask.
> The conversion to cma_alloc_frozen_compound() replaced it with
> GFP_KERNEL, re-enabling direct reclaim during the preferred-node
> attempt.

Oh, I forgot about that commit. The naming and some of the comments are 
misleading because alloc_buddy_hugetlb_folio/alloc_surplus_hugetlb_folio
can allocate both buddy and gigantic folios (which can be allocated from
CMA).

Maybe rename alloc_buddy_hugetlb_folio to hugetlb_alloc_surplus_folio,
or other names...
