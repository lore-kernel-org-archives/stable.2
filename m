Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793565114;
	b=I+ctJ3fAn/5iSEZgndm/Wg1MJOSAuDLRn+OqtSe1f7SeYeVzMcsWtJkWMnCoCGR3YWwp
	 Uqr7YMNbEoq1eyFIBrlflX0QoO6ai+0FBvximRaTxqKkhQKg8zdsVNV6Q0H0gwBCqmjBa
	 ScquuvLhWlLTGLDSEUI6FAWiX+sbAO84KAjsR73OAMW1F+H0fvqpSd378iwXZ8ExEYh/d
	 6PON2LA8h1HuY3NOOu21HCCK8aiAyQlARbQQjeiHT3O/FbwQE6z3e0TnJq7/RtNx58j3x
	 MWeJwiwcblxPqwurbSX1tERItD1xFq6SxFt9NK5l35jXWULOi8redJ+PZyvlM8/qcDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793565114;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=qwY6kIQTLPzWov54qHOvM+TK62ot9H/ibtyULblRoOY=;
	b=if1kqEy5zvdhkpKSqm68n0UAbEBJHVAyHDVqX11lWswTJjlrbl1D5ag3z+txX/IuNzkJ
	 Ly/JeKSarqMCKGPraqRORmudTugGv94E4ta2uHWm/lB1GEGbMVT6Cyl8rzqek10B5IhXR
	 iv1ffZaXG2Nw4CkDDCYWa6Ja543iHd6+hcbvSdW0Xj4Iu38JrZk7InHI7QGOi7ds6TGy8
	 tzcB+ODvXh6r4gIR/EECqSAXBOsC7/AaahPMgsqsx5cf2CA3fyB5ikASsjjPJTTCFcHA2
	 amQrH3Hrih0wreFh/9DGOsM8xNr0Dn+J1GYT2uTYVrVbJmGjvTZLlTbqujZLpEQh74g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EgcdEJ9N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.21
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D49606A324;
	Sun,  1 Nov 2026 20:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5D49606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EgcdEJ9N
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fz/dCxGTz0x2XvaSPV9lc4FreAi31xI7dDJAyZ4cVpRCqkrjs67LmuBnCftLRucSXTWqS1oDSGYRjppFK6OREn1+7EzPvz4dnjL2GRipICeguEF8AWwNeQ25wvRWZVX/w/wFqGSz/1XxY5xYS7nitBskY/xP9i+JAH68Rp0epZXGvxhkgJ2xd/tygzwuIEECze9Yv0ZW2DlFi/xwDThOzerdzug5RPaRmdOkfw+2907IaVKQyMBrd/cKSW/Jxysrmblmz+s9Aig3JqGX/Qap23nZrHsZVZkXmwCNuXuYlIzi0DuxXk965abmgKqgL/bu/ntNUGntIRPn0fUuXyqOFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwY6kIQTLPzWov54qHOvM+TK62ot9H/ibtyULblRoOY=;
 b=CHPte8F57CqKe5NCoTLuWx6JM25UeciGmSKYQcSuTsJJOSqKjz4I2asHS8Q3tEZyynJcm57iAMTRNBPOdhvOsTCA+cxdvgKQTPW80WICDydqeDhLrYVwEQsA1GM+9bQAr7AnZ2aNG4FdddXgBdoM4O5dpr7S7RUlaAIxoOnR3gYSpW1aIJTIY7hYKt3ESVM8z2E4UI9pb/OUuH/9gHrh0mUqN4ZR76EXxPpxaxNpkmIpvv9uwZO/sm+37c9KGOF/Tk2ckf4ISexHgq/tLQ41frSqYFfj7oIMV+fXPcLwj7S+xTMW2xREjTwpAVwpEE/eh9m68d707L9DqPImPBb34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwY6kIQTLPzWov54qHOvM+TK62ot9H/ibtyULblRoOY=;
 b=EgcdEJ9NRCVK3UoEbJdrcfU3JqEpRBeQ5g1HndObOFbl6kcYWvU8STp6pSGJwMzrztsSZcbFDfOrZFNHydassq8m7CZMnkooJSkpKJRTQTd3RJs6SFCUhDuPaZ0jP9Fxydx8z62zoKN6yCPK15JyYIwa2gaZoLZ5l2m1kul6oUKjWj2pUzw7Lnsfm//qhAxg97zBsykUc4ruRfT6z7yUXsMk1EZ++uQ18pG9WQjT9e8fjOfMQLw83x3PeAghkIZM201//OdF4tWY8ttaHCaCWP/W9Iy5QtD2mYD6mdNe/03C9zLlifuVvC+sdTJXSCiNzX5si/aA1kM3L5xfl5kSjQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sun, 1 Nov
 2026 20:31:45 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0569.011; Sun, 1 Nov 2026
 20:31:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Nov 2026 15:31:42 -0500
