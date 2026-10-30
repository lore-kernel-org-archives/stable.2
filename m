Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793363479;
	b=bpnrHdyAsj+kRGRCi9Qfmqh2xItqMSBSYwz7M7h6zlv2TbQ28WbHvw29pJVZBlORoAYn
	 JIik5UPLqPMLDXR5pgu3EvjPxWBxfar3+PHrQ241oqbbLO+A/LAhqj50AXDqRs5oaz3oU
	 xJvKLhufJH76nlGzPvmv8ywAK2nuThBX9bdTSX3+oLmP1zoArqpOdT30tx+8UwXVHB7kk
	 BvB6qN3m588UbT2dfsPILCGJ+UhkRRgqXd6Gsz6lCPgRvSIKuPBxpiE7+Vleyr45IQVrw
	 Y/lCtpF+ipf4hqHT6G5+yGCbcuiflZG9s2URszyEHbAYKi8PViJGKnnHi1ehj2HYt8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363479;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=kTis4An4UyWz4xlpu/d8537qtJJIgPi/vZRnyXTaoaY=;
	b=idxAkhDLWA3dSqKafMygKThzAUFCqRaC8mxuHNo7oCnPyfDKWkU7hI9QpEL3Myrcc8cb
	 CMfHzeQ5pIs+Ily+vCuxPMTDeEW6iLnw8cXRtXTYQCUrLBD+0N/jQ3eWSqwCb2g/wTyqP
	 2mQSV2t3wCa2Bu3d7noYZeVzYblIiiF/KqKIulqf7lHNZrzIBEDpxsRuh1mcCdft5aopE
	 P3Kd4o0sFfWcoRH6S3qsLQiqRnNNZwEgMLcNbsoOrqyzpYG12pMCb0zOkUqB1egcgVGkg
	 P0+zDboicznRxMz51OrxCm5RO3Xg0UKmkGAldCjC6vfslZIxKuyHEAaqAOjyr5Dh9GA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PiLSE8Fz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.14
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013014.outbound.protection.outlook.com [40.93.201.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3627F606A31C;
	Fri, 30 Oct 2026 12:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3627F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PiLSE8Fz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PL+l5ur7I1JRCLQ41MIkn9ts8mCGxwFf1lQDHR502SYVGQYU6tRmb8JMQbtnlt+/WQzqOreM3nOxcBb95P3goxc1jaEIphnlljGmdON7NHxw5QCS8/pPS2j/sQvuL4NKGrhr7dz92w9doS0X7j7+KE4qokxIM59mJyAGfY6Q0Oa23zM9QwepMmJJhqehutgSBFM0xRMvX15Ngby+p8RHTctgDpTc7eYuJkSDvVq/BVC5345H2PswMJYK4NxWClnTOlRfdf/Su6vfMaBJ+PZZ+6GdF5DD7W19XK40k7JQl/MYgEkOBcL61A0jQvuBAmXfkd2NQ9pp/c4XykmtrJf1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTis4An4UyWz4xlpu/d8537qtJJIgPi/vZRnyXTaoaY=;
 b=gIFnuoxeFyhix8GJbZv5IJVQ2Bcwq3ZtmBfYC0zIh/BDIQoXuuD1xAPkUghbBiPOZ3S40vSqDQv4oYMRML0Y8mfvgB5ef6SkH6CDHFUQy85rx574+PEsvXhMFs5ygjXiDaq3h7Dk8+YxEgivWBh18+Tvgyxodf2yTdrnH8M7Ruj8doAruewWmpM+Stje343Y6b/0ndsJR+F+870RbQXjyQ+PJZLSQFPL63qWbo/BUn7NQD7PUEtkB59haw5U2G/BUm6nI0vk9m/EiXEbEs5/uAEmncZCAaQamuq1xoDkJckmIjmE0zH70FYXUeKxn6Iv64XD+qGQOeWmjy9xO9CnTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTis4An4UyWz4xlpu/d8537qtJJIgPi/vZRnyXTaoaY=;
 b=PiLSE8FzQcp9LG0wRqkGEKFtArFiRXFq3QyGNf/EdFURmVlJSbcFhvKNKLJTvOLb29OncEiW9ihmnjs6tFMue9qW/8Wt/IRcu8yI60Wsa4MrjVWXEb02rMPci9EZ4Mda/yorkZh6zqsCr0F3xb1ZbBtu27Hs5RfBCcU9Kgb6sGo/R6jobQzCkTHA/jDJ+0Dg+HkGtGlSkfBy9IHoAKxqaFPF//fInBy+8a28y0gLjxAQJ9RQUlR622F+XAUwSJOwmODwMuW1rjkiA3CAarvxflc1Av1ZrfWx1tnjCUR5ZKy7bX2XuDZGMz2tj6R6wtvwidNLxaiUGOfBYd/sme+2NQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by IA1PR12MB8239.namprd12.prod.outlook.com (2603:10b6:208:3f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 12:31:13 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 12:31:13 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v4 6/7] gpiolib: cdev: don't report a failed line read as an edge
Date: Fri, 30 Oct 2026 14:31:10 +0200
Message-ID: <20261030123109.1935475-2-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030111435.GA76958@rigel>
References: <20261029-gpiolib-chip-removal-v4-0-aambrozewicz@nvidia.com> <20261029-gpiolib-chip-removal-v4-6-aambrozewicz@nvidia.com> <20261030111435.GA76958@rigel>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::8)
 To PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|IA1PR12MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: 837cd9d0-83c1-4b9c-7ddc-08df3681af60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|22082099003|18002099003|56012099006|4143699003|11063799006|261022075727099003|261028144727099003|261021123027099003|261021121427099003|261009223027099003|261022105027099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	nkJciIJdETWJ7MtwxNQ99Xdw8ks57OUmOu3no1A3X3CAPYPIqPlhCPaNXl2+gGaZjByVpnIu7ai8daO2Sj/wNKzUcTdbZMYwQvDqCOXit3EfPt+6+PkptswY6q6Pb955PNu6F8gJEdq3zAlVXu25tqzeh59JIXkGEy1DNJXKrm/9JIXyAwrnAzKye6jtrHzA3bTECYl1WojWZB+9MIGYRzBhpZ1r0KjYhlyAm1L51S9Lic0oh8hXVrqWvt9dOpNmjDnq56Sm8U32jk7843dlHuVfcVaib0Cs+O+wizsAusxqaIxpL8GIwpzgdsh8PEQz6arL1Lp8skrzTPfftNLsuOzATKKq7kiluHg2EeBzB8N5JBfgFX2j23aLuFMtW+OSE+EIerymWhFWeidJmGdyQAIP0aACfqu5cqikBQWQEE4lTtaZUJmvniKCuOxM2T4Rp5fRHGoYbESDWQO3cIFjZkQqTJdfBKZj9z4fJ3fqFHMkxVA/t3aUUkTVENY8p/yLUnY5Lype72K+TGdpExmLUu1bbBPBx83pLkh3Qz43X//ptwmoOuuAk8XfXxdoD4ZL9kHmw3VB+EUjzrTEx4lbJIDmi5QDdPSwqT3guNPX2itKCpfNUkECd63OsiF6V8c86j2z9CJ4WqMuSkmZ2Zs+BNGvs3UQ8G/ygAlberVeNxQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261022075727099003)(261028144727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261022105027099003)(261026140227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YL7orgwbvTIUP7JmZE7IMlb4HXtaSR8IGOHbwV+yFrth1Yi901xqCywYJ1f2?=
 =?us-ascii?Q?n4I82mnES9Fdvea7IQ5UsrtE0ouq3XxNkIlkZTOS2oxYDRK/dmkFIp1W6W9L?=
 =?us-ascii?Q?H5NHL7FLoGBTVdRaubzF1Sd6TbgllWmf3foi7hYV7dErrJ12Xhwd4qa6wiH4?=
 =?us-ascii?Q?CwTToXOYnp0MTLRly5s20lris32cwdYj1MKWB4ez7ZJPLcA7tEAciBPF/owR?=
 =?us-ascii?Q?3cQlS3lcwmO6o4ziOri3dnOrrYmrj1OerrU8RSzEnco0bRCm8NdMJRvbxwiT?=
 =?us-ascii?Q?2bUOmOLcY8sHZHxtcaBV0FXhy7i94DPcpjvHW+tugr2w4DkO6vhB+B+N9Dye?=
 =?us-ascii?Q?nAJEGzbLyJi8RiQAD6SUu+yZncBB2ujLSCubKr9l7N8dmdO21KKm/5GJmNcu?=
 =?us-ascii?Q?+P13bW4/0frmTJ21VGSN+qL45VQaRHDeMR8Kzvb5IAFtQZVdErCbSZww9NJi?=
 =?us-ascii?Q?ebgyGKr87lS7gEV5TJ1JIZZQ85zbKc34bCqr7vGtkm9uNnd099J1SnsxVwok?=
 =?us-ascii?Q?0RBa1wBR7/GhfTPyVeDSlySSlEw3TmlTW3MX3biafKAqqAooCvNw7BnzFhas?=
 =?us-ascii?Q?VyarQvnCmxTaD4K4jD/W3ns0ag96oIyeD88dF9lAUtVYt6vCGtHqQhRD1DQU?=
 =?us-ascii?Q?qqsGEG8iJQ6RabUpVY1pFYzdOA01L0/ghPt+ZALj+cQaxC3p3Yjvm2/EEGmf?=
 =?us-ascii?Q?vJyGckBlN2fjVDAbX69FQZI3Sw2I5O5xfhXeLgolArnS7YWxP8Qltcne6cfy?=
 =?us-ascii?Q?eDa0Op8EDicULTekByS+pLstEwCDpLLPRxuXOaTo/BUNzcEn8jUyMrGhw/yf?=
 =?us-ascii?Q?t/+4qubVv++HEGoqgXg9E20hMwcrUQZmV44sHzujlBxpuR7x2IMLDb6WJC7o?=
 =?us-ascii?Q?rzJpsmuhEhq3eRi/P0LcKJfYC3Jykjdvzepy6p75ElJB+TBUwuFZVqvC0H0H?=
 =?us-ascii?Q?644+ZZRlRrQnOOUF0SA833d9AuGyIQTNDNMHFzTILSfp5b0sbGadCWJIN4WH?=
 =?us-ascii?Q?lVjRskGEjmNy1o7CJ5HO3wwu95emzOqVHTJF4mMZPJCrGy28Dmo1eqfSTMEv?=
 =?us-ascii?Q?QxSf8xOII3F1cqKutSarVK46/e+gk9+I1Td4y/UKkTwuDfxhVq+5aJOAjajh?=
 =?us-ascii?Q?bQlCX4weFV4CLMqc+GLMmeEfFJaNwMZP5OywJhHe4jMVAsQzklI7ddQxymoI?=
 =?us-ascii?Q?DECXKEKJJGI6EIpfs4+YI9wa9uE9XxS6Wp3kJSdMheP2SOHJbZR4Sil1CY22?=
 =?us-ascii?Q?Wqvz7l5C6ZK6fC4KNAuWZYmAdtcvVqz6P5/JYM+In8TpVkuDO7GXJipcrdgB?=
 =?us-ascii?Q?+xfYeFfcJLF/8AyzWPoE49saETIVa4mQNQKMoUmlJz0gczbIPhSYqLeJwqRR?=
 =?us-ascii?Q?ZzLSq3ZLVTFSmDe7kGSr0OOAVKQ6Fpo17a9k4K/JdVml+WaQUbm10euy+Ypq?=
 =?us-ascii?Q?FgmH4Hjf1gIvipSpEchSjWGX5PRuEchHvJy30sz3hHopJMz/E5Vk42p7k7OL?=
 =?us-ascii?Q?TUjdndto/i6X/CnQ+Cb2i34v0Vs4AVBrg9GQNj3/2wwWt+ot9yI2it9GGwva?=
 =?us-ascii?Q?7j5OhccxHF0VG3gi8XjxWCdCb4b2SQRw8GEEQAA2EwDyMVprhl3JFAPkD3jw?=
 =?us-ascii?Q?pM+7zLgJEiXq6IoheEDrW2GjsWwp/xR8y4h7Y0ZllVX+R30zF8pVk68Pnmru?=
 =?us-ascii?Q?lyRSx5x+g/hjX4lbpC5QadTEzM7ShtPlzYx6IcIF3Bsx+bJPcco51BOKWhz6?=
 =?us-ascii?Q?XVwoSHB1fg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837cd9d0-83c1-4b9c-7ddc-08df3681af60
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:31:13.3275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvTZt8c7pmhfrPA6raDYHCfIGXdAZs3RXkSDTTJsqdfZuScWk2btbaFdloCQQzv5i5L/bImmzMxmbWgOD1rSyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8239

