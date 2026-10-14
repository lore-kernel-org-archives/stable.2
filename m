Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010042.outbound.protection.outlook.com [52.101.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88D2489895;
	Wed, 14 Oct 2026 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791972279; cv=fail; b=gl2VcseYC6xuNbisHZ/yOFfJKMxVQhp9RRzhmzjfC8d4bQeST4agdG+/+xl3pyGlvTNC0YTGeO2E87sBgA5AG+/FcbbW1S23mYLHta5VXANAlfR1OcVl2iVvnF8eDCQpoSdsX+PGv13GTzUP/h4Q3mgQBoQefD+/YLIKXIytGtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791972279; c=relaxed/simple;
	bh=SimMBpdTYw8Ht2RYBsTqMmBCw0yuvD4rHRLv8XjGLGQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dLHFSajtPUfp9e7wNjEq1XLmA5cIk4EjzdxefzEfbYDzRO1iaEWpX8dItnBGUco0SFSkPL+Inw4zB9U070sFbYNFv4GmkrSCsGJG7Zoy0upSY6JfITDZ64tYCApnOuY/Y+nWqRpf94ltmxm/JWozLgFY6J6s30cwCVuy7rBbJ9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=W5QMICgZ; arc=fail smtp.client-ip=52.101.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="W5QMICgZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTYyt326nb9h1t0u0lnZOqMpT2ZxGY+tvyR6cKa/43QEi2VGW2kGQ9u3PRXoLBmPQGHuCI71moj2pVdhyjXIiwe/xM27JdkYkWPqwCt0y42J4zCtZD+xq+jXRnLfdOOVLkSTq/aC+lkFZ+0B5dEJ8O7jCVGKuXmDd1ZeSh/8+BCbu1Vn6U8th0A9/nWmo3SjboCg0Y2AOaygv/j5g7Fp5cfPK8waunmh3+fW7d+X3F+3/0rJCN/Q+rxNSZmweSt4m8iWFqZAJqQQ9D30k09cqXYg7BOaab27KYb0yjcxYfa29m6FCjuopdqwAlqUJtuqhodjKIVr3/iOcXI3QUS9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4/YZ51VMpeGZYT0eOQpoZx3CrGbfjR4s/3xUDsTn3Q=;
 b=djamcz8bv0pBNoj9a29tMhCn0FtnkUMH4V0QM3lkjJGjeDgFCNkg2D2hqPD9k9F6YhTLBIOmNqDi/uuPpKA5/U3zvFzsYtV6mbTGye6mMlL7sUNXRLzgU0en4yX+h5TvqFRO7gmAYjj0SmOzloniS8ozM+ofvaymGiui6SVL/qcOmv4HjqMuHqQZl4thQSZ2HOGVZOYBAf1Q2BGrHC+LlkhO2GdNefGi/n11vaQqfF2Iv8QKdZzddVPMCKkyFgH5HRek+npbAr0aC8eMGXMsScH3TbNbSzh7jfJbb7OvRLiiArrHp5VC6nV8jFeNC2ox974WOqjgfvCSgOkvKj0iYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4/YZ51VMpeGZYT0eOQpoZx3CrGbfjR4s/3xUDsTn3Q=;
 b=W5QMICgZobgpYmzbDQSRPVb2fToDFEMUOqk9mf709ZhHj/zufmsOAYL12dxMDQKw8fcqUN1V+bUodeca6LrYOJkVbLvk5M1QFYG2cRndPl46EXN+70Ox/9wV4X2uxyW8Y/vU/ag+GicliiHJ4D2RFAwMUagXTc+mSj+RtJdYQaQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB6742.jpnprd01.prod.outlook.com (2603:1096:604:115::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 10:04:35 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 10:04:35 +0000
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
Thread-Index: AQHdW8LS9jwUABy5uEu9aunZjt/+TLb8z0MA
Date: Wed, 14 Oct 2026 10:04:34 +0000
Message-ID:
 <TY3PR01MB11346DAF990D6988FDEA9D7E5869D2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261014095927.635132-1-tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <20261014095927.635132-1-tommaso.merciai.xr@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB6742:EE_
x-ms-office365-filtering-correlation-id: e3440b8c-f5ee-4d1c-4a3d-08df29da8ca0
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|56012099006|11063799006|10067099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 94vufMS3XK/yVt6iDekf8cyegh5XreRPX4cACVF4/2In31xULsfE45OACXBu3zIaBU1mR4fb5xD+OleUD9fGI8KJUif/T6eeMtxqxNcHUs23s+ljd24Xw//dTaapmVPjXZj8j6TL5v29bmw65jx+agnjsOotUMoqpxKI1dfakdwigodRO3JmSsdVGuY79dq96LmyYCwW3LIyVG9vlGirFJ4t6cntIc3FLNLt6xJKn46nhKww8gAfsJElet+KW3df4Gcn8CWiW80XS0LTZrfvG8Hy2zF6xN4+Qdm8B2qkzXLu+Zv7d4WUUBBPRj5r0oRLWFl7mcYxJbkAfvShFyxP738ysJyh2LU5YzKb7Fm0FeUfN0m3PokASma4BWqWrE8pNqwn3smIEUCiHnWWrJkpHPom4Bdqd9+vasGDR/CFDA5avka265U0XULXxXdJYk97CM4WIiSC07OMuPuBc0O06YF1tp49vdImGfcYAQi9/tKnv9nyHnC+oLaMDaxmP6ToemOEZmjiQ9GZTXKUsAMTzHzYPvPP1MeybIhz1gG4LqJuLI+e7xJ8SSIo859546mK5PuI6IoYiH2RUCqJh1x48zn46/rQ+uCCI6ve2tMfprS2d9JM55QYviHj8DkVNKeh2gXqaakDaZ17efa2WEvv54b5FdZPE03B+4vCVXodqNqVcvD146apjyiGMcWUXp/n3dMP7LMzWSBVcNQQhKY/Gm/kLAt7z1UyMlNSGOv9WcA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(56012099006)(11063799006)(10067099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?m7eBj8njB2XroBX3ViAXxY3IJyraI8mzzICDRKGuYgmIH3NLrRNZRUUX3bup?=
 =?us-ascii?Q?boVytUxBhr95N470ZoneTZPu2dfjHaU0IClmY7cf8LKAgyk3t7b9cDkogdNo?=
 =?us-ascii?Q?ARIdqB6XWTluk8B50mQ/5HxD+67XoocmNjpLTV1UiIVWvW/7jfam8QbdlkLI?=
 =?us-ascii?Q?rzU9nrT3KO85eBlQRTcmzAKS9s3H61T1BVkaOW5YvWudeeONxJ2l00EkV6ru?=
 =?us-ascii?Q?Ri24mY30X2Vr0nuQ7M+LhlQ9/PJL8tfUacCFM7Iv3QAfBZHC5NWpmR5lFfgF?=
 =?us-ascii?Q?EdMpkC7u6MjfoP7OOeO/0uN6YWQuBFcAuD/AUkotvN4tY/a9ytDGd+SUVh/R?=
 =?us-ascii?Q?hGleP9xpO2tu7Qqqa+41eJAjCUqi3+vIsxQKUMedgI04hqCSXJZPKw6W9BoV?=
 =?us-ascii?Q?iScGNVHx5UqjAr8nQmshjuCSN6FJUZ8p6ANpEgRT0H7gI1cGU8v7psA7YCaq?=
 =?us-ascii?Q?OwR+NIsnE1iUcjLAmY4p8jqXi/NY7+snCxFiefA0dIyNhPOZZIpYFFVj+aAh?=
 =?us-ascii?Q?T3Jw5VhGtWZcBzizd3zF+X83r85BFCkcWy0a6DrBtVa8HnxDO+nxpNtXgmwL?=
 =?us-ascii?Q?aKn5dGQ9K9dqH9uy220IRd/nhw1gmEmFhMIQB0X4HUes1KsEyMCt//fiYHzF?=
 =?us-ascii?Q?r5Y3gRu8WkCPCqCv6+wy4o+cga9zpm34f73Lac/6lvgeSIlNYBGbTSzUj0lp?=
 =?us-ascii?Q?OvLIiBMNRzf31bG87ktQcPwg+VuK3nnirwa1K+8OqYKLVz0RdxWUHnJL11oq?=
 =?us-ascii?Q?EqSnBxmay19o5HflIojMB68kPSc0TqGGpDXRFJZDQ7Usg8cIbq+A3aup8cBf?=
 =?us-ascii?Q?9Y8fHe+2dly58FHaQPCAeKTNvWw+mklLTLjlz7v8jR4VyyA0hueZxO/JsQND?=
 =?us-ascii?Q?MTcSZ8/U7M7bFjs2xrM/tkawAsTmQuwcs2aAg2iKiY5lPDB/Su/m1zh5BtSK?=
 =?us-ascii?Q?GtVGaX86BSJnH1XK6NNTbU9NQgu/B7wVjPEQw8MGxHxMOjwnCLUT/oNe0DuC?=
 =?us-ascii?Q?rwigmCSvlnezvWX/X3nlpqwB9QvV3OOMtdPePR0stDKkysTGDWk7yQq3c1pI?=
 =?us-ascii?Q?BRDMZMS3LJZciBWh2ygf7Ub+TqqsI4XXI3jexn6BOrBEOL9OrorAGsvvlJev?=
 =?us-ascii?Q?EsdpAJEU3CT3+dQq0B0qCWXVeM5LQz6yFfz6lLrpQTHI9YCNAQIGY4R2wAH6?=
 =?us-ascii?Q?u1rFG7f/69fg0nCG42BAtnWtFZrfeMPfun0kchaphO4qjXJyNkzIGQDUSS8r?=
 =?us-ascii?Q?0CLLWUdm1bWqrpkWH+koFMF7G1M7VJI9yQMl6etvazZrfX47oy0mvb0g7hxL?=
 =?us-ascii?Q?tqUBOweusg2K68RNBJuJYYGdHQez27PTepFzZgh7GYQ1U4uWpq9ndLqz+5QJ?=
 =?us-ascii?Q?wqrZ9a/Mb9VUXPvvtvybDdcafP7Ki22OV0TlxKnbt32Ns4gxN9xeJ3+1NGQc?=
 =?us-ascii?Q?sKRklg+dDxIh5IDAgAHGfz2T5PV12IbCDrN12VYCsjAwQDlzKutHvmGJ3Uod?=
 =?us-ascii?Q?VTGbhaBmTVw7fZCKl5q6f0+PQomBk5/xzJGHBTqdK9q36JH2I2elDufB9Fne?=
 =?us-ascii?Q?rzteQ9FJkrJ0qMH00ItEN9Ned0Oc+Jz0nDM8gOSbr1GQuZMB9vEd/xBO2vs1?=
 =?us-ascii?Q?eAnaqJnKVoB+e+NGSpWlmCkZPEuc0UDX/ti2RAJBUxCGKHCNQ8aUaS5ObRqF?=
 =?us-ascii?Q?O0bO6mTux89D4WCyq998+O/kZ4iV24MCXEllfOvlotRyhjsqq2GNGnlBfr7D?=
 =?us-ascii?Q?VVDXpvG5FQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e3440b8c-f5ee-4d1c-4a3d-08df29da8ca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 10:04:34.8728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o0Ts5gz1jVEyeoyrWVIgOaneFwo1a2YTD1w+OSTb5rMuD/TVAAMPOH4DzNhcG6jc/HzqRnXUWpqx1GpF0CYvUwxLWAAqoKJ7s4rKXk3TfAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6742

Hi=20

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: 14 October 2026 10:59
> To: Tommaso Merciai <tomm.merciai@gmail.com>; Prabhakar Mahadev Lad <prab=
hakar.mahadev-
> lad.rj@bp.renesas.com>
> Cc: linux-renesas-soc@vger.kernel.org; Biju Das <biju.das.jz@bp.renesas.c=
om>; Au Dang
> <au.dang.jx@renesas.com>; Thomas Gleixner <tglx@kernel.org>; Radu Rendec =
<radu@rendec.net>; Fabrizio
> Castro <fabrizio.castro.jz@renesas.com>; linux-kernel@vger.kernel.org; st=
able@vger.kernel.org; Tommaso
> Merciai <tommaso.merciai.xr@bp.renesas.com>
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

