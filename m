Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F413C062A
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789035629; cv=none; b=Zy5XKOgktii8q/BdhjE6hjyrvYaTNHdaG2tJI1XWsZQL5V4jX/sKu7E5vJIO0SR0HX7BlcNUp29U8DnY0b4aKxbDXBY6mFW6HwE2CHAbZbiCVQ4RBaeP6/sqLn2nQMcbWjbG3DywAofltdXuDANM7BpRTuCq8GfE+1u6TiXEJoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789035629; c=relaxed/simple;
	bh=yUtEsfPLjWZamfNRfg9VMtJcusHCb8N2rwynWztzht0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/pqusDWdsVI8LgiAG719/geiK5u66HSinC1TpPPmGmUZUgxJTDGW90Bc6KmCDn5ahjTdTM0q4MHqGconzBTFFDDXihKahgSp/rjqaasFPzG/z6rMFRGygpwdH33cTKh7/3EL8u8j0rgTCTNVPOrw64WNTXfSobfIMi/InVsxYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmAzDaZW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmAzDaZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65401F0089F
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 10:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789035627;
	bh=cdEmpVyv56kKc6AhGYdPAfYFd5B5dnDIFz6+xaDxQFc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QmAzDaZWfvVQyqQLjmvIlHpG8GGTWEDOqslZrCFNLTT5V68oAMJhd39eA/by6J/vI
	 6oCe4xTj+QunMxFAot8H1u98Zt33iLMJjdEb0dk0Nrj8Zo326K1ej3Lk2YnH0iAivK
	 a6a2ZeVoK4F2kLUXlw3No5ZLwKcWeNJQSGrtHWA+p8EtDCYn3E4CUo7Yf1HfPRgE4M
	 smeoV//aMC/rFN6PEYZ6UBXV3nAdI2MqxYEpJXydcf2nVNr+HsD57NE7Z1f46UJP+m
	 9Km6bRlF7X25TvcdvO+ygAZJxb5QcvN/62Ma7Zthiu2kPb7+iMZA4ZpjB+VBh15d/6
	 wUsoNMWTCJBgQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c2055573c8cso963915966b.3
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 03:20:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwWpmmxDAAyBjKV0cFYOuUZ2XPGWIrvxmgmS1TOiLKcDMCc3v7D+/QzrFP1te8vVDud085lZ2k=@vger.kernel.org
X-Gm-Message-State: AFuF++mYYlE2nV2PhYXZux+TB3EM/KEexTVdvTMCBoyMTQvhcuOp/Hn4
	hG/AtFFgc+teBOAp2VjsHQpkgrWEKNfBm/z2crO7fb/9l29L4wjG25Dp6ZvfidF5QFQl91bwgPD
	eLf4IqgxGI2uYlaw7EVIM469CqmHSKMI=
X-Received: by 2002:a17:907:9485:b0:c25:541:fd3a with SMTP id
 a640c23a62f3a-c260c7b5cfemr1652863966b.7.1789035626494; Thu, 10 Sep 2026
 03:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907161938.1932355-1-usama.arif@linux.dev>
 <20260909194712.706fb2e87a6e59097424c31d@linux-foundation.org> <7975ef1f-8d2d-4be3-b206-7c6326bed2db@linux.dev>
In-Reply-To: <7975ef1f-8d2d-4be3-b206-7c6326bed2db@linux.dev>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 10 Sep 2026 03:20:13 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPsK1i2wcDEOx0M3Qb_VaUS0-8aGrdyp_-E8i--Napbtw@mail.gmail.com>
X-Gm-Features: AcwNN1VENlP2SEMBSV-Te_X5pjM4wPgRb3x6c-WQl0KNc5q59hkAJHGQQmBlbmU
Message-ID: <CAO9r8zPsK1i2wcDEOx0M3Qb_VaUS0-8aGrdyp_-E8i--Napbtw@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: don't fail a large-folio swapin whose range is
 not in zswap
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	kernel-team@meta.com, stable@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 3:11=E2=80=AFAM Usama Arif <usama.arif@linux.dev> w=
rote:
>
>
>
> On 10/09/2026 03:47, Andrew Morton wrote:
> > On Mon,  7 Sep 2026 09:19:38 -0700 Usama Arif <usama.arif@linux.dev> wr=
ote:
> >
> >> thp_swapin_suitable_orders() and shmem_swap_alloc_folio() sample
> >> zswap_never_enabled() to decide whether a swapin may use a large folio=
.
> >> zswap_load() samples the same one-way static key again once the read
> >> reaches it.  Nothing serialises the two reads, and in between the task
> >> allocates and pins a high-order folio, which can sleep.
> >>
> >> If zswap is enabled for the first time in that window, a large folio t=
hat
> >> was correctly permitted reaches zswap_load(), which rejects every larg=
e
> >> folio with -EINVAL.  swap_read_folio() treats anything other than -ENO=
ENT
> >> as "zswap handled it" and skips the backing-device read, so the folio
> >> comes back unlocked and not uptodate: SIGBUS for an anonymous fault, -=
EIO
> >> for shmem.  The data is intact on the swap device - it was written the=
re
> >> before zswap was ever enabled - and the not-uptodate folio stays in th=
e
> >> swap cache, so every retry of the fault fails the same way.  With
> >> panic_on_warn the WARN takes the machine down rather than the task.
> >>
> >> Scan the range instead of rejecting the folio.  The caller has pinned
> >> every slot before issuing the read, so zswap cannot start a store or a
> >> writeback into the range and the scan is stable.  If nothing in the ra=
nge
> >> is in zswap it is all on the backing device: return -ENOENT and let
> >> swap_read_folio() read it.
> >>
> >> A range that does have a slot in zswap is still refused, because zswap
> >> stores large folios as order-0 entries and cannot reconstruct one.  Th=
at
> >> stays reachable - a slot shared with another task can be stored inside
> >> the same window - and refusing is correct, since the alternative is
> >> returning the stale device copy.  Report it as -EIO rather than -EINVA=
L:
> >> the request is valid, zswap just cannot serve it.  The only caller
> >> distinguishes -ENOENT from everything else, so that part is a
> >> documentation fix.
> >
> > So to hit this bug the user needs to enable zswap system-wide during a
> > teeny race window in the swapin code?
> >
> > I suspect nobody has ever hit this and couldn't do so if they tried?
>
>
> Yes, I think it would be very very difficult to hit this.
>
> It was part of my PMD swap series, where its actually needed for the feat=
ure.
>
> I think we can drop cc:stable, unless you think its needed Yosry?

I am fine either way.
