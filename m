Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795265565;
	b=PMMg6e1fjfPw7oqBdZ7xOvDbb7Ve37TPkcm7qgtozMd+8HmC4Ca9K5VnrpREyQViBmKL
	 6ZtvjXOy35eS+O4SNU9FtXsk7JJaWjqWVhqju/zyEaKxcIXyrzzJL9DC/KBtZnPN1MDNf
	 i71A1nwz1w4jGhD3B+KwKrFPVm3Onkd5RI2bL7ueMfbpK0wcVAOu62j72Hk3NbXCFTAuz
	 frJtjKSzsd+qQ1zWP4B6104R25JTZkSsxrUMhH6wWmUNVPy+UhNSsRuTaiTjtku4THvy9
	 tZn4Z/irL0JQx9zCMStfsW3dPXuD7CWZkZEli4dYqLMaMO+Gu32iVUvRiofQn249WQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795265565;
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
	bh=c9RBokNlJTUyOl6hS2JAefnEUkSVy9b80NgcIVvxsbc=;
	b=CWLjmb9a4zkMC9nseUBg5t5U5q9EcTs0qPc8SqW9Bohgm7IALxpnt2M7B18A0k0RAuy6
	 3qD8rDtBiR3q5x0FpuZDmHweG10ihwsfgB7EETfSxjxs8D5NIbjwvf9vjHK6+WL2Rvu9N
	 ludr6tmlqt19UKXKFiEv1zasihKtNdfIHv2xgCywlK1EQxzPzQ+H78OpcLLVZ7Yiu5/If
	 1/Ies7FT0XkuK5aKzwbApdez9TsOngMDU/wjsZkg6qBPb8GT1tV7QuSu+zWEzjQKXpEhy
	 kIhNym1YrE5O3+BV0yZ14E/uW4McFgYpTxNo1mggN57tqiSXRjJjir5uF19vl+l2I3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xMoEi3lz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.1
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A7F606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 12:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6A7F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xMoEi3lz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1MdK8GOT77YVzt845TcAYnO9lL4tHMcTmpC6ITVbLqFEC+YfBlf5aa0nTxM/yhAVfpMK2MIcBiIgNR34Q/Y+q7CYzpB5cioW4jcBWgm6nx6avggcwc3LRxUi5WqPDh9Xq0dg+uLsqqbFSVxN5/zaUldcCAEcolUKS7NcFvpVE3TS9dNnu1AVLs81sDMiTLTYiDhR5qlW/nTXnB3iJIUln8zshpACATzWz4rIrc8nV2G1tatbwJEAkRaMjmGn434CgnWJYdFmqOF1eh5SwthvR+GLmHqwLvsU50vj1dUhZr+lZSkV1rj0i79yw3V/AJpIklzRh8BY3BeH07hCwpiag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9RBokNlJTUyOl6hS2JAefnEUkSVy9b80NgcIVvxsbc=;
 b=E1r6S62uGBTpkTBxJ7ieF6SDeUeXGROmhctJK+KyQ5dIc/CP0+nALglFwfaLA/qgDBx/7WExapAni+OxPJoL5fI/YsKUXnsxUrPnkpbuJRUSJmS/Xnrty58h49dXXRHO+UgNFBwE/Vh/S+MPQk1CVNBOSMDpz59H49l5+t8/FlmXLgj6x8bGVlBXl1GjqwMjr0kgSw5h8btInkHtwUDmTsstpPNgTrNij9++30opTIEXsQ2BzfTvLeFBke+E19slfF9kYeiUruwSBA/9CUgKOwOhnUjb3TxJ9QfrYu5/sko0YbjCNPJLhWUoIxd4u6MMCh1SYPANXshF1NgEkTne7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9RBokNlJTUyOl6hS2JAefnEUkSVy9b80NgcIVvxsbc=;
 b=xMoEi3lzURlG4qhNaIdqj+QcxLN67sFXlgW14s89aVFyCWqt0+hWovcGIOOWJHMMPWGqoWWGtDo0tCZUIKKb5CLzBhS/EvwO1+Bp/G4fPQdZsQsa0RkgccUbQKrEgRslldcafWRQ8D04gvy7T4E22H3fwMK+QQlVrG9oRfCqVGU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Sat, 21 Nov
 2026 12:52:41 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 12:52:41 +0000
