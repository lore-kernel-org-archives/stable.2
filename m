Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385D24749E1;
	Wed, 22 Jul 2026 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736200; cv=none; b=J17m72UcZ4lQsGvM2Dukcny8vqelx31aCGO456f6oQVBdbpMeZrrHPlZj4YD7xNMLxFZDqfW0ve/I+cJxQDW1jqBRZx4W7Ov5J+Y48gIKRzGE2WVFo/phu2/4jeFFH3e9LB8Rbuoj2ihaJ61hcgN6wLN1fwivx3mIbsJG3yJXJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736200; c=relaxed/simple;
	bh=3JshwvYSGmdmPVT0eS9/vpcUAfew6p/8glliOI2QBIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AA5e1GMA0+izAdQvO83WhqyGCQG7iXSVhQZtTawCXfgQlYElvx9uEOmHXyAfm46vUJw1j+mpNVuM3UsEkHL1b+s1xPCQyXb/9L3QSM16IFram9odPLIM0tK2SGsSkEbILpT3BtnXaNFGdHnpccUX+yoYYO7pXX/4I2HUUo38aBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpPfvu7n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpPfvu7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BDF1F000E9;
	Wed, 22 Jul 2026 16:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736198;
	bh=XVF6iboHpx/dJTK18UoKC6gB7U14XwiMPQNnAKiOLzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WpPfvu7noZMjNHBdfUsuCGidsqrQjqSkT1af6eWYCHiAtBK7tASHCjOXQ3ULbKxDW
	 mM0TAnrBvwQ0U8002WgR0np6zhlHFW0DyWRA3j2UYixg6WfVaaBYyMSH+iDA7RCw0b
	 y5OVSTK59g0nQS9T3rcjoPVZJLy8SksDaLZiwSyC/fC9dV1YeZORDvgH1thhc82pcN
	 aIYFm734Inxq51XVkaGgkpa9/zoRSG9lMCSW59sG7EiLKjrvxjbJZyHkWVPXDAi3Yb
	 38sN8wtvXmJHmge1B1XSmmz0ikvsHsUXzlc6LCx4/ysU1vEDgN26Fy6t+HaUe0sLUc
	 Xek9zfQQPnAnA==
Received: by venus (Postfix, from userid 1000)
	id 5A67E18090F; Wed, 22 Jul 2026 18:03:16 +0200 (CEST)
Date: Wed, 22 Jul 2026 18:03:15 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/5] usb: typec: ps883x: fixes for older Thunderbolt 4 /
 USB4 docks
Message-ID: <amDi7e8fqqzCRlAc@venus>
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
 <al6-IyyWYRnEW4VC@venus>
 <al-dJjzorP-I4Yff@gallifrey>
 <al_0LjwmfW-cECnY@venus>
 <41222b67-19e5-4f74-b4aa-928d05db9675@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ithrsve4yere6oyx"
Content-Disposition: inline
In-Reply-To: <41222b67-19e5-4f74-b4aa-928d05db9675@oldschoolsolutions.biz>


--ithrsve4yere6oyx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/5] usb: typec: ps883x: fixes for older Thunderbolt 4 /
 USB4 docks
MIME-Version: 1.0

Hi,

On Wed, Jul 22, 2026 at 10:38:34AM +0200, Jens Glathe wrote:
> On 7/22/26 01:34, Sebastian Reichel wrote:
> > On Tue, Jul 21, 2026 at 04:24:06PM +0000, Dr. David Alan Gilbert wrote:
> > > * Sebastian Reichel (sre@kernel.org) wrote:
> > > > I don't think a kernel driver limitation is a good reason for the DT
> > > > property. I suggest to add something like this in the ps883x driver
> > > > instead:
> > > >=20
> > > > /*
> > > >   * Hamoa does not yet support USB4, disable it for now to graceful=
ly
> > > >   * fall back to USB3 + DP AltMode. This should be removed once USB4
> > > >   * support landed for X1E.
> > > >   */
> > > > if (of_machine_is_compatible("qcom,x1e80100"))
> > > >      disable_usb4 =3D true;
> > > It seems a bit of a weird abstraction break to put a machine type
> > > check down in a device that's not specific to qcom.
> > It's obviously a hack, but this quirk would be simple and fully
> > contained within the kernel and thus does not create a new ABI (in
> > opposite to the DT property). Once the kernel supports USB4 on Hamoa
> > it could simply be dropped and people have working USB4 with their
> > existing DT.
> >=20
> > > I'd bet it's not just qcom's suffering from this as well.
> > Qcom boards are the only users of ps883x (the driver is exclusively
> > probed via DT at the moment). So right now one could also simply
> > remove any USB4 support from ps883x, but that would work against the
> > people working on _adding_ proper USB4 support.
> >=20
> > IIUIC the problem is, that the Qcom board supports USB4, negotiates
> > this via the PD protocol and then soft-fails because the software
> > support is not yet ready. Most other ARM platforms do not have any
> > USB4/Thunderbolt hardware support to begin with and wouldn't
> > negotiate it, so they do not run into this in the first place.
> >=20
> > AFAIK only Qcom and Apple M series support it. A quick search
> > suggsts Apple used an Intel retimer in the past and a custom one
> > nowadays. From the looks of it the x86 world cannot use this driver
> > either and probably handles retimers transparently in ACPI, so it's
> > effectively Qcom specific until other vendors start adding USB4
> > support. The only thing announced potentially running into this
> > would be the Nvidia RTX Spark, which first needs to be released,
> > then find a bunch of people motivated to implement upstream support.
> > Nothing with USB4 capabilities has been announced from Mediatek or
> > Rockchip. So I wouldn't hold my breath for another user and still
> > suggested adding the machine check instead of simply disabling USB4
> > for everyone ;)
> >=20
> > Greetings,
> >=20
> > -- Sebastian
>
> I understand, however I wouldn't want to nerf ps883x for the Hamoa
> platform until the USB4 stack is complete. The issues you
> currently run into is:

