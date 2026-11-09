Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212800;
	b=yrG2L/S+epslGxqcAjALiobDUPYN6eN4JEjyysV3e4hWJFpBHAbrgjeNDY7UaCN6wish
	 nmLJPoEyf4qa7h2zLefQBmICIxKqHxw15OcRZF52aoLmYpugDrwg5gpWtItR9A2DXRwg0
	 VNaPneF+AhWBtcdytXX5PAq0Zq/Wl+sgVREG9MpRLKyj+FgLsCdlnDKeuR7cgKezzd4kE
	 YYTyHccLGM6OJsd6v+uh9+6ZqKF2qLoorowhEnvpb3alGFyyO3KcCu2TOCESBoVnHUUjH
	 dcPygpAlqvHqUFmIEBp9eKVYI+bOqAqxQWTvj6Co3+55Y3iSpJPKOSojeTfJIT8qknA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212800;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6NetEu8bRljJte9w/PtFKo360iOSm+g9vSdLRGrjE6U=;
	b=ey82mTOpzbNLbh6+roIquDzQvQ7SNV5kO5jaJ3VyWzZWeAk9XtahpQMguzeY39a/amuJ
	 1UzqwgjpMRb0zBlW+rRL0gCUYIL4/djX9wahjEuE8DU9ZDay16pI84XpdI/EcKBRf/O8L
	 ew+1AmMFHXmNuD3bKz593mJTQis90ViSWTFPI1JbYnajNVt2b/NnED1coEYxqYBnFtuLo
	 nGBNfyI20qa//qrO5m8s6RKytoArxmBSQr8xlCKxmlMgzlx3RspDqlGolCWcme41Bll9g
	 GWz0Jz9vJVkkDTOdrXXcwi18QyAPspFY1Hu2S8HsN5k6G4FRFFZ+4BE4mbaLYi+qj0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNUlR9Gd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7B51C606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNUlR9Gd
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 957BB1F0089F;
	Mon,  9 Nov 2026 08:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794212800;
	bh=6NetEu8bRljJte9w/PtFKo360iOSm+g9vSdLRGrjE6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QNUlR9GdsqiRfXiKKDpD4EtPzWlh01CtBVn/YAomrvBKbyOltqknYw+JlWZzxMo8s
	 AtH0xO5awOE2IPSHXxQCoCSR9WUwE4B2Gp7WSauO/zSP1adCDRnnztr7/W4inxswuu
	 q9AB/KCYjwhxg8IfGd5eYkSp5RfpHRS6PBCPg7GkGaXvGJdwJjNt3pJB3ZRSTJHicY
	 nUcbJzKaVve+oRuN73w0VF4IW6FVZxvb8WwwhQeduuUA1b+/ti0/0QCGTSdnpqd8g4
	 GllVm9ByIF8kvoxfmt3YQZRnKCBEa1gItcQ383DIYiq/iEtZiptfzibAIFC9YqH2dh
	 JctCsTmLMzhaw==
Date: Mon, 9 Nov 2026 09:26:37 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH 6.6.y] pwm: tiehrpwm: Clear period on disable to allow
 reconfiguration
Message-ID: <avGDhwQFx9z_vj8V@monoceros>
References: <20261107053048-failed-6.6-e74b9a7ee500@kernel.org>
 <20261109081728.798045-2-ukleinek@kernel.org>
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
	protocol="application/pgp-signature"; boundary="ieb3rnfbey3rdyap"
Content-Disposition: inline
In-Reply-To: <20261109081728.798045-2-ukleinek@kernel.org>


--ieb3rnfbey3rdyap
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.6.y] pwm: tiehrpwm: Clear period on disable to allow
 reconfiguration
MIME-Version: 1.0

Hello again,

On Mon, Nov 09, 2026 at 09:17:29AM +0100, Uwe Kleine-K=F6nig wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>=20
> [ Upstream commit e74b9a7ee50071aad25d3989bf985292f90b0c6e ]
>=20
> Both channels share one period register, so ehrpwm_pwm_config() rejects a
> period differing from the sibling's period_cycles[]. That value was clear=
ed
> only in .free(), not in .disable(), so a stopped channel kept blocking the
> sibling from switching to a new frequency. Clear it in .disable() too.
>=20
> Testcase:
>=20
>   cd /sys/class/pwm/pwmchip0; echo 0 > export; echo 1 > export
>   for p in pwm0 pwm1; do
>     echo 1000000 > $p/period; echo 500000 > $p/duty_cycle
>     echo 1 > $p/enable; echo 0 > $p/enable; echo 2000000 > $p/period
>   done
>   echo 1 > pwm0/enable	# before: -EINVAL, after: succeeds
>=20
> Fixes: 01b2d4536f02 ("pwm: pwm-tiehrpwm: Fix conflicting channel period s=
etting")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Link: https://patch.msgid.link/20260929120806.2790355-1-alexander.sverdli=
n@siemens.com
> Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

I forgot to mention, this patch also applies to v5.10.x, so I assume
this patch is fine also for 6.1 and 5.15.

Best regards
Uwe

--ieb3rnfbey3rdyap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrxg7oACgkQj4D7WH0S
/k7dUAgAtSGzsIVKXejqPsCzQwxNSTqA1JKqQRfPkZw56Nd+6ndsWeBUbs1aX6+M
R8GQE12poRpHil1XybehA+PWi9Md2GcFEwAuWfxWEydGCYSPojJeYiMRi6whdqiw
ze3uX6zkTc0wFzxhM5qF98FvOr5gMthe+PyHiywhXfjimRnJKqQKy3kuqvdaYhl8
DyNOlYLZMNU4k4DFdfTNKNDoEIW/RQSl4QBz98/8kFGW7OfTkgEelAMB6nNNSq5s
k+QZS/GsroP8Fb4WwwuyIAEzImjtJUqP4ygTQdFB4HQfkfTJKw0DczbygEvzaHur
SrblCK6nsY82lHW/rlf8F6uPGnLKzA==
=QybP
-----END PGP SIGNATURE-----

--ieb3rnfbey3rdyap--
