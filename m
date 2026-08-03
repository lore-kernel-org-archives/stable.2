Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011025.outbound.protection.outlook.com [40.107.130.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB842E6CAB;
	Mon,  3 Aug 2026 02:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785725697; cv=fail; b=hJ1XzmXrMj4gDCsum89r/omqYeAMzRpq71QlYDCZyrLtLKSG3Blma/Lt7Z/lYukZzfAJ6cZy+CiU6RGd6mlIj26Sq19umw6300NehjAGhCfyMmweOJL3qMTbpWREH2cbPtq+P1AlW911ZXUlcAPoY88TM/vZdgdYO9FWdcF8HnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785725697; c=relaxed/simple;
	bh=hHI7Na0gqIwDUalWwtl7oOzuvYkmQdQgJy5gi8HYtd0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f/WCpQMp/yXk7bRqjmIWKSOcwCUnPkSqu4zq1lLqJp8qWBOpK1nyQWBmZqh7U9DLR8SjMG0G8FmaY9KfqyEQuE0/fYt0zscH5On4b1GZN9BILaWB7j/jFg4l2r+93oHN6TSh3Buks/kEG28eYv5SF5TjPmEiC4qr9JUIQRyX78M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dmv0aNFE; arc=fail smtp.client-ip=40.107.130.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dmv0aNFE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y638EFyWXoxCaMNzL9//JbKrEVcSPEqjO8NhLOv02POfA1hRWVwiIUPpLBxe8JFpe0QSmlF7URiQ4Fve1BwBkvPuFkINciUqmchliTRdufNnWkgyJrKjyxzFVMwx0g5cnmv7cRjcoywMi/oVC90GrLRmdOgZZoSdNQSVEK7Ufvr+XscmZJpn2YJ1IyIor2peVl2KDeeV4VfD87dmHHyt7K6T4uTORjsUhVNi33O4pAz5vap6sjMkmGvALbbgAo68hk2ThLXT6mcluKoKlaiyrBlfb0G0SnXTBQLVPRjWoKStIJxtGrRnQgMcWdbw2tvTULXX9mNOvN63SaSI/1ZyoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqTOQ4SbBzPPZT0Ly+V5lA1PDtiCCLUDu6Ggb+erOo8=;
 b=AfZddQju2Rowsp6GjEHmDHgrLBInW8UmkybJEXowBQ635rMdWpB7sIRYG1rtnx+l1AZcoKwlnBpt08MoYEtq4ScqZ8h/0AYP3kAfhufh9Imjb2pMnpUJLgoYt/NyH8oYqKUBoPnBnYxVSuMAwlAtbBHIvYPhFuDqgYW+3qKAcWnXgQEjONB8PzlAxxqZOp5248xOmCsL+W5MIKw9GCjOSPV4Fbehg44EiTQhadkYkgrdS+U44fmgbsg9uSfqiZQpcYwY3MIm+Rh4Kcv2buXeprpl7Js9a2wXJ9q91G+Q/NJKJiWp9arkTzYCgsVmENsuJpfbtmSM1RRfRnhojSWlWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqTOQ4SbBzPPZT0Ly+V5lA1PDtiCCLUDu6Ggb+erOo8=;
 b=Dmv0aNFEfAr9CNjs3ho5z1p+4UoZ5NRc+v7HRgBpMR1oVG0FRnAIyCeu4s/WWZIK+1uAnn0KYy4u/PxhFavJvIAeGaX6Xwxjsihnr3qHevK3GGqiO8HqnaJYLyChEsMuAxY/aO+3dbzudjD7OtdzgQzYvfOmmbKBm9rckDwXCbtj2Nz6aYg7IyON6Ed6zglt980plbag7cKhWZ4lfYla5p4cD828d/u6a7cUjfVPgBX6CmCorZCgM/FhD4VpJ7/WygJTffUYhBHenlImvwgI8rz3Z3YljdBUEXxTe67zk7ZhG5qqVrB2+GSZ3U+xG2IY4oWdjZttUboqSe52b/5pMw==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by DBBPR04MB7818.eurprd04.prod.outlook.com
 (2603:10a6:10:1f2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 02:54:52 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 02:54:52 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Rudi Heitbaum <rudi@heitbaum.com>, Lucas Stach <l.stach@pengutronix.de>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] PCI: imx6: Avoid dereferencing a NULL clock name
Thread-Topic: [PATCH] PCI: imx6: Avoid dereferencing a NULL clock name
Thread-Index: AQHdIm1w5va/16ikG0S9QOXPkrx3PraLnaHg
Date: Mon, 3 Aug 2026 02:54:52 +0000
Message-ID:
 <GV2PR04MB120195449378280CCAF9503328CD52@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <am8iBwJSEhYhWTqk@6cfee64030a6>
In-Reply-To: <am8iBwJSEhYhWTqk@6cfee64030a6>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|DBBPR04MB7818:EE_
x-ms-office365-filtering-correlation-id: 48eef8b4-8205-4be2-b15f-08def10a9727
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|23010399003|366016|18002099003|22082099003|38070700021|6133799003|56012099006|11063799006|10067099003;
x-microsoft-antispam-message-info:
 fe0axc/vhPcO9rcl32zr0HXtiB0z42nHP0uiNjbBvMyDcRsFIbCSAzWR7NFymhnANyOz0TSsZ1rVcJqDt8XgxaKpla6OzoOEyA8gyLOFsqh8UASqu41+z5oV82y2k7BM5ID4utTkQKDc0sFYXxczzD2dloxUtheNBIJV0ERNNlFmJyVjLXKAG3pcuQvddLCGyMArm4pO86ocv9A6sqWfnmlbBm12nYy6SVxNSrWcuiGQmdxlbOZ1sHgFudljjPkJDTfzI7C3Zyssf7OKqq7TimGtup2Fpy4UnBmKp5XhbQOjR3Xno3o2aUgKIm0IIpuh14THiU0WyXKG1aWyhDYTTYqiAyNL9UYBYviCsiKNgbYR8BXswx5YzU6+YS3DiX9OeHwTiJ3wENh0LtUzDAjjJzsKLADnXhpUvgsdXnjsXiI6EiAMu+EVGxYRYvA8TtxtYjF516sFfoKPn7GyQy2O1t3hvasKeZYEsLoD+fRWBIf4Lsk3IzIvmh8LKwQBNwmWygPd9bowNE2JUXUVBEveOvL5NU+4LhtXwuC1QNWXjYXjVANRBeUtoDtVYVuvepUgPpbXKHS0e7QYlmZcJ8IscnRQTfezv0YeNNtfcVZyZfK5cbxNDfxrWXOwrbQt/jA70K3r+QpBenYO/lAhh0pIS5hCidI/ZakCb0BhpRfMEEe0w9F8UwtaoH6VqV5CUBFltFOFCkXl+Y5x2EfPiEsEwCw2lG0A3xwH74n6wzO8LD8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(6133799003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?CN2DHGti+tdqcqKhw/Kp7/qYtPwwcJnXnkWn/ikJM9vS2Bm+8BzzOjqYf2?=
 =?iso-8859-2?Q?76ytQDK77pu3Odg3vehAsRE1henRhfR8L9TX9rEkiK2vDv7M1XXO4Glmjd?=
 =?iso-8859-2?Q?ikWSrWKy3X986JfUxfgBeavp2NWmeJhIiWuT2Lx8cePEp26yiIvM0Nss3a?=
 =?iso-8859-2?Q?a4dNzrZ1zGcpHDlGBrB9bbolMnUN7W6BjpobeKQTDXzUICTgK2bfPSUTn0?=
 =?iso-8859-2?Q?hjMVH9P5u5JmikVpoe0NcplZffDik5qs8icV3MIk0TiDr3u3t3ie76QRCM?=
 =?iso-8859-2?Q?rimkVDIKxQWPydkfMHqHeYv/aHiQpaDo9aFnQyMg+x+l2YrvRQzfv2mFz7?=
 =?iso-8859-2?Q?w5xWQfw8ouLbjDVMeRmFXICo5W7zxRVtJApB6GJTdLPA9stDI8GhRrJynL?=
 =?iso-8859-2?Q?dIHY4tDqy7SNUX0isc7nhdu9vevJMK+gEP73SCu4EBehNr85v3piYB/zlZ?=
 =?iso-8859-2?Q?PnuGAOlRVmYAjoVBj5ra3xg1adB1kaQUYUGcTPNPq8WtQBZ3uHZHdjBxkx?=
 =?iso-8859-2?Q?86SPayNLAVxRNdNO2Ek9Bnjedl4iIHqUUcdzRGbOphAjghAQdeSrcVB4uJ?=
 =?iso-8859-2?Q?zch51S6CIhS4nWqdaKZrZiifGgw9cNO9RyG5o2pcgsOd8auF9Ukyp3k0G8?=
 =?iso-8859-2?Q?cYIihXuPl2wZDhKiBl7p9wDIu//VyqflMStxXhyV8BYqPwNPkbKEp9KAXU?=
 =?iso-8859-2?Q?H5Ao/L5GDUjkwuRM0VRzPPP+mmWYZKCY6O0F0WCPbZY7/SscZjK0F4nilT?=
 =?iso-8859-2?Q?oPdKQ7kMIYYJcpFZX3iTiWQzDyuyGhlJdkU9Vv3ICbXjAQG93e6a9YeqlF?=
 =?iso-8859-2?Q?j45GdYk/JLTOm9mg+CoPqShp5w9uVUTAT9G1wJHLHJYGkF5hIOdblnXUez?=
 =?iso-8859-2?Q?c6nEjkEjOqpwVNeKK2ZUTfA3ki+OFSLT29KMxOS7B8mTcwQmnk50QIXIv+?=
 =?iso-8859-2?Q?rhs9OM9nlKHCdoaHVo4PQte/kLhbVIZnDhx5HIIhvJj+wTUHdwuDBVPVXW?=
 =?iso-8859-2?Q?r88oBZHF5IzTCve8cSOuuLjbfVshedVoLC2IZY3EqEhlr9k4A3PNtFeYFg?=
 =?iso-8859-2?Q?jkd5yuWIYL43UVtKtGRqnRdwe0BuHhB8AYOIK3PMvhlejMkuvN4RK6Fx28?=
 =?iso-8859-2?Q?4ETgbdh59Ug5t3IneCTnwsPKGG5xaa+MMaFaQTDvVvAXuNzD9PKRePG0lm?=
 =?iso-8859-2?Q?AEulbSYdqMh3/6h8YpgLtmBdZZ4m92t7Rt+H/NO12EhIrREyQEN4ZcMxJJ?=
 =?iso-8859-2?Q?ktLZVe9b4749Ig1I81qDQMQh7bMnwbBU2jyh+Kaf+Ov77KcyHpTQ8M6i9S?=
 =?iso-8859-2?Q?fuIrulzSZHwo/Vj592b/xy43KPLg+UvlRjH4y4lCXYLu4eidXezJ+wIf5f?=
 =?iso-8859-2?Q?pi84ebWFYLGGtyAkzamMRcUkxRE6YgxjFW3eKQh/fJ/iPq58yq31RMK0zY?=
 =?iso-8859-2?Q?b0pzLzQm32zZaO4HV0Yq9YDcIkMD14KUfasDNGFj55wMK9/mrPfUtWhFE0?=
 =?iso-8859-2?Q?tMA6dqbaZeamDsE8EWcEuWQkzXPKmCFRqTNrWBv3LH5KgxL+pGjBNiARsR?=
 =?iso-8859-2?Q?qPo063sAeHbGxkZ+vXEvm5B3PdJUYIXC+zzY4NKFqEUpNhX+MnC+3G81GD?=
 =?iso-8859-2?Q?9urNnuUOsMb1GsVj3m4HeHq44i1Qi3Uh1FvMMw3S6Wy557FIf0HJI79Dyr?=
 =?iso-8859-2?Q?q4Ew6Y396skI9s1hiMLRkzWPxXkfaw0ve2JR5oiOd7YGR3z2lMzVv4HtOL?=
 =?iso-8859-2?Q?l2/sWVOlHAShRDcS3jPhBWwC+1BBcEiHkNPS61wd0ud/Xj?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 48eef8b4-8205-4be2-b15f-08def10a9727
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 02:54:52.0867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S1WVD4ShAonQ+dFXH4ywnrD9V8T4IsCgM6a6N2UOD5vlIgK0weyKJZxvc8OKGSt2fah8+JkTpvdjmj+5AdU8qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7818

> -----Original Message-----
> From: Rudi Heitbaum <rudi@heitbaum.com>
> Sent: Sunday, August 2, 2026 6:55 PM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>; Lucas Stach
> <l.stach@pengutronix.de>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>; Krzysztof Wilczy=F1ski
> <kwilczynski@kernel.org>; Manivannan Sadhasivam <mani@kernel.org>; Rob
> Herring <robh@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; linux-
> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; imx@lists.linu=
x.dev;
> linux-kernel@vger.kernel.org; stable@vger.kernel.org; rudi@heitbaum.com
> Subject: [PATCH] PCI: imx6: Avoid dereferencing a NULL clock name
>=20
> [You don't often get email from rudi@heitbaum.com. Learn why this is impo=
rtant
> at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> of_clk_bulk_get() leaves clk_bulk_data::id as NULL for every clock that h=
as no
> matching entry in "clock-names", which is legal: a node may list more "cl=
ocks"
> phandles than it names. The extref scan dereferences that id unconditiona=
lly, so
> such a node oopses during probe.
>=20
> Check clk_bulk_data::id before dereferencing it.
>=20
> Fixes: d8574ce57d76 ("PCI: imx6: Add external reference clock input mode
> support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
Good catch.
This isn't triggered in my daily tests, but the fix is correct.
Thanks for this fix.
Acked-by: Richard Zhu <hongxing.zhu@nxp.com>

Best Regards
Richard Zhu
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> b/drivers/pci/controller/dwc/pci-imx6.c
> index f7389b5437df..dcdeba1856f7 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1831,7 +1831,8 @@ static int imx_pcie_probe(struct platform_device
> *pdev)
>                 return dev_err_probe(dev, imx_pcie->num_clks,
>                                      "failed to get clocks\n");
>         for (i =3D 0; i < imx_pcie->num_clks; i++)
> -               if (strncmp(imx_pcie->clks[i].id, "extref", 6) =3D=3D 0)
> +               if (imx_pcie->clks[i].id &&
> +                   strncmp(imx_pcie->clks[i].id, "extref", 6) =3D=3D 0)
>                         imx_pcie->enable_ext_refclk =3D true;
>=20
>         if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {
> --
> 2.53.0

