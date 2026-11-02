Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793605237;
	b=HsbC0IdfgRcVqU+297jvWvLkzCPtMw1ULWJm/n5wVK6On1h+oB6KUy8o3ewrO3S51wFI
	 Ogms6twMXSdyNxUSOOxd5L4NdRPcn2IXE4O2GSQ57efTneedReS7RmUgC/VoLAFwfI6VE
	 puuyf6V/IY7wsdLuGPs/ijTYEX+zqIH1w3tjOvLgf9KamJBxoyhf6XWAA0tmyhyVsAs1p
	 ZDEqea/qe0O+814yCn5TfAptR0a5gruUBNXrKM0lROlKY5fXcPDJ72bSnTVyNXbughYz9
	 caRNlI8+ylzlZHEGPrvg/Ksb2mXkr+xGWrGpwLCIKjynlZv4InuINASGuPXnKChedVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605237;
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
	bh=PVMd7Dax3JmeaQvsAYrI/bYK0fLlhlfV0MwERNIpPxA=;
	b=g/DrcInTsHfo6KL3dhae3Jz4NEcg+KqVxxLuFGA6D0IdF4OuJFU+hjRyUKCDSZprZU52
	 wBZJUoXBRVC1jQslqhSFjn0maP48+x3/uxWG5/zPW6hyHHz9vbjNOHGyq9j2rrBQMWccu
	 z9G1wT2Z7wpAYdlxtri65HDdCF4jY/TLDc5tNR6oa//R3qDP+GmpHFZAmkqfQssdpWLmt
	 8zOFAg3WVx6kz9WbnQLAlHEzv+il9T6vtzsbj/+TE6yeVNLnhAEzRuzGmYEPKDWDtJNj3
	 lNPqMVzm5Eej/+Tn+J0ZgVyvehZyJtspkkFR9tv3NhR2i1CKyRcg1fEX0Nm66PrxGBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=TcR9Zpyp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.60
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010060.outbound.protection.outlook.com [52.101.229.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F25606A337;
	Mon,  2 Nov 2026 07:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97F25606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=TcR9Zpyp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cG39wNUAVfe/EJUarPPvtPxD5A/kZYtfqv7qIl+Gsw16QW/eoL/Z0jv8MHfWkgY8GDD1yfNBEpZ9s1TMyndihHitarmyqDNZRu+eXSyvDFJL7Re8x50wJ7dF6Sye8ethCqY0ri0OWEJcI2l7Ei3ywKcYtmNsqPfAcHLLbaCGazaY/gQhNETTs3jejCN+LANlhjZXYLKTgpuO8c8LwVrihk4QnUDpSBWeJSJ+sQcNhEoCi3a3eK36TS4Rn6xWMtm55L5vLaPjwBKQv/fThVpIvwXTH6Bw5iqeZZaGn7KYB65cnv151VDLC9mmV22SmGE2aNH2oq0uZ3fUdBp8VYqW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVMd7Dax3JmeaQvsAYrI/bYK0fLlhlfV0MwERNIpPxA=;
 b=xjyY1FtwWXTfWYRUXQ7f/eG8scLlonfqRvXNDraVbaAMT9fmzR1tFWBJKypNL54CCFQUGwW8JHMi/3ookM4jX8gsIVw0gNTyN3mZMS/IxHDwvWFiFdtiBhtG0VR7A9YnfMFwa5c6nl8tswRLv87Mig1+sMadUkpsWmz0eTIJw0VAZsti1IryVXtnjLwjuyhDARlkYDfCZyoRtG92JXg2hCBBoiDpJ2jYGZq5jwB4MtfTwJR6L4NIVXS4M0QZ8zhe/Pnr7idi8QMOW0rG+6Th/Eqf7KVAYOt9IWorZKpKJ+G74/I0ah89CjKLZfuUr/4J8ohJ0cLNaNjGinyEQE08XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVMd7Dax3JmeaQvsAYrI/bYK0fLlhlfV0MwERNIpPxA=;
 b=TcR9ZpypxUXO5/uEvi8bYoUfQKiXh2hdBEqVNr6rjDyS8kJg+zMFsMdWuhA/HrM2YtIj2cgaH5tepCVX7L17jUqMxaTzKwti+BUsrK6KAzJyUxSjrZW/NH+Fn8X8cEFaLCvyTJmGKMCW9LWXcKjwvn7hoPblF5+2CtbqmX2vpyg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB13052.jpnprd01.prod.outlook.com (2603:1096:405:1c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 07:40:32 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 07:40:32 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Li Youhong <dayou5941@163.com>, "wbg@kernel.org" <wbg@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cosmin-Gabriel
 Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, Li Youhong
	<liyouhong@kylinos.cn>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3] counter: rz-mtu3-cnt: put runtime PM ref if counter
 init fails
Thread-Topic: [PATCH v3] counter: rz-mtu3-cnt: put runtime PM ref if counter
 init fails
Thread-Index: AQHdagIDqhu567yWBUmB1msGgm04LLcaZgeQ
Date: Mon, 2 Nov 2026 07:40:31 +0000
Message-ID:
 <TY3PR01MB1134693BA02E518FE0A498205866A2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261101130746.1724364-1-dayou5941@163.com>
In-Reply-To: <20261101130746.1724364-1-dayou5941@163.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB13052:EE_
x-ms-office365-filtering-correlation-id: 9738ff94-5c5a-49bc-1d05-08df38b492e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|6133799003|10067099003|18002099003|22082099003|38070700021|56012099006|11063799006|261021121427099003|261021123027099003|261026140227099003|261022105027099003|261009223027099003|261028144727099003;
x-microsoft-antispam-message-info:
 WIT8RQPLWbqsE+gD/VjR/2bqvSObaRoDDtkSfVlCNWm5wGcxGNPBC6iru6DTPOWfubKoN4qQMmVCapdaa5dpkc1r8To7iOxbR+KFsYAt79JH2y5hFdFZ3sod5da0asMgz7KL9x/7QyCpXew5EcXwbl5XWNIjwkdsKLsFmTyfWzfKlSvLkPTbFI7+KvHxHvKJYPDL9mqwnCgB+uOFhjzzBOPeEOU0NJsdIJ6dYQBmal0wHTh1//rHWfxIoac++0LExYSsA0sGTkjTvLX4VWrVtBErrKUGip4WyjrJyi4cEn5y9IEJpQJxiSCKZw6SFXEYeOGuF9ug9KuEw81/P1PiBfOqVtefT4SUnJo3zn6tqQEXMMATUucXHXHu6FQ6u/dS1Ck87AAW2k8zpVBMj7mISv3Sz5mJSKV2CfdOU2g7ycB8V4w/Ph7c08L6hgxqH6jKBeAIt0a0tpbCTa+HIHRYGbbxghC8GqZ26RLQGaaFfvr+/z2BXZ3RKeavmragC3q1TyKXum82nwnfT/PQI8UU335kgYUucyKcWmhPTQKTf5f4bTtDiPuSWfxVtxB0oyYd1cSNuM154KFWIl+LL8DxriHzEG1HE4PRX7briIDBGzYM5qifEoFqVZJiBf3fXQXZAPhxPi7ntEVPTotEuAFvAmLsZZ/otKWy9V2nhJaroqA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261026140227099003)(261022105027099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?77TCN2yBz3R/1OXcuCxIY18WLhJeZ44KQyh3EjgbNUsPb4oO5ATYcqLnQr9Y?=
 =?us-ascii?Q?ZilURfQCjyZAjODYY7anfRx5PoeGaiqUW+CWRfQSzMWs3ilPajLdWHMiUo6A?=
 =?us-ascii?Q?1KirRIEiLFGQNcxnPSaPJ/lFyXUsgXpRzEUBdQGmsIl7blDYGDaxTX5KdKLs?=
 =?us-ascii?Q?isvr5uLTiwMnYeY3r4982Y6Xnbcm5YW/Zrs6DXdPUk4R/jHAQe+yeXc6uFA6?=
 =?us-ascii?Q?zF1Hg/X+IVIIgGcE7Ahbm04PWn1xVDPKtWd8Ab2pSq5sjeKDGcaiFAqCxzcN?=
 =?us-ascii?Q?qPUCPRja7lhyXrID6Wx83j8rqog+KzhaY114PIgPkHYQH9+mA2Fwl8GcMURv?=
 =?us-ascii?Q?99JEsL2O5oiqBfDq5JBkegy/6eKDaDayqVnwtuRU2BSfcnR8fLKJKXmPOyPp?=
 =?us-ascii?Q?A4zxsIBQKZN+5obg7RHrr27fcLT08905q+7O9VeZgBGj3C2w+cLh2TVXJQDz?=
 =?us-ascii?Q?/x43koC0PavsxI5kzqq9b5xxZxgcsa5LK6ioRgcODdwE2T6Px9TCrg2XkPSr?=
 =?us-ascii?Q?uVUlKZZO/gA3cSLxWVWCIlURF9uNc5jwIUlnL5ow79GyeaTKiQBVzVeOC3jA?=
 =?us-ascii?Q?/GuCaPf+C6uQqhNwym8JYD4I02Cn044+HlDiQc5qwyg1w+MGcwp65swiffe8?=
 =?us-ascii?Q?bU87rMxRMB6XjhF+cKvFC9/UjvhSmohFVBtVOIZ/v/ZNkvMl/PsPjFHX3DwA?=
 =?us-ascii?Q?wHt92ZC+DQVuVOPU/kVc7qgbNYZU7SROZ7Ws1jr7aVpESI0XOSCtKagijB4I?=
 =?us-ascii?Q?jfN1FXiLNuHccHqLZIMVAvfnfGftTwFcC++kLIGsRPjS3UXjUepx2WqQs5UO?=
 =?us-ascii?Q?LYfr+JQRLoNVaTSJ4/lykjAqYow6dMEZlwoZNb1sjkjySsk5D8nry24BXD4A?=
 =?us-ascii?Q?7zV089d4OkypNeVgz3spFbirlHMPAoJ10Evlq0ztIP0/Z0dL6lkNqOea/Icw?=
 =?us-ascii?Q?OAz37P7qvXXDo1jyliqUHFRyavfxzRfVC+I65Ixfadfbd813RsF+fLqC5H6z?=
 =?us-ascii?Q?r/CjKokX2E3mE/6rX9pKclUvoH4FbfntOUqJzwlgNupfUu1yEN4jbcdn99oc?=
 =?us-ascii?Q?RyZTgUOZbJ9igSHQNC3MFT4keDcuU76y3y9WR0fa5061JgNsBaftVxkq5BI8?=
 =?us-ascii?Q?/fzPPn5zoDKOudY9+0iDTZzEbG59D5D37wG4XYUwWOIQb/5dGPL9l0laCHiT?=
 =?us-ascii?Q?1A9tZ3brRQQV2RLfakeZU7s5rGb7yMEQdihCrlK6pGgd4J6YuYe5oTd1r71a?=
 =?us-ascii?Q?ieoFKHIvxFq1gqVIqvUcB+JXm8mbD1pMkq17RbgO0ba+FN4ewizrD9sKxLB0?=
 =?us-ascii?Q?9yRjPyy6P3MTCtzPxLY/8Nj+TGXkxat4wNjZFxm99YwpKfBEDn7gsMAh88hX?=
 =?us-ascii?Q?dfj9I50uEM6WK2DUmkwGhuMdFRXkX849AG0NJN4tQ6u1FhgOMEawIwmczCgJ?=
 =?us-ascii?Q?wMqwNNo9CPeOoPtHls6QNkFcAQJqL/7rQkjKjTABsFQfBhSmvQBxlVcANCri?=
 =?us-ascii?Q?11l7b01BUOsNm7XMDcZ+5mOW8tX+BtNfSyocdQv8LcnoZcGJqMmepNGpBeRV?=
 =?us-ascii?Q?BTr3W30EbtIsyUkpczeYLjydAkYQ8x7rwuTmTsuMdtswziNyqX5xpkBS4YQO?=
 =?us-ascii?Q?xbg17KeLFIJdmFZKmC8uWl3EEJmIzSzPoygoI7zkm9IlnluP9hamdD9WV/M6?=
 =?us-ascii?Q?xP5t39rTyHH/64AzS5lkv3b2xjqW4k/b8hdjrctfPT7mU3X71LzKYESzojYp?=
 =?us-ascii?Q?0mHMbjS+2w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9738ff94-5c5a-49bc-1d05-08df38b492e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 07:40:31.9581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJX5TfCG3F65JtBORg7CnU02vLWetb80IGG1qy3yr5lgneOSQIgZOyUJws8HUZxFBTFLRi0LjKl8X90rTuLX0XxjCaKKEWM1TpPGHKC6Ab4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13052

Hi Li Youhong,

> -----Original Message-----
> From: Li Youhong <dayou5941@163.com>
> Sent: 01 November 2026 13:08
> Subject: [PATCH v3] counter: rz-mtu3-cnt: put runtime PM ref if counter i=
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
> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
> ---
> v3:
> - Set count_is_enabled from enable after either branch succeeds.
> - v2: https://lore.kernel.org/all/20261031142813.2522444-1-dayou5941@163.=
com/
>=20
> v2:
> - Add Cc: stable@vger.kernel.org.
> - v1: https://lore.kernel.org/all/20261008020506.211566-1-dayou5941@163.c=
om/
>=20
>  drivers/counter/rz-mtu3-cnt.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.=
c index
> 7bfb6979193c..e7fe8bf45164 100644
> --- a/drivers/counter/rz-mtu3-cnt.c
> +++ b/drivers/counter/rz-mtu3-cnt.c
> @@ -506,14 +506,17 @@ static int rz_mtu3_count_enable_write(struct counte=
r_device *counter,
>  	if (enable) {
>  		pm_runtime_get_sync(counter->parent);
>  		ret =3D rz_mtu3_initialize_counter(counter, count->id);

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Now days bots started complaining if pm_runtime_get_sync() fails
Then rz_mtu3_initialize_counter() will lead to kernel crash(sysnchronous ab=
ort)
as it is accessing registers without the clk.

Since you have added fixes tag, not sure this to be fixed in this patch??

Cheers,
Biju

> -		if (ret =3D=3D 0)
> -			priv->count_is_enabled[count->id] =3D true;
> +		if (ret < 0) {
> +			pm_runtime_put(counter->parent);
> +			goto exit;
> +		}
>  	} else {
>  		rz_mtu3_terminate_counter(counter, count->id);
> -		priv->count_is_enabled[count->id] =3D false;
>  		pm_runtime_put(counter->parent);
>  	}
>=20
> +	priv->count_is_enabled[count->id] =3D enable;
> +
>  exit:
>  	mutex_unlock(&priv->lock);
>=20

