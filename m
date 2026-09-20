Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126C73E49C3
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789891627; cv=none; b=tOUiNArwx9Ww0+uPNbvmFV5uJyuqNeSSIRDDfBXe50jm3ikv0wQ2ODT+9ZpEp1xqBSraQa2ENxb52GDCIo3LoQP6HBUCxzQ22FA8kDnckCh8YJnHr/goTWPsRSHgFvDcffgrn9PKMQpu9pkCsaylOXEHn7CNbTo6zFSySXoW8mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789891627; c=relaxed/simple;
	bh=NxKn2zgdt91w1kXFCzpOjTEpxO7DBd/+TEc3QoOOwRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0dcQ6J4fYM7FCIxaWLbKK7+L9RgV/dlTOrWtHnysXlF/O18mCjW8r/5sNGO66DMcNVQCCd6Ldil8afBPtabJdwYteoKY80LmjXkiE+G1kx5BZJmtq8JkK/vDYcIieTgvttmWcgsJ3HYcEpRnPnFiX4+4/ScxcdMl+Q+kkRdI/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kty1hwW4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D6OAkr6+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kty1hwW4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D6OAkr6+"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68K55ZY12632871
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 08:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=e5jUCEkf9yLnafQe149Ub/uG
	ZIIw9CugVMd5LhvprM4=; b=Kty1hwW416uA8gajdA7yNh0yY+XBuf1N7vMsN3UU
	zxxkWksof4NOoXgHcirirZU6rUOPJlhCeVnM5VolI9KftZO1xKVU+aimHRjYN7BQ
	eGkvzUlwuf2rnRAQuMwBwjJFXlhIHtCI+bwySg2c4ZkOhUjog6AQgKE8hriAR5z1
	uWLrjPkPBUo78q/fGFEY/yVx+TbYOO9LloQ8/Egwj0g+gkh2ndhR5TRsxSqWOi/B
	7Z9oNZ5AWCJ4k3KJp0P/wWh9clA1Uyz0Y9ixKmOdLjqiUrIdpXjl4W/VsBs8zGsb
	WDkNsVtuFtlQ6Mq32mKXR+euyskVuwluBixrn/UM981OXw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsg3f2wbe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 08:07:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a183a0e93so493061685a.1
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 01:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789891623; x=1790496423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e5jUCEkf9yLnafQe149Ub/uGZIIw9CugVMd5LhvprM4=;
        b=D6OAkr6+6g/R472yARxyArSMcc5perYQGwMmkq2ZUXzGhgC4618VY7VBD8NvF3pmPP
         bld+YnHMR9uANqaqlRngBd2PiK7iTXGZdLPbMzqsUAFz5HwDQExvHmlBcvTk6six4tnK
         Wj8GOGGkpiYZ1o1xNIfYL9yI9CJ+reELrI7OqmNuqmmptTSqh5jlFblpMiQbowr0zP6e
         xD5q/fvSxFZbHeaGNX1nOSmJIHNG+KJT+oqnfT6+sJ/q4JFBXfImkuRv5WWFEBF6lx0C
         iLlxCLZ4A4V4+/rcZlN7v99E07gdDfJ6+Om7uI+uhXIdzQrFRhO4+i8iC+1ogzJjG+1P
         yABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789891623; x=1790496423;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e5jUCEkf9yLnafQe149Ub/uGZIIw9CugVMd5LhvprM4=;
        b=m1+o8dvEG9g5n0k8V3Ugzrksdht4MOdpzqXvCAX2gxH4cXfFQA7Dnnfw5vJzzCAqE9
         Tu4ZOGuNO795v2XcEvbOoN06NB/wMITk2ciftezb0ZSzT6rgRy3A+nLCGZhSwHY9/A58
         uwk5ZzhsoQesnslfJnyCnH75HMq7TE42edbUNknyOF9dEdRXCi97de2So4ggqqW3oOaJ
         JQMPyyIo+SNk81rOQf5mkRvFKqP/wq0oZwumEC1WXJp9Kr+oKgroJPEyftVWRJjaJlgQ
         uWoEabu/VRenxLMjUllgQrx5wpC4jvOGd/vbP4W/DxGoreFNkNRCGCXJUs3K2aekAIeV
         PVkA==
X-Forwarded-Encrypted: i=1; AKwUvBy1aLq2WG9KbkjwiaDK5Z5k/tfm2SZhfnH5oD8i8Dmg1Z13fWa00GiEAw5sImP0QGiNSnPeOxo=@vger.kernel.org
X-Gm-Message-State: AFuF++m0VMJjvGlWjE+neCUo1s5CHO5GZs+CPDo60oHlbBXbITEuoagq
	Xgtm8GDVkCMJN2iw18AGyCaGb/+bgRnIx9NGUvnNIzHf1z81g274vV5eKJMUaSG7234Jtzxa6oO
	3MbYXQE1mug52I8c1JuAv+MWgnM6WWxCl83JGmSXnaaXYXYlXSihnj+/YFRw=
