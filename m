Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708A22D94AB;
	Wed, 17 Jun 2026 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705876; cv=none; b=TFzfK8Nfzo6WTnL/q8BQTSP19JMtH0zulfALL8cMlXvPWXHS1NnBORPDqixNgk1WACqFazTqxpJftIfRP3TwbNYWOrfGgAcC2m1M1YMnIJcJPdHsl8iDF2N+3EwMNTAK5o4vc3FJCJfh1UUuTsUesUYEKK7FPKMlR+HOozBpO7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705876; c=relaxed/simple;
	bh=AkV1b2SxhRv8Z1DlbLWqqT7osTEwXFUZ7e4YsH4eZEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pkd3i96U0fHWYzwToLHLPFvwdAJFTV7WRZEOSIp0fI12dxRBOKzzlPenW2Rdj+bwcax5ccOmFLUb33JGXNvTmFp6QrVKzOf/ZXDmPGJBvGz/5pUlcXr24KU3QLFvgh8EzS8eYssw/zLT+kgd4UCbiTZhnD1Nb17Z0wffnzs5D8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gc5bOCuZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gc5bOCuZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBB51F00A3A;
	Wed, 17 Jun 2026 14:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781705875;
	bh=ZM2pmLbZEnRqiiVMijb9mGZhjVGPxFxAiEd6zjVu+Dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gc5bOCuZLI6PDDkSobp4K8u/Gu2ToeIkkty6kGEQ99T19G2igxl8tMZJ9QnWmEja0
	 OnUPlrWfGyI6ltcOMvb31qTdgYQM9jZqd1ZPCSrLwhBhlp+o+FRhnrepHrftRg3PUZ
	 8CO+GHehP5avJ54vOWEbxFCy9vbhwYjocqpX0PvzI2FnYHqtRgHyVby/HgVvLjltTU
	 GResIs8NOufz35OAttR9gC70AibvbR0vbrdvdAiAkAcoGD+Q+V6gcnEjXPcGkYpLQ2
	 xxK9+jCSWGDDaPTOGMoUB6Yyjp+mz4Eu8h499HPhWo+N57y88eKt175oKQSgmkt6qH
	 +QpKVyfcQ97fA==
Date: Wed, 17 Jun 2026 15:17:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Teddy Astie <teddy.astie@vates.tech>,
	Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: timers/core] time/jiffies: Register jiffies clocksource
 before usage
Message-ID: <20260617-flounder-pebble-fe4c19e1be81@spud>
References: <87y0gn3fve.ffs@fw13>
 <178135728754.1650852.1266320590541376793.tip-bot2@tip-bot2>
 <CGME20260616184701eucas1p13c7aff447073832095aa4adfb85935f0@eucas1p1.samsung.com>
 <813164f9-d036-4858-80ad-f3af9bee9c77@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rBlzqT461HFZGlY+"
Content-Disposition: inline
In-Reply-To: <813164f9-d036-4858-80ad-f3af9bee9c77@samsung.com>


--rBlzqT461HFZGlY+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 08:47:00PM +0200, Marek Szyprowski wrote:
> Dear All,
>=20
> On 13.06.2026 15:28, tip-bot2 for Thomas Gleixner wrote:
> > The following commit has been merged into the timers/core branch of tip:
> >
> > Commit-ID:     f24df84cbe05e4471c04ac4b921fc0340bbc7752
> > Gitweb:        https://git.kernel.org/tip/f24df84cbe05e4471c04ac4b921fc=
0340bbc7752
> > Author:        Thomas Gleixner <tglx@kernel.org>
> > AuthorDate:    Tue, 09 Jun 2026 17:14:45 +02:00
> > Committer:     Thomas Gleixner <tglx@kernel.org>
> > CommitterDate: Sat, 13 Jun 2026 15:22:40 +02:00
> >
> > time/jiffies: Register jiffies clocksource before usage
> >
> > Teddy reported that a XEN HVM has a long boot delay, which was bisected=
 to
