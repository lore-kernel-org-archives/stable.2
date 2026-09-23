Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E4F39CD0A
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 02:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790131585; cv=pass; b=YihZ6A4YTr6KIaxGW7uIwz3X3U1fV59Re+FJMMMm2oKskskSxld5Cd9Wxv0/zqSLtNedHgVNntdkeFZn6VDLC2PPxSHQURisrKTulpBVSG/dACIqplUUdYmX/toKUtQj9TFXwYJpAhMUa+BV0JVAp4HU19ntLg75wNhm2vEgmgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790131585; c=relaxed/simple;
	bh=kmwED0F7EVhtTZgnbPWq4Ccrr/KizV9OlK48mu3PyOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FPOMzHG2sWUfDwsAImlSnqTzxl9wdhXRnllGCGlpaIXgJNofk3YsS7/UUVauQBi4WB8eQXVBH/+OISlLJ6HWDP/Ja5euugJqhPY4LrY1Avhd77YHKX+UrEI2Tqp8d/6oAY/TJzcXRETUD/6DWik7xLBsugM+ZUE+Vjv8EoWv++k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FhsD4ax6; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FhsD4ax6"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53113d72966so83841cf.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790131579; cv=none;
        d=google.com; s=arc-20260327;
        b=Ut1PeJtMou/1AWD3pSkzLYG8x1wRImkchAwFwDTtCwgKg92xJMUzbDgJHQVuQ/KhWp
         yonYCAYhKZKRoBtEAOx8BwovMN/UG85XBf8zRt0qUC6Ty5/zBaZUsssVf/FVOudnfnCz
         AnWRBPJd46gmFMoWAldQ45q1iBoh/Z/Tz+3o24Gda2SAqG39B7ktx9i8eU4ipz8JUZip
         hBZT0ZNuG3Kgr8AjG6scIclqKGm3z0Tyd2AedvkWwpAfCD0ZiB1MkcqyDLwbY8+77gv5
         n0v91SCBlWH7bUioR259wouOxH8GFQr9pOSOJuF9gFcwlPk4cRcMxnidQIHtGuD0fQ86
         YgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R8uOFzpnkzf/kQZI5AxzptgiLFgV6BJGWg7vBofd0M4=;
        fh=P3El2YoJi19IVCUhXVb1eOaG2dnvLBoYLw4yMIs9ims=;
        b=YZijxW5xaM2HJ6QffxAR5KozQw48wKpzhMTExrV/jKvVTXnDHrnrB9hD0aKdYrpMT5
         JobnAloeD+im5DC/LzvUbwVxUQSg7ox18+9+bceWzlPjuKaErPhJsFEvbxK8D2kzpuUl
         aI4x9c2wq9osG+wcMCldattJB4VhXNZ8ttGYJ1c/p+jkJxA/BqF4nsf/FnOVdA1phHLU
         f2slcjgSXaLGDMOgCWcjYlgL+2pieVXPeQYbvzGqf3TTjjLin/PoZ5PBh31h+R6w9FAK
         6gtpOnagR5XCOhnblIcos1xDioo/whGsLQG2irSelSJeL4x8h9yu2n30Vyp8gF/+VldB
         /Ekw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790131579; x=1790736379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R8uOFzpnkzf/kQZI5AxzptgiLFgV6BJGWg7vBofd0M4=;
        b=FhsD4ax6CjKafXoJ1RrdhIPO2TAZB3nglt7RVhl+qW3d/8W1b9DWNxaiJwMYsaIrfL
         7vU+CAFu8owbdivVei+xLd4UynDY2wJJgz4+DC1Ggnbzdy4wwi++X3HCiayBbiNSDMda
         EJ0J74sDMHIBeNs3NeBt0L7iO/zT2dbhLJz05syk42oyUbMgXYq4u/8JoveEow2tM/o0
         0etVB4UZrMnOqaKCphClQ1TXrcvLBImFcGtbWh3MSDbf5EZmrWA8rIOQ6hu6xvDr37Qa
         dPlETHFMgHbPamNNlL4MBMeLGreMbIR86ghVb7mGQ+TEOrmTTBE+PYsMbWAhcRXSD391
         1FyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790131579; x=1790736379;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R8uOFzpnkzf/kQZI5AxzptgiLFgV6BJGWg7vBofd0M4=;
        b=SV497rmYdHxYwNypVWA6kbiJOV/VRbUQAh1LAeoOjDd3CjKQiT8cacG6hArkGg3lgB
         G1DcWxo3Cb7yzQ/Gbi1ozeVKC/l1bExAp2BuFNXi5o7+Um6KllR6V86SH2W3Lx/NEpvK
         6YKT7iNsA07SSWr9PhoR1jWOGKXV86lZgYRc4XLyelS+NG3CV6lUarAK1y8KExatVows
         XoGhslv8NEYzsYnuqIqepDUd//CKO+M7wUN87BcjaMfNhp7KIu9QV3qLkMsKQabjU8k3
         AzM52BM/bYW2CGc4z2boefa614hZfuyPUHS5x2OsAmVuTS5VL1wK4n/HpBi2Fu0D8v0g
         dKmg==
