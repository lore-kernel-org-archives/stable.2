Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DF71A9F96
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785807035; cv=none; b=IxW+S2Z25TsXIBfAPOb+OnF+YB1brfHeSQY5l/1c/LobSOZBkYuj+i59xaDYU/lDwcrCmRitbtJrV7VYoOm97yV5XACxfL2TXeMAnJcxuFdZd8UaPnjCmUCXWOWnHTAA2cV3KLuo8zWRyKSONkrX8PBO/sDeWVnulmBPiuoGnzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785807035; c=relaxed/simple;
	bh=JxqOqsYjtn0SYd4l0COVPAKAI1f0fxWFJUKoetKg1KA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ul23IBR+EEoERmXlCbqLYOhZ2lKQ/BHlyEMWn/fYO1G/9YShITwUlzKeIrZDI299/f1ZiJIIfmRNBihmLQwZM7ly4bcO70EntBYx02O7/C5dh9TM3f30LmEChL8ipSAyy0/dfjKBJvH5NBVRpRXbNoqSx1defMYAVHqlzWyNEPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ycu282mQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ycu282mQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F491F000E9;
	Tue,  4 Aug 2026 01:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785807033;
	bh=t/L/MMJR8dfLGR3Oi7GZgsl7WMiqO1bZP6I4xwqMLaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ycu282mQQVXVyhwb+s/oovbJewQNWcYI0isihQpIIUDwxDv2mjv8gP8ew2FG8eQo8
	 rqVFTbabsZsx/XbrWPjYKUHCDS9FfXtiuLiYSNtoOSDjElzfR67KRJNF7Og+KpTDwa
	 FO4uOyGGJF1aOI4cO1gyy5NkIH8eqEGvi6Z+JH8s=
Date: Mon, 3 Aug 2026 18:30:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: luto@kernel.org
Cc: linux-mm@kvack.org, luto@amacapital.net, "David Hildenbrand (Red Hat)"
 <david@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, Liam Howlett
 <liam.howlett@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 stable@vger.kernel.org, dfoxfranke@gmail.com
Subject: Re: [PATCH] Fix incorrect flush address in direct page table
 reclaim
Message-Id: <20260803183032.7cc1fb1007d309c2431855ea@linux-foundation.org>
In-Reply-To: <20260804003708.49830-1-luto@kernel.org>
References: <20260804003708.49830-1-luto@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Aug 2026 17:37:08 -0700 luto@kernel.org wrote:

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

Huh, cool.  Very recently I was scratching my head at Daniel's ripgrep
report.  Upon which he obviously did a ton of work (many thanks).

	https://github.com/dfoxfranke/ripgrep-3494-analysis

Daniel also pointed a finger at 4c640eb4181c ("mm: move pte table
reclaim code to memory.c").

The manifestation is that a tiny race window causes the zero page to
magically appear where an anon page was expected.

Anyway, I see Daniel is testing this patch.  Please let us know the
result.  (I think I found his email address).

I can't find an email address for BurntSushi.


