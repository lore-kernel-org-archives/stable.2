Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792743985;
	b=NBFvhu8FLRzCxI3xvw5vQ0A5pHeWcl0YTOmxSeypgubkUdmtIqpm9JIjAairtksNLqpx
	 xmt4oTeJ3GkKnmu+OckMPsRG73hAK5088/G+QXTdLAHOcL7Cckej2vQTHTjmcKrHpLEb2
	 /0ZcraOiv2vCN1QucIvqpDLNRbr9PaIf5bfcZVpVcGOVr3hCrcqtnNceXXg11iKoVWuGj
	 i2a2mN94Lt+UYLi2TTi7NAXwriFiH4Zo3HQ/BXZKUFdPOkzXF7OaEIywlorUsjD1/AcSO
	 38bba0hK1Q2GF35RE2QIMgRvpeXuWePtwgQl3ideLoU5MWWipwcXIAyCNJSj/SACnCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743985;
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
	bh=S1YD5EpGDqTiFVo7VMB1hOrB6yRp5Gv5331ZY5cvGnQ=;
	b=xj6KqWhrT5JneMAt/HbjdHJw+iNavn125yNHwuXTZz2Hz4pHUBYAeaV11oIsHdKivloi
	 fkxA4Q7WKr/34wDWHyFw4FUWdxKssm8Lfi+pCajMLcCKtBRXhoS6Rj/CWn7jFbr9d2Zf7
	 I956w8ZxLJC0RkVcbMVZxA8kXBCtN6Iv+9VYDYM0ja/yrkEuXb4bhDdzLq4fyKHMVxD7E
	 iflqmRGa9zqqC62mqOWwU1i4Jh3JRQfpmxMeW9ww8V75EQQUj6N/wTLcrhXCptSRNjj7o
	 Bl+oZL43oG956B0xAplvv5BKSIkJi0Uxi930exBGkxA+OxAcJGByn8hrqF7InnNECfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="we+XQ/zh";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.68
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AAF606A31A;
	Fri, 23 Oct 2026 08:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94AAF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=we+XQ/zh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6Hnlr8PVXay7tzOpRqePA6z8SFT30vVcthojYycT6f8/O+mngSXuaWu5wdLbRXHH624jWkt2ciltKn5EueeOB1VPp0b5koW58705rk0nStoTS1u4rtk/ysOTB4Bls9zNfp5HL9W5twY96VYpmDKBUoBZ3iH0oBntj+EBgLydUXI8wNioHRCEQjraF2O5rgQtrlCRO4Bv0CVuEL2IOm7a0q89nuO6qiB+MHt4sjdZdtS75LEP6C/rk0rSVBGd2r8VxkyfVZzTFNSYI6H5dZTyFdGwbZ64atzHwEaSxtcNigARg72s6uD2PQ0GLegf7/zXRPqBBfZIV0qLXJCwRRlpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1YD5EpGDqTiFVo7VMB1hOrB6yRp5Gv5331ZY5cvGnQ=;
 b=ghG3d2p+FNTHaxQ4Uq+vD0tRPJ9Fy9R9D852PsQrZ3e97Mlcv8634csk9ctQmOXcZa5Z6PlX+bs+/PNnGGaeyHn8Ag/dUaXRMiKIN9jl/QHYNUvwf4uTGZ93iX3LxzP7Z5GYa278nUN4IplRnBjeq+2vLug+XIURspJPc91XEvM/Q25zyiNcF8C5OFr39CialkGYtZc36qwuuVC946GjshX+d8zVDYiiSDIk2cXndf3RQZr289aW3WzMfVdzYJDuKGN5MEL/qmPYMImu0k1SY8bzwCaMKsEnyOFtqXS/fP036wQgv6itoHfR8omFRVYHYiOJ7OwZFhH2nQeoJP/2zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1YD5EpGDqTiFVo7VMB1hOrB6yRp5Gv5331ZY5cvGnQ=;
 b=we+XQ/zhszuXVAju/uhLLlzzFr1/IkkcGg4R0KqYXqtQT3IYlPvr0wbQaEbWHRTMDX4IkyCKMOiHeCGr6kF4oSKpACd5ZvJZ+20FoFmz1JH3+2Ud61c3pNae9EEp5gQO/Qificke1Mty7wlHk4tXA2Qq/mTPzX/vDJdNxxLX13k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 08:26:21 +0000
