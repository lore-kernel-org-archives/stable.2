Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD543DE45C;
	Fri, 17 Jul 2026 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784288461; cv=none; b=KuSY9X4GdSiUP+3zbX+aIjHTr8DtxDAQSujzzR/6oyEr9r5YRQpk5sq3VsaHAsp2i16Epq1oF4Cuxdi1oCsRAbE26tb59w9erQpF9zI8NZoHMb8OWSEimbmYH4vhy1TPn+ECSglfDhvIO7ikwDSf3UhtSd5IQMqbKXnkflKvKas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784288461; c=relaxed/simple;
	bh=Dq3NfMG9vTxz8615uFZN59ykS5dijz8IdMkpDWyk7T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udfB88qCCNl4CTGBHNBOn0fkVH73EH46yhuP/0Eoo04BuFqEqKE4roSn8iIkWpFL5RS+2p9TWd2zB8dnrHIs1tloBfaIzk3wKjKCy2V45jhdsfGocZcnc4Xzcvc1RRNimNuZn6Y8d2b13xB4uZXo3hJH5LK9c0dN+2GiZMF6OvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+ylRJNl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+ylRJNl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5B41F000E9;
	Fri, 17 Jul 2026 11:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784288458;
	bh=wMxcpm+IoVsxd9X54J6KG7SdZat99QLXoKqL6gFffBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F+ylRJNlTcwJhGBJ01DIn7oLm7TXQAXu2+mO4HsHi6022TFDme52Ltzf3ykFIWRiX
	 sDUdKjTGWVvaP9TatyQ/XjfOHTVub9UT1FV65inDcTpw4W8oOP9O6WVi9El6ZeqsqJ
	 m46cQ0zYPorXuwz6Y8HY8rwe2DW1IF0j5tCHwJX9N192yjBgysenD381xVaGlm/Fvk
	 Cvsz+r+CrYck/qWkFmT6wVGOyFCWQqzs3VrwfmwtwPew8yesYwgkFpSzcvp0B+O/Fz
	 6Ct97dz1xPU8clKQl2wZ+nr4fCUbBsTibi8odepAZRFcXrNNRwCVOw1m3xVZHW8xNn
	 UNs+8qr93MSiw==
Date: Fri, 17 Jul 2026 12:40:38 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>
Cc: David Carlier <devnexen@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"Denis V. Lunev" <den@virtuozzo.com>, stable@vger.kernel.org
Subject: Re: [PATCH mm-hotfixes v4 2/4] x86/mm/pat: acquire init_mm write
 lock to avoid UAF
Message-ID: <aloAVwijpWpfO-5n@lucifer>
References: <20260716-series-vmap-race-fix-v4-0-8c108c4317df@kernel.org>
 <20260716-series-vmap-race-fix-v4-2-8c108c4317df@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-series-vmap-race-fix-v4-2-8c108c4317df@kernel.org>

On Thu, Jul 16, 2026 at 10:31:13PM +0100, Lorenzo Stoakes (ARM) wrote:

OK so note to self - don't send series late in the evening when you're
exhausted :)

I rather glossed over the problem, Will's reply, and Denis's excellent bug
report at [0].

So. The (other) problem with CPA, as Denis pointed out, is that
__change_page_attr() can update something in a page table that is
concurrently being torn down, with set_pte_atomic() being the point at
which the UAF occurs.

With the switch to a write lock we can simply do:

	scoped_guard(mmap_read_lock, &init_mm)
		ret = __change_page_attr_set_clr(&cpa, 1);

In change_page_attr_set_clr().

Since CPA_COLLAPSE is only ever invoked via set_memory_rox() collapse is
only done via change_page_attr_set_clr() and this covers all callers which
are impacted by this.

If people are agreeable to this I will respin with an additional patch to
do this, as it makes sense to bundle it in this series with its depend
change (this patch) included and properly ordered.

Cheers, Lorenzo


[0]:https://lore.kernel.org/all/20260626163213.2284080-1-den@openvz.org/

> x86 implements page attribute modification using its Change Page
> Attributes (CPA) mechanism.
>
> This tracks properties of ranges such as cache mode through x86 page
> attributes, and as part of that logic manipulates kernel page tables.
>
> Since commit 41d88484c71c ("x86/mm/pat: restore large ROX pages after
> fragmentation") ranges of kernel page table entries can be collapsed into
> huge page table entries as part of this logic.
>
> As part of this collapse, it frees the page tables which the collapsed
> entries previously pointed to, and it does so without any relevant locks
> being held to preclude concurrent kernel page table walkers.
>
> The only way this code can be reached is if CPA_COLLAPSE is specified, and
> this is only set in set_memory_rox() via:
>
> set_memory_rox()
> -> change_page_attr_set_clr()
> -> cpa_flush()
> -> cpa_collapse_large_pages()
>
> Notable users of this are execmem and bpf when manipulating executable
> mappings.
>
> However, this is problematic for ptdump as it walks ranges it does not own
> and thus runs the risk of a use-after-free on page tables freed underneath
> it.
>
> In addition, concurrent CPA collapse operations are possible which can also
> cause races.
>
> Resolve the issue by acquiring the mmap write lock on init_mm across the
> whole operation.
>
> It is safe to acquire a sleeping lock as all the callers invoke
> set_memory_rox() from process context and in any case,
> change_page_attr_set_clr() calls vm_unmap_alias() which ultimately takes a
> mutex, disallowing atomic context here.
>
> Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
> Cc: stable@vger.kernel.org
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  arch/x86/mm/pat/set_memory.c | 15 ++++++++++++++-
>  include/linux/mmap_lock.h    |  2 ++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index d023a40a1e03..d1e63f7d267f 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -22,6 +22,7 @@
>  #include <linux/cc_platform.h>
>  #include <linux/set_memory.h>
>  #include <linux/memregion.h>
> +#include <linux/cleanup.h>
>
>  #include <asm/e820/api.h>
>  #include <asm/processor.h>
> @@ -410,7 +411,7 @@ static void __cpa_flush_tlb(void *data)
>
>  static int collapse_large_pages(unsigned long addr, struct list_head *pgtables);
>
> -static void cpa_collapse_large_pages(struct cpa_data *cpa)
> +static void __cpa_collapse_large_pages(struct cpa_data *cpa)
>  {
>  	unsigned long start, addr, end;
>  	struct ptdesc *ptdesc, *tmp;
> @@ -442,6 +443,18 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
>  	}
>  }
>
> +static void cpa_collapse_large_pages(struct cpa_data *cpa)
> +{
> +	/*
> +	 * Take the mmap write lock on init_mm to:
> +	 * - Avoid a use-after-free if raced by ptdump (which takes its own
> +	 *   write lock on init_mm).
> +	 * - Serialise concurrent CPA walkers.
> +	 */
> +	scoped_guard(mmap_write_lock, &init_mm)
> +		__cpa_collapse_large_pages(cpa);
> +}
> +
>  static void cpa_flush(struct cpa_data *cpa, int cache)
>  {
>  	unsigned int i;
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 6b5c2390cc30..047f5f5e2c34 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -621,6 +621,8 @@ static inline void mmap_read_unlock(struct mm_struct *mm)
>
>  DEFINE_GUARD(mmap_read_lock, struct mm_struct *,
>  	     mmap_read_lock(_T), mmap_read_unlock(_T))
> +DEFINE_GUARD(mmap_write_lock, struct mm_struct *,
> +	     mmap_write_lock(_T), mmap_write_unlock(_T))
>  DEFINE_GUARD_COND(mmap_read_lock, _try, mmap_read_trylock(_T))
>
>  static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
>
> --
> 2.55.0
>
