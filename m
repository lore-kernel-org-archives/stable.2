Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6274E222590
	for <stable@vger.kernel.org>; Sun, 16 Aug 2026 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786893410; cv=pass; b=tuqoM/zHE9eM8xfafoUAsZ5lGq3rOnAzu0H2G0OdEGonBxUgRndRdNzA2bTN9HbKvJxpxmVoNhAR2/74C09Ys3qHx2I8BdClUN/7xQWwZJ5nBrXCt512uFPxhMg0r1xGXUwLr9YYWxX1UyVaAb3L2Vj5hCzwTrzW++Ci7R9/n6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786893410; c=relaxed/simple;
	bh=nTQYatXTuo/oI/IsZwKNVXTQE999UX8l9kqBpb11hlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWWm5tVW/r78U4EmTUr/x4248Ht1LdgT4ugpc5y+H1wG7V/wdGU13uhKXnXJSH2hELC+YxWfbDKkDuPPPGzXK3R6iMFK4MkDiPVABvGnEUdT5ZbXuF5tUCGmNVp2UK5v38CZwJiwfbQvt9RHnDGEmk6FsG+v4xX97RRyk2uAgIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iiIyU1XV; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iiIyU1XV"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c10e86e52so479851cf.1
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 08:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786893406; cv=none;
        d=google.com; s=arc-20260327;
        b=M4Mmk92XiYNy1puE9jeeQXMhmmoP1wBKlWF0Uq3OUlVRY4/jfjf8+r8rABBZd6NLpy
         xJQvv2ihge12lGp+kLi6TTGM8y1k0/PB5evO5CvCA3Q5oE1l6LXml7g+X/6loCWcjm2Y
         ARcsHXhXGzuZsQj0+5SdzH0NB9q9GQ12MiiGwiFwJq0H4uPse9f3ZVitwXJWF1KfMFuq
         +HRArks8kvX/Ziz/dUU0vgVB0VRXwW2mO7TJSdrq8XZHKXuWAYyCd0GJKW7EoBq2S03S
         O2zxqFt2OcnyMJa4Cx6xUvQUi1wK/OzuJE7WSU0c5yLhrJk6R1XUJB4S3CcFp1ncUeaV
         Xlfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=paElrpHQlE8g3P6OtIHexotZleQW+QuOt1CzJnnLFjc=;
        fh=4mgAbDKLOpnXiTMbqhCCz8nx8yPAMKgwxz6nlt21hbw=;
        b=WZHw9Msced6K2tZ1w1+nWiIvZRd1ZReWSxVbLKeuIHdKtmmj7tsRyUm8E3+NaHoC6n
         cOJAOGDOpSD7rhNN3ExOQzu+ndtFkIlfUoDknBIbj9Eb+PRZmm4R97moF0NXscTHGOel
         WO7Y2pT7pLpTfdsK9Yx/Ll94kTKop/5MCfRctSkJvTF6uJilyhFrPZiCyKup5n0KiRfZ
         hFdpfu5/b18vLHrrU/BM3Y27lnJ+OmH7U1oy8ZBIWAjFOVnbv2u3GacZJTDFWKQV9uuz
         3LMVkXeaONago3r8waBMb+c2P8UVqWRKSdA1VqegM0HE0Hgy93rt0g50mJqOlKqNFk3t
         A3ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786893406; x=1787498206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=paElrpHQlE8g3P6OtIHexotZleQW+QuOt1CzJnnLFjc=;
        b=iiIyU1XVANX+/lvpdh/C92MD/gI1aZa2VLbw4vkBA5UogzJyi433p9RQxlCpP+8A5M
         smkk0iswmpmYeVXIdzVL5FK3DXhFw4NVPobm5ve+HOTswU/WYrF8GVXuAkCwB8+Vm5Qi
         02XIWvzr/pCuLUAh1uR5E4E64boWSYAeoKHZQrgQIlAvCRZIYH+jLZC/KnrmrhLpEZ8w
         mSLu82zViXgIj7LurCFKcLkQGAKFbGF9bOE2t1KnR8pnbffPVxE62Ncb9+vlBlkBn2cd
         6hoCAzA9ZZ/w4HZkPVWsPV7vCWGe0qpYQpXhONdMDfScysYNsXiar1ZVFipNdPNwRIUt
         D4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786893406; x=1787498206;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=paElrpHQlE8g3P6OtIHexotZleQW+QuOt1CzJnnLFjc=;
        b=M3IaTh9xK8WouhIHnKSthvT2d7xWfDSFvtmWkJEbGc8tXCxS39qnexVb/e1IcinC5b
         pH0pFdq/zivMNSFjlkulmaYpzIkzS1lDQVYMKKgb55rfQMLXEzYaRgYSzI/6etXlC/kq
         AqdX1q1HZnVmg0wskQ8A+OQZQ4nu7OPKSDYLuAZa2Bb6oEEyUM/LyBYsX+V8DvzSb61G
         Lx3BfP+YWPyVP5JXl0FgCnzHlWSNTZDo88EKuucVD3kLLnjoJKwlNdKJRViscbcCYL/S
         ikdtxMQjQ7NsT5mtPKNfVFoJm5AvY24yjKKUUPBYfuoS3+myVfSV5UiBR/H5SnajNecM
         1boA==
