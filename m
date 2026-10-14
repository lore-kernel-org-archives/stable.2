Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6AE3CFF65;
	Wed, 14 Oct 2026 05:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791956679; cv=pass; b=p+JEsz6vU2tR07AldMJ72vzcUuHxmvdR3Fu4/P5H4EnK1zU2sK5+2ReNuom2kKQSf8VcMJzqYAPYU57aGOBIogOazcmptIu47RBSXCPS/f/EGpDAzQIxWOcAVXl5LVufP5BvGzqfPil08CD6ETpil5f6WTIwAM7i0Jn6HJAVYl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791956679; c=relaxed/simple;
	bh=fXtoNcOdvkomLJmBNUK2gtCZe5Vc4SS2qMz1wIvAufA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGI1sd2bRcQA9+Oh8HV4Lm2x26DsmCSVNtl9PGc2xDSWfERgvHkT1jA1k37O3niOJ8LuMe4yq4p/FBiXpy2HYe1kqMqBEpgjxAZJMPkfk0Tgo/POPrlXXbf7TJx3as9j+kwhfOO3qMEY+5lJNNhGB6edihWZKkfMzBnkMHj610U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Z7iy8eqd; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Z7iy8eqd"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 378EC201E03;
	Wed, 14 Oct 2026 07:44:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791956674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6uza6PpaZ0+pqzEIwL1v815myEpERgJfMgVOiQgMLXo=;
	b=Z7iy8eqdt4Xwc/8pa1pG56CDteTKtxLTTDy+XHUNbWzcLdMzLFID7jA4M9u3cp+wm0+Aoy
	2qDi7C6t5uwr0Y9VtaxzDquvLdUljsuTvUZCXPf2XsZ5Ddb0g8vBvFYsgp3XNbbHGkDcGp
	RcrOgSBte1u+WbrbjAuHTAZEKeJ75wezQW1Ue9KLPAvk8xn3dm4WAjmIlWTBaIL6mX2Oem
	aDqaZnnPM362B8fI5jTYvff0mKWru7ZdLlIZJh3zGAS1/O9ZmYQ4FOASuKKdvYQ9NHY9E4
	x2ci91YQzrITMwoc575+9Qkkxrv30H0VHdkCqQAEEpEOg6cdemXx/OEkp49i7w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791956674; a=rsa-sha256;
	cv=none;
	b=D+1+pzwVsOXpM00YnX3qkn6ZXhrgU7141hXDfAFYeBbih0nzUInirL2XJbZLej+5/dMbnt
	h0U3mxE8BGyOZixSJKpkGR7A1TRZmWX4EJvp5J4TVT/nX3wKD1bK6ZfkiAOWnlVu0xYTVo
	0w0ZHXtQcX0wuNsu4senb/9fCKPcWMuzg033+orMiOFEdJqRDTQsSy568nXCaPXjNacqqv
	fvhUVvM3+0hwxa5GnECLhh/tP9UWiSPO6gDA/o260h+IZ9lqAz1Je+3YTSAEqs//T5Fu/y
	y3OT/7Q+zn65UoxYWzvu1xj+pYAJjopP7jk4qej/MhOgGh9GGmXba2l7nTgeDQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791956674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6uza6PpaZ0+pqzEIwL1v815myEpERgJfMgVOiQgMLXo=;
	b=XDS0MXgmxUfdVwuJa6uIhIKpZOBlf30xJYPj81Na4i31QHWZrKjGILr7dYToAQ4du0Vaa5
	vc9uzCLRPkz98DwmLqOO7gapM7vHxp/0Xat6pNUZ3KSEKOtOX6z+/xwW75sLAQvFtw91pr
	7et1mPzgKlI+utJu+ACXowbeKROIgVTLCinx0H3j/XRjYOm1Pc1/OwQ8j9iKrE0uNyuQL1
	DGRclsaUnG50NWIgvJm6gMaU+ibXKS99COl6H+3HmuHJlKCq0ElAlpNWDCo2TAtWkI4hTC
	7tLB3jjALtZ6mmOLUQSsv2Mwf5LpU1jd3bchQVRMyDmHFnpbC2Uye3woEzuT7A==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xGrn0-005o3A-0N;
	Wed, 14 Oct 2026 07:44:34 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C416B5C39D3;
	Wed, 14 Oct 2026 05:44:33 +0000 (UTC)
