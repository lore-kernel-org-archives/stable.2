Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438AB3A874A;
	Thu,  8 Oct 2026 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791489873; cv=fail; b=L+t3C6X1hQZVCQRBHnbNtB/UZP8g5RSeqeHzfpWGiK4a/cidTL03b2fPGgvdjDON2HVJCfzqakHWuXgKIMvKG+AqJ8v2FpJ8AZB4sB20NOo2+WAyAgQRcMSUdlH7LSN7XoxfpzvS4fNu/OU0CrY3DaVqrBrzwaxiLjaYDXcVxM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791489873; c=relaxed/simple;
	bh=e9vDWgAWgHn1wVzSpMgfBTf2lszYD/8SsLTNCK4lBKI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UTl5i8JdxPHqKADLZolzrCAk8l6aM5HJ1PqbVTuC90d7cE3Xg5LSUDCrqNbtLlitQPp4k9ltRfZvkE46IHyF0CMwXyFKv1DGVOqn3qJ8jLz+aApJRWVvuwOA6rRCcjVAFcvCQlMYEFnC09iMC4OJkVkN4Jdc3wWrGGV/x0g/FVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4YzBfjg+; arc=fail smtp.client-ip=52.101.56.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4YzBfjg+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQ2sZGVSnrGMCj5c8pL0WLDPwdaGQWAW62wFDC1PP7c5vE6vjTulrKa60qMKWhzkg/87ba3RgzdWYR86j9N3NmLE6Xs6ljSdg1PbXlP12QYxMYTNLBfEobQOnhwEGcckLTJ4HSp5tnK4z9li1C6heuqbwFQweIvTQpCPK8uVKyMuJlTToWAkvHIf/h4YRPB7JcCCXiAluMT4UU25xHvhh4nzWafx3z2MESSdENIm4CGsaoNwQOV/asZvrWIlEkUmZFedENDGbuYct6PT6HfHLQD06lvkfnzB6mhsJkDc5zHuDvgdWxGd8npOgeGHS4bfGO72iBfGivxssQDoekseXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yixPIz2vFF2kii6+Vpsud0m2RRmccJk/QNiX4ULseBI=;
 b=Zyw4+jEjPbpGgQzC3cm9MJRElk7ZPysP1OOPTP+jMVamK5l6MidmHfohjCuTL9MgrGN6KzfEKa6jMpGRsZIdYJmLaaVkkwjDzBSSCeivYqE4TGAIloRxdUKY7jJUaPm+mpn6u68lqJazOH0GlX/jdvWKbs2uo0saaSBw4E0MKi4j7GvINi8w9FX/3GHVD5dJZLJg6ySOj4j9gc6DNNZZ0UE2rn9pYXMC77P16AvP+OnIo8M8yaxN3qHBcLj/NvCnDy4TLtLg/6/PJnWxNaKa2G8Rh7I8Q+8u9cLVywwkETugf5LI4podO3YrFSqJ/+KtxikeC0p765no1EERKHrzbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yixPIz2vFF2kii6+Vpsud0m2RRmccJk/QNiX4ULseBI=;
 b=4YzBfjg+f0rFSV1BD3tb79CCOS6u2l8z8GLUbETlNov4jusdIEnzISex/OgyuMMdFWbm10P8u6V5niw15B17UxCIZjIzKbYEQjMhiswbCorTE9LXMyKJNL7Xn4k+/nvOW/2xUa6HpQF/jbSJKj/D2Es//6mGc/AZVChKHSaN0+I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 20:04:28 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 20:04:28 +0000
