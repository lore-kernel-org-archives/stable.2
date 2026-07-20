Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7159E3B95EC;
	Mon, 20 Jul 2026 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784583156; cv=none; b=puLletzWSLL4qnW/Lz2B29QyTXNN0SB7kt96T4WLhd14YrQOJCcX4mZ6zAK3+7OTPdSqSTiH12b3BGGacZerOuqP9x9O15wNzueK3HSe8N3J8keqCgHsyhqejDuUSG/ElcReBy0ngjG7bc5AdQMehyAgnSz13FDZ6yIxrRpQgno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784583156; c=relaxed/simple;
	bh=LlIxelTikGMdw1rKf35LX+BEaisYFnZKcwaALW2PemE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDR/Od6flInFtLvPFKZAjUj7yfjJO7FvCrShbeBpJuYjNRirajLfU3ax8ndOOmGxREd9c7fDjwxEm2tPcHsLRLHL/BJkXDpXcp8tz1l5Dxm9sCw6J6X6h1o1Sqrm6oYMRyu+OJAl5qipCb7LkXr9MtxXfhZjQNM/tHNzaOKQB/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEoW3pdI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEoW3pdI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D676C1F000E9;
	Mon, 20 Jul 2026 21:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784583155;
	bh=mKrex1umT6hG+AjDNIvo1szzKdWcUC0cBJWpzB+A6CY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iEoW3pdIStA3NkMQhjsNeiy9UI4ohlJkG0JheD9KZkvncSwSebzO3ohaK+q23jqi9
	 ZUE5bKMQQKE5ppx8ci11pk+1LryXEcxJ3bZxiiRxoMnM6APchxulqlmqJnuW4dAxYj
	 zBYPdEWfpLA1yqGgFCpcr7CNJ2uf6tERcOjuygHBH5JunzSOZzVBcvV02vXLFTDLtt
	 zL4L6Ce6oJHQvJ2tVmxHzyQJlgkl5xlgWP2JXjzTv8o6/qwd36lKbc3QqGBoZj5fKt
	 wnFvOdWiC1vqSMjvTWnmz2Km2/YBRwWqouGdbJMzrjQdJs6nmmmHCrLRoTghxBHZAk
	 ICQNAROuDxyIQ==
Received: by venus (Postfix, from userid 1000)
	id 3239B1809C8; Mon, 20 Jul 2026 23:32:33 +0200 (CEST)
Date: Mon, 20 Jul 2026 23:32:33 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Ma Ke <make_ruc2021@163.com>
Cc: hansg@kernel.org, marex@denx.de, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [RESEND PATCH] power: supply: bq25890: Fix power_supply
 reference leak
Message-ID: <al6SZUG_RY5SXSQu@venus>
References: <20260630083352.1841720-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7zzn7grzvaxgknmi"
Content-Disposition: inline
In-Reply-To: <20260630083352.1841720-1-make_ruc2021@163.com>


--7zzn7grzvaxgknmi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RESEND PATCH] power: supply: bq25890: Fix power_supply
 reference leak
MIME-Version: 1.0

Hi,

