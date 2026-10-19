Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6026364934;
	Mon, 19 Oct 2026 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398743; cv=fail; b=Bp5fQ98srr6y5OCrkilRaZtSpd290gVaMr5Ib8P79NmEZBpgdj0FKT0V5zZ3Tpr41KGIjm9fBo3q4mIR6Y9muwiMLQeCbfj6DrOGd5sgkV8Z5JoLVip4BMT2YghDtW4PiPfWO/uqO57uTEoSJh9vlrOoUEDmQ+f3vPDadtucJEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398743; c=relaxed/simple;
	bh=E+Fy6qy7lQrhIVWiNkFA7XzUhjBYGxlf2XZnWzOibiY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b8sizeYTlWzPti3BZVM6EFuYEaJrTW27geVApScyfzuRp7PSeOqWLZkEYv5rOZpFk5NP2vLZ2O9VxelwSYc2XVdRr/A+cscDALxce1kNCZnWUMvpVrCVWEth8cc5E4ZN/EchlWCR4dBZgN68K3oZe8qq175jwT9d0N41Uan/3uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y8++olys; arc=fail smtp.client-ip=52.101.193.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y8++olys"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQ+/rOafiRvZFI2ZknsY9eOtlFeEPNI5kZDMwoyRQyQUSXjUUkb69hw/UKneeGfmZaUQn1tSgS7cd8HWH8hclSN2qSLx+yG76+1izluPO7aIdD6qBRMu02+DUkORFhY4NooZPYDMzZo4vj5NoD7Hp7DdVuHtKJoAuVc8q1DKqBv8QOHlDO7xY4Xl3IbL41pFt8ht0qTPXhvvi0JQp1+l2efG0ZgMDT+WurdrvIgBmVp++I068bDHvXTEVSz+IWRh0hmhzbVbSQgGLmtFHxyCMziJmQCb/xOnJUM6eP/G8YwLMH4qVDj2DVwWA9g+w1VSSFsTZD0zGROaQ/kU/kZotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLTtQ+QLy21/X5ReLRuGW8WqtiPwXVn09E3zjooxMIY=;
 b=QnT7bWZPE2TqAab5XNjpJ5AGf9ONXm0vTpZSov79HKf0IQZujtICXlZsvIb9SpQy+dPXKXqVngTm+Sns+8pYvGj1CHQto0hJcYMD8TPjTSjF/E9EOND8s9xGQhf3mgL+sYWlYcf6mksKEZttS9I7ZYyAmPpI2zDDqL5W4QENhEMDIkJGBr1QRfWRScw3FtNwQWngX/PSJyCLycSuCSj+8F42fN44HlD6X9aRcgtqeJgSWxs/uxPbCaBXk2PD4IL+6UBDKcccflDgj72UIRWisaAbTW517pC/JJWACBDdzWG0r4xmIjjyESLDwwSuIldiDyJsHIXDuL1+SjG9yCT6Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLTtQ+QLy21/X5ReLRuGW8WqtiPwXVn09E3zjooxMIY=;
 b=Y8++olysa7K8l4Pd3jx/oG8FwH2zb4T/TiF7r8PrnFCDy2P+Jqhqnd1lMsuOwmm5ui/WAIx8p0FirUh5RTc+U4QMp1BHgpKeEcCaJcyt3djMSCNgsAVQi3wQJrUZhwSFo0CfCwg3W9C16URG8hi+ylSjB1uKgtQ/nouEhomoAhU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Mon, 19 Oct
 2026 08:32:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 08:32:19 +0000
Message-ID: <d15dc783-04ca-493c-ac9d-cda406fc4731@amd.com>
Date: Mon, 19 Oct 2026 10:32:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: disable SVM when the GPUVM cannot cover CPU
 addresses
To: Felix Kuehling <felix.kuehling@amd.com>, Daniel Huang <danielhu@amd.com>,
 alexander.deucher@amd.com
