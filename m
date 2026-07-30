Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F8D415F01;
	Thu, 30 Jul 2026 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411544; cv=none; b=EB1uH7/xX6O8gwaP1AbJUQy6mOsi0GM06jnMCDAeDMN+gyLhy2BP9cQ+Amz6YqScRG2wfpsw5N7EestKTjyEmkV80jN+/1O5ikRu2EPpRRFiRtBhLC5qfZWcQPzoHnhV6TIk7WSbPodLoVGx2z247FmoN1HzEwgBE4QIeHdAiMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411544; c=relaxed/simple;
	bh=cgJfEpsokjfdE7NgXLzQHJNkE3SGVN0UtI8QvIYjdvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D82FMZJKvoTkP6UvYG+FKgH5KltC1my7ti1x47Wij/GUH6RB4Fdv3LMU+b4i3rAtTzoHnkUmLlAlcNhMQ7rocrYnfsBVdIPdf/POqRQu7+R8HT/hHO7EIZRVikSo+2+HSVvi/RiuuTUpa+OI9l94xEbhnzfWueRG373G+J5BGv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7CC41202AE8;
	Thu, 30 Jul 2026 13:38:58 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wpP6I-0022Td-1G;
	Thu, 30 Jul 2026 13:38:58 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1DA1C576EA4;
	Thu, 30 Jul 2026 11:38:58 +0000 (UTC)
Date: Thu, 30 Jul 2026 13:38:57 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Cunhao Lu <1579567540@qq.com>
Cc: kernel@pengutronix.de, Vincent Mailhol <mailhol@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] can: rockchip_canfd: prevent TX stall on echo skb
 failure
Message-ID: <20260730-secret-soft-swallow-4da108-mkl@pengutronix.de>
References: <tencent_D802EB485A801362BF9F54130C0D990C6206@qq.com>
 <tencent_5E44473FC626379A34998A84DF11E6000807@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="275kakqmhn4gk3eu"
Content-Disposition: inline
In-Reply-To: <tencent_5E44473FC626379A34998A84DF11E6000807@qq.com>


--275kakqmhn4gk3eu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/3] can: rockchip_canfd: prevent TX stall on echo skb
 failure
MIME-Version: 1.0

On 30.07.2026 18:11:46, Cunhao Lu wrote:
> rkcanfd_start_xmit() advances tx_head and requests transmission even when
> can_put_echo_skb() fails. This creates a pending TX entry without the echo
> skb that the RXSTX completion path needs to match the self-received frame.
> The entry cannot be completed, and the netdev TX queue can remain stopped
> after the two-entry software FIFO fills.
>
> Do not advance tx_head or request transmission if the echo skb cannot be
> installed. Account the frame as dropped and report the error. The
> -ENOMEM and -EBUSY paths have already consumed the skb; explicitly free
> it on -EINVAL, where ownership remains with the caller.

Can you update can_put_echo_skb() to always free the skb in the error case?

> Fixes: b6661d73290c ("can: rockchip_canfd: add TX PATH")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
>  drivers/net/can/rockchip/rockchip_canfd-tx.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/c=
an/rockchip/rockchip_canfd-tx.c
> index 12200dcfd338..d2cbe25c46d6 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
> @@ -125,8 +125,18 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, =
struct net_device *ndev)
>
>  	frame_len =3D can_skb_get_frame_len(skb);
>  	err =3D can_put_echo_skb(skb, ndev, tx_head, frame_len);
> -	if (!err)
> -		netdev_sent_queue(priv->ndev, frame_len);
> +	if (err) {
> +		if (err =3D=3D -EINVAL)
> +			dev_kfree_skb_any(skb);
> +
> +		ndev->stats.tx_dropped++;
> +		if (net_ratelimit())
> +			netdev_err(ndev, "%s: failed to put echo skb: %pe\n",
> +				   __func__, ERR_PTR(err));

Is this error message needed? In the -EINVAL case can_put_echo_skb()
already emits an error. If skb allocation I think in -ENOMEM case the
kernel already throws an error, right?

> +
> +		return NETDEV_TX_OK;
> +	}
> +	netdev_sent_queue(priv->ndev, frame_len);
>
>  	WRITE_ONCE(priv->tx_head, priv->tx_head + 1);

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--275kakqmhn4gk3eu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCams3zgAKCRDMOmT6rpmt
0tPFAQDy6JtgZotjJ8v6LUFvroXnCHocuILjVvgcmAvujXv6nAEAhhhtmLqAGAdb
EcHrrOylui+MjrU7+T/Sau//YioFSgc=
=qTFm
-----END PGP SIGNATURE-----

--275kakqmhn4gk3eu--
