Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F104D9549
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161784; cv=pass; b=lmvaLa2DXGFw3LD1cHKjebSpF0B1JGUGyyeqA2duN+F3xW86TlnBq09PrDaB7l11GsUkAX031rNl25IsyEGdhguCIjOpLmTVzJknN0ZMocT2XdRyTp2UujUqMvYoKC52iLK0bqyK8RXM3c3XwjcuOyroQSBdgOmDBJvO/rRr11E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161784; c=relaxed/simple;
	bh=UBNtMDVYWEB8MGKn1aRe8o7inZto3DUEyzBIj6oCEAY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKX5dXE7hZEx37jHAQTgoRVNZZs6z9GOMTgrmxia0zyR0wdppELQYuXJGSSHURbd+1ffE69DSPNl+MwahwW1KRcI8Lo72ay/C9sM6lBiZ7GjlVqHzuSVbqqMYg161dkMEqoq73822yqv9h7Qvv87FqBU6h3t4Uqcm+JYF7h/IWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPEFogDd; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPEFogDd"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-673504236d7so8604d50.2
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 07:43:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792161781; cv=none;
        d=google.com; s=arc-20260327;
        b=WDhT7tYGjsBPYHBwNUXAbsMj7R5M2A4ieX5lSWDgBawWEK1Lmjf4WvXrhv5wwHOskK
         mIppSyVSRYOLw3sushGxxnARFgHEJfl8QSQrcPWiOhWklbZgn0JUAgzC1b5kt2h71b6/
         3x+EMWRjPE6UUSGDgUS8KhQ+AXNEH6PouwTZhzqOpNqLQaxtscQ7sj80a9vVEiLFRTTf
         zdpaUE3VKAK2fOxisPDhRAUkrd6TqZoA45+9NF0cppk+hfvnRspbgu1UTjARoFo1rwer
         VwOqvn4m6rKN2fdb1+IudciGlthNsHdSSRi91kITLUXDC20AFOf/mvtmqMKklkkymNnz
         Cmjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=nJtgmZrmor3FIwfdZIg6Zf/PH5vjzxmpZb34dCGZXac=;
        fh=oHwHtbAaAG3i4RvikrV5wq3u58jXk0utItooTmRYFL4=;
        b=AJMA5TItr6xXvP7YjuItPXcImTxtucIzHBp2Ge1S3fm7n+kX0aRVwbobL0+u4FW252
         FTYUhMn1kfqaisX4rTN5wtWZIXn954nQhwPFsNg//n/cL7qrCecOw8V0dSRiZVGJ7khy
         W3GOR+3R4SfoY5KGPilHAipM89+J6VTaAeQPXc6DURIqiRbK7YYykiOP/jyThTELiPM5
         GChXHlp6O520KOE5vHt37AB64eXHm7MxY1hbVYEF4Du/LZNG8htgzlsfRPP2nbyaOvSv
         7d1FOsB5pmL8hQZq/XbTOz6bkz+J26vPyb+8QeK7WO9H/Y4XxDJh7wkRLoRGX8E2cMHM
         dzGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792161781; x=1792766581; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nJtgmZrmor3FIwfdZIg6Zf/PH5vjzxmpZb34dCGZXac=;
        b=lPEFogDdyjA4KU4rBBYFB4XkH5xmA8pXiAZf+emHARds2DMbt+SGxHaqCnZYxBG7Ty
         tNIxUwPE7ZF+AQppTTEpd3cCiR3b8SH6f+EwmYRjjRGpz88v81Qkk5iPTdg+5Q2cbkwB
         gNZcatTihYtSrt7Qsjl97N+ZsLmrP/pDfIBzynMkZvRyyeb3ng3A8OjEI9LhmHowaEIR
         OMrt8u9ZQV28WKACeB88RA8+0wMhOnLT9DQZxiL3mq9WKSuY8O6GWOIgnJH8UJTZ/IRo
         RwdD2b0B9/q0kHykEJOWbxIyie+dsCh0woMVl7UCxWuVlYB+QXVA7cVvEIfE5PwOdVMs
         OVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792161781; x=1792766581;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nJtgmZrmor3FIwfdZIg6Zf/PH5vjzxmpZb34dCGZXac=;
        b=A62DGWScO0SoWuO8+jgGqe8obVdDu2G5go7lUKcb6cWpa46lJDIYrvpl3spKWxmvHV
         8zW1O5ol79TBSg7EXOLMnGVa21mrPK+riJkzVuNeOYGgTjNPNl/BflhlOGZd8P1uLeML
         XCteHNzhq6xwIB4Sjjuw7L5Wx0ZMWiX7dtGZZrOS5aRF3ZIY11rHtiwYAXceGKR7FWmm
         Xbbnm2LLHFeYYTfHKFLkZuhpbiGgMgVMcxhYKl17ubYiHWbUCxlvV4en2biQHnrnUHpx
         F6JFZtyQ3PkK/cq5r0mk1JAorD8yAvjMyYOnzb9m9M4DpZaU+f1FML6CkXlhPqRofA6a
         lz8Q==
