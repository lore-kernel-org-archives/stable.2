Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013059.outbound.protection.outlook.com [40.107.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863B3330641
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316249; cv=fail; b=o2LSICnfkYV/hLhClnUPcm0BD/xC/cjr7Qj3f5jHT0KdXfRYJwCL4AkN9QKaroViDUZa6vfOK4TCXE/rEuXNX4B0WnHFa1yIc5BD0ZTYV35R3FpA4iUyYbsYB4DNftxHtDyi1LBi8seWNng+O6gsTNjCIw+m27poNoNEVKZtdeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316249; c=relaxed/simple;
	bh=kVJgjRFcLEsaJHl9HVMOtsrObx5+qL2Iv7sq+uAUOrE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i7CMYyE/QFO8wu35GcGvDTkkF3X+aIPVhiDdbS77dg4zC6HcX90h1k623PsmZ2aBqo47sPWJ0DBsPhvwUQ0UzK4Chzq2jKDRWuH7ywEr/ri1LQuWXfqabU1Bx5zMT11o9YCQXFkxY1XEunSg6czvPMOuhMZLSyY24y0TchBeMa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mxxMB82Z; arc=fail smtp.client-ip=40.107.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mxxMB82Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJhlThZ4ha1jnnuoF637po+XCRBAnC+bsU9wRIzSeJTHUARtMA979ObTogvgIyi5LHhG6l4mi6+HWMaqUwdfzU1w+GhkjwK5Z6QNdxMA75XAiPe3IAhBJm07emCFTRBzXXZxpdx5xGml1oVPnxtV454v9DT5Bz4Bcf2YiPV357WuiFWnGP3gvCGNp9EyYHDknM/WTYQHFV2fIm9BPluhGrBxz7mXwZJnLKH0IPb/a2dAMeFKXADjAqFCGA5ik4IcNZ/tPKPiJlgMFGv5W+qoAAvw6Tk9yK5lJIfY8B53b6kiPBfoKMH9iN9m/x3cEPq/toZQ6EiHPXhKjJbfVPitQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BRBuSCfhBI00B9Ok3MnhSnA1agFeZHBJlkBiDvzDU8=;
 b=uIjGZpNcA7zUnPKLPFqF1RwS/kQ3u03tq9JnxUq/318WsO0hL2ZAi79pkSRct2i1upUovFb25eIR0uyEmWHQ9y1Akuidp9k4fteIUAqJMkL0vn1iPJaJHM2IDE+KuHiPNhKGxNThwb4Eq+X1tDfLldJt0sFfQu0HzPIsBxo1eznK3J2mPA+AEdZslBx1Tp2tA4qqF5QHeLg0rS486dc/CwxJX6pF3mApJAAScyg3dxvaf3mwJJ1viu4UJ8u4qPJrYByPmREi8ceRITZ/dI0Sv3isCCUC8krnSnVzDY5MFX1Y32HOd3dea5uiGB4oklxGURvwf2GzuG6D/ubewdB9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BRBuSCfhBI00B9Ok3MnhSnA1agFeZHBJlkBiDvzDU8=;
 b=mxxMB82ZXLtPNbu1P5lR+kYUUsBRpoKJtd8EaYSpH23KLJxNU2xOKOW11O5qhvDCiYzi8jvptOe7Bq38ukeZRIUJVwoS6Nha7Xo/60NDKuVaTJkY540AD64KS0ES8uY7LELHV2uH9IaquWzFqdvi5M1fRwviE83iG+SknjAyWb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS2PR12MB9774.namprd12.prod.outlook.com (2603:10b6:8:270::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 12:17:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 12:17:24 +0000
Message-ID: <157c5cfc-b0a5-4ee9-b91a-909e87df3080@amd.com>
Date: Mon, 1 Jun 2026 14:17:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Fix UAF in xe_gem_prime_import() on attach
 failure
To: Matthew Auld <matthew.auld@intel.com>, Nitin Gote
 <nitin.r.gote@intel.com>, intel-xe@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: stable@vger.kernel.org,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
References: <20260601101536.1333480-2-nitin.r.gote@intel.com>
 <ff4a02f0-5a59-4bad-af76-3d71146f136e@intel.com>
 <5e3854dd-d6ad-4110-966e-9029ef7c2374@amd.com>
 <b9b9e20f-703d-4e43-bd1a-17d8bbcead70@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <b9b9e20f-703d-4e43-bd1a-17d8bbcead70@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0411.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS2PR12MB9774:EE_
X-MS-Office365-Filtering-Correlation-Id: 994efc61-67a5-453f-b010-08debfd7bc76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	j2DUx7orDTa6Gfoa1nTKZjKyvJx6zIrBBRCdoN1LPFwUMen5dyfonKjQ977iQAk227Egkuih6boEis5UkbaDVkYT8RPfjmu6rl7q+doqRgOgn/w7/WrcIGemQlwfZWAy62Q0VCgCK1Esp7F683Xjgkm2cHl2KO51MOXLoCkNdJRNqthmLkbHBjELO+oLCkCp2cwgmBhr8JG7qRhysss6pI+qiQp+X3+n5hWZ7HlB6G1R/jtIZJMWueKz61eUOvrExbdBG6XjhJHQr5J4exCLrDvJWrngDPWytpRPLanpWwmFRAmfrvaCP8paWX8GZOKMU6TvEfCUgkvEFWLoOP87VgCJZEKzuTv3inlf1TWHiOBw71j2nnx1AZfEtfk6yuG0PlaG46Fzhv1sUeObAcOls88ZHlN5EDwH4b+AK8wfYpaK5d2lo/p4IHOW7a+ukOA/3iuAZvqmYzKHriD0LvgRi538rEj4IFArTARAzm4uNPBoQ6b8MKhiewc1JzTZ2Z8t+pFdHhkqStkC9CG2VxSD0nwqt2IIRyHqBEIfxDR3CvqqSQ9GqpoGZK7XxJ8uWDlP+nAHEAP3cMN2ZjbEkM+iG+MIZsM1TOCVRiambvfpUE/dTgJ42eOGzXANoBkKUuW1cYYoJwBrn/SPUdm0WwaM7w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW53Q0RadjRZMFZlemFaeUl0RXVNTjQ3R2lZY3lETU1VZzl6TDF5eVNpUkhI?=
 =?utf-8?B?aERLRmNaMWFpd244TkdkeFpjY21qU3djN1RJTElPUHNqL2IzeW9JN1NFazNI?=
 =?utf-8?B?UVRnTHZrT3NBQVVQTm8zcVhuRVZvTi9CY2ZJcFpvZXdBUWptTnA3NW54V2VL?=
 =?utf-8?B?MkdEaHdSK2NQSTQ2QXZZSTh4Vzdyd2haYk5iU3RFWGJKR1RpZFhzVWxFT09y?=
 =?utf-8?B?QnpCOC8rTDBiR1FMSEV1SDczekxRck1MbGQvTlRVRU9oSThkRm1SUmx0bVRG?=
 =?utf-8?B?ZjMySUcwTFl2WVVGTEFMcm5pZGZLd0c3L01tRGU2WHg0eG82dE5YdkxneXVa?=
 =?utf-8?B?L3F2N3dKM0NFTERFMEZaQTdSRHJyTkFoS01sKytTWGpMcGJtbmFZejM4N3F6?=
 =?utf-8?B?UHI3ZmpQV1NvL2M5QUZTd0FseWdHWmtXZkJRaGtBR0htTXRtb29IeitVUG9x?=
 =?utf-8?B?M0g3bHhpUmtFSEJOZVFXUDJUTlV6aHFXdWw3cWd0SEJRbllJUFhHYm5ROUM5?=
 =?utf-8?B?cDFraktRaEV3MkJUSDJ5QlBjMThXT0hneWZtejdNWDAvZ0ZvaTJpa3ErdTI2?=
 =?utf-8?B?MFl6cGJvRTJZVktnME9CZmdUOVBtYWdWWitnUlcxbDE1dFBjK2R0UWlrUkhG?=
 =?utf-8?B?d2FTNCtOZFQzNzB4TW9UZ0VTdUMxcnM1UnBvTDRHR01rcVhMMkNOdW9yTVlQ?=
 =?utf-8?B?V2kweVFrdlI1SDUvNGpLc2RLRFBxNXNrQlNaQWZoRTVMdjVRNkVOVGRtNjBn?=
 =?utf-8?B?Q0h3cnlSdWJLR0xqZjZJRUFJd1kyb1pNbFpUQVpIMWowb1pZcmlkcXE1QkxZ?=
 =?utf-8?B?U0trd3AwMDRWRGJUU2IxMFZWMWxJQUJiaWE3MFZiQ2E3UzhobHN5azY4Nkht?=
 =?utf-8?B?VUJLeG5yallScVNXV2NOTUZ1SWNzWm9DTytkREJJT3pFMm45eHhtUnRMQXdC?=
 =?utf-8?B?VnN0RDF1YzNHUEd3c1dYZUIwdWlrRENzWnk2L0JjNlBIOHp1U0ZJTGZpNWQw?=
 =?utf-8?B?TFYxRlVYcmJyTGRxeVoxbnY1WkRqZGFrUkx5UUNWdzdubDEvalhkNmJnUEgw?=
 =?utf-8?B?QnF0cC84YnBiKzd1SlVhQnFHUnR3SS95U2tnSWxodUwrMEN2cjNXaFhMem5B?=
 =?utf-8?B?OThLUU1odDhJYklCeFdyNUc2WnpwVXZ6UGVueVNiU3NmK1JJNTlrbERmRXNO?=
 =?utf-8?B?YU1TbStQSWFWdWpZeWdoYkF1NkQ5SUs2STg0ejBBZzE3UmYvKzNFd2ZPclAr?=
 =?utf-8?B?Q3BpeHB0ZDN4NnZFalV2ZUpicm9iRng0RDhjbENweGUwMXZwNDhxSHNnNWtQ?=
 =?utf-8?B?UHE5VUw3VW12aFhNM3MyY3pRY2dJSFdKelRkZlU3eTh6Q2NZU2Z3cDFvNTk3?=
 =?utf-8?B?NXpNN1Q1UUJpeHNnOGtYU1g3YXhJR0JYaVdTUDZiYnR5Q1h3NDhZekxBcEtC?=
 =?utf-8?B?Q0Z0QzFJTWQ5MWYzWWRvMVplMElXSmtqOXJDSy9JS0dPbkhjbzhCK0RKTXQw?=
 =?utf-8?B?azVabnRpZmNvQXRpVGUvZ2lJQzQ5dWJCRm5va0dmQUoyNy9iTm9QeVl0NGFC?=
 =?utf-8?B?QkxQVUVPZndSOVlZeVJKUFlWOFFRUnpHZzRWM09WSzJReGxNV2MycDJkRWth?=
 =?utf-8?B?THc2UUk1SU9XcWw4UUZVTmFVZkViWkZIdzI5SHB1SjdiVG45N2dodFFEcHdR?=
 =?utf-8?B?TUh6blpLcWFoekduTllqZUwzYTREU0tVTWU2bDdoS0JJb3g2S3dUYjBsKzJE?=
 =?utf-8?B?cldSdVhQS1pqd1loVU9ra2tzTU9BM2ltZEVCakU2T0F1REd2ajJ3bDJTVzdj?=
 =?utf-8?B?V0FZQXdWcndIUTUwbnJmR0I4RExDUC81K0xoOVFZR0hmL3RPQWFTeUgzOE5C?=
 =?utf-8?B?b3IrR2hRZmx6eVM4RjRpbmtGcDdnd2dkV1pQZElqalp6UVRpcjhWSXFjbU9v?=
 =?utf-8?B?LzdlRldpRUFlaG9WajRibU56UXNXL1JXZm1KdkdwVHB5dzQ0ODJjM2VQSEJF?=
 =?utf-8?B?Z1ZKalpDL2ZuYnRVdFB3YkJwL3p6aTVKOG43R1RSL2ZLN2wxK2c4RzhwaGpy?=
 =?utf-8?B?OXpYV3UzWVUycWVTQ2diWTc2eS82ZFlCZklZSEQxY3R2RGFjVFg0MmRoVWt0?=
 =?utf-8?B?ekowSG16dFRhUXJaSHBRckEyekdJOEJ5ZVNBd2sxZVZhMEtzdVVnOTJWc21m?=
 =?utf-8?B?UVlNMDU2bTIwR3Bwb3BwdlNWVG5hY2M0a3VMemZ4ZjNEcnoyazA2WFlNQ0t2?=
 =?utf-8?B?MDJHSDd3YzRQV1ljWEJ2OURSMFc1aThOd0tqTVNNYzNBZDg0K0VjVTFiSFBF?=
 =?utf-8?Q?/RQxpuuqv2Lky8Ea9F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 994efc61-67a5-453f-b010-08debfd7bc76
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 12:17:24.1599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4yLqYXABj3x81el4HB/H/cWdjERkgqrNA3ame09XAj4EYFyPYe5eZB2oj8KyLhZu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9774

On 6/1/26 14:01, Matthew Auld wrote:
> On 01/06/2026 12:39, Christian König wrote:
>>
>>
>> On 6/1/26 12:46, Matthew Auld wrote:
>>> On 01/06/2026 11:15, Nitin Gote wrote:
>>>> xe_dma_buf_create_obj() creates the importer BO with obj->resv
>>>> pointing at the exporter's dma_buf->resv. When dma_buf_dynamic_attach()
>>>> fails, no dma_buf reference is held so the exporter can be freed
>>>> immediately. Since ttm_bo_release() now always defers cleanup for
>>>> ttm_bo_type_sg BOs to the TTM workqueue, the worker later calls
>>>> dma_resv_lock() on the already-freed exporter resv, causing a UAF.
>>>>
>>>> Reset obj->resv to the BO's private _resv before calling xe_bo_put()
>>>> in the error path. The BO is not yet published (attach failed) and
>>>> carries no fences, so the switch is safe.
>>>>
>>>> Observed with igt@xe_live_ktest@xe_dma_buf_kunit on BMG (QEMU):
>>>>
>>>>     Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b9c
>>>>     Workqueue: ttm ttm_bo_delayed_delete [ttm]
>>>>     RIP: 0010:mutex_can_spin_on_owner+0x3f/0xc0
>>>>     Call Trace:
>>>>      <TASK>
>>>>      ? __ww_mutex_lock.constprop.0+0x2dd/0x18e0
>>>>      ? ttm_bo_delayed_delete+0x41/0xc0 [ttm]
>>>>      ww_mutex_lock+0x3c/0xb0
>>>>      ttm_bo_delayed_delete+0x41/0xc0 [ttm]
>>>>      process_one_work+0x239/0x740
>>>>      worker_thread+0x200/0x3f0
>>>>      kthread+0x10d/0x150
>>>>      ret_from_fork+0x3bd/0x470
>>>>      ret_from_fork_asm+0x1a/0x30
>>>>      </TASK>
>>>>
>>>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8023
>>>> Fixes: d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup path for imported bos")
>>>> Cc: stable@vger.kernel.org # v6.8+
>>>> Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>>> Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
>>>> ---
>>>>    drivers/gpu/drm/xe/xe_dma_buf.c | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
>>>> index 8a920e58245c..6d944bd4065c 100644
>>>> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
>>>> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
>>>> @@ -384,6 +384,14 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
>>>>          attach = dma_buf_dynamic_attach(dma_buf, dev->dev, attach_ops, obj);
>>>>        if (IS_ERR(attach)) {
>>>> +        /*
>>>> +         * The BO was created with resv = dma_buf->resv (exporter's
>>>> +         * resv). Since attach failed, no dma_buf reference is held and
>>>> +         * the exporter may be freed before TTM's delayed_delete worker
>>>> +         * runs. Switch to the BO's own resv to prevent a UAF when
>>>> +         * ttm_bo_delayed_delete() tries to lock the stale pointer.
>>>> +         */
>>>> +        obj->resv = &obj->_resv;
>>>
>>> +Christian, does amdgpu not have the type of same issue here? Also any thoughts here?
>>
>> Oh, good catch. Yeah I think we have the same problem on amdgpu as well.
> 
> Maybe dumb question, but why does the ttm_bo_individualize_resv() skip the final switch of the resv for type_sg?

Because we need the original resv object for cleaning up the mapping should the initial attach and then map have succeed.

> It goes through the trouble of copying the fences across?

Because we need to know when the import can be cleaned up.

In other words TTM takes a copy of the current fences and only unmap, detach and then do the final cleanup after we are sure that the set of fences which was active on destruction is now signaled.

If new fences are added to the resv object (maybe by the exporter itself or other importers) after our reference count got down to zero then we don't care about that.
> If we do need to handle this here, do we also need to grab the lru lock, like we do in ttm_bo_individualize_resv() when doing the swap?

Good question, of hand I would say yes but I clearly need to check the source code as well.

Might be better to switch the type of the BO on error so that the normal cleanup will just switch over to the local dma_resv object.

Since we don't need the original dma_resv for the cleanup that should work fine.

> Ideally xe and amdgpu can just have identical solutions here.

Yeah completely agree.

Regards,
Christian.

> 
>>
>> How the heck did you found that? Do we have a dummy driver (VGEM?) which could be made to always fail attachment for a test case?
>>
>> @Vitaly can you take a look and try to come up with a test case for that? Thanks in advance.
>>
>> Thanks for the notice,
>> Christian.
>>
>>>
>>>>            xe_bo_put(gem_to_xe_bo(obj));
>>>>            return ERR_CAST(attach);
>>>>        }
>>>
>>
> 

