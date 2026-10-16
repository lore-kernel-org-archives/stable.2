Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011063.outbound.protection.outlook.com [52.101.57.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB845FFD5;
	Fri, 16 Oct 2026 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141780; cv=fail; b=Jjfcx+ug4evnWQyZSc0RiVr6vii7dckDZtCK3JAwZ8c21E5J49/bGMv9dKw16LeW1SgwICtCb8BKRo9AjDoxLBeESTJJcFfTDCnwQmghIJ7Ut3aJoJ4q6/rOrLUQzoE/ORCmhtBqM+9VdUYS90d8WUlx8wSoAQ9uIhtQ9pB/MeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141780; c=relaxed/simple;
	bh=S1BoyI2B98A7HsihSOEru3hNpN5FsTXCIexNrRxMA18=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sNBixDtBuuogUf/QpQQZ1q5E/m5UbhNOArK+iN75rnUoqxWmELdgGLGjJwLodvxte42RrNxO+szz5cZlrSLgxHmkgMcI0WfK4x5vqTSWmeiKQ9UHB7K6LcPeWyTmDy6V1S2HoLXxKidrLEo3TQJfcInWjMoGJUfWB15IrXZil/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v2Xvq/gS; arc=fail smtp.client-ip=52.101.57.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v2Xvq/gS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9E5C537OI+tDPyooTa2tVlLcv2Nz4Btl5bAB1RCSbxrENYmGInQCkaOLRV5Yo5AJ8NUk2vnZl1EeLv2t31z7pXOf3UL1lSUmTskpmUtgk5TC6QdsnhwqbyZnpjQjd8vARIYSt+BbGRVceu2eBBsEp1ZDQ8Keg1nReErFsVy8OlLoj4ObG4D8cdUJtCNLeDO3c4vSdNWCHQeMZfXdPS1NHh/Q6snJqWzYMV3LHrBnhyUCPNKIFFGeVT5H9tUQHGpNtLPeRpNtix5Kkt2t2UrrQ0yd+3djtYRoKEA+5HOvRFiw0xJjI/HN+B2oJEl1AvbvoeltCBGPl2n36/RpAyLow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4JZV1/rcYkWCsuaRpRpzI0IqXSWE6nD2ODhxdTcUFM=;
 b=HDQaqHV/dbuVTU9KUZgtiBQ5FBL4eeDiqkrOjWZDgHp1yX6ZTbrTf88G3giYQhY0YPr1I8oCGdSDYZyoe6575+MRabEenZXRfHskwuL7EvOZobw2bgApu6S2XgiEIo8Pv8tI+Cxv7bDmkXS6NY/K/7dhxIlQ2x84wqPmyXU68QpejTWzlAgW81Ubxw7dxvAXdNvcY+xvMwkbkcpzxpYLeEhOJonG8FwntqPWXTlpcMy/tx5yOneFghtlIskOxaAFMzkVkRA41b2x+ALcKwP4btjdSAIM4Lzr1V1oPLjMYXxu/VrBAG/thSJGqT7CnQJiGSdgHo6GbzOoeWYza3NgHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4JZV1/rcYkWCsuaRpRpzI0IqXSWE6nD2ODhxdTcUFM=;
 b=v2Xvq/gSrXFJ4NlRiJIxL/tmMlumMSrYq02/A6OZNfb5gSn25mMfkosyD8oMavhU4fWm6AOjwLCm50tIu5o/ffZq1ut4fp1D+onDdhIPqZds+0dnNTT+J5Mgx1gNKk0nlTBz9KqFM+pOrvGQFAcOyK7dqVmYIr8INjaKRGt/TzI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 09:09:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Fri, 16 Oct 2026
 09:09:34 +0000
Message-ID: <8a0a2d4b-ee31-48f6-8a44-d5a7d4af579b@amd.com>
Date: Fri, 16 Oct 2026 11:09:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: disable SVM when the GPUVM cannot cover CPU
 addresses
To: Daniel Huang <danielhu@amd.com>, Felix.Kuehling@amd.com,
 alexander.deucher@amd.com
Cc: alex.sierra@amd.com, Philip.Yang@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261016145129.69645-1-danielhu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261016145129.69645-1-danielhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: aed4eb4d-7ad8-49b6-9d7d-08df2b653209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|6133799003|10067099003|18002099003|22082099003|3023799007|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	yqiCBfSyp1qtjCdKGw0myomoSejwQD24YiUCcsjeOC8nlxe4dpfedTm//+ySaIkz5p1onIfv6FPMFVTrn+YAHVjvKurb5hho1fK50NsNq9BOF3Z12J3vKdkzWZMt099LTLt1aTg/YJAsx4VwzGaHGfSpfrhCpUtb1d8h7eINLtMSdhuONAe+JpRH4NuR31CXskGaUQG25XGZgU+p3+Sfdt2V/PkQ39hjOwL3EnP5591Xa7GvMVHvNku7fztT3xB5bx6kzUx0IpiA0iyh3OfM5G7tUwcVRpOGLfcVQBOA4rQ3aFqX6Mao42Xoacz8PVkkQlWtIil4S3NuJ5Zx3yu1P27LNUWoh0woSSG5KmYwinfvRWnNMO4dxHdB8rZBFGZGHET5AZWlT5j5IEi1hFVxR+fmJGhrDWB4mW3vgZx6gF9ooUoHfIfI95/CmmpUhTLGdUOvBq7dA7Kw9317MIQh7lLiMBvddUidu2qpU1p2UEdUq/74VcKmxBUh9UZqNTYIAT8rRIf3nwsbJDsT3MASoEMFlxUFmlPgpkOagQmHnAUpqy68ENb31Fmfc+HMc4mEAY8WpqthaeTLkN2AZpGoEPg94+MDptAVEqec0X+899NCnb/klHowiL07ZjbwJUhI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Znc5aDduMC9NMmt1dUdyMXd3bHBvcHdRMjdRN0Y3M2R5S1FsRTh4bi82R1Jq?=
 =?utf-8?B?YXJZNVRUWlNjQ04wRDNsb0NLTVFVTmJ5UnI0Q3NJZEIzcnErWlQ4dVZ6NzVw?=
 =?utf-8?B?NHliOExqeUpibnZLNURlZjBjYTUzNlljbHBrV0ZjdWVpMEZOVVdJRjBIditm?=
 =?utf-8?B?Z0lJMlp6YUwzUzhQRENrSC85dFM5ZjR3c09yOFJhRm5ibTlVS3F1cWZadkRZ?=
 =?utf-8?B?ZlVDNHRSNE9MRngvQkw1aUZIRCs1WE5ENWFjVHlHUmRXK3VMTHhYVVdZOU9m?=
 =?utf-8?B?MXhIWngrUXBGV3JoaUhxMFhOb1hiS25Zdzl5RWlvTSt0QUxSQTE3NURYMWNt?=
 =?utf-8?B?VWxPY0taWU1XYk5jUWFPNFlXRjB1ZXpkVlM3VnFITFV0OVN3MFlQSVdPQ2ow?=
 =?utf-8?B?L0tuZHZrUWpPZ0ZpdkU2bDRSNmk2MXBZb3VWS09mTW9hSTVtZUppODJVa08w?=
 =?utf-8?B?UEpXZVp0SEIwNUhIa2IzYnJrcXZwMGQvMUFOb3g3cGlsQmIvemU0Wk5nRlJq?=
 =?utf-8?B?UzZLaE4vWHV1UmdBUFdXL0E4bzJEN20vRGhDTUxDVTdDb2VVNlR3UVJZTXEz?=
 =?utf-8?B?RVJCalNKZ1VidWdTa1B1anVucWw3OVlWdktsaFd0MzJqc1VmUGlMUkZ5OGdW?=
 =?utf-8?B?Qy9nSXFadkhkV0JBOXBTdlpYVmJ6Q21VUWNTUTNIcHRLaWVGVTl4dC9TN0Ex?=
 =?utf-8?B?aWNNNzYxRTEyN05LZytTYmhVY1REU3B3clhrZXRjNzgvcE1iVHlzS3AxeHVU?=
 =?utf-8?B?YUZqS1d5R2IzNjBaS3NpMWR6LzRtZTE0UUtZYUdvYm16UTJJTUdvc1N0S3hY?=
 =?utf-8?B?ZlpMNHZGTGdpSUMyUG5GR3pzcFRGU21BcHRaNVV0Rmx2S1htbStkcWh0Mmwv?=
 =?utf-8?B?eTlUNHBMTk9mQmczcUtzYmhtQkJKbnE3M3MxMzJDZDBBeHhaa09ieFBiK3ZZ?=
 =?utf-8?B?QVYxcEtSdmR1S2M0SlVaN3NUcjF0YlhSOHdwcFlHK08zZHJvOHRqY1N0bTZ6?=
 =?utf-8?B?elRMdDlnOWN1UWx2UDk3cEpuR0Rob0R6blRVQ0ZNMHpKbVAyRUhMNWxhdXdV?=
 =?utf-8?B?VVE1UGZwR3FrTWFZZ2VnSGZralVwaWczSXZrOU9NWDhNVzM1WC9BMkJSaDFq?=
 =?utf-8?B?Z05iUzJscHJ0dmN4eFErN2RrZC9nR1JueHpPK2IvdjcrdFVQMnFzQmdwWFo1?=
 =?utf-8?B?U0pjVlF4VnFZS0lyb281VU44SnpSM0N6TWkzN3B1ckowdjRZZzdSUHlKc1J5?=
 =?utf-8?B?UjBDdlY2cC9iVVpTbUwzcHZIdUV4UEplc3phYTFSVGpHSXhmNjV4cTFmY3Bh?=
 =?utf-8?B?U0lrcFo3OTFRNzRON0RVenZsUVUraGJMZTJQeGJnQXV2WmUvQm5OZjAzZkIr?=
 =?utf-8?B?cEtHMFdjN3QwcUdUejRWYzNaOHo0RmNQUndxQjBGOUJDWVRNZjREZmlKSEh1?=
 =?utf-8?B?OE5UNDhLeVlKclc2WnpFWDZITURZVUo1TjBTQ09XVjIxdXFHaGF5MWxyUjJ0?=
 =?utf-8?B?aWxOREVNeVo1L3haOHNERHY5Nko5Wi9FWHpGVjhacnJaL0w4MDdHYnlnbmVa?=
 =?utf-8?B?d3o4RGpDNmpSRXlBRXA4NVhPZ0J5V0d2YUd6bDlTRnlSR0ZZZ016NW8rdHFw?=
 =?utf-8?B?WUQrcWVPUy80SVVpMkNCTDhKa1FIU2xORmp2bklVVmhaMkZObWZ3QnBmMFc5?=
 =?utf-8?B?VkpSOGFFbVhRby9lSHlUMllIdWtmdjB3aDkvWWtPa0FjV1RHM2s1b0svc1lo?=
 =?utf-8?B?TWZEUXQ2MmJib0RGWFB0QXpMdTMwSGZsSmJqRmcvMGZkeXN5bzBQRnQ0cjhP?=
 =?utf-8?B?em54ZDlwTjVLNVFKdmp2R0hCTnhubUUydmlxU1dmcGttb2IyT3JjSEVLNGpX?=
 =?utf-8?B?SW1XY0dkNVZGbjA3SytHdGxvSFVGSjd4d1NMMnpkdWVsM0E5Z25kSzlFcTRY?=
 =?utf-8?B?b3haV2hHQ3pINVVDUEV2SndkTHUraGZvelRBT3U2MFBLUkJuN3ZLOVRad1gw?=
 =?utf-8?B?OHRtZ2FUZ3BwR2dBdUFWTEkzbWs4SXZkVENGT3hhdk51T1lBd01vQldhZU1P?=
 =?utf-8?B?SDIzYi9KbGo5S0QrZGRZRFV4a1NTL09IM2hwSnMyV0xvZVEzenUwYSs5b3JT?=
 =?utf-8?B?NDVMUldUNWVlUHp2WUJZbWhLNEI0WEdZMWlaRnZINkdHbGtiTzRsQ3FTS3Er?=
 =?utf-8?B?bnoyT25MUjJhb3VQN2xCR0lURU0rdWw1anpmeW0vNVNGYXEyWUhsbEw1a0Qw?=
 =?utf-8?B?b0psNlZJRWZSSUh5TTc1c1lic3ovVnY1cEdQTmZ1YzdqcjN1NVJMSGFkREF5?=
 =?utf-8?Q?8Hslk7poAmrR2vnNya?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed4eb4d-7ad8-49b6-9d7d-08df2b653209
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:09:34.3999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYIafMax9wQlwCPrPEjNgc2lM0hBnwEAeUl3ZJkmGZ9TuFcT7pcad6Sytmbh+yHM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076

On 10/16/26 16:51, Daniel Huang wrote:
> KFD SVM maps memory in GPUVM at the same virtual address used by
> the CPU. However, svm_range_map_to_gpu() passes the corresponding
> PFNs to amdgpu_vm_update_range() without checking them against
> vm_manager.max_pfn.
> 
> If the GPUVM address range is smaller than the CPU address range,
> the page-table walker can index beyond the allocated root page-table
> entries. Unlike the SVM path, the BO mapping path validates the
> address range through amdgpu_vm_verify_parameters().
> 
> An explicit amdgpu.vm_size override can trigger this condition by
> configuring a smaller GPUVM than the driver would normally select.
> 
> Reproduced on a Radeon 780M (gfx1103) with amdgpu.vm_size=64.
> Repeated hipMallocManaged() allocations attempted to map CPU
> address 0x74bd48000000, well beyond the 64 GiB GPUVM limit.
> The out-of-bounds root entry contained SLUB poison with
> slub_debug=FZPU and recycled heap data without it, resulting in
> a general protection fault:
> 
>   RIP: 0010:amdgpu_vm_cpu_update+0x2f/0x140 [amdgpu]
>    amdgpu_vm_pte_update_flags+0xfa/0x1e0 [amdgpu]
>    amdgpu_vm_ptes_update+0x38b/0xa00 [amdgpu]
>    amdgpu_vm_update_range+0x279/0x930 [amdgpu]
>    svm_range_map_to_gpu+0x13d/0x400 [amdgpu]
>    svm_range_validate_and_map+0x8d3/0xaa0 [amdgpu]
>    svm_ioctl+0x66/0x80 [amdgpu]
>    kfd_ioctl+0x40a/0x650 [amdgpu]
> 
> As discussed in [1], rejecting out-of-range PFNs in
> amdgpu_vm_update_range() is too late. SVM must not be initialized
> when the GPUVM cannot represent the required CPU addresses.
> 
> Prevent this by disabling KFD SVM support when the GPUVM address
> range is smaller than AMDGPU_GMC_HOLE_START. This prevents
> affected devices from advertising SVM support and excludes them
> from SVM mappings. Warn from kfd_update_svm_support_properties(),
> which runs after the device memory pgmap is registered, so that
> only devices that would otherwise have advertised SVM report the
> loss of the capability.
> 
> [1] https://lore.kernel.org/amd-gfx/da43b0e3-5bd9-4aa1-86d3-b733f3bad108@amd.com/
> 
> Fixes: f80fe9d3c114 ("drm/amdkfd: map svm range to GPUs")
> Closes: https://github.com/ROCm/legacy-rocm-build/issues/6691
> Cc: stable@vger.kernel.org

I think we should drop the Fixes and CC stable tag, that is not really a bug fix.

> Signed-off-by: Daniel Huang <danielhu@amd.com>
> ---
> 
> Tested on a Radeon 780M (gfx1103, PCI 1002:15bf), kernel
> 7.0.0-38-generic, and ROCm 7.13.0-2.
> 
> The reproducer performs 24 iterations of hipMallocManaged(1 GiB),
> hipMemset(), and hipFree() per run, with 40 runs per attempt.
> 
> With amdgpu.vm_size=64:
> - Stock module: kernel Oops within approximately 2 seconds on
>   every attempt.
> - Patched module: completed 40/40 runs in two attempts, with
>   stock and patched modules tested alternately on the same kernel.
> 
> With the default GPUVM size, the patched module preserved SVM
> support, emitted no warning, and completed the same test.
> 
> Two questions for maintainers:
> 
> 1. I interpreted "SVM must fail to initialize" as disabling
>    the SVM capability for affected devices rather than failing
>    KFD initialization or rejecting the vm_size override.
>    Would a different approach be preferable?

I think that this is ok.

The amdgpu.vm_size override is only for driver testing and not something end users are supposed to change in any way.

So that here is actually a really minor issue.

> 
> 2. This check also affects GMC v6/v7/v8, whose GPUVM address
>    ranges cannot reach AMDGPU_GMC_HOLE_START. Although these
>    devices do not register device-private memory, an APU with
>    apu_prefer_gtt can currently advertise SVM support.
> 
>    Should the check apply to these devices as well, or should
>    it be limited to explicitly configured amdgpu.vm_size
>    overrides?

So we still support GMC v6/v7/v8 with KFD? I think we have dropped that a while ago.

If we still support this then that would indeed be problematic.

Regards,
Christian.

>  drivers/gpu/drm/amd/amdkfd/kfd_svm.h      | 18 ++++++++++++++++--
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 14 +++++++++++++-
>  2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index c7d7adae4476..6235ce0f988e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -203,11 +203,25 @@ struct kfd_process_device *
>  svm_range_get_pdd_by_node(struct svm_range *prange, struct kfd_node *node);
>  void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_struct *mm);
>  
> +/*
> + * SVM uses CPU virtual addresses for GPU mappings. Disable SVM if the GPUVM
> + * address range cannot cover the required CPU address range.
> + *
> + * The parameter must be named adev since AMDGPU_GMC_HOLE_START references
> + * adev->vm_manager.max_level.
> + */
> +static inline bool kfd_svm_vm_covers_user_va(struct amdgpu_device *adev)
> +{
> +	return (adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT) >=
> +		AMDGPU_GMC_HOLE_START;
> +}
> +
>  /* SVM API and HMM page migration work together, device memory type
>   * is initialized to not 0 when page migration register device memory.
>   */
> -#define KFD_IS_SVM_API_SUPPORTED(adev) ((adev)->kfd.pgmap.type != 0 ||\
> -					((adev)->apu_prefer_gtt))
> +#define KFD_IS_SVM_API_SUPPORTED(adev)					\
> +	(((adev)->kfd.pgmap.type != 0 || (adev)->apu_prefer_gtt) &&	\
> +	 kfd_svm_vm_covers_user_va(adev))
>  
>  void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 35b3abe57b80..5de19fa27d12 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -2471,8 +2471,20 @@ void kfd_update_svm_support_properties(struct amdgpu_device *adev)
>  				sys_props.generation_count++;
>  			else
>  				dev_err(adev->dev, "Failed to update SVM support properties. ret=%d\n", ret);
> -		} else
> +		} else {
> +#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
> +			/* Report it rather than letting the capability
> +			 * silently vanish from the KFD topology.
> +			 */
> +			if ((adev->kfd.pgmap.type || adev->apu_prefer_gtt) &&
> +			    !kfd_svm_vm_covers_user_va(adev))
> +				dev_warn_once(adev->dev,
> +					      "GPUVM size 0x%llx is too small for KFD SVM; SVM disabled (amdgpu.vm_size=%d)\n",
> +					      adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT,
> +					      amdgpu_vm_size);
> +#endif
>  			dev->node_props.capability &= ~HSA_CAP_SVMAPI_SUPPORTED;
> +		}
>  	}
>  	up_write(&topology_lock);
>  }

