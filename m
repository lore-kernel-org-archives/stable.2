Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6853655CA;
	Mon, 24 Aug 2026 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584328; cv=none; b=RJ1nCwMSuxWLxKYJMStsXtlxrXPhHxfNwHbNmeexCrUizOOUe87G07fyIKhiNPQQ7jonWBUH7uiQeombyGC5cCVXHnCl2aduefq4a9i50D/2nj89PExTJegPs3/VpEFMAkUJom9la5y/FdbszwLXET0hinkUCLNvUtMGloVpH4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584328; c=relaxed/simple;
	bh=A2RqH/jaftMlRxv+xBpJ27Pe6NxHP5IbHqviH3Gs2cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Udm9+9CxVNi3osR/CDpWarVil4Ub9q3CgviVBRrf9ilAhWVU+JiSDXhF6I84iP7RYH9xQam/h2P8UzI1WyOa937ofaCRulRfNfPXFfGm3W7guYATZKpHtKUdUc4MBRncsOoIBDGOc5zZPyZWAHK6TfmnYMfrup8eNviRm5+32LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 43832200FF9;
	Mon, 24 Aug 2026 17:12:00 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wyWLA-0037uy-0Z;
	Mon, 24 Aug 2026 17:12:00 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E903E58B62D;
	Mon, 24 Aug 2026 15:11:59 +0000 (UTC)
Date: Mon, 24 Aug 2026 17:11:59 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ji-Ze Hong via B4 Relay <devnull+peter_hong.fintek.com.tw@kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, "Dynetrex, Admin" <admin@dynetrex.com>, 
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>
Subject: Re: [PATCH v2] can: usb: f81604: fix struct f81604_int_data size
 mismatch
Message-ID: <20260824-alluring-affable-hog-d072e8-mkl@pengutronix.de>
References: <20260824-f81604-fix-v2-1-fc9be5581394@fintek.com.tw>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2rgw3gn2fwjgklpi"
Content-Disposition: inline
In-Reply-To: <20260824-f81604-fix-v2-1-fc9be5581394@fintek.com.tw>


--2rgw3gn2fwjgklpi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: usb: f81604: fix struct f81604_int_data size
 mismatch
MIME-Version: 1.0

On 24.08.2026 21:18:14, Ji-Ze Hong via B4 Relay wrote:
> From: "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>
>
> The struct f81604_int_data defines 9 bytes of interrupt data:
> - Byte 0: Status register (sr)
> - Byte 1: Interrupt register (isrc)
> - Byte 2: Interrupt enable register (ier)
> - Byte 3: Arbitration lost capture (alc)
> - Byte 4: Error code capture (ecc)
> - Byte 5: Error warning limit register (ewlr)
> - Byte 6: RX error counter (rxerr)
> - Byte 7: TX error counter (txerr)
> - Byte 8: Reserved (val)
>
> The hardware sends exactly 9 bytes for the interrupt endpoint.
> However, the struct was defined with __aligned(4) attribute which
> caused the compiler to pad the struct to 12 bytes.
>
> This causes a problem in f81604_read_int_callback() where the short
> URB check compares urb->actual_length against sizeof(*data). When
> sizeof(struct f81604_int_data) is 12 but the hardware only sends 9
> bytes, the check fails and valid interrupt messages are discarded.
>
> This results in the driver only being able to transmit once because
> the TX complete interrupt is never processed.
>
> Fix this by removing the __aligned(4) attribute so the struct size
> matches the actual hardware data size of 9 bytes.
>
> Fixes: 7299b1b39a25 ("can: usb: f81604: handle short interrupt urb messag=
es properly")
> Cc: stable@vger.kernel.org
> Reported-by: Dynetrex, Admin <admin@dynetrex.com>
> Closes: https://lore.kernel.org/all/A3834A07-5639-4779-844F-C5843DFC3928@=
dynetrex.com/
> Signed-off-by: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>

Applied to linux-can.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2rgw3gn2fwjgklpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaoxfPQAKCRDMOmT6rpmt
0hmXAP91xu9xxDOYrO8cHst+E5lzaoro3Ss9f94pRx5LgQ4RWgEA4UX6dWR7uhJs
akVJhD6uAWYnkgtbM5vxPGxh4I5kJQU=
=PjPm
-----END PGP SIGNATURE-----

--2rgw3gn2fwjgklpi--
