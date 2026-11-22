Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795313340;
	b=Eq3wSTpTEjYVmhyO7G4d2GmJkLRIaP7aY4L5mcQGXaVwF/xd92gv3xI15JC5OuEr9DmC
	 wNlR0Jk8lLeHT4yEkqPnDfjErLoV1XJoOh+dabiDq6A5avR7FogSeoYDtdTT1GdQJ1+8L
	 susehb3EDQ+PSaCtfXkQoWBPHQOmtEX/qNC+KYGWQOOVlxIK5zByfkC+MTD8rfFFm1kzk
	 iZwjsYD1C/MvM/PK4XdCdf46fnZh0Wliaby61zCmtIsTdMsUtW5drNWaIBi24nfos1Mdd
	 8SZFQkr0K6sogNjjdyJxyscKZam6ian9+bmwE6KBqDt0144NQAXFvqPpoy6wThLVYUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795313340;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=QSOldkyDHE3yvTcYOBM7bHlgZUHM49mDL6VtgEY/wP4=;
	b=t1500H50LGikg/og+kT2uTD7Ro9L8isNb3THdFMsLVHeNiA9XGAs+TT3Sf7RhMjAqXoH
	 ymgTac65neCbvZV271VOzJZVYd7lHa1IwHYj71UqE8LvC0hLm4UiqNEpOEZtriVVrM4VE
	 Gr+K6dFvp5HppT87dGd0fN34WjUHFgPQ0o0Q8hcTvtb/aEGUv7fQpR3cQZ0i9QeGSVrG0
	 OSBU9ANnJ7HFSPgrgZ6rWgfOYt1FhWGpq9AT7ZYoF9EQ4a802BY/xqNACRTVG7ZngKKfo
	 R908z+zLRfoBKE9LCzFjjI6ns20csGlTHGeWjlcBhvAG0J5RKL+q41fAsri+PqoOP5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=iM8UOG+5;
	arc=none smtp.remote-ip=79.135.106.98
