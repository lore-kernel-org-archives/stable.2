Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FCB36F428
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 07:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791529239; cv=fail; b=pKOXyPatmW5hIR9oqGEIywYxRuue688ho6OM7Fe/7wZh11p6ulGwdcHWtz5EJnPBh9Uc9lSzElsIcVhkME4FYwq/NyUrnX9B+6KzvIKME7hGSsoIaojxomEXzqQhxz820/jeqCsMbEaUof7fQbgpEXRrXzc7Rz2uzt/SK71nP5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791529239; c=relaxed/simple;
	bh=39Zu7q9wQVbuJgQx33iLwRp3Ru+tNJfIqPhYbBRJpbg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FvIPap5HYO5Gmsi2fVepTcdte0Oe65rRExeVfmoNV4tSolLFomjCJ5oHLotf/vY4NHO9FJpDJwL72a2wdg/UMjswzzUgVEynfLD62eBOUx195U4B/+fHhC5fteYmo1STHjmjgN9k91QqykycZUImDdM1iL7jqMh4Dn1DQXbLZbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UQV3U0hN; arc=fail smtp.client-ip=40.107.209.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UQV3U0hN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fovFioz1sDdEs11DYgL9B60RaBtynVu3CiQLWCnhW1KZQdUOntvsi00Xmau9JZue/LMLp5ETLMomS1u56UIjlWecyIqbyBcuFY2Y1vuANBLyca5IE2iYGoCJtQQfgga6Sa8Y/8C3L8qpFcufjOFFqCAMTcns6ufxxRezgvmMrlrb8KcwBYzXTJxlp0FQDIw1i7D3NOMVaYIJFOBMaKMI3w+L4iaat0BhwR4UdECgvQyLEOISzPVx5K9OoMNy32or05V/AIK3U7WPnU9Kwx+67y6xZGBTTzY7DM7LNfDP2Brode8ef7G7HH6h4pkqwmu9YwMfm0bD7yVjVE1Jy+OGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCo6wGRWu8BFdU/gNdiTea787T5Ld1Y++XjLjBclhrU=;
 b=O0JcmDL4muW5P1y8w+NRPHrS7uJq8nNvqsnk4wNb/6eW8C1HazFiyZCcKbEeoiQ/3hVM9X43Vn1wXb47Z4zbmI2Eq7/OkNfZxMA47MhwrdpQmonufmuvFZol4Ro3bKA7cAASYwJmch50Vqyu2HV80A1tADrk1gYdCs4+SaI5iJ+fIV2ESZUGV/Jcddvn6Lkb20aa+IPK0a8NokhAS8A3WCxcflxfgS1oUohcwkpzkd0Nejk1CLXFAjPKQJZEG1/Ijc0bg3bfgQ1+SLHoBOhPY36/ti1twFYzN3kHlMXNg6lySIQzEa/mbvV/74jPak5s53/8GVhaaPYrPOzlEPVgtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCo6wGRWu8BFdU/gNdiTea787T5Ld1Y++XjLjBclhrU=;
 b=UQV3U0hNzxSPbe0m0n7cSNWeP6k4/0yUnDv2M1OWDkp6QoG2pgBGmxn93yhuPi+YZ/PBbVNUKdJYfwhDQQ55BNZcTqZP4Jg/oVxZFUrwXeIV2f44g1W9QKagUhr/D6zuMp+nDYskz2W3gn9j8py0ziRt0hrGjaqoXsllCPs8rVY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Fri, 9 Oct
 2026 07:00:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 07:00:35 +0000
Message-ID: <c64df6fa-6734-4c66-8f8b-52e5bd118cdb@amd.com>
Date: Fri, 9 Oct 2026 09:00:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: wait for pending page table updates before
 switching a VM to CPU updates
