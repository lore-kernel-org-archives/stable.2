Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893564;
	b=mKzWdag4HqI3WR+iFaqFWykdYajuDMmlwNbu4nYO44M375dPWmz4Ajn7TmMogO4IIQp3
	 yAToeOETFlVcshRsAzJb8s3o+4MoT39QeJVrrOYWbiJZTFURqVLptgWAsUVOU9Espq4oP
	 mffFep++DPxy5H07oBVlUtYwwSD4moaWT5M4yNBwoyHf5Mq/wdCU3tl+iysZSoU8JP2rz
	 fEUgStQ4lkXiaPA6RoOsXdZuPC0KyfNcL3JH3xBMU2m0dcA6dwL0jMT11/6GUM5lzTgEf
	 dtR1uJj4KpX/wsF+KHLXDHjAEbUEuD9r/mMWqSQHUJPUcK23rHDP9hUPOLUxRkEvoqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893564;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TEExI0wyKCh5UrhCecRJ7HynlA0hRxBVTphCMFuZjBM=;
	b=LgHDdG2OFfxTULNCnC9hKro0Wbaoslb7+0dAZW7UnngSYJKG7PYPC8h1cG3ioqH50e9K
	 rYfZnH6WU5tiGf15cky3yhJICeXeHtqn0V1w/uVgB9tSTpbNMsdcUbWAMPq4IC6vx20J2
	 U6dxzauleYlhlOeAYXa9PzRx4a3aL7Zh4ENNOACGbL0ddCDEnmiH0z0UN6bLcwq5sPGBc
	 dkCqqATs6MZkvKh8yTMfzK89pvqd+gawzijoUrqsMSrHg8/Zqq2pkVAVx5cJCyy5sZwTl
	 EQ5H2eH8fkwLgyrY8R47cQU4pDu0En0mYLpz5SkWyGgu++xAzaN3zkfZQRgma2KXI1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifdAfxYL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7977E606D834;
	Thu,  5 Nov 2026 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifdAfxYL
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7876F1F000C1;
	Thu,  5 Nov 2026 15:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893564;
	bh=TEExI0wyKCh5UrhCecRJ7HynlA0hRxBVTphCMFuZjBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ifdAfxYLh+GoaGTXqEC0N5Mc1S6FzqY7oRvV92Sqpk8TeKMYsVG6WafXtr5AjcBJq
	 DBgFHcvhnnkSM9mwN2MDAkMhLRy+q/MzKfSSu0Hfg1+OPWYGUlEZAIGRpAijE5pwKS
	 GKtckZy/si3vrf4i4MGr/FUdNXbRBTmJlL/G+M1uo06PWLGLVF8EF48TDzGObepLD/
	 R+eGMaXX23EqNY06AslovgPYTziSDewOH88X2Vm1bbyjB8PiNpKWf5Mt48ka2y/liA
	 iG1NAkENvzvygZl9inlAsrRGNXz/GsqmEe2EDGOzl/z4/H5iDBsii7vKgnFIPnhVhH
	 r3RrWIhUVqMeA==
Date: Thu, 5 Nov 2026 16:46:01 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Sandipan Patra <spatra@nvidia.com>, linux-pwm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/8] pwm: tegra: Prevent 32-bit period truncation and
 division by zero
Message-ID: <auykeNit2S4e7axg@monoceros>
References: <20261105143847.2559586-1-lee@kernel.org>
 <20261105143847.2559586-2-lee@kernel.org>
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
	protocol="application/pgp-signature"; boundary="5nxrbirnwnmd4xu2"
Content-Disposition: inline
In-Reply-To: <20261105143847.2559586-2-lee@kernel.org>


--5nxrbirnwnmd4xu2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/8] pwm: tegra: Prevent 32-bit period truncation and
 division by zero
MIME-Version: 1.0

Hello Lee,

On Thu, Nov 05, 2026 at 02:38:03PM +0000, Lee Jones wrote:
> tegra_pwm_apply() passes the 64-bit state->duty_cycle and state->period
> values into tegra_pwm_config(), which accepts signed 32-bit int
> parameters and performs DIV_ROUND_CLOSEST_ULL(c, period_ns) before
> validating period_ns against pc->min_period_ns.  If a consumer requests
> a period that is a non-zero multiple of 2^32 nanoseconds, period_ns
> truncates to zero and triggers a divide-by-zero panic.
>=20
> Widen duty_ns and period_ns to u64 and validate that period_ns lies
> within [pc->min_period_ns, U32_MAX] prior to dividing by period_ns.
>=20
> Fixes: 1d7796bdb63a ("pwm: tegra: Support dynamic clock frequency configu=
ration")
> Fixes: fd3ddd4355c0 ("pwm: tegra: Implement .apply() callback")
> Closes: https://sashiko.dev/#/bug/linux-5c5b97d6-4da6-4d06-9dc7-957419dcd=
832
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

This is already addressed in
9ad5602d4943 ("pwm: tegra: Fix value discarding for duty and period")
which is next-20261102 and later.

Best regards
Uwe

--5nxrbirnwnmd4xu2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrspLcACgkQj4D7WH0S
/k7IZAgAgTxBFVmi5VNODULNSO0AzIE/XByrLnv9QPXpoGtE3u0fxn0SqZ8wdLaO
zboASSjsv6LW2VhdvVNNouW6XmjvAVtBXq073REQWGEEWjqbkZ805Hc9CRqgKbS8
RimnYb03FQPAOnXbH3zgXI7WOxw5+4Q42FHW7MKWR/65rq8sPRfklO77fm7oSDn5
jjSz5NN2ES6hvDHjGAdp4/dOC7X+7ZKFguO0eOYolk7E5mmPJ1MiIKBx3AgcDkh7
YHw/xMpIWcaQk1mvbkPIcyUIDdW7jA+l9hpwq/6hnhBAuEpkOkxNcNlRQfq9XHOn
DPYJUkv/NkCqUKrSSQg/yc07PydLug==
=3cdS
-----END PGP SIGNATURE-----

--5nxrbirnwnmd4xu2--
