Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3CC29B77E
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 05:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786773508; cv=pass; b=YHNFst0oJgGakniWj5TxNY1/ugtwInYxpBtxOHYtxc/g0E+6ElGiVIUcA5jq6OvUR3SCILcZZKmp+AT3jqiwWx0iUDCp8XBbb5LvftWK5gBvCYw6d5d24bG+vCLBMBov4ebPWwIYjq9GKuEZXv1PvrMbI8v/Tz+8b3DvHW8cETc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786773508; c=relaxed/simple;
	bh=MAjFb91ehRZt19IwjNc2zqB7sKvI8LxKr1AycouuNvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2eVmcsft61OvDnh2Q3o/iHXJWAhJ8/jdPK78NR6C4ZO0ZvOaRWuxQyA+QGw4yd2dUmAKdFYL6JT23p8mNeukYDJy1keFkATbMxwPXwroSdv660zdnTmq4SwmOwCtLnb9s6xQ6/jtXCcqnb0rwNhpIsMM8T50hbq1qi13PJCBIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hfj6DVQJ; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hfj6DVQJ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ccdf36f63dso180545ad.0
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 22:58:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786773506; cv=none;
        d=google.com; s=arc-20260327;
        b=K7aLnJ/qETi/85YVkiMRmAO6XBAxKpVYf8Pvh+65EEALAGefnvQGaDdSwzyk8xitjU
         LPVuG5boclNYs0PXU1vcmf4IawaXep5d3FxsK+gZHxmmLTwe3CjQWO/I8p2v9t/RT325
         /ILifHHM9Ca1aOeSSVJ07CnR4uj48hPXyibXrqHO2Sl3I/43bpv9Nk3R89GqxvJo3HnM
         TXlAjQy7Nmdfeikb4UKYzuMDXhCe9reXEW3afw1ROlHT7PAm9DiPvvgmt+9/Xt/E4xPQ
         gqkNOHQBSOuZVUd5Vx/5gbo3kDGJJpR3jt54Y2u7AcgUU/r9eZCbSVxa9SE8b8y74bK0
         J09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GSNHZ1rhCWbjDqMjYrewNRXpE7DLnZyqNYRIuv59LLs=;
        fh=WZjn/7oUC8+W7rIT6tx0AAv6nsQkJn5zJgBziffrsRY=;
        b=TwUlF+eU7RsReE3EXAOMYZhkCJWzHLLQ4EH6iTsA72iugTY6SEgE9D9s4pjonG3vaq
         GK4XJHpI0ZhrRRTwfRqdC39aPmfjAeUOsh/FmdtlvrMqoVTJfxHZLR1IGBk543A+BTxn
         nkAFVFjKtNWjkzGVqVwR70kBUfauTpNM+gdGat4fYGHBnvoTEN8uhYsLc3bjlbSFhEhZ
         Do6m0xrw9OS7jej/8iMndLwO2g5yhE/240ZyXt3UAx0z5AARFDG+PP6mplBND5S9zLEY
         442zXI2wCrRcJ/7aSu24K6LRa1WRP8n0Lg0PfstWcBkojk+7yK+7V3yD1VZb1XjXQ0E9
         1toA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786773506; x=1787378306; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GSNHZ1rhCWbjDqMjYrewNRXpE7DLnZyqNYRIuv59LLs=;
        b=hfj6DVQJAlfvwzocfR3WdlwWy+sIWGGjHr7wAu+TPKjLGjWcOnO5/yaupwxuA0LN5n
         bV5E7Q7uVV79RW/vfwd7mQgHF/cJXl6/mgq7VuMX6uz/b7NbQTigANXb//uLxzO4NoZi
         BOh/fk48zlUBmjE2nRWRGFKzzyh2dt8MnuZqp6j9RVjBo1rCfqH9VwcsCm4i0YcZ5kW0
         Ga4vnVaN8Rw0paWZBFPpG3F47lfiE1NyZ2h2ZS2ySG0iWa1fMp+Y9ikhRnt3fgPRrkTe
         1DS6RNKqDGmu0Xn6I5dzzpKfx4asf3bxZv0OTnJsbKipvoImvfPXds4s5bdi+BGZSpf4
         kDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786773506; x=1787378306;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GSNHZ1rhCWbjDqMjYrewNRXpE7DLnZyqNYRIuv59LLs=;
        b=jHUTkeRpz4QhH9I/271CMjRELi9pv2bepRv8UFynJGG88uk3HOPhavP1QD0yZqw+2K
         O3O2vfpZMjEXxa3O0cyVzUifEeW0ChrZwWI6SqltEm2n+FG06dSYydFxA2UX1bPZeCp2
         rYS5KjDyfKO6bBn6T2DkxzO87HDdddzqgmCmrlbxH7rAA6uOUaj9WFqqjMBTYDvckJxI
         tMRj5FeHGU8gEmfJqQ/zCftIuUIbayaht4aSitUVoAa/XKQeFwRlLKnTsbC5rjYsUVQg
         sRC12HmcPi8dzzShV53RjNgXio0O9sjfVJG6zkRnQOo2Xd4dz5sSlcdIRe6m8cqX+Mjh
         j67w==
