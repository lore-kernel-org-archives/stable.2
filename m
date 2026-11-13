Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553003;
	b=ST4xbtQ+kkGxCAHyLD2UPT2sQXoYm5hYM7iw6TnUhuO9B5xKJaGN86xOZSMgnam/WUdj
	 siHzHpc4WHS/55uNjvb0xLwNEeBi4sabqeaL6mmvCMzb53hmizAg56EHhy/qJrp7Z62sZ
	 RMWOfCz5Qg9u6aHNAZxy52nGMdLXRWWs3k6CU2SP3rKb5pH5dIrmT8iCk3R2Ltu39hdg9
	 PRJY7cWZft9djh6chD/K2Qv6c/yrejxg+8mS7a/OyeyhylFaNNtpINVexnG+AJApBZ4XV
	 4q4f/hXEfxt741DFZJZ2WtrUugWKqvhLLeG339UN8ZdfW3perrDhZS6P1I02s6whFzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553003;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dleCmS+wcIoZt0s8RSq4SghUIJElDi6eszWr991uRyM=;
	b=pD/jJSqqXztnkKBZDtUsqR+bCEpU7OH9w3QNw3aZrO5b1s8BCco8UWL7Q5DTnv6tvI+u
	 sm5mOKdQa8wItFfquaK80rKRHehS8ElSaMDG+j78+qDJ1JwtYB+5VV+sMTg12NJiYn/rg
	 eQ4Kgjf72cv41f2HfZaR46kIdPPJn0R/37qDzfMXRqpLh9oIGCYXHIomGnGBv4lX3l7mR
	 5Q0sETDIAoUd/VLJOwYc8mZEQnw21cS73ZpGMyTmKPvbxrckJHe2ShXClwu9+NGQqPQ9a
	 A/bBk3/ssg6zV5rr2UeAkyEvg0+VHyahRhsPVX8M4I7V2vUSfXUyZYEoO5aZThV7bMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XT8j0cIE;
	arc=none smtp.remote-ip=91.218.175.168
Received: from mta0.migadu.com (out-168.mta0.migadu.com [91.218.175.168])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2261606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 06:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2261606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XT8j0cIE
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=I3d8MPdHTNroLOq0wxxtMmc+Uc1DmX33W42S6M5zY04=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794553001; v=1; x=1795157801;
 b=XT8j0cIEejCvCFQEyHvGwSzdi50PYjxEqKneCcP3LpJN77o/bDGaHfDT47eTRd0Z7AGuuN+b
 stLjH4uRl5IOQFn5U19x2KG4Z6oCeiKj/zKuaPKo6EP/yO4Q15ISHe7Hm0j1NPkMPBchFjAXOhs
 6RwsD9X9AVWIqdBKcYDYMXCY=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 120149e2deeb02e7;
	Fri, 13 Nov 2026 06:56:40 +0000
X-Mizu-Trace-ID: 120149e2deeb02e7
X-Migadu-Flow: FLOW_OUT
Message-ID: <dbfa9791-5a4e-4837-a2cc-ac506826761c@linux.dev>
Date: Fri, 13 Nov 2026 14:56:34 +0800
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
To: Kefeng Wang <wangkefeng.wang@huawei.com>, muchun.song@linux.dev,
 osalvador@suse.de, david@kernel.org, akpm@linux-foundation.org,
 azpijr@gmail.com, lance.yang@linux.dev, Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org,
 "Oscar Salvador (SUSE)" <osalvador@kernel.org>
References: <cover.1794379433.git.zhengqi.arch@bytedance.com>
 <1c5e8c4ae230dc238a16f2f42d65bffac6244ad3.1794379434.git.zhengqi.arch@bytedance.com>
 <7def88b4-cba5-4e8b-9e68-6069c492b582@huawei.com>
 <1cd3c151-24c2-4fec-8356-99853f8d6971@linux.dev>
 <9b46d8e0-104e-4659-8dec-67eb6f059dac@huawei.com>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <9b46d8e0-104e-4659-8dec-67eb6f059dac@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/13/26 11:56 AM, Kefeng Wang wrote:
> 
> 
> On 11/13/2026 10:30 AM, Qi Zheng wrote:
>>
>>
>> On 11/12/26 7:27 PM, Kefeng Wang wrote:
>>>
>>>
>>> On 11/11/2026 2:46 PM, Qi Zheng wrote:
>>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>
>>>> cma_alloc_frozen_compound() uses GFP_KERNEL, allowing direct reclaim
>>>> during the first MPOL_PREFERRED_MANY allocation attempt even though
>>>> the caller clears __GFP_DIRECT_RECLAIM.
>>>
>>> MPOL_PREFERRED_MANY is only used for the partner allocator. Without your
>>
>> It's doesn't seem so.
>>
>> Gigantic surplus allocations already use MPOL_PREFERRED_MANY, following
>> eb02f14c4a2b ("mm/hugetlb: allow overcommitting gigantic hugepages"),
>> which predates 9bda131c6093.
>>
>> alloc_buddy_hugetlb_folio
>> --> MPOL_PREFERRED_MANY
>>      --> gfp_t gfp = gfp_mask & ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
>>          folio = alloc_surplus_hugetlb_folio(h, gfp, mpoli->nid, 
>> nodemask);
>>          --> alloc_fresh_hugetlb_folio
>>              --> only_alloc_fresh_hugetlb_folio
>>                  --> alloc_gigantic_frozen_folio
>>                      --> hugetlb_cma_alloc_frozen_folio
>>                          --> cma_alloc_frozen_compound
>>
>> Before 9bda131c6093, cma_alloc_folio() forwarded the caller's GFP mask.
>> The conversion to cma_alloc_frozen_compound() replaced it with
>> GFP_KERNEL, re-enabling direct reclaim during the preferred-node
>> attempt.
> 
> Oh, I forgot about that commit. The naming and some of the comments are 
> misleading because alloc_buddy_hugetlb_folio/alloc_surplus_hugetlb_folio
> can allocate both buddy and gigantic folios (which can be allocated from
> CMA).
> 
> Maybe rename alloc_buddy_hugetlb_folio to hugetlb_alloc_surplus_folio,
> or other names...

Naming is difficult. ;)

The Hugetlb implementation seems quite messy in many places; let’s focus
on fixing the issues first.

