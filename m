Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792656817;
	b=QOxlbDSFWF5yfm/+jw3Xnd16BcIRSyXW52R49XR2XcVoyR3mWiV0cNcaf8vXM8I3hZM8
	 6RoFNYw9rxTEXGxo9cipQUPqPDfpe4zIVfV1gGDy1u5M6egBzybEHDAgD/6BOEzbyJhxQ
	 EKxRh4PABCdx9zou1LPcuCIVyhOmAjvZLsrl0PQnVJ14h21k73L3aCBTqlmy4Vz2rtcUg
	 TVqVeAWLLLw4S7EoiaDBBfFJwXrGVGtpkBkYh8XQEM0UZ+hBiRl9m5T+Air2C7Ld14VYF
	 BvVulvL3f2182z/K58D62ONrL0XQtChNNhVSjJKIEHJ7KDZ3NMSi2dVZY9CtvQ7nvfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792656817;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Hn94stfKvj8i1droBHm2wo/E94pjMfGrEhOxZCqr07Q=;
	b=tKmxjZC24kDmTXnDmRiwL7AWfA/RmB2l51WKu6Jp8yYGLlWWHmpebHG9orDOq6nVgS1B
	 sHdY5dRZ1NSNrmsTHQAlknEYe2DFg1DR3Vrltb4j5JbZVhLK+/laHoitB09QX9t+7Rpxn
	 mMjEdjwyocgT09IF+iTLqCD6GG9iIBv0h3+dsdztV79SFHCFUCpelmTelA6Gt0aYy585M
	 8Wd4hagUjko8sp0DivqLvTEwhePluuLmj/y59SoWVSuwt22+7bYkuLMXLfkZxzQ9R+vMC
	 Pp2TplnfDy0ZKoXG+F7v6VaemiPQmanW8HsM5p6DK8gUAUcqrTT4PDdm9+gj4zEwVOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="e6bexpq/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6F450606A31A;
	Thu, 22 Oct 2026 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e6bexpq/
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7D5251F000C1;
	Thu, 22 Oct 2026 08:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792656817;
	bh=Hn94stfKvj8i1droBHm2wo/E94pjMfGrEhOxZCqr07Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e6bexpq/OSf3BBoP7uOF2ezUjDjBfCFCCf+BXPvdMlg8K31ht7ddkAYHlX17CtxsW
	 YyUgfuoGa7cOE0J8McUX/pvAuzOcDiFpXnGNABSkkuOVzrEY06ipiRoWVfZqwG0T9M
	 bD08UF1z5+pAFsit4iF3DLzO3IXqZFnEOzrGyuN6tGqXGArpgGMVF4cF7m4/MyiZwQ
	 drki+9JXWoLPTnx59YWeFfsihkHuKQ/J0GucjFpgyoEZXBjquaIg3TIwORKi+diRZG
	 JwfzwnnrDo3Gzse5mghzFcm1cN3h6Xhaw3TollKVnMLXj9Fz7QyW9S/EtAuFaPLb2l
	 r/K1Bv9XKECLQ==
Date: Thu, 22 Oct 2026 10:13:34 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	"Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, Frank Li <Frank.li@oss.nxp.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Leonardo Costa <leonardo.costa@toradex.com>, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/8] of: property: Make fw_devlink follow GPIO, PWM
 and clock nexus maps
Message-ID: <atnE_Brn9gxwO3q7@monoceros>
References: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ofdufvh7sevdvg3p"
Content-Disposition: inline
In-Reply-To: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>


--ofdufvh7sevdvg3p
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/8] of: property: Make fw_devlink follow GPIO, PWM
 and clock nexus maps
MIME-Version: 1.0

On Tue, Oct 20, 2026 at 03:00:11PM +0200, Ernest Van Hoecke wrote:
> This series fixes an fw_devlink supplier-resolution problem reported by
> Leonardo Costa while using a Devicetree nexus to describe GPIO and PWM
> resources routed through an LVDS connector. Consumers referencing the
> nexus could remain deferred because fw_devlink linked them to the nexus
> rather than to the providers selected by gpio-map and pwm-map. [1]
>=20
> GPIO, PWM and clock consumer APIs use of_parse_phandle_with_args_map()
> to resolve specifiers through gpio-map, pwm-map and clock-map
> properties. The corresponding fw_devlink parsers use direct phandle
> parsing instead. Given a consumer which references a nexus, the consumer
> API and fw_devlink therefore resolve the reference to different nodes:
>=20
>   consumer API:  consumer -> nexus -> mapped provider
>   fw_devlink:    consumer -> nexus
>=20
> A nexus is a translation node rather than the resource provider and need
> not have a driver. The link to it can consequently remain unresolved and
> defer the consumer even though the mapped provider is available.
>=20
> Make the fw_devlink GPIO, PWM and clock parsers use the same map-aware
> resolver as their consumer APIs. The resolver also handles valid direct
> references by returning the original provider when no map is present.
> Use dedicated exact-name and suffix declaration macros to opt these
> bindings into map-aware parsing without changing unrelated property
> parsers. Retain GPIO's existing exclusions and compatibility handling.
>=20
> Since fw_devlink runs the resolver for every consumer when its device is
> created, patch 1 first fixes a stack buffer overflow in the resolver
> when the provider referenced by the consumer has more than
> MAX_PHANDLE_ARGS cells.
>=20
> The regression tests call the OF add_links operation and verify that a
> mapped reference creates exactly one link to the provider selected by
> the referenced map entry, not to the nexus. They also cover valid direct
> references. The GPIO tests exercise all property spellings recognized by
> fw_devlink, including the deprecated singular and unprefixed forms.
>=20
> The clock patch fixes aacc54c67869 ("clk: Add support for clock nexus dt
> bindings"), which has been in clk-next and linux-next with the same hash
> since next-20260907. There is no build-time dependency on it, but the
> clock patch should not reach mainline before it. The series applies to
> next-20261014.

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

I guess this will be merged via a dt tree and so doesn't need further
action from my side.

Best regards and thanks for caring about this issue,
Uwe

--ofdufvh7sevdvg3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrZxasACgkQj4D7WH0S
/k7skgf/RTyRTIhl9ulgELoJGvcHQK0j20ck1KxPZOtdE/7JrK//4vSgIVtc6FCJ
PsUbu+0pHi2uumsVa1WEtpuopPIk9sMCn3yAIvgklhYXllmwvG0pZkKt38XXX9Lt
ShhE7/oKXv226oZOb7QWgcrpk9flhB2z+ljA/gNricSibhdP08U3Gice3AFahNKq
EzAtKrWVd1SQcVlahBgpcWdDqc/nY2ysM7SN01dDPr8UU6KX4cH6/OjjxaVrc25d
2eIdyCpbJ2PzBQhbiMnmd8pQtrsAeWmph6uevsyYeCQLf85SYCsuKgRmvGjh7JdU
QS7OBnpPYdXuPVj/fbJQ3257d4cOzQ==
=v5/K
-----END PGP SIGNATURE-----

--ofdufvh7sevdvg3p--
