Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012070.outbound.protection.outlook.com [52.103.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33692882AB;
	Tue,  4 Aug 2026 06:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785825032; cv=fail; b=Tl+fkOYZxn7mYQGWJynz5thpXdi75ACKS+u2P3j0tA4ETRHGgZWfa1fjmkgAJ/aM2pRnNmEqB17DsldrqMlMAMKDfOe4t9LccBaYDBtW4Bbn7IjRlqNafMdaJ2Mj+WvM6Hb+GVeB/xrqrcLpEbllpYY7YpQmGM63FZq9RoK1M3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785825032; c=relaxed/simple;
	bh=OHs4Z4Eu9gj8StMb3qYUzAKXItmuHRPDFzF0wxn2gBY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kt86MgOc1Mn4t3xPUaRJdRWqdiF2+nbA3CZrsocwbUKpFqf0dJYl+H9l1kkKJSEMHe10QhOelNpIhdDJwgkHzqoKyw9T3z6TzO3T9pVa/0W+iblyCp03nIkMRjx8pUz5vV/ViDYzN61u0R8u9M/u3OMOEEy+2V7h1ael4Xm0rys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aZUJsyOC; arc=fail smtp.client-ip=52.103.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aZUJsyOC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHiAwT8zSvE77iokkbvus8ciD7uaVz9wtVRb/98LnneCxKpB19RxdNGDmNlHSW58MoPebrV88R4wy6J0REmcrB9D8DTDDqslE5U2tHR4GbTWmRhPAkySD0KEEmqWW/7Mbzda06RYejW4YW2DP1QjfPLeRTpcwftOg3YobauPQQEa77EjZ93UmdcfCLNl+jhcl5Es3dtg/vLfCXcB+0MXLRXOpzFpCfN6JbmR+czuTg1kPn/A9sw9JI629tMdeXHQlRdpsjhzaBMXxeOMJAp/kbdiA5nAsLxqtICrxgqhOjuwQc683wjkbOle3h22WxIJgplXtLw9nptMoeQUuFFTXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oqv1Goa2AuEM2ktQASSjFeUVDFzi4LBiYShFsGNFQPo=;
 b=laOh+xC+dsZIBTjU1xI3gqPNiqK0jslA4kAA0c3Xewuy4QU2DWmP982u2SUTxsuokfWQCGjvBiTtDpcSr2lDz+MpABlcz1Sxcmoweg97ewaKiDttw7p7yOsaFUbpEr6Q41krjH1zrkg2W6YaSB6viiDyuPy9TTgwDWi/sQ44OyQDJhr9dBggM3UGekRT7i95ALc0/skq4y9nP5lJdVs3ySxV+pK07F3oKIKajAKexcOGU1qL1OT+/JaWW+Otfa39A4TBkmT0Y6EDUx97x18WIEJA7r2NUD+UgEeXDk5aWhWhWHZyQLhm8VXKJLj7+AwPhB7NoUkXz445b+di/pZUmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oqv1Goa2AuEM2ktQASSjFeUVDFzi4LBiYShFsGNFQPo=;
 b=aZUJsyOCace8yAeOENs+W+m633xsRjJzkvvd8MGae3GoazncoXmJC7tZhP6WCScyDPQQhTKDsjU6A5ZyUcJXiSPNqwTAQMk7ebO/dbHXpU6pY7xd4vv4zO/+UAdO7W3OhXMurowIzzPyXcO2CDs1xUkEpZ1mMLJDQPowmPSMC9r0dIMVbcTDppEEY6s53gwgJTbUGPXalenNIM+1Mcc84L+uMRbM/NMeN7pBhNc8ZZN+wXYi0g0ufdaiM5QQWQIfZkz0FeYBzsp28GAR0FxU3d3nZWDxUSPvw8Jl69z+Ft1duLCC9KsrpwRERhsFjxsXT0217BZlX35y6njOLmQlDA==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY7PR01MB9306.ausprd01.prod.outlook.com (2603:10c6:10:23c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 06:30:25 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 06:30:24 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
	<chleroy@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Yuhao Jiang <danisjiang@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 3/6] powerpc/spufs: bound NPC against local store size
Thread-Topic: [PATCH 3/6] powerpc/spufs: bound NPC against local store size
Thread-Index: AQHdIpbczLtbGuoNv0iCXaCHyauSi7aMC6yAgAFkioA=
Date: Tue, 4 Aug 2026 06:30:24 +0000
Message-ID: <A64E7079-435A-4562-8AC9-530D37165CF5@outlook.com>
References: <20260802-fixes-v1-0-7368423440f4@outlook.com>
 <20260802-fixes-v1-3-7368423440f4@outlook.com>
 <073a9c41-4545-4bf6-aeb2-1dadf3c222df@app.fastmail.com>
In-Reply-To: <073a9c41-4545-4bf6-aeb2-1dadf3c222df@app.fastmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|SY7PR01MB9306:EE_
x-ms-office365-filtering-correlation-id: c278e68f-7cad-4ffe-3d53-08def1f1ddc1
x-ms-exchange-slblob-mailprops:
 9IecXKUgicApcBHgIkF1u3SRiU/lhwt0wE+C82ATxMiPsmpI1GaWg/KI+ul90EZdU6zl+hC+uErPfcdaqSYP+vq4vyecbhrxAD+ujsRLjwspV4SGfLUCZf5kb0mZ28D5DZPJqXLk66/PB8L1TffBmGgdlHApZOQVK/++uXzBFqrKwzOacmwxBTdz5nap5UjQakqaoA6ddAGbCVYMuTRXFAITbOGT0YRzPHzTaxEiZbWNBahIvUKdXoI2t0wjxM4+Hg+MnO+EB8C8U8kqLb9IsoHPh0gvPxIriOO/0Urs+lGOzc5trs5SD5JP+lbvTy+9iVKadVx84eloOeukmGtMmY/XNrmW47vw8n2p9DEBv1wPuQTxlPutxme+puqeJZDTTcCwBfBG68xUrpcyVzRVNvGU6JQ611S4RW6CkI7Q4UIRkGbfW7vRJX+5LUzVYH3xP4OJnd1ITuIwSWG4/jJU0seWMEUhHE4PWsbE7Ubr3bD4NanGQVOApmEGvPpfJFnX24z6UqxIIK6Qf9z69KYbF55wU9fC+w0I7kJIYjjue+wRTOP0Jv4+jLvf0VXEI4adwHwNINw1jdmZ8GCtJlRgK6Fo7/FzJw8ZeRPXGYnicBW+T+AV90Gv57wS2UvSlxDeGnBTc9PpJIST0rm8qdynl4QMtyML1BVT0EKtnb7RXCGcnOxe0GcpOl5a0uIRed1d52WLWxKjB7IH1aiCXr16dZrAIUgYPtPvBB0l8d0N6Crda/zPowZ35w==
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|12121999013|31061999003|8062599012|8060799015|19110799012|15080799012|4140399003|22091999003|24121999003|25010399006|39105399006|22121099003|40105399003|2607281247196008|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Z4rdTfQoDFmlOwR++HJoIFNwLC8J0CqhwnU6tcKL4zRDxdseB3m8oIJrvrkj?=
 =?us-ascii?Q?oGwCNzqC3KtK63V49bmJCxNDaRcQC5hBzBrtFCvWc0ANA4h/9Y3ZgDHy31fs?=
 =?us-ascii?Q?nNGmeGpivjTRkPks8xQN/ilk2nq337kt+IYiG+kX4d2GfvIPy98ZxfJ1CNHe?=
 =?us-ascii?Q?szooeJdPqhAV3uvUJyZqW7EJi3Q6TvO8w0yhnYq7asjWgz2fxoArMsTJEQ8q?=
 =?us-ascii?Q?J+xIBYBTvNeB5MgRxFWIYiRY5zLPI73AEuSey/cNZIDuT6KPKgn6R9Wi0Nw4?=
 =?us-ascii?Q?TbkKa7DfW4Wg/93ixuXR1+XjDoED6V3laz3nzdyV8V5qehDbWhtV6dpz+ARz?=
 =?us-ascii?Q?hQxrpefK3F7ACgju/SeiXDs+ffReLajVjt8u5nI2uuX5rf4jMxym5DVUTS8c?=
 =?us-ascii?Q?09QVkTvjFgNaErzMwEEo9FxopmccVR5iefueSZKCaTDNJEK/V2h7rdQhQEUZ?=
 =?us-ascii?Q?C5CIcuVE8D3z8FytWvg0ekRbdK6Sg7hfEX+jUOcrmUGEA5zwq/NpEp3K6ipG?=
 =?us-ascii?Q?45cmAW9i8KU0R+XW+SY7ygQLOka6fietQZC5aAu1sl6jzWJ1aneeZX78X7tl?=
 =?us-ascii?Q?mMvukHBbgNl5CYGxenjwC9P5KlKpYQZwGi8RLl7Vesm9OmudJC5TRIKpqs0o?=
 =?us-ascii?Q?PQqdMvrgnrh3qZIMifRlbfHdB2vNvvWzg6QYUAqI4BRlXN2VQNVq7/00Blj2?=
 =?us-ascii?Q?SK9R7SOaKxgZAWrNnDOBhfuVeCRUHUWKTrZF7iBkrzBQR1JE99ZdIXT2Ywmr?=
 =?us-ascii?Q?scU3nEDwvLLpj42VsPzDIsPiXoo9HzmVqqpqQCXEEKclc28Ma90Qw2yO4ipq?=
 =?us-ascii?Q?GtJ8jRM96Qmcka1epgK6FpFacAEiZy5yTwh7DvD4PjlaWQMxbAo5q4jHb/YR?=
 =?us-ascii?Q?UeBnIiEFE9fRslPTYHEGlXVhMdS7fLAohQhLehA3EXv+hVytSFKEtBUayrSr?=
 =?us-ascii?Q?UAXqna3ZmJ3b/n+lIChx/6hKRkCk/xcoxLU7XibetCrEaozto3n6DEv49KNa?=
 =?us-ascii?Q?CrIMiv//6DBXXpX7BQnVoMm6OJCAFmDaRcAWQcH3llejR+0IP8F4GvV1ShSf?=
 =?us-ascii?Q?aeNLhToD?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?psIhq6gQz78XiYJcqUUlJi6AMj+1E7y5dQO9ODQaR0GPdcpIwfS++pd6i0YO?=
 =?us-ascii?Q?Gckecr8D/ldsH4MSKcSXdfD5/5wvYlTA9+VYPScZM6OkXoDL0vhYncdAg2fn?=
 =?us-ascii?Q?45XlKXOlXDT1HnWg6eZ6sI/cXJXMbgDRtBJOekorKvJBrsVbGsUYehKumDbc?=
 =?us-ascii?Q?G19FFmAY6h13qQWE+tncOPZgEBRBLX5ZGnwh6JkLt3BsHwGXdFlvD1IgCLyq?=
 =?us-ascii?Q?n+/QBzd5jRsj7tlPzW0flIxSREjWWwUbywLjidprHdChnF6ifpF2CthFu2b0?=
 =?us-ascii?Q?DRbTXoZ4AFvYCKuwz5W4LSV8mCLWObYrmuLZ3LGYwabw5EDSlq6Ksi2zaJH5?=
 =?us-ascii?Q?tRpg0waW+nJB+UzH0D/g3snAAtuBcMpZAci9wjwtp4zmZ2c8FjZg2h93oh3M?=
 =?us-ascii?Q?sqVrtrm/q/CJIf7FMHb3WqKWP5becB6WHoC/tS4aWbfFZEum2e5tVh0xeWb6?=
 =?us-ascii?Q?dZ1ll8A5+uYO4BH58B0tlf8jtyH64lq/bOGGBfsgx3NONnUV/LLohF41l6NB?=
 =?us-ascii?Q?2OBhzAUOmXGFG1WFbmWI77IRGxa5XPM5gM4J+3p3mKdNNHtSeyvlJKkpGIkH?=
 =?us-ascii?Q?oh3yTH7j/JmkJyYeUHgqOmhidzfuZ+Vh1neEzP1oS+VaBC7aBC4PZk400ky1?=
 =?us-ascii?Q?30VhSdOqF2A0mgUHwiwRuGX7SXZjvLTxISsv6BSxVZ0CfxwKtbMhnuiRKoHV?=
 =?us-ascii?Q?eOk60zWAffGGPNrIqnTuPbd1Gu8rurrCWFfZzQYaBnELLZfv6/74BM7mYsI7?=
 =?us-ascii?Q?kl9S5QrCvtoP1f6GzIgynRqr6L/5BhDFB+0hZ2z7qHvXCJiBfgZ4VEg+IWWF?=
 =?us-ascii?Q?ceifyltNPNRnGp7LFShIHygK4xgy5QEiQyY7nZ5RiClUsK4YAcZXqJYmrg2t?=
 =?us-ascii?Q?TFYq5YH47cVGxzmZvrpwy9YU2xnezN3XFQ9E2Sf6bnGXR9yDJJ8EZKIzYeFR?=
 =?us-ascii?Q?g+NEO4vg9WEloSIDqYquLdSgD78hbGj6KtxbGp59lPzyUliM3wqn/vY68zYK?=
 =?us-ascii?Q?rzfTyf6QMXaS4+5JICXzcsHIqhxrw9Vx3j+K+3KFPLmdkvumhR/7upkFQPIg?=
 =?us-ascii?Q?4WpV83XN/dwjncogOYimejv116Kwq7GlphTyxD1ZXqMR+pt+LnpET7gmLV6E?=
 =?us-ascii?Q?nit8rS87gKxv6PZf4njURwz4NlapGVAIPTZZ4H38bsCrr5/TDl/2AMFWbYfB?=
 =?us-ascii?Q?BYudGSHW+2zUwc6X1LfBLd0h5w5nod2immnv5vnageH8FzzEOUwDaQnDXFjo?=
 =?us-ascii?Q?GIomhDHpE5jAjo24OuQhqywMCVQR3T0WTI5FDT4m51fOm7N4i5whWxjb1xuT?=
 =?us-ascii?Q?6ChzIef5thLlRUnGkEAYZjcAQFPkWaFQCVr+mrPl6HI/hE2cU+Ay7BpGN502?=
 =?us-ascii?Q?8ABBqvpJnWzqUNEtgDk4mi10TYcwwcUhg8xxCzeZSXDtUbdz6Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <82ABA394BD24D84CB5674ADC3DE32ECD@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c278e68f-7cad-4ffe-3d53-08def1f1ddc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 06:30:24.2542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7PR01MB9306

On Mon, Aug 03, 2026 at 11:14:03AM +0200, Arnd Bergmann wrote:
> On Sun, Aug 2, 2026, at 17:51, Junrui Luo via B4 Relay wrote:
> > From: Junrui Luo <moonafterrain@outlook.com>
> >
> > spu_process_callback() masks the low bits of the NPC register and uses
> > the result as an offset into the SPU local store: `ls_pointer =3D in_be=
32(ls
> > + npc)`. The following guard validates ls_pointer against LS_SIZE, but =
npc
> > itself is never bounds-checked.
> >
> > Fix by rejecting npc greater than LS_SIZE - sizeof(ls_pointer) before t=
he
> > read, mirroring the adjacent ls_pointer guard and returning the same
> > -EFAULT.
>=20
> This one seems wrong: npc is a hardware register value that can't
> go out of range, unlike the ls_pointer value. I don't think there
> is any use for the check.
>=20
>      Arnd

Thanks for the review. I didn't establish that it can actually go
out of range. Please drop this one.

Thanks,
Junrui Luo=
