Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795208855;
	b=OrPUupnP+52ljs+otu6wfv05F4XBGJxNBXyHlBQreZLpqOHBhQdzOWdc5ZxE9IEbfbSR
	 z6aKRqx0waiBp32ERwGPFtDK5FsuW5WXqso2uR+shRTD87GWr9LpmUdRYlHiJF9I2v5es
	 rZwwEwtK2WPzZMvZFI6RuuxyeAEJmcI8Kw0/Rvsbcl5hlqb8N5Ods1o1O86WAGyLZrBp1
	 7PIuk0iB2WusUpMq/dbrgHg495MoAV/KuhRKJV8JcHP9GEZYlXCZu4kKxUp9Ci8THwZpm
	 1hVVQ1aOo2UdMT1mf4t3f8ALxxIPxoJzzvtGCcHm+SlJO7U5Yy/svrg6mFJIOUsTKzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=23FU4s0qSHIWACezHPWGWY27dHdjz6IS0tWZIdmWGk4=;
	b=Eh5fp4A858v8+FQ7rUk5tomKojW4AGqLBemEfBiqCyRF40Duzvcdg55xTo5xeoNo9/Ph
	 F94Ge38gxX5BQ3cDNueiDcO3neUerpl2+qXSg3Z+nR21kKD1/g2QmuDX0gc3SKa8a3csq
	 jpOAjZufsZB0iB4EsfFpI8n6uWNWYiiMhm4/3yCgceU4z+QsilIFalLUkKEDOJF77cS3a
	 E/QySC6lt70Gsl8UVriMsERIcLDOYKcUWzvAU1xZs0+09acg9gfksnymMzLz/3nHsqnl9
	 MrQhDXqUE0qvNkX/snJmj9unGY1GhasiUWU436uHaiFf5r06K+TyzhPccc+ZAZl+m6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QVSSVXiD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71969606A68B
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 21:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71969606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QVSSVXiD
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-55c7445cf85so14491cf.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 13:07:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795208848; cv=none;
        d=google.com; s=arc-20260327;
        b=KgmCRHpLenBujI6b/GrSyNDS383A0s4Spuap0P3BC8QYRuUzQO3IhyJcG3SXYEotYW
         6gleySKjJhg2dJ+CV1i77QusSf79idUSfDO+HAtb2d3mWdMsmi5sTAMSYSXitqksPiOZ
         fDfJWvQytNZbvDaJX7oH8SotEaIhcqTNgzDdXxx4qtOmBTt97t+LUexZtwdTmskbSjkX
         SB9VAMYVDC2JIYia6/bvoBNT8GwRdVLDyFwodQk+vnLHhH+eZGNDmfY7y7CcS3/iNutG
         +yvs8tfg8k5qkTEnOs7v5ximYrLDYMGSj6m6zgQGQxJkkFFvUfgl/LQEHmeYPLAC+S5T
         IbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=23FU4s0qSHIWACezHPWGWY27dHdjz6IS0tWZIdmWGk4=;
        fh=tgslk8TDFshx++bWSCpY+yY2DQG2BAek+wSfe9tQQGA=;
        b=AyHTIsQvYnjKUjwk/FFk2TrT5lPntpUDaRFl3xbEUKjKwdkH6LPtiuz1nt0WAVzYqG
         s0yjAFLAdp621hWWBbKiIp3mfv/StOmlGLJ/nF+KpiEezjVrZKaOAhJOgR978ftmeKZL
         /ZQfDRI0Vuect9sobgfBt12/nvp9UphJ1ZrP2E76w1hK81kf+Sej8QKiIGY11d+YsE18
         FNM3loPrMQ4s5PPpJxCvnVk4RXgM6tZQ9Y7pBA0ulK0atuhGG3Ge7jUaWcN1pgpJY9Q6
         dyfjTVbLPV8T6bX3iiVZsVhcvrE7HFwFfm2HUU6xdW3Bb/0Vmd6/Y25yedO4pnv32Y/Y
         ZsNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795208848; x=1795813648; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=23FU4s0qSHIWACezHPWGWY27dHdjz6IS0tWZIdmWGk4=;
        b=QVSSVXiDyDh2Dry5QSwH2I9mXhURDvGWpyjjKejatJa0Xl11pQ3eO0nVMo7fUvjFeN
         GhxCvcnH/HCodBc2o8d7K+fJM/oBDdiZNDRxFpVnF3IfWA2+poWOvPct5/foMJbPQkX3
         9BmQ9YhaM8iyIUAmv5O0yT+PmCUdS15ytojUw9IctYnoNvfKd3CTy0X5tQ23gIodYwvV
         6zeHM48NbTSxZ0HBz76NYYYp6zUaFaTB4g8mPz4R5XZpwQ9OCtamHXtAzAFpMnXJWM9s
         MCUoDRi66qvjR/RG7iDgyPvGeRKzz/aFP+3zjCty75qtfVNtMw+OVQby9ZNzaExfmAJF
         KPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795208848; x=1795813648;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=23FU4s0qSHIWACezHPWGWY27dHdjz6IS0tWZIdmWGk4=;
        b=afbX+goYb+cU7EymgKOD3HwZ21+QRMGSBRFDJJmg4vEHTOKqDPFsL9ChhC3PYzp3Ca
         R9WaKuLNfMRMoPsnCFC3l+EZCln8x9JuYAZVc2OWSNBHPXeplSztJxB3nho5IXYFqGd+
         1q+EiJE6DGOs0aBPpPXe9pwOXeZKfprCkVGKb0gHnO8du1qrdMSfrLd8KUqpHzXYNNLI
         EDuaGu+jFPotNtEHh+m97NB2uAb385D9XI6ooDd81qYmXwj7wwgKpFXI6lg744tgeMhu
         LG0EKEOgE0L6zho3LlAiAAY+SnOmA4bP/dYIx3XsYuxGri4NPIn0BpXNdeCo4hg8+IXx
         dFDw==
