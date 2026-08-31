Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA944525A91;
	Mon, 31 Aug 2026 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188849; cv=fail; b=BU1kwQcG5P4ZMhUR2SpSsJuh+Hg77w323W8D6BCD1Rh4ioSzjnXoQXdeHHeDd3+uYZMwV4J/jI9k2hcAlByNdRI4KEWetWU4wxZV5UaVF0r6x8rTrKskjEoa2+zHJHQeYlDhd8rFz+8lfTZDCGvlBGm/2bojv7ICvKArMM4mMiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188849; c=relaxed/simple;
	bh=x/xUDRpfeDTQcKn/6BxmOYSGaD0JwJ0aby3dCb6r6I4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VqThGXGGZOdTVYaf/qijJywevc5lbjp9vznUMRkdvKIbLXqvk/rG4G3IWaSJmxuosH6245+cYfFnxQr8je41AtyXO3QTDS9lSlpGyTENA3ObxjmxYiZ5MTNkU3V/+nnrFwXa7aRnTox43kvqPIjQr6DmexlqU2e4RZF7CYXa6OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WOznDQhh; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WOznDQhh"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEVDoM889044;
	Mon, 31 Aug 2026 11:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ib4PE
	4EjexcdnxfgiSyAK4wibIBbzY4hGKIBXM+ZZBA=; b=WOznDQhh5XRsevtaeuLPd
	OlRPPBvr/l5voYLgbBrGwltzrUb7JlozhtpiQTRNKLQZqdBJ7sDvfERvNZ1nHg6r
	kbXtQhGpsJNvtmRmZgeSkxkzBYM7+I0lFHAdM3GGEAe5Zhjej+6bDyU4lFKjyOgX
	UleiNr5fXZh5eVdovXkv+1jpoIM2ie50j7uIEdFALlIKE2Ed5sgCWXkhVbR4jKgO
	K/dblR24/eHjyyagKMmz/0jnII6No/Va2UkNZ2f/R0FsfmedccfodEBYC5PwQ/62
	S3nuszH8E01ycssEwjqWyCeMYIO0OEtRiJrzt+syhEWb2zV68IoDG8gKMMbcv7zh
	w==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gcdrdn6ck-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:06:15 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUTrg639SY6M2hMrM0tpM8f93bDsKFQj5xAHWkc0Qv17XOWvOvFKFlYMaywKDvy1GV2GRQns6LikI++z15pcadhvzRD7bTbvUzfBxai2pKqae+FXhKr6CZHdOIqk1+VteM7p3krp0w/5iH0vs60VHLwjRHioB0qTT+OJ24fVr7TtKuLLoSgjdFAuIM+Lf5xE4m8cmoVTF4FdhPvA6wUQ3/VVMymYrh797sjnnG5L8bBZx4Gy1G7uML7lRyTQhsiEqGPW4bFerK488PLJfB6ozXEo6tqL4GauIy1nD2Vx/LOLZ6WO7rJjaGqSRLKS2ZW/8Sfn0QrxgF+7HbGK83H43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ib4PE4EjexcdnxfgiSyAK4wibIBbzY4hGKIBXM+ZZBA=;
 b=Rx6Ps4m6hKrfxNOWFfB01HxIwkQp/G4s1FmdPExqFSzkIkXNq52sWJuUizuRDnpJO5NrRinXN4+84yAbL/iK3ZfBawhCXlsh28oqNjOa1yUGEzdw5cdqm9B2G9Uy4raiMSXsojPJPBVgcnXdO+MUHVkkJjSO/2lDGs34zwqRZXK6yckGKL7GqxczzhBWq3jr882CgBtHIgJ3lCEPCUDxuxTA3KSYJlGzgvSnqxWzwNMqrcrcVO3CTFo72Zm4nAV3JcB2Z+Gi52ATCaL4757pNwPBAza6bNEsASis1TFig4ZhpA1eOp7h3QmdoHRSA6NdPdi0VJbzCSU6B8iHvGJzYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH9PR03MB767167.namprd03.prod.outlook.com (2603:10b6:510:3e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 15:06:14 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 15:06:14 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Mon, 31 Aug 2026 16:07:18 +0100
Subject: [PATCH 2/2] mtd: spinand: fix zero oobavail when no ECC engine is
 used
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260831-mtd-nand-no-ecc-fixes-v1-2-c2ec46641b90@analog.com>
References: <20260831-mtd-nand-no-ecc-fixes-v1-0-c2ec46641b90@analog.com>
In-Reply-To: <20260831-mtd-nand-no-ecc-fixes-v1-0-c2ec46641b90@analog.com>
To: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788188838; l=1923;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=x/xUDRpfeDTQcKn/6BxmOYSGaD0JwJ0aby3dCb6r6I4=;
 b=omOmYhLc8HqaHrQlBp6welGuSr8MtTp9c4Vg8alaooRXBF2Upwp/GeJKblQuuNcg4yP25BHHP
 qaQXOzytBeoB6A6aTLnkCndKB8jCfGw1TLrrZxJD86/eriqzO8OBlTn
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0061.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:49::14) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH9PR03MB767167:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f706f5-a8b8-4789-2fe4-08df07716678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	SiyWDOHB7Dut7UbsrJG4e10T+A2IeSnu3uzTH42NI963sr9TVQ0BDiIJ5JATP+aHOoeKfkXavLnGrcR5QlocciqyXfY8ZvnO0Hn/GYDN2z79LRqEeWUEvAECmwBM9MeUy594OsCht+2AtI15VcE4DfULFBRALkRWMe3G+FeXJZtXrd6AFJIn5pWPtNmeTxOaTZre5YdvkmNsK2z1z4Hixtd8+VHZQqSOgFZ4ggcaXaAVlF9vWOiolE/RCBpQ0gQfuNQ6r1lkQ4WgBjCqLiDSVdniqydL5FlolbR1RBXO8Le3QImES1ZWTZrv/AUS/6wf73G6/QizQB7Po4Tdpy/r2/uW55dUmteuXsmuJ825wPGsaWahl4dKhL0nzy1WpHGaVikT3JWLzGK0oMync3Dh68/9GXk7WI/3v+4sflY55VOPoACi3gLxVW4kj96H82T+lAHNIKgOdbWKm/4qwntrDqZgyrMsDbxKqy58IiaY46oR6IFtKw3ShYV9LK/PZEJkFzRIXTKvRYkgOGvqp978twhhCG0gJjM2y9KqZnYNgECoefYcbS1/rl+CqzE7e8d493kmNGc6p6CRc9OiHS2mBMEleGSDmhlmhmOQisbQF6cYM1iwnoXiyw8XJI7kd2YSLoH7gtVRcK9IX0SBW4TM1guxvufcywdC6jzWUKgpWNY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1QyYUVsRG14RTBtWldBbVY4cHp0cW5VVEpNaWdQTlIyRWowd0dFMWRibXNV?=
 =?utf-8?B?bnIrUzZhc05IMldWYTFDOVlyOUxxcTJJQWc0K2tBbk5zZGVTeW1uZ2RsVFo2?=
 =?utf-8?B?aHg2M1VQa2VpWmloSmdZN2kyN2dodGxCZS9RVjBYaVltOTZpTnUvOWJDbkU0?=
 =?utf-8?B?TXU4YXhIbStRekRDTEpKd0I2N0p6dDNUMkRuVlhmK1M0RVllMzV1ZjRwMDd5?=
 =?utf-8?B?eURycGpEbWk1Y0FjTjE3U3EzOXFEL3FybXArYnpyNU5jM3BGUUpRRCtaTnY0?=
 =?utf-8?B?clkzdityVFpwL0hhYS9BYk5FRWFUZVZBd2dxUVgyYU9GSndrVm51TmQwZEts?=
 =?utf-8?B?Y01EbDFpK3V4Y1h1V1o5ayt4SVNWQXljSXVsUmVNL21DU1RkU3VuU0hXVzND?=
 =?utf-8?B?TlIxTjVTLzd0cXZsNWVTdXlBTXRZMGdHVDhVNnhqYnh3K2xlekxQdWJ2RTdp?=
 =?utf-8?B?WjU5Znc4LzhXdmk2SHhBbER5cElJa204QVpTOEFLOUZ4cGZSa1hlcXZqcUpL?=
 =?utf-8?B?S2hLL3NJQWlzc2g0V1hCQ2tlUUZ3b2Z6ditlYTd1dzNPM0Z4TGRIYjRLanYw?=
 =?utf-8?B?czJoN1NnRFNJNlhzeXZpZXJUUy8rMVdsbEs4WlBOYkxVNE9kVzF4ZmtGWHlM?=
 =?utf-8?B?d3FiWGlEdS9wVVp3MlJuMm0wa2JOSXI5emlYMjBsdFJ1UHBFSzJpbDlDS2FU?=
 =?utf-8?B?bVIvbEd0WEVhNExwQzN5Rml2VHFUd3YyWlhrSFExaXRWV0JjbiszQkRXdnkv?=
 =?utf-8?B?SXk4UmhzSGxxMDN1TDNvbU04SjBGNXVlTTdyU3pjbC8xd3dIYWVGU0lDQVpD?=
 =?utf-8?B?dVVmcStYMGJXd2JnNzAwTkFnL0VQbk9OYUJwQTkyU2JPOURBZ01zdmZGMFlK?=
 =?utf-8?B?UTZXbzI2d3pOQ1JiZDNmaG9TRE02NVp6ajlIamxLNTk1Wk40R24wRThjT1Yw?=
 =?utf-8?B?VzNyeGNoaUxwVkhXRGRxWVlEa3JyNitTSkVtWUNRTDVPcmlYbGZTUEMycGtp?=
 =?utf-8?B?VHA2bzFtN0tNVGJnUEVCZkpwSGxYVnZBUEY3Uy9iU3FzOUlVWWM4WDJzUkxW?=
 =?utf-8?B?QXMwZEFJcSs3ckVYdkRiaDFzR29lZW9TNG52Rzh4NzNMcmhVeWJ2UXYxbklm?=
 =?utf-8?B?QzBObFZYNW1kSmtNbmE3ZXR2N1hHbHBwK3pmU2FSTmdsYW03UHNvSzEvK3Jy?=
 =?utf-8?B?bk56MnAvN0NJc1F5UXhwYmVtTmNjdm9XcjFaSUE2T2FLYWpMNXB6cmdxWG9F?=
 =?utf-8?B?NFl3elo2clJFeC82Y3J6cDdMbnNBcDFGdmdYZWVTbUNnclo3VW5ORExPNzdZ?=
 =?utf-8?B?amZGNTZMSWZlc0k0WDUrN01VcG9uUGFHemluOS9wSG00cUQ3cEhFUmRJdWlw?=
 =?utf-8?B?ZGxMcklaK1BOOWFYbnY0STFRVjVINDY1Q0M1cytBWjZiRUVPcVlENFRFeDJJ?=
 =?utf-8?B?RnNYY3V1aUhwbHo1Z1lhUXJvM3NUTnlzWEtRc0g3YXhBTG5aazM4NTdvNHNu?=
 =?utf-8?B?TEtNTE54bThQSFhsWWpIVUhsOSthSkVseDRvaTlmQmRuQ1FNbHc4OEJJZmFB?=
 =?utf-8?B?RE82UkxZdVdIZk8wZTFiRmJJa09ZSTIzSW9wbXkvcTdZdmszWWNDNllwMmFU?=
 =?utf-8?B?TnpWSjRWajFXc0FXMnROSDlCTFF5Ym5CL3ZQRHlhbGVDeXpEbmZ4clBtZ3c1?=
 =?utf-8?B?Q2VOZ2NKNW53SlpRNENEbmwyZzY2TU4rUHpwZWJ4ZzlZUWNtbGNYOUkxdWNn?=
 =?utf-8?B?ZTcvS2RRbjFRdnlsU3p3Qng0bW5MeFMwNlRRK0NVLzExekVlM3ZZblhYT3Vx?=
 =?utf-8?B?ZXNCd2NlV0hIUEtqUjBESWpGL0RIRmNjMXZHcm1lS2VrWUcwa0gxWCtGV3Z4?=
 =?utf-8?B?bkV6d0l1bnZoc0RIMHpBbENJQVRVR3NXZUpzMHJjbERhNHhIUVh5amJCNThm?=
 =?utf-8?B?dm1kQXdkV0QyQVppSlV2RzhyYzgvdWM5UW9xYVFUbXFPSmhDRHdrT1V5RStJ?=
 =?utf-8?B?aXJwVXZpeVZZaUkwWjdiM2FQSkV2cG9wYXdxZHBLZHJUWTFDdEViNElDVm1m?=
 =?utf-8?B?anJ2aG50QTZ3RGViMnNZang2dG5ZU21tMzI0YkI0SjFrdjk4RzFKTGZDU1lU?=
 =?utf-8?B?aFNIZ1EzaGs3Yk9VSHFaNS9FODVwOWhRUEdMbmdoL2tvVHpoYzllamtMVE4x?=
 =?utf-8?B?ZFVobFVkT1Zzd3FKZ0wwWVYyazZWZ0tJamMzNVJPNnF2amtIRGphNVpRcTBk?=
 =?utf-8?B?UTJMTDNPWkIrM0pqalViR1BoalF1bU9XQ2NJdEVjWTkrTWVqSUhDaDlmNGI4?=
 =?utf-8?B?RkZIdThFbkZlajJuUndqZk9RVlZ3MTR1dm1qK2krOEJXa0RQUzV6Zz09?=
