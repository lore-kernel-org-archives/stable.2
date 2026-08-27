Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1CC21A453
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787791681; cv=pass; b=FCvFmeQ6RmKD+toAlXZnI0fHJpJ28nvAxP2lxjJGZqWA7dokLC0qnhw9PJBCdQl+2NHbqKWrEJObEZcW/StnTLNt7/k2jlRberuMkePfIbSnRrM+s3E46+BfWcY/yn635K2tuyHBnTh1jl2ROFw4MKcBAxTglGeWWLnABNvlX3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787791681; c=relaxed/simple;
	bh=v22GW5nFHgPU14W8nSIh2G9Ynmyrk8jVy5i5UEboylk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YK75QI8Y7gW8hkV43EQccGbco/rGyzfcNKPtMR4fDYxosbQM3r7Y4gJnSZlPlUnGz7H4vjthNnYRl6JxXRSDotD4kvFnxMbSIxXRcEWpjTa6tyC6qv1NuyUKoxdGxtz1oFA047oSPNcDySLW8R/kKpeNRhM4Zx8wFfxTR01bzZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wQa7WL0C; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQa7WL0C"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-52faa58bff5so13791cf.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 17:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787791679; cv=none;
        d=google.com; s=arc-20260327;
        b=A7UjWpoz1jJTMpGsr/xXAY7ijtXIp2thHGrbbnsuMHifVd4nmApsrRoZBj0G9GXTjf
         vLAzegUlheDy1EO1dL0JODZCSjI/3R0LPXWvMJ15BN3WK6VIlBybeZA7XYjkQFoI5zkT
         M9p547PyfR4DrtbZAr+t9m3KY+Dh/OadFRjIJ0+HUXrj22RAaUjpynFSl/m953GvVhuA
         LOzrMIfnCS9dWeHcJhDZaqMbZeLrgn1QH/b6hmr+6SUJfHwyiqjnDdNGuswkhkCYw6lU
         E0oxqrZwYwfnUdo440JmU/ohrXZIds0Sf4+xH1rTrwlwDsydHGzhv9/9Ti5DppaBsLOj
         BtMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3RZmQlixUCcZAoWs8FseajLNnUbL60FURNfuweUrEtU=;
        fh=2ypieyc7aogkm7+2Rud21DAqFa8WqI01s7tl+C1HCoY=;
        b=OyTNrn7WHP5tVfAmyN2qSKylnrhJYvYB+nzBsdJrgFYhv+D+Isl6KLBac27XAQTKpn
         ozIs2wSNgg0pEzFnpI29POBJX/RybJD/zSfSxCaPPYUjhnddi8DShwunz+Zi9y1WQVGM
         O6z2VyrTx4XVTxFAgn+2fJAzbzurVDU1ijN/rvQ/Hy37ZzYei3AG/uljeAOHIigtFxEW
         sOSzjG4+YSdN2pEHQjty4Tkvx1qFTZueF262tqnXFEtfMOWeAshEImQaZxeimUX/Oi41
         6Xu7JN1+BxsAv9iPfWMzTVKNWp/Kch2gCcjggkUq/aQLhYtmR/Qh4nG+Q8drdjdk4odg
         mxQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787791679; x=1788396479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3RZmQlixUCcZAoWs8FseajLNnUbL60FURNfuweUrEtU=;
        b=wQa7WL0CZ+FkbAtCqJTIUllOwvpqBhv+LaqkjU3FSxKO4IOufUu/LVW7+Cbjvfcy4P
         GiPJyvcA2oNUYMtsSFPda56+AnOhmE2Jx7LvOj6scrLl+GH5JZCDPWqMVbIZ8++YeOYp
         6LA67YPR1J46B5B92BpBzcVU0aghdCh3FOjlGZAlRS2kDzVkrT7c9htaPWLObioaF+Xb
         Lq+IZDa1WLpgcdBgHPJWUhndGU6pk6pKLjFdpUAkaPnwu4cwpR05orule7YnrrhrgDyU
         1w5L3f/Q8sJG3exkot1MDadUkFb6kgLuc5DruswIqowvP4uLIrVi0VeUAma1+V0LVug2
         uYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787791679; x=1788396479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3RZmQlixUCcZAoWs8FseajLNnUbL60FURNfuweUrEtU=;
        b=URGyYB3o+/43iEKlISYDWhhXdXFjyI4tvy7rKdjj+/wDs+kJ+vOEuufiRlO/9SiLZr
         JRRPPyIHSTg8xaU3XvxILpDUKSL0e3JnEmaViF4kU1LBFuvh6fxsIKl1vBFdbELR/wJv
         fOcvdvIWrLuGhGZue/rbV3lv2US5WFX4ezzZ3h6lbS6KWjBaubKtQUXHCKxQXgD/w9es
         60y0SrzJPermF68JDXiYMtGg8DSW0ph53kxEbisN1JoR+ntw5EpAVJTg67L1me3LnQWr
         bgHhhMS7xps9ztyxJnMtHfL+nxgHee4juDQ4RkRMn4H9ZS2ORJq0RqaZzhK3NkB5t8hb
         2vZg==
