Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011026.outbound.protection.outlook.com [40.107.130.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CBC3D666A;
	Fri, 26 Jun 2026 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782454994; cv=fail; b=EFTWS3u+CB+Si3vnSNCGkmETk7Cky1ulZVI6HejSlKCKFk8EAahwE1zfibCZ7azyAObxUhoSs3qlBYfo2d+lTmRdmkIrE7Vq3UfJtC7zx42p7yxLJBTI+yRYdyyoKgswLO3nV3m0Utl0nGB9NNlcHG8f7Y6L3w6Vtx95iynByoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782454994; c=relaxed/simple;
	bh=f0+4TNJ7cJw24SMJ1TrdMcnZzogZId5pXUAEPEvttZk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ot5Fq9cQpFJ3mS0LzyEIS+3EPeuFYW3tvqwCuETYRorN7KRRGYrskg/nzcjXKVLRz1kWY/B/V4Lkcgrt9AIJE/hB9pnIBITPecmfI0vF1b/bDstm8CGxQA620x33WitoEJOrrNO2b4OYNpSvJBwRQOkDGQfJWp3G/nMW6qOh8Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ov/80l+h; arc=fail smtp.client-ip=40.107.130.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ov/80l+h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4YVRLQPKd3kzQ/BhiOM89j2OyOOBw+HowsOG1LAnGjTcx7D+FakovsDWjdWaXXNv7cBnIVdEXKc+bGQdagBFeoIeuH30LQKQXyNBV/Knpe5yAsavyog9GDOevNyE14jVLc8LQVp+hRlcP8WzWFnYNxuGuTeAMLfwNqFayST6c8sJpePgyNCSbSprFdtN1gAXhPYHrtroQeJ2EOsGHyxFrAyP2ckN1hBvI6+H915cvL5K0PM/+2yr/SqGXw9dBytDNf9doE9pGz3ukvUAcgZY4na33BpqQmrYQoqItDY9JoSMvh2ZS8T90Eefo4ZTqyJgrWGn0V83m8q9bLYEqHF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUQZ6ECZifSBVMAbhnFeSTzY4ycAXCqm1vh9j4tp9jg=;
 b=DW278ZA8TgDJX0Jifd0Tdv397RhJ9Cb0XD3NUZ8sAhpiGSpqaUmaUSzUbtJXih+CqQbLT0QVzV1JjvAVnCcK09PIt/qOOVQQGb7iG1sPs2IKhSXlB5b1aCQP8Yk14zjviFzVDDqmfaS9UDZhr6s9m3vPk4V7ImjLZOM8ppHn1zE9/Pd2Grn+JwcIng8/dWonQqfriN9OoiVWvJbfzGgbWm5zRwMLbVOXHGWpsZ6bGrbUt7qHVfRvxPE0zxr3wpf3pt4SJOuwsHTXasddRv0MQoImoIKzD90x5HkFL2M2uCwpbS9wi1j49VQfXWXT8/wn3HJLrSC/TSGhq+1gYXw+Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUQZ6ECZifSBVMAbhnFeSTzY4ycAXCqm1vh9j4tp9jg=;
 b=ov/80l+hv7SoLP5BaVX7RTKxFa9PRNBm2k2IV/nqjRNOxSkVPW2T0+GUPpED8l9r/SBSV/sv/foXGfgu3yR+c2rP1oa3E4+KuiQnnPonaQ/ZGhJaWYJlxSTNnlC7uA5GRoXX6GkDZppItRr4waOqHd9QeDajY8mCQYso/AUhfEU/+kX+ueWLm81/UydpYC43BN7gqJSK2rAej5AEkL31J/co0AeQtRl8dJCDURwDTBN8r/CFfvGNpH2ECzH7b7kDFoloWGywbCwcOmaKsZC/gZis3JN3tDWNzjiyxqFfw8YwOYSGhUXyUIpTJ3hwYtsoOypTBuguFGrpD02ER1FLjQ==
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by DB9PR04MB8106.eurprd04.prod.outlook.com (2603:10a6:10:24b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 06:23:06 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 06:23:05 +0000
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
Subject: RE: [PATCH v3 1/2] i2c: imx: Clear slave pointer on registration
 error
Thread-Topic: [PATCH v3 1/2] i2c: imx: Clear slave pointer on registration
 error
Thread-Index: AQHdBTQ/aFJXFxn/x0CxIaV6/MYxPA==
Date: Fri, 26 Jun 2026 06:23:05 +0000
Message-ID:
 <AM0PR04MB6802B863CD9B9AE1609C1785E8EB2@AM0PR04MB6802.eurprd04.prod.outlook.com>
References: <aj1UR5ddawsdMbZC@SMW015318>
 <20260626025846.106157-1-liem16213@gmail.com>
 <20260626025846.106157-2-liem16213@gmail.com>
In-Reply-To: <20260626025846.106157-2-liem16213@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6802:EE_|DB9PR04MB8106:EE_
x-ms-office365-filtering-correlation-id: 645bd355-3ec5-4611-fb1a-08ded34b624d
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|23010399003|366016|38070700021|22082099003|18002099003|4143699003|6133799003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 COsZJ28tskx03qYGFzHHYnMOEVzRlyDYhoxdeynE1GMaTQ8D+UYntBQ6+9v0iGD1P621BYEuY62h+xCts/r6w6nqIjVjSr9PuMvzBBINmf3L4A97bA/Dku+jCpmXSCe2yYCRoTZpYOhNC4nl40AFFFboMYckfXtmtyFvYHWvSWlCLdO66XSNgORyjdBIzfFBwowYdh1stZZz0S7dymQCwHPiAD6FNG6CokU3HBzV6BkfCadHEukRbjF4q4TxbqvVFqeJ3oJs1Qssx2jlATLbNAFWODrQQCb6hZlZpryllQvxP8pN1QqQ4ZGe7vDYSQ0620l2pQhZqFgD9cp+ewajTJq7yLJxfjUElD9OqEh9m2Ry2v9EaQg/FCexkDlk1PUj4ayjbwnbbttTWzpUZAAJGxQJ/7Qm34tjHZmWr5rEjtSBBBye2KiJLrx3EuVVuUAxGRRORsyJqm5PwxwAIVCdeMw8OGsqdaSB3JaEYsuHz1355II1n1MuLrsb1tMlWNCZjqCCzKPeajFMenramAneCSd/GxjeGjlAHpEJiYxzkKQZ5YauTzpVjX2bfOIND9CjQiFWkSsfD0Ari+nBhRpdFwgd9/78heZzitNAi1lp9g/Lpq951IFyZEc0RBwgzYrvHzt2CNFhkYJJVchM0yHjHambnLPX40jFd254KVUpyft8ULuZEe6vcv1BszOpf1s6+zUzJYulbxQjwV4Ma6dGe/oO2Zo1oALSF861Q89XnNs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(23010399003)(366016)(38070700021)(22082099003)(18002099003)(4143699003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?W5mWmLBr3ZkmMVCHgVzXEfoLbMC6AX5eB2edMnMq606BdRHQNqEKw/bXGx5a?=
 =?us-ascii?Q?jaZprzaMV26C7TSqIaOmgwhZAtgp9usPjm0f+boa/ylwlQBoz1qNYMUrm+Oc?=
 =?us-ascii?Q?xgaprB3dNBM61Ql9oMd12VLZw4o4VdfHVNgyRxkWssRDum7JOEwZSmG+FB7a?=
 =?us-ascii?Q?7cfsFag9yDDtsx1tAMDuwzdVLU5FH9mKUiL4NFQ+li9VVrCEAkdLdfxsQ84E?=
 =?us-ascii?Q?NuEqd83ed9budGOutSv41Gt8xmVOdBPP/n2lQpRAXJl9P5S55XCZi1NFaLkG?=
 =?us-ascii?Q?796a1S26/71dW8yHvn8Q6YsSVwnf7aX4rUK6eDzo+KDkNQcrWaA9N4szeuHs?=
 =?us-ascii?Q?SR5PGnhGvKhwlKVh5qVsZBRxTIi3+9Dgffphf7/U3tOvWOsQIUKWmtnJtPqe?=
 =?us-ascii?Q?1YWLQzqSHgXgFxmvNWpr6EbVpqnYx++TV+P8LrqhgtRJglZwuUlWdSDDzNqz?=
 =?us-ascii?Q?9oOF2Qw3jCzeyEPF+zLE8eH+Hs5lKw2FauwmKyfMT33GEM059gAjTZ7RE3eB?=
 =?us-ascii?Q?ABDa1MPDy3zoy5uxvRTPOBoBVpZIs5G0YVmRWQnUFTyI6yKs2zB8vvrN43uN?=
 =?us-ascii?Q?MHGY1rkqNT4Xvkc04FeOLpiTSZqEQY2xtu3qwuOdc0Glm9HB3jOoKJd8XQcI?=
 =?us-ascii?Q?/cBQUKH4XDj3pHm2CMNIVX8U5rqXZcrPlKF5JRzRS5baYwfpB+VNWlFFVyHs?=
 =?us-ascii?Q?ShPhCDUWmLCY+3xdCGSVlfZj11xcMK5myepDqQJHWYFlOrlw44NZQmsH+5rw?=
 =?us-ascii?Q?vKEHsLdNNTBLsX1V6ru9WFHCG2wFX5NJZbfBbWznIZc7rYmkMGvtjXfpUbnk?=
 =?us-ascii?Q?y/lpJROiO/0Mi0MyDifSRswdosc/Q2uVveExg5Ox6ZWbLQ8X4TuiaMDd6yNR?=
 =?us-ascii?Q?9dg5UAFftb2zqwamO0HfP5ISPPU/MOBwbkqgYPbYsDCIX0ii29BX+udwYiLj?=
 =?us-ascii?Q?hEDEJDDBSaOAD2GPbl8bwOevTkDL5plJXcHIzYFWJVcCfnnP0zlxYD2ebVvj?=
 =?us-ascii?Q?OybXsTLXPEYxMb9YVSSm9KtvZEc9QpZGLeMdQ/G6DfbUSsOtsYmgI515SMz3?=
 =?us-ascii?Q?wmWWTKgmVBHfNA+6/9plk2FJAIO0vPqF+NSrdogDmHz32NOytiqARTgWxSye?=
 =?us-ascii?Q?Slp1z5iyHzcsumt9JvmnUcWhbi3RGP5Ez+C0/LiWjFnW3tNAEWTcYd13ii25?=
 =?us-ascii?Q?WLvoFThW3uUrOzWVNt6UAryWJCeWE783l474rI3DznFyx074MAlRmHfPmnUe?=
 =?us-ascii?Q?L5jNIuFnjHT7l+9tU9P/CLD4GqqVbyGioAOVnK4lKKM3pySiG2h5JKEIMwpJ?=
 =?us-ascii?Q?7wd96tJfGs25YkPP3EoRcPVjDfSeQEV7qoR8U6dtRixZilyfokXfbH69xmlX?=
 =?us-ascii?Q?eDTYC9+o4gaFe/6mOkqEMrtyOtkamFM1WKmOCFFR2oeLH/H1hJ3hZhryOVGI?=
 =?us-ascii?Q?t5/iX6L+FPMi3U2ZThZdY7T50jWNV+mCSltnz9pfVkt6BioXWDuSw2XqYdOb?=
 =?us-ascii?Q?1qg0OFTVmWVfWQwgaC3pQo+Ka/nodpnDBmmEyfJcRBpgHyF+YKBvR8CfcKLM?=
 =?us-ascii?Q?jAJMxk552Df/whXHJ5+VdzXvVyM9smXZVvKB0hwVBg1ULnY/UCUeXHr4d2E2?=
 =?us-ascii?Q?hSa3YPWMQrCzFhwdUkCiSkHrj9ZuUbHCeUNB7CJg4AKjkzLRCS7/QPtf8fFs?=
 =?us-ascii?Q?HavUmv24fzWaRx9xiLUdexY2XgDKP6k1qSf+610hvIjfWpM6YPhO5DZP+bJv?=
 =?us-ascii?Q?WrYA0eJaeQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 645bd355-3ec5-4611-fb1a-08ded34b624d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 06:23:05.8346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jbJr9hevalubxVV2adPilpwLXREoDpgh+/4mIYIeafA5fpOo1vjfHfF9uXgjqekbK2S8Syt479CrW/C9PSf2Gw==
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
> Subject: [PATCH v3 1/2] i2c: imx: Clear slave pointer on registration err=
or
>=20
> In i2c_imx_reg_slave(), i2c_imx->slave is checked at the beginning and th=
e
> function returns -EBUSY if it is non-NULL.  If
> pm_runtime_resume_and_get() fails later, the error path returns without c=
learing
> i2c_imx->slave, leaving it non-NULL.  Subsequent attempts to register a s=
lave will
> then immediately fail with -EBUSY, making it impossible to register the s=
lave
> again.
>=20
> Fix by setting i2c_imx->slave =3D NULL on the error path.
>=20
> Fixes: f7414cd6923f ("i2c: imx: support slave mode for imx I2C driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Liem <liem16213@gmail.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c =
index
> 28313d0fad37..17defb470776 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c

Hi, Liem

LGTM. But I notice Sashiko give a worth-considering topic:=20

Can this assignment race with the interrupt handler?
Because the driver uses a shared IRQ, i2c_imx_isr() could execute
concurrently if another device triggers the interrupt line.
If the ISR acquires slave_lock and evaluates i2c_imx->slave as valid, and
this error path locklessly sets it to NULL, wouldn't subsequent accesses
in the ISR dereference a NULL pointer?

> @@ -936,6 +936,7 @@ static int i2c_imx_reg_slave(struct i2c_client *clien=
t)
>  	/* Resume */
>  	ret =3D pm_runtime_resume_and_get(i2c_imx->adapter.dev.parent);
>  	if (ret < 0) {
> +		i2c_imx->slave =3D NULL;

>  		dev_err(&i2c_imx->adapter.dev, "failed to resume i2c controller");
>  		return ret;
>  	}

Is it helpful?

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 73317ddd5f02..e50058fd39ee 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -930,14 +930,16 @@ static int i2c_imx_reg_slave(struct i2c_client *clien=
t)
        if (i2c_imx->slave)
                return -EBUSY;
=20
-       i2c_imx->slave =3D client;
-       i2c_imx->last_slave_event =3D I2C_SLAVE_STOP;
-
        /* Resume */
        ret =3D pm_runtime_resume_and_get(i2c_imx->adapter.dev.parent);
        if (ret < 0) {
                dev_err(&i2c_imx->adapter.dev, "failed to resume i2c contro=
ller");
                return ret;
+        }
+
+       scoped_guard(spinlock_irqsave, &i2c_imx->slave_lock) {
+               i2c_imx->slave =3D client;
+               i2c_imx->last_slave_event =3D I2C_SLAVE_STOP;
        }
=20
        i2c_imx_slave_init(i2c_imx);

> --
> 2.34.1
>=20

