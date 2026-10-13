Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35D73F39ED;
	Tue, 13 Oct 2026 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901643; cv=pass; b=VsHC5qYshIEZRu6DZcayQlCCkixgKrqtg6aRQu26qRdQIJnoREUv48u3AjVdsr49HQQDNYiEHVjKHsUMCvG6dJytRv7NGBO2PPDJbbj6GEhNtMfzo866WNfmjhiOENgC1i4DO0tCFix7ELZXtAGWhx9/JtYYAyj3WpOBdXuNi48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901643; c=relaxed/simple;
	bh=H+/6flN6EIebDL8txC+8pIK+BNBctC4gEmFyLzzRBh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQXmOdJGnAylZZE31W+1sGQotaTnjxIcZyhvaRS4RYIVshH6An0EpK2mxtNPc1VPheogY6rU2RS9fAAqLZ2zXyA2ge7P87MGR6gNO4HSiXhTxu+vnYUk1ru+b1puAKSXLB9G1+nlGB2uIr/U1vxIsJJPEtuhNwKxIBCCp9PrrvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=gmAViN1S; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="gmAViN1S"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 805422018C1;
	Tue, 13 Oct 2026 16:27:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791901637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ApdHT9jlstoFu3E8M4KUrdFK8TNXHrk50WUdd+Ue74E=;
	b=gmAViN1StYgezRvrnW2kU8LQG8nMplvHkIg+MierkaxjevnZyfzwz2xBT3bQZ/Lx2On66e
	CxZEqSRp7QUJczqg6DXtuwRFjWeUrdY9yxtUsaNcvLXqkBXvfekIH5AXc8P5+EoBIO/cCR
	CLMiMhVkysMTlrD5KKWKWyxlB317sBBB69hXj/EfsbTvMeldaOAc/qFbkT+sB/7gIh1I1s
	IrEgx+oQ8a03xHgo4L/dYoxwcSEGq1gxQ1OSl19BJ3FOAFfVFw6QbGscuqQ2siuorLz8tI
	DOm9vTThYYK8qVtXI/CkZlMfYsvXF1GLy5frs94qdDe3W/zF6nT9VVTfFKRaTQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791901637; a=rsa-sha256;
	cv=none;
	b=BDXTtdWUkb9ZmZKI6YGH0IyAPrPSXhaar59i2sS6xaP2XB3PAz9yy/y+eEYlzp/3kKG3Lb
	/GHldNmy/YDouinmqqgbO5+qvEwMf37IWsHG60/cvIGFunGXArKj+y0zmUtARQbf5oEw2g
	aOX8ok8x+G7ujGhJnTOyBCggpNnMk8fZuruZ74RAwT0rl+mS5CB8OK3PeHgh7dW+Eh928z
	QDB3FdSTFBff8M/pWw2CI8saJnAK0/4OPtea59luZ5UnNvsU3EqP6QU3ikOx82H+Ye2l1E
	sHF29Jj1xEbX51X652LMo81vWn4NZfEw3OfSxPtV63h+lUrjRzGglIkeQGN8Ug==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791901637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ApdHT9jlstoFu3E8M4KUrdFK8TNXHrk50WUdd+Ue74E=;
	b=f1QeBoW0Ze/ClU7CMtKhrNIi3ByiryX7MiewNu1+Sdzb+h3dJ9+7RT7HD1Z4Fu2PLkn8ND
	T8zWl1BCf6IZCvaiIN1vAWqtvpmvHBhx89nvOv1w6SHBNd7UIKKb2Bxxqjut93IJE3w4Oz
	n9uUASxmUnDTHoMIzEoYr9mdPTrVQH8/TrzqNoQx8Xdey7KU+DGe+618tczic++uLL8fQ2
	SuevtlTvbvVPLKsjW0P1Lzd9qaj9jDf68eqI3sqVQvbe2kF/nUGF7dNE6j0pJ4zvjeebRg
	kPr2tp8PUecAK1nDJF5VX2KeahtdWU018s7EAwvdyFDDF0t913j+l1uLgjAFUQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xGdTJ-005hqR-1L;
	Tue, 13 Oct 2026 16:27:17 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 191795C31D7;
	Tue, 13 Oct 2026 14:27:17 +0000 (UTC)
Date: Tue, 13 Oct 2026 16:27:16 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Cunhao Lu <1579567540@qq.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-can <linux-can@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, kernel <kernel@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>, 
	linux-rockchip <linux-rockchip@lists.infradead.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
Subject: Re: [PATCH net] can: rockchip_canfd: stop bus-off restart before
 closing the device
Message-ID: <20261013-tricky-piculet-of-ampleness-cada4c-mkl@pengutronix.de>
References: <tencent_5802EE88434010229EDF7A53084D994C6106@qq.com>
 <20261013-hissing-saiga-of-endeavor-ef5e03-mkl@pengutronix.de>
 <tencent_F9D491A400474428BFE7262F1A1799A88407@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p2fdgwty2yztquzs"
Content-Disposition: inline
In-Reply-To: <tencent_F9D491A400474428BFE7262F1A1799A88407@qq.com>


--p2fdgwty2yztquzs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] can: rockchip_canfd: stop bus-off restart before
 closing the device
MIME-Version: 1.0

On 13.10.2026 21:06:21, Cunhao Lu wrote:
> Hi Marc,
>
> > AFAICS this is a systematic problem and should IMHO not worked around in
> > one driver only.
>
> Agreed. I initially only noticed the problem in the Rockchip CAN-FD
> driver and did not consider the common CAN code.

Thanks to your analysis, it was easy to reach that conclusion. :)

> > netif_running() tests __LINK_STATE_START, which is removed in
> > __dev_close_many() prior to calling the driver's ndo_stop().
> >
> > Can we make use of netif_running() prior to calling do_set_mode(dev,
> > CAN_MODE_START)? from can_restart()?
>
> If you have no objections, I think it would be better to put the
> netif_running() check after the existing !priv->do_set_mode check and
> before netif_carrier_ok():
>
>         if (!priv->do_set_mode)
>                 return -EOPNOTSUPP;
>
>         if (!netif_running(dev))
>                 return -ENETDOWN;
>
> This would preserve the existing error precedence for devices that do
> not support restart.

ACK

> > can_bus_off() should not schedule_delayed_work() if !netif_running().
>
> Agreed. Although this would change the behavior of some drivers, I think
> it should help improve stability.

ok

> > We still have to call cancel_delayed_work_sync(&priv->can.restart_work)
> > from each driver, though.

Let's wrap that into a function and put this into linux/can/dev.h. It's
name could be something like close_candev_cancel_restart_sync().

> I can make changes to the other drivers. However, I do not have the
> corresponding hardware and would not be able to test the changes on
> real devices, so I am concerned about the risk. I would like to confirm:
> do I need to audit and fix the restart behavior of every CAN device
> driver?

I think it's OK to fix the rockchip driver only.

> > What do you think?
>
> I will address these comments in v2. Thanks for your review.

Please split the changes into several patches:
- fix the existing infrastructure
- add new close_candev_cancel_restart_sync() function
- use this function in the rockchip driver

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--p2fdgwty2yztquzs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCas4/wQAKCRDMOmT6rpmt
0sMkAP9SLysRPyc/bN1kfprQlX5GQAMSIsfWuKXrKvknT5XDYQD/fce1XVIeVE/g
Wu3BWgWdmmI0Sq7/V4pT4SEDHKDXXQM=
=J0Bg
-----END PGP SIGNATURE-----

--p2fdgwty2yztquzs--