X-Gm-Gg: AYBFou017BgvOIS2YQIp3TcA6MaRO9K7eztOtgEEo0DUF+p3j5Hgis+ZbrK5We/o0H7
	9M9/GnBOW18APjpLIYRFmy1gS0Kr1vnVyfHVxxd5bqO4Y6yWBak1Lh2jYDb0vcq/FGH+LloYd3c
	mlaLiEToRfloBjOV548A2a7ON2iimxsr+bdvwsasgcduavubhLAR3a8EEpCffMN7qn3Yd0QT5ua
	tzmiM9XWgqWici02iwWhW1VdOXBSuceQCsqXe031nvDdxDKEWE9bhftaNlX/3UnRgheE5kTF3a6
	0Z9KNqpUvkGufYhVC9SrN0XkqKoDhN2SjxjzdS8M5bCRPwyOrBIoNrHsKlSblXV0kgpSp97fKeq
	aJCctj9vyUSY3qA==
X-Received: by 2002:a05:620a:2311:10b0:93b:fb3c:2d09 with SMTP id af79cd13be357-93bfb3c2d27mr213524785a.66.1789891622754;
        Sun, 20 Sep 2026 01:07:02 -0700 (PDT)
X-Received: by 2002:a05:620a:2311:10b0:93b:fb3c:2d09 with SMTP id af79cd13be357-93bfb3c2d27mr213522885a.66.1789891622276;
        Sun, 20 Sep 2026 01:07:02 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc55cd8a8sm196415225e9.0.2026.09.20.01.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 01:07:01 -0700 (PDT)
Date: Sun, 20 Sep 2026 10:07:00 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: request the MDIO reset GPIO only once
Message-ID: <aq-UJEFIq2aHfEee@lore-desk>
References: <20260920054703.1897755-1-xiaolinkui@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5yyGVeVacvTbMRAa"
Content-Disposition: inline
In-Reply-To: <20260920054703.1897755-1-xiaolinkui@126.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDExNSBTYWx0ZWRfX80sG1JJAtbgC
 zzYDQhRZjYdlkKAz8TrHQJ7TKS/Ek1wclXptyxWYBSHpK0Bbm12KEm0NhN3t4mlX2it2A8qUc92
 owfXJdCpinHv0/Sk/yN+8SSaHdD98cs=
X-Proofpoint-ORIG-GUID: KeQac0-OPYva_RhIwVk6jSsW4PL0iATb
X-Proofpoint-GUID: KeQac0-OPYva_RhIwVk6jSsW4PL0iATb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDExNSBTYWx0ZWRfX2eDcvrbj+Aj9
 3t78ASlee3AVb3XOY7I4SLzeN4O/EUOIBiEC1eDE22LP7/kk3/zpgIj92h1VZjkTTnI9a8nC2ji
 d2CaY2QpHlxnZZ6g7v4deZWEY4l64AxkEZQLxi/ODYO0Ca+OAcM+N3h1NsGYRZVwGu5A0gYYfdf
 qi2Cqpasebi94INmIn8VX5RB9BGI35+aGmoBns8TnM7vi9CfsiNOJBPGJtX4iseQlt3WT6DW7kR
 sJUO+wKCmxyZXLdkCmSnmVX2c7+WzsZK8sWcpKULn8uUSRLbTd/SitE7WKY7HQatrs+43GdrFS+
 vhxTkwCz+gm77Sj+dp7GOHsLtEW7CRlmSEXDCV5tsDqYQRQXv0Zh7wysjhCTejlboZdO9Ny9tIr
 579JtO6aPTk7wTMlZx9c5ttHt4JbhE2EpMk7Xpx4Z7UAQx+uaXDfvmw1O/No89O8u1Nk+TOj5Ee
 fhghhnOGSA7I7Rig6+w==
X-Authority-Analysis: v=2.4 cv=N6S8hG9B c=1 sm=1 tr=0 ts=6aaf9427 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=ROrK7FBXa46LgAKx6Y4A:9 a=CjuIK1q_8ugA:10 a=3qf_Ru5Olzpm8D4UWuwA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609200115

