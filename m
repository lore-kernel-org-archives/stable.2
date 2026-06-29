Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4046BA45
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 06:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716375; cv=none; b=T0my3Vag8lqQLBZWR5Oq35llWGMrak1V9MNNv8T9cSi850WBG05KAykRZUnh7+RLkN8mYyTwqRgXOc52J+c8QTKvw0fmWujRpxb/QGHgxs99iZzcPljNKeMsSUvW5IRW0FZN85un5fwPd66rwfMJAJ0Thw9iEEEzZd3Z9nORb3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716375; c=relaxed/simple;
	bh=jo7qIqrE9uE0oWniagettds49XQ0MvQn/8X0KRnXJcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zo3S5DJe10T6B2VeycEtmn+6XYbPmXlIIfaDd+8T5OTC1Y+MgmlQJGlp8+bqANUI3pCeVribx7GrViyJGkP9Orb647KJHcHy4csentJcz2KeZg1TVvwunxsWlxPZyZXRSRLNdcPdpzivdoR+gAFyKVxz9dGcs3gNhAg4wTzib0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DDHiMsy5; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DDHiMsy5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782716370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHRiMqDlFwcJe/A5WBZFbr9/kLEIZnbR25zBaf1Mgu0=;
	b=DDHiMsy5WoetwRHmMY/f3MDGJeEIiEiSQlfiqCsqhkXrK0G8y2nHgKhJ+WyQoOzkR1Pj3z
	1J61aO1SyLsadSXK780OpBUYjd2sESHNxRD5m8AOU9clPbLrFQ50R1UkprCNTQkAsxEVO3
	Oeum72prWOggU3P3Aw11HExUVqbfbYY=
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: lance.yang@linux.dev,
	dev.jain@arm.com,
	linmiaohe@huawei.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	liam@infradead.org,
	riel@surriel.com,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	kas@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	rcampbell@nvidia.com,
	apopple@nvidia.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	mel@csn.ul.ie,
	nao.horiguchi@gmail.com,
	ak@linux.intel.com,
	j-nomura@ce.jp.nec.com,
	pfalcato@suse.de,
	dave.hansen@intel.com,
	tglx@kernel.org,
	jpoimboe@kernel.org,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/5] mm/page_vma_mapped: use huge_ptep_get() for hugetlb
Date: Mon, 29 Jun 2026 14:59:09 +0800
Message-Id: <20260629065909.88972-1-lance.yang@linux.dev>
In-Reply-To: <98f3aedd-de11-4a83-81b8-f3e3c9380e49@kernel.org>
References: <98f3aedd-de11-4a83-81b8-f3e3c9380e49@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, Jun 29, 2026 at 08:39:22AM +0200, David Hildenbrand (Arm) wrote:
>On 6/28/26 07:44, Lance Yang wrote:
>> 
>> On Sat, Jun 27, 2026 at 12:43:31PM +0530, Dev Jain wrote:
>>>
>>>
>>> On 26/06/26 10:16 pm, Lance Yang wrote:
>> [...]
>>>>
>>>> Just thinking out loud: given that huge_ptep_get() already assumes that
>>>> addr matches the huge pte, at least on arm64, would it make sense to
>>>> have a small hugetlb wrapper around it that takes hstate and aligns
>>>> the address before calling the arch helper?
>>>>
>>>> Might make the rule clearer, and a bit harder to get wrong again :)
>>>
>>> Are you suggesting something like:
>> 
>> Yes, that's what I had in mind :) thanks!
>> 
>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>> index fdb7bdf7645c..xxxxxxxxxxxx 100644
>>> --- a/include/linux/hugetlb.h
>>> +++ b/include/linux/hugetlb.h
>>> @@ -825,6 +825,15 @@ static inline struct folio *filemap_lock_hugetlb_folio(struct hstate *h,
>>>
>>> #include <asm/hugetlb.h>
>> 
>> Maybe worth spelling out the rule as well: 
>> 
>> For arch helpers that use addr, huge_ptep_get() assumes addr is the
>> address for the hugetlb entry ptep points to. arm64 already makes that
>> assumption.
>> 
>> Callers where addr may not be hugepage-aligned should use
>> hugetlb_ptep_get() instead.
>
>Do we have any examples where code would do that? I would think that all code
>must properly align addr ahead of times.

I was thinking of the memory-failure case from earlier:

https://lore.kernel.org/linux-mm/20260626141031.14309-1-lance.yang@linux.dev/

There, page_mapped_in_vma() can be called with the poisoned tail page,
so pvmw.address comes from page_pgoff(folio, page) and need not be
hugepage-aligned.

Cheers, Lance