X-Exchange-RoutingPolicyChecked:
	Nkvju3YUodzkJIBnXMmon36BS0yQkOcrMnH8tjsopl2df04kNVAIox7AqhhxRDUXKBzlSxzi6Z34VhPREbSTXfI66JkomT82/PvQFBdwaJ21P3JwFQNnti2wlK+zIB0z3Qy8FHdE2S/rKPx61jng27UObBSZ7lxJ2So0GIoXjYGurNqZ8OsGZc4jaIBOaiu4oRbA/buAxdlugNm7fV+ce4BOVIVHu9EUzf4dwmxaxKc7vo4tl+8qjkat1F0mDy9RwUOsyEUEuVwbhoxU/TX3rtQl6VrCe88A+P0OONC1+acUF8k4rBf8UyJ4JhB5pQ1NJuYgy/ONcJvgd3Do/OI21A==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f706f5-a8b8-4789-2fe4-08df07716678
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 15:06:14.2470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cf6kFjGXfeeytWhXo1Mf514W7xqX5Qqo7irqJXuJy2O15XStBwPFLzyAdlxhpIilo1ww8YNZLwhCwwJPuvymOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR03MB767167
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX2trGV+GR3SaS
 /PfrEIKq97vaicnKqVhR4v49B3GTzV8XFtE/i+i5YyPSTY55UPx/jkTJhOjQzFbiHIm2LbYHSDb
 LoOSGH5NGNOzALXYf3jVQt3y6ZWqIwuZhPDaP9daQIT1MYcTkduq
