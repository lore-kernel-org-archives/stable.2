Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673923D891C
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086065; cv=fail; b=CRIk49EISrqBLu83weqF7IhfnI9xYalrHlr1gfDslL8rmiTDEOk9SEKtsw0USUIT33HGnJBRnQsUQK1C5rcZUGxu0WHbtvJKOZML9qeWwrZaThRZfKirh6oB56SJKk7mSmFm2HsFkjGOaqKfBX3T+XCBPQHhgfqW6VZ4Qz+Jg28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086065; c=relaxed/simple;
	bh=f71L7qOJDnTxWXzWduFsBOx9n55a1RRYmuyE5+WTkvE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V6pcJsUGmd3ysNlRBVfOF2TIxRd+7Ubb1StHQEPFZNUc4uXIFgrtTvdsRezms5U6AaYH/zo0o5FuwUXn06+/FzSZgOwjaebJB2yJBciqUXhg0QrN8/f7gvWDvrg0QkB6uzClpoPw2C26ISh2xU6/4KHy+W8UOquu9HnC8HUvqpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hBiAU2nt; arc=fail smtp.client-ip=40.107.209.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hBiAU2nt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voze5HXmwdNGgFyiURqeUS/Era9yypFP8yKk/PlXVkFA7cHKJVP6OTM3/aLXmKcObixosZs6/EDaZEXvSwtMEHnjLvHFCct/X/QFcjmxCf2eH7EXaVv2SvG/vtV/qmx6WX4LCJzXc7qmSZsdceAR+0xSrFGBwd08DGU1exGppuRIF95q29pIr8FqZGPVS/2BBKs4sL7AoN3bw/WBAWeZEk2nnaUN3KFjz4cxuKQMVk8lF+agsAm2fkIAKDgm+EZbc+NvTDKK1M7xoMNXPlDRDBfI5JWWfpxwMhGJxnDB2U8+DMK55H1u5dJrKTMqBYL+EYFZswV72wEpw98C94cXpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zsKGeV1pnWEIUindNKBAbZZUDY7/fKQSbSD9qqq+Qo=;
 b=qmWQb/CEFCkTLFVcceCbvMa3E/1JyxVfKIZfjqoPymXblBkPYT2TWh848sUFVVVROuW4HFDAfOwXo8g0Z2v541nfw7oGV+K+I0wgUtrRwSwDjob2eaHb/TwdY2OGIDA6OqZ6v+JaURqUUzBHTaH+MYaTjTBQdz8IuCOqfWKndlj3oIVXMjkL6rhtGv3u6k8dbCrZybvMJJKEKsoH2lK/YhWxScagUmMUEum3/vvTgw7hvH+IP0uUmeUv3Qld342/FFOjxPF8FStX//2yzqLLAUt7ec7CRVucKfkmLlIUpratuufCvKJRwEIza5tLcheAO6lZsdzPBVERhzPoqeItRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zsKGeV1pnWEIUindNKBAbZZUDY7/fKQSbSD9qqq+Qo=;
 b=hBiAU2ntCDY3d/fg9OTHfiOdBRH2W57hfH5ZGWgM+3vtSlbmgpvhU7Nr9B3ka1sK+3xr6SIJffvyNmVoYE2fdvDXkewoEi4CZtzkFcnxM7ZCZjuj0Pct4BBfEqqkaiKlo3ac81m0LNYAp0fghv3DPw3SoPVHb2RaJyBcRYiME/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by DSVPR12MB999194.namprd12.prod.outlook.com (2603:10b6:8:496::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 13:41:01 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%3]) with mapi id 15.21.0159.015; Fri, 3 Jul 2026
 13:41:01 +0000
Message-ID: <c3ab374c-23bb-4348-b7d2-1f431fe07f6a@amd.com>
Date: Fri, 3 Jul 2026 19:10:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gpu/buddy: bail out of try_harder when alignment
 cannot be honoured
To: John Olender <john.olender@gmail.com>,
 Matthew Auld <matthew.auld@intel.com>, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, stable@vger.kernel.org
