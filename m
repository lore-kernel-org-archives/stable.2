Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0524334C5
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 23:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577780; cv=pass; b=YcbtJD4lUHNWcK32cmVCTJJKpS8yEpkJtNajUrT4hk1URF67tFtdLcl8Pa8oiWmwWHXF1hx+EAuqenMLVdnVEm55kEz0NNprK2aH6lUAWy9Z00o6LofCm0ZvY7HCRUdYomBMF0alnc6K/nsNLUPGcxr6P+mz9czhgWEXNBnRWnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577780; c=relaxed/simple;
	bh=PfNnabqW3QJtRxCUAoPKG6v/jEnHvlCCYIh30p6N+XU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NeouOqc+Ew3+t56CwmzN/imD542cGz1ZyMe3bY6jYR4W/dbGYg/vB18rkbm6WUW7QfPGHZF8zSVcWmf3dfABAAMoQC2wrBgf9S//o0X6Iu+3cH0F82iRoZr28xq6PtLdt5wDqo2k21JKvulAtcMvNjZnNiAIyZdagx+6mqNn+78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iwwj4LeZ; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iwwj4LeZ"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c15a5b265so55891cf.0
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 16:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786577777; cv=none;
        d=google.com; s=arc-20260327;
        b=T24S6p54X2xwD2f8YPIA+3QnbFSNdXObkuBrdEdYg4GPiubZTbu673ug9AaBZQQwpd
         wnb13lyp+NZLszJErTs6OX+QzdmeolwMsEKh0evGDj4ndRDvt2o2c1ti39Gs7cbnXDYQ
         ztfrVhW244L/MNkEOxkr7OujHtpij4N4PtwkIGXXDNHpEd/DnQqbijw3uynatcuPEFeV
         pu3kJGpm7J4CN2dQWBfbIBGFAxIRxNxXiLmaJGZEK4+lv44v6kLdLDpIUlc5w3jwwr18
         SW2N46cqoAUNGC1MU4CR8qYrjGkBv1IM1TM9eodG/7FfQE/DExO8jgoNnYcG7EawYvfY
         yygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yDR5LOVZf0UVA86YVgOsqlNvwhJx7RGcxgggKSkD57o=;
        fh=ds0NktwhD3zhVjW0wT7qDOAcAVtMyki0fQ11+x3zHYY=;
        b=dyan8MO0I7CmVOg9NjsqK25hxb+e2k8Vcn3hgAw5pgLSJoJYD08CjYbAqsNfZMevhu
         xPPaX2VQXsP55RVDKBIwl/bx81YI8kQGPtp/JyxS5klZMd0dQmSqsxpfF/HH1bI3Ow7/
         +4y3yuK2i7cdWdQIx7Zv9JHV7ViK/0oaL3xaDUGH8ljiaD1Gap0yvyvtRbFL+z3vdF+R
         l42yUJWuB/Ag9iIyMQX70HucqzfBVEERcTLqX0pRl6woc6Kk4xEBubguQ3+Gi+qfkv2A
         elJCicgHsjccDuYyeWlPtdK3fZNJhBqNH7W0T80NthlRP0rbCpxaMCz84dk0V61OGj4D
         WJTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786577777; x=1787182577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yDR5LOVZf0UVA86YVgOsqlNvwhJx7RGcxgggKSkD57o=;
        b=iwwj4LeZhEAzsgvSI1yWgPfTHgNeaLoTFbZY54PMAC8NjOu696bh6MHydB+b/wvE2w
         u76+cN2R2TfLjZmW+s06Ji/Ca3JSuAoB4V5pdx6Jybw+zgvxKaZTKrVAMQdE/0nOL3N8
         OBYpUlweMqQOVSt6g18PlN6YgoiUa0KU8xalvFKJMKuprHMjIpqBwY/GHcuDqeEz9ZIn
         USunt+/sDdEVEJGcsJhwnmezEb5ydCDbLvg2iVozqEQZ+lNkrHKlZDWXuUFhoGtEpHEG
         RgJgWZEdP+CitX8z8boHEbKkXrGY/1jbYv0TO2pPAsQrNTPWXft+xNsUM5JEcKaJ0Kzb
         LNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577777; x=1787182577;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yDR5LOVZf0UVA86YVgOsqlNvwhJx7RGcxgggKSkD57o=;
        b=rCIoDYnrQbV4R93BV32/ZzqVs6tkRohlHRkgqX+EQU0pVtzG+iAZK5Zj3yr5joU910
         f+eY2FFd/ZtJpTx9tNSh76UUAmWQ8tOJ7OCh0DYeg1v1usSsnZ/Z16pdB3n7/nnFIbla
         wMuS4RBBkfLteVzrSPJLAfD6c9c1nax+L24EBTqu9PpVxasdMFU5WB/1SixSMSvefOom
         EwUl18es25jVVyMnhKjdkRHxK3aEfacfh9YzdI4Re9kIfXcQHg2gDiBLdpft92Y7dp0n
         SA/hNhnviaskzBJsE44RSy0yYHEnR+uYcqDr1Vd9MVk8wbuIXk4I6ClBlIIdUdzh1noo
         ro8g==
