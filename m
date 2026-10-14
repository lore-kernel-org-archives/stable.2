Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0563B14AB;
	Wed, 14 Oct 2026 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791965045; cv=none; b=b0+JEhpCjNsHJLIg+T0Nzy0/pRAY1Wu+M/Lo24TIeGnudbgsncpijkwG2168Iz0bys+eREamp4sDfzCzTNgMPBvHQAigrx2gAlmDCsaCTP2eWN4WQWtzsMjzgaxf3CaekAr1Uvsx2nJdSRBA5Fkn2g+3ObeTccs19fCvAnoWbww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791965045; c=relaxed/simple;
	bh=VUvyoQp7IJ7ge8DNUtWhByz1MCFOiIjd3zBAxfxqntY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AiH4wgo1Qkn9JVyOraDPxviusOXUFq2GGfRxEPGgUP9VBnnOE4LAZVVIsm65rHD6C64tDi2FvQK6VPoF76E//G8COtkmAPvNOHi/14Z73+YHlIWT4i5es5pHikuPk7DzsaYQRmee9fv90s9+S3+WtRoG/OLnKIprJecY6d02DnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ai0tDpZ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ai0tDpZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354451F000FF;
	Wed, 14 Oct 2026 08:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791965044;
	bh=deXI1eiZdMA+rkrnahrdm835ND51y4e0N1ut/tP+PjI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ai0tDpZ2EZeG/dvtP+1wHIwzOW7ilCIq0udzFFDkI0sYJoRsijgr1TvQleV8oIaA3
	 +AI4sbxOlu2cs0No/M/Orymgt3KpM7nYldonsRcxk44/NWct60V6MuWz6ND4fAuUnX
	 sISzo56gQmTUvPta4zKqa+EuKemlpuGcBCG25RAs2jAMRa+n+p2jGXFTk97c7EvyIT
	 X4av0a3nGHqCNa0X2yKZLUtU05RfHB3YdjPAAXtwOoOYWpFg3zaEH/pmgFDqMTRkTw
	 9nDmaCaukYhgpG7j6rNBn9ByTlt8hoUYpH72HtL/HUqORiIi/+NQOY7NPFlAIGmU3R
	 7KqMMan2HLljQ==
Message-ID: <8d5bbe19-710e-4488-901c-22263ea6797f@kernel.org>
Date: Wed, 14 Oct 2026 10:03:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix address wraparound when scanning large folio PTEs
To: Barry Song <baohua@kernel.org>, Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Chuanhua Han <hanchuanhua@oppo.com>,
 Kyle Zeng <kylebot@openai.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261013-folio_pte_scan_range-v1-1-c50dc30bf6ad@kernel.org>
 <as4qKLx_XwQ6qY3p@thinkstation>
 <CAGsJ_4y5j+p0-VdEzpnS-Q31vhvBZRa96VJtA6+HyNj=+r+Ufg@mail.gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <CAGsJ_4y5j+p0-VdEzpnS-Q31vhvBZRa96VJtA6+HyNj=+r+Ufg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/13/26 15:17, Barry Song wrote:
> On Tue, Oct 13, 2026 at 8:57 PM Kiryl Shutsemau <kas@kernel.org> wrote:
>>
>> On Tue, Oct 13, 2026 at 02:30:37PM +0200, David Hildenbrand (Arm) wrote:
>>> numa_rebuild_large_mapping() and do_swap_page() can be tricked into
>>> generating an address wraparound, crashing the kernel. All that's required
>>> is to map a tail page of a large folio close enough to the start/end of
>>> the address space to e.g., make
>>>
>>>       unsigned long addr_start = addr - (nr << PAGE_SHIFT);
>>>
>>> to wrap around.
>>>
>>> Let's fix it by providing a better helper, folio_pte_scan_range(), that
>>> takes care of staying within VMA and page table boundaries while
>>> handling possible wraparounds.
>>>
>>> Reported-by: Kyle Zeng <kylebot@openai.com>
>>> Fixes: d2136d749d76 ("mm: support multi-size THP numa balancing")
>>> Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>>> ---
>>>  mm/memory.c | 43 +++++++++++++++++++++++++++++--------------
>>>  1 file changed, 29 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 1f5d5f7d39cd2..a3823010aa981 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -4933,6 +4933,27 @@ static void check_swap_exclusive(struct folio *folio, swp_entry_t entry,
>>>       } while (--nr_pages);
>>>  }
>>>
>>> +/*
>>> + * Get the address range in which a folio might be mapped, assuming its pages
>>> + * are mapped consecutively and the folio page at the given idx is mapped at
>>> + * the given address.
>>> + */
>>> +static void folio_pte_scan_range(const struct folio *folio,
>>> +             const struct vm_area_struct *vma, unsigned long addr,
>>> +             unsigned long idx, unsigned long *start, unsigned long *end)
>>> +{
>>> +     /* Stay within the page table and VMA boundaries. */
>>> +     const unsigned long pmd_start = addr & PMD_MASK;
>>> +     const unsigned long pmd_end = pmd_start + PMD_SIZE;
>>> +     const unsigned long lower = max(pmd_start, vma->vm_start);
>>> +     const unsigned long upper = min(pmd_end - 1, vma->vm_end - 1) + 1;
>>
>> These -1/+1 gave me a pause. I guess it is for pmd_end wrapping to 0 in
>> the top PMD? A comment would be nice.
> 
> Will pmd_addr_end() make it better? I mean
> 
> upper = pmd_addr_end(address, vma->vm_end);
> 
> nop?
I don't like pmd_addr_end(), given the weird semantics:

include/asm-generic/pgtable-nopmd.h:#define pmd_addr_end(addr, end)                     (end)

Even if that doesn't apply here, I much rather spell out the boundaries clearly.


-- 
Cheers,

David
