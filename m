Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B74441D628
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788686410; cv=none; b=h10G6ONzQIfxk4UXSJTCFOLNWHeZAs11z/Nk5S/VWUfc0He7+107w7mDNJPubkEspIjsXC/qSNPwihdeOii+J15OIddAOsxXRFrF7os3Ql/53L87Zs+XVFp95KSqq3HBvfC9uL9VhFo8cvTkOZx0D73BTrTT9rRQoyN5NWr+zD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788686410; c=relaxed/simple;
	bh=Q6oWJksFDxcXUt+2kWXQGvOTqAQCe3Qm7ReLz0eWQgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYhNVl3cJHEsSnrohLoBB40YtND9YB32oV6DY6XDDTWJUMqrDhWRoyK3X/lJXXvUdRDroQcd8btd1Gnwe44T13qH00Dmy7VHPgoPPwM2l6WBPtAAwjxF3qzrGncd+uYhUq+ZzazxI0WvEb04gXdmKjQLptjSJqW9edeIt0R30v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2HGSTo7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2HGSTo7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C27F1F00ACA
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 09:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788686404;
	bh=5cYW1ROi37KqkEFd5TNsEKoOjauJGezJQOt/C6A47Gg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=L2HGSTo7B4iRN9sfqV5g4K+SfsKOsum2FixJmbh/Rqgs6n/p3Sv5A0gLVb4XJUGF/
	 e/ikIJfx/9kEzeRGQPQ8nbi1t9ABlsAez9T+Vb3Y5lnuIK9ifDfO11lBXj7jQELlxb
	 I/b6edrWHniBGmULwcWBJmLooFESq560rtZ8dfQz3wmFXg1OxqLqbPVOCZN3MpxU4m
	 PfHdfX3VuNOz0LPPm9wjzvYqSp3Gg45anocl707EqTW0jmhXfj3aZlAjfxBoymuhNq
	 VjGYgYVP2mpmX2Lu3ICaFI8EpqK/qa6xM38Raw9TY+uZSt5S6zK2JHTCV8mYhXAiYU
	 je4VJibT3a0+g==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c262bc686d9so158077166b.2
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 02:20:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxTV1pxKkOdyvfWAmF7ak90I0mnt7M/70PC6d93xp+sCmc3i5GU4cN5BzHJX/+JR4oLi8kbHF8=@vger.kernel.org
X-Gm-Message-State: AFuF++m9WfPD37LgU2MU6jrP5XycPbrcyDkmWeZJbFySyoWjM30vrNXk
	s30slkmO1wpD6O4ra+GYE57IkCZdse4tFyu3BkexSNX6UWkWQGSQkOCD8EPOAZVioAZeZvxchW/
	+sMi/Z6/g6tsVKazzPfSuvXt9Tezo7Ao=
X-Received: by 2002:a17:907:72c7:b0:c26:30fa:7cf2 with SMTP id
 a640c23a62f3a-c2630fa7fb2mr218413766b.13.1788686403464; Sun, 06 Sep 2026
 02:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905125101.2970456-1-xialonglong2025@163.com> <20260905160926.9836f2ca0dc977b89f2f146e@linux-foundation.org>
In-Reply-To: <20260905160926.9836f2ca0dc977b89f2f146e@linux-foundation.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Sun, 6 Sep 2026 02:19:52 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPhMw=2+wyRYwbBS4As-zNbVnkcT3Y2ppqLo1AxPzaTAQ@mail.gmail.com>
X-Gm-Features: AcwNN1UCbtlS7EgmlQzmJJ99lyp_A81DiewRw8op0GuZAHVNhmi5SzYIkBSJIkk
Message-ID: <CAO9r8zPhMw=2+wyRYwbBS4As-zNbVnkcT3Y2ppqLo1AxPzaTAQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/zswap: enable static key after runtime pool recovery
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Longlong Xia <xialonglong2025@163.com>, hannes@cmpxchg.org, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Longlong Xia <xialonglong@kylinos.cn>, 
	Alexandre Ghiti <alexghiti@fb.com>, Usama Arif <usama.arif@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 4:09=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Sat,  5 Sep 2026 20:50:28 +0800 Longlong Xia <xialonglong2025@163.com>=
 wrote:
>
> > From: Longlong Xia <xialonglong@kylinos.cn>
> >
> > When CONFIG_ZSWAP_DEFAULT_ON is disabled, zswap_setup() can complete
> > without a pool after a failed initial pool creation. A later compressor
> > parameter update can create and publish a pool, but does not enable
> > zswap_ever_enabled.
> >
> > If users then enable zswap, zswap_store() intercepts swapout while
> > zswap_load() still returns -ENOENT without consulting the xarray. The
> > swapin path therefore reads a stale backing swap slot because the store
> > skipped writing it.
>
> That sounds bad.  I'll leave it to reviewers to suggest whether this is
> a sufficient description of the runtime effects, and to decide whether
> a backport is appropriate.  Please.

Yes this needs a stable backport AFAICT.

A more high-level description would be:

If zswap is enabled by default at boot and pool creation fails, then a
pool is later created by updating the compressor, data written to
zswap is corrupted on swapin.

>
> > Enable the static key after a successful compressor and pool update. Do
> > this outside zswap_pools_lock because static key updates may sleep.
> >
> > Verified with fault injection on a stock kernel (compressor builtin,
> > CONFIG_ZSWAP_DEFAULT_ON=3Dn):
> >
> >   1. Boot with zswap.enabled=3D1; pool creation fails, init completes
> >      pool-less (static key off).
> >   2. Echo an available compressor name to zswap.compressor; a pool is
> >      recovered but the key stays off.
> >   3. Enable zswap.
> >   4. madvise(MADV_PAGEOUT) a pattern-verified 512 MiB region, then
> >      fault it back in and verify.
> >
> > Step 4 reads back 131072/131072 zeroed pages (zswpin=3D0, zswpout=3D131=
072)
> > without this patch; all pages intact (zswpin=3D131072) with it.
>
> And thanks.  Sashiko might have found another issue in this zswap code:
>         https://sashiko.dev/#/patchset/20260905125101.2970456-1-xialonglo=
ng2025@163.com

Hmm I think this might be fixed by Alexandre's patch (in Usama's
series): https://lore.kernel.org/linux-mm/20260818131202.494754-6-usama.ari=
f@linux.dev/.

Instead of always returning -EINVAL for large folios we only do so if
they are actually in zswap. Usama/Alexandre, assuming I got this
right, can I interest you in sending the zswap bits of that patch as a
standalone fix? :)
