Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617B43815F3;
	Fri, 16 Oct 2026 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792180933; cv=fail; b=QtbkoxWGGabqEqkNzR9HiEyYYVVQxmrSpPKnYSZPjH0fbw389QxgUO3HaDwV+7ocTPyKkdYxO5X/Z+0ZZ+8tVeMMjGjfD1W32Y48pOxBa8ARH6UQxGxUdx6yUcK8Eo5si9LZho0FjyRhToPnCXfAwHatYCqM+RtogkhvRE4Xiwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792180933; c=relaxed/simple;
	bh=V3ZrujkJ44TnLSadLN9sdsHX0UqBx7MoRD6ER7GsOVw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qaK/24GCqA2kcVYgW59WcJwEHkvclcNp4NTfkC07erJ3wBV7snNhgSFqXGj2ju4ogU2dS8aqezcl9eRduafw6OeC2rMeQAUyUAA2CkhqSijv2t4OKOpuTNIBR+F3RH1nvFiyPkbUmbA6saiV2ZpS4a9OVa4enBT6KYUax2snfoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hou7cFKp; arc=fail smtp.client-ip=52.101.52.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hou7cFKp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiQuUMT3VCqvNwT2qmNLOLmrpI2cfOIuLSvGkeUi/BNAOPOmsZXsy1LniB1oG3+jX4I3AtNHd0LFaPC8g3+snGkPO1f0WA3bizGa24StozIq31yLMq32kd2QbdUkcMNgha+jpMXJMn+8TxusBzO+MoD9aHBHLmv1U4j91CSrPN8dGPko7nKzTJQQ3mC6q/uc6U2+YIVLeLjHit8ShK9/syUxQwc1YT4ZliOnLGotbGN8Kiss+D+u6Is44RM3Lk2K7JMfvd7XmLB/2bWX1b5WRVmFEbAw7HdWZck/iuZnkV1w64B4l85GHAG9QOQdUnd9Pit/OORSFtkyvj9JCKhGvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pYf0ZvwtWM88hfbJ+5slFC/S5xnE/laWPu8Nv4TKLs=;
 b=xpLxzpwqNAhPvsdMnJWwcaHz5vH+QADdHy5PUTMT7Wjxwe1dFDOnSpkgCWZq6kjF0BvaM95sUcwo11X9wskh01EWXefJ1wwPsceO7Od66NKysPNafW4ZbN2+Qf9KYjDyYZtLU7VB1DV07BORCXvzs26fOMbjXBmIm21gr90PHm9Txzbt5C4otFi51c1OME25yGP/7DsY8T1MN7wTvxvvTUmCi26s+mvilt+xkgEdEcvSK0Pf5PgqJ6vaCaZmvQIvxOBIiJSitMuaXXI9p/aRFYWgUf5GuGInP1CWK32Ntd7fsi6UqH19NotOwn81pMEKKA5D78cQPEOJ8hn5ZJpR6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pYf0ZvwtWM88hfbJ+5slFC/S5xnE/laWPu8Nv4TKLs=;
 b=hou7cFKp7FdCFZVXusTSpf9zzd5xyuHTeLmppb1E2YNkM/Q/rxZa9OoG5RDN59resvrHUkwpzOHpmDO7k0N1bgO7jokMNBSATjZXRsnGcW5Slj6JHwda4J4fKKsbk2ZAvdf4xb/r6qLItpBHouw0hvdGobU3gRh234+GGYaxbng=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by CC6PR12MB259526.namprd12.prod.outlook.com
 (2603:10b6:170:209::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 20:02:08 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054%6]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 20:02:08 +0000