X-Forwarded-Encrypted: i=1; AL+hErFX8UFsGr9GE/iYYYHeG34jCgHbrnnjiYF9LKoMtsfjrseOLKMfXqvcsD/eflSr9Z6Rin8i8Vk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9p2SySzQFlDXOrHzho4KVl5HZhFsyXx4LOSuejRVrXP3dYR6AC
	W3bfZzBKG7MAUf4rokvwOdW19dgzM/wk4oZ0lvTjZrW5vWnzHgPUJ8US6me34TrDHyTD543IIc8
	yrLyx3Jl4lCaIVELjaFeTJ92sGGJvRBIivjm7G44e
X-Gm-Gg: AYBFou3RBgQEph06SavFQO8K0uj5mvGA9xdO39sBOe7K2QE26qrPrU3NcBREDgLDKdL
	MPGCCBYbZp8c4a+BnntwY1+d7MNQI9FlxvQ93fOAEFVSQapbDL1Z+bjjihlpKoy3Y3bfCe8AQ+3
	dNqYQhkEo7t/LFdbC4I+FF16nVuqBmD4AEJrP3ZtkZulk4X3rGtcVNGJ81uVk9hLk46whrB9nfl
	llYOJOw6wgCHN82kt1gpmp0DvUdjHhi3SLD1RmOtV6OzOWpwTPpe0welSYJS9z9RwlUNWm5obNd
	VDQkLaxLMVSGkBcsIoEvtklY7HlwmaqLKq3J96GAupiVM96GZOiJXJsML9AOmAbvxq1resYQG1i
	BmNSTf4NLbqMQxZqDCkwEWMDM8l7l8fIFwBZAnyeCgzAc53kLQPYupXUvijbqeMAd/2+3ha0uPv
	4QD7xD3zEGR2go0UiG6ueOS18ccqR8upQBUSjlJ8NtrcAdBA==
X-Received: by 2002:a05:622a:c15:b0:530:e335:4ef with SMTP id
 d75a77b69052e-55d88014944mr3653311cf.2.1795208847503; Fri, 20 Nov 2026
 13:07:27 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116071325.263682-1-hao.ge@linux.dev> <20261116071325.263682-2-hao.ge@linux.dev>
 <1020e36e-83bb-407b-8a6b-7669f04c26c3@arm.com>
In-Reply-To: <1020e36e-83bb-407b-8a6b-7669f04c26c3@arm.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 20 Nov 2026 21:07:15 +0000
X-Gm-Features: Aa3M54oHBR0Q2Es3gvoLgXXE93aLU88piHn6n8RQiRkJo_c2VMPM-YJNeTPQZo8
Message-ID: <CAJuCfpHtWJvs4F2L+QCMe9gMJ-qmcj4Q1G4hqVqFe6Z6gPoQ1Q@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] mm/vmalloc: skip cond_resched() in the vmap
 unmap paths when atomic
