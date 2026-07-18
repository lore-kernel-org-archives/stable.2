Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75DF2DB794;
	Sat, 18 Jul 2026 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784372103; cv=none; b=Z49NWUgIcG01ZpnayebeTNvloq2IkGpMgKbxCkqvKDw1pchQLMdPgD4MmznnExBD3WbpTRmAReQzHsVDLAgxz9QUPePYwJmqwzKBCw5FfDteBHj4d3T95Dq6EXWszKkbxxgL/EN+Mjl6uDzmUURHmtFeK65acZzchyQ6jflAN8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784372103; c=relaxed/simple;
	bh=VPez2kCk8EUMWhoDf8qATR/LDnFE4PepJlxC3mOAojQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSkS1PLVHW6511OZex2mVJsIuwm3od81JrCleokIcnkGeM+eOkkFsCuvG7o7H2tqURKFi0bSTvk4T2lUN3bLjAfb/haUDlz688J8R1urFXeWhOGhGL7eGbPtQT1CUyxZUhkV9How29rayzDdfncLeuOi1huO6BrgBH9Z4DUarCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiI8R0kP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiI8R0kP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B31D1F000E9;
	Sat, 18 Jul 2026 10:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784372102;
	bh=6Wk95nsyLty8ZIxsRyt5wCr5/RC7WWcTwZjDgbSZNSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aiI8R0kPNLSytO43AkjaOcOjJhYehi+jiu0VA1Efoyqtg1kBLTrE0UTrpEjDlMu/K
	 dnFZ5QtHXVwRiuDjw8yONGi0FSYk9RBir2PD/U99wZJ1Vb4q+9Q4RbVpWwNVcr91Yq
	 r26wxPsubsi+R9hxTg+TqhAGi1e756ZR7odtaCpKb0PSYO/H5GFAFLy4cbmG5YQ0re
	 pgLWdpkAR+xyXqa9zjTTRyaD6kK/ktq2b15gni9Bc+q78KU5jfhbAVk+s5GWZpn6Tg
	 mzKAgRuA9T7wlRb+kZ1gwGzSToi43PYttqNOzzE6ePr5aWjBeK4df/8CUqk7vVM6BB
	 us/qCDz52pdng==
Date: Sat, 18 Jul 2026 13:54:50 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>,
	Toshi Kani <toshi.kani@hpe.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Carlier <devnexen@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"Denis V. Lunev" <den@virtuozzo.com>, stable@vger.kernel.org
Subject: Re: [PATCH mm-hotfixes v5 3/5] x86/mm/pat: acquire init_mm read lock
 on attribute change to avoid UAF
Message-ID: <altbeuTZ0HCz_7HS@kernel.org>
References: <20260717-series-vmap-race-fix-v5-0-606a0ac6d3e5@kernel.org>
 <20260717-series-vmap-race-fix-v5-3-606a0ac6d3e5@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717-series-vmap-race-fix-v5-3-606a0ac6d3e5@kernel.org>

On Fri, Jul 17, 2026 at 06:30:09PM +0100, Lorenzo Stoakes (ARM) wrote:
> A previous commit protected us against races between ptdump and CPA
> collapse, however one still exists between attribute changes and collapse
> as reported by Denis V. Lunev (linked).
> 
> When an attribute change arises, a lockless page table walker obtains a PTE
> entry, which is later written to via set_pte_atomic():
> 
> ...
> -> change_page_attr_set_clr()
> -> __change_page_attr_set_clr()
> -> __change_page_attr()
> 	-> _lookup_address_cpa()
> 	-> lookup_address_in_pgd_attr()
> 	-> [ lockless page table walker ]
> -> set_pte_atomic()
> 
> There is nothing preventing a concurrent CPA collapse which can free the
> PTE that was retrieved here, resulting in a use-after-free.
> 
> With the mmap write lock taken on init_mm over CPA collapse, we can now
> resolve this race by acquiring an mmap read lock on init_mm over
> __change_page_attr_set_clr().
> 
> This locks across the whole operation over which the walk and the PTE entry
> write occurs, solving the race.
> 
> It is safe to do this here, as no spinlocks are held upon entry to
> __change_page_attr_set_clr().
> 
> The CPA_COLLAPSE flag is only set by set_memory_rox(), which exclusively
> operates upon vmalloc ranges, and on x86 only within the module mapping
> space.
> 
> This is important, because some callers directly invoke
> __change_page_attr_set_clr(), bypassing this lock. However, none of these
> operate within the module mapping space.
> 
> * cpa_process_alias() - a recursive helper called by
>   __change_page_attr_set_clr().
> * __set_memory_enc_pgtable() - operates on the direct mapping and (via
>   __vmbus_establish_gpadl()) the vmalloc mapping space.
> * __set_pages_[n]p() - called by set_direct_map_[invalid, default,
>   valid]_noflush(), __kernel_map_pages() - operates on the direct map.
> * kernel_[un]map_pages_in_pgd() - operates on EFI ranges.
> 
> This work is based upon Denis V. Lunev's excellent analysis of the bug with
> gratitude.
> 
> Link: https://lore.kernel.org/all/20260626163213.2284080-1-den@openvz.org/
> Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  arch/x86/mm/pat/set_memory.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index d1e63f7d267f..301fb9e77d91 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2122,7 +2122,9 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
>  	cpa.curpage = 0;
>  	cpa.force_split = force_split;
>  
> -	ret = __change_page_attr_set_clr(&cpa, 1);
> +	/* Avoid race with concurrent CPA collapse. */
> +	scoped_guard(mmap_read_lock, &init_mm)
> +		ret = __change_page_attr_set_clr(&cpa, 1);

There's a small issue with this. debug_pagealloc_unmap_pages() ends up here
and since it's called from __free_pages() it can be in an atomic context.

>  
>  	/*
>  	 * Check whether we really changed something:
> 
> -- 
> 2.55.0
> 

-- 
Sincerely yours,
Mike.