Message-ID: <ed80d662-663d-40a4-abae-1dca9cf8e97d@amd.com>
Date: Thu, 8 Oct 2026 15:04:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd/hfi: fix platform device leak on init
 failure
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Perry Yuan <perry.yuan@amd.com>, Hans de Goede <hansg@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, Guangshuo Li <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org
References: <20260921082609.244774-1-lgs201920130244@gmail.com>
 <179148103665.29028.12297507526234628809.b4-ty@b4>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <179148103665.29028.12297507526234628809.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR16CA0023.namprd16.prod.outlook.com
 (2603:10b6:610:50::33) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: f29f939a-95e1-43bd-4d99-08df25775bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	N9WRv9BBQ+Aex/ZH+2gUvDaQ0TmbvNyWgIt3DfhYVwFYmaVEvlGF6qMFky5Kgznxh8QpT7l0UVzlyfs0liVnsts4Cc8EJ9zYTdNScXUBMnxCJGsiE4IMKjFZ8cGNbhUIcc4P4gatIMsWKwvLDLuXMcIDkCveHmBPn8CSJZa5Sv6tv1eEpeeu0QYmzylWphrC2LaLHQQz04/7q43xqgROKdy8wmkZ1OHUTvECNOm3ODp7xBZLvNvi3UkWqBFKmIiJBzeKTzrSr0VkCmNMnCqaZHLksuo2FfUUkAbLQcgX/Z/iiEyDfxhjfJDCTBdcBvYCc90GPC+lB2s3Pdr0eruM+c6kvYhYIRydQhWX9gqXpCMFlTwdT6x0mwF4uMkHLkMRSH+e/x04lzojiwAro5bCZKkuAv4sftpRI7LQres8G/gB8Y1Ol4XLmJu7wiEYIlfCFBtVk4twu0smF/ONV0/kDQw9guv2R1mIIPe7SWIzap7RyJhr4a1YARl+mR5GGBKi2VGuQdMyKhCqZBaJ7/QG5WmUJgLYOuW92NYmSz0/CLQDJs0Nh8uPHHG6v+HGJHWmxanFpeZ5yfBQvFwSl8V0ZoVkEMkrjyHA+V01x3CE/no=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE44dFkyVTVFbWI0YVhseWd3ZHhWQVdsQ24rYlRQNFlvRlpjbUVUNEVLcHRP?=
 =?utf-8?B?eVBtMm1VZlBCYXdjL2dSM1lSbnF2MFhFRGxnajM1dFdZR0I0N05ldzB5SHJT?=
 =?utf-8?B?VnJJQk9EUHVZZ2VRYUxpSGRKdmFhQlR3My9JV0x1d095eExBWG9keGhnYkd5?=
 =?utf-8?B?SndGZ3FWTGs0SW9xeFpiZ1ZSTFN1b2NsT1J5Y0VWNUloakdCMFgreUozcmxU?=
 =?utf-8?B?bUxld2VCTWlwVmFIVEJUVmlpemhrSWVLdmczQmswa2RUTjBIand2SkpWd1dQ?=
 =?utf-8?B?T1VRL1dYU2JUU29JMGp4elYzV0lva1I4K21ZcFVHbFdtREhtakV1enNPeDRO?=
 =?utf-8?B?MmJHTW4zNnhDMjl1YkdET1ZhN2lKSHpwc0NSZUdlb0hFUlZWbUo1TTI2TDhD?=
 =?utf-8?B?S09OeEc5UWxPR2NzOVBubitKTXhselJPVVNHQWt4cXZKWTh0ZGlZKzRST0hC?=
 =?utf-8?B?ckdqMnpGRnBoMlFyRjBYUEtjeVFiVlBGelF0UmFxb2kzUU5PVXAram9lSjEv?=
 =?utf-8?B?WmJZUythcEovK2t4dzljWlNXWWdHQW8vQjVYRDZUaUxlT2Y2aklXVThEcHky?=
 =?utf-8?B?OXVIZHlCWll6dVY0TnBpMDkwaGt0akNMbmpBZmVWZFR0bGhlQndkTnFDakJy?=
 =?utf-8?B?RFVWQmNRVFdOR3FWYm1JdmZnd3VFSEVCbGVDcEdXRVUzTFAzYVhUNFRvdUlr?=
 =?utf-8?B?YmlJWG52OFhTRW1wOW9zZkFNMDR5MEFyYWJhY0pwMmwyUlNDVVVGS3JvV24v?=
 =?utf-8?B?N2kwTHFpN3pNZGhLOXVERS9wbzNUV3E1TjRaUDVRbnMzNFRRcWs4V3NDSXRm?=
 =?utf-8?B?eWRsemRLaWNmcG9zMUdITTdJU1pYZzJBSngvbm5wZXp0VmExOGYrSlJUVXZX?=
 =?utf-8?B?Z1kxczdGalpBMnhTVm5McXB2dlFOTmw0czcwQjNUaCtNdThHVFpSZVB0SnZR?=
 =?utf-8?B?UGxiejR2YklXTHhPK0dxUzFZNndMQVF5NStWclYxTy9VeHdzRTFPbG53eERx?=
 =?utf-8?B?YUFCdnJwMHEvTXhKUHh4ZVRNSTR5VEdHMXRKcjRwL2VKdlRneE1mRGFWODNC?=
 =?utf-8?B?eFhXRmFibHhRN0VTWnZVMTVna25TdEtHUXlGWGJhODNDNE02L1NJTlJGYWYx?=
 =?utf-8?B?eWRNZ1JZNjRpVWRXNEswK0hvbGQ3aE5FTmNpMVFoRUlYNXdDNkx1YjUyQjJy?=
 =?utf-8?B?RXBMeS85WVM3WW9KZVBqd0J1LzVIRjNmdjQ5TzN6cW1JMFVnaWY3MjNGWCtN?=
 =?utf-8?B?cjR0Mk52VUt6N1YyUks1NG9HdG5zZFc1Z3VJMmRFcHM0clZJZmU5YnlQU2dq?=
 =?utf-8?B?S2lKVFhkVTh1dDROV1U4Q014L0ZVMmhjUkFrWnVwN1plODlSRTZvejZMaDM3?=
 =?utf-8?B?N1Fuc3YzaUhXRTRFWGxOeWtkTy9LM3g2T0NYeXI2Q1drd3crSmtLbnV5cGc0?=
 =?utf-8?B?NEk2RGh0L1hRa1Z5MlkxZ004TEdGWG50VFVITDNaRlphd1RPbkY5R01IbXZj?=
 =?utf-8?B?OHA2QWUxQi9Pc2xwVWZaSjRyVFNqSnc5M0pIeTRUWGFqanZvV2x5b2JvVi9s?=
 =?utf-8?B?L2pnN3hURjE3MldrSVRBdytJdi84Z3VMNlNqOS96VUxnVEkzYk9oZFI0QUpV?=
 =?utf-8?B?b2JtcnNTYjl4M1NxOEp2U3ZmQ0lSSDVRMXpHUEJOR2NYWm5OdnpzbCtDU3J6?=
 =?utf-8?B?MkhNRDNpSUwyVE84TUdFUDhSL2htK0h3WlZGdDZuVStiYlk3emhYSGhKeUJ3?=
 =?utf-8?B?cDJtSjFLSXd4V3E4QzBjSUk0SUl5SGVSeG5jM3VxQkJzaHNpYVV1UnRqdEhL?=
 =?utf-8?B?dTcrSG1BYXlSZ3hoN2pzK0hoYlpRT0o3ekxMLzBnZ1dBd3lPNElDRHhPVHZB?=
 =?utf-8?B?NWdnbzVHVlRvUFFTc0VEZnRmR2ZhQ3J6NHdSQnlhV0QrMnJmcE1USW03OVlJ?=
 =?utf-8?B?bmZlZytsY3l2WFB2VEJFMXUxTjM2YThReC84bGdVZEZaWFBKWXF4RVd5ckh5?=
 =?utf-8?B?QWE0Qlo1RmtFalkzdG9VVThicEowaVRHRUdkWE44ckFIQkNqdlZ1ckJ5U3Zy?=
 =?utf-8?B?ZFlIeUUvbE9vZG5RTlNVV0xxeTlGQ2dNaVJWMnI5QllVQStqK3VXaHh0c1Zm?=
 =?utf-8?B?Vk8xc05QSmdxU0tOVFp4bjIwSmUxWHJrR3gwZ2FIZzhGUEs5TGU3LzJBeHFH?=
 =?utf-8?B?dkNkTW5QOGc3LzJ5U3ZXTXVpdXI2b3p1UVE2WGV5aVBZejE3YmVYMGMxcTZE?=
 =?utf-8?B?UFpIWmY3NEhJK2NYOERCQWM5YlF1RU1Nc016QlQydEd4QWYyL1Vab0N5a015?=
 =?utf-8?B?T1ltVDhtZlF3RWtRbDlzZlNMeHR5djc3VkJKSHlKQ2Jvc2JWTk0ydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29f939a-95e1-43bd-4d99-08df25775bee
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 20:04:28.5389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QK+KvR5wDCL3Ob1q72H7TmpTUve2q1CrIjfQja+6emoUHiNwvnOpc9kQ0EHXyPMaG7YpzIi2oghaL/OYRCskw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254



