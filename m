Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011039.outbound.protection.outlook.com [40.93.194.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EAB33937E;
	Thu, 10 Sep 2026 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789026386; cv=fail; b=fIK693+ZXiLfBujYDEIctHNMe4CuzSgoPfyfAKl+AqT9oBA7fUew34PTwemVUJsUgRGD0Y7rEibNbqFY73w5MTKf8k0ynIcRe9gaw1QlmHfxpswSOfSs0u1lrTiKIZ514k97HAQgNPoV8mWYmkzvk8AzZUmADCoUvUWtR2gGMVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789026386; c=relaxed/simple;
	bh=dMSOHUGxkCVDj1wKTra++9a4wD8Ih/tJaGKqJ9bDerU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OWbpZhGqgUbPCGD9fyLz43TjqjaN34jh04/LUh5amw3+TgL4Hm/JMdjWcRtveCD3rhd/ltSSTw5AZtiK8ft5Q0G7giB7cw0fuBDXGfsrMfECNo0fsYMB6eWsu1IBoWVwWgyGMyeJNoSBBC78nQLhz/3VDebN+6hcxQoBBqPxtak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R3//rQuk; arc=fail smtp.client-ip=40.93.194.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R3//rQuk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5f11QilmlIf1oSM8LP2ugjBOZjp4FiLWPGPNfK/a2l2KNKPrxebvYp1m2QTZcc6Vwqb1M9GI7R1RdhEHhAOne9Ekq3fGSFh+epuMQTmJwO7KQ6B1+Uy+HfwkSey5x2ZO+/jwiXvSEqOq60lU18e9AoPcJCrvLK8Ks4WonuQ0QG/Ej1gywFbKhuzz4qI9Yr40GN9ya7DiPnqvfnenqSEnQ/1LW9ZcX/bfhcd/yRrOa3CzhMh6qiu3PJ8zqGeIzMpjTkixEE4S3+Tw6LsgaC1pKvW7AxkX89KcUOKYz6A82irY4IkyW3CDjFIWKY9lXkN4bVHg4kG0cypwX/ZN8P1+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqqHF98sc5hG0NSryPbTDEFbm+d7FwHCBeFVxNU0evI=;
 b=HJY2Osh2yBPJTIjMqBqO8poSmtwyZogdltZRdFVNeGM4zS/+GHQcFnuAbyXPCe2bXwlOKjj9jdXEMDRouNNnyvJY3kPh7Grry2nR3S1RZHyrnA+BucdHzEoLvfYbuFLmnMB6r7YI1bm2fzCrTkRaghrHX22PHCW2TKwkGpaCUR13trdM8SATojBXp6ifACLtHMAIf3DnbFPqUvFE3RV0E+LNjg2cGW6o0/sxNNFI1dff/QulJQOmiUXixZ1DzJ+LqrXuKsRy8PiUvXJ2u3Wy3B3lmvIJVnRLT7cc5lYtM3Kyw4yAb+1EniQmeU4QqqwPutXSM4U9HCIRLV+sj5h6og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqqHF98sc5hG0NSryPbTDEFbm+d7FwHCBeFVxNU0evI=;
 b=R3//rQukXV3syoS+rlyeY+Fw3rwj2Sl+3SAxYWZK3BaaZ+iCp9xoKm4+OgNXM05Fuad9O7oEtzV791c9V9SKoz670uE5MFOyhxOY4O3stLOidGJ/OGcb5Kad7oJqDzSsYg/3+/mIG9PZpkUkx3LrZpvOZQCPXEt+9dbxbG7YupU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:46:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 07:46:12 +0000
Message-ID: <853fb020-592b-4f85-a9b5-a522aca6a29e@amd.com>
Date: Thu, 10 Sep 2026 09:46:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: fix swapped-out resources never leaving their
 bulk_move range
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Vadim Nikitushkin <bub4z0r@gmail.com>, ray.huang@amd.com,
 matthew.auld@intel.com, matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, skainsworth@gmail.com, alexander.deucher@amd.com,
 bernardomagri21@gmail.com, Natalie Vock <natalie.vock@gmx.de>
References: <20260909205028.13799-1-bub4z0r@gmail.com>
 <067e5ddc2268ae4678745a900108e93d0c6eeb74.camel@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <067e5ddc2268ae4678745a900108e93d0c6eeb74.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0254.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: cae733ea-7615-4f7e-b4b2-08df0f0f9593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|4143699003|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	jSRlBHpD0wEKddwKHTzkcYjIQBbWh65HqunIiDxRYKFu8xCcu/CfiVcuAmB3KI81kMuAhI3EJNS8hZtTkNzimAbEklNuUgqLUTv/YObQGf8sCBjnb4KwzYqi5KI/c1P4c+4f4fLItP6fMeDHtdnzxI997cWXheOAaiO97R3rNAB+/q5ivmrVCt/ZxDg3x2XAVz+YMCFJx50BBMOSR3Cu6KxY1qzoZOcVfHj+FDX4NyJWkutbEKsNDHC917m2hHDdk6fJvOKnPJUyNc55La96LRzETLuOnaBSen96qY6NyMztEh9dQKdUTYPFMGNmpyLrcm3XuJRPisZ+Yv0Re+2rnkGIqSBgkocnWBWGbzkFnDJn/hCN+tCDyqVv6mLz2OL80sU3omOqTpfLT4E7Vwx/nOeCCKNC5Dv8Tu71wYhG7eNTseht3ImeGFoWNDO+3YoHQlV5PBli2GPQOi2bJQD5NxTKjw5GlKusRxwRqmUgiTLd6Sx/wguZp/HkKV9z8cFUzdL8WbTJE6me4q4zKJdB40hjPEGe4VlH8iXuZywIsHypaXOywbXSR3I8dzHoe73kuKSNXMgJm00Xn4O3+JHRagWDJLaXcozJDFQm4Xc0chI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(4143699003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2cyUUNCTkpvWkY5d0FjRjJRZnYxY3M5Q1NHeG42ZEdyeTIxbUZRQ3RmeTVO?=
 =?utf-8?B?NGl1VStUaWo3UGQ4dklBRTdBZy8zMS9Bam1oZkxzdXdTZjVaMmxMMDRIME9u?=
 =?utf-8?B?YmlYQlkzRW1oNWJvS0hEOG1NVkhRS1F2cHJPd0F3SCtHVFpWVXB1T1p2QktJ?=
 =?utf-8?B?U3RET0d6QjBJeWlqQmFpb1VrdFg2QSsrbWpmVlZ6ZkloZVZHcDBLWkJjQlRW?=
 =?utf-8?B?OXlrUHZjOEs2T2hNSEpTN2Fybk9kOHc1SVkyemNVK25zamhOTlNkaVNHYkhh?=
 =?utf-8?B?UkNNNy9wN0drOStmNGFGNTFqTW9iUzBBOFh3YTJybCt3c0prb3ZQb1VMaXRn?=
 =?utf-8?B?Ulhkdndma3NxUDBOUkJkMk9RV1FuWXViNzFwb2JKdi9rRUd1WGxYajhIZ3hQ?=
 =?utf-8?B?aHZ5THpMR2dEQlU4WTJHWmtZR2lUcDdXOXBMVzFKRDdhZWpJaUlOOFV5a3h0?=
 =?utf-8?B?aUdhenUyUmJoUHZ4M0VpZHpoMzllbm9lNnQrSmg3cnNLVFV4OEFHSU1xLzlN?=
 =?utf-8?B?cWVjbmtobUdVbUlBYVdZbU1ocDNNKzRCUjAzNWxUMFI2KzAvRUpvTmRBYWhv?=
 =?utf-8?B?aTBQaWRScU8wTjFRTDc0Wm5ad3hQTTJhZWpyK2lYdDNZR0ZrUVJRbVFWYko2?=
 =?utf-8?B?RlVHbFdHbEVHQVd1MDQwNHhEdGdiTGsvdVYvcG9paVpCREVpRnR4WERhRjcy?=
 =?utf-8?B?OW1mazQzSzUyRUw2MHkvYXBJMjJDS3d0eHhnVFFsaEo1TVR0eG1ZTHlSTXdQ?=
 =?utf-8?B?UjBjbEE4bWU2UjlnZ3hxYk9uR3VaUXAyTlBBaWF1dmxBTWFiK0ExamcreGJk?=
 =?utf-8?B?SUJPWWJZYjFPSlpEVVZCZUQyeTRRUHpWeTR6d1Z1aWYwSU9QRTlpY1hJbW5F?=
 =?utf-8?B?RWRJcTJ1K0xoRWZBTXlkWjd2dG1RUndwd291Wldjc0I1TU5xYS8zUEU4U3pC?=
 =?utf-8?B?Y09MWjB1dEtZOUZRRW5UZ2tKYTNzSldXL3pnTXlCSWNSdlNkYTR5RUZPMVM0?=
 =?utf-8?B?Wk9zdmR5akIxalp2QW51RW54RVI5L1l3RlllaThxb2J2bjN6ek9Ta1VDZGU4?=
 =?utf-8?B?ZUo5amlyVFl5bWJVUEVLWDZyd2dwa2g5MjZDVzJpTVRqWnlrT2IrekNxaVBQ?=
 =?utf-8?B?UENBMy8vOTdkelAzNE1WNkgwc08wKzdYZHNIRlYrSGx6TW5PcTY4V29Va1hD?=
 =?utf-8?B?dFFXTTdyOEY2YWd1NjdoMTVlTzZmWTBGWnBoWVc0SnJSRHZRajJmNkd6YlVU?=
 =?utf-8?B?c2ZJYkg0WWc5ak1iT0p6UDl4NUJJa2JKWGtvUUNGRUNyT1V3VmRBL2FHSW1a?=
 =?utf-8?B?T29oWnRLYWw4bHV2V0UyaEVURFZ4bW5PcWludjZRc3lrR3p2UG5LbC9FTTQ5?=
 =?utf-8?B?Tm1saFg3TUlIMmtBd0R3WkJFL1dMWUorMmRKOVh6VFVzeDBuY1dFZkdaOXlo?=
 =?utf-8?B?QmhJTEpDMDdkYmMwZlBzU1lJbmtnNnMxZU5DRFpaclRNcEFrdXpZOHE4cDFL?=
 =?utf-8?B?cEpVdnZjK2dCalVTU1AzVGUzZDJUamRNc2EwUGk1RUQrMXlBdUthaDVMM2Q3?=
 =?utf-8?B?cnk2OEdueG5rR3NhQjczcjFONysxYkNkeUxBK3lMM251a2diMGovOUYzajc4?=
 =?utf-8?B?UC91MGFyaFJqMlBtV0JER0ovSHlpcmN3RlN3YzZ4UTlPUGxrSDN6d1dXbUx5?=
 =?utf-8?B?QVR6akNFalRlUVZWT0FEWEdseEF0Q0d5eXRFTUJRaUcyZlE2cnlacCtGVDNP?=
 =?utf-8?B?WlRZbUtYQTg0SEZXTVFrK1VCWkVHRm1GZjRhT1A5aDAwUHB3NUplK3NLR0ta?=
 =?utf-8?B?WjdQZDJmZ3hTQm5pbjRhY3VJM1NjSUZyVEg4eXdWK21TZHJic2xCNjh4ZFNt?=
 =?utf-8?B?dVQ1a21BVUtJVEZEdzROZ2QxcG10bE94M201c0c3V3NSaTUxRmJNTGFScEtj?=
 =?utf-8?B?UmQrWFRHZlYzMXVGQVVGU1EzMUJVY2ZPRUltcUdFK3JRczZkdm5jbEJHSHVw?=
 =?utf-8?B?SUM0WUEzaUJNZHFGaFZLQmhZbk5WMjExME90RkNFeStMSVI4cEh0N0Vjc08v?=
 =?utf-8?B?WkZwdzBvZ0VOcWRLQ1U0OEh5YnZnUHUrSEhJQThuTEpuWnNEU0hWQm1DZkpH?=
 =?utf-8?B?TlJyTEpHZnROTlFVTDlWK0ZGWGFvcTkzYTI0ZVJLWkMrUmx2UFFWUStBOE82?=
 =?utf-8?B?cTN5QkxTamhpM0tZOHdHajg4WWwzVC9RS3hFSHpLUkg2bWNpTHNUK3RNSS9s?=
 =?utf-8?B?YlJDU1NMeUdNaHFMbkwzRWxwWldXUnh1VmtVMDJNTG5wVWZYL3k0Q1o3TzdD?=
 =?utf-8?Q?B1k0SSRECDvnVQtncm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae733ea-7615-4f7e-b4b2-08df0f0f9593
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:46:12.2824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xp6FJdqUj3dGxhONqGbBd8KZ/EJS5/x9SXU0pU88+U0+OldH3Thb+CPR8jSBDtIv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337

On 9/10/26 09:14, Thomas Hellström wrote:
> On Wed, 2026-09-09 at 23:50 +0300, Vadim Nikitushkin wrote:
>> ttm_tt_swapout() returns the number of pages swapped out on success
>> and
>> a negative error code on failure; for a populated ttm it never
>> returns
>> zero. Commit b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite
>> LRU
>> walk on swapout failure") moved the bulk_move bookkeeping in
>> ttm_bo_swapout_cb() under "if (!ret)", so the
>> ttm_resource_del_bulk_move_unevictable() /
>> ttm_resource_move_to_lru_tail()
>> pair is now skipped on every successful swapout. The equivalent
>> change
>> for the shrinker in commit 1d59f36e95f7 ("drm/ttm: Fix
>> ttm_bo_shrink()
>> infinite LRU walk on backup failure") tests "lret > 0", which is what
>> was intended here as well.
>>
>> Before b2ed01e7ad3d the resource was taken off the bulk_move before
>> the
>> swapout; since then a swapped-out resource stays inside its BO's
>> bulk_move range (and on the manager LRU) although it is unevictable.
>> When it is later freed or the BO leaves the bulk_move
>> (ttm_resource_free(), ttm_bo_set_bulk_move() via amdgpu_vm_bo_del()),
>> ttm_resource_del_bulk_move() skips it because of its
>> !ttm_resource_unevictable() guard, so a range endpoint in pos->first
>> /
>> pos->last is left pointing at freed memory. The next
>> ttm_lru_bulk_move_tail() or ttm_resource_add_bulk_move() on that
>> cursor
>> is a use-after-free, seen as the resv WARN in
>> ttm_lru_bulk_move_add(),
>> "list_del corruption" in ttm_resource_move_to_lru_tail() or a NULL
>> dereference in ttm_resource_manager_next() -- minutes to hours after
>> a
>> hibernation, or at process exit / reboot following one. Samuel
>> Ainsworth's analysis of drm/amd issue 5387 (see Link) identified the
>> dangling cursor; the missing removal at swapout time is the reason it
>> dangles.
>>
>> Testing the condition for success restores the removal. On an AMD
>> Phoenix APU (ASUS UM3406GA, gfx1103) running suspend-then-hibernate
>> on
>> a 7.0.y stable kernel carrying the backport (Ubuntu 7.0.0-31) the bug
>> crashed 5 of 18 hibernation cycles; a function profile of one
>> hibernation showed 336 ttm_tt_swapout() calls and zero
>> ttm_resource_del_bulk_move_unevictable() calls. With this change the
>> removal happens for every swapped-out resource and 12 further cycles
>> were clean.
>>
>> Fixes: b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite LRU walk
>> on swapout failure")
>> Cc: stable@vger.kernel.org # v7.1+
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5387
>> Link:
>> https://lore.kernel.org/dri-devel/CAHYiNPa6aVacJoLOje-qZ1GyYx-9p0tN4NuP8D_eSL+UJeevXw@mail.gmail.com/
>> Signed-off-by: Vadim Nikitushkin <bub4z0r@gmail.com>
> 
> Nice catch.

Agreed, that is a really good one. We had tons of people staring at the code without seeing that.

> 
> This also explains why https://patchwork.freedesktop.org/series/170311/
> appeared to fix the issue. But that series actually kept the resource
> on the bulk sublist until someone bumped the LRU or removed it.
> 
> Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

If nobody comes up with some last second objections I'm going to push that to drm-misc-fixes ASAP.

Thanks,
Christian.

> 
>> ---
>>  drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c
>> b/drivers/gpu/drm/ttm/ttm_bo.c
>> index ef56c18..9b85b5f 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>> @@ -1434,7 +1434,7 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk,
>> struct ttm_buffer_object *bo)
>>  
>>  	if (ttm_tt_is_populated(tt)) {
>>  		ret = ttm_tt_swapout(bdev, tt, swapout_walk-
>>> gfp_flags);
>> -		if (!ret) {
>> +		if (ret > 0) {
>>  			spin_lock(&bdev->lru_lock);
>>  			ttm_resource_del_bulk_move_unevictable(bo-
>>> resource, bo);
>>  			ttm_resource_move_to_lru_tail(bo->resource);