To: John Fisher <jfisher84@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, Prike Liang <Prike.Liang@amd.com>
References: <20261008204517.392180-1-jfisher84@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261008204517.392180-1-jfisher84@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: 73352ee7-86e1-4a44-7e07-08df25d3046a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|260925021911599003|11063799006|10067099003|260925021311599003|260925022911599003|56012099006|5023799004|18002099003|6133799003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ur6m4EEznlAZW3qLiTJvqnVka+lCmI+aNlWtCtoA/0z1E3rsy9zETsm/cUzTejPSPaI3iLImi3Glvr5PwAUSEZy1Vrah27vKCiBsjJRzsuOkw4uRTN7dvhvPtrMv/A2yNIInhk2VnGmiUZ0lxWP3nrhXau8i4o0evLB91l2V1ma2SKbAVogPhMiwFZmIW8uzHTAY9Kgcxs18oy+JuOgykZW6+76LOaA4qnVFjbV0TrTNpUNXP5YiTD17bdjO72NGIiIh/FFpIFM9ZIIotTVgJSjSRjJ/5sK1tkWuASrGJcb17MdslmLxWUPvNmwSr5n0TaoO4MnrhXPvqfIjPo8JI5xz/LWAmx9H4dNUKGWyuwRu+k7PDGNAT0W5j77nxx/Xo7Xb9zrKcklNEAfp4H00xJwO75fZWXwp531AIwbRY03jlwH6t3J72a9jQijldVVWKcjXVoKnvBSQrGLSqmKLX84hQoqgUBzrMjJRNLKgR8vl6euh02K4giAJMuJ4Oi4dycUU1Dqcwk/rX9GCzQ7r0WgJJn0bU4+5D+PQN5CRehA0xwV4Pn2AJJLk1AhvkNwKA0hJtAuESxVsCbfm9o8TwyzzWjQ8FshBLTylyn0FjcwL/I7HPxzpxpoLHX0ofjj9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(260925021911599003)(11063799006)(10067099003)(260925021311599003)(260925022911599003)(56012099006)(5023799004)(18002099003)(6133799003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Kzk5WEpXcTJ5K1RJRURNcXUySm14MlAra3o4UWR0TTZZeGNYZWx4bG0zbDhx?=
 =?utf-8?B?M3djd1RENUZBYkZTZm4xYVA4OXZ5bEZTQTNBNEgrZThVM3NqSGJETjJXRFVV?=
 =?utf-8?B?d1B0UGtycHlZcmxPc245b1NHTCt4MWFaS0ZDNFVhVWJTTGxDeDFIQTVSR0xN?=
 =?utf-8?B?dSt3T015a24xRmx1OUhVQVQ0ZWtRck4yVXZpc0k3NlpIQ1pUeGxQRGFPRmMz?=
 =?utf-8?B?eTFrR3pjcUpibVlFWFBEY1RoMThOS080YUNBRWcyRzQzWTdxWEJBNk4rMm5q?=
 =?utf-8?B?MXdXeWx6UDJJWVhURzlGUVdUK1BleDF2dlVlZmRJS1Y4YWQ2NmwxaDdEQWlG?=
 =?utf-8?B?MFE4ZGQyNVJyVTJwZTc3cHl4TTA2Tk9kZVhHaGFlN2pCajBUb2twbXlNRy9G?=
 =?utf-8?B?NFMrc25QMXFudEdlU1pXSFhkR2VMb1MrZklqTG1IT2FVZ0FmR3c1R21lblVp?=
 =?utf-8?B?MmZPRFh2bCs5c0YxZStQd0prSnJyUTNnVGdjWmxMVE1SdGlRczljYTZMWjRR?=
 =?utf-8?B?Nm9pK0VMTjlJREFzT0NFR0xCSjAzNXZuUi9DOXVvazZlNXFoZ0hrNEJjUjUz?=
 =?utf-8?B?V1VPaUh3Y3hVNUNZV3hRaCt4Y1YyNllTWE9DSnNxT0VudDlTQ2w4RS9QeDJn?=
 =?utf-8?B?bk9EVXVMN1IvcjRiWkRtR3crcy8xMDRZWEczRDh2Z3JpZStJYUc0M1AwelNL?=
 =?utf-8?B?SWpPVTlDRndBZTRSM056RkhoRUNGSlZSbEFrbEVLQWV1VDRBU0ZRVnhCaCtv?=
 =?utf-8?B?ZUE0cGVsak9STGRDL2d6Wk44c0NGY2tlZmRxYzkyc3hZN2UxclU2eEJuTisr?=
 =?utf-8?B?dHIyME5KcGZXQmRpd3pJRDkvVzhsSDc5WmEvaVFCdEVSVm4wUm1BdHRJblpx?=
 =?utf-8?B?dFAwOXRBQStJbHEyMU1PcWlyVllRK2VhRVdpM1JPd0UzbnFlZXIrRVJQd1cy?=
 =?utf-8?B?UHE0TStIcVVRbW9MNXlWaWJuRHR1QTdBRnlvc2hrL0FXUDQ0TVlGVmcxWlNt?=
 =?utf-8?B?MldCYXZzbzdnaWUxYUlkcjBCay9ycUdwa2xUWkp1elJEZWo2a1hvMGxWNVVh?=
 =?utf-8?B?UlBFUGRxWG9SM2FMdS9mRDl2RE5xUENOMTV5MGkvZm5kZGpQdzlGZ0UwSWJm?=
 =?utf-8?B?M2hhMFZMUXl4Nkp2Yk12Rmw5Mi8yTERIOW0xRlJqTCs1aHNROGUyc0FoN251?=
 =?utf-8?B?M3RHUkxoK0NxVVYyd0RxeTNXSkxmanRlMlJ1YitpSjJRZHAxNmxzOCtzRERU?=
 =?utf-8?B?RGJ0SVJJN0dRQitqS0QwK1FNRkJneTFQdUlxQSt0dkFwcmRBLzFhYXhzb0Fh?=
 =?utf-8?B?VS9lNFBoVjRSZ25UV2VTeEpUb1d3TW9DOEw1N1lJUjAxYXp1MDV6TVpKRXFt?=
 =?utf-8?B?QXZGcWF1Q3BLclBaZkI1NkxZOWJLdTB4WjRBUTRKVS9NcFQ3dEpCYzgwaGVY?=
 =?utf-8?B?OW1Ba3djYnpERTh4TDZTeGlHZDZVU1F2RmcrdVJXck5SUWVyNlhRZ0dLblhu?=
 =?utf-8?B?OFE2TFFwVGtTWkZvbWxuV3pWL3gzdGJRcjJ6Qy9LVDY5U2dHODJxT25IV3By?=
 =?utf-8?B?ZDVwKzdmRFZBQUZya0d3ZUppOExqQk85UmplbXNkV2hudTVaYmtYYzhhK2hq?=
 =?utf-8?B?ZDdlT09Yb2ExUjVkUUlMMHkxN2FITGJMbE03akZveWVlamczajNuN1FLRnlD?=
 =?utf-8?B?Rks2eHJncUFxOE1vc0xCcmNzdlo5T0NDcnBSMnhlQUE5a2NzUHhkT1dQK1U2?=
 =?utf-8?B?aHJBSi9WMEpxKzBlMFRCU3JnOFJpejhFNHB0bGh3QVliQ2pwVjVXb0U0UytQ?=
 =?utf-8?B?U0s2U2lUdHV6RzNqOTZlRlpmYlZubDlPMVBaS3JiMlJRMWFnT1NGMTJQbjQ1?=
 =?utf-8?B?OVdwUDhtTUxCaVQ3SS9uaTFFM1RmazNHVk1aR0ErUFBnb09xVVBzd3NGY0sz?=
 =?utf-8?B?ZlVQL1NROFI4MEk3WldpQ3cxczQxL0Y1dkVWUmlYYkgyUVR5dWxZb1JjNlFk?=
 =?utf-8?B?L0xCYkVHTDRHN2NXT1RrMDVhNi80OEpvcndrT091U0wzTzcvZDBKbzg3SjdC?=
 =?utf-8?B?amRwRXExZU9BcGh3TTZRdlEvTUtybXNFSW9tRDEzU2R2WEk4dlBSWjUrcXY1?=
 =?utf-8?B?YWlPM0FCN0I3Z0hOQTVzZXhsTGs3Q0JwSnhHREhFVDRsRFdvd2FZTWwwN2Za?=
 =?utf-8?B?NGhyZDVEbStqb1dFdHJFbWpVTTNnU2FqRWd6RStPZHYrRDkyb2haSVRudnZI?=
 =?utf-8?B?Slo2WnhZbmNrbjYwazh5aWtvbHF5MCtqTTMrS0JMZUU2Zm8yS3J2WDdRczZB?=
 =?utf-8?Q?wa/AchyO3k97jg3vZ3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73352ee7-86e1-4a44-7e07-08df25d3046a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 07:00:35.4584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMBhOyUHQ+bIy90ZDM7p56VJ055Z4WsALw3qjy1OP8opO5HSkVwwhWPdD1yFNqXh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620

On 10/8/26 22:45, John Fisher wrote:
> amdgpu_vm_make_compute() switches a VM from SDMA to CPU page table
> updates when a KFD process acquires it. It syncs "with the last SDMA
> update/clear" through amdgpu_bo_sync_wait() on the root PD, but that
> walks the reservation with DMA_RESV_USAGE_READ, and the clears of the
> VM's page tables (the root PD from amdgpu_vm_init(), and the PDs/PTs
> the seq64 mapping allocates at the render node's open) are added there
> by amdgpu_vm_sdma_commit() with DMA_RESV_USAGE_BOOKKEEP only:
> amdgpu_vm_pt_clear() commits them with a NULL fence, so they do not
> reach vm->last_update. The CPU path's own waits (amdgpu_vm_cpu_update(),
> amdgpu_bo_kmap()) use DMA_RESV_USAGE_KERNEL. None of them waits for a
> clear that is still queued.
> 
> When one is, the CPU writes the first entries of the new compute VM (the
> KFD trap handler's TBA/TMA page at AMDGPU_VA_RESERVED_TRAP_START, mapped
> during ACQUIRE_VM) into a page directory the SDMA then clears. The
> entries are gone, the handler's page is unmapped, and the first wave
> save of any queue of the process faults in the SQC instruction fetch at
> the handler's address (GCVM_L2_PROTECTION_FAULT_STATUS 0x008012B1,
> PERMISSION_FAULTS 0xb). The MES then fails REMOVE_QUEUE and SUSPEND, and
> the device takes a MODE1 reset with VRAM lost on 7.2.9; on 7.3-rc6 the
> queue is reset instead.
> 
> The window is the time between the render node's open and ACQUIRE_VM.
> ROCr spends milliseconds there and is practically never hit; a minimal
> KFD client that opens the render node and acquires the VM at once is hit
> most of the time. On a Radeon AI PRO R9700 (gfx1201, Resizable BAR, so
> vm_update_mode defaults to CPU updates for compute VMs), a wave reading
> the trap handler's page right after queue creation found it unmapped in
> 8 of 12 runs; a 5 ms sleep between the open and ACQUIRE_VM made that 0
> of 9, and the same sleep after queue creation instead 3 of 3.
> 
> The wait covered these jobs until commit 926c79ad6ecd ("drm/amdgpu:
> promote the implicit sync to the dependent read fences") narrowed
> amdgpu_sync_resv() from DMA_RESV_USAGE_BOOKKEEP to DMA_RESV_USAGE_READ;
> the VM's page table jobs have been added with BOOKKEEP since commit
> 4247084057cf ("drm/amdgpu: use DMA_RESV_USAGE_BOOKKEEP v2"), so from
> v6.16 on the sync in amdgpu_vm_make_compute() waits for nothing of
> them.
> 
> Record the clears in vm->last_update, as amdgpu_vm_update_pdes() does
> with its updates, and wait for it, uninterruptibly, before switching the
> update functions. The clears all go through vm->delayed, so the last one
> covers the earlier ones; immediate clears are not recorded, as before.
> 
> With this, on 7.3-rc6 and on 7.2.9, the same client reads the handler
> 10 of 10 times, 8 busy queues on the 4 compute slots complete in 5 of 5
> runs on 7.3-rc6 and 3 of 3 on 7.2.9 (1 of 6 before), 16 and 32 queues
> complete on 7.3-rc6, and two processes with 8 queues each complete
> together on both, with no fault.
> 
> Fixes: 926c79ad6ecd ("drm/amdgpu: promote the implicit sync to the dependent read fences")
> Cc: stable@vger.kernel.org # v6.16+
> Cc: Prike Liang <Prike.Liang@amd.com>
> Signed-off-by: John Fisher <jfisher84@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> v2: wait for vm->last_update, in which amdgpu_vm_pt_clear() now records
>     the clears, instead of every BOOKKEEP fence on the root PD; wait
>     uninterruptibly without checking the result; keep the original
>     comment (Christian)
> v1: https://lore.kernel.org/amd-gfx/20261007200345.417281-1-jfisher84@gmail.com/
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 5 +----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 29187fabc..757a037ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2737,10 +2737,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>  
>  	if (vm->use_cpu_for_update) {
>  		/* Sync with last SDMA update/clear before switching to CPU */
> -		r = amdgpu_bo_sync_wait(vm->root.bo,
> -					AMDGPU_FENCE_OWNER_UNDEFINED, true);
> -		if (r)
> -			goto unreserve_bo;
> +		dma_fence_wait(vm->last_update, false);
>  
>  		vm->update_funcs = &amdgpu_vm_cpu_funcs;
>  		r = amdgpu_vm_pt_map_tables(adev, vm);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index c03327f12..cdbc2e931 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -427,7 +427,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (r)
>  		goto exit;
>  
> -	r = vm->update_funcs->commit(&params, NULL);
> +	r = vm->update_funcs->commit(&params, &vm->last_update);
>  exit:
>  	drm_dev_exit(idx);
>  	return r;