On 10/8/26 12:37, Ilpo Järvinen wrote:
> On Mon, 21 Sep 2026 16:26:09 +0800, Guangshuo Li wrote:
> 
>> amd_hfi_init() registers the HFI platform device before registering
>> the platform driver. If platform_driver_register() fails, the function
>> returns the error without unregistering the already registered platform
>> device.
>>
>> Since the failed init path does not run amd_hfi_exit(), the platform
>> device remains registered and its reference is never dropped, preventing
>> the associated platform object from being released.
>>
>> [...]
> 
> Thank you for your contribution, it has been applied to my local
> review-ilpo-next branch. Note it will show up in the public
> platform-drivers-x86/review-ilpo-next branch only once I've pushed my
> local branch there, which might take a while.
> 
> FYI [if applicable to your patch], as per Linus' policy change, also
> fixes are mostly routed through for-next unless the fix is for a
> commit introduced in the most recent cycle or is clearly a regression
> fix.
> 
> The list of commits applied:
> [1/1] platform/x86/amd/hfi: fix platform device leak on init failure
>        commit: a15d58ff15a6ede327e3814c791c6912b973e434
> 
> --
>   i.

Hi Ilpo,

Did you see my follow up comment that this patch should be unnecessary?

https://lore.kernel.org/platform-driver-x86/652e3b3b-0f56-4d01-8fd8-e4a9ddedabfe@kernel.org/

Basically pointless call torn out by this series:

https://lore.kernel.org/platform-driver-x86/20260921170411.1149960-1-mario.limonciello@amd.com/
