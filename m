Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793362955;
	b=5MKINjUFquV5wHpmE7wn2biwpsu6PpfljZyPoRSW7s8+4Nvh9LcujEO6trBJePT5V4+I
	 BO0KcuPdhQdOu3IFXRIcObcs/oztt6z3wkhPxQ77dX4uNHgxd0Ert12bR/wIAiR9owYws
	 lv0djtOc3N/1mVyNVwxp1eU5r393tYR5/8cPojNpUfbWqwFuaO+4tq2VweUAb3jZaP8ap
	 0tSnYojDp/faCX5aSF6fTIxqI0Jwa6urno+lJ/EG7o97Y1tUtcQRduuuho9yBGHzZgRAx
	 6v6fTSsQBdD2jUohUrUTehWfBgb5X2PFyKjYETS92jgk54KYbZs1gZ4CR52GU5zRATA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362955;
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
	bh=pDcnT4djSt9pCqT6ZxvVUgmjfPqDa4igSgdjZ3ZiFkM=;
	b=lqq8WFTfQG+YoTw87SvNqcW1OyGPSub4rUl1gLp6YK/Wi68HWZhAfKS/hdAnyUtYi1ud
	 OAFAUmgWsL4y5eLEM8cYRoTn4izcCYNcTGPcInHafBMKIIaRL8HvBn/OLnsh+8AFUIzPo
	 NrgdWBxcgw5etdffafePKQTFqmZzfo79Zwb8E4MQ+13WdYdbNx7LUUL5im3UzwlrzWplc
	 yFkHVgVo54ZkiQ7GavprCf0PR9aZ8bXnVqwUotQgmTTDXbYPw8MbnC38bWD/Mx/mfJDV1
	 y3rTy2i6J6QhbWFKBG/BxVMhWv3MpH/af8oMXFAR2uLH3Fdg7ZG7nHa3+kQd9c1zeig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wCo1EOTT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.44
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4B2606A320;
	Fri, 30 Oct 2026 12:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA4B2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wCo1EOTT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sw4TsegQUaGknQUWR2S+HS7QGEmesLy9WuW57uM0rqB1wN8Iw4yNm959PUdf5q8fR15pOfEAtWe4G/YaHtg2hPQtNfQ5tfOBCKFy+FSQe51EeomRaF/KTiw1T7jfm26FHWKIz0xa+XMFCqjDk8b4WO8khaX9c12BZRGPTDQGG/43m1xeKlsic+P/lruLWctDwvvcMk/lIkCf4laklh5mm69ybHZM4dZtJAqmmAF08xLdjYhNLgKYAu7kfrnJvy3gvKyfxMnJOV8J58uv+k8GMPUdf4NhwqM27HGaA4vgPIu6zwa9KqLgWt+dps6Aw5MuTSjjEmtxxlWgX0ooCSg0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDcnT4djSt9pCqT6ZxvVUgmjfPqDa4igSgdjZ3ZiFkM=;
 b=x9Lhg8aoGKoVZpn6iCBeqNFCpZNAzcXlyPkFUt1+d9T4ZoohCqWCKDoaCf7lFCBwox2p7yF7FAloCy7wCoLaF//INqVKanWoXsjC2TTvsPkD+A/ffMzz0/1vqT6QDFyziSFVWos72i2LOmjR05vzi7QY9sfLiBfdqvaRyCyg3jfvMKeU0RZC/QyqEPBn5Z+KYrTmrCrvw6gLaP7dFiBnd4SbIu0xtrUUbwGBw3thUT+lv+Umo6fBdFWSJtHGsVY9VOAUhuQ5xTzoQTSRkOirwGBiLotCIHmSJnJUwsxu1Y5FpToYVqY0BgoNu3LwNOasDoWIMeS3p+aEevaEFEYjiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDcnT4djSt9pCqT6ZxvVUgmjfPqDa4igSgdjZ3ZiFkM=;
 b=wCo1EOTTpnbkexkh7KOytIuzabB5aKlpSC+xgkB9sQL9zqDZGuCIeCv4nkSXuGF5OGO7UUEpbyXw3qWKOSY9RYdomtjLYSP7xASxBS8ILUYiGzDY6OIqnsT6wYTmzlp5d+GbsNh+jsPt9xI60CRn0oYOnKOnucvR2hmKcICgCFs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 12:22:30 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 12:22:30 +0000
