Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794351715;
	b=yaI1N4i7MO2GF2aRF5dCr0khqj16fao9nEXAGr+QqnZy3kI40ho8igBoIJM2rnfd9uyf
	 sz0ZNHI8T42rRQONsm/b3dxCY766U3wJ0tCeRp20PLvdohjm6ekYq71GfSMq3m/QRKFk+
	 djaOIRbwp4x5RecoyUo+7o0ODYJdBKchskMtqhR0lnbj4pGPygLGDCGtQQ4r9XmKkZtYO
	 YU9OtVaM0XVfekOHRgywLkhT/NHVtwJqQ5sWsq41pLQOiLQjXVFSFnyipEfopwZ9rA0EC
	 iB/jH6QfII3NDSg43nWh/+7M3frZ4Py8UD3HlDionUwokN9L/fj1QR+mxbSwiom5qVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351715;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Content-Type:Date:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=pZee+KzChQw/h9ewmpwQaoj+eV3S7ffC1hCMvrWt4Ms=;
	b=mQnpRsRwwDXsCpW4oIEuWvo0XsGeKtaqLZiDSaXw3FBj5+YusZEmqwWUTT7uXAB9govI
	 AD7t3608QJKhdHUxPwJK/dT6148c/17Wz5ekdCZJJfrAWcJp9tliwkBKPolIHZgJntgPJ
	 4RMAx0T+LdLE/h4nx9b7k93t4xRQVSkfA15ullgFxw8WQfR5YbXSxYDw8DcSE8xXywZ+f
	 ZgVyeEbgbkMGlUj+EDFL5CoMlTZE7VrtmJWgqafnZg+aws0o/jLFWw7WDvUC5k3698mlT
	 qzgX9oQKEHdADA3jDRc09/ohPV8KJj2ZFpvy3OTtdcSFz8UhZX5uVygjpEu8iRWWaEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=k2Vtas+S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.16
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011016.outbound.protection.outlook.com [52.101.125.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB3F606A31C;
	Tue, 10 Nov 2026 23:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBB3F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=k2Vtas+S
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbIuiidzXE/gyPEPgY5qzdflRjzjfMnEUIOB5mqUi6Erza4UqJQ9S8UKYqcvwMINqg2Kn5j13Z/hSfHGnXWPZkJlx3GBReuGrxc4swKMxBEOrNXPCm0jOdM+VciqjqewWfnUCx2JTDJi+oiVxJ4Sye1GM/vcVm0yRlzfjxDyCldiEn/Vka7c+6IzX3gqHquoTMo26MSDlk8oC7wn7IAfge70psPyo47MNEW/QIY10cFDm4DnL8Qmin7aRbCKVQ6ZezKt9n27qUMae/0FkyoKMio/kderkaWC5i06oTqZ1UJHKOraqvr8mAJcXP9Cn0Abe9TCo0F9KvuxRAfcXnDr2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZee+KzChQw/h9ewmpwQaoj+eV3S7ffC1hCMvrWt4Ms=;
 b=hPPdSK4FFXLP4K/t6F0iFjXP0Uqf6B6xACAPFpU9iB4SFKoRq/MYqMijjqHdSmzCXvV8IJS7OfEBdDyWNGamgxRDGfvqjYQ3EfUyLELxgjZR3P+fNwHnwse8R9yTc0JB9J4pqhTASVA5/pF27pTSJo5ssekkzmTDVa0sLsdjIO3oIF5PqJNoHBywKkqrg3X0zsjoTvUXBLyB1xxZHxNDNuRIOU4SMueZmoBo2Y23i0q/uMYewHslAVn/yh1cNQiiScrbZdI4hKZ1pBjydzCpTlxL3MmtFmJWZcQOwmejHrt1eE0rjNK/4tN4nZsoP35YfPWJtlgrWyAnjpxOa+rxzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZee+KzChQw/h9ewmpwQaoj+eV3S7ffC1hCMvrWt4Ms=;
 b=k2Vtas+SUMi13FeKbDKHcgAp9KQvd07dF4uZkr771KIS76zEuugR38PNPDf1wZwf6lArHudVTMWCrWFtJu+3kQl/rWJ49oywHKH37DPNoC/HStu26XzgNQZPciM9Yb1xQzzw61127x7Kbxt4KoKNdNSNIN0MKSJf57s5GPKuTCY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYYPR01MB15175.jpnprd01.prod.outlook.com (2603:1096:405:27d::8)
 by TYYPR01MB7877.jpnprd01.prod.outlook.com (2603:1096:400:117::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 23:01:52 +0000
Received: from TYYPR01MB15175.jpnprd01.prod.outlook.com
 ([fe80::9bfd:a110:68f1:134d]) by TYYPR01MB15175.jpnprd01.prod.outlook.com
 ([fe80::9bfd:a110:68f1:134d%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 23:01:37 +0000
Message-ID: <877bik2svk.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Hyunjung Ko <hj351016@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: ak4613: cancel dummy write work on component removal
In-Reply-To: <20261110054453.2286414-1-hj351016@gmail.com>
References: <20261110054453.2286414-1-hj351016@gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/30.2 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 10 Nov 2026 23:01:36 +0000
X-ClientProxiedBy: TYCP286CA0369.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::13) To TYYPR01MB15175.jpnprd01.prod.outlook.com
 (2603:1096:405:27d::8)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYYPR01MB15175:EE_|TYYPR01MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: 730cb563-eda2-42a2-0d46-08df3f7e9287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|23010399003|5023799004|11063799006|56012099006|38350700014|18002099003|22082099003|6133799003|10067099003|261022105027099003|261022075727099003|261021121427099003|261026140227099003|261028144727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	hA69dsXzaLXHubXuoMMdrqdKVCdQOfwckNV0J6S/hWAdZgroCe3PB5vbQx/3ujZfYMwJXm+MkXjaonPs1a7ncauKulOLfKBbf6TM+Jr2bPE+b4ASrN1to4/6Ftqz5BSHU0xwC4iL3d5kWCCHhHZaBpiyod50/8SSspEXV4UEBmn8evD5hw1trsml/WZYfnGPf264xYhbnY3SbWYIa6qbiyCLf+6UqCgNJnsdXnEAoncELjquQBbWOOpOHtF62B4mleNnfV/+rWtqFeDRRqmzJtIWuNLdWcVYT51S2+N74keHiULoJnNOIilqEp8rFgypqZTxtuFRU9JTjM/UWXaed4uI4PVtBSo1xPK5zcRpJzmkAEpGS1ZGjXGVpqp7C7X4sLt2vXsgBUBpGr3btyxuWQyd2ML+MU0Doq6P1pEPwsDmF+OiSx/+k13AFjCKfcjpnlEqsbuIFZ2AEpWVwkBuMRGoX6XNfs9ZMWImq6/wdkKBappMQolzU/v6sPJMiVDRheSJo1QZCnZ1w8jWoXGX9Ys0mW6fYTAU9ykj7Z5qx+cwV7SpLPQynQpvXCIE+fvhW8hsw2q3qfN6GxBcQjwfbFmQxI1CJwd01QH3BfwTZXqErqPdoVSo1vSmXTyImM0/ANlASkuhqHkAk9pNi56YqflqVoLpnki+CYd4Zh/G+WnEFQ+0+5Bo+wYIfRwX6bS13RU3fawU5AustQEzhtlUz9cdJDizWnG/SpYqPOK6oxA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15175.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(23010399003)(5023799004)(11063799006)(56012099006)(38350700014)(18002099003)(22082099003)(6133799003)(10067099003)(261022105027099003)(261022075727099003)(261021121427099003)(261026140227099003)(261028144727099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jqhK0nmQOm5P5Npfc+ql3Ej8QEHNwm54DqhsymMT0TPY+Y3n1bjC3qqfBMa2?=
 =?us-ascii?Q?7b31/dOEvPnk65SIsa5K+ttpy50c49tVE1b/PP0U0mavoHGsoN4Gcyoz7E/v?=
 =?us-ascii?Q?mRe1QBS476f207STsMECXmVuDMDSMpEo7xBcHGaDAskeOKLRvbXZEPVjVGt0?=
 =?us-ascii?Q?BRWxx0BXRvdZ6lGLz4tYv0qr7VsyQgUEzpd4iMfYs+nt+3/fg7YgkSCrTVP4?=
 =?us-ascii?Q?jYRbnqp8qCBC2aZPFzeEXjACMgvgSYdzu7tmQVrOvC6RTltdt8uw2LQ3dcMC?=
 =?us-ascii?Q?07OP8RHQifpF25wBExmdtFajIory5cnZ1uLWSZ55b1fNob8xU2zXS+HLLjjQ?=
 =?us-ascii?Q?b5+jOQR7zWm67WeUlgmQOdG0EUMTJnLawX9NtGh1BCQcm5mfRIA0MMHeS6Ft?=
 =?us-ascii?Q?BHia3ZOAE0jrgB6hNNKcap4jMaUW4kANca4WYtjNXgv51dkFaL6Wme51Hu2J?=
 =?us-ascii?Q?ywdVgmCLMdfFLLtz6gMkpSeLwRS0zHTmjuDudeaIoTqunGF5EzhDlurkf66g?=
 =?us-ascii?Q?R1dZ6e/wY3jzTMCccBDqlOSkMTK+qICCE6MuotTcv4kJqiVtFWdlMdOfdv1G?=
 =?us-ascii?Q?Y0NrjIyhaWaoOYqJrGW8qx0bEPQZzTrNY4Xlzqrf75I+y6ksVbntNto6c6tW?=
 =?us-ascii?Q?boCIhSvDAYkYYEoBiPeT/mK0WZlZKVt7KAAD0WU123ee46/YYGaN4QMjFItX?=
 =?us-ascii?Q?mx1N/ki6oXnm0pcirDvzOAagoJjjZ2ggnNagxUG3RnDJfU+UD4hakAK1+H8R?=
 =?us-ascii?Q?vg1lyNV78DIaQCq8dOvOK/b1sxq8pDO6RxonPj6mzNlNXxC9uDH1sUP2/Jlg?=
 =?us-ascii?Q?Xyvv/EBqTucV9BzTI3krluD4/Qz0m3RqdZFvD1S2qHXVqkJ39h1wRLKDfBp/?=
 =?us-ascii?Q?g8ZBGNFyXoH7yxL8g392hvuqgu6nztG05VSYM+olcosynMYudEgU4XZimVGN?=
 =?us-ascii?Q?jeQBT9SklxEoh7hSPqGf0tK1StOYCxtfuHL8jI5Gie2barlyQrnwPRBHFLoz?=
 =?us-ascii?Q?NSvTSkDQ/Afk/CvSvLjpeyUGAqs6QulI5udsa6umxNZLOTTFngTwXfeMYMTB?=
 =?us-ascii?Q?QJK91IN5AdpOHJj86LOUsYbgJLgKFdUq0oVL6GtbpE1WCPl8XdYro93iqDFk?=
 =?us-ascii?Q?OpIkU8Ouef2MjhtdESko8jX6Sq9DmXCbcbw1hY9RmtC8U/rLy8f6G1UXT8Ys?=
 =?us-ascii?Q?8tpLKiRs/dunC4+dx6m9Wu412O0av37daagzRmvVPoBDb8ekC6ZIYtmtIos2?=
 =?us-ascii?Q?plXBNhq0P+fDKe7JNHtJsVSYVBO9UhVYs/NvM+hhCl+wqes4CSgr1BvdvE4N?=
 =?us-ascii?Q?iWfNzHfxQkVYqo/vTtwLeOMl8xTnUSEtAX7M3LC4ZnMs9OuFyxKZXmHExEE+?=
 =?us-ascii?Q?oFlSOV3MfjZciO8Zj4P9Iv8dj/sVLrk5oSCj1jzJYP6NkuatyfcLEc+QSJTD?=
 =?us-ascii?Q?5xOKzVy24xoa6YgrrSzsvpmWKz1Hoo8r/SwxfiLg/G7ZGbeuCle417V9GTxa?=
 =?us-ascii?Q?oA4N+y5YFXG/m4LC+qIhfW8ehk0lOi7TbiBh5lBV4+5etn5g5pnqJmF/3ETs?=
 =?us-ascii?Q?xlxVto+DkZiaPWSDaY/2dV+oeyCGCAOi4WRhnH2NvwQiP66Qqard5O7YVHfw?=
 =?us-ascii?Q?GZO84gt1o95THZ0z9oZGRUVI8YuoC7Q82ezYbxG6l8AepzP9gqlZ3o1+ZC2y?=
 =?us-ascii?Q?KgdiVKLdieBR1eb/ruPi7/bmo6ykvlK0Z+4U3AnbV/LkfF4Gey3QMnondV28?=
 =?us-ascii?Q?H3BuVh2cxMjmYfU47LPLISF2ISgW1R3OHjO3gcqWugDwyAL4+uov?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730cb563-eda2-42a2-0d46-08df3f7e9287
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15175.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 23:01:36.9973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3XrJ2tyVmP63GF04/OQgIC7AiAYPhhpWGarEFSbNtNAAjlmSw0Bli6klLK7sf6UdOJ392pouXG8sT8ALu3BNMjDUgVr8tpZSTcWQ5eOwVSM7yEIyrOQPXYDpu3swnAQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7877


Hi Hyunjung

> ak4613_dai_trigger() schedules priv->dummy_write_work on playback start
> to issue the PW_MGMT1/PW_MGMT3 dummy writes from a non-atomic context.
> The worker dereferences ak4613_priv and accesses the component over I2C.
> 
> priv is allocated with devm_kzalloc() and the component driver has no
> remove callback, so nothing cancels the work on unbind. If the device is
> unbound while the work is still pending, the worker runs after priv has
> been freed by devres, resulting in a use-after-free.
> 
> Cancel the work from a component remove callback, which runs while priv
> and the component are still valid.
> 
> Fixes: 03bbf9f5e4eb ("ASoC: ak4613: call dummy write for PW_MGMT1/3 when Playback")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> ---

Yes, indeed.
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thank you for your help !!

Best regards
---
Kuninori Morimoto
