Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B25333F5A7;
	Fri, 31 Jul 2026 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534230; cv=pass; b=QDsGhQvb0H0vTsGgJcJDdEHAfk8aOsMbbu0V2MUJrIhTizf0ykQymO3h91mhEsXXgf4a0LtL99xJRvb6V/N2JqlS2yOkKZqDwFpISkbuN+ctV9tMtvfyMtuiPG964xeBcIJPfk0rvEKSDxSdfjJrP5xJWyN+n1j+kdesyHKYau0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534230; c=relaxed/simple;
	bh=ERkvDRi1W6ODflnf0Lpp1hylVLMvTXT+7KBGwj4IZo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYhvb9AaxKtsyoH42dF/2V4unH2E27HP6fKe/+JKHoJIixTB1qAmwZXFIYj9T0dD3fVMBZBzvaxrEhVlPzQrYfQ7OzW86ZUnp2jfarVJlOrD4D7ysbHftxxfFwjhya4O2SrIuCoe39QRVhDLfitwhsw8YVSE5YDf0qQL6g02ZZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=YpZ/xICn; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="YpZ/xICn"
ARC-Seal: i=1; a=rsa-sha256; t=1785534215; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D6GhEWUkHccMj5pyQ0iM6P5N9c96CfuhddcKlxR4Q1fviJmLYLu7ri31T5V8zuqokFIeooUaY2nfnti7S3XcqcXA59+Xt0MsO5ke/9l1JU6o5xiTijOYsw9tJN7CMWrX/ZpNH/sGR4VlRcFPfAx8ujWete/BGXkZZao8Z3SNJhw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785534215; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cLYN2e6oNLmhz4rIaTuzuiTwkB3LebJiI0BOj54V12s=; 
	b=Zge4ka9qUD8wqpwmYEApQuQXv1wz+wG82LMhA4WuZ1IgG2kDCR8/c8kj+Znxh5BZ37IEh/1TacgUfX+3RDQMWa1LmGK+qnG85WAZGEYo4SzsRbL9rIEvke8w1h/daB918UWBKPYudz43HdzgYrPSaddqD7zRDyc6PdPGFVpVYFM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785534215;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=cLYN2e6oNLmhz4rIaTuzuiTwkB3LebJiI0BOj54V12s=;
	b=YpZ/xICnFOkY1iGdXp/nrsbAFq/KSj99Zh7pHVGR1KLEmL+Be03uMU20MHZctXRG
	+23ttf+hNLSvO9DS0swyA1t23CxHyuG6b4dp/mgmEyxpikwG+XqaIWqcsCsAEahwkxC
	vNqnTjdinxifIpAv3MC+84+INPL9aVI89qLfx5EQ=
Received: by mx.zohomail.com with SMTPS id 178553421319824.818552707404592;
	Fri, 31 Jul 2026 14:43:33 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 28B1318029A; Fri, 31 Jul 2026 23:43:30 +0200 (CEST)
Date: Fri, 31 Jul 2026 23:43:30 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-pm@vger.kernel.org, andersson@kernel.org, 
	neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] power: supply: qcom_battmgr: fix use-after-free of
 battmgr on remove
Message-ID: <am0V6zvEDsNd8J2L@venus>
References: <20260731022006.317192-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ac6b47sewf3gjghq"
Content-Disposition: inline
In-Reply-To: <20260731022006.317192-1-fanwu01@zju.edu.cn>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.527.77
X-ZohoMailClient: External


--ac6b47sewf3gjghq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: qcom_battmgr: fix use-after-free of
 battmgr on remove
MIME-Version: 1.0

Hi,

On Fri, Jul 31, 2026 at 02:20:06AM +0000, Fan Wu wrote:
> qcom_battmgr_pdr_notify() queues enable_work when the PMIC GLINK service
> comes up. The worker recovers battmgr through container_of() and issues a
> firmware request.
>=20
> The driver has no remove callback, so a pending or running enable_work can
> access battmgr after devres frees it. The PMIC GLINK client stays on the
> client list until its devres release action, so a PDR notification can
> also queue the work while remove is running.
>=20
> Add a remove callback that disables and drains enable_work before devres
> release. Unlike cancel_work_sync(), disable_work_sync() also blocks a lat=
er
> PDR notification from queueing the work. Store battmgr with
> auxiliary_set_drvdata() in probe so remove can retrieve it.
>=20
> This issue was found by an in-house static analysis tool.
>=20
> Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power =
supply")
> Cc: stable@vger.kernel.org # v6.10+
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---