Cc: alex.sierra@amd.com, Philip.Yang@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261016145129.69645-1-danielhu@amd.com>
 <8a0a2d4b-ee31-48f6-8a44-d5a7d4af579b@amd.com>
 <48db6848-50a9-42f1-81cb-fd4c7e726671@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <48db6848-50a9-42f1-81cb-fd4c7e726671@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:208:256::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c7461e-7fbe-471e-a1e6-08df2dbb7ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|261009223027099003|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	4tTRk6VL7Sb6NNaD7pzUvXz2RHKpj2d+Av6RLOfrwS9DnMxFwEPuJVehqyURG1nKmHqlRQEHB+rk9YUVM1sM93kDP1t0IpqtY3ItHXqmsbqEzY2Q0PrMmN1XwLcjTYMdFpJtrNjOVbTYLf9+MbQ7if9fHdZ0hnCBp5K+xu+e74JBoZflSwdKHyp5U2Voo7RBP+m+qRFmZ9mUU2Mw09zlttBN/Oz2a9HydPUEejHtme5ku/tLmFXiN2VqNfvVUUjjWE7V8LhJdS+j559h5aj4N4AHouvKsLNPLNq7EUWdBXC+y9HU4x6MFe/C7gaqR+jybtph1uygZCCVEl6uMmvUuNqDsEwyB0yJZwKoxrsN5A+bKZOQkJ+aXLHKmjjaGIdAngn6lMEAcbaZEqrg7Bt4Ok7hUjsDxrIQkvzkXAPDX58breqW9rtBVKrh/MScmdFGtBxz/1xU5gLedybpj9+0U1yekxLt9D+sgznHsTMu9oJbnVp3G71JCOgM80IxIcg7+ivWQFeiQavTIqUClN3nFZ4p5sq4DZPoqIWypw/izNKO1G3kbzTlKdW+BQbFF0yUY9YS1aVfkgfr4AxSqStxybNPzYncp7MKQyy5uf5fMCrRBN3AHP0mof4So5JlG1YN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261009223027099003)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enRCMHVWUmdqdDcrT2U5VTJzYUZaS0kyNU1pVW5Bc2tCWjFoc2wxNDhGT2Q4?=
 =?utf-8?B?cExsbnhjaU1rR2lRaDhpaDFnNnB2V0hvVFVJT2QyblU3N1c2VkxKYkVadDJW?=
 =?utf-8?B?TmZTSnF0Q3ByUzZsZkJ5MkFWL3NWQ0lGZ0JrR2pyRG1SVkgvVzNSWWVMSXIr?=
 =?utf-8?B?TlFRV1RTcXZObGxtVHRxWGlxNzVQVzIxa2kvL2NZaFlJOHFqM1Q5cWJ2V2gx?=
 =?utf-8?B?a0J5UXk1RVFhME80VmJRakFQZVM1QXFEbUtpVlVDMUc0d0NuazB3M1NCcStB?=
 =?utf-8?B?UHhqcmJsYkphUVpYNWxXMTIzRXNhU0d6b1RkOEwvZXk5dDgwZFF5TjMwZ3F2?=
 =?utf-8?B?NXlRK3kwNGZsdGFsYSt6eEpPelpBWllXdlRZRXFqZFFzUDI0SWhZcUFjMlVu?=
 =?utf-8?B?OGxzN0N6di9mMlNZKzJSTlpuNEl3ald4QjFja1BWcENHMHRwcXp0bEVJOXFP?=
 =?utf-8?B?R1E0bzgxbGY5Mm5CZ0ZaSkRKaGdreG5oalZMcDVydkxINnU3T0dRTG1nRUhW?=
 =?utf-8?B?azB1RzFudWNYWnVOdksyRmR5K1UwZzZxNWJ3OXYzdVlKd3B0SVpWbERCcGZi?=
 =?utf-8?B?cjY3N20wL00vbHk1T25JWUhOSE5ZdWQ4ZzdhbFNmeXhmU0ZqMWxpU2dZVHFn?=
 =?utf-8?B?Y2xRa1RMUjZ0NTJnOUc0UXQ1S3RkczluTVlOUkVKRTh2Szc5R0x0QmxDUm41?=
 =?utf-8?B?RitNWTVvUzFQRmlmcjlscmY4S2lmWW5oaUxBYWwxSCsyK2JRSEFEM2wzNmxI?=
 =?utf-8?B?d2RFUXFFbkVLQWlLdFN2UHZTZDJyL1JOc0Z4bWo2RVVPaG5RWktNaFVBTjNW?=
 =?utf-8?B?YjlCZkozMEw4RTFOdkpVU2Z4NEFDOVZnd1FJaGpBODd1cGNTNnFpZzJqcUYv?=
 =?utf-8?B?ZDM5dFhKenBzYnNzVVpFMXFPQjdSS2JLdHVJaTY5OXk0bm5YVTFxRjFIMEJn?=
 =?utf-8?B?WDM0bDdLNVRzMXVhTzdDWWM5OFBUMElNZENIUUZOTVdGeWFURTRhS1VXbmdy?=
 =?utf-8?B?dHlHdUJIZmhxTnpPOE8zbmo4NFMvdWlZYXc5NzE1SmNkRFVKNVkrakd3b0NZ?=
 =?utf-8?B?NHpIaHU3Zk1WLy9LejcySlZUS3p5dUo3OHJRTzg2eTB4aklmZXVGU1dJVXJ1?=
 =?utf-8?B?STNpdGhxS3laeWFxazNZN0xzMFYwR3czM1paRVRYNlVOandic2lNWVdxTXhX?=
 =?utf-8?B?UlR6eGtIS0t5aEJMWEVnalRhYjRqenFiSlNXVUQ5NjdrcVc1end0YllHZlha?=
 =?utf-8?B?aUFCdTZ4Ni9NcjlBZGwrQmo5UURlNnltN2lDclhZejFzanlUaFRSRXZOeVFo?=
 =?utf-8?B?TlBiRlkzN1BTVnFvOXJpSnkvVlJ6SitNQ1ExanpKdlZ2dHJIT0E1RmZHWjAx?=
 =?utf-8?B?MFFxcmFaa1drN2MyZm53aDUrTFFUaFpEN1I0TXZGSWgzOWtMcnVnZG5IazZK?=
 =?utf-8?B?TXhIK0NlZ1BwNHpBczl1Y0dUNHJlc1dPTjM2SFJyYXlxUE1ER3JGTVVqcmkr?=
 =?utf-8?B?dDlnZXR5SjhKWFBNSXF3RVh3UDM5Nis3Nzl3VzU1b2xKY05zSUZQWG9GZDJv?=
 =?utf-8?B?MzMwQWhuRjhsZzE2dTcrTVNlY3c4bDBQV3dZbEhhcnhPaWpwRVhESW8wSm8y?=
 =?utf-8?B?ekFFREFvOWdGbmlXQ243dUtKSHJVcFE4SmE1cTNNZnc4bWtaUFBJV285Zmhl?=
 =?utf-8?B?MTY5bmF6OHpqLzViVjFrdDZpTE9oMjdMaS8zbHcyMlFMZFNvNUwwb0tkM0hu?=
 =?utf-8?B?Y0VDMmFHSFNvL2FuY20yNURqaDVuUXc1alJLM2RpU2IvbHpDakFYcjYwbWhv?=
 =?utf-8?B?ek1EWlp3N2xKVnpXZ1VkcDFRQjVzQTJUekZUZEl5dk1OQ2djSVNtSFlJZGY2?=
 =?utf-8?B?NDFXMXMxRk5sZXhjVkJ4QW80Yk9helAxK21veDRJMzN4bjVacDdBYVJrR0xa?=
 =?utf-8?B?b0pTUGMvditOZUVwQlZTbUszWUo0NGNpM3JOV2tDQ1RadzdpcW9Cbkkvd2R5?=
 =?utf-8?B?cnBDNnJ4bmZYZ1pKcGVlWjhnRFpOSnVkRkhmclMybElSYTBCclMvWUR5bmpy?=
 =?utf-8?B?bW56Ny9jQ05lZktLZ2tIcnhhL2lxVytDVXgzK2YwSm5oWVN3Q2UxU2dpbnBY?=
 =?utf-8?B?Z0QvNFZjellZNlY2NGJJTS9ybWpVeEJVK3U1TS9zTnFhdWxPWW5yZDRhQXE2?=
 =?utf-8?B?aE1OY0VLSXovZWIzemxqQVpqcE5jbk9CeElCaUNLR0VmT0ZmbTJRVDRIblVK?=
 =?utf-8?B?cEZSV25ldy9lcnNLQXEvNHU0d1NLRmp2TXFVRWpkRFN4N1BsTXhVSW1IYXZB?=
 =?utf-8?Q?k74jAw3Su/pmC3pn5X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c7461e-7fbe-471e-a1e6-08df2dbb7ced
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:32:19.0007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWkjWGN4GzBchUFj36yERamTg3pnfvFesxLuFSzs4+FEMRirfnGwBN3ge8KoQ4o/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298