--5yyGVeVacvTbMRAa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> stmmac_mdio_reset() calls devm_gpiod_get_optional() every time it runs.
> A GPIO line can only be requested once, so from the second call on
> gpiod_request_commit() returns -EBUSY. devm_gpiod_get_optional() only
> turns -ENOENT into NULL, hence the error is passed straight back and
> stmmac_mdio_reset() bails out before pulsing "snps,reset" and before
> running the STE101P MDC workaround.
>=20
> The first call, made by of_mdiobus_register(), succeeds, so the failure
> is only visible later on: every resume that does not use WoL goes
> through stmmac_resume() -> stmmac_mdio_reset(), and that caller ignores
> the return value, so the PHY silently stays un-reset.
>=20
> The descriptor used to be requested exactly once: stmmac_mdio_reset()
> resolved "snps,reset-gpio" itself and cached the GPIO number in
> stmmac_mdio_bus_data::reset_gpio, and commit ae26c1c6cb9b ("stmmac: fix
> PHY reset during resume") relies on that cache to reuse the line on
> every call. commit 7c86f20d15b7 ("net: stmmac: use GPIO descriptors in
> stmmac_mdio_reset") replaced it with a devm_gpiod_get_optional() that
> caches nothing, so the request is repeated on every call and fails from
> the second one on.
>=20
> Request the GPIO in stmmac_mdio_register(), at probe time, and keep the
> descriptor in struct stmmac_priv. This is where devm-gpiod is meant to be
> used: the line is acquired with the device and released with it, and any
> failure to acquire it is reported during probe instead of being ignored
> by stmmac_resume(). stmmac_mdio_reset() then only pulses the cached line.
>=20
> The request is still gated on mdio_bus_data->needs_reset, which is the
> condition that installs the reset callback, and on the device using DT,
> as the reset itself is.
>=20
> Fixes: 7c86f20d15b7 ("net: stmmac: use GPIO descriptors in stmmac_mdio_re=
set")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
> Changes in v2:
> - Do not request the GPIO from stmmac_mdio_reset(); request it once in
>   stmmac_mdio_register() at probe time instead. (Maxime Chevallier)
>=20
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 ++
>  .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 19 ++++++++++---------
>  2 files changed, 12 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/e=
thernet/stmicro/stmmac/stmmac.h
> index 7582fca63741..986fb43db45f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -25,6 +25,7 @@
>  #include <net/xdp.h>
>  #include <uapi/linux/bpf.h>
> =20
> +struct gpio_desc;
>  struct stmmac_pcs;
> =20
>  struct stmmac_resources {
> @@ -287,6 +288,7 @@ struct stmmac_priv {
> =20
>  	unsigned int pause_time;
>  	struct mii_bus *mii;
> +	struct gpio_desc *mdio_reset_gpio;
> =20
>  	struct stmmac_pcs *integrated_pcs;
> =20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_mdio.c
> index afe98ff5bdcb..346f93f86abe 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> @@ -386,15 +386,8 @@ int stmmac_mdio_reset(struct mii_bus *bus)
> =20
>  #ifdef CONFIG_OF
>  	if (priv->device->of_node) {
> -		struct gpio_desc *reset_gpio;
>  		u32 delays[3] =3D { 0, 0, 0 };
> =20
> -		reset_gpio =3D devm_gpiod_get_optional(priv->device,
> -						     "snps,reset",
> -						     GPIOD_OUT_LOW);
> -		if (IS_ERR(reset_gpio))
> -			return PTR_ERR(reset_gpio);
> -
>  		device_property_read_u32_array(priv->device,
>  					       "snps,reset-delays-us",
>  					       delays, ARRAY_SIZE(delays));

nit: what about moving even these properties to stmmac_mdio_register()? It
seems a bit odd to have half of the parsing in stmmac_mdio_register() and
half in stmmac_mdio_reset(). What do you think?

Regards,
Lorenzo

> @@ -402,11 +395,11 @@ int stmmac_mdio_reset(struct mii_bus *bus)
>  		if (delays[0])
>  			msleep(DIV_ROUND_UP(delays[0], 1000));
> =20
> -		gpiod_set_value_cansleep(reset_gpio, 1);
> +		gpiod_set_value_cansleep(priv->mdio_reset_gpio, 1);
>  		if (delays[1])
>  			msleep(DIV_ROUND_UP(delays[1], 1000));
> =20
> -		gpiod_set_value_cansleep(reset_gpio, 0);
> +		gpiod_set_value_cansleep(priv->mdio_reset_gpio, 0);
>  		if (delays[2])
>  			msleep(DIV_ROUND_UP(delays[2], 1000));
>  	}
> @@ -608,6 +601,14 @@ int stmmac_mdio_register(struct net_device *ndev)
>  	if (!mdio_bus_data)
>  		return 0;
> =20
> +	if (mdio_bus_data->needs_reset && dev_of_node(priv->device)) {
> +		priv->mdio_reset_gpio =3D
> +			devm_gpiod_get_optional(priv->device, "snps,reset",
> +						GPIOD_OUT_LOW);
> +		if (IS_ERR(priv->mdio_reset_gpio))
> +			return PTR_ERR(priv->mdio_reset_gpio);
> +	}
> +
>  	stmmac_mdio_bus_config(priv);
> =20
>  	new_bus =3D mdiobus_alloc();
> --=20
> 2.25.1
>=20
>=20

--5yyGVeVacvTbMRAa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaq+UJAAKCRA6cBh0uS2t
rG2zAP9gsrCleSZRt7ExqFD7e5Mo2sDtzXBvEdUjogUqIwHIFgEA/iL8xVFwvzmN
CrJXix3dYybHYLP1NiQCPZif+Yis2A4=
=/udT
-----END PGP SIGNATURE-----

--5yyGVeVacvTbMRAa--
