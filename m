Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793635328;
	b=bTZ1CoTuDTr3WSoQQZf0ZFU4f3zD3DUXidtsd3HJo0bK5Frb1PTvz/ivyD/Va+EYvat+
	 HyGnwqET//ena9PpjSbsQm69BiN/omLWH4Nxq2s3NhTtqrkhOcLyEpN17dGQCZ0LQChA4
	 a+zPbkd+nNpcZmKOkSEDS6N1YGoNOxD3aiqZHy4mce97JbGaJZgfDxYTZGYxy8qpIpqWX
	 5PLv1+Dsj79jbJdN7fGnnsDRved+YMvUNpVJw0jEv70QeEctCSc39GsShutATT1iY+6Hd
	 jwzgM9x8JuDAPJDxJqUTPQN6LIDFHWh8hTBOdMM/OEx5W+j7TEMbu2z9BY2Yze9e8BA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635328;
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
	bh=TSW1GRvJhzMnDeLAb/ZRB3TRTOcMALI3gQ+NWY0m6Yg=;
	b=Ym5LRPRSo/Q4TvHpDyORdPebVSkNC36uLD7DTLwSuDVYmicf+9vjAbju2kKWj7sJF6s+
	 oEkhWX3g6+000nZh+JcJvNjDqyAuce+LhX30QW2V7w4I4Dd2HiWgNV/9txO4k4YamAQgx
	 1VC7HzZxHGFJgccE5selqHJZxadQj8lA40g1ggHjIJQ02uP4St4LwT4E4C4TWaH8vRDf5
	 CiT12LFPV1FkWFMSuWt3Q3oBV+rdxjslEXRY7d2Raz38MkvbI4uqtEPpvlwQu1Xo/4RvS
	 bTCgCJ17LzkcJ++oPEr1sTzBeUmxGaVAw9VAFET9oj/7PKslFav/nyTP8QPNgfsh1Ug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OCDr2gKw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.18
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11111606A598;
	Mon,  2 Nov 2026 16:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11111606A598
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OCDr2gKw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHmH3WTl9X9FQCKnWB/dvf1cN+FfGibcfm+MAsNPw92S0srV4qAXTW998nDfvFbrazBt3y0qFQT1mjA3xKpTJZk7Ot51eZwvYk7RDmgP9tfLbc5iRsdt2eWboglkHgxScmLw32KrBTellRqS2PnWhKmVmKs17OaQ66L3x34p/Vbjv3C6wST1Vcd0D8oP+E5cSAnaSgiB1dH7F9ZC4FE71LP4YLJ5PB+eIG9wQ6QB/4/yojSCZ4zOHGnEkHD1qp5lppPj3UtNOuEvMrGli0ZaiSpgY4axdLOfqH29XyaeeiMfhyeABn3HtyEtTJMDV0egRcICSCr5I6xB1+ZHTj2lkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSW1GRvJhzMnDeLAb/ZRB3TRTOcMALI3gQ+NWY0m6Yg=;
 b=CWZuvHZvwdN9+lhp4Attiej8ND0FwyIxoSabwvhJF6YTLfKapoUga+25zTs3NefHGPavSC2Woie66mc+JkQ0LgPvcZKOjGda7urXCy0HgrprtOgbLMragNJnnsm90ftZbMWgeUfqjOaz+vZo3FyIQ86E5Ug2YF0huKi3b0wvlHv9K8ZhzwXo0+IaPfanUnPf273SGl/ftoPaAVt6xrmPpfd5GjBbz+v1xGuBjp6glitdbLSGNXpzjxUEgtUn9Z1Tv2Y6phtS8Ab/CfWuQMDJBCTa458NvED5cxxGIQXlR3r9qYL5uehoeXgqipHKeeJtIYBg8IsCGqX2C+L0K4dd9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSW1GRvJhzMnDeLAb/ZRB3TRTOcMALI3gQ+NWY0m6Yg=;
 b=OCDr2gKwLWk7/WnNmkS5p98AUIc3Vz7QBzgKsZcZX4Sh2rLOO7hZp7CJrEXhkKOIAvxhjJE5ViWKm2XwnXshRH7W3c5LLpOxUoWdGWQaXiawF0QfDavfiKSQJf07+Weh9cPN3RFtQT0WuAu90oOVLx1p96xYACRK7Pwg/mC0k8g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 16:02:03 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 16:02:02 +0000
Message-ID: <92c85732-9274-4bc1-83e4-0d3aa9941494@amd.com>
Date: Mon, 2 Nov 2026 21:31:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Skip non-IVMD entries when parsing IVRS memory
 definitions
