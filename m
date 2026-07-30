Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEC5429008
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414918; cv=fail; b=ajqiLP/ICc77383obDKOCM5ze2h6RM+wetXCL0OFhaBwrVeWmEYmm1lARmAfvLxeKzAvDyvlZtfYadqVmnWbGVCNybUsCRr7fe5QbJ8qM/ZA5cOKR5UuFptup+ByBnYJbwVXYCh+ratdeCAqL5WNQs4Wc09V8pwQheLZ+onZrw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414918; c=relaxed/simple;
	bh=lgswxLCYTieEkyg3iEg5yPqs5cSTZMrNHGFEAnXXp3E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I8q3GEbMN1uBbIBh+HLJ3vLq/5wUlqX64PQ34uDb3adPnNAVm/8TTH1QrAurx2qxrUADbjlRpJv070e/m78/0WzkRbu4DfBKK2N9DWgnOvVgQ35qEDgVOozF0ehcdIATRW5m/d/36+Sq/gi3Iu7bhvaKlq04rU4rnpjOmgEWiqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ExPs4MCn; arc=fail smtp.client-ip=40.93.195.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ExPs4MCn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1f0NCERUKxN4zTPqY8Vp4upzkq6ixiQRJTIHaPtujBnDZmPf4iYMad0PknfoG89X3CRqDlRXWh0/41EY6ydtzNzX/jNXez8a95Gk6QoXxKosEbDiosZkpC6F/3Yk94u3z3cP4QCrHmY/RQ+Au4VepWRQxkXDIuxZbPD0ummH9GdqluKCBZRkjn+3vGUIzam+XJhiQLDiZJybTIjoMzqYrR/6PNE79wNv05SDSIDoHDZsf2pfUGCbIGl/8OVEjCgW5fkk2YHSGtmrnN6wGzwlg1fSeHZ8p33CnUlTURF5DfejI1k0IwInt9tM+T9lJwOt8ehMiJ6ho7VjY1LNdGojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSswp5kbNK/tGjMn8DSbN7tyepQSBO+5C1PcF7M40Dc=;
 b=P9fKZZ2/8wjUfXuJjFz+4YoHlnnZRGm4k3OI1wt4ouTIvU/22B/NZa2vptQVKsg0qMF3XiQ6gQBYWFzg3IqLy7qrfiDGwKVbPZVkRfs2HeoblPe54mWCDDCRjVJU6Zjqz25xJAzl40/J7aAvBb2POr/2FDtESJ7BI6EMhO+Px/UYBpziq+rezKSWe0QbPQVlv3Bj6pu5xsakueKmbfmFgOz6BPxcNyGHVw0miKNJRko9GWkG7egAvGAodnYw1hWIbENPxsWHgxCLUgoVTIv4aUShyQ4gScsb+FbHh5vvSImbXaq1Ui5yW481IsTJvYE6416Rh/pppqLfShrEH9VsWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSswp5kbNK/tGjMn8DSbN7tyepQSBO+5C1PcF7M40Dc=;
 b=ExPs4MCnmBTVdDJmJqIq8xcXmUuWNhxlzMbAMZKNV0WUdyHhRZ9yb0ur9XHDWBs1qhwfdA9OhiKKxEFYxe+GLRN3H6nyCOtFzdxJgc+lKaGSxXn9p4Vi4wqg7GybLHMQBf6Bi3SrRGtYgpF2V14AGz+6vnOZx4tz+ejKJH9JOxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 12:35:12 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%3]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 12:35:12 +0000
