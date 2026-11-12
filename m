Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794521724;
	b=mjfqPYhr3M5++CRN2jQfA5/SE6wsXQCNfA7oeAKT12PvjijwBmAk3F9FVmminGEiMC7W
	 MKgtLxOmZmky2StNcS4KuD3MbXElyuB7/gSsXOsouOzk7TNO1xy+ombzwpNhJlJS/khna
	 nMegp6hq4S6VIqyRnEs7Ikg+t2NG7FEFcnm7lXsSp6wr7Ej2ZwbzgVH/nBDE7i8h6Fb4O
	 y3/WB0Q//qsqMOH8nmiFSsON5T2AH/tMLsZUv8MdRPPFKu9Hoxy6+0ZXnibPdrOI0Tt6z
	 D7xcT+MzLwH8O84JnZP26zDQq6p5qoUSRjIo3Tk47BEpuzKjL2xc5OyifkkecSA6LKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=x4QNJEvzAlMIXBGcKmxpv9rSZn0KBUFpxlms+bXqEbk=;
	b=quRPnvxo/2hup76y4IAOpGPu0SrdoCILd49jzqyqm3bDcRH4BgcmrPZMQn7/pS5ZxnPb
	 c9PT1Ilxq22Y1V37baQshNVbzX5gbbaObSgiNhuTTjrMsoOLdV/EWxh2PSo7YysVZ0zWY
	 xjxBrb98CZEBpWH2mysumtJXPZAVVeOAgXeDx2z/A8x22bz9o9nxd9eAWqLdYujlDPhLD
	 V8xTSXNvVOhDoA/Zm08uMXKbd8n0cdfpRxq8t6hqmaY1lTjbnlxzEYpGo7jtfn9GvM8iY
	 r8n5qUNIT3G2ANF2KQaTN1ZrPxOXFcTtCGmiQl1jfXneXr6jF6rNNxSQYLmDzmhmNCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k58G8NKk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDA5606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 22:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EDA5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k58G8NKk
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b791a4b732so1593a12.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 14:15:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794521723; cv=none;
        d=google.com; s=arc-20260327;
        b=DYkrXgDtWeEGJuhD/ZQWNaImSLu1Fgkaf1UO/2va6mfy5hXr7PJUEnKKq4Q6nqouve
         NVesOdt8cJk7IRZ7QCsWP9tu8jQSoHJ4ct32crhnSqWR8DgSadLH04yu4/FHoWlSZXV2
         4YMH0Ndo/9ti8d8ERZ2/3XZ8wZxrMUb89dSbEjJEMc8vVUpX9hEjCpzfZ8mwzTf7V4K/
         RO/0mIfcCsjiJ+AErIhgpxkdm4Fkhtp1WnM3opFjtS/17g2eebrzMseeEdoi5yauPcll
         /u0iRlJRxdAbSUqLEWRMmp5P3UI6/Eqmnb8Tp6lpnQD2ANbV7Qa2a8WvzU5gr1TlYA5m
         RfTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x4QNJEvzAlMIXBGcKmxpv9rSZn0KBUFpxlms+bXqEbk=;
        fh=/HSDMUMXlHad6x6+8MUCTrBW8Q1OswW8KEarJ0bgxkc=;
        b=BnIBBOGQbHb+pJ3n4teXywX+A7DwyNDxUA1hrqasoUwBzKZn1qAYVPFdXMXMtFrC9T
         GzTBb2p+EP5miMb3Xz475M2tp3PRSXWR2n0u5EE+dJYJf680DA61L8qAwkIZjFKajSOi
         8GW+bJ6jw1N+z6OOruIhuBBmRReBy0Fxxwbs1c3o3XN8TRPiK0O88lqBJVGgPPW4w2Yc
         VD482PhrBNLIlZjxaCC5nwERHpnl3knilxSDtuDeX2dOGyl+utJCYdqzSYBaW929E79E
         u7VZjkjWT2fZrWcKQEKkn9tkHVyX6E3KKtXoq+iCrmvfhB1mZCCVzK+LsqfVlLJapg9n
         wgsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794521723; x=1795126523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x4QNJEvzAlMIXBGcKmxpv9rSZn0KBUFpxlms+bXqEbk=;
        b=k58G8NKkh/WsO/aRn9zE+/XMKmaKwxlhXgHBSvCnvHbmNfDC55M7X2cJKW4lOKEx4x
         2XNA0hvefFg1GTOwg1l0gDcBeguG+3wlsYuA5Jlcj1ULA4bU4n5PTag1gNyIvKkqyct1
         EG/Y1U3CSzwHU9DtmRvprGNhPzCUsJHA9+l8c3OnyeJ6ByJagEMf7UVpb6eWtputS+1h
         PJCHxP6olqZSrD/Ave3Zs+DB88iVS6JTBYv/JGD0RK2zve8vysCXWssv80uB1hHK23A1
         fE49K2Io7dbCAALB7BBl9ArU+/VCaX5lbpZ1PP7vr49li/SAZwymMr+G39ZrTCVvNDYI
         fQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794521723; x=1795126523;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x4QNJEvzAlMIXBGcKmxpv9rSZn0KBUFpxlms+bXqEbk=;
        b=vk/Gx8lDWHAzOt37q7em5fpjZZTy9vgzeFc9Z0D9ACvazv6Lf3dYbHLtHYVPz04fBc
         U2/4xlnev8WaORuGkF0XTeGIBg3P4oXqY2uyO55Z89+SZTDDwDYhhMoMilDPfKSQgy1D
         VlUNe5HGgh/lIA30Ocvz5jwDZV5+Nm/vRcN72a1NzSTSu7VWEDtfjwr2h6/UJpBKhyR4
         HlKSKYeo84SmwTcow3UDtMbCY0rS75g9f/nTbrKDscNgaIIr2gHT2OnSxxwBvcGfR9fi
         Ub5e2QYzaH5atCa0BhljrR442KwpUbcGmreuNlx3o0SncWZnsve+Ay4kYsMBoP2NL31W
         3oiA==
