Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264FF13E41A;
	Mon,  6 Jul 2026 03:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783307171; cv=fail; b=WF68bHB0joiMVE+NDX4ZN9717+2kJ1RYnfxLCAL4N2bFD4M9Ad+0G3eN62x0516armw1uk7eJ6hsz9nJinMhQ3D3nTik0t+mbtV3kejMNqIQj7dtaHQAjYDWqsQ3gGH4kUnkHmt9yaOWh364dB5VAXRUk5Z0LimiIs542brJfP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783307171; c=relaxed/simple;
	bh=zwrSEDy7cCLFcAaLVHDssis/m3mV2pPujI/rAS6F9ps=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cLS9/62842V0PtCsIaHKTI2IQtF+5/2se157msbNUfelhNXY9kZeT0ntXmAVnIdivHqV+OMLUQUsz4qgJgC+Vnt1d1Bl0js7PzuNYn60rYcNxgdVJTlZzQKRp9FkVTPSvsxphxPC09AD41kSYDbC95MQ4sTOiENgZt1hyVJu2Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hn4dd3l1; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hn4dd3l1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTgERx2UVjr1p6zLQzITvrIJz5d/VCCvKCkioaHdOLakWJsL87bLYNyWIEvr33K4l4qoK0YDdyX1LEDLVFZMT37kYq+RZ87yUwo4M+js2y08B/Unmrjr+mdn1qKH7JMlCxbt4tZRDJQmzLWHJrIdnKK7ZKm4pvuF5RfvEDhTHwFjAvgWpnx3wgIQ3hxLRnvC6idfY/9qgcFNvwBfsm3Cv1RGF9glmujfbguXasLc69JtYyGzq3dOklpe+i//PdfSrKrtQwYG8/lCG7jj2ghmF6a7zvCtzbWHJT45GaX5NZEufdnlDxxNyv2Lwb1YRFQqXd6FtV0eU37qVyCYA0zLjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8acSCERfeNRvBwWUOROGEsUqOjNaclZSY8CaY/yVZQ=;
 b=RHC/Buom2O/ZnhXHcLZYUYhsiXCXGm1rV0EPiRDaK7PS7xVNqcGnxERhshH9lPnGA68HdSgkFBRCig82Kph/7yWRL/LSOtU7vrA3Wgd9B9/2H8tnDD4OXDxYb/mOHIzHe6ehu8N2RweWuk3EQQSKNOuS0boG/tTD4PfrSOvugFnxc7xeON/Iv27u0wHcP3naR4i71pc/jlHf/kZMe5OML8iKtvfxw62V7YmnJll+Gh6uHWi/Q9cVG12xYphx2sbJmMWBpwky0l/fuyYjqNaTlhVxXEWCWVd1SY6jnaLAAOfKm7iMLuHS7sffQcuts0xGUlxDIwTDkuIjiIsv3qk8LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8acSCERfeNRvBwWUOROGEsUqOjNaclZSY8CaY/yVZQ=;
 b=hn4dd3l1Wa8Az9qfYTTllxOScCjUzyR+42jiH6nsq85guG+OaGQ/xPF1bM+DmikIn4h2JyCa6TEr32nFNPoMtGLGGBbm4Bfjok11USL1+Daj37JBMNeFn1LWh54I1u2fjYwOW6GjjSncYGl4giDtiN51b7l3B+ed69NQvbkeb/SCZ7PBihEL8jxFBYiIWSEzyQHMX4hcP17fAT7/0Q++UwiknU3zIXMgk9aWEYQxq7RlooWrsfa+K1IVX8V94XW6YtnQPp+0XJC4xIxYTk43N9vM7T6zj6xLloiapdZsGfUxj123k8PIJ4xe3O/4QCmzSOcKHHSMMVUWVc8JKZE0sw==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by VE1PR04MB7376.eurprd04.prod.outlook.com
 (2603:10a6:800:1a0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 03:06:05 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 03:06:05 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Soeren Moch <smoch@web.de>, Manivannan Sadhasivam <mani@kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Manivannan Sadhasivam
	<mani@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Bjorn Helgaas
	<bhelgaas@google.com>, Frank Li <frank.li@nxp.com>, Fabio Estevam
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: imx6: Keep Root Port MSI capability also for i.MX6Q
Thread-Topic: [PATCH] PCI: imx6: Keep Root Port MSI capability also for i.MX6Q
Thread-Index: AQHc1j02pL1yKLxXyk+WT7EvKyovarXzvQ/QgGtSuQCAASvw0A==
Date: Mon, 6 Jul 2026 03:06:05 +0000
Message-ID:
 <GV2PR04MB12019F9FDB33AB138A45B74388CF12@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260427115804.134231-1-smoch@web.de>
 <AM0PR04MB5220EBE4BF61ECBFAF162A4D8C372@AM0PR04MB5220.eurprd04.prod.outlook.com>
 <ba9ff61d-8840-48c1-828a-842ab0956e3b@web.de>
In-Reply-To: <ba9ff61d-8840-48c1-828a-842ab0956e3b@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|VE1PR04MB7376:EE_
x-ms-office365-filtering-correlation-id: d735fe0e-17bf-455b-b6cd-08dedb0b84df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|23010399003|366016|18002099003|22082099003|13003099007|38070700021|6133799003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 DzYhU8hgdG3K0rpSzMDoe6U73QseFX1BlCRuz4WKMKFCe9SIq9MZssQVqn+bJc8QZIea1IdZApnY3+s1CH92wBrM6GQuiDz6P8ZZxPYLaPQOY7UKc+ytExaZXFiscmbG3S+rf6lkJ9aU1jj1LYECJsJTBO5v/Ft94s8bOUPlx05kgOQ4yrBhs97w2GFPwQihwwc8bZk7ORu+aJNB9GAHoxdVK6SS5EqRKWonHQPYu5A6PAacsJ1Aoyxhos3HmxEIzOsPZsUv4XTQN6riloEf7L+/8xYx0g8M7c8zWfY6pzFcfpztwCNKpNprAIRMStSUUbJL+jE16PyE9ZGiecFDw8if94uUM0GPpSHbVpGJzapEHAShx6qb2z/cTNnxSrgn4VIqnFE1tAllaFCAKk8OGrSfu3MOdSelrfzbZ/v2HYMtWCZ5m3tWB9pX14xwEiiBSJltBAYVD5T3GvTcyymMY0JFMmjqVSmCeQpiDMsDYHoRLahdjiwHZoTTXXii9+f6ejG2AWKlAUvGE6qshvLvZMvccFMT3f5S8qoaUePZfuGjB10GYaSfPyF92hLYWA82cPnV7f+d91K02NtHv9gMYUX5s3CejuGVuNO+tqXdL8ZUdN0iq8FAKVxlyCaGKJABjg9Kk25FahFqhuT156QvzNmIsBhUQzJztM7gRQaigbdd5uWsEY9eSGkldKcC7N4ImXtppBQyKbMybxYA0jgaPLfsK2l6TMMSAUSr5qN6qbM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(23010399003)(366016)(18002099003)(22082099003)(13003099007)(38070700021)(6133799003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+eKixIGeKAoxw2IpzEKXKFBeNntWl+ezP9dizVcLe5c2PP5N4MiKqvcdUndA?=
 =?us-ascii?Q?gqV6jDBX2dxBBLCLFxTxmatvQa8VVcdaiwCrzIYRrmcWbVrRHKDWSnt0vWbi?=
 =?us-ascii?Q?W76eGEl24BDL9k8WgKeNf0uinf3Xs2OEBLhcktwztHRf43CJA9damDNFDTBV?=
 =?us-ascii?Q?O1ZdpzynbIAvIEZFMwVjsnH8eKwQfD1Nrx1cIXQdfLm6CipX8H3l3gdKQGzf?=
 =?us-ascii?Q?JlROkZz5XE8Nci1eokBpXU97a0mmoW33y7O2Wr52D8vrvsVTjl1d/B0wb8I9?=
 =?us-ascii?Q?ADMWz3jsDpL/GjeOVFd0mDRP0/OHpO9p9o5XJs/H5u5TDyNmzfQqh53EACpx?=
 =?us-ascii?Q?6iRJ0jt/Iys8zZn/hrQDrNj1Tni3uJrISBolvKkJ+Pmn9soJEAqpf/eBSgX0?=
 =?us-ascii?Q?YSR2Dyq1Tt6oKYpLW6lQi9QZWcqY3OPVQrcVhKOJELutRUZYH8SFudrXg454?=
 =?us-ascii?Q?7ma8ZqVc5YJeHIQxQTmegDYIB3HojEkUd9W/wgTa9fOpmtzmOXkQysxu7xSw?=
 =?us-ascii?Q?d02LTULmt7KQHWNu7T9NRYTBoimTrz7LQgTuSB7blsDMn1Hnd1YAGSn0yJQM?=
 =?us-ascii?Q?jCkFZP6iRB0hnKRgk5ZHJTLwgZ2vm/+7GUJIm0MHQoXpQne4OjEL8+Lkd01k?=
 =?us-ascii?Q?P90Was56KNjaY7uaKVOnzAPA0cEJaM7qfrU0J7RJDEW3Zp9xqTg9ZjPWCUlp?=
 =?us-ascii?Q?+H9dgnGMDQ86MzMrbSleVA4rYw/c1+GDtyxmQFTg3pT03mvRlMZeJdhcMfyt?=
 =?us-ascii?Q?JnnDua+ictWPF8IfqTJ3/irEBhFG7UXXlKUhro/dsl+QxQSDznQpgqJGXsIL?=
 =?us-ascii?Q?d+g/8klvuc5nfviIVossH1H/l7lonSWh+K2Ebj28kYRLIfgPOdVSyNfzOpaq?=
 =?us-ascii?Q?tIpcHq22Ka9IeF3zUEtL/yhP4WOSZIxeM1qQYw106waxRXpcp/yroHQ3gUCR?=
 =?us-ascii?Q?jjFQubauLB7p1OCkPFw/6jZSNREfMs3SF/Rh/NDdoD3ekgVb4Khc81p1TcMe?=
 =?us-ascii?Q?PZBurns0o0XZaIortAd3L4W1zOo0mutT/ar8S0uYBXgGQXvIQiAc5oi9D2bs?=
 =?us-ascii?Q?WI4j2N281TRayl43O444YS/2u9JI/F16nBQ2apSL30uDaYq84h9AfiPxLn71?=
 =?us-ascii?Q?cKU/yVH2nEr+LIdnIYL8yCKvsEHVe/Jb5GZwJiZFTCWNPBN8lSGVOJjtoA4w?=
 =?us-ascii?Q?D0O2B61AszKBVzQgmTYe29HsLWL2m60nf4iOhScHyvPHxIkwUuUO5Y26ETDH?=
 =?us-ascii?Q?6KBrPbXCChyioH3CcUSe0JUHd6m0QCLV94kETtVVxY4/07mvV2k8ohVGWeSN?=
 =?us-ascii?Q?xIfFj9Ju7+ZUmXJgMdbCjmUmFqp3j7lOGeoIr2nWoNU8W2GyK6+bP1zqrVKr?=
 =?us-ascii?Q?teKs1V/DYQQ3FkV969oXz0xZYQpACxoihOyB49v2aPNOHQM4VrORrnkMOt3j?=
 =?us-ascii?Q?aJ3BmMCkNLWPttk8wQTplwcqlrtjB7CPkU/Ww7xMG5flXfok6m+qkGrgX9t5?=
 =?us-ascii?Q?1ppjjb5h3Y2Fb1Wo1V9RKLVjckDR0vN6WHR9J8Fjm1zr+GZyBShd5AoYGn2E?=
 =?us-ascii?Q?I47sHGfmI5DGKLDvEJWe0kOr1uMlJGEw1UglfdDXL6W+5iVrZu1yN9HJDMRS?=
 =?us-ascii?Q?z5Y5yR6QQ1ZhI6bIqFyEC/CkQV7PfKMIQxaqINX7nCbX2IEh32hSdDhkrd+B?=
 =?us-ascii?Q?X8xQRuarrIsCwn9Mci9+hQ9G0U9lQywrmtm8JroFogc1e8wb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d735fe0e-17bf-455b-b6cd-08dedb0b84df
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 03:06:05.3076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSf1ahQWkVNTNPVTbM7btCXvCRjPdg+fRxtlFL+bRlPI4OrtT9BJvq2aFCN8Th1CNKfAeGyGObSGjtZiPR46uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7376

> -----Original Message-----
> From: Soeren Moch <smoch@web.de>
> Sent: Sunday, July 5, 2026 5:11 PM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>
> Cc: stable@vger.kernel.org; Manivannan Sadhasivam <mani@kernel.org>; Luca=
s
> Stach <l.stach@pengutronix.de>; Bjorn Helgaas <bhelgaas@google.com>; Fran=
k
> Li <frank.li@nxp.com>; Fabio Estevam <festevam@gmail.com>; linux-
> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; imx@lists.linu=
x.dev;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] PCI: imx6: Keep Root Port MSI capability also for i.=
MX6Q
>=20
> [You don't often get email from smoch@web.de. Learn why this is important=
 at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> On 28.04.26 04:19, Hongxing Zhu wrote:
> >> -----Original Message-----
> >> From: Soeren Moch <smoch@web.de>
> >> Sent: Monday, April 27, 2026 7:58 PM
> >> To: Hongxing Zhu <hongxing.zhu@nxp.com>
> >> Cc: Soeren Moch <smoch@web.de>; stable@vger.kernel.org; Manivannan
> >> Sadhasivam <mani@kernel.org>; Lucas Stach <l.stach@pengutronix.de>;
> >> Bjorn Helgaas <bhelgaas@google.com>; Frank Li <frank.li@nxp.com>;
> >> Fabio Estevam <festevam@gmail.com>; linux-pci@vger.kernel.org;
> >> linux-arm- kernel@lists.infradead.org; imx@lists.linux.dev;
> >> linux-kernel@vger.kernel.org
> >> Subject: [PATCH] PCI: imx6: Keep Root Port MSI capability also for
> >> i.MX6Q
> >>
> >> [You don't often get email from smoch@web.de. Learn why this is
> >> important at https://aka.ms/LearnAboutSenderIdentification ]
> >>
> >> Also on the NXP i.MX6Q chipset MSIs from the endpoints won't be
> >> received by the iMSI-RX MSI controller if the Root Port MSI capability=
 is
> disabled.
> >>
> >> Even though the Root Port MSIs won't be received by the iMSI-RX
> >> controller due to design, this chipset has some weird hardware bug
> >> that prevents the endpoint MSIs from reaching when the Root Port MSI
> capability is disabled.
> >>
> >> Hence, always keep the Root Port MSI capability for this chipset.
> >>
> >> Note that by keeping Root Port MSI capability, Root Port MSIs such as
> >> AER, PME and others won't be received by default. So users need to
> >> use workarounds such as passing 'pcie_pme=3Dnomsi' cmdline param.
> >>
> >> Fixes: 3a4e8302e72f ("PCI: imx6: Keep Root Port MSI capability with
> >> iMSI-RX to work around hardware bug")
> >> Cc: <stable@vger.kernel.org> # 7.0.x
> >> Signed-off-by: Soeren Moch <smoch@web.de>
> > Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
>=20
> This patch is a regression fix for linux-7.0.
> It is still not part of linux-7.2-rc1 .
>=20
> Can I do something to get this merged, is something still missing from my=
 side?
Maybe Mani missed this fix in previous merge window.
Hi Mani:
Can you help to take look at this minor fix patch?

Best Regards
Richard Zhu
>=20
> Thanks,
> Soeren
>=20
> >
> > Best Regards
> > Richard Zhu
> >> ---
> >> Cc: Manivannan Sadhasivam <mani@kernel.org>
> >> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> >> Cc: Lucas Stach <l.stach@pengutronix.de>
> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> Cc: Frank Li <Frank.Li@nxp.com>
> >> Cc: Fabio Estevam <festevam@gmail.com>
> >> Cc: linux-pci@vger.kernel.org
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: imx@lists.linux.dev
> >> Cc: linux-kernel@vger.kernel.org
> >>
> >> Tested on a tbs2910 board [1]
> >> [1] arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
> >> ---
> >>   drivers/pci/controller/dwc/pci-imx6.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> >> b/drivers/pci/controller/dwc/pci-imx6.c
> >> index 6d6a1688e7eb..3d461bdef967 100644
> >> --- a/drivers/pci/controller/dwc/pci-imx6.c
> >> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> >> @@ -1865,7 +1865,8 @@ static const struct imx_pcie_drvdata drvdata[] =
=3D {
> >>                  .flags =3D IMX_PCIE_FLAG_IMX_PHY |
> >>                           IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
> >>                           IMX_PCIE_FLAG_BROKEN_SUSPEND |
> >> -                        IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
> >> +                        IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
> >> +                        IMX_PCIE_FLAG_KEEP_MSI_CAP,
> >>                  .dbi_length =3D 0x200,
> >>                  .gpr =3D "fsl,imx6q-iomuxc-gpr",
> >>                  .ltssm_off =3D IOMUXC_GPR12,
> >> --
> >> 2.43.0
> >

