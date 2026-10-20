Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792487320;
	b=2XZkLtHQq4oLDC4Op4cjZM5F69CPL9LsZFVqdLQsO1px3Yd4NhXNqYXX/PXKVgkMvkxj
	 clX5FZeY+tTwmyoMarWCpZd0DdYzpkJPhBfIZla3af2hGpARy2X/9KCg+9BqpYCAANj3s
	 WufqWjd5sBITH/kY6lKY20aa+Gi24B3Ub+4ddI3x6/t9amJ46d8BNGRiV+06tMrMUlcLC
	 W/NdapuzUkSkjGrM9IhzML2hd+uDMVVpTL+Fh3ifwxf7/xUVZ4xihgfL5I79Ti5GsUvj1
	 YEURAHM4XWiG10/NLC8+7/QTk7SRDDTZ4jQHK5HK6SoMVWnGLywyMVTQqYcWMJ0OrSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487320;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=SI3NG50e0qifw8rcKAfg82Rn2PZGsgRISScsgeSFDRY=;
	b=hHYeZWEr38oLZ+9zuaDv4M08LHra8DzC2EkyG8ZsiZ17Lyinte/iIQoiuNTYZf/lsaIe
	 xQYrGEZ/qGA5boZEyd5nt4KN+LGgmoULWAEe9/VBxw8K5tLbK38pPkHZBPjUkKxBRznXw
	 +bwfw9q+JLkYd4/T02Vw4X7ZWnl8FFbxTQTLqLNBFK/y8g8eAUTxVLDgVj4vvtr4lWpdZ
	 bV4FuLxf+i+YTE1uvZBja8lFzKl4UyDZfjyr9G7TB8i7uAhyPYahDGD37JsoXYeoJZNHn
	 C5N5mIH3TGHCfncRmZyWW88HaQDMlMo+nYxzBPjYVXvS2USqw3QdufKpQ62n6G3675A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SIEaPCGK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D00606A325;
	Tue, 20 Oct 2026 09:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46D00606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SIEaPCGK
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A22EA201EDB;
	Tue, 20 Oct 2026 11:08:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792487316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SI3NG50e0qifw8rcKAfg82Rn2PZGsgRISScsgeSFDRY=;
	b=SIEaPCGK1H9u0hn8qedTLfpXNn+Yo4MptoDtAENBu1oorp9X6fToxUxqA8r455VAqWeb86
	1EIejGU6KVu+D1f4ytKe9n7EYvOt9DoVcZXX43Q4JdEtX5faUABUvp5TGyMJssLvIA7MYp
	syMgjHkfdqPcDMJEw1Puqowmra1fZLx55arx30o0+LRNGFZZNrmAGNLWvhrfQmng4crx4i
	ocPcJdhV1L37VJr+45Ilhdzhhr10tkQH1eRiRBfgAP/FtajS+JNbrLCvP+Y9qpem1tkdKs
	eOAO4IzMIZslTQscYdVZP5cOMHT5Fqtzt8rnHXvstaJbjUYETyIYtEibeIfV3Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792487316; a=rsa-sha256;
	cv=none;
	b=MnU0gGfUhlKxmHnBdRI4GhC5Or7Q5fGUG48Hk7brgTTvnqPGOpxDzG9sgd23Lf+LNbXbgs
	y63K5012keYShgs1MtyezQHsCdf/wFebF8YzSHqSxzG1EqgzZcwvlY8+da9Xk51EQ5OT5o
	Z6ndNLUc0OyVw/lLhW76UsPmqAhoEO/65Ev02go39N6kGgMEdSzR4csoWZQZO5uyl2K8wP
	AkUGaDDV8D0duJ0N5HXdtWhfywAw0h9oC4RDTbJ8DFd2KmdEPo3epQrJh5mirNrZl0H4FU
	j1GN+41hd3T0YEH6pTzAe+O+AcUDnRhDcVatzEqTQx1YmvO22WmT42/ZGMmPow==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792487316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SI3NG50e0qifw8rcKAfg82Rn2PZGsgRISScsgeSFDRY=;
	b=HgNbthJPzXtrs5PHZB3CFOmjJ4566bwTMpg+SmWcJZqNUgENZ6Kz2gpdg/2EsPE08uAJOQ
	htDPnNG3cAPia7umd+DGdH+yPTvfcqMzd9UlgQ++GHJ9Y12+NrNV/RDGj6YPxsZ100QtX1
	9mq0higEGkQm6/hEGEP+1ap9MEy7E2XRwjV85CeM9R8LkmXDk/g1wIHe6/vOOtQ7Czj7mm
	9aCLOVC96CkOItY/HbG+Xon8qN6Q3YL8i3oMHTYNk7r9uygr8HhTZFQ4V1CLCwnZ9jiufy
	5OOddYHFQCYH/V7MXFlxOFEDDTU37AG1xyf++80GAUXA1+RtQ5kKHZnl5tfVCw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJ5pk-000LmT-1l;
	Tue, 20 Oct 2026 11:08:36 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3C1355C9D7C;
	Tue, 20 Oct 2026 09:08:36 +0000 (UTC)
