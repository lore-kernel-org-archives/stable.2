Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ACC443E3B;
	Tue, 21 Jul 2026 23:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784676883; cv=none; b=f3i1M4k/NcNjUChVmlzHV6TB2DQSTNNg+jaijcerL5EniEDOfU6r/cJi2mEAryF7XdrI7W/rxsrPxJ/MLGHkUwgEr9hNsc4mkDSnaEuVWcz8ZolisFRoRI/AGJCEYpEQ6QlR597VgZFCk7bM4X0dN8/y27bandW2j+VS4Cf2Zh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784676883; c=relaxed/simple;
	bh=Nc4WY14ZOG9b3cMEtUSTkLaMCAnOejtKaABYyofBm5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/kVC1JVA3DzYfTUAmC/bRwK4ZtUlRYI7YXoJRXMuJOX2Ikzi8TcoEdRyiU68DQYOoppxXojFKZmlKWwfUzGO0iOqR71u8B9sC/KZpli0wWzvYlEYBnv+v+iy+455lHzu3ReBoCagJDsJIebtuwKW1/WrlaFwzj6L+dXN5N1+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxveD9ff; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxveD9ff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C173B1F000E9;
	Tue, 21 Jul 2026 23:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784676881;
	bh=cv958Pfgp7GUM/xVymrAwRNqVH7beklVxrmbR/6/w9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JxveD9ffXTtbXb5I0bpaEeHuMDG/QnEyEuexLu/O2UvTTyhDYrpGnyQgBauldXR3j
	 gj0SJH1MbDTpU/+pUxCwEBMpz1iNLlsAPXrDyeKFISU8X1kuYYK02QR3ibjuUrHvwt
	 d6G9B71nlgcR+PtrqmE41sZKLGYlOCaKbRIdEVy1dTngToRLRqJi7e1zmXRrnpHnTH
	 lgJV8ztUMmBY42gGr5b/zPLvzPaYfXbSNXPw1BTZHU3k0MUt65MRa2T56jvvFRn44Z
	 oXhthrS7UJj303+JbZCS3skzcQw0J2v2mBpq41DkR7d+W8EVV9TBh4xK6P8mqQ2cCv
	 kkeHZLAX/cNAQ==
Received: by venus (Postfix, from userid 1000)
	id 339D2180765; Wed, 22 Jul 2026 01:34:40 +0200 (CEST)
Date: Wed, 22 Jul 2026 01:34:39 +0200
From: Sebastian Reichel <sre@kernel.org>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: jens.glathe@oldschoolsolutions.biz, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/5] usb: typec: ps883x: fixes for older Thunderbolt 4 /
 USB4 docks
Message-ID: <al_0LjwmfW-cECnY@venus>
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
 <al6-IyyWYRnEW4VC@venus>
 <al-dJjzorP-I4Yff@gallifrey>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pugdf46x7r7xbl4p"
Content-Disposition: inline
In-Reply-To: <al-dJjzorP-I4Yff@gallifrey>


--pugdf46x7r7xbl4p
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/5] usb: typec: ps883x: fixes for older Thunderbolt 4 /
 USB4 docks
MIME-Version: 1.0

Hi,

On Tue, Jul 21, 2026 at 04:24:06PM +0000, Dr. David Alan Gilbert wrote:
> * Sebastian Reichel (sre@kernel.org) wrote:
> > On Sat, Jul 18, 2026 at 07:06:28PM +0200, Jens Glathe via B4 Relay wrot=
e:
> > > On Qualcomm X1E80100 platforms (e.g. Lenovo ThinkPad T14s Gen 6)
> > > using the Parade PS883x retimer, connecting USB4-capable docks such
> > > as the Lenovo 40B0 via a regular Type-C cable (which forces the dock
> > > into Type-C fallback mode) often results in working USB but no
> > > DisplayPort output.
> > >=20
> > > This series addresses the issue with two main changes:
> > >=20
> > > - Add a new optional DT property "parade,disable-usb4". When present,
> > >   the PS883x driver rejects USB4 mode (-EOPNOTSUPP). This forces the
> > >   Type-C stack to fall back to USB3 + DP Alt Mode, which works
> > >   reliably with the 40B0.
> > >=20
> > > - Refactor DP altmode handling to also support the legacy
> > >   TYPEC_DP_STATE_F request (deprecated since DP Alt Mode 1.0b) sent by
> > >   the 40B0 and other docks (e.g. SSK SC220).
> > >=20
> > > - Add a short delay after writing configuration registers, which
> > >   improves hotplug reliability.
> > >=20
> > > This is a temporary workaround until full USB4 DP tunneling support is
> > > available in the X1E USB4 controller and qmp-combo PHY stack.
> > >=20
> > > Note: The DT patch adds the new property to all currently upstream
> > > boards using the PS883x retimer (15 files). Happy to split it on v2
> > > if requested.
> >=20
> > I don't think a kernel driver limitation is a good reason for the DT
> > property. I suggest to add something like this in the ps883x driver
> > instead:
> >=20
> > /*
> >  * Hamoa does not yet support USB4, disable it for now to gracefully
> >  * fall back to USB3 + DP AltMode. This should be removed once USB4
> >  * support landed for X1E.
> >  */
> > if (of_machine_is_compatible("qcom,x1e80100"))
> >     disable_usb4 =3D true;
>=20
> It seems a bit of a weird abstraction break to put a machine type
> check down in a device that's not specific to qcom.

