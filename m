Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793092823;
	b=rQck7BtZycOLGPajmtioUA1fhsoKlI5YEHYpQRXctUxx3snIsljC6Eg44shhTqKk1wys
	 wMAsgQX38L3xeGGphzo2gIVcu7tGXJU83eITz6DermumbRtiemL4EpZaSsn6PJHjzjOun
	 lqzOAuAbx/S1IEcau4K2JbrBS4vvaOUCTcjIB0QM7cR204dVhcgQk/mquzx1Z4lBNinfo
	 P7xyFTMnAxLauXljmdmXmP9IL/X9JMWe2bCYEZxSNbueNMYLlIojFj4eYg+2VgM0k4MK2
	 st94mIPIy0+hT+bDEaCfK6Bsysy48k5/sZEvbgT29WUAr7TTQTR3gxL7dWfM6N7VD3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092823;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=jcyAMqkFqLBwkbzNR5Ttpcd+d4aaRMoP1bBfqTr9PKU=;
	b=nFm3WnRs3rPDu3vOM8DKMFfV62I3LELn7XR5iVkgByiQgzNP9qM7NW3HEK+Y66hnDWwU
	 B55UxWvgSNhCqhpqDQ4zO4SH6rXP6yVJAO0T2a6vkZ3N4qvGX2o2PhGg4UlPD3juR9FCd
	 PcsCaToTX0k7+fJ/k+2z+pan/H6muR5QO9VAQErH60iitpczC8Ch99ov9+Uhv0MKGuy0w
	 t5NedM91f1Lb7LCKldHD256skc4vBXJ9MA8zQurRY58fgX82BLff+bGSkpmyUP2KmsjeP
	 Ecqj6IWc4/OX/zSMo8Xvu+h692cwazS9aYPd/6ni0wZfY0OdpNqOtiWDEr4ie7OXIdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=XKECpg9H;
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A56606A31B;
	Tue, 27 Oct 2026 09:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4A56606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=XKECpg9H
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2052D201F0D;
	Tue, 27 Oct 2026 10:20:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793092820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jcyAMqkFqLBwkbzNR5Ttpcd+d4aaRMoP1bBfqTr9PKU=;
	b=XKECpg9HnAuZvs+ymq+dvC55yRs4Fs+J0Elc0egv3nPMRX5TOfZOxWfZbsUj/30mCHVx/L
	Pny3mmtTRb0jjO4dk84h6Vp8qyIUUwuV56uNA8u2xTsTvgFTLRf5JNCuKkWvp2wV4o5ZNH
	oKcnTwZBCIRhnJ/MQ8ns1hYRWH6lmeJCwAQGxctiIV5AiJ8s15iLkYmIt+7LV0AQkhtRHz
	FBQDSewZZwxRUMSQG1gfg/Tsq6ABpsMWLMET4Ni07/tTvsiIn1S4Owz40PcpaPun7veooA
	pRlGIKSwB0XZ7rnUtD3f+TssB3Tpi7UJtpjItfDnc/YG26QksNNwWInY6WbZtg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793092820; a=rsa-sha256;
	cv=none;
	b=YaFumjsRyq4JeydNdHAt75MyTSKYyvFkqkyfqM9LaTNNkN/x+iyHOP+4bjyJlaPruI6oUg
	LEUwRQvV/as6PMe5P3XgU3Xk0s1N1P3w/vpt7RIMjrPanOLWmqani2SxBc//kDPs6VBhx2
	OoGhS7GejenIGQRismbCPtwhGzNdjwGk+i50hPs9ph1ofygtIijfxOmqHrAN8zEb3YlXQN
	boN60VxQxd/gFI2duLnJ6PG/HEF72A5sKxkukKSNKqAhXIexB5nr/HUiSI8GbzH0GeBkU+
	6MeYhSfxFdrp8S7CzG3v3xTGBvXQGJJfXReFdz/gK6TyYgg3gCrGWqtJR+Ns/w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793092820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jcyAMqkFqLBwkbzNR5Ttpcd+d4aaRMoP1bBfqTr9PKU=;
	b=JIqe6q8ps0Y8t8CLbcrRrnYEIgD70LwEjfRWsdQvcsxM4rri2OzSlwJUVYWHp2hEwzNIH/
	tbsGkno3Y8zj8c57XlhBb1ok+dlTf0ILG2XsOAbcvxtID0w01tlo2glCcA8PxEQ5JnVpoQ
	WH0BJislOPFS8QGlNoxiC/71sltqlG8CyDO8KuW5aeEM9SnSuHZNzeP8jKKC68XxihBgzK
	6gO8/87upkK55/s+TWL/EZhTHPxa0+ePwOAQQVGPWWr1NMnL09zksObShTa+XnJJ1wjSJA
	hfT7rx+WnPIJ7lu4NwHMRLawgCB1EfcwGQjryiCyHbH4kZIKL9YR34VE+596mg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLdLw-001PMY-07;
	Tue, 27 Oct 2026 10:20:20 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C91725D7AB3;
	Tue, 27 Oct 2026 09:20:19 +0000 (UTC)
