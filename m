Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B4C381E98
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785941203; cv=pass; b=Is79zwiiNgk0AytancF4uGNdZhz8aVDhEKhfGU9Rw9QuAFrwYUlmu7igIy1HF3Rff8vmMZzSEioTTHRmseFbGImte5ufEfjo30LnvtBYGvq6fwohWNqg3U8jQG002bGEu+OxoUsHpdx4DW/+TJfoTk5BPK3VgcWO5fPVd1L9UE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785941203; c=relaxed/simple;
	bh=KvSM8cON3qujrkF2u8/ulKuxwtrvuhS86k/dRZa6tqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8CPP+vBnUmndixDqIxdANq9U0tcRSPwgpvvF9WJlfJ3e8pkHMdOmDRhnCZ5p9oWSLf0N4MRJlBCNXfjg6mtQHYvza3i+UnkYDKX5ThZImUWkQ2u3pR7w5YBrCOMkYxahFJfq18pbJX0LDP2M8mpURGdjmsWsPdHeFuaD7h9ubQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o6eFKmsX; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o6eFKmsX"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so9969a12.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 07:46:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785941198; cv=none;
        d=google.com; s=arc-20260327;
        b=P9MOo2GgS5pN3XcWa6Pd5f/z8AvmrNKK3/8CAMG4IO31SJAPh9MWbbvtH9Bn7JzkxO
         1yTYp5zxLlV46mVt1mmncMpyo20ryGjZIDbGke8Gi2IUO0l5GQeiYXQgY2jLoILwbOBc
         PG4AV68GARuG5xp2kQ022xoKjehOicbnE+4zJ/rjGYmzalSCcYsVxlIMySfaNy9Szn5M
         vayuVZqI2xD+pf6BenOO3h5HFI0xAPWD6HNp/DT8qk4eXP6p1iwMryayB+eWwC0slxsa
         5zn+jEoeXGO9qJ41bNemXjd3K51hBCJySWX9XLHA/CUiHcxaSJ/GZOh7wXhBp0/2q0PC
         v2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dhHfw8IKmQhSRm7kIO0Cdw4azwnv0DEyL0+zw+KJvLs=;
        fh=Ev0sdO/DtbgP4RprdG41di92UqF0yzq5Ac9Y1/vwviU=;
        b=SFU1GzSm/Viq4d5Yr5juX53Ou3HRpdqbwxdpQqQCBX0Wc6Uk4e7PnVvAzohR0E/JLP
         1pGq+a9A5VBzbcUB3orqIQ9rHCbsX8dKlRFF/8sfl3MDdaO0DYVhCR6nI5EYs71U3by5
         fVIUesXJu5YD8z/GedTlhyd3udQIO2g8kvp64HmzSSoqurRtbeLvsU6iPqtD+PIlG+O/
         +tebJr9QMvXmTeUBhqVSRZVO0zp1vL9LUC/DQJS7WuwbiP9DY5m5rjgEpg6PzL4cSQIT
         oPMeQrwV95ATsU1psfCN7rH5K87SZISgT6VeaFIgShTYD6hid7Jxo/bxl6YGqKLau1LX
         3vGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785941198; x=1786545998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dhHfw8IKmQhSRm7kIO0Cdw4azwnv0DEyL0+zw+KJvLs=;
        b=o6eFKmsX83lefxEXpG4AQOI828ZEbZ85PhkkfscF+ydCvGyrib176w+cma/RFsCOqI
         jmI++uvWaI1d6i+n9VGNKFITjrV7NMi6gWoqR9L2Oz9eZR4epxPpoM2icl2IsAl4Qye4
         sCajDtS6xYgHIRX7c3B56xmmgBL98b9YzCU9jIl6KTAO3NFL7XA6d1vQX7vA9u52ZO+X
         Mykes7YqyOx4+xqeHBQgj4Plmh1v/fPoUu+GlTPKuQ9SjMcbN+UlWgOWfnPPIS3nTNc+
         D6DsmQ5X4bJY3N6teznUoHOI/CwEoprS4NbZQ9kISiadLBvTZFqUqlGgbFD9P6IulCqh
         pMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785941198; x=1786545998;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dhHfw8IKmQhSRm7kIO0Cdw4azwnv0DEyL0+zw+KJvLs=;
        b=qB4ymSE5VgluJ+P5akUMPqqj6TePRov4BulYCtKxPvdvBIEpQHjdv5dnXHT1dotyp5
         woOvvrgnKRpW44hQgQVTLImyKN1zIDeGga+joxBPgkKnuwi/WUrkyoLuTb6m8g1wXrkS
         TUVBn9sX8gEEd0MgH4FjbDL4weaZGi5wS3qMoyIjU2KO7WhRFC4NzVVz/JEy3OGP+Vl7
         kqFYDNsdYZqarMcW5sxhI1muvlh79Sx8ryGXf4eB1jRlepr3lbwZ2ZXtreaJ4lHiG+nQ
         ImzBsa+/cD1zvu3RqpLdTP56mIqlXrjUfOFmyo8EQFJ6WpILG8nXJYgGvNuh87t23NQD
         m0Ag==
