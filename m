Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C6A3DB301
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563023; cv=none; b=lmurHbZFyD2WYAjeZ9gXnxogWEZfFUEPFJr1y9eqTfE1D8jCvm0TrIBYYD2oC0AFYPImIju9fO/3NvH+SLg5hOC0yGHgJ0vIlXE78SgVFy3XaYWT8mEQc6bBb+/VWhvU+/kSlsZpYCjOmwBf2fnSH2DSZEKbgj9qNwbvHGIuviY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563023; c=relaxed/simple;
	bh=aCpKIJ+QgbZCXIEODsRAzIR7ljW8BH6eX1Jwet/sqo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+Cx01HfYwwxOGRln2w3W7mwqpTPDI2HhpsUaC1qd/2n8mzeqy6yJWT44A8ghe+nzDdbZy8MiqqqR41JQJ9s2FLkzvD/1e1tggbIOabHSwRXrnmsMNtJqhRCdEE+hcbtzcGVTfJD9ja1cDYoO3i8NbuNtsim0oEs/1sEnDczmio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ioNDaKeY; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ioNDaKeY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=9Hff
	ekHVo++p5/gZcufC8Kzcfe00IdLKlAV7bvdlcmE=; b=ioNDaKeYz0ocZ/MWTZIH
	UxbKAKC/GMyLPF4aUL/ej/Eo+V67vNeYCXJvovujiZE1iKg2nzofuSxbMkYSz9nJ
	yz/9srZMhpoQCpPzU9NrNR+vPsK1msMt+2YLXU/k8wuaq1HCXApwKEKFXOj9AfG9
	xxFlt7VInK9V7Jc97aE/YFmI7h3AoX5MWRw74uBnb0t4kSQojrZ3+U1B+Ox2ucLf
	2YUCyjQhwLgOatS2peQpgo3qZa3hhT5Ai7JcZeAHkkZdcY3aU1w9Gj/X3TZU++CP
	UxmSeDIBj3pdVeMYeZGhTVjyZqt9JOKVXxEJJvp0qekRQLP82HJ3LpCxDGfO5jHL
	Kg==
Received: (qmail 3573591 invoked from network); 4 Jun 2026 10:50:16 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Jun 2026 10:50:16 +0200
X-UD-Smtp-Session: l3s3148p1@JeQVomlTcogujnsi
Date: Thu, 4 Jun 2026 10:50:16 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 07/10] i2c: core: fix adapter registration race
Message-ID: <aiE8SONCyzX4LW4M@ninjato>
References: <20260511143715.729714-1-johan@kernel.org>
 <20260511143715.729714-8-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iv+Vq4ZBGsfBbAIV"
Content-Disposition: inline
In-Reply-To: <20260511143715.729714-8-johan@kernel.org>


--iv+Vq4ZBGsfBbAIV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 04:37:12PM +0200, Johan Hovold wrote:
> Adapters can be looked up based on their id using i2c_get_adapter()
> which takes a reference to the embedded struct device.
>=20
> Make sure that the adapter (including its struct device) has been
> initialised before adding it to the IDR to avoid accessing uninitialised
> data which could, for example, lead to NULL-pointer dereferences or
> use-after-free.
>=20
> Note that the i2c-dev chardev, which is registered from a bus notifier,
> currently uses i2c_get_adapter() so the adapter needs to be added to the
> IDR before registration.
>=20
> Fixes: 6e13e6418418 ("i2c: Add i2c_add_numbered_adapter()")
> Cc: stable@vger.kernel.org	# 2.6.22
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--iv+Vq4ZBGsfBbAIV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmohPEQACgkQFA3kzBSg
KbYVGQ/+LPR+PdrMnjr2Y1GBHQMEvaqRPnJso+tGKhcyqqk3VlRARrqUdxG4M7CT
0VV/lgUuCcbTzYHv3IQrIrvGzxQ0lrZJoSzhpvEIWSm7jdyPUrxb7FvkwkJuQJ46
/O4Xn6PkMKqav/iJIkA+i6fJg3/BXvYirwBkF+14HeYmv9rOlq4twcdzHBx00bo7
c8BY3ICFgI02KgZPROSjwiMIFitQ0tE/G2qbgy1Oi+KuvGMPauN7RPD+LfAXzYjE
NDyOrFs6EzfO8/lqLdqKQ9rl/12gkUzgplseM2jHyUgqMSuQ8IYdAWZ80hun62Om
LWtK2SvtpsebcQzeqmUKCMXRa3lf2S/yRopcGal6RJjQHrpeuq9x/5PcIz+6oRAw
oMAsXgB0j5wUprPP5V+aZIwIGcUNbwl7eAMfVoiAyCf5ycNv7s0feZ6HTSlCCZQK
6CkmNnepTvEM+wFrlp73hVK1LenCRU1BXnd3/56eNsIa9xSS1lS6fnLrDT8ECNQj
mVo7PkUpEDbxGKBpFZ7CEYtuBsxMbcOl3L8JMBnP0EF0b41a4BQRxhf4kEzZUMtg
Xo/jg/8q4Jt5eIQlFgXMi2NG+eJoXrPoGRNN3XAXzZzF6XP+oxADCzT3WrXstFz8
xm0dMOClMPAOyNzJpKCktM45h+X9Req7Nvty/ugJXhXWjX8fMEo=
=XyRL
-----END PGP SIGNATURE-----

--iv+Vq4ZBGsfBbAIV--
