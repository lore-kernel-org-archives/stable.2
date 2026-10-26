Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793048957;
	b=zyQcjpoD2vvdy7QHgH+/KG17EuzzDjDZrvly+4Y6N3/M01cSXOfTH8zBWoZmBWDp6VEB
	 1TSpgP+YFtx86iAmZOG8GZ6cBvjQFcebBtv/Rgz8/ukPCYM79vR3e1zXnT9jw9HnrTzEI
	 Yf+su5pyVsvF7mgrB3XvEsXD4EF/HQe6cnkNkxyTbRlpWQyS7wxpEUw8jK0RPQwcnuuB4
	 6TGqPxPtxSYQFxKqTJ62xtoLs7CVCI92HsLrUAcdlhY/CzrGc1/r7VDsZSlcaM3WqwkGX
	 YmDuL4PrQDUkgfB17BYRLw3/F+7IY0+994MbHCGqqqkSOa+jOdtYE0ViLxOiymuKjUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048957;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=P5w/QGhcG86xp82d5uftEaCF9L09XL6IP5SJYwvQM/s=;
	b=pkhTO9MEbYljuPfFYj0HqxaW0aXKWwbiYAWgy/sEnyoHmENWBhE2JP9q128cs3m4HMN1
	 v0jsIrrcv12ORsZRAN1qYRAzNuwpNWSL5GIvx29pC7zAqOV+xzFvxgF7GfPwGCDq+4dsC
	 x91t+/kZ8Ta34r96TESlKEo/ETbJLatkAaE46ugapkPOIwgTZSr0LyRhZGI+ezl/1Jzay
	 qb7gWiaixJveigOMv2XgEQ2p75C1wAW4cG38erS53G7gAFsqGWK+vhR1zgI/PVtHEnrWP
	 XQP2FXLkPhJh3e2iLRiSgzMg0M7IHFe2VUWTZO8z7NlZEYWkbIUkW3CLY10euku3ijQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=bK8vvrKG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E8F606A322;
	Mon, 26 Oct 2026 21:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9E8F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=bK8vvrKG
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C5A88201EF3;
	Mon, 26 Oct 2026 22:09:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793048949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5w/QGhcG86xp82d5uftEaCF9L09XL6IP5SJYwvQM/s=;
	b=bK8vvrKGiX22xeC6DeJnf5YzcAr7f118aoVMWdF17yyvRFT+gxdSc0d+hZiAcq8LJoruzJ
	xgSCchYWibXx6g22T+KRfwYbr79wsMlbIOokJZELItqNzcFXu3BEgdFAFEpMNdHdacimt7
	qg1QedNn/jVD5UmRDN5nx86R3gU5wVIY5QlrgclRTZx/73fytbottkrNdIfdevjMsALwnb
	DHCcgZSy0O3Xog2oTyaF17ooubydleODug5RFf7Rqil0Q8H61gMEIKAaDAB6ojXVHz+MTL
	+0zJTmigxs9NoNbTqV3Y8dmhQ+bMhuJ2XeQJQJ8Ih/W4NmI5qE4+PKDBZLqBJw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793048949; a=rsa-sha256;
	cv=none;
	b=e/bo4y53DHYdKi56QDm/+OmJxXP+TRXAYgcRRdF5RAkd8Xq+EMm8xehr6TMdUbHPN/txLS
	VKYQovDuduRB6f/IoXhKFikwXoJqxiwC8mFb6YZhhmeFvVifmLSiGnVjt5c7OoT4Ioyjgr
	Exrk0img1hTB5yERcwifOkc8AT3YPd0rUfTWu6PIWSYmpWBFVBQ3gFeL/Zh1M4B/Ug4B8q
	Jt5T+CYTWqArV2y6nZDJAJq+7bbniUciHklLkaeXLsVi+O+KixooXrQTFWCRYdOWzhe8y/
	QcSPQHzxo86hT9Dmhg0spPRy4xi2YiGXNdgrH5n9tZ05jX1blmHe/PlV6YJaZg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793048949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5w/QGhcG86xp82d5uftEaCF9L09XL6IP5SJYwvQM/s=;
	b=WMwo3KcHto1IsUWvFSmNkOVOy8V5d5u9LswJ0uyvcrnhSmTFicUuBMsylctLYWs4R95WHS
	9TkgoQJ4wWnoY71DFzM8n6gt2IJtblfyvmCiQ4TaM8zkgu/wiBVDIz1jFlKM3tN72PiCed
	4zWImALPW4jqrf7QXjrNDN8N9WNnCnxmJgdegaIt39EvJEIjMdC14Ka+TD78TKznc68DU1
	T6cUMnkXTAWDMKjJAW/TepNhHk8WjuNMvQsUqvquGCFPbUHiMjKXfLRcHYGl9wVoQCZ38u
	0TBvTf7Gn/Dnf3hAv/TZ0ZkJmGuvRuBGL1fpaOlAb7n2U4E90kO7XYlx4Pq3GQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLRwL-001Kx6-2G;
	Mon, 26 Oct 2026 22:09:09 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6811B5D7368;
	Mon, 26 Oct 2026 21:09:09 +0000 (UTC)