X-Authority-Analysis: v=2.4 cv=feSdDUQF c=1 sm=1 tr=0 ts=6a959867 cx=c_pps
 a=GcdpE1at2Es8HfJfZlkF2Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=pgLpeqkCuYE-37Z2sHMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 79b-lh6TnrFjR1wkjJTlGERIdVcr3VE2
X-Proofpoint-GUID: 79b-lh6TnrFjR1wkjJTlGERIdVcr3VE2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX2n3jvtJGUYJW
 Ndp7DrygOoklEcXWM/qw8fzrsXixQFLN6SZ9IApTgOxF0PbST34D1H69TZAvyRsbYgMyjpkcwA7
 mR9FXIqdLb5cDPBf+nDaTRf/7u2XrVbm345doyggfojLLTAMezlXWQ7/Cii63IjXV+zLd3TOokj
 U6j5Am2IVDLqtvQt1u0rheb4tnkJ6GFZ0SCpJx/5abcMvRiTwrS7CKaD7eIOauYjvNWP3lqQUwm
 Ew+h+NyH1AHC6VgoLW9J7GsEb/TWEM/ol2KNsOBXXC5Kq59Q7/uqMCP5aOLy/auzdD6ydycUmjf
 lu6UnqK5F6eXG3mHeZ4dAzPrmv7NOjMjuqCBO6Sx1g1SSXvEmBdBKq3xMRnxb9QwVH8g/N4w6Cw
 rdIMUiyxMkmGxTHq8XE1teVwOT3ENtQcHochO00qpDYoMh8DCQH5HAzNvPaxOSI+A1WZJgrjVrl
 7m9CcccPppoTarDTtIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310130

