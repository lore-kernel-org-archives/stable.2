Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A76D23EA9B
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 01:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784251852; cv=pass; b=lKWgairQ/PIwIB1Wb5IgXV2kXbFOHknuDafTsDT8spD2rQIosKfVaxzFWFDdtyPyYIV5yBIXiIE8SO88unQTNGDP2droCPQQMDV/dJUS7WPsn7Hq8GF6v7yoy+rdkkkM/ypO1BvyTwj5AderB8hRSOIjSLJqLYtw9/M6/XUSUT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784251852; c=relaxed/simple;
	bh=OBEEQrnqhUOFUCZbEXhhBV5LLdskcVhecEoX0s3BLpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s508nN8d1z/E0rfBIRqthU55l8FINm7fY5yalvVp9/GBBf3GyC0+6VtMr+yAxIEJT0z7PrzeUS9tlSJEbZ2Q3Cb3TSHIqnllcuhJ2ZAoxuaHRxn3VRtOxJcauJO3/eXSvHAH7pNE9F33DWbttXkCRKJUcjGcrgP5ynzCwlWRZUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYImcS0C; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYImcS0C"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c167aa9500dso321563866b.3
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 18:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784251848; cv=none;
        d=google.com; s=arc-20260327;
        b=Lovyq5EGjrSMF39RXg2Rxpz/f6T4kxfLajNyJHPXzmiU5OyahUk4Xy7SVF0ac6j0W9
         cP0ykiUVMzZ97tfhFslAdnmd8L/UMPkFqoCaZtmz5cSzvphKKRuGiOMoVbpOsS0Vupds
         Q/3b9qrR6Sb6dUrL5/YQ5h8ZVkNeYqK0hFUdEPa9OGx2aIBgJ64xiM68695lu8qkdPrW
         mnXdBg2N+v+3It8MjhJ/QRY/ny2p/dYwPVitCgByY6AogqmcgnpxUwdJnDCqT1o7k6TB
         KDj5/Su4wfcQ/Pp1IMfQfPRjOJ3XF85b2zkTOUTL03vEDCSPOVEEajrxuIRuXUUIUTfw
         7nYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RZ9TBkxSpUZL44kNUoTv9yQ/Eho7g6USaFbCzSHCIVs=;
        fh=T7WsPk7UoN5vsNeIhLaqfrvRmbkGlDvrpn7HIjMMsQo=;
        b=pcxNp9kHWtly+z2bG8KlvztLYlBLITiKcG/xcfYGpfVsw83+qGWe6Q7G/tYYFQ8mjL
         9DDp5NJ71db4qT1RokTe1ZvIL8P4ltNGaIyNPr3uRgBqnzmUZcB3ii/PiJOPyf0GhIyp
         /tdtEVnX24UX1jBP9+wUazBXislcuLFPM9p3i+L0ylvOq3SWbS/wdjned+P8hrWg4NDu
         1rR56WvMk4h1fuWMS588O1gaOtC7rDP8QAK4gDqgBufuPUOn+/z8bkluxyn1beVyHrvS
         PGcjU0hKgX0IJfx8QqOvwopKb8G4sK3uazC3cPVZW6u4h5wdwl0DKfakUG0LsaNNOr73
         UbeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784251848; x=1784856648; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RZ9TBkxSpUZL44kNUoTv9yQ/Eho7g6USaFbCzSHCIVs=;
        b=nYImcS0CBsv9AuA/qyBmLJdtLNSKtsWzQde8L3Zu9M6WHFos1mAL+uTEMx87tfDOFb
         SG/CLc4BBN6Au/VXxCM3UjR4YeHvKMN33TxXrrhIwvODNPQkfetyg/1WqnSFUeMTwMkN
         gi7p1yBKLexy3P9Bh6K4jssRxZzf+ecVZyegBwoqCrf/PiLC1keJkSC3HpXHAGvBO6uE
         S+P/9zvzFyVdic79OFI2OV/4r2pOZHx4sLdNOyYuItSo3oTdBe8QnGdHiu0KzKBnBmE8
         v9/aPx5gk6FbiuCd92mQjQTo+dQHLqa//z1g7/iy22cwpk/cdRjThZuArVx9+AjbW70s
         ygzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784251848; x=1784856648;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RZ9TBkxSpUZL44kNUoTv9yQ/Eho7g6USaFbCzSHCIVs=;
        b=EzKBezzaqd0k1a6Luytr83/GzFSqwaKwEvDIpXUWpRjWPrWRuS69j7tQLtwmD3XIBM
         XH4EYZQvk6kue708EzTNSLyL0VHITg+qgWVslj6hfqOtkMbAHnEIQ8znd3vH0a2qv20H
         9YFxxt3NgzD9DDF558FR1n3pil3WPg8rWY8Rh3bg07j9mbZbk/mM5t2zdxIO6dx0D/rQ
         bGYXdVN63z2+s4ESMGPGZGWUk/C0tMvTN5jdudINa9RWOwMu7UPmldUTvUjIx81p2VNd
         hR/cIJiQSrfxkf4arjyXcRG+Qhvw35vGrbZiJj5YV7hyTh72D8JpxRDPOVgPapVuJEfZ
         NiiA==
