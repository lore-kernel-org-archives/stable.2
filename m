Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793462656;
	b=eaKddglvwCh+3alTYVNAZ4zhZS1cI/fX2Ul3uVI/zHfoeyFIOpK7W635IH1+vhVomAkQ
	 y/wRAisoCyUNDDzleVznv2j+JJRyB1YqCBbBSVLbJ8u+4uQvYIfkzrH9RamW6S/8A3Umx
	 WQ3pM5AMy+CwKbpIyO1ctmmX8MAljMMLPvqMIk8iFg0H8dI0TRCuvVWwJPWgskGRjLqQ4
	 dWeD6T08NTbWwNq8tt0E6ErawHSxJ1NDRoHHk6aL/ZNUtTq1+pYzJ/A3EiF1kHwjlQRpe
	 zi3uw2lxqT8p3mp9PH9zGmPqDh2V8TiJbrJiv0WZXOpjXFf0rDx/dtMfWiEkXAJq0Cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793462656;
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
	bh=euVcZIRKW3p3P6R47ahvJ5MgCVRanEsTkJhhuQQt3Uo=;
	b=1Y5zJm+dNiSq6SLh5i2ujy6ODlfZPDDBAhXbjOJYv4/MckQBwV0foMOepopPS0FThjf/
	 A63C1/ru34d4LsfG2wWygsP9ZZTJRaRv+il82dOjnbTOR2pe/yLNgoORRHPRACjZrxi5l
	 DG4fMGOtas8ZITf8mFtSoGrzcGZWm4O4JajN3oW0VoNxSbhcdiEYt9109070+CvCSTEqT
	 YldPOMtRj6bvfwyeqsOpOR9i4o1HrdZZls20LPYtL6yH+VRkGgbkWldDvBeetEFfp+8n9
	 bSRXS465Q4V7LP9yEy5hLcVWMfYcT8rNZ5NAZq22hOkha5K0Fk3UKUfIfw3N3BhfIVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Qcpiz4Bz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.30
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011030.outbound.protection.outlook.com [52.101.125.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFA5606A31A;
	Sat, 31 Oct 2026 16:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEFA5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Qcpiz4Bz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2Get5UzyJXz573ZhghP0OpvD7hDu66NfFMtIQeLaQMZdeNxUcRH3zm8N7axBJM65DFR62sfjkP19psAkmAa7R8y1WDyVez6IxyIQj2pB4FHrdw0GhrCNqRD+tMWlhAJBViLtWWJp6VZydptt83bM1VZZ50PlN7KK+4dNnuTP0yrndc7lHofNXYr0rfERTDfhgkLbhke+wjvY7rpD8Gr27RQ45OGv1TftV6MMP8Za5H026UbqKZRO8V0sGZL0Tb4uKJOs+JJ4xa9AIRMrCn9gpApkDZnZ0/BDfSPIMhjlpm1chnTkm5QrzsPwd7fzK1MFWtESiStR5lQs7+uRKsZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euVcZIRKW3p3P6R47ahvJ5MgCVRanEsTkJhhuQQt3Uo=;
 b=daOVQLBPBTZK9JlhhN78rJ22irwlZO3afOGq3PrRspyKs30AIZmOeTfmxzQ+dX53sTuPHZHLN1oZ2WsrPhTyPAxGTIndPdyEGq9CeehtJMuKePakrxEwik3vX22wJY0QVRFhsxtzf2DpxbJT+Ux7tLYEw8LZv85gaaKBGrPoUfhaQv6J9YkBTmmmaLXNvlIfgKhNpXCyCbza+lc222AZ8sKt+6wvv4al/T5cff/+oHZOeE7FbxNT7f4KZwUAZKrroBeAPkUi3BWiKPvorKFDdHF85BGta6FwiK7+RHWUUwYX0X0RqBQzdi1Ru8ZYXEBdMBjrxGVJnq9EPpgHAeBF1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euVcZIRKW3p3P6R47ahvJ5MgCVRanEsTkJhhuQQt3Uo=;
 b=Qcpiz4BzjwDEazbDNMjDw7xndW6Et7FV6hQzgfYjKXNhoUTlpj9Y5XG/4EA3ESiMjsTXG5CdDh6k/+BE+xNI3sqsT3+sYQ/qiF5XFna+9OEXbYLRqO+I3j9t6Pyg1sdx+XnWyRamcU6fxDr9ToP15xUkxeF8XtE7pifaUXH3nQo=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB7897.jpnprd01.prod.outlook.com (2603:1096:604:178::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 16:04:11 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 16:04:00 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Li Youhong <dayou5941@163.com>, "wbg@kernel.org" <wbg@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cosmin-Gabriel
 Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, Li Youhong
	<liyouhong@kylinos.cn>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] counter: rz-mtu3-cnt: put runtime PM ref if counter
 init fails
Thread-Topic: [PATCH v2] counter: rz-mtu3-cnt: put runtime PM ref if counter
 init fails
Thread-Index: AQHdaUQVMKdks6J/dkie/1eCJR5kdLcXz5FA
Date: Sat, 31 Oct 2026 16:04:00 +0000
Message-ID:
 <TY3PR01MB113469FA0C53BC58A29CB919F866C2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261031142813.2522444-1-dayou5941@163.com>
In-Reply-To: <20261031142813.2522444-1-dayou5941@163.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB7897:EE_
x-ms-office365-filtering-correlation-id: 6f41447b-521b-4a80-1015-08df376893c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|261028144727099003|261026140227099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|10067099003|11063799006|261009223027099003|6133799003|18002099003|38070700021|22082099003|56012099006;
x-microsoft-antispam-message-info:
 vG5pjweCf8uBIZRm92rx3KXNOdjW7eoB7DU0LfJM2r3kPltTLuDOOe/jbjrR2jDuYnZzqhTroPpS/syaN9r21a+V+zQfxuAVK1QEalj9JeFJ3WpMAddw/oIAvpVUC0HghRqtgRZD3yr8h/GA3nX4PwdNAI2cjun7sG/WFvOXDzC8n1g5MLdAb2f4nQVvgINDqjUTiOZgyVWNXOTSKa687zCM6d2PUIDPwx747E7P5v9feu62qPCgzZUwgqb4sK/j48JzDS3L0wCUHNGSHlxRwvFJ0m3Z3cYT8jhrtVjfEUN1yLz9xXYuON8GsR3U0y+Xq9SKG7kILBNU3TrStAu/RlewoRJyUcKZwXDRK+4zuhe5/d3m3xqCJRs60ExHp0j2N5CnTRXqdoD5POGmuD19qIX1NUBJwJ4TzXailVI6XqrRBtiqzuxGBECMlD/mzSys3uhvQHkSOuS+wf6eTOWfd2qxctBnC9+8WuZEcovJraNcqgCa06O2hlGsUA8RWPM82oVFV1HlKgTtQNB2L7s+P77Owt/IjO5EwIsc265lvdij3wHmycet2Tr4pfYXzoYpVtUE/V+jZYXZ1pdEA8Z7Mx7dWucDbXGjO73bo86yDkv+YciwP5+A/u9mbCzP2LArdgq7QQUbSa2mJdCQni6GtlJgfJ54q1GnJ7HEfESQjDl3LRYlsrlM9Y3zQ+nX5Iz+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261028144727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(10067099003)(11063799006)(261009223027099003)(6133799003)(18002099003)(38070700021)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CSjuk3en8fcfjTqIXsNx5Z48Z/QCceSKrpmedkSp3wdRbudPHqiMBRpsxaJ7?=
 =?us-ascii?Q?GoYVs3fvOM2BUdjiyqWrQYT/taD89O4vpmDqGo8o+Q5sJdAi61HSp/Wb4rp/?=
 =?us-ascii?Q?e/VMC9X8+4YPr2Trf78kzRJrNg7n6M593TlEL5BvmxfEqqc/zbT5qYAw7fOz?=
 =?us-ascii?Q?5H79b1mazkU1LSDoSZ31WKirv+oBrOj2Zo4kb1t+IklX8BHUrJWpxnFRbNn5?=
 =?us-ascii?Q?SmipV1hX7qkv6cihqTb/2gOD+P1wFYdEHkrpZ2IruxFb2hDrDSofnwOjLW8J?=
 =?us-ascii?Q?wu3m7sjJvMMb6b8oEKQmXCo14bINVAnB8dMtnu7oSHl7H2pPyf+/aSzIxOXZ?=
 =?us-ascii?Q?cpbjeKjV09wlpcZLUDJHKzDPL1irSaoW+UaoZxNm6ZUGI/Zoo90lQFc4b08e?=
 =?us-ascii?Q?fVlwGg0PuEqm1pm2JQVZVjS5oietpXTS7S1U9W+dBS2QOhRW1XQGa6kyePHE?=
 =?us-ascii?Q?/oRyEdf8JKh3aCtf3Qe5HnsCi6xGu9EO635LcK7L96fCrNI1JMKkeudeiwtT?=
 =?us-ascii?Q?77Fb1A1ElaHQyyUfClT36tuDU+DxsZR/CG5EgxThoFFz0pSdb71vP8IMiRYr?=
 =?us-ascii?Q?TQkGqg5vMQrGc0bxBLis8zux+poLjbsTf7qeSjc8TeW4+91efI1BH17+v9ct?=
 =?us-ascii?Q?s9Ff4JafKA7OGjgTo8ToXVGNR8HbKwfIlIKdQkJ8tTKc/hDw9gHncT208619?=
 =?us-ascii?Q?CXfUSmpqVUzO0RE95NRAkgqk3msclrxcueEzYYf42u+w6/GjqM6Ay00ZP2l+?=
 =?us-ascii?Q?rD2gie7YTQR7i3hJSHc6c14WCAl2EOmesp6Ob3775ZZRjbz9wZkZNuKTI6MH?=
 =?us-ascii?Q?DQqcoNIkhQ1yJflBnqh8uHWSoZPRgwnfcZN37YmHTcHHWUWOpJCNsR4+3C+1?=
 =?us-ascii?Q?1Q4GEEHASjq50yPRWyX9/oTvbuwt3KK4A1g3Pk1D68hGSzhklsqLecE31fJM?=
 =?us-ascii?Q?g1UmBwNPUV8Wv2FRdoOoGksBw7yX6AtIKxa6Gsm/JUGiZDDi93EC3FAOKKe0?=
 =?us-ascii?Q?rTH90tYKltXQ5yrGgf7ntcLUuNkc40huGUMMzw2fsPJjPUOC4OVlkfY3uzGE?=
 =?us-ascii?Q?235av1X/5u0VpGprViSO5lQKdmymqM3c/Y7Zr2E660TG4orDeyhuFrj6Jizj?=
 =?us-ascii?Q?HCZ/2PNnm/iP9+v+XgEqPz4BRinjE3AVsnZPzy3kstGi+x+JLUJCAAZADqNZ?=
 =?us-ascii?Q?qPps91x0a7D/exFzB4Jo9Q41H+qxRnl+kkMVWEe4XHOk+G+DbzGWiDJ4I2Nh?=
 =?us-ascii?Q?KRa5X6grq6Q4sZAWfquGKilhDPIZe8eKEihK3DZQQYTLMKpR0LHtQ1JWB2aD?=
 =?us-ascii?Q?NN+75Ty9Q/boLCXvJiz5peBii6PmiFX0/BJyartKQfFRh/SkJQKNl4TkkLaR?=
 =?us-ascii?Q?rM/+ktFqk1KDvgHnvS1UjgGPzsp0kTSF37uowREu2QGHznLxpKHH9ilZpZKv?=
 =?us-ascii?Q?j/hZj02pHZEcDFu8TfQSB424pOTuKH/FhsTC9LiTZ/x3wjDaIVg8M1nQusYK?=
 =?us-ascii?Q?pXLRU/u9S4O/Gm4wuNSv0fI1S5qzoVaKjgPv6Enys/2M65czcmqWUkx1nesz?=
 =?us-ascii?Q?5v8kPowi/w8f7ZAXS56lac694xE/3dngAFYjxOILpJ6I4tY8Z3ne/c86T+En?=
 =?us-ascii?Q?u2nIOuhWSJTUD4N95KqldoVDzwlfygBHuQogFygeGAL+bvEuSP/hCi1dof/Y?=
 =?us-ascii?Q?dgk7hvRRTiMfNv5LMb0loQvalC1d1Wu5x9OX/zT01NkUbsjGGgligNLWyr90?=
 =?us-ascii?Q?aZcIk6qNGg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f41447b-521b-4a80-1015-08df376893c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2026 16:04:00.4479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xKSsf9BoMGQID28VTXdMJB1Ku95pJ3Svzef4U9cHhdmYctWaV33GUmg/j8vDkd665bbLquFuCIRl20Kw8fMfFUwbjmzdcoaZRJhxz3UKE+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7897

Li Youhong,

Thanks for the patch

> -----Original Message-----
> From: Li Youhong <dayou5941@163.com>
> Sent: 31 October 2026 14:28
> To: Biju Das <biju.das.jz@bp.renesas.com>; wbg@kernel.org
> Cc: linux-iio@vger.kernel.org; linux-renesas-soc@vger.kernel.org; linux-k=
ernel@vger.kernel.org; Cosmin-
> Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>; Li Youhong <li=
youhong@kylinos.cn>;
> stable@vger.kernel.org
> Subject: [PATCH v2] counter: rz-mtu3-cnt: put runtime PM ref if counter i=
nit fails
>=20
> From: Li Youhong <liyouhong@kylinos.cn>
>=20
> Counter enable takes a runtime PM reference before initialization but onl=
y puts it on disable. Drop the
> reference if initialization fails.
>=20
> Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
> ---
> v2:
> - Add Cc: stable@vger.kernel.org.
> - v1: https://lore.kernel.org/all/20261008020506.211566-1-dayou5941@163.c=
om/
>=20
>  drivers/counter/rz-mtu3-cnt.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.=
c index
> 7bfb6979193c..61fbeb122851 100644
> --- a/drivers/counter/rz-mtu3-cnt.c
> +++ b/drivers/counter/rz-mtu3-cnt.c
> @@ -506,8 +506,11 @@ static int rz_mtu3_count_enable_write(struct counter=
_device *counter,
>  	if (enable) {
>  		pm_runtime_get_sync(counter->parent);
>  		ret =3D rz_mtu3_initialize_counter(counter, count->id);
> -		if (ret =3D=3D 0)
> -			priv->count_is_enabled[count->id] =3D true;
> +		if (ret < 0) {
> +			pm_runtime_put(counter->parent);
> +			goto exit;
> +		}
> +		priv->count_is_enabled[count->id] =3D true;
>  	} else {
>  		rz_mtu3_terminate_counter(counter, count->id);
>  		priv->count_is_enabled[count->id] =3D false;


Now, Maybe we can avoid code duplication??

priv->count_is_enabled[count->id] =3D enable;

Cheers,
Biju


> --
> 2.25.1