X-Forwarded-Encrypted: i=1; AHgh+RqYclU0XJ0oCH056tKnp9CgzbdLHvi6EFgSYjReQXVUs6lalj5uuLvT2jvyc7dQVqU3Gm8jkkM=@vger.kernel.org
X-Gm-Message-State: AFuF++nrQ2hOnd+S0L5hjfEy2pvVf/u4QjArFg9bGsSV/mK+caHcgkDo
	jFMF+uPOWO/IniwFOqtlaaZzJj3+szMnfNK1O6LfQbxZpUeEiL6pe1ei9MEJnOIfsMSDjw3axhh
	MApDG2KEfljdUZQCgvEZboB0u1kcZuubATraZ5NSa
X-Gm-Gg: AR+sD12NEvIsnS4wAEy4PdQ4oemd0CQB/6B2vT0uXwtIoNNd9EjEGTF2Hrfcz70Uu8/
	i2rY2n0fjydP2+yalfSv/rwPKEONR08rEfaAhAfkKRrmZzVMzGN8z3svG2Xr9rGKU+qERuRCDGK
	4nlgFsi9EV1pm2oOBIevsW3ydmo5ZnHXam9lQnMkSxExUhuU1j7ldYvcaNi86OPdta5I+HHITLk
	SdwgKlKXuDO9nzsnFlqHo3dlyIswgQYMo13f0NLgNb8DgDGw0KRHWF/Fo62oEm24Odi21GLa9ia
	3pCDI85vhymIpiphEBbak/KskPMe3xAfaOdqCxyU2BY4n1PZzUNqAw==
X-Received: by 2002:ac8:5a8e:0:b0:519:b82d:fe62 with SMTP id
 d75a77b69052e-52fa6597314mr3597551cf.7.1787791677524; Wed, 26 Aug 2026
 17:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812054105.102637-1-hao.ge@linux.dev> <20260812054105.102637-3-hao.ge@linux.dev>
 <CAJuCfpFvdNFdsKdK2CdF2fNp8gbNgFpoeAiaqp70mpbNGCvk3g@mail.gmail.com>
 <143a37b5-93a2-4038-8be9-29e13263e743@suse.com> <CAJuCfpF1pWqhc+P9zPg8FT_CcdQxRuEpJ2DtYja1BeMXhW7-8Q@mail.gmail.com>
 <499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse.com>
