Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4AD459AE9
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141339; cv=fail; b=pHlv45z3L0KAd/Db0XKsx/ol+43l0vc36qd5SzvfOJUhws+XPNh7R3GhHEC+28yl7jqdcXMaFmyaZiWM2sqNcC54BcEjoGS4w0eUmkFMcxGwjvGQ+EvcV8YJVAx9OKv8NimuhxECeypQJ86aOI9a9K1ePseGmmI0e6aW4PvogYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141339; c=relaxed/simple;
	bh=WrwwfkTgaqujVip6Ae4sgS2zxUGNc5HLjWfoCsoWCJI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nRoJEEBK/6ypiOFEIMsxqf8yWzuKXfhvUiOweWx/LtU17ysw4IrUL+XbpC9K925wtaE8xRi+iShf3perRM4+WKunswU+dT0d8/kGuTyqllKfSC0w0u4fQlV3ZT21upJq+YCDDSdeJMIqmQf5wgIiJLHh14p3HX7tluJvrmsNmlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PJlZcx7M; arc=fail smtp.client-ip=40.107.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PJlZcx7M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TG71OT3OPApJVXGMNyEOM8CL9TrJmMC3O84X0KTpsJWEr1BaygzOTQrulCit+K043BxH7wMZCqMauV6qmB9GoegcMB+sDCHI7u6etnC2fh5pkRKPPa3+ovq5Jma+WmAv6Uj9akpq31AmRxbBfCm7m52jljQf2nDLMoFG1I9jACOJnHv3IMV4H7qxT2lYxgUjqhAeLfmdMblDrVDiQG1lbnQXuhOG1cEdUfWgYodv2OJpM0WrjNarVuX3CMzBGTRXgw32T+NxZkc6gRA3qK5LohzxkON+On93rLuq1zbzMtiOHm5CXvdVDUr/TTbq3enBKcoqTu2f5wVTwi+hcGGxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4scvDB8ll+9R/FnZHZpb1lpZPH7EVYrvzotOgGGmNts=;
 b=iE82VFQK5/9EEYl1JFBfEYdC/fdlITBYWN7J9te4oGSwAGl9et12LcKINSVN4+b5+bHegNSroVlzT/89XvTbe/bjXA949vMQsDt4R3F4lNlqYPK51MrTW9HETrg8whF/LFtdtUOaAb5yAIjjpyFQCUBGHmWtKqGLrVKx2/37k/18y8gwQFwGc2KgvRCxT7aRFKKLXA1ANoHVrA/R9VE/Hr5RUYpwe130B43XlNpK+KOlzHlWfoAduESVmqK1LrVC8cioDga0TuP7hjTZclmr2/bYdiiANFyJaiJyd4LPWG2YBL+Hu6o8dc6K5fYT/EbtS/VqBs1HNDIEh8QZF7mMPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4scvDB8ll+9R/FnZHZpb1lpZPH7EVYrvzotOgGGmNts=;
 b=PJlZcx7MVxKhqJgepGrdIDJzr+Hc0o6IIDrNY1xepB/l5VlVFzpoEprcrwWIzcuRaRG/GwEmmxJp50Km7xg0p5+/2yuIy2qTtY1SwFZx5OYTJ0rfkSfmAvKjiiiwRX9Mc9epjHHvU5LfDK+s9AVjdAzZ6BbdZVh9lrMaWEqH1KA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 09:02:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Fri, 16 Oct 2026
 09:02:13 +0000
Message-ID: <9114d572-62ef-4885-bb29-d40d37cf2d61@amd.com>
Date: Fri, 16 Oct 2026 11:02:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: wait for pending page table updates before
 switching a VM to CPU updates