Message-Id: <DMK5RLDQBPQE.O1YJZ0ZX5YBV@nvidia.com>
Subject: Re: [PATCH v5 04/12] mm/page_alloc: detect zonelist rebuilds from
 memory hot-add
Cc: <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@meta.com>, <akpm@linux-foundation.org>, <david@kernel.org>,
 <ljs@kernel.org>, <liam@infradead.org>, <vbabka@kernel.org>,
 <rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
 <kasong@tencent.com>, <qi.zheng@linux.dev>, <shakeel.butt@linux.dev>,
 <baohua@kernel.org>, <axelrasmussen@google.com>, <yuanchu@google.com>,
 <weixugc@google.com>, <baoquan.he@linux.dev>,
 <baolin.wang@linux.alibaba.com>, <rientjes@google.com>,
 <rostedt@goodmis.org>, <mhiramat@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <muchun.song@linux.dev>,
 <osalvador@suse.de>, <joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>,
 <ying.huang@linux.alibaba.com>, <brendan.jackman@linux.dev>,
 <hannes@cmpxchg.org>, <bigeasy@linutronix.de>, <clrkwllms@kernel.org>,
 <nathan@kernel.org>, <ndesaulniers@google.com>, <morbo@google.com>,
 <justinstitt@google.com>, <Bessel.Wang@huawei.com>, <jiang.liu@huawei.com>,
 <mgorman@techsingularity.net>, <anshuman.khandual@arm.com>,
 <stable@vger.kernel.org>
To: "Gregory Price (Meta)" <gourry@gourry.net>, <linux-mm@kvack.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261101021340.2251928-1-gourry@gourry.net>
 <20261101021340.2251928-5-gourry@gourry.net>