X-Forwarded-Encrypted: i=1; AHgh+RrL/dJvQno0HqWWjcenFEsWBYrJhZNu2K97lyhzDI0CGjIDJXxAFXXvu10hcwMoPyr70LdFmtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIVllVQYauvYdAQzZHBOFmIibIFAhUesl9zHWK4HcXQ9bjdoB6
	iiXrrVfUEn0JvRMwxtlSRhzgnyshLc0wplQgfHJ63Gfvrom9kqo9eohKcdIs3meImeBCUUlAVfd
	myQhplQ7j7x/h0AGk5wiLUCAVn20m6LUrI10gYZu1
X-Gm-Gg: AR+sD12n2WecgrL0tEdNKZ25Bp/8+IUMjAM/gWv5trAiYfmn4oVY0VDyqlds6h1gEGz
	yitY6p3AegrxdRUY2pbHZ4rrLkNEshoOI55ZcK9lf0tJoGzNGuncVe1oVsYG4eaxon16vQCmOzn
	Bg+Yi1BIPYjZ/A1KmguDvW+3vz9Y7mKpfG/ZflNVL6pcpD0J+QBQ6QRMZeIWAwVoFDY3Aca1pfg
	/m+Adpvy/B91vvJFflXep7WnxUZFMtW9jgTcQezpFpV1rmRTs/9Of+p+Q9dHfK5fwUw0tiq4jrP
	R3yysfwZTwaI70RoK2Z2UJXWALEj0dLjImQ4zC32cqngHGWrPjd0D/0/f+rN3dEmqoLOLysNtts
	=
X-Received: by 2002:a05:6402:2057:b0:672:117e:55d4 with SMTP id
 4fb4d7f45d1cf-6a14fb41676mr74064a12.0.1785941197837; Wed, 05 Aug 2026
 07:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804122038.190270-1-hao.ge@linux.dev> <CAJuCfpGit7zcNPGAB9D2A5+718NY-qdksxt7gUaN_eRcB_5+Ug@mail.gmail.com>
 <bd95f8c6-33e2-4fda-bd4b-ebc37ee7c0fb@linux.dev>
In-Reply-To: <bd95f8c6-33e2-4fda-bd4b-ebc37ee7c0fb@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 5 Aug 2026 07:46:22 -0700
X-Gm-Features: AUfX_mz50Be69N2L1uJmWHpgSowRNnB8Q9VYlBGvXf-rL5eJN_8IPVgC77iH3eo
Message-ID: <CAJuCfpE+-nS9=g4nG=ZZZ0vCnWBxvgcU9LQKj+wFdicreD3Bww@mail.gmail.com>
Subject: Re: [PATCH v2] alloc_tag: fix undetected compressed tag overflow when
 profiling is disabled
