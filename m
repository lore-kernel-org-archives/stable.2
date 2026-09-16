Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061263D9524
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 07:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542100; cv=none; b=R/z7wHkUE+8hJsqrlq13T4eZF8Xdost6eCWKCxD7rEmTYZlEwJxaIU7ky/UPM1Y3fO451ASq2gEu87NZCjS4KRfuJNR5hJ+3XNoS0Gdt2r6qjd9gIJFlA0P2B9ZikQzAINcRPhhOVZVC9SUGQQebWeFP0Gt5ULQXggfUIOKFyuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542100; c=relaxed/simple;
	bh=/uXK3nBPcvOluMqRdbUimf5jbPBZRHH3dsYrxtCj4x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyQbh3U8Azc2V8FWdVB3aPahgHc5aNoRb0l7HhPJrnEM1lkz7+8VuaRTxq/2K3YuIna0EgGTcjJjp9/i4f+dVrXrIuXQK4xO2RVl7cIAgxAqdv/NJxTktxkAFHtM4gV9ZbBusglDy3KZGALq156R9VcRSwgB8ZkwtwYhEPOzn5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bWMyIdc1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hhDrYaGT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bWMyIdc1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hhDrYaGT"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G68b8o1730394
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 07:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1Ut7kgm3lbIbgif0w1qtAKfZ
	wX8AzmJ0SyvmVTj0gdA=; b=bWMyIdc1uc9hXJVKe6ZNjVUgWVVhrdlwyggBXLCu
	8Kec5D51yYBYDR/RNHQXVGOtgTZMcyBsEtUzxZYUh/KTZzTpqf5GyiO+n7yzeGAo
	z34c39SWYjY7uVEsA4e+YfLRQOMxdO5XUOEemw75NpETLdhekixFXAAxRWpoP8jp
	yCXAq3GL8FV1NDi0pIq3TcN1qaPa+ZdT7Gli+FRte3GfXTuL1PdlFTyV4Qt1Y0zv
	MfTFO5K4zAccldwD48CSX2coflm5RF1CMwL9yc/H3l3dHSj5soWM9fgq31L4T6Qh
	WrrkpucoQ2iY6V3l/HAwb8je7Ir91nE0PcTyoiiLaVeTpw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqkv7gp6s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 07:01:35 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-980989f5030so4028209241.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 00:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789542094; x=1790146894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Ut7kgm3lbIbgif0w1qtAKfZwX8AzmJ0SyvmVTj0gdA=;
        b=hhDrYaGTnPXBPL6Sql+ImrGRo3nt3lpNptISnZzE+09ktTzBQ7Y8cdatnPTauBdO69
         if/Q5Gl3UiL9lcp8TjJU3Qrj19kV0JK9P8fAaggic9czCxK7TG6GfNTwIc8L5EV9Dub0
         r9s/3rsaNzrRb/CI1oMpM6nJdkOdBonRUbjxVzomAuy1TBNFC1ceBueE4i5DuX0JbeNt
         4qSFKJssvA7Ue5dbsW7VKBJ+Hm7LculFgX+z6T25/5/JnynJEpYdeBkvqpdPp4Te9L53
         F/fdJSzMg4FdIbvNAKJyv0Sg5FCAloT7XDxhabm9nu0haFjJ6Azq2xm2nKn50j7CxuJi
         yg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789542094; x=1790146894;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Ut7kgm3lbIbgif0w1qtAKfZwX8AzmJ0SyvmVTj0gdA=;
        b=PgNElV/9I3akUy0lHpIW06Nt44FNtd3BYGQ+wbVP63Rwfqhv+eJt4piD5BZ3vwkzlR
         RPV4ZxJdOxBd0TBXvK7UVb8A4RQvD7dqOrYH0cXMab9ZPrysyiOQLqLwyOJh6ZQNdUHJ
         lKDlnVt5lBnggQIlMbzVfGj65+0cUlvQKMPsOlKc5HWudJcg77h1rMJsamuQFn1cODbG
         Vos9Z6FBwYFJXTFueW/2RniiVXXF3I3qHEJyi9UUVFhG0VerEc0rSwbMCOgQsijqMEF+
         Pcv8DzwO8eY5qZcz8OWEevW4RrbAWrbWoJtbYxrYGiWftSq7Q9/sKLXMX5UEPFfUlvcw
         EIUA==
X-Forwarded-Encrypted: i=1; AKwUvBz2tF9XcjY0lB52TpDl2a82M2jPqXMYvZ7ZheW4CoWchdKLhH17T0brMestlNFJKkigfp8C270=@vger.kernel.org
X-Gm-Message-State: AFuF++k7pukCut9nx9CrMsEZa71pNHxmvVAVUBTBawwsG+ce8SW/fFQa
	LlLOzvxY7PiaJWgGPSplvrT6PEUqAW5d66PeMqFIWB7p8YredEj2x9tCcDSz2dWDH+eNeM1hoCg
	XVLZ2MQ7p1MWk4Nz8BHYq0z6P+B6A+//Bc1D884lPU1Q05QsscvkA5CiB+tc=
