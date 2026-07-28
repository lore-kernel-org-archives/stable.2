Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BB83B27CE;
	Tue, 28 Jul 2026 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244412; cv=none; b=es3HD3ncy7PsLIJdVQII12Ma8dpn22p4x3orlhylTLtvzdaZV6RkkoU+0WE5PRRpaqLWGyYd7GpqZY006e6xmELT1iHy/zB2f3DlLDpaBtDGM3ub3EKcDLGkUdZqLvSQ4UW2MNqTNfrX6tIMb8nSPf4PWTdHJHF34cJOtHwxeZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244412; c=relaxed/simple;
	bh=43nlqQGyNvV6RU4olGdIrOmB9dFfNMqmbMt7I2qicBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbXsKZuo0IHL9f1Wy2t9cEj/2cyZizeTeyO7LtsdiLBSSTeEvDlhFqi54Nwp1H4XHkxqmBaWBme0cGpRfqRBtSR5H6hpZ3whGi02lPKrVtrK3H01NIsjOjCfSLk/8teWH0aPp6l1tbS7twZv0WrlyHbsVPJjxyp48SqgqF3gOwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzn/3sd1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzn/3sd1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21791F000E9;
	Tue, 28 Jul 2026 13:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785244411;
	bh=edsvZpHOz/mK9RXEfjieBaI2uRHLdU4GTctLQewLIA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bzn/3sd1lQMhcvwoLaRajVWT5kPg6XFlWUd0RKfagTCKUxU+Mnc+Tafa40Ay1tvkZ
	 XKuTj68ArvEOTpX/Vd7ynVk5yaPX6pD+5MCnezKnwqeRfwNfXC2X61nt+eaQ+sP9W5
	 B9TwAcvJoV6wF3Vg3Z2xb2STDWWj5i2N6U4x1Q1sNJX7Y69VD1PPcvz6lFoNAwRlxa
	 xkPAPucRm0P7rf1Zy2hbwlYE6MT0zfNY3zXoRze6NujmbqD5j+IZu2oN+AiaLqWqpD
	 MFetWF9YTEPwGa8lNj/rH+CRpMqS3DplerNhPLwbH8osryXKvsvwzrZyMRf/t39f/g
	 C2EZfMIgX5GzA==
Date: Tue, 28 Jul 2026 14:13:10 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, David CARLIER <devnexen@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Juergen Gross <jgross@suse.com>, Kevin Tian <kevin.tian@intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Toshi Kani <toshi.kani@hpe.com>, Vishal Moola <vishal.moola@gmail.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 1/5] x86/mm/pat: introcude cpa_lock() and cpa_unlock()
Message-ID: <amiqlL6yD5Elil-_@lucifer>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
 <20260728-cpa-fixes-v1-1-2ed2352300b3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728-cpa-fixes-v1-1-2ed2352300b3@kernel.org>

Typo in subject :) introcude -> introduce

Hopefully Dave can fix up easily.

On Tue, Jul 28, 2026 at 04:07:44PM +0300, Mike Rapoport (Microsoft) wrote:
> The splitting and merging of kernel page table mappings between small and
> large is protected by cpa_lock.
>
> Commit 5fce67641a3e ("x86/mm/pat: Don't gate cpa_lock on
> debug_pagealloc_enabled()") disabled gatig of cpa_lock on
> debug_pagealloc_enabled() to simplify the code presuming that skipping
> the lock when debug_pagealloc_enabled() was an optimization.
>
> However Lorenzo Stoakes notes that:
>
>   __kernel_map_pages() can be called from irq context:
>
>   < GFP_ATOMIC context >
>   kfree() or whatever
>   -> ...
>   -> __free_pages_prepare()
>   -> debug_pagealloc_unmap_pages()
>   -> __kernel_map_pages()
>   -> __change_page_attr_set_clr()
>   -> cpa_lock spins [irqs off]
>
>   So you're spin locking in irq context here, which is probably not a
>   good idea.
>
> It would be possible to unconditionally use spin_lock_irqsave() and
> spin_unlock_irqrestore() but that would complicate locking rules even
> more.
>
> Restore gating of cpa_lock of debug_pagealloc_enabled(), but instead of
> putting the open-coded condition
>
> 	if (debug_pagealloc_enabled())
>
> before every lock and unlock operation, wrap the condition and the
> locking operation into cpa_lock() and cpa_unlock() helpers.

Yeah seems sensible.

>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

LGTM, so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  arch/x86/mm/pat/set_memory.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index b1e780a465b5..4c8922695fd3 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -65,8 +65,25 @@ static const int cpa_warn_level = CPA_PROTECT;
>   * Serialize cpa() using cpa_lock so that we don't allow any other cpu, with
>   * stale large tlb entries, to change the page attribute in parallel to some
>   * other cpu splitting a large page entry along with changing the attribute.
> + *
> + * When debug_pagealloc_enabled(), page attributes could be changed in atomic
> + * context that would warrant disabling IRQs. But since debug_pagealloc always
> + * uses 4k pages in the direct map there are no races for splits and collapses
> + * and locking can be just skipped altogether.
>   */
> -static DEFINE_SPINLOCK(cpa_lock);
> +static DEFINE_SPINLOCK(_cpa_lock);
> +
> +static inline void cpa_lock(void)
> +{
> +	if (!debug_pagealloc_enabled())
> +		spin_lock(&_cpa_lock);
> +}
> +
> +static inline void cpa_unlock(void)
> +{
> +	if (!debug_pagealloc_enabled())
> +		spin_unlock(&_cpa_lock);
> +}
>
>  #define CPA_FLUSHTLB 1
>  #define CPA_ARRAY 2
> @@ -417,7 +434,7 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
>  	int collapsed = 0;
>  	int i;
>
> -	spin_lock(&cpa_lock);
> +	cpa_lock();
>
>  	if (cpa->flags & (CPA_PAGES_ARRAY | CPA_ARRAY)) {
>  		for (i = 0; i < cpa->numpages; i++)
> @@ -433,7 +450,7 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
>  	}
>
>  	if (!collapsed) {
> -		spin_unlock(&cpa_lock);
> +		cpa_unlock();
>  		return;
>  	}
>
> @@ -444,7 +461,7 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
>  		pagetable_free(ptdesc);
>  	}
>
> -	spin_unlock(&cpa_lock);
> +	cpa_unlock();
>  }
>
>  static void cpa_flush(struct cpa_data *cpa, int cache)
> @@ -1239,9 +1256,9 @@ static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
>  {
>  	struct ptdesc *ptdesc;
>
> -	spin_unlock(&cpa_lock);
> +	cpa_unlock();
>  	ptdesc = pagetable_alloc(GFP_KERNEL, 0);
> -	spin_lock(&cpa_lock);
> +	cpa_lock();
>  	if (!ptdesc)
>  		return -ENOMEM;
>
> @@ -2025,9 +2042,9 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary)
>  		if (cpa->flags & (CPA_ARRAY | CPA_PAGES_ARRAY))
>  			cpa->numpages = 1;
>
> -		spin_lock(&cpa_lock);
> +		cpa_lock();
>  		ret = __change_page_attr(cpa, primary);
> -		spin_unlock(&cpa_lock);
> +		cpa_unlock();
>  		if (ret)
>  			goto out;
>
>
> --
> 2.53.0
>

Cheers, Lorenzo
