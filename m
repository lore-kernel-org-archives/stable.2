Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FE135CB91
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585654; cv=pass; b=mTxmncul3+s8C4VXZaPoUOkMjlH9ZAGpVM95G5zUiK5FjpiJ+dMoCA0PylIAzZZy3S7YEuatU40nZMAvrWaDRPIZgL6wW/7jD1oIqG1TVGbXokiLSz9/mlk6sy/10g2k3d/XkRoWI2hc9F1O9kqPRbOmLL058YP091pS/xRthDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585654; c=relaxed/simple;
	bh=KPU7IzR69Ng/j6m8YHFvvjb5SqAkfnaH0qbM64QKGw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8PUbMlN7oBmZAuIWbhF5/mNqi7feC7A/whc0WEjKdwemxzmZPlIhhSrlipfzKd4lTQrkWSnlkpOSChqxg5QS25cOsWc7WkPeK90pIz7qsfMGQD2Jdk+Qpfkiif0LPJX20AwT5H+sd9JZ1ZPc02Zd3yQwp3Avwnk4bkwjAGxXPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CMnwcelI; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CMnwcelI"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530d5fc2cd8so7051cf.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 12:07:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789585635; cv=none;
        d=google.com; s=arc-20260327;
        b=Dqj4Ell08Gvk6XQDWs7w71HOiCLQLp84Mpzo/KNpccqXDl++woD57wVCIUAD7pTTLW
         ewfd+2DPO2gVXvnqAxWglUlAEnqIdhZ31k4hQTIhwxTQzPh5izvJUFDg3i8pXD6XWX5y
         YyQQcgi7PgVbuq1sWKjfMXjFf++nOvECha8iQ3PEm1E3ajdZw80PtO3A4x7Vm+y11VPU
         nids4VMB+MOIPMqrLc2MBDHJMDIhmWRL1hzjJXUAaDyIi0nuHlebgqsKY/WBeVkYDL8t
         fRS2R/pjCV/ZnStegPbiYk1IM9Fdye6WyJmF5ZNWV1OStE80nZObhYpUTJa4Fq1UjhP2
         +CUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yHbOQrPgVkpK3KZeBIodImpdgvuoykZQvSNB9/nSIAA=;
        fh=3DFXAnsKddIS6PHnz/9D8zqlQ6GyXVcVilMAQm12G94=;
        b=kBxlf2SnnU/oXQW1gHV08brtbuf8sxnb5gY9fkHdzssWOHgTCsqSZcaiGNGLGHIiLI
         65ueDAbMFSyZ+Vf3S1FZoEobSK8zH1N1fWtjfqDjt32afWTTlQ4K0pLAQrEsE1Jt2V6h
         Wo952v0hS2jlRv36QvW4AOtlubHbUstf7nOiHkHeGSpZD87uIyRIUdLwirnbpsSrtqev
         nWNj6322issekf5ojEg3vWLu6sJMYtUxzkU52i/6aEPpKiSkkgldbYlO6ln/JukekTBa
         kfbKAcJUqkMVKWQfpyxcJ9YWcrJMPPw4nFrCyEEw7CuyQsgGyouPCpQz3JC9tgrARJcP
         8zJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789585635; x=1790190435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yHbOQrPgVkpK3KZeBIodImpdgvuoykZQvSNB9/nSIAA=;
        b=CMnwcelIDyTuiaLuMFiKWIa46IsxWJ4KWE9fsZXIAQSidAShgdI/KaW/IVr7HtoC2S
         0vZDyOvkUTEsb+tvmR6ABoA7KdFaUhVVSJGcQNs4asTkCGd6EG02plpR32tBIT+kHQmk
         SSFEsgciRvORBxi1Rn2bSrxwANGb/aFprTORpICWh0L0M41AUYVeFTxSVeEHjLi8CQrI
         azO40xSF15FI6YZJyksiuxIKWRnWY4Tm69IKkbGZjfofxlDCLxAoLNlBj5HxVN166FKB
         w7juyQjYBlR8Bn546PFYQa4wAEY96rjQHZYe+51sl+pyEfpamHPuqtYdPZOnWnkJgNQ8
         ODjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789585635; x=1790190435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yHbOQrPgVkpK3KZeBIodImpdgvuoykZQvSNB9/nSIAA=;
        b=dtI/YSjN8Gdy57N97E/winna10fgW5yiFDVOwZzhqrh54EQFdGKp4xOQSxtz7MT2Lz
         4yQ7jg22d/PdOWVZAGG9/2A04aAbCxSqVVwgm+Sk5xzcFoXtAn3jsS18RxWkGB46DiRA
         unD0BvagxRCA3h/ketgU/Rw4CLRIhD4TQ8dvTYZCpsILmpRa1fBIizeSo1K/lA2m3o2R
         UGECRNgSzcs17lNLhotMFAY0bJZG4f87wBpqfCLFO8ItI1k86wZMXy6lZ5JKLxygoo1V
         0xoKeJ2VS/Z2B0r41kUavu0UjuoXpGaxZZWgQ6qoOTN9cWxf+htdcTeTh1DL3FHn8d+V
         lMIw==