On 10/16/26 22:02, Felix Kuehling wrote:
> On 2026-10-16 05:09, Christian König wrote:
>> On 10/16/26 16:51, Daniel Huang wrote:
>>> KFD SVM maps memory in GPUVM at the same virtual address used by
>>> the CPU. However, svm_range_map_to_gpu() passes the corresponding
>>> PFNs to amdgpu_vm_update_range() without checking them against
>>> vm_manager.max_pfn.
>>>
>>> If the GPUVM address range is smaller than the CPU address range,
>>> the page-table walker can index beyond the allocated root page-table
>>> entries. Unlike the SVM path, the BO mapping path validates the
>>> address range through amdgpu_vm_verify_parameters().
>>>
>>> An explicit amdgpu.vm_size override can trigger this condition by
>>> configuring a smaller GPUVM than the driver would normally select.
>>>
>>> Reproduced on a Radeon 780M (gfx1103) with amdgpu.vm_size=64.
>>> Repeated hipMallocManaged() allocations attempted to map CPU
>>> address 0x74bd48000000, well beyond the 64 GiB GPUVM limit.
>>> The out-of-bounds root entry contained SLUB poison with
>>> slub_debug=FZPU and recycled heap data without it, resulting in
>>> a general protection fault:
>>>
>>>    RIP: 0010:amdgpu_vm_cpu_update+0x2f/0x140 [amdgpu]
>>>     amdgpu_vm_pte_update_flags+0xfa/0x1e0 [amdgpu]
>>>     amdgpu_vm_ptes_update+0x38b/0xa00 [amdgpu]
>>>     amdgpu_vm_update_range+0x279/0x930 [amdgpu]
>>>     svm_range_map_to_gpu+0x13d/0x400 [amdgpu]
>>>     svm_range_validate_and_map+0x8d3/0xaa0 [amdgpu]
>>>     svm_ioctl+0x66/0x80 [amdgpu]
>>>     kfd_ioctl+0x40a/0x650 [amdgpu]
>>>
>>> As discussed in [1], rejecting out-of-range PFNs in
>>> amdgpu_vm_update_range() is too late. SVM must not be initialized
>>> when the GPUVM cannot represent the required CPU addresses.
>>>
>>> Prevent this by disabling KFD SVM support when the GPUVM address
>>> range is smaller than AMDGPU_GMC_HOLE_START. This prevents
>>> affected devices from advertising SVM support and excludes them
>>> from SVM mappings. Warn from kfd_update_svm_support_properties(),
>>> which runs after the device memory pgmap is registered, so that
>>> only devices that would otherwise have advertised SVM report the
>>> loss of the capability.
>>>
>>> [1] https://lore.kernel.org/amd-gfx/da43b0e3-5bd9-4aa1-86d3-b733f3bad108@amd.com/
>>>
>>> Fixes: f80fe9d3c114 ("drm/amdkfd: map svm range to GPUs")
>>> Closes: https://github.com/ROCm/legacy-rocm-build/issues/6691
>>> Cc: stable@vger.kernel.org
>> I think we should drop the Fixes and CC stable tag, that is not really a bug fix.
>>
>>> Signed-off-by: Daniel Huang <danielhu@amd.com>
>>> ---
>>>
>>> Tested on a Radeon 780M (gfx1103, PCI 1002:15bf), kernel
>>> 7.0.0-38-generic, and ROCm 7.13.0-2.
>>>
>>> The reproducer performs 24 iterations of hipMallocManaged(1 GiB),
>>> hipMemset(), and hipFree() per run, with 40 runs per attempt.
>>>
>>> With amdgpu.vm_size=64:
>>> - Stock module: kernel Oops within approximately 2 seconds on
>>>    every attempt.
>>> - Patched module: completed 40/40 runs in two attempts, with
>>>    stock and patched modules tested alternately on the same kernel.
>>>
>>> With the default GPUVM size, the patched module preserved SVM
>>> support, emitted no warning, and completed the same test.
>>>
>>> Two questions for maintainers:
>>>
>>> 1. I interpreted "SVM must fail to initialize" as disabling
>>>     the SVM capability for affected devices rather than failing
>>>     KFD initialization or rejecting the vm_size override.
>>>     Would a different approach be preferable?
>> I think that this is ok.
>>
>> The amdgpu.vm_size override is only for driver testing and not something end users are supposed to change in any way.
>>
>> So that here is actually a really minor issue.
>>
>>> 2. This check also affects GMC v6/v7/v8, whose GPUVM address
>>>     ranges cannot reach AMDGPU_GMC_HOLE_START. Although these
>>>     devices do not register device-private memory, an APU with
>>>     apu_prefer_gtt can currently advertise SVM support.
>>>
>>>     Should the check apply to these devices as well, or should
>>>     it be limited to explicitly configured amdgpu.vm_size
>>>     overrides?
>> So we still support GMC v6/v7/v8 with KFD? I think we have dropped that a while ago.
> 
> KFD SVM is not (and never was)  supported on GPUs before GFXv9.

