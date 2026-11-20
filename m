Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795165188;
	b=cKtmjKmXmze6su5XXEobNHOewXbc4Cmq4Ms6q0lsyy354/paSNEf2rd2sf6Y2kimdO/3
	 tUzTK7t4HQKxBMi03F/YK4KkfUgEy997XvniikHDqU+GEyRAvpN3owhhnK+Fd4o/V4VB+
	 GkvnU0DUnlMLzluONrs1+BaOCkjR/fsf4hxemFlaTmpkqqzCDwt2hinS56hhStElGoPpA
	 z2sBw1Fi92EVTmxpmZtKy8gcs+GwKJpUgh4GpNZCZdDnP7PLgx70KU+GPKXw3Hv8r2Lf2
	 kRXJcVl1jj3OHUlVzT3+kURyJavY4y7zE7jtVddTkNw2sfoc/3tPS364B7691yRH32g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795165188;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Yc9PKLM1TRlGBdAGztoHr3hWSYWm+6yS6vAIXll0IPg=;
	b=LKYn0JOKxaroGU6BNQUOEAFci/ZT8HpzaTV6WEe6pkZfFgl0QUe2Do5g3WGMTeqHTSL0
	 8KeuER9mwLhTfRn6ir+sjVhkoBiia4gPfunVTHA6qmm3eA5gCh/qbQced3LoJAJaIz1ND
	 0F55dFqFJF/iBgNV+xf8DIyGJdFAgzUCdD1h18WumXG/TBzomIWto7qdoxDP1JD2ENPoG
	 Y6Nl3HwMFRtd5G5At47kspTto0FK/uGvnU1ci/DWTeNGDlUgAukJzOTcrWeBDL8H8/jgj
	 nFqZQOaBF20FvMeCzQAfB+E850w6bcGsiefg/J232dWHFT+dMCMm4VPsoJfepjHv+Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="ZTuu+/kE";
	arc=none smtp.remote-ip=95.215.58.11
Received: from mta1.migadu.com (out-11.mta1.migadu.com [95.215.58.11])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353E6606A332
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 353E6606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZTuu+/kE
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=j5sy5dx6lTWHNP91V+IG2oaea8AWB1IF7PeLayynPtU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795165186; v=1; x=1795769986;
 b=ZTuu+/kErGbrYo2EAUfdxPsJCulCf/mPmE+cx+8a/P4Szyb57xHYVvLt47wm0vx3T4zDn6sx
 8FYBuQIOQv4YIq1Uy8gwodwX4PMKEtuks16140GAL9kQ5PUPmIU6yxlaAmXtHUyq9jkd/a/cKGR
 970u3E1iYGzwaNsILxITdGjY=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ff20ff19d5265770;
	Fri, 20 Nov 2026 08:59:46 +0000
X-Mizu-Trace-ID: ff20ff19d5265770
X-Migadu-Flow: FLOW_OUT
Message-ID: <18eed3f7-1403-4738-b8f8-f11551e1cd7c@linux.dev>
Date: Fri, 20 Nov 2026 16:59:41 +0800
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
To: "David Hildenbrand (Arm)" <david@kernel.org>, muchun.song@linux.dev,
 osalvador@suse.de, akpm@linux-foundation.org, fvdl@google.com,
 Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261120074701.48298-1-qi.zheng@linux.dev>
 <8a43c25e-0828-492b-90cf-beeb72ecdbb3@kernel.org>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <8a43c25e-0828-492b-90cf-beeb72ecdbb3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/20/26 4:55 PM, David Hildenbrand (Arm) wrote:
> On 11/20/26 08:47, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> With hugetlb_cma_only=1, early HugeTLB CMA allocations follow hstate
>> registration order, which can depend on the order of hugepagesz= and
>> default_hugepagesz= parameters. cma_reserve_early() advances early_pfn by
>> the requested size without aligning the start of each allocation.
>>
>> On arm64 with 4 KiB base pages, 32 MiB and 1 GiB pages share a CMA pool
>> aligned to 1 GiB. In a 2 GiB CMA range starting at 4 GiB, allocating a
>> 32 MiB page followed by a 1 GiB page places the latter at 4 GiB + 32 MiB,
>> violating its required 1 GiB physical alignment.
>>
>> Simply rounding early_pfn up before the 1 GiB allocation would leave a
>> 992 MiB gap and advance the cursor to 6 GiB. cma_activate_area() marks the
>> entire prefix below early_pfn as allocated and only frees pageblocks after
>> it. The gap would remain reserved with its bitmap bits set, and releasing
>> the two HugeTLB folios would not reclaim it, permanently losing 992 MiB
>> of usable CMA capacity. An alignment-only fix would therefore also need
>> to track and reclaim such gaps.
>>
>> The same alignment issue can affect non-LPAR PowerPC64 hash MMU systems
>> supporting 16 MiB and 16 GiB pages, with 64 KiB base pages and
>> CONFIG_ARCH_FORCE_MAX_ORDER=7. The 16 MiB size then has order 8 and is
>> also gigantic, sharing the 16 GiB-aligned CMA pool.
>>
>> Allocate early CMA hstates in descending order. Each range starts aligned
>> to the largest supported size, so this preserves alignment for subsequent
>> smaller allocations without creating gaps.
>>
>> Fixes: d2d786714080 ("mm/hugetlb: enable bootmem allocation from CMA areas")
>> Cc: stable@vger.kernel.org
>> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/hugetlb.c | 28 +++++++++++++++++++++++++++-
>>   1 file changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 4a448c5909d36..d69a9532ad5ef 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -4600,6 +4600,22 @@ void __init hugetlb_bootmem_set_nodes(void)
>>   		node_set(nid, hugetlb_bootmem_nodes);
>>   }
>>   
>> +/* Return the largest early-CMA hstate below the given order. */
>> +static struct hstate *__init hugetlb_next_early_cma_hstate(unsigned int order)
>> +{
>> +	struct hstate *h, *next = NULL;
>> +
>> +	for_each_hstate(h) {
>> +		if (!hugetlb_early_cma(h) || huge_page_order(h) >= order)
>> +			continue;
>> +
>> +		if (!next || huge_page_order(h) > huge_page_order(next))
>> +			next = h;
>> +	}
>> +
>> +	return next;
>> +}
>> +
>>   void __init hugetlb_bootmem_alloc(void)
>>   {
>>   	struct hstate *h;
>> @@ -4615,9 +4631,19 @@ void __init hugetlb_bootmem_alloc(void)
>>   	for_each_hstate(h) {
>>   		h->next_nid_to_alloc = first_online_node;
>>   
>> -		if (hstate_is_gigantic(h))
>> +		if (hstate_is_gigantic(h) && !hugetlb_early_cma(h))
>>   			hugetlb_hstate_alloc_pages(h);
>>   	}
>> +
>> +	/*
>> +	 * CMA ranges are aligned to the largest supported size. Allocate larger
>> +	 * sizes first to keep the early reservation cursor aligned without gaps.
>> +	 */
>> +	h = hugetlb_next_early_cma_hstate(MAX_FOLIO_ORDER + 1);
>> +	while (h) {
>> +		hugetlb_hstate_alloc_pages(h);
>> +		h = hugetlb_next_early_cma_hstate(huge_page_order(h));
> 
> Was thinking that this could be written in a neater way, but it really can't.
> Best we could do is issue a single hugetlb_next_early_cma_hstate().
> 
> order = MAX_ORDER - 1;
> while (h = hugetlb_next_early_cma_hstate(order)) {
> 	hugetlb_hstate_alloc_pages(h);
> 	order = huge_page_order(h);
> }

Yeah, that is indeed simpler — will rework it and send v2.

> 
> Thanks!
> 
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks!

> 

