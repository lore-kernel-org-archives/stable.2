Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27323839AD;
	Fri, 12 Jun 2026 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274296; cv=none; b=N/qku9mHNxxMouTZgSepHWm7XmrInsttabtd+HslA27DBCJWW6hMFn7WlvY7PcNBCv7XIAeZka0QTw6kL/TpfQZ8vGDkvW/lUj+ECrrnRSNX1Vh879JX3UpF0joRg8rZmLQfFCkqm9n1qriYGCud4RPmtB4xhzCWhj1zFpgOt6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274296; c=relaxed/simple;
	bh=o9FmxhXkdy8nu7c7PeyhmJ87iJ6ZqDGwT8/Z7FIizAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhYcpuSFZaSGTI9kiOaDv09/roDXQQLR0XCoEFvd0OO2FE4EsoRfninPMu/bfbLicFWD1ArddVeAfyHapyzFnBpjk5viIdZilHWqsbskT76JOZY8uNPzfJQQExyBiSr3k7fb3J3NCQvWI7Up6DYR4rSwe6sV1HZ20moCBnNrLR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yN++Ar4U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fw/CS40E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yN++Ar4U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fw/CS40E"
Date: Fri, 12 Jun 2026 16:24:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781274291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwVtWQfu240VJ6rqsKtn7HxHk2R31SZbP2CkXTGyVBw=;
	b=yN++Ar4UPeFVObgPptrM588vgWIw15P7N4oXqSzIGyFQOf7x7CuItiHn6bBlXUdRbH+axN
	cxeXNn9myH56N2/BOTWRv5I7U8xz2ahAuqxtOjs44Y3LN3KzmtViijfT3xmoFWC3fYywgC
	kdA5dD3bEqw8r/tQcN3waQH5d3f78ixh5AeNCpzcyxsKx5QLrYM81+yA6PadxpruigX+2y
	yMHPec+j0IT3CFCARpo6yNoAGFxdEHrOCyXSCcbTlK8229Y/u0vIU868LvZkG1isqj5X/s
	shtQSjoIxeiw44nTiY3N4xwJaXBVysKjTYpH81IBW6iV1cOjhGLr9CIDNM9lEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781274291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwVtWQfu240VJ6rqsKtn7HxHk2R31SZbP2CkXTGyVBw=;
	b=Fw/CS40Emarj/k0CM4lLjf3k6omNTZJE0zu0chda+lYYSWq7q5sblGyvvDa0yVi5lfqMRN
	8BnlkiroEJEQ0CAQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Andrey Smirnov <andrey.smirnov@siderolabs.com>
Cc: pasha.tatashin@soleen.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	syzbot+2b5fe617654be3d8848b@syzkaller.appspotmail.com, Thomas Gleixner <tglx@linutronix.de>, 
	Andrei Vagin <avagin@gmail.com>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_table_check: do not track special (PFN-mapped)
 PTEs
Message-ID: <20260612162031-b4731d21-b293-4d36-8582-26394bd55a1f@linutronix.de>
References: <20260608155758.1220420-1-andrey.smirnov@siderolabs.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260608155758.1220420-1-andrey.smirnov@siderolabs.com>