In-Reply-To: <499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 26 Aug 2026 17:47:46 -0700
X-Gm-Features: AcwNN1XT-rcdo_XETSjod6HErreezxHNaJvrkrMwvUtAwfNAjQo_hdUi2H_bXu0
Message-ID: <CAJuCfpE7tSXOOfDVUpOp-jKyyw0vXUk6Q7MFxOVoYULXmh8GjA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] alloc_tag: fix undetected compressed tag overflow
 when profiling is disabled
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Hao Ge <hao.ge@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 1:32=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 8/16/26 5:16 PM, Suren Baghdasaryan wrote:
> > On Sat, Aug 15, 2026 at 3:45=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com=
> wrote:
> >> On 8/12/26 7:41 AM, Hao Ge wrote:
> >>> In reserve_module_tags(), the tag overflow check is gated on
> >>> mem_alloc_profiling_enabled():
> >>>
> >>>     if (mem_alloc_profiling_enabled() && !tags_addressable())
> >>>
> >>> If profiling is toggled off at runtime and a module is loaded whose
> >>> tags exceed the compressed-mode limit, shutdown_mem_profiling() is
> >>> skipped. vm_module_tags_populate() still maps memory for the tags and
> >>> the module loads successfully, but the total tag count now exceeds wh=
at
> >>> NR_UNUSED_PAGEFLAG_BITS can address.
> >>>
> >>> Once profiling is re-enabled, ref_to_idx() computes each tag's index
> >>> as its position in the alloc_tag array. update_page_tag_ref() masks
> >>> it to alloc_tag_ref_mask before storing in page->flags. Indices
> >>> beyond the mask are truncated and idx_to_ref() resolves them to wrong
> >>> tags.
> >>>
> >>> This silently corrupts /proc/allocinfo: allocated pages get attribute=
d
> >>> to the wrong call sites, so the statistics it reports are wrong.
> >>>
> >>> mem_alloc_profiling_enabled() and mem_profiling_compressed are
> >>> independent. Once compressed mode is established at boot, it stays
> >>> active regardless of runtime toggles of mem_profiling.
> >>>
> >>> Remove the mem_alloc_profiling_enabled() guard. On overflow, shut dow=
n
> >>> profiling, release the reservation, and return -EAGAIN so that
> >>> layout_and_allocate() retries with profiling disabled: codetag sectio=
ns
> >>> are then placed as regular module data and the module loads without
> >>> profiling rather than being rejected entirely.
> >>
> >> When the described overflow occurs, why should codetag sections be
> >> placed as regular module data? Will the codetag support use them in an=
y
> >> way, or do they simply waste space? Is the issue that alloc_hooks()
> >> creates relocations pointing into .codetag.alloc_tags?
> >
> > Correct, alloc_hooks() will have references into .codetag.alloc_tags.
> > With mem_profiling_support=3Dfalse they should technically never be use=
d
> > but I don't think it's a good idea to skip .codetag.alloc_tags section
> > allocation and to leave dangling pointers. Also the case described
> > here is an outlier, so optimizing it would not yield much benefit.
> >
> [...]
> >> I'm not sure this is the best approach. It's complex logic for what
> >> appears to be an edge case related to a debugging facility. It will ha=
ve
> >> the usual problem of error paths not getting enough testing and breaki=
ng
> >> subtly over time.
> >>
> >> An alternative could be to reset SHF_ALLOC on the codetag section to
> >> remove it from further processing and have relocations that point to
> >> this section resolve to something else. It seems that alloc_hooks_tag(=
)
> >> could tolerate this, since it only needs to reference the associated
> >> alloc_tag when mem_alloc_profiling_enabled() is true and that gets
> >> disabled by reserve_module_tags() on the overflow.
> >
> > Hmm, yeah if we redirect the references into .codetag.alloc_tags, that
> > would be much better.
> >
> >>
> >> It is also not an ideal approach, but I feel it could be less intrusiv=
e
> >> to the module loader. I can put together a prototype if needed.
> >
> > If your approach does not cause module loading to fail when we disable
> > profiling, then that sounds like a good idea. If it's not too much
> > trouble, could you please send an RFC?
>
> The alternative approach I mentioned unfortunately doesn't work well,
> since redirecting all relocations against .codetag.alloc_tag to
> a different destination is nontrivial. It would require introducing
> something like frob_relocation() that is called from each
> architecture-specific apply_relocate()/apply_relocate_add() after the
> addend has been decoded.
>
> Another option I realized is to change the order in which module
> sections are allocated. Rather than interleaving the allocation of
> codetag and regular sections, the module loader could first try to
> allocate codetag sections and then allocate regular sections. If
> allocation of a codetag section fails, it can naturally fall back to
> being treated as a regular section. This avoids retrying the allocation
> process, which I would prefer to avoid.
>
> A prototype is below.

