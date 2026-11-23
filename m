Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795453200;
	b=Etu0YJRTyGR4j2Fz1AgC/jVPJPqtcLF7XqLFuXUjG2pENUuT2yPS7TxDQuB/HvxJDWMT
	 2mabFjrsPPwzrbYDKkbVdI+efG1i91bRK/FqltqfMpWpmYrtiK+0smRBjON1dIo4D7QwV
	 xptn1bllEo++PueXqw8Q4IcQ7djOUKjui6/9smbuhB5Fs4HXleb7oclLUGOimfOAqySV4
	 ImbFRAVqdGgGibw4qS7kvHHmUGNVi/tAD3oe2wsowS0WmYNjKKzoaeLWjVJd/bxqVNlKF
	 gH8CuHy3A7NkeVeNYiE5kzZ05scHeX1tlnxZFVQmOcWwOYPU5PdJ4UoLwEs4NWFLEVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453200;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=UpTLdu5CcH8lF7t/Sm90Ly0kN2suiiHm97i5LAO+3Zc=;
	b=Qnwy9IarF9EAVvdzlyZZ1SY8myX/PlAiWeLveIpCcSZF1lg9OFG4mLmZ1EexgkSKB5iW
	 dPjMWh7YFCK/zYgq8EwWbGb65QYZDvjpg7r20DL1DTuLbCpvJWL+CqPzh/DixaTZ7JV0W
	 Kxm4sXpYx/+IE6NWX9RLh/z5lDNe/rv8mIS0HkoKA1/MV82FJMpB4B3rT3MIJlpRFBjKY
	 2gpc1Ox5RjC8t5Tbn3FDKqYRFzCPvdG78AggMlAW7zFA5IpQA0jrv5d4PRKdBKU4+BTC/
	 dLOccq7iSI87TFgEwB8BB7NrzTIqg+H0I+vBVFu1qQHX5ekL7ovEd7WcoeccLFKnFUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=YYEXCtNB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE45606A31E;
	Mon, 23 Nov 2026 16:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EE45606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=YYEXCtNB
Received: from pengutronix.de (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B0054201BD1;
	Mon, 23 Nov 2026 17:59:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795453192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UpTLdu5CcH8lF7t/Sm90Ly0kN2suiiHm97i5LAO+3Zc=;
	b=YYEXCtNBvwDNCbDrkOFKZXrsfeA53MQC3ROu8BS2jehRiah4g5wmOiwU/KYpgXU+T9rqmX
	8YPC0IOH8b3pHBbYxmhq89Xv6NUCR909MWn/wGveDAF4A0rGB5iewIGmUxcCbido+dm4oO
	Kab1sJTT2BQ+KXD7aQBLq1ldu58ABB8PURKg2OHMvZii6nPxW9RXMUIrf2oBSHjRP9g1Dh
	CntuD5sY+eETi6/5tICYjifvuNylk23RbQoR3jbgvgSSkQr7HjbnxTG0TrEEG5Lnnx8q02
	G0zD3VPHSxSd/levQLc2ZFWv7vH5japKV3mYp2NGmiPrpuFWRTVi5hNYptgFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795453192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UpTLdu5CcH8lF7t/Sm90Ly0kN2suiiHm97i5LAO+3Zc=;
	b=B9Dk1P+Bo5x9X/H+bvhrM/JjPru9g6x7ztHbw6yzvvlDTnR2GrCrtH2zS/fCQHRCRPL2Bx
	biuiFILweZ9zXBhOP4EuaJVqInoAajPnztE/pJ82RTl7fN/2DTELE094CbDmzZy8N3HRZ0
	Gzq46EelNEdCPOL7lk55AW0gGe1I8lshlQWeTfRkRd6Rq0VxTcdjKcLe2hq/d91mDB+oaL
	Io2fl/goluuxkeDTRE2IQKFCLvcLBMruce9SDxacA7WY08MaXey0wl+L53aN5fao0qJMjt
	ZWC6oIKbK9C/bJB1kiR93Q+JLnFRHSwL7i4eKlqgZ7LBuTFY4n3hgKw+drKeaw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795453192; a=rsa-sha256;
	cv=none;
	b=DPrQbCA0J/aZCxcLWwJUO8ri6d7l09sXa7qMhOM04qqf2cKLo6nQNTM2MkCAz7CXxA7Pc2
	Hz6njIEndGhCSlDnk1UkvSHEn5jG65ivrtWYY9Lg/vUBD+Aa30PHb/cobKyMsVeJeyTOfG
	REhj3mpbLGuvoghfKyhVKvwLw/TWLyoECuHd5A3NIx++r+bBo6PuEe7F/6Eiy0u6OZGd/5
	aVgKAeqrroBM+okf0an5P1VMGkJ2p3mbm6iojJhS3K+cHpGqp3N0P8WRmtgPjaejSTiARl
	PafI19IQo3Zn9mLhbwpCU+4P0qvKPukbPZkkXhKH8KW7FlfSs7P3+S5i6zcZwQ==
Date: Mon, 23 Nov 2026 17:59:52 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com, 
	max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, shuangpeng.kernel@gmail.com, stable@vger.kernel.org, 
	vadim.fedorenko@linux.dev, kuba@kernel.org
Subject: Re: [PATCH can-next v9 05/13] can: gs_usb: fix hardware timestamp
 state for mixed channels
Message-ID: <20261123-busy-clay-sheep-525906-mkl@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-5-db121d488945@pengutronix.de>
 <179543522241.3131.6628219369362226414@kernel.org>
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
	protocol="application/pgp-signature"; boundary="4ik6btt3gkq67g65"
Content-Disposition: inline
In-Reply-To: <179543522241.3131.6628219369362226414@kernel.org>


--4ik6btt3gkq67g65
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v9 05/13] can: gs_usb: fix hardware timestamp
 state for mixed channels
MIME-Version: 1.0

On 23.11.2026 12:00:22, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] In drivers/net/can/usb/gs_usb.c, gs_can_open() has an
>   unbalanced brace in the new gs_usb_timestamp_start() error handling,=E2=
=80=A6

will fix.

pw-bot: cr

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4ik6btt3gkq67g65
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCawRxBgAKCRDMOmT6rpmt
0kaWAQCPBtmAN7ZtzrB/VlODwz2GWTNBwRZgTSDqb4rh9+XlLQD/Rtv299BlL0+s
yntFuZ4YvXOC/iFnCidielmGf9QdEw0=
=NBCf
-----END PGP SIGNATURE-----

--4ik6btt3gkq67g65--