X-Forwarded-Encrypted: i=1; AHgh+Rpbeo4LXoG+kTDMdovzcDp8X5ErvZMoAI2pScUkNBd9oNO+ETxPgtkitwIWtjo4ggZr0nQVYgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpqqm6JGrIHNUNFT2KzB9/tiCu+v1PbyZgP3T8Yi78d3WdCdWF
	1rKtaznqjLGe/fZJNyQUN9NpYbcJReFnvTb/QOwHsX/VVLsmWL+JN7icljzso7qMbqdzpoR9LOV
	hIomBBgCAmPSWtiOIsqblT9ufz7pgaVLx2JSg291o
X-Gm-Gg: AR+sD1183mVYAX4B9DKHraU+WLFLQZd5xYcLM3PQ8KzTasbTcha1i8mbn51J7bvnI8N
	sYTizHWVUsXFPXCrqdokThwxfWQTzLuLMpJtIG93itARH8a0CbdbW4b9FF6inIiL+qQd+UJpabF
	sfY8EQFK8kIERXYU+cQuDXJc5Vu1AWiQUNITpkB8u5xubbDJZuQ4Fh/z+43DWDBVJXFyfruUww6
	XoR2lga4bbJZdixnBkwIBHQ69Ru70mqihz7B2iVwUU0KWWPDXRBiR+v2bSPonC9/4Z4ljw7Gfy9
	7uueElaCqrtDUEqVLbfHlJ/SdY2XkwW/tamWqwbeWydqc720cV2GuFM=
X-Received: by 2002:a17:903:3246:b0:2ca:bf8e:360b with SMTP id
 d9443c01a7336-2d3b49010f5mr13153455ad.9.1786773505668; Fri, 14 Aug 2026
 22:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812054105.102637-1-hao.ge@linux.dev> <20260812054105.102637-3-hao.ge@linux.dev>
In-Reply-To: <20260812054105.102637-3-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 14 Aug 2026 22:58:14 -0700
X-Gm-Features: AcwNN1Vv8e8AYIsvCRMSKDbhePjWJ2ljICkt_7vSL2FAbtl9G2kesUL9ji3umuM
Message-ID: <CAJuCfpFvdNFdsKdK2CdF2fNp8gbNgFpoeAiaqp70mpbNGCvk3g@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] alloc_tag: fix undetected compressed tag overflow
 when profiling is disabled