Message-ID: <a7981925-d19a-40db-811a-b91bb44a87d0@amd.com>
Date: Fri, 30 Oct 2026 17:51:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/21] soundwire: amd: Resume manager before hardware
 teardown in amd_sdw_manager_remove()
To: Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mastan Katragadda <Mastan.Katragadda@amd.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Prasad, Prasad"
 <venkataprasad.potturu@amd.com>, Syed Saba Kareem <syed.sabakareem@amd.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>,
 "N, Poojitha" <Poojitha.N@amd.com>
Cc: stable@vger.kernel.org
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-18-lee@kernel.org>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20261030104840.3361217-18-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::13) To CY5PR12MB6252.namprd12.prod.outlook.com
 (2603:10b6:930:20::17)
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
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc629e2-ccdb-44b2-91d4-08df3680776e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|921020|10067099003|11063799006|4143699003|56012099006|261021121427099003|261022105027099003|261022075727099003|261026121527099003|261026140227099003|261028144727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	CJY3fJ6D02wL3D0KvG8eEdfj8ilfwYo2shlQyj+QwdMHzYDNEAFJo69MUAk32dbsyJyYvoR73wzN+I2eZ1hSb1XDwlsLM2UMUTNIPceCvnJINbdH69viwTEe3noR0TG37MLuy+s2seeHQcg5iChzSsQGW8Psaeo5WAW/jqJ19u+wtvwJjp9eurhmA9fLiRJwqV8co0o67GY/z6bVlMSJe9EW+jSkCsIP0+mae4VFTXxU1W24pJZXIAvBys95fVbcnkqHxTyIzEGVfiKZQz4IVeIGie2Rh0O2aXkALZlQ6xz/RI5JLCRJ2yxGlw3fRwC4W58/00hJLscaNwzaLBCZ49GulFfvCXNa0Q1s023S/5gtwMhHfnyh8QmLcFvluVSLCW8CMmTNdIK9hCHAT1f93aPfzEXCN3QqPAbQ/+aUgkkL19Bam9wI7EdFlUDVHoc9WL46bDyeuvZR/WmiD8S+4wzH6SHav3XSI6tcpsur24Dn7SfS9BKIG2C7N4CO/3i7Wvor/7UF5KtfOlSPV20txMGdAugEzfowov8lxOuYl5Wg58NSj6QOOYHIuGGjnKYghLs26wUt0c3OZy1bA9XtTfGNY+y7a+X64Htbwq9qJWyaCdkhwmgviQheOJIYoCFTscUOYamcSF4w8UApRpv/Kg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(921020)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261028144727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REZzMjBBQm1ldFJoY2hIMXVNOERIY2VEanFPdi9ncTZGSGZaWnpBdEZpczJw?=
 =?utf-8?B?cmFXb1ZFd2VFbEV3Z3VIVE96Q3o5QnZtazNrb0g1RWY4eEk2WDFsQzl1LzRj?=
 =?utf-8?B?WDlyU1RSVnFoRXBUaFNScmYrdEtOY1lzZW96SlEzRWZ2SkV1ajByN1dYZFNx?=
 =?utf-8?B?dWlLRGpKdTlaWDhCaXBJY28xNjRiVjVucUU4dGIzUXQrVnVpV0dacWxmSEMy?=
 =?utf-8?B?QUZxeUlKTHVJRWZwUzhWVi92QXl3RFhFTndxMVdRTENHOE5ndUQ3TUw1NmxK?=
 =?utf-8?B?SUJsMXhTNFpqNUorY0o2SEh5ckwvQXROZElXTThMTHBvT3FadTA4citRamtJ?=
 =?utf-8?B?M3Z6MjllWmYvd0lJNUhCMEUzT2NLL1pHcXExbFFQYkNoTW1ESCs3ZU9qbHFS?=
 =?utf-8?B?N2wrQXNSSTVEVURIcEQzZGNRWTRLZGdJS3FBQ0t5SkhONmFzNFIrQ2tTeFRB?=
 =?utf-8?B?cFFWUHNibTFQbGJkUkxFOGljQ1EvQm1mcEJsUWNLM3RkeVZFN1p2NmJhWXpm?=
 =?utf-8?B?NXE4cnJSRlFtNVVESmVGa1FvdHlUMVA4SkgyV21Qem1ySFlMTktwN2JqVEU0?=
 =?utf-8?B?a1hHbTAzVzZzMm1nbWluMS8yNDJVZEFqejJTdjZML2RidERWeTBVOFZFaVVq?=
 =?utf-8?B?NWNTaXdZeGFqbVpzZ3Z2REQxNVBRMnpjNGxSczZEM1ZBSWE2Q2ZzeXJIMkll?=
 =?utf-8?B?RXI4bWlKb0UxRm1ya3RDYjgvK01IREt1R2Z5QkVubEIzZlRTVHZyMEpqNHFK?=
 =?utf-8?B?SEN4NnlWYlpYZG5EQ2pMc0hYbkZKbXlnR2cyTDJCMWcyWVZmVk5mWkhaVXpZ?=
 =?utf-8?B?dm1pVkRsVXFjaGJzZ0FEQVJwZWpVNXJKMTVQOU5BSW5DbFA4Y1NlTkphUGZB?=
 =?utf-8?B?VW9RUG5NQW1NMENqRGZzc2FZbWNVSkhydWZNK0VncEh5cFFnTTl1bDJ4TlFL?=
 =?utf-8?B?TS9FNExWWFVJSXNHOS9mS29laWFaNmg5UjRWNDdtdTZxcTRteW5VK1R3NWhx?=
 =?utf-8?B?ek5qZi81dFRWS0VvSDlJaWh2WjJvUHp4N0lER2FtOW94Y21Mejg4MjNvWUZN?=
 =?utf-8?B?SjYxRWtxMlA3ejNsUVBEMW1mbGlSSStVZ1lTVE9PMldhazJTcUhvaVJGQVBP?=
 =?utf-8?B?ZmF2SDlOSzl2SG90M0RVM3U5ZnFWTzhoeWpzZXlVRlk5cFBFR2JqYVRtdHdQ?=
 =?utf-8?B?ZllXUEtXZHh5bDUzbjBRQ2VTL1VzSDB6bnY4eHlHNGJnTytpc2RpNmgyMDF6?=
 =?utf-8?B?VkQrNlVNeGM1UE4rV3dGeEV4SXcyODhTY3VyeFhOL1FZZUpvdzFVMlZpMVpR?=
 =?utf-8?B?WW56YWVyS3JRaWQ4M2dxTXQzazRaaXpiTXJTMWVjMkl1Rzk2bk1FNnlBbmtx?=
 =?utf-8?B?aCtHNlZiRFlCVnRGYm53OVN0OUpQWlVWSElZOFhJTFp0dTQ4d2tyQkVGS2Q2?=
 =?utf-8?B?OS9yL3d6UUk1SDMySHJGZ0JjME9FNWxkN2M1R3kzcnEzMFRnNnU5UFd5dFlu?=
 =?utf-8?B?eVF0elhObTYvN0drVExVQTkyZlgzRkpqb0lGbENlbzNDQTFIYzloZ2MyNlkv?=
 =?utf-8?B?L3FZZ0pycEQvSnR6RFc0dFNVdk14VnU2L3RGRFRjbW5lcEMxR3FlRUFOaWUz?=
 =?utf-8?B?ZCsyaVo3YXB2dUg5WHY3S0tqMkRUZTNXcWU1bERPYUFQWFVsOXRHenBGaFJa?=
 =?utf-8?B?THdJTjZubXkvSGVPa3BkZXgvN2ErN1pSdVpSR1pvSHoyZVErNjM3VW5tMkNJ?=
 =?utf-8?B?VTBIZzFWWVRlb2JpWE5rZG5XZDYrZ3NQcjkzWDBLWUdHS1BIOG00ZWR2aXpM?=
 =?utf-8?B?SDA1TXRCUjZYblV0UWRGR2NyZEJJbzI0cllTbXFWbGlqc1F2UUdUVCtwWVJ6?=
 =?utf-8?B?TTNtNGVDY3lFSzNqRmpIRElCVTNocjBqNlRJc3pnczhVY3JtNVpRWm15QnRF?=
 =?utf-8?B?dnJnUE9iQjY0L3piRmNwNUhiMDR5eGlOeFA0U2Z1UWdFbm9ZOTltZzdGTGY4?=
 =?utf-8?B?VmpRV0ZqUzkxQ1R3Q0dpaEN2ZWZZUmEvRXQraVJPdVNNTTR5THB1R1o4Zm1C?=
 =?utf-8?B?eFpaa1FuWkN6TzV4Q0N1aWR1bWx0NEVKZHRYQk9XMGJJa3hHZnZ0N0tlS2Nx?=
 =?utf-8?B?Q1hXVDRtWEFXZGxLbVBWU2sybjVMbS9FMnlua3UyaU1XL21FTTAweStWQlhN?=
 =?utf-8?B?WkFUOXI1WVBjK1FGekRLTmR1Vm4wZzQwYkVOM05ZNFZndHh0UkZXdlhzOUtk?=
 =?utf-8?B?bWdtb0ZMa0ZSWFl1QmlFLzNuVkxqN2t2WUprbnRYNlRRY25mUlN4OE5NaTl5?=
 =?utf-8?B?RTV4V2x1Unk0ZFJmaUJGaTh5ZWFpb3U2SWRDczFIUjVSbXh2K25oUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc629e2-ccdb-44b2-91d4-08df3680776e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:22:30.0645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUobbBL7AIj1Vdt62S+sCFoqt3dooCSRyLyDPVZ3BT5IKZ9/XIGFjF/Rc6FGKYX0uhwzbtkwpxtjmqgLS/wfrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982



