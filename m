Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C16377AA6;
	Fri, 31 Jul 2026 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486149; cv=none; b=HcDilYSKb56mrGmpjxIN432suo74jTAj0hudZhsge1b04bu2iXhCdcHdBeaqbXqlmHGeLUHXSisUdN5CjUhj/EMDaqNv064Q7R8I5ia0XIG9FiNqRhYrL5HGvzD3/G/aICWi4BgtCP4uDRLXLxaIK0xvrfpHnYv7d2WGmOamKNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486149; c=relaxed/simple;
	bh=u8C8L+dFYN76fHY858NJNOLzgrxpdhmQvCa+yenYneQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5y7p2tz27yHanAvv8YMk7c0rc6Ki0/adQrJp1QVk3gfqYtNKLpwGEiBzaHznxgIGvvcZlfNbCIzENycU1O6LRLUD/6yym5CgG7I7NzptVpsb0Ex2t8y2B+G1n/BoBz0TKX2yWInqWZP99D/izJkIDZtv4vtgpIPKBH1EnHi9xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2D9E52021B3;
	Fri, 31 Jul 2026 10:22:24 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wpiVc-002B9e-0D;
	Fri, 31 Jul 2026 10:22:24 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C2EEA577CDD;
	Fri, 31 Jul 2026 08:22:23 +0000 (UTC)
Date: Fri, 31 Jul 2026 10:22:23 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Cunhao Lu <1579567540@qq.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, kernel@pengutronix.de, 
	Heiko Stuebner <heiko@sntech.de>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] can: rockchip_canfd: prevent TX stall on echo skb
 failure
Message-ID: <20260731-important-dingo-of-abracadabra-054a28-mkl@pengutronix.de>
References: <tencent_929320CDB8CC5402DD486A402122B7DF5606@qq.com>
 <tencent_BFFE7E8E4D7E349F32F509B7233D01FB8808@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2bsbsmil5anrrh5q"
Content-Disposition: inline
In-Reply-To: <tencent_BFFE7E8E4D7E349F32F509B7233D01FB8808@qq.com>


--2bsbsmil5anrrh5q
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/3] can: rockchip_canfd: prevent TX stall on echo skb
 failure
MIME-Version: 1.0

On 30.07.2026 23:50:41, Cunhao Lu wrote:
> rkcanfd_start_xmit() advances tx_head and requests transmission even when
> can_put_echo_skb() fails. This creates a pending TX entry without the echo
> skb that the RXSTX completion path needs to match the self-received frame.
> The entry cannot be completed, and the netdev TX queue can remain stopped
> after the two-entry software FIFO fills.

Have you seen sashiko's reply to patch #3?

>> Should the driver only write to the hardware registers after
>> can_put_echo_skb() succeeds?

I think it's better to call the can_put_echo_skb() after the
"if (!netif_subqueue_maybe_stop())"

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2bsbsmil5anrrh5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCamxbPQAKCRDMOmT6rpmt
0kswAQDlV7wYQ0x9hzeWB3ThJBYu7HS6D0tL/LkyqJEPkxuKuwEAwmQSALVhaYdi
rI0YBtBNnxmZR5iqTe55aydOSmff0Qo=
=tlqy
-----END PGP SIGNATURE-----

--2bsbsmil5anrrh5q--
