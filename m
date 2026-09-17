Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90FA4DDB5E
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789665953; cv=pass; b=oth424+R8aJCWJaaSGQlU21xfs5CHxFMrVrMIDqZQx448WVL1QCY/6dhtXbXc4MHibI3gg/HWV/NC/GdlTX35muUMWgHD10gWHwGpkfVonaZ/nF1ZDbQ/wikLxY0ULe/GCGBFaAXEG9FFlyAUX/7Rwz0cszF6Spt33M44hBBz9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789665953; c=relaxed/simple;
	bh=ykSGCDC5mG2ODpRQPd0vJL+tlN35Q5hi/KlRm9aqv1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=er1jQs+G7ETp8eViKRVNgZ1iOD/UgCplKdH9m+fBmvYHK92uJXPQJANcDOrYscuhGZ2g83XG5u1qYsFnitaL2rz1wepRppLYi07+ZcxyWo+/w3T/UFehYltNOk7ieEgvGCMw76vj0H04NOlJt/bQWGFnHDxL8onsb8TFRxE6TAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fpieXGNv; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fpieXGNv"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6aa13d8d9d0so605a12.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 10:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789665949; cv=none;
        d=google.com; s=arc-20260327;
        b=eYt5HWnFOh4/ETjV2SenWDRV8HmW/edX57P0oAWO5Hrl+hvozXtQLRFJkGKH4LnGZk
         fuvaCaGNyMDBg2iy4azDALZs0X8LdmwdVaf4dvRV94C9xNwZ+dDO8r94rJe9tYwR9Y0w
         E9VFW84YWjSj9CvAXU5ooZChQnAK/dkkwyFS2/8NVQ14jM1wpZmK3C5X0LRrW33SS9+D
         S70q4NTk1D1IvCPVwA3PbhkKK37V4NeMGSxlrfOOd5PYyauOgq6FWf/dct1ysvza6kg1
         BRE4n/mqttddxjMuW73ms2MJtXzHeduSjbc/C8Q5SUhQXELjlmYEg4PhDIeU5yNL2IzP
         PnbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KsTRDsiQkb6uPtn9uEZQZ4pGk/1dXT9fj39UbJRrdLw=;
        fh=IHl2uxgJNhxu+cS/tzqLdMEWMfqPFxyyAUMqy+l8fAA=;
        b=X2qHsaFxe7QncnsvRwYMDmF1MfDDrsUG46Gz1kuxYGUJnOmxjwLVwJR/e6+4oAOgcU
         3f/lS8CokR8wN/h6HzSc6HuCRnZ2zsTRjCjLFTfdEXBd7o1K6oTvs+HjI1BHMf+DFcb4
         e+LYmu5jfL0TUtSjgKH28ujGsqNobNdWzztirBBGFmYJeD42g5Jp/oh7PEnVS6NTvq+t
         2lOqnDqd20w7yUTxMgc3cro9ceaTPJTzr1Kz75YrKgrg+jQYmwspdjOSuF+MzDg94rMt
         0So5QTH29/yoM5cU7c8ZMCZf1FE+hr8KEMjgeTeyrm7C2eUr9JqxcveYf1baPMM50jBQ
         co6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789665949; x=1790270749; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KsTRDsiQkb6uPtn9uEZQZ4pGk/1dXT9fj39UbJRrdLw=;
        b=fpieXGNv/dpPCIHoM36bpK5baM9EzApt3uxLKii1Yz5JoQ+3tiERLf2PgetveMunjI
         5JrOl90C8iGhRISj/bktHkC5W97XfV13IifKhYajjHJDBZj4vBYqQT/C0QNZzNPWkjUc
         ycQZ8hJzoMsNPS5bibpdvupvX1XZv8/VhiudLve9jlQ8D0RS9gb8hnX3TM30l2DJz15H
         JAtD/5Fr9WN2aB95LUul2mWFr+05WImN0K3+yDF7smf7grSCc2FwutDZICx4k1SpaGf4
         SkgBv9AfD6Dc+ztbYAmamfnt5etJeYf/fS9aUwZKuX7gFyoSW577+mVKLJLrP3DicR24
         /KDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789665949; x=1790270749;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KsTRDsiQkb6uPtn9uEZQZ4pGk/1dXT9fj39UbJRrdLw=;
        b=QJwXhCxG339dJGdBpCsongghD+/VadVXQ+WUy+gwfTuQqXp/AxY5R0xgR10gIMgjot
         26URlZzRnTOQPrReeNYJbzvIRHb7mVVMvHomSHOhUZ4Yanj0SDjKHRYX2zjNYa07ZPlp
         nuoNNXKKWm6Gfu/+O92b21N+pDi+Zt3TVb4201RlU25M3mkRK0/Wdn9CMJ/uuQYvWLKk
         Sf3mDYBpisUXVH2EU42USNAXVEgXycVmveK/kYAYs7oGHKieKRvYcefgXivQTLx+h9Ku
         tH6z5ztVPEEBTne+LA0lXbWzei2KEGd0O2iQvu3ZQq77mHs10lBFIW4qW8EgAKgnzQFd
         PQfw==