It's obviously a hack, but this quirk would be simple and fully
contained within the kernel and thus does not create a new ABI (in
opposite to the DT property). Once the kernel supports USB4 on Hamoa
it could simply be dropped and people have working USB4 with their
existing DT.

> I'd bet it's not just qcom's suffering from this as well.

Qcom boards are the only users of ps883x (the driver is exclusively
probed via DT at the moment). So right now one could also simply
remove any USB4 support from ps883x, but that would work against the
people working on _adding_ proper USB4 support.

IIUIC the problem is, that the Qcom board supports USB4, negotiates
this via the PD protocol and then soft-fails because the software
support is not yet ready. Most other ARM platforms do not have any
USB4/Thunderbolt hardware support to begin with and wouldn't
negotiate it, so they do not run into this in the first place.

AFAIK only Qcom and Apple M series support it. A quick search
suggsts Apple used an Intel retimer in the past and a custom one
nowadays. From the looks of it the x86 world cannot use this driver
either and probably handles retimers transparently in ACPI, so it's
effectively Qcom specific until other vendors start adding USB4
support. The only thing announced potentially running into this
would be the Nvidia RTX Spark, which first needs to be released,
then find a bunch of people motivated to implement upstream support.
Nothing with USB4 capabilities has been announced from Mediatek or
Rockchip. So I wouldn't hold my breath for another user and still
suggested adding the machine check instead of simply disabling USB4
for everyone ;)

Greetings,

-- Sebastian

--pugdf46x7r7xbl4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpgAggACgkQ2O7X88g7
+prddRAAhL4NyRbROef+dbWH0+QaDvk9eCLvX99NubMXCloYyIVGfR41nxlMt49+
7a70KAC+BGtNhJNOX2oGuwyQWuSMvicojed9x/Wwn8aCkjWylz8gVhC4ffnfQTD0
OZo/q1d/IDZ95f7F+zfKTveevqaDLzhq3om/8gM7Z15NB14LV1fFz7N9SVK+9DkV
ZLvQMjf1dwOaCg0/7hdBNk8M1jAVkcDfR+gkh0kcsya0F/5MnwxhLv/gM/3hGYNJ
Dwfjk9EZslE3MZVIsdsUtyWutwhrdUj6V3OOCGKvEE9TjEyDu/zVDEUTRVWIK8v4
MsRT0+SsBSM0YPlU/FT8D56CJ2LOFUoqWnw29UJewMxnflQ54Bxe3cAnZ2bGxFD0
/XDJUCASrkmzR8YQvJhgTQUCBFv0Wfou2dWjMHql2kWr4Xc7ABOhHxV1tHkuJhFx
kj/dZsVu3vJj3JFomyHn27G3qjNcJsAjHPhkfrgVtxqDHFW3/GlkXOO/2wQQMCmQ
T7G/jR8+sjcBFXlhf3Ncx61UasAIsASOICyDqIi43wYXfO8mQsr/6vsMaWCM3AYW
+hy0y5SoxdwCJ5XMTNVml5a6IflJyrL6oBnpBMB+5wR3dDuY0c7D4bgCtkDlexdD
3DsaLUgcOj4tx8ljd1T9/xS6yq3Syj8CMZ0H2OZorgxql8++9Mk=
=PakO
-----END PGP SIGNATURE-----

--pugdf46x7r7xbl4p--
