Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF8E3B9D8C;
	Wed, 19 Aug 2026 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149912; cv=none; b=d59r169SB/V/lpW51KB2lpUlsRv2IE8X//HI47gt9pEOsYd9+8NDXUFw1rqfzBH1WoVxGgtzd8xqsWYTuDQ0xgQAk/fJUHzyFzTqOj7jQ36Xh7Af5+UBaQO7A5YKKcW1dNvJKyA4HKDgzXkiYGUQYSAW7SObKSNnP/egDMEwPqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149912; c=relaxed/simple;
	bh=7W4o1OJURvnOdIThrJxaRqjbhXtD6H2a2kzLrkk0yA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmgtkJjPnzpIiSQT8zWX4V21/jmVkM1pL0CF5UryZu2PaLo75HkDRFeeesouy27+ovk15E7F6MwjGqCNtcPNus3IYTp7aDUe2myi++o+HGI/o6GZSVprfjy5XR7RN5/0hg6QC5TSHjVMGIzNrN1bZHSjDCspqwCjc95B9v1Gn1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSP5n2xW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSP5n2xW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B141F00A3D;
	Wed, 19 Aug 2026 14:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787149908;
	bh=o9hL2zPKdPgs0tnH+5d/gk+ueKMxp9P+vcuepzTiVwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hSP5n2xWxVocs+JOnjL7+TVh4fWHw+ON9XGYiY95OdunuzN5Xew1X+o+WeiwBMaeX
	 Cfae7yrOqIREMT8+3VTLBk+6XtFMaJbupCZIpsZKMMADmBvxmwfnP1NOgJxetnynHl
	 kNxHAmDOtJ62NtmBulrhIE7+o75v5vE27C9QgsV66y+4CPAC3wFP5sBJYl1UPoN9Fs
	 FgV4+3GaPbT6B5pmdZjTpp8oFqxDvEIsW75IgrkdoRaEwCI1eTynzVITAzeTommc22
	 QkkMXBlE/GjXepaS7rReSyyaaXWr1r6odQOtPzdpcJQ5VnAcyhbs8+pzHONCMDWaPr
	 NozeBn9BDdjiw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id 851771980050;
	Wed, 19 Aug 2026 10:31:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 19 Aug 2026 10:31:46 -0400
X-ME-Sender: <xms:Tb6Faok3i-dm0H9rS3jUX0pvk9UpAelOaKToC4HOs9R-BtSwEjbRAA>
    <xme:Tb6Fas6JeZeTtHLs_JZqQ7Aaf-gSXkVXXP3CG9TvUb7cObGFUhjS_5uVF6DxfGGMp
    NG_ngo1k7rXzcUO7SX9OjmUuAY861Y9bmtu2FNE9lyZoLkVesCdTA>
X-ME-Received: <xmr:Tb6FajoGnUk1mdca6i9OLwpTyrHyQa9_7mTQqMQPLYZWveVvQ3p9cIA15RQ>
X-ME-Proxy-Cause: dmFkZTF42tJSbts6mf9F9oXTzfvss1tjtzDvWnFg8m061QZeTeF6vhFaQtDHjL2/3ftFnB
    aFPcb4p6MUdN9+3pb/2vojcWzemgyDQMIo0qqiBYTAENbnrXMi9Aot+OJ732H+/iOj4TkQ
    UW6KOX/5Nsng3IBn01i8dwcK1UIQbngydn8TCkAboN6DwoIpZieNOVoKs7klySzQYvfmy/
    CMNONe8gzzXK43jqFi8fypPcac9ti5PY7WBwwuIDD2R2A71esJbhvYZarcBkdAfthU2FHB
    IMDubUYkgARIYkMwk7hg4B+eywnxtAvE8QvciQ8Cb3tA61BE3eG+n+iuR5yFdyKKXuvOf2
    MUWP/gOzPpLyyJgH7J4k0hNNF5D1FLsfoxY1HA2dnEGlYWZnfD13tUkrL+d8SDmO6yWbmL
    Ihw3ACASJwTCqR+0xnPnByDptuOYfA2xwvoqlTkTUnx1cfLlOiuhLPErhrACzRlGtwP3tV
    ZEruxLZdn5cuBwphmxbOpTdGoELe6maSK8G3791ODUBQ66kSHieDPDWDNuzM015LiGlf40
    JVxZlacB/ThSuAi7JWj07OYQonYJOa5jJs/KgKdk5gNlZRRtdWpEADS2TuoMjO7vq817kb
    apfDs73DhCFvKWVdbneCaAvkzoPQSS9Vr0fXTackII+vnHFl28eXhupToV0g
