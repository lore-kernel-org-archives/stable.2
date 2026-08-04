Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F32BEFEF
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827414; cv=none; b=cvO/AGmN9C3Z5nxfJD6E/p7zagJGP8Hi1Ttrlp/jHqt7PoL0ESpVGUeJXBw+diw12EEDaI5CTCEiGaeZjCFspWK1vQEbAWuUGNNAaOOHmAykCqXW3C0QTZ5XKYtxBi0Ci6HtiRSNTyQcQ6Tznjc2juFf0lCQ3rRQ1FcsqAZlj7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827414; c=relaxed/simple;
	bh=ZEJea/w+GUiDRAm1FfRunk/Q/VmcR5t9BM+IWn44s2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBMMuWQGLkO53V+49GX+g7FyvQXQ8IwBVEd42lmGAoMQuc/b6puoC2UJev461MhliKM7/2MFWa6EypbgZYh8ZTtjM2Pc1PZQ1Mhi5AEaumahyAEMomGFSgOc6sU3WXd1NQWF4qcNruhLRZzi3m6nGPe97A5RvAwhA8PoJid7pm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FqcCNj46; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FqcCNj46"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so30153635e9.2
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 00:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785827411; x=1786432211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8CHZd4YuwGcJc3b8qOHO09r1oYkP6xlLG3IhvYLK+Yk=;
        b=FqcCNj46pWopRXR17M+HuM4sTtv4SDXkCYKgmV2FkpOe62xUd21LS2W5me58rxX8tD
         /9EG9+lVFdLKUn3XsTEEl3YvH0Zzcsq029E1QjM/GobKh5cWowoIpE7JjwI37DT+hvVh
         I533uPK5TnKBaegi12C8en8eaQ3/UyFSWoan+BRn2NU0o90PHgMnXHMzHN53cfkH5qKe
         ovkBpGcwY7sbyPY3zcSVIxQamlDBGaKzfFhC4LMXx+iuJiWvA74TMMKhhs8amKT0WwKb
         2dvb63xwN0sAWyDfMymZdzCKMzKk07edareQ76OuV9fbUNuOtYXa1K6lxgP+mOK4vRrx
         YGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785827411; x=1786432211;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8CHZd4YuwGcJc3b8qOHO09r1oYkP6xlLG3IhvYLK+Yk=;
        b=ODmClQKE87MAfiVS7fIwe5XRAgt4Z4pw80b1Q2qX8o5sqUHcn8fce64SD5B41fnN8b
         nThCRGBUSfMfturiEswMLr8gFwy+hNS3WiviRBMFbqN5zy+cALQ0hDrP9gdV88ZEphFP
         SNBXDfYbyyI+v83XKESjHDtKvvDFrldNVqbtJn2FrR+MYhkMwi12UnoUVuClATljkyTH
         es6HdueI/4UEpIdmSxaOJEIPbnXFdnL0Y7+xz/RPX3PesPVVHIDoTOK+uGBmmjLd1fY9
         sWcpKOWlnuOKxparPtmQE4xvwBi5po4eFSMQnypOVaY9h7FCJ4EONRPiNtssD+y3Rs47
         AGeA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3gnbdAwetXm3hMSf/v4X6J7cwJ2LZSkjd9g+9mXI8SNiO1n6yQudARF/A6Oj9bXwa88HPSEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMMEj5u8NbjLYM6xf8bF2ZdSD8bWKCZYdrE/UG6bH4MOARDdEy
	uCqxYVlCSjvfnUPRhLSVILnWx2AhAfGGCuxMNrPjuSivzd/mEWn1xUGnVHA8eZw20cw=
X-Gm-Gg: AR+sD11P76hR3ydfjQgcXm0uO3I44CUC2XIkU4xeHKyguPUXhokjolpju17ul2CQk9J
	7JpTrueX3N3iI+yHyW4xrDb9FoJ7TNDB0vtS8xg6D/gSF8jPcYbpEFrICUpAV/g8eXVWlisZl4f
	HsEOqOYoRCKmCSB8tM8AFJf89wfXgUBoyaUcsRXAlS8lY7Tq4Ty9mPRzxepDT4KHZC9fBMM3Qdd
	T0JcHlAC982PB0ohEffvoVqy1j0+k0R9Y2QH3aXkDmQCZnEFYBk3HOGFt6d7wzkPDHtuIFQ+2cg
	SonJWeQS1yqQKL8B/xCnENBClwC93/Rj5+ldl3h0cKriaZle0lmDrR3WHAUrWJsm5V4fAkhTT6c
	IhNvZ9+QvHc+c4Ljz6Ew30WvTaErADOG5usWEHhrXMVh+0roQteCVbjxz05XBrppdbkcMGF1Kas
	GXv7GT+MBcPc7KgEuJrPZ6S6NZkC8bmx7VEreDFctLAt6udzF7cUlD4EbJCEhP4LCLuH3simT/y
	+7tT1ZZmo53
X-Received: by 2002:a05:600c:1908:b0:495:7838:7e25 with SMTP id 5b1f17b1804b1-4980ee9f00fmr283702505e9.15.1785827410708;
        Tue, 04 Aug 2026 00:10:10 -0700 (PDT)
Received: from localhost (109-81-82-211.rct.o2.cz. [109.81.82.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5b4a2sm364133085e9.1.2026.08.04.00.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 00:10:10 -0700 (PDT)
Date: Tue, 4 Aug 2026 09:10:09 +0200
From: Michal Hocko <mhocko@suse.com>
To: luto@kernel.org
Cc: linux-mm@kvack.org, luto@amacapital.net,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH] Fix incorrect flush address in direct page table reclaim
Message-ID: <anGQUYvgDYj1Z0ti@tiehlicka>
References: <20260804003708.49830-1-luto@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804003708.49830-1-luto@kernel.org>

On Mon 03-08-26 17:37:08, luto@kernel.org wrote:
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

Very well spotted. It was really easy to miss that change during the
rework.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

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
> -- 

-- 
Michal Hocko
SUSE Labs