To: Dev Jain <dev.jain@arm.com>
Cc: Hao Ge <hao.ge@linux.dev>, Uladzislau Rezki <urezki@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 5:02=E2=80=AFAM Dev Jain <dev.jain@arm.com> wrote:
>
>
>
> On 16/11/26 12:43 pm, Hao Ge wrote:
> > The vmap failure paths can be reached with GFP_ATOMIC or GFP_NOWAIT
> > since commit b186a94227b7 ("kmsan: remove hard-coded GFP_KERNEL
> > flags") and commit 8da89ba18ed4 ("mm/vmalloc: handle non-blocking
> > GFP in __vmalloc_area_node()"), so an undo of a partially installed
>
> You mention this commit too, implying that vunmap_range_noflush() can
> be called in atomic context right now, but in this patch in
> vunmap_range_noflush() you pass 'true' unconditionally to
> __vunmap_range_noflush()?
>
> Can you give me the call chain existing in current kernel which makes
> this bug trigger? In case it does not exist but is only triggered when
> you add the rollback code later, then this patch is not fixing a bug.

Yeah, IIUC this is a prep patch for later changes and does not fix any
existing issues, therefore should not have any Fixes tags and should
not be CC'ed to stable.

Other than that LGTM.

>
>
> > mapping may have to run in atomic context, where the cond_resched()
> > in vunmap_pmd_range() cannot schedule.
> >
> > Give __vunmap_range_noflush() and kmsan_vunmap_range_noflush() a
> > can_resched argument and skip the cond_resched() when it is false.
> > The existing callers are on sleepable paths and pass true, so nothing
> > changes for them.
> >
> > Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_pa=
ges_range_noflush()")
> > Cc: stable@vger.kernel.org
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/all/sashiko-outbox-178439@kernel.org/
> > Signed-off-by: Hao Ge <hao.ge@linux.dev>
> > ---
> >  include/linux/kmsan.h |  8 ++++++--
> >  mm/kmsan/hooks.c      | 14 +++++++++-----
> >  mm/vmalloc.c          | 24 ++++++++++++++----------
> >  mm/vmalloc.h          |  3 ++-
> >  4 files changed, 31 insertions(+), 18 deletions(-)
> >
> > diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
> > index 7da9fd506b39..0016c032d1e7 100644
> > --- a/include/linux/kmsan.h
> > +++ b/include/linux/kmsan.h
> > @@ -150,11 +150,14 @@ int __must_check kmsan_vmap_pages_range_noflush(u=
nsigned long start,
> >   * kmsan_vunmap_kernel_range_noflush() - Notify KMSAN about a vunmap.
> >   * @start: start of vunmapped range.
> >   * @end:   end of vunmapped range.
> > + * @can_resched: whether the unmap walk may call cond_resched(); pass
> > + * false from atomic context.
> >   *
> >   * KMSAN unmaps the contiguous metadata ranges created by
> >   * kmsan_map_kernel_range_noflush().
> >   */
> > -void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end=
);
> > +void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end=
,
> > +                             bool can_resched);
> >
> >  /**
> >   * kmsan_ioremap_page_range() - Notify KMSAN about a ioremap_page_rang=
e() call.
> > @@ -355,7 +358,8 @@ static inline int __must_check kmsan_vmap_pages_ran=
ge_noflush(
> >  }
> >
> >  static inline void kmsan_vunmap_range_noflush(unsigned long start,
> > -                                           unsigned long end)
> > +                                           unsigned long end,
> > +                                           bool can_resched)
> >  {
> >  }
> >
> > diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> > index a706666db097..69008b085658 100644
> > --- a/mm/kmsan/hooks.c
> > +++ b/mm/kmsan/hooks.c
> > @@ -136,10 +136,13 @@ static unsigned long vmalloc_origin(unsigned long=
 addr)
> >                                                KMSAN_META_ORIGIN);
> >  }
> >
> > -void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end=
)
> > +void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end=
,
> > +                             bool can_resched)
> >  {
> > -     __vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end)=
);
> > -     __vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end)=
);
> > +     __vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end)=
,
> > +                            can_resched);
> > +     __vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end)=
,
> > +                            can_resched);
> >       flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
> >       flush_cache_vmap(vmalloc_origin(start), vmalloc_origin(end));
> >  }
> > @@ -168,8 +171,9 @@ static void kmsan_iounmap_pages(unsigned long start=
, unsigned long end)
> >               if (origin)
> >                       __free_pages(origin, KMSAN_IOREMAP_META_ORDER);
> >       }
> > -     __vunmap_range_noflush(shadow_start, shadow_end);
> > -     __vunmap_range_noflush(origin_start, origin_end);
> > +     /* ioremap metadata mappings are always GFP_KERNEL, so resched is=
 safe. */