Received: from CY5PR12MB6550.namprd12.prod.outlook.com
 ([fe80::b0a5:664e:bd0f:3f14]) by CY5PR12MB6550.namprd12.prod.outlook.com
 ([fe80::b0a5:664e:bd0f:3f14%5]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 08:26:21 +0000
Message-ID: <7e2046b4-be10-4d7d-a7fb-ce56add7ea60@amd.com>
Date: Fri, 23 Oct 2026 13:56:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] HID: amd_sfh: Use shared interrupts
To: Ho Jie Feng <hjf3108@gmail.com>, basavaraj.natikar@amd.com
Cc: stable@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261023081803.21761-1-hjf3108@gmail.com>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20261023081803.21761-1-hjf3108@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0041.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::15) To CY5PR12MB6550.namprd12.prod.outlook.com
 (2603:10b6:930:42::6)
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
X-MS-TrafficTypeDiagnostic: CY5PR12MB6550:EE_|LV5PR12MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1cd38a-409d-4e78-f829-08df30df5150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|18002099003|22082099003|261022105027099003|11063799006|261009223027099003|261021123027099003|10067099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	xPaCvgeKf/UnDmNeBQx5kNSiKqGHYZQrEXUkEn7iBdUKqXV6oZjbsBDAHWE6nDEqEYpEtF3T/IUh0OOXxyl3X4ab7vYH2/YN8v2tv+/X4ykPnIXUp+PZmTI3nljM3rWjLWDtvCYBUMR88G5QumEjB0F5NEm4abAsIYOJjJLJdC4EDHmWFn0k6bnyNvqPr4HrWe0PNRd43nNkCn0vUxo17cH4oDEIYUCJaohtkJ1N3cVETRT0HzCdcC07UyYTI4cKEp5UujpiqFlDgbYqPf/HL3bemF+4SH8EID85q2hq5zv5SoRUj4eHQATqkH3Y+2PxBR1iD5w58NxXMe4TbBHaI9XbZAXwJemvxTabG6HNdhWhkkfdYeuqs0segJg1KDZwI04WQTHowToc5HlSMQ6IApLBDKLEOuCR8NUPJzndIAgWGQwSmr+fVumNaubYueDsYrLl6k5Q1cyU2LemITL0wI9exv5cWWWSXh9xVCPphJIGkTrqk+lwtlJvY4QawayCviiz1PXkOeAJPEpN8hxgthYFQyplnosTc6/YmIxwcwP41r03Dx8/3WbZl797OWpAmm1MntdtfqTgdzHUK0CjuIDGUT37qJnsZUox5+RwHsgsZNXLES8NTIs4uBsOb7pTZLfFZBD9XTk8O5KGTATlWPYIhGiWx6eqFLhq7kohM6c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6550.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(261022105027099003)(11063799006)(261009223027099003)(261021123027099003)(10067099003)(261021121427099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEU4T2JKVzZ2MjhoTlA5eVdBbU9mZFpqZFUyMkxnQ1pxMnpuR0xiYThkNWt5?=
 =?utf-8?B?RU5UZmNTYzhacjhtTXFUZGs0TGJOQlExMmdDaG1zajRYMm9QM0Z3dDR2TlNJ?=
 =?utf-8?B?SDV2MzB3ajZHSHpoVnFNZHJBR28vVlQ3elhYNzBxT3FzbmIrM2FBUE1wSU9T?=
 =?utf-8?B?WnhmdWNTNVIzYllkWVh5a1BpLzF6SEI0L1JaQ2JETWo5WnAwYzNWQmYzVkF3?=
 =?utf-8?B?RHRwcVpoRUV2MXBEaGJVTXFtTEs2UjZDcko4RW5sMnpvRkZzeVlteWtwRnU5?=
 =?utf-8?B?eS8zVkFWWVBMenI3R2tWWW9UMmFSVVEzRFJxQTFwK2JJTXpMbjA2VlFhMEdC?=
 =?utf-8?B?OEl6UkwrelJCSXF0N1l6blA3VGsrVW42VStKY3JUa0g0UDZjWVVMUjFLRStV?=
 =?utf-8?B?anNkcnBmVi9QV01YV204L3FaVFExelp3V25JaWhRbUdUSkpzdVRaNExXTVdN?=
 =?utf-8?B?bVlxbE00a0Q5TTdaaWI0TmY0Q0cyNmpTT0hvVTZpSCtnUkw3UXMvZkVYbE91?=
 =?utf-8?B?RWQ3RnlPYmVuSU10UjFmSDI2M0FUUnZrbU1sbWJ5RUFGekk2MjRSQXVpT3JY?=
 =?utf-8?B?L3A0eUxxanRneFJjU3dmaDQ0OTZIZGdPUERxTldIcExocDBNYktEQ1FnMXNn?=
 =?utf-8?B?cm5VYlZjR25MOUdNeGxvN0RFY1VrRS9PMGNDNG9Xcjc3aHFsc216dTBjbnRo?=
 =?utf-8?B?a2RSdWhNSTBUbnBFSDAwODhiWnNYUUl2TlFyYWNsMDR0R2JKaWpuV0J4LzJF?=
 =?utf-8?B?bzZPL2VuT2NKYVU5ZnpQbjVuMWZCK2lsTXVsbHF3U3BCVm1KSkphUXFsQTdk?=
 =?utf-8?B?ZVpRVVdMR3ZvRWpuUTJLR0N1VTJueVVjL0dSYUYzeUxpQ2FRb1lEU1M2R1Z1?=
 =?utf-8?B?YURuMWhaR3dLTXpONUF6K1Y3YVYvUGRveWtYK3JzczJrY1JsNnh4UnNhak9T?=
 =?utf-8?B?RzdWQlRoZHhWY1psOTZPR1BkZGYzbUUrZW9OMjMwU1N6WGJHdWt3ZkFNTTNy?=
 =?utf-8?B?T09hVWhNcGRJVk9UamlPSC8rWE5Bd29CS05EcVRNanZ1Qk96cXpkajZrVVMw?=
 =?utf-8?B?WWFGU0JVTlBzWW9OMkg2OFVpMDMwV3pQZzdCbmMzNGsvQjBCL0FheDllc2Jz?=
 =?utf-8?B?Y3Q2ZU52cVRPRzBMUGtUUS8rTG14cHd1b3JrZ1RJZThkZ2Fpb01VdkhUN3Vs?=
 =?utf-8?B?VUJwQThtaTdONFRQby9yaHNYdzVsL1FYMnN4NWRMck9zamV3aE9wTDdHbXE0?=
 =?utf-8?B?MmZMOXN4elJlWFFEbFFTanpLN0plNkVVZTErcnhXYThOamxOUzRHNGY1MU93?=
 =?utf-8?B?MlBzaURRNjBBMnRGczIzWXI2eHNmSDFQSmlSYlVyM2lZTFlsWUEyKzdoUWg3?=
 =?utf-8?B?R01aM0tYSlRPbzFjRmNzQUoxbGw1RUJqcGVVVEVaRDVZVUhBMHhjRVdXakpU?=
 =?utf-8?B?YXlrcmN4S2RvVXhnaTh0bTZIQ2tZdEcydW1oT3ZGWTJWSkxSemNFV3FrNVNi?=
 =?utf-8?B?bnJTTVN2bzRzWTVMclZjOFBnMGVHWFJnRVU2Ynh3cnhzeVJLb0FzTGJYQ3M0?=
 =?utf-8?B?M0Iya3pmc1Rqc3d4K1VaVU5TbUF3aW5WeXQ1ZUdnamRNcXMybzF4VUYxNExB?=
 =?utf-8?B?MVVweWVjeHVyNHRMMDQ5M3RaUForVE1mSzNleE9sNnR1T0N0YmdPa2RYTEdD?=
 =?utf-8?B?RU9LaWVYalBDUVY2aHBYaW9LMzROcW1xL3l1M0tza1hsbUVReWQ1Q0prZ0ZH?=
 =?utf-8?B?R1YzRXRNelhJV0FEVW5UQjR0Qnk1dEIyVDFLN0IrWTNqWkJ2MmdYeHM5b0VM?=
 =?utf-8?B?TlZGY1hONmw5aDYzejNlRXRmcmhudGRSNSt5WG9ESG1VVE9lVFJ4WlRpM1BL?=
 =?utf-8?B?dnhxS01IR0JVbEl0ZXVRNS9ZQ210alNvV2lhSFRHYTBHN3hUUkxYckh6SllI?=
 =?utf-8?B?OUlCZWtxblBQOUxrblJqdlMrUXI1RWx1aDhyVGt1Z29nNVNuVU5qU3YreHFu?=
 =?utf-8?B?a05TUkYzTzRwVUd5alB3cFRpMnR2OTdBOXdRT3ViYmE1N2lBekJFWVQ3a2k2?=
 =?utf-8?B?eXlFQlh5VXoxR2tHb1pWS3FleU4wb1BoeXJZU2grRTVLd3dhVkZDSkN0VzVE?=
 =?utf-8?B?bWRwNjRKeFlwYVV0TGxibGk0Vmp5K095OVhCVzBWQTUxS3VzWTFuTDB1bkJ0?=
 =?utf-8?B?Z3l2YnhtRHVROFhUZmRGZVlSenQ4M0FDYVNhNEtuRVRnSzlnbWNVSEk4TzB4?=
 =?utf-8?B?SFdqRUZBY0t3WExnWUp4SFBUSFNpMXQxVG12bXhwbVNNQVQ0NWpMMFZQTzdt?=
 =?utf-8?B?ZjFMdmR6cUdOS3l2ODBVNjBCMm1BSTVpMFdpZmRTclAxclFkYmcvdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1cd38a-409d-4e78-f829-08df30df5150
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6550.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 08:26:21.3675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/E3Nu3N8iYlm1EXvFUmHMatXjpsD6PiTrAmDtfOULL5Ng73VkrAaP7K3VOl183yJMn1kbIZhSrEuAn7Ej24pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825


On 10/23/2026 1:48 PM, Ho Jie Feng wrote:
> [You don't often get email from hjf3108@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> The AMD SFH driver requests interrupts without IRQF_SHARED.
> This can cause VFIO PCI passthrough initialization to fail
> when a passed-through device shares the interrupt with AMD MP2.
>
> Request the interrupt with IRQF_SHARED. Check for a pending MP2
> interrupt before clearing and acknowledging it, and return IRQ_NONE
> when no MP2 interrupt is pending so the interrupt can be shared with
> other devices.
>
> On an AMD Ryzen 7 7735HS host running 7.0.0-38-generic kernel
> from Ubuntu, trying to pass through an xHCI controller
> (1022:161d, 0000:e6:00.3) fails with this message:
>
>    genirq: Flags mismatch irq 45.
>    00200080 (vfio-intx(0000:e6:00.3)) vs. 00200000 (pcie_mp2_amd)
>
> QEMU reports:
>
>    vfio 0000:e6:00.3: Failed to set up TRIGGER eventfd signaling for
>    interrupt INTX-0: VFIO_DEVICE_SET_IRQS failure: Device or resource busy
>
> With this change, the passthrough is successful through VFIO
> on the same host.
>
> Fixes: 7f016b35ca76 ("HID: amd_sfh: Add interrupt handler to process interrupts")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
> ---
>   drivers/hid/amd-sfh-hid/amd_sfh_common.h |  6 +++---
>   drivers/hid/amd-sfh-hid/amd_sfh_pcie.c   | 18 ++++++++++++------
>   2 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_common.h b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
> index e8cc7f1d289cc..4481a50359de6 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_common.h
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
> @@ -85,7 +85,7 @@ struct amd_mp2_ops {
>          void (*stop)(struct amd_mp2_dev *privdata, u16 sensor_idx);
>          void (*stop_all)(struct amd_mp2_dev *privdata);
>          int (*response)(struct amd_mp2_dev *mp2, u8 sid, u32 sensor_sts);
> -       void (*clear_intr)(struct amd_mp2_dev *privdata);
> +       bool (*clear_intr)(struct amd_mp2_dev *privdata);
>          int (*init_intr)(struct amd_mp2_dev *privdata);
>          int (*discovery_status)(struct amd_mp2_dev *privdata);
>          void (*suspend)(struct amd_mp2_dev *mp2);
> @@ -100,9 +100,9 @@ struct amd_mp2_ops {
>
>   void amd_sfh_work(struct work_struct *work);
>   void amd_sfh_work_buffer(struct work_struct *work);
> -void amd_sfh_clear_intr_v2(struct amd_mp2_dev *privdata);
> +bool amd_sfh_clear_intr_v2(struct amd_mp2_dev *privdata);
>   int amd_sfh_irq_init_v2(struct amd_mp2_dev *privdata);
> -void amd_sfh_clear_intr(struct amd_mp2_dev *privdata);
> +bool amd_sfh_clear_intr(struct amd_mp2_dev *privdata);
>   int amd_sfh_irq_init(struct amd_mp2_dev *privdata);
>
>   static inline u64 amd_get_c2p_val(struct amd_mp2_dev *mp2, u32 idx)
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> index b3cb13b8c5e87..f48a096a6d2bc 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> @@ -103,25 +103,31 @@ static void amd_stop_all_sensor_v2(struct amd_mp2_dev *privdata)
>          writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
>   }
>
> -void amd_sfh_clear_intr_v2(struct amd_mp2_dev *privdata)
> +bool amd_sfh_clear_intr_v2(struct amd_mp2_dev *privdata)
>   {
>          if (readl(privdata->mmio + amd_get_p2c_val(privdata, 4))) {
>                  writel(0, privdata->mmio + amd_get_p2c_val(privdata, 4));
>                  writel(0xf, privdata->mmio + amd_get_p2c_val(privdata, 5));
> +               return true;
>          }
> +
> +       return false;
>   }
>
> -void amd_sfh_clear_intr(struct amd_mp2_dev *privdata)
> +bool amd_sfh_clear_intr(struct amd_mp2_dev *privdata)
>   {
>          if (privdata->mp2_ops->clear_intr)
> -               privdata->mp2_ops->clear_intr(privdata);
> +               return privdata->mp2_ops->clear_intr(privdata);
> +
> +       return false;
>   }
>
>   static irqreturn_t amd_sfh_irq_handler(int irq, void *data)
>   {
> -       amd_sfh_clear_intr(data);
> +       if (amd_sfh_clear_intr(data))
> +               return IRQ_HANDLED;
>
> -       return IRQ_HANDLED;
> +       return IRQ_NONE;
>   }
>
>   int amd_sfh_irq_init_v2(struct amd_mp2_dev *privdata)
> @@ -129,7 +135,7 @@ int amd_sfh_irq_init_v2(struct amd_mp2_dev *privdata)
>          pcim_intx(privdata->pdev, true);
>
>          return devm_request_irq(&privdata->pdev->dev, privdata->pdev->irq,
> -                               amd_sfh_irq_handler, 0, DRIVER_NAME, privdata);
> +                               amd_sfh_irq_handler, IRQF_SHARED, DRIVER_NAME, privdata);
>   }
>
>   static int amd_sfh_dis_sts_v2(struct amd_mp2_dev *privdata)

Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>


Thanks,
--
Basavaraj

>
> base-commit: 2c2fe95ab19b09bef7391e3e5cdf8146d09792b6
> --
> 2.55.0
>

