Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1C836F42A;
	Mon, 14 Sep 2026 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789374699; cv=none; b=Yg/NxzftCAsvcoWyIWJigKjD0Mu/L+5zpJeM5Akv9p2w+Trm1H0+58w15pr0bGa+035iPh48UND0DpoGoyUKC4wkvb6SS6I6OWAWe/8cLoIudY4l8ZEFJCIjsMOYGIg51K1q6SswleySGHDSwFuI8DnjdrxDM2s8XKJpYItSGn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789374699; c=relaxed/simple;
	bh=y10HXNt3BKezzJBLNx4KVYS116Y2If4zoGN8qiW++iQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=OPY/FeaWg2x740L8XV+ETFG2odGW7zxqzUlyKwVZvdSKp9cDbFJRmsV2yZONcIIWsNYyBMWrrSUKyCWJ+zC9MAHim3h9cDkdYCrr5KbOsYTGDvuBABu9U++u/ctgV8/TptQyXHpIrSFIz0nRJhoyRMzvzC+30YU+izlpo61z0M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUUAHmMi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUUAHmMi"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 75D9F1F000FF;
	Mon, 14 Sep 2026 08:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789374698;
	bh=9u1F+W1oWjvcpd0PLfJhCXFiZmV0PhNRETn8J/wT6U8=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=TUUAHmMiPOMISjS7XtQL9pFYonBRDATq/+JuEZ0feBXs6xaT5WpwvuNVKLiK7C1l/
	 BSVaWuDc8Mxs/zcQMM66NWuGYn4yogbkO31MDMNPix12ZZt1Mn96XFv6NhuTJbW4dX
	 jTDIcmEB9CmfsFvC7tMEPD9O4ihF+DHMy2oT7Cu0cHX6rrjwLVTMcZBiEZ3g6ca7/U
	 fV3mPhLmiFmBp2Hbvr0AjndbLwhfCP/4u3OXmiYnq5mnCXGC6KToGa+PmRNrGN+Kwg
	 ws7DKrhiVxE2Jjn1EE536Ygpx0n84nGkflWL19no5wNTU3ySx3J+nLbSx5tGGEJv28
	 FOF3G5Xh+ws3Q==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=9726a21b38a454b89c1f8873bc459716b7d00c2c9442490b0d3eb7b96098;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 14 Sep 2026 10:31:33 +0200
Message-Id: <DLEWE24XEKNU.1Q1JD8PFVRJML@kernel.org>
Subject: Re: [PATCH 1/2] mtd: spi-nor: take the flash lock in
 spi_nor_shutdown()
Cc: <pratyush@kernel.org>, <linux-kernel@vger.kernel.org>,
 <takahiro.kuwano@infineon.com>, <richard@nod.at>, <stable@vger.kernel.org>,
 <miquel.raynal@bootlin.com>, <linux-mtd@lists.infradead.org>,
 <vigneshr@ti.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Itai Handler" <itai.handler@gmail.com>,
 <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.20.0
References: <20260910184452.895485-1-itai.handler@gmail.com>
 <20260910184452.895485-2-itai.handler@gmail.com>
 <20260910190139.BF6231F000FF@smtp.kernel.org>
 <CAFpOueRqaQ=C3u+br6AsCDPeeFwqVUmCG6JSCu90noowVCfd=Q@mail.gmail.com>
In-Reply-To: <CAFpOueRqaQ=C3u+br6AsCDPeeFwqVUmCG6JSCu90noowVCfd=Q@mail.gmail.com>

--9726a21b38a454b89c1f8873bc459716b7d00c2c9442490b0d3eb7b96098
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Sep 14, 2026 at 10:08 AM CEST, Itai Handler wrote:
> Thanks for the review. Taking the three points in turn: the first is
> unreachable, but checking it turned up a real bug next to it that this
> series has to fix first; the second cannot arise on the path this patch
> serves; and the third is correct and is already stated in the commit
> message.

So is this now two AI agents chatting with each other?

Sorry, but please be more precise and on point and drop that wall of
text.

And please annotate your commits with the Assisted-by: tag.

-michael

