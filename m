Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E6181AA8
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780314007; cv=fail; b=RMhTvPx7D5rlMqdMURwY8s/7QQCdsRQQ62LqyMoBGIwpCKznj09uqsNjiMWeizUqDhDT5KoNiSz1ebmBSBez2UrphM96NqGJCN3dBvvOxCzDfDbhNbpN88AVRuDKuIwyXneIIbcnMJsMlFUrcXOvdIM4+k+2z+eRNdiOUGDk+K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780314007; c=relaxed/simple;
	bh=l250ObQZ9s+WR1VUBBjTRiQKJs8Nv2Yw75YgmTKgyXg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mAKV14tumrU12uBeJvrk523zxUMd08QQ1VibtjRRkodG0w0xt+zFnX8aKGCSfQch9l+Z2byOnMRK8KQda/bAwte+pZ6TqyebKXtGq+kqKS0xbH9gKX2vOLXnCJ9kI1rFdCf7tdG6efmbvdkI+Mr1ibsqBYC+trVu8NFtkTqBl/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=byfgq2I+; arc=fail smtp.client-ip=52.101.46.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="byfgq2I+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwIYyh0xN6mgyVYvXCOyHPsQyP4aim3ZheOEm/Cl05FbmjPOn+MT+832DSBSyUUnTKBPtfAro9PvD+0Ixt3lZnCR21W8Sc3Drx44KT20K9B9674dg/W5Om2PvFjd8PM/4pqQnTXYoTb2Xq6kZyTISeckY2ZxjVrD0Ns4QuBlM1uoe/2pO3yC9Rp6+anKXbASpY00EZtb0pReyZ6cy414I0NXe+DLBUYdxGWatrDyGzMuLU0YVWcCZLAqdM5yPofVSH02bl7awqwy6NHL6hdCbBBm/3QsKUJsCtsCQrqOI3NM5Hw9uR7TOtnRO8It5UxA807z3xL3e42aI3b3NeGasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqWYXt44xvM9WQlzJLT2AQZA6xkaRG0FLS0wTvp9vH0=;
 b=MqkTj/YARuzsxJbE8h+lXSMil7oNW6ZOeUkjMn4Pwg7Adl6gEX3gz0TrO5VXVojl8rmCWIx8z1UWjR/uyr4fXOsAQhZOBUElwr+j7w7deevKGC5oLDHX7qKKppd0qYhr/c/yTZMQlWuLijs1IWwqU8zJnuEzPbjT+eWIzdAhnpAzGDruUQRQ2GPELGblckN+x1qd+cbYDvn3uR7D67w7utoIUENt5zzKFp7zaA1tOG4RDxWbYTGG885QYUIemWTgAS9CyQKWWclfd2pp/Ljtw0Sfo8LtmeEakErpmkSBuDcxQ7ixQdxnYtmfyLPYo8MQcZGMQoMHOLFUgraZfIDMKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqWYXt44xvM9WQlzJLT2AQZA6xkaRG0FLS0wTvp9vH0=;
 b=byfgq2I+vXWiDE9BllV+6GxnrCvSE3ztmsOWTo4zhyqAcSu2cBwIVyp2ta2j7vmMykBMeWQH+bqpBgKlfIngr8hZKmQKJsjtSfx4i6v3rR6fyR1fg7sO33AjmZGeZgsZlDVVSmQMuiDUURLqqZVuIDiYrbfnrcXiV8XslCDpaCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB9551.namprd12.prod.outlook.com (2603:10b6:8:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 11:40:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 11:40:00 +0000
Message-ID: <5e3854dd-d6ad-4110-966e-9029ef7c2374@amd.com>
Date: Mon, 1 Jun 2026 13:39:54 +0200
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
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <ff4a02f0-5a59-4bad-af76-3d71146f136e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN1PR12CA0005.namprd12.prod.outlook.com
 (2603:10b6:408:e1::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB9551:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e953c96-5932-4d25-1fdf-08debfd28325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	4HA0lmtkVbY1CMdX52gD9vaEjAnXtXfPIL56H2/F3xKbmBLjXmeBKbo1EDjs0HL9go4r6QqDMMK+BYETiWmz0hVbmizdKLA44YqhKs//hoxXQrUNDmXxkTqZ5C5aJ72wuVchEquYdqLOzOOdAeYyBfzrnT8+BZC2EJnGI2VdTn3k0R2F60Thts6KXuVFu0yI/rjKn+8Rs1xtULPZEbtr3X2QjEyE0MhxmqDqiBYn4sCaWAOVJR6W8Z/Q+WYm/DAp3FhO01dglPpAqF6UZ3A6CZ5S4SnBBzsy1O8MKkPTn53nIC8v1E1OerTvy8M+0Ad0xb224CqPC3uOl00K8pfuphzfZYrXuGRq2J8HCT0mJKghDy8Sg5B5Nb6RMJp/ee8AlFedmDtMkyhRt+gaosennJ74YqeWofE340sRK6qVKVA/tg/9hhHyz3V4MJBXzn4o1unKYBcvOG1HNO0bnHUqsya/AfERKydZJM7nKCLvUPQLOAdltUUFsUsng62Nwb565KsjhFkMhV4ja5VV6cyF70ivBvIwpkxJBwNtLpFOGFlSCbRKJC5xMg/OpS+ISQUH3+IBgl3fDO2fNR31ruC0nsbxgQhUaGV59+ZNY74dUWf4g8FrIL6McLTFuBNPiKeDDvaNudGlFAP24L78wdB8Ew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0ZSdWNHYmtOWFhLL09taXJNbndyL0MxZjdHbVFUeHQ5dVhINlhMVFIwYkg2?=
 =?utf-8?B?TTJiZzk5Mmo5dklLa2szSW45dGUrNEV4NVFKOEhUMTNoUk5yVFI2MCtIOU5p?=
 =?utf-8?B?YnZodEtMTC91MTJPbGNUZ3NMdDZsVGIySVA0cDNNcm8zeHk4VTMvK3pYVURN?=
 =?utf-8?B?bDhNTlRzRVMrdmdyOXBPWEpoU2V0dk4vUlUvNzRheW4yYzBGTC8wSzQyTjdP?=
 =?utf-8?B?anpYbmRzdHJ4UUt0YStzUEtSTEVidDNPbzFNT1dLcXdzSUFwSStTNXFkNC9M?=
 =?utf-8?B?NmttbkRmUkxwS1VHbFF6K2lEbHI3aXlHUWJ2YTErZnpPd3NPdDZrS2F2U0hG?=
 =?utf-8?B?MWZaQjgyZExNRzRIYkl0Z1dXNjNyZXF2SVJ5Y2Jua1ZTQkhrZVVYTWpiL3VF?=
 =?utf-8?B?RnBjMzhqeGpQYXZxU2VCWU00QjE3eXp6TzJyL2x2YU9qemdrZE1CRFh1RnFq?=
 =?utf-8?B?WWM5aTV2OXlkQkQySW1SejhOaWJEQmN4aDU2eXBsamduUFBscm03anBnYzJF?=
 =?utf-8?B?Z1JwMlFuV1dlYno1R1JQR1BtQVlJWVVpYW55VFhGZXBtdG9HVVdZajVscUpM?=
 =?utf-8?B?OVZhNmd0elA0VXZXOE9CWHlTbUt6cENOQjU5NVBrZU5XOTJmV2E1L1ZUaTN4?=
 =?utf-8?B?Q25WaVVHMUl2OUpEUzNUc3BYOUE0N0R3Q1VUU3J2SW5abjFFa01NMGtPdS9p?=
 =?utf-8?B?QzkrWkxVQndPRmZDMFF2UExUZ3ZaODBFZDVPOXpmemZxejdBdzR4ZVhOWjhj?=
 =?utf-8?B?OHdlUHBoM2NqWTUwLzJhWVpFcG1MckIyYUVneTVWMkgyZGFGd1o4SWtqWUJz?=
 =?utf-8?B?eUtVMXdIVWxEcVhTdlhtblBBTC81eUZPYkgwYmtyWTVRU3M0K0ZpM3E1NEV3?=
 =?utf-8?B?dmRzQ2dBVzRocXkvTW8xYkZYcFBMeHVWQXhISzdGVjg4V240R0MrUzNLMFJL?=
 =?utf-8?B?RXJnYXVEQ2pzY0Fsajc1dHJqbmppQjJFUXI3aDE0VjZGMVFxam1XOEhnUDd2?=
 =?utf-8?B?UVlUUTB5NUQ1d0RIeHFzdVNkNEQvNms3UVRSYnNEMmgzRDRPYUZUbTIzVDk2?=
 =?utf-8?B?QzNGbCtxeXJyNEcrTjdDa0U2T2dTRHU3bG9vZDNkZ040bGFlaUJYTjg2QWg0?=
 =?utf-8?B?ajlBY2dHNGlIOC9pZUVjbWdKVUtCdFZQU3ArWlVVazJ0UU9oTVg4bEJsbXRZ?=
 =?utf-8?B?em5oOXhJZnFUOGxXM1FsTTNiYUVDSXVkTWtYTTZFMnhueGkvMEhHRmtLVTB5?=
 =?utf-8?B?enRGUmpqZTlSNS9OemswblJkVEhZZkhpOTRyNDlaTDlmYzRnWU1QSzgxc0FQ?=
 =?utf-8?B?UE5wdUltRGp1QjNVZ3ptZkptbVlyM0xBQW5kNEZoUU0vN09nT2pVSVdtYVJq?=
 =?utf-8?B?Q3JUQzd2aW1MNWpGVGk4M3A3TnpzZENaSSt3Q0QvKy9lL1YyVlhpVng0RDdm?=
 =?utf-8?B?a0piOEk1Yzg3S29CNDk3Tnp3VG15a2tPdTM2eGYxYk9wZ1FaTEdIblB5R2Jm?=
 =?utf-8?B?b1RYV2FPQ3hCakMwTDlXTlBvN0pyZ2lrejlhN25MZUJRNVpYMHJQcHBJdWZE?=
 =?utf-8?B?MEtaeWhQU2RyTUtoTEExVjI4UURGdTc1bHB1WTRSWmtsSHFkakFhcjJGRDZT?=
 =?utf-8?B?VE5jRmg0MFZUeHp1b3hSSTEzMkxsSm1zWm0wWVVFYVBoNk8vOW5hZmdmTzQr?=
 =?utf-8?B?MXpJUVV4SXBueEtPdWllQWFTbkhMVWdqK3M4cFNvaXMySUdrMTlEbFp4bmIx?=
 =?utf-8?B?MFY0WkRJZlJDcWU4cjZBaVhvUHg4R3cwZDVlUXo4V2hlZ2RIMDh6aUNCS1Bz?=
 =?utf-8?B?Z2tMRmw2Y2cxSjduREUzQ3QraThHR2NWVVN0TEdDRjkvWlRpZDVXcWpwWldz?=
 =?utf-8?B?eE1sUWFPSmlkZzFaVnV1czJ0V2JyZHdGM01mRWtsVWRaOU1RMVhLWEVpOUx1?=
 =?utf-8?B?ZlhIc1pOQ1N6T3MwWDBFcGhjcGQzL1lkRG1vU3BYYis5Nkl6ZUNhdU1tUXVi?=
 =?utf-8?B?V3R4Q1JQeVBhb1BubmdGamo2VTZNUzcxTGNVbDdqekpNSmJ4UThsTHRBYnY1?=
 =?utf-8?B?NkU3QzNJS0wxMkZpUmdiUDVHWFB3a05pNG44WGIxbjVzcG9iNmxjZzBOaUxM?=
 =?utf-8?B?cTlNN1pNN1UrZ2dUSFBFMXhxUnFJY1VIK1NHTkppLzlLaTdjcnZDN2xlYzVm?=
 =?utf-8?B?alJUcVd0SGo2UjFxY0t6SW5IeE44Q3QwcEpUa3JTRWN4bkUwQ1QzQyt5ZDNo?=
 =?utf-8?B?U2duMHE4RjZoOWNIQWRySFdBVk5rZW8rV2tXS3I4QjExWmpWOVRKeFV1V2lG?=
 =?utf-8?Q?E/j3MgpKTKcABwuYqc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e953c96-5932-4d25-1fdf-08debfd28325
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:40:00.2329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfwhcWg4P3iA0yfaa5aV1qzQEsiW8TVJRY0v6B2WG9axiZMYokBGPjCV1sGQ0w80
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9551



On 6/1/26 12:46, Matthew Auld wrote:
> On 01/06/2026 11:15, Nitin Gote wrote:
>> xe_dma_buf_create_obj() creates the importer BO with obj->resv
>> pointing at the exporter's dma_buf->resv. When dma_buf_dynamic_attach()
>> fails, no dma_buf reference is held so the exporter can be freed
>> immediately. Since ttm_bo_release() now always defers cleanup for
>> ttm_bo_type_sg BOs to the TTM workqueue, the worker later calls
>> dma_resv_lock() on the already-freed exporter resv, causing a UAF.
>>
>> Reset obj->resv to the BO's private _resv before calling xe_bo_put()
>> in the error path. The BO is not yet published (attach failed) and
>> carries no fences, so the switch is safe.
>>
>> Observed with igt@xe_live_ktest@xe_dma_buf_kunit on BMG (QEMU):
>>
>>    Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b9c
>>    Workqueue: ttm ttm_bo_delayed_delete [ttm]
>>    RIP: 0010:mutex_can_spin_on_owner+0x3f/0xc0
>>    Call Trace:
>>     <TASK>
>>     ? __ww_mutex_lock.constprop.0+0x2dd/0x18e0
>>     ? ttm_bo_delayed_delete+0x41/0xc0 [ttm]
>>     ww_mutex_lock+0x3c/0xb0
>>     ttm_bo_delayed_delete+0x41/0xc0 [ttm]
>>     process_one_work+0x239/0x740
>>     worker_thread+0x200/0x3f0
>>     kthread+0x10d/0x150
>>     ret_from_fork+0x3bd/0x470
>>     ret_from_fork_asm+0x1a/0x30
>>     </TASK>
>>
>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8023
>> Fixes: d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup path for imported bos")
>> Cc: stable@vger.kernel.org # v6.8+
>> Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_dma_buf.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
>> index 8a920e58245c..6d944bd4065c 100644
>> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
>> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
>> @@ -384,6 +384,14 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
>>         attach = dma_buf_dynamic_attach(dma_buf, dev->dev, attach_ops, obj);
>>       if (IS_ERR(attach)) {
>> +        /*
>> +         * The BO was created with resv = dma_buf->resv (exporter's
>> +         * resv). Since attach failed, no dma_buf reference is held and
>> +         * the exporter may be freed before TTM's delayed_delete worker
>> +         * runs. Switch to the BO's own resv to prevent a UAF when
>> +         * ttm_bo_delayed_delete() tries to lock the stale pointer.
>> +         */
>> +        obj->resv = &obj->_resv;
> 
> +Christian, does amdgpu not have the type of same issue here? Also any thoughts here?

Oh, good catch. Yeah I think we have the same problem on amdgpu as well.

How the heck did you found that? Do we have a dummy driver (VGEM?) which could be made to always fail attachment for a test case?

@Vitaly can you take a look and try to come up with a test case for that? Thanks in advance.

Thanks for the notice,
Christian.

> 
>>           xe_bo_put(gem_to_xe_bo(obj));
>>           return ERR_CAST(attach);
>>       }
> 