Date: Mon, 26 Oct 2026 22:09:08 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Song Li <songl@zju.edu.cn>
Subject: Re: [PATCH] can: gs_usb: kill RX URBs before destroying the netdevs
Message-ID: <20261026-armadillo-of-uplifting-excitement-9bcdba-mkl@pengutronix.de>
References: <20260923070352.487595-1-fanwu01@zju.edu.cn>
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
	protocol="application/pgp-signature"; boundary="m6udzpjeck3ay5pl"
Content-Disposition: inline
In-Reply-To: <20260923070352.487595-1-fanwu01@zju.edu.cn>


--m6udzpjeck3ay5pl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: gs_usb: kill RX URBs before destroying the netdevs
MIME-Version: 1.0

On 23.09.2026 07:03:52, Fan Wu wrote:
> gs_usb_disconnect() destroys the channels one by one via
> gs_destroy_candev()/free_candev(). gs_can_close() disposes the RX bulk
> URBs on the shared parent->rx_submitted anchor only when the last
> active channel is closed. With two or more channels up, the earlier
> channels are freed while their RX URBs are still submitted, and a
> completion in gs_usb_receive_bulk_callback() accesses the freed struct
> gs_can and struct net_device.
>
> Fix this by killing the anchored RX URBs in gs_usb_disconnect() before
> the first netdev is destroyed, and in the error path of gs_usb_probe()
> before the previously created netdevs are destroyed.
>
> usb_kill_anchored_urbs() waits for running completions and a killed URB
> completes with -ENOENT, so the completion handler returns without
> resubmitting the URB. The kill in gs_can_close() of the last active
> channel then operates on an already empty anchor.
>
> This issue was found by an in-house static analysis tool.
>
> Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devic=
es")
> Cc: stable@vger.kernel.org
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>  drivers/net/can/usb/gs_usb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index ec9a7cb..663746d 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -1595,10 +1595,10 @@ static int gs_usb_probe(struct usb_interface *int=
f,
>
>  			/* on failure destroy previously created candevs */
>  			icount =3D i;
> +			usb_kill_anchored_urbs(&parent->rx_submitted);

I've fixed the root cause of this problem. Do not register an interface,
before all interfaces are setup:

https://lore.kernel.org/all/20261026-gs_usb-fixes-v4-2-59e3b6360053@pengutr=
onix.de/

>  			for (i =3D 0; i < icount; i++)
>  				gs_destroy_candev(parent->canch[i]);
>
> -			usb_kill_anchored_urbs(&parent->rx_submitted);
>  			kfree(parent);
>  			return rc;
>  		}
> @@ -1636,6 +1636,8 @@ static void gs_usb_disconnect(struct usb_interface =
*intf)
>  		return;
>  	}
>
> +	usb_kill_anchored_urbs(&parent->rx_submitted);
> +

The USB core disables all endpoints before calling gs_usb_disconnect(),
so this isn't needed.

>  	for (i =3D 0; i < parent->channel_cnt; i++)
>  		if (parent->canch[i])
>  			gs_destroy_candev(parent->canch[i]);
>
>
>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--m6udzpjeck3ay5pl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCat/BcgAKCRDMOmT6rpmt
0noWAP9LFdKbeYotc821LjsXYFEgC5EUxEHjvy0JtAvJ14m3oQD/V7UWEUeLecq9
ReIxfAnAUjTM9paYTgJpLCIztbwfhwA=
=0wRy
-----END PGP SIGNATURE-----

--m6udzpjeck3ay5pl--
