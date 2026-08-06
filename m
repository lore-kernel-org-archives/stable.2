Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020141.outbound.protection.outlook.com [52.101.61.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98436442FCC;
	Thu,  6 Aug 2026 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025856; cv=fail; b=Tyu+89SA73qFjqlDhBml6x6YKUiMpIO3G0ROSXPOI3UvXCEZyMkuDC8H+xQBNmj9pSasUlmZY7CQ/vD4TQMycbvJ/UAIDawv53l7p0a7dmMJIurqLQ/DnaO1AwVIaOHE9aN9aZGftn3I7VUHZ4E5FUx3vFQjef5l43TR+Xpi3eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025856; c=relaxed/simple;
	bh=VG7YaCdc7YsCUewZY3CzeUqQoap2zqDmZwswATXyHRU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HS0BKAGbpA0EcqNYNxIMba96fFjEIvHo3FEp7ilGXy+5+svN/1vp0SMqNiQM6FwtAXN1XzVGns1KW1LxigZShGSOlOxSM32naZGU9gYOOC04zSHrSbX52FH2iPV3OUAdYXhzjUMYVTFHjOSE6vg892zR5+XTWtHqFoaa4thDZxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=XNiIV0pu; arc=fail smtp.client-ip=52.101.61.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XNiIV0pu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOEtgNIW5PBnTmRYu40K9PVHnV8+SGiTjwAiMj99I6+dHW3VlSFoJu8kJpYnlcbAVQGuAnZMgalJK2ea1NHRTK918n0JkclZ1xMTBm4xpUGr8IIn2gh4oBTePlcqB3/gFtkbYUuQy9oKJK7eZ19yFK48fnTyj3oj7soAd6nqladwnhEa/UL2aW0tbEA5NXByzlbyaD5xdC7PBmDOZ8VqGojHSkFkGP1MUFABZrnuZhmhP2LZ3p2kA32mZSeGIzTqnZ6XFNTHFW7CwN2TEIiyOSemwqr/zXla5M6lwjAelU5TH5NbXnoo9U8QXk/dxuq2Ccqpeja1g6YC1QdAAXfIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXZZKcB7D4UQic7+jNhaPgkQ1Q+MGQl5uTEz1ITLx30=;
 b=mXvtKX2rgXbwHAYNiMfaieGbXuy9bC9OVJkGHcTm7/hQFMVfEYKlS7dCri8UTypXneThuFVANxXvBWYZraEM34WyCJRnsllUD92tNKGGNlOq9SgVyNd4S9EbS+Etesjkj3bJFGPESFEp1IRVQBmTTABcuCwfhBLcc0DrXaC4lH31rJNiFYGKhwUO68uaQEUPBD1FCKHjxZNzYR/5iCrZLOEJK4B1NkDIvFZCVUsnD/NmsnHJiGCGNMR3u2iED63SFQHT0jzgVAiAIABbjOED21z3lgRM7UQmYTHH97V8b52otYAMbd3FLIPVwomW3WeCL5ysPpSYgGltgivYuChjeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXZZKcB7D4UQic7+jNhaPgkQ1Q+MGQl5uTEz1ITLx30=;
 b=XNiIV0puhpkNdiPDs7AXshZcJ1ZkwT5Qh78/9FEwyiE49xLP37sjber2ojQtW88FcaEbaSYpP20+la2dznI4LMxQ+eFYKgN0iAYfwMhAkztEbu94TRokbVDPYn+IpO1of1YM3ngQfH9cOkkGkDaf8ZeGJ+lnrfpeGxOpPq2KKgc=
Received: from LV5PR21MB4704.namprd21.prod.outlook.com (2603:10b6:408:307::7)
 by LV9PR21MB5382.namprd21.prod.outlook.com (2603:10b6:408:2e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.3; Thu, 6 Aug 2026
 14:17:31 +0000
Received: from LV5PR21MB4704.namprd21.prod.outlook.com
 ([fe80::144b:98da:1262:2ebb]) by LV5PR21MB4704.namprd21.prod.outlook.com
 ([fe80::144b:98da:1262:2ebb%6]) with mapi id 15.21.0315.001; Thu, 6 Aug 2026
 14:17:31 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Fan Wu <fanwu01@zju.edu.cn>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Dipayaan Roy <dipayanroy@microsoft.com>, Sahil
 Chandna <sahilchandna@microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <DECUI@microsoft.com>, Long Li <longli@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net] net: mana: fix reset work race with device
 removal
Thread-Topic: [EXTERNAL] [PATCH net] net: mana: fix reset work race with
 device removal
Thread-Index: AQHdJOg2mtcqzdMGRU+fPvslDaSma7aREewA
Date: Thu, 6 Aug 2026 14:17:31 +0000
Message-ID:
 <LV5PR21MB470447ECF9B18154AE2F2D66CAD22@LV5PR21MB4704.namprd21.prod.outlook.com>
References: <20260805143812.220509-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260805143812.220509-1-fanwu01@zju.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: dipayanroy@microsoft.com,sahilchandna@microsoft.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d3e2481a-0724-4161-9fe7-b061c267c8d6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-06T14:14:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV5PR21MB4704:EE_|LV9PR21MB5382:EE_
x-ms-office365-filtering-correlation-id: 646848bd-8484-4c7c-b33c-08def3c573f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|38070700021|56012099006|11063799006|7146999003|10067099003|22082099003|18002099003|7053199004;
x-microsoft-antispam-message-info:
 24yhdiL3oXACK0KpufXRdYnga3DLra3JhiCxu4riPFPcxZWSfGHwPCFaWmv2wFpEbdqtEnYdS7/oivi7/eWyIgn6ceAfJqH6QNKD9J6s59gRNTYFdYujRor4CfRgPbjFndUHGwaLPUg2iHXTCg7p/mtZEZiupa40nLBj0M/EGCZZlVuczM6X9bIbt9LNHQQfqRV3ULuD9v2CuTiEsIQ11L6xhKTYE3GE9d60omxKr58mY5M1VQRxJmQSJCCNEcZlM7gGhwuyNDa6liEMex0DcSJ6gH+AZNsjTxN0SAYCk/XAzaP60V6ebl3X2DQFlBihCOgcXVvpkTqlfvAG5vv20pXsZP/Xg1dXMHt5uOQxtWxO8AYdLctC1/MKeIsrpVEmDVqYtiBT6O6cFNGpxLjwCnBfxp/yUW5vBVRRhkjl0lr+XDX1/QHS2vcV3FxoKphfnecU6Son460akenoa1stB3sUaReDyQDInfTMjJQ6/ndjyFI6A7J/f1/yHnzDvsPLxUoiB8gZlktrMWyTroTBBy00OeEeXu7i4kkuWkpBn1X2N05svNG+3hFbdd4suvLEpD9qqtVJa1W77tAHlx+sD4acwIzor9ufu5p6YTvzp7KAU07dSVI08zBXiaoCP7RRvGdIg3Mcu3CFcaNVFOoUm8Zfj2XSvO0Kbw2i7RYUkRvn8Arv2U4orqJxyAEuH3fXxuAEyYVGb40uZfmblGWjV+6yNE3JxY1ShJhd6NcH/k4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR21MB4704.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(38070700021)(56012099006)(11063799006)(7146999003)(10067099003)(22082099003)(18002099003)(7053199004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5r4s+hc8CpHSVWqmiJdbDB60Y5qe2awrbYATOIe8UE4/h7cII47GQeZemzth?=
 =?us-ascii?Q?8TCi2oiWRRMAd7222DidJ0bECMxs2NXrccGuW2J6KBqMIJMEzijX/yB8p+6I?=
 =?us-ascii?Q?9m7GSpnTBdqq+X1UovZi7nyi37OR+++Qz1weGOo4hSr8N7iLlMnvKICheyT7?=
 =?us-ascii?Q?dC4gJKvdzYelsKpU7SDGnc79Kc5dtO1w6tU5Ag5Zl6i69TOx8acJjngbZX15?=
 =?us-ascii?Q?Ej7lSOlEoo0MIldJY2iX4B7gqDUnCVsba2zVqxg8n9zMvVRW8LzXifpmjg7n?=
 =?us-ascii?Q?P6YEUtom/qoV0NOHG6s4DjDoVVDrXFSs0EuqYvrL5u2QTXLXxx07ht772/sE?=
 =?us-ascii?Q?nRE2W75mAF2egGIGvLyjIi/sSzWd7HA5qwk3356bT4yf+TUOh5fiFSV4GOay?=
 =?us-ascii?Q?7dS9gZSpLzcqvR3etswwtAGWyqKLF64+obrNd9XbcVxkkhDc6IL70i+5SBM2?=
 =?us-ascii?Q?rJg3irhB0RUa9SWDw8kCB4xPNVR8h//XAx5D/cmQKA/0g1eJq0y1I+NH/Pgb?=
 =?us-ascii?Q?lX9s/Ob7rEjkN41SgIXZM7CnkzcDPUS3/bsNqaWUnNkbyrPWx7Ra0AzcWTtK?=
 =?us-ascii?Q?+kAIzB71t/fUL/G9FRtREBV5TRxhk8Hct4TpQu+QBnQGxLLD/b6jlfqCocwF?=
 =?us-ascii?Q?oXOwVox5qY66ZuYjkb4Fv7c08r4tVxiPNj7WhJ1YH/x81TY24nMf0P+03smK?=
 =?us-ascii?Q?V5K4cE45iDiNPsifAkrnc+Iu3LQgM0Q+m0iPYTCTezcRb4/4IskADHP/vAAF?=
 =?us-ascii?Q?gG58W9EXWQWLNMXsH9OLA2v9a4kIwmM6nqTw3vogLuM9VleGZ85O55rkJaOL?=
 =?us-ascii?Q?eo0yzQ3JhkTtuyvrDtYkWn/ghB8AoXk2XKSSByqsejJUCdf3Anl5XkZtRiu2?=
 =?us-ascii?Q?15HZlhjM/ccrw8HoE4lCdycg7Y1e5Ljvp2azfHabRxaleYTPE/rzbbIWwqY7?=
 =?us-ascii?Q?6eXxHkv+XGB387MRyIFKYmv8LgYXIZEg3xgphv01DxniA+0i52KWsrPKnI9h?=
 =?us-ascii?Q?tttqvCoWcWKoCPHYS5FWDMJ3aeDdm3LhmJBOq/C7OG9Djl08XqgNlo2Z1vXl?=
 =?us-ascii?Q?HryWJkMwvXYb+OuQNKFvRObA6jeoR6+lPxUEcVt/gc3hOoDzxF9jd4nZRuaH?=
 =?us-ascii?Q?t1+7XSLboyD3GmgOn7zxY3WWV1s4uirMGoY4FN9th/rnuxvM0OM9rIxab198?=
 =?us-ascii?Q?JrUozalBidjRId2uFVMWYsn10dc1KvSIP+rATfUmc7+Yg3sgo7zn8sR9t0DE?=
 =?us-ascii?Q?7UZEdctDGwW2ZPOFaDv2hoLZPUkixrubMCWJR4bwl5fg+Ks3hJH1JDr9/RP+?=
 =?us-ascii?Q?mHAGoPVZbgYh8rZbpEFjq+bdJbcI2wrw/jzhxaEzXoDKp9Ihe6hTfS1VEhiQ?=
 =?us-ascii?Q?5fQmZ1cwHbJGwcC84kBuZBUGItE8ITOgFBLvH4n/fckh19TlQX3AmcN4e3b6?=
 =?us-ascii?Q?+hbCojGI7BooTD7KKQHYPIt3zCJfl+v5WALC6eE4fECp9vtqTRHsfTz8kX0s?=
 =?us-ascii?Q?QhatVebmZfV2AqVhwTnv8T1vc3jtHLzFs7yQeyg7/6d+hj3Ur6H2M+vAYsto?=
 =?us-ascii?Q?6OevnBgOevWvRnf6lr1+2alZs2/f8i3x9mrw5jwPZb2/JYhXbtw8jMz4v8ke?=
 =?us-ascii?Q?1Aij5wvKMKjUaTg5kATZa6GwytyIdmq+/U8rKC4T7TbaAWCqZHTHRtOyDfaO?=
 =?us-ascii?Q?gi6f6W3Ao4/C/YReTZvQLrrfnsD6XGRTEWt9XejZbHATrvSaFI0EjzSoQwMF?=
 =?us-ascii?Q?jNb5g9kDAA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV5PR21MB4704.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646848bd-8484-4c7c-b33c-08def3c573f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 14:17:31.2234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7sR1TL9sYawchxHOGhFuhQdMwq+dzdW9Vnr2hoVP7P2+317osZcYLFMHbazpMmidW3eQI8B0ya6a1UZ6AL0FMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR21MB5382



> -----Original Message-----
> From: Fan Wu <fanwu01@zju.edu.cn>
> Sent: Wednesday, August 5, 2026 10:38 AM
> To: netdev@vger.kernel.org
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <DECUI@microsoft.com>; Long Li <longli@microsoft.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; linux-hyperv@vger.kernel.org; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: [EXTERNAL] [PATCH net] net: mana: fix reset work race with devic=
e
> removal
>=20
> [Some people who received this message don't often get email from
> fanwu01@zju.edu.cn. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> The reset service work runs on the system workqueue and obtains the
> GDMA context through PCI drvdata.  It can race with device removal
> (mana_gd_remove()), which frees the context.  A reset work that runs
> after removal can therefore dereference the freed context.
>=20
> Serialize mana_serv_reset() with device removal by taking the PCI
> device lock across its drvdata access and reset sequence.  The driver
> core holds the same lock while invoking the remove callback, so remove
> waits for an in-progress reset.  Work that runs after remove observes
> the drvdata cleared before the context is freed.
>=20
> Drop the lock before rescanning, since the rescan path may remove the
> device and acquire the device lock again.  Also clear GC_IN_SERVICE
> before rescanning after a failed resume, so this exit follows the same
> service-state cleanup as the other reset exits.
>=20
> This issue was found by an in-house static analysis tool.
>=20
> Fixes: fbe346ce9d62 ("net: mana: Handle Reset Request from MANA NIC")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>  drivers/net/ethernet/microsoft/mana/gdma_main.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)

Adding some of my teammates: @Dipayaan Roy @Sahil Chandna

- Haiyang
