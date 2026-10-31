Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793470441;
	b=2k+2C35kz8x/qyWp/72OpNOkiSrQojeQa8tKHTN3ZNfhPo1PGHeEJLKs9dzmq+dixp7N
	 sU2WH8or7aLNICtzM3RxwaWNAT3VV0HKERX4THA/G5C/HF66NAebMVa3ZfcdyGTTm0Z8P
	 PsklYXIMWi4RYTz4xJjtxTAuQjn1FCCd7qpW/jphA1Qa6joXYDkWoK1x0w9OcPcBdkqJ4
	 7/CUq0BkkdoxKdNz07gn1L+wSAGoHCqIcXbfkKWq53I2T2k417vMONTAvSrtCSk2nup5K
	 mLX54Frk6SkA4eJYALcMiGJCULtfBFEHnLi4NwxoiQEsCFfMZX41hrih86fbW5TgX8Q==
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
	bh=QEHbNs1P9sgXdoaHtYKnfNWpFfis72JhPUSFD0wZRNc=;
	b=iyew4JtUpLJS6bwQAGnUVrbRT0I4GwVVky5vwnTpVfXghaUS7xaLTfR6bYZYvxLp8ZXY
	 NtW6GMNaQeV3xk/Un2wTEIanhA57Q/hEvVJBZ8yCOVSNFChBxh3eEsAPQ0kXCSrXmQRta
	 bmKviYWDI1Ph/0PmjUvcEVhjCJb2t8JURdIdA1Uxy0ResEC6KnTaHMl1biSUP2SzSmQwn
	 NzlfxEE7djfcidz19bxB4NB8/YEdRYtJhIgIB+hkpwmYD6hzbgmDWXWZGVqsuLRL0AA0F
	 SobWwNJCoZluq73UvgqBzaIn2OEgV6R43futz/PglG/9fxCXCf8/vnmDbr+Q97mxBQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b="i4/isZWK";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.54
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012054.outbound.protection.outlook.com [52.103.10.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42E6606A31E;
	Sat, 31 Oct 2026 18:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A42E6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=i4/isZWK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZvWLAHAdvh98kCKqLm2DEryI65vmY+eQg6Xb/665P9pQAxbmUd+myQDaWJqAhIxjh7wJBRGFevnw1acOsvnxdLvrjokknQHTZh0+j7TwNm2M9VSDso5ZKSNEu7jtq3NhwWeYoAi6A+rW1vbUwbP5v/04WxO43mDrrHrigqiWeWh1GmgIm/mGgk0giBT6vk30vbN1zt/UjAlja+4xDxklhiePvLk65cylgGpftLYjtbfjiFfr4+Wdw+KxTKwHqCiuzsvPvKTte7deJSikdHv8ZlSJg+N1GSBpnVdfupCJd3TJXj0jaEo7K8y8dwKmQi2124NSxXrR4iuLg+XzPl1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=QEHbNs1P9sgXdoaHtYKnfNWpFfis72JhPUSFD0wZRNc=;
 b=LWtyI4QYJP2sNJfiV6l7wTIate696tnRtwJZ2HkVuITP/5josukw7XwsVsIRuYbORJwDuk2OQcOUXw8c8lT4M7lA9UkAjiQxR8jK/ZXmQmI8ROam4S5WL0bXTrb51ldI/YINNJIAMSpywu0HQhrLejEV5AW5U+dYonTTQmpQBpGDVCBNg+8YA7RQFVIct8lMDkn7CsqsCan3qh7Ohw0xpFwsV/uPc3SbnJA30RJLFqlkT/DPxi5om61cc1CuH6YF/5ZTMvXTAUPkZMcsj68zvwzuUnmMLJi8454MCi13BMOK7vFE9hjIae85Vhl6E9LrhXybaBs8YLGKXyNhQPClLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEHbNs1P9sgXdoaHtYKnfNWpFfis72JhPUSFD0wZRNc=;
 b=i4/isZWKr39Lyo7qJND+TzwEuQYS/nQYTc1EhftNz4tfGk3SuksZCLB+kNTkBAGDpI4EYg6QRlc5GLz0RlWl/mN20WO1nYepTbDHazWmv6YJy9ga5w/5fTDNX2ckdDGi0NnuXHKZgaMXT1yxED3vjiuaEEpgj6hS9US/mWEAt+t9IJ00YzPJAxxYofsPOMBL5lXJzr6V0Zpa8CiaSk8YNnZKAbhP4DMIEVMlEy/g6F2Oc+k+HHpvKt1LghOfgQmUYN34I+zri5MK9N4Ww/A8P8Okjcg2875qjc782UrrzmNwXj9tZYqnA81jEcXbMZjusCFqVRrPhaH56IKqEIVC2w==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by MN6PR05MB10826.namprd05.prod.outlook.com
 (2603:10b6:208:4f8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 18:13:58 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 18:13:58 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: Neill Kapron <nkapron@google.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bingquan Chen
	<patzilla007@gmail.com>, Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	Felipe Balbi <balbi@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH v2 1/2] usb: gadget: configfs: NUL-terminate extended property
 data
Thread-Topic: [PATCH v2 1/2] usb: gadget: configfs: NUL-terminate extended
 property data
Thread-Index: AQHdaWOZIMWq6XNQsUiSMDMjJAke4Q==
Date: Sat, 31 Oct 2026 18:13:58 +0000
Message-ID:
 <7bb734dd2b0ef5f1ff7ffd9f1ffd8fd7b84e5073.1793470427.git.x-professor@outlook.com>
References: <179338899796.2590875.15337207674245295434.b4-review@b4>
 <cover.1793470427.git.x-professor@outlook.com>
In-Reply-To: <cover.1793470427.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|MN6PR05MB10826:EE_
x-ms-office365-filtering-correlation-id: b96a8d72-dc35-4c34-f163-08df377abbdd
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|24071999003|24121999003|15080799012|24021099003|41001999006|39105399006|38102599003|20031999006|12121999013|8062599012|19110799012|22091999003|8060799015|4140399003|25010399006|3412199025|440099028|4302099013|102099032|1602099012|10035399007|26121999007|23121099006|40105399003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?dQhAvABsSAIEjl9ElmyE6bCVhMBfNMw47YBoZJ/loYUFcIyLZlfIMeomVh?=
 =?iso-8859-1?Q?fCAM0FnGZL3BHSG1IU2JkpzbTNc/VQk8C5XDUyEUy583pBhPzpQXqgyG/W?=
 =?iso-8859-1?Q?Bpab5KkNcT5CAwsukdCb8niBsXzlg9Y8PZQfRXKHRrKsvkjWrr6c57pVE+?=
 =?iso-8859-1?Q?cxpYzGhCjdqWS3uBg2BDkTBUhhaSbjQmZbl3CULVH2lazDV4V76amcRCGY?=
 =?iso-8859-1?Q?4IUOxLc6K48yrOAF+oyEefBHolB3F45TBLnR+Wj5oNWsl5VEIb3MJKgqOg?=
 =?iso-8859-1?Q?wu2HgST4LpT8sHnkcCeL7rc59oDgZReaq1u5PkBw2mg1gOrRPxfwRCgOH/?=
 =?iso-8859-1?Q?BnTZgfpmjtlSAlq0lV23t5I9z3/Tsp2/CKRy0ymWKA7c0XKUOgUWPfgchk?=
 =?iso-8859-1?Q?D7qEJsaLdzBWaYbQ0Rn41dA8D438ZsP8C2h7Cq3H5W3SOX8gNUjsaSTBDM?=
 =?iso-8859-1?Q?8vjNv67OWWZUV5JfQYW0bwRixRBWn1qe/MPkQmKIpBEGThRhPjTMiGZcty?=
 =?iso-8859-1?Q?+TPMQhs2hHFzLaPteO/VxfPdp8FM7gsVY7AUyFWQgtA0Py3w8dR/NUlfuh?=
 =?iso-8859-1?Q?b9/IyVPigVZ8J8Hbvgu2UzxIPxmZc/d44robd/+IDiUxMuYkxmM/oYTw7v?=
 =?iso-8859-1?Q?UG49ATbr8JXn5Pz3REodMIme+eBv6q/C1d5JImeFiPJZNuILS9Z/Y10DRW?=
 =?iso-8859-1?Q?tuY8WHYu/GccNqDv/mP+Y5dJOt2Pbl2/JHDcnp3OOw/YnCVR3E2vfYWDC4?=
 =?iso-8859-1?Q?tDYf6ltelo9FeEv56I3ai5ED/AHQhr3CCvwoI3ZfRAqO2uUAQVyjV+lai8?=
 =?iso-8859-1?Q?T3ZLUSiTaqGRplbgF2Vv8Bem11jmG+lDDT/0SyvyQiysNjLqLP6trcEEno?=
 =?iso-8859-1?Q?z5V6fkQSpKc9pg8yQUSDzTox3/l+CX0b6ZCxDsR8d27ny9SsjH5wcAssQe?=
 =?iso-8859-1?Q?GaEdMLdWK2YgccwZVLtA8l5w1T+CWGw6HTsya8zIjcAQGEmFFaYdUsH3s8?=
 =?iso-8859-1?Q?nlrRbD0bi9BY2iYkaQFLhO9+2P1y6w9DGsV5CEgMAPSfJjWvqAxFw9PRsl?=
 =?iso-8859-1?Q?2S5zvgEJzImlDc7joUvFbrwLWb+/seE2Yy7eLUahngMmYoz2MRmlhaswDO?=
 =?iso-8859-1?Q?3hELRfNR069AyB7BcxFflpk24yJ7elgAYYHvHZN/zf5smgZYKS4CJ1TazD?=
 =?iso-8859-1?Q?HmtqXfrOsJMsd4T2DU1ToDfHNwcmmuTVBtqy/ejIQ/kmM3zOi3uyZBSvFq?=
 =?iso-8859-1?Q?K2Zs/TQcLa82VkzmH2ywbqzkOlGqRyRIThxXKQFwdfAdhEVSsbLXz27LGV?=
 =?iso-8859-1?Q?v26ntqkHYOXbDNgkadHNY2W1iQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?nluNVcXYXrB3v4xDSLm+Y1XGWaTTzvDipKWf5zLOf1LWMGBJJg8///Vtvd?=
 =?iso-8859-1?Q?ev5oET3wZZEetzip/Cm0X6vEygoGajDtvwZnKsogQPZUE2THFhLIsgB4q9?=
 =?iso-8859-1?Q?42VSE+cD1zrJBbPAgiUs/+/MtE3D5MxjdWKYfZSguC+66KoHAhfRXhMpom?=
 =?iso-8859-1?Q?xgunOnLanlhOazpXRbqMLa51Blmvf5t0hypqv0SbCfH5xlwksaXWSRQh/0?=
 =?iso-8859-1?Q?1SxgEzNehhXyAbFgQG6a5m4j++ZLN7v8z12XUm1bsIVv+kBoXRpzEusubn?=
 =?iso-8859-1?Q?8XsE3ePjpEwR1yZGM2jUJnI+0ZC1cRhTkZU0znoQIxvZZJWhq9z2IObbvV?=
 =?iso-8859-1?Q?QWyJ/yEyS6jcjCVKKNUth0EnNzCEBe8cj+SUIm9cn8FGe/L6WPlWwcsk04?=
 =?iso-8859-1?Q?L8+dXE+55E4dzL0jf/VQx439GOGIyRjKK1xipf2V/em2nU0i+7XkWjwXKV?=
 =?iso-8859-1?Q?jSEu3/ZCagDbucXocW1NFf96dGQ/BtH5uYVpsczs17B6e0OE0XbX3mkZSw?=
 =?iso-8859-1?Q?ShsNMxKdPDsCq9vnWvPvpSH0dqLfbQ/NyP4fAJm6y5Njwa+XU4ey+gS4Yd?=
 =?iso-8859-1?Q?0pCvDgcvZgNU/sLHKfQFjf9+NHgFr6EpgsAWjTeFceyXk4G4JCaPJ3kkJc?=
 =?iso-8859-1?Q?4gHQahLfq9qA97vTPj8tsxHxE5++/P3kJIw8ZViowqMkij56jC7+mC1mVN?=
 =?iso-8859-1?Q?AOHPJrOzwYol5IszZSyfnZCToRosv5g3ucICSSXRy4dgUfw6M246EhEqg9?=
 =?iso-8859-1?Q?6df75zCtniNHR2SX172JzJLiOydg8LLuWqjtyGCazsjyyUK1CuYkg4ehzl?=
 =?iso-8859-1?Q?/v7frytiqVxSyefPPmAwCXlC/NxEw4hB773m8NZnc0e4ZrUHgRTR/4XRbd?=
 =?iso-8859-1?Q?fK3fqRcSh6uzy7tjXp1GExIlM+R+9nQPKpwYGz0o0d+hj2bbVOo0j5Q/+l?=
 =?iso-8859-1?Q?uDmfzT6dM6y3/dXiK2tv479E6KSf4P2qU0XxGuc1wQi1nGR4BhAbybvR1d?=
 =?iso-8859-1?Q?Oah2/fJclow5GDjldVLrF06kKvubvVtbf8Sd3RwPGAwxZyPsPHu4rJTPDO?=
 =?iso-8859-1?Q?XKfUl1ny119IFY3IbFbUSFBHljjFhXSr+eSOAQG40Xm0kE6YnE8E/dfDFS?=
 =?iso-8859-1?Q?7w3cgJJn3ITZ56DUo5zIZHMpv/+hz7xrHn5iFYqPFc/cTdg6wdtESN9M6d?=
 =?iso-8859-1?Q?oIOx/fMlQDRfOpnvycNWLFjIqKjqloSlLUehiTyfbunn38buot98K1DCLk?=
 =?iso-8859-1?Q?/E0gRqbq/rS3hklG5aPpbdsmo9v9gNppYuLgX6sN1gdvnQdhztECqGUhWI?=
 =?iso-8859-1?Q?EYXtyTeBercpabOB5QUsMgKLtFZ4snKO+0qdFOme6K6fkFGOhd3D+FuAuE?=
 =?iso-8859-1?Q?EGQ3VMaWWnlAalAEMeqK7rW8PwLXrMZFVlBMa/uclX1q/I3ycFH4DCds0Q?=
 =?iso-8859-1?Q?sccP8AXWv/di55Lw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b96a8d72-dc35-4c34-f163-08df377abbdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2026 18:13:58.2790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR05MB10826

Unicode extended properties include a UTF-16 terminator in their wire=0A=
length.  The configfs store path keeps the raw UTF-8 bytes, but the=0A=
configfs readback and descriptor conversion consume the source byte=0A=
implied by that terminator-inclusive length.=0A=
=0A=
The allocation currently contains only the input bytes, so both paths=0A=
can read one byte past it.  Allocate the trailing NUL with kmemdup_nul()=0A=
and centralize the raw-to-wire length conversion used by the store path.=0A=
Avoid dereferencing page[-1] on an empty configfs write.=0A=
=0A=
Fixes: 7419485f197c ("usb: gadget: configfs: OS Extended Properties descrip=
tors support")=0A=
Reported-by: Bingquan Chen <patzilla007@gmail.com>=0A=
Link: https://lore.kernel.org/r/20260421141010.5607-1-patzilla007@gmail.com=
=0A=
Suggested-by: Neill Kapron <nkapron@google.com>=0A=
Link: https://lore.kernel.org/r/179338899796.2590875.15337207674245295434.b=
4-review@b4=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Yingjie Wang <x-professor@outlook.com>=0A=
---=0A=
 drivers/usb/gadget/configfs.c | 33 +++++++++++++++++++--------------=0A=
 1 file changed, 19 insertions(+), 14 deletions(-)=0A=
=0A=
diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c=
=0A=
index 51df6d1d1487a..f5fff213d7952 100644=0A=
--- a/drivers/usb/gadget/configfs.c=0A=
+++ b/drivers/usb/gadget/configfs.c=0A=
@@ -1283,6 +1283,21 @@ static inline struct usb_os_desc_ext_prop=0A=
 	return container_of(item, struct usb_os_desc_ext_prop, item);=0A=
 }=0A=
 =0A=
+static bool ext_prop_is_unicode_string(u8 type)=0A=
+{=0A=
+	return type =3D=3D USB_EXT_PROP_UNICODE ||=0A=
+	       type =3D=3D USB_EXT_PROP_UNICODE_ENV ||=0A=
+	       type =3D=3D USB_EXT_PROP_UNICODE_LINK;=0A=
+}=0A=
+=0A=
+static int ext_prop_data_wire_len(u8 type, int raw_len)=0A=
+{=0A=
+	if (ext_prop_is_unicode_string(type))=0A=
+		return 2 * raw_len + 2;=0A=
+=0A=
+	return raw_len;=0A=
+}=0A=
+=0A=
 static ssize_t ext_prop_type_show(struct config_item *item, char *page)=0A=
 {=0A=
 	return sprintf(page, "%d\n", to_usb_os_desc_ext_prop(item)->type);=0A=
@@ -1332,9 +1347,7 @@ static ssize_t ext_prop_data_show(struct config_item =
*item, char *page)=0A=
 	struct usb_os_desc_ext_prop *ext_prop =3D to_usb_os_desc_ext_prop(item);=
=0A=
 	int len =3D ext_prop->data_len;=0A=
 =0A=
-	if (ext_prop->type =3D=3D USB_EXT_PROP_UNICODE ||=0A=
-	    ext_prop->type =3D=3D USB_EXT_PROP_UNICODE_ENV ||=0A=
-	    ext_prop->type =3D=3D USB_EXT_PROP_UNICODE_LINK)=0A=
+	if (ext_prop_is_unicode_string(ext_prop->type))=0A=
 		len >>=3D 1;=0A=
 	memcpy(page, ext_prop->data, len);=0A=
 =0A=
@@ -1349,9 +1362,9 @@ static ssize_t ext_prop_data_store(struct config_item=
 *item,=0A=
 	char *new_data;=0A=
 	size_t ret_len =3D len;=0A=
 =0A=
-	if (page[len - 1] =3D=3D '\n' || page[len - 1] =3D=3D '\0')=0A=
+	if (len && (page[len - 1] =3D=3D '\n' || page[len - 1] =3D=3D '\0'))=0A=
 		--len;=0A=
-	new_data =3D kmemdup(page, len, GFP_KERNEL);=0A=
+	new_data =3D kmemdup_nul(page, len, GFP_KERNEL);=0A=
 	if (!new_data)=0A=
 		return -ENOMEM;=0A=
 =0A=
@@ -1360,16 +1373,8 @@ static ssize_t ext_prop_data_store(struct config_ite=
m *item,=0A=
 	kfree(ext_prop->data);=0A=
 	ext_prop->data =3D new_data;=0A=
 	desc->ext_prop_len -=3D ext_prop->data_len;=0A=
-	ext_prop->data_len =3D len;=0A=
+	ext_prop->data_len =3D ext_prop_data_wire_len(ext_prop->type, len);=0A=
 	desc->ext_prop_len +=3D ext_prop->data_len;=0A=
-	if (ext_prop->type =3D=3D USB_EXT_PROP_UNICODE ||=0A=
-	    ext_prop->type =3D=3D USB_EXT_PROP_UNICODE_ENV ||=0A=
-	    ext_prop->type =3D=3D USB_EXT_PROP_UNICODE_LINK) {=0A=
-		desc->ext_prop_len -=3D ext_prop->data_len;=0A=
-		ext_prop->data_len <<=3D 1;=0A=
-		ext_prop->data_len +=3D 2;=0A=
-		desc->ext_prop_len +=3D ext_prop->data_len;=0A=
-	}=0A=
 	if (desc->opts_mutex)=0A=
 		mutex_unlock(desc->opts_mutex);=0A=
 	return ret_len;=0A=
-- =0A=
2.43.0=0A=
=0A=
