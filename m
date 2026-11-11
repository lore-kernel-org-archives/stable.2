Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417696;
	b=gqDi4AW0Kn+B2Nb+o3YIm8eMiWeWdLKY7Cv0M5P/Rida9cEzi5FEGACDVbJBsnzWBHU1
	 OWXhEEi2C6h2jydQ/UNSLZ8Sm5KOLLGrq48U+YOuJcru7XVUuirjZYw1bkc2dtjLIj0oV
	 uMRz98WzPqpKtsrpMKKthl8E37KhnZpbMMmRjFf6K9oJ7vHVaboJkbfQznhRGM9en69PZ
	 AOOgaXRaBZQViBXmPfWMIgPtGHPhR7LAze/5sNdaj2nmaPTX10JW3TvPj+DcixEHyM1lm
	 xsO8Ip/eYkbOuG9sEx1rw7OOUDQzZKh1M3j+0VCRKhIfQA8350fADiA+sFR0kKG3pRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417696;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=mgdmcspbD1Yyk+0ecRe5xCyE0njK/qpMy7OsZTOU9pA=;
	b=FiMhDqjg9BY8s50dkHDsX+Cq/d6/ahbBd/SKxztuxi646OFpzO+O3XOsytQdOc+5PXYX
	 P7sLYDzu6LBvWC9wthSePQ9s5uVzUZFiRnqRJo306UvU1axal22ugKKWUczFDrOlketaN
	 mLqLK55S8D0NL5R13QTO5gDXfD3QrV7vArPpuUCzwrK8VkneSmMYG5mT3vAmixtvjuiOB
	 VMrNWVScOx/7WROmo9n7YVtYBUeLDtIDxKKWcFTgk1HDKsU+vctbaPyb6MzbVLJbwVt95
	 sfYB2EjhicFqd3wJ/Fq7HwVmlhqczDKc24xOgJ2ddoDgbWtUWNuqdT920i0DE/Btdhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qLwB8YuY;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C415606A32A;
	Wed, 11 Nov 2026 17:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C415606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qLwB8YuY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mgdmcspbD1Yyk+0ecRe5xCyE0njK/qpMy7OsZTOU9pA=; b=qLwB8YuYISU6n72YmjlDMvwfBh
	h/z/COi0TrAJz8Ram/slbP3UEwSHIcCZ8uXK1SR1hXnlQ6x5A9eyX2KBtH4XdJRJCVzXnuicCaDZT
	Lbwrc8CCcJNtU1OKoNR9KjLyvMrOWIoEguIcmwkA/kztGB+02Go8rO/5RypB0KH35550pYv9h+AOc
	HO5KaRA758zKA+w3CEWhLZSfxsIVzv9MMRumia6IGlyfFIwlEoxP7rKaMZmDozt5oBFV00MwjGR99
	txipC4M+XXzb5LfgID9YmDCPxfCRN8jMpXhNMdQqMJhvYa59+HJJqFSZPnGM7C9jVB2lIYSSynqx1
	pfpIyoig==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRC0p-00000007IAb-2pCY;
	Wed, 11 Nov 2026 17:21:31 +0000
Date: Wed, 11 Nov 2026 12:21:28 -0500
From: "Liam R. Howlett" <liam@infradead.org>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/mglru: fix a no-op lru_gen_clear_refs() call in
 lru_lazyfree()
Message-ID: <4xqyzrl4lbxwbky22lc5k5mcvusudg75z6hspjokfoghp3dny3@rjuukqzxiuyv>
References: <20261109021611.22247-1-hui.zhu@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109021611.22247-1-hui.zhu@linux.dev>

On 26/11/09 10:16AM, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> lru_lazyfree() calls lru_gen_clear_refs() after lruvec_del_folio(), but
> lru_gen_del_folio() has already cleared LRU_GEN_MASK, so folio_lru_gen()
> returns -1 and lru_gen_clear_refs() exits at its "gen < 0" check without
> clearing the refs or PG_workingset.
> 
> A MADV_FREE folio therefore keeps the state it had before madvise(2),
> even though madvise_free_pte_range() has already cleared the accessed and
> dirty bits of its PTEs.  lru_gen_folio_seq() places it one generation
> younger, and PG_workingset puts it in the last tier, so sort_folio()
> promotes and protects it instead of evicting it and charges it to
> lrugen->protected[], which read_ctrl_pos() uses to balance anon against
> file reclaim.  __folio_inc_gen() clears the refs but not PG_workingset,
> so this repeats every time the folio reaches the oldest generation.  If
> the folio is redirtied first, ttu_anon_lazyfree_folio() keeps it and
> lru_gen_eviction() packs the stale state into the shadow entry, so a
> later refault is promoted to the youngest generation.
> 
> Call lru_gen_clear_refs() while the folio is still on the generation
> list, as deactivate_file_folio() and folio_deactivate() already do.  Its
> return value only says whether the folio is in the oldest generation,
> which lru_lazyfree() does not need because it re-adds the folio below.
> Keep folio_clear_referenced() unconditional: the classic LRU needs it,
> and it also covers the folios that lru_gen_clear_refs() skips.
> 
> Fixes: cc8ec7be78ff ("mm/mglru: optimize deactivation")
> Cc: stable@vger.kernel.org
> Suggested-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> Reviewed-by: Barry Song <baohua@kernel.org>

One nit..

Reviewed-by: Liam R. Howlett (Google) <liam@infradead.org>

> ---
> Changelog:
> v3:
> Add Cc: stable@vger.kernel.org and pick up Barry's Reviewed-by.
> No code change compared to v2.
> Per the thread discussion, the __lru_gen_clear_refs() refactor will be
> sent as a separate cleanup after this fix lands.
> v2:
> Call lru_gen_clear_refs() before lruvec_del_folio() instead of
> open-coding the flag clears; drop the lru_gen_enabled() branch and
> the comment (Barry Song).
> 
>  mm/folio.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/folio.c b/mm/folio.c
> index 35e242b48870b..ea3adb6a89d75 100644
> --- a/mm/folio.c
> +++ b/mm/folio.c
> @@ -597,12 +597,10 @@ static void lru_lazyfree(struct lruvec *lruvec, struct folio *folio)
>  	    folio_test_swapcache(folio) || folio_test_unevictable(folio))
>  		return;
>  
> +	lru_gen_clear_refs(folio);

Since you're not checking the return here, you could use
folio_set_lru_refs(folio, 0);
folio_clear_workingset(folio);

>  	lruvec_del_folio(lruvec, folio);
>  	folio_clear_active(folio);
> -	if (lru_gen_enabled())
> -		lru_gen_clear_refs(folio);
> -	else
> -		folio_clear_referenced(folio);
> +	folio_clear_referenced(folio);
>  	/*
>  	 * Lazyfree folios are clean anonymous folios.  They have
>  	 * the swapbacked flag cleared, to distinguish them from normal
> -- 
> 2.43.0
> 
