Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794224749;
	b=qshAK4M7QdamwwyoVtTk0A2jTlTO3v0Zpg2Us0PvFN/8NQguUkRStSuklNSEs/az2HtT
	 nU1vIgEEFWDWxpw6NxmoRS3VvO4V9Oh6RGPBWP6LYAub/GQJryPKRUBrQzM1zFveUBZ6L
	 s5OH/2qogDThjyvxkbyWRxeR+EJIpKdkUDpl6EnXwTN9XzG65Zzkk+L9giWbVLNUHNSUd
	 7aT3mcyMwAwvBfGXXpJMQMl1LUg944/oXhsDqgky5G2kGbqqf3OIAjkS1hUdoXRpkzB9p
	 TAF4OsUbbysBD30B0nlgDmIJxi3y0CUjt/AjzANdEvItsLQLQU19Mef3Nm9nhIIx0Gw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224749;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=pPrQZxX6D5w2FDmdd8S9NYIGPfddhMKHDzOIXRyQnk4=;
	b=T4b75o5E8ZxVm8Flw7NderQCiHN50kj45P3sDLvWwyaLGcUDASTGOkFhlsBt+ooctAnV
	 3So+dv771ugd7tO28ZvjG4xdZENRlNDYL4wqkqGiIYT+7kUCWgftOWSd87MxuAeBixyK9
	 F6G/khqSuEN7DcZUavzgF0moWNCJjx7hNyUdKTn0bA1LA6jiY9BTKtJMTKwtnYK3e1IyA
	 Onr8unPC8xPUacoaEk19sckoljMAuCkTzKKClCWw7NZkFxEmt8cskrXb65oIQitB0XAvt
	 7XtAkxY5UpmDnVGV1Gey9wyjZmXIucorGzOyJrHeMIhLb/WiaqzR9CUSjs6R9mo5iIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=GRkKOkDr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.9
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010009.outbound.protection.outlook.com [52.101.229.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661E8606A323;
	Mon,  9 Nov 2026 11:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 661E8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=GRkKOkDr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXdfxfyag7uRngajEN9MTkSKycmiD3OY1n4LKXdKqI7fEnTMUuhJDVmElCBGdeU7KcvaAmqE9RexfE3sppQGXVw7UCyNUZ8DH9d5eOEbPqqKkivEc7KFN2ntusJqb+6IAvKJeMF/uaCNpkPjSgFw9YDs8pBXP1QycAvVOrmcOrSEdikbcQImHJzdtx2p0K6DcK4kiFGopNV9nKWIvJ6w7VQor9t6MIJ6llXV2EbiQPFLXHxIE1wd8DB+aFyv2VEDuz61nRjsR/a2YvQth8ZNds2nC5CjWuOX/tsS6GfXfbwZhYMl8KmWznFob71VvuYwkMYrhwMX/D93QiZFe7Tseg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPrQZxX6D5w2FDmdd8S9NYIGPfddhMKHDzOIXRyQnk4=;
 b=UEdNRyh0PzYr33f2dnv+WUF8W5Yxce81LrIAq8nr5c0ACXTnFPhTZV38vHbnkXsKbc6hQuJuIXK2SfSIIZLGwVP2ychPW8JWnx0GAUdZOK0kvwhIu0i4u/JuoVKmkyqikqEn/QU3Ojj9bnSqeaLjI/hGhAhlUW0GORbFkuadwdatJFlwDsW5u+NXhWPbdv9J2b+q6zijWhroOfUvbIaPM3yaoBmFvYj906Es+6DWllAPpNghfKV91w0pgAmeQAYEorJYyAXqEFxzrKjQYBtC4kLXWj1GySeBpbeGWThiM0P+APc5CA6PT06SUlVtrLJ/O0TA8bUXL3NeZ4j/nZR2GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPrQZxX6D5w2FDmdd8S9NYIGPfddhMKHDzOIXRyQnk4=;
 b=GRkKOkDrSh8UisMuvjBsbd7WCUn3wH9tv4fHq2ENtbTpfcRRiwyk80if8GMLue/VAoJ6JUTuzuuGNr3QRtjSwNhRHI3VHkPxNHu0UCLBqJ+iZ26J3Jvj1Dqwl5x2CFb/1PM1gkgrvpS/zyW0i0N/OUiDVYazyAXjydb/zG58ZJc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYVPR01MB11200.jpnprd01.prod.outlook.com (2603:1096:400:364::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 11:45:45 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 11:45:44 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: hyunjungg <hj351016@gmail.com>, Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>
CC: Vinod Koul <vkoul@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] phy: rcar-gen3-usb2: cancel OTG work on unbind to
 avoid use-after-free
Thread-Topic: [PATCH v2] phy: rcar-gen3-usb2: cancel OTG work on unbind to
 avoid use-after-free
Thread-Index: AQHdcD3tdwfXnl4oFUKkoRivivoQjLclnj8Q
Date: Mon, 9 Nov 2026 11:45:44 +0000
Message-ID:
 <TY3PR01MB113466938179F6797D7406F0B86732@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261109113121.1534929-1-hj351016@gmail.com>
In-Reply-To: <20261109113121.1534929-1-hj351016@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYVPR01MB11200:EE_
x-ms-office365-filtering-correlation-id: 70195f1d-3d7f-45c2-3c16-08df3e56fd51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|10067099003|38070700021|5023799004|11063799006|261028144727099003|261102123227099003|261022105027099003|261022075727099003|56012099006|261021121427099003|261026140227099003|261009223027099003;
x-microsoft-antispam-message-info:
 kQwDrJ3mjisNnJ/Sh1rwtzpfIfDhSwwH2SXwGGGUTG/oOIR3qBg9ICqJWSkFeLlxklyE4PRzLSkUIXj4xukNFESf2v4Zbj/Op1qJNPjEL1h02Bydw/pNx/Svnn0TsYjVjURNsJcFawhFkL4YWZbAkKfb8jkdFwuLvlSc+wzNdfg/B9YhwPaNfqYeaXUixMuTbX2tnYV05ZWW6fm0pgUedAmRdki/jIvne2f9sZMpnS5Bsdk/Xz4mCpcPaJZ2Vm3ayVVI8ZstBEebgAR/02YrUK6xqnb/KgkPpMuVkNTIBfW3OwD6cDzS58kvpqNSD5SjZRiet5VxwiU1vzWFP18pMs6rl1GiQSrYbutVfFeaZi5kAT+ONT4nJutUCeduoUwEHJpjBuuKcKbETNIAP7xbFQLHdZCcbdB9rmnNF6cyudvwfT09NevperJoOAxfeZCesNhMv8ZlvCxXGlCcdeF53oMuvdpawX7Ky8zDuB5XAIooIqnMoFh0kzTnT7r2lbRMGe42TVuKOu41wOQdVO5kf5U5/chiQ9i9Sv303P4+B9uXv7H08slrvRL7ebm794ItD1UvbtLWPRr2wzFslw8Memmopvp2R+PqgJcsZkLUIaaN5RyVC6vbrQqyyCzAdfuRJx8zBDTgARncWLkPybzOBDTN/axWAN4+hhsMLjHN6Ps6Al+jVgqVYStOve2lWwohcLM4rRfkX1+EpuNpsI/cdsRPDlbl1pvCWcsXfSeinHU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(38070700021)(5023799004)(11063799006)(261028144727099003)(261102123227099003)(261022105027099003)(261022075727099003)(56012099006)(261021121427099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hhkTZJt0ZNVXnkBMDpQ+2e9AteVF2kWJOSeL+8Ey8wCE8kIZvhST2j7NaTDi?=
 =?us-ascii?Q?1VNdFR6b6NkQ/k3VYrlnZi9cLGh58X61N0QfRL/pnttc6C7v8wkAfZbkSqUv?=
 =?us-ascii?Q?eTYF8LUQLjt3h8UZQER2qb9tP59yrmLWbc21lm7Jjsb5A0qaIR7rSmeQPyMY?=
 =?us-ascii?Q?B0jdZ86Bn9LbRddj/HTMx7dePsD/pJUM2+RcFNfZKpMQuzTkU6dOgQKLwjTz?=
 =?us-ascii?Q?xiSVI8Redhsl1qaUaYb3gfMiEFhmHM67WJ84UabaDLsQzwSzKBIYllB/rkHR?=
 =?us-ascii?Q?LvMJdNzJEDQldgPvse60jlebKRv0kKMpJcoR/woKUnovEDp9FQOvYYOnR9DC?=
 =?us-ascii?Q?xFZ2wua69EGK/3D4h7lpZgDTf+TeyvdceZUqQBWKwKKVsXSK2aZvvSTPScFq?=
 =?us-ascii?Q?lwAm/51qhoxLajtmJt32dmooiVquc/ZvYiy+kUtDpSC8WrmyYMs0lVSPeT0I?=
 =?us-ascii?Q?8lC+5tykHrREp6m2z8zDFm+W5DfWDgk+awodo3YbVbxFcHV1S+0/E1HWMzep?=
 =?us-ascii?Q?+jTS63x3Z7rISaDehr1QlepcZ+9CBTTQuva+/GoNCj2uL4oiaaU+h+kqmHBO?=
 =?us-ascii?Q?W2Ql+Ja84sUFicmHUmJFiYVImqsLVXu5nOb2E2xq4ikPSLBJSr69Qxl2Tsd6?=
 =?us-ascii?Q?ZTZup07STVWUVvORWrCefbPTSiH3RKyBTLscn8RlLRiZakM/ebGBS42ovXq9?=
 =?us-ascii?Q?qcVivBjvoJg+2hTn0NAkmohNCgkjq+Lm6YZnX3i00+lyKLDXuSk+hv2OAKHS?=
 =?us-ascii?Q?rBkJxGY5j3tSpAWifHHZRC00LWSoZoNDVEom43QIs9rG/Nwk7MA0bA2Oo7Nz?=
 =?us-ascii?Q?Chi/1LIC2uc4mlklSxV9VDZd1oVfwHzR6pUav3O3V3QT1WLIk3+KZ1SsUmBc?=
 =?us-ascii?Q?7SHTiNrWv9B3CIouR4svGLMVtTmsVKHmT3rbu6YYIasOaSIyrx5KJtQFqpsp?=
 =?us-ascii?Q?S2lUiwl2mPoVzbNlZCKFZLOxJc7pyLrz+mDCx1BmSFqeVUhNDDhqSti9xJUI?=
 =?us-ascii?Q?DZnfLF5Pk7kNEDWy6UUd6T+g1wNakDuDjZUr6eqTPkv8nnE0J3miV1WEpDIw?=
 =?us-ascii?Q?XhXhctZGlM8SDRZoNzuJ1xKCx3/leh/fL0/6MCixNh8yMh7hs7O2TKrejkXU?=
 =?us-ascii?Q?7AW7Zhp2HzMcuz6v26TCkiRG5WklE3RCz7FPCkIIz2J95U47+fdN5Gzpt2wp?=
 =?us-ascii?Q?a9Adg8v8xJUlVq7JDCGvWA3Kgryok1tK6tXTOjoRszDxKB4OC7byC9cQeuHe?=
 =?us-ascii?Q?s+vc8voJNjJivLmErbxNwuw+NoSYuRDI6y18bY8ETlOJTX+QXAwKvc4D9SPu?=
 =?us-ascii?Q?L/SRKY8f2cwtfgzW01MXbpaEKQX9ZRzmpGRZk+oP3kX9mE9j24sqNcI2YYvJ?=
 =?us-ascii?Q?9FqpqElm+KEGVfREEOa48mm3r5cSClfPIr43KRXBWjcV2lT7GEw5XPsHOk7Z?=
 =?us-ascii?Q?xohnGmaDdP8/rYRlIQ54wZSw2JoqmEjPbfiIjFjDXqJYlT/LjJcK98RCeCW6?=
 =?us-ascii?Q?1y1tqCnUXurVB/2Ikd5zxPZaptd8YkeiAHw2Da5Cnl5GLCoyvePysfwXaizK?=
 =?us-ascii?Q?WANtTcOwDkOIw795VCtt88IyvbVoIeB8X3N2NSEi0KqzHt90SySqg2Owz50+?=
 =?us-ascii?Q?5zBGuwfrKE+9EJJddl8t5Kgv0lffo703i9+eP3KqTe5AcmT5j9rR9Te2KqJr?=
 =?us-ascii?Q?R7RTkDiKOZQwWyBEj/cdTqmhQoi5JvqQ3solpfdLyt0NjCjXI298kSfXxA0e?=
 =?us-ascii?Q?MDjlKv1w1Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70195f1d-3d7f-45c2-3c16-08df3e56fd51
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 11:45:44.7643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kk98QTLlAp+unXMfnpjwZC1zIuDhhLf7mVFkxsWIsyUVAExr+xsd5Sf69Cn/26kwGCjoR6UqKLEC3TtbH6Lrctrzqli49m8OwAtuuGx15Ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11200

Hi hyunjungg,

Thanks for the patch.

> -----Original Message-----
> From: hyunjungg <hj351016@gmail.com>
> Sent: 09 November 2026 11:31
> Subject: [PATCH v2] phy: rcar-gen3-usb2: cancel OTG work on unbind to avo=
id use-after-free
>=20
> From: Hyunjung Ko <hj351016@gmail.com>
>=20
> The OTG role/VBUS interrupt (rcar_gen3_phy_usb2_irq) and the role sysfs a=
ttribute schedule channel-
> >work (rcar_gen3_phy_usb2_work), whose handler dereferences the channel (=
ch->extcon). The channel is
> devm-allocated, so it is freed at unbind, but nothing cancels channel->wo=
rk:
> rcar_gen3_phy_usb2_remove() only drops the role sysfs file. A work schedu=
led just before unbind can
> run after the channel has been freed, a use-after-free.
>=20
> Cancel the work via devm, registered before the interrupt is requested so=
 that on unbind devm frees
> the interrupt first (no new work can be
> scheduled) and then runs the cancel action before the channel is freed.
>=20
> Fixes: c14f8a4032ef ("phy: rcar-gen3-usb2: fix mutex_lock calling in inte=
rrupt")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> ---
> Changes in v2 (thanks to the Sashiko AI review):
>  - correct the Fixes: tag to c14f8a4032ef, which introduced channel->work
>    and rcar_gen3_phy_usb2_work(), rather than 2b38543c8db1 which only add=
ed
>    synchronous extcon handling
>  drivers/phy/renesas/phy-rcar-gen3-usb2.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renes=
as/phy-rcar-gen3-usb2.c
> index b5ba751..35e519a 100644
> --- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> @@ -1171,6 +1171,13 @@ static int rcar_gen3_phy_usb2_vbus_regulator_regis=
ter(struct rcar_gen3_chan
> *cha
>  	return rcar_gen3_phy_usb2_vbus_regulator_get_exclusive_enable(channel, =
enable);  }
>=20
> +static void rcar_gen3_phy_usb2_cancel_work(void *data) {
> +	struct rcar_gen3_chan *channel =3D data;
> +
> +	cancel_work_sync(&channel->work);
> +}
> +
>  static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)  {
>  	struct device *dev =3D &pdev->dev;
> @@ -1277,6 +1284,17 @@ static int rcar_gen3_phy_usb2_probe(struct platfor=
m_device *pdev)
>  		return irq;
>  	} else if (irq > 0) {
>  		INIT_WORK(&channel->work, rcar_gen3_phy_usb2_work);
> +		/*
> +		 * Registered before the IRQ so that, on unbind, devm frees the
> +		 * IRQ first (no more work can be scheduled) and then cancels any
> +		 * work still pending before the channel is freed.
> +		 */
> +		ret =3D devm_add_action_or_reset(dev,
> +					       rcar_gen3_phy_usb2_cancel_work,
> +					       channel);
> +		if (ret < 0)
> +			return ret;

I have a question,

What happens if this return error? Is it ok to call
cancel_work_sync() before scheduling it?

Cheers,
Biju

> +
>  		ret =3D devm_request_irq(dev, irq, rcar_gen3_phy_usb2_irq,
>  				       IRQF_SHARED, dev_name(dev), channel);
>  		if (ret < 0)
> --
> 2.43.0
>=20

