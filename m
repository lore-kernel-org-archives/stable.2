Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B4F4E56CB;
	Tue, 13 Oct 2026 10:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889127; cv=pass; b=UdFm2pwxOfwueQWKJ0i+pY8y+VzWgBYJVzxdUR1GI31tNw8ov9hIqaJqtBY6CLKJfCCcltqCBnzwq58FQnFSD7HLxRy9ikZyPsfoJmEOm8TvWKqbXWy3nCBgcZSKa4zMini2ilnQco9c19RauGwCVS1ZN//6b2Q7emj+U69MJ/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889127; c=relaxed/simple;
	bh=oLhSYzOwujkBqrh0f9DoDHEmGMsT5+OaO+AH+QqxHZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4s6S5v82F0ma7K4QHwTvwTwWX3qPgDHORUTvKpPeyZv4fhNy5ZHLUDGPW4xIE/XFkvaCDe4ox+VA32tITDHKiTdmAeywPnh9QTVNqnsfJlqWKmlB5caJRb3LDwDXijKe+0CJQBsHn9l99FxmdPG+i9Jp8zvhr19cMGeg6TJJMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Ft9dEqdS; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Ft9dEqdS"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D89D5200582;
	Tue, 13 Oct 2026 12:58:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791889118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ibx4Wuf/nDfg8JytDfccS5wn8x8YmTr1cZIy71hpWvY=;
	b=Ft9dEqdSqJcAUHVzPIc2Eix4ACSvnxYrBByJWx/dmOdIVRCmu/EeYRQP2CINQ7tuAtTN+/
	Zys067Vs7HBtwPQyJNyvNv5Lh3hyUWpXmcILku2mXqsz46MNws2gfJI1O586Urlfo58qcU
	9VyHc37+7jpex2p0wrt3C/wQGOE0+MD7inDL+q46sOhf40AiTKpiR7EAsDBK0ZvAinfgJO
	9jmDQWCWriqusDxw0q/KDv7YeAYMFEvNGVYeaRpZtEXTe2CNP+BD4FSrTlmXR4ex56m0jM
	tkb9dNyrp9togtfNL9QlKlskYUkqlbO2ZC264rzgmFZIV/gTvoxAX1sc9PT9dA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791889118; a=rsa-sha256;
	cv=none;
	b=H6lGdFXLC8FRo8ALFR+JY+10yIo5YK/+Ss/C/5Ge0Z7lmrzl0BemHysBpEXjjul0JMaCc3
	Z/+L6EbsYtN9aakUCGvzNn7csRXqyyQmi9vsDWidakbgfQ2jPLFI5bJHKIHZ5fsouuL9Bi
	Uz44QfRUT9PsyLJ6E0FRuvhDFXdh84ESkpZ9ti7Ev2wwZ6r3+G8lE0SB386d8cKhoZFaJU
	0Zllheq8FeQVD8dMfKrZkkcJUs9fXBL+77v8pii+b7cRycZND4E/1/dPjhYDJutal28nic
	GidRYbn9ynscfXEylHWlXhTdl5MzjPBItgQcpb0Hzrw47nPHLFSWdf0mllwGQA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791889118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ibx4Wuf/nDfg8JytDfccS5wn8x8YmTr1cZIy71hpWvY=;
	b=COiVH5dzxNsq4sj3ao+H39OF5fYjChNz/VJalg6MCyepxFLn+CCrFd2APcgYSxdwDl158h
	3Ydjmn8PeKtThSxC1pOTzEp5JeWk4MA0fyMVE2xqX/DAduXGMv+Snd22wWXQKNTmxGMoij
	295cJh1BqBtYuiP7cE26uELPkPrxCkw0cNDqiCmg+9SN6eELvKvjTGZgXVrGkfI0HjsPSp
	OZD7EUe97EMR77WC6Hynn2RwG99GJBXSHN49JEGEAwwZCqC1MChtevdwuW4NGEvg1GzfhO
	j/xP3UStSs9sAwhWExXm+v8Q0FmXqXKjvRNA5/QoslsFv/2qZOTSHoap4bHiGw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xGaDO-005g8E-2X;
	Tue, 13 Oct 2026 12:58:38 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6C2E45C2F46;
	Tue, 13 Oct 2026 10:58:38 +0000 (UTC)
Date: Tue, 13 Oct 2026 12:58:37 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Cunhao Lu <1579567540@qq.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	kernel@pengutronix.de, Heiko Stuebner <heiko@sntech.de>, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] can: rockchip_canfd: stop bus-off restart before
 closing the device
Message-ID: <20261013-hissing-saiga-of-endeavor-ef5e03-mkl@pengutronix.de>
References: <tencent_5802EE88434010229EDF7A53084D994C6106@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="25w3tbmyskksrjyb"
Content-Disposition: inline
In-Reply-To: <tencent_5802EE88434010229EDF7A53084D994C6106@qq.com>


--25w3tbmyskksrjyb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] can: rockchip_canfd: stop bus-off restart before
 closing the device
MIME-Version: 1.0

On 13.10.2026 11:22:37, Cunhao Lu wrote:
> The close path cancels restart_work after freeing the IRQ and stopping
> hardware. A queued bus-off restart can therefore enable the controller
> and interrupts after teardown. It can also restart timestamp work before
> runtime suspend.
>
> Serialize restart with the close transition using a mutex. Mark the
> device closing and mask its interrupts before synchronizing the IRQ.
> Release the mutex before cancelling restart_work, so a queued restart
> can observe the closing state without deadlocking.
>
> Exclude the IRQ handler while reinitializing the hardware on restart.
> Do not disable the shared IRQ line while waiting for work to finish.
>
> Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD=
 controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

AFAICS this is a systematic problem and should IMHO not worked around in
one driver only.

netif_running() tests __LINK_STATE_START, which is removed in
__dev_close_many() prior to calling the driver's ndo_stop().

Can we make use of netif_running() prior to calling do_set_mode(dev,
CAN_MODE_START)? from can_restart()?

can_bus_off() should not schedule_delayed_work() if !netif_running().

We still have to call cancel_delayed_work_sync(&priv->can.restart_work)
=66rom each driver, though.

What do you think?

Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--25w3tbmyskksrjyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCas4O2wAKCRDMOmT6rpmt
0q+pAPwIF8wpYL7J1/gk9g6RXhUr5SARSzzpYTyGVX3yt2JlIQEAxgkwnBhMJin5
BgazUeZQAgL09GXx7TEVzKpH1RZCUw0=
=mEzK
-----END PGP SIGNATURE-----

--25w3tbmyskksrjyb--
