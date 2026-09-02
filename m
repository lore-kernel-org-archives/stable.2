Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012001.outbound.protection.outlook.com [40.107.200.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99623409620;
	Wed,  2 Sep 2026 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356077; cv=fail; b=Wd95XoFnvHLRHjFhjvu3iwwYg6xCuN2UwI8O6jedaelaxYP5DFxIppauVS/F+7uEnz94/MRrVSYit/A2luamOP72uvVVbo+yQWDtGGliYAvKVZp6lgfSNNBsHaIk068qt+m/Kag5ooHuw9GuJouLSL1i+OlF6fKq6FoPmLT/rZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356077; c=relaxed/simple;
	bh=K80U0W99W+yrVl0Lh15gdLWvV8p7t7NOfnk26rGurIs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tnj/xzKXHCmY/JBt8EdwMjxX1V9kSBaxaPxInxXnYGTxeGe2Hv4NLR7R1KIzL185qUTN3W4yMYpYtkOCO9x1dr+zWxvt5jSPXdYB82Haxm3AuKRrN9m1jQhoP+ySAhh7SnSUIt88sjuTCwtv3le73TCnTS9D6VjMMWvFyaV+wHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SkyyMM1v; arc=fail smtp.client-ip=40.107.200.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SkyyMM1v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ya/PS1SwExXU8A9HWdp5BW80RZ4AHgyyDF6O3Ls8ukcXUBgwOifYm94iI0Y5gsb+icAkBQhQBC43B4t27rmz/ywRorFmEDD+cfYRadP8+IOWvtvDRjROH8rs8bR/QvsaEXaq63hh+yHxzBHnkcl6k0VSqljFfcXIoabBi6QH/Wd+W8tciLBORqGqQZCeHTtJAEQXTlH/DTmJucrrIxaohqIlHGpJxKr3RWwn+NQiEQT9N236r7TmdstL1QTmO8EeIXZKaLN4bclo05X4RY4d5F+eS/ulPDyg3F/IgBE/JQpDovrKxut3vu7I7LPSEaRWD3AT+gCkGQx5xkeIvoygvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfJCBw0Qvw3HdzwXTgbj28ghteUL5B+j/R4+mIY7xsg=;
 b=B1CKKd0CDY7RLErtkYUR5lb9CHwAb4+lMUGLCaXtjkpw0ZAwJSVQ2gsm4czxl2/G+ChLJT/Io/HuYqCQgM3nXYQZAEJWeL/BUd3VdeXcsLd6sUdJ0xU7yWqBeiJuIaRlCu7Z19rfc/1DIxYe0EAwnvLw6X6nhYpatafX3bR8Jbq3upxXNp57cYoRHTuMMl+Nfg4sXkd1p4UBBBKTvzMlIQgV9TEXZ86mDMZKsIFJJ8PQLZki+k3LYFuZMEAoG/iyDicgIFmmQrkNZxQAl2SSGrUJrdV3gzmrmb9I1tpIK+XqhGmd4Xb8kkAgCti871lAN6MTsHP9DOmZzCqaopSG/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfJCBw0Qvw3HdzwXTgbj28ghteUL5B+j/R4+mIY7xsg=;
 b=SkyyMM1vhIZhFXGpbrlVFHnLskRQnS/B67uNuL7RqE5T5QbAQ06NIYYj5PVkN8pkmdsgERe+8BkyniyuuQnGyQKW5ldCf2wp9MgqBtB+vYBclHSkWTFXcLExIDeF4oO+k6l1VZGsJoyIwTIXqaHNkJIFXpNuGIjulYLAp3Pk89Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB8434.namprd12.prod.outlook.com (2603:10b6:806:2e6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:34:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 2 Sep 2026
 13:34:26 +0000
Message-ID: <7471c6e1-fbba-4430-a196-3f57a73505b7@amd.com>
Date: Wed, 2 Sep 2026 15:34:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] dma-buf: Fix silent overflow and alignment
To: Leon Romanovsky <leon@kernel.org>
Cc: David Hu <dhu@x6u.co>, sumit.semwal@linaro.org, alex@shazbot.org,
 ankita@nvidia.com, chriscli@google.com, david.laight.linux@gmail.com,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, jgg@ziepe.ca,
 jmoroni@google.com, kevin.tian@intel.com, kpberry@google.com,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, nicolinc@nvidia.com, praan@google.com,
 sashiko-bot@kernel.org, stable@vger.kernel.org, viursachi@google.com,
 xuehaohu@google.com
References: <20260901170849.4052816-1-dhu@x6u.co>
 <2bf581db-7cc5-4f38-a075-1b988c332f3c@amd.com>
 <20260902073936.GR24140@unreal>
 <aed39f83-6340-4fe9-890c-6d5f340c97d6@amd.com>
 <20260902083232.GT24140@unreal>
 <aae19599-2ba8-41fd-b3a9-b1f80107f563@amd.com>
 <20260902095338.GU24140@unreal>
 <65dc4ca1-6882-490d-baad-3e0abd708af3@amd.com>
 <20260902105919.GV24140@unreal>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260902105919.GV24140@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0414.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: b72f6a5f-06b1-470f-8288-08df08f6e881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|56012099006|10067099003|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GOO6VBHnI47U6sIL2Neh/6WXJ3IPblseNnsVkX/cqH0bIAxYiXYlcq9cKlo0+VfEj3wU0mzvdaCnvU52PV/5BD4xyd1vwthLYb1pfTL6hy/lrYI4/v4d3EsGlQrP+4KDNNj5WejUSAano2gfKM2c0XDyMA1ts9Ve2AqpUc1TD6rAMfNNCu2ar697h/uNdY62gWEvZ03p4Zo3VUwHGc4q0MFdu319wcLs+y8M+9Fzj3frugB1sES+HV91Nr5Knu6jtrWCnZVZQ6uoU+8HHtYiyBHW28Re0qyfLAh4qhk+Q4bFy5F8biZigwy0w0MMditsDjp3K+1EkJ7GDyHYYDz387IPcXTr9D2Zmu2aSxtSrsMfdIwEaArwfVwrpAhiawUWhJpLIXdfO1ug1VBp/U+Qrtt6PYwUyzYxaOX81eVSlDWCPJXxgMA0Quy8LzjWxeEWujy76imncjjPw5dWJ+98YBS7UC44joDV4BZkxvn7rbY4ZT+fw1oxbvm2ONwyFZtF9O5uL3i/SdYaO9ew551aLnedlgn1x/zooUHHhJuDcviFC7duX3sWGT0R45r42CQaf4fxVWo8AhlDBrbMxZLMBwTZ0sydI2n7ukB/QC3IiUQ87f+U2CM2m6O7QKMx3WSULB5gnYrvE7XQoSHi35Fz6EEfq0zNhWE4k3v3EuyxXsg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTEwTEs4S0xDY29KSVlYVUo0UDVzWlNpVVAxT1A2ZjEzODV6L2Nab245KzM2?=
 =?utf-8?B?MlBrUXpWc1AxVHpWaisveUYrY1l3YUNRbzVrNE1hVWdXNndiNzQzRTZubWNV?=
 =?utf-8?B?VmJKN1FGankzM2NSdldSK0I4Zmk3RzkyT2hwM1YxNHFRVzNFUzV6bUVnclRW?=
 =?utf-8?B?SDBpT1QwL2ZFODBtWGhlazdpSHNXVytnNENVcit2WlhjaVZYOFhHaGRaSlc4?=
 =?utf-8?B?YlZRazhzRHNqVjZXUDBWL2lMUHF5eFlaVkhaR3FuenhzczNpMjVaakw1ajM0?=
 =?utf-8?B?TURkY2hOT3VlV2xhMUhEaGJpS2NLOGFpWWlLcFBET0pQZEttRzB4d0o3RzNF?=
 =?utf-8?B?YlFIdmEwaHlRMHZsVmtoNXlIRnFscGZpNXNJTmVTUEdwcWkvRXZDNG1iMThs?=
 =?utf-8?B?akF1UlQzVDd4RjdXdDNseG85SHlKc3ZPZ1Ard3Z0VU5LbXNWT0srbEFzQ0FZ?=
 =?utf-8?B?ZUFSMzUxYWh3K1puNWJXN0ovaHRVSnd3Y3NiM05SNmpodlorenprWUlTSmZZ?=
 =?utf-8?B?QXF2QVJkVEVwMFc5YWMvaDM2cmd3U0ptaWw5M3lQTm1vVDdhL1JJL3ZTY1lQ?=
 =?utf-8?B?dzV2aXdDdFlrdk9Mb3VCYlo2K3p2UWtsNGFtM080bi9QV0M0cTh1MU9hYVBW?=
 =?utf-8?B?UTc1MzFsZ0h5OTNJZnJ2aEl5UmcrNnhyTGgzamNnVWdRSjNzMkkwbU8xSUpI?=
 =?utf-8?B?T2pyK3RtT1NDQ3hmYmp4Z2o1dWxVTWh3QjlZQU0zL0lTekdaVEhVTU8zdzBm?=
 =?utf-8?B?eUFYdTk2eW9uSzBWR2hOaHlGWnVkRkNlbUxiK2RBM0t0UzljRXFHSjExYTNm?=
 =?utf-8?B?YkNPc2FtSXVzTitqVmxJaE5URHBPWStJSW5XYjdHYjN6U2lCYTJDK1czSlZw?=
 =?utf-8?B?RmNVNHJoMGZaWTUrc2RHTEZlcjZMNXBxenBhMjFVQXY0cGphSmZsTDJBc0ZL?=
 =?utf-8?B?N2NmUFQrcjBPek9veGlmMDd5WGlMWVdnZXcwenh5UWVxYkxjRE1tZVhTSkgw?=
 =?utf-8?B?aUZlQ2FhSGZzMFIxU3M3a3dIdlhtR084Z2p1QURBdXhsZEdOZ0JCQkExdkcw?=
 =?utf-8?B?KzlBOVptbzFXajZ1K1g4WjRvWGVsbktyOVVETGNiMlFVTDVXRGJIK1Mwbjdj?=
 =?utf-8?B?MmNJeTlPSVNPRmVncHVWbmtTSVRNYUhNSTFSYlVGSTBaT1V0UU9rbkcrUG5H?=
 =?utf-8?B?bjNSZ0ZoTDlNYi8vaENYQWFvVmQ5QXIvaWhPM0tDUWNsTmpyTm1IZkpYYXFJ?=
 =?utf-8?B?U1BDTG4veEdaTDJTUTBybnJtdGo0SHd5M3R0SVgyZG40WVUrQVFNQ2pBNUdh?=
 =?utf-8?B?MFROSXlRdHpic2paYi80T1cvem9SL2RUTllERmpBcTBnWm9SMzRuTU8xRy9Q?=
 =?utf-8?B?dU9tcnhPNFRET1VabG8yTllIamF4dGErUzRxbEpJN1JCRktyanY3Zis2Tlkv?=
 =?utf-8?B?dWxrN2hycThoWHNvblpFRWcvb3FrR0lLMW83ZWZGeVhyZE02TzVaOVJQckc0?=
 =?utf-8?B?bE5HeXBFUm15ZFpqK2Q5SDlrZUdmRE9iSjNndWVlVXkzL01YcWZHNGdCK3M5?=
 =?utf-8?B?TVZBREV1dXYwTkN6NzAvTlpwQUhHbGRKVi85VzdWa2xXU25TeC9NZStETmRy?=
 =?utf-8?B?enphWWlIY0djSXR5Q2lpVGJQbjF3ZWVEVVAzcVhza2ZnRUdoS0xmMG9tZEtD?=
 =?utf-8?B?MmluV3hsRmVqNFFiZkNRVjNIR3BqdEVOd1ZGZkxRemp4U0k4L053OW51MENU?=
 =?utf-8?B?eFFOVHFIWHh3NERCVzB4R0tJaWtQc2NGM1YyNGovR2l3WFhnM3dtZ2JHR0FB?=
 =?utf-8?B?U2tOd2Z2aXhVZFdkbklOTTZoZ3hwamR2OS9DOE9xSTFEQnIzN1c3TEFMV2pH?=
 =?utf-8?B?YWRRbnBzK2hMS0hzUzJCRy81aTRtRVdKMUdjSXc1Um1JcHMrRWs0Z1F0SnpP?=
 =?utf-8?B?STY3OWdITVowSEJvcXVGT2RlT2tPNWZ2UUJOMk9xd0wyOWVNU0p3Z2MrRENL?=
 =?utf-8?B?Zzl1ekJyaWRNK29LanFzTUw4ZmI4OTZnc1QrRzhJQ0pFUVRNQW1aYjhPd0cx?=
 =?utf-8?B?eWtiZkt4RmVhN1FmdjlDNncralUyem94bVNEdmk3dGFkR2lOTDF0WENOWlNK?=
 =?utf-8?B?aHR4VG9KS2F2aTNrWUFndTVxSDBTbGlua1pER3MzR09nWENqVjVWVVU5WDNa?=
 =?utf-8?B?QWpYNXNpK0xBQTVydlNpRERVUDBsdnNsbk9xc216S3lWRzNNK0J4RDMzSnJN?=
 =?utf-8?B?MUttcEpET3FORXVsNENMYmtXbXNJaWlvVFRRbWpYVEo5em9Udnh0bmZadFl5?=
 =?utf-8?Q?nZ8daaMyaQblg907FW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72f6a5f-06b1-470f-8288-08df08f6e881
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:34:26.7558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHXdzdX1mPObGzH90BcRJ/kkojS6e1FmjKMaH0P/WB+1ib0XKRwqD2IuDALeP9bX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8434

On 9/2/26 12:59, Leon Romanovsky wrote:
...
>> The PCI_P2PDMA_MAP_BUS_ADDR is not supported by DMA-buf and as far as I can see is a complete dead end.
> 
> Maybe you mean DRM, but VFIO works perfectly with PCI_P2PDMA_MAP_BUS_ADDR flow in DMA-buf.
> What am I missing?

Well not quite.

The approach PCI_P2PDMA_MAP_BUS_ADDR takes is fundamentally tied to only map a physical CPU address into a PCI address and doesn't take into account that in a lot of configurations the CPU can't access all resources.

So when VFIO uses PCI_P2PDMA_MAP_BUS_ADDR it only works for a small subset of the use cases DMA-buf supports, but yeah as always in DMA-buf pretty much everything is optional.

Regards,
Christian.

> 
> Thanks

