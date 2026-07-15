Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE0B481AAE;
	Wed, 15 Jul 2026 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784129110; cv=none; b=i5NhLveVy71KSYi98NxjzjbhARQKNb8p5hjYrDH9yQdFvx8tU7GJ1GMOM7ENKIAEYH3wKeF8HI8itSY158pGivRWuAx1KY22/QIrFLx/e2aEYcaR8rFiyZlhtj5pHatMnQnj+QhC8+YpNx2LF+1/qcZf5ScfphUsugPDlNdnYqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784129110; c=relaxed/simple;
	bh=TFQwChPGGQpyD8Jb2d8bWS+39TTHhvMm1OUCTvvPIaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDXR0B2w095GrL66RAECTHMRP17V2KNDbbJaOFcu3JRJTB2nVRuJZ4eVLj0QDRiI5q0e2vmDjTSFShAE9+xsjvyHIiRBJbIV6FfM+38Bh+IPE/2eCL6gQah5ZengTXfHxo77RXAr36GU1Q+M5YKxB2hZ/+S9KLMOkuMFErBwKrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwMy915a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwMy915a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964801F00A3A;
	Wed, 15 Jul 2026 15:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784129108;
	bh=qCp0Z/LIk1edhZq1e91Hff3OKVN7JtELVDWP1PDw0J0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VwMy915aEQWDn/J7UuYWhhXw3fAuF/NfHhCeydmjSgm8zTWdGZ07KnFIzAFCGPioU
	 mNxRZH8SV2AisnBrgxf6GmCTn7fXNnVEc+e6DwDNpH8jpvm7hrvgYEc111EpGEewhI
	 6h1bpyF04jdaupPip8MRN51K+CRQ7yFfolxRDo1qEZeqCY/M/SWy/xLZkfS7kJ4Glg
	 ILmipLdPfluoX0rllpEQL22sWbqsl9tnp7m7OpLfDbSlevM6b2g8JeCQyXT/bMyIg7
	 OOiSSVscvB13OcUayLrJJSpfisWAiHKVMx1nO7Bc9tqbk0zTWgfwXUf+nUg98nEETe
	 O4cENe7Z0QUYQ==
Date: Wed, 15 Jul 2026 16:24:59 +0100
From: Will Deacon <will@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Toshi Kani <toshi.kani@hpe.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dev Jain <dev.jain@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
	David Carlier <devnexen@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	abarnas@google.com
Subject: Re: [PATCH mm-hotfixes v3 2/4] x86/mm/pat: acquire mmap lock on page
 table free to avoid ptdump UAF
Message-ID: <alemS7vxeRB7NcBO@willie-the-truck>
References: <20260714-series-vmap-race-fix-v3-0-b812eccfa0f9@kernel.org>
 <20260714-series-vmap-race-fix-v3-2-b812eccfa0f9@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-series-vmap-race-fix-v3-2-b812eccfa0f9@kernel.org>

Hi Lorenzo,

I'm certainly no x86 expert (quite the opposite!), but I was looking at
this with Adrian and got myself confused. See below.

On Tue, Jul 14, 2026 at 06:24:24PM +0100, Lorenzo Stoakes wrote:
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
> Resolve the issue by acquiring the mmap read lock on init_mm which prevents
> a concurrent ptdump as it acquires the write lock.
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
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> ---
>  arch/x86/mm/pat/set_memory.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index d023a40a1e03..4c4b8244502f 100644
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
> @@ -436,9 +437,16 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
>  
>  	flush_tlb_all();
>  
> -	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
> -		list_del(&ptdesc->pt_list);
> -		pagetable_free(ptdesc);
> +	/*
> +	 * ptdump might read these page tables, so avoid a use-after-free by
> +	 * acquiring the mmap read lock on init_mm (ptdump acquires the mmap
> +	 * write lock).
> +	 */
> +	scoped_guard(mmap_read_lock, &init_mm) {
> +		list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
> +			list_del(&ptdesc->pt_list);
> +			pagetable_free(ptdesc);
> +		}

As I understand it, the argument for taking the read lock is that we're
operating on a region that we "wholly own" and therefore we can happily
run concurrently with CPUs walking distinct parts of the page-table.
However, from what I can tell, the CPA collapse logic will operate on
regions outside of the address range being manipulated by its caller
because it rounds up to the PMD size.

As a made-up example, imagine I have a 2MiB aligned region where the
first 1MiB is read-only and the second 1MiB is in the default r/w state.
If one CPU calls set_memory_rw() on the first 1MiB while another CPU is
walking the second 1MiB (via some other API that doesn't take cpa_lock),
it looks to me like the first CPU can collapse the page-table and free
the unused pages under the feet of the other CPU. What prevents that
from happening?

If all concurrent walkers have interrupts disabled, I guess the TLB
invalidation logic would do it, but it would be good to call this out in
the commit message because it's not clear to me why the read_lock is
sufficient for the collapsing case.

Cheers,

Will