Message-ID: <69043022-b215-43f4-87ff-71c52d999021@amd.com>
Date: Thu, 30 Jul 2026 18:05:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Fix lockdep false positive in
 amdgpu_lockdep_init
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
References: <20260723221910.85822-1-vitaly.prosyak@amd.com>
 <20260723221910.85822-3-vitaly.prosyak@amd.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20260723221910.85822-3-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0315.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21a::16) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 347ab4b7-b1d3-432a-f85e-08deee36ffa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|56012099006|4143699003|5023799004|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rnQO92ftLw2aYwIWWYJh5NiI4Qq+LFyuE/rdoPMLX6opYceGTk5QuKgcyn/CkvGHr253zVwZkdUmDwIS5pIceaeu/d7bMzPajHo3Yet+0ZOQM5fb6b6oBpQm5IuG2se9TnPnSHYS57DEYj10ECnsE/4OMVMfzj0ftBZsvPMo/eQlsFzL/5LdmBdPJOh+obko+4mRMpyEYa6F9FC2S+PsTHR8Mf5nsWOG0BlgUaYJ8UAfH7Fn0Mvxp/9u7LGpE7j95G/WSsXItl1F8Q7CoGB3YBfA7nRjSYnmEXi5Cnb7nYLexCwFuw1FdfB79xskCVAAHYI0Dpg4kDuT481CHqE81wXA5E82qcZ4SWA8pl8S7Qy0BlO3jI5C7vavpP2pNOaUjyUjTI9CnjzUk04Y9KN1PA5QzuJGphGqBrvZTQADiSAYp/D1jBPdLVYm7V5zRCKD0L+ocVUOePx6L480xfeAyBuqNK0zYw0riMs4oLH3SW6fomVYfCLqo+N0/c5DpwoIWqAlgzqTAzUeVR0kRMAJ4d7oa0leDKrgnUHGgPWvDq6b3Zkk757+6/FGTbB07QUbTpJq6hKk0XKa1aH5RgUE+nmCY+ifo0CZidgd/EXG62KJgkyvptrpsh2O5yJ8/+FaoSHP8EgisSrGGPi+Jctr78RQ2fHMEnDHTsI7jsNJbog=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5039.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(56012099006)(4143699003)(5023799004)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFV2UzkwdStDSGp0L3N4dERydXhwRjEzZ29TQmM4L3E2cHYwSmdDSjZPekth?=
 =?utf-8?B?RDVBQXJsL3dqZ3FPTUt6VW1SNlV3ajNCb2FISTN3T0tralA2U1hoY3diMU50?=
 =?utf-8?B?R1M1amdIVks2NVdxRWE4WE91TjkzWmNHeVduY1h6L0ZiK2hibHA5YThtSG1U?=
 =?utf-8?B?RGlqMFpkU1hlQk9Scit5RmZ6UzVScmZmUmFMUGFEWkY1djhtbGUxdmRQeHE1?=
 =?utf-8?B?VDBxN1U1ZTRodjRWdjhjYTVCMzZDelpKL2JKTlNaU2t4TnJtRjFYRjJpZWJV?=
 =?utf-8?B?VXhDNHU5Q3B4MW1QenM0cGVNY0lQUmFnRGlZSHlrQXpwaHFtcElJb3RQZnNm?=
 =?utf-8?B?V2JNREYrUnJROTFsUjRBSEtJZUpEenh3R0VFaGxESC9WQTJwcG5JelpjbUpy?=
 =?utf-8?B?N2dVeHRnR0pMbmY4QlZRWWQyNTFrb1ZXSUtUUTdCcXhYMm9iQllmRlpTV1k5?=
 =?utf-8?B?V0prWjdPT0JjYUJGMnMzUDU3bEo1THlETCs2TTVUMGhzb3lFK2Rpb0hCNUUy?=
 =?utf-8?B?TWIrL05ybnlwOUJ5NC9lVmdKMWZqZzNtSG93cG9TU3phaHRHcStHanBGSTlo?=
 =?utf-8?B?QlI5YzNRMTlpRFR5d01ISFVxc3ZURldWZ1QzcTZhNnluQ011QTZmVmNRdklJ?=
 =?utf-8?B?MDhlY01rYWc3QkZHaFZLVzFrQmtFSTRxakNHL2hzbENaV0w0TWU0M0cySHFS?=
 =?utf-8?B?RlJtVGJPYXM1Z3JUQmphT1k4S01RdjRXTHgvRU9XUUdId1RJNjlCdFNSVEdv?=
 =?utf-8?B?RVI1MG1UN05nQTJwdXdNY2FvK3Q0TGdRSmtOb3pBbFZodTRCVHpmc0V6VmJu?=
 =?utf-8?B?TUVsSGQ0VU5EcnVTQno5S2Zsa0hxaUgxQkRQT09QbEhjeHJ2REdTQ0hocm1T?=
 =?utf-8?B?MkNvWFpaQWlwZElmV0wzR2FmRDU5SUR1bG5uWHdvcndkRVFhZXRRbkh3ZFBT?=
 =?utf-8?B?U0pROEE5cFdKMnpFa1UyMGpZdW91bGRzbUMzc0lQL0Z1M1JvMUdERGpVQjNo?=
 =?utf-8?B?UXBWNmo0d1hsUmZ6V2pKWFpuZ3luOTAwS3lHV3BKL2hLYjJiTDN4VDV6Ykxp?=
 =?utf-8?B?NWNMVDlGN1JZcTlCT09uaW55SHMreFNXZTRyNDBtU05YMzA0RkFzT3NWOTFR?=
 =?utf-8?B?QjhhTG9SV0o5cDhCTEx1dTFCbGo4T0I4empmZEhQOUc0b0xQR0JqQ3FzdUF3?=
 =?utf-8?B?VG81R0FKd2oraUVIMk1oK21qNjNxcisxL2o1NFh2dng1ZkpwTFIrb0k1bXBN?=
 =?utf-8?B?MlBYUUVmNDQ5L20rSll3SzZ6Mk5HK0VKbEY3SjNuRzNSQmMxYmZuRFBQRG1C?=
 =?utf-8?B?TnpXcW4rbHU4QjhtN01EOVIwd1U3L3BPT2M0ZkRWaEJnSzRJdFArcDJDUW8r?=
 =?utf-8?B?NUpyZndZU0VDeDB3a0NRQy92bjNmUVZlM25XT1ZZWG1JaStKYzFQVHRmRHlF?=
 =?utf-8?B?UUxXQWpYby9OZFFWZktSR1hhYVdXRUhYTEczTHE1ZC9INk51dmVjS3pscUVR?=
 =?utf-8?B?eVYyQzBEakd4UW9YNGZsbVdjQ0NXWDlZVjhUZXRYdzhpRUJUTVFSWHhVZnF0?=
 =?utf-8?B?OE5LUC91OFZNU3N2ckozbEppWXNPVkprQ3d2czBad2xsaGdtdkJLWlZLeVJT?=
 =?utf-8?B?Q0VmNVNQYmFZTWtGelJlMERHczFucHZiR0lwQ2tMcElUd09XdEk0ZDNaTDhr?=
 =?utf-8?B?M0VFM3l4MGJYVVFVajNLV3FuYkhnSkhiOUxqU3NlZmk2dTA4cXdNQXRiZVkz?=
 =?utf-8?B?SDd4OVRxNDBUdEpSZ2xQbHo3M2ZHZ2dwV29zWkt1YWNtSGx5cG5Qd3JTODRM?=
 =?utf-8?B?M2o1bUcwdVp5VnNsZWpWWkt5aktHUUVEK3ZLc041OVFEOGQwdjBVQmlBeUVI?=
 =?utf-8?B?cHBuYjU5S2Nud1Z1eDlkalVNZnhDUXN1U1dSb3AvMWdXUElEUDl0dXI1Z09L?=
 =?utf-8?B?enk0S0hLRjgyWkxLSWlTeWRQNTF5K0JSUEJkRllYWnFaNWlrdi9pM1IwRVR2?=
 =?utf-8?B?OStPcnRjL01lUlVYQ3dsOGFVR0dzK3J1Q3FKSHFHaHFtS0xYeXVlUThDalpH?=
 =?utf-8?B?c2Z2Wjg3SWw1UTdMTytLeDloNW55anBWL2xteUR5QXdkN1lpWFNaM0RyWU44?=
 =?utf-8?B?SUl0c0pYNTFrR3g0VTNGRzdFdkE4TklET0RmSWdzQWpyRVZodmlWTGJqb2FO?=
 =?utf-8?B?V2srcDhETzBROTZsYWsrVHBYQXQ0UDR2NEZLYytKV0tKaHE0SCtTRnJ1VlRh?=
 =?utf-8?B?emQzcW5oWTJHYW1FZUNHVEw4NHZmd3J2M2kzRlVseVJObkZjTzJkZEl6S2s1?=
 =?utf-8?B?S3Arak5xSFc3ZURqNk5mZlJwU1BQR3RPUWt0bkVjcjBTNllUK2VCZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 347ab4b7-b1d3-432a-f85e-08deee36ffa3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 12:35:12.1078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbbPwUL2/9b2/sid6cSuNb+Cgf4B6SJfO8XDWuQ7mMMNEPaRV9WNjpA0TBr/jGeDcX7V1mnma7YZScQ2QJH/4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354



