Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010068.outbound.protection.outlook.com [52.101.84.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4240C2F8E81;
	Wed, 24 Jun 2026 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782314874; cv=fail; b=kfbDomYEQ0nLuGFojRwHo/7UIt8ui9+vkDjMgkmZFA2pLmu7p6AqcxCMxYEUA42Dlp9+MclvcehKKkGvNuCOybmzVQswAVDpnnmBdiAzrFXHJvCZhCXOLmOvziDM7SwCS9ya/0tm0fZClv2lOctwh1UHYdDaeJ/lGvwVZwVvjeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782314874; c=relaxed/simple;
	bh=UbZSGAkMp/9AQdD+P8oB1DgITJbBGs6aVrDm09cMnow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B/7QfPzfOarbTZaCzqTU95tIpE4B0zDGFyoMX0CSreyKf3KaiN4B+bYQ8WGv+FfRg7ZJ0cRDLMBF64CLY2wWlEw4Wx2Dpqf9zUOPl53/z0dLhqRfHfpM5K8A0TfvKmV3SGAfj101nVsKBZdPJioG78CPm6vZuGWdDpLdDAPqdds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aTjq4RAN; arc=fail smtp.client-ip=52.101.84.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aTjq4RAN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFp0MM3aM+FoHEgPp0OudMNWgrHboSMzVOcTZucIZq3doIlfFYT03dvjGdyWOYLl4oNm4aJXPJ4w3VLDkzQ1RBKyIT4jU/1FRCrQJhkjMFFWlApNgGNJqwJaxFg0ctck2qRQPi1yMOWuM02/BBI64TNC8OmW08AKBcIIYuOHQdLT9OqH6hL7M4YGw7Baoqh73JCX8MsQz8bL65orVrCAXTRovGOMvf6vP8ddbpHjVyyUTz5g7TEQvhHKTY0KrG1Jle6lz24cMm3advlvUcMRLY9psmrIx7rHpRgIZMulTOJvcuZ8W1U6CPCzBlV37RUJQTmhaUxbdR3kQd+a5hvoGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2E1GWR8p1Lt61IxU6XjwCv+WWZn1seqOABqzX0+9sHo=;
 b=Hpdmbn0hkkzq4W8dmAltEuCXPOAZ9trIrKhpCk8kR6KYBfjKuY+whzbd8hOUkTnGoeeRi9fRa77nJAy7pgu9QKeNooW//xxLb3VVrGrMJ1kyBYuclxB2ywW6nIXegojZ9nM2/pTbSeCwhznHD5bwwR0q4MWjsHjEEiZR5K+NXKdAYNR4+R0tgn4bFFL1O/4L3q1wQTJZslPtu/c2cbAiLEcbj543v8AymSxE0pt1erk0D7uib02tzfnS9NYZSeHllM9vGtvTC1OZxWV2gYwJTACl95oTlXCWxfLGLZIyYSXTdKUU2eZtZ9KFLsSx3S3h02QgA0Ye+tjbqcZd2oXayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2E1GWR8p1Lt61IxU6XjwCv+WWZn1seqOABqzX0+9sHo=;
 b=aTjq4RAN9+K/ryMn/x6B0hOlh4+V+vWQ3S8plFaAgXGvZmg3ZiAteqsj9wHJUas6WXGRgapHL17dLRxbBXngao65kV/SF98adccB6/NslMJwcLsuaHoXYrSnP71kXtC8izLIp5ZGmY5Ilg8Q5qDTnf8q9R9su1rSWgyBb5ht+ktWgKWNDIg2gtrC6ylu/rtot9KkHY6Klr1s6O/LX7HAWRcmoNJe1crDIsmgzRvCkktNqXEjJu6PPpU89gpataAFPFAQy5zXDn2dU206v8NwushQ2wWapiPkFnryDsZfEAd3qhJlwvzEtnU32+b0STF8YgTARC7/anuSRGv6xAHSng==
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by DU2PR04MB8693.eurprd04.prod.outlook.com (2603:10a6:10:2dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Wed, 24 Jun
 2026 15:27:49 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 15:27:49 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>, Mark Brown
	<broonie@kernel.org>, Frank Li <frank.li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] spi: imx: reconfigure for PIO when DMA cannot be
 started
Thread-Topic: [PATCH v2] spi: imx: reconfigure for PIO when DMA cannot be
 started
Thread-Index: AQHdA+4Dys8i7MW5JkKuqY43zXsxcQ==
Date: Wed, 24 Jun 2026 15:27:49 +0000
Message-ID:
 <AM0PR04MB6802ED0CFC33BED94C1E2D0BE8ED2@AM0PR04MB6802.eurprd04.prod.outlook.com>
References: <20260624151958.18626-1-javier.pastrana@linutronix.de>
In-Reply-To: <20260624151958.18626-1-javier.pastrana@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6802:EE_|DU2PR04MB8693:EE_
x-ms-office365-filtering-correlation-id: 38e86289-8abf-4017-f3db-08ded2052638
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|7416014|376014|1800799024|23010399003|22082099003|18002099003|38070700021|11063799006|921020|6133799003|56012099006;
x-microsoft-antispam-message-info:
 ckbcZ1mBmToZjz1kvUHc/ERzmRgoMbGHyt46xpSlzuHFvWghmQ1QsbRQ/FUNUgU76/xn3RBvn19Lf4cSwgbO8AJM6sUVGzDADVb/Tf7mENhXCivydGsC0Vq0iaJE364nU1DL3v/H6UICbMrZtYeqz+HgZSNo35Gf4+7WiMGlwh0Mnlv0MkEsdNR46oFaI6tgpVo0dQmWDUd7yYlUAlqmD7WLIq0msFO4aJZ1iQEMwzzKfz/ZoLi5JxKpm3mm2aPXs9DyiumRLxEGyWqGN+/y+0p+nTdTVIPZXvTHWATt7eGQQo5HUZ7FYUzsFgXm2SbJBRSBAND3bpHgVPvcwUtCQ4HU5sdwykplCDCvs2mQlhsWyG5U7ps3JrRJdv77HilAWNtDXrb2F1nQmsuq7C9NEjTuf8jKuFYiiP8Q6pTLovhekGu8qmWrCSW4KMklwCuG12tIDmbjTePBj7m2t5DtV3Bv3HzZJXmXo3+kFutkBx/JjfN/uTMHjJqYfY7LoaGewAUYcDLJOJtYYGfL9mYsk28cAvEK7FdSlGUUrlXQcjsX8EtO8fwF2+lcNSXyd7n8LBkNXPGUSL6LMB/pqmQg3nqhp717qrhvgaRB5YWtqRqbVngi/wGb0z1RCi4sRRrYVLPp85/rAZ9ERo9wr3C14mBaV56EjKQ6y3yv5SYT8HTvJIRh2SVXB3wx4pQ0EPnPss4g0NU+q6s+qkrawEuJrftYhCxR5SgRoVO69tppt6KaG+ojDRhgOogS+yH14xXp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(38070700021)(11063799006)(921020)(6133799003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?i3ACLfT4/gy96aFqNzGEushMcDwiBT8A3IBdpVJX/7ab5ZKvaxjnBZRpQ2LH?=
 =?us-ascii?Q?fUZnJa+dQIORkxopNDvpp7czQlLWKh0ZPt6HcLY5Xes8ZNQ95tf/XG4m7DAw?=
 =?us-ascii?Q?1FZ/vyrwNDSQ/XuuT5JI+m4RnDZuUPOku8EEhsLRahn5gwGrw+HKushh/RZk?=
 =?us-ascii?Q?XGeS8FSfWrRr0Z6gjr4Ua99wSYy+Laruc5ufkgjnlrsLdzhY0P9DvfrlSv6h?=
 =?us-ascii?Q?kigRdXrEo2pik2IsSnAAd+pO7oHdixc3qXemYj43IwPXt3RnTz3H1qQh/VHj?=
 =?us-ascii?Q?qHsSMe6HtunTXkewo3Bdpl3Bq69cGkCC6K/Ces+1ofkyjqtJnAAgoT8tmoDF?=
 =?us-ascii?Q?pVOTpwsx4ZSGR/IGBe7O7eJw/2P1+8RWM6x33KOw1Nvihk+4idTUSvYJ+xNW?=
 =?us-ascii?Q?8DlicEPXeUIHJvlqpsE5VQC2a3pIqa5A96FokKSiwbXPiepFfE/Opem/btux?=
 =?us-ascii?Q?ETKO6W5YkWwzyrbnFiHVMFBsYt3eTI5daJyojwo02A0ooskOpEn0LDljRc//?=
 =?us-ascii?Q?hIaK36j6B3U1kCyNY+tLO3N685mJ3NFxRNuUl3K4XEE6s07oBDflD7Iv7OIq?=
 =?us-ascii?Q?YaZVvOHWQdc/rktKBYukNpukH6Xy8I8DfJ9li6i9ftC31JPyflnFGw693xAV?=
 =?us-ascii?Q?7wogcTRunfipzV51BDUJPGgETqXcW0+GcMKZ6lCfGvhyuFdVmML4JmvldvrR?=
 =?us-ascii?Q?vrW7G3ckAaCJaNBLMx1X+7SwPRTgm0DX5qHmj0Uz25ooa3HLtKKE37Wr5BOl?=
 =?us-ascii?Q?nwylueY83WhhudonJjoja14YOtYLBDbGkgyJWqHx53W37HXYuprfgtFWV1Lq?=
 =?us-ascii?Q?MoTz2hK/LHw3odQYiBNEwuRyI2zOHp8jRcjkV0hy687ZwyiPbom6TCTj0Hwp?=
 =?us-ascii?Q?7/RbW02vW4yqectlRwLjY1ql86foc0LY8VuzEc7fZWYOqvXVI1GyqGWTgqUx?=
 =?us-ascii?Q?2V/j10d0JAjUD+2l2cNq2HO94SJ1ZuzOUPHQaLGZ63Wq9yZnzBTqADdl/NZB?=
 =?us-ascii?Q?RZi37kR74ybubnZ/u/FSWE2e8xGruQYcwUZ05wSn1QdPp58HJaWJseMQ3q0P?=
 =?us-ascii?Q?8WKVx4tSfVPTREWdoBtxD/HFR9vUkLxt6OCnkwf2G3zEgWjx8dpM9bpZYbnU?=
 =?us-ascii?Q?FuUcb+xHHCurral6g/4BN3GBURbXqed2Hk337g/ICj3igXQBvMi0B4cM0F8q?=
 =?us-ascii?Q?668et+zmaJq6yx/cuT8ydHBlWQz3+YTzXQUZ5Rtpvx0Xg4cJVgWDrmT34yyM?=
 =?us-ascii?Q?QwFd7gmTeCFy/YUkZ5PWycE3Us6wQm3TJO5xwCSvEkwfxA81FBxdJ+wuaumo?=
 =?us-ascii?Q?Uifxk/AT4hXnubUFkdXRvVE7aCTflDvqAidV+R79oElZdasfJqjp5ETa6XzU?=
 =?us-ascii?Q?hziShzL8PiMGL6veXQwvT4aIPcgkxKqtnSjvCvJ2Y1Jk7IBaHhZ9oFE+PROH?=
 =?us-ascii?Q?zc1jQ2jcb4xGLHjZP66y90sMzmDwbfCK2AS6LQ2gKsk3lqhjCk3QC8q4GW/9?=
 =?us-ascii?Q?WnFG658coXTctF41Q429Sv5mfB5cYUviWyVlGKp4bBW9+6EFGPjeyScyXkXU?=
 =?us-ascii?Q?HFUlRTWzpIwt/9WGv6PHO9Ign/WoWWYFAI+cCdWIqFnVmLB4vvhwYrB6xmfk?=
 =?us-ascii?Q?5AWjXDMiaw826N1cQBSRvEDz66hmlRBk6cVYpv9js5rERRopc+Jb4uX7R2ri?=
 =?us-ascii?Q?6+9TIAoNAokKMRr3aL9YTxk/qfKyTySR2gVSGlPU0BkRjIYy?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e86289-8abf-4017-f3db-08ded2052638
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 15:27:49.0736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uI339wTLQqekhUhc5c1Z+TggyvypnuNfsc0mjhWX+JDGiGJiWd5F+SXbGWQoRxYxvC6MofYJK0GfNQbIEJcYdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8693



> -----Original Message-----
> From: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>
> Sent: Wednesday, June 24, 2026 11:20 PM
> To: Mark Brown <broonie@kernel.org>; Frank Li <frank.li@nxp.com>; Sascha
> Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Carlos Song
> <carlos.song@nxp.com>; linux-spi@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Cc: javier.pastrana@linutronix.de; stable@vger.kernel.org
> Subject: [EXT] [PATCH v2] spi: imx: reconfigure for PIO when DMA cannot b=
e
> started
>=20
> [Some people who received this message don't often get email from
> javier.pastrana@linutronix.de. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> Caution: This is an external email. Please take care when clicking links =
or opening
> attachments. When in doubt, report the message using the 'Report this ema=
il'
> button
>=20
>=20
> When spi_imx_can_dma() selects DMA, the ECSPI is configured for DMA:
> spi_imx_setupxfer() sets CTRL.SMC and clears dynamic_burst, and
> spi_imx_dma_transfer() programs the dynamic-burst BURST_LENGTH and the
> SDMA watermarks.
>=20
> If the DMA descriptor cannot be prepared (dmaengine_prep_slave_single()
> returns NULL), the transfer is failed with SPI_TRANS_FAIL_NO_START and fa=
lls
> back to PIO. The dynamic-burst DMA path uses its own bounce buffers inste=
ad of
> the SPI core's mapping, so xfer->{tx,rx}_sg_mapped are not set and the co=
re's
> DMA->PIO retry is skipped; the driver falls back to PIO internally. But n=
one of the
> DMA-mode configuration is undone, so the PIO transfer runs with CTRL.SMC =
set,
> the wrong burst length and dynamic_burst cleared, and the transferred dat=
a is
> corrupted.
>=20
> This is easily hit on i.MX8MP boards that describe ECSPI DMA in the devic=
e tree
> but run SDMA on ROM firmware (no external sdma-imx7d.bin):
> every ECSPI DMA prepare fails. An Infineon SLB9670 TPM on ECSPI1 then ret=
urns
> shifted TPM2_GetCapability data, is flagged "field failure mode", /dev/tp=
mrm0 is
> never created.
>=20
> Set controller->fallback before re-running spi_imx_setupxfer() so the ECS=
PI is
> reconfigured exactly like a normal PIO transfer. With
> controller->fallback set, spi_imx_setupxfer() sees spi_imx_can_dma()
> return false, so it clears spi_imx->usedma and reprograms the controller =
(clears
> CTRL.SMC, restores dynamic_burst and the PIO burst length). No explicit
> spi_imx->usedma =3D false is needed: setupxfer() already updates it from =
the
> can_dma() result.
>=20
> Fixes: faa8e404ad8e ("spi: imx: support dynamic burst length for ECSPI DM=
A
> mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>

Hi,

LGTM. Thank you!

Acked-by: Carlos Song <carlos.song@nxp.com>

> ---
> v2: drop redundant spi_imx->usedma =3D false; spi_imx_setupxfer() already
>     clears it via spi_imx_can_dma() (Carlos Song)
>=20
>  drivers/spi/spi-imx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> 480d1e8b281f..1837cc7b0b96 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -2152,7 +2152,8 @@ static int spi_imx_transfer_one(struct spi_controll=
er
> *controller,
>         if (spi_imx->usedma) {
>                 ret =3D spi_imx_dma_transfer(spi_imx, transfer);
>                 if (transfer->error & SPI_TRANS_FAIL_NO_START) {
> -                       spi_imx->usedma =3D false;
> +                       controller->fallback =3D true;
> +                       spi_imx_setupxfer(spi, transfer);
>                         if (spi_imx->target_mode)
>                                 return spi_imx_pio_transfer_target(spi,
> transfer);
>                         else
> --
> 2.47.3