X-Forwarded-Encrypted: i=1; AKwUvBwlqxhWGUYvtS+8ESORwZZdkOdHhIdV1cCEKGLkVbhZPFktS/esMwqbSucLLLCwdyNCx+e8Ua0=@vger.kernel.org
X-Gm-Message-State: AFuF++kzQynpt4vwynW0LMngimsJUI+bFwJLrHiSsT2eiXS0eeDgEBkl
	nA5x6tFXIDgi3CeRouZTAVU/8MKsyQtI5Aa/vPy/TawZ5jG0v+aYXCMCkJBxpp6AXfQO+Cdu1xo
	aIj5EXepseGiQQZlejNFqokc+A559YpcwPUfaHj8I
X-Gm-Gg: AYBFou0Fmy7OqKBP9RRgxtOrF8p8MaL4ZzIcCy8tIH7I9gvUZ05CeYv2NV+LED3If97
	stVNiuekGwEu9SkdC8eKoYfUMhGoyky78qnSGzgvzMyaK3QvH2BCnlEC6/dq9K/d4yLCOSq+IfE
	OsgqOk/ITfryDgBvNmvz0uEHJto9Xoe2pYuhny7PAU8Yd5hhsjOfsaLrYLGXge3wNVeQHpp7TOp
	4ZZ26knVTY/ompBVOqtaCE7eLxm0xao/0gLv75V119sE1mJNu+1eOW/hObj4fMmKmwuWjoLyszF
	mqVQq7ymano3qmYTOmnOmNOX4jikj50AO82oqlhsAc0v7MQ5xZ3Vjr92EgGCxHkn1Y4XL9npqR2
	Lch+rcCs=
X-Received: by 2002:a05:6402:c318:b0:6a7:ef71:28e0 with SMTP id
 4fb4d7f45d1cf-6aa4de2f154mr1263a12.0.1789665948368; Thu, 17 Sep 2026 10:25:48
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915070001.113559-1-hao.ge@linux.dev> <20260915070001.113559-4-hao.ge@linux.dev>
In-Reply-To: <20260915070001.113559-4-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 17 Sep 2026 10:25:34 -0700
X-Gm-Features: AcwNN1XYvpWm4JKrRXV9ykFLQYiWSqvvLPav3S2pb3RC8LMV6NkXRBZ6FuHBL-c
Message-ID: <CAJuCfpHz6V0zT5+QkYdQsBzG9kWCFhP+gris2XRrvSu4hHD6Hw@mail.gmail.com>
Subject: Re: [PATCH v10 3/6] module: introduce SH_ENTSIZE_STANDALONE for
 separately allocated sections
