Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013047.outbound.protection.outlook.com [40.107.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A56C44A403
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791457287; cv=fail; b=XONhk5wASKG02INsax2x4HoQT8RaONk20+e1r5hc7mazvTlvf7YnsxlIj/5MqRPD9NyJ+4kgWpsmhoxq80Vy4PVlEHdc+31/Be7wTs8kzeBSeCEHujfrntKN2qkaMe1obo55voGQVpUz4WYxpIwfBk0b4GI8D9JtEymbeJ0+lD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791457287; c=relaxed/simple;
	bh=uu2fqaQTaoDiLXD/1RRzkaQ2NjN2HwQoq4xkucyQR+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CWiI2HQS3K5/iedu4uyBVffORJvC3Gh4nWA21rrr+qqVxDtsN5f5uGDCazoWIl3RJajY9w23Ez8htZl+C13vA+PyTx5xibpxQFJKBB3ZTx16W/PpJCHgPdHQ1fpMdSjVN8sRZzJl5JqDqSu4Lk3MdHLFevV6w0o+i3ydyBwGmho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZoFoV//Q; arc=fail smtp.client-ip=40.107.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZoFoV//Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BK2sCRYM4kBhAXTibtTWYOSon+Mw9ISmkEYIUBNRFg+tGy/kLUJwGF8PaOdg3CX0pZ2V7IcRzY9srKGKVTShrOl58zc4YvFxgT2yObN2w3jMfwZ1RUkSQyMKRN9L+XKjQjtzyvpI8kKQ7lJO8Kfoj3H1cmMixRqIlXoYtr6kz9CPFB5iL5Y+Uf8UDfDiHWTbY/yIJrDdzst0jKc9fvQ6phOeixTkW9fpAukNnc3Ra9VzXSUINIhVj59HxODykZz1ENTlIHc+vi97KH6KKWZ+e4MsX3kpSQys7AqOyT4q3IT0VjqYVZPKNKLqLJLLQBshwo+WnLv9ieyxRnDuZ5mfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTICfItmd8rAviGmPKPTYFAvbsz5K2h9SLbt4d3Uh9E=;
 b=Wq5fOJ4f3PF8tl9nQueaQN+QrEM1Rxr9mxY8UwbKDJRLcF413TtzGa/PVntfa26WKqLMtArIColExGFwU5ZYn34xLJADmxHGd5zvgL9QxMgGtLAHL/z8gTuDQJOvJVyF1n//9xXFBdh64Selz4jNlodW4ySHSnN2sIG2A+Z40OqMsXnMi3VPlLAdCBW14X7vzFUSa+Qs34Qmz6miAJgei7U6Fe6f5M2f8AHd6lVlrtjGz6rQOk2X/0NBxEYCAurYGmLUQN4oCHfSC7fl/Eq95XIOZRnzodF7k6us0+bOaa0gzz1SNnhC4Yov5SwEXcOtOj3IeP9cAr5bBTadsEPj5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTICfItmd8rAviGmPKPTYFAvbsz5K2h9SLbt4d3Uh9E=;
 b=ZoFoV//QjFYISxfS6uAz3dzRAwzNsG9MHZfgmNGvfsAiRuN5w8b+NcFrOng1WT79fx6AHUroU+HVaxTc1VW5JYFy56dVRXXwOkepreaB/MtAcrswwfyLNzV/eh/jHQzz80wyFJHGsubko46pHoCMxVMiLEDkFngcBXU6TOkMWxE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 11:01:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 11:01:18 +0000
Message-ID: <017b79ec-db97-4eab-90c7-cdd967d3edc0@amd.com>
Date: Thu, 8 Oct 2026 13:01:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: wait for pending page table updates before
 switching a VM to CPU updates
To: John Fisher <jfisher84@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 Prike Liang <Prike.Liang@amd.com>
References: <20261007200345.417281-1-jfisher84@gmail.com>
 <e14295dd-c78e-4604-ba38-5a03c8ffa7c4@amd.com>
 <CAC7wNSAqWcaR=v7N+_Qe9SRPU8AAd0vjophDtkfnhRY4RhrXqA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAC7wNSAqWcaR=v7N+_Qe9SRPU8AAd0vjophDtkfnhRY4RhrXqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: ee48c3e5-a7ab-4685-1421-08df252b7a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|5023799004|11063799006|4143699003|260925021911599003|260925022911599003|260925021311599003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	DngDhcmJZ1WOJhaW67wpPOSpTfEwmiskeBYAoL/kGxuspzEV+MowGQ9wa0jeqWzZW4vxOdS1jAgbeFM6e3JWVj+misX4wp2X8KPkMU8If9fbVFBYg2LPpEF8ITMr4lygkRA1HgguoQ40+KC3gHQ5kWA3xbEXdMP7/GavmrydRHYu/ls7wPTgu2FfL6RKPXgeR7iuLPf7+Xw2Jhm4tjFMKo+gRZZISwYUFZEkdQhY5aHDZB0x+z+12eb1y05Y6Wff0hQyeUqdb0+14eyK3eKktgpl9Ud28CvCvI/jKvRBRytmcG96K2VM0J+mMs/RBS6fLzYdtXSMa8mHrwnnI8ASsmgADoTY/SRY9IDo40/qWggp/LpcFpsVH1PhJGrko132SOiPbRe61nOm3oS2aGHPbh0bYE1BKvv/ftgJXQ4C69KdVhYlDn1kpSJOK/1R3gNyyDPzrCvCiZCoUpYHMg1cJZRlAZqeONOCTxAGb8UO+oyf1USOm1TAWudBSk6mxM2xhL5QPJMz8I5ANDmKqgVFyKzD5mLySkqPDXKVdySSd5qJOE/8IeuOGrZ33TOvpW+unPuTGzseKTF/izTseYNEY3qIdsK83lgV2dizSBc6zVU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(5023799004)(11063799006)(4143699003)(260925021911599003)(260925022911599003)(260925021311599003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3dVUXZHdEo5QmZ0UkRuUCs4WDZ6ZTdjUmxhdXUrWitTdmkvK2tvVkpIYzNB?=
 =?utf-8?B?OHpSRWZvS2NrTDVPWjdKNFViL21ROW04YnBidUVyS2c3bDVaN0Irc2x4L3lR?=
 =?utf-8?B?M0pucDllSXZJNTduL1pBSks2WjRGL0ZHMjVHQmNtRDBkbzd6cUhicXFDRE1a?=
 =?utf-8?B?SVFjanJ4RlFTMjBmbEgvUE9aWjM0UUd1bmhLSVUxejFWaGs2RkdIem5FRTB4?=
 =?utf-8?B?ZEZJTG0xa3lqbDVkTm91N0pvZjdYMFdXZC9YZlhnbUhISXBTQ3lWdVdnVWN6?=
 =?utf-8?B?Ri9NUFRmdVkwaDZrTk9iRkM1eUF6RmJKUytteWZWcXk5QlJBZnljWWZPcWJ5?=
 =?utf-8?B?dVN2YTVSSTlXNTdBRVhjNGN6eVJzNC9JQm82amFIRlYxRjgyTUZla1YwL0hO?=
 =?utf-8?B?SG5OSWhwUWxNbDFNNGdJdWdQOGtTQ3ZQcXBpOVhpUFZwMFA3SXIrWmsxUncz?=
 =?utf-8?B?M3FDWmtjNzgySlB4Qk1HL2FOaGJ6ckFIRDZQcjJlREwwVHphbHNBYndBcUdv?=
 =?utf-8?B?OTVLZncrZWJhYXF2MkZBMkZWTHhIT21xbXJTdUM2aWtKeXZWc252YzdxTnBZ?=
 =?utf-8?B?MUZpWTZCRGNQQ1h4N1krUEo5c1V1R2VvaU5BTTNWVTVWVSt1U1cweHJjUmEz?=
 =?utf-8?B?Z1o0QmpwOGNhVmRKdU9wNEw0Uk5NTWNmckorVStYdlRlVzIyVHRUSHlMNkVX?=
 =?utf-8?B?alhjNTNueEFBVSt3c3BsSjJJUHBNaThqRVlURlpnQy9GUXdiQnhBVkZjZHNq?=
 =?utf-8?B?Y2VpMW9XNFVlQjRJRWh5TS9SR2VQR0YvNU8zbXNOYjFVaHY1S3cyT2dDMnNO?=
 =?utf-8?B?VVlMQ2RQU3V6dkJ5bUxXcnQ4M254UmU5RmpzbVdKRlNVcVdNYThqU2lxd3h4?=
 =?utf-8?B?VCtOa3VvUUJIT21WdUV5aVZ2R2pPWkJGSTAzck1jalVhQ0RzSWlyZkZHNENW?=
 =?utf-8?B?cmFEcWdxUGVFbTU5MlcxbHJhdWFPSFVxUm44bnUxOEtGcGFlVElFQ3VWRWNC?=
 =?utf-8?B?NzA1clVOS29jS3grTmlxbW1PaS9OcVZlWjVkN3N1VUx1eDhwaC9jSzl2Y0Fn?=
 =?utf-8?B?K05pV2R4bHpuZmZDNFZJc1JmU090V2s2amVKTmcrb21oTTIreFk5c3RMQStO?=
 =?utf-8?B?RjNRalRoWDFFSlhsL1h3YXlIZW53RmliT3JIMTEwRzFFV0k2Yy96Y05VMUNv?=
 =?utf-8?B?aEovUGxGeFBQTlFlY0QrQW53Vkp3YitqbDQzVkxpdzh2WU9Canl0elhZK1Rr?=
 =?utf-8?B?REJwdEhvcWFCTmVmdWVNaE04QktEYXFCNVdLWlpNTGxxaVoyQXJ1NnQrU2dL?=
 =?utf-8?B?a2VnekV6Vzk5MGdYa0pyUDlzakIxaUlhWit2KzFjTVExbHBsUlBPdnZxOXRz?=
 =?utf-8?B?R1pqSGk5M2lnTjR5UU1WdW1va2twL01OMHdFSUpuem1XR1A4UDFTTG1wSEZF?=
 =?utf-8?B?RGE4MWM4aXd1aFRSaU9hVFkrMk85MlByWFhuT1BFOUI3Z2p0WG1obDIxdytI?=
 =?utf-8?B?UzdzSHNZOVlMWTFhMDJ2WGg5akRqL002QjdndmVFMEdDRG5yNUVvRFZCdTUv?=
 =?utf-8?B?REtaaytsL29XOGVVeUQvbGQrTzZ2Tk85a1FhVjJob3FTcXQrczJZR2E5Ynk3?=
 =?utf-8?B?d3J1eVl2SktCSFBkNVEzMG5rREtyRHprTVNlYTczYk8rekpiVFh4bW81Uy9v?=
 =?utf-8?B?UmlwdGMvRkNUakZVSFBmd2gwLy9PVm1lQmdSSGlvQnIvVE5ER3dkYS9ZaW5G?=
 =?utf-8?B?MjNWSmtScDhlb0E5bW45RmFuK3VRYkd3SGhhZkVPeXcrTEZ3YzRhbFM1bzY1?=
 =?utf-8?B?d25pb0xjNm9TMVNlbXZIVzJqUFJRNEpZZzZZSGRJSWpWR255VWtha2Y2Yk4y?=
 =?utf-8?B?ME9zSFl6Y3ROZlJwYTVUMGtDS3R3Tm1hSkZWeFFmMW1sRU90cmN0c2tVaE9K?=
 =?utf-8?B?QUp5c3BTT0I4aElzL0JyVWpzaXJRTklJdHowZFpJMFg5b3ZYd0UwSlhJM204?=
 =?utf-8?B?c2ZZZjFWQ3U5bjN6bkdkQTlKaDhQSDBKL1VNbHhGcHRuVUNIdUhrSy9qNDR6?=
 =?utf-8?B?N1VsZCtEdnBBeTc0WmRkSnNuSnRVZ1c3V2kwdG1ITXJFaEMwQXZENWJhT2Ur?=
 =?utf-8?B?KzJGOGpRNkV5d1podjVZQlRnME5Oc2JvaXJlcWozMGJtTlV2STdMZ3JteHlW?=
 =?utf-8?B?NmNQNG5MK203VEcrSCtwSUs3MjF0T3BCYzUyRmJueXc5Y0tvdDdLcUtRbEx4?=
 =?utf-8?B?N2JzaU5JQ2xPWlNPSVp0ZHFxSDVrRFhuM2wvN1g2d0RSUkswaDlxTSsyZ1FI?=
 =?utf-8?Q?XWTGPMgFpFIQc3AoEK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee48c3e5-a7ab-4685-1421-08df252b7a9c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 11:01:18.3920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghlmtaIfzVEjgpDfjAoD9mMa9jpUVMrYCgRsPXF1DnD4Amc9e8N/Og3AkKuIV4AM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318

On 10/8/26 11:46, John Fisher wrote:
> 	
> 
> Ok understood. Uninterruptible with no return value check.
> 
> Which fence should it wait on, though?
> 
> The jobs that race here are the PD/PT clears from the render node's open, and as far as I can see their fences only end up as BOOKKEEP fences on the root PD:
> amdgpu_vm_pt_clear() commits with a NULL fence, so they never reach vm->last_update.
> Nothing else sets vm->last_update between amdgpu_vm_init() and ACQUIRE_VM either: amdgpu_seq64_map() goes through amdgpu_vm_bo_update(), which puts its fence in bo_va->last_pt_update because the seq64 BO is not always valid; amdgpu_map_static_csa() only maps; and the PDEs of the new tables stay on vm->kernel.needs_update.
> So at this point vm->last_update is still the stub, and a dma_fence_wait(vm->last_update, false) here would not close the race.
> 
> I think maybe two other ways to wait for the VM's own updates:
> 
>  1. Have amdgpu_vm_pt_clear() commit with &vm->last_update instead of NULL, and dma_fence_wait(vm->last_update, false) here before it is dropped. The clears all go through vm->delayed, so the last one covers the earlier ones.

Yeah that sounds like the right thing to do. We are in the process of dropping those clears, but it is still something we need to backport.

In general CPU based page table updates are not well tested nor supported, so I wouldn't put to much effort into them. If they keep making trouble I think we will just drop the feature.

>  2. Keep the clears as they are and wait here only for the fences on the root PD whose owner is AMDGPU_FENCE_OWNER_VM (exporting amdgpu_sync_get_owner() or adding a small helper to amdgpu_sync.c).

No, that is code we are slowly removing over time. So I clearly don't want to add anything new here.

Regards,
Christian.

> 
> Which would you prefer, or did you have something else in mind?
> 
> I'll send a v2 once I've rerun the tests on it.
> 
> Thanks,
> John
> 
> 
> On Thu, 8 Oct 2026 at 21:13, Christian König <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
> 
>     On 10/7/26 22:03, John Fisher wrote:
>     > amdgpu_vm_make_compute() switches a VM from SDMA to CPU page table
>     > updates when a KFD process acquires it. It syncs "with the last SDMA
>     > update/clear" through amdgpu_bo_sync_wait() on the root PD, but that
>     > walks the reservation with DMA_RESV_USAGE_READ, and the VM's own page
>     > table jobs (the root clear from amdgpu_vm_init(), and the PD/PT clears
>     > and the seq64 mapping from the render node's open) are added by
>     > amdgpu_vm_sdma_commit() with DMA_RESV_USAGE_BOOKKEEP. The CPU path's own
>     > waits (amdgpu_vm_cpu_update(), amdgpu_bo_kmap()) use
>     > DMA_RESV_USAGE_KERNEL. None of them waits for a clear that is still
>     > queued.
>     >
>     > When one is, the CPU writes the first entries of the new compute VM (the
>     > KFD trap handler's TBA/TMA page at AMDGPU_VA_RESERVED_TRAP_START, mapped
>     > during ACQUIRE_VM) into a page directory the SDMA then clears. The
>     > entries are gone, the handler's page is unmapped, and the first wave
>     > save of any queue of the process faults in the SQC instruction fetch at
>     > the handler's address (GCVM_L2_PROTECTION_FAULT_STATUS 0x008012B1,
>     > PERMISSION_FAULTS 0xb). The MES then fails REMOVE_QUEUE and SUSPEND, and
>     > the device takes a MODE1 reset with VRAM lost on 7.2.9; on 7.3-rc6 the
>     > queue is reset instead.
>     >
>     > The window is the time between the render node's open and ACQUIRE_VM.
>     > ROCr spends milliseconds there and is practically never hit; a minimal
>     > KFD client that opens the render node and acquires the VM at once is hit
>     > most of the time. On a Radeon AI PRO R9700 (gfx1201, Resizable BAR, so
>     > vm_update_mode defaults to CPU updates for compute VMs), a wave reading
>     > the trap handler's page right after queue creation found it unmapped in
>     > 8 of 12 runs; a 5 ms sleep between the open and ACQUIRE_VM made that 0
>     > of 9, and the same sleep after queue creation instead 3 of 3.
>     >
>     > The wait covered these jobs until commit 926c79ad6ecd ("drm/amdgpu:
>     > promote the implicit sync to the dependent read fences") narrowed
>     > amdgpu_sync_resv() from DMA_RESV_USAGE_BOOKKEEP to DMA_RESV_USAGE_READ;
>     > the VM's page table jobs have been added with BOOKKEEP since commit
>     > 4247084057cf ("drm/amdgpu: use DMA_RESV_USAGE_BOOKKEEP v2"), so from
>     > v6.16 on the sync in amdgpu_vm_make_compute() waits for nothing of
>     > them.
>     >
>     > Wait for every fence on the root PD's reservation before switching the
>     > update functions. With this the same client reads the handler 10 of 10
>     > times, 8 busy queues on the 4 compute slots complete in 5 of 5 runs
>     > (1 of 6 before), and two processes with 8 queues each complete together,
>     > with no fault.
>     >
>     > Fixes: 926c79ad6ecd ("drm/amdgpu: promote the implicit sync to the dependent read fences")
>     > Cc: stable@vger.kernel.org <mailto:stable@vger.kernel.org> # v6.16+
>     > Cc: Prike Liang <Prike.Liang@amd.com <mailto:Prike.Liang@amd.com>>
>     > Signed-off-by: John Fisher <jfisher84@gmail.com <mailto:jfisher84@gmail.com>>
>     > ---
>     >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++++----
>     >  1 file changed, 13 insertions(+), 4 deletions(-)
>     >
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>     > index 29187fabc..8d0c03a40 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>     > @@ -2736,11 +2736,20 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>     >                   "CPU update of VM recommended only for large BAR system\n");
>     >
>     >         if (vm->use_cpu_for_update) {
>     > -               /* Sync with last SDMA update/clear before switching to CPU */
>     > -               r = amdgpu_bo_sync_wait(vm->root.bo <http://root.bo>,
>     > -                                       AMDGPU_FENCE_OWNER_UNDEFINED, true);
>     > -               if (r)
>     > +               /*
>     > +                * Sync with the last SDMA update/clear before switching to CPU
>     > +                * updates. The VM's own page table updates are tracked with
>     > +                * DMA_RESV_USAGE_BOOKKEEP on the root PD, which
>     > +                * amdgpu_bo_sync_wait() does not wait for: a clear of a PD still
>     > +                * pending here lands after the CPU has written its entries.
> 
>     That comment is a bit superfluous, it describes the what and not the why.
> 
>     Just keep the "Sync with last SDMA update/clear before switching to CPU" or maybe change to "Sync with the last async SDMA update".
> 
>     > +                */
>     > +               long t = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
>     > +                                              DMA_RESV_USAGE_BOOKKEEP, true,
>     > +                                              MAX_SCHEDULE_TIMEOUT);
> 
>     That is quite suboptimal, we don't want to wait for the BOOKKEEP fences here. And drop the return value checking and wait uninterruptible.
> 
>     Regards,
>     Christian.
> 
>     > +               if (t < 0) {
>     > +                       r = t;
>     >                         goto unreserve_bo;
>     > +               }
>     >
>     >                 vm->update_funcs = &amdgpu_vm_cpu_funcs;
>     >                 r = amdgpu_vm_pt_map_tables(adev, vm);
>     > --
>     > 2.55.0
>     >
> 