Message-ID: <bd7566e1-66bc-43bb-bd41-f1170e32b8f1@amd.com>
Date: Sat, 21 Nov 2026 18:22:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: do not remove the shared IRQ domain on
 intcapxt failure
To: Chengyu Liu <lui2012qwq@gmail.com>, joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 stable@vger.kernel.org
References: <20261104072241.1617661-1-lui2012qwq@gmail.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261104072241.1617661-1-lui2012qwq@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0266.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::14) To BL4PR12MB9505.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2b2135-d133-43fa-8e4e-08df47ce545d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10067099003|261022105027099003|56012099006|11063799006|261009223027099003|261009221227099003|261026140227099003|261026121527099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FS/2RY5kShMNS6f9w8U8kepItwtZx9YZwTMMXFPqhw9Ydcxc356tcsMWlmQQvGyfCHIeNcSU3W4qJPviwXwOVC9bQ2141FIZi/3svcj6kSaCcaMJpTJH+rhvXyAMmP0+4Fe5zZa2n+u9geksNUhNY4RR1WOB+51Csj5kyGvZWEJi2cGFKgEh+pQ7N7X7hOAtrGRx7m9cj9mif/j07T91T9VhFaxcj7JPogY+JtYAeXf1mR1MZVVNZyB2lo4kBG5qy1kCvFvW33740IhpxafRgZHgOeQRvha9IQkI/pz+Ik+dQcfFpAWTROgELRuZOZbdboJn2AvM3jNIxRHkJxn+98AXlA16z0RHcg5izOXQl7izRNVnmsHb0FT2VyOxYn4lPRGMJrzlV20HdcfiA1uZOmBZ0xNaadvhSHVBkFHLcBc0Nh3n7SiOlj+7q99RIRPeM+NwYX5rBCtbi2IpE+Xw/9epPjMTeQTswAU1iEu2SynbuyanFtUPFFFAuufS+1KNJ0658INW7hm0TzGk/kg9kTeZXVOcI74pYL2HP6dnUSRrOrt8n3E9tyDPuJtZvk0mpT1HN5vWdn2BzvNrdJ3Kg3NQQTGgiVH8gw0vCsntG7/q5stR6i7qNVpzjjbhzSwZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(261022105027099003)(56012099006)(11063799006)(261009223027099003)(261009221227099003)(261026140227099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ei9RWHhqcVZJWkdUWnE0RE9meFhNdW9zVDdINHAxakIrdzNyTjlBYTh2dWd3?=
 =?utf-8?B?K2xWM2ZIaE03WUZXVDFmVGdIcldDRXBWVVJzMEpqUGg3dFhtNFlvQ0czYzl4?=
 =?utf-8?B?RVZtUVo1bE1IOWx3bENWUkZqNnBRQjBQck9ZT3RRVjU5MGpaUlJzVWlFb2Nv?=
 =?utf-8?B?TkZTRDhDaVJpUHVSY2dQc1pla3Y4VEVrK2toVG5zNk1ZTDl0ZUNkZ2hiQzNG?=
 =?utf-8?B?NEpyRWJSSGVoYkdtWGc5NzFBT0pCV01EelVWNWozQXVCcmxYMjQ2ZndTYUwr?=
 =?utf-8?B?TWJ2SzBkNy9zMTV2TCttb1d4SUdZbGI2ZDVNRnRvZndUaWt6VFE2cDV5MGgz?=
 =?utf-8?B?UFZPYTN5dW1xZ3lpMzZ5bHJQcFI3RzQyZUMyTEo2QVpRMVRxaFJiN1hnNUlq?=
 =?utf-8?B?OFZSOHQvVTZxcWw3UlpvMzlQWnRma0ZDY3loTTY2REt1Qzl2d256UzBOOXNF?=
 =?utf-8?B?cStDUmh2enVETXd0cXRUM21UQ21kWDRvbXdKUXplL005bUZZRXVGYXQ1cDJP?=
 =?utf-8?B?dXY3dHZ0VHFzSHgvVXJaRGcwTXNtNTM0dGk3YTlCNFFpYWtTMHZqRlV1eDZo?=
 =?utf-8?B?UjFBbzFrQzdaVnlQTDd0MXhtK29Jcm90OEVhbjJyb1QzaWU1WUNsM3JWampx?=
 =?utf-8?B?akJwMmxtZ0tFOGF4TElKQUM1bzFWaHluZ3pqSEx6R2kxYWpwZXA1U2Y0dUdv?=
 =?utf-8?B?MngyTDFSUDM5Ui9rUlkxUVRSV3V4VHpvUVdYZnE1YTJRU1pOSVJlcmF3V0N5?=
 =?utf-8?B?MytZSmk5cERzcGNua29XQ0ljTFo0VHhDYUF2cWY5amdLQmorWUlTWXJYOWZP?=
 =?utf-8?B?RjNZdnFEVUNScGN1V2FwQm02ODBNZm1kMjlaUnlCQnRVQmpmNjhPbG95Y2p4?=
 =?utf-8?B?aksveHR6RVkxN2dFV1BuS0NUNHMzUHRvc1R4VEpaVHlvcmdZeHQ2bEhzQlVa?=
 =?utf-8?B?QXI2ZnNVVW9ZMkhHWk9ES3grWHE3eTY4eVNqUjgwRXZBOWpTeUlyOExIc1E1?=
 =?utf-8?B?NlI0NGZRYW1nNlRZbmdLMXNhSXNuT1Frc2ZtelZTcjEyMHgzMUxmWURhSk95?=
 =?utf-8?B?WDM2Rll2eXRqZWF4YjNDb0tYcyt1aUl5VlFJTzJSbnBqMU9NK1lsSnRCMm1E?=
 =?utf-8?B?U1VSR1BJVEs3aTFmcnR0WXpwZXZRQTNNVW5ZN0JVaElaaG5UM2xoVTAvck9q?=
 =?utf-8?B?SXRvUk1JQVVDcmZpWVd3RFNmT2crcDREYzZzSXBoRUh0U0Jzak1LQmJOeDBm?=
 =?utf-8?B?R2RURzRCQzZHeWVlb2pBWmJXL1ZOL3g0b2xIdTNjSGNaKzNvRThwQXpwSkli?=
 =?utf-8?B?OWlHTmczdmFzeFJRTDZqbGdYZ29MdCtlQm0zb1pheGZQd21DSmw4TUl2UnBT?=
 =?utf-8?B?SHdicEVMM0hwcUhRd1VDTkZ5RlhjNlZidlMvR0UzWVplK1V0bm04UDZLVjFR?=
 =?utf-8?B?aCt1Y1BKQm9uV0xwT2tRUEIrTVZWaVVRYWY3cnVZT2U5Vitmck93ZmlSdjVG?=
 =?utf-8?B?bEJVd05hYkNkRDhHTitNcVRIODRCd05zbTJ0TW56RjdjYlI5bXZTYjZWck5O?=
 =?utf-8?B?Wko3RnExM2didGRLK1o0dE1wQ0lOZUtHSmdDRVREcGNSSGNZSFpINi9MeUkv?=
 =?utf-8?B?bXQxOXAvTjZ4WkRUM3Z1dEh1TzRQTXMyNTZleURnSFozZ25FSFg4VmdjNXNq?=
 =?utf-8?B?TnRkejAzU29ocndEWk9hQThyenlGSnpTS1pQU21FSzhuUjJQTFp1T3AxZC9z?=
 =?utf-8?B?QkVhS2FSYy9LTTRJZndGWU5lU3dpNVZjMmRqNkVNN1dVdHlicGRORlBjeGVr?=
 =?utf-8?B?Y200Ty9VK3BHOWE4b3lEa3Z1aGtLTHlORTRsT1hwY1pNRXp6aExQUWxwSkNo?=
 =?utf-8?B?TE82OUlqWEIzUC9SdGNid216ODVHM0tCZjFROHo0RGM5bWhEd0c5aWJmTlRq?=
 =?utf-8?B?cmU0RGNqZ2xlMkFuYVFJN3lxRm03dHJJeXdvQ3dBaDFDZDl0c012UEZuL3JP?=
 =?utf-8?B?SlBJdEVoM2lxRnJRV1ZrUDNpczFOeHA0WXJGMWVnQ1huRHpUanRUM3IwYlpQ?=
 =?utf-8?B?d05Td1h6RThybVE3aTJiejBpSCtTc1A1c2RpeXVneFNPVitwZ25LOHQ2azBU?=
 =?utf-8?B?bEZUdUhZc0plK0xSMHAvbFBCUDRVMmZNd3Y0VE1kR2tGbEUxbGwwK3JEUnNa?=
 =?utf-8?B?S1M0emh6b2FGY1JYa1JqRXRQSUVOdmpRUnhpVXkyU1YyK0Z5N1ZWR2w3MmZn?=
 =?utf-8?B?bmlReWswTjFySXBYQUgxc2w1OGJmYW9DNy8yTHZhTWVrQnh4czVLNDlXSVJ4?=
 =?utf-8?B?emdZN2VrK3F5NldaeHpHYjcxeE1LODBZbEZWUzJHcFhXSUk1Wk1Jdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2b2135-d133-43fa-8e4e-08df47ce545d
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 12:52:41.7521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moWn9jRNJPb09XUpzLKpX2WNQW750prx5rPuPca2KAnp/jRo9Royax97IADSpngCPqL0BL06ggqOAU0yEXegeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484



On 11/4/2026 12:52 PM, Chengyu Liu wrote:
> [You don't often get email from lui2012qwq@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> iommu_get_irqdomain() lazily creates a single irq domain and caches
> it in the global iommu_irqdomain, shared by all IOMMUs.  Both
> failure branches of __iommu_setup_intcapxt() call
> irq_domain_remove() on it, which frees the domain, but the global
> pointer is never cleared and keeps handing out the freed domain.
> 
> The failure does not prevent reuse: register_syscore() runs in the
> IOMMU_ENABLED init state, one state before
> amd_iommu_enable_interrupts() runs in IOMMU_PCI_INIT, and the error
> paths never unregister it.  On resume, amd_iommu_resume() re-runs
> amd_iommu_enable_interrupts(); for an IOMMU whose setup failed,
> int_enabled was never set, so __iommu_setup_intcapxt() runs again,
> gets the freed domain from iommu_get_irqdomain() and passes it to
> irq_domain_alloc_irqs().
> 
> The shared domain also makes a single failure affect the healthy
> IOMMUs: if IOMMU#0 set up fine and IOMMU#1's setup fails, the remove
> frees a domain that still has IOMMU#0's irqs mapped, tripping the
> WARN_ON(!radix_tree_empty) in irq_domain_remove().
> 
> Keep the domain alive on failure; a later attempt (including the
> resume path) reuses the cached domain.  The request_threaded_irq()
> failure branch still backs out the allocated irq via
> irq_domain_free_irqs().
> 
> Found by static analysis.

I have a slightly different patch for this issue which handles all scenarios.

https://lore.kernel.org/linux-iommu/20261105040016.398718-6-vasant.hegde@amd.com/

-Vasant