Message-ID: <48db6848-50a9-42f1-81cb-fd4c7e726671@amd.com>
Date: Fri, 16 Oct 2026 16:02:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: disable SVM when the GPUVM cannot cover CPU
 addresses
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Huang <danielhu@amd.com>, alexander.deucher@amd.com
Cc: alex.sierra@amd.com, Philip.Yang@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261016145129.69645-1-danielhu@amd.com>
 <8a0a2d4b-ee31-48f6-8a44-d5a7d4af579b@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <8a0a2d4b-ee31-48f6-8a44-d5a7d4af579b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0327.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::12) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|CC6PR12MB259526:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ed6357-9e35-418b-af06-08df2bc05b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|22082099003|10067099003|3023799007|18002099003|4143699003|11063799006|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	E4jlNeM8cKEtw8kvr153q7GwZlcv2YYQsUsNMMmZEKHgBJpierlUFSozwsQZ4sLkJsn3+lhF80NFbTm0j61k+1l52w/yK00WS4oIdj5EBjetz46C9xsIlK9Vrhib6XN42gw5+PoXjlfvG+3sIWmT9U+RyFg3Ij/0VH4F6Cw5nYIfm3kZgti9dFoBZ0cq7wVCARnChjNBDafnlQNfKwPZEETPX7X9Xq9Sq8jZo+fTGvrXyTX9vWAareVOviDwt+WQnW3o5VbKX0pIh7YDf+9+WwizAWDDnYvXsYNMmEBE+DVTTMozz0W0gA736mUycZ//J3/28enrzx+kI/Dh1MCzVSHKu3hhEZOGkwe7SaTT46w7UCulhfblE/xRCit+iqW0Qc67cLPGZLTtd3Fii41QiAv93YSZ4se50rvtpK3C7Qj2a00qnCS8R9h91Wp0QoGhxATXVez57jiJ3hQRyHYfIMHwrdUfYse4YOqTf5k8CIB/VDdkje5gEUwqOxuwMV/CWmsiiYOh6Ui927GAxN+mliWUivJHfeu4ghZ2OnZ3RrSF7lQFDq519pIDmsXJcupHdyw0APlMRNgneeeSpmWOxCCQIA8911C8ncIzdt4In5sQiI4TyJQP9BHh/nafgdiw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF78FC67EBA.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(22082099003)(10067099003)(3023799007)(18002099003)(4143699003)(11063799006)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjBzUXlROXNsVTdFNTJzWTVBczdELzBsV1VLV3N1UW8rYUdzY3NZYkVjemwy?=
 =?utf-8?B?UnU2VFNxMWhxdG4zV2t1a3F1c096dVU2TXE5ZlN4KzcxZWtyek9ybHcrMlht?=
 =?utf-8?B?OWRIZVNrbE9vWExCSUM1WmVKdkhnYjJ5cVFRaHVMYjU4YnJkb2h5eFJGdFor?=
 =?utf-8?B?Y0VwOXB2c1JGSFJVZmQyL09LZnVQbUUxN3l6MG1IdlpyaTVjUEQvWE1GVVJK?=
 =?utf-8?B?M2J2NG1XNkcrb2k5K01kRWVldzgzMWpjY2pRUGVxbHZhc0QyWlViZEN3VHRB?=
 =?utf-8?B?NXRWeVlnVExPZ1Vjd2w4YVlmc0ROL2pwelpOZ2V6UE9PaWpjRUJOT1VKUmFh?=
 =?utf-8?B?VDNreTcxWXNKbERoUTh6TnJTSXBNSnlCaDU0aGxUUUI4cTBrNTdmSkM4Qmw1?=
 =?utf-8?B?amxxZlYwUGExVXBiMFJ6eUJrSk85NmVtK24yVzZGcW1FeTl2YTBwOEJlNWpL?=
 =?utf-8?B?SWQ4aUNsM3N1bkdjQnEvaW0ycUJ2STBTbk5IdzN2ZlRXWmFDMG9QcjZ2a1Vy?=
 =?utf-8?B?QUJyVWJtdHFwWVVoR1dOTGIwRzErNCtRUnV4M204YWxNdnRQUDY4T2xobERp?=
 =?utf-8?B?V1d5dnhBZ2NaRFNZK09HNzlQOXZSWUpaU1gvZVJSRjJEaHcySE94alNMaUJ2?=
 =?utf-8?B?eXRjL3d1YkhNUkhLTXNod1Nub3BLOCswTm8zVTZFN2R2aHZOVHkxRml1WHN0?=
 =?utf-8?B?dXlNalNDdWxBazlNUk1rTFppZ2xpTndGZ3VBRW4yNEVJRFBRVWVBTHpTLy93?=
 =?utf-8?B?S0J3SHlhQ3I0OWg4YlNETVUrY3IwcGgyTGtXaC9YMlprYkltTi9meTZhWEFP?=
 =?utf-8?B?Q1gwcmIzNmlZY0lLSW9xcnM2cWlZZGgyNi95ZWpqTnFlZ1JmTXpabVk3S1VQ?=
 =?utf-8?B?Z1lrQ0o5djhnNXlIbmw3Z01HRm5ybDc5MG9WL1I3SlBXNmY4L01HemllU1JS?=
 =?utf-8?B?UkdndFRlWmNwdGRMaVE1VXBSUmt5L0s5RmcyemM1aldiRm1FYkFNbHBDZ2h1?=
 =?utf-8?B?MElrTUZPazV2c1BzSmlpU3owcHFRL2ZuL2hiaFVhcGtObVBlMHI1TDc1UElL?=
 =?utf-8?B?T2lnZS9DWUZ4eENoNmNxMEowaEhOWEJVdHJXZmJsYWxncllpcXhqSnFvaURm?=
 =?utf-8?B?VHh0c3lya2VybjdWTGZmeXhNR0JvcmRxVGlQb1pLVitqaGFXOGduRmpxdVFE?=
 =?utf-8?B?MW9odldXYXIzUHFUSk5QSERJR3RmSmpKak9GZzBkenQ2STlzV0FsRmVIRG9W?=
 =?utf-8?B?eUZuanBGNndkSHI0RWFZQktRL2graUJINFVmbS9ZWXpkalJ1ajA2ejhXVENW?=
 =?utf-8?B?aXBUa0txY1hteDB4V2NJc0p6dW0yM2dURDcvcnhQUCtBQjhYZ0MvKzNJMDBV?=
 =?utf-8?B?LzArSVo5Ylp5MGkzc0dVeUx3Uk5CdnJYWWFpOFk3UTRvSWUybXFxZWs1bUxD?=
 =?utf-8?B?UnlKRGk1bmMxQnl5aktNMUR3ZXo0azNsT2NnY3ZGa1FqeFdQd0ZPMk9jamNo?=
 =?utf-8?B?V0tRZTM3RHdOTE1RWG9iKzl5Y094MTliWTA0bWlDWW0wMlFVekZxVzBmTWdx?=
 =?utf-8?B?VlFnbGRpekNpUjZ4OGFMOWhCbU1LWE1GWDRXTTJpSG5Sc0lmZ3BiVVA4YU5B?=
 =?utf-8?B?SWgrdEIrc1Y4VlEreS9wckhyRnBtNG1kRFRkMjRwOXBwNGUrZklZcXFVdmlK?=
 =?utf-8?B?L0dOcVVnUHZzaFpxN0NXOTV1Z2dYZXphaVk3dFFPcVl1WWRoWGFBWkp2a2pt?=
 =?utf-8?B?NE1RdEphYW5XKzRmNkk2UzBPdlZaV24vdEJUTGVWQmxmLzcyR2dOZ0M5NU1o?=
 =?utf-8?B?SU96ZmlUV04wc1NaVUNnSDdPL1VsdjhoOXhBajhCNW5xNEFiUzErVWhuK1dO?=
 =?utf-8?B?eWdBQ0FIdjA1ckhKcEFRTUl4L1pVdkQvdlZHRVc3NkwzVzdKK2VZWU8yMlhj?=
 =?utf-8?B?Y3JQMHhteHBIdlExN2Z5a0RRbnZSYzJja2F1aXVQZEZhL09KVTlhaWF3S3Zn?=
 =?utf-8?B?MkVCc29jSEc1cVo5dUU1UlhSVXhuMkd0S1RvYTI4L1pXNkZUTFgvZU4rclQ5?=
 =?utf-8?B?MWhyaXFLeWNJLzV6WkZ5OFdRQmV3eG1Md1Boeis0RnJ2Y2IvQk5QVmJDQjhE?=
 =?utf-8?B?VVdQUU9XTzYvZnJLUjVjOExBeTBNa2RLa01ldFZDaDBWb0RyVkM1bHVyTWp6?=
 =?utf-8?B?aDlraFNmL3c5all6djFrbk16cmQydzNMWUxEYXdWMjRvemt0NHR1WHJ2VklU?=
 =?utf-8?B?VUJDQ1EwaDd0Y2l2bXM4MjNwSlFBVmpVbUNRSmZNZzNZQnlXVzIvbFNIRjUx?=
 =?utf-8?B?cmcrenB1WjdTYVpGUmtSbWNYQmtlNGtyUEIvTk1lNzBBWXVnQzZaQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ed6357-9e35-418b-af06-08df2bc05b98
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 20:02:08.2982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24oLlB8x+BoaCRwlMVNhWy8uKkkcy74OIFC+VjRxtHlr0U23LXxibxejqLNm7Dz1txWdyp/+8Lqk5bNXtjctzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR12MB259526