To: Hao Ge <hao.ge@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Abhishek Bapat <abhishekbapat@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 7:26=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Suren
>
>
> Thanks a lot for your review.
>
>
> On 2026/8/5 04:08, Suren Baghdasaryan wrote:
> > On Tue, Aug 4, 2026 at 5:21=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
> >> In reserve_module_tags(), the tag overflow check is gated on
> >> mem_alloc_profiling_enabled():
> >>
> >>      if (mem_alloc_profiling_enabled() && !tags_addressable())
> >>
> >> If profiling is toggled off at runtime and a module is loaded whose
> >> tags exceed the compressed-mode limit, shutdown_mem_profiling() is
> >> skipped. vm_module_tags_populate() still maps memory for the tags and
> >> the module loads successfully, but the total tag count now exceeds wha=
t
> >> NR_UNUSED_PAGEFLAG_BITS can address.
> >>
> >> Once profiling is re-enabled, ref_to_idx() computes each tag's index
> >> as its position in the alloc_tag array. update_page_tag_ref() masks
> >> it to alloc_tag_ref_mask before storing in page->flags. Indices
> >> beyond the mask are truncated and idx_to_ref() resolves them to wrong
> >> tags.
> >>
> >> mem_alloc_profiling_enabled() and mem_profiling_compressed are
> >> independent. Once compressed mode is established at boot, it stays
> >> active regardless of runtime toggles of mem_profiling.
> >>
> >> Remove the mem_alloc_profiling_enabled() guard. Also return an error
> >> after shutdown_mem_profiling() to skip vm_module_tags_populate(), as
> >> the mapped pages would never be reused - shutdown_mem_profiling() sets
> >> mem_profiling_support to false, so no future module load enters the
> >> codetag path.
> >>
> >> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compr=
ession")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> > Thanks for the fix, Hao!
> >
> >> ---
> >> Changes in v2:
> >> - Return error after shutdown_mem_profiling() to skip unnecessary
> >>    vm_module_tags_populate()
> >>    v1 link: https://lore.kernel.org/all/20260804064408.105033-1-hao.ge=
@linux.dev/
> >> ---
> >>   mm/alloc_tag.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> >> index 52aece27b00e..d8c36430f1c0 100644
> >> --- a/mm/alloc_tag.c
> >> +++ b/mm/alloc_tag.c
> >> @@ -904,10 +904,11 @@ static void *reserve_module_tags(struct module *=
mod, unsigned long size,
> >>                  int grow_res;
> >>
> >>                  module_tags.size =3D offset + size;
> >> -               if (mem_alloc_profiling_enabled() && !tags_addressable=
()) {
> > Makes sense but how about replacing mem_alloc_profiling_enabled() with
> > mem_profiling_support? Otherwise this warning will be issued multiple
> > times if we are loading multiple modules.
>
>
> That's a really good point, this duplicate warning issue will indeed happ=
en.
>
> When I thought over your point, I realized using mem_profiling_support
> creates a small race window.

Yeah, you are right.

>
>
> Thread A=EF=BC=88insmod A=EF=BC=89                      Thread B (insmod =
B)
>
> --------- ---------
>
> needs_section_mem() -> true
>
>      needs_section_mem() -> true
>
>      (profiling still supported)
>
> reserve_module_tags()
>
>      overflow -> shutdown
>
>      mem_profiling_support=3Dfalse
>
>      return -ENOSPC
>
>      reserve_module_tags()
>
>          mem_profiling_support=3D=3Dfalse
>
>          -> overflow check skipped
>
>          -> vm_module_tags_populate()
>
>              maps unused tag pages
>
> So I'd rather go with pr_warn_once here.

pr_warn_once() works. Thanks!

>
>
> >> +               if (!tags_addressable()) {
> >>                          shutdown_mem_profiling(true);
> >>                          pr_warn("With module %s there are too many ta=
gs to fit in %d page flag bits. Memory allocation profiling is disabled!\n"=
,
> >>                                  mod->name, NR_UNUSED_PAGEFLAG_BITS);
> >> +                       return ERR_PTR(-ENOSPC);
> > This ENOSPC error will be propagated all the way up to the init_module
> > syscall and it's not among the error codes currently expected (see:
> > https://man7.org/linux/man-pages/man2/init_module.2.html). I suggest
> > returning ENOMEM instead.
>
>
> Agree, will change
>
>
> Thanks
>
> Best Regards
>
> Hao
>
> >>                  }
> >>
> >>                  grow_res =3D vm_module_tags_populate();
> >> --
> >> 2.25.1
> >>