Date: Tue, 27 Oct 2026 10:20:19 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, 
	linux-can@vger.kernel.org, mailhol@kernel.org, kernel@pengutronix.de, 
	haibo.chen@oss.nxp.com, shawnguo@kernel.org, imx@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v8 2/2] can: dev: can_tdc_fill_info(): don't read
 automatic TDCV if interface is down
Message-ID: <20261027-capable-active-leech-1aae56-mkl@pengutronix.de>
References: <20261027065012.191348-1-chunyuzhiqiang@yinhe.ht>
 <20261027065012.191348-2-chunyuzhiqiang@yinhe.ht>
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
	protocol="application/pgp-signature"; boundary="3hoorgl3hwcfdx7m"
Content-Disposition: inline
In-Reply-To: <20261027065012.191348-2-chunyuzhiqiang@yinhe.ht>


--3hoorgl3hwcfdx7m
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 2/2] can: dev: can_tdc_fill_info(): don't read
 automatic TDCV if interface is down
MIME-Version: 1.0

On 27.10.2026 14:50:12, ChunYuZhiQiang wrote:
> The automatic TDCV readback calls into the driver via do_get_auto_tdcv().
> Some drivers, such as xcan_get_auto_tdcv(), read controller registers
> without taking a runtime PM reference, so calling this while the
> interface is down can touch registers whose clocks are gated.
>
> Gate do_get_auto_tdcv() on netif_running() in can_tdc_fill_info() and
> adjust can_tdc_get_size() and can_data_bittiming_get_size() so that only
> the automatic TDCV size is skipped when the interface is down. The other
> TDC parameters are still reported, as they are meaningful while the
> interface is down.
>
> This is a defensive hardening based on code inspection; the automatic
> TDCV path has not been triggered on hardware.
>
> Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
> ---
> v8:
>  - Split out of the berr-counter patch so that the stable backport only
>    carries the hardware-tested change.
> ---
>  drivers/net/can/dev/netlink.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index b958c04d53db..613beee9e936 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -720,8 +720,9 @@ static int can_changelink(struct net_device *dev, str=
uct nlattr *tb[],
>  	return 0;
>  }
>
> -static size_t can_tdc_get_size(struct data_bittiming_params *dbt_params,
> -			       u32 tdc_flags)
> +static size_t can_tdc_get_size(const struct net_device *dev,
> +				 struct data_bittiming_params *dbt_params,
> +			     u32 tdc_flags)

fixed indention while applying

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3hoorgl3hwcfdx7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCauBs0QAKCRDMOmT6rpmt
0oVeAQDPEldnMllUjP5SviKmoKnl3wLQpl6Na0CmXlnuUCcdVQD+IERK8W02hMHr
yGq+TzIrMiw2A/UuXMYwz7euvw+nyAM=
=KAH8
-----END PGP SIGNATURE-----

--3hoorgl3hwcfdx7m--
