Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC3743A7F0
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785834318; cv=none; b=trFSLJeZC9Q5ieBTZbWUpBDZR1iZ9HsMJPzXXKeMUOYXtpIWyrxD9lQIxVpxipqomRt7TE4/ymDrcvzCFago10p8uJ2d32IKaUSL5lIVODfn/0MWi/C1PX3S/oADVEZ8YQx8QlYTB7E75Ki/E1yrJpogQ2UgV2eBzQuvWxZJK0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785834318; c=relaxed/simple;
	bh=0ZwuY7ERjyMN69WcoXn/ka+hwIlePDvIjJNGM0dTgbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEp7uqCs049RuRP/kLvNKeWo3kGi/conhsogzdF4IYVByLrBcXokZAWyU88hXpin0slG20BmBiWjkGAUAO1hCQ/ZpSRAIokZ6RcEsdZ/pItaE7s+CC4Br+uEt2Fx+SHkAoXZnRADdSLL64eentpFzHgGHLU/LjP+i78+I9vPnLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3jFx07+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3jFx07+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783741F000E9;
	Tue,  4 Aug 2026 09:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785834317;
	bh=hj059WCquP/lUvBihPYV79ogH8/82Qj5eNoxf3Md8Iw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=L3jFx07+roZJHX4SdQa/Ejs8hdyjLGoof/wlcpRbkAMAUjT08mQGdQRQzNwQYY05X
	 NB3wfIqvOdYioteyRg7rmVTwy8rmW72YRPCclU5+xbnJu3NycSEdmb81Ietu9DlsR7
	 iRG+fcKcjBL0qU+01KLMU4rNSGCSZcuRakm9XMwLXeeo6d9Ed96IGE6Jfd8aqjhKUi
	 a0fcnA6mUJ2b93BWcLMi7JS1GUqWpSyeT6hritISK/T29dAy77l07WgYWuJQp1DbFe
	 RPJHNCfKyL71+S1fZVRAn3mY7Kso3sedHkijEnUJ553E6ScXp3GmgpgPdg+BhE8POM
	 d2WpI+qEyy/0Q==
Message-ID: <313133db-3b94-4a63-8bcd-21952ff77e41@kernel.org>
Date: Tue, 4 Aug 2026 11:05:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix incorrect flush address in direct page table reclaim
To: luto@kernel.org, linux-mm@kvack.org
Cc: luto@amacapital.net, Qi Zheng <zhengqi.arch@bytedance.com>,
 Liam Howlett <liam.howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
References: <20260804003708.49830-1-luto@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20260804003708.49830-1-luto@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/26 02:37, luto@kernel.org wrote:
> From: Andy Lutomirski <luto@kernel.org>
> 
> When zap_pte_range reclaims a page table, it does:
> 
>     pte_free_tlb(tlb, pmd_pgtable(pmdval), addr);
> 
> and this is unconditionally wrong: if this code executes, addr *always*
> points one past the end of the range covered by the table.  The addr
> parameter is used to flush the TLB (really the paging-structure-cache)
> to drop references to the to-be-freed table, and any architecture that
> cares about the parameter will flush the wrong address.  (But they'll
> still free the correct page).
> 
> I think it's worth contemplating why the kernel works at all.

Note that this only triggers when someone does e.g., a MADV_DONTNEED over
a large enough range (covering at least a full PTE table).

So this isn't the ordinary munmap()/exit() page table reclaim code.

I'm still surprised that it took so long to show up; likely we need more
targeted tests for PT_RECLAIM that

> 
> If we hit the offending line of code, we will first clear the PMD entry
> (line 1954, zap_empty_pte_table), then we will issue pending flushes if
> force_flush is set (tlb_flush_mmu_tlbonly(tlb)), then we will skip the
> retry on line 1979 (phew!), and then we will do the offending
> pte_free_tlb call.  *Or* we will clear the PMD entry immediately before
> pte_free_tlb (line 1983, zap_pte_table_if_empty).
> 
> If we have any pending flushes (i.e. we actually zapped any last-level
> entries) at the time we clear the PMD entry, then the flush really ought
> to flush all references to the table (Linus certainly seems to think it
> will on all architectures [0]).
> 
> The condition under which we have no accumulated flushes at the time of
> the clear is very complex (the whole zap_pte_range function has absurdly
> complex control flow).  If we do hit the bad case, then we will end up
> clearing the PMD entry after the last time the range is flushed, and any
> CPU is free to cache a reference to the (empty) page table.  If this
> happens due to an ordinary read or write, it would segfault, so it would
> be rare.  But the cache could be speculatively filled as well.  Then
> we'll flush the wrong address and then free and possibly reuse the
> table.
> 
> On x86, even flushing the wrong address works on non-KPTI Intel systems
> because INVLPG flushes *all* paging-structure-caches, not just the ones
> for the target address.  But INVPCID does not, and flush_tlb_one_user
> will use INVPCID if it's available.  And then we're toast.  AMD systems
> are more susceptible: we set the EFER.TCE bit, which makes even INVLPG
> only flush the target address.
> 
> P.S. IMO zap_pte_range is a mess.  The control flow is excessively
> complex.  The direct_reclaim variable itself has a confused meaning --
> for the first part of the function it means, approximately, "we should
> free the table if can_reclaim_pt".  But, later on, it means "we ALREADY
> reclaimed the table".  And the goto retry on line 1979 is IMO just
> asking for trouble if the condition ever changes such that it might
> happen after clearing the PMD.

There is certainly room for improvement :)

This should, however, not be part of the patch description (best be had below the ---)

> 
> I think this might fix an issue in ripgrep reported here:
> https://github.com/BurntSushi/ripgrep/issues/3494
> 
> [0] https://lore.kernel.org/all/CA+55aFzBggoXtNXQeng5d_mRoDnaMBE5Y+URs+PHR67nUpMtaw@mail.gmail.com/T/#u
> 
> Fixes: 4c640eb4181c ("mm: move pte table reclaim code to memory.c")
> Cc: David Hildenbrand (Red Hat) <david@kernel.org>
> Cc: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  mm/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 86a973119bd4..13b70861c8a3 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1981,7 +1981,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  
>  	if (can_reclaim_pt) {
>  		if (direct_reclaim || zap_pte_table_if_empty(mm, pmd, start, &pmdval)) {
> -			pte_free_tlb(tlb, pmd_pgtable(pmdval), addr);
> +			pte_free_tlb(tlb, pmd_pgtable(pmdval), start);
>  			mm_dec_nr_ptes(mm);
>  		}
>  	}

Shame on me, thanks for sorting that out!

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