X-Forwarded-Encrypted: i=1; AHgh+RrNz7dYbfoyNpAeSEgHQYrn2/3BZjsTZ/D+40B4rIe0krUmk9+nHcahxMJNoYzF7NwS+D33vUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCIVurKTFfxnh/EsD72O+5MuTdjFenYBaLCt3lo12+ci3ys3dR
	xlgtFKDbEIZDllwkTT3Zr2aK0YmIIzoVOuTfPv8u/sIr0KK3NHxyoMfC0YDdMdk/rp/4QMuhiis
	W8SCOoOJUT2aFaLh1Btk2smpjyCAMs8yqKrXlT3s1
X-Gm-Gg: AR+sD11VQMKOMylkHycEEvm7lmpbfnGU2s4gHbKdF1LHEoOcJlQ2S27Jkl2BgSvqeQd
	oZlW8yXbsDnkDFxUzWGyhIL0NVREFRy2ks+8oq/ruTOPsEi+DWcSul/FdbxbOBe+xlfC9yXh2l9
	CA/jJCD6UY6svIw2X4gMzxPTQMHe3IBYx1NwtrM2GoI7OCGWrCLWxlx3b3E7HnGUZk2UT85uUSH
	q7DGnfqwdYUVvocPvk5Locd04kkj5U96JMp19MIFd6cIkkI4NmmYE5TbHsKn850fgYlFQBx2iDT
	dX5WcbS+++H4RBgi3VzEBo+ILBcoqF4pRuzUW4SxDYY=
X-Received: by 2002:a05:622a:291:b0:517:6010:7c71 with SMTP id
 d75a77b69052e-52db07b97ffmr678631cf.4.1786893405340; Sun, 16 Aug 2026
 08:16:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812054105.102637-1-hao.ge@linux.dev> <20260812054105.102637-3-hao.ge@linux.dev>
 <CAJuCfpFvdNFdsKdK2CdF2fNp8gbNgFpoeAiaqp70mpbNGCvk3g@mail.gmail.com> <143a37b5-93a2-4038-8be9-29e13263e743@suse.com>
In-Reply-To: <143a37b5-93a2-4038-8be9-29e13263e743@suse.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 16 Aug 2026 08:16:33 -0700
X-Gm-Features: AcwNN1X1kkHyn9OSKgwwnu-af8eWVC7nq_5zQzZp6a8dGSxkkhZX0C7kT05sApM
Message-ID: <CAJuCfpF1pWqhc+P9zPg8FT_CcdQxRuEpJ2DtYja1BeMXhW7-8Q@mail.gmail.com>
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

On Sat, Aug 15, 2026 at 3:45=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 8/12/26 7:41 AM, Hao Ge wrote:
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
>
> When the described overflow occurs, why should codetag sections be
> placed as regular module data? Will the codetag support use them in any
> way, or do they simply waste space? Is the issue that alloc_hooks()
> creates relocations pointing into .codetag.alloc_tags?

