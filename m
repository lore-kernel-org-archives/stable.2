Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793833735;
	b=Wi5U70rZjLmSpJayDjv+sFPBcB2LixMCWyEXnYb5X8NhHzkxtOKOZNNm7JSSdutWv+Ok
	 G2cjdc1bBGI6Q9lau1V4gwFaltIB3e8eUU1h/UdiJBd1Fwg9NoxWh5w720m3wBtRC8t5N
	 jjtaQv2FdIMshsmiP40/U+JvgE45FDEBfVQMGyBION2iSj7nLTtGfZ+QdzXD8ABhPTwNg
	 MA4EuWRMw62SpxFh9/sGv8Di69i6tCe6vdflFXOOHSbhotveIWBzeb1n97eQceLqRXN5L
	 C1pmy2RUZL1KAcZaX3v312ig9HEl3KvM0u5A+UFP58Gs+iqpv0jyvlirIwphRfNwucA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833735;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=JjRi3UE9S6Wxo4DzCxCHKDuddEzfqvWFCBEHiXVXA90=;
	b=JZcuKTsM64GsaXF0LnwYmQpEoMIQ6WUoSpQllVclebzKWTmA/3TxiWZaexe5zcd5P6sQ
	 wPOvKx8eoEIJO2Wnehuh5dVWpMROUD8rWQSEM+RItWCOmICjAWK6b9HlC39JyiNceTh+B
	 25vVtsgdZ4rcTviG/QS8sVCbhHSGCB+8yrX76ALTbZE6QRYxwKhd+V1Mf8WPPCH4zWWyV
	 1KJL/kl2JU3jotop3tMmpNnwQaGrjZMgCOnj7t+LjVt6hFppYce77+TEMYh6JXA23WPWw
	 yqczpRyCc8qPthLyENmN2YbiMwDAWd6eMLdydaxiOegFUemnHrh5OE+23h80f4hTABQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=XAcyuura;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0265606A329;
	Wed,  4 Nov 2026 23:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0265606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=XAcyuura
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 68C0F200938;
	Thu, 05 Nov 2026 00:08:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793833726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JjRi3UE9S6Wxo4DzCxCHKDuddEzfqvWFCBEHiXVXA90=;
	b=XAcyuura7K5TPgxeD6rEBet5+K4MLvwXfKnXbR9BBKjkm8gfiNpw1mUaj2IMCE02ESbuNg
	nNH63N9BnS/p1FuPRBav1YkaHoNAZzek1v1k2QlOT99A6dJVHwAkRYu8Nf1PjBJKNzr1QT
	0+BZ9VkfOmQZy1coBryUH9aKx2YBasXtnmhfzk3ximjon2LiNMOLZR9vmQ7Z05FdNYB8ax
	jO0D2H7QDEK9z3oiJbuaDCp6QYYsWRCeUZ1ZUnqLrC0oNdgCGZwo4QFCVJs5tuGk8QUA8B
	rc9q4l6eCmVV78IQR4hJO5DSSPRiYhOWuKM0AcQ3MHICMr32OI7+D8mnIg4Fig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793833726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JjRi3UE9S6Wxo4DzCxCHKDuddEzfqvWFCBEHiXVXA90=;
	b=BWrpQz6aVp5Ufpsq0iUwgz+kzGskbej1WVecc77kE0pHQeCmQwR0IfIqDgM4vmW+KY75W2
	sXJWti6D2S2bMJNq/TggwsKgxfmB510VRVNwwjQ39AEbjzUghvU7N4joxWObWo5WOInoBm
	0aS4zCcxtspxW0c9gQAxo4pb5T0Dq2PvanaAum3UMDZC2zyMEOmx/iF2BjqlXx1Dgp2Egc
	0PUSxHS2AlGYcG5QBICveMg1ZulGNLfWl7to/BDqa+ScNXSS4xekDQ6RtigfrClkTB6BVl
	0qkfvLhw6aVuUcgdmQ5kGXisWuwExoJG5IHtsVFozsKG1hXOyQcbGxpjvhSn0Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793833726; a=rsa-sha256;
	cv=none;
	b=b/mZ09N5/Szmxwqm9Tf6534++1q7FZsGbFHIwSjZVNOlsZM0nUw9pr4Z+45g24HcwUhTaa
	kBxFXhewrxrTNdpX+2jOw3P3gKadkO/kWhYQdEHZFtu1gb1/rw8+0yf4lDKu+LRVT9xBLn
	n7vZHK5zFLMeL8J2VsunB0gqS5eaD0p1Wy1v9ZrvTAG4wSxXe3LHTVvR3Jyk7vEae4N987
	BTv5di8ujwhzv9J+rECB5w4dQmjK12JUKWqjbyzR+9wls9e+e97bjQhBSE7VS7amLMr26W
	yH4OSXpqp17sVlKveoqpDAIBH3N51ahxfXVJONWj61b2A8bR7MvIG9PJfcDf0w==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xOk62-002feM-12;
	Thu, 05 Nov 2026 00:08:46 +0100