> > +     __vunmap_range_noflush(shadow_start, shadow_end, true);
> > +     __vunmap_range_noflush(origin_start, origin_end, true);
> >       flush_tlb_kernel_range(shadow_start, shadow_end);
> >       flush_tlb_kernel_range(origin_start, origin_end);
> >  }
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index ccaf158c5b7f..3c0d9e69b886 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -429,7 +429,7 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned l=
ong addr, unsigned long end,
> >  }
> >
> >  static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned =
long end,
> > -                          pgtbl_mod_mask *mask)
> > +                          pgtbl_mod_mask *mask, bool can_resched)
> >  {
> >       pmd_t *pmd;
> >       unsigned long next;
> > @@ -451,12 +451,14 @@ static void vunmap_pmd_range(pud_t *pud, unsigned=
 long addr, unsigned long end,
> >                       continue;
> >               vunmap_pte_range(pmd, addr, next, mask);
> >
> > -             cond_resched();
> > +             /* The undo path may run in atomic context. */
> > +             if (can_resched)
> > +                     cond_resched();
> >       } while (pmd++, addr =3D next, addr !=3D end);
> >  }
> >
> >  static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned =
long end,
> > -                          pgtbl_mod_mask *mask)
> > +                          pgtbl_mod_mask *mask, bool can_resched)
> >  {
> >       pud_t *pud;
> >       unsigned long next;
> > @@ -476,12 +478,12 @@ static void vunmap_pud_range(p4d_t *p4d, unsigned=
 long addr, unsigned long end,
> >               }
> >               if (pud_none_or_clear_bad(pud))
> >                       continue;
> > -             vunmap_pmd_range(pud, addr, next, mask);
> > +             vunmap_pmd_range(pud, addr, next, mask, can_resched);
> >       } while (pud++, addr =3D next, addr !=3D end);
> >  }
> >
> >  static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned =
long end,
> > -                          pgtbl_mod_mask *mask)
> > +                          pgtbl_mod_mask *mask, bool can_resched)
> >  {
> >       p4d_t *p4d;
> >       unsigned long next;
> > @@ -496,7 +498,7 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned l=
ong addr, unsigned long end,
> >
> >               if (p4d_none_or_clear_bad(p4d))
> >                       continue;
> > -             vunmap_pud_range(p4d, addr, next, mask);
> > +             vunmap_pud_range(p4d, addr, next, mask, can_resched);
> >       } while (p4d++, addr =3D next, addr !=3D end);
> >  }
> >
> > @@ -512,7 +514,8 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned l=
ong addr, unsigned long end,
> >   *
> >   * This is an internal function only. Do not use outside mm/.
> >   */
> > -void __vunmap_range_noflush(unsigned long start, unsigned long end)
> > +void __vunmap_range_noflush(unsigned long start, unsigned long end,
> > +                         bool can_resched)
> >  {
> >       unsigned long next;
> >       pgd_t *pgd;
> > @@ -527,7 +530,7 @@ void __vunmap_range_noflush(unsigned long start, un=
signed long end)
> >                       mask |=3D PGTBL_PGD_MODIFIED;
> >               if (pgd_none_or_clear_bad(pgd))
> >                       continue;
> > -             vunmap_p4d_range(pgd, addr, next, &mask);
> > +             vunmap_p4d_range(pgd, addr, next, &mask, can_resched);
> >       } while (pgd++, addr =3D next, addr !=3D end);
> >
> >       if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
> > @@ -536,8 +539,9 @@ void __vunmap_range_noflush(unsigned long start, un=
signed long end)
> >
> >  void vunmap_range_noflush(unsigned long start, unsigned long end)
> >  {
> > -     kmsan_vunmap_range_noflush(start, end);
> > -     __vunmap_range_noflush(start, end);
> > +     /* The unmap paths are sleepable, keep the resched point. */
> > +     kmsan_vunmap_range_noflush(start, end, true);
> > +     __vunmap_range_noflush(start, end, true);
> >  }
> >
> >  /**
> > diff --git a/mm/vmalloc.h b/mm/vmalloc.h
> > index d8372a4f65c4..4ec114a75f04 100644
> > --- a/mm/vmalloc.h
> > +++ b/mm/vmalloc.h
> > @@ -44,6 +44,7 @@ int __must_check __vmap_pages_range_noflush(unsigned =
long addr,
> >
> >  void vunmap_range_noflush(unsigned long start, unsigned long end);
> >
> > -void __vunmap_range_noflush(unsigned long start, unsigned long end);
> > +void __vunmap_range_noflush(unsigned long start, unsigned long end,
> > +                         bool can_resched);
> >
> >  #endif /* __MM_VMALLOC_H */
>