To: Akshay Jindal <Akshay.Jindal@amd.com>, iommu@lists.linux.dev
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261018074549.1493086-1-Akshay.Jindal@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261018074549.1493086-1-Akshay.Jindal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0168.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::10) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb95360-8045-453d-7e36-08df38faa22b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|261102123227099003|11063799006|56012099006|261009223027099003|261021121427099003|261022113327099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	nVOHbw+fhCDT8kMr6hc0QTajmhgXR8vi9hZOayA4gQeRaixJfCa1+2SQ3MtBYeza0cfDrsxSo4wwelWG/8AGBaz5glCQfBCtbRO5U2xNUF/b5kVPmPWFokpcWtoP+O8vw3am9EVcyK5xcVdmPNN4pb9nrTmSEugWJrOUu4iY9gwLD0ccvTeLv1wtYREutiICBLil/5xG+z0+JMrdjFrd7O4EH9iFdP5q+qajOVOsmpPlz64gV03GMJL5b7k774itYxQ77Lp0bhM3OZXeKCHCVvEqMIOcHuqqEVH/jk9VbixaQkYFDFnRxXEnwL18aSUkZ2mQLLPz0Syot38aQpJT66CIuypqWlmOyUA7uzc2cdg174VjNKLUnBpiM71oAWAMLVAJY7Umbwu5lzjSS2Xq6l5AgRrBN/GKQtwEzUjlZnHMlPa3R7hH2BlWBRIiTSt9o+Kct1DG2dUG72ZVwHmgiM6aMJlzq0MRURkeaeUJTHgN36GE9bUIP9dVkepkTPTHq32MejGfOWSbBDQ/qOwkjXAgaJpccilb0XrvkWzf1s+HmaTQCgzpXTPazZ6Phw6f3E2RLwaH4gYEQxeJUGlxlaSGWdyuqvYlLUfQNQEwt+9jAu6ggvzC/uEpACscEDF//ed3gFmdHMM7JtM3iwYEXIVrRUOBmljlKvP7JmLxX5g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261102123227099003)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261022113327099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGZYWVdnYlU1T1Nac05GNUdHWkxCanROZVBiUXlRVnVtODFNa1N5OWMvNVhH?=
 =?utf-8?B?Z2xSODZKSG1Oclp5dVpQUzliVkNNelZRKzhGMk1ZV0h6WXV0N0laRjQwdkM3?=
 =?utf-8?B?aWRkMzY1WVp6bjdncUZYYVhNeWc2eFQ5NVNwS2MvbVNzUnl5TmQ2RmluMUpC?=
 =?utf-8?B?NmFia1Nzc3paeVRnbHBFVk15dlpvRVc3cFBteVF0ZUszendyU09ydDY4MzYy?=
 =?utf-8?B?VEZETU5PN2podTMzaEw5cW1oNndqNnl5c0ptZTBpd1YvSlRwUG51QkMvYURz?=
 =?utf-8?B?TDEwU0NvTzJmN3VITm9DYjkxOFo2NXYxYTkrSE9oTVFkaTZxVlVIUDlGTU5Q?=
 =?utf-8?B?cmNRMTJJTGpMeFNsZm8vLzJNUDFWSUpYQXoxSFRrWGprVnF1OVRjY0xIWkdO?=
 =?utf-8?B?TmYyTTlqcVVYSjM3M01aTVRCNEJENHdhamtLYndxZGUzS3RKYWc4QVQ3T2F0?=
 =?utf-8?B?QjBDdzNQTWVZUi91OHJGZ0lNQUY2RE5scGlkZG9nakhKSUZ6dFBUeXplRVg3?=
 =?utf-8?B?OEZNcWpBWUxhVjZXTGhqZmhyMUpRd0NPQUFUbWxCY3RCZGZ5WUw5UWFEYjY3?=
 =?utf-8?B?eExrRVN3Vzg2Q0w3VldyUkFCeG5ZUlFPd01oMWtFUjZTQUZpOUtBdzZaY3Qy?=
 =?utf-8?B?Zm5WM055dnVSTm9RNHpLKzc5WHlNT0M3bmpMMHpWV2NNd3dqQnJxMmJIY3hv?=
 =?utf-8?B?RWhRSCtOWnZkODdXV3FqRGo4RGN0b1hkNHpXNUtQYlFTVzBRNmM1UlN0QU9v?=
 =?utf-8?B?QU5mOGNXWjU5K3AwWGI1STQxTXBtQVhXRzh6T1VPUG1ycHE0ZWw2azd6UFEr?=
 =?utf-8?B?TnI1MW40RXU4Qlp0Y3E4RDU2QTJ1UjhTRTJJUjNMa3o2b3QzQUFXV04wZS9I?=
 =?utf-8?B?czNzWHprM2VMc1EyRlordWUxbmFOMUtRWll4Z2lBTGlzTUZxbXBtNWlicnlo?=
 =?utf-8?B?bzlWeTU1SWJMVnhldEpCUnR5bkQ0WWFqVkg4NmRCNVQrS0V5VndMYmlaVUZU?=
 =?utf-8?B?cUlvS0JYWlpJYTVncHZOeHpreFFvWjhwU0FubUthcUt6b1lhU1k0Sy9kQk8r?=
 =?utf-8?B?OEg3KzNZY0hqbDRvOU1LcWM5K1Q2VU1HWEJjSVUwTmYzbDFKRENZYzJIdFdj?=
 =?utf-8?B?SHZYNVlzZjJ2bTRUdXhtTVlXTGxEUWlKYUQvU3VIM2FTTmIxVEFZaU5tVkJx?=
 =?utf-8?B?MExVa1h1OG92YnQ5ZnhJS295OFVKQkFnb3Mvb3k5QmF2Z0hTVmFEbkRMU0Jw?=
 =?utf-8?B?eEtRMmtjUTBFS0VPOE9JVzE1cVZrdXlYaGNBckNvdFZKSnA4WmQ5U2p2SUUr?=
 =?utf-8?B?UXhPcGxpRWhTaC9jZUNJQUZCcktkWGd1NDBPSVRONGlaQlYyS2t4di8rSnBX?=
 =?utf-8?B?Ny9rckk2cDIzdnUrZ1hBTHZSbmRmaWttTnBxdTFmYWZJRXNndEd5M2prQitm?=
 =?utf-8?B?ZDRwdXRlYzdKSlorQVdyUmVDclk1bUo0dUk1b3N5VmQ2TVBzb2VZRklIeUZ3?=
 =?utf-8?B?SEhaS2lXUnFSY21iVkoxQXJZZEV3QlhMcFVBa3habGNFUWJqTWNPSEs2YkFM?=
 =?utf-8?B?YVRXNUxTQllLNS9ZUUR3VUxMT011VWpuSTFFYzNSNEFVVmpkenJGc3BPNGNw?=
 =?utf-8?B?Z280MlpMWnhaaVZKT3FiSkZLZ1RKek9xYUFmazEzSlhhc3B4eVFJcjFKOUND?=
 =?utf-8?B?R0c5N01sMitkOGFCZVRyOU91UEszZE9nQWZYaHlleW9uOFhzLzYzYzZWRk1I?=
 =?utf-8?B?YXhzNjMxZlRITk1tYzEyVzQzelRZTzlaNk1vY01SRWFIdXBMOS8rQjc3NW5q?=
 =?utf-8?B?anlrcnRLdXVmNTZuV2lOUzlSNWg5TFhwVGVZWGZNOUJBZ2swdGwyU2JuK2dq?=
 =?utf-8?B?TS84cUJEclEzMDJxSHUrRU9LZ2x6UXRWM3UyOE5NM3BGVkVRTjR3WXcwMmtm?=
 =?utf-8?B?bVZIam5BelBjaTF1aXlpQ3JlYW5BUndxZlcwMWNoWDVjUXU2T0JDUUVwMG5a?=
 =?utf-8?B?ZzFIVWwwMEZzb2VXVmdxTzRBbXRHZ05EZnp1Rk1tS0VZbXdWUGsvUnZ5NDA5?=
 =?utf-8?B?RzBlTHBCc3lRNFRJb2RXWTBpYWZZakxjREZuWkNtL281Q0xDdDN6c2pMd1I0?=
 =?utf-8?B?OFdSRndtMXU3R1psVG44NnV4TlQ2NGovdVVjSHlCRVBmL1FqWCthNmRlalUy?=
 =?utf-8?B?Y2pnYjVtZ3hhUXdERC9ua0I2RmpqWkNXTWZvc1kwekhXS2VQa1hrTmJlYlUz?=
 =?utf-8?B?N1Z0UHVFbWZOZzBFU2R6ck5Ld1FqTUFtUnNoaEd1VnJUSzJacGR2VEVzUE51?=
 =?utf-8?B?R0tIcmlRdGdWcHF0aFY2MUNuWE1QRWltc2ZYSHI4aWp3c3pYUTdjQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb95360-8045-453d-7e36-08df38faa22b
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 16:02:02.7516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNiM+J8QHaSeTR3lt3BX+OVAM51TL8STky/eldRha4u3IFRY3Pt1rF11FX2csxiEkdOvLoDqkMxlMMyhZ8ANsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147



