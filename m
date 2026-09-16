Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BF647D925
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565553; cv=none; b=kASyZj7sFm0ClRtc49GR2pXGj2Pc8TXF+oftW+6xD16InqocSUcalNzGg6O6T1jy7H7v47+6p4fef4FJHzJltRkJvj7qsL/ymtSB0jCPFcSoJ+eYX7B4YHnXGULesCkUfaId8TOyRyXrMOI30QF80l+TWTbztRWlWeuZuFaSD5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565553; c=relaxed/simple;
	bh=TJOPU11RcMATtIJnIIx4zDB5egcNfZ0cNE8AjUBHtrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVMe3NPmYKODjYAVqcv2+pn3xgot5chVbwRFdPL5V863EvJ3Qu6snJ3aO41sfFPa6hdL3skpBGBqX/9QC7nwP/AVnQS7ABgLwzpDJ9WbZHnxVveoO933yoYcRnGaRh50rTkdygUCqZ7nFGOv28hetDxGFjvqmShe435DO5sP3Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V4GpXU/O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ts0Q6Os1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V4GpXU/O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ts0Q6Os1"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GCYSpv3843663
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 13:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qe2S3srd1ujMpZtLOxTjpY2O
	me9X1N9uun2WLowXtZw=; b=V4GpXU/OUWzxUaYUHd0oGK1WYU1khlQr3aeBheGu
	Vv3Cx4I7CUuyPxFbA32OKSMiJU7JhlZyi55orQ4J4NSyPIYHzZeT6PauFLsVM4lu
	8LK0u2VWijNwpQsPNp1uExIkPU42Utwp3el5SAg4NtzhL4KVrKUWiS0LMeDUtM33
	EmtFpiH/KcYyGlxZLooIVT1B5piverXFjH0RYvFCPAc1LVodfh8+p/arUkEEo6lg
	CpWpDVv7357L/cW2MJkz334VEJjLtEoNWjzweFzYdO/T5IbaWXu+y5/RT5VXILSb
	odtFvMmbCseEAzIJLjvxprkFinMlqSGuXIWsgK8hatj0WQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqefpbc7p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 13:32:26 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c7b0f8e40bso6871806e0c.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 06:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789565546; x=1790170346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qe2S3srd1ujMpZtLOxTjpY2Ome9X1N9uun2WLowXtZw=;
        b=Ts0Q6Os1Pffk7lcCITGCcdTMOSnZ0vNO5c6f6s89uGi81JoPVEpyg7Y6HUd6hDOp1E
         x4Q18Wikpn7UX6N58DN1UckFuYW4Er14LL6MXMJI0zAt6P0k/LRi2NI2IXXRrOZDvyuF
         L6ky+l0cpMW4og3u0bKfFKEgqXl4NPyf970UQZGuoxc2XCtOzGa9azjOZ5pHqCSOhLHH
         xiTMzWvTl20dPJOAv0LThhElTG456bJGMcgJiMLORvtEkSiVaIe+s50ZtmrtiLSnsj3x
         7kERC1AkgzH83ZhjKjr9iRD+1FQQ7CQKVFGBMGmH/qLFZK30CH+4i+5NV55opGLNAU09
         kzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565546; x=1790170346;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qe2S3srd1ujMpZtLOxTjpY2Ome9X1N9uun2WLowXtZw=;
        b=hfNCESe2O0jzlE7IxfFv55FJDqyvLmQrdfEAcCveD/QkLx16+Er9loMLAU6cWSpPYr
         1EHZoAxtZHQjJi9xUrsPa0mftsjbUVcaUXoullgTk0DpKOr+M2iRcOHWy55cQ9bIgxCG
         EPSaEJg3nZ88sETRMjWXio69fcQYCeFhckl4y9fbbtxe/8kOoYqJpDCLcXd2rVSJhBR7
         xjUHpKaU/iRkAXq9KM+uuKmIcYBv+o86FStTrQi1uq9Ft9wmALU+F+PVkl+0nsenqpY/
         7SUruQ1eIj5PD6CNyl9KLTofWWnpxwzqJIKgDBZPQ2bPi9+LIcxNbD4t9dctzbDq29Cb
         lpgw==
X-Forwarded-Encrypted: i=1; AKwUvBxzOeXoznpOeOrGV1O62DxZ7SeI5it40wGJxij4LWSXpj3ZP+qLUj6sSERNiHD8PRbuyZDBXbA=@vger.kernel.org
X-Gm-Message-State: AFuF++moDQkACTIXc4WbyCLf5HdGIS5sXP8FcEIXymAkOaONaTyfBld4
	Uo15B1FDD0/n8CJv15mZa4jqA+zFwiJf/2Uq29BOJyI5umChui698RAm+exwxIGqiYDP3FB/U6B
	q4Es2whP+ANY3wToarloRuulurv2Z6aQi4vVFYJiYgaF37Hnw3wh/VU33EVg=
