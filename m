Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F392DEA93;
	Tue,  7 Jul 2026 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452325; cv=none; b=Ot/bAMszUBLkx122K7zdFDZp95fDUtZbOvF6+SH5khcPfw0XLB+RStbNmLjwV7rwBUaVGdNYBCHJ95Bjz4A3S1zgThaNue0uRQy8ppMVLoWa51bthUTsqJTT40nnmslkdEtgMxd5l3dNT7KX9mJIQiu8G+zqZi+mzWpYiESHnNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452325; c=relaxed/simple;
	bh=qyHXkiiXtHVu6IXHR06nA/H0C6hdALcVPLtuIdOWBmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=teKlwoTpjnXbpgwkduX3cWITEdDhiv8HDWzb6J5pQMX+r9lsORR4EknrQFZB4PEkGO6Bu9DEBM32Z/L+U7Wmv2VKWUQWhTgHbPFQ+An50Zv0S9URjF3M97lmCouXSHvq4rU6UMkrli0DnJXAL5xir50CK/kuR0LarHC2Yq/ctGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pnl3raGO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pnl3raGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD0F1F000E9;
	Tue,  7 Jul 2026 19:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783452324;
	bh=2xhU7BWgC9NP48BtOkymuxeMVINmF7dxhGu9Uk05sPs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Pnl3raGOoJkCwbnzFm64lOMWPNyEnR+6u9+7fd989jtUVH/maOI9HvwzXCprAFwRd
	 yj2xtf+KcrkVmrtUnSRrNgOANy/ipsDJGogspMH2MhUh12ZlWB4lWdCo9pX+nweAdq
	 zs2xJSy2+eaiwb8qC8GMpJLuQIHKpAE4o4Q6Rqabc30+8O5qL6of8fUaQX6bH6XVbZ
	 JY5W5kY9yUH9upf1RwbM2/HTnHc1lq7RTSqNmRCTAELq7TVY3KYYDn+3R50TZGi5YA
	 SRrw+Bg7LkezQyWX75bJqhWDEw0EABo6/wu3+et1PoS/R3DZvJCuGArG/lCUN2pKk/
	 EwWpwozAAcx1w==
Message-ID: <b7ceef51-b7f4-431f-bfa3-20e2e39e3a36@kernel.org>
Date: Tue, 7 Jul 2026 21:25:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: fix swap entry corruption when clearing
 uffd-wp at fork()
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, osalvador@suse.de,
 peterx@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kernel-team@meta.com
References: <20260703161833.57416-1-kirill@shutemov.name>
 <678ecae4-cda7-4683-9012-ed7c5c5b879f@kernel.org>
 <ak0w7MB_wKJtBLNu@thinkstation>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <ak0w7MB_wKJtBLNu@thinkstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/26 19:05, Kiryl Shutsemau wrote:
> On Tue, Jul 07, 2026 at 05:05:49PM +0200, David Hildenbrand (Arm) wrote:
>> On 7/3/26 18:18, Kiryl Shutsemau wrote:
>>> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
>>>
>>> copy_hugetlb_page_range() clears the uffd-wp bit of hwpoison and
>>> migration entries with huge_pte_clear_uffd_wp(), which operates on the
>>> present-PTE bit position. Swap entries keep the uffd-wp state elsewhere
>>> -- the same branches read and set it with pte_swp_uffd_wp() and
>>> pte_swp_mkuffd_wp() -- and the present-PTE position falls into the swap
>>> payload. On x86-64 it lands in the inverted swap offset, where a
>>> naturally-aligned hugetlb PFN always has the affected bit set, so the
>>> clear advances the encoded PFN by two pages.
>>>
>>> No userfaultfd needs to be involved: the clear is guarded only by the
>>> child VMA not being uffd-wp registered, so a plain fork() with an
>>> in-flight hugetlb migration entry (or a poisoned hugetlb page) corrupts
>>> the entry copied into the child. Instrumenting the hwpoison branch and
>>> forking after MADV_HWPOISON on a 2MB anon hugetlb page shows:
>>>
>>>   offset before=120e00
>>>   offset after =120e02
>>>
>>> The fallout is mostly latent: rmap walks match migration entries by
>>> folio range and remove_migration_pte() rebuilds the PTE from the folio,
>>> so a within-folio PFN skew heals once migration completes. But any path
>>> that re-encodes the corrupted offset -- e.g. hugetlb_change_protection()
>>> rewriting a writable migration entry via
>>> make_readable_migration_entry(swp_offset(entry)) -- propagates it, and
>>> an hwpoison entry misidentifies which page is poisoned.
>>>
>>> Use pte_swp_clear_uffd_wp(), matching copy_nonpresent_pte() and
>>> move_huge_pte().
>>>
>>> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
>>> Closes: https://lore.kernel.org/all/20260703140011.99E601F000E9@smtp.kernel.org/
>>> Fixes: bc70fbf269fd ("mm/hugetlb: handle uffd-wp during fork()")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
>>> Assisted-by: Claude:claude-fable-5
>>> ---
>>>  mm/hugetlb.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 571212b80835..a4e6dd3a82f4 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -4918,7 +4918,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>>>  		softleaf = softleaf_from_pte(entry);
>>>  		if (unlikely(softleaf_is_hwpoison(softleaf))) {
>>>  			if (!userfaultfd_wp(dst_vma))
>>> -				entry = huge_pte_clear_uffd_wp(entry);
>>> +				entry = pte_swp_clear_uffd_wp(entry);
>>
>> I think installing a hwpoison pte will actually drop the uffd marker.
>>
>> hugetlb_change_protection() does nothing on hwpoison entrues.
>>
>> So how could be possibly get a hwpoison entry with an uffd-wp bit set here?
>>
>> If we indeed can't, Id assume there is nothing to clear here at all.
> 
> You are right.
> 
> I am inclined to remove it in a separate cleanup patch. Any objections?

I'd just do it in this patch -- removing unnecessary code instead of fixing it.

However, if there are strong opinions, I don't care that much.

-- 
Cheers,

David
