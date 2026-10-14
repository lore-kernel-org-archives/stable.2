Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011055.outbound.protection.outlook.com [52.101.125.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1286A4A6CF2;
	Wed, 14 Oct 2026 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791972540; cv=fail; b=WnNBfTGfg2K8O3ylYAH0YYhn+28eaNGT4lsCkHM05HdiQpQSUqPHpbXCJTgCXC6Nqo3vgN4AnVk42pOBAd96Kj64/R4lUSFV/qWHkQSd6rvELuKNOtlET11dVcPmuHMvY79By4ABXf6RP7v4pnQyPvDNn2gdT9jAXm/l+yA+nTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791972540; c=relaxed/simple;
	bh=nOTOZF5cIdVSN+CimDfBjEJU0L8Jx5vFuZmlvCx7vvY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HHvOUQwzUcLr+UONZ10zX9canPWgDEtCYplPhsXbXw1HbRmA+ar1coeFlv/nIHcJABUJoMbQ5sWEJ6sIeVZBkAz7iPcFbWToutTWMyt5BXDntmneyrRowNHbMbQLH0OR/8iU+Y94RA/C4iqQphoBip2K01TgbpNwHaFCfBdZJnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=jUx5KEw7; arc=fail smtp.client-ip=52.101.125.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="jUx5KEw7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axGLDq4xetc7ncLb5oOnzJ3QNsaq2yLyj+wBLK3tajMZY0j1N5YuGXH8cWg4IYmCj0138s3DjZ8efXBcpxWpKe/MTc4WVROIvezEVOfp7vMB/9idE7drBMOZamE3LxH5vEe4AtSQHdq2uBP0VhOdweQPD/o3RBcON6CbgAPrJrDGPL/HFwAzD31uNKK3ly0BzQL02Bngxv57lU+K8aUvwyJfIQsc4qjwrwJ2wwPRrVla9+LRME0eA2wGW1ekeqada6uIO2jsAkcuXO5sbVOn9RZUTVk7Hy7PBHQaT7lPMAdxsb2xeHxWuaCsv88UPDXWD9Nr8vefNlup1UNlbtOGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5hdg3dFTihw1DnBAllAQMLXhgH6s+12Psf+rVwP+nY=;
 b=t2LwobpANHcyWFzjga+cMlNFU8FU8BX/k4na45tDbmav1RXMqXLH6Wx/M3WkFtu+h620r5RONVqclYtVlT7VHiNt+s2bTxXAzxwxpiEKAdZlYUJEpWVP4oaPjgOIua0gJMdhNj3HVZZSbpMzR8Rd44Gb5QuclzV9xsy5pr6tGycJglwwwiNhW0ueFL+FWTtC4QdIwVxZPVOP7pSjK4SN2IeGUYGFZbBCh1NeItdYAXABKtyGHjy3L0D8Em9NZVtfBUR8Ygd9JCiLF5ITb7yBwe2RqQBghggo9C40OTIzaLDQ2b+74Dv6j3l7dXDcwcjakm9zXmVpN55H+80kPSH51A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5hdg3dFTihw1DnBAllAQMLXhgH6s+12Psf+rVwP+nY=;
 b=jUx5KEw7wX8TKNokqpIGu4AiYdTPtJ5gaWNG8IgrU58Rr4JMDTbqEV7Zwu5A9WRy+0DjihBaPsH8kNrOUDN35u6En9IamxQE/HMFyq7CEN34L2kx3fUmMQtxzVYC40iohcB5YPGa+eEvP0+caRPMqhiHj+xpbDZj47ci2hhOgWc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB14951.jpnprd01.prod.outlook.com (2603:1096:604:3aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 10:08:54 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 10:08:54 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, Tommaso Merciai
	<tomm.merciai@gmail.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Au Dang <au.dang.jx@renesas.com>, Thomas Gleixner <tglx@kernel.org>, Radu
 Rendec <radu@rendec.net>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] irqchip/renesas-rzv2h: Preserve TIEN state in
 rzv2h_tint_set_type()
Thread-Topic: [PATCH] irqchip/renesas-rzv2h: Preserve TIEN state in
 rzv2h_tint_set_type()
Thread-Index: AQHdW8LS9jwUABy5uEu9aunZjt/+TLb8z24w
Date: Wed, 14 Oct 2026 10:08:54 +0000
Message-ID:
 <TY3PR01MB11346E75A9CF528A328CBB7CC869D2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261014095927.635132-1-tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <20261014095927.635132-1-tommaso.merciai.xr@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB14951:EE_
x-ms-office365-filtering-correlation-id: 1869ef28-4b89-4745-a2c0-08df29db272b
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|10067099003|22082099003|261009223027099003|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info:
 Q4viHZWEq9vn/aSoaYFgX/ZlLf2Sk8Tg9eZDAdvXz4wufW8nHqGVGCLFUtsKemL++MIopLMQgJbE6wkp0R/Gf/7UNVteFctjDp6D5fh1gJbnO7hLDBpTzVzLhlpF/BSY8UJo7fj8AuiwQ1iMcboy70gmsp+9sNyVuBcxjtxN4eVE5Q5n9Wtq+/+S5rED9e3C7wsNiHZm6+7wvGFR1ZzqWBlzjMA3fmUMC3tfECMi/OTudPfCvBWlKUVrCnwtbL+9GIIWMHQH5Nnb4LISifiX6iJW1IdIWSyp27g0n4Vqk3KhPw00AYQscw1WeYUOd8nlITafjiZV75ZylGcdS09NJtErYQTxdOwtQwnz8llSpOKpXRHC4w4+eNAxbI+LPgkPqPp1az5zhy+NalfoyCt/P6xMK0eM5Cdnut1IF8/yMvhsZB1px9R2RjOWdmytUIcl7rL4ZXl/ZkaUANwSTh9midDUyb8YWPtKJilHFiEnsdnZdJY55AtB7fgm2oLelRBaS04nTKV6vCOOIuUpAt7ZPkFx+y+DqicG/NHrlssT/f92nkp6O728lgRNuy2UQ/Hfr3BcpP1FvmR2lG3NYuh6f+AmyBMLjodej9AVQjhTdofxWdFWACF5cKGcZrS9hq6sqoUW/wCJIGHlJZkhgK6BfprFgV6qRYKLxvYLyUBQn7QWR4+1onWOwaqYpLSMxFUxSc+esDhhAMsr1yaOXkblP3zPyKy/DNbTTa9nMYF8tMY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(10067099003)(22082099003)(261009223027099003)(38070700021)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Lz2Z7bKivmmDcZ0JFvB9LYhDSfQh9q6234Pvtxvm0J9azwj06QG8w/eonrpH?=
 =?us-ascii?Q?kCoiJNHpdGYZqUGKGWxoVF6G8YTwe7hjWXmttShB0hBK6ll4lk54RxJ9LGkW?=
 =?us-ascii?Q?jo6IADQTGy8xKxLPp5oaLXihpRo99JmCpoCjHPioVvAHpLUrPLRgSWAgu02j?=
 =?us-ascii?Q?Cu0Gy3fx4Me5l6Qhw0AxKkOXdzpfvBMTa9uHyVRLNq1bY6J9kRy/1rSA0m5/?=
 =?us-ascii?Q?pQTy+4d/DUdALImRpb/ixBVtUsqZ/37fnQS2TgYr2a1twXYellrBaAXNGA/9?=
 =?us-ascii?Q?GPDqtdufBOrSBwxbsWCcwhRU3R2c++CtWyXc7Yu38cQLq44C10TdE2Dho1Ot?=
 =?us-ascii?Q?IOTcCSfQK+EVNWdwoYRPIuH+JQhtSKB6WLqYdNB6vfS1w5FZcqJp3quOzfkf?=
 =?us-ascii?Q?OvCMkqgFqostRCE+Bnu7DhwfHgSiAqW9McnbbxoRCaufqkZBundmCUo++o/P?=
 =?us-ascii?Q?UnrQgXRHf91Bw11zejOUq4SXVcXom9xpCCO6HfLDEhCGRcsBAlIPNpERChNy?=
 =?us-ascii?Q?UpN63TUnYyFvgf0bqqUoTDkvEFaWDyALyC47DK8aSwI1vuSZCnLE3TFRXk89?=
 =?us-ascii?Q?HcDnrUjGkbo9aHwcT90sLGwmBt46rKyFJdQ8zBB6FmZfi0z7iSxYmqmiqy1P?=
 =?us-ascii?Q?HZDIQipxRSs3l/d/6TjfpDpjdRMYANFWKjmm2/4mQbddbNaSPO4toyzPHO8I?=
 =?us-ascii?Q?/v+KypqJ45HoHQ7Nsw7ia1IAu4bUDKXo9EsIXKb3gNUIcA4ywaMu+5RHJMyp?=
 =?us-ascii?Q?pIq/bnaU4z2XKydBFoqI1PdqW94/2oxRAokBMs88jXzuW236jgHBLyYchPfK?=
 =?us-ascii?Q?Pier8cphF1GXI2dgGatZ1PqNDYBCf9tu/cifE/dEyV8jrTp7jG31EaHXmLAX?=
 =?us-ascii?Q?tlApRG2Op2JTq2DbM2Q+TP9qtcaGiYOh31eLnektDOStZM1qZEnVvymMMtDP?=
 =?us-ascii?Q?bMNLX3qkXgvDhKxssL3UQOhJITmU8Ru4pxV58KWZuWXgk0klGBrnQdk6suOo?=
 =?us-ascii?Q?jWYGvyF3S7HSdK/GhvjaV58w5zZ2LbIBvRSQdB8RATB6LTMBMwSpzMMSsxHt?=
 =?us-ascii?Q?zpl4gAOimQGGc3UkBdvXfq1WFGX+R1modXB4Z1qiOxrwqmuttewgdubtN1zS?=
 =?us-ascii?Q?hZclPnW8RNko1U2ETZE7WM+0yndqvay1+9p97vACD0aS3vPgTicRnQd1TlwU?=
 =?us-ascii?Q?rBeD/RerFGwzUjt5mH/YKhzZTSe0srhEBHduIXr0zzrBn0IJGixD8bzzrAdQ?=
 =?us-ascii?Q?83qQ1Pj7ufaTaPKCK+ZHn4IffxOh5vSVlPX1Fo+FH/V7hNwSbcqmsgcsrZiM?=
 =?us-ascii?Q?wfTL/DZeishRULXDCFdRScmxBedM7xm5PZwGeB6Dn/9HljJBZDd/xbJ7/byV?=
 =?us-ascii?Q?B+aXu2JQzcQKl4ycMoIvKmCBLxxOhNzk86J8SUq3vMQ/SNfF7fiUDetg+YP9?=
 =?us-ascii?Q?XrI1BV53O0a3Lo4Jt8xt5XmmjuB4kgkwtdIPgKIiBATNFjPT6/kvG0zhYyp1?=
 =?us-ascii?Q?Kh+Qg0UWerKngDRKiGuR5UMLOoTWrQqQAe9EML57RloH/TvzFoxqijoheM5e?=
 =?us-ascii?Q?MFqxweh9ClJZvruD5tXD1NEnMl0wS5AKIrkX2G6KoML6hiS0QDiv2jTvoiLF?=
 =?us-ascii?Q?4Ip0eiGgxUInbODDspzGERC5GbeQ0pSaa9uivDVmxBPQQU7WAs/VEDlqvZvU?=
 =?us-ascii?Q?yU7GDf5XsZlopPHc+tWo62mewhC1QMWnINeeY9o+zZKV6cAC3er3GryvgkpW?=
 =?us-ascii?Q?VwomNKxjpw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1869ef28-4b89-4745-a2c0-08df29db272b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 10:08:54.1089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VvY3o0lMmfgCVk1hmu0lHmU0FMoPkQX724HPjlSFfNKQzyQ4mJOOgxxEOShkeer0GgZ4kekdEPvFk0UTIkg3sFaN/0f4q26Iz42wRMHQjHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14951

Hi Tommaso,

Thanks for the patch.

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: 14 October 2026 10:59
> Subject: [PATCH] irqchip/renesas-rzv2h: Preserve TIEN state in rzv2h_tint=
_set_type()
>=20
> From: Au Dang <au.dang.jx@renesas.com>
>=20
> rzv2h_tint_set_type() clears TIEN while switching the TINT source and the=
n unconditionally sets it again,
> enabling the interrupt even if it was disabled before the call.
>=20
> Restore the previous TIEN state instead of forcing it on.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 0d7605e75ac2 ("irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU)=
 driver")
> Signed-off-by: Au Dang <au.dang.jx@renesas.com>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

> ---
>  drivers/irqchip/irq-renesas-rzv2h.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-re=
nesas-rzv2h.c
> index 1a4703a353e9..485c3eea7632 100644
> --- a/drivers/irqchip/irq-renesas-rzv2h.c
> +++ b/drivers/irqchip/irq-renesas-rzv2h.c
> @@ -420,9 +420,9 @@ static void rzv2h_clear_tint_int(struct rzv2h_icu_pri=
v *priv, unsigned int hwirq
> static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)  {
>  	u32 titsr, titsr_k, titsel_n, tien;
> +	u32 titsr_cur, tssr_cur, tien_cur;
>  	struct rzv2h_icu_priv *priv;
>  	u32 tssr, tssr_k, tssel_n;
> -	u32 titsr_cur, tssr_cur;
>  	unsigned int hwirq;
>  	u32 tint, sense;
>  	int tint_nr;
> @@ -477,6 +477,8 @@ static int rzv2h_tint_set_type(struct irq_data *d, un=
signed int type)
>  		if (tssr_cur =3D=3D tint && titsr_cur =3D=3D sense)
>  			goto set_parent_type;
>=20
> +		tien_cur =3D tssr & tien;
> +
>  		tssr &=3D ~(ICU_TSSR_TSSEL_MASK(tssel_n, priv->info->field_width) | ti=
en);
>  		tssr |=3D ICU_TSSR_TSSEL_PREP(tint, tssel_n, priv->info->field_width);
>=20
> @@ -489,7 +491,7 @@ static int rzv2h_tint_set_type(struct irq_data *d, un=
signed int type)
>=20
>  		rzv2h_clear_tint_int(priv, hwirq);
>=20
> -		writel_relaxed(tssr | tien, priv->base + priv->info->t_offs + ICU_TSSR=
(tssr_k));
> +		writel_relaxed(tssr | tien_cur, priv->base + priv->info->t_offs +
> +ICU_TSSR(tssr_k));
>  	}
>  set_parent_type:
>  	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
> --
> 2.54.0

