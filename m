Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3065470E82
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135746; cv=pass; b=IlWnrATFJtfOTUPIX/mF+/QQtMWko33qPQ/YSzuKo+4iggzQZGzHOIdd/ednzUu2eeD9ZQ9rZOb48+gd4dT+nSujLp2nlKRFzuhUgefM+YjkmzM7iv/PalKC4dZAwl1rvutkzL1pyQBbkYIFjEkw1BxPxJz12bi9db42Z5Tt7i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135746; c=relaxed/simple;
	bh=0NIxRm9j8x70g9FR+y+hF4NZwYnxGeMUXTvlqQyCFpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0n0ifjdhxzjIj58cb7o0V4edQjr8fMzPpqr1C+rzen4v0Zd3ZVhg5Hd6HCtvnIU1BDha4ZxLgi1lG/WNDT7JxeBmJ6CUipSBOysMDqSwhDpB9LoeiUNrZXtpsL+xl+JdfIvRAt0PN7KEYvWKyjUthN4aBe/znBlzJ945LOqyi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ILOiw9pf; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ILOiw9pf"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5337fa12431so183161cf.1
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 10:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791135743; cv=none;
        d=google.com; s=arc-20260327;
        b=btCGoXvK/AKGIh2F6MP2sWAiJBbyd6ukZ1VM+TubeYExFCygQxfORicqyCokIA2+No
         66QlkkL0RHVrcNTlBwZgPfCXazSst5i87IMe1ubSrdUZ9BIEkrcXu9nwXjHaayf7NuPx
         YiFRKnf1btIw+3XEEY4CQxwjYdOQA/48aFpArDbMRf8Mw9InyDYOby24J8fsoMrY78Fn
         e0am9mQZAFDv+DSIVyDhw4yT7TpSXmcQrlgOQbpoMtdyKWo3azJikVgy/BkPK1TK7BIc
         +05vyxLN+fzeD7a9gesGOdOf8dGidTTof4fp5oX7m7u/3qPCa5Yz5UgQI6QsekBibCpV
         5suA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lc5562D3mWi9zthF4OGWqkURt3JXx0LaNSqwCjnMAYk=;
        fh=Jc/CI4bzv6JZs1NLxKBauRQKEFne2YGYy3AcrFI9N4Q=;
        b=gyRxIT/UwZPgREDhf8hH0gcKHSlYbS8h31bPLLh49hbycro/G+QoWqeYql1W15Brfp
         geLzByv17EcMg20NEKQ6XWYb4nlnE3l3eWtanjbYD89Rm2/Md25lshUbWH+iXg+hu732
         eMY31WpigVmzswPY+s9zRCQOEzZ54kCgZ6qjI+g3RniJOWoO07eZt1idsa1rtJMjB4hQ
         32PUG9gUQvVTqcV5MS+D4Z4nEebrgFJn8n1aZ2uqkd40PNuZ4jk+VMTQuUjHrUkEJTdk
         ijgGu4HiWrXfAqRAmleZHfp0/CDoDaUMWhjXEHXjo9Ax+zaA28WWIPuy2W3daqhUahgv
         mjGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791135743; x=1791740543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lc5562D3mWi9zthF4OGWqkURt3JXx0LaNSqwCjnMAYk=;
        b=ILOiw9pf6KdcSmEjiztckKpeDjPXye7B29Pkv2pXYu5MflCje1tmk02XjxPl/C7fC0
         TJQ2yC20mZ9Icj1b95YFcFAhU4h1h0E8WzA30HMHYDk0mwN/LCGpHXvsRJ5Wr9i/4EZ2
         NIvhrezs7hTROTSxkstIQhzJALL9gqyPYweOADFTihlJf54CmUMOQ99geRfCzazmYh5h
         yh68ECoeU7WNpOEdRQk/9DvX3wjy1dE3bDOmarfbZHqxWT/HIBJ1IRWX1CP/iz4tQnso
         mMviIlXJpawOWja+wqlHhNZSiHfqCTPZNf+swfDfGoZ45+BmZsi8eD0Oh53j1DgSiWYr
         +9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791135743; x=1791740543;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lc5562D3mWi9zthF4OGWqkURt3JXx0LaNSqwCjnMAYk=;
        b=KhJPOBSkP8ix80F49ITrAq3nb3alxO/BI4MKLrHWLzz62k+rz4TOlGG5AMa6p6R3qX
         ux8A8sCkv+gbfKdq8sU/GJ4U4drFBduL3Txg+m8IxNySXA88s3mC4XeL632DBOV1EGS2
         KPXsVyiZzMuTC6XfT3kRt6VSAlD8vDllniTiW/nWlArMZYB+PNhlpoYW5tzll+BkKlRd
         r64PAAU9IYRmuW3NjxFMbM+TbiT/p8Npb3yDq/xksZIp+8TMaAGqwTnD3vrj5Sd3agp5
         G2KN9h2vNU9sa8u6ASvOagtklsWtXHGUD5+cON5vcuzOEM7Reb9t4twSwqi5v+vN5BIT
         WYUg==
