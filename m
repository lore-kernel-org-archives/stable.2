Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010048.outbound.protection.outlook.com [52.101.84.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5765B3F88A3;
	Mon, 29 Jun 2026 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782725418; cv=fail; b=JDiqtBggMcL9kxCZzAys23Q4FjtHAoVTA8c63oOCOlemevW8RplTrMFZgCJJqqo+LNhWsiNEqTPdJyDl5xVKdz2YKvqihHiUjuUeMzQwAnUaeO9yWpFxisw9pc7Q02l6dPHghWo8XqYTS6uqUTMIGZuezOuTSwkiivg2fvjji2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782725418; c=relaxed/simple;
	bh=7XYaweA7TsI8h7KSAyJCTfYY2qK2If7scSfteuRjZFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UG/5U/ZSpQEbudkkZUuFqSR1/CHTdIlz5FzkiBJgLb13gn9qetlT+f5t4AcJVZVrqTdOwrPVyumpMPJKkHqbt9x0s/agDSxRw+t9vdOQQErYde0U7XHdOg0WZa6iTeuoxdL4oowO6/0QM3U1QcL7/Z2HHULoZoziCXok3unbQF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SHshhBEj; arc=fail smtp.client-ip=52.101.84.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SHshhBEj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1Ymmo02u4ZEskbMZf0cs13//V1+nwEaCexo0qiwsyqZboBV5FfUxrtQYvnMax2DEk9XxNv0Osg0pYcmYeDH/5kjhbUxekFs3JSzhMKThr7KtiOGfUgsi8/llFn6k+IjgbeA3UUiPTSIqBoYJnr4trBBsjhwoI2jRg4ELo/BGes0y8pFsRbn54cHi0tvJNBeyl1BUJBwNRV2G9+/XWGy7fjQY/WoRVefirsTx2ohM0ciGAyIZq/Q3Z2KyZSQzw7G0+s8Z6Kfg8yht7QME3epENWme3CwZNxWQRPM9Rw4JVVH7Oj/LD/rlkInST6z3wYFjijvdugk4T5HXt53Cj8NVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6f8DACVvbhtUJCw1DAtzBvyTOcdwPV0ysXW0l4SzZ1c=;
 b=QHIBFe+jWUDplAr7rp+JZvY1eV+zygo2kK2oasCssdf7HZHw64qSj39ohgZfrRPDYB+NEJhT3yKUxJcFGMjnXkabysvOCZZNRLKtpZFwKHYj7eSXvVwcKTwn9QRjDI3ubDk67N694WgNPT6dD9bq7lwytQomts0HATTHlgx6nMXNq++46Aaqhlp6/irXl3uCTJ76xocHUgjunSwQ5WvQsm6okGFsER0VLdT7E2fs53ChvjJ1vJsMc3dSVFjnZjcv0KHtPE7i4LHhWgx7Pied9Ojsk+p8XOidqXOo5OGm8t6/Ns5YhxMMF8ZTf5eXiO2gfrQOBMftb8xGoLvHzrSxQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6f8DACVvbhtUJCw1DAtzBvyTOcdwPV0ysXW0l4SzZ1c=;
 b=SHshhBEjOyUV5HtsyCwJmU4dEXQtV2TWCFEe/B4rDJMQEr8RUUEq+vv5LC+LuEG4QSnV1NYiItAGUjne3WP9Olls+mtkb7Oyq4e6iK/GItGpnxXjUvBiMxFt8MmPOfBpg0r9XmMWAFPQeWVvP40f/zcKLzrM0FRPyIJvKF1tTTh3R0ucgljNv5h7z9Zo9Vj0xMvLSBU/5u2vEg6i6TfTK4yvek2XOn6T+3sEAiXCJExapEr3Jz2HwpuS5y1G9FUVrzsgwmgSZM6kypf+B3FkWJFIBF3kKBbdTvx+FBnyTZViHH3Frkd/zir6ZDh/L8qWPEPw89Y2iPKYxdsspGVtMA==
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by AS8PR04MB8055.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:30:14 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 09:30:14 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Liem <liem16213@gmail.com>, "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
CC: "andi.shyti@kernel.org" <andi.shyti@kernel.org>, Biwen Li
	<biwen.li@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>, Frank Li
	<frank.li@nxp.com>, "Frank Li (OSS)" <frank.li@oss.nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "o.rempel@pengutronix.de"
	<o.rempel@pengutronix.de>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "wsa@kernel.org"
	<wsa@kernel.org>
Subject: RE: [PATCH v4 1/2] i2c: imx: Fix slave registration race and error
 handling
Thread-Topic: [PATCH v4 1/2] i2c: imx: Fix slave registration race and error
 handling
Thread-Index: AQHdB6njrpEtRieVbECqYNWZBJ3keg==
Date: Mon, 29 Jun 2026 09:30:13 +0000
Message-ID:
 <AM0PR04MB6802B76DD86D74C25D9B05DEE8E82@AM0PR04MB6802.eurprd04.prod.outlook.com>
References:
 <AM0PR04MB6802B863CD9B9AE1609C1785E8EB2@AM0PR04MB6802.eurprd04.prod.outlook.com>
 <20260629023829.152651-1-liem16213@gmail.com>
 <20260629023829.152651-2-liem16213@gmail.com>
In-Reply-To: <20260629023829.152651-2-liem16213@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6802:EE_|AS8PR04MB8055:EE_
x-ms-office365-filtering-correlation-id: c0f75615-4252-4fcb-affd-08ded5c105fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|19092799006|1800799024|366016|18002099003|22082099003|38070700021|11063799006|56012099006|6133799003|4143699003;
x-microsoft-antispam-message-info:
 BnXvvGTiwLrxosKtYXfS5ENwm0sjRAKMi7iHMih62kzsiJVLp2MzN/kzDfpJyg6u4pptWA5eO4WiTWM9oQ2a6LEr0FXi6sJROwsbWdUJZXRERez87HUinBJFrF0mi3hIFrjV1g4wQvKw7cmiUHmVLZ+Q0eskpxIGQyia9QihXh3DLOCzpQyim2nZuByvFHKSBGLj3LSPgn0RnYdZxq94pxTH3FLSKEwzd62eqfa7TfdkYvNDsfr4wyhmAgs1nNl/v/avmeHDQjyaxDqI01rMfCr5gwHTyA6h0hXGl1x8MVAF5wdptd8RObnirnj+2DNJq9KVTaa/d4iT1QzV94CgGQGVxZn0qe1rAKh5jEUFsQpvd+za1tuRuTSv2089xybf8+uek/VnzNoLZTKhZwxm/oBpJsDamOTCTvH1HVvy3TT5scwRdH2UXCtvvTGxxfU2V3DxI0t5dh7RTGCBF4PGFk20Dl8zsBUvpRUP0SpzQVz7nNtpW9epBQtNGQGfAQZ1HRpiCSdLd/7FdcUjQg8qmUtn/NOWPxwPtFC9ksIFbkfHMlYIyWsfKawlAhZRWowd3SSrm5coSSAqFK35uBduof7DpnrGJoDV+aeUH+Th8asiFdmsjYgsmu3catlvQkl2uvgKyIRw/71I+WSuNwfUmgSjhA3pEUTiAcOOUJQ2xBRa7cbaVMWxttAOY0F61DDdVyqf8IEWrA+T5esMJthCwTQzaOKqnLIyF8bdQJqPEV0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(19092799006)(1800799024)(366016)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?c9JRapUidK3Y6Y9cCHbIYrJMS3ZxwPO0sYqUSX4IySFevjwjkJl+XbZfPcMu?=
 =?us-ascii?Q?pgprUWyPjjccB2mJgV2LLvjLpcynWYr2zLQdH4yXmo/KKrzL64zdTmEbxShS?=
 =?us-ascii?Q?9uQCgsOJO4o+2fQgFll1vHCtGpQAB+3OAXGwbly4mj4EkmusaP01UKAlKIhj?=
 =?us-ascii?Q?LTdOzcDr3TEPzIi6JMSiWiD7s9jLTuxyR4KGMVrkOvAODZS680Lsu8bDVFz2?=
 =?us-ascii?Q?tsIBPMU7Y3Q23/BQ06sUw8CJef1yJXUxd22gsl589SMpDuugO8Vo+iqqei5q?=
 =?us-ascii?Q?DPoRe2223JyV+4DtssmJBKd0qTzMDFFV6fMdZYVrQdZk4tbEjA+tvf+P+hgT?=
 =?us-ascii?Q?rZAnGQZxTbUXRfDDJbvwwXWqr7EQ/t7GfWGMfX737SgHYFda5yUySpboSwwP?=
 =?us-ascii?Q?Kq7ZdJ7R7PxmjRNWSVQdhKA0sUCirGDGqIX90pW47gVsSCCAnTRG3TrYYjvz?=
 =?us-ascii?Q?9FcP5SFRId3VMVnGnaKlP3jwJ2ZcqKKqa+MybQSStoBuWw49ltojEQbqaOZb?=
 =?us-ascii?Q?VUvvS+eI3oPl0AWNVuBYwvjCp77OqNis31CUzMXZc3OthGicuHv0YTYvBeuJ?=
 =?us-ascii?Q?/xp0Yggj00/PYlrFlihaumBVnYPJwLji7uKpawMEkRzc380d7/k+Drho0DPO?=
 =?us-ascii?Q?ZUwYWxhza1cntwgZAdOEym7lYDxF0zIo9eGvDSN8NRpcStiLZ2fRZcvAyAk+?=
 =?us-ascii?Q?1laFzMeSxPhnBWLMfGf9ECYLkOkOeL2PqGOEEDUOvcnzzv00WxHYBcazxR4b?=
 =?us-ascii?Q?VRXR8FpUJzRZ4M2/arQm9cKEDteW0STqU1+5eR1ByqXHuUSMEfVKBPf6CuPt?=
 =?us-ascii?Q?zoive8JJb4fCkXvmrxa1a1Y5MmqNY9jxwJ+190ozmiBCQkH+h+F4Iqki9TFj?=
 =?us-ascii?Q?swaWEotuBk4iURbTu87/uzfcCTuThy+Ec/4KJ3bB698I1YTrYPHfqbrM1PmM?=
 =?us-ascii?Q?4pYb6LQzjUQHVzpOzJ2ITBMsuugdaSo8q6s8sEVL5l1ru0wjUkTmMY3MCgkT?=
 =?us-ascii?Q?WpaTg+v6dzlyx9iOgLja0piSI8+R+xbTJT0G56MNMHLDtfuimelx+NdwYjaY?=
 =?us-ascii?Q?bGlHBG3kxfqg8m36lsEl7JGvwzK+UIEiNVzZexVsyrvKTJRhbyAxI9ALs31e?=
 =?us-ascii?Q?aKoV5FRzAF8uy0IvtED3YlOpWzFwKYfRuVE/Jt4Kkfx0a1ByqLjyFh/3bkYH?=
 =?us-ascii?Q?4zXS/+zUN0Lf3inMjpAw+b826C59CSutt3zBo05JLGzhRWax9kx0aR9QWKDw?=
 =?us-ascii?Q?yWBHZ2k3DTpLRrlRpJ62Ycl0iXy0dLHuT6gbSkPhTslGZH1q0TxQ9TQGV6Xt?=
 =?us-ascii?Q?iiqL8A2EsuWz+Nb259MS9gpcmnAD8SlTJjFp17b+QjMH5tafthMjxeZAPeA6?=
 =?us-ascii?Q?QfmaoQ5YJTbp3AN9jdkF74D4TpN4Uu3LGnAfEN6Z5oHvow9eRT7ZDEsapS/1?=
 =?us-ascii?Q?iw70HfrIbdrhmOI3InApNBajxZFOJTRC8qhVve7ot/V9Urgj0h0pJGVss1gC?=
 =?us-ascii?Q?bEhp08RRO2UoJpMNB6U15+Z5xMKuW/75TvWZjxWWKLJbGAXXzWflP6Z1Dwcm?=
 =?us-ascii?Q?eay7DMnZ9sCtW9zQEoWAt/y17AhkNr1stqGeNQDaDHh5/RxrFHO1bHCMZe51?=
 =?us-ascii?Q?Ru8jM4l9tCLLoUA+J7E3YlUFT+iLr6oTjgb13MkrZLD7OuV4b8a7JrI81huU?=
 =?us-ascii?Q?aMaVmU6pSUTm4W4g9R03Vb+kmKd0DZvVD/eCCFh7+m+IJ8O7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f75615-4252-4fcb-affd-08ded5c105fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 09:30:13.8576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PbN6hut3eoCGa4Necdr8DCrksDoxHRqPGJF/lJwmQqcp7AmMs1G0DNo/9MN6l39p3k5ltA4DKB7mqg9D3A9rgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8055



> -----Original Message-----
> From: Liem <liem16213@gmail.com>
> Sent: Monday, June 29, 2026 10:38 AM
> To: Carlos Song (OSS) <carlos.song@oss.nxp.com>
> Cc: andi.shyti@kernel.org; Biwen Li <biwen.li@nxp.com>; festevam@gmail.co=
m;
> Frank Li <frank.li@nxp.com>; Frank Li (OSS) <frank.li@oss.nxp.com>;
> imx@lists.linux.dev; kernel@pengutronix.de; liem16213@gmail.com;
> linux-arm-kernel@lists.infradead.org; linux-i2c@vger.kernel.org;
> linux-kernel@vger.kernel.org; o.rempel@pengutronix.de;
> s.hauer@pengutronix.de; stable@vger.kernel.org; wsa@kernel.org
> Subject: [EXT] [PATCH v4 1/2] i2c: imx: Fix slave registration race and e=
rror
> handling
>=20
> Caution: This is an external email. Please take care when clicking links =
or opening
> attachments. When in doubt, report the message using the 'Report this ema=
il'
> button
>=20
>=20
> In i2c_imx_reg_slave(), the slave pointer was assigned before
> pm_runtime_resume_and_get().  If pm_runtime_resume_and_get() failed, the
> error path returned without clearing i2c_imx->slave, leaving it non-NULL =
and
> causing all subsequent registration attempts to fail with -EBUSY.
>=20
> Additionally, because this driver uses a shared IRQ, the interrupt handle=
r
> i2c_imx_isr() can execute concurrently and, after acquiring slave_lock,
> dereference i2c_imx->slave.  The previous fix attempt added a lockless
> i2c_imx->slave =3D NULL on the error path, but that could race with the I=
SR under
> the lock and still cause a NULL pointer dereference.
>=20
> Fix both issues by deferring the assignment of i2c_imx->slave and
> i2c_imx->last_slave_event to after a successful resume, and by performing=
 the
> assignment inside the slave_lock critical section.
> This guarantees that the slave pointer is never left stale on the error p=
ath and is
> always valid when observed by the interrupt handler.
>=20
> Fixes: f7414cd6923f ("i2c: imx: support slave mode for imx I2C driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Liem <liem16213@gmail.com>

Hi, Liem

LGTM. Thank you very much.

Acked-by: Carlos Song <carlos.song@nxp.com>

> ---
> v3 -> v4:
>   - Instead of clearing the slave pointer on error, defer the
>     assignment until after pm_runtime_resume_and_get() succeeds,
>     and take slave_lock to avoid racing with the shared IRQ handler.
>     Suggested by Sashiko and Carlos Song
> ---
>  drivers/i2c/busses/i2c-imx.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c =
index
> 28313d0fad37..2398c406e913 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -930,9 +930,6 @@ static int i2c_imx_reg_slave(struct i2c_client *clien=
t)
>         if (i2c_imx->slave)
>                 return -EBUSY;
>=20
> -       i2c_imx->slave =3D client;
> -       i2c_imx->last_slave_event =3D I2C_SLAVE_STOP;
> -
>         /* Resume */
>         ret =3D pm_runtime_resume_and_get(i2c_imx->adapter.dev.parent);
>         if (ret < 0) {
> @@ -940,6 +937,11 @@ static int i2c_imx_reg_slave(struct i2c_client *clie=
nt)
>                 return ret;
>         }
>=20
> +       scoped_guard(spinlock_irqsave, &i2c_imx->slave_lock) {
> +               i2c_imx->slave =3D client;
> +               i2c_imx->last_slave_event =3D I2C_SLAVE_STOP;
> +       }
> +
>         i2c_imx_slave_init(i2c_imx);
>=20
>         return 0;
> --
> 2.34.1
>=20
>=20