X-Forwarded-Encrypted: i=1; AHgh+RrK12XQRtEgZuDgdbDRvyYhcJnyOziKSBsHL9BCMNboSSi4rSt04hdvuj5B0C0AVHC6eTUwDFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEnpexkO1UNtpFYQKslLILWvcfKCXWhFGddQs1koYwJAPmUoAn
	fHvfXn4OQegAHKPkHkQbUzUgJmQnUYNgOh/GB18NmM4w/7R2voewU+cwydLH6cH8zjGCojSIvMm
	Om4Ht/WZKvPTGiLOuNfqk/eyAxR4n1h/sQUQ23fBC
X-Gm-Gg: AR+sD10+7pikUaECiQdyFfkMQX9X7edEA6ztrjnKdv7p+wgnlFX11EX4EdAiqUYNFQR
	iGoyHerpixOl+HSwY/l0fq6shs7UZ4XbsvCNTPMuDbcy6dNgF6yt3tntwV5QoCoO+3BdI4P09A0
	gMGN1Y/BWa5SBxipbK5SBJUmnP/Q5In1h2TTyYS6zmCmqpXBIcF1Kntbi2pPebR/2TeXGzO8lcm
	bxQjSUomNOuX8MlZpOT0Mo122LnOa0mu2//a3D6NCdZZ9ciLcyBRrlKHCnyvSRBgB2guysnaGKZ
	vWhStsv2imqMZHXa842sxCkKE1oDuYxdw+mAIScenMc=
X-Received: by 2002:a05:622a:5912:b0:519:b82d:fe62 with SMTP id
 d75a77b69052e-52d76dc6002mr1956281cf.7.1786577776667; Wed, 12 Aug 2026
 16:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810071518.115381-1-hao.ge@linux.dev> <20260810071518.115381-3-hao.ge@linux.dev>
 <CAJuCfpFO1=HaN-DVqqpQPHKC9utAMKSCNUNRE3cwi5JvrL-e=w@mail.gmail.com>
In-Reply-To: <CAJuCfpFO1=HaN-DVqqpQPHKC9utAMKSCNUNRE3cwi5JvrL-e=w@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 12 Aug 2026 16:36:03 -0700
X-Gm-Features: AUfX_mxTbA9g0zgCVxBY-XPLoXadtUbyF-b8ygfhYTsz239TtVOz_7EIGhur_ic
Message-ID: <CAJuCfpHZZ7Ui25vW4jBNPdpVAwC3tBpYzLfyDyNLvqBjye=adQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] alloc_tag: fix undetected compressed tag overflow
 when profiling is disabled