References: <20260629074311.68836-1-Arunpravin.PaneerSelvam@amd.com>
 <a4657daa-c58e-4441-ad81-c3e770bc5a94@intel.com>
 <edcfd337-2cba-49da-a77e-3a2f8aa67e4c@gmail.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <edcfd337-2cba-49da-a77e-3a2f8aa67e4c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0261.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::17) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|DSVPR12MB999194:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cbec038-3588-4a2d-cd69-08ded908b821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	LKdSWcSd5AwaBQMVc5xrUPe10o7vt18aBvrunUasERkrNlyvugHOiJVRt1w/4W02m65iYkDGn5iJZGi7I6UwvCQmuIs4f7TC1xszFS30blVdFJNS+21BN2mjC0s948mP8MH8jU5Jz7yIEtHc82XN3TjM45lwDWZItiIdIz1mGXy74CH8diV675FIIiulmhduNQAv6M3w3kzs6MN3IHk+1KKV0TR1jYdoIqLM4pWBuJjxDWObKFCaDOt+Rs6mp4Ts/gv6v7bmHeVAoRwHV18E1aJow1Kw7aUWLTmj/LBT87y1ozTOQ8Jbgp0e2R98eMzn5X5qWQBBNE6OhWPhtYeZEDh3ujNqlBMlaVWZtdtXuYEjG3xRGm2G9aC1K4scN3QfgfwkrVUzQRYSBp9eHWJ46mzAjBHJ4+eS62fBdVvkPYXEw9ZpTtxQehO1uBBh8g1tvTvh8RThageYhmt7QLJByGf3xyrNLfkvYkB9i6esoluKBNYt5H+2K03QbqV7sNdea4vV+lghfwJwgqAM8bVzwcHJlXwqwq4XG0P4lm8HV04cfPSwNYH9pDKqhSod18EbwId9ZxAGif0rA9xxc9rV0PnKLc0hPMDFcAP+wKq9TEhHqxX7OBpPbNjtT5aTxx9G4ZW0yQooFTF4dwZAd6qer5feQLf1gmMbErOWUutL540=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5039.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDc4OXhGc2FXOEJsTEdDRHk2MVZjNEZ0TzhoRStZQVZVOThIWlg0VlZyNFFY?=
 =?utf-8?B?M3ZGSnc4UjQwUGM1WXpwSEltTnRFd1BhZUhWY1g0M29va3U0SzJwYzNuVUZn?=
 =?utf-8?B?MVcreUxlVzAzWUVZY2M2RXduWjVJcC9RQ2NhcWdLWVBGUWN1OXp2ZEJ2Z2tC?=
 =?utf-8?B?ZUdabzc1ZVhuam9iVlRRRmo1ZkRkcnBjSUhjbnJUdnVWSm9QOUlEaFVYTHFI?=
 =?utf-8?B?M29mV2FxYXRWdUczSytLMVBtcCtzYXY3MzlTbVFpYzJDMkxCaStGVVlYUHFi?=
 =?utf-8?B?alFjc1ZKY1g1d3A1ZGVkcUZoUHM3S3hRWmI0cU9oQzhpZXRDNm5DMDRmUFNM?=
 =?utf-8?B?ditBMGxLWWdBOGVqRkdibWtzN1ZsSlRDSGRQQVB6eEd4aGRvZGJMNi96dC83?=
 =?utf-8?B?NjNZK0h1aE1SZVNXVHpoaG9OZ3owUnd6aGkrYW1HVE1jMFprZUl6Tk1QZ2Zh?=
 =?utf-8?B?UXdmU3BnTW16b3ZSQmZHQ1pLYXdmVEJaNzZ4eDFCeXphM29SOVNhUmtxNUEz?=
 =?utf-8?B?dG85TzdWd1VhcVBWdC9saDBqRXB3MG84bzc3RG5NYnJ2Z0RhWEZRTkl1MEg0?=
 =?utf-8?B?ck9FY0IxTFVIZzJRQkdENkkyWWhqZ2JVVytrb0RKYkNxQy9mOW92a2tNRHpK?=
 =?utf-8?B?YkhTaVVMYjc4UGFWMGhvYi9hNkVIUGM5YWhpRzljaTY5V0NXR2JpMTBETmVw?=
 =?utf-8?B?YnZZWkU4ZUJlTmg4bHFrclRXaVFDSjVJM3R6bHV2R3BJdWhKaVEwaDBQalMx?=
 =?utf-8?B?QXZBakwwaVNtQ0o2R1pTeFY3VGowMXFzcE1oZnVxNm9WVGVBbnJaanZsYUNz?=
 =?utf-8?B?cjVERUNVNWRKY1Q2Slo2aEwwemU3Sjg2ZU1KU2MvYUIxMTVTd0Q2bUt5SWtp?=
 =?utf-8?B?bjhmS2tXMlNaYWZ4bkExL2pRZ3Z5bCt1S2Zya2NTbVN6Z2NndHRncXFpUUVJ?=
 =?utf-8?B?eFVTaWlZWFZYTHlvQVdGZnE2VjFlV3kvVG1LbWVkcnBSR01SeGRRZ1d5d08v?=
 =?utf-8?B?c3Z3ZjRGLzVpWkpSU3VPWUZ5UFpQMGpmV1djRWdBS2huMndEY0xycXBVZ0Qw?=
 =?utf-8?B?eGhPcHRXTlpOWC9hWnp5R2MyK1ZiMmFzOTBTaDhpT3R4QStNdlFFS2k5ZXJy?=
 =?utf-8?B?TzBoUDRhdWlDZktvTFNUTVkvT3FDcXBQVWdXN0tIQmJHVndKZ0pOQ3hzTE5X?=
 =?utf-8?B?b3FRZ2psR3hxOTVNdEp5SzZnaHdyMUpkMWdScjBaUlh3bmNSTExvS1R2Rlpr?=
 =?utf-8?B?OVVuSFlBMmJEV25meUN1Q0tiVWUwakpuMXU3ZTV6WGJvU0pNdHNrNmw3WWNh?=
 =?utf-8?B?K2FwMW5zYWJWb05zSzc5Nk95MEEzaWRacE5rVDhMTW5IM2ZXcnZQcmZnYy9O?=
 =?utf-8?B?Qmd6VWNMRmNjcEdsOGZ1WmZvOTJwOUNYL0hrckZJM3kzOHVKV0ZrdGVzOTVw?=
 =?utf-8?B?Z1F3cDRtOXVwd3FnOHVFbi9wM3g1YVpXYUhVRmFhNW1iT09jcEVBWG1hbzJG?=
 =?utf-8?B?eENrbHhWak12ODh1VWdjTHRjeU41QTl5eWp6WkwzSTRnc2NQcWIvV0RBRlhB?=
 =?utf-8?B?NmdjTWp4WTRXdC92U1dXUkpheHNIUkJDOExRTnFWY281WkJoNHl1Z0ZjMXJZ?=
 =?utf-8?B?MzVBNXVVVHo4U2REWjBpK0R4eHBXWjYxSjNyK2lIM1RYZ1Y0cUJiaDR6dVh2?=
 =?utf-8?B?eThEMmE3amFVM2lPVmpHWVZXT01STmZtUDhRTlFFaFJEY1ZPQkxua0JEelpw?=
 =?utf-8?B?OEZRN3l2d0tUMGpoL0tWWlM1dm5OL0tka0lVbEtFZVZBc1gvK3BQaW5SWUlM?=
 =?utf-8?B?TFdHTWhPbVo2NGpPKzBmUlBxODVid2ppQVFTb0pYT2FsS0dneWZsR2srZDZO?=
 =?utf-8?B?ZVZlQ3pvZXlIemZVY2ZKc0ZzS24zQVRtK0Zzc0NEVXJGUXJnamtqOEo3eDZw?=
 =?utf-8?B?NjlMM3g1eDBpTVBrYWFlbW9LTVRsVGxsa2t2WFFncHZMc1ZLc1VwYlhKUWxL?=
 =?utf-8?B?T21ITDVOTklCZi8ya3o4VDdIRGVMamN0aTBRR2daR085ejJISUZJUXdCejVw?=
 =?utf-8?B?eVdBYmRpNExiam56QWhrVE5XVkV2VjVDK1kyWjkwbUJVT1F1YVVJUjFVVGhr?=
 =?utf-8?B?SlVvT3JEa015RUVoa3ZWOGVsajBIbFhqOTlIYkZWNGd0emE3QnZ4N2JtVFZi?=
 =?utf-8?B?MkNCeVIvQlF1N0o5eHU5REx6YzVpRHpRTlFqdWEvRHlQZE5TUnRYR2ZPUGFK?=
 =?utf-8?B?Yi9XTTVnVUdHemppUlB2SWJjbys2QmZHU2x0Vm9YM2JuNlU4TjZ2Mzc3NU5R?=
 =?utf-8?B?NzZwTVlNeENzbnVjY0JmcU1XMTJyUkxQYWcrQTlxa2xtQmtuUDRjZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbec038-3588-4a2d-cd69-08ded908b821
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 13:41:00.9089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pxPrdPUgfwnob3RHPj/mV0AVlWqW2xcuKj3ZuCoynECsoKoKCRKeDMaAHxBY0pwPh1wC76HcW5xs90fxTIKWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999194