On 7/24/2026 3:48 AM, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> Move fs_reclaim_acquire() to before all lock acquisitions to eliminate
> false positive circular locking dependency warning.
>
> This is a 7.2-cycle regression fix suitable for stable backport.
>
> v3: Address Mikhail Gavrilov technical review:
>      - Clarify that fs_reclaim_acquire/release pair only REGISTERS the
>        fs_reclaim lock class, does NOT create a static edge when called
>        with no locks held
>      - Explain that the actual fs_reclaim -> notifier_lock edge is
>        established at runtime during memory reclaim -> MMU notifier path
>      - Add Cc: Arunpravin PaneerSelvam
>
> v2: Address Mikhail Gavrilov review feedback:
>      - Fix author name: Michael -> Mikhail Gavrilov in all trailers
>      - Add Fixes: tag to link regression to original commit
>      - Add Tested-by: Mikhail Gavrilov (tested on RX 7900 XTX)
>
> Fixes: 1d0f5838b126 ("drm/amdgpu: Add lockdep annotations for lock ordering validation")
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Analyzed-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Test-case-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Tested-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Arunpravin PaneerSelvam <Arunpravin.PaneerSelvam@amd.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Change-Id: I3f1a19877615cefc2e5d7c063144a6404a96ba38
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> index b251350b1fb2..5f1f1960ef72 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> @@ -151,6 +151,20 @@ int amdgpu_lockdep_init(void)
>   	 * This establishes the dependency chain.
>   	 */
>   
> +	/*
> +	 * Register fs_reclaim lock class FIRST, before taking any locks.
> +	 *
> +	 * This acquire/release pair does NOT create a static lockdep edge
> +	 * (no locks are held between acquire and release). It only registers
> +	 * the fs_reclaim lock class with lockdep.
> +	 *
> +	 * The actual fs_reclaim -> notifier_lock dependency is established at
> +	 * RUNTIME when memory reclaim invokes MMU notifiers:
> +	 *   fs_reclaim (held by reclaim) -> notifier_lock (acquired in callback)
> +	 */
> +	fs_reclaim_acquire(GFP_KERNEL);
> +	fs_reclaim_release(GFP_KERNEL);
The fs_reclaim class is already registered by the core kernel on the 
first GFP_KERNEL allocation,
well before amdgpu_lockdep_init() runs. Is it kept on purpose, or can it 
be dropped?.

Otherwise:
Acked-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> +
>   	/* Level 1: Global userq scheduler mutex (outermost) */
>   	mutex_lock(&locks->userq_sch_mutex);
>   
> @@ -168,12 +182,6 @@ int amdgpu_lockdep_init(void)
>   
>   	/* Level 7: DRM file list mutex */
>   	mutex_lock(&locks->filelist_mutex);
> -	/*
> -	 * Mark potential memory reclaim boundary.
> -	 * GPU operations might trigger memory allocation/reclaim.
> -	 */
> -	fs_reclaim_acquire(GFP_KERNEL);
> -
>   	/* Level 8: SRBM register access */
>   	mutex_lock(&locks->srbm_mutex);
>   	/* Level 9: GRBM index access */
> @@ -190,7 +198,6 @@ int amdgpu_lockdep_init(void)
>   	spin_unlock_irqrestore(&locks->mmio_idx_lock, flags);
>   	mutex_unlock(&locks->grbm_idx_mutex);
>   	mutex_unlock(&locks->srbm_mutex);
> -	fs_reclaim_release(GFP_KERNEL);
>   
>   	mutex_unlock(&locks->filelist_mutex);
>   	mutex_unlock(&locks->reset_lock);