X-Forwarded-Encrypted: i=1; AKwUvBw8GtxDgHJrjjGLAy/9zxR/2Bbqp/WCAM1SnpQqnHluZ6ZfeiMw1x/QHEdjuPLSaqewzrnRa6I=@vger.kernel.org
X-Gm-Message-State: AFuF++lyNvXm9CDOBDUDPT2xJXIR3H6k2zwQxP4Pv7ybRwFhRDVGqBt6
	4Hndok7qIygTxZWzex+FNrP05cRuEadJcRgfaTsGrJrQ7Dyf2dVL+qRtYLqK2RPYIYS/D0LX6T7
	2v5mnEy7aUKb/eUrVcBjrxrhTIF/Mbt1iOITgJNYK
X-Gm-Gg: AYBFou15CQ4NaF1HRtSh9n9jmWHMGeVfEMT9wQec3e5Jir3rLa8cYvQ+/sopOR53hGe
	K9wOeVNwDE/O+pTvOFt5rlpZcLtCaKuJx6LgPIdyq3PuF0gWt++i233VVId+0nakfILPer02ik7
	O/IKJ8nXZlVsnh/MPGZxCvXOskGShFFsUNcJrNnlqwNT1MPwCRmDMNqBMenAJwR3iAa1gpe3YvI
	p61D6QdhbmCsCNibVd+cvvGCJ+0vwHR7ZLL/SvDuTP3Mn4f95U5tQYFhplGiNM3aKNk6mAU03EG
	MqVOvTdIImu0wkKByeJJ5elVp8hbK2owbOt9Mmy4cYd/Opq7PjZZB1EbO4A5ktbdyK8+SGM7nTs
	VNMNHJ9wJyQ==
X-Received: by 2002:ac8:5d10:0:b0:532:858d:e791 with SMTP id
 d75a77b69052e-5328dc0bc4fmr2243931cf.8.1789585634800; Wed, 16 Sep 2026
 12:07:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915070001.113559-1-hao.ge@linux.dev> <20260915070001.113559-3-hao.ge@linux.dev>
 <CAJuCfpHJSwNhgotMVpmjVvdv=m52_7Kvzpztf0WcN0AaoSeGGw@mail.gmail.com>
 <60642a7f-2949-428a-8290-40d69c989a77@linux.dev> <CAJuCfpG3d7n=z5WnUQYZsqvrt1pemF8TFvGiGyZGLO7ykVvqAQ@mail.gmail.com>