Received: from pengutronix.de (ip-109-42-119-212.web.vodafone.de [109.42.119.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 69E515DF2B5;
	Wed, 04 Nov 2026 23:08:44 +0000 (UTC)
Date: Thu, 5 Nov 2026 00:08:42 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, liucj1228@outlook.com, 
	s.grosjean@peak-system.fr, stable@vger.kernel.org
Subject: Re: [PATCH net 13/15] can: dev: can_fill_info(): don't wake up
 controller if interface is down
Message-ID: <20261104-prudent-mottled-gharial-1bfbfa-mkl@pengutronix.de>
References: <20261103204305.3211144-14-mkl@pengutronix.de>
 <179382521036.488856.13184139645230625670@kernel.org>
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
	protocol="application/pgp-signature"; boundary="nr5f2jf7be65j4od"
Content-Disposition: inline
In-Reply-To: <179382521036.488856.13184139645230625670@kernel.org>


--nr5f2jf7be65j4od
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 13/15] can: dev: can_fill_info(): don't wake up
 controller if interface is down
MIME-Version: 1.0

On 04.11.2026 20:46:50, netdev-bot+sashiko@kernel.org wrote:
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
> - [Medium] The commit message describes this as removing one trigger of a
>   flexcan abort on i.MX8QXP.
>
> --
>
> can: dev: can_fill_info(): don't wake up controller if interface is down
>
> This patch changes can_fill_info() and can_get_size() to skip
> IFLA_CAN_BERR_COUNTER when the interface is not running. As a result,
> do_get_berr_counter() is never called on a down interface. The goal is
> to avoid a synchronous external abort in flexcan_get_berr_counter() on
> i.MX8QXP when "ip link show" runs on an interface that was never brought
> up.
>
> Link: https://patch.msgid.link/20261027065012.191348-1-chunyuzhiqiang@yin=
he.ht
>
> > diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlin=
k.c
> > index 766d455950f55..b958c04d53db6 100644
> > --- a/drivers/net/can/dev/netlink.c
> > +++ b/drivers/net/can/dev/netlink.c
>
> [ ... ]
>
> > @@ -1006,7 +1006,7 @@ static int can_fill_info(struct sk_buff *skb, con=
st struct net_device *dev)
> >  	    nla_put(skb, IFLA_CAN_CTRLMODE, sizeof(cm), &cm) ||
> >  	    nla_put_u32(skb, IFLA_CAN_RESTART_MS, priv->restart_ms) ||
> >
> > -	    (priv->do_get_berr_counter &&
> > +	    (priv->do_get_berr_counter && netif_running(dev) &&
> >  	     !priv->do_get_berr_counter(dev, &bec) &&
> >  	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||
>
> [Severity: Medium]
> Is this meant to change the output for every CAN driver, and not only
> flexcan?

This is change is intended. Reading the CAN error counters of a down
interface makes no sense, as they must be read from hardware. The CAN
error counters are set to 0 by the hardware (as required by the CAN
specification) when the interface is (re)started.

> can_fill_info() is the only core caller of priv->do_get_berr_counter.
> With this check, no driver that sets the callback will report
> IFLA_CAN_BERR_COUNTER on a down interface. can_get_size() gets the same
> change.
>
> Several drivers turn on their hardware inside the callback so that this
> query works while the interface is down:

Yes - this can be removed in later patches.

> drivers/net/can/sun4i_can.c:sun4ican_get_berr_counter() {
>     ...
> 	err =3D clk_prepare_enable(priv->clk);
>     ...
> }
>
> drivers/net/can/c_can/c_can_main.c:c_can_get_berr_counter() {
>     ...
> 	c_can_pm_runtime_get_sync(priv);
> 	err =3D __c_can_get_berr_counter(dev, bec);
> 	c_can_pm_runtime_put_sync(priv);
>     ...
> }
>
> Other drivers do the same thing:
>
>   bxcan_get_berr_counter() calls clk_prepare_enable()
>   xcan_get_berr_counter() and ctucan_get_berr_counter() call
>   pm_runtime_get_sync()
>   rcar_can_get_berr_counter(), rkcanfd_get_berr_counter() and
>   flexcan_get_berr_counter() call pm_runtime_resume_and_get()
>
> The commit in the Fixes: tag, ec56acfef2af1, states this intent
> directly: "flexcan_get_berr_counter() may be called from userspace even
> if the interface is down ... This patch switches on the clocks".
>
> After this change, the wake-up code in those drivers only runs when the
> device is already active, so it no longer does anything useful. Should
> that code be removed?

ACK

> Or would it be better to put the check in the
> flexcan driver instead?

no - we want to fix this conceptually on the CAN netlink level.

> The commit message cites m_can as the precedent. Commit 91a55c72a821
> fixed m_can inside the driver:
>
> drivers/net/can/m_can/m_can.c:m_can_get_berr_counter() {
>     ...
> 	/* Avoid waking up the controller if the interface is down */
> 	if (!(dev->flags & IFF_UP))
> 		return 0;
>     ...
> }
>
> That version still sends the attribute, with zeroed counters. With this
> patch, m_can sends no attribute at all for a down interface. Is that
> change intended?
>
> Because of the flexcan Fixes: tag and Cc: stable, this would be
> backported to every stable tree since v3.16. After that, "ip -details
> link show" would stop printing berr-counter for down interfaces on all
> drivers, including ones where the query always worked.
>
> The commit message does say that the attribute is no longer reported.
> Could it also say that this applies to all CAN drivers, and that it
> replaces the per-driver support for down interfaces?

If we need to re-spin this series/PR we'll update the commit message.

Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nr5f2jf7be65j4od
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCauu68wAKCRDMOmT6rpmt
0qMNAQC5tLQIgbg3/0lUh7Z6J0PIk7ccz+sVNzmSIilimtF/AgD/UN1geg2HHdMr
fKe19j11SLTVXUOM+wVDT1ivWsMf/gk=
=xc4X
-----END PGP SIGNATURE-----

--nr5f2jf7be65j4od--