> > the recent enhancements to the negative motion detection. It turned out
> > that the jiffies clocksource is used in early boot before it is registe=
red,
> > which leaves the max_delta_raw field at zero. That causes the read out =
to
> > be clamped to the max delta of 0, which means time is not making progre=
ss.
> >
> > Cure it by ensuring that it is initialized before its first usage in
> > timekeeping_init().
> >
> > Fixes: 76031d9536a0 ("clocksource: Make negative motion detection more =
robust")
> > Reported-by: Teddy Astie <teddy.astie@vates.tech>
> > Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> > Tested-by: Teddy Astie <teddy.astie@vates.tech>
> > Cc: stable@vger.kernel.org
> > Link: https://patch.msgid.link/87y0gn3fve.ffs@fw13
> > Closes: https://lore.kernel.org/all/1780914594.8631fc262581453bbf619ec5=
b2062170.19ea6c8227b000701b@vates.tech
> This patch landed recently in linux-next as commit f24df84cbe05 ("time/ji=
ffies:
> Register jiffies clocksource before usage"). In my tests I found that it =
triggers
> the following warning on Qualcomm Robotics RB5 board
> (arch/arm64/boot/dts/qcom/qrb5165-rb5.dts):
>=20
> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_n=
s: 7645041785100000 ns
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> [ BUG: Invalid wait context ]
> 7.1.0-rc1+ #16790 Not tainted
> -----------------------------
> swapper/0/0 is trying to lock:
> ffffb0d1364d1270 (clocksource_mutex){....}-{4:4}, at: __clocksource_regis=
ter_scale+0x204/0x3e8
> other info that might help us debug this:
> context-{5:5}
> 1 lock held by swapper/0/0:
> =A0#0: ffffb0d1376855f0 (&tkd->lock){....}-{2:2}, at: timekeeping_init+0x=
13c/0x21c
> stack backtrace:
> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.1.0-rc1+ #16790 PREEMPT
> Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
> Call trace:
> =A0show_stack+0x18/0x24 (C)
> =A0dump_stack_lvl+0x90/0xd0
> =A0dump_stack+0x18/0x24
> =A0__lock_acquire+0xa48/0x225c
> =A0lock_acquire+0x1c4/0x3f0
> =A0__mutex_lock+0xa8/0x8e4
> =A0mutex_lock_nested+0x24/0x30
> =A0__clocksource_register_scale+0x204/0x3e8
> =A0clocksource_default_clock+0x48/0x64
> =A0timekeeping_init+0x148/0x21c
> =A0start_kernel+0x4c8/0x8dc
> =A0__primary_switched+0x88/0x90
> arch_timer: cp15 timer running at 19.20MHz (virt).
> clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x46d98=
7e47, max_idle_ns: 440795202767 ns
>=20
>=20
> Reverting $subject on top of linux-next fixes this issue.

Same here:
    0.000000] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff=
, max_idle_ns: 7645041785100000 ns
[    0.000000]
[    0.000000] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    0.000000] [ BUG: Invalid wait context ]
[    0.000000] 7.1.0-06889-g4b99990cdf95 #1 Tainted: G        W
[    0.000000] -----------------------------
[    0.000000] swapper/0/0 is trying to lock:
[    0.000000] ffffffff820cd258 (clocksource_mutex){....}-{4:4}, at: __cloc=
ksource_register_scale+0x222/0x306
[    0.000000] other info that might help us debug this:
[    0.000000] context-{5:5}
[    0.000000] 1 lock held by swapper/0/0:
[    0.000000]  #0: ffffffff82fdae70 (&tkd->lock){....}-{2:2}, at: timekeep=
ing_init+0x1a4/0x25e
[    0.000000] stack backtrace:
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G        W    =
       7.1.0-06889-g4b99990cdf95 #1 PREEMPT_RT
[    0.000000] Tainted: [W]=3DWARN
[    0.000000] Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
[    0.000000] Call Trace:
[    0.000000] [<ffffffff8001c0e0>] dump_backtrace+0x1c/0x24
[    0.000000] [<ffffffff80002526>] show_stack+0x28/0x34
[    0.000000] [<ffffffff800135a0>] dump_stack_lvl+0x60/0x88
[    0.000000] [<ffffffff800135dc>] dump_stack+0x14/0x1c
[    0.000000] [<ffffffff800bb096>] __lock_acquire+0x81c/0x234e
[    0.000000] [<ffffffff800bd924>] lock_acquire+0x2e0/0x460
[    0.000000] [<ffffffff80d61d46>] mutex_lock_nested+0x44/0x8a
[    0.000000] [<ffffffff8012e704>] __clocksource_register_scale+0x222/0x306
[    0.000000] [<ffffffff80e15572>] clocksource_default_clock+0x48/0x62
[    0.000000] [<ffffffff80e15286>] timekeeping_init+0x1b6/0x25e
[    0.000000] [<ffffffff80e00f9c>] start_kernel+0x67c/0xc66
[    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff max=
_cycles: 0x1d854df40, max_idle_ns: 3526361616960 ns

In your case, do you also see an increase in logging verbosity, as if
you had enabled debug on your commandline?

Cheers,
Conor.

--rBlzqT461HFZGlY+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajKsjAAKCRB4tDGHoIJi
0m0fAP4lo8ZsVCUAHKYAdo5qn/L/MN1CijsOd5Ddw3YVOsfIqAD+JTE6gwUtFeNa
VkRMAUbqWBdYN10Jev0LJYjemyLDrQo=
=z7J4
-----END PGP SIGNATURE-----

--rBlzqT461HFZGlY+--