X-Forwarded-Encrypted: i=1; AKwUvBwZa7upMe4FtjMzXg5LgYnzvDlmxP5q5w3KTO65qoL94S+Gj/l/sUGXM+2yiXRoVQFucEC9j0I=@vger.kernel.org
X-Gm-Message-State: AFq9FYICOS+9Rm7mM89fkCvKqRAoUnj4WymCQf022HJH6BBereZZiMOw
	2km7uaHFBzByG4BqAzLADbLZVHf1dXihw9FdSd0t2fgVAjHCC+jqUGLifQESUTylOF5gtQWUjP3
	PJFBnYKISJAwVtISzmteZF4E4anfupCo=
X-Gm-Gg: AYBFou3WgYQ5f5LDGagQ0NsC5JYLeKcSwh7tTGaIRq93DLuAXXv6htinxC64On7Q7io
	9+TqyJmhGQAG5Rb/Qyqs9lzDPv8Dp2A+rxQVMmTqsberkxeFYs5g6jQPLYftaaZaZolFDO6CLMX
	WzkLa7JsqcHt1WDUQobesRUJYSHxMG7D22k8lqdC2de2llfPzZI/mLh2M4F/Z1fIjI1Uva31Ktt
	OvSgG4ohsm9mNyUY//ozrLf7fbHDjIINiVZ/ej6K32kiMMS+RE186qkEDXhnDZJjD6Wt2Tk8oL0
	pljT92Cf15Gs7PX6XHOvOLhm55+Wa4VfdpVe6eA19qPBTWD/OiETKQ==
X-Received: by 2002:a53:ac86:0:b0:679:bf13:c02c with SMTP id
 956f58d0204a3-679bf13cd2cmr835137d50.0.1792161781303; Fri, 16 Oct 2026
 07:43:01 -0700 (PDT)
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 16 Oct 2026 09:42:59 -0500
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 16 Oct 2026 09:42:59 -0500
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20261010133751.46807-1-songmuchun@bytedance.com>
References: <20261010133751.46807-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 16 Oct 2026 09:42:59 -0500
X-Gm-Features: AclHuK8b5Saw62oROYWx_NReQFrlF0sxRRr84kcTA0PC8A8ZSdrqwWS_5T0zMZs
Message-ID: <CAPAsAGyDqG0_JPB3c-4bY9jwdQ7eTxGJT0Ce-NowKiJ44T3LsA@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix runtime shadow page table synchronization
To: Muchun Song <songmuchun@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Dan Williams <djbw@kernel.org>, linux-mm@kvack.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Muchun Song <songmuchun@bytedance.com> writes:

> kasan_populate_early_shadow() is also used after slab becomes available
> to install shadow mappings for hot-added memory. When this path
> allocates a new P4D or PUD table, p4d_alloc() and pud_alloc() publish it
> only in init_mm.
>
> On x86-64, runtime kernel mappings that add a top-level entry must call
> arch_sync_kernel_mappings() so existing process page tables can see it.
> Without this synchronization, the KASAN shadow mapping can remain
> unreachable and fault when the hot-added memory is accessed.
>

Did you actually hit this crash or it's just LLM's/code inspection finding?

