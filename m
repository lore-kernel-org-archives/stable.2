Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800392;
	b=vD0wie9u8qdxbzH3DP3ibTTbFLfpnxjflPYeiXbi6w08sMcnE4V7lD5wUebGoE8a9Kqj
	 NVhyecr8B+k/LRnreyXHYmuhL6lX4iqiJtL5Vv1E3sikXMKn0JNQ3HP6otLzLPRgwsMDv
	 9KoJxLbM7lLpLumJRy1ZzOmIBRjCyQb3669CoNZ9pbgy5L/ZvUGfSuRYDZhMbbTqxsIaU
	 XmlEYc732w8KB5Vqs7chrSmhZJ25px0ZmZVx7mnR4R+T7qL7gS6X7yddP7YbAMTvoZhhi
	 FrdE1HivisRXYqcayDmmiDJbeKFQSN/lvjqDEb3/+LMWRPD2ndxEo4oU3QEvKtZXIIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800392;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=TauMCQr5SfziqD6k5VSsvGBJXXxJunQZxGoZnoDMU38=;
	b=NPcqToqq39T6hslsx5hrc/nrPiapF4zHEzMqP9Kpi5gVI/EXhVElpepG55utelzvBpok
	 whLTqlzNgHpTZvTdM7In5bzTmURAisHktXpBD/1V7UECFXOSC08li30jxWXaJcKN7moRX
	 wOB0m2jiLa2puDB8foRIPFKcfm0jGKulsVuZwngMxMsaD1qvzdHslr9BHcDMqOonrs4Fi
	 eZe2x1QpjyT0PPx41JpA1BHCnI3ObPslq95Kze0xS2/UotMM0uCEyI66NvVCByoqoIQ6c
	 OWCxkVYyHHfJlQRB6xEI6c64QHWjWKFGLnN5coMADdotMLDtXpLmSHIfVHBAUJ76BFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KsBdrZMG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38676606A31B;
	Wed,  4 Nov 2026 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KsBdrZMG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9791F000C1;
	Wed,  4 Nov 2026 13:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793800391;
	bh=TauMCQr5SfziqD6k5VSsvGBJXXxJunQZxGoZnoDMU38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KsBdrZMGYslUlrw159MQZM1yGBRvFOW+mgCwb3GfULU4Vmz/NVXNg7yA004p3o+BW
	 zRAAn8aQShUwwUG72mVfANjki//iW8YlgOYPC58R/29fyq49qQ80/3uCGtB+iBBwp0
	 /DNk7x7UztqX0syDNojNaHjGSu7Xv5afPQnSeYEJrw5P/YUP1K8r74UfUyGkBqoPPD
	 x38+3iKRY8sqn6JiMJr2pFZX+o+dH2g2hOIfAnWO7ctYNy/aX7ajLIqqN9+YftgMhO
	 9SHsmxPjYvtMlKbpTbSoF/XA+Mdz4cIzTp/ZbS5dBWqm8Aksd3RRvD/k11H+rrv2vp
	 tyyrDqa6F3tEA==
Date: Wed, 4 Nov 2026 13:53:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Chengyu Liu <lui2012qwq@gmail.com>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] regulator: disable disable_work for good in
 regulator_unregister()
Message-ID: <5e63dcea-a397-41a4-a647-a356ab67f1a9@sirena.org.uk>
References: <20261103174911.1600930-1-lui2012qwq@gmail.com>
 <20261104134838.326041-1-lui2012qwq@gmail.com>
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
	protocol="application/pgp-signature"; boundary="r1mTOHNVXENWSM17"
Content-Disposition: inline
In-Reply-To: <20261104134838.326041-1-lui2012qwq@gmail.com>
X-Cookie: All rights reserved.


--r1mTOHNVXENWSM17
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 04, 2026 at 09:48:38PM +0800, Chengyu Liu wrote:
> regulator_unregister() stops rdev->disable_work with
> flush_work(&dw->work), which is a no-op for a delayed_work pending on
> the timer wheel: flush_work() only waits for a queued or running work
> item.  A disable deferred by a consumer's regulator_disable_deferred()
> therefore survives the provider's unbind, and regulator_disable_work()
> fires after device_unregister() has freed the rdev, dereferencing it
> via container_of().  Use-after-free.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--r1mTOHNVXENWSM17
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrrOMMACgkQJNaLcl1U
h9AY6Qf/YDsn3/z3Ip4FsAx/iYVXNkX+Tj59/+U04/uBNX1p4VF8dvobid56hyY/
4R1d85MsF2sY1AOHuwCdA8TyLoGQJmUISiUIg8mY4clECUjRjpHhMYaFbqlxJujs
YR47oW6KG+r8VSIG2i47xP+96zzcJEteFyV4T/KJGJEr6qqeOr5wZV1/KwidK8MY
6EVW+cdRjASoUsKMZEl1BNYO/IyqRfBNQr5WupbD7fp1tOgha8NIFuarOawRdqON
Vwyy1TlkmTYv9uHkAfoLUD9vNhDqSmT7fDvonrWoV47H381MU5Z73HSHP3gw3jnv
PFtkjkTYJ1yaIkpjtXnGAWODOsyGPA==
=kmR9
-----END PGP SIGNATURE-----

--r1mTOHNVXENWSM17--
