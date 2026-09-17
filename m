Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF064FB9B4;
	Thu, 17 Sep 2026 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649186; cv=none; b=sZzINOrSBLudJAtp2WO13CIPc9GbiL6YbSf3bUl5PsQu3vL75f6HAdKhfRe38B2DWEbvlPC7D8kmYY8DhuQkv48uvr6HZ3W8poEwhCU6akUYnm7QULy9fZ27XjSJd6fZXkxSWyLUYKElvFmlJXWrNx9aCYm3l6lWpHhf7Y8EUFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649186; c=relaxed/simple;
	bh=ffMa2LYmjtNZfCneY2/wOPZyo78KttonYV3gJ6OYHBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkMjEnbdXDWAURwEw+7EyIgRdzt809aEG7Gsmh9sfNvmGD7Pdk3uY1jMGQe45okvgeSQV3eE9Q5tMwAfpHp14+WkNJpL/Tx4PzEs7JMOgXqsX+5KY04keSYkuh9YDcF8V/OVBNPxjEh8nnfn6oIvo9gcSNuIcucD9WW/oRdx1mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 760B3200314;
	Thu, 17 Sep 2026 14:46:08 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1x7BVA-001OrF-1A;
	Thu, 17 Sep 2026 14:46:08 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C65D659FBFC;
	Thu, 17 Sep 2026 10:01:11 +0000 (UTC)
Date: Thu, 17 Sep 2026 12:01:11 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: davem@davemloft.net, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mailhol@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] can: flexcan: Fix OF node reference leak in
 flexcan_setup_stop_mode_gpr()
Message-ID: <20260917-clever-lumpy-stallion-df086f-mkl@pengutronix.de>
References: <20260917095302.2145506-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gd4enemhbx4iajs3"
Content-Disposition: inline
In-Reply-To: <20260917095302.2145506-1-vulab@iscas.ac.cn>


--gd4enemhbx4iajs3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: flexcan: Fix OF node reference leak in
 flexcan_setup_stop_mode_gpr()
MIME-Version: 1.0

On 17.09.2026 09:53:02, Wentao Liang wrote:
> of_find_node_by_phandle() takes a reference on the GPR node and the
> error path releases it through out_put_node.  The success path returns
> before reaching that label, so the reference is leaked every time the
> stop mode is set up successfully, and the node can never be freed.
>
> Release the node reference before returning.
>
> Fixes: 13dfb3fa4943 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git=
/netdev/net")

A merge commit probably has not introduced this problem...

Marc

> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/can/flexcan/flexcan-core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index f5d22c61503f..68699d674fc3 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -1986,6 +1986,7 @@ static int flexcan_setup_stop_mode_gpr(struct platf=
orm_device *pdev)
>  		"gpr %s req_gpr=3D0x02%x req_bit=3D%u\n",
>  		gpr_np->full_name, priv->stm.req_gpr, priv->stm.req_bit);
>
> +	of_node_put(gpr_np);
>  	return 0;
>
>  out_put_node:
> --
> 2.34.1
>
>

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gd4enemhbx4iajs3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaqu6ZQAKCRDMOmT6rpmt
0o59AP9vAe/2cIX0lC7anBMR0T2CLTK93kl1hY5HigOU+l4OlgD/dFKkGogHKoNi
TKoxHzG6RkdVep2I6KhxMco8UmnBfgA=
=U7kJ
-----END PGP SIGNATURE-----

--gd4enemhbx4iajs3--