X-Forwarded-Encrypted: i=1; AHgh+RpCLHLdHrd6jmWTo7Fesi6HYcbfAxdNiZgyJYGBaoK8S/ERGiGk2a8x/1tcyP2RrVUOecR24Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxLXOV3Y/4bJAxYLriOfZiDtBbf3lXOWSj4Yj/Eh619aXZRTyj
	+ovjJzPPctmPGTOosjKJvkD234ryi8/6O6DYzUWON0JVcah69wtfMKsTjhg4mtZNYPBXJxMYxNq
	+tHHdfp+SUIYJAcsEYTqwpZf4Xk6EAGA=
X-Gm-Gg: AfdE7cndZPrLBYPjvFmDRpxzrRmKFz5dnhEhU8zoL6omdQFRu+OsV/31Y5L1kPlvP/l
	81Qx/vqCdm+TJt+8+Flb6fHqtyVHUgvnoiTr34O86dittGUnLiM5ODPacBNssnh3gXFCTzw0+QN
	6EyZSCbo67sheB60PBZTSHdu3hV3N4fMqHLguZX9hDXK3UYpamVBXDkxBchSolPohAs7rxbLFmz
	yBSLt5aHARsKT9SDnsUzno9FEb8iaU5BcQZkzICK51BJ9Uph7XaKL4vt6yLdQVPgZLDi3TEn5tY
	eUlQF4HnQ5TI0kE7LQf3YGbDn/6O6A==
X-Received: by 2002:a17:907:930a:b0:c15:efb1:9ff7 with SMTP id
 a640c23a62f3a-c16b4702bfamr12697466b.28.1784251848021; Thu, 16 Jul 2026
 18:30:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716174511.8738-1-nickolay.lysenko@gmail.com> <79884bc0-1a2c-4e34-b8c7-75292f3466f6@gmx.com>
In-Reply-To: <79884bc0-1a2c-4e34-b8c7-75292f3466f6@gmx.com>
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
Date: Thu, 16 Jul 2026 18:30:36 -0700
X-Gm-Features: AUfX_mxBE4PDdRf64j_fJODWXG-NvH4rSdWUtcRl_DQY19VejLd8-db-0a4ldeU
Message-ID: <CAMtxOX2m5SCQ5Qp4LmUCKRSrxQnmJcx_UCVrKEGd4-EZ--qvWw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: raid56: fix inverted bio-list check in scrub read assembly
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com, wqu@suse.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qu! Thanks a lot for your review!