Your patch leaves a race condition. A notification might arrive
directly after disable_work_sync resulting in scheduling new work
=66rom the notify function.

Considering the driver is fully converted to device managed
resources, it is better to replace INIT_WORK with
devm_work_autocancel() anyways. Just put it to the right location in
the probe function (directly before devm_pmic_glink_client_alloc())
and things should work correctly.

Greetings,

-- Sebastian

>  drivers/power/supply/qcom_battmgr.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/q=
com_battmgr.c
> index 490137a23d..f8c3efd2c9 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -1638,6 +1638,8 @@ static int qcom_battmgr_probe(struct auxiliary_devi=
ce *adev,
>  	if (!battmgr)
>  		return -ENOMEM;
> =20
> +	auxiliary_set_drvdata(adev, battmgr);
> +
>  	battmgr->dev =3D dev;
> =20
>  	psy_cfg.drv_data =3D battmgr;
> @@ -1729,9 +1731,17 @@ static const struct auxiliary_device_id qcom_battm=
gr_id_table[] =3D {
>  };
>  MODULE_DEVICE_TABLE(auxiliary, qcom_battmgr_id_table);
> =20
> +static void qcom_battmgr_remove(struct auxiliary_device *adev)
> +{
> +	struct qcom_battmgr *battmgr =3D auxiliary_get_drvdata(adev);
> +
> +	disable_work_sync(&battmgr->enable_work);
> +}
> +
>  static struct auxiliary_driver qcom_battmgr_driver =3D {
>  	.name =3D "pmic_glink_power_supply",
>  	.probe =3D qcom_battmgr_probe,
> +	.remove =3D qcom_battmgr_remove,
>  	.id_table =3D qcom_battmgr_id_table,
>  };
> =20
> --=20
> 2.34.1
>=20

--ac6b47sewf3gjghq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmptFvoACgkQ2O7X88g7
+po9Zg/9HZRLQDoVCsq29L8pz8bTGzIjhtfYe8QnzuDmJ78gFWpyVmZzRol4nvh4
U0daNKa3FzMQ17yY7iLXrtiucksu5tbklLpiHnhg3nY4C5gpjL2lfjgWHKgpBX6C
9vrdBH6Wjr4odzqs7HSrJBg65XNYprf/UJoi7McPjH7anXU43iVzaADb0D9mIEkJ
zrPUI2i7kj1qZzZeWXB20P0rndl/foauw2j3lrXlrIwsys7dz+BN5p8MgSggWlPO
MRezYVhZt5HN5LQZFpZHzAMZOuofeoDsjsAq/73GKb87CLAKcwHBUO+BzDdFPrK7
2T37eBdHT9/5FA/tMvMkWKttPqa/7bbYQ+HPVRnAFZBYg9jpWZrhbmSBvtJmvxBH
Ly5pZNnd7Gqsp7BVYz/4/NDEp2hw63Rpss6vWZ849234h3xZ+doeAvcLG5qlf4la
utjpUUARbtS+uFsHfhAIp1GGcGgnqZ3waVSC3hj3oLFGTGLMKXw8S0eW+WArnEzj
3cRmAPZ29yNAfs62VM3C7QMIK34FIlhw9RKHtj1Ae/1aW/InEc0NUOBCIYyBIkte
PIug/K5oN1eWBKgEscWr5TbZvy5GtU7MzY+QsGQrssPkMEFEq/kLn1sZA4RliqrQ
DUCogDHUaNfK6c12UmaKSXA0ukFG/HtQmn0qt1Tm+z8SgBIWogs=
=RfPG
-----END PGP SIGNATURE-----

--ac6b47sewf3gjghq--
