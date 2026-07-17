Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665EA33F588
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 03:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784260017; cv=pass; b=eOI1u5B/BaGngAvHRu+eM2GPqWv8gCKCpXBh4f1BIxx0o/oGDxAzc+MpsW29/fGqJlAwLveZK+LIxWX1eUam6x7QZMwCkYTrMNdXgyu8Pv58SbPUiH5n5nnS0s0mekX2mlaMvio5g8sshQlyjwef1WZA5R2ITErbCAV6nhn5SFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784260017; c=relaxed/simple;
	bh=N3fP95K9irXNso3jags5aBR487rSqTZ+oeDUbB+drfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsrps4xgXvL/5Q7xjz3TNFi593DiVA7VoSMLrouG38AHPQEp2si9/1zcY74MY2dbaP7tQm7+/Y5cBWuyCyR181EWH325K50EYROo/Fn6xsGUlkU4xTZXSYRswTjukj1KWcm/7XLD8FoIWs1L7bDtVm7TafmJxBN1v7MFnXEMuG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qdYj+q2E; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdYj+q2E"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4513435cdd2so3040978fac.2
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 20:46:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784260014; cv=none;
        d=google.com; s=arc-20260327;
        b=EoH5vz2Co9f3q6lHiJexE0/F6sd/cc/XqOF8eiPx++irDlcR1WrU/DO0PyvFZTPq7O
         MsXa5BYlKVbtRyZqKXsCaHHUo38P5QZMULUpVTz448PVykCHmEX7D4ZihvwL524CVjp8
         Yg60IiKvB1Lp6DO641p6CR24DEbEw3BYzrrJPNC2gNza1oW+P3NZgc6c0M3f+KS3R9Nm
         4wPRNzqVjfxOGftXNNXHAEl5tXPOAJRP5VavScGiZyXuSi7EiRDwDjTdixT7ItkDuwi3
         QfXkQpq/KuOptOPx8vM8cily7k8axaR4zGTsWpPBjHiVet/tx727Xwe2luqyGE5+rYu8
         iOVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+qfsfSM7+v1WClc9BxhjMt2YlMxMtKRK2E8WppuykZI=;
        fh=nz6CskT8+eOUseESeuaYwgrzw05OroyKj/NA57yYmx4=;
        b=XhdHRWWkglGB83bx9NwOSHxug4nfF+H9S/MWyNr1UIegBLvVZnkJ3PadLJXM/28GO0
         iKdBcn0TybHrNgexAS9QHEhfq5kPLeEtmLdv7fHGgBDqK5Ezeimrkak1TcXJ5vog6Rit
         tU4AS2dk+uP0QuRg2N1Felkc2ICDsG+NqyvM6CV4uC9G+57Lks1MlWyQyxkScxVUn4ga
         ssasN/9TFA4NQJxqpoEcg7QEX/Qw+zh8UZHn958AIePQq1JXwqncFgCGa4zrdD5C+oWk
         OlaukfCZbXmYJR4FQvEgsfsrKvaAaNsXEY2Zb9kVj6CwloW4uc9Lop8s5NRsZKAEorUx
         Or6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784260014; x=1784864814; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+qfsfSM7+v1WClc9BxhjMt2YlMxMtKRK2E8WppuykZI=;
        b=qdYj+q2EWfrycp3pPsJ+CchD861m7W4DZKe8nqTihfVjt+54usexVwm9bnRRb1NWSK
         mojP4UoNaybtyuILBit3sAseHl+OW9T9ukOC6P+fWqKkxhDl7Du76wvOtXBlcZ1f4R6P
         4idaRD2Yn2KtYn42ZA5nKrGwmDykLXA0mnffL9oed2P48c4WI1WCVXs0aZghEfFxLS+y
         5OlVgUEayX7Pkb7w957zNY+ESWWnQkjNCnyLyqRGNw5GnscjLmFVxDBJmDuhLyxNu4cQ
         dhLo6E5zpWjG7QPzyo+boYPcxzOag6ZYjHLCRZI1fmj8OT1rvzkfOQjk48ybkDLY7mra
         ju8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784260014; x=1784864814;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+qfsfSM7+v1WClc9BxhjMt2YlMxMtKRK2E8WppuykZI=;
        b=j/cfYQ9M1SpUikAjqfe6rtIRVmHm1OOZWnP/udOwAauXTJv2wn/KRIj8Neuc3du2QX
         y2DNL1AA5palJimuW9LQ2vjOt6z64Gqt2mF9ih8EFwlz75990whAEi1DCLVM3oom5CeV
         lxoH/vD5JWcJg/m2SRpR5WdK49AHY3cJBryGxWFofnUKQzWWmhTDIyuRfHKG9/6CxMg7
         pMC9I2nMOtTiLBJa60HUdUa8Serv3EWPCFt1PdN+mEF695BTMcBqnpo1A8Z8vks7hK+K
         UPfaEbQ1m0WuCJuxxk3qQM0IEIwWRETiuKW2+wxweOjih6YB+aeZ7h4HSpMghMvUUZfO
         Hsuw==
