Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793426113;
	b=Anr1DRg6eY0NsHN4CRa6K/1DCRsUsIn/anfLjPIYL5+/RYEQ6tc1LBhxw6x/4f5ou2r4
	 NvrRyW8jlmcth3qOVXCVBWQtdfSAZOr3de5+cXBq587cA1KpQpXbud/gT/qwXE128V3/z
	 n06QutukHOGUgQ0YsFr8DmKoUDwl1dQiB325J5qGu7urnsmlG1GqekrI6n/l2+PNiM2ft
	 z3hVtjsZLoXIp8cxaUGhM8nmUlHFfOkrt91fw+J80lwCv03t2o85D893QSYeTugu0hd8j
	 tNhA3e+XjgA1fUOQ+LC7Omu5idQHFF4SN1ovblpQUHdlGwutY6T3quuAnUpaPfoX2Jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793426113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mK4CIiWiVxpLggdWj3AZATJbmi8Y5VPf+YWX8QjFhvA=;
	b=Z9FxoyhubhucZee5FgzcUzSisGNUx5EDN9QVMj5r3CRbDFLebTUAIz3EwSqW+kOcLtfO
	 m9fZVBTGU+cL5Wtkv16z99gJ+p8YzQ6jfokd6aHxDbX4WzNGtnz38SBBktssjU1lj4sgF
	 jim9R/MV/R38oxqrF+e9PdXobxvjxWJNF0h/MpTN67Gf3v1mkLf+232+nwAALjUdRldFx
	 t+b2WmZHhnoc/uo4PXzWwnjz6xyLWOM+Z4EBdW56C/a3E97MrKCIHf9Shc4697TvgxcmH
	 6edrZ9f7kvCKbZNdcSAZ61jtVRPFVnSMh0ghldCxo7yQLA6rJ+f1vGInfW3yZuBMdig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="urPdt/Du";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAEC606A31D
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 05:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEAEC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=urPdt/Du
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c38ac26cc5dso230643066b.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 22:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793426111; cv=none;
        d=google.com; s=arc-20260327;
        b=ZhXZacE1avrSuZfQQVZFxNITzKXmisBuhdhIAzUsLcxATBYN/2TLponQ/06I3zljcS
         CyDl8+DQIxJgyENl7+kowS5/cddRO8gd809dlT2SGETD+anCc8AiOyf90NfdyUueyWB+
         pQmGLn7xx+uWoJbbfFviElVjX87+djseCrLdjQNwaMvJKTO0Wp+uqQvQqgDXSRaf1vbK
         qRNpvbd+vl8kPJSBqDFFcwKVsryBZ2DTchN75BGHZd8Q+6lSeqOiOVDq3qc7mJh5ITlI
         TKVyOdFiLp/YeT3ZxEMXXP1/KipS5sLaZq4APtMZKjeCf1Snx6N+rP47zXR9LSuPzGq5
         Fmmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mK4CIiWiVxpLggdWj3AZATJbmi8Y5VPf+YWX8QjFhvA=;
        fh=2LFWPRaJGAVaQCymQjEVlCTcmQFbkukjNbP0GxkMpZU=;
        b=dy/H3zBFRplmFpA2ngnAqdw0eeFzGfASR1axqN9kbPfZ2rQ2XAT0+lXwVnxkQPV9n2
         o1TWbgFWpgNhhY92l9gO/N2q5jDWG7AjMKDOiOUNkq5IcjpVf0DMV6zkgGshX9H79JxL
         E9QaE0bqJQVAZUfP3xhNajy+7BXXujSDjetHBGCNQWu7Ly08X3H6mFXPD2F0l/ZuM53p
         jcplYCqvrDtrBUdv69gPdd6gDau3OBBaIWVWJXt2TQlzmb5uYT9fnOrGkF1QwuM+vOX0
         IZMoZ6Ymzp9qz/4c8Wj7lEOwZ3Z/FeEH8Z0vSo2J5zdedAk7wScwn0UBb/TI3dd/Xvce
         ROzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793426111; x=1794030911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mK4CIiWiVxpLggdWj3AZATJbmi8Y5VPf+YWX8QjFhvA=;
        b=urPdt/Dus+RyVnLBTI2XTdiS8d8qF+cOZSfn28ZBE6GgJz7liH+foI4aJGnODLZa2H
         nnNTg11oajI9SCp4RhYWinsF/zPDh+QLTbZK5hivQmKaVh9qOfRJktGJusAnGtXvlC8z
         wr5A53tEr60a3Z7FNqcIExahUTUBL+b61F+4Fs4NTaRDCNX4x0cIPXq71eUppbXQYNmp
         v15buepgFFssGmImCXbFzYCxqDuf1OjBbKwvGpcteK/1ujDKRRsCD4CbWzw27QxPzv+/
         FvsjYjK/r+jCxldtNCSfS4oTcq68HfYu7jaG6FVXhE6LHDDe9VsdSyKin054+/AYWQ31
         qldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793426111; x=1794030911;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mK4CIiWiVxpLggdWj3AZATJbmi8Y5VPf+YWX8QjFhvA=;
        b=N8G/XgpH/o83uS66P7Pztmlv7t464S6LexqCd4P4rZ63F3IeLryiQ22puMz1vemQPN
         5aZrWmFrAXlPLPiXv4NiUiryIEDHkXJsLq+izroGXEe83PchOwZRfJTbO6iz4TmOkpTe
         nw/JwVhH9b/W8dNBAxWEbNGk/o1uDSvDLmN/ZzmHZxKb3IXycXzfZmUFJ92MTGETkc0V
         dcMMRizdj6BSk6f03Eod78kUe4qYr3DWhs98QD7CyvVUQDk2ofH0zXcd1wSV1HGhrUsJ
         jLAsec0P2pnKAdAX8g+7cQpqdNdigaVomj4ZNrm2HS8eqDVxKq3FxgjhO8AvCoV3imqa
         UfhA==