Thanks for following up on this, Petr!
At first glance, this seems like a much cleaner approach. But it's
also a sizable change, so it will need some testing. I'll try to run
some test scenarios over the weekend.

>
> --
> Thanks,
> Petr
>
>
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 96cc98568eea..0c6f32ddcbf2 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -325,6 +325,8 @@ enum mod_mem_type {
>         MOD_INIT_RODATA,
>
>         MOD_MEM_NUM_TYPES,
> +
> +       MOD_STANDALONE =3D -2,
>         MOD_INVALID =3D -1,
>  };
>
> diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> index 061161cc79d9..217bb540e361 100644
> --- a/kernel/module/internal.h
> +++ b/kernel/module/internal.h
> @@ -29,6 +29,10 @@
>  #define SH_ENTSIZE_TYPE_MASK   ((1UL << SH_ENTSIZE_TYPE_BITS) - 1)
>  #define SH_ENTSIZE_OFFSET_MASK ((1UL << (BITS_PER_LONG - SH_ENTSIZE_TYPE=
_BITS)) - 1)
>
> +#define SH_ENTSIZE_STANDALONE                                  \
> +       (((unsigned long)MOD_STANDALONE & SH_ENTSIZE_TYPE_MASK) \
> +        << SH_ENTSIZE_TYPE_SHIFT)
> +
>  /* Maximum number of characters written by module_flags() */
>  #define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
>
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d0e1e0bd2ad0..a86ae8774cd0 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1624,7 +1624,7 @@ static int apply_relocations(struct module *mod, co=
nst struct load_info *info)
>                  * ELF template and subsequently copy it to the per-CPU d=
estinations.
>                  */
>                 if (!(info->sechdrs[infosec].sh_flags & SHF_ALLOC) &&
> -                   (!infosec || infosec !=3D info->index.pcpu))
> +                   info->sechdrs[infosec].sh_entsize !=3D SH_ENTSIZE_STA=
NDALONE)
>                         continue;
>
>                 if (info->sechdrs[i].sh_flags & SHF_RELA_LIVEPATCH)
> @@ -1722,20 +1722,6 @@ static void __layout_sections(struct module *mod, =
struct load_info *info, bool i
>                         if (WARN_ON_ONCE(type =3D=3D MOD_INVALID))
>                                 continue;
>
> -                       /*
> -                        * Do not allocate codetag memory as we load it i=
nto
> -                        * preallocated contiguous memory.
> -                        */
> -                       if (codetag_needs_module_section(mod, sname, s->s=
h_size)) {
> -                               /*
> -                                * s->sh_entsize won't be used but popula=
te the
> -                                * type field to avoid confusion.
> -                                */
> -                               s->sh_entsize =3D ((unsigned long)(type) =
& SH_ENTSIZE_TYPE_MASK)
> -                                               << SH_ENTSIZE_TYPE_SHIFT;
> -                               continue;
> -                       }
> -
>                         s->sh_entsize =3D module_get_offset_and_type(mod,=
 type, s, i);
>                         pr_debug("\t%s\n", sname);
>                 }
> @@ -1745,16 +1731,10 @@ static void __layout_sections(struct module *mod,=
 struct load_info *info, bool i
>  /*
>   * Lay out the SHF_ALLOC sections in a way not dissimilar to how ld
>   * might -- code, read-only data, read-write data, small data.  Tally
> - * sizes, and place the offsets into sh_entsize fields: high bit means i=
t
> - * belongs in init.
> + * sizes, and place the offsets into sh_entsize fields.
>   */
>  static void layout_sections(struct module *mod, struct load_info *info)
>  {
> -       unsigned int i;
> -
> -       for (i =3D 0; i < info->hdr->e_shnum; i++)
> -               info->sechdrs[i].sh_entsize =3D ~0UL;
> -
>         pr_debug("Core section allocation order for %s:\n", mod->name);
>         __layout_sections(mod, info, false);
>
> @@ -2800,7 +2780,6 @@ static int move_module(struct module *mod, struct l=
oad_info *info)
>  {
>         int i, ret;
>         enum mod_mem_type t =3D MOD_MEM_NUM_TYPES;
> -       bool codetag_section_found =3D false;
>
>         for_each_mod_mem_type(type) {
>                 if (!mod->mem[type].size) {
> @@ -2818,36 +2797,14 @@ static int move_module(struct module *mod, struct=
 load_info *info)
>         /* Transfer each section which specifies SHF_ALLOC */
>         pr_debug("Final section addresses for %s:\n", mod->name);
>         for (i =3D 0; i < info->hdr->e_shnum; i++) {
> -               void *dest;
>                 Elf_Shdr *shdr =3D &info->sechdrs[i];
> -               const char *sname;
> +               void *dest;
>
>                 if (!(shdr->sh_flags & SHF_ALLOC))
>                         continue;
>
> -               sname =3D info->secstrings + shdr->sh_name;
> -               /*
> -                * Load codetag sections separately as they might still b=
e used
> -                * after module unload.
> -                */
> -               if (codetag_needs_module_section(mod, sname, shdr->sh_siz=
e)) {
> -                       dest =3D codetag_alloc_module_section(mod, sname,=
 shdr->sh_size,
> -                                       arch_mod_section_prepend(mod, i),=
 shdr->sh_addralign);
> -                       if (WARN_ON(!dest)) {
> -                               ret =3D -EINVAL;
> -                               goto out_err;
> -                       }
> -                       if (IS_ERR(dest)) {
> -                               ret =3D PTR_ERR(dest);
> -                               goto out_err;
> -                       }
> -                       codetag_section_found =3D true;
> -               } else {
> -                       enum mod_mem_type type =3D shdr->sh_entsize >> SH=
_ENTSIZE_TYPE_SHIFT;
> -                       unsigned long offset =3D shdr->sh_entsize & SH_EN=
TSIZE_OFFSET_MASK;
> -
> -                       dest =3D mod->mem[type].base + offset;
> -               }
> +               dest =3D mod->mem[shdr->sh_entsize >> SH_ENTSIZE_TYPE_SHI=
FT].base +
> +                      (shdr->sh_entsize & SH_ENTSIZE_OFFSET_MASK);
>
>                 if (shdr->sh_type !=3D SHT_NOBITS) {
>                         /*
> @@ -2879,8 +2836,6 @@ static int move_module(struct module *mod, struct l=
oad_info *info)
>         module_memory_restore_rox(mod);
>         while (t--)
>                 module_memory_free(mod, t);
> -       if (codetag_section_found)
> -               codetag_free_module_sections(mod);
>
>         return ret;
>  }
> @@ -2951,9 +2906,47 @@ static bool blacklisted(const char *module_name)
>  }
>  core_param(module_blacklist, module_blacklist, charp, 0400);
>
> +/*
> + * Allocate codetag sections separately. They are loaded into preallocat=
ed
> + * contiguous memory because they may still be used after the module is
> + * unloaded.
> + *
> + * If the separate allocation overflows and fails, allocate the section =
normally
> + * so that the module can still be loaded.
> + */
> +static void allocate_codetag_sections(struct load_info *info)
> +{
> +       for (unsigned int i =3D 1; i < info->hdr->e_shnum; i++) {
> +               Elf_Shdr *shdr =3D &info->sechdrs[i];
> +               const char *sname =3D info->secstrings + shdr->sh_name;
> +               void *dest;
> +
> +               if (!(shdr->sh_flags & SHF_ALLOC) ||
> +                   !codetag_needs_module_section(info->mod, sname,
> +                                                 shdr->sh_size))
> +                       continue;
> +
> +               dest =3D codetag_alloc_module_section(
> +                       info->mod, sname, shdr->sh_size,
> +                       arch_mod_section_prepend(info->mod, i),
> +                       shdr->sh_addralign);
> +               if (WARN_ON(!dest) || IS_ERR(dest)) {
> +                       /* Allocate the section as a regular section. */
> +                       continue;
> +               }
> +
> +               if (shdr->sh_type !=3D SHT_NOBITS)
> +                       memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size=
);
> +               shdr->sh_addr =3D (unsigned long)dest;
> +               shdr->sh_flags &=3D ~(unsigned long)SHF_ALLOC;
> +               shdr->sh_entsize =3D SH_ENTSIZE_STANDALONE;
> +       }
> +}
> +
>  static struct module *layout_and_allocate(struct load_info *info, int fl=
ags)
>  {
>         struct module *mod;
> +       unsigned int i;
>         int err;
>
>         /* Allow arches to frob section contents and sizes.  */
> @@ -2967,9 +2960,6 @@ static struct module *layout_and_allocate(struct lo=
ad_info *info, int flags)
>         if (err < 0)
>                 return ERR_PTR(err);
>
> -       /* We will do a special allocation for per-cpu sections later. */
> -       info->sechdrs[info->index.pcpu].sh_flags &=3D ~(unsigned long)SHF=
_ALLOC;
> -
>         /*
>          * Mark relevant sections as SHF_RO_AFTER_INIT so layout_sections=
() can
>          * put them in the right place.
> @@ -2977,18 +2967,27 @@ static struct module *layout_and_allocate(struct =
load_info *info, int flags)
>          */
>         module_mark_ro_after_init(info->hdr, info->sechdrs, info->secstri=
ngs);
>
> -       /*
> -        * Determine total sizes, and put offsets in sh_entsize.  For now
> -        * this is done generically; there doesn't appear to be any
> -        * special cases for the architectures.
> -        */
> +       /* Repurpose sh_entsize to track where each section is allocated.=
 */
> +       for (i =3D 0; i < info->hdr->e_shnum; i++)
> +               info->sechdrs[i].sh_entsize =3D ~0UL;
> +
> +       /* We will do a special allocation for per-cpu sections later. */
> +       info->sechdrs[info->index.pcpu].sh_flags &=3D ~(unsigned long)SHF=
_ALLOC;
> +       info->sechdrs[info->index.pcpu].sh_entsize =3D SH_ENTSIZE_STANDAL=
ONE;
> +
> +       /* Allow codetag sections to be allocated separately first. */
> +       allocate_codetag_sections(info);
> +
> +       /* Determine total sizes and put offsets in sh_entsize. */
>         layout_sections(info->mod, info);
>         layout_symtab(info->mod, info);
>
>         /* Allocate and move to the final place */
>         err =3D move_module(info->mod, info);
> -       if (err)
> +       if (err) {
> +               codetag_free_module_sections(mod);
>                 return ERR_PTR(err);
> +       }
>
>         /* Module has been copied to its final place now: return it. */
>         mod =3D (void *)info->sechdrs[info->index.mod].sh_addr;
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 2070e682fe10..112a014d4b89 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -950,10 +950,12 @@ static void *reserve_module_tags(struct module *mod=
, unsigned long size,
>                 int grow_res;
>
>                 module_tags.size =3D offset + size;
> -               if (mem_alloc_profiling_enabled() && !tags_addressable())=
 {
> +               if (!tags_addressable()) {
>                         shutdown_mem_profiling(true);
> -                       pr_warn("With module %s there are too many tags t=
o fit in %d page flag bits. Memory allocation profiling is disabled!\n",
> -                               mod->name, NR_UNUSED_PAGEFLAG_BITS);
> +                       pr_warn_once("With module %s there are too many t=
ags to fit in %d page flag bits. Memory allocation profiling is disabled!\n=
",
> +                                    mod->name, NR_UNUSED_PAGEFLAG_BITS);
> +                       release_module_tags(mod, false);
> +                       return ERR_PTR(-EAGAIN);
>                 }
>
>                 grow_res =3D vm_module_tags_populate();