X-Forwarded-Encrypted: i=1; AHgh+RqZvFvXOtLtntU61GPPVCiczyQfNIziolH0dWaULNrV0Aqca9vQsYodpV8UF+Bl/UeZv+eQSuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJR7gkfHWp/RXQJ57yKN8KiAbAmoesl70yvwqAVP8oxv9lfHd9
	pxxiK42v8WeEmYoPpKTrfTVInt0t9sZT2NMLNPKixYBHv0mAukVj5YL2OqG02n5fi1fqFlDF2CU
	OP863JfoqU/bNli8Hmu2YZbii+/8SeJo=
X-Gm-Gg: AfdE7ckA/ENfBXTUaBFRZe2RS1un5fdLgqhtsQ7VNaUP+Y5D+rWKr+pcO3U3Xz1xwzV
	CY36IVUmZRIJEsqKTu3BsUcEuUCmXw7NHPSSIpVGqphcP89YLHLbrCTpowELu8A1mG5/mAt73z9
	fJPOucEEAUTAix6J+aifAU2r0j+JNRken2iRCzmGWa2eVLSVNQv/ofHPXGOYCRTRBowtyH/8by+
	x1P36O9LNlYgvlZ8VcF8EA3dlsyvl9CU/XJI183uOPNuquls9eYd7q0K9/V710RKiC4nKdda5OW
	nqw44ytVTcE3vUJd
X-Received: by 2002:a05:6808:14c6:b0:4a4:a693:9d8f with SMTP id
 5614622812f47-4a4d03063fdmr419990b6e.6.1784260013937; Thu, 16 Jul 2026
 20:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-series-vmap-race-fix-v4-0-8c108c4317df@kernel.org> <20260716-series-vmap-race-fix-v4-2-8c108c4317df@kernel.org>
In-Reply-To: <20260716-series-vmap-race-fix-v4-2-8c108c4317df@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 17 Jul 2026 04:46:42 +0100
X-Gm-Features: AUfX_mxBLT37KrDyrNbP0EYWC50r_QKOrJ4iSaMj1OT4QL3-liPKJMNfSVRy2ow
Message-ID: <CA+XhMqzUO49FiC-Oa6VYUt7Wm9RZLH30DhUH2kVn_PBodyZ6dg@mail.gmail.com>
Subject: Re: [PATCH mm-hotfixes v4 2/4] x86/mm/pat: acquire init_mm write lock
 to avoid UAF
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Toshi Kani <toshi.kani@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"Denis V. Lunev" <den@virtuozzo.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jul 2026 at 22:31, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
>
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
>         unsigned long start, addr, end;
>         struct ptdesc *ptdesc, *tmp;
> @@ -442,6 +443,18 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
>         }
>  }
>
> +static void cpa_collapse_large_pages(struct cpa_data *cpa)
> +{
> +       /*
> +        * Take the mmap write lock on init_mm to:
> +        * - Avoid a use-after-free if raced by ptdump (which takes its own
> +        *   write lock on init_mm).
> +        * - Serialise concurrent CPA walkers.
> +        */
> +       scoped_guard(mmap_write_lock, &init_mm)
> +               __cpa_collapse_large_pages(cpa);
> +}
> +
>  static void cpa_flush(struct cpa_data *cpa, int cache)
>  {
>         unsigned int i;
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 6b5c2390cc30..047f5f5e2c34 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -621,6 +621,8 @@ static inline void mmap_read_unlock(struct mm_struct *mm)
>
>  DEFINE_GUARD(mmap_read_lock, struct mm_struct *,
>              mmap_read_lock(_T), mmap_read_unlock(_T))
> +DEFINE_GUARD(mmap_write_lock, struct mm_struct *,
> +            mmap_write_lock(_T), mmap_write_unlock(_T))
>  DEFINE_GUARD_COND(mmap_read_lock, _try, mmap_read_trylock(_T))
>
>  static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
>
> --
> 2.55.0
>

Hi,

This bullet confuses me. __change_page_attr() and friends are serialised by
cpa_lock/pgd_lock and never take init_mm's mmap lock, so this doesn't
exclude them.

Collapse vs collapse looks covered already: collapse_large_pages() holds
pgd_lock across the walk and both collapse_pmd_page()/collapse_pud_page()
calls, and the pmd_leaf()/pud_leaf() early-outs stop a second CPU
re-queueing a collapsed table. I couldn't build the interleaving behind the
cover letter's "could result in memory corruption". Can you spell it out?

If the reason is really Will's v3 point - collapse rounds up to PMD/PUD and
frees tables outside its caller's range, so it has to exclude
walk_kernel_page_table_range() walkers holding the read lock - then say
that. It's a UAF independent of ptdump, and it's why v3's read lock wasn't
enough.

Also: patch 1 justifies the trylock fallback on ptdump being rare, but this
takes the write lock on every set_memory_rox() (BPF JIT, module load,
execmem), even when nothing collapsed. vmap_try_huge_*() then loses the
trylock and quietly falls back to PTEs on every BPF load. No counter, no
trace. Not a blocker and I've no better idea, but fa93b45fd397 was about
getting vmalloc-huge on by default, so it's worth calling out.

Rest looks right. 4/4 restores pud_free_pmd_page() exactly as it was before
fa93b45fd397, and 3/4 builds the same walk init_mm got via
walk_kernel_page_table_range_lockless().

Reviewed-by: David Carlier <devnexen@gmail.com>

Cheers !
