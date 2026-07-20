Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2121.outbound.protection.partner.outlook.cn [139.219.146.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2B01DA23;
	Mon, 20 Jul 2026 01:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784510858; cv=fail; b=bOAX3v4iT0vsFVIQ7f/i2bGgtjUX4Hoaxv46xVITylNjHCJ9+rUXX3Ecj23v+zAz1mGD4LUECM/NFkJLwyFddjru505WceJIRALpcczUojDCuUPQihDPe+/soOMVUIjyrZtTppG1C3V3vnk38UITA1dQR/NDddNEFkA2VPD7Aa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784510858; c=relaxed/simple;
	bh=7786A+yWA4AoEJhHO8idRFFbJueR0ym4jt0uqpfp2XE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MSpTb+oWBh7K1MR6rkSUbLLV0ZDO2PzqX20ycsgjFk0FCpUyAe3wRkADFWvbIxFAjKOSfjQMUjRHL2hknTpTCqjMGyxsZZwG2lE7Lni20XLCzwTzeFg4U6V2MsiUW0CesAwZXNHt8mudswhNtFyl0u+RQ4umzTF7xrCHZoE+nbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ilqd4kXzocUm0SoPr5mF/d6jMBGCjERlVF0Crq2X9Ep4BhXemypA2kFiv3qXnf8lDogL3IKYScJMsn4j67guGoPhBsRtUBL4jUzbgyNgXWtjOL9FK4bOFZzRWCQrN95iFaWDEvVFD5wXR4M1Rd+FmfGcIGoZhR+5U5uLN0IzAxzJy9DkSTW0FwbmOy6jREx3N5yIK0xs7cHz8hNigakuoJzptRBchUOHFo62+qYyJT/oc9TBmqr//JZwd9ntfmfdVwvNxYPGQ2ptNmQMy0gS60dXnkoCbctbPktTJ+wqN2CpFLi2Z1OWVIHJNQMp+m31qZ+STv9R/1upzqrP9Fr0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcBdQ6BBenV9KTv6aO3P88TSGBN1MbuOfcmuXT05l20=;
 b=nUnNBhn8/yOxkPZmsDgQM/cS3ylAvF5YbFncAwzLbRiV354antewjeQ9aZNfw5Hkqu8YH/t7PYmqLXJn9I6NpcQ/PX8FKW5UtKRrVfSjGLluhHLbGKzHydIXZf4UiQr8xzLi8LmDKqFrNawjkcvERWg0EENzkr/y8W70xBDWJOxIUB9ZpUdq5hapGcQIBUJBrWcaJLRHwEwDwXQutTyprNDfexxcxTIJCAGOjRJ3bkp5wMfs5CwRKhuVEeRTqo3Z3IokLRouwzrhrtZN1GZrOwK1OpTncPIrIDQpN093ijwKEbeHloGvT4R4OQhS7iXdWZfzoIi65e+5q/iv3JGKCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1316.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Mon, 20 Jul
 2026 01:12:38 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%2])
 with mapi id 15.21.0223.015; Mon, 20 Jul 2026 01:12:38 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Can Peng <pengcan@kylinos.cn>, "jack.zhu@starfivetech.com"
	<jack.zhu@starfivetech.com>, "keith.zhao@starfivetech.com"
	<keith.zhao@starfivetech.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>
CC: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] phy: starfive: Fix runtime PM cleanup in JH7110
 DPHY TX probe
Thread-Topic: [PATCH v2 1/2] phy: starfive: Fix runtime PM cleanup in JH7110
 DPHY TX probe
Thread-Index: AQHdFpQMtTB3hbeiVUmGFHzI225YobZ1nIzw
Date: Mon, 20 Jul 2026 01:12:38 +0000
Message-ID:
 <ZQ4PR01MB1202A26BE85C41F0D582AA67F2C32@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20260718090054.444513-1-pengcan@kylinos.cn>
 <20260718090054.444513-2-pengcan@kylinos.cn>
