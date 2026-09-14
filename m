Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72BA3D7D7E
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789383581; cv=none; b=n3wJ1iXOtjycaBuK57H4ifnfIQOCLkT17Fh5DbWXSjt6MEfAogoPDp/EYsap7yN83oc326zO9IYO1/KuY0zVpfwCwDu3uM2Yf0CBwoYgTENM2aPvB4QbKP1Jti/iyN1BpkRQG2T4VfXEmb50B+FwwdJp/fdIcVJAed+N702HxQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789383581; c=relaxed/simple;
	bh=PgkI0z9SON09RoaG0Eo1dzgmmu3lPuYvERolAIKtbyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKHb1L2AB1Z9IIelwI4HvLkDODz19g8qbjkhd1afm113/TuyXk6wC5s0wki42qLBwYEXHQ7OTHpkF4AGYSFeV7ZS6V5z0RI3lkfW363pFSr18+1gN3wSEKWL+ncan0YPvYkmzs5IkqokLIT5yCLCzp66q9A+gbutgLC7d0iMKjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zuk9D7+m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zuk9D7+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA341F00898;
	Mon, 14 Sep 2026 10:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789383576;
	bh=k/820N3jYr2GH3WCO3bqlo3T1Ji36Ja7L774u/GuoxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zuk9D7+mhbmETqyGx+b6NA4d8RWyYcLoNEy1TLPy0e/Dn014vxpUU1WikKC0T0r/7
	 Ov0mc/YucGBUfMHEKxaz4Szf0RCtFDXTL2j+5EaEU684rqf7h1KAeJsVLwHuCgvnNX
	 rrJ4Xmspi5n/zFEUrfvdeasWfnfQdQ//QstsUMkPh0bcblv1/EHVAl33TI/hLAazdJ
	 cNEMhFVSfrV3SbjJoJY0rIhS5ju09P/WvIdRLw6sRKPkBBYVNX+nnLSUjbs4KwUuXb
	 r7jP6cKkSNV3pXSLrkE2Il3/ucxD2s/GuuCvD6IxvGqiJOIuaAAs2eYk6liRWao171
	 MU1WgEBpP/keA==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 90776198004A;
	Mon, 14 Sep 2026 06:59:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 14 Sep 2026 06:59:34 -0400
X-ME-Sender: <xms:k9OnaqHYjWotVJxbnp41r1vGY8JgRiwaCeF8ZUhFdpvWFG7d-4QyPg>
    <xme:k9OnatqGa77SeWvVYXGCWqC6KA_p51VWUT3QfNN8pXhsTf97SBefGebz3M2f4GUQM
    efQkSQbQBgk5TetMsyHfOTnRZs1MvplpYV0c_QnK22bo74jwpjhdFbC7Q>
X-ME-Received: <xmr:k9Onai2kuygq_g1aR0atLTaZwY5SGosh2LTQ7AUPw54UU8OogHShrHUYt1s>
X-ME-Proxy-Cause: dmFkZTEa4sevxAV6Q4GAtMmH3bNgFi9bBl2P5MgBoETq78GI1x+H4CqfJcXgtyg8PZSHj5
    LvBOUCzISOeMcJoRas58P2quezxpo3JC6BH90ravhEQYsyOcJAJXikWX7542hpMGHON4L7
    i7k6Zwylw09Q7uXYpekWt9ouQUuEpeXnzySfB+XsC6DRIfmU+wT5NEO4827CpZTmvhRRw5
    c6Kmio2ItUEUefEPyDnOD+8oAQJ/XhY/CYU1LoF4MPhTOKywPDF6hfnX5h1iFSclCvFQYr
    kcrXR0C/DEDl7eglkfSInGXgUWVUj950lWrgzDvr/sTLu+HwJpLB5xSuAE4a5sKhKXt3Ip
    PAy8KT9QsKuOTuZHH23753Aasww8q9BumVuQkb4ZSLnqUwyQwh0wDgZdyuVJSqKWgmm7ym
    N2ZaTFzPy4JKby6jkjg9S1XjwbxdToO/GANDuV2z6KCDq2De5oJAgSC83nQ3xY+T78TA7Q
    hJdkQHaht+xAzKVkzoiC6y2OZ0JKyqEHq6uBWIKe7wAViEPip3UJ6AELJ5Wc8yO3cB/hml
    5Yn0mDJEYYjhvcZM6qxXkCfnYOK3NyW3sHKdEzTU+jVaDB6T4AuSwnL9tpWBkqTl87Gi4l
    8ZlwpGwz0CZcFI/a9uqBNKj0fHONB5xJe9RxjfmyiTvEPvjRZDq3KhXsVX9A
