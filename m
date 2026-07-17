Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5554C3F1AA8;
	Fri, 17 Jul 2026 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784287850; cv=none; b=Qs8Siyz/Zj9PKZpYqf5f8ozo9YOqMpbw0tqWVM0+IkOSQlnUviie9XvJc+kWnDiQE8NBldyAO/qvjN0xycdeiKTzirtKaNWfutKShLAE/dtdU2+V4uAVaXyR4qbaL54mrddzYfv/Ws+jT5Q5aRxhPt6e1tMpX9yDURDc8Ku4D9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784287850; c=relaxed/simple;
	bh=XH0bTbd8PQ+uJqwGAphGeklYpbJLRfXC2YtGdGf5MUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8SsEQ39RNX0ZwuyKFu6YHUkuUicqSL70vOuIaNqej+GZi9WGYVCaIAT+HkC6GfMb1Avyt/2jbgFwiRiv2FIQ/ZkTtzZQ+z6lAcNjmWkB27eUaC4uM6wpJm1bzFQrw8BIV+xHtThteOeOu0L47AN20EBPTs42FCh8og0kz9Y5PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mm6Mjx2W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mm6Mjx2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6D01F000E9;
	Fri, 17 Jul 2026 11:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784287847;
	bh=Z77F8t8gGlaXLq5H5fqhrXWlygcKdmYBzV6kxoIyf9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mm6Mjx2WdJ6T9LFLOqOCy1chNn5Dfw9PYBRptQkrjobxEd6vdKZLFyWmyExSV/IXO
	 kAoVHmBEWIKVYOz94aV4seSn830RCuIjBT/xQg4Cr0LJVahJuc1ntlKVjPNrzVVdaV
	 thsnBEOE0IROso9ahcOE1hw75IA/w37iZJgWnJlqe3JM8tW0cGt33sGZdDndeu0nlq
	 req+4/lVTHvqtyAkvbM4J5acpd9z8LGvG4KD+v8A1sy9uFscqtEM7ZDXAgqAm+8YGh
	 HLj+sAwlRqvIpc+VPdGp7LfESROOJknoQznqamj40WF3XjNkWbqbqHyDI64Nzvgbmu
	 Hm+KJoBMLN7Bw==
Date: Fri, 17 Jul 2026 12:30:38 +0100
From: Will Deacon <will@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
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
	linux-arm-kernel@lists.infradead.org,
	"Denis V. Lunev" <den@virtuozzo.com>, stable@vger.kernel.org
Subject: Re: [PATCH mm-hotfixes v4 2/4] x86/mm/pat: acquire init_mm write
 lock to avoid UAF
Message-ID: <aloSXsTLOSepa5fA@willie-the-truck>
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

Thanks, Lorenzo.

This ain't worth much here, but all the same:

Reviewed-by: Will Deacon <will@kernel.org>

with one nit below:

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

The CPA lock should handle those, so I think it's the non-CPA walkers
that are problematic. Looks like Sashiko reckons it's found some that
don't take the mmap_lock at all [1], but this is still a big step in the
right direction, fixes the ptdump case and we're not trying to boil the
ocean.

Will

[1] https://lore.kernel.org/all/20260716215307.14A6E1F000E9@smtp.kernel.org/#t
