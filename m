Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F102449B12;
	Tue, 21 Jul 2026 00:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784594634; cv=none; b=dwFdHwnNXtZIqgVOHaEQ2NjmuCUbHvT/dex7cnpfVzTdbZnPo9UgLJPNbfy2+16me2UxZolWSvhnn4zPbAWAhLAB6TWrVjLTn2Gp57ZQIM8lr1KF6vWyH1svoMDlX8wL1BtMSGtV2zYH5Xb2FBctHr4MkkUby+fF1C25CX8hkBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784594634; c=relaxed/simple;
	bh=cbUUJ+eotvRm5zqUM2Kx6OHXTRyJBbLTfUabYVaGVJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUM3a/7ivqmgD8ZCMd3ZaT+2T+bOLM+Vrl5UDWx1XxR/+rMlGFDh57QSnDTcpd/hLdwa6JXFaNhSW3TcaPsxQBDj+xemPkfHiZsi3YbYNowm2XURAKjTNTfroSUDFzaNxnjxlRhDMNQk4VSM1VYDXiPG6J6WNvRXPPGnHxp6ZOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcUB+xYs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcUB+xYs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AA41F000E9;
	Tue, 21 Jul 2026 00:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784594633;
	bh=Fd7hZsvKd8rP/mpwq0Fu3nIETh38pakepxFmYnJYgxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RcUB+xYsd+/61NPi9gClvOM297EcDNaD3cip6fmFmafrbDFc35548GifLazPnBIE7
	 72vA+A031otpSAV4CSK+7zxnl39hBheSrMIj7rf28bo3naMhrR8q+QkGuM8jywBGR4
	 AqpSba3upqKYQrEzeW3hU0sGclvpreircWESkf0H82zqO9yaDa0k9BJn8dotvaK0EI
	 GeiIrJLVP1s7Pa+aqCtPZvpT328JqaMzeFYs3wWz5EkBky1sTrjnNjtssxjeKeIZtX
	 OcUS/+XPTeE0NzhhVj1Di4KN66SZIzu6KY0gNXvf6K/lEvTSuZoaQD4RO2AerjPzXy
	 z7/oXCTWCFw6Q==
Received: by venus (Postfix, from userid 1000)
	id CF0C81804CE; Tue, 21 Jul 2026 02:43:51 +0200 (CEST)
Date: Tue, 21 Jul 2026 02:43:51 +0200
From: Sebastian Reichel <sre@kernel.org>
To: jens.glathe@oldschoolsolutions.biz
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, stable@vger.kernel.org, 
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 0/5] usb: typec: ps883x: fixes for older Thunderbolt 4 /
 USB4 docks
Message-ID: <al6-IyyWYRnEW4VC@venus>
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fkc6jiysmodswgij"
Content-Disposition: inline
In-Reply-To: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>


--fkc6jiysmodswgij
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/5] usb: typec: ps883x: fixes for older Thunderbolt 4 /
 USB4 docks
MIME-Version: 1.0

Hello,

On Sat, Jul 18, 2026 at 07:06:28PM +0200, Jens Glathe via B4 Relay wrote:
> On Qualcomm X1E80100 platforms (e.g. Lenovo ThinkPad T14s Gen 6)
> using the Parade PS883x retimer, connecting USB4-capable docks such
> as the Lenovo 40B0 via a regular Type-C cable (which forces the dock
> into Type-C fallback mode) often results in working USB but no
> DisplayPort output.
>=20
> This series addresses the issue with two main changes:
>=20
> - Add a new optional DT property "parade,disable-usb4". When present,
>   the PS883x driver rejects USB4 mode (-EOPNOTSUPP). This forces the
>   Type-C stack to fall back to USB3 + DP Alt Mode, which works
>   reliably with the 40B0.
>=20
> - Refactor DP altmode handling to also support the legacy
>   TYPEC_DP_STATE_F request (deprecated since DP Alt Mode 1.0b) sent by
>   the 40B0 and other docks (e.g. SSK SC220).
>=20
> - Add a short delay after writing configuration registers, which
>   improves hotplug reliability.
>=20
> This is a temporary workaround until full USB4 DP tunneling support is
> available in the X1E USB4 controller and qmp-combo PHY stack.
>=20
> Note: The DT patch adds the new property to all currently upstream
> boards using the PS883x retimer (15 files). Happy to split it on v2
> if requested.

I don't think a kernel driver limitation is a good reason for the DT
property. I suggest to add something like this in the ps883x driver
instead:

