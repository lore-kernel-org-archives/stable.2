Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D754F43D4FD
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836995; cv=none; b=iGpLs8Ec8w5U4gZQl4NKsadlmPDCip2lWUDZe5h07SN5lH1RCLksl3sBON3BPuK6zhRyBSGdW9ih8B8QydpbNxxxhnlfeVh2lOv7EadjlqM3VzaaLU5HUhvSd8Kf8fBMDReQrJkcLf59xHcxH6jhfte6lxSm9dcNPdY3Vn13r58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836995; c=relaxed/simple;
	bh=2hqwKxuvASlqegCD99d0tLwzvxPXUavIaaZGuu9QST4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HaEUHXmJwZ2KzjQO82hLVHsPk6dyyNEgj4FC5cbE1g+D3s98OOz4IPhbCtglQ6dGWDYnqH6grS87ZcAr2FFjGpJsVpZj8tNKX9FWy77Vn6tobxnwIA/AYXyUgXdRLQn4IPU6ckNAY8vAdTPz3yOYzQDq6J2sNv8euiZAnoSL4og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwN5/TCF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwN5/TCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFEC1F000E9;
	Tue,  4 Aug 2026 09:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785836990;
	bh=BsV3o1KLMefy3XRvWOq5u78Xu6yZM8uWhDXpfCPHVF8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BwN5/TCFBCvIzvY1vCR0CTNEB3H25/SXZSKTNq28DbjncHPFkXWk0pL79VWac3vWc
	 jryLhb7KFzD1h0TjNnXFUR0/Ws1tCzXFqMIla4FoZlOU46vYVJG+DtgMe7bRxWZox4
	 /R5uMkS573Gi9i51af22zh1fD38R6y0r57sfldrQ0/NDDaqXC1W419eyigqrEUgnpn
	 U1WQ6vF1Pa+fwuhjy19aGrYHxVZytkjY2nX0+Odqec+Z0j+gbr4mdWU5/ZwdjpRyhn
	 DJga5q5EyWRg/D+4bzkCKmxHoDhgviFxpYiArPZRuSMxipmtslLh9WX4t0vRw24Ib0
	 ZWu64bOd8B/1g==
Message-ID: <0adaae9e-7086-4213-811e-ba6e4181e145@kernel.org>
Date: Tue, 4 Aug 2026 11:49:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix incorrect flush address in direct page table reclaim
Content-Language: en-US
To: luto@kernel.org, linux-mm@kvack.org,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: luto@amacapital.net, "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Qi Zheng <zhengqi.arch@bytedance.com>, Liam Howlett
 <liam.howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
References: <20260804003708.49830-1-luto@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260804003708.49830-1-luto@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+Cc Linus for nerd sniping purposes

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

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

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