X-Forwarded-Encrypted: i=1; AKwUvByWvP8oNq1wWr6ZAD1g83EZXaccFTnpp/JmPMQMdAeElHD3J7JXGlt04j9EFsojOi3c2L9KRgs=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8dd9Wb5VGT/jbF0QlTt+dZSPot79WmA/ule9ZKkMJ81gNnWh8
	c+UMGBJow7tL73vlFDxso4FlMChD4BJJdemVLC5UQftIPS4Qapp6RiuvtaE/+9IhGyeekcgKW/X
	nXgIs7CdUgDR8JXXyIb3Fn+b73OcKSnA=
X-Gm-Gg: AYBFou1GJfYZblEg7hFdOX0ylKSjjQxxm/vVNlfgmIxWffZDccea4cIt66QaxwMlnjy
	zv3D6X5D6yrG2mvgwj7ft8KAKJF+6KQJkSIgucwoInRNQhEScDgrPCVxlMDCxlH5ekfsBAoyfW3
	zxDOW7TkyGqn7Cxa9Iolrd3QJqG4ZUsjqAc8n0oyquTrzGskrlAJkSy155lGy6fS4rBR6Fa+P47
	a5wdeXIl8pTpdd0sfSlkvJzJApm0AN7oxIIiXodu7w3+6WIIiMWb/4PLG46uYuIwPdttz+H4e9a
	RVtkjg04/59COyOLIgdLL1JqK3t5rYi1TIhRydHitx+Bx57H7083VR5loin8izHBuDIgBqOjAaz
	4gOT7PAnkvufCDiLvYJ2Gi3W2gjeftOUmZgJw+HyJXqHG3xL7PMFbiAj34cFoyqYb8m7YXA==
X-Received: by 2002:a17:906:2846:b0:c4c:bff4:200c with SMTP id
 a640c23a62f3a-c4cbff42ce4mr14178866b.32.1793426111172; Fri, 30 Oct 2026
 22:55:11 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-swapin-large-unmapped-v1-1-41e4ae378e6c@columbia.edu> <20261030155419.b10056c8fb37bc784b0d2778@linux-foundation.org>
