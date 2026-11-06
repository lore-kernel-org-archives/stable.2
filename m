Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=40.107.208.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793959834;
	b=c/QDCxyoiZOrcKc84ZELY2sPQJzn56Feg61EGZoVungnIaxBWc+m3+1/bmSnvJ3G9SaN
	 nVuqDsHPKUm4myOyv1mu8BdVRfXgEOhN4RstuV7B5Sb6ilKkQ9oCKlmEec/foWSy3KoNK
	 VNxV6e5XFNgUuSE/j51Lhu5eOh6jiyPJH+ru1qI1SKWnVS/VYUlFLt+6IvbjIRS7GtLIq
	 JhktCNhAmijDn+zZv/UYPIwjvKJFGUffARJdxUOx/82Gv7kRsQI6StjJTt23seH4HGG/1
	 HOWjABP29JRclo5RYyzwg6Moln/GFZrrcGKkuMDqXZAsJ3ltrcazbTXRHWG4CiKCnIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959834;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=aT+bTIoMNj/bdd+dgyVJBvz0wdyi5T29Lspl5yVu9nM=;
	b=B4cMvuscJ9yDuDu8Cq+WA5isyJIDEN11C4PyCSLrQrUPPco1KFyRRY2C47yZ0PoVS2pb
	 ObReFu2hfocXl3d7qnf24x1uSAsJhtrtWJwgu2Ghc2tpP90jSX0PM86odhIujayPVQogE
	 Jto3pTS1huMvIcN5g/VnZa+9WdFjxvquQy0/KN8H1S5Mk3G/ej0HIQnRDMg9rk75a0Yi6
	 2BVATMBRdh/O9SJlNbeNizLGcqMGsphcGQWXSZLQsU/tUqSskClAXR5K1GkZ1uiwiEg/f
	 2mlSzbtlmSpcnTbJJtLUxt6OG+EmsztOZg/qEe21BPbR46ACyrpPhRLKd1ZjQw+3r0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CqNEcy6M;
	arc=fail smtp.remote-ip=40.107.208.2
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C8A606A32C;
	Fri,  6 Nov 2026 10:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47C8A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CqNEcy6M
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDYtvztqHTYo+Z676o170jOmIwIMHqU5/Yj3KHRyTiv8t3eMGiQYK7icwDT0WV5NNM5dG3KLsimluF7jLHi+G8/FbdxBt0gVhmEc8+3HiUINXG8j031QIjVmqZX1JBmcXBujZ2sq6psJtrnpGb/Jl07SHu47hWHB4bKDbTp7r4Prkq5duSDjPQ56dHmsZNfl6O8nJtDGxXD4aVhZsrz2/gJxnKh8FnvZ4NiU6DHcpJbKF7BtIKD0mO9ZobV+L2NyZjAE4sIZH0AqOO+NYsnS3ze+uZM/J7Up3k5JIk89aPBSqFhULi4mQ0MKuziBo6TsqTOZVxhNFqxSscood2QHBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aT+bTIoMNj/bdd+dgyVJBvz0wdyi5T29Lspl5yVu9nM=;
 b=jcHysqYA/um0/PXiCOr/zLzJHpwdkMGM9WxB4rgXwF9DE0828mw6fXpvsuINP0vR4sJzTnoVVnHUtYVKIqFezenwP6uQgsNi4WOZMemLJWs73dnp7/F4koecmic7EeaLLuKXmVIyO5cZUungPgtN68b/o+P5eeuO2iltFQNmSu5EDUUQIG1ylZe9t60MYxPb0XlMQThOxfJEEWI1l7Oaec3Sd+kne+teFvrIU8nVkdbjYKBBc2HCzEmUw5S8QrtUB8hM1osfVJUDvzbvo4156BPU6dLL5ZOBChf84FYhyeIMm7Jk7+gmsA9MNU6BjlGm4PcO0lC8z3W4Vx/9AKtQXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aT+bTIoMNj/bdd+dgyVJBvz0wdyi5T29Lspl5yVu9nM=;
 b=CqNEcy6MdQ3PRZPyW03GhMUFy6K/vYLzOSi/kQwz0Yf4+H/lIanYpUve2TQaSFALAd0J2sKQkMejAnmCO2Iur+G2LwW8ZEfdzmLoIufwqeZ/J1hJUjQpSo5ZwO1z35N7vatCr+d8KOFi+lPP58kEpRSqv+BqJG7h2s0wNfVg24w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB9060.namprd12.prod.outlook.com (2603:10b6:8:c4::12) by
 DM4PR12MB7597.namprd12.prod.outlook.com (2603:10b6:8:10b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.11; Fri, 6 Nov 2026 10:10:31 +0000
Received: from DS0PR12MB9060.namprd12.prod.outlook.com
 ([fe80::e096:864d:d60a:c83f]) by DS0PR12MB9060.namprd12.prod.outlook.com
 ([fe80::e096:864d:d60a:c83f%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 10:10:31 +0000
Message-ID: <70a8369f-aec9-48c0-ae1e-5081d2a838d4@amd.com>
Date: Fri, 6 Nov 2026 15:40:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: adc: xilinx-ams: fix out-of-bounds accesses
 when parsing channels
To: Arnav Kapoor <kapoorarnav43@gmail.com>,
 Conall O'Griofa <conall.ogriofa@amd.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Salih Erim <salih.erim@amd.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, stable@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261104164510.105359-1-kapoorarnav43@gmail.com>
 <20261104164510.105359-3-kapoorarnav43@gmail.com>
Content-Language: en-US
From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
In-Reply-To: <20261104164510.105359-3-kapoorarnav43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0214.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::10) To DS0PR12MB9060.namprd12.prod.outlook.com
 (2603:10b6:8:c4::12)
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB9060:EE_|DM4PR12MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e430c3-56ff-44d3-f670-08df3bee3047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|18002099003|10067099003|4143699003|56012099006|11063799006|261026130827099003|261026135527099003|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261022113327099003|261021133027099003|261022115727099003|261022105027099003|261022075727099003|261021135927099003|261021123027099003|261021121427099003|261021130227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	AuZZTKFhPhgNu+UrKvLCEZiDkURL5Mz4d/d8audlQtHHN5wBXckqq4mGjklhotgH1snEYl06C1A37Tyx501Hd5AniV27QMvHlC1rYjqokuzW+QRkrQDU8XdbbhXfAYlxOqtW624HgF2U7S+Y1P17IordFkUUxEpDyhPi6LoR9oAtEjZTrtSWAxyiIisvanNjtyFJh4U6kJcfHQU9pT1GjvoHYhNFyC1yaGZGLqgXkUnEGmFtAqCDDJBdW0Lyo+0hEz7OWkaaL3lBRRSc7izw6Tsp2w9Y9F74fwJDXMc0r5jP9kwPdWYoz+1+PogDLu4SOYv9ZRSXPgycYeoRQnUD9TSrvIfS6OeW6ON6+KL6NMbhVvvFW+9r8GwBLQjywuP/4RDazk2bK4Pa2RiAfvvl9D9sepeBF104RQocIEt9PeWEB7sr/qZRdm+nBuiCv4FqNgK0DowQHQZ6rHPhns4u8qlyHD6oLSJGJ5hetUOlyZDqdrP6+KCkcUwUGpwskt4rbfXYh8AXSv6hH8eEtc8EX5yYBGzoTKucNd1TILPs/hyITtfpvqDG5VfMr+vPp4w5BxHX1ANVJPFUCMWGy0KPxk1qZXjB7GDZMNTB72AiZrUeDwFNSpwvbxv8oaFyiO3RnQJ6Yols1m4YQHZ5i1MRLJGfTjsNUvvqIESK0ALOtlk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB9060.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006)(261026130827099003)(261026135527099003)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261022113327099003)(261021133027099003)(261022115727099003)(261022105027099003)(261022075727099003)(261021135927099003)(261021123027099003)(261021121427099003)(261021130227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlJFUWl3MjJHSjNGVzlYUGY4cGUxcEo3ZGNJWEljQUxxa0FuQ1JYbEZLYVZK?=
 =?utf-8?B?b3JiRFNlZ204enR4S3A1RXV1MlpqaGh4Z0xQRVJ1VUFET240NTNjSHAxQkFH?=
 =?utf-8?B?cVJNbVJiLzAxK0pYaEpuZGY5RGNxUy9lbXN6Szh2TzVVUklXUGlnK2xXT2VY?=
 =?utf-8?B?b3BrSHNXMG5EcWNaT0ZCQW14N2pSSW0wSGxvd1A0MzQzRk5GeTltM1dTVnFN?=
 =?utf-8?B?YlE0WTUzMERQdEY1SXhBcndKRHc4MXJQMUdHbTBnMEpEVDF1U2tMYUNYS29V?=
 =?utf-8?B?eENzbVg4VTROT2ZSTmI1aFhkRGhkd3lWNytXcFFwVEFDU0o0NHRPSUdVWG1z?=
 =?utf-8?B?dHVYRHZYeTZWQXFNQlJodndraVMva1NRRzVneUZ4K0RFQmlCOUtOSnJ0L1Y2?=
 =?utf-8?B?MHlrZWNMdDQzS1VJTjJneEFTWklBaVpHaFUva1hQdXJkRnFVdC9MZVVXbnNF?=
 =?utf-8?B?YnJyVVdsWHF5MVd0RlVjL3d3U0pKNytGSnZPTjdGRkw3WU5VWHpFT3U2K3da?=
 =?utf-8?B?TGk2UGFHaW9aZXpkdlRmRGlHVkovQlQ5YlM2UXVUMno3Z2pVQXl5MkRYN3hW?=
 =?utf-8?B?bUdrN2xZSDZ0aUw4VHZIOGxBT2V2bkpmdVAxMmY0aGJZWGF0bmFDK05mUFdl?=
 =?utf-8?B?TXlqQjF6Q0ZsK0U3bitDMXFjQjU5cUVyYXNneVE3UmVtU0RFNUhEU0dCT3RI?=
 =?utf-8?B?RFM2UkNyNVlja2hnMW0xN2RuSmpER3BBa2k4TkFXVGRJbkxvbWxIL2tFRity?=
 =?utf-8?B?eG5ON0FFRmZoSUlWTlJkVkpObWRHSUtGalBqa1U0V0pkamlHZzVhNklaUHRI?=
 =?utf-8?B?MzVhSUtCNXErbHgwbTNnVjhuVW5hS3BJVWVRRHhQeHNOZFBoSytING9ncUwy?=
 =?utf-8?B?RDh6SU91U1FvdW9sVnIwUlFTaUdmSzhqSU5PTHo4OHNiUGgyU294OWRkWEh6?=
 =?utf-8?B?QTVobnA1VmxISEVra3JCY0Z3d2tRekUyQXg5RE9rdW1kdFpZMDhtMjJjb0dm?=
 =?utf-8?B?WVZNalltRWN0aHFtemg4dUhzWkMxY1dRUk1SWUQ3WGZJV3kycDUyN2tqWWZG?=
 =?utf-8?B?MnJwQ1UzM3FNbVYvaGd5WU5BRDZRU29hL2FDL0NrVVhyVTIxQVpmYUlGemlt?=
 =?utf-8?B?ZXpNLzRvTGowNGNkeFBJc2RsMTBEa21ocEt3eExhRzc3UE1rY0NzdTR3YjNz?=
 =?utf-8?B?K09qU25VMWMxd2FGckljUnhpOUE5a2p1UzZ2MnJuclBIWDNDNEpxNFV3U3Zk?=
 =?utf-8?B?bHZvelhWOEEzMmp6ZFgzMm5mSTRESkJDRG9FMlA4cnJMOXhIbmhabEVlVGFn?=
 =?utf-8?B?RW9XaU5WQ2wwa2hqNjlGSmlEY2JkeWpkaDJJcFNKNHUzMnJlYXF5NXdhMXMr?=
 =?utf-8?B?M0hQSVE5WHoyQnFUNnU0SlJPUnF0OHBTOHdyTWJvcERheUhjNVcxRWgvU2Jp?=
 =?utf-8?B?aSs5ekdNMmJGazZid2FQUXRxcmpiZ0FhTnhsamJubUk4MnQyWnJFNC9OUVdR?=
 =?utf-8?B?LzdnY0J2Vmk2UXBuc3ZqRk5Nd3U2ckFiWWU2V0c5eTZFQjZKeDFQdDlIekVM?=
 =?utf-8?B?TG5jNFJGOERha1NmWFJQUjlBbk9CRGdPQXc2R09XajlEZHdicHdTVkVidWN2?=
 =?utf-8?B?R2cyUjJKNjExUW8vOWRZcGlhYnBuMm9PVlRaSTM4dzNtZ1FLWVV6Tk0vS0Ur?=
 =?utf-8?B?N1hFYlBDZVZrZWZSaDhjRGVRSHVmSklmSWxkYkh6UEZKd05hbkRGamdmcmZ2?=
 =?utf-8?B?bjdlSmZTYU9iUVJVSnJyZ2FlczV2b1Y4emxCbndEL1FhZnd3Q3QwZjBvOXpF?=
 =?utf-8?B?NW8wbjhScEQ3RFdiUlR4cUtOR1lIV3UyMGxYRHY4aDJSbUVJdEFjYTBmUU8v?=
 =?utf-8?B?RFRFWXpYOVNWcmxoam5BNWNMdlpTcUdydWR2ZGtiYVJQemMzV2ZFSnRhUTJZ?=
 =?utf-8?B?Z3BDSWFuV2NhenVlVE5zeUZTRmdoNHBza2gwL2pmM3lJZGNQTTY1eS9hMVlW?=
 =?utf-8?B?VmxrUW1IVVJ3bm5YSXg3Y1A5aEE0d0htRHpXUWl5VEtGZzBud2ZNSll1ZDFu?=
 =?utf-8?B?Y3dMbWdzNWFrOWtwUmlnR3pNRzgvQXVNQ0lEUldPS3J4SEswNmVZQVBra2o2?=
 =?utf-8?B?QlJxTEtHVEczVUlkZWZudmJKMzBNbjlUcER1WkZZZDJ6MHZwWGhnQ2o0YXFR?=
 =?utf-8?B?Q01sOEN0R3RUUDkvSG1MdXUvd3QvVGR2UzlYQ1lFWmswV05tMXNnZE16RHFv?=
 =?utf-8?B?cml3VXcyZXpvS2dSSzRvL1V3QXh3dU9JRHhwSjJKb05HeEQ5MTViS3UvbkNI?=
 =?utf-8?B?UksyMFF4dm1OL1k3UmU0ZTNqMjFuK0xHc0VpNTdzMkFPbW1TSERiQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e430c3-56ff-44d3-f670-08df3bee3047
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB9060.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 10:10:31.0053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/NcT/1hFykDzTcQGzURPoz7WDfy4d2s4BNVXExOWJ/lJj6SAkPJqGbY4SnQ+8bWS8Pcd1VIvEZ1PhdmEDSzKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597



On 11/4/2026 10:15 PM, Arnav Kapoor wrote:
> ams_parse_firmware() allocates room for ARRAY_SIZE(ams_ps_channels) +
> ARRAY_SIZE(ams_pl_channels) + ARRAY_SIZE(ams_ctrl_channels) = 51
> channel specs and lets ams_init_module() fill them for the AMS node and
> each of its children, without telling it how much room is left.
> 
> For the PL-SYSMON node, ams_init_module() always adds the 10 fixed PL
> channels, numbered 20 to 29, and ams_get_ext_chan() then appends one
> channel per "channel@N" child as ams_pl_channels[N - 20]. Only channels
> 30 to 50 are external ones, but any N from 20 to 50 is accepted, so a
> child numbered 20 to 29 duplicates a fixed channel. A PL node can then
> have up to 41 channels while only 31 are budgeted for it, and together
> with the 13 PS and 7 AMS control channels this writes past the end of
> the buffer. Since the modules are filled in device tree order, the fixed
> channel blocks copied after the PL node can overflow as well.
> 
> ams_get_ext_chan() also only checks the upper bound of reg. ext_chan is
> unsigned, so a reg below 20 makes it wrap and ams_pl_channels[] is read
> far out of bounds.
> 
> Only accept the external channels 30 to 50. Also pass the remaining
> capacity down to ams_init_module() and ams_get_ext_chan() and fail with
> -ENOSPC when a module does not fit, so that a device tree repeating a
> reg value can't write past the buffer either.
> 
> Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>

Looks good to me.
Reviewed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>

Regards
Sai krishna

> ---
>   drivers/iio/adc/xilinx-ams.c | 57 +++++++++++++++++++++++++++++-------
>   1 file changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> index 158e6133abf5..745edcf7c735 100644
> --- a/drivers/iio/adc/xilinx-ams.c
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -144,7 +144,14 @@
>   #define AMS_PL_CSTS_ACCESS_MASK		BIT(1)
>   
>   #define AMS_PL_MAX_FIXED_CHANNEL	10
> -#define AMS_PL_MAX_EXT_CHANNEL		20
> +/*
> + * The PL channels are numbered from 20 in the binding. The first
> + * AMS_PL_MAX_FIXED_CHANNEL of them are always present, the external ones
> + * from AMS_PL_EXT_CHANNEL_MIN to AMS_PL_EXT_CHANNEL_MAX follow them in
> + * ams_pl_channels[].
> + */
> +#define AMS_PL_EXT_CHANNEL_MIN		30
> +#define AMS_PL_EXT_CHANNEL_MAX		50
>   
>   #define AMS_INIT_POLL_TIME_US		200
>   #define AMS_INIT_TIMEOUT_US		10000
> @@ -1131,6 +1138,9 @@ static const struct iio_chan_spec ams_pl_channels[] = {
>   	AMS_PL_AUX_CHAN_VOLTAGE(15),
>   };
>   
> +static_assert(ARRAY_SIZE(ams_pl_channels) ==
> +	      AMS_PL_MAX_FIXED_CHANNEL + AMS_PL_EXT_CHANNEL_MAX - AMS_PL_EXT_CHANNEL_MIN + 1);
> +
>   static const struct iio_chan_spec ams_ctrl_channels[] = {
>   	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCC_PSPLL, AMS_VCC_PSPLL0, "VCC_PSPLL"),
>   	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCC_PSBATT, AMS_VCC_PSPLL3, "VCC_PSBATT"),
> @@ -1142,20 +1152,31 @@ static const struct iio_chan_spec ams_ctrl_channels[] = {
>   };
>   
>   static int ams_get_ext_chan(struct fwnode_handle *chan_node,
> -			    struct iio_chan_spec *channels, int num_channels)
> +			    struct iio_chan_spec *channels, int num_channels,
> +			    unsigned int max_channels)
>   {
>   	struct iio_chan_spec *chan;
> -	struct fwnode_handle *child;
>   	unsigned int reg, ext_chan;
>   	int ret;
>   
> -	fwnode_for_each_child_node(chan_node, child) {
> +	fwnode_for_each_child_node_scoped(chan_node, child) {
>   		ret = fwnode_property_read_u32(child, "reg", &reg);
> -		if (ret || reg > AMS_PL_MAX_EXT_CHANNEL + 30)
> +		if (ret)
> +			continue;
> +
> +		/*
> +		 * The fixed channels have been added already, anything else
> +		 * outside of the external range is not a valid channel.
> +		 */
> +		if (reg < AMS_PL_EXT_CHANNEL_MIN ||
> +		    reg > AMS_PL_EXT_CHANNEL_MAX)
>   			continue;
>   
> +		if (num_channels >= max_channels)
> +			return -ENOSPC;
> +
>   		chan = &channels[num_channels];
> -		ext_chan = reg + AMS_PL_MAX_FIXED_CHANNEL - 30;
> +		ext_chan = reg - AMS_PL_EXT_CHANNEL_MIN + AMS_PL_MAX_FIXED_CHANNEL;
>   		memcpy(chan, &ams_pl_channels[ext_chan], sizeof(*channels));
>   
>   		if (fwnode_property_read_bool(child, "xlnx,bipolar"))
> @@ -1183,7 +1204,8 @@ static void ams_iounmap_pl(void *data)
>   
>   static int ams_init_module(struct iio_dev *indio_dev,
>   			   struct fwnode_handle *fwnode,
> -			   struct iio_chan_spec *channels)
> +			   struct iio_chan_spec *channels,
> +			   unsigned int max_channels)
>   {
>   	struct device *dev = indio_dev->dev.parent;
>   	struct ams *ams = iio_priv(indio_dev);
> @@ -1191,6 +1213,9 @@ static int ams_init_module(struct iio_dev *indio_dev,
>   	int ret;
>   
>   	if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams-ps")) {
> +		if (max_channels < ARRAY_SIZE(ams_ps_channels))
> +			return -ENOSPC;
> +
>   		ams->ps_base = fwnode_iomap(fwnode, 0);
>   		if (!ams->ps_base)
>   			return -ENXIO;
> @@ -1202,6 +1227,9 @@ static int ams_init_module(struct iio_dev *indio_dev,
>   		memcpy(channels, ams_ps_channels, sizeof(ams_ps_channels));
>   		num_channels = ARRAY_SIZE(ams_ps_channels);
>   	} else if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams-pl")) {
> +		if (max_channels < AMS_PL_MAX_FIXED_CHANNEL)
> +			return -ENOSPC;
> +
>   		ams->pl_base = fwnode_iomap(fwnode, 0);
>   		if (!ams->pl_base)
>   			return -ENXIO;
> @@ -1213,9 +1241,14 @@ static int ams_init_module(struct iio_dev *indio_dev,
>   		/* Copy only first 10 fix channels */
>   		memcpy(channels, ams_pl_channels, AMS_PL_MAX_FIXED_CHANNEL * sizeof(*channels));
>   		num_channels += AMS_PL_MAX_FIXED_CHANNEL;
> -		num_channels = ams_get_ext_chan(fwnode, channels,
> -						num_channels);
> +		ret = ams_get_ext_chan(fwnode, channels, num_channels, max_channels);
> +		if (ret < 0)
> +			return ret;
> +		num_channels = ret;
>   	} else if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams")) {
> +		if (max_channels < ARRAY_SIZE(ams_ctrl_channels))
> +			return -ENOSPC;
> +
>   		/* add AMS channels to iio device channels */
>   		memcpy(channels, ams_ctrl_channels, sizeof(ams_ctrl_channels));
>   		num_channels += ARRAY_SIZE(ams_ctrl_channels);
> @@ -1245,7 +1278,7 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
>   		return -ENOMEM;
>   
>   	if (fwnode_device_is_available(fwnode)) {
> -		ret = ams_init_module(indio_dev, fwnode, ams_channels);
> +		ret = ams_init_module(indio_dev, fwnode, ams_channels, ams_size);
>   		if (ret < 0)
>   			return ret;
>   
> @@ -1253,7 +1286,9 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
>   	}
>   
>   	device_for_each_child_node_scoped(dev, child) {
> -		ret = ams_init_module(indio_dev, child, ams_channels + num_channels);
> +		ret = ams_init_module(indio_dev, child,
> +				      ams_channels + num_channels,
> +				      ams_size - num_channels);
>   		if (ret < 0)
>   			return ret;
>   

