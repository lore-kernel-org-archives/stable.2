Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E8218871F;
	Wed,  3 Jun 2026 20:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780518160; cv=none; b=Ykrzey6rGio4UeK1n+1BlcvkTabux9SM361xS0CecUT7xE9+q3/cm8tzb4kpbpxhMKQHjPKmI2jXzbUFtE/H5NG5TbUJHS9bW+I218AsIfynmB9IqUzstUNnGrBLTAwFqA3BCXj9iwMgHC6hz9+/2y0VKu9rbyWsQ3vYVSxDbA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780518160; c=relaxed/simple;
	bh=k9adqn0wCXAkviCCB4H2B1SXFVaBvXE79KQiJoOTyOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZvXK8wIR7arXaUwRNrNA0XeiCM2DaR0M7YjLw6TVAzPYGQ84KsTQCdSQMxzAV723q8l2/78oyTn8Q/n3htVWTMzk5usb2m6sdmxkR689iqN9RQWifYeyiNnpKJ0agklnz/YXRaI7KvEdDogFLXtiuo+c3QqAFrfAaDYc50h8A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=SQ+eQwGO; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="SQ+eQwGO"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D3D4E11681B;
	Wed,  3 Jun 2026 22:22:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1780518150;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=QWCn+RvJ2hGSRSiKljKAu45ohCbEXtbZ3L2rPOZI8RI=;
	b=SQ+eQwGO5JwvwC+uNxWbnqIRnvt79Yl71aQPe9p0aLBIn/I26nJ2vzxtNCxprHt3PLkSur
	mmB+zOm/5+L4B9CwHTYQ5loboSmeR8YawF6iF98lUL+inpKmHeYDQO48Yc7ErUM7FXBmuo
	LE4Q7n3zncDMmNMFBqjx0eECLRCBPjX0Nilpb9sCqjhE93VK/n857dLwBiJaMpCbQZOwKF
	TUClNqqpR7lJ7ibUv6+aMJGB7QHQVQtEnw9RlVxDEgOb45pqdl7ZvtywOBxbzqWYwEI96V
	EnoEc5DeJAt8fGxonAS7E1fwFhxqv9L7Jixdj2wq3G60U6IAmDolUuf7o1edlg==
Date: Wed, 3 Jun 2026 22:22:26 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, stable@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea@kernel.org>,
	Pavel Machek <pavel@nabladev.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chris.Paterson2@renesas.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: renesas: rcar-gen3-usb2: Fix the use of msleep
 during spinlock
Message-ID: <aiCNApnB9NKuuw8R@duo.ucw.cz>
References: <20260501225859.504868-1-nobuhiro.iwamatsu.x90@mail.toshiba>
 <20260602180900.rcar-gen3-usb2-reply@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NANqtt7thEV32wSe"
Content-Disposition: inline
In-Reply-To: <20260602180900.rcar-gen3-usb2-reply@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3


--NANqtt7thEV32wSe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2026-06-02 14:21:25, Sasha Levin wrote:
> On Sat, May 02, 2026 at 07:58:59AM +0900, Nobuhiro Iwamatsu wrote:
> > [PATCH] phy: renesas: rcar-gen3-usb2: Fix the use of msleep during spin=
lock
>=20
> Now applied to 5.10.y.

That was the

- msleep()
+ mdelay()

one-liner patch, right? Yes, that's indeed best solution for
5.10.x. Thank you!

Best regards,
								Pavel

      =20

--NANqtt7thEV32wSe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaiCNAgAKCRAw5/Bqldv6
8r08AKDBOfLTMbP3R9oD2tSWnHNShHmBfQCfWutBq+G5WdgBS3g35MQceQDfZ6o=
=5y02
-----END PGP SIGNATURE-----

--NANqtt7thEV32wSe--
