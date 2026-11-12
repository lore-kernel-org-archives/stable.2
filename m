Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506732;
	b=s7UML3Hhp5BWnoOtXRfm/Rylm8m0G1yNIYy8tscZ7cHVrl9LEhjEH/W3UwByfxaGJlDz
	 7O2y6MVBNOv48zi7PBU1ZS1td6U99FEGMYdNk852j/+ieRQ4rF3x85nBPjDiVuW6yEmGG
	 Hu8BVp5M+pDgGtnNAlYg5OvjcXR8D4savHwpIaW7tX9+ezESM3DPZCiEsLIg1X/h1Bjz3
	 3WMk7WJeesmpTbyqk/wK4g1Yv+haoADBmMiZW9IgJLcI9L+nVBQl3bAAFtA2wDIHzISym
	 PqYMySHUQuf6+pVuZW6e+UmhhpjuSblRhOk76qaJt6s0gayNiJ+GgZUqOqYzFKbzDMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506732;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cG8SYyf7w3dlGbNaL5P0O22CIF0Qp5uX3wBmRgVBppY=;
	b=eomSZpo+dFax9UUnfbEV9Ujl3Pm5zCF2w8XHduFBqVSA/bS4Ob1hb7aymhufl32bMM+E
	 bhpuxWCuE4rlEGzc0MQo2qRb9UtXdI++K7Hg+sPaOFNgHx/ewWfT+unHUPdqpDC5I48Ns
	 Ce19CgduzU21ZlB1xxBO3n1311TUIKh/3EHcmSj52iKaZnhRnwapF/97YnIihQ9oPIRDm
	 RxDfOam5WqDTRvWkUm5jpwZ+BviD8EGy1xASHKyzI9ME1b9JKUbb1PvDlkOlKH4tk7BoN
	 Wzp9X19mqr7Jq/iJWBe928bAYx3eFfJVJ96kt+oqbLIbH8SaLn9LPrEemL2F18QkoGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=an6rnEFH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB13606A886;
	Thu, 12 Nov 2026 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=an6rnEFH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229B61F000C4;
	Thu, 12 Nov 2026 18:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794506732;
	bh=cG8SYyf7w3dlGbNaL5P0O22CIF0Qp5uX3wBmRgVBppY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=an6rnEFHIEQfMD7hb2IewvTV/EyagK+WFjhHhGs/7elOcrogcIsxGsV7IEc9I16wr
	 cANtce9G2vgpUy5lhY17FNcwQneKEIcYIY+W5IJ0slGgd16Qk/Qh3Wvfb0zV4chVhc
	 IWjf74UV4A1kTN4ldOCaeItZJzfYiJbdziIksaMS+AIHq/71swxVE3OezZ1iatBt1x
	 mY6EFh67QqtG015uZu6gP3MiS82xe2OjWemIl7CKMV8h3i1bYCNpH9tYb/TROWIPLE
	 piSdwUrsYtmEhsz/5LVnzo3yxJqT7rc1ZXvFCJsvQ/MIJ7Bb3Se55tS3K7ruw2DYyY
	 auQZ8KPUL8o4Q==
Date: Thu, 12 Nov 2026 18:05:20 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Andrei Vagin <avagin@gmail.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, 
	Muhammad Usama Anjum <usama.anjum@arm.com>, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Chris Down <chris@chrisdown.name>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 01/12] userfaultfd: use anonymous memory for
 UFFDIO_ZEROPAGE on private file mappings
Message-ID: <avX_qlthMqypxHm0@gremlin>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-1-00713d368976@columbia.edu>
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
In-Reply-To: <20261111-uffd-state-fixes-v1-1-00713d368976@columbia.edu>