On Thu, Jul 16, 2026 at 3:29=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2026/7/17 03:15, Mykola Lysenko =E5=86=99=E9=81=93:
> > Commit 5387bd958180 ("btrfs: raid56: remove sector_ptr structure")
> > converted the bio-list membership checks from sector pointers to
> > physical addresses.  The two conversions in rmw_assemble_write_bios()
> > kept their polarity (skip the sector when it is NOT in the bio list,
> > i.e. when there is nothing to write), but scrub_assemble_read_bios()
> > has the opposite polarity -- skip the sector when it IS in the bio
> > list, because then there is nothing to read -- and the conversion
> > flipped it:
> >
> >       -       sector =3D sector_in_rbio(rbio, stripe, sectornr, 1);
> >       -       if (sector)
> >       +       paddr =3D sector_paddr_in_rbio(rbio, stripe, sectornr, 1)=
;
> >       +       if (paddr =3D=3D INVALID_PADDR)
> >                       continue;
> >
> > Since a parity-scrub rbio's bio list only holds the empty completion
> > bio, the result is that scrub_assemble_read_bios() submits no reads at
> > all.
>
> Then you should remove the check completely, and replace it with an
> ASSERT() to make sure scrub should not have any bio sectors, aka,
> rbio->bio_paddrs[] are all INVALID_PADDR, or all bios (should be one) in
> the bio_list are empty.
>
> Otherwise the analyze looks good to me.

Sounds good, will be addressed in v2.

>
> > finish_parity_scrub() then compares the parity it computes from
> > the (cached, correct) data stripes against whatever happens to be in
> > the freshly allocated, uninitialized stripe pages:
> >
> >    - if the garbage differs from the computed parity, the sector is
> >      "repaired" and written back -- accidentally producing the correct
> >      on-disk result;
> >    - if a recycled page happens to still hold the old (correct) parity
> >      content, the sector is deemed clean, dropped from dbitmap, and the
> >      actually-corrupt on-disk parity is left in place -- silently, with
> >      every scrub error counter reading zero.
>
> Unfortunately that's by design, as scrub never reports P/Q corruptions
> since there is no counter for them, and there is no space left for
> expansion either.

Got it, will reframe.

>
> >
> > The second case is intermittent because it depends on page-allocator
> > recycling.  Observed with fstests btrfs/297 (raid5, 2 devices): the
> > corrupted P stripe intermittently stays corrupt after a scrub that
> > reports no errors -- roughly 1/10 runs on x86-64 KVM and up to 7/8 on
> > a UML build whose timing favors page reuse. Instrumentation of
> > verify_one_parity_step() showed the "on disk" bytes never matching the
> > device content (stale 0xaa / zeroed pages instead of the injected
> > 0xff), and after this fix the injected corruption is read, detected
> > and repaired in every run (8/8 UML, 10/10 KVM).
> >
> > Fixes: 5387bd958180 ("btrfs: raid56: remove sector_ptr structure")
> > CC: stable@vger.kernel.org # 7.1+
> > Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
> > ---
> > Note 1: I found, reproduced and created a fix for this problem using AI
> > tools
>
> Not sure if we still require the disclosure of AI usage using
> Assisted-by: tag, but I'd prefer that to be extra clear.

Sounds good.

>
> Thanks,
> Qu

Thank you!

>
> >
> > Note 2: I am referencing UML (User-Mode Linux) above which is coming
> > from the project https://github.com/mykola-lysenko/btrfs-uml-fstests/ t=
o
> > run xfstests in the UML. For reference only.
> >
> >   fs/btrfs/raid56.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> > index 00a01b97cc..93de764d70 100644
> > --- a/fs/btrfs/raid56.c
> > +++ b/fs/btrfs/raid56.c
> > @@ -2910,11 +2910,11 @@ static int scrub_assemble_read_bios(struct btrf=
s_raid_bio *rbio)
> >
> >               /*
> >                * We want to find all the sectors missing from the rbio =
and
> > -              * read them from the disk. If sector_paddr_in_rbio() fin=
ds a sector
> > -              * in the bio list we don't need to read it off the strip=
e.
> > +              * read them from the disk. If sector_paddrs_in_rbio() fi=
nds a
> > +              * sector in the bio list we don't need to read it off th=
e
> > +              * stripe.
> >                */
> > -             paddrs =3D sector_paddrs_in_rbio(rbio, stripe, sectornr, =
1);
> > -             if (paddrs =3D=3D NULL)
> > +             if (sector_paddrs_in_rbio(rbio, stripe, sectornr, 1))
> >                       continue;
> >
> >               paddrs =3D rbio_stripe_paddrs(rbio, stripe, sectornr);
>