On Mon, Jun 08, 2026 at 07:57:58PM +0400, Andrey Smirnov wrote:
> The vDSO data store ("[vvar]") special mapping is created as a VM_PFNMAP
> mapping and its pages are installed into userspace with vmf_insert_pfn(),
> which produces special PTEs (pte_special()). On x86 and arm64 (and riscv)
> pte_user_accessible_page() only tests the PRESENT/USER bits and does not
> exclude special PTEs, so page_table_check accounts these PFN mappings in
> the per-page anon/file map counters even though they are not rmap-managed
> pages (vm_normal_page() returns NULL for them).
> 
> Most of these data pages live in the kernel image and are never freed, so
> the stray accounting is invisible. The time-namespace VVAR page is the
> exception: it is a real alloc_page() page that is released with
> __free_page() in free_time_ns() when the last task of a time namespace
> exits. Across the map / unmap / vdso_join_timens() zap transitions the
> special-PTE accounting is not balanced for this page, so a non-zero
> file_map_count survives to the free path and trips:
> 
>   kernel BUG at mm/page_table_check.c:143!
>   __page_table_check_zero+0xfb/0x130
>   __free_frozen_pages+0x52f/0x650
>   free_time_ns+0x85/0xc0
>   free_nsproxy+0x7f/0x130
>   do_exit+0x313/0xa60
>   do_group_exit+0x77/0x90
> 
> This is reliably reproducible on x86_64 and arm64 under heavy container/CI
> churn that rapidly creates and destroys time namespaces (CLONE_NEWTIME via
> runc / docker-init / tini), and was independently reported by syzbot on
> riscv. It only manifests when CONFIG_PAGE_TABLE_CHECK is active.
> 
> Special PTEs have no struct-page rmap semantics and must never have been
> tracked by page table check. Skip them in both the set and clear paths so
> the counters stay balanced (always zero) for PFN-mapped pages, regardless
> of how the architecture defines pte_user_accessible_page(). pte_special()
> is available generically (it is a no-op returning false on architectures
> without ARCH_HAS_PTE_SPECIAL), so this is a single, arch-independent fix.
> 
> Note that the v7.0 generic vDSO datastore rework in commit 05988dba1179
> ("vdso/datastore: Allocate data pages dynamically") incidentally avoids
> the problem by switching the mapping to VM_MIXEDMAP + vmf_insert_page()
> with balanced struct-page accounting. This patch fixes the still-affected
> VM_PFNMAP path used by 6.18.y and earlier, and additionally makes
> page_table_check robust against any future PFN-mapped user pages.
> 
> Fixes: df4e817b7108 ("mm: page table check")
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> Cc: Andrei Vagin <avagin@gmail.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reported-by: syzbot+2b5fe617654be3d8848b@syzkaller.appspotmail.com
> Closes: https://github.com/siderolabs/talos/issues/13496
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrey.smirnov@siderolabs.com>
> ---
>  mm/page_table_check.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index 4eeca782b888..ee492d5389b9 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -150,9 +150,16 @@ void __page_table_check_pte_clear(struct mm_struct *mm, pte_t pte)
>  	if (&init_mm == mm)
>  		return;
>  
> -	if (pte_user_accessible_page(pte)) {
> +	/*
> +	 * PFN-mapped (special) PTEs - e.g. the vDSO/time-namespace "[vvar]"
> +	 * mapping installed via vmf_insert_pfn() - are not rmap-managed and
> +	 * must not be tracked here. Tracking them can leave a non-zero map
> +	 * count on a struct page that is later freed (the time namespace VVAR
> +	 * page in free_time_ns()), tripping the BUG_ON() in
> +	 * __page_table_check_zero().

As this comment mentioning the [vvar] pages is already stale, IMO this should
not be mentioned specifically. It is also not clear to me why this only happens
now and where the non-zero map count comes from.

> +	 */
> +	if (pte_user_accessible_page(pte) && !pte_special(pte))
>  		page_table_check_clear(pte_pfn(pte), PAGE_SIZE >> PAGE_SHIFT);
> -	}
>  }
>  EXPORT_SYMBOL(__page_table_check_pte_clear);
>  
> @@ -205,7 +212,7 @@ void __page_table_check_ptes_set(struct mm_struct *mm, pte_t *ptep, pte_t pte,
>  
>  	for (i = 0; i < nr; i++)
>  		__page_table_check_pte_clear(mm, ptep_get(ptep + i));
> -	if (pte_user_accessible_page(pte))
> +	if (pte_user_accessible_page(pte) && !pte_special(pte))
>  		page_table_check_set(pte_pfn(pte), nr, pte_write(pte));
>  }
>  EXPORT_SYMBOL(__page_table_check_ptes_set);
> -- 
> 2.53.0
> 