X-Gm-Gg: AYBFou1GFsEfyP2QgTx8auGBJSBQwD1Syhide4GBY7faKAkRzqLNPDOlJkxioI5xso2
	eDwmpvCRw8ueoU9QlaMI7daBBusRzEJG+R7DFMxt5izj1VjTQPgr6/nDWelSiNsk2ej+ZQbXya7
	eLShbsNXcNRG1p383YbfAeAHRyHEIftLPXtwLU1s9iUAQy6adJygHRXtxGDnswFkwBP+Wt9zveb
	S5+HxnclPdJwwFfQ/e1u0vjm0R4038oDPNxxdlu6z5y9c6MIxyfDB4hbX3Q1tYb27S4tWyw6tgp
	ZeG35JPdjdfHNs5NAynfCEMsdJ48h0xK3CjrZHTOtdK6LJoi1P2MfWe1a0vXn/vrcoNtb5nskAs
	+TPNozY14IaWVCA==
X-Received: by 2002:a05:6102:41a2:b0:79b:1b6c:4f66 with SMTP id ada2fe7eead31-7a0247f043cmr1487022137.1.1789542094454;
        Wed, 16 Sep 2026 00:01:34 -0700 (PDT)
X-Received: by 2002:a05:6102:41a2:b0:79b:1b6c:4f66 with SMTP id ada2fe7eead31-7a0247f043cmr1486975137.1.1789542093963;
        Wed, 16 Sep 2026 00:01:33 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ed292fc12sm34571555e9.15.2026.09.16.00.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:01:33 -0700 (PDT)
Date: Wed, 16 Sep 2026 09:01:32 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: mediatek: fix PPE resource leak on remove
Message-ID: <aqo-zBZDb0v_20w9@lore-desk>
References: <20260916051618.2904439-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JPSBXS7aDo/qX3Vv"
Content-Disposition: inline
In-Reply-To: <20260916051618.2904439-1-lgs201920130244@gmail.com>
X-Proofpoint-ORIG-GUID: hxgJvX-0-j1lfZSPDBfAbsdjWPgIIUmS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDA4OSBTYWx0ZWRfX1v3aL0ZHJNOZ
 5N0HePCOOXN3HEvzhRwFedKzV+QsB8DpGwZdQV7Zh5/6YcZE3c1BazisvtO86Cmw1JIsUXCdtQv
 KUD5odQHLWULZR1VwZC2P97TXT5N26g1wBW916tA+twN6kSiNFUoisyv0zbjkVrlhsodbHQ4xud
 80i98PpBXpswvJnjl3/ivFcdDblfhv8L1B3Ap0RpHlsqi3JKImko2C1JKoFFVfEMe3pxiqZ//IF
 IgvrwGSflBsIb4ECi9ixA1HTSssv5dhFizKQkd/b4vnV05sZut2R6IKyuW6EgOf2q+nfsLAp52E
 rGppO17/Mxq792dLorbg95cT2hsKKM1pz/yN5CuGaWxHzXIAB/1JKwI/gZ3mmTY4H+jKtBXh8eh
 hBOyFPEwHefwpM+9WbnzW0B9RJPUfGf1p+R22xm+pIUJkslx/OU2HySWM8FjqpJGlomKs6gwm5r
 EokuWHp6BuwzhEWq2/w==
X-Authority-Analysis: v=2.4 cv=eKmGH3p1 c=1 sm=1 tr=0 ts=6aaa3ecf cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fix1ya3lApHd03os7AAA:9 a=CjuIK1q_8ugA:10
 a=NtCxNmvqVL2YQJkQa48A:9 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDA4OSBTYWx0ZWRfX7DM0ns1LKDTS
 3lN97ksGwPKLXjVKZyvPx3odKLFKcYK18lPzS0mDwTiWFhtWxPAyX/cQlvxaaA+VB6phxY2q80x
 eNKyB2TV+udRUJGfOamzKETyhF1j5/M=
X-Proofpoint-GUID: hxgJvX-0-j1lfZSPDBfAbsdjWPgIIUmS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1011
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160089

--JPSBXS7aDo/qX3Vv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> mtk_ppe_init() initializes the l2_flows rhashtable for each PPE
> instance.
>=20
> The probe failure path releases these resources with
> mtk_ppe_deinit(). However, after a successful probe, mtk_remove()
> tears down the network devices without calling mtk_ppe_deinit(),
> leaving the PPE rhashtable resources allocated.
>=20
> Call mtk_ppe_deinit() during device removal before freeing the network
> devices.
>=20
> This issue was found by manual code inspection.
>=20
> Fixes: 33fc42de3327 ("net: ethernet: mtk_eth_soc: support creating mac ad=
dress based offload entries")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/et=
hernet/mediatek/mtk_eth_soc.c
> index be3bd025c41a..04d0a1eec4cf 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -5394,6 +5394,7 @@ static void mtk_remove(struct platform_device *pdev)
> =20
>  	netif_napi_del(&eth->tx_napi);
>  	netif_napi_del(&eth->rx_napi);
> +	mtk_ppe_deinit(eth);
>  	mtk_cleanup(eth);
>  	free_netdev(eth->dummy_dev);
>  	mtk_mdio_cleanup(eth);
> --=20
> 2.43.0
>=20
>=20

--JPSBXS7aDo/qX3Vv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaqo+zAAKCRA6cBh0uS2t
rFAWAP9S+DvP3rvVFwcvFbsCuUr8lmqmNv6uJJcrmYWW6kMSmgEA2kxhcWJU0SBx
j5014OQKU1hwFlulxNmz3jzfj8R4dgw=
=eEvR
-----END PGP SIGNATURE-----

--JPSBXS7aDo/qX3Vv--