On 10/30/26 16:16, Lee Jones wrote:
> [You don't often get email from lee@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> amd_sdw_manager_remove() calls pm_runtime_disable() and immediately
> accesses MMIO registers in amd_disable_sdw_interrupts() and
> amd_disable_sdw_manager() without waking the device if it is
> runtime-suspended.
>
> Call pm_runtime_get_sync() before disabling runtime PM and balance the
> usage count with pm_runtime_put_noidle() so the controller is awake
> during teardown.
>
> Fixes: 81ff58ff71ad ("soundwire: amd: add runtime pm ops for AMD SoundWire manager driver")
> Closes: https://sashiko.dev/#/bug/linux-dad4d803-06a7-473d-829d-66860776f4d6
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>   drivers/soundwire/amd_manager.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> index 2e1038ea0f36..1d8a08bda261 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> @@ -1196,7 +1196,9 @@ static void amd_sdw_manager_remove(struct platform_device *pdev)
>          struct amd_sdw_manager *amd_manager = dev_get_drvdata(&pdev->dev);
>          int ret;
>
> +       pm_runtime_get_sync(&pdev->dev);
>          pm_runtime_disable(&pdev->dev);
> +       pm_runtime_put_noidle(&pdev->dev);
The SoundWire manager is a child platform device of the ACP PCI
device and does not have a dedicated BAR. Its MMIO is mapped through
the parent ACP PCI device's address space, which remains valid and
accessible for the lifetime of the parent device.

Runtime-suspending the SoundWire manager child device does not unmap
or gate that MMIO region. As long as the parent ACP PCI device is
alive — which it is during child device teardown — MMIO access is
always safe, regardless of the child's runtime PM state.

The described scenario cannot occur on this hardware. Please drop
this patch.
>          cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
>          cancel_work_sync(&amd_manager->amd_sdw_work);
>          amd_disable_sdw_interrupts(amd_manager);
> --
> 2.56.0.317.g454f8302e1-goog