In-Reply-To: <20261101021340.2251928-5-gourry@gourry.net>
X-ClientProxiedBy: YQZPR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::25) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: d6da741a-3ea4-41a7-3547-08df38572587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|261021123027099003|261021121427099003|261022113327099003|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261028144727099003|11063799006|4143699003|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	QupNHcujqHpU3PwbHyhSOdv1fpb0WZx75ZFn559AjdsN6jETmuoOj00DoKvEgNmC0DiUF64K/DWvTxxFolAV8UVzoGtEpGPU+3abebyVyD8Mh1wsxxS5HV7cBn9Yht/Vury2wedly+hvwlGGKkb9MGPM4ySPLqEXiC0RVp6uhJIDcPF3921SRzbgD5cRPMrfXTLW8FCuRyXQld5NqmudIo4+OzMecintadWWqdG+7Qyi3L4FDWYzPxXg8ABroN1LGwzd/RxfQUkeNRyxLQLQdAjTgqIhRP2X15euN+HwJcAoiodGVdSdFnaesUMthZTpjMX2UGc9BLfdKNCmNQ0wvyRbg/dUvJJ+qtu7IEAIbzsCktQp528Pjj5K339OuvrKWOS+PP2U98zn4Wo9GXdHWKPDjQoigKy8HkEWOSK2i7QepTlIg3pXJcCfHdq/D4nrIk+a0s1wpYX2SI64hHCiX2PAHWF2JtkO3Z0SIFn8uJ/11STR0y2ksMG44N6vvYREpGgkYdJKp8iF37yAkl1Klvrw+CuVxm2ummPd9ewzJyKF6gOiJnfCWRKhw3cMHlOpWRzsCHMw4C7fTVqRTOCmJdIzym5SRpFECxtvOP+WzpwXfDtQoxAeswwx4kFzdEyg6V3q/kSbUt0ekXRq/i1puEO3nBMrdPLAdfIEHZxHTQE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261021123027099003)(261021121427099003)(261022113327099003)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHlsSHRjOGIvZ1pEZU5RVFBnTkZySWhnakx4K2hGZzJuanBtWUI5b1FEdWlE?=
 =?utf-8?B?dUFvWUovVkpRN1pSbGJLZzVmd0tFS25WWENhSU1yS01EY3JxV3lHN2xhekNU?=
 =?utf-8?B?ZEVLRy9SODhYR2dpa3VvUzNUbi9MZUhIYXI0N1BkN1hzOG9KQzRxUnQwTVBy?=
 =?utf-8?B?M1A1SUlYUkVlTnNMc2Q0bzRybFo4N0VvM0RKdlRGajkrMlE1dllvOGtXdXZT?=
 =?utf-8?B?SFhSVGFoRHZpUW1CaENQbXNqSlF4SUJSbjJhblZGUnRQNHpHckEzeWVta3JE?=
 =?utf-8?B?NmFEd1lydXI1YVczeDNVbXRPbjRZbVRSUlV1THJtVXZCWEtmSmtRMGRxSHQ4?=
 =?utf-8?B?aktMcitHbFd4U0hQUEpkL2ZrRU8wOFZWTkllY0VBdkNWNERLYjZWVlU2MDVC?=
 =?utf-8?B?Y0FLUWJEU1laVExtQ0xRWm5JTlpmSGtWQmt1VHFyQndvL1I3b2lMdERxMXgr?=
 =?utf-8?B?UWd1T2N5cm01NGxWVS9RM0lxRm10VUVaZStRakNkdkt4SXJwQXRTUHdSbHBi?=
 =?utf-8?B?N2s5aE5rY1p4NFIrQTRpZFVHeGFRMmJHU1RpelA4WmE4M3pYZ1dmemlRTkJk?=
 =?utf-8?B?Q1Q4S2tGL3EzblhIR1FWWUlSdHVYTmRpa3BvVmFJN2Z0M215M0R0VDc4cis0?=
 =?utf-8?B?Mk5YS2hwRG5zVEhvZFdITWhPT2NPeFk1NkRVTlFXK3dQYmVLQWp5UUZxd3E2?=
 =?utf-8?B?WlRtVDFZYy9nWWJRVmlsN2tmUDVndHRzelZRazQ5ai84cVJpVDZsU1NHMGNt?=
 =?utf-8?B?WkVDeU5XVEgyZUFDR09rUFgraWl0TVhOUDZDRjB5T3JWTVBBczg1dmhGK3Z4?=
 =?utf-8?B?NDgzWStwV1FqVWFCeEF5Qm5HNzRqZzNKUmx5NG1LTlRYdm1EVnBTNGNuY2Qv?=
 =?utf-8?B?T0F0aXcxZDZKUFQraldSRDNtL3d5cEE2Y2lkZTY4UENzdllQQUNHVUxlVk1j?=
 =?utf-8?B?ZUNJejQ3WUNhTVVzK0MzdHJONUJOTGZJRDZ6RXFSNEJTQ2JXczlHelV1N0tQ?=
 =?utf-8?B?elIrM3Z6dUlUNDdSbmtzeTc0emZSdC9mRXdaOGo3ZG9qUHIzR3ViTFFNSkd4?=
 =?utf-8?B?ckNLVmZCMWxFdWJGWVVHODZ6cjNEYk5OcHhnWm0rSG90c1JKWDlSQlVreFZy?=
 =?utf-8?B?REhuMk80c3R5U0lOTzN4bU9WaC95QjR6ZHMrKzJ3d3E1S0ttekpxWVU4Ynli?=
 =?utf-8?B?bVlQWjI1R21XY01zMkZEOFFSZjFXQVR6NkhaakN3UGhRMXREK2hwdlRrQWM3?=
 =?utf-8?B?Qlg1dGFIVGUzTHhpQjJVSVhTYSt6a2ovWUNQR1hoaVJTYkkxSzRrT2JBQlFM?=
 =?utf-8?B?TUpvQ1g5ZjFjalBnRG4rTkVnbnIrSjI3alRRbHVKRGw3TFJhaXA3WGF3ckFS?=
 =?utf-8?B?MGFVS2I1U04zZlNpd3MyNUFocmtLWWFxVnA0N3JnNWVDQVRVQkhPbVBiS2pB?=
 =?utf-8?B?a01wU3B5SzhlazJwTE54c0REaXVRZUk0Q29NcEJMcjE4dHlPSHJHQ2lrRmlE?=
 =?utf-8?B?cGFWbnNiRUU0YTUxaHh4d1l5MzExVGIxSUp4Yzc0YkFYekRsdlBsQUZWc3Nw?=
 =?utf-8?B?Sm1vV2toUDJqQWZSNEd2OFVvSXhnN2JrV3Fybi81dVYrRVF5T3BleEdFQTds?=
 =?utf-8?B?RXVTUEp1L1dQT1IvM1NlUFM4aXdyR29ZemF0L09xemZkMjJYeGRYbjdtTkpZ?=
 =?utf-8?B?d0dNTEtpeWhTTXBHcEc1NE1wMHhHOFRUNEdQUWVnZDBQQjh3d1B4aGJwN3Y3?=
 =?utf-8?B?dTVOeFFkK0htc21NUzBZczdhUTRPK2NyKzJBVUp2U2w1cTEzWnY0Q2RISTJM?=
 =?utf-8?B?eUdsN1dVSnRtclo3YVNReXgxOEphb2N4VU1jS1BnMjdMZGowQWUzeTczcHFT?=
 =?utf-8?B?T1haTktxcVAwZVkzSTc1ckxqVVpMQk9lRXpDdStQeXk4ZnhTSVp4ZWtRV2dE?=
 =?utf-8?B?c2Q5SzlVTDFFcXdxY1dNSi9vcEdrNWF5cmQvZStoY24vVkVOOUVJblJ3ejRC?=
 =?utf-8?B?VTZvQjNydGsxRXFBUXd6Y042M2xxVjFyd09vRkU5aUJrYklicXdjam9YRVRK?=
 =?utf-8?B?T1l5WnVzWW1JWmpUQVo4Umh6dmVQeFI2N2VHUm1ZYitzNnhKdjhkQkxvSmdv?=
 =?utf-8?B?eGx1QlBibkpkMURYNVB5TDZiUUZzdGZVOWpHbXI3TjlpYUFoRnNsRXRiUWhQ?=
 =?utf-8?B?bnFkNmRBQ0ZSa3FVYmM4Z2Z1OC9Nb1luMzNDSzVISFJ1NkhXOXlvbU5UakFl?=
 =?utf-8?B?MDFOWWxFYnNlQUdTR2RvV1AwTUpuZU9ianVTeTVseDYxU2thbk9KMjJEK0Jk?=
 =?utf-8?Q?ltx4gaVSJaV0/dOrf9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6da741a-3ea4-41a7-3547-08df38572587
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 20:31:45.3682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCkTGY+GARRPSyq/ivwgPNqzrWdHPRqNU07aRTW2txn1nBDxPUJmiGdwjswUPskp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452