Date: Tue, 20 Oct 2026 11:08:35 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, haibo.chen@oss.nxp.com, 
	shawnguo@kernel.org, imx@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v5] can: dev: can_fill_info(): don't wake up controller
 if interface is down
Message-ID: <20261020-purring-cute-ocelot-54ef8b-mkl@pengutronix.de>
References: <20261018101744.93657-1-chunyuzhiqiang@yinhe.ht>
 <20261020075340.417899-1-chunyuzhiqiang@yinhe.ht>
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
	protocol="application/pgp-signature"; boundary="xhtixbv4xfmns22l"
Content-Disposition: inline
In-Reply-To: <20261020075340.417899-1-chunyuzhiqiang@yinhe.ht>


--xhtixbv4xfmns22l
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] can: dev: can_fill_info(): don't wake up controller
 if interface is down
MIME-Version: 1.0

On 20.10.2026 15:53:40, ChunYuZhiQiang wrote:
> If the interface is down, the CAN controller might be powered down, the
> clock disabled, and/or its external reset asserted.
>
> Don't call do_get_berr_counter() or do_get_auto_tdcv() to read the CAN
> controller if the interface is down. This fixes a generic logic problem
> that exists on all platforms.
>
> As a result, IFLA_CAN_BERR_COUNTER and IFLA_CAN_TDC are no longer
> reported for down interfaces. This is intentional: the counters are not
> meaningful in that state, and calling into the driver can wake a
> runtime-suspended controller or touch registers whose clocks are gated.
>
> Fixes: ec56acfef2af1 ("can: flexcan: flexcan_get_berr_counter(): switch o=
n clocks before accessing ecr register")
> Cc: stable@vger.kernel.org
> Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
> ---
> v5:
>  - Gate can_tdc_fill_info() on netif_running() for IFLA_CAN_TDC, as
>    requested by Marc Kleine-Budde. This branch has no IFLA_CAN_XL_TDC
>    definition or call path at all.
>  - Keep the TDC part of can_get_size() consistent with can_fill_info(),
>    without hiding the non-TDC data bittiming attributes.
>  - Document that IFLA_CAN_BERR_COUNTER is no longer reported for down
>    interfaces, and explain why this is acceptable for stable.
>  - Clarify the Fixes: rationale.

Thanks for the patch. In the future, please don't send vN+1 as a reply
to vN.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xhtixbv4xfmns22l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatcvkQAKCRDMOmT6rpmt
0rQsAP44p13C0FJDoheLomyTm1VKGdoHw1GCjJoCA7idRbdqewD/aQFNnROx2OGI
kU7F50XIuO/F9m2zEK9DjzJ3dXYEcg8=
=BMlh
-----END PGP SIGNATURE-----

--xhtixbv4xfmns22l--