On Wed, Nov 11, 2026 at 12:55:09PM -0500, Tal Zussman wrote:
> If the mm cannot map the shared zero page, UFFDIO_ZEROPAGE falls back to
> mfill_atomic_pte_zeroed_folio(), which allocates a zeroed folio and
> installs it through vma_uffd_ops(), no matter what kind of mapping it
> is. An s390 KVM guest with storage keys or protected virtualization is
> such an mm.
>
> For a MAP_PRIVATE shmem mapping, that adds the zeroed folio to the page
> cache of the file. That is wrong: a private mapping must never modify
> the file it maps, and the file might even be mapped from a read-only fd.
>
> The ioctl can also fail where it should succeed. A missing fault is only
> delivered for a hole in the file, but UFFDIO_ZEROPAGE can be called on
> an address that did not fault, or can race with a write to the file. If
> the file has a page at that offset by then, inserting the zeroed folio
> fails and the ioctl returns -EEXIST although nothing is mapped at the
> destination address.
>
> What we want is what UFFDIO_ZEROPAGE does on a private mapping when the
> shared zero page can be used, and what UFFDIO_COPY does: only check that
> nothing is mapped at the destination address, map zeroed memory there,
> and leave the page cache alone. The zeroed folio path did that before it
> was moved to vm_uffd_ops.
>
> To fix it, pick the ops in the common folio path, as
> mfill_atomic_pte_copy() did for UFFDIO_COPY: anon_uffd_ops for a private
> mapping, the ops of the VMA otherwise. That makes
> mfill_atomic_pte_copy() and mfill_atomic_pte_zeroed_folio() redundant,
> so remove them and rename __mfill_atomic_pte() to
> mfill_atomic_pte_folio().
>
> UFFDIO_ZEROPAGE no longer modifies the file, and only fails with -EEXIST
> if something is already mapped at the destination address.
>
> Fixes: f74991b4e383 ("shmem, userfaultfd: implement shmem uffd operations using vm_uffd_ops")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Looks sensible (also another cleanup in disguise which I like ;):

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/userfaultfd.c | 46 ++++++++++++++++------------------------------
>  1 file changed, 16 insertions(+), 30 deletions(-)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index d65184d9a480..61a712e1f9f5 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -531,15 +531,27 @@ static int mfill_copy_folio_retry(struct mfill_state *mfill_state,
>  	return 0;
>  }
>
> -static int __mfill_atomic_pte(struct mfill_state *state,
> -			      const struct vm_uffd_ops *ops)
> +static int mfill_atomic_pte_folio(struct mfill_state *state)
>  {
> +	const struct vm_uffd_ops *ops = vma_uffd_ops(state->vma);
>  	unsigned long dst_addr = state->dst_addr;
>  	unsigned long src_addr = state->src_addr;
>  	uffd_flags_t flags = state->flags;
>  	struct folio *folio;
>  	int ret;
>
> +	/*
> +	 * The normal page fault path for a MAP_PRIVATE mapping in a
> +	 * file-backed VMA will invoke the fault, fill the hole in the file and
> +	 * COW it right away. The result generates plain anonymous memory.
> +	 * So when we are asked to fill a hole in a MAP_PRIVATE mapping, we'll
> +	 * generate anonymous memory directly without actually filling the
> +	 * hole. For the MAP_PRIVATE case the robustness check only happens in
> +	 * the pagetable (to verify it's still none) and not in the page cache.
> +	 */
> +	if (!(state->vma->vm_flags & VM_SHARED))
> +		ops = &anon_uffd_ops;
> +
>  	if (!ops) {
>  		VM_WARN_ONCE(1, "UFFDIO_COPY for unsupported VMA");
>  		return -EOPNOTSUPP;
> @@ -597,32 +609,6 @@ static int __mfill_atomic_pte(struct mfill_state *state,
>  	return ret;
>  }
>
> -static int mfill_atomic_pte_copy(struct mfill_state *state)
> -{
> -	const struct vm_uffd_ops *ops = vma_uffd_ops(state->vma);
> -
> -	/*
> -	 * The normal page fault path for a MAP_PRIVATE mapping in a
> -	 * file-backed VMA will invoke the fault, fill the hole in the file and
> -	 * COW it right away. The result generates plain anonymous memory.
> -	 * So when we are asked to fill a hole in a MAP_PRIVATE mapping, we'll
> -	 * generate anonymous memory directly without actually filling the
> -	 * hole. For the MAP_PRIVATE case the robustness check only happens in
> -	 * the pagetable (to verify it's still none) and not in the page cache.
> -	 */
> -	if (!(state->vma->vm_flags & VM_SHARED))
> -		ops = &anon_uffd_ops;
> -
> -	return __mfill_atomic_pte(state, ops);
> -}
> -
> -static int mfill_atomic_pte_zeroed_folio(struct mfill_state *state)
> -{
> -	const struct vm_uffd_ops *ops = vma_uffd_ops(state->vma);
> -
> -	return __mfill_atomic_pte(state, ops);
> -}
> -
>  static int mfill_atomic_pte_zeropage(struct mfill_state *state)
>  {
>  	struct vm_area_struct *dst_vma = state->vma;
> @@ -634,7 +620,7 @@ static int mfill_atomic_pte_zeropage(struct mfill_state *state)
>
>  	if (mm_forbids_zeropage(dst_vma->vm_mm) ||
>  	    (dst_vma->vm_flags & VM_SHARED))
> -		return mfill_atomic_pte_zeroed_folio(state);
> +		return mfill_atomic_pte_folio(state);
>
>  	_dst_pte = pte_mkspecial(pfn_pte(zero_pfn(dst_addr),
>  					 dst_vma->vm_page_prot));
> @@ -927,7 +913,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mfill_state *state)
>  	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON))
>  		return mfill_atomic_pte_poison(state);
>  	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_COPY))
> -		return mfill_atomic_pte_copy(state);
> +		return mfill_atomic_pte_folio(state);
>  	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE))
>  		return mfill_atomic_pte_zeropage(state);
>
>
> --
> 2.39.5
>

--
Cheers, Lorenzo