Commit 00c15b78b4b4 ("mtd: spinand: Allow the case where there is no
ECC engine") made the OOB free bytes count conditional on having an
ECC engine so that probing would not fail when none is requested.
However mtd->oobavail is still assigned from ret just after that
block, and ret is 0 there, so the device ends up advertising no
available OOB bytes at all.

mtd_oobavail() returns mtd->oobavail for MTD_OPS_AUTO_OOB, so a zero
value makes every automatic OOB access fail with -EINVAL. JFFS2 fares
worse: it keeps its cleanmarker in the OOB area on NAND and refuses to
mount outright, reporting "inconsistent device description".

No ECC engine also means no ooblayout was ever installed, which would
make the count return -ENOTSUPP, so install the same fallback layout
the on-die path already uses before counting unconditionally.

Fixes: 00c15b78b4b4 ("mtd: spinand: Allow the case where there is no ECC engine")
Cc: stable@vger.kernel.org
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mtd/nand/spi/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 03ff43445693..8f3d12c5dd90 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1978,12 +1978,17 @@ static int spinand_init(struct spinand_device *spinand)
 			goto err_cleanup_ecc_engine;
 	}
 
-	if (nand->ecc.engine) {
-		ret = mtd_ooblayout_count_freebytes(mtd);
-		if (ret < 0)
-			goto err_cleanup_ecc_engine;
+	if (!nand->ecc.engine) {
+		if (spinand->eccinfo.ooblayout)
+			mtd_set_ooblayout(mtd, spinand->eccinfo.ooblayout);
+		else
+			mtd_set_ooblayout(mtd, &spinand_noecc_ooblayout);
 	}
 
+	ret = mtd_ooblayout_count_freebytes(mtd);
+	if (ret < 0)
+		goto err_cleanup_ecc_engine;
+
 	mtd->oobavail = ret;
 
 	/* Propagate ECC information to mtd_info */

-- 
2.55.0

