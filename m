Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD99175A7B;
	Sat,  3 Oct 2026 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791027953; cv=pass; b=qEVCtEtQY6n/weATatOnhyIYrnUqTEjlvN4nGJgRj/KK17vD2ITKqBMUMCn1LCteuXd7L2o8KhB1jtU+tE1qmuBIGQ4gQ3GH03ibIGII5p/F+FZ2olL/LJ5WVjPiCW1g4h1Ri+7RW9piJgUWNwDhcJmUmg/BwtTlwlfWTkYIXyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791027953; c=relaxed/simple;
	bh=GwKbBgu7Y95TKT8/SFa9ikBlPBwjpdZaOuJeoGemCGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoPfif2b2ng2Y9bA2ZTA8GIJm05jOLVod0AG1sLIB7Z/SaNUi2IS8ASNMr/pwbo2jsLunvmMhUWHfRFtzxlsg2YNuFvLSN60aoczr4EFx8OHs5RgppC9yk1VMtE7KhR8tXJADWRV5LeaPzbd++p9km899lCUvsBvk19T0FqnVao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=e8BxF54f; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="e8BxF54f"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 66D432001F2;
	Sat, 03 Oct 2026 13:45:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791027942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mScnjil3OHXQHbEj0MChhUrmjdK6rOY2h5e9ZekJNcc=;
	b=e8BxF54fMp7Sso9tdpB1rD4kzXlADTrKrG4GJ9xTLvXF45gPbaxYQWyezWyEXglIY3rD7K
	Xq2xT9Ayx6NLx9UH0zusVm9q2LJZs1WWOPY/h37YMEQ/DIxxoediydEUXP5MWk5WpyzwiG
	Ji1zazbZG2imopIKdcbGjYelLCO3jb1Nny6qlGJf5WmPwT9TnN6Wh9DBgQ9YsAGC2YU2Vl
	HuPcQ5dOGeiukquvwkKECjHvXUJcQB/6P5oRS9W0P8coThRWyb3c5QA1keFXnE1/uvlaNj
	WZZbwZArEbeyQckCZ5uvo92YTTuIQ37pqRBHBcUjcMMPlH0HoKGpUxQ2GEsKDQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791027942; a=rsa-sha256;
	cv=none;
	b=Pzwin5/URqrJM28cQOFbEdKKZXcbKs8ikUdEoEpA+X0LtNPJwgycNOgcXg7iq6aUIASFaM
	A59Ad8BNfXEYk8MvxhNASnwrdmLuwJ1FJdmxL40A28gaT3pSzdJZeIrFT8UcvSPDQu85qs
	hHuGxUNb4zJVtdMMnqLgPcB4C+RLz0BifFzyT7xD2NebNiOwRiRRtWCLGOY2rcVPFXvDmS
	mwZz7B/TxFJ0UDDnBne5J+W4lYoNCY94CxWei+hjUaJDmVG3nya1y2ofZ7bmezIieMn4+X
	gn+AT7B7nk2PUgI265otbjHQHbCat4KNlmfC856OJtjMVUfxR39Q7tuLslHXkw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791027942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mScnjil3OHXQHbEj0MChhUrmjdK6rOY2h5e9ZekJNcc=;
	b=ULHOpnvr9g9QOvdJt3mxdJjdklIlwX2S521/W7PClXzmFVk/aETIWHuYG4yOlrbjCCoFER
	nSl+Hw2NSp99nQWGPyZS+iKeKCmUlPCoCJHljwZSujubJRy2Ew/rn9XSJ+PK0PuQK2vkMS
	Gn/eYBE1MIg5/FdpOMhkO/5YEBZiyFOEfXR8NDuFgHWSovycpIGs6cU5O0Y1rj1CcPk/62
	w5NI2PsG5M+z2UAspIN2IotPLP88mXBUcnQNIiyQ333FCyKwc4Eb171rU8Sr9WMraSV0rg
	sUWumNDQdf+uYvzU5lEv2UEX/YwdQfCRdXyRd+MfN6AuWeiL4pSQKQ4nlTzf9w==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xCyBS-0042vP-0z;
	Sat, 03 Oct 2026 13:45:42 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 09C905B904A;
	Sat, 03 Oct 2026 11:45:41 +0000 (UTC)
Date: Sat, 3 Oct 2026 13:45:41 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ji-Ze Hong via B4 Relay <devnull+peter_hong.fintek.com.tw@kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, "Dynetrex, Admin" <admin@dynetrex.com>, 
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>
Subject: Re: [PATCH v2] can: usb: f81604: fix struct f81604_int_data size
 mismatch
Message-ID: <20261003-shiny-alchemical-donkey-156221-mkl@pengutronix.de>
References: <20260824-f81604-fix-v2-1-fc9be5581394@fintek.com.tw>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bqgah23wjv3jb3mn"
Content-Disposition: inline
In-Reply-To: <20260824-f81604-fix-v2-1-fc9be5581394@fintek.com.tw>


--bqgah23wjv3jb3mn
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

I hope this patch goes into v7.3. While reviewing this patch the bot
found this issue:

Will the 2nd issue be fixed by
https://lore.kernel.org/all/20260901-f81604-fix-v1-1-c55b5178f9f8@fintek.co=
m.tw/ ?

