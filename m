Received: from mta1.migadu.com (out-131.mta1.migadu.com [95.215.58.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085D92EEE65
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 02:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791597871; cv=none; b=rgTRzXja1LFDzUYUGLXrOQvnv4teFB6YEMa5VFDiXO2te4853QcmICADkkc+LI0/XS9O52O+xlks4icCaPPYb3ThXxNSsihINTeFibjGvKceGQs665UVjutO6ADGT3ROBSa2a8Jiy972arisx8rvJXTmh2S4ks3sjMnL+QCyJPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791597871; c=relaxed/simple;
	bh=fbmxI+htNWm74+BKcQ7IgvVzWZQKZq0MmTX+riidlGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vv059a1poSdelqZ71taENav/VgsnCZ93JdlrFGt7XODNMLKBIIPWNJwZG3XdiGDvRZLVx0B6FxC/ZVPkfKf9Z7PKT98xkFnbdhCnG0aZdLebqPDKlSie5pK9GNc9oKXSozO+bGxuBnZdaZ6+uTmY/LgV7UWE/aS5WN+XF4gAO4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FKG/sy/l; arc=none smtp.client-ip=95.215.58.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FKG/sy/l"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fbmxI+htNWm74+BKcQ7IgvVzWZQKZq0MmTX+riidlGQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791597866; v=1; x=1792202666;
 b=FKG/sy/lZB2dNFjWpqgvN5VwDtTKpSwOj/nsE1d6r01NeWdMc6w8rnJzau8xFdG/TGCoOII9
 DQllyG/uRqaIj+wFyww4IJA4PfFs5r1VpUsSpSstZ1jqd32mSQHUYegl8gZTSRo3/70+ylrXmqw
 P07gDFF4Ig9MTVnDJrTQiGuc=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6dd7cb59ec794fa2;
	Sat, 10 Oct 2026 02:04:26 +0000
X-Mizu-Trace-ID: 6dd7cb59ec794fa2
X-Migadu-Flow: FLOW_OUT
Message-ID: <b8d458c7-b9be-4d89-be48-940897695e6d@linux.dev>
Date: Sat, 10 Oct 2026 10:04:12 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: avoid transient none PMDs during lazyfree
 reclaim
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Kyle Zeng <kylebot@openai.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 stable@vger.kernel.org
References: <20261009165214.40212-2-kylebot@openai.com>
 <DM0II2QHWWS1.2RXEJXC8S0101@nvidia.com>
 <8db35dc0-eb06-42e4-90f9-534522e810e1@kernel.org>
 <55765FF3-18D7-424C-984D-81C316F323E1@nvidia.com>
 <d68cb3de-e471-4ce8-8c6d-c7260d79ec1e@kernel.org>
 <0ec81c65-fbf5-405f-948b-0fb1b2e083e8@linux.dev>
 <DM0S9L075B57.1FCNOI7LA1FJW@nvidia.com>
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <DM0S9L075B57.1FCNOI7LA1FJW@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/10 09:56, Zi Yan wrote:
> On Fri Oct 9, 2026 at 9:12 PM EDT, Lance Yang wrote:
>>
>>
>> On 2026/10/10 04:44, David Hildenbrand (Arm) wrote:
>>> On 10/9/26 22:27, Zi Yan wrote:
>>>> On 9 Oct 2026, at 16:23, David Hildenbrand (Arm) wrote:
>>>>
>>>>> On 10/9/26 20:17, Zi Yan wrote:
>>>>>>
>>>>>> There are some gaps we need to close before getting this fix in:
>>>>>>
>>>>>> 1. GUP-fast cannot follow the invalidated PMD: riscv and LoongArch need
>>>>>> pmd_access_permitted() that requires _PAGE_PRESENT; s390's
>>>>>> pmdp_invalidate() needs a change.
>>>>>
>>>>> Ugh. We really need pmdp_invalidate() to have reasonable semantics. This whole
>>>>> PMD locking is a mess :(
>>>>>
>>>>>>
>>>>>> 2. sparc64's thp_pte_count can be imbalanced with this change (based on
>>>>>> Lance's offlist feedback).
>>>>>
>>>>> Ack.
>>>>>
>>>>>>
>>>>>> In addition, powerpc has a page table check issue similr to riscv, where riscv
>>>>>> fixed it with commit 9f4a88b8d01a6. This is not related to this issue
>>>>>> but discovered along with the investigation.
>>>>>
>>>>> Zi, do you have the capacity to take over this patch?
>>>>
>>>> Yes, I can take over it. My plan is to send a series including
>>>> patches for 1 and this patch as is. powerpc fix can be a separate one.
>>>>
>>>> Best Regards,
>>>> Yan, Zi
>>>
>>> If we need a quick stable fix we could temporarily disable the whole thing until
>>> it is fixed, just a thought.
>>
>> +1 we could do that for now. A quick fix with minimal churn (correctness
>> comes first).
> 
> How about the patch below? unmap_huge_pmd_locked() and
> __discard_anon_folio_pmd_locked() will be dead code to keep the patch
> small. Later, with arch fixes, the function can be re-enabled.

Looks good to me! Thanks for the quick fix!

> 
> 
>  From 2204b9d08530796847a586428b1f782b987d071c Mon Sep 17 00:00:00 2001
> From: Zi Yan <ziy@nvidia.com>
> Date: Fri, 9 Oct 2026 21:28:10 -0400
> Subject: [PATCH] mm/rmap: don't discard lazyfree THPs at PMD level
> 
> __discard_anon_folio_pmd_locked() clears a lazyfree THP PMD before it knows
> whether the folio can be discarded, and restores it if the folio was
> redirtied or has extra references. A concurrent munmap() or
> MREMAP_DONTUNMAP skips the temporary none PMD and unlinks the VMA from its
> anon_vma, so the folio stays mapped after the anon_vma is freed and a later
> rmap walk uses the freed anon_vma.
> 
> Using an invalidated PMD instead of a cleared one requires additional arch
> code fixes. Instead, disable the PMD level discard of lazyfree THPs, as
> before commit 735ecdfaf4e8 ("mm/vmscan: avoid split lazyfree THP during
> shrink_folio_list()").
> 
> Fixes: 735ecdfaf4e8 ("mm/vmscan: avoid split lazyfree THP during shrink_folio_list()")
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Closes: https://lore.kernel.org/r/20261009165214.40212-2-kylebot@openai.com
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

Reviewed-by: Lance Yang <lance.yang@linux.dev>

>   mm/rmap.c | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 805db93fe0428..1131b76bbbc28 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2275,17 +2275,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   		}
>   
>   		if (!pvmw.pte) {
> -			if (folio_test_lazyfree(folio)) {
> -				if (unmap_huge_pmd_locked(vma, pvmw.address, pvmw.pmd, folio))
> -					goto walk_done;
> -				/*
> -				 * unmap_huge_pmd_locked has either already marked
> -				 * the folio as swap-backed or decided to retain it
> -				 * due to GUP or speculative references.
> -				 */
> -				goto walk_abort;
> -			}
> -
>   			if (flags & TTU_SPLIT_HUGE_PMD) {
>   				/*
>   				 * We temporarily have to drop the PTL and

