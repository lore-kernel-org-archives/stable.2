Received: from mail-24426.protonmail.ch (mail-24426.protonmail.ch [109.224.244.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A8A3644A4;
	Wed, 16 Sep 2026 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562063; cv=none; b=AU51C24wd3ndDwReMmWNlr9V9dA0jRdVT3yg8DHW/agGZUQFwXn8be2GggTdeigeU20ehPvhmeToUKUhdpvDTEh4Wj1y0DrptjnuEPpApdhexE/ucgm4D/oATI5C6wnul0pdUhDUVBN/1cRHaG4JIWLB4buJd6mpJ/CapuDsyds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562063; c=relaxed/simple;
	bh=Afuig7NdFAQ5XnHoQ8HzWcRJNPh6Fl9+Itbf/eok9q4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Gesjrot++J+OZfCCWpfmb9bBGCzkijbVzZuuijGy2jSqTE2E1q1VbMr6cZXt3dlDd5vNp6ZPo3dnsNUtgTuf918iK0u8b4SeJQHNaEqe04N/IOiQOIP//Vin4MjLoLbTEGIRwNQycLZOVARQoxCH5poRZipqW+92VzZYOG8Q/TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=eP2m+BlE; arc=none smtp.client-ip=109.224.244.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="eP2m+BlE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1789562053; x=1789821253;
	bh=Afuig7NdFAQ5XnHoQ8HzWcRJNPh6Fl9+Itbf/eok9q4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=eP2m+BlEvnRBrC/brOvZjY6UgP/qCQldM5DvoCG7JLV9JBIvU4ZGAaPX9W2JVoCox
	 rgezLkqCrnJSjqZ9V9/PyycraBGBY7KiyhbylIKQlwvYxdF7edtQRRBU0FeK/gxRGd
	 NPVlK5yNhuzmr2cZuPp7vjgLmQoJ6hInKyadsyAiIlVFPdtRu5mqq5DGig4F5Ztv9o
	 Q7zsNnWcWCaHSobu+fHsW0/3anH/bGqPA5SuJ9Ox326TfjiM6Mi0fKXnC/Y5R6BhhG
	 feY/S9Z8E/gNX7FsY8aPPeF8tpHV4R4IdMiFByxjbXg1n9DduEx4uHjZYF6daaQyFb
	 5Azk+iiGN8Htw==
Date: Wed, 16 Sep 2026 12:34:06 +0000
To: ricardo@pardini.net, alchark@flipper.net
From: Ryan Leung <untilscour@protonmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, finley.xiao@rock-chips.com, gregkh@linuxfoundation.org, heiko@sntech.de, krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, michael@walle.cc, miquel.raynal@bootlin.com, robh@kernel.org, srini@kernel.org, stable@vger.kernel.org, untilscour@protonmail.com
Subject: Re: Re: [PATCH v2 0/4] nvmem: Derive Rockchip MAC addresses from the OTP CPU ID
Message-ID: <20260916123355.4507-1-untilscour@protonmail.com>
Feedback-ID: 184418679:user:proton
X-Pm-Message-ID: e5075cf7b5d4595542ae7b0ca159d512ead7b50d
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ricardo, Alexey,

> On 02/09/2026 15:07, Alexey Charkov wrote:
> > Rockchip SoCs are shipped with a unique CPU ID in their internal OTP
> > memory, and Rockchip bootloaders use it to give boards which have no
> > dedicated storage for a MAC address a stable one anyway: they hash the =
CPU
> > ID and patch the resulting addresses into the device tree they hand ove=
r.
> >=20
> > Kernels started without that fixup, e.g. straight from the SPL in Falco=
n
> > mode or by any other loader which does not implement Rockchip's derivat=
ion,
> > fall back to random MAC addresses which change on every boot.
> >=20
> > Formalize the derivation in the DT binding and add a Linux kernel drive=
r
> > implementing it, so that a Linux image can use the same stable addresse=
s
> > regardless of the boot flow.
> >=20
> > Only RK3576 is wired up here, that being the SoC I can test on. Other
> > Rockchip SoCs keep the same CPU ID at a different OTP offset - 0x7 rath=
er
> > than 0xa on RK3588, for instance - which makes supporting them a two-li=
ne
> > addition to the driver's match table plus the layout node.
> Hi Alexey,
>=20
> I went off trying this on RK3588 and - exactly like you said - it=20
> translates perfectly there, just with a different offset. Thanks!
>=20
> Not content, I went for RK356x as well - and that revealed what I think=
=20
> is a snag.
>=20
> Both RK3576 and RK3588 currently describe their fixed cells as direct=20
> children of the OTP node -- turns out that is the "legacy" way, which=20
> works due to 'add_legacy_fixed_of_cells'.
>=20
> But RK356x/3528/3562, done more recently [1], use a single=20
> 'fixed-layout' with child cells; and there can only ever be one layout,=
=20
> so we wouldn't be able to use the new layout for those.
>=20
> I imagine one way around it would be to allow such fixed cells also=20
> under the new layout, by delegating to 'nvmem_add_cells_from_dt()' and=20
> adding patternProperties with '$ref: fixed-cell.yaml' in the binding,=20
> similar to what fixed-layout.yaml does, but I'm unsure that would be a=20
> good idea?
>=20
> Either way, thanks for this, it really helps with Falcon mode and edk2;=
=20
> I can also use it for the fixed-function RTL8125 PCIe NICs I started=20
> describing [2] (and will eventually send a v5).
>=20
> [1] https://lore.kernel.org/all/20260312213019.13965-3-heiko@sntech.de/
> [2]=20
> https://lore.kernel.org/linux-rockchip/20260617-rk3588-dts-rtl-eth-descri=
be-dt-alias-v4-0-2bd38922d129@pardini.net/
>=20
> mvg,
> Ricardo

What about changing the driver to handle something like:

=09otp: otp@... {
=09=09compatible =3D "rockchip,rk3528-otp";

=09=09#address-cells =3D <1>;
=09=09#size-cells =3D <1>;

=09=09nvmem-layout {
=09=09=09compatible =3D "fixed-layout";

=09=09=09#address-cells =3D <1>;
=09=09=09#size-cells =3D <1>;

=09=09=09otp_id: id@a {
=09=09=09=09reg =3D <0x0a 0x10>;
=09=09=09};
=09=09};
=09};

=09otp_mac: otp-mac {
=09=09compatible =3D "rockchip,otp-cpuid-mac";

=09=09nvmem-cells =3D <&otp_id>;
=09=09nvmem-cell-names =3D "source";

=09=09#address-cells =3D <1>;
=09=09#size-cells =3D <1>;

=09=09otp_mac_address: mac-address@0 {
=09=09=09reg =3D <0 0x10>;
=09=09=09#nvmem-cell-cells =3D <1>;
=09=09};
=09};

using devm_nvmem_cell_get("source") to read the otp cell.

Then a match table would not be necessary and it would work with every
SoC, even those without the fixed-layout nvmem, because of
add_legacy_fixed_of_cells as you mentioned.

Best regards,
Ryan