regards,
Marc

--- Patch [3]: [PATCH net 3/3] usb: f81604: fix struct f81604_int_data size=
 mismatch ---
commit 6877926768a247e156dd43002e5a7320e9ac2d39
Author: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>

usb: f81604: fix struct f81604_int_data size mismatch

This commit drops the __aligned(4) attribute from struct f81604_int_data.
With the attribute gone, sizeof() is 9 bytes, which matches what the
interrupt endpoint sends. With the old 12-byte padded size, the short URB
check in f81604_read_int_callback() threw away every valid interrupt
message, so TX completion was never processed.

Link: https://patch.msgid.link/20260824-f81604-fix-v2-1-fc9be5581394@fintek=
=2Ecom.tw

> diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
> index f12318268e46b..4c147b9d6d690 100644
> --- a/drivers/net/can/usb/f81604.c
> +++ b/drivers/net/can/usb/f81604.c
> @@ -169,7 +169,7 @@ struct f81604_int_data {
>  	u8 rxerr;
>  	u8 txerr;
>  	u8 val;
> -} __packed __aligned(4);
> +} __packed;

Discovered by: opus-5-5 =C2=B7 Missed by: gpt-6-astra, sashiko-gemini =C2=
=B7 Confirmed by: gpt-6-astra =C2=B7 Ranked High by: gpt-6-astra
This isn't a bug introduced by this patch, but there is a problem in the
short URB check that this patch adjusts. In f81604_read_int_callback(),
the check runs before the status switch:

drivers/net/can/usb/f81604.c:f81604_read_int_callback() {
    ...
	if (urb->actual_length < sizeof(*data)) {
		netdev_warn(netdev, "%s: short int URB: %u < %zu\n",
			    __func__, urb->actual_length, sizeof(*data));
		goto resubmit_urb;
	}

	switch (urb->status) {
	case 0: /* success */
		break;

	case -ENOENT:
	case -EPIPE:
	case -EPROTO:
	case -ESHUTDOWN:
		return;
    ...
}

Suppose the URB completes with one of these error codes and actual_length
is 0. Won't it take the goto resubmit_urb path and never reach the
return?

On every ndo_stop, this call chain completes the interrupt URB with
-ENOENT and 0 bytes:

f81604_close()->f81604_unregister_urbs()->usb_kill_anchored_urbs()

The callback would then log a false "short int URB" warning. The
resubmit would fail with -EPERM because usb_kill_urb() has set
urb->reject, and that logs "failed to resubmit int urb".

On -EPIPE (endpoint stall) or -EPROTO, the URB would be resubmitted at
interval 1 instead of stopping. Each failing completion then logs
netdev_info and netdev_warn messages with no rate limit.

This ordering came from 7299b1b39a25, the commit this patch fixes. This
patch doesn't change the behaviour, since 0 < 9 just as 0 < 12.

Could the length check be applied only when urb->status is 0?

Discovered by: gpt-6-astra =C2=B7 Missed by: opus-5-5, sashiko-gemini =C2=
=B7 Confirmed by: opus-5-5 =C2=B7 Ranked Critical by: gpt-6-astra
This is a pre-existing issue, but this patch makes it reachable again.
f81604_close() cancels clear_reg_work before it kills the interrupt URBs
that can queue that work:

drivers/net/can/usb/f81604.c:f81604_close() {
    ...
	netif_stop_queue(netdev);
	cancel_work_sync(&priv->clear_reg_work);
	close_candev(netdev);

	f81604_unregister_urbs(priv);
    ...
}

What if an interrupt URB completes after cancel_work_sync() returns but
before usb_kill_anchored_urbs() runs? Can f81604_handle_can_bus_errors()
then queue the work again after a bus error, arbitration loss or overrun?

drivers/net/can/usb/f81604.c:f81604_handle_can_bus_errors() {
    ...
	if (priv->clear_flags)
		schedule_work(&priv->clear_reg_work);
    ...
}

On unbind or disconnect, f81604_disconnect() does this:

	unregister_netdev(priv->netdev[i]);
	free_candev(priv->netdev[i]);

Nothing cancels or flushes clear_reg_work again before free_candev().
f81604_clear_reg_work() gets priv via container_of() and then calls
f81604_sja1000_read() and f81604_sja1000_write() on it.

Would this be a use-after-free of the netdev private data and of the
embedded work_struct?

This ordering has been there since the driver was added in 88da17436973.
After 7299b1b39a25, every 9-byte interrupt failed the < 12 check, so this
schedule_work() call was effectively never reached. With this patch,
valid interrupts are handled again.

Could f81604_close() kill the anchored URBs before cancel_work_sync()?
Alternatively, could f81604_disconnect() cancel the work again before
free_candev()?

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--bqgah23wjv3jb3mn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCasDq4wAKCRDMOmT6rpmt
0qtCAQCHh5XSGyLvu1S2W64qEJ8RCvD+vGOcy9sXKfh/OK9DDgD/aQv2SH1IsvnI
pNFRlw0/hkgjXfyswC0GVrSkPa4Evgs=
=khbf
-----END PGP SIGNATURE-----

--bqgah23wjv3jb3mn--
