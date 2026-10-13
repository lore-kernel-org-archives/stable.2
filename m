Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309B34749DE;
	Tue, 13 Oct 2026 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906066; cv=fail; b=m5nR7RRzE0hkixCF7gQEsUouBSM7wlTJutJQ484Iac5RTNTs3OARYKru5Pi4nsuE6+P8vitNws8EBVph4t/J0D/FIE22H9C8jawNCsZAO9wCI8ip9HCi9w1H24cS/IsaEo2VDFwoBvTygF0pJp6tvU6YeYzNOJjMzwG+lXMJsfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906066; c=relaxed/simple;
	bh=RvFUsziGFMO0I03hge9tQg+0ufSC/xvzU0rWCS/tqDQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kuCe34Vj5aCK8r8dN7bZX+0nVFrcDdDEOz1aN5lPrmASPveHr2XkbCf0pOIu1qsD+1wihqfMeGBBn3aiUu+WpUIk738ovlANxktGXJ4+0i58TXebp6QKc79w1xThoG947E9YqSVcZlXNgb1O/mQoJ2IEx3gSwg3+JfDLvM2/niQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kqfv7v3w; arc=fail smtp.client-ip=52.101.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kqfv7v3w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAo0wRhVkspwSYY1KZ8N6El/SzuAvhuF6bJ6QRe4oJhAh8Mr5c4dc1aTrfs6tilnCfeRr1jVrqjynwgbNlTPAMOsA28+jMv3iNxFVDgqvM8U8/eYI3GGqyZWDNzu6KPdR6l+7fEJhiVK7/RosUe+w3qf8VGl/umucE//DYzfuWS/bMMkjR0FnfFaEl4RRpajDXor+yT9h+0er5Rkp92FsHZmWT24DN59xgxzyglaZegr3XMYxSI5xWnFcGbikQbEbiuRn9RqClmq1/YTaogK4GYo3dEIjq89xx9SmI8HjkNl4suTGweQWpPCTwDGRczXYkU1mmZmzQekraNSw+NwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XucqAaLWHbA4IgeJDCYRf6YLsu92kkD0hmBoQWgXRsE=;
 b=O0f+TSkDUZIf2NiDdSbLtF5qfs0drfl645Ddz67rdulc8vuzwCLfbMo1lqb++FAu0w8QKWCCWAnUjhxQ3bQG8Xqf64YU9XSAfPGbUzJBUqjY2Ne8hjubUc0zLYlOjq7XXjPPso5hZOMkRL0aBLfcElxw/rWteeiBu/puUXzNrLYW3y2CKlvlSXn5VvHtP5/Xa6bxBSS+XQLYDOUBPKNXadlw/fgv64bXtrx8fQycwJSN/kUZzlzNkUfpUbQXy+sJwMmxXVi6xLnb7PvjHp8iiZUgoA0yukKmICbPGYg8S5ikSRi3UEjGdwz6fFGFbvA069eSPt7W6jG3pzEAt4M6aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XucqAaLWHbA4IgeJDCYRf6YLsu92kkD0hmBoQWgXRsE=;
 b=kqfv7v3wtgQZpq2XSXype+7Z7MGXZCVTtnUeRz9pWhSdtDeXVCpg7I91oF0QmkNYeB6UrRUsBTf2tYfZJENMJXi2WHn2mpiOyFlX0KvzU6F1Nd9WVvbFDSKvrGN2Rg3f1kGqdBrUhKyjTctzoh0KHOGTEE11Uus+SwzULOIn2Ec=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by LV0PR12MB999070.namprd12.prod.outlook.com (2603:10b6:408:32a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 15:41:02 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 15:41:01 +0000
Message-ID: <d11aa70c-4753-4a28-9955-990c45649677@amd.com>
Date: Tue, 13 Oct 2026 10:39:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/PM: Restore BARs after powering up during
 enumeration
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 Keng-Yu Lin <keng-yu.lin@hpe.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Matthew Ruffell <matthew.ruffell@canonical.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, andy.liang@hpe.com, david.chang@hpe.com,
 s.collins@hpe.com, jenifer.golmitz@hpe.com, pravallika.kamma@hpe.com,
 zhen-dong.lai@hpe.com, zachary.pabor-ext@hpe.com, stable@vger.kernel.org
References: <20261012104645.975190-1-keng-yu.lin@hpe.com>
 <CAJZ5v0iGhqaF1m-Vc2xdXQXj_BxPFFWCBTP=Ypg_gWQEqWkNfg@mail.gmail.com>
 <642c49e1-7d47-44fd-b597-e5ff0877bb56@amd.com>
 <20261013060957.1023448-1-keng-yu.lin@hpe.com>
 <CAJZ5v0hndk_ck1hcgWXyGX=OHmbfbhKsrJQsNQF9DQrucRNMDw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0hndk_ck1hcgWXyGX=OHmbfbhKsrJQsNQF9DQrucRNMDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH5P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::9) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|LV0PR12MB999070:EE_
