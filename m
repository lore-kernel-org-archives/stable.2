Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C3E43E075
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835597; cv=none; b=MTnBZ0bX/7ZlFHFCD0Ctppzo+OlUlVeaAG7tFD/POM5Ld55g8qMuq59n84Jjy8wPlw/Fm1QF+bSfFEUZHN7UlvnGf/Qb7sHilyWhIb9vNDRrUgYGZhnaBdZgeJ2db+3+2/7flSkYoTI9zBrMkr7rqujaJVNpiVsOqTfaQrzJj/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835597; c=relaxed/simple;
	bh=zxPnOVNPMIXhRmwjCzBGrr912l8i0WZutG7XcUsOXBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPDdeIq6GgJomJU1jwrqMVKaRAiJOb41wN0LKKgQOMIQL/iU8AVTfmx+bL1KiZ+RRfbOezMwDN5mOiLXxQ5tunYaXdL1Bn77yfO1raCaZaxvkqnh114Pb6On9JXiiVcp02f+fij0Hk3FOJcbvDybPJhIrHJyHGdleCK8VdphiMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WdGI1w4Y; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WdGI1w4Y"
Message-ID: <8cf8eaca-fc04-4a68-bbc8-50ecdbf96382@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785835590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GXsEyDbR+ekRmUJxbgwnYjbmowg3ztyLB2O7GdRRKes=;
	b=WdGI1w4YQks+dOYciTyQuvU/fCjKrq/XGQbuunri30FAQst23iApzmVJm3Lyyd+6exrtBt
	OeUePHyFqijPvgsOGHnQR11o7CTBsJHFa27auIJLn37tMsnpKM82AN+23W2TqrHXDgIoDG
	mE+RZgDQ+6VQGlE+H1yXEfwq5Us2wLo=
Date: Tue, 4 Aug 2026 17:25:33 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Fix incorrect flush address in direct page table reclaim
To: "David Hildenbrand (Arm)" <david@kernel.org>, luto@kernel.org,
 linux-mm@kvack.org
Cc: luto@amacapital.net, Liam Howlett <liam.howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
References: <20260804003708.49830-1-luto@kernel.org>
 <313133db-3b94-4a63-8bcd-21952ff77e41@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <313133db-3b94-4a63-8bcd-21952ff77e41@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/4/26 5:05 PM, David Hildenbrand (Arm) wrote:
> On 8/4/26 02:37, luto@kernel.org wrote:
>> From: Andy Lutomirski <luto@kernel.org>
>>
>> When zap_pte_range reclaims a page table, it does:
>>
>>      pte_free_tlb(tlb, pmd_pgtable(pmdval), addr);
>>
>> and this is unconditionally wrong: if this code executes, addr *always*
>> points one past the end of the range covered by the table.  The addr
>> parameter is used to flush the TLB (really the paging-structure-cache)
>> to drop references to the to-be-freed table, and any architecture that
>> cares about the parameter will flush the wrong address.  (But they'll
>> still free the correct page).
>>
>> I think it's worth contemplating why the kernel works at all.
> 
> Note that this only triggers when someone does e.g., a MADV_DONTNEED over
> a large enough range (covering at least a full PTE table).
> 
> So this isn't the ordinary munmap()/exit() page table reclaim code.
> 
> I'm still surprised that it took so long to show up; likely we need more
> targeted tests for PT_RECLAIM that

We backported the PT_RECLAIM to our internal tree a while ago (excluding
the rework patch being fixed here), and it has been running stably ever
since.

> 
>>
>> If we hit the offending line of code, we will first clear the PMD entry
>> (line 1954, zap_empty_pte_table), then we will issue pending flushes if
>> force_flush is set (tlb_flush_mmu_tlbonly(tlb)), then we will skip the
>> retry on line 1979 (phew!), and then we will do the offending
>> pte_free_tlb call.  *Or* we will clear the PMD entry immediately before
>> pte_free_tlb (line 1983, zap_pte_table_if_empty).
>>
>> If we have any pending flushes (i.e. we actually zapped any last-level
>> entries) at the time we clear the PMD entry, then the flush really ought
>> to flush all references to the table (Linus certainly seems to think it
>> will on all architectures [0]).
>>
>> The condition under which we have no accumulated flushes at the time of
>> the clear is very complex (the whole zap_pte_range function has absurdly
>> complex control flow).  If we do hit the bad case, then we will end up
>> clearing the PMD entry after the last time the range is flushed, and any
>> CPU is free to cache a reference to the (empty) page table.  If this
>> happens due to an ordinary read or write, it would segfault, so it would
>> be rare.  But the cache could be speculatively filled as well.  Then
>> we'll flush the wrong address and then free and possibly reuse the
>> table.
>>
>> On x86, even flushing the wrong address works on non-KPTI Intel systems
>> because INVLPG flushes *all* paging-structure-caches, not just the ones
>> for the target address.  But INVPCID does not, and flush_tlb_one_user
>> will use INVPCID if it's available.  And then we're toast.  AMD systems
>> are more susceptible: we set the EFER.TCE bit, which makes even INVLPG
>> only flush the target address.
>>
>> P.S. IMO zap_pte_range is a mess.  The control flow is excessively
>> complex.  The direct_reclaim variable itself has a confused meaning --
>> for the first part of the function it means, approximately, "we should
>> free the table if can_reclaim_pt".  But, later on, it means "we ALREADY
>> reclaimed the table".  And the goto retry on line 1979 is IMO just
>> asking for trouble if the condition ever changes such that it might
>> happen after clearing the PMD.
> 
> There is certainly room for improvement :)
> 
> This should, however, not be part of the patch description (best be had below the ---)
> 
>>
>> I think this might fix an issue in ripgrep reported here:
>> https://github.com/BurntSushi/ripgrep/issues/3494
>>
>> [0] https://lore.kernel.org/all/CA+55aFzBggoXtNXQeng5d_mRoDnaMBE5Y+URs+PHR67nUpMtaw@mail.gmail.com/T/#u
>>
>> Fixes: 4c640eb4181c ("mm: move pte table reclaim code to memory.c")
>> Cc: David Hildenbrand (Red Hat) <david@kernel.org>
>> Cc: Qi Zheng <zhengqi.arch@bytedance.com>
>> Cc: Liam Howlett <liam.howlett@oracle.com>
>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Suren Baghdasaryan <surenb@google.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Andrew Morton <akpm@linux-foundation.org>.org>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> ---
>>   mm/memory.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>

Acked-by: Qi Zheng <qi.zheng@linux.dev>

Thanks,
Qi

