Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792498819;
	b=tyKXbHGSRzAvnQBm3Fe8uHuX8+ZCMVvRTbqB6H4Op0YGIYT7PB9dvVUFn9W2VbTsQo8d
	 qVKeCiu9USkQi9I/8+ExOHnlfKX5MNg08UYxZyDNrn1LmJrlqDvHX5+PS3BLZzY7pY3fR
	 FKOvWe41EaWpk0vjHtUQSMwPZYjr522F7hTDqWgvtDWiWyRPgrz8iKvfunIdnUdEx2JnM
	 IlmHU2hml7kA/bJoAP0h7SmGv/Ujb+c3AO3+XU5UcW+xIOD1S8/6PrmuaBqEfuk43goSl
	 6Fu2l5nrVLZeHeiGNE8W5D6X5Yome/GHhxLAMfyU8kV4JHZAnORmwSqw+nM3PT+8aJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498819;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=wznNCRKHtn1iM9EvO1UMzM82x96//EGlJSq6jELOgak=;
	b=5iHUggbtEYgDfuNUQAgk5NtFgGTHT+3teKnGt6HwENIt2vDDrb618/EUElDGN6b+0lu0
	 M3WAHmCJlGY5zW9fAfE2S/kH6bdGefbpX1gsNaLQIow9zuRDqov/YdyQQl4tgJ3iKNw/6
	 V6a4cqoXxxqs7qjk60QrEx0tg1SG9VRv1NZOcFUloQ9j5TZCIvBLpqh5mGdB48/J+oH8b
	 FDFb2jyaGDYw+wWu4AfDV825CG6siGNN64fh935hu6NvhAM2nIRC+MutGkM5CTqDt9HRh
	 GEnIJ0IdSMrhSJXsuN+sk6uAMzy/3TaXN+6+9cDXyEHhKFuSovENlmcDY3ux/6vybMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=P5BmVsGM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5F1606A33D;
	Tue, 20 Oct 2026 12:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E5F1606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=P5BmVsGM
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 521F9201EDB;
	Tue, 20 Oct 2026 14:20:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792498816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wznNCRKHtn1iM9EvO1UMzM82x96//EGlJSq6jELOgak=;
	b=P5BmVsGMl6TW795WF/XQZb/3Ngvx4XMNNB+tUG4ttxk5H9NojOr1MqetCCoWC+/NlF0DFD
	idzG3jxi5EJl00OInDoKxLhHYMB/vSSBQLhges08ddPNJEBvAF/j0NcmRpK9lRKTqaclRQ
	o97BZLaKj9HL7pcVCLFLXlmIWdIn6458sERehOtdlTJAvbmHa+mTsHEtsO9bKayDdzAu31
	klKzRRwKkx1axzpH2B26GQLQ4G5K2HE5AXhuTTLbOPNLM3W94Z+k5GUVbxCx136V+BsMMF
	pDfffXp/g2/nIzZuABLYH72OQ08Dc6m1fs2LFO9Wx0lf8hrlBxaLHMJ6p3vOcg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792498816; a=rsa-sha256;
	cv=none;
	b=HP50idT8l3jSXcw623YS6fFJlNS7xlD6trJkMyp9QnOYF60ccN2x2poaEyZwBixNob8o/O
	EO3l7VZTmAgUG6sH0X3G56FxxfIaecsyj2tOn8bmUoI361Wa+3khefnwsIxgLX+3ewccdq
	R10hbQFGdXb63RJfwv7aJ4GiZJ4H0QpWaz8xO8dSQZ7eV/9EXVHAzzFBnMjLoQh0Phq4OQ
	PdgQTkmuj3Mqvbqdgu7DVR1z6vs8FYbrmwyZD7yOjsZerPD68D22Sgcxx+/WYQ5/+hx2md
	rYJSpgyURaKhH6juiesIhseLbFKbbHJYP3iVZHr7n67D1LY7gnAqNMLsAVMTfA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792498816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wznNCRKHtn1iM9EvO1UMzM82x96//EGlJSq6jELOgak=;
	b=JrbvSXOM1mMNRcfNYcFCVQOT6WPCV4flyN8bqSu3g20Qp9whnFokNVi2CiliuHMy8/cFUn
	G3f2qI1ir6JzzxwcZgUzrPRvXz1yO5NRWqO/CRU/jlGyAmD3AdcHKuljkvdz1AY2LgwxFV
	Ff2gTvbIbAztFRQd50SwAXyYHXqi3MI+sb6jib0iW8up1HciMuTzNBqbTGoKOnctyi9SaY
	gNjySsV5O1OjdWJxUdk3CVCcED2dcleu54lb20fJC9/Dsa08/RrEEwVgVyJl/SVTx9pkLx
	cC0UB36Y4e1guNRSpI76LrtGQV4fZofaN9TKFQx3VfqvFZ30F4KRxi66qYJVng==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJ8pE-000N34-0l;
	Tue, 20 Oct 2026 14:20:16 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E4B045CA0EF;
	Tue, 20 Oct 2026 12:20:15 +0000 (UTC)
Date: Tue, 20 Oct 2026 14:20:15 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>, netdev-bot+sinfo@kernel.org, 
	netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de, 
	haibo.chen@oss.nxp.com, shawnguo@kernel.org, imx@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v5] can: dev: can_fill_info(): don't wake up controller
 if interface is down
Message-ID: <20261020-nebulous-meaty-guillemot-bb7589-mkl@pengutronix.de>
References: <20261018101744.93657-1-chunyuzhiqiang@yinhe.ht>
 <20261020075340.417899-1-chunyuzhiqiang@yinhe.ht>
 <CAMZ6RqKpP62XS5tPR714wUmwf6QkdY4V5fb7c4rTFSyoDc+DAA@mail.gmail.com>
 <20261020-precise-panther-of-symmetry-db65f4-mkl@pengutronix.de>
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
	protocol="application/pgp-signature"; boundary="nhduwjfuedzjltb2"
Content-Disposition: inline
In-Reply-To: <20261020-precise-panther-of-symmetry-db65f4-mkl@pengutronix.de>


--nhduwjfuedzjltb2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] can: dev: can_fill_info(): don't wake up controller
 if interface is down
MIME-Version: 1.0

On 20.10.2026 11:51:10, Marc Kleine-Budde wrote:
> Yes, the call to dbt_params->do_get_auto_tdcv() should be gated. Also
> check if the size calculation has to be adjusted.

pw-bot: cr

Marc
--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nhduwjfuedzjltb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatdcfQAKCRDMOmT6rpmt
0ms+AQCNjeuij2m7hnT3oBUURNKN4beYCNdM1WnZwZS7UABeIAEAgwL1U0D8Xxcz
nca95JtOHUYJ6DbtY23yjikAIH4CgwM=
=DDNG
-----END PGP SIGNATURE-----

--nhduwjfuedzjltb2--
