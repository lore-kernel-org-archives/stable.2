Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792624435;
	b=zmYIPSmwjFpubneCrXPC75gvuMFby6B65dy8AYvHfaDNxij3H0Rjwc2QX/dpeH0qdjsu
	 z9x6oYbNqMtrajrC+shC5Es5grlYq2wBwuoejTGFD0PUYqGU6r+146KCRVRG93RlgMY2R
	 vdn0ZLLf1u6bzi0MpDYCsZhFWsKtRGfREhiAHc579DHbkoTOoYpubRZrhu/hDKm3po8IU
	 gkD/+TIuhjdwrf6aAxd3YKZqHyA+6I5uOahhIo85vIO51wpczIne+uFVEhsPhEvuQeb2a
	 V4mQ42q3AK8HZsm/zdxTLyQrhfTq8dyvKYAAhNAx1EjxGqMAWDEfhSm0Jb8F6zfyNow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624435;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=x/EerbpQzIDCCfxtdbYFQx6u+XW/yZXRuyEGxPXiKGQ=;
	b=lqkm6RttzTT+jZWoDYfZJGKqXOmmcA45oBbRQ6vuYtqwzlzFIcT0uzTccL+EP6s31+7i
	 YJj4PyzHFSTfUTuGei8jpWA88RfqMm7OoXAotisnJxZJPBy2TY0rOjprZj+0LjGza81Cy
	 7yvFq+I3V3ZceysK8q3BP48RJgKvv2HGYiiuyE5RVvvO5N8Mn4hazynEBri2AstJc5XMA
	 3GcCnR2fJ3jmtKD4NZ+kVr10O7xgexdxCxC1dGjVd8K1UA3VAHM4+PzdteB+ZkG/rYwP8
	 qi65mH7fvfy/ClBLieXRUBh1R/1uLcelLDhL0pGXh4rBaMkq2TnDn6TLzIWHSus7T2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=eGGUAYJZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F06606A31B;
	Wed, 21 Oct 2026 23:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7F06606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=eGGUAYJZ
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EF957200073;
	Thu, 22 Oct 2026 01:13:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792624428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x/EerbpQzIDCCfxtdbYFQx6u+XW/yZXRuyEGxPXiKGQ=;
	b=eGGUAYJZ+qkuUsqfTeXbYBtwoTukdjpFoX97mPyOdUUNSG9g1xm3nZiJoqmCl6dYZ6hnxX
	3uchwCy7J+Vu0rdDGngr8Vf336sjNdiesDKFRwdP/bEiiMOQ4IFH6ZTXDjKnd0TKDKEVs1
	sDQzBbm/h2JXuKVXiFaoqg/PQjhPTlRR+rFwQndppc9Rxtgja3MZAO2jJXdr4NrTfSgTvt
	MpWzR25lRXL9EfGMr5d/Qnx5IiREJ8yVvainuDlkkP/Qm3KV0ulh0qc+NFFcNRLwrV70PI
	LL5POGAsZqCmeSgXtrhFeHuAJBUFeiL9+fxCIdlNJsYnzWvLGgoZqykZN4OBiQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792624428; a=rsa-sha256;
	cv=none;
	b=a330ypcBsbWmtw6FDb/01tooDn9wZdDQak/RYxtOwEgqVm1sUOH2AJZejj5KfOJL/u+iVO
	Ok4ja5PTsLzxXT/eVpAA4TpreO9h/EMeBKp3Mdq/h/4lgUB+Yp42d2rmz6MDq8VqLZSBEy
	f2m+u9F5JnXWW4H938/SxjEj/vUa9j33bzUTCVJlicVB5KzuK/XJZCa29lvyockJtmH89t
	J24+fFeikHA+HCVqK0ti/Jc2Jrv0k/h+T2jPbjuWHFzFy4jjk1Jpgv0Z0OP2Ginz4Sq1I0
	LItBhbzaEyTE7qOHpVv1B5SCXhXbRJO5Wybxm+70Y23u1WxRexAH1E2mBAgBdw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792624428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x/EerbpQzIDCCfxtdbYFQx6u+XW/yZXRuyEGxPXiKGQ=;
	b=CWtYerFLAk+SJJnQSqclgZHUKNDaQ7skc0cJ6FSiIoAr4OtVmTR0H1uvUOVnXcxYDGNrTH
	uDy1StHjldbRWL+xBApS99zPtgciihr1WDlFW1zq680m9FNItUdHEn2h6rhYqNyaCvW0jQ
	YpAyb4lQJK00GMU/QWdrCk6ktQoQwTt77OsNFJwXM+pNHvHXglPpbchz/59FRY9gNaN6WE
	/Ol6ew2yw9GJhtrUmAazBwX+BFjHLYzxcXvLkJYBCnLwZYvgwzHdjMcMCYYXq/gbNJkyuh
	o+lYTOhtcP/uQjhaa+SeiSV1nYEuoSiFnlLnjXI+DZxGPXnC+WSZnztugopyIA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJfVE-000cif-2r;
	Thu, 22 Oct 2026 01:13:48 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 47A015D072D;
	Wed, 21 Oct 2026 23:13:48 +0000 (UTC)
Date: Thu, 22 Oct 2026 01:13:47 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, 
	runyu.xiao@seu.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH net-next 11/11] can: protect the receive lists with a
 per-device lock
Message-ID: <20261021-industrious-rooster-of-respect-139f21-mkl@pengutronix.de>
References: <20261021102756.1900679-12-mkl@pengutronix.de>
 <20261021205534.1620083-1-kuba@kernel.org>
 <47b77a2a-ff3d-4189-b633-54b1fad3cd1a@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="tmxh4rha2oermskf"
Content-Disposition: inline
In-Reply-To: <47b77a2a-ff3d-4189-b633-54b1fad3cd1a@hartkopp.net>


--tmxh4rha2oermskf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 11/11] can: protect the receive lists with a
 per-device lock
MIME-Version: 1.0

On 21.10.2026 23:59:17, Oliver Hartkopp wrote:
> Yes, changing the order here to
>
>         rcu_read_lock();
>         dev =3D dev_get_by_index_rcu(net, addr->can_ifindex);
>         if (!dev || !can_get_ml_priv(dev))
>                 err =3D -ENODEV;
>         else if (READ_ONCE(dev->mtu) < so->ll.mtu)
>                 err =3D -EINVAL;
>         if (!err) {
>                 dev_hold(dev);
>                 WRITE_ONCE(so->dev, dev);
>         }
>         rcu_read_unlock();
>         if (err)
>                 goto out;
>
> is a good hint from sashiko-bot and follows the raw_bind() concept.
> @Jakub: I've sent a V6 only for this single patch 11/11 here:
>
> Is this ok for you? I think Marc is offline and can not re-spin the PR ri=
ght
> now.
>
> https://lore.kernel.org/netdev/20261021215456.119268-1-socketcan@hartkopp=
=2Enet/

pw-bot: cr

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--tmxh4rha2oermskf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatlHKQAKCRDMOmT6rpmt
0h+PAQDi27CIy1rVNaPP4/mh5kn6j0MdI07QPWExdOXF1RkTjgD/RkjKkVG3l3+j
q32DE5fbv4cSiTyEf4cLchzw19Bb4QY=
=2aq5
-----END PGP SIGNATURE-----

--tmxh4rha2oermskf--
