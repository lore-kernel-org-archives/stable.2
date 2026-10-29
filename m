Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283685;
	b=I7VgzIZQm7cdnouG5AzvDE7/bXzlN+0WO1dN/HAEcRkG6nIuz9GYo+z2MXUdiU9U0nNw
	 MaIB3alJe5ZHEUAw55rr82aFSIExHa7hFrDuN+E1Vu7zdTLs8Pk90ohX/O/7xmGUFIakD
	 M5+YGNC1Ced0Uha+i4jDL+WolKtO+oFLK5RmNymHQsQ1lLIPyO0ijNGtSF3cOfaxpEReM
	 lL0sEtgIKHFk+tmxz2wKWWyT63i5BYEbYTznNsPyBvSNs22e7hmmwyk9FZoz4QjEahFcQ
	 2HaCcVNs8FIQ0IWCGkV9YoZRWnFpCqBH1d7yhcNSYMEG08AO9GkaXCya7SZbiQMeNbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283685;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=xFKuNJcxj4VSt6AKgr+a9KKuVSlzKzpvJImELoC06s8=;
	b=lJmfy+rNaQWQd9FBMzHrnoZ4BxZhgpg0JmNFiVWa0kGn+YUJpGiAcWxkmEiCk8tJ+ViD
	 wGmnjxEPvJ55nkKd32s9nhs0bNZFldrf23nHznuwrvoRhgZNfHsyQRMHprI2DU/8MufRA
	 XgxIkhoRvUcYLnM5SguoQqgx5Hyr/mxWrMHRYk3yAJ/qKvuIv6mFShGr/hKcdZRKbZfHq
	 17KRYjVs4FVtghH/vFGTmSAlO72MzrDEaXPgHsIuWbjGnkMNXpBHr9iSvqzxpBmpYYlSn
	 ulYwXD1g5oiCgjFXJT3TA5FPz4DEuxdUYhyHjRxE9wK34LQMsCagqv7qa4AyRPVAGYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E7K/l13A";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C75606A322;
	Thu, 29 Oct 2026 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E7K/l13A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116941F01828;
	Thu, 29 Oct 2026 14:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793283685;
	bh=xFKuNJcxj4VSt6AKgr+a9KKuVSlzKzpvJImELoC06s8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E7K/l13Ab1IP0j6+mGy8qrK19IwgZYOXMjFjHW1YI3uFoAERCgfaALLtsEWp3g9+y
	 7h1Y/IcGYYtvJ2CjAbxjHcoukVufPCXgCz3ndYZeXdiI9cFTSjDuqFUdtalqoDVQ6a
	 S0vHD/bcCYQZSahoK9VQjThC27tNrfUoOcB28xMIH49lOCIoC1wixVHSn2mcU6D/Pu
	 BfLGcEG+1fZFZtxBvaxnpLBXNOKfpC5PC5pi/iCxIvqYFRfqyGk8yuFe4S6+iVLYHw
	 /Vuu4Q1zhT0dDHCiuRo9j6lJr8u2Iwusbrfs2jgb3j2YGchsmtift+elSLYoxhaNfd
	 mtXcrNFZpk+ig==
Date: Thu, 29 Oct 2026 14:21:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Weibin Liu <liuwb@xiaopeng.com>
Cc: jth@kernel.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] spi: ch341: handle transfers without a TX or RX buffer
Message-ID: <f1df288a-559f-45e4-9521-dbfff9ee863d@sirena.org.uk>
References: <20260929081152.41753-1-liuwb@xiaopeng.com>
 <20261013054339.77477-1-liuwb@xiaopeng.com>
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
	protocol="application/pgp-signature"; boundary="7/PeIJh9FypLs7U+"
Content-Disposition: inline
In-Reply-To: <20261013054339.77477-1-liuwb@xiaopeng.com>
X-Cookie: I have a TINY BOWL in my HEAD


--7/PeIJh9FypLs7U+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 13, 2026 at 01:43:39PM +0800, Weibin Liu wrote:
> ch341_transfer_one() unconditionally copies from trans->tx_buf into the
> TX packet and hands trans->rx_buf to usb_bulk_msg() for the readback.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--7/PeIJh9FypLs7U+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrjVmAACgkQJNaLcl1U
h9C65Af/anGwZzs444y23ORunltBU/srXKKVDVi4hJUuYiTkxv12xooOWRfMKVen
/CfB1YNnOnNsUyp+0BwRyKtqyFDuORatJksw39j4UumzihwXm6vY8sy5orP09lVL
B8J91LR0XQrifQBK4Cov6ZH6f9648sGM9hryaw3gG2TIK/JFz3mcY/X1FC5D48Z8
Ibyw4JqK3V7gVDk4NcIUCUudzW3KJQO3cBYumfIunfg9ZPh8t4soXPXYAKwuZgYY
QrkamTwEglIkRHHLANdqrVadlXR/SLsTaLuPmZ7rZrhKqThgk1uwu1UpSxL3+Gxw
QHEMGE3K+q1Npqn1yooSe+uSmjnKcQ==
=umg0
-----END PGP SIGNATURE-----

--7/PeIJh9FypLs7U+--