Date: Wed, 14 Oct 2026 07:44:32 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Cunhao Lu <1579567540@qq.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	"David S. Miller" <davem@davemloft.net>, Wolfgang Grandegger <wg@grandegger.com>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2 0/3] can: fix bus-off restart during device close
Message-ID: <20261014-solid-slug-of-tempering-22b862-mkl@pengutronix.de>
References: <tencent_82C93561D200C84C24608C80049C23EEF80A@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iqvdsuvim664ntyz"
Content-Disposition: inline
In-Reply-To: <tencent_82C93561D200C84C24608C80049C23EEF80A@qq.com>


--iqvdsuvim664ntyz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net v2 0/3] can: fix bus-off restart during device close
MIME-Version: 1.0

On 14.10.2026 10:54:21, Cunhao Lu wrote:
> This work started from a real failure on a production robot using a
> LubanCat-5IO with an RK3588. RX continued, but the TX queue remained
> stopped and subsequent sends returned ENOBUFS. The interface still
> reported ERROR-ACTIVE, and the hardware indicated neither a bus-off
> condition nor a pending TX request.
>
> While testing the echo-loss fix with fault injection, I discovered a
> separate race between bus-off restart and device close. This series fixes
> that race; the fix for the original TX stall will follow separately.
>
> When automatic bus-off recovery is enabled, bringing the interface down
> can race with a pending or running restart. The Rockchip driver currently
> relies on close_candev() to cancel restart_work, but calls it only after
> freeing the IRQ, disabling RX offload, and stopping the controller. A
> restart in that interval can re-enable the controller and its interrupts
> after IRQ teardown, and requeue timestamp work after it has been stopped.
> That work can subsequently access registers after runtime suspend
> disables the controller clocks.
>
> The networking core clears the running flag before calling ndo_stop().
> The first patch uses that flag to avoid scheduling or starting bus-off
> recovery once the interface is observed to be no longer running. The
> second patch adds close_candev_cancel_restart_sync() so drivers can wait
> for recovery separately from the echo cleanup in close_candev(). The
> third patch uses this helper at the start of the Rockchip close path.
>
> The running-state checks do not replace synchronization with a restart
> that has already passed the check. Rockchip waits for that work before
> tearing down its resources, and keeps close_candev() at the end for the
> final cancellation and echo cleanup. IRQ exclusion during hardware
> reinitialization is retained; the shared IRQ is not disabled while the
> close path waits for restart work.
>
> I tested v2 on a LubanCat-5IO running a PREEMPT_RT kernel, using the same
> setup and procedure as v1. The 1 Mbit/s CAN bus was connected to four
> CANopen motors operating at 100 Hz and four sensors operating at 20 Hz.
> A bitrate mismatch forced bus-off with automatic restart set to 100 ms.
> The v2 campaign completed 380 valid bus-off iterations, covering automatic
> recovery, close while recovery was pending, close near three delay points,
> 200 randomized stress iterations, manual recovery, and reopen after close.
> All 380 iterations reached bus-off and scheduled recovery.

FYI: The threading of your series is broken, due to wrong/changes
"Message-ID".

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

--iqvdsuvim664ntyz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCas8WvgAKCRDMOmT6rpmt
0sJeAPwIvBNFwhbZe95g0ffTZF+mL/ZK566Mh4xHIsWt+4rCsQEAmjSMcdiy8FPc
/izydOSxmmTTbZZLa2AspdMyIYHI0Qk=
=Q/RN
-----END PGP SIGNATURE-----

--iqvdsuvim664ntyz--
