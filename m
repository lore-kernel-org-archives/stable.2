Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356F6385D66;
	Fri, 31 Jul 2026 07:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785482041; cv=none; b=MBNAF7gvNIiry8cLkoRRd0xJR/EG5EpsU992fCTNKxNL2y0vCTmzqjOSlzKN2lcaPcCJcwzicVG21Ea2E9nktXpPrVDMhS7JFvCZ0j2hIybj8M704RxvblbPn4ieKEhumDcYZzxY1++APgrMWfO4KW3LFLwjUdNe/ZujO3rkPUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785482041; c=relaxed/simple;
	bh=v60M4Z0mY78dMneLPOx700i7dM3GDvG4uFlHC2DuezU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tukQgp/ezcoeeCXlCsgBVABfkqe8KMnUS1CZin75TVjhbGewHi+pLVCnvL1Nr3U1fefy+S+tjpr91XTqG7j7Vn67/urLyhywWvpysjkTSLYzaOLQHE0Veds1uvtN8jDdL/1Pmxk0E3lfQeA4RRIiEpG8mdUXtFWJpOH7B0YX1qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D0718202C52;
	Fri, 31 Jul 2026 09:13:56 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wphRM-002AXa-2L;
	Fri, 31 Jul 2026 09:13:56 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5D438577BB4;
	Fri, 31 Jul 2026 06:50:14 +0000 (UTC)
Date: Fri, 31 Jul 2026 08:50:14 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Cunhao Lu <1579567540@qq.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] can: dev: can_put_echo_skb(): free skb on invalid echo
 index
Message-ID: <20260731-real-rousing-hoatzin-f93fd8-mkl@pengutronix.de>
References: <tencent_944DADCC4B42C8484EC01DA2B15F42132906@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u4nt42x3sliajmhd"
Content-Disposition: inline
In-Reply-To: <tencent_944DADCC4B42C8484EC01DA2B15F42132906@qq.com>


--u4nt42x3sliajmhd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: dev: can_put_echo_skb(): free skb on invalid echo
 index
MIME-Version: 1.0

On 30.07.2026 23:03:12, Cunhao Lu wrote:
> can_put_echo_skb() consumes the skb on all paths except when the echo ind=
ex
> is out of bounds. This leaves ownership with the caller on -EINVAL, unlike
> the other error paths, and can leak the skb if the caller expects
> consistent semantics.
>
> Free the skb before returning -EINVAL so that all return paths consume it.
>
> Fixes: 6411959c10fe ("can: dev: can_put_echo_skb(): don't crash kernel if=
 can_priv::echo_skb is accessed out of bounds")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
>  drivers/net/can/dev/skb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> index 95fcdc1026f8..44ebeba99837 100644
> --- a/drivers/net/can/dev/skb.c
> +++ b/drivers/net/can/dev/skb.c
> @@ -54,6 +54,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_de=
vice *dev,
>  	if (idx >=3D priv->echo_skb_max) {
>  		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of b=
ounds (%u/max %u)\n",
>  			   __func__, idx, priv->echo_skb_max);
> +		kfree_skb(skb);

I think sashiko's comment is valid. Can you use a dev_kfree_skb_any()
here. Can you add another patch to this series and convert the existing
kfree_skb() to dev_kfree_skb_any()? The new patch should be the first
one.

regards,
Marc

>  		return -EINVAL;
>  	}
>
>
> ---
> base-commit: 11028ab62899e4191e074ee364c712b77823a9c4
> change-id: 20260730-master-abf3e4067e47
>
> Best regards,
> --
> Cunhao Lu <1579567540@qq.com>
>
>
>

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--u4nt42x3sliajmhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCamxFowAKCRDMOmT6rpmt
0oGYAQDtGv2w1OmuLkYqqSevUCbdmvgoCjAlD/6+KemkSAo/QwEAiU/o6tLN5S+I
VLmxdLj0DEBsth4D3t5DwLD8foTFQwA=
=BtLU
-----END PGP SIGNATURE-----

--u4nt42x3sliajmhd--