On 2026-10-16 05:09, Christian König wrote:
> On 10/16/26 16:51, Daniel Huang wrote:
>> KFD SVM maps memory in GPUVM at the same virtual address used by
>> the CPU. However, svm_range_map_to_gpu() passes the corresponding
>> PFNs to amdgpu_vm_update_range() without checking them against
>> vm_manager.max_pfn.
>>
>> If the GPUVM address range is smaller than the CPU address range,
>> the page-table walker can index beyond the allocated root page-table
>> entries. Unlike the SVM path, the BO mapping path validates the
>> address range through amdgpu_vm_verify_parameters().
>>
>> An explicit amdgpu.vm_size override can trigger this condition by
>> configuring a smaller GPUVM than the driver would normally select.
>>
>> Reproduced on a Radeon 780M (gfx1103) with amdgpu.vm_size=64.
>> Repeated hipMallocManaged() allocations attempted to map CPU
>> address 0x74bd48000000, well beyond the 64 GiB GPUVM limit.
>> The out-of-bounds root entry contained SLUB poison with
>> slub_debug=FZPU and recycled heap data without it, resulting in
>> a general protection fault:
>>
>>    RIP: 0010:amdgpu_vm_cpu_update+0x2f/0x140 [amdgpu]
>>     amdgpu_vm_pte_update_flags+0xfa/0x1e0 [amdgpu]
>>     amdgpu_vm_ptes_update+0x38b/0xa00 [amdgpu]
>>     amdgpu_vm_update_range+0x279/0x930 [amdgpu]
>>     svm_range_map_to_gpu+0x13d/0x400 [amdgpu]
>>     svm_range_validate_and_map+0x8d3/0xaa0 [amdgpu]
>>     svm_ioctl+0x66/0x80 [amdgpu]
>>     kfd_ioctl+0x40a/0x650 [amdgpu]
>>
>> As discussed in [1], rejecting out-of-range PFNs in
>> amdgpu_vm_update_range() is too late. SVM must not be initialized
>> when the GPUVM cannot represent the required CPU addresses.
>>
>> Prevent this by disabling KFD SVM support when the GPUVM address
>> range is smaller than AMDGPU_GMC_HOLE_START. This prevents
>> affected devices from advertising SVM support and excludes them
>> from SVM mappings. Warn from kfd_update_svm_support_properties(),
>> which runs after the device memory pgmap is registered, so that
>> only devices that would otherwise have advertised SVM report the
>> loss of the capability.
>>
>> [1] https://lore.kernel.org/amd-gfx/da43b0e3-5bd9-4aa1-86d3-b733f3bad108@amd.com/
>>
>> Fixes: f80fe9d3c114 ("drm/amdkfd: map svm range to GPUs")
>> Closes: https://github.com/ROCm/legacy-rocm-build/issues/6691
>> Cc: stable@vger.kernel.org
> I think we should drop the Fixes and CC stable tag, that is not really a bug fix.
>
>> Signed-off-by: Daniel Huang <danielhu@amd.com>
>> ---
>>
>> Tested on a Radeon 780M (gfx1103, PCI 1002:15bf), kernel
>> 7.0.0-38-generic, and ROCm 7.13.0-2.
>>
>> The reproducer performs 24 iterations of hipMallocManaged(1 GiB),
>> hipMemset(), and hipFree() per run, with 40 runs per attempt.
>>
>> With amdgpu.vm_size=64:
>> - Stock module: kernel Oops within approximately 2 seconds on
>>    every attempt.
>> - Patched module: completed 40/40 runs in two attempts, with
>>    stock and patched modules tested alternately on the same kernel.
>>
>> With the default GPUVM size, the patched module preserved SVM
>> support, emitted no warning, and completed the same test.
>>
>> Two questions for maintainers:
>>
>> 1. I interpreted "SVM must fail to initialize" as disabling
>>     the SVM capability for affected devices rather than failing
>>     KFD initialization or rejecting the vm_size override.
>>     Would a different approach be preferable?
> I think that this is ok.
>
> The amdgpu.vm_size override is only for driver testing and not something end users are supposed to change in any way.
>
> So that here is actually a really minor issue.
>
>> 2. This check also affects GMC v6/v7/v8, whose GPUVM address
>>     ranges cannot reach AMDGPU_GMC_HOLE_START. Although these
>>     devices do not register device-private memory, an APU with
>>     apu_prefer_gtt can currently advertise SVM support.
>>
>>     Should the check apply to these devices as well, or should
>>     it be limited to explicitly configured amdgpu.vm_size
>>     overrides?
> So we still support GMC v6/v7/v8 with KFD? I think we have dropped that a while ago.

