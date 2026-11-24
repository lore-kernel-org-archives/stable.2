Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526809;
	b=SgUB9bqS7Uwisriu0ofXPuvMCAAyqRSAwulzPeh95AY46DA86SO8FlXVrPoet9stsdtl
	 adxwDWTS6NWajO8c9abL84Y/iPjbSM0B2+AKeRpjF5N21+3Fr26b1TZoJf66kdBnKOQ9Q
	 BKDoH3fvBrIiavOWdJJe4GV+rSZOJsrL/GYnkMvCrLIjby7kldDqXWVB71qON6B1ZFkzP
	 oBvgNvii2ijg2UiD3FAN0UbKmZKWn15csmm96YiPR8AGsMVqnV5peea3Dgybd/UjPCPfA
	 7x5cF020R9BVHmEuBLp4hF0XOmB3x+xsnc0Rq8qOrVImWOHjOAGTR5h73P4vy5pcjTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526809;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TGbRNMlBiqQcwxv0P2/3UU/uHuduzqYaI4dTeURK6EI=;
	b=gvbRTjjDonn2nolmu+/6gQgIPBGnpkQw20YmxXiRlKSUoK7QKmnowcG71QwunAbOenR9
	 va7oTYSyeOSY1Arx3mDbC6YowMMbq6sr79F0dP4InqThPuDotALcKe5auPSIxy2YmCyNz
	 3MKIKedXhYYX4n3wZC+0xVZvmlC8YAYSrKPe5ECj0wfpdJcDiWCplIgIpIltZJ59zJ81T
	 eeZH/lRarr+PHj/GU6MHnRmMsp+iorJZE2EJD6X8KcQGZtHDouHZtG4QmbpaCRFD6JT5U
	 hie+LXAGPvFYR5/dSlSXOK+JcszmChXEMv/BcpReKV174eg144Jmq0E+8XJxeqWRrZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omtiuRGg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 88F7B606A31E;
	Tue, 24 Nov 2026 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omtiuRGg
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 969DE1F00A3C;
	Tue, 24 Nov 2026 13:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795526809;
	bh=TGbRNMlBiqQcwxv0P2/3UU/uHuduzqYaI4dTeURK6EI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=omtiuRGgWioc714Sp525Z1hVz4JVmy5BO+Xq0XWMZNEbT5E8pw/lYSrplLQCThmMx
	 Q+Hs/1c9oV/a3JulF6gdm0xy+uhmYYQnwH2to/tg/YpHUVf4brynmd/FBSGU3OUatC
	 g/ZqJg6MyJy5u/ILQEptaI3G+tvDMClleSJPzgfqg7YukZ4ShqRNHrEsz8lCq+g2qw
	 URf8D7QbdBGVblT+Yv6vcWHt6eD/P8LktNfJOAHmohU0YK3XWtwFmbibLD8950rw2F
	 GSIpq8fPSkka/7AygDKUtCSnG6LLBMdesl8k+ch8LMsYFzsnvFZgIlHRq4+3oUtSHh
	 pf3VesqmGugOA==
Date: Tue, 24 Nov 2026 14:26:46 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Yu Zhang <yuz08559@gmail.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] pwm: gpio: unregister the chip on driver unbind
Message-ID: <awWQWD1RG-0F2r_o@monoceros>
References: <20261101032646.11397-1-yuz08559@gmail.com>
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
	protocol="application/pgp-signature"; boundary="icbp37xdehavlxab"
Content-Disposition: inline
In-Reply-To: <20261101032646.11397-1-yuz08559@gmail.com>


--icbp37xdehavlxab
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: gpio: unregister the chip on driver unbind
MIME-Version: 1.0

Hello,

On Sun, Nov 01, 2026 at 01:26:46PM +1000, Yu Zhang wrote:
> pwm_gpio_probe() registers the chip with pwmchip_add(), but the driver
> has neither a remove callback nor a devm action calling
> pwmchip_remove(). On unbind the devres callbacks release the GPIO
> descriptor, cancel the hrtimer and drop the reference taken by
> devm_pwmchip_alloc(), while the chip stays registered: it is still in
> the pwm_chips idr, its sysfs attributes and character device are still
> there and chip->operational is still true.
>=20
> The chip can therefore still be reached through sysfs export, the
> character device, debugfs and pwm_get() from a consumer. Those paths
> call into chip->ops, which point into unloaded module text once the
> module is gone, and pwm_gpio_apply() re-arms the cancelled hrtimer and
> drives a GPIO descriptor the driver no longer owns.
>=20
> Use devm_pwmchip_add() so that the chip is removed before the hrtimer
> is cancelled and the GPIO is released.
>=20
> Fixes: 7f61257cd6e1 ("pwm: Add GPIO PWM driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yu Zhang <yuz08559@gmail.com>

Applied with Stefan's Reviewed-by tag to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Thanks
Uwe

--icbp37xdehavlxab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsFkJMACgkQj4D7WH0S
/k5nWAf+KbEtCX2TojwT9s89cuwvkSRQWogDjs+iq1QUnlR5Adse+e6q9UDhTNgW
60BLcbTXyTCUZbybVqOdfkO6HrsTDbxh3CqlBpTLRx9OvWrhw+CSNBbCJBdd2VRq
5qo7XLJQKEMlIzM1k0JTdiETY4sCXH0yQnxY+wMJ2PeqDm1H9leYznt98CKDQgZj
+3Eg6/gmowkCmlYWldMWga22780eFByBWwlxoLtSIe5Dz+b0uZBo6SfHtmVzI+PZ
G/pLOrrvW4mraL1k5j4ktv0iP9K087/lSk8QF/Iln8hQvv1doi+u0loj8dOQ29eU
XicX0aAbLMMFvvOEsmADQHgxi+4Fgg==
=oZSU
-----END PGP SIGNATURE-----

--icbp37xdehavlxab--
