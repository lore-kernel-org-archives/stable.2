Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD6433CE9A;
	Sat, 11 Jul 2026 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783764327; cv=none; b=p0F+8zPrcrYKsJkCwxrDLq6B9isHQw6hdUqhj0Bakh1PBkmIoVoGiCiNepeqZGr5kMjA2brOhl+iK5TgaEBQ16de8bbr/PV6pYOREam6qj2znSpnGs/ttiFGsu0dqHLnqV1SgvEhWMldh0um+D0Z/VTH6FPH3xlHlE6jerfwaZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783764327; c=relaxed/simple;
	bh=InWxaxjlhCKmIA+W6MZk+UYaeE0ntPRJPK9tMyRbA00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJ6WWCt6AKshIVAtvSoflurBuXkqa+yryNaNY0uhfFQCiAJsB5wPrGfnpLfOrxd8csZXRRwHimcGC82JhFNnr01IDA2QMyThIU0XPYCW7z55btM9zyT56WUOPxVDabM/fc1wYHcVLmSHYdVUL+Yy3bV+/lNH33G1cnaumhoW6tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XioELHoH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XioELHoH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD0E1F000E9;
	Sat, 11 Jul 2026 10:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783764325;
	bh=NEXzQwCM+KjtFiOyreYV4OHvCpIVJqllobeJxoh3ia8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XioELHoHSzeJEbZcDohx8AiAsiBZoGu6V7u6C6dP2+IEpHdiic53QISQ8Y0OjL2oI
	 Bq48b8s9wwVoGbBDRJMfCru5b/0m+8WRaTSl8Sr/pbyRFbRSHG6eop2Ku584dnfFDU
	 wPX6/zqUcRpQElWnJZ9Mz2+nWTM0jVa38+Cp+xS3ftp6VSBNOoEQ4ISVxCZJZViLxj
	 9lNPHSuQxs7bq6SV/Dl6VRDG6M/juIkvfVEuLIMJhfAu16LWw56RHkmHycOXD7xwrm
	 ZBGujZ3P7I6/Sx9uMxpb/TFfK+Scbh70aGNvvGlbQrqBXRfifgVzVw39RcQO1oFlLy
	 N5nzcjfdchAIQ==
Date: Sat, 11 Jul 2026 13:05:16 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Carlier <devnexen@gmail.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm/pat: acquire mmap lock on page table free to
 avoid ptdump UAF
Message-ID: <alIVXHrcjaHhaFQo@kernel.org>
References: <20260710-fix-cpa-ptdump-race-v1-1-d898699a7417@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-fix-cpa-ptdump-race-v1-1-d898699a7417@kernel.org>

On Fri, Jul 10, 2026 at 12:56:40PM +0100, Lorenzo Stoakes wrote:
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
> However, this is problematic for ptdump, as it walks ranges it does not own
> and thus runs the risk of a use-after-free on page tables freed underneath
> it.
> 
> This patch resolves the issue by acquiring the mmap read lock on init_mm to
> provide mutual exclusion against ptdump, which acquires the init_mm write
> lock.
> 
> It is safe to acquire a sleeping lock as all the callers invoke
> set_memory_rox() from process context and in any case,
> change_page_attr_set_clr() calls vm_unmap_alias() which ultimately takes a
> mutex, disallowing atomic context here.
> 
> We also include cleanup.h in order to use a scoped_guard() to implement
> this cleanly.

This is a part of another patch, isn't it?
 
> Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  arch/x86/mm/pat/set_memory.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

-- 
Sincerely yours,
Mike.