X-Forwarded-Encrypted: i=1; AKwUvBxd2rs6HaR4h4UAJS/WzPvKd2UH5GmOsuhoHFtYtUq6rucQ5zm0bHNqSLu1nzhytLPtVor7Y/4=@vger.kernel.org
X-Gm-Message-State: AFuF++mvHEpNUtAUkVUa4bcoKkFWDwOqKi/GClDx8M+lIOYHKchcE4LW
	H+OQ7HGUtcwKipEgC9REZCaFCV2U+IrZ4wYz0xClOK+85pBL6jTYu9gs4B7Ld3Zs+SAO9NnwAYM
	IE5R+U4qyqvANhF5ruvhnOCCbT/eMR3qI3PwR14cu
X-Gm-Gg: AYBFou3JIEhcRZ7LhVQ9URf3MGXFmdN/qLCP5t9H9yrxTeMGsSA4MvVbVVx33k0BzrG
	+JkLKG9PmBC8NTeG4wOMV6ICm5ylw25DgiO67aK10ZKQ4uo+eqn4ERTxRUCPb65CtTy6Sr90zAF
	n71WXVsSLrf2pqvpebiFOL7vdp9X8ubuIgaoLWVeSJ3HFUlp9qryi2wVGhYdvaYpV2BETQhbsLn
	3CZLfY9FXgB7Ep2jvhX+PYvqaNtbtxwtVk1UM8Q0Q+c3P5NEhotFFkKUIRm7uYjF5dtukY9uwMO
	YCzXRZ6U1jXmAsT76yQ4feYzGErEg4Tc/RBH51kkqfUGEDMUv52te10P
X-Received: by 2002:a05:622a:606:b0:532:84d3:abb with SMTP id
 d75a77b69052e-535131b5a84mr14423871cf.7.1791135742728; Sun, 04 Oct 2026
 10:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929082014.160587-1-hao.ge@linux.dev> <20260929082014.160587-3-hao.ge@linux.dev>
 <arzgoe-bXAz1poAt@milan>
