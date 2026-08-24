Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B45D3B42CE;
	Mon, 24 Aug 2026 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566043; cv=none; b=EoguUDZwJVKnhSRK6UcBxONp4DNOfv5GlatCEBnRE6/x/oPODtXrO1w9JsT5ZjBbKua4F25k5hHR3BKZGN8kDieRWeAVpu1G3LW1+RwR6A12ke3tW4RpAVgBVPQN956noAc4qRTQKWgQ/lrGYRYORjYNz4YIJrCDtOz7emGARI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566043; c=relaxed/simple;
	bh=CgDbmE6b3iePHKsgzQQvpsXNl4tKweSy9suZM6Qsk3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsHEQuKKeR1JtoEQDqxV6y6dQIGuOK9Zx45ANN7z+apeDglVX4qb1sqwIX+4NAF8hIgAOLK8wi44wFR8jhcWEiwN24/JfAWxo86kz06iDyfDX0nqLm3JFPKkAfAxrHL2OKcejPE1BycMN7hAcxoSC7nw4ZDhNbA2TTMPwwJG6x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 09E7B201917;
	Mon, 24 Aug 2026 12:07:17 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wyRaG-0035Vy-32;
	Mon, 24 Aug 2026 12:07:16 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7638258B22C;
	Mon, 24 Aug 2026 10:02:08 +0000 (UTC)
Date: Mon, 24 Aug 2026 12:02:08 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: PS10 PETER HONG =?utf-8?B?5rSq57m85r6k?= <peter_hong@fintek.com.tw>
Cc: Greg KH <gregkh@linuxfoundation.org>, mailhol@kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, admin@dynetrex.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] can: usb: f81604: fix struct f81604_int_data size
 mismatch
Message-ID: <20260824-barracuda-of-exotic-mastery-0c55bf-mkl@pengutronix.de>
References: <20260824082758.9118-1-peter_hong@fintek.com.tw>
 <2026082433-dynamic-overspend-8f32@gregkh>
 <8b816ee1-a81c-4d5d-a908-97e8640b07d2@fintek.com.tw>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x2xppsvbc4lwyie6"
Content-Disposition: inline
In-Reply-To: <8b816ee1-a81c-4d5d-a908-97e8640b07d2@fintek.com.tw>


--x2xppsvbc4lwyie6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: usb: f81604: fix struct f81604_int_data size
 mismatch
MIME-Version: 1.0

On 24.08.2026 17:38:23, PS10 PETER HONG =E6=B4=AA=E7=B9=BC=E6=BE=A4 wrote:
> Greg KH =E6=96=BC 2026/8/24 =E4=B8=8B=E5=8D=88 05:08 =E5=AF=AB=E9=81=93:
> > On Mon, Aug 24, 2026 at 04:27:58PM +0800, PS10 PETER HONG =E6=B4=AA=E7=
=B9=BC=E6=BE=A4 wrote:
> >
> > Fixes: 88da17436973 ("can: usb: f81604: add Fintek F81604 support")
> > Fixes: 7299b1b39a25 ("can: usb: f81604: handle short interrupt urb mess=
ages properly")
> > Cc:stable@vger.kernel.org
> > Signed-off-by: Ji-Ze Hong (Peter Hong)<peter_hong@fintek.com.tw>
> > Nit, doesn't match the From: line :(
>
> Sorry, our company recently changed mail system, which now overrides
> the display name with the internal name.
>
> Could I resend the patch with the internal name in the Signed-off-by: lin=
e?

You can use the b4 "web submission" instead? It bypasses any mail system
completely.

| https://b4.docs.kernel.org/en/latest/contributor/send.html

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--x2xppsvbc4lwyie6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaowWngAKCRDMOmT6rpmt
0qmCAP93x5vcBx9W9cGk8+wgwRG/k22W2iaE3Xwi/jdsgWZ9zwEAk9fuFk5Ys6I6
TqwdX3MQAYu87AyB4Eb4ZV5fZB0CkgY=
=/QaD
-----END PGP SIGNATURE-----

--x2xppsvbc4lwyie6--
