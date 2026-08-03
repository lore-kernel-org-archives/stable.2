Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010079.outbound.protection.outlook.com [52.103.72.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E403B40927F;
	Mon,  3 Aug 2026 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761099; cv=fail; b=MQs+RMgQi7Qffw0fSLnRKj6UtjqF0tsMbk4SKR8u77EK+4h1nBw0C8fmKYZAFRjianWnnfMgNFdIiLfOSg6bgfJhuckJZbBVjz6F+5bpFersJTOWVlYa1EnyYZ8NgKZFyxMI0sZs8k/eH0BQX49vr/ralhOgErDAqN2IiNQsuS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761099; c=relaxed/simple;
	bh=C8EQvscOVlVVTuf/tw5EjAbjPvSFlUH9i6YzkuDu7LY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dy+d5JZXnd7hyCDV7W8ThfQHtgwKmLq5BZBQ45/C1uqA+bpSxLgl/u+Fapar5Gb5buOrNFp3sYqC56Xr/X8UJqvCcPrZrk8ZwZGxndC7jOqJUYT3GzQJTuvNnsqqFrQnOx11J+ZvoU5lJfzEx9fao3JqvyYYujb2unn1ZHIFsjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ASi4pIa8; arc=fail smtp.client-ip=52.103.72.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ASi4pIa8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wofak6E74qwrlcP5CXc1QTK4+70Suq23tDqwkx3B5LJbO6wUcdB8LZTmfCjPd6SAU+H/IMom14YVcn/x+QCF651qXHjNpT7IEgTmczBJzzUsFNB4M8/wC/1bKuQQ9m63jn9UPutiDtlTKBELLnftjUd7Y1HPbLnFFFITKprV5eqify9OIFKeSp88KwW+3QDhaSlXLawVX3rdkhzJWh+rOtAlSshwijvhSx9KVDz6wOPFCwvmrB0tNfc6o3Y/clfqoomnYNe9su1IF/kAh9/tyBxx3Yp2ufZr3E3Vr2wL2hMEugG5uvE5gZm/8NkJwcQ+7MbolfJz0QzGteUg2UFyVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRdbckxE7X6/v/jGvlPkzzdxzQK+faoZ52q/+IOPFHc=;
 b=xbCo8h0dl4CUI6yMSHgd+gbGC/YX6SL2sl5BE+g8LbW9hmbZNkcifSm0l+6oEJ2bewPwOJo0uBLnRuEwYCqMzgm94dROCx3UHO9f3XRrJU+CWXzBGBM5VJsd3es9BqoS7fo1G5W10eHcoebcTbODjINfEr1mm2K0jmfR46Xt9CMMIWJZYaIQ2KgPXy1xiHA3yJThzM+PfEkz61XeRqDyUeCVcgTyb6apSLVKcj94ti3e2NGv1oa8b7LxPe0NgA6WmBjDjBh71k3a1lM4gixl9ZIS5fpQwSvkmQpzA+T8HhoMjpAPA+IzJCXbE6muirGIgSnfEaARskGa01pS3nywRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRdbckxE7X6/v/jGvlPkzzdxzQK+faoZ52q/+IOPFHc=;
 b=ASi4pIa83dwrIHA51SErs7qOxt6OLJhy/xeaDF7YIcSIBdhdyQvdTUo/uf60mZuDuHRT7wAhVgYjKqpohkv6RdtVkf8AL8lf3OTh7ErnjE/BlR8kC3y6To3nlS/BKnHmhlwuURzDTfowLuphUzyHRVWX2ivucsoZ2W+A4T2MJ9jR5qk8cIQUJXhdsZX66vMDzq3KPVlfJv23+h7tEopncgKgciGaAsWDIfluD7ckBadrXw+87V8KKE399VQLmm4id7s5h1+kau0XeNT6OadDWbP+GBGiTQVnVrJUlGfP51zrncwxa+H1JyuwzDlfCGdBjUGQ95+bymZLUdPdHU1M6g==
Received: from MEYPR01MB7886.ausprd01.prod.outlook.com (2603:10c6:220:17e::8)
 by SY7PR01MB9055.ausprd01.prod.outlook.com (2603:10c6:10:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 12:44:53 +0000
Received: from MEYPR01MB7886.ausprd01.prod.outlook.com
 ([fe80::19df:3891:d8aa:692d]) by MEYPR01MB7886.ausprd01.prod.outlook.com
 ([fe80::19df:3891:d8aa:692d%4]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 12:44:53 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Nicolas Dufresne <nicolas@ndufresne.ca>
CC: Hans Verkuil <hverkuil@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Dafna Hirschfeld <dafna3@gmail.com>, Mauro Carvalho
 Chehab <mchehab+samsung@kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Yuhao Jiang <danisjiang@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] media: vicodec: fix out-of-bounds write on capture buffer
Thread-Topic: [PATCH] media: vicodec: fix out-of-bounds write on capture
 buffer
Thread-Index: AQHc8cLfT36G8KLRYEyWjUEbjsvUi7ZvjqoAgB0Zf4A=
Date: Mon, 3 Aug 2026 12:44:53 +0000
Message-ID: <5DCE028E-E3A6-46DA-9CF2-DEACBBAD5B2F@outlook.com>
References:
 <SYBPR01MB7881A4E2AC434488ABFA775CAF152@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <79f19fa34a875dc4b6944ec8df498d9862b5d3f6.camel@ndufresne.ca>
In-Reply-To: <79f19fa34a875dc4b6944ec8df498d9862b5d3f6.camel@ndufresne.ca>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYPR01MB7886:EE_|SY7PR01MB9055:EE_
x-ms-office365-filtering-correlation-id: ee9407e1-baf1-4aad-b94e-08def15d03ea
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|8060799015|8062599012|19110799012|8022599003|24121999003|22091999003|15080799012|24021099003|25010399006|3071699003|2607281247196008|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?odu4ZGrEdUO/onFTYoDNtE9+VK1SHh/L8PG2Whik4srqw+g/UjVh/GzcPjFl?=
 =?us-ascii?Q?PhmtKh/1dMi6/nvjLlrOeehG51g9r43ePPIaVK5dKhJ3GVn9U0ZtlfCUoVVQ?=
 =?us-ascii?Q?rU6S/4AYESHgBAjenggTFxJWHgADQ41gveFdQJwvHqrfyJFDSKwK6ivtNTd5?=
 =?us-ascii?Q?0gfTj+KZdBkBCNLL1euUnwHP5wwIl1x8OfBfmCr/ew9EvEenDyTNKq2xfY6e?=
 =?us-ascii?Q?i1cqNDMhgZRmv6QldvJvrilQsi3PcVPlUx5cm/d8Bbi8Mqgh4Iq9ynY1jPRx?=
 =?us-ascii?Q?IpHze2NC4QwQcd3w3Qn22j52YHlPnwLiosedT8/ifT1nbjUhsW1gygYTLEOP?=
 =?us-ascii?Q?5Y4EmHrNIXyWF/nBW72kwop11KI+N6L0380yYrXtLT/cOR1A1+EJPOSuR4rh?=
 =?us-ascii?Q?qezXFpL7+BnxPrfDzHovA9esYHhSAQKZlHs+6QZ3zCg0D56vAvuXpybE75X3?=
 =?us-ascii?Q?+tHeGNB62V4LdaVZF7yiusPxgBnt6XPj9dNW3d53IGp7C93pGm0EKEoMJWu9?=
 =?us-ascii?Q?5wMWs0l6YH8d53Rb3QrZDsjzfOS8GQ8/vKKCT28Jb24uBQ33BnaDKpJ8302B?=
 =?us-ascii?Q?jkjMYshO5Dkby9x+F54NZcfGkk/FhSglGqzH8fGYMhaWu+YekpAvCO34YH3e?=
 =?us-ascii?Q?hLN3BabMogIOpnbggbI1V1Ta42PNqHhF1qi5Gi+IS3v0HYgQ4Qgzrr/74VOp?=
 =?us-ascii?Q?0lvufyfbwJHQqVuynBotMNEtnC9HLMu022GB4SPXScwfJzA9H2lPhRAWHFnC?=
 =?us-ascii?Q?cQ/GkhH2T9qwZxRgX4BSpYFOnaFEBTCMwdzjpQZ9avr+7cDmfw7BBscypciC?=
 =?us-ascii?Q?eXKBxuo/QV/8wxYUcwXelFOUAuT4rX4s4STpICBMKv5GAWjT2RhgeFQeXZlQ?=
 =?us-ascii?Q?biuQkdic7HShcd9sJkmj7kqZ3PdfOh6F2lvR7MpEwJn/fBB1RQ9XNvZcwPen?=
 =?us-ascii?Q?uXwX4YCSloGPmjkrB0PDPf9UMIQ4WwZEFnVNZi1a0/JEGVtE3yOBr/x0B54G?=
 =?us-ascii?Q?GRBT?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Fx8JdoZaqkIcNzlnhv+m/GRtdIsVWRoZ4yapzjUf47GQWrCSLe08QoFEjrTQ?=
 =?us-ascii?Q?2WH1FPnpMmazp9H+h7A2Ij5n5G3Idcl19i1qOdZSUdqsdLafVd9f5oTwhCGp?=
 =?us-ascii?Q?ktDgBw0Gq1lFG+BAyFpkRbQfhi01ZCQUX0VeCYE76vEGaEmTWzeJDF5xeTZ/?=
 =?us-ascii?Q?j+h4+fpTSrlM7Ywqw/TzGmqdVB9OS0tP964/LkXsT2ReDEl9CLzvMrRfpjw3?=
 =?us-ascii?Q?/6KxaLkRMAuGUlBQaRo2urrcZ1nH+CHHIkS9Wvet9KWVqTNKzV0ANtSWPo7j?=
 =?us-ascii?Q?W0/UTBGxUADbTxozoVa39EPziqZWZoCFHxei5CBj5GaPK+RUEX6HGj7Y5BhN?=
 =?us-ascii?Q?BJYurNH9a3nkuMJnP4G8QbXmoIU2lVoQgdOj2y5Zom+jUaYAsEqHSp58DpXH?=
 =?us-ascii?Q?pM06FbkUJlgyoOfWsS7J4Hy+8F0KzBfZYqw3o0kgMyIuvwG12qpcKO8QjQFm?=
 =?us-ascii?Q?VmgA4JUeKEpGQJLsNtdODFVPLXKnufkmlVPuBzhyAO1HyomJ0XPAnp+E7Raf?=
 =?us-ascii?Q?BIuFf+ZXIg2s0SMA6ijLe1y3etC8lDgQQej1Xqbn815/rastfeddcVhgR3gZ?=
 =?us-ascii?Q?snGobI+X/rSSjqM+gvUOXAOXVOFx987bU9qJ+70FrvspYR0+t9G2gNA+/IgA?=
 =?us-ascii?Q?d9KPsiREKQ+hjonrAgt/OQ1Dqp+sl7ay4rd3fg+i4uCf0uhImRPdY6Z7yJ4a?=
 =?us-ascii?Q?qNx6HK2WyHQjnqYgrNgCt3U8iANv779HwKyGcf76P3ky0nNIbMkc9kiHhZZZ?=
 =?us-ascii?Q?8BdqJMvtesxXA4DPM5j9Px2fUf+kuA3BcnPUn4y6UuofNruMrRUqB+13iHf+?=
 =?us-ascii?Q?FnAF9OikIXlLS6wPtNQIIpxnUJEkzkFTe2gQOlJUFytve/55aXG6PqUROQ4V?=
 =?us-ascii?Q?4dPHomoMbxBWTR3itl9dyMrQuf09OmkdBVZGzN+txhxbzxSfsfyebObBR0pa?=
 =?us-ascii?Q?Stl1a9KbYxvaYN7iVuGxV7IgLXoLw5mi9queVZU5JauPnLLaMsMHU9mnj4kj?=
 =?us-ascii?Q?r+t9I8cL9nczx+oNDLU8hXqSzm8v0VUxqsLct8gF4mwl8tvcGFnrbOc2igwb?=
 =?us-ascii?Q?00n/TOBjbxEyviicZbm8AOB0DyKR+nqTMCBsKUHmPTFIMvjxaBbGsY5bjHns?=
 =?us-ascii?Q?JIz7Sfud6Spfx7HGxF1vnHIGOuoO5b9iPXdfR4PO/p+b0ZIG0nLSY3gQQPSL?=
 =?us-ascii?Q?c9wouGk4P/4druw94s14gbfEFaRn+maNQ9s3Dp0PINjkJMweXKVCSQ8aGM7D?=
 =?us-ascii?Q?h7XZKQPHn6pv9wXg82ueCGrlaoLfat1L9FQD/le4QJPEvF68pZ+M07lZjYIy?=
 =?us-ascii?Q?Cc+k7w5egvaC2YRrJNiZuBc7DIZJu1OSkzVOZyM0U1rOPFum2k0BwKo4avMR?=
 =?us-ascii?Q?FnakhaQ4hBRwF4VU6UkZnPLo9ZKd2euNXxqBhMeUs2C9E0l2Bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8C362B8603E4E649B5B90FA38C8768A0@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYPR01MB7886.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9407e1-baf1-4aad-b94e-08def15d03ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 12:44:53.2985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7PR01MB9055

On Wed, Jul 15, 2026 at 08:21:50PM -0400, Nicolas Dufresne wrote:
> The analyses is just incorrect. At this point, the driver is entering DRC=
,
> meaning the queue will be drain and will stop until streamoff/on cycle ha=
ppen. =20
> If there is a out-of-bound bug, it would be that that q_data->sizeimage i=
s not
> match to be smaller or equal to the vb2 buffer size at streamon time, not=
 during
> processing.
>=20
> NAK
>=20
> Nicolas

Thanks for looking. Right, `source_changed` gates the draining during the
streamoff/on cycle.

However, `source_changed` is only set in job_ready(). The first source chan=
ge
goes through vicodec_buf_queue(), which sets `first_source_change_sent` but=
 not
`source_changed`, so it does not drain. A non-conforming application could
commit CAPTURE resources before calling STREAMON(OUTPUT).

On v7.0-rc3, KASAN:
[    3.777164] BUG: KASAN: slab-out-of-bounds in device_run+0x969/0x1850
[    3.779180] Write of size 2560 at addr ffff888008de1000 by task trigger/=
69

It can be triggered by S_FMT(CAPTURE, GREY 1280x720), CREATE_BUFS(CAPTURE) =
[plane
over-allocated], STREAMON(CAPTURE). Then QBUF(OUTPUT) with an FWHT
header for the same 1280x720 but NV24 (3 components, full chroma). That
grows q_dst->sizeimage to 2764800 without changing coded_width/height, so
STREAMON(OUTPUT) runs device_run() and copy_cap_to_ref() memcpy()s the
NV24 chroma plane past the GREY-sized ref_frame.buf.

As for the fix, where would you prefer the guard? I'll send a v2 accordingl=
y.

Thanks,
Junrui Luo