To: Hao Ge <hao.ge@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 10:41=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> In reserve_module_tags(), the tag overflow check is gated on
> mem_alloc_profiling_enabled():
>
>     if (mem_alloc_profiling_enabled() && !tags_addressable())
>
> If profiling is toggled off at runtime and a module is loaded whose
> tags exceed the compressed-mode limit, shutdown_mem_profiling() is
> skipped. vm_module_tags_populate() still maps memory for the tags and
> the module loads successfully, but the total tag count now exceeds what
> NR_UNUSED_PAGEFLAG_BITS can address.
>
> Once profiling is re-enabled, ref_to_idx() computes each tag's index
> as its position in the alloc_tag array. update_page_tag_ref() masks
> it to alloc_tag_ref_mask before storing in page->flags. Indices
> beyond the mask are truncated and idx_to_ref() resolves them to wrong
> tags.
>
> This silently corrupts /proc/allocinfo: allocated pages get attributed
> to the wrong call sites, so the statistics it reports are wrong.
>
> mem_alloc_profiling_enabled() and mem_profiling_compressed are
> independent. Once compressed mode is established at boot, it stays
> active regardless of runtime toggles of mem_profiling.
>
> Remove the mem_alloc_profiling_enabled() guard. On overflow, shut down
> profiling, release the reservation, and return -EAGAIN so that
> layout_and_allocate() retries with profiling disabled: codetag sections
> are then placed as regular module data and the module loads without
> profiling rather than being rejected entirely.
>
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compress=
ion")
> Cc: stable@vger.kernel.org
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

I'm looking at your fixes for pre-existing issues reported by Sashiko
but this patch looks correct to me.

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  kernel/module/main.c | 25 +++++++++++++++++++++++--
>  mm/alloc_tag.c       |  8 +++++---
>  2 files changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 46dd8d25a605..ed26f167be84 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2944,6 +2944,7 @@ static struct module *layout_and_allocate(struct lo=
ad_info *info, int flags)
>  {
>         struct module *mod;
>         int err;
> +       unsigned long frob_size[MOD_MEM_NUM_TYPES];
>
>         /* Allow arches to frob section contents and sizes.  */
>         err =3D module_frob_arch_sections(info->hdr, info->sechdrs,
> @@ -2966,18 +2967,38 @@ static struct module *layout_and_allocate(struct =
load_info *info, int flags)
>          */
>         module_mark_ro_after_init(info->hdr, info->sechdrs, info->secstri=
ngs);
>
> +       /*
> +        * Save the sizes reserved by module_frob_arch_sections() so they=
 can
> +        * be restored if we retry below.
> +        */
> +       for_each_mod_mem_type(type)
> +               frob_size[type] =3D info->mod->mem[type].size;
> +
>         /*
>          * Determine total sizes, and put offsets in sh_entsize.  For now
>          * this is done generically; there doesn't appear to be any
>          * special cases for the architectures.
>          */
> +retry:
>         layout_sections(info->mod, info);
>         layout_symtab(info->mod, info);
>
>         /* Allocate and move to the final place */
>         err =3D move_module(info->mod, info);
> -       if (err)
> -               return ERR_PTR(err);
> +       if (err) {
> +               if (err !=3D -EAGAIN)
> +                       return ERR_PTR(err);
> +               /*
> +                * -EAGAIN means profiling was disabled but the module
> +                * can still load without it. Reset state and retry.
> +                */
> +               rewrite_section_headers(info, flags);
> +               for_each_mod_mem_type(type)
> +                       info->mod->mem[type].size =3D frob_size[type];
> +               info->sechdrs[info->index.sym].sh_flags &=3D ~(unsigned l=
ong)SHF_ALLOC;
> +               info->sechdrs[info->index.str].sh_flags &=3D ~(unsigned l=
ong)SHF_ALLOC;
> +               goto retry;
> +       }
>
>         /* Module has been copied to its final place now: return it. */
>         mod =3D (void *)info->sechdrs[info->index.mod].sh_addr;
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index af44f90379f2..0a7b657fe2de 100644
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
> --
> 2.25.1
>