X-Forwarded-Encrypted: i=1; AKwUvByqtfAOhiLEbLmxTXhsBHrit6AyZIlEwhsI3LyY6+nH4siTipleVnBoZjcamAn2wzT1GAmStxo=@vger.kernel.org
X-Gm-Message-State: AFuF++lHYdgmv8XUq2iLO0kIZeOdcKsPw+eBgvVXzhOEyVINXe/ZfrB2
	r8rMCg16Cf79EqO6h0wNv5vmKRQn8mZk2HS2w0PLSLzs54I9XiwfXVYYxXJ9kK/vrEjNiUHhiyg
	jwbHm5RN8s9gIHCYXIWyOkCDWFHeP6MM71WHXLxDH
X-Gm-Gg: AYBFou3kYUrK38rI87J+4rnl1eoOBPjN1RyEccwD2/9lcRJh3dWYXo7JFP8W8vpOYV8
	hLM7Y3PiQ708+p6tWO7higkSMfAOQ5pD6Wwv+qirVABpjwXQA6j5LvpvbufLCaWZlj85Ulqw6lk
	q70MjFrRaL2dAE5pbibNmp3DWvEMGtBYNwIg3ZkkBKQqROzmoLdJoHaNwlgWPygR3drPTQdt5D8
	RaANXjTLPGomyNhW/VdemL6fI6hRpgrxzA0Kn55zZQpPkAoireerX0+UA1k9c/CcJJwfnR2OefU
	DAEsXkezHKXyi4cur64PLEUQ575Wqpzw45wMROkUBOZhBY0nTdB5qhc=
X-Received: by 2002:a05:622a:11ca:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-532eb7fee7dmr8415971cf.0.1790131577959; Tue, 22 Sep 2026
 19:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915070001.113559-1-hao.ge@linux.dev> <20260915070001.113559-6-hao.ge@linux.dev>
 <CAJuCfpFKGxOy9W+ZY9KasU5YaDVG4kbGsV6AYb2NNRyW4gT0mw@mail.gmail.com> <f16c55ba-3403-4721-9ff1-061d73e17fa5@linux.dev>
In-Reply-To: <f16c55ba-3403-4721-9ff1-061d73e17fa5@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 22 Sep 2026 19:46:05 -0700
X-Gm-Features: AclHuK-77SC-AzzB_PEzWsM6m_1tPyT3YYUd84GMA5eJaxU9zbpMbRcwXBAS0q0
Message-ID: <CAJuCfpFT-DVa3W6_tNAxoSPjw5bu=eadYsCmhFX2=twQLTNcvg@mail.gmail.com>
Subject: Re: [PATCH v10 5/6] alloc_tag: skip percpu counter allocation when
 profiling is disabled