In-Reply-To: <arzgoe-bXAz1poAt@milan>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 19:42:10 +0200
X-Gm-Features: AclHuK_ov-dYU8ZQ3hSK0lFHr-9gA3i8l8r8LsI_kBqLCittdU-KxegpDjovpwQ
Message-ID: <CAJuCfpHavrwaJ2T6daHnJc+r=9khBwrv_zOp8s3Cwi347SHXRw@mail.gmail.com>
Subject: Re: [PATCH v11 2/7] mm/vmalloc: undo partial mappings inside the
 mapping functions
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Hao Ge <hao.ge@linux.dev>, "=Kent Overstreet" <kent.overstreet@linux.dev>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 12:12=E2=80=AFPM Uladzislau Rezki <urezki@gmail.com=
> wrote:
>
> On Tue, Sep 29, 2026 at 04:20:09PM +0800, Hao Ge wrote:
> > __vmap_pages_range_noflush() and friends can install some PTEs before
> > failing and leave them mapped, and the kernel callers do not agree on
> > who cleans them up. For example, pcpu_map_pages() and
> > kmsan_ioremap_page_range() unmap the leftovers themselves, while
> > vm_module_tags_populate() and the __GFP_NOFAIL retry loop in
> > __vmalloc_area_node() relied on the mapping functions cleaning up and
> > did not call anything like vunmap_range() themselves. When the same
> > range is mapped again, the attempt hits the leftovers and fails, with
> > BUG() in vmap_pte_range() for huge mappings.
> >
> > After discussing with Suren and Ulad, we decided the cleanup belongs
> > to __vmap_pages_range_noflush() and friends, so the callers no longer
> > need to unmap the partial mappings themselves. Each function now
> > undoes the PTEs it installed itself.
> >
> > The rollback calls the low-level __vunmap_range_noflush(), it just
> > clears the PTEs of the range it is given, which is all a rollback
> > needs. It cannot use vunmap_range_noflush() because these mapping
> > functions also map the KMSAN shadow and origin, and for a metadata
> > range its hook would look up the metadata of the metadata, get 0
> > and BUG() on addr >=3D end. The failed mappings were never accessed,
> > no TLB flush needed.
> >
> > Fixes: 9376130c390a ("mm/vmalloc: add support for __GFP_NOFAIL")
> > Fixes: 0f9b685626da ("alloc_tag: populate memory for module tags as nee=
ded")

I don't think this fixes 0f9b685626da. I mean it fixes it but
indirectly. That patch expects vmap_pages_range() to undo the mappings
when it fails, which is a reasonable assumption. By fixing
vmap_pages_xxx we fix all its users, including
vm_module_tags_populate(). So, it indirectly fixes several callers but
when adding a Fixes tag we do not list all patches we indirectly fix.

> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hao Ge <hao.ge@linux.dev>
> > ---
> >  mm/kmsan/shadow.c |  4 ++++
> >  mm/vmalloc.c      | 31 +++++++++++++++++++++++++++++--
> >  2 files changed, 33 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
> > index 0c88d89bf0d6..2166086d3dc3 100644
> > --- a/mm/kmsan/shadow.c
> > +++ b/mm/kmsan/shadow.c
> > @@ -258,6 +258,10 @@ int kmsan_vmap_pages_range_noflush(unsigned long s=
tart, unsigned long end,
> >                                           o_pages, page_shift);
> >       kmsan_leave_runtime();
> >       if (mapped) {
> > +             /* Undo the shadow mapping set up above. */
> > +             kmsan_enter_runtime();
> > +             __vunmap_range_noflush(shadow_start, shadow_end);
> > +             kmsan_leave_runtime();
> >               err =3D mapped;
> >               goto ret;
> >       }
> >
> Can we just do that inside the vmalloc? For example in the
> __vmap_pages_range_noflush() as entry function for all(?) helpers?
> So we do not need do it manually?

Agree, that would be better.

>
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 859e6d2d57a3..9bbf75706627 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -349,6 +349,10 @@ static int vmap_range_noflush(unsigned long addr, =
unsigned long end,
> >       if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
> >               arch_sync_kernel_mappings(start, end);
> >
> > +     /* Undo the PTEs installed before the failure. */
> > +     if (err)
> > +             __vunmap_range_noflush(start, end);
> > +
> >       return err;
> >  }
> >
> > @@ -363,6 +367,9 @@ int vmap_page_range(unsigned long addr, unsigned lo=
ng end,
> >       if (!err)
> >               err =3D kmsan_ioremap_page_range(addr, end, phys_addr, pr=
ot,
> >                                              ioremap_max_page_shift);
> > +     if (err)
> > +             __vunmap_range_noflush(addr, end);
> > +
> >       return err;
> >  }
> >
> > @@ -667,6 +674,10 @@ static int vmap_small_pages_range_noflush(unsigned=
 long addr, unsigned long end,
> >       if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
> >               arch_sync_kernel_mappings(start, end);
> >
> > +     /* Undo the PTEs installed before the failure. */
> > +     if (err)
> > +             __vunmap_range_noflush(start, end);
> > +
> >       return err;
> >  }
> >
> The only one user of that function is __vmap_pages_range_noflush()
> so we can cover both cases there small and huge path.
>
> Is that enough just to do unroll in the below:
>
> __vmap_pages_range_noflush()
> vmap_page_range()
>
> functions? It will also fix NOFAIL case:
>
> <snip>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 89c327a6ce7d..fa1f357ecf3f 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -359,10 +359,19 @@ int vmap_page_range(unsigned long addr, unsigned lo=
ng end,
>
>         err =3D vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
>                                  ioremap_max_page_shift);
> +       if (err)
> +               goto error_cleanup_range;
> +
>         flush_cache_vmap(addr, end);
> -       if (!err)
> -               err =3D kmsan_ioremap_page_range(addr, end, phys_addr, pr=
ot,
> +       err =3D kmsan_ioremap_page_range(addr, end, phys_addr, prot,
>                                                ioremap_max_page_shift);
> +       if (err)
> +               goto error_cleanup_range;
> +
> +       return 0;
> +
> +error_cleanup_range:
> +       __vunmap_range_noflush(addr, end);
>         return err;
>  }
>
> @@ -683,26 +692,35 @@ int __vmap_pages_range_noflush(unsigned long addr, =
unsigned long end,
>                 pgprot_t prot, struct page **pages, unsigned int page_shi=
ft)
>  {
>         unsigned int i, nr =3D (end - addr) >> PAGE_SHIFT;
> +       unsigned long start =3D addr;
> +       int err;
>
> -       WARN_ON(page_shift < PAGE_SHIFT);
> -
> -       if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
> -                       page_shift =3D=3D PAGE_SHIFT)
> -               return vmap_small_pages_range_noflush(addr, end, prot, pa=
ges);
> +       if (WARN_ON(addr >=3D end))
> +               return -EINVAL;
>
> -       for (i =3D 0; i < nr; i +=3D 1U << (page_shift - PAGE_SHIFT)) {
> -               int err;
> +       if (WARN_ON(page_shift < PAGE_SHIFT))
> +               return -EINVAL;
>
> -               err =3D vmap_range_noflush(addr, addr + (1UL << page_shif=
t),
> +       if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
> +               page_shift =3D=3D PAGE_SHIFT) {
> +               err =3D vmap_small_pages_range_noflush(addr, end, prot, p=
ages);
> +       } else {
> +               for (i =3D 0; i < nr; i +=3D 1U << (page_shift - PAGE_SHI=
FT)) {
> +                       err =3D vmap_range_noflush(addr, addr + (1UL << p=
age_shift),
>                                         page_to_phys(pages[i]), prot,
>                                         page_shift);
> -               if (err)
> -                       return err;
> +                       if (err)
> +                               break;
>
> -               addr +=3D 1UL << page_shift;
> +                       addr +=3D 1UL << page_shift;
> +               }
>         }
>
> -       return 0;
> +       if (err)
> +               __vunmap_range_noflush(start, end);
> +
> +       /* 0 on success. */
> +       return err;
>  }
>
>  int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> @@ -714,7 +732,13 @@ int vmap_pages_range_noflush(unsigned long addr, uns=
igned long end,
>
>         if (ret)
>                 return ret;
> -       return __vmap_pages_range_noflush(addr, end, prot, pages, page_sh=
ift);
> +
> +       ret =3D __vmap_pages_range_noflush(addr, end, prot, pages, page_s=
hift);
> +       if (ret)
> +               /* Cleanup KMSAN metadata. */
> +               kmsan_vunmap_range_noflush(addr, end);
> +
> +       return ret;
>  }
>
>  static int __vmap_pages_range(unsigned long addr, unsigned long end,
> <snip>
>
> --
> Uladzislau Rezki