KFD SVM is not (and never was)  supported on GPUs before GFXv9.

Regards,
   Felix


>
> If we still support this then that would indeed be problematic.
>
> Regards,
> Christian.
>
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h      | 18 ++++++++++++++++--
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 14 +++++++++++++-
>>   2 files changed, 29 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> index c7d7adae4476..6235ce0f988e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> @@ -203,11 +203,25 @@ struct kfd_process_device *
>>   svm_range_get_pdd_by_node(struct svm_range *prange, struct kfd_node *node);
>>   void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_struct *mm);
>>   
>> +/*
>> + * SVM uses CPU virtual addresses for GPU mappings. Disable SVM if the GPUVM
>> + * address range cannot cover the required CPU address range.
>> + *
>> + * The parameter must be named adev since AMDGPU_GMC_HOLE_START references
>> + * adev->vm_manager.max_level.
>> + */
>> +static inline bool kfd_svm_vm_covers_user_va(struct amdgpu_device *adev)
>> +{
>> +	return (adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT) >=
>> +		AMDGPU_GMC_HOLE_START;
>> +}
>> +
>>   /* SVM API and HMM page migration work together, device memory type
>>    * is initialized to not 0 when page migration register device memory.
>>    */
>> -#define KFD_IS_SVM_API_SUPPORTED(adev) ((adev)->kfd.pgmap.type != 0 ||\
>> -					((adev)->apu_prefer_gtt))
>> +#define KFD_IS_SVM_API_SUPPORTED(adev)					\
>> +	(((adev)->kfd.pgmap.type != 0 || (adev)->apu_prefer_gtt) &&	\
>> +	 kfd_svm_vm_covers_user_va(adev))
>>   
>>   void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> index 35b3abe57b80..5de19fa27d12 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> @@ -2471,8 +2471,20 @@ void kfd_update_svm_support_properties(struct amdgpu_device *adev)
>>   				sys_props.generation_count++;
>>   			else
>>   				dev_err(adev->dev, "Failed to update SVM support properties. ret=%d\n", ret);
>> -		} else
>> +		} else {
>> +#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
>> +			/* Report it rather than letting the capability
>> +			 * silently vanish from the KFD topology.
>> +			 */
>> +			if ((adev->kfd.pgmap.type || adev->apu_prefer_gtt) &&
>> +			    !kfd_svm_vm_covers_user_va(adev))
>> +				dev_warn_once(adev->dev,
>> +					      "GPUVM size 0x%llx is too small for KFD SVM; SVM disabled (amdgpu.vm_size=%d)\n",
>> +					      adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT,
>> +					      amdgpu_vm_size);
>> +#endif
>>   			dev->node_props.capability &= ~HSA_CAP_SVMAPI_SUPPORTED;
>> +		}
>>   	}
>>   	up_write(&topology_lock);
>>   }
