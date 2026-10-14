Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED8752CCFE;
	Wed, 14 Oct 2026 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985755; cv=none; b=S4Mfq88MXvsOIwqoSLdFAjyfC9JKSsRd1hVXsY1R90aYbDYbs77VG5DL/G66ge0swKQsAxu5yv0tteauN9KGwvMYtHfuSlTQ/0qIeU5v5SpUkc9xPOGu6quhztOR2ur9L9wv3abfhdfJfkDqqmBfJZycotTbIS9hJqk9sRn/Mw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985755; c=relaxed/simple;
	bh=ATEv/LgDAtufUjFNthhjb/yPJrgbH8CUVruzjsRTs8c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=G1wqUN+HbnozRwrVg4QBsVfmYQMIKm5w6bYAM+n7EdAVmmg8sa6gVlugWcohRrMUqec2JlSuoEz+e+pUgRbqkke94WIk7lb7BdIVETA4bRzjcESO2wy6TFDG/leWc3+9NO2M4OvLEIU+am8pWUcFKt0WJAwVTImV9xgd0HxdpzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPzlrtN5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPzlrtN5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6631F00A2F;
	Wed, 14 Oct 2026 13:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791985753;
	bh=VlLY8lFnuENoZRIPsEzQ8Q4quedoDle8h5IdEqEOpQ8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=PPzlrtN5VSLvNoSdjJv8S6IWz9JcAweG/P0+UvtQ1sFu3nTPMRHLcXiHWN6/+oOnh
	 b6OtZ7RNPpBkN6oXyFeYTlWLq8AVTzH20JzehD7cT8uw2qqGkQVdsEU2Z2f5T7zxkC
	 vTf251qwCUxZmP+wHqVHv04VZChr+GLxPVOZltV1asZdwZhTXbPgUqJMB2nd2dAvM+
	 aI/JIprBTd4sXSeuAB2rchOiIBEH2YxSdtlKkNWOhmY+ePYdJLniCVRNHZRbaaplMG
	 +PBAufsc9gt/VUYrXHHRlIK1CL1g+vCrrpqELVc8ry9r2hSzKlV6OkbaT3ClmIlA7v
	 tafO21tHnIPig==
Message-ID: <807e8d2e-e7c1-4491-a3e1-21d84cc58946@kernel.org>
Date: Wed, 14 Oct 2026 15:49:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix address wraparound when scanning large folio PTEs
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Ying Huang <huang.ying.caritas@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Chuanhua Han <hanchuanhua@oppo.com>,
 Kiryl Shutsemau <kas@kernel.org>, Kyle Zeng <kylebot@openai.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261013-folio_pte_scan_range-v1-1-c50dc30bf6ad@kernel.org>
 <as4kvHe9IFZH5qrC@gremlin> <9add8400-66c1-47e9-b5af-7a4081ebf3c4@kernel.org>
 <as-BZibPscw4cxsD@gremlin> <06930044-4bcb-4478-8a6f-2dd3cf6d290e@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <06930044-4bcb-4478-8a6f-2dd3cf6d290e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/14/26 15:45, David Hildenbrand (Arm) wrote:
> On 10/14/26 15:27, Lorenzo Stoakes (ARM) wrote:
>> On Wed, Oct 14, 2026 at 10:12:06AM +0200, David Hildenbrand (Arm) wrote:
>>
>> Since I'm convinced the logic itself is correct:
>>
>> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>>
>> This cycle is brutal enough not to hold up fixes :>)
>>
>>
>>>
>>> I had that, but decided "not worth it for an internal helper".
>>>
>>> Is anything here really that confusing to understand in mm/memory.c context? I
>>> highly doubt it.
>>
>> I mean I found it pretty confusing :)
>>
>> But this is a nice to have it's not a big deal.
>>
>>>
>>> Ugly.
>>
>> Yup, fair enough.
>>
>>>
>>>
>>> I can just call it "folio_pte_range()". Slightly similar (but different) to
>>> "folio_pte_batch()"
>>
>> OK that works.
> 
> Ok, let's do that.
> 
>>>
>>> Yes. It's fairly common, though, to handle clamping of exclusive ends that way.
>>
>> Right, it took me a while to figure this out though.
>>
>> It involves an implicit assumption in there too, that _one_ of these values is
>> known not to overflow.
>>
>>>
>>> As replied elsewhere, I had that, but decided to open-code as pmd_addr_end() has
>>> very weird semantics with folded page tables, where we just don't clamp at all.
>>
>> Hmm how so?
>>
>> The logic seems, at a glance, equivalent?
> 
> It's the following thing that adds confusion:
> 
> include/asm-generic/pgtable-nopmd.h:#define pmd_addr_end(addr, end)
>        (end)
> 
> I think we have to assume here that with NOPMD we will never end up in this code
> because large folios will not apply (each PMD table has exactly one entry as of
> today, so we cannot map large folios .... I think).
> 
> I can try condensing that in a comment and cross my fingers that that is the
> case. I tried that now. and codex review already tells me:
> 
>   • [P1] Folded PMDs can reach this helper — memory.c:4948 (mm/memory.c:4948).
> The comment’s assumption is false: arm64 with 64 KiB pages and 42-bit VA uses
> folded PMDs and supports THP and
>     NUMA balancing. Here, pmd_addr_end() returns vma->vm_end without clamping. A
> large folio remapped across a PTE-table boundary can therefore make
> numa_rebuild_large_mapping() walk beyond
>     the mapped PTE table. The previous code explicitly limited this to pt_start
> + PMD_SIZE. Cap the forward distance at PMD_SIZE - (addr & ~PMD_MASK) as well as
> the VMA and folio limits.
> 
> Let me see if there is any truth to that ...

Ok, the PMD table as a single entry, but the PTE table obviously has 2k entries :)

So large folios are possible and pmd_addr_end() would be wrong in this context.

pmd_addr_end() really only works in page table walkers ...

-- 
Cheers,

David