Correct, alloc_hooks() will have references into .codetag.alloc_tags.
With mem_profiling_support=3Dfalse they should technically never be used
but I don't think it's a good idea to skip .codetag.alloc_tags section
allocation and to leave dangling pointers. Also the case described
here is an outlier, so optimizing it would not yield much benefit.

>
> >
> > Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compre=
ssion")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Hao Ge <hao.ge@linux.dev>
> > ---
> >  kernel/module/main.c | 25 +++++++++++++++++++++++--
> >  mm/alloc_tag.c       |  8 +++++---
> >  2 files changed, 28 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index 46dd8d25a605..ed26f167be84 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -2944,6 +2944,7 @@ static struct module *layout_and_allocate(struct =
load_info *info, int flags)
> >  {
> >       struct module *mod;
> >       int err;
> > +     unsigned long frob_size[MOD_MEM_NUM_TYPES];
>
> frob_size is used to store values of module_memory::size, which has type
> `unsigned int`. The types should match.
>
> >
> >       /* Allow arches to frob section contents and sizes.  */
> >       err =3D module_frob_arch_sections(info->hdr, info->sechdrs,
> > @@ -2966,18 +2967,38 @@ static struct module *layout_and_allocate(struc=
t load_info *info, int flags)
> >        */
> >       module_mark_ro_after_init(info->hdr, info->sechdrs, info->secstri=
ngs);
> >
> > +     /*
> > +      * Save the sizes reserved by module_frob_arch_sections() so they=
 can
> > +      * be restored if we retry below.
> > +      */
> > +     for_each_mod_mem_type(type)
> > +             frob_size[type] =3D info->mod->mem[type].size;
> > +
> >       /*
> >        * Determine total sizes, and put offsets in sh_entsize.  For now
> >        * this is done generically; there doesn't appear to be any
> >        * special cases for the architectures.
> >        */
> > +retry:
> >       layout_sections(info->mod, info);
> >       layout_symtab(info->mod, info);
> >
> >       /* Allocate and move to the final place */
> >       err =3D move_module(info->mod, info);
> > -     if (err)
> > -             return ERR_PTR(err);
> > +     if (err) {
> > +             if (err !=3D -EAGAIN)
> > +                     return ERR_PTR(err);
>
> The move_module() logic is non-trivial. -EAGAIN could be returned by
> other code, now or in the future.

That's a good point.

>
> > +             /*
> > +              * -EAGAIN means profiling was disabled but the module
> > +              * can still load without it. Reset state and retry.
> > +              */
> > +             rewrite_section_headers(info, flags);
> > +             for_each_mod_mem_type(type)
> > +                     info->mod->mem[type].size =3D frob_size[type];
> > +             info->sechdrs[info->index.sym].sh_flags &=3D ~(unsigned l=
ong)SHF_ALLOC;
> > +             info->sechdrs[info->index.str].sh_flags &=3D ~(unsigned l=
ong)SHF_ALLOC;
>
> Why is it necessary to reset SHF_ALLOC for .symtab and .strtab here?

I believe layout_symtab() sets that bit and to retry we need to reset
it. But I might be wrong here.

>
> > +             goto retry;
> > +     }
> >
> >       /* Module has been copied to its final place now: return it. */
> >       mod =3D (void *)info->sechdrs[info->index.mod].sh_addr;
>
> I'm not sure this is the best approach. It's complex logic for what
> appears to be an edge case related to a debugging facility. It will have
> the usual problem of error paths not getting enough testing and breaking
> subtly over time.
>
> An alternative could be to reset SHF_ALLOC on the codetag section to
> remove it from further processing and have relocations that point to
> this section resolve to something else. It seems that alloc_hooks_tag()
> could tolerate this, since it only needs to reference the associated
> alloc_tag when mem_alloc_profiling_enabled() is true and that gets
> disabled by reserve_module_tags() on the overflow.

Hmm, yeah if we redirect the references into .codetag.alloc_tags, that
would be much better.

>
> It is also not an ideal approach, but I feel it could be less intrusive
> to the module loader. I can put together a prototype if needed.

If your approach does not cause module loading to fail when we disable
profiling, then that sounds like a good idea. If it's not too much
trouble, could you please send an RFC?

>
> --
> Thanks,
> Petr
