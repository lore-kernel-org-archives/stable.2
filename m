Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013004.outbound.protection.outlook.com [52.101.83.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AF22BE035;
	Thu, 25 Jun 2026 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386279; cv=fail; b=L2vA9Uy9/sjW8aqBzvVHL9zBDSotpX/bhvt5HCWrmQzKNAadBVhFXYYprCicRDDDRRTlUfnBU7lgOVuqMpJPt5ADM9rvK+RWux8YbThL9LV18f2uKahawoLJoXZjPcT/zKEPjYz+vG/oE0tBfk8s6ySl3rVj2iITdNuciOjMgcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386279; c=relaxed/simple;
	bh=Wck3ZAMHtLwIa8uT20atU83r1MqFywPReyf1loGU2ck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u0STagx2dRTCa4gS7FOKYMl0tk0d0sAZS6NabcDyFQtJZfV3/eWkTkrSNlRYJB9nTAwaDOTOcKMxefA1HwZz0u7sSSiil0JJPMN/GVxn0Abz01VAkjMuyALdI09VuwFbgFWECxofLM5bUxptJ0Vm+ouBiNU+/Keq9QlwKP8PkQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bpNcxIn4; arc=fail smtp.client-ip=52.101.83.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bpNcxIn4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngddBmI08eviWvBGQX4YB8YbGuOTGyxY660QGki/EdRwRjO72I8zZdpiiONtffulYNkK3eFVc2NWWcAwD97OckDRSvz7IdkuhPfuWi0ybq5MxnSeWxr/LPYVzGA3/agrtWaMACIV8nvIIyOoo0xnaEwEfC1MQGlE7+yYRadzh2IHtBqrUA8VN85cC/8GVWFWner3lPwTEwd9m5dqZ8AqXb5dCKawfJy4+JPMqUk+FjcEWtTu4QIsnExvJG3pvoJZibU/4+fjZJ18y+d6XfPfAodOtOorzL5SEFbcJMBI45kC/fvek3iFv0vCwEk7Ge4qAOwRApV7UNYVRtJc2dIykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSR64S6Aqa6ktWZllA6jH0aHgPNk5Mazi+gTKN4jgpc=;
 b=HTL7dOIS6lrx/UuESQTw0h08AAOluCvwrIBiSbazMNSceMiwPGapjS1wauBpDTqmFxciZnWLqbOwNDKT3Im7iHZwU247oma8tP5eKtToM2Tt/SIaigWeL0IBRDbgJBk1/JxyYMY3pfP36FZ0vZM/dpSTmSX1qTB1c2qwoaMyZa+wYdO9GYCcQJryxiHMcpgRjqzJr0PAJNEf32M2Fe6Iwu05yHMWytZxGzgVNbvvPVFZujXZnxZt21sNq/qy00fG1FpVCShZQSCwZxUX9mqljQkkqMq2IfVGTjl5xZd+NxiBsXdceWUDh1EzhoxtsPhAMAj6TVd3XmDtLyAwtWY8Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSR64S6Aqa6ktWZllA6jH0aHgPNk5Mazi+gTKN4jgpc=;
 b=bpNcxIn4kEVfBnSMDGxlwliO+6s9+LrbfCS1xJmsmdiLq9pDzqhyqxOysnUPfHuADfAdXiWbsMzIH+uIUO1MQWIqqbjRl5Dek6Le/kkBKRi6/VXdDMIdjgiNBfMGfFyDGInKJywdUMUj7PzNEGTZA6V75YbTH/GsVbPD9EURITF7DDQP+PYaLVfFadG5GiKAogiGI8L791ol1AXMS+6HFA1Ex7nhX0N0pLsU35aolXMv9HGHQS0c/n9bUuBSIH794iOc+gXXUEkTLhIabe+WZ3C85wl1MDjaY5FjYERdvsvZtJ0KTimHVgaeDosfW3GDvGMvnW53RzSyNmrMkoU1ig==
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by PA3PR04MB11226.eurprd04.prod.outlook.com (2603:10a6:102:4aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 11:17:50 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 11:17:50 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: Liem <liem16213@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>
CC: Andi Shyti <andi.shyti@kernel.org>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Frank Li <frank.li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Biwen Li
	<biwen.li@nxp.com>, Wolfram Sang <wsa@kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] i2c: imx: Fix slave registration error path and missing
 NULL check
Thread-Topic: [PATCH] i2c: imx: Fix slave registration error path and missing
 NULL check
Thread-Index: AQHdBJRCYLZIRGV8v0Ks9SBmILGL8g==
Date: Thu, 25 Jun 2026 11:17:50 +0000
Message-ID:
 <AM0PR04MB6802E046B76A723EA3EE8649E8EC2@AM0PR04MB6802.eurprd04.prod.outlook.com>
References: <20260625071130.93544-1-liem16213@gmail.com>
In-Reply-To: <20260625071130.93544-1-liem16213@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6802:EE_|PA3PR04MB11226:EE_
x-ms-office365-filtering-correlation-id: 8069ebf2-d269-4e7c-ff3e-08ded2ab64dd
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|23010399003|7416014|376014|6133799003|56012099006|11063799006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info:
 JG4Tkc7VZSLLkbQkV0Yhdy9G8g6cA3oXvdoQypQFQZUZJUFic/ldEKUKsIbSnxXj8tIDVGvm5u3hJC7b9jf8pu7n+2wGgWZ4lQthsE4RZtPjHb9UbALlx+0gHnUnmL+vubpL+3c6P/1Qosd+hhrLyQwrDFjx1/KDEJd7F0c0iHXhZnqIKp0CfRwSJTKFbefzwJGdRqwGfN8WGepGAG8gNgRQXKDNwFHJsQYDbwnztKGu7w/5SBi680TOlkLlDrP9rDFpa08NcQlCEa/u44/xXvEZLAFVMFXtsDz4uXriRLn9b6eoJdtCB6GYx/YpCd3aUZjrUb+qxax1H1Myd8w1+Dmv+ZqWeD4/TO+5JacXn3irVBcJhxm4r5+v37bu+LNJaEFFF8Biai727eUqEJKEFcGoy9V+8EABFz5OH/2v+IK6cfX+DJz1r2wJHXUQlMHz5IcNe3ZwFM2CtJTk0kAAEbaKy6yWvSnEs+6wK06f19QGCelw2U7RB/LczblU4Wz3nh2ffJ/eQXPxllLc5Yd4HrtT312PsCVL6eX77xDWFubnajVXRNs7U6RBBXGa6yWCTLex5AkDLZaxZQRHO8bKd36MgumSn6zauoq8gP1Gloflvyu8Utu+tBH9yaT9C2944Dlhau4kDU3re6mHRcv/6cvtunA/2qi0FNfkrNqMMmarue0feywGuSS2okGhkyXKjisWyYJPxfazVCBTiGUCDf9QL/PNyZnR8Ohs1ueEVTs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(23010399003)(7416014)(376014)(6133799003)(56012099006)(11063799006)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yXCFM0GFy70LCI5IQ/cDsBptu2J7eMmZdTBE1ygmQY3wi9sfAXwH2W/cGfM7?=
 =?us-ascii?Q?ZesVC9v8AHwBzDoXi9ssqHup7/LsQ9GKqoZ1jm5O5PkonpqQFU54rJBPiogF?=
 =?us-ascii?Q?H1NwGBtkINKXmjlcQTj3u/Tf7fEX6p/LPYwmVRVKZ92B7Pvl5m/IvwhN3k5b?=
 =?us-ascii?Q?fR5xoyalwsFTTkwU/LsBlZLLDmgZH/Tfc6zlNZb+mYb38c00necTecaeroT9?=
 =?us-ascii?Q?4lppp5pPQSqAcHuzj7iMsS1Q4cl/kfcp9Zuu4tiuZIKINcZif14159kVexOh?=
 =?us-ascii?Q?VGbj5lYjmLgFUQl8p2yxVyyK6Kxixf7hTLxobrdRKEkOrlED5UA5QP4zPL1R?=
 =?us-ascii?Q?tdDFuK5BJIlIeOJfZ6d87GdvQxv8klt+y+igLTzVmR16PEwdZgKK3yE22txn?=
 =?us-ascii?Q?mTN49aoUSGbZaVZ+08mTNSJBhu+AEiboK/AQqxNC0kQUtPsHYsqgXFdri17n?=
 =?us-ascii?Q?+bOuCkc9VZVfLu+4h2squWFBDwJRUgraZOcFYN2eOPi952x4y54DlGqH549Y?=
 =?us-ascii?Q?0E9Gbl/smWIIdxVlRuxdmMwxjuZGF3y6BmRfOcI82Kfpr5pO49x7pwgc/trM?=
 =?us-ascii?Q?s7ZKJl/DeYOsWratnFUygQtVZCgZIXvx933B7H7GD7PuDAu3uUCSr5SNNQxe?=
 =?us-ascii?Q?0D70YYMwRiJo1iRcB8fj1p3/AWmtccO8bVs8In4gHGr5Dwi0xyGPq05KHBM4?=
 =?us-ascii?Q?AuETvW4tSd/rXy5ILuX6tXprShIZ1MSf94MIolYYi4HlSMOQWCUDdfMLpMGU?=
 =?us-ascii?Q?FKFfGjrD+0Uy8tfQYFMWzJwD6pU1Me44UvDxdYTGc9YMzjBTezA/+rB0l9pF?=
 =?us-ascii?Q?g/Z1V3ij1xF9Q0Yq36AP3KYAxLEb8icqxcVSe6X6oqbUU6zOWSr8V3ljlvya?=
 =?us-ascii?Q?6PPCyuwE5rYPOB2n3vft0FNEXwrIcX75sdxzGKM2ds3BybnhTdsphEVx6CGd?=
 =?us-ascii?Q?jTIMktmHPYj4Em78F+SlKgNZwCrN+QAWz37coUqLbvfeUJmc7/ejHVp4ZeNK?=
 =?us-ascii?Q?lhUSsYcFe48LLys0sAxdw+b6y8dTGkBFf33hSlY0GKD+xL4Z/DYJ2g3iYrZL?=
 =?us-ascii?Q?mXK+4YyDy/Y2gi/CwKmnmhO6DgoMSEJTA0BPfAKQ/Mlod4urytBbpyPUEjyY?=
 =?us-ascii?Q?cjI7ZvM4+87qtkdVmHbngUkcOVztv10CT+yY1n/5T3RLYyhu80Nj+WKC0zhh?=
 =?us-ascii?Q?Sj/Y3fl1BRvPDh6muvkfNoyk2KiVZBrU3jbsK2LW2DMhN7wO+xIh1JXTYqmJ?=
 =?us-ascii?Q?iunBVyLHmWtv9kJtlAMZtef4wJlIKqy0etbs6Q9OFy86vVMMaJR1t4xcKXRm?=
 =?us-ascii?Q?UrCGuI+Y3r0AZHp0t8LF715To6IR5LVRLvBrskeufC3x4KyZ383p72kRiO5J?=
 =?us-ascii?Q?/41ypRt3YodLFr2VrvtRIivkXHtuqFj30KYLOpO2KwcCyOD6EW4usjPpKrmA?=
 =?us-ascii?Q?waoypDKd4eHo/WYR/kovOBk2Qbc0KAA62ZgmMP5hmD6jHY/ntkURNpEyTGlH?=
 =?us-ascii?Q?iuAHSZmFU4uCFUiyS8jw66nn2hDu3OCD/ascjIl5Gqh/d4P3Q5/tPwsiwAPn?=
 =?us-ascii?Q?ozekkqDOMR9Ayvy1pO1Dxc5xwuTEc57SPidp/SyoY2wek4/SNtQ/MRrhvJC1?=
 =?us-ascii?Q?3WDF6tBWbdMV9qk5VSy+gQ04vDNfWJXURZw5eL9TDej5kHx1pGENj3l6EfF9?=
 =?us-ascii?Q?2Ose1+X+s53zYmuDTwF/JOTHXZd/t7bFZ5soqH4yBqcNyB3exHZ2+OOllBNr?=
 =?us-ascii?Q?VeFm+sYfdQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8069ebf2-d269-4e7c-ff3e-08ded2ab64dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 11:17:50.5675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJo52ILwq91IIKlK1IaRfC/e+biIHI4LZjyAbP4ouX8igYIZgIdWKwyiUNRixWWBKC9uffMLJlImwJuJK0ri8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11226



> -----Original Message-----
> From: Liem <liem16213@gmail.com>
> Sent: Thursday, June 25, 2026 3:12 PM
> To: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: Andi Shyti <andi.shyti@kernel.org>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Frank Li <frank.li@nxp.com>; Sascha Hauer
> <s.hauer@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Biwen Li
> <biwen.li@nxp.com>; Wolfram Sang <wsa@kernel.org>;
> linux-i2c@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org; Liem <liem16213@gmail.com>
> Subject: [PATCH] i2c: imx: Fix slave registration error path and missing =
NULL check
>=20
> [You don't often get email from liem16213@gmail.com. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> There are two issues that affect the i2c-imx slave handling:
>=20
> 1. In i2c_imx_reg_slave(), i2c_imx->slave is checked at the beginning
>    and the function returns -EBUSY if it is non-NULL.  If
>    pm_runtime_resume_and_get() fails later, the error path returns
>    without clearing i2c_imx->slave, leaving it non-NULL.  Subsequent
>    attempts to register a slave will then immediately fail with
>    -EBUSY, making it impossible to register the slave again.  Fix
>    by setting i2c_imx->slave =3D NULL on the error path.
>=20
> 2. In i2c_imx_unreg_slave(), the slave pointer is set to NULL after
>    disabling interrupts.  However, a pending interrupt might already
>    have started a timer (e.g. for slave event processing) before
>    the pointer was cleared.  The timer callback
>    i2c_imx_slave_event() dereferences i2c_imx->slave without a
>    NULL check, which results in a use-after-free / NULL pointer
>    dereference.  Prevent this by checking that i2c_imx->slave is
>    valid before calling i2c_slave_event() and updating the
>    last_slave_event field.
>=20
> Both issues can trigger a kernel oops or permanent slave registration fai=
lure under
> certain race conditions.  Add the missing NULL assignment and the missing=
 NULL
> check to harden the slave path.
>=20
> Fixes: f7414cd6923f ("i2c: imx: support slave mode for imx I2C driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Liem <liem16213@gmail.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c =
index
> 28313d0fad37..4f7bcbeecfd0 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c


Hi, Liem=20

Thank you very much for this fix!
Looks like you are catching a corner bug and try to fix this for i2c-imx ta=
rget mode.

Have you meet the issue on one real platform?

> @@ -775,8 +775,10 @@ static void i2c_imx_enable_bus_idle(struct
> imx_i2c_struct *i2c_imx)  static void i2c_imx_slave_event(struct imx_i2c_=
struct
> *i2c_imx,
>                                 enum i2c_slave_event event, u8 *val)  {
> -       i2c_slave_event(i2c_imx->slave, event, val);
> -       i2c_imx->last_slave_event =3D event;
> +       if (i2c_imx->slave) {
> +               i2c_slave_event(i2c_imx->slave, event, val);
> +               i2c_imx->last_slave_event =3D event;
> +       }

From i2c-imx.c driver, I notice this call trace is:

1. IRQ-> i2c_imx_slave_handle-> i2c_imx_slave_timeout(if in progress)-> i2c=
_imx_slave_finish_op
2. IRQ->i2c_imx_slave_finish_op

'''
In i2c_imx_unreg_slave(), the slave pointer is set to NULL after
disabling interrupts. However, a pending interrupt might already
have started a timer (e.g. for slave event processing) before
the pointer was cleared.
...

Yes, this may happen, then trigger slave hrtimer running.=20

Go into i2c_imx_slave_finish_op().

you add a judgement in i2c_slave_event():

if (i2c_imx->slave) {
	i2c_slave_event(i2c_imx->slave, event, val);
	i2c_imx->last_slave_event =3D event;
}

At this time i2c_imx->slave=3D NULL,=20
so i2c_slave_event(i2c_imx->slave, event, val) and i2c_imx->last_slave_even=
t =3D event; won't run again.

in i2c_imx_slave_finish_op(),

Fall into" while (i2c_imx->last_slave_event !=3D I2C_SLAVE_STOP)" the loop.=
 So system maybe hang.

My idea is just cancel the slave timer and wait it finished after disabled =
IRQ.
If I am wrong please correct me. Thank you again.

static int i2c_imx_unreg_slave(struct i2c_client *client)
{
    imx_i2c_write_reg(0, i2c_imx, IMX_I2C_IADR);

    i2c_imx_reset_regs(i2c_imx);

+	hrtimer_cancel(&i2c_imx->slave_timer);

	i2c_imx->slave =3D NULL;
}

Carlos

>=20
>  static void i2c_imx_slave_finish_op(struct imx_i2c_struct *i2c_imx) @@ -=
936,6
> +938,7 @@ static int i2c_imx_reg_slave(struct i2c_client *client)
>         /* Resume */
>         ret =3D pm_runtime_resume_and_get(i2c_imx->adapter.dev.parent);
>         if (ret < 0) {
> +               i2c_imx->slave =3D NULL;

This a good fix. I agree with this.

>                 dev_err(&i2c_imx->adapter.dev, "failed to resume i2c
> controller");
>                 return ret;
>         }
> --
> 2.34.1
>=20

