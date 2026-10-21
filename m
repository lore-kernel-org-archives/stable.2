Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792566848;
	b=ByR0g8BcEG3K8hDHCNNpi4UdqgL5OhDny86amM6+0L585bzPfD4DXrxwq/NjZod5qbzN
	 DybyYUi/khruzmIfvesRkqiUmDr6l+8MeDDcath88kexqutSbKb1Z+EONzrOrEFRCwxvY
	 SNxYeZKaMs3UOZx8RHZRjN0pM1RBOZaqjxggnKW5oP9ati4JX0LyjQ6MjYiPzZ1DNxlyN
	 koEcqrtvIvxGvmlgSFpamU9CKxUWMoQwjs5md1aRYg9j/8pT2xaqozBgqoU7iCVTN87bg
	 oz4yozVScUH3ngaFk+a9ViRyfr9EBk0YyyTYqF8zt7x046498nbJhS9LYMb+TjkoD/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566848;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=xW+DrLlhsj3i2ST9zEExY497nn4pt6HBHPaGRt1skVQ=;
	b=HGes1woE6irwrRvd0ELFtbDl9gIBnct/gjL4TBcjsAfTA+dmb3MVRvC4/p7ElnuAmC8H
	 3LwyABviWulZ3g2dpRpRqscICcWuHsMBnpZhS/ZtSbnQjVll+pNFl+BrntzXVoi9kp20c
	 Ff5x9ZERtAV4ySguv62dtu8FrauOEfFP0SClSNLiWc2uvdloocTriXgwQx8Mb0Uywo8UB
	 3lzIJqTE3Z0RCd+41zJAlQ7M1SLRoIsJjfTR0Zgt13ccbkYSZ5jwTdEzMbmjopMmRoJu7
	 mdlfWNB45jFpDVc5nFI4/zNfaEnBUkNJ4kW8mMpc4meQY6CDjUiuOUnXDgIdS4TSJFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LJb14zGL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539B6606A31A;
	Wed, 21 Oct 2026 07:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 539B6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LJb14zGL
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 21045200758;
	Wed, 21 Oct 2026 09:14:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792566845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xW+DrLlhsj3i2ST9zEExY497nn4pt6HBHPaGRt1skVQ=;
	b=LJb14zGLgex/M1IZueP1de1Iji3jjgp/cFv1aslkSpLxK9qUsNzFkgUOinJIl0MIU/l9Rt
	QYeODM0HXPxmC+RFdQ5JZRDduFhQHDGUcSAdoqR6ANbv6YezxKbo4sdto9ZwBkJeVCdw4j
	BfXhXEoN+8jNj5tbwHHA8Tq9sOUhF+qIM63hBT3BDpJhhvXWaeB4KuiB3kQZAUqBmjv388
	yVDuV0FNhGtBUqi4q4uE3I2sqSgD9YT6/Qi59bLWEDOkA96qQf0dQhHTlrBxdfO0sKJxLw
	NBTGSze5yYXulVL3KHWA7P22E3lLO3V2By0SAiQ6fSYW/NMkg/MXsqeGMaEivA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792566845; a=rsa-sha256;
	cv=none;
	b=IYmqaARi7lTRxPqsWAhJ5BWq3onF3a5m0NoFLZZsJsDhisSBZf3zTTHWCvAwuaEwtVzbIf
	4BFtzqhLOPuJeRhX9iUje4iK6hgC+NGhnhRJALDJyd3jMMTU8L14WneG61fs5DxrvFTyig
	aTkbxyLnXM/brToidMZ2auRV9D9YiP2BcefAvPG75WHkE7QK/GGXL1478Hz3VjJBXDV726
	HI44wJp5pA1bjkrC/zUZhKRvm2gn1x+o7QHov3J8sg6Hq1gMVcDmmpVrvnq86F0US3ybNT
	3f+sMNgDNK/mYZ7AcILE3ZhKRO9qJIT/j0Ko668AMS6Dbjwb/GVl4ATeKRSAnw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792566845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xW+DrLlhsj3i2ST9zEExY497nn4pt6HBHPaGRt1skVQ=;
	b=VQuON+vEpiNieAH8VuiC8sUzkjit5KtcSU6kiK+ejy6njFqymVKaMUHcE1pCEw6mtnpi6a
	9ydgGl5gO+ukI48SXmf41irHN1tAvk51kmwLosaZ/sbNchvcwXibtLXvPqXKGiqk476szj
	sI1SW9fwK4z7HInY0gHc8ffP9mWzZ+ssZabjdGmjv/9G7SMpdNRFYJ0tdE7QkPqezznKJF
	T/CEX8e73fMPHl3BZKERKm68yftFMoqVuICBeyPQbk2pPMNzUyZ3dx2vglp1lkCNtaGy0k
	2lDed9SiSmWR58s8l6eDAm9jLe2bIRNWYeni6cB7iu/tAOU08Ovtc7XsBRs0Rw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJQWT-000WVn-07;
	Wed, 21 Oct 2026 09:14:05 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B50BC5CACAD;
	Wed, 21 Oct 2026 07:14:04 +0000 (UTC)
Date: Wed, 21 Oct 2026 09:14:04 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, haibo.chen@oss.nxp.com, 
	shawnguo@kernel.org, imx@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v6] can: dev: can_fill_info(): don't wake up controller
 if interface is down
Message-ID: <20261021-romantic-jaybird-of-cookies-1ed8e1-mkl@pengutronix.de>
References: <20261021023334.11803-1-chunyuzhiqiang@yinhe.ht>
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
	protocol="application/pgp-signature"; boundary="b4v5jvssqpnf3qex"
Content-Disposition: inline
In-Reply-To: <20261021023334.11803-1-chunyuzhiqiang@yinhe.ht>


--b4v5jvssqpnf3qex
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6] can: dev: can_fill_info(): don't wake up controller
 if interface is down
MIME-Version: 1.0

On 21.10.2026 10:33:34, ChunYuZhiQiang wrote:
> If the interface is down, the CAN controller might be powered down, the
> clock disabled, and/or its external reset asserted.
>
> Don't call do_get_berr_counter() or do_get_auto_tdcv() to read the CAN
> controller if the interface is down. This fixes a generic logic problem
> that exists on all platforms.
>
> As a result, IFLA_CAN_BERR_COUNTER is no longer reported for down
> interfaces, and the automatic TDCV readback is skipped. The other TDC
> parameters are still reported, as they are meaningful while the
> interface is down. This is intentional: the counters and the automatic
> TDCV are not meaningful in that state, and calling into the driver can
> wake a runtime-suspended controller or touch registers whose clocks are
> gated.
>
> Fixes: ec56acfef2af1 ("can: flexcan: flexcan_get_berr_counter(): switch o=
n clocks before accessing ecr register")
> Cc: stable@vger.kernel.org
> Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>

This patch doesn't apply to current net-next/main branch. Please rebase,
in particular you're missing commit e63281614747 ("can: netlink: add
initial CAN XL support").

regards,
Marc

pw-bot: cr

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--b4v5jvssqpnf3qex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCathmOgAKCRDMOmT6rpmt
0uj8AP4yGFQJIMVqlEI5/+RDEFA3+3pBM6fgdqjVSuxrMOme8QD/a8ofDu3h4Vvs
g84TZrMgmn81vb/ggWnqa+m2Z/mbFAQ=
=KxHD
-----END PGP SIGNATURE-----

--b4v5jvssqpnf3qex--
