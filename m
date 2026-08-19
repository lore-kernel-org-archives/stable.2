Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA03D0934;
	Wed, 19 Aug 2026 06:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787120743; cv=none; b=gMJ/KbKpHcG7rQK6fCJKvhL0Eqf/qz22FAINkix6/3gM2a/H+KR+UQf9jdVoR6xoaOgvLWKR8Yvbo1PqkWQkcSh7F1Vv+OJt4CxvnrAOluiNxUz9SHrqUoDeAlTtyVik/w8ShwhzQGRt4Ee3hMzKyyfu3bVB3UKzWYxHVAoOHVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787120743; c=relaxed/simple;
	bh=31Y2OOXv1aNQHI3J2fxbeLDomI0JMcqsp2rDEtm12lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMDbgjNYeh/9kX3CYX8upeCmnVcUOiLSX0rQ0Cl+TQyovjcPcY2Oo+VH+SAcL2BuDcFAEPxruCRtBSQLVFhEVL9iKpnw3bZS2jTGAXk1mwpP+sksVV+EwfBzfZDdmxIniNEVs+HzW57mnZpIWeexchAxp1bVdAifwSM8X+P9vcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 99E55200C95;
	Wed, 19 Aug 2026 08:25:39 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wwZk3-002FUK-1h;
	Wed, 19 Aug 2026 08:25:39 +0200
Received: from pengutronix.de (unknown [89.207.172.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 17FD15860DF;
	Wed, 19 Aug 2026 06:25:38 +0000 (UTC)
Date: Wed, 19 Aug 2026 08:25:36 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Fan Wu <12321260@zju.edu.cn>
Cc: Fan Wu <fanwu01@zju.edu.cn>, linux-can@vger.kernel.org, 
	Vincent Mailhol <mailhol@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] can: kvaser_pciefd: fix use-after-free in bec poll timer
Message-ID: <20260819-amethyst-spider-of-development-85130a-mkl@pengutronix.de>
References: <20260818063832.383829-1-fanwu01@zju.edu.cn>
 <20260818-ambrosial-courageous-carp-1162c8-mkl@pengutronix.de>
 <D2ED044B-6B32-4FB4-B9FF-E65497B84A25@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x6oxu6rwav2tj2rt"
Content-Disposition: inline
In-Reply-To: <D2ED044B-6B32-4FB4-B9FF-E65497B84A25@zju.edu.cn>


--x6oxu6rwav2tj2rt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: kvaser_pciefd: fix use-after-free in bec poll timer
MIME-Version: 1.0

On 18.08.2026 21:22:51, Fan Wu wrote:
> Hi Marc,
>
> Yes. The driver has three timer_delete() call sites, all for
> bec_poll_timer.
>
> The calls in kvaser_pciefd_bus_on() and kvaser_pciefd_stop() are runtime
> cancellations: the CAN device stays alive after both, and the timer must
> stay rearmable for the next open/bus-on cycle, since the interrupt
> handler arms it from handle_error_packet(), handle_status_resp() and
> handle_status_packet().  Converting either one to timer_shutdown_sync()
> would make those later mod_timer() calls no-ops.  The stop() flush-timeout
> path, which skips its timer_delete() entirely, is also covered: the device
> is still alive there, and remove() still shuts the timer down
> unconditionally.
>
> kvaser_pciefd_remove() is different: its timer_delete() is followed by
> free_irq() and then by the final free_candev(), while the interrupt
> handler can still rearm the timer.  That is the call converted by this
> patch, which also adds timer_shutdown_sync() to
> kvaser_pciefd_teardown_can_ctrls(), the probe-error path that frees the
> CAN devices after free_irq().

Thanks for the explanation.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--x6oxu6rwav2tj2rt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaoVMXQAKCRDMOmT6rpmt
0qMuAQDyz4+BUCe/00dUZ2oXyb8zFZNenzRj0zqLS3jQYrTKvQEA2ACowyu+IipL
rCZv3Iv8/fu3+KRyk6INBF9BmvhFLQc=
=kCD6
-----END PGP SIGNATURE-----

--x6oxu6rwav2tj2rt--