/*
 * Hamoa does not yet support USB4, disable it for now to gracefully
 * fall back to USB3 + DP AltMode. This should be removed once USB4
 * support landed for X1E.
 */
if (of_machine_is_compatible("qcom,x1e80100"))
    disable_usb4 =3D true;

Greetings,

-- Sebastian

> As an additional observation, the same dock with type-c cable works well
> on Thinkpad X13s, Thinkbook 16 G7 QOY, Ideapad 5 14Q8X9, but doesn't need
> the ps883x changes (naturally).=20
>=20
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> ---
> Jens Glathe (5):
>       dt-bindings: usb: parade,ps8830: Add parade,disable-usb4 property
>       usb: typec: ps883x: Return -EOPNOTSUPP for USB4 when parade,disable=
-usb4 is set
>       usb: typec: mux: ps883x: refactor DP altmode handling and support T=
YPEC_DP_STATE_F
>       usb: typec: mux: ps883x: add a delay after writing config regs
>       arm64: dts: qcom: x1: disable ps883x USB4 capability
>=20
>  .../devicetree/bindings/usb/parade,ps8830.yaml     |  6 +++
>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts         |  4 ++
>  .../qcom/hamoa-lenovo-ideacentre-mini-01q8x10.dts  |  2 +
>  arch/arm64/boot/dts/qcom/purwa-iot-evk.dts         |  6 +++
>  arch/arm64/boot/dts/qcom/x1-asus-vivobook-s15.dtsi |  4 ++
>  arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi  |  4 ++
>  arch/arm64/boot/dts/qcom/x1-crd.dtsi               |  6 +++
>  arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi        |  4 ++
>  arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi   |  2 +
>  arch/arm64/boot/dts/qcom/x1-microsoft-denali.dtsi  |  4 ++
>  arch/arm64/boot/dts/qcom/x1e001de-devkit.dts       |  6 +++
>  .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    |  4 ++
>  .../boot/dts/qcom/x1e80100-dell-xps13-9345.dts     |  4 ++
>  .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  |  6 +++
>  .../dts/qcom/x1e80100-medion-sprchrgd-14-s1.dts    |  2 +
>  .../boot/dts/qcom/x1e80100-microsoft-romulus.dtsi  |  4 ++
>  drivers/usb/typec/mux/ps883x.c                     | 47 +++++++++++++++-=
------
>  17 files changed, 100 insertions(+), 15 deletions(-)
> ---
> base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
> change-id: 20260718-ps883x-disable-usb4-19b0fc13b5ab
>=20
> Best regards,
> --=20
> Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>=20
>=20
>=20

--fkc6jiysmodswgij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpewMMACgkQ2O7X88g7
+powWBAAol0/PBJ1eXYYjlNiwB7qCbCecEfZTULQrX4zFmaA3o1MaYHhWFBR2WlK
L74HXVNCoFn/IDQV0U4qDy15RPrOAr+NLj2sdyr6jqHx54IPi3OBHumGmEWrJmAO
EGvtyp/AJb5mt7cvLlOoZukTcqgEP/oKgufLnER4KfHzcemjWMmcspzbOpz3648z
7igV6sjiF0IoxzrzZKhWLKu12UWAPZE6BsrI/J2v3oojgJShxBZPaD+QblK7M4ME
/b8tSYxWIVMiHCKQVebR4ZGyjEbMW5FvMYqZ3+H7otYTZu3VniPu8C/XSyohj3fy
wxN/lOUOrSeM9uTaQWUjgQIongdBLc5gEoWQCp1U512bKCXkozn1UQThc5raqhoa
wbTD/ZMioGLf//hOBk1FT+Gq/O+SEABPcMQ2zmHvHF8Pueeld7QuFU8Pd9dCbY5b
/k7VlT/sKkJ0EvRZ6eEtdqCthk855FAvDQPS6Y3cVTfurlobnXPR7saZ7sR8AEne
letJqKFPNXGMC5LQA7EdoQxNHU0lmYLeHsTKiDRvI34YluwsRvRH1fR/B7ipB150
/bkqIu+I88a/9DFFBbkcr1+QUYxRdFTFnG5bNew6BqIUQrBA/GeqOOXGQ2BMm4cQ
8l0Mblkqr3Gv3ZoZIx5R784zqBlD/3CwR3SwhU4nOF3Z8z5GMdc=
=lVu4
-----END PGP SIGNATURE-----

--fkc6jiysmodswgij--