On Sat Oct 31, 2026 at 10:13 PM EDT, Gregory Price (Meta) wrote:
> The zonelist_update_seq retry was limited to CONFIG_MEMORY_HOTREMOVE,
> presumably because only hot-remove takes zones out of a zonelist.
>
> However, build_zonerefs_node() rewrites the zonelists in place, so
> onlining the first block of a zone shifts the entries that follow it
> in every zonelist containing that zone.  This can cause a spurious
> allocation failure for a __GFP_THISNODE caller.
>
> For a node with only ZONE_NORMAL, onlining its first ZONE_MOVABLE block
> rewrites the node's ZONELIST_NOFALLBACK list as:
>
>   [NORMAL, NULL] -> [MOVABLE, NULL] -> [MOVABLE, NORMAL, NULL]
>
> A concurrent GFP_KERNEL | __GFP_THISNODE allocation can observe the
> intermediate list, skip ZONE_MOVABLE, and find no eligible zone. With
> CONFIG_MEMORY_HOTREMOVE=3Dn, check_retry_zonelist() returns 0 and the
> allocation fails even though the node has free ZONE_NORMAL memory.
>
> Gate the sequence checks on CONFIG_MEMORY_HOTPLUG, which covers every
> configuration that rebuilds zonelists after boot.
>
> Fixes: 3d36424b3b58 ("mm/page_alloc: fix race condition between build_all=
_zonelists and page allocation")
> Cc: stable@vger.kernel.org
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  mm/page_alloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Acked-by: Zi Yan <ziy@nvidia.com>


--=20
Best Regards,
Yan, Zi