On 10/18/2026 1:15 PM, Akshay Jindal wrote:
> init_memory_definitions() walks every top-level subtable including the
> IVHD blocks (type 0x10/0x11/0x40) in the IVRS ACPI table. It interprets
> each one as a 'struct ivmd_header', solely on m->flags, without first
> checking that the subtable's type actually is one of the IVMD types
> (ACPI_IVMD_TYPE, ACPI_IVMD_TYPE_ALL, ACPI_IVMD_TYPE_RANGE).
> 
>     if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
>             init_unity_map_range(m, table);
> 
> IVMD_FLAG_UNITY_MAP (0x01) occupies the same bit position as the IVHD
> flags field's HtTunEn bit. Unlike real hardware, QEMU's AMD IOMMU
> emulation sets HtTunEn unconditionally (flags=0xD1 for type 0x10,
> 0x11 for type 0x11), so every QEMU-emitted IVHD block is misidentified
> as a unity-map/exclusion-range IVMD entry, which subsequently results
> in the creation of a bogus pci segment. Eg:
> 
>     AMD-Vi: PCI segment : 0x4000, last bdf : 0x0000
> 
> Fix by checking the subtable's type before treating it as IVMD.
> 
> Fixes: be2a022c0dd0 ("x86, AMD IOMMU: add functions to parse IOMMU memory mapping requirements for devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Akshay Jindal <Akshay.Jindal@amd.com>

Thanks. Queued for rc.

-Vasant
