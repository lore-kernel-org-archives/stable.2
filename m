Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FA848662F;
	Wed, 19 Aug 2026 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155761; cv=none; b=WbJx8TESXXv1oVntN0iONohgzT6cOjbZKMOV1LbzWZpnF6t0B27zmX5FPDK4DSJ1ccg8GRb6pX+5U0IYb1r2iuLt83mqm92FQp8QpYeTzc+7PL3AixDeqMxMlOUy1jQO29hoX2dvLsX2i329RUpRmxfVQPAOduZ04Mv2zK7e+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155761; c=relaxed/simple;
	bh=vyBInu7Tm9q5ns7vgEaEBClsZMsrSMd4w13hBn9wiMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVWp+wcct/4ZiJqYYWyPgM9iSbFYw6hlEC/2BH1fmdqcXjay8YKT1Y0li08j1IWBY/yo7YwUCMNLRtBdu6UV4sQwhTEzlNoXhOJfZHst4KIrMNPqiJLERahXVSYiL2541TWkri4S/RnA1lo2SaRAgwr1dNqnidhad+o2b/6MJds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOJKhE6Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOJKhE6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215971F000E9;
	Wed, 19 Aug 2026 16:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787155759;
	bh=63V/Ij2B9WrOrIN2e2zHaSp/qasYhzA6FfRA6dqG5dE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HOJKhE6QS17uYsGjRHWX/10MHY1v1FQtfamHsWROPjC4W1e30OS75ZZhE/FlHuLHk
	 JlA6cbf5GrzAQq1aJE2kXvjz/M3mxFgzeH6hcZy1bg887ih+kWUIH3WEvniS1FUHko
	 f8YGIOhYiEMOuzBgg/da9wIR0wfdVGX9uRtn6A43EsvkQfSSfF9AsfZi03KJ6qA9AP
	 V57RYR+ColbGaPdAWY8sGcIL2XVw1JMdpD2Ue1AuGazkqrgvaG7I6vI4WWh6cmRMvx
	 WUd8LeDNIpmMpgdgOFTk9eXWlfvlOTF6HHD8ezwbFSHAScUReKcXCNxQ1cAR83ZCN1
	 iiub28M0gMLHQ==
Date: Wed, 19 Aug 2026 17:09:13 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com, lance.yang@linux.dev, 
	liam@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	nico.pache@linux.dev, ryan.roberts@arm.com, ziy@nvidia.com, kas@kernel.org, 
	nphamcs@gmail.com, hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev, 
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: transfer the pmd dirty bit to the folio
 on zap
Message-ID: <aoXVDppXAxte7Hzl@gremlin>
References: <20260819101222.3732660-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819101222.3732660-1-usama.arif@linux.dev>

On Wed, Aug 19, 2026 at 03:12:22AM -0700, Usama Arif wrote:
> zap_huge_pmd_folio() propagates the pmd young bit to the folio for the
> file case, but not the dirty bit.  The pte path does propagate it, in
> zap_present_folio_ptes() and so does the pmd split path, in
> __split_huge_pmd_locked().
>
> For most file mappings the omission is harmless, because writing to a
> shared file mapping goes through page_mkwrite(), which dirties the
> folio.  tmpfs is different: it has no page_mkwrite(), and
> vma_wants_writenotify() is false for it, so a *read* fault on a
> MAP_SHARED tmpfs mapping installs a writable pmd via do_read_fault().
> do_read_fault() does not call fault_dirty_shared_page(), so subsequent
> stores through that mapping set only the hardware dirty bit in the pmd
> and never call folio_mark_dirty().  A shmem folio allocated by a fault
> is marked uptodate but not dirty (see the clear: block in
> shmem_get_folio_gfp()), so PG_dirty is never set at all.
>
> Unmapping such a folio - munmap(), or exit_mmap() when the process dies
> - then loses the only record that it was written, because zap_huge_pmd()
> drops the pmd without transferring the dirty bit.  Reclaim afterwards
> sees a clean shmem folio: the whole swap-out block in
> shrink_folio_list() is inside "if (folio_test_dirty(folio))", so
> pageout() is skipped and the folio falls into __remove_mapping().
> There, folio_is_file_lru() is false for a swapbacked folio, so no shadow
> entry is created and __filemap_remove_folio(folio, NULL) simply empties
> the i_pages slot.  The data is freed without ever being written to swap,
> and the next fault on that index returns a freshly zeroed folio.
>
> This is silent data loss for any process that keeps state in a
> MAP_SHARED tmpfs segment across an unmap - for example a cache handed
> from one process generation to the next through /dev/shm.  It requires
> the folio to be PMD-mapped, so it only shows up once shmem THP is
> enabled (which is what we did in Meta fleet and started noticing crashes);
> with THP off the pte path transfers the dirty bit correctly.
> It also only becomes visible when swap is enabled, because with no swap
> device shmem folios (which are on the anon LRU) are not scanned by
> reclaim at all, so the clean folio is never dropped.

Good lord.

>
> Reproduced on x86_64 with a tmpfs mounted huge=within_size: read-fault a
> 2MB-backed region, write a known pattern through the resulting mapping,
> munmap, force reclaim of the cgroup, then re-map and read back.  Without
> this patch the region reads back as zeros and vmstat shows zswpout 0 -
> the data was discarded rather than swapped.  With this patch the region
> reads back correctly and the pages are swapped out as expected.  With
> huge=never, or when the first touch is a write, the test passes either
> way.
>
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Thanks for this! LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/huge_memory.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ced400f72d43a..afbb5974bd225 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2449,6 +2449,8 @@ static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
>  		add_mm_counter(mm, mm_counter_file(folio),
>  			       -HPAGE_PMD_NR);
>
> +		if (is_present && pmd_dirty(pmdval))
> +			folio_mark_dirty(folio);
>  		if (is_present && pmd_young(pmdval) &&
>  		    likely(vma_has_recency(vma)))
>  			folio_mark_accessed(folio);
> --
> 2.53.0-Meta
>

--
Cheers, Lorenzo