> Add p4d_alloc_kernel() and pud_alloc_kernel() to perform the required
> synchronization, and use them for runtime KASAN shadow population.
>
> Once copied, a top-level entry remains in other process page tables.
> Clearing only init_mm and freeing its target table during teardown would
> leave stale pointers behind. Retain these shared levels instead. On x86,
> this keeps PUD tables with four-level paging and P4D tables with
> five-level paging, while lower-level tables can still be freed.
>
> Fixes: 0207df4fa1a8 ("kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/mm.h | 24 ++++++++++++++++++++++++
>  mm/kasan/init.c    | 10 ++++++++--
>  2 files changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5cca90fc1df6..5453d3e42780 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3855,6 +3855,18 @@ static inline p4d_t *p4d_alloc(struct mm_struct *mm, pgd_t *pgd,
>  		NULL : p4d_offset(pgd, address);
>  }
>
> +static inline p4d_t *p4d_alloc_kernel(pgd_t *pgd, unsigned long address)
> +{
> +	if (unlikely(pgd_none(*pgd))) {
> +		if (__p4d_alloc(&init_mm, pgd, address))
> +			return NULL;
> +		if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)
> +			arch_sync_kernel_mappings(address, address);
> +	}
> +
> +	return p4d_offset(pgd, address);
> +}
> +
>  static inline pud_t *pud_alloc(struct mm_struct *mm, p4d_t *p4d,
>  		unsigned long address)
>  {
> @@ -3862,6 +3874,18 @@ static inline pud_t *pud_alloc(struct mm_struct *mm, p4d_t *p4d,
>  		NULL : pud_offset(p4d, address);
>  }
>
> +static inline pud_t *pud_alloc_kernel(p4d_t *p4d, unsigned long address)
> +{
> +	if (unlikely(p4d_none(*p4d))) {
> +		if (__pud_alloc(&init_mm, p4d, address))
> +			return NULL;
> +		if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)
> +			arch_sync_kernel_mappings(address, address);
> +	}
> +
> +	return pud_offset(p4d, address);
> +}
> +
>  static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
>  {
>  	return (unlikely(pud_none(*pud)) && __pmd_alloc(mm, pud, address))?
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index 66a883887987..93a74a1fcdec 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -206,7 +206,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
>  			pud_t *p;
>
>  			if (slab_is_available()) {
> -				p = pud_alloc(&init_mm, p4d, addr);
> +				p = pud_alloc_kernel(p4d, addr);

I think it would be better to reuse pud_alloc_track() here.
Pass a pgtbl_mod_mask through zero_p4d/pud/pmd_populate(), and call
arch_sync_kernel_mappings()
only once at the end of kasan_populate_early_shadow()

>  				if (!p)
>  					return -ENOMEM;
>  			} else {
> @@ -268,7 +268,7 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
>  		if (pgd_none(*pgd)) {
>
>  			if (slab_is_available()) {
> -				if (!p4d_alloc(&init_mm, pgd, addr))
> +				if (!p4d_alloc_kernel(pgd, addr))

Ditto

>  					return -ENOMEM;
>  			} else {
>  				pgd_populate_kernel(addr, pgd,
> @@ -322,6 +322,9 @@ static void kasan_free_pud(pud_t *pud_start, p4d_t *p4d)
>  			return;
>  	}
>
> +	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)
> +		return;
> +

With 4-level paging the PUD table is now kept here after it has been
synced to every pgd. A later kasan_add_zero_shadow() call can overwrite
it in init_mm only. This might cause a problem, because the aligned
shortcuts in kasan_populate_early_shadow() and zero_p4d_populate()
don't check whether the entry is already populated:

mm/kasan/init.c:kasan_populate_early_shadow() {
    ...
                if (IS_ALIGNED(addr, PGDIR_SIZE) && end - addr >= PGDIR_SIZE) {
            ...
                        p4d_populate_kernel(addr, p4d,
                                        lm_alias(kasan_early_shadow_pud));
    ...
}

So sequence of kasan_add_zero_shadow(), kasan_remove_zero_shadow(),
kasan_add_zero_shadow(), arch_sync_kernel_mappings()
might trigger the BUG_ON() in sync_global_pgds_l4():

arch/x86/mm/init_64.c:sync_global_pgds_l4() {
    ...
                        if (!p4d_none(*p4d_ref) && !p4d_none(*p4d))
                                BUG_ON(p4d_pgtable(*p4d)
                                       != p4d_pgtable(*p4d_ref));
    ...
}

Perhaps the aligned populate paths should skip an entry that is
already populated.

>  	pud_free(&init_mm, pud_start);
>  	p4d_clear(p4d);
>  }
