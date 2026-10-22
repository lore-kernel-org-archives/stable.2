Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792630270;
	b=hXjuYfFtD849y4ScBPYETevEpaiycnbwEeC2d/SZJtamR2MbknhftozvTtgjKxHzvuyR
	 UHH/a8UA7m6ddw6uFtvy+cHXXz7MfkpMrji4hNr6B5bSnpTBRBr81LoukDUB9lfRahyDJ
	 BUEn1fz1uRyNWAY5AeuaWnm/X722JjE7Ikph+mU6rsbiknfgr9jHfecTSno6gAQp+S+gz
	 dZaViGesqrZkRNGGuWog5BIfNKutY0uW99CSewlKUzQfgT6BeYgYPCr+PuFZJSIkKhvTQ
	 WTEi0aS7Nnusf8t4g5geCaKcjLO31vsYY8HG6BTEf6XH6UPxOUWzNqiqZarvCjkIaBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792630270;
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
	bh=49Yjo/RKG8Xsgp0MBES1gC+MYGEArP05kInBZ3U+JBI=;
	b=bg8RksmUrJ8XIO/5kGpCEK1C0aeZeCXSlyNQfqV0ltt+lpsgzUSBceUA2SRFkn+SXhFY
	 LF0WuhcQByeB3gsR1TTQQM2mDiT6NeUDehonjfTXA0GbXM8lhBw173GId2Itd8exhclPi
	 BCxa1aX1aYthJsCbK5BVOAJEtxZ/4PgrruQJD1zThfFu3/Nhdjo5xeuJUZYQEXnvrqiUD
	 4/pmUYDQsiEvnAQWY9255+XsWMxDQpCe0EFaN6hKm5sa2jTPzY/UH2Pt5ZtIGSF+qFo1T
	 13cgnHwbKHlGNsa/7waWq3oyHyiW8RCq7S4KCh6X4nMrAeaGXlzG7wiiSrpAmuRR5Iw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chipsnmedia.com;
	spf=fail smtp.mailfrom=chipsnmedia.com;
	dkim=pass header.d=chipsnmedia.com header.i=@chipsnmedia.com header.a=rsa-sha256 header.s=selector2 header.b=uzaTj2Nr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.113
Received: from SLXP216CU001.outbound.protection.outlook.com (mail-koreacentralazon11021113.outbound.protection.outlook.com [40.107.42.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF58A606A319;
	Thu, 22 Oct 2026 00:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF58A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.a=rsa-sha256 header.s=selector2 header.b=uzaTj2Nr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zI7q+/9jK2WWexMcFExFvPGdEpdyCU60M21U/oXIYs17/728tVheSHiloeZeoOWYrq//ZEOJhD5tWbHqARsyTpAhFa0uocCF+JPbzHZ1TEYC2RNkm87mM6o4qry579MxD3/WD67XIAfKu8Dlfe8LOv1jgJHkiNcvfCEwBLBZEW6NHjbiyCEe8tZi0aw9tJK7hJfTz7Gn0sbioEY6W1P2bGw31FUFpUSvrU12s/S1YUeDty3xZGBK80CdB/Xw0sG/jSP/vYnpzbP8iZBLDoliZC689G7bXITlS8QjmbhC+Jpofkz9XLTjwQPBPdN4pFFF3TiG/8cBAT+/HVHB+FjOpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49Yjo/RKG8Xsgp0MBES1gC+MYGEArP05kInBZ3U+JBI=;
 b=lEqow1Wj6zFDVmG/ewvLThpmqlxTzvT9oNfowAWDQPQCewb74fEUqlSWJyfBF5YLTP7WYCYhTTPZ/AmhKQuQK7KodfqJezpnDEl0NpeGSRowebMDbmzIBgj7Mrsrbvk9LciCIoLyVh7lJn78Gdoqh5YMHT3uvDxVSNvJDecuskokvmaQmbHMvwyXWN8AohboWGisTkgdEXdRsJ+7gZJ2YgDDIzzWwQzxKDvC54cXcxdKOAvYCbcq+cZXlNcI4aI3y78mOGro4uHjv7c3PSnmBvcwMt/CuwXmIMv9pWmLYI0f/rFbAIqKeI8hMQas0l4T3IPM57MYZKigmp6pNOwf3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49Yjo/RKG8Xsgp0MBES1gC+MYGEArP05kInBZ3U+JBI=;
 b=uzaTj2NrJHQ1OUH80WQ6jKgw5xK9kLMEXF4EKY9sSVEW7bVOdXKlAEN+2buM+JBQ7kc59ssQ3PQXZd6NW2YK+CygaKO38dBvhkVTe+LUkmd15QPRMHiKa+/sa4UIU+Bc8FIy9sbJ2X8zJWiFhiAeQjDvczyrIr5mL7RpwgswfXPwpydLI9KI7RvPSy1AuVCr6EJGh9JIJjIyfn+6fPzMlxj4XgF1MHFCbfZsGcSwQuzqdjyYQl3T6fF4A8BHLCw8Sdy+THuq9v2ZvwuE0AxTavah5Ovjw9omrbafnb0zHkoleb2Ok7q/9WfUC55jrpuLLEq+X+9svaFB1D+Ycb0g2A==
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM (2603:1096:101:f::14) by
 SEWP216MB922542.KORP216.PROD.OUTLOOK.COM (2603:1096:101:305::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 00:51:04 +0000
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be]) by SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 00:51:04 +0000
From: "jackson.lee" <jackson.lee@chipsnmedia.com>
To: Jiale Yao <yaojiale02@163.com>, Nas Chung <nas.chung@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, Nicolas Dufresne
	<nicolas.dufresne@collabora.com>, Sebastian Fricke
	<sebastian.fricke@collabora.com>, Hans Verkuil <hverkuil@kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3 4/4] media: wave5: handle runtime resume failure when
 closing
