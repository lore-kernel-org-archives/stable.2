Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C586D29BDAA;
	Mon,  3 Aug 2026 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770080; cv=none; b=CTS3YoEBAtdz/25k4QrXdG3OTWxbW/LMhgpH7XOFQDe/5PnkLl/SVpw+8djehNJq8wE+Yae1ut9uN5sMrDDZJkNN9Qa1V4ENDEnEAftZhAMmG1znbS90gPLRU6Zzf09r3spJXGGpPjmvjOmFCjuiXjiZqIO5jB0m3cp3oSfl1UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770080; c=relaxed/simple;
	bh=KKk3WtLKjexT3Ex51exX+4KxnHu4UtIIzmN7NgXdCuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLed7O6/pL0G/N4k0ggR3ya3cBYvsdJkpKyAArYFM8Dy5r7i9EueG9eEn+cqwb9agKwbKACIe9+gKDwbxLmzfmdL1pOg5zOXRw1MxeebJbEK2msRly2xLvLwP4tG8GhMjsNXwvuF2hcO7Z5ArKevVE/OSS9OA3Sq0cInORljSq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vzlq/5g+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vzlq/5g+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC91A1F000E9;
	Mon,  3 Aug 2026 15:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785770078;
	bh=jxpSlS7fw1sw+jv/kLILYNNHEAmkhzbCu2EmmYNqlJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vzlq/5g+ZM8dG9vHbh4TD57opi++DNF81m2TQVy2RYsQyN0pzjJAMexGSS+Q8mNDB
	 Jf7LIuUrrx1JK+4ohZhTwFnu6d1cXwaIg2A2F3E9SdD4/vIywwlQpe08Xbt9sg6iFO
	 CDDU9qVyT1E44okjSeeTmASarl2PQDxEh6rV0J300Sv1sGdbBxdQUXtfidCC7pfBkG
	 5vgdgpKK3P1JG0FSb/QuNlcD4Dhz8PvTTfl7JU4lsTLdQwMEvBHxL+AUNBJW1gwO7v
	 jejBsVHnSD+uc3mfeYd0/uiOMiAROHdPYhO1FhX/bVSilxznmRPJmgiip5jH5YJJ8t
	 tF6fpoaRiestQ==
Date: Mon, 3 Aug 2026 18:14:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	David CARLIER <devnexen@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Juergen Gross <jgross@suse.com>, Kevin Tian <kevin.tian@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Toshi Kani <toshi.kani@hpe.com>,
	Vishal Moola <vishal.moola@gmail.com>,
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org, x86@kernel.org,
	syzbot@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/5] x86/mm/pat: CPA fixes
Message-ID: <anCwUb9lV18v6mfN@kernel.org>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>

@Dave, @Peter, how do you want to proceed with these?

On Tue, Jul 28, 2026 at 04:07:43PM +0300, Mike Rapoport (Microsoft) wrote:
> There are a couple of CPA fixes floating around:
> 
> Denis Lunev fixed races between split and collapse of the large mappings:
> 
> https://lore.kernel.org/all/20260715183453.2381141-1-den@openvz.org
> 
> Lorenzo Stoakes fixed UAF caused by races between CPA and ptdump:
> 
> https://lore.kernel.org/all/20260723-series-vmap-race-fix-v6-0-8cc77dcc0018@kernel.org
> 
> and an issue with stale page tables in IOMMU:
> 
> https://lore.kernel.org/all/20260721-fix-cpa-kernel-pagetables-v2-1-2b255deed710@kernel.org
> 
> Mike Rapoport fixed a check of RW attribute in lookup_address_in_pgd_attr()
> used for the verification of RWX:
> 
> https://lore.kernel.org/all/20260715144519.934289-1-rppt@kernel.org
> 
> Some of the fixes got merged into x86 tree, some of them got merged into mm
> tree and some are still hanging in the air.
> 
> Beside the fixes there was a supposed simplification of cpa_lock locking 
> that looked like removal of an optimization for DEBUG_PAGEALLOC, but it
> turned out that it was not an optimization but rather a correctness
> guard because with DEBUG_PAGEALLOC the locks could be taken in an atomic
> context and couldn't use plain spin_lock()/spin_unlock().
> 
> The changes here are collected from all these fixes into a sinlge coherent
> set on top of tip/x86/mm:
>  
> * update to cpa_lock handling with DEBUG_PAGEALLOC
> * fix for races between CPA and ptdumpi causing UAF
> * fix for stale page tables in IOMMU
> * update to the fix of the race between split and collapse of large
>   mappings
> * fix for effective RW computation in lookup_address_in_pgd_attr()
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
> Lorenzo Stoakes (ARM) (3):
>       x86/mm/pat: acquire init_mm write lock on collapse to avoid UAF
>       x86/mm/pat: acquire init_mm read lock on attribute change to avoid UAF
>       x86/mm/pat: allocate split page tables as kernel page tables
> 
> Mike Rapoport (Microsoft) (2):
>       x86/mm/pat: introcude cpa_lock() and cpa_unlock()
>       x86/mm/pat: fix effective RW computation in lookup_address_in_pgd_attr()
> 
>  arch/x86/mm/pat/set_memory.c | 95 +++++++++++++++++++++++++++++++-------------
>  include/linux/mmap_lock.h    |  2 +
>  2 files changed, 70 insertions(+), 27 deletions(-)
> ---
> base-commit: a5a162fe1ae130e3d2ceefef3f43afe3773c1d56
> change-id: 20260727-cpa-fixes-d3c73c075672
> 
> --
> Sincerely yours,
> Mike.
> 

-- 
Sincerely yours,
Mike.