In-Reply-To: <20260718090054.444513-2-pengcan@kylinos.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1316:EE_
x-ms-office365-filtering-correlation-id: c90f6f75-0590-46b1-8b07-08dee5fbfd7a
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|18002099003|22082099003|4143699003|56012099006|10067099003;
x-microsoft-antispam-message-info:
 wx29O81RbSaIZ0MRkXCoJgln3S34B5+4Gw7/u13YkpFFj9VJC4PyrFICyGBG+jQzpARN/jRjZ7u8aqsX/6keN+M0BzpIzVoQkNZpJ68W2V84SsTWQmAoyTfZ3BVmdGVhVpf4SEVW9xf2NivemYGtfh1xlNHtHxrqopOxgfBoH+TBsGSqJHJvl/vSB4nE55oQ/vE+HcYMdcd2Vu6CPCCOF2eTTYCxQsc4jITc9AzqRsjSOWM3XVC3s4NqBIbEILWc8/bI8iRvjqUYXJh2LoLjBfT9cQkI9/MkULDGaaM20sfARrtsji0WpzoyOW4LHjsV030pMx/plyz879ad+2MoieIVfSCTp5CajvWEyLOwIfEduKPUbOHNeECn57cgRAMyt3i9Wj95Frzv2YaXLIWgIA1fM1JwllrHMSF4x5/5f5xoKbV5Rb4tldQQkbmQLBtCuD4BcWwchGRBwjgjgGmh4R15DtPK3BORuE7G6chdwFwOqMZBVntu5Gx50XlhnXzZME1wD2JcWf7rDw6VMO2ZDSiL9oPCkKJaF/uXWrloFXXfDjqiGiThdL1DP6xJ9JMe
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(18002099003)(22082099003)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fUpK/FA3j7b1k4CcXpgLRCpBck7Sj5dJnY30BmW6I78hKqXPlvePYdjRTRcz?=
 =?us-ascii?Q?cufXWR9LY9QJ8aJso9rDEFJgh3EQpKJ6fbynB82c/eyugoCFLlwshiHDd6Hr?=
 =?us-ascii?Q?RDv6sdaOmYU5xSIn/PM49RNH0S+ObD56r5Z9ZLDJtpcqD9aRW3pUk3Rxw2l+?=
 =?us-ascii?Q?I/YM0h0FPTWayv8uCAV2og59HeJHxHO5h3lqZfXWNhGApr7FB49wl4LTbdvj?=
 =?us-ascii?Q?4eq0FjsjO93Z4L3w0d81wi3qb9gxFyM1OqhNlFJcIdNkzyYnxw5SYLBNdf/O?=
 =?us-ascii?Q?OalL1VmQqGxfxIvH+yW5z25Y+Wk76aoRkuaDj5ScLKp+RMcm2rKX7oT4Z2y/?=
 =?us-ascii?Q?13KW8C5B4WjqqD9Oerm5HB5WXpEyVLhhkmRULVUS0GJRL66yWnbl1vJbHrc5?=
 =?us-ascii?Q?J9H/zoKDVuoJ+bY3MArkOKZqYKwOGQwrdml+jkAq2B3tXIAuvnGCngmXbzP+?=
 =?us-ascii?Q?ZuXyBED7CfmRcG890emyJu7r9yWRQ7VX6BkeCDsA8T1sUgqHr45Qq1UCou30?=
 =?us-ascii?Q?ylV5lyIXCSzw1v5TJqWUrSYUFXwdBdUicBepGzcvjTLUkEjLfA9V1uXBZ6Du?=
 =?us-ascii?Q?XyBuzwrguuQV0fMlwTXVVBxX9j1kgIKNY2AhfyYg/982SD0aFICxfg5PATpD?=
 =?us-ascii?Q?3t2aUxigK4va/WmEX4NahcixyXevIHWwduC/ESXiy0UZnsfkIB+1rAUZLM7J?=
 =?us-ascii?Q?izgpbPfbYNdUt/SqStHZAvEnZqzA44SNqOx3xVYN4apS9ec/ISBJTb6DAX2g?=
 =?us-ascii?Q?DIwHyTRDQJDOQ3h1OHtXSGzSay1hio1LZK0HS4O9RqvfpYDGsGj2AtMcpth1?=
 =?us-ascii?Q?1J72U+V0oefHQGcN60l4rKyHd619+XeA4ngUg+dJCVXs7UlKqfQSkYOfUy44?=
 =?us-ascii?Q?AskBVctJyuddI/akYVMurBnWmWcBz5UqQrwAxnPqLm2bzO2g61TWngtMs8Lj?=
 =?us-ascii?Q?QuhIXMvoPZcVcnkiwsDbsyG28iaWMK2Gh+ymxfuVLmSAieG9SCJCGLrm1KKf?=
 =?us-ascii?Q?MmXpZvr2ZYpb4E8ttQB1avPjp/h9xpL5+cV0j6Z4d7gzOluJYSOd3SEkDsn7?=
 =?us-ascii?Q?HgVRrYvxAuBHpORGs/Ca8bWMXB2K0EViGYkxOPEYwUWH0qtrWwgKCo8F//N9?=
 =?us-ascii?Q?DpW+6Spq7VC3KH0F4MD4/VRUEzW1Pd19dl0QCLnsMVgSx2z2vLSV6Mcb1zUz?=
 =?us-ascii?Q?jHdQPXJ8ysgshG3c2HuZeGjM1Nfy+X97p1HmseyxSLZZ268XSgpqMmLOS4xC?=
 =?us-ascii?Q?f396twe2nkI6Ztj8fSkL+cF2QBCcsyNGR9YE0ZCEXH0rCJ21W3K6dIrd9CB7?=
 =?us-ascii?Q?MA/iH/KuG0ibjYBi7XFIXTDkvlvhMz/bLY85Bu5MQYMaF9vrXtGDy9y7RUc5?=
 =?us-ascii?Q?kUIwE9sPxRl9g2Q/CVf2Ecw71hIm7I3mkUIJOXd7Ym2tssvkLOvcgiWXIRMe?=
 =?us-ascii?Q?6tw2izJBgRukRdYymIdKuWck9wptmkinCemMp+pVXxLb1vGpSjbwbBRTjyjf?=
 =?us-ascii?Q?97L/U/uOIQfg6fNZc81NpEvhr0jwRh1xPmhgW9oetEiwcK1/j3+o+pu0mNAZ?=
 =?us-ascii?Q?hAHvkNxMKksDFTGyuKUwe3unWIkPhVmXNUemj8YqAebUAu5AoY7WS6LjbY3N?=
 =?us-ascii?Q?GliCH+XKo8438P10QNhgZsoWfsbn63HCB5j3oC+/FWVfsaZrGeCvmQrgZAaF?=
 =?us-ascii?Q?blrQbbEaeRcu67NT+fAR4nc1ztc5uWxQazNpTzEVSUbXeu33y5vI5mqsre/v?=
 =?us-ascii?Q?vC7t/vwCV7BI+Xj7xIZJEImqujyJ9BQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: c90f6f75-0590-46b1-8b07-08dee5fbfd7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 01:12:38.5240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LEhAPKQy4KfFpDFz8dwSUQkUlvzlnpZgs2SayGlIl4QV5qoSOoQJJJNn/dbSKcVARvRabVzyDatIatv9dAvSLFjtHkRYhDWD9PMVRwM0rO1gmHCwqrflNeU/Qv6TDRn0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1316