Thread-Topic: [PATCH v3 4/4] media: wave5: handle runtime resume failure when
 closing
Thread-Index: AQHdYW8VD/Sl8n1VJEm5Y+Eey/BwnrcIuxxw
Date: Thu, 22 Oct 2026 00:51:03 +0000
Message-ID:
 <SLXP216MB114821BA8693242EE758E961ED652@SLXP216MB1148.KORP216.PROD.OUTLOOK.COM>
References: <20261021151552.428590-1-yaojiale02@163.com>
 <20261021151552.428590-5-yaojiale02@163.com>
In-Reply-To: <20261021151552.428590-5-yaojiale02@163.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SLXP216MB1148:EE_|SEWP216MB922542:EE_
x-ms-office365-filtering-correlation-id: b5613ffe-f278-426e-f151-08df2fd68cab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|261021123027099003|38070700021|56012099006|4143699003|5023799004|261009223027099003|10067099003|22082099003|18002099003|6133799003|261021135927099003|261021121427099003|3023799007;
x-microsoft-antispam-message-info:
 +abLkOHRzBZ43N0yFdsjyrLL++r2E9pa8QedhZQ2zyQOKLVx0EtY+xz4Ki+GUgE/JEKFy3EZRRrprJ5wyDVzg+G8aMzaOArihDbTximLi4e7syb/aK2vspZ2Ixp7X0FV4iD6RhNUXhUGXE7x45Jkz0RDTg5MpMXTLZ1RbcJFH5TOGD+0g6gF4XO/2KZpJcySrvDjAL6KvwK3LOe27e9tcGuRv15AQyyWh6CqzzfqL/BR+EGSk1hZv5zhtptFBSk+lwn+oW2vf4PnIIhgmwgiqHvr3zwEgnuVEA7TDxUpE5hrXdeRsQfzNepfxLYCeWmHnX2IiOdgbiPFrr7SkAfQPhLO08StVmaIjlfnnatRCUbgNvbaKzFaURijUNDb0CQlIEex/v2w54srpT3rJzCJpe3jU3sZu3IYRF5+UlEUflQ8qpAr8RtxxrIB7aPmcVkLmpObcNV0c2YvxvdJ+Tme3W+eDhTcCrUaXA7Wqo6lvamm5SlL39/XdUnBJnIOqqli5+Vgn14YrnjaxBvGy4fYrFhmi6dCUUPWcrJXHGFoLcPLyWMSQtI2tLSUbPUDfHvtqtKgsclgBuoetcrqoxFW9xgkKXta3yosGt0Csb29JQSaAKi0oq9VGqQBnhevRQC2dsaUjr6gPXb15JrDBI7H03CjuCtRs6Ito8kQ5pdz63wFffd3AwZnU5xXyC+mQigONIxPtX4myW9lbcjLIbW5RLDnV7gfq1mpuMy5340QONg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SLXP216MB1148.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261021123027099003)(38070700021)(56012099006)(4143699003)(5023799004)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(261021135927099003)(261021121427099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qpm8iTWV3IwqmQqpnv93FMZbB3vGB0QnkZkFVHEJx1/xP69vxtn1x4MGY1rM?=
 =?us-ascii?Q?LurBopSxKjrMsLJBDhwvo8b9kTPqrTGAFzl1BL9QZ5f0kGgactIwIW0TVdOc?=
 =?us-ascii?Q?GS2cjJF2JB5ngurYZWgeoIXW4mfGKnLspZlgft6UToPrz7c19TNB7gvySSXM?=
 =?us-ascii?Q?EZ01odDs1Q57kUM2ba6ssccwt6x7PmPKA+hFJAiu1ONnxhpTbcP1jHNGzaDv?=
 =?us-ascii?Q?HvcgdBzxbMgYXwzjv95UX6ksS0S7na7z3jmJSAdJj21Hf+zdYDP9bdAwhgz8?=
 =?us-ascii?Q?kE6AI9nmo/FmDdVZjCcDlPOFCCgwEMxhESL1BwwCb4FyUPS5SBfxKmp9QcL5?=
 =?us-ascii?Q?JKXtuMGpGY5Hr4FE6BGpxnXM5Rcq2UZvivjSh+AM4uAFnyRn4CMp2c67afeo?=
 =?us-ascii?Q?6Pr+xQ90iBc7do4oUTnLAsa1sruV+tzhYIlUQLt1hXp/vZSABJpqIbUy5KVr?=
 =?us-ascii?Q?TA3wxcstr735tthtp1Y3kIRwIX4QLphztT5kRg13JJUGnF4J0eLPL6LbTnIe?=
 =?us-ascii?Q?jQ5UOTLgPZUewdBOPSNTTYEna72PI2AT6OjSBpTMXIxQuO17xdfiE8MYcDBh?=
 =?us-ascii?Q?eDcFZ7gkkiQ9AFmoKU+vXaHfHZoSBz/bmnQGsXmN3OfS5B8wszhbmODifHyT?=
 =?us-ascii?Q?5A9lRU/BpLx6fAsf23KBDaeauhMJyZCk+ln+GSw4q7VD7WyQnP5XXeHYoCbQ?=
 =?us-ascii?Q?0G8Jc4Scf1738qYjVCTSJGXF/zv9WlF3WZw8EQ7UlNAQ9rb5kvbIbfcCJXjW?=
 =?us-ascii?Q?rC2jDAKEFFKW+OLwJD8YNMKHmPLfuEuBinzTt/ffBVaQ5w64FR4i19hSs+Oo?=
 =?us-ascii?Q?Yc5FMFv9D65B6IrTCAERJr2QppwxK0DBp6LtLWOdvjr9XAIXqr170q8sD7Y5?=
 =?us-ascii?Q?uEkqGbp6sRC80z0z/Yi6li3J2eOpO7A0tqjCJJGq4//JuzUPSVanfZU5fmee?=
 =?us-ascii?Q?OPzNvh/sd3RF690UuPpkO/u5EAgIZdhmjbnza1izzCLBPlNOxvxt9+cLSny5?=
 =?us-ascii?Q?WrFzgUKrg+7NxsDKYTAXBMgjAnesXLItBSkKgM3IzR9WfMNJvNWeiEqf+Xmb?=
 =?us-ascii?Q?ZrIq8K7HTCFBhJAXaKSXUOYdpaB7XTFFU2HTldrjyT7w+mPMwqIvJ3jYHk5y?=
 =?us-ascii?Q?Mraozff3wXLDDZyTObltOV1PPKWJx6V6wYVBCxpdMf4Fbj3XCooq6/fL9g0C?=
 =?us-ascii?Q?VTE3FKv7klQM/hMZSJ8OkNlJXTqfb5eNH+qz21qdhFNjVvXWqfvKvQVW1xyq?=
 =?us-ascii?Q?j/KuTdZHuh1CFfPFIsJUDbV5PSelLlC8mH/O2/cU1W3L6g1YeUMWAexEXr4t?=
 =?us-ascii?Q?d8Z5WoWjQXGutGm7rDIBm6nmJF4+E2Q8Cmd57J2Z0lIob5QJ8Zn8OEyHc6Zo?=
 =?us-ascii?Q?PdTYR2w+asTyx0pQIm5s1wTs3Je0mtoFOCNgLKkvE7ZIXB2IV8OS/2XQSpni?=
 =?us-ascii?Q?6Bew0uQ1Xxr3CdfT47t6UeaV6dAo42Vi9OuTf4YEpFVRTzTsu6S0WJ2SrdLU?=
 =?us-ascii?Q?JblGQ0eWVA8WwwXlT7Ok80788rD7NydZ43IiAarBCNVBw3JtiQYoQmeKD40M?=
 =?us-ascii?Q?5PQbeb60dGknAZPXErAnFFb4JN7IY6/SAeXwwNfzK4gjhmqEoxNo0PVrlJyh?=
 =?us-ascii?Q?KcEYvFLqJvD5Jf7iBD7YCEisVwFtCV0C7rQKzLTIUwmTjD/SoUDyWG5MXOn7?=
 =?us-ascii?Q?LPOSyNvaggqK+gugmpGQWMrVE0pkvRdTMJnI5dYFs+gLYTvJw9YdwmuhwLqm?=
 =?us-ascii?Q?MHmTc+I3Iw=3D=3D?=
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
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b5613ffe-f278-426e-f151-08df2fd68cab
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 00:51:03.8854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YN30FYUFk0EBqjD2ipPHPs6unofcRn3VQ6DTlCQadE/PdL/6Xq5jCmU1Vi/86gmCcTwfbeL9F5UkS+3DMQyjz3Rar7WLN2Iz1jHFBVlYaUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEWP216MB922542

Hi Jiale,

Thanks, this version looks good to me. The decoder problem is fixed.

One small idea: you could also use a helper function for the encoder, like =
you did for the decoder. Then both close functions would work the same way.
This is optional. The encoder code works fine as it is.

Reviewed-by: Jackson Lee jackson.lee@chipsnmedia.com

Thanks,
Jackson

> -----Original Message-----
> From: Jiale Yao <yaojiale02@163.com>
> Sent: Thursday, October 22, 2026 12:16 AM
> To: Nas Chung <nas.chung@chipsnmedia.com>; jackson.lee
> <jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab <mchehab@kernel.org>=
;
> Nicolas Dufresne <nicolas.dufresne@collabora.com>; Sebastian Fricke
> <sebastian.fricke@collabora.com>; Hans Verkuil <hverkuil@kernel.org>;
> linux-media@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> Subject: [PATCH v3 4/4] media: wave5: handle runtime resume failure when
> closing
>=20
> The decoder and encoder close paths ignore runtime resume failures and
> proceed to firmware commands. If enabling the VPU clocks failed, those
> commands access unavailable registers, and the paths later drop a runtime
> PM reference that was not acquired.
>=20
> Returning the resume error directly also prevents release_device() from
> calling wave5_cleanup_instance(). The instance has already been removed
> from the device list and its mem2mem context released, so its host-side
> resources leak.
>=20
> On a resume failure, skip the firmware command and hardware lock, free th=
e
> close-path resources, and return -EIO. Use a decoder cleanup helper so
> auxiliary-buffer cleanup cannot overwrite the resume failure status.
> This lets release_device() continue with its common instance cleanup
> without unlocking an unheld mutex or issuing an unmatched runtime PM put.
>=20
> Fixes: 2092b3833487 ("media: chips-media: wave5: Support runtime
> suspend/resume")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  .../platform/chips-media/wave5/wave5-vpuapi.c | 47 ++++++++++++-------
>  1 file changed, 29 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> index 4c1842f02c..31be2581ae 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> @@ -206,13 +206,26 @@ static int reset_auxiliary_buffers(struct
> vpu_instance *inst, unsigned int index
>  	return 0;
>  }
>=20
> -int wave5_vpu_dec_close(struct vpu_instance *inst, u32 *fail_res)
> +static void wave5_vpu_dec_free_resources(struct vpu_instance *inst)
>  {
>  	struct dec_info *p_dec_info =3D &inst->codec_info->dec_info;
> +	int i;
> +
> +	wave5_vdi_free_dma_memory(inst->dev, &p_dec_info->vb_work);
> +
> +	for (i =3D 0; i < MAX_REG_FRAME; i++)
> +		if (reset_auxiliary_buffers(inst, i))
> +			break;
> +
> +	wave5_vdi_free_dma_memory(inst->dev, &p_dec_info->vb_task);
> +	mutex_destroy(&inst->feed_lock);
> +}
> +
> +int wave5_vpu_dec_close(struct vpu_instance *inst, u32 *fail_res) {
>  	int ret;
>  	int retry =3D 0;
>  	struct vpu_device *vpu_dev =3D inst->dev;
> -	int i;
>  	struct dec_output_info dec_info;
>  	int ret_mutex;
>=20
> @@ -220,7 +233,11 @@ int wave5_vpu_dec_close(struct vpu_instance *inst,
> u32 *fail_res)
>  	if (!inst->codec_info)
>  		return -EINVAL;
>=20
> -	pm_runtime_resume_and_get(inst->dev->dev);
> +	ret =3D pm_runtime_resume_and_get(inst->dev->dev);
> +	if (ret < 0) {
> +		wave5_vpu_dec_free_resources(inst);
> +		return -EIO;
> +	}
>=20
>  	ret_mutex =3D mutex_lock_interruptible(&vpu_dev->hw_lock);
>  	if (ret_mutex) {
> @@ -258,20 +275,7 @@ int wave5_vpu_dec_close(struct vpu_instance *inst,
> u32 *fail_res)
>  	} while (ret !=3D 0);
>=20
>  	dev_dbg(inst->dev->dev, "%s: dec_finish_seq complete\n", __func__);
> -
> -	wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_work);
> -
> -	for (i =3D 0 ; i < MAX_REG_FRAME; i++) {
> -		ret =3D reset_auxiliary_buffers(inst, i);
> -		if (ret) {
> -			ret =3D 0;
> -			break;
> -		}
> -	}
> -
> -	wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_task);
> -
> -	mutex_destroy(&inst->feed_lock);
> +	wave5_vpu_dec_free_resources(inst);
>=20
>  unlock_and_return:
>  	mutex_unlock(&vpu_dev->hw_lock);
> @@ -750,7 +754,11 @@ int wave5_vpu_enc_close(struct vpu_instance *inst,
> u32 *fail_res)
>  	if (!inst->codec_info)
>  		return -EINVAL;
>=20
> -	pm_runtime_resume_and_get(inst->dev->dev);
> +	ret =3D pm_runtime_resume_and_get(inst->dev->dev);
> +	if (ret < 0) {
> +		ret =3D -EIO;
> +		goto free_resources;
> +	}
>=20
>  	ret =3D mutex_lock_interruptible(&vpu_dev->hw_lock);
>  	if (ret) {
> @@ -774,6 +782,7 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, u3=
2
> *fail_res)
>=20
>  	dev_dbg(inst->dev->dev, "%s: enc_finish_seq complete\n", __func__);
>=20
> +free_resources:
>  	wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_work);
>=20
>  	if (inst->std =3D=3D W_HEVC_ENC || inst->std =3D=3D W_AVC_ENC) { @@ -78=
4,6
> +793,8 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, u32 *fail_re=
s)
>  	}
>=20
>  	wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_task);
> +	if (ret =3D=3D -EIO)
> +		return ret;
>=20
>  unlock_and_return:
>  	mutex_unlock(&vpu_dev->hw_lock);
> --
> 2.34.1