To: John Fisher <jfisher84@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 Prike Liang <Prike.Liang@amd.com>
References: <20261008204517.392180-1-jfisher84@gmail.com>
 <c64df6fa-6734-4c66-8f8b-52e5bd118cdb@amd.com>
 <CAC7wNSChWJ3nYY4GPT0Av+CDiudQ346hnxE_U0bfNLVvHdbozw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAC7wNSChWJ3nYY4GPT0Av+CDiudQ346hnxE_U0bfNLVvHdbozw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: 48fc54ab-7432-452c-3788-08df2b642b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|6133799003|10067099003|18002099003|22082099003|260925021311599003|260925022911599003|260925021911599003|3023799007|4143699003|261009223027099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	uit94AfHsi7wYmZJX6EV2zxvlJifuxamw1x3Y0EDcx8hfNyjYzWTsrc9woLmnuEGWndzFktPmoRVyqOVnE/M33YcX/vXmm9ptZpTX9anUK70YA+kIqfe7e4HiMu46pRlB7iK+JyqIBjCAHafpR7lbRfixEYDoAKynGojAOsRmZ+CEKlRfJCPuOZvlKd837o3gSGk2t7h4s2OENaR00GPudR7jHj89+p8+S/K25aGk4/fyp4kvitCNR7zypEjiSPoDBHZelClZbJwb/T8ZL6mPRyumPs7rmH9cqpBK/tRq6Qwtl6SGeRLlAhnJfF2mD0CK5A2xWSQ+JLse+497/yRW8gR7fqjBpITIAr0Mtm7MLEmGHy4/R6c7hsVIj/jfET6AlsOY3yQ1wukbVnq/Qyr91soVjWQ98bI0sPQXt2/LPB19LzOxsDOkbWq1we2H+xHZl9YMeCGGtASLRPw/aETpQr2rfuqtOL1dxIrnMdZ+qhkyN3vJbJBUQxnseGbhn152f89Ytt16+TKmx9H+jWZUs+2n7SDqjoOJ2V/XlTezZL1zm7rQ2O0OYrHIYWJmGz8aZYUxbEAKAqezynHtW5t4iMSWLusXeTEoWLtuPRRJMQDwNGzU/2uOoouOTBhBAWe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(260925021311599003)(260925022911599003)(260925021911599003)(3023799007)(4143699003)(261009223027099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0t2VURPT2k3WTJTYkNYSG1YREhIK2JaSktwV1ZzdjJEVkZzY3cwaTNUVHpk?=
 =?utf-8?B?bUMvVHFXZktTL0lINWR6Q2wvQWJGQkpJVWVURmFvdVJSTnBmajdITW1Cak9I?=
 =?utf-8?B?L252ekQ3bS85cDhhYWZqRzUrZ2h4ZktkQm8xNTJjeDVtSXg0bDVJRDU5cGNR?=
 =?utf-8?B?N2h1NnF6b2RrZnFIaXRJREhmdU9qMThJWUNpQlQzSXFWc3VWQzI2S2FvTC81?=
 =?utf-8?B?N0U1cWU3bXRCbjk5OUJvYmwxOGFBY2JUN1RlSTRzR2dGOG5GTUZhVDMxUFlS?=
 =?utf-8?B?ak9LSnQyS2tUNEZoelJNVnNlTDc3Y3M2Y1lBbUVvdG5rYmhxNGFtTjlYR2lM?=
 =?utf-8?B?RDNDN0xUVmhXR2RXUkRDekd3TFhNRStobjNLOTk2WDhINHlnZ2NnOWc3MTNV?=
 =?utf-8?B?SmFhUDZHVUYzc20vYnRkYTBaY2tKMS9ZcWcwOUdDeDV0elh4Vis4emFKZEEw?=
 =?utf-8?B?bjVvRDJ4YzBGOU81TE02K3MzYkU0akZzekFGVk9RMXEzcXRySUtiN3J6amtj?=
 =?utf-8?B?QXFSM1ZGY0t2emJQelhPWndUeG5SZWt0NDU1Z0l2eG9XN0I5QXREbURFaWlR?=
 =?utf-8?B?ZGFRWm82Q2dtTHdKeGJhZVFxUHhNeTlGM2hhKzZNeXBTSml5dWlHZ055Rm1P?=
 =?utf-8?B?MFhJV0h2OEZPblE1d0dsSWRkVXMyN09qRnV5TjJibmxOb0RjbEF6dXRNellQ?=
 =?utf-8?B?S0I4aER5VzQ5S3JOUmYyQmtXQ2pKS29qdHArZDRqUUEvYm9hWEw4ZEh1UnVm?=
 =?utf-8?B?LzhHSlJnalRLRTlPN1ZwZXEwYVpqc0o4bGlQMzQzd3BaZnZEYW44d081ODRp?=
 =?utf-8?B?SE0yUVUySDJFWVgxZTAxL0M4MXl5djlHYmFMQjZGRXkxRTNmQ1R2NVdTVUlF?=
 =?utf-8?B?enZ0dGVVZVZIR2VCUnlWbVZRcHo1YkFvODByeTR3Yk93VHNtYUVJcHNZTHY0?=
 =?utf-8?B?TTJ2bWN0dzh3WllPOW1KT0VaVjE0c0o0REtEaFB6UXRlai80VEdrUW45UFhK?=
 =?utf-8?B?Q3lOSWNsNFBDQ0RndnRReEwvMXZjU3cxUjJtRFg3ZVJrRzFrMm9iOHJFZE9C?=
 =?utf-8?B?bENLVmdLUEVuWTdYblBzR2ZmUnV6SWlEVGhQbHRhMjNnYkxRTTZJSmREd1Bt?=
 =?utf-8?B?WVJCRzBWbGpxTkxxYWNuUzNMajZDa2VoalpDdTVTb2Zta0hEOFBMeDZTT2pE?=
 =?utf-8?B?MUo1R1J0blJvTVMrc3BhZmRiUWhKMVBXV1RQcFBFbm1ET2ZlOFpWZ0dSU2p5?=
 =?utf-8?B?ZXpJWWFleUhRbGFBR1oyc29wV0M4UnBDUU9Oamkrd1NtcC9Za2NkaHlPYTkz?=
 =?utf-8?B?cFBmOEN2MTJoRnZVQldvclUvVXNXYVdFOS8zdjVqTy8xV2tab2ZickFDREhF?=
 =?utf-8?B?WHpyY3A5QSs0amhiV1E0TlJnakRHczNzaC9HaVJmUWcza1U3eStGM3F0N3cr?=
 =?utf-8?B?NnhLbWRUVks4T1h5L2ZZUFVnNFFBNDZrbG9vM2p0NVhuVTlCb0xQUmhpWW9W?=
 =?utf-8?B?Z2FSZVc5em8yQ1BROFZNUVovSEtKdEZjcVExWTA0dDZQN3BpeDJUSmpGcWxV?=
 =?utf-8?B?OTc3SzJrMXhnR01ZS0w4R3NQSlp5QTZYcDd3WlpkQU1wdTZ2OTFqQUFOWlRk?=
 =?utf-8?B?S3BJV1RCTWcvSWpTN3k4NjcrSCt6K1pPRkc4RHVrcmgxcVo4dm5ET0h3clVL?=
 =?utf-8?B?VExlYnI4bHNXR0d5a3JEMG1LUXc5ZDZHVzh2VXNRRkUrK0F0Z2hDcE5ENkgx?=
 =?utf-8?B?ZHJiNjFKazFUTTBVbm1PQ2tJVlVja3BjaEQ3ekREQnBsekVQZnNvL2ZLcG05?=
 =?utf-8?B?Q2hQMWJncjBvRWhFNlowU1NnWEFCenVLckNOTmRvZWxWK3V6R0padHFuUDJE?=
 =?utf-8?B?ekJRWURoczIrUURobFJDQ2lwRWRCMFNITHRDWWRpTmpQK01ZRmVPcHZXWStu?=
 =?utf-8?B?VHhRUFE4L2VlSWtVMnhXdkJCbDkxU2ZjdUM2NlJMOURMTDQ2dGV3TTYzMXNF?=
 =?utf-8?B?eDZHOTU1SnErMGRqZmQ4NE13NkI3MTRNVG5vRWJWWWUybzNSSEZMSVVieS8x?=
 =?utf-8?B?WTNpa1JpSTV1dmxpWDlZdGh3cUc1a3c3TEYwdlV5MXE5RXRGcVQzUXR0Z3N0?=
 =?utf-8?B?czZUd1B6R0VmTks1L0l4TUhUUDB6S2NlSVg1Y0ZEbW5Xa3JMMFZzdGhscnJE?=
 =?utf-8?B?NlRPeVVUYVZ5N3llV2gvanZKQ2dRQ3g2eHhhalM5K2c4RWREcjBZU2xkWHlM?=
 =?utf-8?B?cVJRUmYrUFdEUFNlS0JjT3JCay9DdFVjMzArc0lUa2xjMGFIdWd3Q1lMa3V3?=
 =?utf-8?Q?kTDQeCpeBxNPOilBbz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fc54ab-7432-452c-3788-08df2b642b76
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:02:13.7874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbhIePBXE15RV5CzDvfYmQBsPZuTWVGc7D1krO/KcBfy5edLK+kdTrywvG1xlj/9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076

On 10/16/26 05:25, John Fisher wrote:
> Thanks Christian. Since I don't have commit access, I assume that if
> all looks good the commit will be passed on to be applied?

Alex usually picks those up after a few days and merges it into amd-staging-drm-next.

Regards,
Christian.

> 
> Thanks,
> John
> 
> On Fri, 9 Oct 2026 at 20:00, Christian König <christian.koenig@amd.com> wrote:
>>
>> On 10/8/26 22:45, John Fisher wrote:
>>> amdgpu_vm_make_compute() switches a VM from SDMA to CPU page table
>>> updates when a KFD process acquires it. It syncs "with the last SDMA
>>> update/clear" through amdgpu_bo_sync_wait() on the root PD, but that
>>> walks the reservation with DMA_RESV_USAGE_READ, and the clears of the
>>> VM's page tables (the root PD from amdgpu_vm_init(), and the PDs/PTs
>>> the seq64 mapping allocates at the render node's open) are added there
>>> by amdgpu_vm_sdma_commit() with DMA_RESV_USAGE_BOOKKEEP only:
>>> amdgpu_vm_pt_clear() commits them with a NULL fence, so they do not
>>> reach vm->last_update. The CPU path's own waits (amdgpu_vm_cpu_update(),
>>> amdgpu_bo_kmap()) use DMA_RESV_USAGE_KERNEL. None of them waits for a
>>> clear that is still queued.
>>>
>>> When one is, the CPU writes the first entries of the new compute VM (the
>>> KFD trap handler's TBA/TMA page at AMDGPU_VA_RESERVED_TRAP_START, mapped
>>> during ACQUIRE_VM) into a page directory the SDMA then clears. The
>>> entries are gone, the handler's page is unmapped, and the first wave
>>> save of any queue of the process faults in the SQC instruction fetch at
>>> the handler's address (GCVM_L2_PROTECTION_FAULT_STATUS 0x008012B1,
>>> PERMISSION_FAULTS 0xb). The MES then fails REMOVE_QUEUE and SUSPEND, and
>>> the device takes a MODE1 reset with VRAM lost on 7.2.9; on 7.3-rc6 the
>>> queue is reset instead.
>>>
>>> The window is the time between the render node's open and ACQUIRE_VM.
>>> ROCr spends milliseconds there and is practically never hit; a minimal
>>> KFD client that opens the render node and acquires the VM at once is hit
>>> most of the time. On a Radeon AI PRO R9700 (gfx1201, Resizable BAR, so
>>> vm_update_mode defaults to CPU updates for compute VMs), a wave reading
>>> the trap handler's page right after queue creation found it unmapped in
>>> 8 of 12 runs; a 5 ms sleep between the open and ACQUIRE_VM made that 0
>>> of 9, and the same sleep after queue creation instead 3 of 3.
>>>
>>> The wait covered these jobs until commit 926c79ad6ecd ("drm/amdgpu:
>>> promote the implicit sync to the dependent read fences") narrowed
>>> amdgpu_sync_resv() from DMA_RESV_USAGE_BOOKKEEP to DMA_RESV_USAGE_READ;
>>> the VM's page table jobs have been added with BOOKKEEP since commit
>>> 4247084057cf ("drm/amdgpu: use DMA_RESV_USAGE_BOOKKEEP v2"), so from
>>> v6.16 on the sync in amdgpu_vm_make_compute() waits for nothing of
>>> them.
>>>
>>> Record the clears in vm->last_update, as amdgpu_vm_update_pdes() does
>>> with its updates, and wait for it, uninterruptibly, before switching the
>>> update functions. The clears all go through vm->delayed, so the last one
>>> covers the earlier ones; immediate clears are not recorded, as before.
>>>
>>> With this, on 7.3-rc6 and on 7.2.9, the same client reads the handler
>>> 10 of 10 times, 8 busy queues on the 4 compute slots complete in 5 of 5
>>> runs on 7.3-rc6 and 3 of 3 on 7.2.9 (1 of 6 before), 16 and 32 queues
>>> complete on 7.3-rc6, and two processes with 8 queues each complete
>>> together on both, with no fault.
>>>
>>> Fixes: 926c79ad6ecd ("drm/amdgpu: promote the implicit sync to the dependent read fences")
>>> Cc: stable@vger.kernel.org # v6.16+
>>> Cc: Prike Liang <Prike.Liang@amd.com>
>>> Signed-off-by: John Fisher <jfisher84@gmail.com>
>>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>>> ---
>>> v2: wait for vm->last_update, in which amdgpu_vm_pt_clear() now records
>>>     the clears, instead of every BOOKKEEP fence on the root PD; wait
>>>     uninterruptibly without checking the result; keep the original
>>>     comment (Christian)
>>> v1: https://lore.kernel.org/amd-gfx/20261007200345.417281-1-jfisher84@gmail.com/
>>>
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 5 +----
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
>>>  2 files changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 29187fabc..757a037ed 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2737,10 +2737,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>>
>>>       if (vm->use_cpu_for_update) {
>>>               /* Sync with last SDMA update/clear before switching to CPU */
>>> -             r = amdgpu_bo_sync_wait(vm->root.bo,
>>> -                                     AMDGPU_FENCE_OWNER_UNDEFINED, true);
>>> -             if (r)
>>> -                     goto unreserve_bo;
>>> +             dma_fence_wait(vm->last_update, false);
>>>
>>>               vm->update_funcs = &amdgpu_vm_cpu_funcs;
>>>               r = amdgpu_vm_pt_map_tables(adev, vm);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> index c03327f12..cdbc2e931 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> @@ -427,7 +427,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>       if (r)
>>>               goto exit;
>>>
>>> -     r = vm->update_funcs->commit(&params, NULL);
>>> +     r = vm->update_funcs->commit(&params, &vm->last_update);
>>>  exit:
>>>       drm_dev_exit(idx);
>>>       return r;
>>