Received: from mail-10698.protonmail.ch (mail-10698.protonmail.ch [79.135.106.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894CC606A32A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 02:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 894CC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=iM8UOG+5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795313337; x=1795572537;
	bh=QSOldkyDHE3yvTcYOBM7bHlgZUHM49mDL6VtgEY/wP4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iM8UOG+5q86LGv69yARR1d2gnI8ozdIm0sBATLpKTk5PtHE6eIDPGugKw8AvDltsC
	 BdrxmxTMSvOq4x3T20ZNWLk/6OZU4efCiTZD8T1IUkhYC5Ok+6+izz/v45K/NmJxvv
	 i/0RPFHyV7v+40ZUXld4J4elUYcj/KD9N7zoSCJn9RKUZzCKH+P67XpveWtsZZu7pB
	 6QUCsjCLfVZZcoZP5F1R+B9FlzQjfnNMX2B8af2OReUW5vWnpS/RJ98oGhhs3dCbTn
	 GqR1o+jNnq89v37hD7zq1BCqfdzIXWqz0aKh+fQBUWlZKSd5OrXmmRtMLtJ6pyQbf4
	 +oOYXn18Rqp9Q==
Date: Sun, 22 Nov 2026 02:08:51 +0000
To: Alexey Charkov <alchark@flipper.net>
From: Ryan Leung <untilscour@protonmail.com>
Cc: Rob Herring <robh@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Michael Walle <michael@walle.cc>, Miquel Raynal <miquel.raynal@bootlin.com>, Finley Xiao <finley.xiao@rock-chips.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/4] nvmem: Derive Rockchip MAC addresses from the OTP CPU ID
Message-ID: <RWg2ZbGh-TJtEJMDWD9DGxBKsszG10BM07351ALdCUa9UL-IImPGxSYztcNF3kiRFVCA0x5cECwign-2lb56nPMGZQ5LVZhckY4-KTb5qpk=@protonmail.com>
In-Reply-To: <AQpdyd6hRl9cLAxBK-fEdzq0dcZsWpHP63dbDpOxcNQWCdaNIc4D3Mfi9Ll86jBVsbEVhr5-9EZzFHbkF6efBDcRUT7nXx9TH5Aeffy5DyU=@protonmail.com>
References: <20260902-rk3576-otp-cpuid-mac-v2-0-e4b7fe2ab13f@flipper.net> <CAKTNdwH9QAgreJ-6+t1j_P1di4VyoMBSsFkf_g=mCi_-M8g9Pw@mail.gmail.com> <20260917221857.GA4056431-robh@kernel.org> <CAKTNdwH6E5=9gZHB6tdianC2+1aDv4wnLmvL59kDW-dR3a12bg@mail.gmail.com> <AQpdyd6hRl9cLAxBK-fEdzq0dcZsWpHP63dbDpOxcNQWCdaNIc4D3Mfi9Ll86jBVsbEVhr5-9EZzFHbkF6efBDcRUT7nXx9TH5Aeffy5DyU=@protonmail.com>
Feedback-ID: 184418679:user:proton
X-Pm-Message-ID: 7c823cd84927e819292d16fce6b08949de0d11f8
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Alexey,

On Wednesday, November 18th, 2026 at 10:51 PM, Ryan Leung <untilscour@proto=
nmail.com> wrote:

> On Friday, September 18th, 2026 at 3:08 PM, Alexey Charkov <alchark@flipp=
er.net> wrote:
>=20
> > Hi Rob,
> >
> > On Fri, Sep 18, 2026 at 2:19=E2=80=AFAM Rob Herring <robh@kernel.org> w=
rote:
> > >
> > > On Thu, Sep 10, 2026 at 06:48:33PM +0400, Alexey Charkov wrote:
> > > > On Wed, Sep 2, 2026 at 5:08=E2=80=AFPM Alexey Charkov <alchark@flip=
per.net> wrote:
> > > > >
> > > > > Rockchip SoCs are shipped with a unique CPU ID in their internal =
OTP
> > > > > memory, and Rockchip bootloaders use it to give boards which have=
 no
> > > > > dedicated storage for a MAC address a stable one anyway: they has=
h the CPU
> > > > > ID and patch the resulting addresses into the device tree they ha=
nd over.
> > > > >
> > > > > Kernels started without that fixup, e.g. straight from the SPL in=
 Falcon
> > > > > mode or by any other loader which does not implement Rockchip's d=
erivation,
> > > > > fall back to random MAC addresses which change on every boot.
> > > > >
> > > > > Formalize the derivation in the DT binding and add a Linux kernel=
 driver
> > > > > implementing it, so that a Linux image can use the same stable ad=
dresses
> > > > > regardless of the boot flow.
> > > > >
> > > > > Only RK3576 is wired up here, that being the SoC I can test on. O=
ther
> > > > > Rockchip SoCs keep the same CPU ID at a different OTP offset - 0x=
7 rather
> > > > > than 0xa on RK3588, for instance - which makes supporting them a =
two-line
> > > > > addition to the driver's match table plus the layout node.
> > > > >
> > > > > Patch 1 is a prerequisite fix. The OTP hardware has its own inter=
nal state
> > > > > machine which only works correctly with serial access, but the cu=
rrent
> > > > > driver serializes nothing, which results in timeouts and/or corru=
pted
> > > > > reads (e.g. returning splicing a TSADC trim value into the buffer=
 of a
> > > > > caller asking for the CPU ID, or mixing up trim values of differe=
nt TSADC
> > > > > callers). Hence the Fixes: tag and Cc: stable.
> > > > >
> > > > > Cross-checked on an RK3576 board: the addresses fixed up into the=
 FDT by
> > > > > U-Boot match the ones derived by the new driver, and the driver c=
orrectly
> > > > > assigns them to the network interfaces when the kernel is booted =
without
> > > > > U-Boot proper at all (via Falcon mode).
> > > > >
> > > > > Sashiko also rightly pointed out a use-after-free in the nvmem co=
re when
> > > > > a layout driver is unloaded leaving its sysfs nodes and the postp=
rocessor
> > > > > function pointer dangling. This is fixed separately in [1].
> > > > >
> > > > > [1] https://lore.kernel.org/all/20260902-nvmem-layout-unreg-v1-1-=
2d16bebeb518@flipper.net/
> > > > >
> > > > > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > > > > ---
> > > > > Changes in v2:
> > > > > - Switched from a scope-based guard to explicit lock/unlock calls=
 in the
> > > > >   OTP driver to avoid mixing styles in a function using goto erro=
r
> > > > >   handling (Sashiko)
> > > > > - Link to v1: https://patch.msgid.link/20260901-rk3576-otp-cpuid-=
mac-v1-0-ea9135270fc2@flipper.net
> > > > >
> > > > > ---
> > > > > Alexey Charkov (4):
> > > > >       nvmem: rockchip-otp: Serialize reads
> > > >
> > > > Incidentally, patch 1 of this series also fixes CPU thermal throttl=
ing
> > > > on my RK3576 device: apparently, the mis-read OTP-programmed therma=
l
> > > > trim values broke the thermal governor logic, which now works
> > > > correctly with properly serialized OTP reads. So it would be great =
to
> > > > have these merged.
> > >
> > > It would be great to have the sashiko comments analyzed and replied t=
o
> > > as well if you would like this to be reviewed.
> >
> > Of course. One code-related comment Sashiko raised has been addressed
> > in a separate patch [1] which is still pending review. The
> > binding-related comments will need to be revisited, as I'd like to
> > first explore the idea Ryan proposed in the adjacent thread [2], as it
> > will change the approach somewhat if it works out.
> >
> > Best regards,
> > Alexey
> >
> > [1] https://lore.kernel.org/all/20260902-nvmem-layout-unreg-v1-1-2d16be=
beb518@flipper.net/
> > [2] https://lore.kernel.org/all/20260916123355.4507-1-untilscour@proton=
mail.com/
>=20
> Hi Alexey,
>=20
> Have you had a chance to explore this? I have got a working proof of
> concept [1] for the format I suggested, tested on RK3576 (NanoPi M5) and
> RK3528 (NanoPi R28S).
>=20
> Best regards,
> Ryan
>=20
> [1] https://github.com/untilscour/openwrt/commit/a622c1cf292f7a4bb7093521=
e25436be324fc1a4

I've updated [1] the proof of concept slightly. Perhaps you are busy
with other patches? As it's been more than 2 months, if you don't mind,
I'd like to send it in as v3 of this series, with you as co-author.

Best regards,
Ryan

[1] https://github.com/untilscour/openwrt/commit/6686af2f6475f6cc9d1c1fb37c=
d8855845f754db