X-Forwarded-Encrypted: i=1; AL+hErFLv8si2GqGvYcCShu3I6Yf2qLsvhE/v25ow1M56Asjupjl2I1lejeqtMgApEzZMEv7qZOdWtk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SsTKfkg+bILA2Ec8Azi7JFJcDQg0YJwYpTDN1SY7Tr/ksCF4a
	8mBISBgd/4m/gZnT6QcapzfznPkJBJEbgZlXPCLTAdUpdcfN3e1RFvHLRl5uxvcqld8LCjTx+2i
	VlsxonHJNgQoFhlPrROGcf5jiKNnQlLO6R7gxT7SU
X-Gm-Gg: AYBFou0+hiTIf1KIDHAC+yMt2Wh3Jebj+nxDx88HFgwYf3sjDLWDifUs1n+9MZgnb1D
	ttXyoTojbd1f+vn3jy+f1nZau5nYRnbqpL8wCC2S1jSGlBXQSDWf87u7PqhHain6DhQ3EJ2GIhB
	bAbN/0DocYqszLMUfdjgJAR4xap2Vn+3bNb5c125hWNVZfgYQT0auxpO7miCSYtMkh6ocsbatTy
	UL/shFXwidk9EYmfd0iCSfBt9vXtvNcnpefX7gl2j1GtKx9f1i7pCJMsGmqVUQMp/bPkhrt6T8I
	SBsegG5xDYsq5D1/nBYcCOcSbZslmW3ASzsiZN1ETxca2MupHjsLcqS1yuGCyTVaMzXGKHiZ5ZV
	OWNbnaFk4UwxcMKi5IEao7nauQtn4gtjb6Ysy8ZbTzJIHry/3Nk7a29UQWajvKkixRPo=
X-Received: by 2002:a05:6402:c886:20b0:6b5:70a4:c77c with SMTP id
 4fb4d7f45d1cf-6b7c82e0d9amr8478a12.11.1794521722130; Thu, 12 Nov 2026
 14:15:22 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-pte_table_clamped_end-v1-0-2dbe339c487a@kernel.org> <20261111-pte_table_clamped_end-v1-1-2dbe339c487a@kernel.org>