On Fri, Oct 30, 2026 at 07:14:35PM +0800, Kent Gibson wrote:
> > Fixes: 61f922db7221 ("gpio: userspace ABI for reading GPIO line events")
> > Fixes: 73e0341992b6 ("gpiolib: cdev: support edge detection for uAPI v2")
> > Fixes: 2068339a6c35 ("gpiolib: cdev: Add hardware timestamp clock type")
>
> How did you determine that?  Those commits are where the associated blocks
> of code were first added - not where the problem first exhibited.

From the hot-plug case in the message: a driver's ->get() error has
reached these checks since each was added. Removal is newer, as you
say.

> The failure mode you are addressing was added by
> commit d83cee3d ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU").
> Prior to that gpiod_get_raw_value_commit(), and gpiod_get_value_cansleep()
> and gpiod_get_raw_value_cansleep() that wrap it, wouldn't return the error
> that you are handling.
>
> Could you bisect to confirm?

Confirmed: with gpio-sim and delayed IRQ threads, a falling edge
during removal reads as falling on the parent of commit d83cee3d2bb1
("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
and as rising on it, 10 of 10 each.

A test chip whose ->get() returns -EIO gives a rising edge on that
parent and on gpio/for-current, none with this patch. pcf857x and dln2
already returned such errors at commit 61f922db7221
("gpio: userspace ABI for reading GPIO line events").

I would use Fixes: 61f922db7221 for ->get() errors and d83cee3d2bb1
for removal. Is that OK?
