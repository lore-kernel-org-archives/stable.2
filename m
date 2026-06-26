Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011037.outbound.protection.outlook.com [52.101.70.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AD13D6CD9;
	Fri, 26 Jun 2026 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455197; cv=fail; b=AURMzWyC9wMw28ezjnv/cgKRX2l8od4uXmBaG5esDAXGodxyhc3pqMA90vjgYmC3FOtQJGS3HO3TJyO7uCxFcSXPp0S+zSGIqvfzsVX8KPfK14vMxIjyU44Ww77pmy8qj9H4rl9s+qleUaKeBXKp26yuhLo2RUsWayB3vAEMfWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455197; c=relaxed/simple;
	bh=j3+RO6xvXBSD1h0sR1x9/mxCTwxWOXNKxhCsdovekiU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tgWWod7ItxQ5dw3vGTsIDpAsAxZQQUBmgctLf/+aO7tRvN/XbCf3FVe88Zl08QKw5Rw3g8VkizNFDSvjI9x357sUNyYSQ9wu1hA9i6nFTIyg9+HEPgX1q6Npaj4suCzGmiveOXM1Dzdodnv2KWqBQ5JTo/a1fEH6DCPBin1Hiyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=yHdWLCtk; arc=fail smtp.client-ip=52.101.70.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="yHdWLCtk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dd/524L8QOHaVurVAn7EsZEO2PNNl0L4ABtSm3ZyBJBgys7O3bUKojn4cb85TDGO6w92PQrM2ft/MG8uKcOVSE12y43KSTaE9n82dqE+K200XhYBLV2cp/tX+zWc428ClasH2egy5XQ95mnxHjEMmykH+piq/k8KZb2LP78wK5IrZ33gXe/UW96yKWAmSsVmVStK3UgAYy316jS3FYbsYI/KH5lTjyRYw4nL6cGYWVpL6sdYr8k1VVk1AqduQeRRrCQGeXljuDH5R9tjAy4Qjgs7QeNX8jldtxuQHV2Nkh7sZEZHU+EudwvjeX5a7OmyPKmH/feIET4KAj0mXiPAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sExoYDVPghPXJ68AZtWQ4DK7XmNAWGU+Nwn0klI55Hg=;
 b=e2exS3OkD0yHlUhYUPiY3oi0dhOydMkauzvaYpuxFe9vKTf/kVpi3SADZfSPm1Ov/PULHd5Ik39I+C6W6eu6FyKUukYXCLiihzMXFZPWcK60NbPbyqkFa1d/2VE0z/SAvk1WIiF6TTiEIJN8MvuGuhWeV8vfGe5no87vGbUTsdht2Dz9MKT3FvgzWZ9qW0wZijTwSQUiDCGePF24KzxwjATAgEUqpXYdwSTG1cRleB1pfdbhPJIzdgWn01RefV44G35eeLBc3+WnH+0sIUbWFJSXKuvre79PSI+rP8twLkhPzIk3EqxxRIZ1XAr+D000rFf6Bcg/OG1iMRIE9j5TKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sExoYDVPghPXJ68AZtWQ4DK7XmNAWGU+Nwn0klI55Hg=;
 b=yHdWLCtkfQlWNFCLDlOT+ugKIDVxus7FsEd1ZrU0uV4uz55T4yAgDsqc2tW9nb43tIEbJ3vUXAEfj4EIrDZL1TSbFRLsMVkXR/P3Si4AWeigi+98ZQw5vPhh74ex2bDRlK8hwTjST8Qh1UTBeAF+mGUfKym0osVGbNfhKARpl6CavTkpl9NRsycRH3GmYXYbrJUVBYMP0gXKON5HBKG0floXxP1XKvfNWhDy1WGGa1J4XzCKInUSQgaUPGPX0zxph+fjm7U0a2bNLYCo7scNPLb4AUPosylnJpjESJf2Aw8E/2LEUwSPri2m6zaUrzGC9Ne97vn2peZUxqnZQRaFNw==
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by DB9PR04MB8106.eurprd04.prod.outlook.com (2603:10a6:10:24b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 06:26:32 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 06:26:32 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: Liem <liem16213@gmail.com>, "Frank Li (OSS)" <frank.li@oss.nxp.com>
CC: Frank Li <frank.li@nxp.com>, "andi.shyti@kernel.org"
	<andi.shyti@kernel.org>, Biwen Li <biwen.li@nxp.com>, "festevam@gmail.com"
	<festevam@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "o.rempel@pengutronix.de"
	<o.rempel@pengutronix.de>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "wsa@kernel.org"
	<wsa@kernel.org>
Subject: RE: [PATCH v3 2/2] i2c: imx: Cancel hrtimer before clearing slave
 pointer
Thread-Topic: [PATCH v3 2/2] i2c: imx: Cancel hrtimer before clearing slave
 pointer
Thread-Index: AQHdBTS6N6En6z20Wk+dYCEk3v1Mcw==
Date: Fri, 26 Jun 2026 06:26:32 +0000
Message-ID:
 <AM0PR04MB6802DC473A8DD2B27EB98B3EE8EB2@AM0PR04MB6802.eurprd04.prod.outlook.com>
References: <aj1UR5ddawsdMbZC@SMW015318>
 <20260626025846.106157-1-liem16213@gmail.com>
 <20260626025846.106157-3-liem16213@gmail.com>
In-Reply-To: <20260626025846.106157-3-liem16213@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6802:EE_|DB9PR04MB8106:EE_
x-ms-office365-filtering-correlation-id: 961228e4-02da-4563-4ef1-08ded34bdd43
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|23010399003|366016|38070700021|22082099003|18002099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 geLauECdmuV8fsY5Afv6Awi79LE5quSd9HadGfp/vop/yI4CmSyLjmhHMtiFAi6lkBqXH9o9cCDFIM379a1D/aeYLP7SYNNMvGS2b8xpuZ1h/C6QhMJo59RgjNP4KdiIQtKEhTa6QZR6X2l47WbSKsvTvu/YKh77BvKo2Sdvmf4+PKYkrxGxe/uXGvZhDXx1hX0h26ts3yOluEpxM8NTyY2QkJ2IMkY++ytFBEosxVpCMNY1eGtsi34CJeaXCsAO0xhmwBtSDQ+abGMl/7L1ah/hY1QiyHfJGUs9mhbaomcjHB53CpvSnwZl4T1GbkQz0nOTsvDzFrZ6CMMRc/7amLhXG3/dHjO9FKuoSsJ62dXoj5cEfKZl1e5NIj2O+1+F5QksUB7hyWKzXnkBKj51szRWZuZIVXBqhZRkhNJLiw5JVCbHsQbUbCaTUktAAUIeP0y8GHLI5lV6q8tDWm6r0NFNTkXeYdQkbkNvhPRVQVroWWhtFFPX3G/LWkCSKiRRYoAKbgiEO75Udu/GAZfe6OavYMks/HHPlepaMfcXJG1bVoiJB6RLldTemWg1CBMi2pRCNrSTy0RpxQ1lqzX1gaug+6LaCnHfu6z2ks2hS85G8hhTxDbTdVeIS71so538muSTStA+EpIRf9HskdxVzPrPLjpeMKwqs2z66X4CyWZV2ILneDY6d6gFLCQxwQJzOqFQ7rwkrAFnLbv6KFj2kC0DF34L9IyZXJ9yCxRvoaU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(23010399003)(366016)(38070700021)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CgngtVZVIfPeVscpmhyCbKRYSqwIa8KAHaKcP4X91dRQwU1UU/vQGKiTXd0H?=
 =?us-ascii?Q?28Dd8mvn+6qR9yGKkwmfXstJDv88Sud0uly0ccyyggI22f9dcB8TuAVW/C+c?=
 =?us-ascii?Q?7IN7cYDW7V+zOneTo8xHRQ+EMIDuXHI710Z9C+MuVOWwp2H3wHj1zOy84a6e?=
 =?us-ascii?Q?jG62ICwtZRiKqMio865pIeJ5ak/hpQ9TpAHD4xcnYUpFuih2k2I5deHrxJaE?=
 =?us-ascii?Q?wgWSt7zMmCud0J4qSLr7gvpJSD4mdxXmlUxeD8J7SFEmMu7ZRvnNYX4UEwCq?=
 =?us-ascii?Q?IynI3b6lHRQ4jCL3B96/0YQQb8vHlWqo2l+1Es0cbUAi++K8J3hgiNUGwLof?=
 =?us-ascii?Q?e8aGQ3q+4ZUbFtpVHYMyYxI0CvtLea5vb6xxpel4kvgGXFFKbAcRJcsyiy2/?=
 =?us-ascii?Q?bXSYxDRr8drupnBAcB2cthk7V2vn4gzI4k/WvC9XFmFB7TBizjUrz3o6H2F5?=
 =?us-ascii?Q?pBtPs3fmSc0HWwRWCuDXRgwBLmgtbKgvEwuJaIdU04cmv0dSkeajCMFf6RaQ?=
 =?us-ascii?Q?RT786g7ocW4mN0T14Z2Qh/vk8xcrJ7AVEOCnQNLVNdocLC8Vr0KmX604XDqu?=
 =?us-ascii?Q?ZA0Guf9UV68lMzkf+iUWmab2MjdKAeaexeIqKYyrRGPWCZM/jusLJgmqdFWX?=
 =?us-ascii?Q?CFd00GQi6zhGpga44C59N27F+QOY+wJRUWExXmQvKU5ImaSdaF27srny5jnq?=
 =?us-ascii?Q?5P2g5Rps+qmNWLSN2w2oCkE+Tfoa/Reh97cZ9HssFOK1rirSOa7J2mza+s8b?=
 =?us-ascii?Q?0HQ/cqjH9cn1GgVl9/y/rhyVaVGJ8xb3X3TwljYF+jvA+woNaEFl9Pxk+Icz?=
 =?us-ascii?Q?yZG6/Wh92G/wWkq698kac/J5AtYsWiFQNLNNXnxvmU8OUJkHKr6KQsfF0fu3?=
 =?us-ascii?Q?uKkOeYj4ZdT9F5A1cFItb3yVRBgKVRNkAcSQx9mKQnp9SJxRC7FrquCVNx5a?=
 =?us-ascii?Q?n59u1Y/Di1vAsjrHCZn5xKVIgp5GcL9kO0quBq2le2zQv3Rxj589eCt/nAns?=
 =?us-ascii?Q?8OLEXbtbKcus5+dHziSID4xq7r2OIFRrRlMOtTiofJLXAPJQT0Cu93Ya97Nh?=
 =?us-ascii?Q?HjZZZswG0AiqTAhSMbKSrbiWs/8MGPsvsR2xtVmAaTJcEmvcMT9lFnIHeZSI?=
 =?us-ascii?Q?eaJxWZezDDUE4F4LooHwrSR052MsXvKn/DWjhsiEIjZbhn2PuO3MhQ94Gubb?=
 =?us-ascii?Q?dBX3KsXVAjBjc6m3wbsBoULT4bQV2mkfNbLn4X1I73Gz5d1f39oNdH8XdX6H?=
 =?us-ascii?Q?zwEZKpPQK6atgbg/Q6MKl9GMvAQCyNYmfCdFMQbznOVrvpETPFDLw3Jp244U?=
 =?us-ascii?Q?Udml/9hD6Vetf0LeplFgCB0ef7fmH68tqvxGilp7lr6VTko50+wvG0tkTLGa?=
 =?us-ascii?Q?jjxV4kB/Ke+0s0DFnj6+ujb0uC32a68DMc8ls4TBBt83Zt23xWkM4CZHhcEg?=
 =?us-ascii?Q?t5Qwp+e5BwzPklxzR4af6VkU9OxniNeJzOP9Fhi2yfggas996mTHqVer0Kto?=
 =?us-ascii?Q?vpGEvfEE8n+W5CTrfoTw4C55qZqYGSzwMqX05HIiFiyCM5eEOy9uHgJuDCZ3?=
 =?us-ascii?Q?IMjhRyj7jo9dKaHSpShcTY2sdh+CvYMDOmKrtGRvqrnyocaeDGkR0QW4p4Om?=
 =?us-ascii?Q?aKuxCiT6Vlc22yklkaMB0ODIVwMrV/GA/OIKf6fdQ4I6U9jvb6q9F56g9n5l?=
 =?us-ascii?Q?FzVqS34JudHoMQyRwMlDJTWpRj7R4ZSX8I+hxuHaEQ5MQ+uQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961228e4-02da-4563-4ef1-08ded34bdd43
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 06:26:32.1138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y9xgHtYcKjtfssXdKRH5ukCOjWV6AJDODDOXcaS4Zvj1uJil9E3Aq2BxkIKrTGDRLHxnXIF6lRVznNSLPFD98Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8106



> -----Original Message-----
> From: Liem <liem16213@gmail.com>
> Sent: Friday, June 26, 2026 10:59 AM
> To: Frank Li (OSS) <frank.li@oss.nxp.com>
> Cc: Frank Li <frank.li@nxp.com>; andi.shyti@kernel.org; Biwen Li
> <biwen.li@nxp.com>; festevam@gmail.com; imx@lists.linux.dev;
> kernel@pengutronix.de; liem16213@gmail.com;
> linux-arm-kernel@lists.infradead.org; linux-i2c@vger.kernel.org;
> linux-kernel@vger.kernel.org; o.rempel@pengutronix.de;
> s.hauer@pengutronix.de; stable@vger.kernel.org; wsa@kernel.org
> Subject: [PATCH v3 2/2] i2c: imx: Cancel hrtimer before clearing slave po=
inter
>=20
> In i2c_imx_unreg_slave(), the slave pointer is set to NULL after disablin=
g
> interrupts.  However, a pending interrupt might already have started the
> hrtimer (i2c_imx_slave_timeout) before the pointer was cleared.  If the h=
rtimer
> fires after i2c_imx->slave is set to NULL, the timer callback
> i2c_imx_slave_finish_op() will call
> i2c_imx_slave_event() with a NULL slave pointer,which results in a use-af=
ter-free /
> NULL pointer dereference.
>=20
> Fix by canceling the hrtimer and waiting for it to complete after disabli=
ng
> interrupts, before clearing the slave pointer.
>=20
> Fixes: f7414cd6923f ("i2c: imx: support slave mode for imx I2C driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Liem <liem16213@gmail.com>

Hi,

LGTM, thank you very much!

Acked-by: Carlos Song <carlos.song@nxp.com>

> ---
>  drivers/i2c/busses/i2c-imx.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c =
index
> 17defb470776..f02c216ba299 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -959,6 +959,7 @@ static int i2c_imx_unreg_slave(struct i2c_client *cli=
ent)
>=20
>  	i2c_imx_reset_regs(i2c_imx);
>=20
> +	hrtimer_cancel(&i2c_imx->slave_timer);
>  	i2c_imx->slave =3D NULL;
>=20
>  	/* Suspend */
> --
> 2.34.1
>=20