That's exactly what this series is doing and not really a problem
considering USB4 is not working anyways.

> - you use a tbt4 / usb4 cable and nothing works,
>=20
> - you have a tbt4 / usb4 capable device in fallback mode that does complex
> stuff when negotiating and firmware / a partial USB4 stack requests USB4,
> which ends up not working.
>
> Both cases are not the hardware's fault, it is capable of USB4. The driver
> stack isn't. Therefore I would prefer to deliberately disable USB4 modes =
by
> device via the DT.

DT is not a kernel config file. You can find that in .config. The DT
describes the hardware. Writing in DT "no-usb4" means that the
hardware does not support USB4. But the board files you are changing
can do USB4 in hardware. Thus the DT entry is wrong.

> That way it can fall back to re-negotiating something the driver
> stack is capable of. PS883x is not the place where this starts,
> but where it's convenient to stop.

I understand that part. That's why I suggested to just put the
disable_usb4 =3D true; in there without the DT check instead of
something completley differnt. That's exactly the same, except
that the information is fully contained within the kernel.

This is actually __less__ intrusive:

 - less code
 - there is no need to touch all board files
 - the hardware description stays correct
 - it does not create ABI (you are supposed to continue supporting
   the new flag also after known users dropped it)
 - affects the same devices (all X1E)
 - but automatically also affects newly added boards
 - it's easier to revert (no need to touch all board files)

If you don't want to have a hack, the proper fix would be to detect
that the follow-up stack is not capable of handlin USB4 and avoid
exposing it. I'm aware that this is a quite complex task and
considering USB4 is WIP anyways, I would go with the hack until
then.

> I did some tests without USB4 disabled and the 40B0 stack in
> type-c cable fallback mode, and most of the time it just works.
> Except for an unlucky plug, and despite it shouldn't request USB4,
> the request lands at the redriver. Disabling USB4 modes reliably
> let's it renegotiate.

I'm not doubting the result of the patch series and plan to test
with my TB capable Dell U2725QE later.

Greetings,

-- Sebastian

--ithrsve4yere6oyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpg6b8ACgkQ2O7X88g7
+poxKRAAhkOHIVGbE9bt/i28okHDL9qLEyOEBiNY9LxYpbyXnI4/iWgSIAfSsCFB
FqKtm/Wj+o3Y2SmGV7jpKElgDdE3+jyBSMr9rJCS9ZHwBA4Pvh7Mh5IIuUcEDo+N
isD6EOir1FXINNCIuFgC1zQVGljslyaGSblvBq73BdV2tu/KNKeVtp548fEeHWBW
8q1o7k618DqD9eKT2OOeD6K+Zsa07BFhelb1LiCujJbetJPTgqTZlIp9TYPVMdCt
HHButUW9kL4Mzlo3FIehJGwf0rslLNy9cTTwX/1bp97jBPDPzAY3Ylgj17YaXmZw
HZxq3sZkvEnDeUwuyautZxJdBI6Y1vrkMgk1N4W4C7j5UFP3IuumOgLvT49RZz92
PGZZBG7pIzAIXhCKZ1CGr0Q/M0VNmmmYcyCzSvQWEVJ3HjIkwjPOTyG5OAwX5TYe
awY8/TUlWPDo3TSnoKmOZrkiRGzzc4GeoVWb5KgDKq9EZr0tobF8FxFHJDYnSwGW
1G1MIHOzNpL9HUNKNV4uqGIpFTWT41pwx9RpsJTqu0a5DHwAZ4VyQfA9KOzPSVjv
iKRK5EJHKfwBD7xw4iOexmqPjL9TRx7zWjuANoSTxmhw8IRM5hZz/yZnuELcu0lh
VMWAxkkuh3udwqq+oSa/eIXK67ejr6XgXpfHyf5u9IvZaUtyRHk=
=cRMf
-----END PGP SIGNATURE-----

--ithrsve4yere6oyx--