To: Hao Ge <hao.ge@linux.dev>
Cc: gehao@kylinos.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 8:49=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Aug 10, 2026 at 12:14=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
> >
> > In reserve_module_tags(), the tag overflow check is gated on
> > mem_alloc_profiling_enabled():
> >
> >     if (mem_alloc_profiling_enabled() && !tags_addressable())
> >
> > If profiling is toggled off at runtime and a module is loaded whose
> > tags exceed the compressed-mode limit, shutdown_mem_profiling() is
> > skipped. vm_module_tags_populate() still maps memory for the tags and
> > the module loads successfully, but the total tag count now exceeds what
> > NR_UNUSED_PAGEFLAG_BITS can address.
> >
> > Once profiling is re-enabled, ref_to_idx() computes each tag's index
> > as its position in the alloc_tag array. update_page_tag_ref() masks
> > it to alloc_tag_ref_mask before storing in page->flags. Indices
> > beyond the mask are truncated and idx_to_ref() resolves them to wrong
> > tags.
> >
> > This silently corrupts /proc/allocinfo: allocated pages get attributed
> > to the wrong call sites, so the statistics it reports are wrong.
> >
> > mem_alloc_profiling_enabled() and mem_profiling_compressed are
> > independent. Once compressed mode is established at boot, it stays
> > active regardless of runtime toggles of mem_profiling.
> >
> > Remove the mem_alloc_profiling_enabled() guard. On overflow, shut down
> > profiling, release the reservation, and return -EAGAIN so that
> > layout_and_allocate() retries with profiling disabled: codetag sections
> > are then placed as regular module data and the module loads without
> > profiling rather than being rejected entirely.
> >
> > Skip percpu counter allocation in load_module() when profiling is
> > disabled, as those counters would never be freed on unload.
>
> The approach looks correct but we need to address Sashiko's findings.
> I'll focus on the pre-existing issues and will post fixes later today
> or tomorrow.

Sorry, I'll need some more time for these. Day job got in the way :/
I'll try to get it done by end of the week.

>
> >
> > Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compre=
ssion")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Hao Ge <hao.ge@linux.dev>
> > ---
> >  kernel/module/main.c | 17 +++++++++++++++--
> >  mm/alloc_tag.c       | 11 ++++++++---
> >  2 files changed, 23 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index 46dd8d25a605..c32bb47a573a 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -2971,13 +2971,26 @@ static struct module *layout_and_allocate(struc=
t load_info *info, int flags)
> >          * this is done generically; there doesn't appear to be any
> >          * special cases for the architectures.
> >          */
> > +retry:
> >         layout_sections(info->mod, info);
> >         layout_symtab(info->mod, info);
> >
> >         /* Allocate and move to the final place */
> >         err =3D move_module(info->mod, info);
> > -       if (err)
> > -               return ERR_PTR(err);
> > +       if (err) {
> > +               if (err !=3D -EAGAIN)
> > +                       return ERR_PTR(err);
> > +               /*
> > +                * -EAGAIN means profiling was disabled but the module
> > +                * can still load without it. Reset state and retry.
> > +                */
> > +               rewrite_section_headers(info, flags);
> > +               for_each_mod_mem_type(type)
> > +                       info->mod->mem[type].size =3D 0;
> > +               info->sechdrs[info->index.sym].sh_flags &=3D ~(unsigned=
 long)SHF_ALLOC;
> > +               info->sechdrs[info->index.str].sh_flags &=3D ~(unsigned=
 long)SHF_ALLOC;
> > +               goto retry;
> > +       }
> >
> >         /* Module has been copied to its final place now: return it. */
> >         mod =3D (void *)info->sechdrs[info->index.mod].sh_addr;
> > diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> > index af44f90379f2..3eba6331174d 100644
> > --- a/mm/alloc_tag.c
> > +++ b/mm/alloc_tag.c
> > @@ -950,10 +950,12 @@ static void *reserve_module_tags(struct module *m=
od, unsigned long size,
> >                 int grow_res;
> >
> >                 module_tags.size =3D offset + size;
> > -               if (mem_alloc_profiling_enabled() && !tags_addressable(=
)) {
> > +               if (!tags_addressable()) {
> >                         shutdown_mem_profiling(true);
> > -                       pr_warn("With module %s there are too many tags=
 to fit in %d page flag bits. Memory allocation profiling is disabled!\n",
> > -                               mod->name, NR_UNUSED_PAGEFLAG_BITS);
> > +                       pr_warn_once("With module %s there are too many=
 tags to fit in %d page flag bits. Memory allocation profiling is disabled!=
\n",
> > +                                    mod->name, NR_UNUSED_PAGEFLAG_BITS=
);
> > +                       release_module_tags(mod, false);
> > +                       return ERR_PTR(-EAGAIN);
> >                 }
> >
> >                 grow_res =3D vm_module_tags_populate();
> > @@ -975,6 +977,9 @@ static int load_module(struct module *mod, struct c=
odetag *start, struct codetag
> >         struct alloc_tag *stop_tag;
> >         struct alloc_tag *tag;
> >
> > +       if (!mem_profiling_support)
> > +               return 0;
> > +
> >         /* percpu counters for core allocations are already statically =
allocated */
> >         if (!mod)
> >                 return 0;
> > --
> > 2.25.1
> >