>> [Severity: High]
>> This is a pre-existing issue, but does spi_nor_prep_and_lock() leak devi=
ce
>> preparation resources if interrupted by a fatal signal?
>>
>> If a process is killed while waiting on wait_event_killable() inside
>> spi_nor_prep_and_lock(), it returns -ERESTARTSYS but fails to invoke
>> spi_nor_unprep() to roll back the earlier spi_nor_prep() call.
>
> The asymmetry in the code is real, but the leak is not: the two halves
> are mutually exclusive, so there is never anything to roll back.
>
> spi_nor_prep() only does something when the flash has controller_ops:
>
>         static int spi_nor_prep(struct spi_nor *nor)
>         {
>                 int ret =3D 0;
>
>                 if (nor->controller_ops && nor->controller_ops->prepare)
>                         ret =3D nor->controller_ops->prepare(nor);
>
>                 return ret;
>         }
>
> and the wait_event_killable() is reached only on the parallel-locking
> branch, i.e. only when SNOR_F_RWW is set. That flag is set in
> spi_nor_late_init_params() (core.c:2981):
>
>         if (flags & SPI_NOR_RWW && nor->params->n_banks > 1 &&
>             !nor->controller_ops)
>                 nor->flags |=3D SNOR_F_RWW;
>
> Note the !nor->controller_ops. A flash that can reach the killable wait
> by definition has no controller_ops, so spi_nor_prep() was a no-op and
> spi_nor_unprep() would be one too. RWW and controller_ops cannot coexist.
>
>> Does this
>> also apply to the other locking helpers like spi_nor_prep_and_lock_pe() =
and
>> spi_nor_prep_and_lock_rd()?
>
> Those two have the same shape and so the same answer: same
> spi_nor_prep(), same wait_event_killable() on the same SNOR_F_RWW
> branch, so there is nothing to unprep there either.
>
> One correction as well: on that branch spi_nor_prep_and_lock() does not
> take nor->lock at all, so the error return cannot deadlock the mutex in
> the way described.
>
> That said, the neighbouring code is not fine, and I would not have
> looked without this comment.
>
> spi_nor_rww_start_exclusive() returns with nor->lock held, on both
> paths:
>
>         static bool spi_nor_rww_start_exclusive(struct spi_nor *nor)
>         {
>                 struct spi_nor_rww *rww =3D &nor->rww;
>
>                 mutex_lock(&nor->lock);
>
>                 if (rww->ongoing_io || rww->ongoing_rd || rww->ongoing_pe=
)
>                         return false;
>                 ...
>                 return true;
>         }
>
> It is the only one of the ten spi_nor_rww_{start,end}_* helpers that
> still uses a bare mutex_lock(); the other nine all use
> guard(mutex)(&nor->lock). Commit 03e7bb864d9a ("mtd: spi-nor: use
> scope-based mutex cleanup helpers") replaced its "goto busy" with a
> plain "return false" and deleted the busy: label that did the
> mutex_unlock(), but did not add the guard() that the others got. Before
> that commit the function always released the lock.
>
> So on an RWW flash:
>
>  - if the flash is idle, it returns true with nor->lock held, and the
>    matching spi_nor_unlock_and_unprep() calls
>    spi_nor_rww_end_exclusive(), which does guard(mutex)(&nor->lock) and
>    self-deadlocks on a non-recursive mutex;
>
>  - if it is busy, it returns false with nor->lock held and
>    wait_event_killable() then sleeps holding it, so nothing can ever
>    clear ongoing_*.
>
> That has been the case since v6.15. Nothing hits it today: the only
> flash with SPI_NOR_RWW is the MX25UW51245G, which has neither OTP nor
> locking ops, so none of the existing spi_nor_prep_and_lock() callers in
> otp.c, swp.c and sst.c apply to it. That is exactly what this patch
> changes - spi_nor_shutdown() did not take the flash lock before, so an
> RWW part never reached the exclusive path, and with my patch every
> reboot would. v2 therefore leads with the guard(mutex) fix as patch 1/3
> rather than building on top of it.
>
>> [Severity: High]
>> If a fatal signal is pending during the reboot process, such as from the=
 OOM
>> killer or a manual SIGKILL, wait_event_killable() in spi_nor_prep_and_lo=
ck()
>> will immediately return -ERESTARTSYS.
>>
>> Will this early return skip the spi_nor_restore() hardware state reset?
>
> Only on an RWW flash, for the same reason as above: the non-parallel
> branch uses mutex_lock(), which is uninterruptible and cannot fail, and
> spi_nor_prep() cannot fail on the spi-mem path because controller_ops is
> NULL there. So on everything else spi_nor_prep_and_lock() returns 0.
>
> Where it can happen, skipping the restore is exactly what the code does
> today when the restore fails, and spi_nor_restore() is best-effort by
> design - it ignores the error from spi_nor_set_4byte_addr_mode() and
> only logs it, "in the hope that the flash will default to the 3-byte
> address mode after the software reset". The patch does not make that
> outcome more likely; the unlocked restore it replaces reports success
> while leaving the flash in 4-byte mode, which is the failure being
> fixed.
>
>> [Severity: Critical]
>> This is a pre-existing issue, but could releasing the lock while the MTD
>> device remains active expose the flash's modified 3-byte addressing stat=
e
>> to concurrent operations?
>
> Yes, and this is the right thing to have flagged. It is in the commit
> message:
>
>         This narrows the race without closing it. The restore still runs
>         while MTD users are attached, so an operation that starts after
>         it has completed will address a chip that is now in 3-byte mode
>         while nor->addr_nbytes is still 4. Closing that as well would
>         mean having MTD stop accepting operations before ->shutdown
>         runs, which is a larger change; serialising against the
>         operations already in flight is what keeps the restore itself
>         from being issued into a busy chip.
>
> The mechanism as described is right: a page program issued in that state
> sends four address bytes to a chip expecting three, so the fourth is
> consumed as the first data byte and the write lands shifted.
>
> It is not introduced here, and it cannot be fixed here. The window
> exists because ->shutdown runs with userspace still running and MTD
> still accepting operations; the only real fix is at the MTD layer, and
> it is a separate discussion I am happy to have. What this patch removes
> is the strictly worse case where the restore is issued into a flash that
> is mid-erase and silently discards it.
>
> Thanks,
> Itai


--9726a21b38a454b89c1f8873bc459716b7d00c2c9442490b0d3eb7b96098
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaqew5hIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hvGwGA5r93zMI1j9+VVprFZTx7n/vNDBYybUtG
pIlMfsnyAWjLCsh032MhrO1huHu6aaRNAYCavd8nVVAinDLWCvlpMrYCC/3AbAm7
l1ag7IZO+FHchAyBJxj5KMTOqUbt05lp7F0=
=DFGe
-----END PGP SIGNATURE-----

--9726a21b38a454b89c1f8873bc459716b7d00c2c9442490b0d3eb7b96098--
