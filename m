Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29DD39CCFC
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787039032; cv=none; b=o/1saYT0EPhDutp/AzwUA1NvCLLPtSpJmyETxN0AxmZUFire9L5Ha8i7Qxp00ekMj3dW5bBv/73oDOm2PkDXSNXc163Hmx6v/fLm+OtPZw9BbzZrLfpUoTBZSWaPOJ40eFbFldHw0U5Sxyy0IhQ6JRBrpmGbL89Rpb9L9dQlRQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787039032; c=relaxed/simple;
	bh=1aLxMe0Atk+XJgzIR3fixWNbWmNbUP6R6LKC9ILxagQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QC1yc0RKJuIwEBMm5QUekSnDfhyRQSQV7pqSghv/od3yFHjUNF4YcBP9sbuAS42k3UDvhSo4xTnoafLYXRRP/y3b5hQbG9ZIDsah3rxg9liv8CytS+2kHi+5A5nI24+l/NXlNY0yYtIrdP5u0GPy7Crm9jY8H2zTIF0zHuZ35is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=EBbfmX9G; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="EBbfmX9G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=1aLx
	Me0Atk+XJgzIR3fixWNbWmNbUP6R6LKC9ILxagQ=; b=EBbfmX9GvVzhmB1tiogi
	FJOxuyXmzkfXVbrLSgb1Z+aJgYLa0cWYf+IlwZO46bX+KLJTpsoRgDtwRPeDByT8
	ElqvasUv39JhhFlB/vh9AdC8gUHhT6K5QBCyX3i1Gbyp2QyzOj6BqhGKeBubeQOZ
	eSdV5etAJP3A292jPqLPAziOwaCvmJNDfYNYEi0H3YQqFPmW/kZ7hHNwSqxDuluQ
	xRqaHodOOiYIn4fOZorMk+Z2/dSaq4oUU1BfGsjhvof2ne3AaAksOTjtSBOgFL0C
	7YtFh3Rbjsh8xmJP0GiixRgp/RCe5agLrwmWAfeYF7rkhX7Ps8gyQw1Ioi87Gf5i
	GA==
Received: (qmail 3713490 invoked from network); 18 Aug 2026 09:43:41 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Aug 2026 09:43:41 +0200
X-UD-Smtp-Session: l3s3148p1@LH0Uck1ZrpgujnuP
Date: Tue, 18 Aug 2026 09:43:40 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 02/12] rtc: rzn1: Handle EPROBE_DEFER for optional pps
 interrupt
Message-ID: <aoQNLEIqQ7ANpxId@ninjato>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LTZSGmC/HwKGZ8xM"
Content-Disposition: inline
In-Reply-To: <20260706175138.12587-3-prabhakar.mahadev-lad.rj@bp.renesas.com>


--LTZSGmC/HwKGZ8xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 06:51:28PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Check for -EPROBE_DEFER from platform_get_irq_byname_optional() and handle
> the deferred probe request properly.
>=20
> Although the "pps" interrupt is optional, an error code of -EPROBE_DEFER
> indicates that the interrupt subsystem is not yet ready. Intercept this
> specific error condition, assign it to the return value, and jump to the
> dis_runtime_pm label to avoid ignoring a valid probe deferral.
>=20
> Fixes: eea7791e00f33 ("rtc: rzn1: implement one-second accuracy for alarm=
s")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--LTZSGmC/HwKGZ8xM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqEDSwACgkQFA3kzBSg
KbaBEg//bAjQwgWY6CSjsZry7NlQ4BAlLXIQqIbV6wzZEyqCpVi/E4C3BaYPS+P1
4ZqhEHxcbMzvzEiM3PddhRsEa3ho5iHEehdHK+qJCnnOKf3lGVOjo+1xt/humngD
xEAh5fUzIkpEl8zUV6+z0LDrWLRE4px45UXaib0HCa9wfPEBa2dP1O/52keX26oB
nnZeLg9WvfdWfdIgvVHvNgVL+iusbCLQBQmgQljjAHTYoUjLHmdCHwFOSYQ2FENo
neCkvm468iF/BY1Ustej9OKEYmLfBRU6GAJV0t7Gptb6zTVawu9A7znwWI7jOUsE
XuKrCUN3oJAeefqGT9yiiG9k3NK2K0C1kAEC96QYuz7gk09LWnCg2vZlLDWWOHKN
FSbD+NW3IbzL75WKzNQ+gFbTwEEPiiAXqQGGhit/kzly/TP3lwq0pG3WV+5CEr/X
FBf76GMeWdXJKQNEguGb47hTm8WG6Kgqj5o+cCNY+W3M6704KqU8XQr25Ol0NkCU
0HJy3SMAJyxfXaoZsI6wDyhZVWpXq7mNcPvYRjNhJTRdf34CGmpgPL/DdJAzSr9i
JvdT27/7eZesj6hnE+uxh6o2i7vpvssN6ryZe6ESzIEC/JRBq+r09l6MXBwtaEZq
dqHIDVVp/v5wYJhH1mNTiWKBt3qJ/4DYIV+3SLraomqnGBLi/Yw=
=ZcXu
-----END PGP SIGNATURE-----

--LTZSGmC/HwKGZ8xM--