X-Gm-Gg: AYBFou1EyPq3kSRBh0zyjxt2dVkWdO2tJUf+auMIRQl4OnHbGyOHo0l7yDaAQs0s5GR
	8T4ln8yv8LZfKaeubsLFzAeRd30Bo/lu99KUoT1/rl9nkj1egNVbd+CK7OISxiHTLgC46SpNNfS
	PoIy0iEkVYQEcnrgJYGph/sRcbBTGxtt+/RV3IbUgyyjEKXDVpXVVDcpjZEUFf8e7z9eBwjpg/7
	jb6YQouI3U/97rD029sJl2Kl6fRJv3xrZHZgIBn7kfOcKXsQ/WDH5NNHg0La1bD9/l86paRsFNi
	hXhGu1geNzloCdktMCnBBjDGAVUFLplYKybO9Qx7yuBLvbii9JrSJ2p396LOUpCKkSr39oKI1U2
	0vPDGfrq5dcDAFg==
X-Received: by 2002:a05:6122:f05:b0:5c2:c0b2:9880 with SMTP id 71dfb90a1353d-5c99ab370dbmr3156538e0c.1.1789565542713;
        Wed, 16 Sep 2026 06:32:22 -0700 (PDT)
X-Received: by 2002:a05:6122:f05:b0:5c2:c0b2:9880 with SMTP id 71dfb90a1353d-5c99ab370dbmr3156428e0c.1.1789565542158;
        Wed, 16 Sep 2026 06:32:22 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bef7687sm8311975f8f.1.2026.09.16.06.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 06:32:20 -0700 (PDT)
Date: Wed, 16 Sep 2026 15:32:20 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Sandeep Haemoon <sandeeph@loljews.com>
Cc: netdev@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: mtk_eth_soc: allocate dummy netdev before
 registering netdevs
Message-ID: <aqqaY4wvRf6LUKjZ@lore-desk>
References: <patch-12c1a57b1d914b28b89455f24de55ee4@loljews.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="++p2aDa+hzFcHMO0"
Content-Disposition: inline
In-Reply-To: <patch-12c1a57b1d914b28b89455f24de55ee4@loljews.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE4MSBTYWx0ZWRfX57SqFtVqQXk1
 RM7o1taGHvdzYpmUJiYcZKfNkS7J/g/bfVUXXNgVP69GAnu7DN3c4M+80AkyBY5o3cmf1Ve+jw6
 wfLdVjdvqzP06IjhmtHuzmgSt3wq89c=
X-Authority-Analysis: v=2.4 cv=HrTjiETS c=1 sm=1 tr=0 ts=6aaa9a6a cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Q38KU-38AAAA:8 a=CJssPnnXo0ZNb1wB1VMA:9 a=CjuIK1q_8ugA:10
 a=0_Dvorhm3KXYGdzd8CsA:9 a=XD7yVLdPMpWraOa8Un9W:22 a=mpgw7_Rw23-bP-ukgNEv:22
X-Proofpoint-ORIG-GUID: VkwsgokCSMlGyQtJ1egSXbNmUg-zW1B1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE4MSBTYWx0ZWRfX4pTShaiGY7A/
 ZW4v8pUDvCbIw61myJyyuugrKllpLFOKpDbqHWLrjAu3/0MZBc4feyPvveUSI54MFuzhyNls26w
 9T82TndctRuMmvxD8oEyOTLewv6v2HA9csXpnZu8KgjlJcabizCqMXxKKTNeuZlTqmMkRiiB8jF
 5tOn1HzIqOI2iy3ySvh4YuDIWW5cKRy79XFhQR7vhhjTiilx+KcdVrn7JBqGgkumlIQnwHZFVef
 0AWVgfihuNztpsJVhT3nrQPkAgxji4nofSPnCnbG7ZtuHc+pDsIpNK4d0edFX2dtAa3uDWNQbRl
 XBfLVIxQIE694IZzMcv4V3MuhO/LQLAdzKaysqbUrgL9LEMRCeHXE0IcsMmactAXXz/b2sZ0+OC
 ysA25tGlC+LhyykHcKg/6KQa7loffYkfDDmQ/q4JC4iQ5BhdviLRNL/P4NlGu4TlBdoN6I3Xy+l
 JwRe02PeLNeXBDNUhWw==
X-Proofpoint-GUID: VkwsgokCSMlGyQtJ1egSXbNmUg-zW1B1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160181

--++p2aDa+hzFcHMO0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
> From: Sandeep Haemoon <sandeeph@loljews.com>
> Date: Tue, 15 Sep 2026 22:00:00 +0300
> Subject: [PATCH] net: ethernet: mtk_eth_soc: allocate dummy netdev before=
 registering netdevs
