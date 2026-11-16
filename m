Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842229;
	b=Z24rVAYHHNp365lTE5jJRHWm5qzZIGaskurkCoaxqLGa4yzwRZIk0L45h0NKFg90k1wP
	 aV7r7sD/7gOKBT58K2/as2kWdJFJX83TNFj4MMnB2cvloaG+BpcWocOboenqRUTpwN49m
	 lHc+JWaHVhNluktf+6bvkHYm89ZZ/lmc7ypbsCd8xM8SnWNaG1XK1dJfHTeAoLHY5SiV/
	 Pk44ZGen0Ow4ykDlrH6as3C571Q1O8IVgL9SiJ3lItGhdz7b4cgBkAAidikaBr3ewai2y
	 HRV004b9IKV+t1VEEy6JaIS+VEVbSzozT/xCeS9FqtYxOGn3JJ0kiDAFAb/QH5xbN+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842229;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ujqrk5GfnvZSQ47QPVWShAtgKW4tgnFTvG/p2sZDfiU=;
	b=m8RBH5TWzfZ7wKYr/a39kynHWmSkW3u5QRAXghMfUg2dPoOjb9kOn1l9R/1iJOgTFS4P
	 UzgznKk66agIf/W5sMmfQDKlFsZnZ93LEC6RkOALxUGtrMIC8JBTe0EtnunJukT7i+vyC
	 pBAtbmH7JJTt8cFyTTszjKKxJNWoeCxGrgjBDmTRRKmaSr9+Ibbo8h+jN9jpWYyPdBeeh
	 T4uOxf4/wWKZ3e2PR3JP8buIG57HihbGG+qVhgRpT69JJf/kCHFBW7fDqHdGNzmV7SUk8
	 FgZU82YsdJcx3X2oBtBCc2CR5dsid+DfjuGOX9Mh6IeEtJrShqTxEr2n2JxGve9GOIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c9gb14EP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8283C606A332;
	Mon, 16 Nov 2026 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c9gb14EP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696291F000C6;
	Mon, 16 Nov 2026 15:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794842229;
	bh=Ujqrk5GfnvZSQ47QPVWShAtgKW4tgnFTvG/p2sZDfiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c9gb14EPpkm2f4Xkve+woq2EcaqVAU6OWFg/jQQkk+LdeQMeL7wWdgnWrcehtDozj
	 hlOPWzyc3otoJDc1BnWmnfcGkELE5ne9YdbXb8bOeqQgo2ANcdeP4VSohetQKo+bu6
	 l5ph1oMq/97A/jF+1i6vYBlBI3MVXXqtcaOkV92iTMzuCIqe5tQ2pEfSD6ogMQ3HJh
	 bic2UvECRtuYisN6i/RkebN7RRB6ItCm2WazrTPfpAne4MbT05QwixHEpiEAMU0J5O
	 v3BC1siAMDf+wN5WhgY81rIR/ucUfVkxsvzUBcp2oLIQ5es2Gj6dI711oOZg0IHil4
	 KlLYgJkBMlr0w==
Date: Mon, 16 Nov 2026 15:16:59 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, Johannes Weiner <hannes@cmpxchg.org>, 
	Hugh Dickins <hughd@google.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>, 
	Ross Zwisler <zwisler@kernel.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/mmu_gather: delay rmap removal on UP as well
Message-ID: <avseFdmK8zN8JTNe@gremlin>
References: <20261116-dirty_file_pmd-v2-0-571883053174@kernel.org>
 <20261116-dirty_file_pmd-v2-1-571883053174@kernel.org>
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
In-Reply-To: <20261116-dirty_file_pmd-v2-1-571883053174@kernel.org>

On Mon, Nov 16, 2026 at 04:06:58PM +0100, David Hildenbrand (Arm) wrote:
> Commit 5df397dec7c4 ("mm: delay page_remove_rmap() until after the TLB
> has been flushed") introduced delayed rmap removal of dirty pages until
> after the TLB flush, so writeback cannot clean a page that is still
> writable through a stale TLB entry.
>
> It skips this on UP, because on UP there are no remote TLBs (single CPU)
> and because the PTL prevents preemption.
>
> The PTL prevents preemption while removing the rmap, but the local TLB
> flush is usually only performed after dropping the PTL.
>
> Consequently, after dropping the PTL we could reschedule to another
> thread of the same mm, which does not flush the TLB. A kworker could
> then run into the original race with writeback: it cleans the folio,
> but the other thread can still modify it through the stale TLB entries,
> and these writes get lost.
>
> Fix it by simply not special-casing UP. Now, only architectures that
> select MMU_GATHER_NO_GATHER (s390) will skip delay_rmap handling.
>
> Fixes: 5df397dec7c4 ("mm: delay page_remove_rmap() until after the TLB has been flushed")
> Cc: stable@vger.kernel.org
> Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Link: https://lore.kernel.org/r/avrxOt_GyXLXNqtR@gremlin

Nitty, but I think better as Closes? :P

> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  include/asm-generic/tlb.h | 6 +-----
>  mm/mmu_gather.c           | 2 --
>  2 files changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 4bba02fd5d543..cb087315b4e72 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -249,23 +249,19 @@ extern bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, in
>  bool __tlb_remove_folio_pages(struct mmu_gather *tlb, struct page *page,
>  		unsigned int nr_pages, bool delay_rmap);
>
> -#ifdef CONFIG_SMP
>  /*
>   * This both sets 'delayed_rmap', and returns true. It would be an inline
>   * function, except we define it before the 'struct mmu_gather'.
>   */
>  #define tlb_delay_rmap(tlb) (((tlb)->delayed_rmap = 1), true)
>  extern void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma);
> -#endif
>
>  #endif
>
>  /*
>   * We have a no-op version of the rmap removal that doesn't
>   * delay anything. That is used on S390, which flushes remote
> - * TLBs synchronously, and on UP, which doesn't have any
> - * remote TLBs to flush and is not preemptible due to this
> - * all happening under the page table lock.
> + * TLBs synchronously.
>   */
>  #ifndef tlb_delay_rmap
>  #define tlb_delay_rmap(tlb) (false)
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index e98397ac577c4..c022aeb7c84d0 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -49,7 +49,6 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
>  	return true;
>  }
>
> -#ifdef CONFIG_SMP
>  static void tlb_flush_rmap_batch(struct mmu_gather_batch *batch, struct vm_area_struct *vma)
>  {
>  	struct encoded_page **pages = batch->encoded_pages;
> @@ -91,7 +90,6 @@ void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma)
>  		tlb_flush_rmap_batch(tlb->active, vma);
>  	tlb->delayed_rmap = 0;
>  }
> -#endif
>
>  /*
>   * We might end up freeing a lot of pages. Reschedule on a regular
>
> --
> 2.56.1
>

--
Cheers, Lorenzo
