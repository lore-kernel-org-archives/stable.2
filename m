Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607479;
	b=sz9JYvsxinrEQ6Zhgzqo427/K9j0IZlO/CI3LRvDKJ244ncGeYbrb0ohRmrHwM2SBV1L
	 30KDIpSJQbpOavqCxm3++aiEIyx2dBjYdCF/4Lrs7AUQjiAa1tInOxPdbEbNrmc4FJJHp
	 EhqhOAVgkVmZ7pDOx5Ee4jHK2sFNoSjvVU/fCVyi2l6GPUAVFtL2FNyg8E0dFkX05A37L
	 rKzCjizp/8otXNt9RNmObSG3kt7kn3D8jsVSdaFopK6q1md77ADCzSb+GmLGlPgnwlA6g
	 XTbcNVnAm/IOzxwrS2VVg4uhZz3MfRCdEfQRRQCq0gcAWeTsr2/1Ihot7IQsvEHoPmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607479;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=060IlpN6nZBHuShVfn1h6xjHXL8bq9e9OYpRoM9tWdM=;
	b=19gpFulTkdfXHcVUHX/+Ffbo3bAxqP0Ht3QtraGORbK1ndZXNs8T+3m4N7F1VKTFNBdP
	 QciMjg+zfBtHKdjDIVumb9H3AEnXSp4VNZYwqPc9VKLe7E/9Lew0hqdDmA3vpKyv8Yjm5
	 exrKDNmfFgXKmwqSGRScClzViNILqmYR28wGqHE0+HlwnRyRV5z8n0HRj+Nrr4fM1TY2g
	 FGJDKoZOrntvuC34BGGOKQB28uftkcO/BGgPNP+pvW/Hx72lcwtw1uaDrfWB1tD1GNK0U
	 +locYzmfbUgZ81R7wBhBNKXpbRgGt5r9G3y15gi4Ln6T90nfNmnwj1H+ljr0jTecaDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=QtKGYcQI;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D33C606A335
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 22:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D33C606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=QtKGYcQI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=060I
	lpN6nZBHuShVfn1h6xjHXL8bq9e9OYpRoM9tWdM=; b=QtKGYcQINLZUbtBvGCrX
	feBVnRhzy4dEj4v8brwXHAjMaRSL7bcMQaulQM1FlgQOGXCUMedRIYcOXT9cAZCa
	kRyT5afiDUnnj/EqONlbiNV1sxsCNgDfidTvRAaHQ+4S9wvNzHNT3Rqj6I/DKVeC
	aXmoKMaCQDVwusYmeKu0SqpliUW7whlJohAEdqKFwD2XMhypU58x38EiedEkywjb
	DYkYWEEJTtfJ3ODg0NVlHHEHhWrO8oQ1kobOVK0CaA1DwB4A0L/l2UqffG3r+8iw
	fof+7B1NO0+SruLY6T6U7ByveZh4NZ/m9lz8z6Fdm3hkB/sj1+5m/xmejGZpMLXB
	NQ==
Received: (qmail 379181 invoked from network); 13 Nov 2026 23:04:34 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Nov 2026 23:04:34 +0100
X-UD-Smtp-Session: l3s3148p1@E2f9nC9g+uAujntX
Date: Fri, 13 Nov 2026 23:04:32 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v2 2/8] i2c: core: fix swnode use-after-free on client
 deregistration
Message-ID: <aveJbJBz0lRkpXMV@shikoro>
References: <20261110085125.2535508-1-johan@kernel.org>
 <20261110085125.2535508-3-johan@kernel.org>
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
	protocol="application/pgp-signature"; boundary="j+L7QhPvMLGA3QYz"
Content-Disposition: inline
In-Reply-To: <20261110085125.2535508-3-johan@kernel.org>

--j+L7QhPvMLGA3QYz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 09:51:18AM +0100, Johan Hovold wrote:
> If a client has both a primary and a secondary firmware node, the
> secondary node is accessed via the ->secondary pointer of the primary
> node.
>=20
> Use a temporary variable to track whether the firmware node is a
> software node and remove any software node before dropping its reference
> to avoid a use-after-free in device_remove_software_node() when
> accessing the secondary firmware node.
>=20
> Fixes: df6d7277e552 ("i2c: core: Do not dereference fwnode in struct devi=
ce")
> Fixes: 1c24e5fc0c70 ("i2c: core: Fix double-free of fwnode in i2c_unregis=
ter_device()")
> Cc: stable@vger.kernel.org	# 6.16
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Hans de Goede <hansg@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Looks reasonable to me. Thanks for doing this and the cleanup in patch
4/8.

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--j+L7QhPvMLGA3QYz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmr3iWwACgkQFA3kzBSg
KbaIMA//eWcgbnF7PZjDx4nprctqMRhaYXXJNHPesqlrO7deaWAuj6I1+Cliuco4
sUxbGoaqeI3Pdn5iMAVHzuzxk4YWp9NqEGaarZZ6oT3MrPx8oTvQwYwnNTsou6yz
t+x04+dPmw5di/r02KlpuI//3aGLKLVH1TStEZ7fdYdeKf9Cjw1BhzTQ5evVW0H2
Xurqmq1uWGZ3QUvb7+LppwTkp3wp6AFbjY8Y2pRmxfrM4VgGuYLWExK7P//qqKR1
pkpxjV4XGIvlZDlX7ynIWf55Yh2xWNjI89dS2ytFYtkXXgKf3KoGzZ+fGg0Y1Yhf
mHJbnTCL+24rtpfDhPnC1fci8rVLJ2VvKVLtfXK3zaNe6ZOshRh8Rdl+dwfNckLi
BMzTAr8NWsfp8m+sCrPZUDRk+bDEZiGu5IQbbgw4WwdREq/5g6z3eo+G7PF2D+HY
cFHkyOVcMkKfq4IyYTm9AVXIKl1Oruz9QyefgNHCmdauegytSfsuI+oBvw66kXBu
MhPSRrAlD2FLZYmOjfUT1R+rbncrT6tLHHwlRnSsjdvnVrZN5PUr+r3Jx9KTkchQ
jTkp8P3WIcE3j3A+5DynJ2+VKhN9Pi/n/dLaK84buiyzOlzbm+TZ8NylR2nng6+q
44eBFj99f+HuUQI/i9a6ovZwD1E9fLT0+J55g4IKqUeVi9KoIak=
=UwRm
-----END PGP SIGNATURE-----

--j+L7QhPvMLGA3QYz--