Good point as well, haven't thought about that this limits only SVM support.

That raises the question what we do for the other userptr path?

Regards,
Christian.

> 
> Regards,
>   Felix
> 
> 
>>
>> If we still support this then that would indeed be problematic.
>>
>> Regards,
>> Christian.
>>
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h      | 18 ++++++++++++++++--
>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 14 +++++++++++++-
>>>   2 files changed, 29 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> index c7d7adae4476..6235ce0f988e 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> @@ -203,11 +203,25 @@ struct kfd_process_device *
>>>   svm_range_get_pdd_by_node(struct svm_range *prange, struct kfd_node *node);
>>>   void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_struct *mm);
>>>   +/*
>>> + * SVM uses CPU virtual addresses for GPU mappings. Disable SVM if the GPUVM
>>> + * address range cannot cover the required CPU address range.
>>> + *
>>> + * The parameter must be named adev since AMDGPU_GMC_HOLE_START references
>>> + * adev->vm_manager.max_level.
>>> + */
>>> +static inline bool kfd_svm_vm_covers_user_va(struct amdgpu_device *adev)
>>> +{
>>> +    return (adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT) >=
>>> +        AMDGPU_GMC_HOLE_START;
>>> +}
>>> +
>>>   /* SVM API and HMM page migration work together, device memory type
>>>    * is initialized to not 0 when page migration register device memory.
>>>    */
>>> -#define KFD_IS_SVM_API_SUPPORTED(adev) ((adev)->kfd.pgmap.type != 0 ||\
>>> -                    ((adev)->apu_prefer_gtt))
>>> +#define KFD_IS_SVM_API_SUPPORTED(adev)                    \
>>> +    (((adev)->kfd.pgmap.type != 0 || (adev)->apu_prefer_gtt) &&    \
>>> +     kfd_svm_vm_covers_user_va(adev))
>>>     void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> index 35b3abe57b80..5de19fa27d12 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> @@ -2471,8 +2471,20 @@ void kfd_update_svm_support_properties(struct amdgpu_device *adev)
>>>                   sys_props.generation_count++;
>>>               else
>>>                   dev_err(adev->dev, "Failed to update SVM support properties. ret=%d\n", ret);
>>> -        } else
>>> +        } else {
>>> +#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
>>> +            /* Report it rather than letting the capability
>>> +             * silently vanish from the KFD topology.
>>> +             */
>>> +            if ((adev->kfd.pgmap.type || adev->apu_prefer_gtt) &&
>>> +                !kfd_svm_vm_covers_user_va(adev))
>>> +                dev_warn_once(adev->dev,
>>> +                          "GPUVM size 0x%llx is too small for KFD SVM; SVM disabled (amdgpu.vm_size=%d)\n",
>>> +                          adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT,
>>> +                          amdgpu_vm_size);
>>> +#endif
>>>               dev->node_props.capability &= ~HSA_CAP_SVMAPI_SUPPORTED;
>>> +        }
>>>       }
>>>       up_write(&topology_lock);
>>>   }