To: Hao Ge <hao.ge@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 11:59=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> SHF_ALLOC means, per the ELF spec, that a section occupies memory
> during process execution. Some module sections occupy memory
> outside the regular module layout, for example the percpu section
> with its per-CPU allocations. The loader currently excludes such
> a section from the layout by clearing its SHF_ALLOC, which
> overloads the flag with a loader-internal meaning.
> apply_relocations() needs a special case for the section, and
> find_sec(".data..percpu") returns different results before and
> after layout_and_allocate().
>
> Introduce SH_ENTSIZE_STANDALONE to mark sections with a separate
> allocation. The percpu section is its first user. layout_sections()
> and move_module() skip marked sections, and apply_relocations() goes
> back to testing only SHF_ALLOC. Based on a patch by Petr Pavlu [1].
>
> .data..percpu keeps SHF_ALLOC, so it would now show up under
> /sys/module/*/sections/. The section has one instance per CPU and no
> single address to report, and the entry never existed before, so
> skip it in add_sect_attrs(). add_notes_attrs() indexes its attrs[]
> array and skips it too. No functional change otherwise.

And IIUC no userspace-visible changes too, right?

>
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compress=
ion")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/499bb60c-c6e3-43a3-bd92-95a0567ece5e@su=
se.com/ [1]
> Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/module.h   |  2 ++
>  kernel/module/internal.h |  8 ++++++++
>  kernel/module/kallsyms.c | 13 +++----------
>  kernel/module/main.c     | 32 +++++++++++++++++---------------
>  kernel/module/sysfs.c    | 17 +++++++++++++----
>  5 files changed, 43 insertions(+), 29 deletions(-)
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
> index 061161cc79d9..4c738074a27b 100644
> --- a/kernel/module/internal.h
> +++ b/kernel/module/internal.h
> @@ -29,6 +29,14 @@
>  #define SH_ENTSIZE_TYPE_MASK   ((1UL << SH_ENTSIZE_TYPE_BITS) - 1)
>  #define SH_ENTSIZE_OFFSET_MASK ((1UL << (BITS_PER_LONG - SH_ENTSIZE_TYPE=
_BITS)) - 1)
>
> +/*
> + * Marker for sections with a separate allocation, which are not placed
> + * into mod->mem[].
> + */
> +#define SH_ENTSIZE_STANDALONE                                  \
> +       (((unsigned long)MOD_STANDALONE & SH_ENTSIZE_TYPE_MASK) \
> +        << SH_ENTSIZE_TYPE_SHIFT)
> +
>  /* Maximum number of characters written by module_flags() */
>  #define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
>
> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index f23126d804b2..0dca6d40160e 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
> @@ -76,7 +76,7 @@ static char elf_type(const Elf_Sym *sym, const struct l=
oad_info *info)
>  }
>
>  static bool is_core_symbol(const Elf_Sym *src, const Elf_Shdr *sechdrs,
> -                          unsigned int shnum, unsigned int pcpundx)
> +                          unsigned int shnum)
>  {
>         const Elf_Shdr *sec;
>         enum mod_mem_type type;
> @@ -86,11 +86,6 @@ static bool is_core_symbol(const Elf_Sym *src, const E=
lf_Shdr *sechdrs,
>             !src->st_name)
>                 return false;
>
> -#ifdef CONFIG_KALLSYMS_ALL
> -       if (src->st_shndx =3D=3D pcpundx)
> -               return true;
> -#endif
> -
>         sec =3D sechdrs + src->st_shndx;
>         type =3D sec->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
>         if (!(sec->sh_flags & SHF_ALLOC)
> @@ -131,8 +126,7 @@ void layout_symtab(struct module *mod, struct load_in=
fo *info)
>         /* Compute total space required for the core symbols' strtab. */
>         for (ndst =3D i =3D 0; i < nsrc; i++) {
>                 if (i =3D=3D 0 || is_livepatch_module(mod) ||
> -                   is_core_symbol(src + i, info->sechdrs, info->hdr->e_s=
hnum,
> -                                  info->index.pcpu)) {
> +                   is_core_symbol(src + i, info->sechdrs, info->hdr->e_s=
hnum)) {
>                         strtab_size +=3D strlen(&info->strtab[src[i].st_n=
ame]) + 1;
>                         ndst++;
>                 }
> @@ -199,8 +193,7 @@ void add_kallsyms(struct module *mod, const struct lo=
ad_info *info)
>         for (ndst =3D i =3D 0; i < kallsyms->num_symtab; i++) {
>                 kallsyms->typetab[i] =3D elf_type(src + i, info);
>                 if (i =3D=3D 0 || is_livepatch_module(mod) ||
> -                   is_core_symbol(src + i, info->sechdrs, info->hdr->e_s=
hnum,
> -                                  info->index.pcpu)) {
> +                   is_core_symbol(src + i, info->sechdrs, info->hdr->e_s=
hnum)) {
>                         ssize_t ret;
>
>                         mod->core_kallsyms.typetab[ndst] =3D
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c1b34dc1e89a..ae2678ac7840 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1619,12 +1619,13 @@ static int apply_relocations(struct module *mod, =
const struct load_info *info)
>
>                 /*
>                  * Don't bother with non-allocated sections.
> -                * An exception is the percpu section, which has separate=
 allocations
> -                * for individual CPUs. We relocate the percpu section in=
 the initial
> -                * ELF template and subsequently copy it to the per-CPU d=
estinations.
> +                *
> +                * Note that .data..percpu has separate allocations for
> +                * individual CPUs. We relocate the section in the
> +                * initial ELF template and subsequently copy it to the
> +                * per-CPU destinations.
>                  */
> -               if (!(info->sechdrs[infosec].sh_flags & SHF_ALLOC) &&
> -                   (!infosec || infosec !=3D info->index.pcpu))
> +               if (!(info->sechdrs[infosec].sh_flags & SHF_ALLOC))
>                         continue;
>
>                 if (info->sechdrs[i].sh_flags & SHF_RELA_LIVEPATCH)
> @@ -1715,7 +1716,7 @@ static void __layout_sections(struct module *mod, s=
truct load_info *info, bool i
>
>                         if ((s->sh_flags & masks[m][0]) !=3D masks[m][0]
>                             || (s->sh_flags & masks[m][1])
> -                           || s->sh_entsize !=3D ~0UL
> +                           || s->sh_entsize !=3D ~0UL /* offset or stand=
alone */
>                             || is_init !=3D module_init_layout_section(sn=
ame))
>                                 continue;
>
> @@ -1745,16 +1746,10 @@ static void __layout_sections(struct module *mod,=
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
> @@ -2822,7 +2817,8 @@ static int move_module(struct module *mod, struct l=
oad_info *info)
>                 Elf_Shdr *shdr =3D &info->sechdrs[i];
>                 const char *sname;
>
> -               if (!(shdr->sh_flags & SHF_ALLOC))
> +               if (!(shdr->sh_flags & SHF_ALLOC)
> +                   || shdr->sh_entsize =3D=3D SH_ENTSIZE_STANDALONE)
>                         continue;
>
>                 sname =3D info->secstrings + shdr->sh_name;
> @@ -2954,6 +2950,7 @@ core_param(module_blacklist, module_blacklist, char=
p, 0400);
>  static struct module *layout_and_allocate(struct load_info *info, int fl=
ags)
>  {
>         struct module *mod;
> +       unsigned int i;
>         int err;
>
>         /* Allow arches to frob section contents and sizes.  */
> @@ -2967,8 +2964,13 @@ static struct module *layout_and_allocate(struct l=
oad_info *info, int flags)
>         if (err < 0)
>                 return ERR_PTR(err);
>
> +       /* Repurpose sh_entsize to track where each section is allocated.=
 */
> +       for (i =3D 0; i < info->hdr->e_shnum; i++)
> +               info->sechdrs[i].sh_entsize =3D ~0UL;
> +
>         /* We will do a special allocation for per-cpu sections later. */
> -       info->sechdrs[info->index.pcpu].sh_flags &=3D ~(unsigned long)SHF=
_ALLOC;
> +       if (info->index.pcpu)
> +               info->sechdrs[info->index.pcpu].sh_entsize =3D SH_ENTSIZE=
_STANDALONE;
>
>         /*
>          * Mark relevant sections as SHF_RO_AFTER_INIT so layout_sections=
() can
> diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
> index 01c65d608873..15c6baeb39c4 100644
> --- a/kernel/module/sysfs.c
> +++ b/kernel/module/sysfs.c
> @@ -62,6 +62,15 @@ static void free_sect_attrs(struct module_sect_attrs *=
sect_attrs)
>         kfree(sect_attrs);
>  }
>
> +/*
> + * .data..percpu has a separate allocation per CPU and no single
> + * address to report.
> + */
> +static bool sect_visible(const struct load_info *info, unsigned int i)
> +{
> +       return !sect_empty(&info->sechdrs[i]) && i !=3D info->index.pcpu;
> +}
> +
>  static int add_sect_attrs(struct module *mod, const struct load_info *in=
fo)
>  {
>         struct module_sect_attrs *sect_attrs;
> @@ -72,7 +81,7 @@ static int add_sect_attrs(struct module *mod, const str=
uct load_info *info)
>
>         /* Count loaded sections and allocate structures */
>         for (i =3D 0; i < info->hdr->e_shnum; i++)
> -               if (!sect_empty(&info->sechdrs[i]))
> +               if (sect_visible(info, i))
>                         nloaded++;
>         sect_attrs =3D kzalloc_flex(*sect_attrs, attrs, nloaded);
>         if (!sect_attrs)
> @@ -92,7 +101,7 @@ static int add_sect_attrs(struct module *mod, const st=
ruct load_info *info)
>         for (i =3D 0; i < info->hdr->e_shnum; i++) {
>                 Elf_Shdr *sec =3D &info->sechdrs[i];
>
> -               if (sect_empty(sec))
> +               if (!sect_visible(info, i))
>                         continue;
>                 sysfs_bin_attr_init(sattr);
>                 sattr->attr.name =3D
> @@ -159,7 +168,7 @@ static int add_notes_attrs(struct module *mod, const =
struct load_info *info)
>         /* Count notes sections and allocate structures.  */
>         notes =3D 0;
>         for (i =3D 0; i < info->hdr->e_shnum; i++)
> -               if (!sect_empty(&info->sechdrs[i]) &&
> +               if (sect_visible(info, i) &&
>                     info->sechdrs[i].sh_type =3D=3D SHT_NOTE)
>                         ++notes;
>
> @@ -181,7 +190,7 @@ static int add_notes_attrs(struct module *mod, const =
struct load_info *info)
>
>         nattr =3D &notes_attrs->attrs[0];
>         for (loaded =3D i =3D 0; i < info->hdr->e_shnum; ++i) {
> -               if (sect_empty(&info->sechdrs[i]))
> +               if (!sect_visible(info, i))
>                         continue;
>                 if (info->sechdrs[i].sh_type =3D=3D SHT_NOTE) {
>                         sysfs_bin_attr_init(nattr);
> --
> 2.25.1
>