> stf_dphy_probe() enables runtime PM before getting the clock and reset
> controls, creating the PHY and registering the PHY provider. If any of th=
ose
> steps fails, probe returns with runtime PM still enabled.
>=20
> The driver also has no remove callback, so runtime PM is left enabled on
> driver unbind after a successful probe.
>=20
> Use devm_pm_runtime_enable() so runtime PM is disabled automatically on
> later probe failures and on driver unbind.
>=20
> Fixes: d3ab79553308 ("phy: starfive: Add mipi dphy tx support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Can Peng <pengcan@kylinos.cn>

Reviewed-by: Changhuang Liang <changhuang.liang@starfivetech.com>

> ---
>  drivers/phy/starfive/phy-jh7110-dphy-tx.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/phy/starfive/phy-jh7110-dphy-tx.c
> b/drivers/phy/starfive/phy-jh7110-dphy-tx.c
> index c64d1c91b130..181491a93807 100644
> --- a/drivers/phy/starfive/phy-jh7110-dphy-tx.c
> +++ b/drivers/phy/starfive/phy-jh7110-dphy-tx.c
> @@ -392,6 +392,7 @@ static int stf_dphy_probe(struct platform_device
> *pdev)  {
>  	struct phy_provider *phy_provider;
>  	struct stf_dphy *dphy;
> +	int ret;
>=20
>  	dphy =3D devm_kzalloc(&pdev->dev, sizeof(*dphy), GFP_KERNEL);
>  	if (!dphy)
> @@ -406,7 +407,9 @@ static int stf_dphy_probe(struct platform_device
> *pdev)
>  	if (IS_ERR(dphy->topsys))
>  		return PTR_ERR(dphy->topsys);
>=20
> -	pm_runtime_enable(&pdev->dev);
> +	ret =3D devm_pm_runtime_enable(&pdev->dev);
> +	if (ret)
> +		return ret;
>=20
>  	dphy->txesc_clk =3D devm_clk_get(&pdev->dev, "txesc");
>  	if (IS_ERR(dphy->txesc_clk))
> --
> 2.53.0