On Tue, Jun 30, 2026 at 04:33:52PM +0800, Ma Ke wrote:
> bq25890_fw_probe() acquires a reference to a secondary charger via
> power_supply_get_by_name(). This helper internally calls
> class_find_device() which gets a reference on the found device.
> However, the driver does not release this reference on error paths.
> The devm cleanup callback also does not put the reference, so normal
> driver unload leaks it as well.
>=20
> Fix the leak by adding a power_supply_put() call in the new error
> label of bq25890_fw_probe() and in the devm cleanup routine.
>=20
> Found by code review.
>=20
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> Cc: stable@vger.kernel.org
> Fixes: d54bf877fd87 ("power: supply: bq25890: Add support for having a se=
condary charger IC")
> ---
>  drivers/power/supply/bq25890_charger.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index c1c12a447178..b50be3fca77c 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -1411,7 +1411,8 @@ static int bq25890_fw_probe(struct bq25890_device *=
bq)
>  	if (ret =3D=3D 0) {
>  		if (val > 100) {
>  			dev_err(bq->dev, "Error linux,iinlim-percentage %u > 100\n", val);
> -			return -EINVAL;
> +			ret =3D -EINVAL;
> +			goto err_put_charger;
>  		}
>  		bq->iinlim_percentage =3D val;
>  	} else {
> @@ -1426,12 +1427,19 @@ static int bq25890_fw_probe(struct bq25890_device=
 *bq)
> =20
>  	ret =3D bq25890_fw_read_u32_props(bq);
>  	if (ret < 0)
> -		return ret;
> +		goto err_put_charger;
> =20
>  	init->ilim_en =3D device_property_read_bool(bq->dev, "ti,use-ilim-pin");
>  	init->boostf =3D device_property_read_bool(bq->dev, "ti,boost-low-freq"=
);
> =20
>  	return 0;
> +
> +err_put_charger:
> +	if (bq->secondary_chrg) {
> +		power_supply_put(bq->secondary_chrg);
> +		bq->secondary_chrg =3D NULL;
> +	}
> +	return ret;
>  }

The fix is incomplete. It only handles errors in bq25890_fw_probe,
but does not release if bq25890_hw_init() fails. It's a lot simpler
to register a new cleanup function:

static void bq25890_release_secondary_chrg(void *data)
{
	struct bq25890_device *bq =3D data;

    power_supply_put(bq->secondary_chrg);
	bq->secondary_chrg =3D NULL;
}

	if (ret =3D=3D 0) {
		bq->secondary_chrg =3D power_supply_get_by_name(str);
		if (!bq->secondary_chrg)
			return -EPROBE_DEFER;
        ret =3D devm_add_action_or_reset(dev, bq25890_release_secondary_chr=
g, bq);
        if (ret)
            return ret;
	}

Greetings,

-- Sebastian

>  static void bq25890_non_devm_cleanup(void *data)
> @@ -1440,6 +1448,11 @@ static void bq25890_non_devm_cleanup(void *data)
> =20
>  	cancel_delayed_work_sync(&bq->pump_express_work);
> =20
> +	if (bq->secondary_chrg) {
> +		power_supply_put(bq->secondary_chrg);
> +		bq->secondary_chrg =3D NULL;
> +	}
> +
>  	if (bq->id >=3D 0) {
>  		mutex_lock(&bq25890_id_mutex);
>  		idr_remove(&bq25890_id, bq->id);
> --=20
> 2.43.0
>=20

--7zzn7grzvaxgknmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpek+0ACgkQ2O7X88g7
+pqGtQ//S6hl3JxBfjJb/dNWVNlNDZFZSsfWNLUx0RArgb5nzHG3CuT0d6OaNdLo
j6Kb5sG5aAVSJNiE6LTu9Ax6tufEPx344/4YXbUeAFGMeUoIoCBv80AK5KJuqPvg
uMYgnYb834CrAIw5CDSHq1ScE464nxx9Pefh9vJ2oyV3QY3KnJwSAcgdw/RkHbNm
6+6959Vg1mCCsLopGMqbC+DFsn6CcbT0x8/VUTqZqJCZFzWuJveJn1SSeohEHXC0
5/TyaejK8QjahVtoJk1znoCbrIipQ69WAm/x04/Zc8Kfoqb3YZK2Vhtf+M+jlx87
PZv0bzwJyjDjrg2yrRcLSWzT+lM63NF3CiG07tm06+qwDuEVdJLvsu3DWf1XM/Un
DDBH0cq2q2NFWH62nGyAzvqw4NGvEsMg/+RPhzH5lk4x0bRuJg8O6kIgLvzoRwd5
ygzy8R4dVqveOu40bUTK/hOkT5v7G1XJnY4gmCxieq9oQUtVawMfGYYae+Ft8ILI
dOiMKUpmNSdo4LUT2p0iuSVBkFzNRb/nWXTh0tARZJq9IBRA2nZhsgF/qFPsZaL5
fdAbjMnQGQ0NxFU15y2f4KLM4qAK/pH7OAn9mfnV3vdmU+A59E8N8uEj6U5mC4Cs
2g4feGH8h774QbImtpW03E/gYbECbOQl6Cc5NXiSg2qMPIgh/oY=
=PIWV
-----END PGP SIGNATURE-----

--7zzn7grzvaxgknmi--