X-ME-Proxy: <xmx:k9OnahBrDsaxL963XQga0pd_HufUJ3UEG3E1KeV3GYJFzKnWO0K0AQ>
    <xmx:k9Onat8SpXgt7AK8tbhOtlPySC-SAZ8H7kq1LJu9o8BK7nhUb35hFg>
    <xmx:k9OnavMSoaSp_NcmONiBIEEodxgVb_NxKWozUyJntVafvVjYQx41BQ>
    <xmx:k9OnanF5FAyueRGy-U3vIDp4RVRlfFaFAvXnoU64J2N6MnXFO9R5Uw>
    <xmx:k9OnausicBquc8Ki5-pPkwUILlALjYlm6cuBbPexMfzrXZah4wJ2-hhJ>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 06:59:30 -0400 (EDT)
Date: Mon, 14 Sep 2026 11:59:29 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, liam@infradead.org, nico.pache@linux.dev, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, usama.arif@linux.dev, ljs@kernel.org, 
	surenb@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/huge_memory: fix pgtable withdrawal for huge zero
 PMDs
Message-ID: <aqfRCPheDYTgTdAk@thinkstation>
References: <20260912234635.db50397364858aa15f58f4d7@linux-foundation.org>
 <20260913072312.52111-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913072312.52111-1-lance.yang@linux.dev>

On Sun, Sep 13, 2026 at 03:23:12PM +0800, Lance Yang wrote:
> 
> On Sat, Sep 12, 2026 at 11:46:35PM -0700, Andrew Morton wrote:
> >On Sun, 13 Sep 2026 13:19:42 +0800 Lance Yang <lance.yang@linux.dev> wrote:
> >
> >> From: Lance Yang <lance.yang@linux.dev>
> >> 
> >> has_deposited_pgtable() uses !vma_is_dax() to decide whether a huge zero
> >> PMD has a deposited PTE page table. That also accepts raw PFN mappings
> >> of huge_zero_pfn, although vmf_insert_pfn_pmd() does not deposit a page
> >> table on x86.
> >> 
> >> Zapping such a mapping would call pgtable_trans_huge_withdraw() without
> >> a corresponding deposit. With pmd_huge_pte(mm, pmd) == NULL, that causes
> >> a NULL pointer dereference.
> >
> >That's the sort of thing we'd prefer to avoid.
> >
> >> Use vma_is_anonymous() for the huge zero PMD check. This matches how PTE
> >> page tables are allocated, deposited and moved.
> >> 
> >> - For anonymous page faults that install a huge zero PMD,
> >>   do_huge_pmd_anonymous_page() allocates a PTE page table and
> >>   set_huge_zero_folio() deposits it before installing the PMD.
> >> 
> >> - On fork, copy_huge_pmd() allocates and deposits a PTE page table when
> >>   copying a huge zero PMD into an anonymous VMA.
> >> 
> >> - Raw PFN mappings use vmf_insert_pfn_pmd(), and DAX file holes use
> >>   vmf_insert_folio_pmd() to map the huge zero folio. Both use insert_pmd(),
> >>   which deposits a PTE page table only when arch_needs_pgtable_deposit()
> >>   requires it.
> >> 
> >> - Moving an anonymous huge PMD preserves its deposited PTE page table.
> >>   move_huge_pmd() transfers the deposit when necessary. For UFFD MOVE,
> >>   both VMAs must be anonymous, and move_pages_huge_pmd() transfers the
> >>   deposit as well.
> >> 
> >> Keep arch_needs_pgtable_deposit() first so architectures that require a
> >> deposited PTE page table still return true regardless of the VMA type.
> >> 
> >> Commit d80a9cb1a64a ("mm/huge_memory: add and use
> >> normal_or_softleaf_folio_pmd()") removed the vma_is_special_huge() check
> >> in zap_huge_pmd(). That check skipped the huge zero PMD deposit test for
> >> non-DAX VM_PFNMAP and VM_MIXEDMAP mappings. Removing it exposed these
> >> mappings to the incorrect !vma_is_dax() test.
> >> 
> >> Fixes: d80a9cb1a64a ("mm/huge_memory: add and use normal_or_softleaf_folio_pmd()")
> >> Cc: stable@vger.kernel.org
> >
> >How real is this?  Is there a reported-by:?  Do you have a reproducer? 
> 
> Yes, I reproduced it on x86 with a small test module. It sets
> VM_MIXEDMAP | VM_HUGEPAGE and calls vmf_insert_pfn_pmd() with
> huge_zero_pfn, without touching the page tables directly. A full-PMD
> munmap() crashes before the split series[1] as well.

Ah. So there's no real bug upstream, right?

And I am not sure it is how we want to address this. I don't think we
should allow randomly map huge zero page (and non-huge too). It can be a
security risk if it ever gets exposed writable.

See CVE-2015-3288 and 6b7339f4c31a ("mm: avoid setting up anonymous
pages into file mapping").

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
