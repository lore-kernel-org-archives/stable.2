Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6FC3BAD9A
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447226; cv=fail; b=tszdF+zXXc5J2meeGj3XLJUj4MvvgjrkJE2Ztfpaalfb0naRnjR9HHTmQK7+n7vrFd1eR0MKYQDR5P9W2HVlzrxjsWA94bEVu9SknmVgxb9juHB+dkI2AynDwZFI2gto12Ym052vV9PeCmtEEgN15M6LeM62w9Hb/as79yiOO8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447226; c=relaxed/simple;
	bh=51mfDQi+IkoSkDla2aFJYM5lLc1KHbcztlK7/wFOrG8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j+TtEbSulDpU/5cX16m0UCkG4ITA1wa+csLqQ72fzkTQw3zWvDqhBUGIcEyHnBEML35ExRutexX5r0/x7+nLMjXItuxCNUYlu0tx9sRvcwaSIjtpGJrRPveVZTcMuojL5M89AAWkkCUCL9lG3eWxAetVIZ9itbN7HJYJVsDgtxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1jS4LzH+; arc=fail smtp.client-ip=40.93.198.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1jS4LzH+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbE+pxoC6zirpL280/i2ZRpQO4gDw97BkE8ZM7J64B4+yv/tsDoNy/YzmNVQ3QpLxi+2Jz1DYO7LrDN/bqrwjdExepbB19ZG7S7ZzOAa/XMoqI3rN6Goaj8nERp6dj4fD9XZxXJm9y7kUtcPAQQbAHispXXgCMTZ2FecfmaOIkpfmVFxm9y5QP6nQsMgZNpImi+r3q+faufL2LDZiiPuJZtwYJ++STpjsZyajxqq+fVAw6oqSRlz78H9w2krz9hlysIT5M4V/9gThr/bRZN94rhiqe870Pa9dTC1k75fGFLrdUKjNWkYMHVkifKHHXYeWqu+6Ehkwk/qJza0ZvCu5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45KCoUNQtjBtHJqJJzeijZwKSssPRfJIgsz5PDRdEUM=;
 b=IKNLBY+KheJIGJpESGwv1gufhpRNjZuZYfdGBGzSiO+EvglpIMq0QMu9k/L0Lb7CI3xFirDYC/TIGFWedQ5QlNuH1SpBYM+XDjKO3TpdP/jryu22R30cqbo9g8l6A2pofVXtE2ejMmNu1G6ws8eVTTXQV1IoMDlOrhaQj164RoiFQciNQldc6FGBBd4RxW4n3a+VuG710chM0RNvs7HMJvTghG0xg/kBEXB1NEm3CG/XpiQiKwYKh4LRLVEAFleos7AWgYkmWHEJUw/BxYLBfwVNYXOYtksgMBIDvqWtOOv1xeb04JzeLrnpc0jP9dDQ3tg8NcDPhNn7R5BeFFkWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45KCoUNQtjBtHJqJJzeijZwKSssPRfJIgsz5PDRdEUM=;
 b=1jS4LzH+/eH5tngg5FHe1JZbjLm78C5A2fOvxTLWCxdyKCWovp/sXzhQ6Qm6wcqkwHTqYwtBXRGDhuWDDPUAlqbjIOAGPBxuzDCrUt0GqcNlRqu9WxSUEvtDCWS2VAK9a/YKJ7C4G+t2zwWOYKz7s+fwPvOT30olxbkh7FHDwXQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8072.namprd12.prod.outlook.com (2603:10b6:8:dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 08:13:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 08:13:41 +0000
Message-ID: <e14295dd-c78e-4604-ba38-5a03c8ffa7c4@amd.com>
Date: Thu, 8 Oct 2026 10:13:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: wait for pending page table updates before
 switching a VM to CPU updates
To: John Fisher <jfisher84@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, Prike Liang <Prike.Liang@amd.com>
References: <20261007200345.417281-1-jfisher84@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261007200345.417281-1-jfisher84@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 344f823d-c8a4-4dee-3b4a-08df25141000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|260925021911599003|3023799007|260925021311599003|260925022911599003|10067099003|5023799004|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DCfYah64uLFjANQioYEq+hAkim235RO3gvXTGXz8oKUf43O0IhEAmf4LZ6n5srrmbuSG+PN955rV13oipWn7awM3t/Snd2qcktkFJmTn0pw948MJLl8arJE7q/RF+usjyJnzgTTL4Bw5EOvW1P29PW0lAktLYGML8Yca1feXRh9omthWafn4f2UsIr2Fw4Umhr/tlk0MLUCdT3XQeY43TS0UiK5bdGEB6PkgrSFrJoql5Eo0l27xU++gN5bJyV5STuS2K/22MCcoV4mmdvnHvVI33E4U44V9b6sdZEROk/Xv5fqIOnCeVnMWZytBLJXZPj1QF6XhrCoYjyNN9BJZSGARZYl6BMuZwlhoM65TJEdfN5EfqIwZQ7dww+9k9YdGVLJ4+W6iax2CUqFM79kQryGqD/sHVVYFiOQCrh3U9IjO1yo0BBF+fPatqUgFfHfotYaktjfTMDdh5hBKoJ8OpLqBw9sSGISgRz1haBcQNAy9rZE3n5hJMt3GlnIcCu/tyXWxFT5feQproeIElzA1abOq6giFip+AATH26EbYY6GBPFETbWQX3PecET94oEg6q5V4BE+BcXlbS9/niPzWNdULduDz0HoCKO524MJ0qMD1F/EByC7fWIPxUmB/GcaIdKz127/G8kaxbRqXTOIfjy28JNW+koFX9IP8FHtiOmU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(260925021911599003)(3023799007)(260925021311599003)(260925022911599003)(10067099003)(5023799004)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2ZUbGp1OE1LTG5HeTdBZVNWSC9qMVdJR1FLTzlhNmU5Q0Z1WHpwS2diNVls?=
 =?utf-8?B?a3ZJNmxIUTB1WVNuL3BzcTBjeko3K1NBUHQ1N2ZHR1JiWm0vQlM4NXdWcWV3?=
 =?utf-8?B?VWlQbkt4ci9CMWVyYXYyTEIzYjdHRDNsYzdJRGhieTlpdUxtanlnV3Q5S2VY?=
 =?utf-8?B?MTJveDZUbGJIeVErN3FQNCtmb1pIUThGZ21XRE9PY3N2SEptdHkyVlk1aVNz?=
 =?utf-8?B?VEY3TU1PVmFqKzlwWTUwTEYwZCtyMGZlVmFTZFJQSG9rcnZ3Vm13MXNNU1lJ?=
 =?utf-8?B?S056cVpOMXAxV1lzMFQrM0M1Njg0cjdCc0d6TWVxQUdvOEI1NWJJRThXUWNP?=
 =?utf-8?B?NEVENzZGQXhRcENnZTlrNWZyMTdXd1hzOWhMUC9iQjR4L2VVZm5YUkpSVklE?=
 =?utf-8?B?U2lkY3VIN1VPQXFhYysrWVJXYVZWR3JkaVBYN0JmR2R4V1Y0R0Y4djMrSG95?=
 =?utf-8?B?aDhxbmVVdzVISHRHNHcwRE83QmJDbDRuUm5raUYrMXhJUGJva2NuTFk3NFEr?=
 =?utf-8?B?RE9Qcm5pVWhRZStQSzJPa3A3UXlwS0pka01wdXJQVGFsdFNob3o0djJla241?=
 =?utf-8?B?VTZiNWFLR1Z5ZjM3SG9WRm9HTTBtU3h1eGROVHhNcXd0VFRjbUE4UmRSaGg2?=
 =?utf-8?B?UTRrWTBlSUVRenlvQnkrOXlUb3BkbElpTGdzUEVMa1YxdWN1M1FHZnVjQVlv?=
 =?utf-8?B?WFUrNmpHOEJnSG1nZXlCNk52QU9ScTM1Z2dmaUtaNTNCaTQ5MFA0cndXMGF5?=
 =?utf-8?B?ZVBRS0ZkRDFhNHo1ZFkwMmFuS3kwRjVadFIxblpZNDl0c2xuMWNneXhpOTFv?=
 =?utf-8?B?V05PT1gzaFZBNkRQVXZieERCV0pkWWYyZGpJT0FhTnFFUnBjYThxWnpQQWww?=
 =?utf-8?B?NkFDZi91ZU1hQ1hQajNIYlhSVVgwbS9zaDl6VnM1bjBlK2FzSHdyQjh2L1Zr?=
 =?utf-8?B?ZHh5b2kyRng1MVVTQUUrL1VNSzQzcitsQ0ZleUtUQzBoOTdsL2RWS1NIa3d3?=
 =?utf-8?B?QjdMeHlzWXJ1YnFicmF0UncydmMweUNsTlBVSDVwbnhLd01Xckh3dTNlTmty?=
 =?utf-8?B?NXZ2Tk1qY3pGd1diM0N1VnZmdUVxdEpSTkxWdWQ3R1l4b0dFNWgzUkpRUEVs?=
 =?utf-8?B?YnNJNjNYZi9tUHRIdHRmRlJseW1OWkwvZVh1K0Q5NXlrMWNlN1VselNTNU8r?=
 =?utf-8?B?VUJVV2VYMkdKaXV3NHZZdCtMelNKQjhIYnVIZzUvQXh5M2hmRXRVWVA3aVBD?=
 =?utf-8?B?WS9ST0JCdGkvZTkxenp5N3h5YjV6RkRvR3pKRzM3MTBCVEpJRXBRekNFUHln?=
 =?utf-8?B?WXp5UlU2TzVOZHU0aGZ3VEFmWkhSbURGSThEV3F6TU5zMmY5bXZkdytJSFQ2?=
 =?utf-8?B?blpYQUFuZnpibE52K1ExMVJlSGZDR01GcC9LYlZsdFQ3di9lS0MrczZqMFU5?=
 =?utf-8?B?ZmpIQnpZeXRtYVNUU2tkazdMbHRuY2FlMVFPNi9Sbk5RblhrY3J0Vlh3NDVI?=
 =?utf-8?B?amZkaEVMVkpvWVZZVmFENDdleVlnMUhPZ0Z3Y1Zpa0FEWnV6clpwb3NGeURi?=
 =?utf-8?B?bUJzZzduak1PN2Nnblpnclo0QkFtVHFoeC9hSXBUUHpIZHBHcE9vWmcveGF4?=
 =?utf-8?B?VUtwODdVZTJkNkYrd3pxS294RHhEZlgyVkFReXdsWnhnS2VRUkdyQUMyU2lX?=
 =?utf-8?B?YWY3QU5iWEJGWEl0SjBYOWoxUU5VdFhaMHQxK3U3OVVTRkxUZlhHVzM5ZE54?=
 =?utf-8?B?dGZtNEZ5SEV4ZlBhTkZTL0JFNlFrenEwVitXS2x4RVJqYlF2blRua3Y1ZXZG?=
 =?utf-8?B?MXgzMU5hU2tQbXVnUFYyeHlOVlRNVlE1SGZGZUU1WCt5SGluQkJCOGVSY2FP?=
 =?utf-8?B?QVZma1lmVHlzWmxuNzhSam5xeW9haXcrMFpCc2ZEYnJuOWJzVVhrVVVQenMy?=
 =?utf-8?B?OHhRd1B3YWdIN3M4Zlh3QUEzcm5mSG9hYWJmeExxcUYxcXcySWliRzZ0SUJu?=
 =?utf-8?B?ZE93RkNabmdySDg1bk1ZTFB6d3N6bTFJVE9oQVJSVUVpcXdIL25lUmdxS3U5?=
 =?utf-8?B?NnhBTFVJQjRUbHZocnlQcWpDMGtlNHgzU2t1djE2MDlDOXhTbm1PTjF2TFln?=
 =?utf-8?B?bkJ5WkprMC9zSDZoOElQZUZ3QnE1TElCWHBUa21KVnZCdkQ1eG12WVNkaksw?=
 =?utf-8?B?YjFOdmppNi9pN0QwaVRReWdrZ1dDN0tLQi9BUysvMmlnYzJhU2VWRVgzMUZL?=
 =?utf-8?B?YUN3bGhLT24zVGFqSGxOUHA0NWIrRmlaN1NZaWM1OGJKM0pGYWs4eXhKVWdY?=
 =?utf-8?Q?HOzBIX86lyEQEuCCC+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344f823d-c8a4-4dee-3b4a-08df25141000
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 08:13:41.0195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/NytTaa+wIVkPdstvxDQgsAo1IS3sEHS3NqkjTBxqHh86y4ezx3fFpXn70bTRa7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8072

On 10/7/26 22:03, John Fisher wrote:
> amdgpu_vm_make_compute() switches a VM from SDMA to CPU page table
> updates when a KFD process acquires it. It syncs "with the last SDMA
> update/clear" through amdgpu_bo_sync_wait() on the root PD, but that
> walks the reservation with DMA_RESV_USAGE_READ, and the VM's own page
> table jobs (the root clear from amdgpu_vm_init(), and the PD/PT clears
> and the seq64 mapping from the render node's open) are added by
> amdgpu_vm_sdma_commit() with DMA_RESV_USAGE_BOOKKEEP. The CPU path's own
> waits (amdgpu_vm_cpu_update(), amdgpu_bo_kmap()) use
> DMA_RESV_USAGE_KERNEL. None of them waits for a clear that is still
> queued.
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
> Wait for every fence on the root PD's reservation before switching the
> update functions. With this the same client reads the handler 10 of 10
> times, 8 busy queues on the 4 compute slots complete in 5 of 5 runs
> (1 of 6 before), and two processes with 8 queues each complete together,
> with no fault.
> 
> Fixes: 926c79ad6ecd ("drm/amdgpu: promote the implicit sync to the dependent read fences")
> Cc: stable@vger.kernel.org # v6.16+
> Cc: Prike Liang <Prike.Liang@amd.com>
> Signed-off-by: John Fisher <jfisher84@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 29187fabc..8d0c03a40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2736,11 +2736,20 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>                   "CPU update of VM recommended only for large BAR system\n");
> 
>         if (vm->use_cpu_for_update) {
> -               /* Sync with last SDMA update/clear before switching to CPU */
> -               r = amdgpu_bo_sync_wait(vm->root.bo,
> -                                       AMDGPU_FENCE_OWNER_UNDEFINED, true);
> -               if (r)
> +               /*
> +                * Sync with the last SDMA update/clear before switching to CPU
> +                * updates. The VM's own page table updates are tracked with
> +                * DMA_RESV_USAGE_BOOKKEEP on the root PD, which
> +                * amdgpu_bo_sync_wait() does not wait for: a clear of a PD still
> +                * pending here lands after the CPU has written its entries.

That comment is a bit superfluous, it describes the what and not the why.

Just keep the "Sync with last SDMA update/clear before switching to CPU" or maybe change to "Sync with the last async SDMA update".

> +                */
> +               long t = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
> +                                              DMA_RESV_USAGE_BOOKKEEP, true,
> +                                              MAX_SCHEDULE_TIMEOUT);

That is quite suboptimal, we don't want to wait for the BOOKKEEP fences here. And drop the return value checking and wait uninterruptible.

Regards,
Christian.

> +               if (t < 0) {
> +                       r = t;
>                         goto unreserve_bo;
> +               }
> 
>                 vm->update_funcs = &amdgpu_vm_cpu_funcs;
>                 r = amdgpu_vm_pt_map_tables(adev, vm);
> --
> 2.55.0
> 

