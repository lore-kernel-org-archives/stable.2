Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139AF43C048;
	Thu, 30 Jul 2026 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419703; cv=none; b=vF7taLcmWNvQDb6vGXoCgg16pxe4Nhk0ZqXYQtqdyV60i4b2dEp9qnJ6BDh0qFn/To6/kiDb/KyJFmSW1ty0Dh5GDriCD4DoeoDHPtobH25fGKJteFhzAa/4jinz3tVs6OXq6RL8Nzq7C95jDJdystAwnxWf1ZZvVs/SOPV+C6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419703; c=relaxed/simple;
	bh=AnP/HfA3Fa/FWFjtJT8GcrEhY4nzvmy/pEPxmVmzgL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4PvMxhYduandDzwyy0c6pB5CnGKGrn5udZ14GxaWTR+GAveQXrwRqxVsbYDLtUF92XNC2LUj/uFNQvfKeL9/7BXtRTZ5Rd1YR6BH3bXFWkzYyrIXrfslKr9FtAjrZa9T+8wt/VgrUEcoxSLjdTGhIg5t8bSSUWIMauhyfKuT+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C862F202AC8;
	Thu, 30 Jul 2026 15:54:53 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wpRDp-0023V8-2F;
	Thu, 30 Jul 2026 15:54:53 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 682D257702E;
	Thu, 30 Jul 2026 13:54:53 +0000 (UTC)
Date: Thu, 30 Jul 2026 15:54:53 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Cunhao Lu <1579567540@qq.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, kernel@pengutronix.de, 
	Heiko Stuebner <heiko@sntech.de>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] can: rockchip_canfd: prevent TX stall on echo skb
 failure
Message-ID: <20260730-pastel-visionary-markhor-d65094-mkl@pengutronix.de>
References: <20260730-master-v3-0-91cf030c337d@qq.com>
 <tencent_1BD50002C4093F92A6181A5D99D004949107@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="isxl4fjmtnaokeil"
Content-Disposition: inline
In-Reply-To: <tencent_1BD50002C4093F92A6181A5D99D004949107@qq.com>


--isxl4fjmtnaokeil
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/3] can: rockchip_canfd: prevent TX stall on echo skb
 failure
MIME-Version: 1.0

On 30.07.2026 21:48:38, Cunhao Lu wrote:
> rkcanfd_start_xmit() advances tx_head and requests transmission even when
> can_put_echo_skb() fails. This creates a pending TX entry without the echo
> skb that the RXSTX completion path needs to match the self-received frame.
> The entry cannot be completed, and the netdev TX queue can remain stopped
> after the two-entry software FIFO fills.
>
> Do not advance tx_head or request transmission if the echo skb cannot be
> installed, and account the frame as dropped. Make can_put_echo_skb()
> consume the skb on its remaining -EINVAL error path so that callers have
> consistent skb ownership after an error.
>
> Fixes: b6661d73290c ("can: rockchip_canfd: add TX PATH")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
>
> ---
> Changes in v3:
> - Move the -EINVAL skb free into can_put_echo_skb().
> - Drop the redundant error message from rkcanfd_start_xmit().
> ---
>  drivers/net/can/dev/skb.c                    | 1 +
>  drivers/net/can/rockchip/rockchip_canfd-tx.c | 7 +++++--

Please split this and send drivers/net/can/dev/skb.c as a stand alone
patch outside of this series.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--isxl4fjmtnaokeil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCamtXqgAKCRDMOmT6rpmt
0rvpAP9S6YytcX2HrTpCKlp28NUpqpZ5Z5a4mN/fxFfQCQ1wwAEA6Gd1fREoYcPY
bE9MZJ+d8RphG0xm33x6xCkxSc13ZQw=
=yAyp
-----END PGP SIGNATURE-----

--isxl4fjmtnaokeil--