In-Reply-To: <20261030155419.b10056c8fb37bc784b0d2778@linux-foundation.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 31 Oct 2026 13:54:34 +0800
X-Gm-Features: AclHuK_Tt59KRB7QsGGZXIHAqauNkBZQGJskNrhNJaJ3MGaw4y8I0GPZZ0wnfjU
Message-ID: <CAMgjq7AUvsHVKkHmLzL-KKf+MBed6e4TeVP7jcGMLM22xO+=5g@mail.gmail.com>
Subject: Re: [PATCH] mm/swapfile: drop a large unmapped swap-in folio in unuse_pte()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mani Tofigh <mt4022@columbia.edu>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 6:54=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 30 Oct 2026 15:11:56 -0400 Mani Tofigh <mt4022@columbia.edu> wrot=
e:
>
> > Since commit f1879e8a0c60 ("mm, swap: never bypass the swap cache even
> > for SWP_SYNCHRONOUS_IO"), a fault can read a swapped-out mTHP range int=
o
> > one large folio in the swap cache.  The folio only becomes anon once
> > do_swap_page() maps all of it, so if the faulting PTE changes in the
> > meantime the folio stays in the swap cache while not being mapped or
> > anon:
> >
> >   Task A (fault)                       Task B
> >   do_swap_page()
> >     /* swaps in large folio F */
> >                                        madvise(MADV_DONTNEED)
> >                                          /* zaps the faulting PTE */
> >     /* PTE changed (F not mapped) */
> >
> > swapoff then maps it, which marks all of its pages as mapped and
> > exclusive, and the next fault on one of the other PTEs crashes in
> > do_swap_page():
> >
> >   [    6.424485] kernel BUG at mm/memory.c:5195!
> >
> > ...
> >
> > do_swap_page() already drops such a folio from the swap cache when it
> > can't map all of it.  Do the same in unuse_pte() so that swapoff swaps
> > the entries in again.  With the fix, nothing is reported.
> >
> > This bug was identified and confirmed with the help of a deterministic
> > hypervisor currently under development.  The C reproducer below however
> > hits it within a second.
> >
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -2518,6 +2518,18 @@ static int unuse_pte(struct vm_area_struct *vma,=
 pmd_t *pmd,
> >       if (!folio_matches_swap_entry(folio, entry))
> >               return 0;
> >
> > +     /*
> > +      * A large folio that is not anon yet was swapped in by a page fa=
ult
> > +      * that did not map it (yet). It can only be mapped as a whole, b=
y
> > +      * do_swap_page(). Drop it from the swap cache and swap in small
> > +      * folios instead.
> > +      */
> > +     if (unlikely(folio_test_large(folio) && !folio_test_anon(folio)))=
 {
> > +             if (!WARN_ON_ONCE(folio_test_dirty(folio)))
> > +                     swap_cache_del_folio(folio);
> > +             return 0;
> > +     }
>
> Let's not WARN here.  If it hits and someone reports it, what do we
> tell them?  "uh, that's working as designed, no action needed".

I think we better keep it, a dirty folio in the swap cache must not be
dropped directly or it can lose data: the copy on the swap device is stale,
so a later swapin of a shared entry reads that stale copy back. If it
triggers it means somewhere forgot to write back a dirty folio properly.

We may generalize this check into the swap cache helper though,
something like:

WARN_ON_ONCE(folio_swapped(folio) && folio_test_dirty(folio));

There are some special users so it's kept out side.

> Also, won't this change cause try_to_unuse() to keep spinning away until
> someone kills it?  Might be better to return -EBUSY and fail the
> swapoff?

It seems fine? The folio is removed from the swap cache, so the next pass
will go on. But you're right about the dirty and WARN case, it spins, so
maybe:

   if (unlikely(folio_test_large(folio) && !folio_test_anon(folio))) {
      if (WARN_ON_ONCE(folio_test_dirty(folio)))
         return -EBUSY;
      swap_cache_del_folio(folio);
      return 0;
   }

We won't run into this unless there are some other bugs I think.