In-Reply-To: <CAJuCfpG3d7n=z5WnUQYZsqvrt1pemF8TFvGiGyZGLO7ykVvqAQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 16 Sep 2026 12:07:03 -0700
X-Gm-Features: AcwNN1U77eJFNHkPfe6Ppe6tyXfOBb0DKmw4ydlFrQQ2j_8G2MzMCljaOX2F-Do
Message-ID: <CAJuCfpGeRdFY6UPF-vXxwHvP2+tN=BKgRkmLR3PMLuWhxgzPRA@mail.gmail.com>
Subject: Re: [PATCH v10 2/6] alloc_tag: clean up the populate failure path
To: Hao Ge <hao.ge@linux.dev>, "David Hildenbrand (Red Hat)" <david@kernel.org>, 
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 9:31=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Sep 15, 2026 at 11:00=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
> >
> > Hi Suren
> >
> > Thanks for you review.
> >
> > On 2026/9/16 05:09, Suren Baghdasaryan wrote:
> > > On Mon, Sep 14, 2026 at 11:59=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wr=
ote:
> > >>
> > >> The reservation is already stored in the maple tree when
> > >> vm_module_tags_populate() fails. A failed load never unloads the
> > >> module, so nothing releases the entry. Release it and roll
> > >> module_tags.size back. Without the rollback a concurrent load that
> > >> already passed needs_section_mem() can reuse the freed gap, skip
> > >> vm_module_tags_populate() and write to unmapped memory.
> > >>
> > >> vmap_pages_range() may have installed some PTEs before failing. A
> > >> retry to populate the same range would BUG on them, so undo them,
> > >> but only if vmap actually ran.
> > >>
> > >> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag com=
pression")
> > >> Fixes: 0f9b685626da ("alloc_tag: populate memory for module tags as =
needed")
> > >
> > > If a patch fixes two other patches, it likely needs to be split so
> > > that each part fixes one patch only. But read on please. I'm not sure
> > > if one of the fixes is correct.
> > >
> >
> > Kept them in one patch because they only make sense together.
> >
> > After a failed populate the reservation is released and the
> > size rolled back, so the next load takes the same gap and calls
> > vm_module_tags_populate() again, and that retry would trip over
> > the PTEs the failed vmap left behind.
> >
> > Without the rollback a load that already passed needs_section_mem()
> > just reuses the gap, skips populate and writes to unmapped memory.
> > So splitting them leaves each half broken.
>
> Yeah, that's why I think vmap_pages_range() cleanup should be a
> completely separate patch with vmap_pages_range() doing cleanup
> itself.
>
> >
> > >> Reported-by: Sashiko <sashiko-bot@kernel.org>
> > >> Cc: stable@vger.kernel.org
> > >> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> > >> ---
> > >>  mm/alloc_tag.c | 10 ++++++++++
> > >>  1 file changed, 10 insertions(+)
> > >>
> > >> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> > >> index 2070e682fe10..95ddf5b743d0 100644
> > >> --- a/mm/alloc_tag.c
> > >> +++ b/mm/alloc_tag.c
> > >> @@ -804,6 +804,13 @@ static int vm_module_tags_populate(void)
> > >>                                      next_page, PAGE_SHIFT) < 0) {
> > >>                         release_pages_arg arg =3D { .pages =3D next_=
page };
> > >>
> > >> +                       /*
> > >> +                        * vmap_pages_range() only runs once all pag=
es were
> > >> +                        * allocated, and it may have installed some=
 mappings
> > >> +                        * before failing. Undo them.
> > >
> > > If vmap_pages_range() failed to map the range, why should we need to
> > > undo it? If it indeed leaves some partial mapping when failing then I
> > > would argue that vmap_pages_range() should be undoing these partial
> > > mappings itself before returning the error.
> > >
> > Yeah it does - none of the paths under vmap_pages_range() undo themselv=
es on error.
>
> Hmm. I wonder if this behavior is intentional or requires a fix. The
> only possible reason I can think of is performance but I can't imagine
> a failure to map is a performance-critical case.
>
> +David Hildenbrand (Red Hat), +Lorenzo Stoakes (Oracle) what do you

Huh, my gmail thinks you are still at your previous companies :)

> guys think? Shouldn't vmap_pages_range() undo its possible partial
> mapping when it fails?
>
>
> > pcpu_map_pages does perform cleanup on its own as well. There may be ot=
her similar sites.
> > https://elixir.bootlin.com/linux/v7.3-rc3/source/mm/percpu-vm.c#L255
> > so I did the same here.
> >
> > If we really want vmap_pages_range() to handle this cleanup internally,=
 I believe that would
> > be a relatively large change, and we would need to consider many more c=
ases. So I think we keep
> > the current behaviour for now.
>
> Yeah, I understand it would require a deeper cut but if that's the
> right way to handle this we might as well do that. Let's see what MM
> folks think.
>
> >
> > Thanks
> > Best Regards
> > Hao
> >
> > >> +                        */
> > >> +                       if (nr =3D=3D more_pages)
> > >> +                               vunmap_range(phys_end, phys_end + (n=
r << PAGE_SHIFT));
> > >>                         /* Clean up and error out */
> > >>                         release_pages(arg, nr);
> > >>                         return -ENOMEM;
> > >> @@ -947,6 +954,7 @@ static void *reserve_module_tags(struct module *=
mod, unsigned long size,
> > >>                 return ret;
> > >>
> > >>         if (module_tags.size < offset + size) {
> > >> +               unsigned long prev_size =3D module_tags.size;
> > >>                 int grow_res;
> > >>
> > >>                 module_tags.size =3D offset + size;
> > >> @@ -961,6 +969,8 @@ static void *reserve_module_tags(struct module *=
mod, unsigned long size,
> > >>                         shutdown_mem_profiling(true);
> > >>                         pr_err("Failed to allocate memory for alloca=
tion tags in the module %s. Memory allocation profiling is disabled!\n",
> > >>                                mod->name);
> > >> +                       release_module_tags(mod, false);
> > >> +                       module_tags.size =3D prev_size;
> > >
> > > Yes, this one is a valid fix. It fixes 0f9b685626da commit.
> > >
> > >>                         return ERR_PTR(grow_res);
> > >>                 }
> > >>         }
> > >> --
> > >> 2.25.1
> > >>