>=20
> The DMA ring and NAPI are shared between the multiple MAC netdevs and are
> carried by an internal "dummy" netdev (eth->dummy_dev). mtk_probe() creat=
es
> that dummy device only after the MAC netdevs have been registered, so for=
 a
> brief window the netdevs are visible to the network core while
> eth->dummy_dev is still NULL.
>=20
> If anything brings the first netdev up during that window (e.g. netifd
> opening the WAN link the instant the interface is registered), mtk_open()
> takes the first-open path and runs mtk_start_dma() -> mtk_dma_init() ->
> mtk_rx_alloc(), which calls __xdp_rxq_info_reg() with eth->dummy_dev =3D=
=3D
> NULL. That triggers
>=20
>   WARNING: CPU: ... Missing net_device from driver
>=20
> in net/core/xdp.c and returns -ENODEV, so mtk_open() fails and the
> interface (e.g. the WAN port on MediaTek MT7988) stays down until it is
> manually brought up after probe has completed.
>=20
> Allocate the dummy netdev and add the shared tx/rx NAPI to it before
> registering the MAC netdevs, and free it from the probe error path instead
> of the now-unneeded err_unreg_netdev cleanup.

I think the Fix is right, but there is a preliminary bug to fix I guess.
Can you please rebase your patch on top of the following one? Thanks.

https://lore.kernel.org/netdev/20260916-mtk_eth_soc-netdev-fix-v1-1-5dac50e=
b65b1@oss.qualcomm.com/T/#u

Regards,
Lorenzo

>=20
> Signed-off-by: Sandeep Haemoon <sandeeph@loljews.com>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 31 ++++++++++++++--------
>  1 file changed, 18 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/et=
hernet/mediatek/mtk_eth_soc.c
> index fd7a49a..ae6a19b 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -5337,6 +5337,22 @@ static int mtk_probe(struct platform_device *pdev)
>  		}
>  	}
> =20
> +	/* we run 2 devices on the same DMA ring so we need a dummy device
> +	 * for NAPI to work. Allocate it before registering the netdevs so a
> +	 * concurrent ndo_open (e.g. netifd bringing the first netdev up) never
> +	 * observes eth->dummy_dev =3D=3D NULL, which would make mtk_rx_alloc()=
 ->
> +	 * __xdp_rxq_info_reg() warn ("Missing net_device from driver",
> +	 * net/core/xdp.c) and leave the interface down on boot.
> +	 */
> +	eth->dummy_dev =3D alloc_netdev_dummy(0);
> +	if (!eth->dummy_dev) {
> +		err =3D -ENOMEM;
> +		dev_err(eth->dev, "failed to allocated dummy device\n");
> +		goto err_deinit_ppe;
> +	}
> +	netif_napi_add(eth->dummy_dev, &eth->tx_napi, mtk_napi_tx);
> +	netif_napi_add(eth->dummy_dev, &eth->rx_napi, mtk_napi_rx);
> +
>  	for (i =3D 0; i < MTK_MAX_DEVS; i++) {
>  		if (!eth->netdev[i])
>  			continue;
> @@ -5351,17 +5367,6 @@ static int mtk_probe(struct platform_device *pdev)
>  				   eth->netdev[i]->base_addr, eth->irq[MTK_FE_IRQ_SHARED]);
>  	}
> =20
> -	/* we run 2 devices on the same DMA ring so we need a dummy device
> -	 * for NAPI to work
> -	 */
> -	eth->dummy_dev =3D alloc_netdev_dummy(0);
> -	if (!eth->dummy_dev) {
> -		err =3D -ENOMEM;
> -		dev_err(eth->dev, "failed to allocated dummy device\n");
> -		goto err_unreg_netdev;
> -	}
> -	netif_napi_add(eth->dummy_dev, &eth->tx_napi, mtk_napi_tx);
> -	netif_napi_add(eth->dummy_dev, &eth->rx_napi, mtk_napi_rx);
> =20
>  	platform_set_drvdata(pdev, eth);
>  	schedule_delayed_work(&eth->reset.monitor_work,
> @@ -5369,9 +5374,9 @@ static int mtk_probe(struct platform_device *pdev)
> =20
>  	return 0;
> =20
> -err_unreg_netdev:
> -	mtk_unreg_dev(eth);
>  err_deinit_ppe:
> +	if (eth->dummy_dev)
> +		free_netdev(eth->dummy_dev);
>  	mtk_ppe_deinit(eth);
>  	mtk_mdio_cleanup(eth);
>  err_free_dev:
> --=20
> 2.39.2
>=20

--++p2aDa+hzFcHMO0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaqqaZAAKCRA6cBh0uS2t
rDyMAQCpP+MkBalzQIvvwZsIzYa9milX/OFLY1JveQYVHbupGgEA69cv9IKlnBls
bOBGM86Ecpp4C2tr6Sw1mNhmwaA8sAQ=
=fg8Q
-----END PGP SIGNATURE-----

--++p2aDa+hzFcHMO0--
