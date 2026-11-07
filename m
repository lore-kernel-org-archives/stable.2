Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794026894;
	b=ay7SROs3woplhrWL744AjKj/fWBItzMPYQuzOyftPqGHg6szhGVaSpxwaQYccfLVdWjo
	 NMJykI0/wANCqijOe+U4sjVfSzOAq9y0QJ08G/355b6ld9WY0f8yBeBWGkO19zTqEy9j5
	 9fjZMZwtTDePTq/92FwRwwnZSUORfKvGsJeOcZKCFFFR++BVFOjH7et8EkbyRY5Z+AW0J
	 PcaiuNDAzqWUm/2VwoPqddhNBEXGF5HeKw5NZo7/ovqMl/nKOYCjkYTTr5wzAhxuje66Z
	 7yz47a0KNO6FifuGe4lqflHW2mgMW69Xd7+Q8EZss/r4qfTlL6VGeLW+xBsXjXokGag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026894;
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
	bh=QtH6Glu67eMGEuuYvsrwUmWXc1YvMG8u3jMeYgz2CeE=;
	b=eQ1q2nJHbMT3TeI1JzotJTXSQbEPRNenCExIJOIClBa/26DeNzjIyi3tVeZRSt9+7hBe
	 IuAPBGEerkymUVjXsMwCDGUf7oM0MlaHESRS1oGItNWD4EmZklpY7gudvgz+AlMwwWZgj
	 FNNYO+7MMw8REXTdEs1vGKGJbGAgEdT1gHSP0GXLl8ctB1vuCmtGg4eGWMZczIaxlxwNc
	 TJK0IjsYZkKc0+FvSCAme/1twr2cw4LZdNlGA8twv53z6Yl+0zl05h6dw6whUDk3bfsTX
	 T1QZnP7JKNhpDlBwuykBzTf4Chrw8Bn0kLTFbTfSjXJSS59OrbUUlqf0X/D01RR390g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=LeK7OUhH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.0
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010000.outbound.protection.outlook.com [52.103.12.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B6606A326;
	Sat,  7 Nov 2026 04:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D57B6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=LeK7OUhH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMIFKDvuZ52SbcSgI/Wi5e9jJbXAig8D3zGbToeOR50Lna6qyDP7wLKxqjWdsxv3p5lwZ9InoHAJtYgJgmUMOGjusrJ3ilMQbXTkafOKDc8lxUV4URUHEZd84+nEz0Vc0aOhXdyz+X5ok1FJs/0P+WKPMOw/bxsvlan0SVLmpEguinmSiW8cP1fN3JNVDxc/CaTYwBdpRigaQGwL29rYcbrgqeqFoO5Re2XKVjYDzO6TFBKS/LSKDqnhtnCjufjhD6G8f6jVdS3hovvNhVDutz77CiL4CQcnJK/SC6CFB+rdFokgRbdRBvX0HaxRD8GJgMz42VuTzUf6bfHdoprz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtH6Glu67eMGEuuYvsrwUmWXc1YvMG8u3jMeYgz2CeE=;
 b=N8q0Vg2+4mj9BHx8irP/WpJqxup6cH4WpaprOMSNVQcmcHuejFaNLLY/ND0wSusLOB0BvPMsosFLj31K9o2aqZbHC/2KCsnY/NV3DdF/luw0uq/SMZZTSEfnOGErZ9Vr18rOurY7jSh5Vf+B/bWQYRgAHGLvXVNY33RDzaJIMv2jL49p6Nwrob4BWm/i9SGSNtFANSsNnSxdSJDXRuY+oFyzvah2snnVN8NX+YqgSxLuq5vIawlvng8tZ1ZfXGPOCJJ1y+n8Xf6sExC847d8rHw0pPXmddUHIs6OU+qPnERaXC+c6hN7XKn7eXGyz/fxkqTdW+STlawll+eN+wBtgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtH6Glu67eMGEuuYvsrwUmWXc1YvMG8u3jMeYgz2CeE=;
 b=LeK7OUhHCRTh45aMhfYjcZq1SLIzDNFpTHpRDyYrpBVRbGuhFkq9ZMYGGHtuHB+f8kHuyqZJ9UU9rI0TeJC4HuUry8LUNsxhXg/Eb7wCdI0jY9bHTB7Sq6PuNu7sh5jtOS2GYco0BrH3DX2MpJ5Buz0srXnM8nUpaxGRUIu30Iod4qrZucF5RJ/p+kAGBbpzI5Z2vQXHe3WHIjNCg5FQ50H+Clh/hGe6jYSvTg4tMLpwE4/xURRZ4rMs1dMO0MQc2kptcIdFROlgYBkdn/UhFtZMfUysROd9CXP0j0FwMxRGxaszaEynVLSiWuCYU/cZTQvoaS29Nz75se+kP6e7mA==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by IA1PR02MB11006.namprd02.prod.outlook.com (2603:10b6:208:5b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 04:48:12 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 04:48:12 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
	"mhkelley58@gmail.com" <mhkelley58@gmail.com>
CC: Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: RE: Patch "Documentation: hyperv: Update documentation for sending
 VMBus packets" has been added to the 6.6-stable tree
Thread-Topic: Patch "Documentation: hyperv: Update documentation for sending
 VMBus packets" has been added to the 6.6-stable tree
Thread-Index: AQHdbmJ71rFA44U62ECkbcYshar6ELciCYEQ
Date: Sat, 7 Nov 2026 04:48:11 +0000
Message-ID:
 <MN2PR02MB68635A4EA06CED7A33AAB6E8D4752@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261107024826.2728987-1-sashal@kernel.org>
In-Reply-To: <20261107024826.2728987-1-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|IA1PR02MB11006:EE_
x-ms-office365-filtering-correlation-id: d391ca45-f39c-4ea8-1c11-08df3c8a53dd
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|15080799012|51005399006|31061999003|21061999006|13091999003|12121999013|19110799012|8062599012|8060799015|25010399006|24021099003|55001999006|102099032|440099028|4302099013|3412199025|1602099012|10035399007|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7KBv/5d1zP5AxP38VUk565RD8ZjmfNRrNwrf5Nc+lYOzCIb3m/V2kno/ri33?=
 =?us-ascii?Q?36OwsRe/5y8IgoJdFFSfzYHFXSgDHRiiuAKustJVDZUMlj/IWzgZDptKriSc?=
 =?us-ascii?Q?aXr04UCRdyxhtQ472hNJPqOfD80K8Lr9HaKcbLFQxXBn46bZv6gEtiEMFWlk?=
 =?us-ascii?Q?rM6uJjiYd5L6KPN8Xcq+B5dFPIA/7Vk35QW9qZsA+rqY2PeqAZA/sAMXpnaD?=
 =?us-ascii?Q?E30qxEC8vGvXLuAGxGO/tbtzr55oHeQ5UvSMh58gH/ynZ9RADfvIShLHkHeD?=
 =?us-ascii?Q?hWKlMg5JV+BCHJAxwpcfQgY5a/fhHN5IVC9tCjhWjHnDQBrNP56YimXXjYm6?=
 =?us-ascii?Q?5clCb+T+7E3b5ZRpWttllwDBKG2eTXEVeQUPiBCdpLB06zSJy7wwh+z+Au0q?=
 =?us-ascii?Q?wMylZTJGFpcsdfLJ3qpRo+x7rEZ6U/xlF7Xt+al/cppxmG7A1fx0i4T/e6Wb?=
 =?us-ascii?Q?wT2sfPZbqCKOROUJiEp8H/8vyu/L0BrRQhl0QAbkK8UtVOuZa3EqWVZLU+Lb?=
 =?us-ascii?Q?aXR21HMJr5BP0FzDZxQYa9lbgLFFYxtphmC5ybPNyG5ja9AmpDyD4YwTcjp5?=
 =?us-ascii?Q?AEXZR2izNn4r4gbz45Y+FGcwmFuqwPlimdiWWaTy5DX2BXh5I2pf3qsdYzN+?=
 =?us-ascii?Q?/RwYaIWjF+C9cBS+ce0eCf3+tJD04VxTnBWWBWDiHbweaCcKIM9PBTKIcrBp?=
 =?us-ascii?Q?C1Rn2Ux8T2lfalZn0vAvmDySM4zAoO+LL/CwwZeM9dy8s0PYWGMh6fNVVcjz?=
 =?us-ascii?Q?LINSUdJZGSaEkgOHwFg1HjlwGwxDqYIu4vsFBYEOWKZ6KyQMJ2ClQhml9bHa?=
 =?us-ascii?Q?gLdt+hkVDHTsf7PNDO2rijrtGdX0gn5mq7sSmI3L1pbho6C2dmdOtnCO7Nsf?=
 =?us-ascii?Q?CH9tlC60tDRVPto603FdtOWGU4O4bHaoE/HchWjbVLI7dTl5j2HkuUh1XIAo?=
 =?us-ascii?Q?KGSIjeiP82wUnZrhQ1jSqHp8mDFgYTwEMc9mnAB//nrcNjc/XNDVrBniGnBJ?=
 =?us-ascii?Q?ldSx14UePbrXsVTk1naqP8ZryK4a73W3o4M1PUlOe3Rf/+aUcc+1I33x/w7U?=
 =?us-ascii?Q?WwCEjnri5RMqbG//QhNHL4rDhNIv3jNedt2TvtgtGSDQGD7NOpQfkgq8mSEs?=
 =?us-ascii?Q?iEJN6ZJWmVk9?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nE/Xr+vBltRDtUP/LV4HaPR/+ylQQsApNDczIuZDdLXReOgqNf2LVOa9aSrM?=
 =?us-ascii?Q?/1jyggjs1FrVtjcZBcuJDQP+XWBPcmi80L4KdJpE2CTmf6icMnBaADNl94QB?=
 =?us-ascii?Q?3tsMDmVJ7O2MY9dA8H8DP/k3lRtTuNYH65dx5hx+3mPMWRcH9J1gQlcC+YLg?=
 =?us-ascii?Q?naBBmfeQ4OmfcFLDVKysfm3SQyAmMYTwATc3lAmh93TO9zYZQxAebLIiwtoU?=
 =?us-ascii?Q?vMrpIgGxePMOngjHEk4vR281vbPobgjwjx9wIUlW9n1L5hIHoRDTnJIXea37?=
 =?us-ascii?Q?jABbJ9RKTqJ3a2TrWAoWHDIAmTr9THK6pn1JNK/mzCkPjSMKhCK//JYbwLOX?=
 =?us-ascii?Q?g2QbPR96Jh2gHzOi0muRbJpmRdCbTAoUJ3esDWax8SvYknqy7PcxoLQ8y2lz?=
 =?us-ascii?Q?k4DN6OcfORel9irk9JV68KvG+JFSCe1pn8/rd5OCxRIW2uQyElF7OkQiKdZP?=
 =?us-ascii?Q?hnkPaaebTGrdW2JBTg2gskC9JqHoaFbMO3+5U6BGlEXDW1OBwdwyWDRgR/CI?=
 =?us-ascii?Q?Ppt1hAqRRTBaQcAHqQnHGY38D8x0TmJnQsL2PNuf5B+hGixw0YA8Rlj1LeCt?=
 =?us-ascii?Q?bNHlTn1/9uGyklXAI5PC0yrDH2X9Z92CZyW5lzGiFDH9ES1uHTiACVpPG0Or?=
 =?us-ascii?Q?dSqRHxyclB61PbLw8/+zNaFxARUQ3JPQHNsnuwjI4F7qyxpSe7EJ792cwH0H?=
 =?us-ascii?Q?mVl2K3Ox3zzbImqVobSqGOWHrCGLlXyBmJID1K1KHlQdaieNI7qjhcXK6vGP?=
 =?us-ascii?Q?blr8JdQi2dsEyIT08F+5FGPisakRpkyTZ39bOZFu9wWimPoB2M0F4HdHCWDd?=
 =?us-ascii?Q?6/8tGTynpLu22gmduY55U64NJaquz+qau0ltnHYIQpLc3CAwAcdfRrViEleA?=
 =?us-ascii?Q?CVTPFeEcTeOxyQAfO9JNQbWGbAL/6iKQyLETs30/P55+JAOGexepOqWsmWIv?=
 =?us-ascii?Q?7/J7Tx/Dwluq1GaN+YvuIoRFxk/LdqC6ggpplD9BVCoG8mZEUzSund8+yd6k?=
 =?us-ascii?Q?wLekH3nor3b9gEeLOgtBps/bIdqEVku5dcl8fFT3Xpe7W1LqsAQdX77+rwrB?=
 =?us-ascii?Q?YvGcNx1zEp2Wt9s6otufUbDo6XA+tG5R+VwZc1aDgcGOPabYzqljBdNSeJG3?=
 =?us-ascii?Q?2OHbST1mgJ+dwXl/GSFf28FM37rmljxuW12Nzg75Yjz2ZacDcMFEKneLl0T7?=
 =?us-ascii?Q?XE9f5PfXtjeNQ76PX1d7Z6hmOulsXmOVtae5hNTKndHJlsip3udmwa29Ujbd?=
 =?us-ascii?Q?E63x+R/5UJGLGixoUlNbBSvow96PTrlJi7YGjUNcYh5dmEP5qFKi5CD/6pNo?=
 =?us-ascii?Q?je9IfOsCqN3H2ZboYY+kBJx8j+a6ZyU/r9B+zVdxf7KbFfF8Qi9kJvEaoXov?=
 =?us-ascii?Q?z0Kr0Mw=3D?=
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
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6863.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d391ca45-f39c-4ea8-1c11-08df3c8a53dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 04:48:11.9542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB11006

From: Sasha Levin <sashal@kernel.org> Sent: Friday, November 6, 2026 6:48 P=
M
>
> This is a note to let you know that I've just added the patch titled
>
>     Documentation: hyperv: Update documentation for sending VMBus packets
>
> to the 6.6-stable tree which can be found at:
>
> http://www.kernel.org/
> %2Fgit%2F%3Fp%3Dlinux%2Fkernel%2Fgit%2Fstable%2Fstable-
> queue.git%3Ba%3Dsummary&data=3D05%7C02%7C%7C292d5505e46c4917672208df3
> c799bce%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C639296165147375
> 292%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDA
> wMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdat
> a=3DMYSr381Uq1XgVG15JMUtbK4ZKJ1Qifhv848VAB%2B0Pjc%3D&reserved=3D0
>
> The filename of the patch is:
>      documentation-hyperv-update-documentation-for-sendin.patch
> and it can be found in the queue-6.6 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>

This patch should not be backported to earlier than 6.15, as
vmbus_sendpacket_pagebuffer() was removed in 6.15.

Michael

>
>
> commit 0c34cce79a67e20f1f352458d661675a2e2fa130
> Author: Michael Kelley <mhkelley58@gmail.com>
> Date:   Mon Oct 12 18:43:54 2026 -0700
>
>     Documentation: hyperv: Update documentation for sending VMBus packets
>
>     [ Upstream commit 6a3d77a0a8cf69cf3d234305e6711729eb5d10c4 ]
>
>     The functions for sending VMBus packets have changed.
>     vmbus_sendpacket_mpb_desc() can target multiple ranges, and
>     vmbus_sendpacket_pagebuffer() has been removed. vmbus_sendpacket_geti=
d()
>     has been added. Update the documentation accordingly.
>
>     Fixes: 45a442fe369e ("Drivers: hv: vmbus: Remove
> vmbus_sendpacket_pagebuffer()")
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Michael Kelley <mhklinux@outlook.com>
>     Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
>     Signed-off-by: Wei Liu <wei.liu@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/Documentation/virt/hyperv/vmbus.rst
> b/Documentation/virt/hyperv/vmbus.rst
> index d2012d9022c5e..3326bb103a5ab 100644
> --- a/Documentation/virt/hyperv/vmbus.rst
> +++ b/Documentation/virt/hyperv/vmbus.rst
> @@ -141,14 +141,15 @@ Three functions exist to send VMbus messages:
>
>  1. vmbus_sendpacket():  Control-only messages and messages with
>     embedded data -- no GPAs
> -2. vmbus_sendpacket_pagebuffer(): Message with list of GPAs
> -   identifying data to transfer.  An offset and length is
> -   associated with each GPA so that multiple discontinuous areas
> -   of guest memory can be targeted.
> -3. vmbus_sendpacket_mpb_desc(): Message with list of GPAs
> -   identifying data to transfer.  A single offset and length is
> -   associated with a list of GPAs.  The GPAs must describe a
> -   single logical area of guest memory to be targeted.
> +2. vmbus_sendpacket_getid(): Similar to vmbus_sendpacket() but returns
> +   a transaction ID that is matched against a reply from the Hyper-V
> +   host. Useful when the struct completion (or other rendezvous data)
> +   must reside on the caller's stack. By invalidating the transaction
> +   ID before exiting the function due to a timeout or other error, a
> +   late arriving interrupt is assured to not trash the stack.
> +3. vmbus_sendpacket_mpb_desc(): Message with one or more data ranges
> +   to target. Each range consists of a single offset and length plus
> +   a list of GPAs that describe a logical area of guest memory.
>
>  Historically, Linux guests have trusted Hyper-V to send well-formed
>  and valid messages, and Linux drivers for synthetic devices did not