X-ME-Proxy: <xmx:Tb6FaiRkGuqUee6HTPf8rrhL7Iy2hqoiH2zbWXY_Zt6W-pbS62a2Fg>
    <xmx:Tr6FaoWS9afcEduZQM4WavzqMSykfvLVu7uSi135f01UPIMOt1IuZA>
    <xmx:Tr6FahDvq-GC9zKAavZwR1cuCEYJJO1ZDaPVhCGKzcMBPmdCjAqmnQ>
    <xmx:Tr6Fans-9q00rNpr9Hh_tvdSnfNSC6scLBUwNNAroJps6CKERhzcKw>
    <xmx:Tr6FakrIA3RMIT7DTz4DYCAUxXHTebrJMM5bfyc-3yFgCAYdJKuv8m-g>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 10:31:41 -0400 (EDT)
Date: Wed, 19 Aug 2026 15:31:40 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Usama Arif <usama.arif@linux.dev>, Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com, lance.yang@linux.dev, 
	liam@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, 
	nico.pache@linux.dev, ryan.roberts@arm.com, ziy@nvidia.com, nphamcs@gmail.com, 
	hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev, kernel-team@meta.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: transfer the pmd dirty bit to the folio
 on zap
Message-ID: <aoWw_iKEDLjKL2jr@thinkstation>
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
> and never call folio_mark_dirty().
>
> A shmem folio allocated by a fault
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
> 
> Reproduced on x86_64 with a tmpfs mounted huge=within_size: read-fault a
> 2MB-backed region, write a known pattern through the resulting mapping,
> munmap, force reclaim of the cgroup, then re-map and read back.  Without
> this patch the region reads back as zeros and vmstat shows zswpout 0 -
> the data was discarded rather than swapped.  With this patch the region
> reads back correctly and the pages are swapped out as expected.  With
> huge=never, or when the first touch is a write, the test passes either
> way.

+Hugh.

Oopsie.

I'm confused why it took a decade to discover the bug...
Maybe read ahead of write for shmem is too rare, I donno.

> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")

This would be more precise: b5072380eb61 ("thp: support file pages in zap_huge_pmd()")

Reviewed-by: Kiryl Shutsemau <kas@kernel.org>

> Cc: <stable@vger.kernel.org>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
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

Unrelated to your patch, but noticed while looking at it: we drop the rmap
here under the pmd lock, while the TLB flush is deferred to
tlb_finish_mmu(). The pte path handles this with
tlb_delay_rmap()/force_flush (5df397dec7c4), but there's no pmd equivalent:
tlb_flush_rmap_batch() only knows folio_remove_rmap_ptes(), and
zap_huge_pmd() uses tlb_remove_page_size(), which takes no delay_rmap.

Doesn't matter for shmem, but xfs & friends do get PMD-order folios, and
do_set_pmd() makes the pmd dirty+writable once page_mkwrite() has run. So
folio_mkclean() can clean the folio while another CPU still stores through a
stale TLB entry -- silently lost write, no PG_dirty left behind.

I think we need to fix this too.

Wanna give it a try?

>  		if (is_present && pmd_young(pmdval) &&
>  		    likely(vma_has_recency(vma)))
>  			folio_mark_accessed(folio);
> -- 
> 2.53.0-Meta
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