On 7/3/2026 6:05 AM, John Olender wrote:
> On 7/2/26 6:48 AM, Matthew Auld wrote:
>> On 29/06/2026 08:43, Arunpravin Paneer Selvam wrote:
>>> The try_harder contiguous fallback could return a range whose start
>>> offset did not match the caller's min_block_size. When a candidate's
>>> start is misaligned, realign it: free the misaligned run and reallocate
>>> exactly @size at the next lower min_block_size boundary. This keeps the
>>> returned size unchanged with no surplus to trim, and rejects the request
>>> only when no aligned candidate fits.
>>>
>>> v2: align misaligned candidates down to min_block_size instead of
>>>       bailing out, for both the RHS and LHS paths (Matthew).
>>>
>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>> Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Timur Kristóf <timur.kristof@gmail.com>
>>> Cc: John Olender <john.olender@gmail.com>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>>
> I haven't hit any issues with this revision during testing.
Thanks for testing.

Regards,
Arun.
>
> Thanks,
> John
>
>>> ---
>>>    drivers/gpu/buddy.c | 63 +++++++++++++++++++++++++++++++--------------
>>>    1 file changed, 44 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>>> index dc81fe0301ce..3c73ae87f3c5 100644
>>> --- a/drivers/gpu/buddy.c
>>> +++ b/drivers/gpu/buddy.c
>>> @@ -1118,22 +1118,30 @@ static int __gpu_buddy_alloc_range(struct gpu_buddy *mm,
>>>                     blocks, total_allocated_on_err);
>>>    }
>>>    +static int __alloc_contig_aligned_retry(struct gpu_buddy *mm,
>>> +                    u64 unaligned_offset,
>>> +                    u64 size,
>>> +                    u64 min_block_size,
>>> +                    struct list_head *blocks)
>>> +{
>>> +    u64 aligned_offset = round_down(unaligned_offset, min_block_size);
>>> +
>>> +    return __gpu_buddy_alloc_range(mm, aligned_offset, size, NULL, blocks);
>>> +}
>>> +
>>>    static int __alloc_contig_try_harder(struct gpu_buddy *mm,
>>>                         u64 size,
>>>                         u64 min_block_size,
>>>                         struct list_head *blocks)
>>>    {
>>> -    u64 rhs_offset, lhs_offset, lhs_size, filled;
>>> +    u64 rhs_offset, lhs_offset, filled;
>>>        struct gpu_buddy_block *block;
>>>        unsigned int tree, order;
>>> -    LIST_HEAD(blocks_lhs);
>>> -    unsigned long pages;
>>>        u64 modify_size;
>>>        int err;
>>>          modify_size = rounddown_pow_of_two(size);
>>> -    pages = modify_size >> ilog2(mm->chunk_size);
>>> -    order = fls(pages) - 1;
>>> +    order = ilog2(modify_size) - ilog2(mm->chunk_size);
>>>        if (order == 0)
>>>            return -ENOSPC;
>>>    @@ -1149,31 +1157,48 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
>>>            while (iter) {
>>>                block = rbtree_get_free_block(iter);
>>>    -            /* Allocate blocks traversing RHS */
>>>                rhs_offset = gpu_buddy_block_offset(block);
>>> +
>>> +            /* Allocate blocks traversing RHS */
>>>                err =  __gpu_buddy_alloc_range(mm, rhs_offset, size,
>>>                                   &filled, blocks);
>>> -            if (!err || err != -ENOSPC)
>>> +            if (err && err != -ENOSPC)
>>>                    return err;
>>> +            if (!err && IS_ALIGNED(rhs_offset, min_block_size))
>>> +                return 0;
>>> +            if (!err) {
>>> +                /* Allocate the unaligned RHS offset using round_down */
>>> +                gpu_buddy_free_list_internal(mm, blocks);
>>> +                err = __alloc_contig_aligned_retry(mm, rhs_offset,
>>> +                                   size,
>>> +                                   min_block_size,
>>> +                                   blocks);
>>> +                if (!err)
>>> +                    return 0;
>>> +                if (err != -ENOSPC) {
>>> +                    gpu_buddy_free_list_internal(mm, blocks);
>>> +                    return err;
>>> +                }
>>> +                goto next;
>>> +            }
>>>    -            lhs_size = max((size - filled), min_block_size);
>>> -            if (!IS_ALIGNED(lhs_size, min_block_size))
>>> -                lhs_size = round_up(lhs_size, min_block_size);
>>> +            if (size - filled > rhs_offset)
>>> +                goto next;
>>>    -            /* Allocate blocks traversing LHS */
>>> -            lhs_offset = gpu_buddy_block_offset(block) - lhs_size;
>>> -            err =  __gpu_buddy_alloc_range(mm, lhs_offset, lhs_size,
>>> -                               NULL, &blocks_lhs);
>>> -            if (!err) {
>>> -                list_splice(&blocks_lhs, blocks);
>>> +            lhs_offset = rhs_offset - (size - filled);
>>> +
>>> +            /* Allocate the unaligned LHS offset using round_down */
>>> +            gpu_buddy_free_list_internal(mm, blocks);
>>> +            err = __alloc_contig_aligned_retry(mm, lhs_offset, size,
>>> +                               min_block_size, blocks);
>>> +            if (!err)
>>>                    return 0;
>>> -            } else if (err != -ENOSPC) {
>>> +            if (err != -ENOSPC) {
>>>                    gpu_buddy_free_list_internal(mm, blocks);
>>>                    return err;
>>>                }
>>> -            /* Free blocks for the next iteration */
>>> +next:
>>>                gpu_buddy_free_list_internal(mm, blocks);
>>> -
>>>                iter = rb_prev(iter);
>>>            }
>>>        }
>>>
>>> base-commit: 6648301c5bb2ef23f0fb15bcb01d21ff66f36799