In-Reply-To: <20261111-pte_table_clamped_end-v1-1-2dbe339c487a@kernel.org>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Thu, 12 Nov 2026 14:15:10 -0800
X-Gm-Features: AclHuK9pHXXgukY8FhNBnEmP3YKYpuBgy2MxKk9i4nfs4cjz8eUM4vjeaML0zRk
Message-ID: <CA+EESO5O7BjFx_bmsogzWBZ0gsDD17na-cGjtc8stwATaHpXeA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm/userfaultfd: fix PTE table overruns in UFFDIO_MOVE
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Barry Song <baohua@kernel.org>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 2:00=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> With a folded PMD, pmd_addr_end() simply returns the supplied end.
> move_present_ptes() can therefore walk past the source or destination
> PTE table during UFFDIO_MOVE.
>
> pmd_addr_end() is only intended for page table traversal, in patterns
> like "next =3D pmd_addr_end(addr, end);". With folded PMDs, a higher leve=
l
> has already clamped the range to the PTE table.
>
> Folded PMDs are uncommon, but can occur even on arm64, for example
> with 64K pages and a 42-bit virtual address space.
>
> Extract the calculation from folio_pte_range() into
> pte_table_clamped_end() and use it to clamp both ranges. This preserves
> the wraparound handling from commit f681d4580d5c ("mm: fix address
> wraparound when scanning large folio PTEs").
>
> Fixes: 50944692052b ("userfaultfd: opportunistic TLB-flush batching for p=
resent pages in MOVE")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  include/linux/pgtable.h | 24 ++++++++++++++++++++++++
>  mm/memory.c             |  7 +------
>  mm/userfaultfd.c        |  4 ++--
>  3 files changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 780fe849ff8b7..66d369870a740 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -12,6 +12,7 @@
>  #ifdef CONFIG_MMU
>
>  #include <linux/mm_types.h>
> +#include <linux/minmax.h>
>  #include <linux/bug.h>
>  #include <linux/errno.h>
>  #include <asm-generic/pgtable_uffd.h>
> @@ -1518,6 +1519,29 @@ static inline void arch_swap_restore(swp_entry_t e=
ntry, struct folio *folio)
>  })
>  #endif
>
> +/**
> + * pte_table_clamped_end() - Limit a range to a single PTE table.
> + * @addr: Start address.
> + * @end: Exclusive end address.
> + *
> + * Only use pmd_addr_end() when traversing page tables, in a pattern lik=
e::
> + *
> + *     next =3D pmd_addr_end(addr, end);
> + *
> + * Higher levels already bound the range when PMDs are folded. Use this
> + * helper elsewhere to clamp the range regardless of PMD folding.
> + *
> + * Return: The exclusive end of the PTE table containing @addr, capped a=
t @end.
> + */
> +static inline unsigned long pte_table_clamped_end(unsigned long addr,
> +               unsigned long end)
> +{
> +       const unsigned long pmd_end =3D (addr & PMD_MASK) + PMD_SIZE;
> +
> +       /* Compare inclusive ends to avoid wraparounds. */
> +       return min(pmd_end - 1, end - 1) + 1;
> +}
> +
>  /*
>   * When walking page tables, we usually want to skip any p?d_none entrie=
s;
>   * and any p?d_bad entries - reporting the error before resetting to non=
e.
> diff --git a/mm/memory.c b/mm/memory.c
> index ec3d9d99ccee2..ee792a2c0ccea 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4959,13 +4959,8 @@ static void folio_pte_range(const struct folio *fo=
lio,
>  {
>         /* Stay within the page table and VMA boundaries. */
>         const unsigned long pmd_start =3D addr & PMD_MASK;
> -       const unsigned long pmd_end =3D pmd_start + PMD_SIZE;
>         const unsigned long lower =3D max(pmd_start, vma->vm_start);
> -       /*
> -        * We cannot use pmd_addr_end(), as it does not clamp reliably. T=
o
> -        * avoid wraparounds, compute using the inclusive end.
> -        */
> -       const unsigned long upper =3D min(pmd_end - 1, vma->vm_end - 1) +=
 1;
> +       const unsigned long upper =3D pte_table_clamped_end(addr, vma->vm=
_end);
>         const unsigned long offset =3D idx << PAGE_SHIFT;
>
>         /*
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 169f681f9849b..57650e6f040d1 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1266,8 +1266,8 @@ static long move_present_ptes(struct mm_struct *mm,
>         unsigned long src_start =3D src_addr;
>         unsigned long src_end;
>
> -       len =3D pmd_addr_end(dst_addr, dst_addr + len) - dst_addr;
> -       src_end =3D pmd_addr_end(src_addr, src_addr + len);
> +       len =3D pte_table_clamped_end(dst_addr, dst_addr + len) - dst_add=
r;
> +       src_end =3D pte_table_clamped_end(src_addr, src_addr + len);
>         flush_cache_range(src_vma, src_addr, src_end);
>         double_pt_lock(dst_ptl, src_ptl);
>
Thanks David!
Reviewed-by: Lokesh Gidra <lokeshgidra@google.com>
>
> --
> 2.43.0
>