X-MS-Office365-Filtering-Correlation-Id: e055c2fb-b211-4fbc-3daf-08df2940626e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FBQfjFjVTDHiMDfm0TFU8r7p4KkYYRg02+uwHHXpl7DGMGhNVxcrlQMh1wF/YpB2li2F+WA7ZJ6CE1I+GU3oWRf8Okn/N4bwEMec6YFnUq4EE3ONYVB0DcAIpNQtwn7BoJCvjSma30jUzsHJ7KyQVTzkQhhLqszslwNc0IQPfVCgYnJ2znTHgaeF4Ulvk0aNCLNbqYpIrvO/DjKGLN7fmZ76oXFtISKX6Q7KLGQVt/sIMdXfT0dXej/Qlogb9vFdKZdp9YDXKLm8XNjVNk6My2onpJwT8OOb7ro4y/1szIOFNiSNp/zgMQNKjPMvSMVWfW5DxPgJQoJ9zzJG9We00gMzGm4HilPj5Qkz316owvS6gqE/sQnkQ6krYM+ow6JdZn3//I9sC7i+OGBqGm1uxqO6a3VjwoX7tNBqrzqjx+A/W5W5B2OqaTk51/uqlH3TvyxMA70q8fXhRL+kfS/i+L4dznQorGBfAq4sCoW2mXnJUp4kp2miVnC5/EptAC/z0UevwG29jx+rhr97gytd0cjdgwdJSnfSwRY2an49Pd/CW+D02og0iML0GqfPrM1+sjYtvRn0ruKvPEJTb+7NZXhVl93WkJzvrZvnZWfeffDw0J6OCKb6pAbZTKjLxCHwgGliaa+MilaF5TWPLHf6zWBxMiOic6gQ9FjeTeMkVn0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWlsNDB0SGhjTnR3Y3JVYkhvVElIV0tQTDNrUG9BRWNtOGExNFB1SW5ZcURh?=
 =?utf-8?B?Qi80Rkcya1ZoU3B0TlB1dWZ4U3NRSUNPNDhxK0NDS2NwNkoyOXpNNEtucE41?=
 =?utf-8?B?aUhwcFJ4YUY0bWVXejhzbmhpT3RVYU5QMTRzR3diV0Q1c0hTeTdOakpndHp2?=
 =?utf-8?B?RWZ0Qzk5WHVIMkRUeExFSm4zTHBMSGgwYVYwR2ZyWGxGSGhBaWwvdS9TcDlT?=
 =?utf-8?B?SjNVSFpoektTTkxZZjRmNTREVm01bWhScjhTOG9udjhmZmI4Q2VEYm1XNitk?=
 =?utf-8?B?REFodHdKZzNFMWEvZ013MjROQVA5ZVZ6SGlzelVyenR3UUVSMmhXcFE0TlF5?=
 =?utf-8?B?TVRZdWtoU3NpK1B2c3JlMUN6OWNiNFpPanhSVG12TWQ1WmczekE1dWZxY0pj?=
 =?utf-8?B?cGlMeXVjcFJWblZGYloyUnc5enlWaGMwcE1wY0owTlBwOFYxZGpEeld5WmtL?=
 =?utf-8?B?MUNlMkVoOGpZMXpNZS9CVU9zYzBxSG11bDN6eTBIaTMxS1M5TS84NU9HbzNz?=
 =?utf-8?B?VkVZT1UvRjFVbk9VT2d2Z1dtZzdoMFV6Y0EzRk8vOVkwQ1hNU2l0N2JETEdC?=
 =?utf-8?B?YTF1VCszT3hBWEVlWStLby9MWGQ4NExDb0FadEM5dkI0NVBIcmg4NFVYK1Zm?=
 =?utf-8?B?VHFMdkdMS0MrWXo4RlBDMkVmNktHZHBNNlp5U2lCbnRjRXNZbjlCekp0QVBL?=
 =?utf-8?B?UnJQV2NjM2psN2xId3dqOU9CTmJJQW94REpQQit5QWVpYWlMVVpWRE9YWGxD?=
 =?utf-8?B?ZlRwcTdISmFKQzB0VFNUOURlL3ZFZUFiTFBVTFY2cTJlK2pvWUtQa2NTeTIv?=
 =?utf-8?B?NklkN3BVN1dUUkVFc0NPajJjWEtRYXV3THFOWTkzTk5iRzhHMVJ3QlRmOTBT?=
 =?utf-8?B?NUovSUl3b3Uyc2JEVWtXNlpYMFNLSi9TSGpZNVpYeGNqUXY5Nm00bWFVeTFk?=
 =?utf-8?B?M2lidDVEMkQrUHMwdzhHYkwzTXEvdmVVaTMxV3l2a0FpWlRoTGhPRjA0bzZP?=
 =?utf-8?B?VEFudTdnSU5FdGlteGNYa1dRTTY5NDRrenJMK2JYMnByZGNaL3ZNY004N3l3?=
 =?utf-8?B?b0ljZUFPWFZJZk1nMnFPcTgrUFNZdGY4VGl5UE5pc0g5a1EwZ1Y1OFpwUUJr?=
 =?utf-8?B?bmh5aHVIZ1dLb1NUV1lXNXdFRU5XTXlsRjhoQVpIam5aWFo1RFJnM1ZuUGNm?=
 =?utf-8?B?aHNBU3pTSTVIeDhrTXdvWGM2UXdlRnQ5VStHQytaOEluUFU0T00rTlo3R3d0?=
 =?utf-8?B?WE5IUEZHWW9LK3NwTGphSGlKQVk3Y1lhVHI0cHoxc2lFb1pNcnlidXpQUUdG?=
 =?utf-8?B?RkNlODE0NDJhYUNxU0lzNnJ5dmZ2UGVBNmZ3dndBVldHcjIyWFBUU2tYM3My?=
 =?utf-8?B?UXA5c21iZ0FJcDdSeGhWQ1lYWFlKSGRXVmtMbUFCSXVQZ3NtU2NqMEpoQkN0?=
 =?utf-8?B?SEZXc0NEN2lVM0FkRENQbE1kNllrVUJYQjFseC9DUllrNUhKQWt4VzdJUzh3?=
 =?utf-8?B?a0lGOExNK1VuN1FicEcwbzFQY1JaVVpnSkNjcko3RkY3TGRIZGFlOXIzYWsy?=
 =?utf-8?B?S1YwS0JuVXF6N2FFdU44ZzNXbFUyRlJab1ZGUUpyeG1OMFFab1ZraGxNNXRY?=
 =?utf-8?B?ZWRmd1Z4S1VDc3FXVnZqcHNFTjRGR0k4T2NTa0JvdjVYUlZTZTZNTThFWEJG?=
 =?utf-8?B?T1pic0NLREhxN1dtWTBxYmFKL3N6NVY2UXhkb3F5RUc2cWJHZWxpN0tBUmlK?=
 =?utf-8?B?d3JYM1U4Mlh5dWI0YSs5S1o2dXQ5cHAyQlFORWZzc3RyOG8xVTBzcGd4Y0xm?=
 =?utf-8?B?YjJKTzlaNWY4NGpjMDVYcVI3NFhrWVB0ZnJvWUR3WHIvR3BIZ3UwVEZ0VC9Z?=
 =?utf-8?B?Tm9RMzY4aXVtVE9jRUJualkrbEJ2TjVZUFBjdkpqSnZieUVna2NPYUl5clBy?=
 =?utf-8?B?ZW9RR2k2OHMyT2RYMjViblFWaERtT1JiS2RJcFJZU2EwTVlhY0llSjZ3d0pY?=
 =?utf-8?B?MW5aeUJqTUVCNHlIY01mbkxjUlFVb3VWYUxCUG5BVnNUa2EvRDlUcWxZcGZC?=
 =?utf-8?B?TlcvK1JKUVMwVUlOREJ3cHRFUHkyWVYrRUh2dEdVRzRJMmhnQU5lbTFyV2Zq?=
 =?utf-8?B?OUdzNW1FNmN1SUZDTkdqSHpaTmxteHVuOUlRc2owM201S3cvWGMyd25VSTBk?=
 =?utf-8?B?bmFlVkFaWllrVHd4WFdERHBjR1VGNWdEQStVVlBacnV0MUdHa3oyTEx6R0tO?=
 =?utf-8?B?aWliMjFCY1gwNWE5bWhMR0hNZGR4T1VJRGx6akZXYTZwL1FWRVFtYTBGR0I2?=
 =?utf-8?B?T0lJdlNkaDVpS3RFa0ZMNFNHcXA2SmxEMER5MGJDME9sWnNmb2hvQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e055c2fb-b211-4fbc-3daf-08df2940626e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 15:41:01.7316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56atcfiywN06LGGLiX3kQfwLh28AaYxuIcmqLnCQjT5xrSWI5qc5kbOWkfkHCH3/KNt28TMrYYj7yzv56J5seQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999070



On 10/13/26 10:23, Rafael J. Wysocki (Intel) wrote:
> On Tue, Oct 13, 2026 at 8:10 AM Keng-Yu Lin <keng-yu.lin@hpe.com> wrote:
>>
>> Hi Rafael, Mario,
>>
>> The initial read is not needed to fix the reported D3hot-to-D0
>> failure. I added it to avoid extra BAR writes on devices already
>> in D0.
>>
>> pci_power_up() does update current_state, but need_restore is
>> calculated before that update. The check includes:
>>
>>          dev->current_state >= PCI_D3hot
>>
>> For an initially unknown device with PMCSR reporting D0 and
>> No_Soft_Reset clear, this still requests a BAR restore. Reading
>> the state first avoids that request, although the final
>> current_state is D0 either way.
> 
> Fair enough, but if the device is in D0 already, it need not be
> powered up, so if you make a point to update the power state upfront,
> you may as well skip the power up if the outcome is D0.

It actually does need to have all the ACPI calls that happen as part of 
the D0 transition though like _REG.
