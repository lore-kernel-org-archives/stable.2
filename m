Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793470441;
	b=Cy4NgnedEADdGwc0zekqEXmDOiS50UaCW+0zrD0eciMNHbBeCmFJBcPJNNU6ASqaOlTZ
	 kyn5fv/QZweIguaaT5UQS56koyKYaL0+phmfU83lUEURexOSrw/a6afat5yWksp2eoIVP
	 vPjC+oLSpxy8AnWxg7gehgof5Ojeq6CFGcxe+42RijWFeWCRtRiizceLmid2n6n+CVzmQ
	 NkH8Qyafe6DSGXw8CuhdfKDjT/bOPdgvYQkI0uHlJMEj/fCaSDGvs0fBXeRINjkOZlJ0L
	 7zoFgjX7YJoQa2dgKpoYt/6pTYsmpsJU4S/IcpgAHsiEWzMDLtMSOteKknrCk7It1LQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793470441;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=yAxHrAEHHqixI8TQogUJb8FwLYhhSm7hPyprPDDRAgU=;
	b=FQoZt8TleSQGxMXaAhSu/2lfW4l9U5Xv3VFfNdnqIguQaGRDklR0rXpVsq7MoVIVpnrk
	 Elp09Tux7O4oKFh4maSmQWH992q+F2Fr/pNvn7Xy4/7Q7qTFiTBx7rs1c83sd/tR0nahl
	 qs6oQPZ+VvWreT5fIRrPhH0UxBk5J47n5ajcIneeTbpqDTcjOTs+cr6FXVXQ9FtX/c0sp
	 j4TlDNYk9q4wPbv4bsqv+9d92P38oAk5VT3A3b2dkjJJQoMUP0ebGlg9Q/2ACFtLPP5ak
	 gqJHEzVLTOIhN5QQIUddDfEDi9dkWGR1GhNTuNaLky2sDfwrGbBE4Q/pJUAhoW61KhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=pQdf5agn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.54
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012054.outbound.protection.outlook.com [52.103.10.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB70606A326;
	Sat, 31 Oct 2026 18:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BB70606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=pQdf5agn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYaedzOYXA4VrUeoMCOjMOwlqz5fwIu7rxkEMB0vxckr41ky5+F9r8Y++T2i/+FrpkKw4xAtuGsTosLovIiW7z4GFdKFZ21ua8l0xJ9Z9CoiIYNao5U2vcl0eMwdSmYuT/osahpQeOMvrSh6l1JQqYeAY6fXhMW0ao2c7iKOnXQTzpQqnZUrSBLViTHhLpaoaSms6TV50xS9ItHQGxlhxC6/0gx5DpLMcW+B/ntydNvkyfQfaMDIK+Dcxaeb1P3cRJyTPID4xMhcvOqf5JdiGuv3nW9VVopq+mMm0o0fh0HXJYEX5p4ehyGIItd4b7A3B2Pd3q/C77kyPlHEVYiPEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=yAxHrAEHHqixI8TQogUJb8FwLYhhSm7hPyprPDDRAgU=;
 b=RNK/mL6P6Cgdd83t1D3xt+TM2Nl8BBHVQVPfGcfyaBheLtXs8QttSut2qGc/zGWJoSPrK/h4Q0LjlMu90H5+WARQT4o7/ctmQNJsu2qQDFF0V9sB+a0lPkCHW8KHwYBL6dPhQgOG6g6bOtZxw6F0XtsWqJX8CRJ7axc7LRg7nnnFM3YWQ9i4LBMAGXg8owTvAsCcEM70hVpqx888Odn/wdAqglcMUrZUi9a3KxSyI84sYdchbzp36U4+FabpwkTBatfkGiwrpAir2jQASnbmg6gndcHxU/VGroIfZ3RK4qItuIBVUFqwD0LYdsH46l7Jz1QKYkANERkCQbar0OConw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAxHrAEHHqixI8TQogUJb8FwLYhhSm7hPyprPDDRAgU=;
 b=pQdf5agnQ7fbsEn7FtWdQS02TGUXf8PYTHVip5JruOiWbXaxDe4EFy2Ayta5DYlDbqKbdYAyZB7ShTMYSZUMUVT1tjn8ryu855m+VAlHe5pd1UCKI0WdzDnw6TI5Lu+dogSCCbl51u2JMHnEFm1/Huv+PKUL+Qi3JHUm/R/3TiQhZpTXyCeP/H15v+dL0CtCR0r2pHCBst4XZd06xdZaCFanoGc3vwtox9Bl6yq8r9HP6lLbmNz96dl4xBHwRcesWes00V+0BwLNbCaD5cNrDLczjnsquqMVOMSkdRSzXtG39xsuMsuzOfTy3BRjTIcEdPkBaUADEZ0a8L5QK+AKmg==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by MN6PR05MB10826.namprd05.prod.outlook.com
 (2603:10b6:208:4f8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 18:13:59 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 18:13:59 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: Neill Kapron <nkapron@google.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bingquan Chen
	<patzilla007@gmail.com>, Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	Felipe Balbi <balbi@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH v2 2/2] usb: gadget: configfs: keep extended property lengths
 consistent
Thread-Topic: [PATCH v2 2/2] usb: gadget: configfs: keep extended property
 lengths consistent
Thread-Index: AQHdaWOZ0KqFHw9kbEe1FnXYV/nMLQ==
Date: Sat, 31 Oct 2026 18:13:59 +0000
Message-ID:
 <54d5a6f6202a9a145fc123476c5ff6b8aa4b4c5b.1793470427.git.x-professor@outlook.com>
References: <179338899796.2590875.15337207674245295434.b4-review@b4>
 <cover.1793470427.git.x-professor@outlook.com>
In-Reply-To: <cover.1793470427.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|MN6PR05MB10826:EE_
x-ms-office365-filtering-correlation-id: 616df34e-0a99-4655-ae43-08df377abc57
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|24121999003|15080799012|51005399006|24021099003|41001999006|38102599003|12121999013|8062599012|19110799012|22091999003|8060799015|4140399003|25010399006|3412199025|440099028|4302099013|102099032|1602099012|10035399007|26121999007|40105399003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?8JPWUdlUxIvGYY17B9fuh+RYmB8rcsgjK6LehBpGj+mrmakJkhU/K02HeM?=
 =?iso-8859-1?Q?LDHLZcoq2yrL2SfgUB0RNCelhrAu4CGFbFkcpN3XszNMfZcZTbL6qDvGgZ?=
 =?iso-8859-1?Q?Um/wktnlTaE+rxT/aLrWBi+GIdZyWt+j3yXq8YdoqKBby+10Ub8IxTYat1?=
 =?iso-8859-1?Q?PlzWeraytA2Vjap7My+NpwGf9JyDpSvxnyItKKHHLRP3+OlAPFYV0ukRCB?=
 =?iso-8859-1?Q?oCQOn+M+XEF8i+2OvR5ZhcZg8dJ2Vg2+mz1P7S/wzDmRO8suTCfPtxLi0i?=
 =?iso-8859-1?Q?GYXCFwW8uvW51tqzCuCcDnvkXR2c9DnI7T7kgM+XG6OGhEW4hxn0jFonqi?=
 =?iso-8859-1?Q?cjKryUpg0Gt+ANFDB5XHIRa9XDwYLdN8/W5jr2DjprL9XYkXi7e/ty9GYa?=
 =?iso-8859-1?Q?V6E4o0aiGB0M4yxb7dT1yR5RW75xEoD/jLFRtuvoyQWDjWriKYBDyfcBIf?=
 =?iso-8859-1?Q?Zg5+FLqWPUfXLzoRpxvBNbGskzeaWeV0anGagO49PpJhYVBn/0EVlT2sQ+?=
 =?iso-8859-1?Q?RXVMzFVFxpnqWluJWVa/ekRzwpwPR0oTb4SPNkt5+VPIqNJ9IFwrj3TIbt?=
 =?iso-8859-1?Q?qE/wAr5BgQOjrVRtRU6cOXFDBzJFKtQ8733STmErZNjtrz9GHdyO8smrSb?=
 =?iso-8859-1?Q?178ZEeOiilRWKR1+r4PThmyhbviz58k+I51WsvKdqBwV4qBlxK2dtRW+MF?=
 =?iso-8859-1?Q?AHjjtxH4JFbE2cLQO8+Rfms6lqIUISIFJZPtmCLkLkNw/DSo//cUwhjKHi?=
 =?iso-8859-1?Q?tH4mwRn5CoId581rn9E1kUulmt3ivmkQT/+3CcgzZCtUW4s+4zpeKT7ehM?=
 =?iso-8859-1?Q?23iieidP9nQmiRU2zXZWUFt3nDCWgNDFY5PIzljj5XtvgDF1kwe4qhJvwF?=
 =?iso-8859-1?Q?KxXaHlB7zx8oLwxBkAlutEmTZQ2Fb60LF1ylLnUFRrSHXn6OgEw4fuXkfE?=
 =?iso-8859-1?Q?Qy00YMhJSuD4EioJzghBeKl2lTWzkyXyuQaGgujNFWecPU+nDzCNYDNqXu?=
 =?iso-8859-1?Q?RE8kRtfn32I6+r7m0WQ5kg1dxWMbRnCuRM5HsRvn2VpizUmHvNSqZmtdKo?=
 =?iso-8859-1?Q?gbvS0tkz0zjz3e5t4tmsDnyon+l/EjObTsB9Y74aWHU5ZkjBh4it3WOED7?=
 =?iso-8859-1?Q?Baje62bxszaBuwL4pUrfmpAru1CnbwPWLNEZVRTfzvnszh/6zYb15TahoD?=
 =?iso-8859-1?Q?Kf4EZppn4amzupQRTivtDslxG13onsWS7a0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?iVzAszbFCwS4kh/0N4YCRl/kpTGzex6cz/M2YlB2PRbs2VYpBTqQpzEq5o?=
 =?iso-8859-1?Q?hhopIFilj93nrGJEZltEoN/7MSrw5OjMHm5zk0pSlf9jpGOf5oiTpg9sGR?=
 =?iso-8859-1?Q?LFA7Ix1/vuiM1NXon+oL7RMMa0uYiQbu4eU1e0w+dMGf4j5d622+dh/w/T?=
 =?iso-8859-1?Q?kpK9STwex97oJ8FQbyh6+FQomSVNl7AB9o87lT9ZoEyimImQYWvIMsEGpA?=
 =?iso-8859-1?Q?fnuoZbb1HEO0iG2ZMuaRlUmTvFDrcv/S32aWRT08CTkkMRHz8+q885AL/t?=
 =?iso-8859-1?Q?8nTJobJ1DGiHMxBv+mUD3pVXOcvmWstrYfEiPhHLTuGShaBzCP2Au43Lrx?=
 =?iso-8859-1?Q?b6S/To1w1HTKt3Z+drLjCPP4rFzrtiP4OUpZ/m4CYIfUNvG6PIII0GWfXZ?=
 =?iso-8859-1?Q?BUj98C+Mwz/iUU5uhTu/C20TOfW/ICTV1VHvoz6MVNAaZDzzBBqBm9LDUZ?=
 =?iso-8859-1?Q?Uk8kG0s0P0oYaSpRPNGJnHGsK3dYP9eeimoS+np2vm3j5BnufH5MIgROYK?=
 =?iso-8859-1?Q?eNr5E7x5MiGGO26Nic7R8iqT1I4ehknWz1iN7vTthgJe3SajGoEZWtA0eZ?=
 =?iso-8859-1?Q?TplJbZN4t0RrpNsP3Z0gXswB98QD2X4zTyvl5wTmLIGQxp05TdzryCpCZr?=
 =?iso-8859-1?Q?IN5TXRUwzaqyRX1aum/lhGuf6TnKF3ACvA74YxHXx5Wsdrwb+pAOP+n0NT?=
 =?iso-8859-1?Q?geU6M6qJLv++bakatmsm1qCh+SIvlt0GYu5zE9x1p7JmeIoRUH5zZGRU/z?=
 =?iso-8859-1?Q?EaCFvcmGzdtj2ueNS+FWjMWE/jPLNjjvurCZ9S3TS3RE+Hr3uxlrbQcJka?=
 =?iso-8859-1?Q?yqz0jV7wtHLmqZgRoQxtVdENyTL1HPlqU9iDELj70jttgGXmqTygVtnpry?=
 =?iso-8859-1?Q?ilPFzCs8b5c9TdOWJ52N/CVAr4bMDSIvnSAzFXVr5NcEOEP42S6yic5LHD?=
 =?iso-8859-1?Q?1zx2sSK3J5P5hg7vYbTKCq/uXFxace8CHk8wYCjhGzrSnz2rhxJgbs7O9/?=
 =?iso-8859-1?Q?UZFFZxJX7XsP6xJzLioBMIN0gsj+laz43fiQR8ZEEPRldVRO/r05NNgvJ6?=
 =?iso-8859-1?Q?OeheyWIv8NkciObW8holSEwGlQhMDHojILFCGI9ah6dzm/Vw4/lZdR9TP6?=
 =?iso-8859-1?Q?YM4hufIghbjqaj/E6ChZ57jduAy8z40Jji9xzYvWm7OaxUb7a7Hka/KaHy?=
 =?iso-8859-1?Q?Uf8ujjffkJHQzWBmkivxeN/94ULK6kZFfGp3CIkSlFUcAxlgOFdHjszGFW?=
 =?iso-8859-1?Q?0iQZgL5BKJ7uIrpMa1ZP9ZNPnp29KXepnLpSS3fXcO8/iqmu/2A7V4E4mN?=
 =?iso-8859-1?Q?QUH4bCgbrqLLeplsclXwaOP7Y9ivd0hji9+3G27nNSfTpfy1LpxaDPl7nC?=
 =?iso-8859-1?Q?gg7i4RFC2WxyyQCItdFqX6D2SddzP2AChpXJaDMZKdgwOWdezLWyNuzJuP?=
 =?iso-8859-1?Q?ncHCNadVp9ate2zg?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR05MB10385.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 616df34e-0a99-4655-ae43-08df377abc57
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2026 18:13:59.5015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR05MB10826

ext_prop->data_len is the descriptor wire length, while the configfs data=
=0A=
attribute contains the raw payload.  ext_prop_type_store() converts between=
=0A=
property types with shifts that omit the Unicode terminator and does not=0A=
update desc->ext_prop_len.  The resulting descriptor can have a truncated=
=0A=
value and a stale total length.  Transitions involving type 7 can also=0A=
leave data_len larger than the allocation used by configfs readback.=0A=
=0A=
Keep the raw data length separately from the wire length.  Type changes and=
=0A=
configfs readback then avoid treating UTF-16 wire length as a count of=0A=
UTF-8 bytes.  For Unicode data, calculate the wire length from the UTF-16=
=0A=
code units produced by the UTF-8 input, including the terminator, and pass=
=0A=
the raw length to the serializer.  This avoids padding non-ASCII values=0A=
with extra zero code units and keeps the descriptor length fields=0A=
consistent.  For FunctionFS properties, record the original descriptor=0A=
data length as the source length, preserving the existing conversion bound.=
=0A=
Calculate the new wire length while holding opts_mutex so a concurrent type=
=0A=
change cannot pair the new data with a length for the old type.=0A=
=0A=
Reject malformed UTF-8 with -EINVAL before replacing the stored payload,=0A=
rather than accepting data that the serializer cannot encode.  A failed=0A=
write therefore leaves the existing data and length accounting unchanged.=
=0A=
=0A=
Type changes now calculate the wire length for the new type and update the=
=0A=
aggregate descriptor length.  Configfs readback returns the raw payload=0A=
rather than the descriptor's UTF-16 terminator.=0A=
=0A=
Fixes: 7419485f197c ("usb: gadget: configfs: OS Extended Properties descrip=
tors support")=0A=
Suggested-by: Neill Kapron <nkapron@google.com>=0A=
Link: https://lore.kernel.org/r/179338899796.2590875.15337207674245295434.b=
4-review@b4=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Yingjie Wang <x-professor@outlook.com>=0A=
---=0A=
 drivers/usb/gadget/composite.c     |  1 +=0A=
 drivers/usb/gadget/configfs.c      | 79 ++++++++++++++++++++----------=0A=
 drivers/usb/gadget/function/f_fs.c |  1 +=0A=
 drivers/usb/gadget/u_os_desc.h     |  8 +--=0A=
 include/linux/usb/composite.h      |  4 +-=0A=
 5 files changed, 63 insertions(+), 30 deletions(-)=0A=
=0A=
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.=
c=0A=
index 1b2238147cfe3..06053f5ae1947 100644=0A=
--- a/drivers/usb/gadget/composite.c=0A=
+++ b/drivers/usb/gadget/composite.c=0A=
@@ -1721,6 +1721,7 @@ static int fill_ext_prop(struct usb_configuration *c,=
 int interface, u8 *buf)=0A=
 				case USB_EXT_PROP_UNICODE_LINK:=0A=
 					usb_ext_prop_put_unicode(buf, ret,=0A=
 							 ext_prop->data,=0A=
+							 ext_prop->data_raw_len,=0A=
 							 ext_prop->data_len);=0A=
 					break;=0A=
 				case USB_EXT_PROP_BINARY:=0A=
diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c=
=0A=
index f5fff213d7952..3d931da3ae6b4 100644=0A=
--- a/drivers/usb/gadget/configfs.c=0A=
+++ b/drivers/usb/gadget/configfs.c=0A=
@@ -4,6 +4,7 @@=0A=
 #include <linux/slab.h>=0A=
 #include <linux/device.h>=0A=
 #include <linux/kstrtox.h>=0A=
+#include <linux/limits.h>=0A=
 #include <linux/nls.h>=0A=
 #include <linux/usb/composite.h>=0A=
 #include <linux/usb/func_utils.h>=0A=
@@ -1290,12 +1291,34 @@ static bool ext_prop_is_unicode_string(u8 type)=0A=
 	       type =3D=3D USB_EXT_PROP_UNICODE_LINK;=0A=
 }=0A=
 =0A=
-static int ext_prop_data_wire_len(u8 type, int raw_len)=0A=
+static int ext_prop_data_wire_len(u8 type, const char *data, int raw_len)=
=0A=
 {=0A=
-	if (ext_prop_is_unicode_string(type))=0A=
-		return 2 * raw_len + 2;=0A=
+	const u8 *s =3D (const u8 *)data;=0A=
+	int wire_len =3D 2;=0A=
 =0A=
-	return raw_len;=0A=
+	if (!ext_prop_is_unicode_string(type))=0A=
+		return raw_len;=0A=
+=0A=
+	while (raw_len > 0 && *s) {=0A=
+		unicode_t u;=0A=
+		int size;=0A=
+=0A=
+		if (!(*s & 0x80)) {=0A=
+			s++;=0A=
+			raw_len--;=0A=
+			wire_len +=3D 2;=0A=
+			continue;=0A=
+		}=0A=
+=0A=
+		size =3D utf8_to_utf32(s, raw_len, &u);=0A=
+		if (size < 0)=0A=
+			return -EINVAL;=0A=
+		s +=3D size;=0A=
+		raw_len -=3D size;=0A=
+		wire_len +=3D u > U16_MAX ? 4 : 2;=0A=
+	}=0A=
+=0A=
+	return wire_len;=0A=
 }=0A=
 =0A=
 static ssize_t ext_prop_type_show(struct config_item *item, char *page)=0A=
@@ -1321,37 +1344,34 @@ static ssize_t ext_prop_type_store(struct config_it=
em *item,=0A=
 	if (desc->opts_mutex)=0A=
 		mutex_lock(desc->opts_mutex);=0A=
 =0A=
-	if ((ext_prop->type =3D=3D USB_EXT_PROP_BINARY ||=0A=
-	    ext_prop->type =3D=3D USB_EXT_PROP_LE32 ||=0A=
-	    ext_prop->type =3D=3D USB_EXT_PROP_BE32) &&=0A=
-	    (type =3D=3D USB_EXT_PROP_UNICODE ||=0A=
-	    type =3D=3D USB_EXT_PROP_UNICODE_ENV ||=0A=
-	    type =3D=3D USB_EXT_PROP_UNICODE_LINK))=0A=
-		ext_prop->data_len <<=3D 1;=0A=
-	else if ((ext_prop->type =3D=3D USB_EXT_PROP_UNICODE ||=0A=
-		   ext_prop->type =3D=3D USB_EXT_PROP_UNICODE_ENV ||=0A=
-		   ext_prop->type =3D=3D USB_EXT_PROP_UNICODE_LINK) &&=0A=
-		   (type =3D=3D USB_EXT_PROP_BINARY ||=0A=
-		   type =3D=3D USB_EXT_PROP_LE32 ||=0A=
-		   type =3D=3D USB_EXT_PROP_BE32))=0A=
-		ext_prop->data_len >>=3D 1;=0A=
+	if (ext_prop->data) {=0A=
+		int data_len;=0A=
+=0A=
+		data_len =3D ext_prop_data_wire_len(type, ext_prop->data,=0A=
+						  ext_prop->data_raw_len);=0A=
+		if (data_len < 0) {=0A=
+			ret =3D data_len;=0A=
+			goto out;=0A=
+		}=0A=
+		desc->ext_prop_len +=3D data_len - ext_prop->data_len;=0A=
+		ext_prop->data_len =3D data_len;=0A=
+	}=0A=
 	ext_prop->type =3D type;=0A=
+	ret =3D len;=0A=
 =0A=
+out:=0A=
 	if (desc->opts_mutex)=0A=
 		mutex_unlock(desc->opts_mutex);=0A=
-	return len;=0A=
+	return ret;=0A=
 }=0A=
 =0A=
 static ssize_t ext_prop_data_show(struct config_item *item, char *page)=0A=
 {=0A=
 	struct usb_os_desc_ext_prop *ext_prop =3D to_usb_os_desc_ext_prop(item);=
=0A=
-	int len =3D ext_prop->data_len;=0A=
 =0A=
-	if (ext_prop_is_unicode_string(ext_prop->type))=0A=
-		len >>=3D 1;=0A=
-	memcpy(page, ext_prop->data, len);=0A=
+	memcpy(page, ext_prop->data, ext_prop->data_raw_len);=0A=
 =0A=
-	return len;=0A=
+	return ext_prop->data_raw_len;=0A=
 }=0A=
 =0A=
 static ssize_t ext_prop_data_store(struct config_item *item,=0A=
@@ -1361,6 +1381,7 @@ static ssize_t ext_prop_data_store(struct config_item=
 *item,=0A=
 	struct usb_os_desc *desc =3D to_usb_os_desc(ext_prop->item.ci_parent);=0A=
 	char *new_data;=0A=
 	size_t ret_len =3D len;=0A=
+	int data_len;=0A=
 =0A=
 	if (len && (page[len - 1] =3D=3D '\n' || page[len - 1] =3D=3D '\0'))=0A=
 		--len;=0A=
@@ -1370,10 +1391,18 @@ static ssize_t ext_prop_data_store(struct config_it=
em *item,=0A=
 =0A=
 	if (desc->opts_mutex)=0A=
 		mutex_lock(desc->opts_mutex);=0A=
+	data_len =3D ext_prop_data_wire_len(ext_prop->type, new_data, len);=0A=
+	if (data_len < 0) {=0A=
+		if (desc->opts_mutex)=0A=
+			mutex_unlock(desc->opts_mutex);=0A=
+		kfree(new_data);=0A=
+		return data_len;=0A=
+	}=0A=
 	kfree(ext_prop->data);=0A=
 	ext_prop->data =3D new_data;=0A=
 	desc->ext_prop_len -=3D ext_prop->data_len;=0A=
-	ext_prop->data_len =3D ext_prop_data_wire_len(ext_prop->type, len);=0A=
+	ext_prop->data_raw_len =3D len;=0A=
+	ext_prop->data_len =3D data_len;=0A=
 	desc->ext_prop_len +=3D ext_prop->data_len;=0A=
 	if (desc->opts_mutex)=0A=
 		mutex_unlock(desc->opts_mutex);=0A=
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/functi=
on/f_fs.c=0A=
index c64a268e98a43..c8f68a8049725 100644=0A=
--- a/drivers/usb/gadget/function/f_fs.c=0A=
+++ b/drivers/usb/gadget/function/f_fs.c=0A=
@@ -3583,6 +3583,7 @@ static int __ffs_func_bind_do_os_desc(enum ffs_os_des=
c_type type,=0A=
 		ext_prop->name_len =3D le16_to_cpu(desc->wPropertyNameLength);=0A=
 		ext_prop->data_len =3D le32_to_cpu(*(__le32 *)=0A=
 			usb_ext_prop_data_len_ptr(data, ext_prop->name_len));=0A=
+		ext_prop->data_raw_len =3D ext_prop->data_len;=0A=
 		length =3D ext_prop->name_len + ext_prop->data_len + 14;=0A=
 =0A=
 		ext_prop_name =3D func->ffs->ms_os_descs_ext_prop_name_avail;=0A=
diff --git a/drivers/usb/gadget/u_os_desc.h b/drivers/usb/gadget/u_os_desc.=
h=0A=
index f8b9f0faa9b16..c4384bfa8fe80 100644=0A=
--- a/drivers/usb/gadget/u_os_desc.h=0A=
+++ b/drivers/usb/gadget/u_os_desc.h=0A=
@@ -101,13 +101,13 @@ static inline void usb_ext_prop_put_binary(u8 *buf, i=
nt pnl, const u8 *data,=0A=
 }=0A=
 =0A=
 static inline int usb_ext_prop_put_unicode(u8 *buf, int pnl, const char *s=
tring,=0A=
-					   int data_len)=0A=
+					   int raw_len, int data_len)=0A=
 {=0A=
 	int result;=0A=
 	put_unaligned_le32(data_len, usb_ext_prop_data_len_ptr(buf, pnl));=0A=
-	result =3D utf8s_to_utf16s(string, data_len >> 1, UTF16_LITTLE_ENDIAN,=0A=
-			(wchar_t *) usb_ext_prop_data_ptr(buf, pnl),=0A=
-			data_len - 2);=0A=
+	result =3D utf8s_to_utf16s(string, raw_len, UTF16_LITTLE_ENDIAN,=0A=
+				 (wchar_t *)usb_ext_prop_data_ptr(buf, pnl),=0A=
+				 (data_len - 2) / 2);=0A=
 	if (result < 0)=0A=
 		return result;=0A=
 =0A=
diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h=
=0A=
index c18041fafa521..1a6db7fb6e3c2 100644=0A=
--- a/include/linux/usb/composite.h=0A=
+++ b/include/linux/usb/composite.h=0A=
@@ -61,7 +61,8 @@ struct usb_configuration;=0A=
  * @type: Extended Property type=0A=
  * @name_len: Extended Property unicode name length, including terminating=
 '\0'=0A=
  * @name: Extended Property name=0A=
- * @data_len: Length of Extended Property blob (for unicode store double l=
en)=0A=
+ * @data_len: Length of the Extended Property data on the wire=0A=
+ * @data_raw_len: Length of the raw Extended Property data=0A=
  * @data: Extended Property blob=0A=
  * @item: Represents this Extended Property in configfs=0A=
  */=0A=
@@ -71,6 +72,7 @@ struct usb_os_desc_ext_prop {=0A=
 	int			name_len;=0A=
 	char			*name;=0A=
 	int			data_len;=0A=
+	int			data_raw_len;=0A=
 	char			*data;=0A=
 	struct config_item	item;=0A=
 };=0A=
-- =0A=
2.43.0=0A=
=0A=