To: Hao Ge <hao.ge@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 7:36=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Suren
>
> On 2026/9/18 08:53, Suren Baghdasaryan wrote:
> > On Mon, Sep 14, 2026 at 11:59=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrot=
e:
> >>
> >> After shutdown_mem_profiling() clears mem_profiling_support,
> >> needs_section_mem() returns false, so later modules have their codetag
> >> section placed as regular data and never enter the alloc_tag maple tre=
e.
> >> codetag_load_module() still called load_module(), which allocated a pe=
rcpu
> >> counter for every tag; release_module_tags() could not find these modu=
les
> >> on unload, so the counters leaked.
> >>
> >> Return -EOPNOTSUPP from load_module() when profiling is off:
> >> codetag_module_init() drops the module's cmod, no counters are allocat=
ed
> >> and the module loads without its tags. codetag_unload_module() now alw=
ays
> >> calls free_section_mem(), since a module whose module_load() returned
> >> -EOPNOTSUPP is not in the idr but may still hold a reserved section.
> >>
> >> Reported-by: Sashiko <sashiko-bot@kernel.org>
> >> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compr=
ession")
> >> Cc: stable@vger.kernel.org
> >> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> >> Acked-by: Suren Baghdasaryan <surenb@google.com>
> >
> > Yeah, I guess I didn't think about alternatives...
> >
> > When mem_profiling_support=3Dfalse, why can't load_module() skip
> > allocating percpu counters, zero out the whole area between start_tag
> > and stop_tag and return 0 as success (mem_profiling_support is not
> > enabled, so we acted accordingly)?
> > Module will be added into maple tree and later codetag_unload_module()
> > will find the module, call release_module_tags() (which is a NOOP
> > because tag->counter=3D=3DNULL) and finally call free_section_mem(). Th=
is
> > seems more natural than special-casing with EOPNOTSUPP. WDYT?
> >
>
> I see, but the module would then sit in the idr with NULL-counter
> tags that become visible to readers which today never expect that state.
>
> alloc_tag_top_users calls codetag_next_ct() to find the next codetag
> and alloc_tag_read() would do per_cpu_ptr(NULL) for each cpu - plain
> pointer arithmetic onto a wild address, an oops straight out of the
> OOM report.
>
> https://elixir.bootlin.com/linux/v7.3-rc3/source/mm/alloc_tag.c#L503
>
> So if the codetag section within this codetag_type ends up meaningless,
> is there a reason we still return success? We will still maintain cttype-=
>count
> and allocate a slot for this module inside mod_idr.
>
> I'd rather keep the -EOPNOTSUPP version (your original suggestion),
> also because the comments in load_module() and codetag_module_init()
> already document this scenario.
>
> WDYT?

Ok, fair enough. I think your current fix is the simplest way to
resolve this issue, so let's keep it simple.

Acked-by: Suren Baghdasaryan <surenb@google.com>

>
> Thanks
> Best Regards
> Hao
>
> >> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> >> ---
> >>  lib/codetag.c  | 10 ++++++++--
> >>  mm/alloc_tag.c |  4 ++++
> >>  2 files changed, 12 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/lib/codetag.c b/lib/codetag.c
> >> index a9cda4c962a3..a0b600720afc 100644
> >> --- a/lib/codetag.c
> >> +++ b/lib/codetag.c
> >> @@ -240,7 +240,9 @@ static int codetag_module_init(struct codetag_type=
 *cttype, struct module *mod)
> >>
> >>         if (err < 0) {
> >>                 kfree(cmod);
> >> -               return err;
> >> +               /* -EOPNOTSUPP means we can load the module without it=
s tag. */
> >> +               if (err !=3D -EOPNOTSUPP)
> >> +                       return err;
> >>         }
> >>
> >>         return 0;
> >> @@ -388,7 +390,11 @@ void codetag_unload_module(struct module *mod)
> >>                         ++cttype->content_id;
> >>                 }
> >>                 up_write(&cttype->mod_lock);
> >> -               if (found && cttype->desc.free_section_mem)
> >> +               /*
> >> +                * A module whose module_load() returned -EOPNOTSUPP i=
s not
> >> +                * in the idr but may still hold reserved section memo=
ry.
> >> +                */
> >> +               if (cttype->desc.free_section_mem)
> >>                         cttype->desc.free_section_mem(mod, true);
> >>         }
> >>         mutex_unlock(&codetag_lock);
> >> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> >> index 5836803898ad..1ca0409b492b 100644
> >> --- a/mm/alloc_tag.c
> >> +++ b/mm/alloc_tag.c
> >> @@ -988,6 +988,10 @@ static int load_module(struct module *mod, struct=
 codetag *start, struct codetag
> >>         struct alloc_tag *stop_tag;
> >>         struct alloc_tag *tag;
> >>
> >> +       /* Profiling disabled: load the module without its tags. */
> >> +       if (!mem_profiling_support)
> >> +               return -EOPNOTSUPP;
> >> +
> >>         /* percpu counters for core allocations are already statically=
 allocated */
> >>         if (!mod)
> >>                 return 0;
> >> --
> >> 2.25.1
> >>
