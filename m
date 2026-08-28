Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013017.outbound.protection.outlook.com [40.93.196.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D033DDAFB
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787904436; cv=fail; b=D0LTAuA9Oe5ausORjgHr+lm8Ecc3SdoQcUEdOzIzvb9347G8yTALsPfMy/eaJaeYxL+4vNTPB2LSSGtU5ZvohEuGiJPS8nDLnMfFrjDEQkGaRjChWYjQ6nyQSis8Etvhr9b9ire38E06T/ayUxXwTTBSYAgnOJtMLdtd2a9WqdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787904436; c=relaxed/simple;
	bh=yEd9Db9FiN/8uqvrlc8iaZQvs9RBI0jYrEdx7agZJNU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QTi3LVRyOXBF0mgTsf0t/+DKAKI7PZSUD94u0CyQ+kcTk2oGFDJqp5ZGDjhWQeFW3mwo+ZhZ58wIsPG6I2n3Ek7NP34cHW1iFPZpgm5Ql7emOCqA9/Oela4ZtGNIJydDXm+Lrn9BgP3vKFNkH9cWxsvrD4+WgNjYFFyxL7ExTf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZViFu7IS; arc=fail smtp.client-ip=40.93.196.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZViFu7IS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ao1NfbTi1fdVm2zHrRl3pg48MKghBpaRfWZOiHYUqGNfPFTxGqV2VxLYJblrgC2oKfUmV0Pw65zHmeJJk1YuI4Xwk9PtZmR4rGuVqejZgDkSOzp8YzpxP+u7yNMlBm7Vx6Rape8X/naBu9vw+T9y8bjSwKxJ8LwJ52q54BokotfCD+jMIBkBjMV53Gbclyjc69EKvUrd6TB4VV2sDCAjyEc/HfytohD7mBMmXYzbf+iby480S5x3ibSuiTgi0Gbua8M1WjhcqzmJtiFy/jumdUSFuH2AwRDngHdcH70Kd+9Ckb92HaCBYyiGvSjVuMbiUjjhn+wE706MwRamzbNTCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z95Hu0eYgMlGXPDbZUsVJ7P0YVu43ni1LfczHfwwFFE=;
 b=hz5iHjbtFS/eAr2YPGcrveD+LpPjTgoxb/WqMUXf2qjDsP+qAh7fP8dDoryPxROMhAUUj2rq+6yhvuGM/zPdRhhSx86REMG8OmpYIIUEcXnylRJkdwXe4OVX+9aT0oCCbcanakCm/yLypqIpjrkdACDPaXvTqms4nWvmY1j+FYxKyssr9Hjm2V03wGWaiKIUlx84FrEvouYHgr2Ip5oiBqcAkGo4IcPzlO4CsQhcoD7bkisNGn5Y2YHGrwpz7MprSSsF54lGHjVpM90yHHd0QwshPUOLZYnRA71bBrAm6tgf6bP9KdLGrl50zSbXMN438y9s9A4xvJWbVMNjBITTFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z95Hu0eYgMlGXPDbZUsVJ7P0YVu43ni1LfczHfwwFFE=;
 b=ZViFu7IS0CRmWQ1mMF0TDkNwcoLASj2UnKPyNbRoWz8Xptu/+3bryNIKW07NnzFRPMuLaL3QrJkIk1eB3+sDsdFYKgbJ8GMsL3/jniUxkX40eCISfyfvi1P3ZK1UdXqmb4Q5vZ0DaUnQbXt7LS3eLmysWwr7OEO8M5ynaOldok0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB9138.namprd12.prod.outlook.com (2603:10b6:a03:565::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 08:07:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Fri, 28 Aug 2026
 08:07:11 +0000
Message-ID: <794bd530-3fa6-4cf5-bfed-202f80a68a3a@amd.com>
Date: Fri, 28 Aug 2026 10:07:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: skip the VMID 0 flush for VRAM
 clear-on-release
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20260828044734.135460-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260828044734.135460-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8758e0-a0f8-47e7-657f-08df04db5d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kG7sWkWY51TAMidlSYr4O5el6/3bZliueIJjUk6DbXuyLFzeGOrOh0abUJP2Ywnt4yf36P/1EWcxCOy8d1qtLkYR6kNkUQUoGsR7Qe+lInXWqRWcE8qhtdFMJW77ZHgDVl6Cai5EHi5KjMq87b36jDNulvnPL/1uaB9HYjtaGGtXJpxp7pa93SqzhWJc0s4Qy6Qg0gEKMphE4Ryj0H0fL4vDkCuXu0QNDFVcPNLBKMwzuFeDJhPq7WfBdVQLdIGnIq7Cy7UBzCpgOjAoITuL6Wp6ztLcUSRzWOziIi8NyPSLR89Xy8EFN/Lu7TNFZy/ogRgkYN4OCGw7wm2h3GMGH+T4Tviw3UBEg5SYuXkrt0IFt05gA/v0IW1GdPkylMkUpqc3kcPkcysieWGeD8yKM28MV+etMk82nNdViYgZrv8t3f5RvIE+XVp5gKJhudhgxrfWQq9Xfzu49o9NFQgKHejj4Hc+lYmfYh3VnSGCA2UKfO3ScX3lOYvxozEpTm+xhaMNQBA2YfAuTAX6u8wRbYEIhWK+7/c2jktlaHKMKBKDoIwWqPLiZcf4xTiIkYei+QRgioFvROVJV1NG1rDkdXGCjntJ/nl5pagEezsOVgWqR49A9tDJLwLS6G5HjPsKeFVk4pnFM8EbMmT4vR5mySEQ9k+pIm4uo1usYNeUdEg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGJXQllDc0QxeVRKNUQwYy8raWs1RkZvQjVpQXRIMjRodHlQZVB5SHRtYUsx?=
 =?utf-8?B?M0Evd2o2L3NpWi9obEw4SVY0N2ZydXYvbitCQ1MvOFRtZGpsejI4cnpGOE4v?=
 =?utf-8?B?NVJSYkd5dURISGhmMFJmcGlPZ1J5M2hBd3FhdWhKR0c0OVh2YkZ4ejJVNVA5?=
 =?utf-8?B?YnRTZ0pXZUVoejFiaVdOdGJuNExxeXp5ZXZ0N3BIZ1ZkSmxXOGluMHR2VWww?=
 =?utf-8?B?V3NTNlVnQkU1RHR3b2xYRXF5UmxoT3pLZUFKekpUb0t3MU11YlVSbW1yZ2pl?=
 =?utf-8?B?TjVXUzZQNWlwRXdSU01MWkN1UXRJbk9LK1IzcURTczkyS1BQRHgxZWJDVis4?=
 =?utf-8?B?Q2dNeHc3b0ZDMjk3U1lJaHVmWi9pSTZ5Y0pFWVYySmhFY2FaVk9mVmxKMGpX?=
 =?utf-8?B?bkNVbHh2bTNRZ2FvMnJSUU12d25PZW5aTXN4aXRWTEN6ZUFoRXBsdVYrV25i?=
 =?utf-8?B?b0VYYVNicTIxU3dybzhxUHVZRzlBVEpvTTZlSjY1WVJsSDBiYzJnTkNBc3lV?=
 =?utf-8?B?MHhyY2IrdC9SQWpYcWhmclkrTWlHbTlYNmhRZzFMQXVXMjVISTVlTUtjWmlR?=
 =?utf-8?B?czYwRi90cytqT0doNHIxQy9xVFdyT2hlVzVaNnExRmVjRlJXSTcrQmNYN3U5?=
 =?utf-8?B?a0g5SjBoQndQQWVUOUUyanQ2azZuRW4xZDFmM3BEMU4vRWNkeDRLUFBjbzJo?=
 =?utf-8?B?amhieWdlbHFmY1NoWmpiOElpTDBtRGVtTFZlZFE3UFVob2l0OUlHbmQ2ZDF2?=
 =?utf-8?B?THJCcFdzZ2IrSWpNanNrS1VpeUhHMHlPWTcwZUlxKzlraGNOMmRoOEZ6S1dT?=
 =?utf-8?B?SU5rTzhrSG42TlpOMXEwQWYwNUY2ZkR0RU5jekE3Q0h5bFQzRWtWaXNGR0Qx?=
 =?utf-8?B?emtudjZGSXg0RnArYXRWamdBVktFckRLU29mNEtRL0MrbTUyVkdVNXdHSk1m?=
 =?utf-8?B?OFZNQk5POXloQ2JqdzBSRWdnTGZNMlVqb2pwMVVQUi9ZbGRxNVh3ZTluRU92?=
 =?utf-8?B?SWgrcGozWVFyTzVaSzIzZXN2bkJRUlFGZWFPR0pONHJlOEE5ZVh1MGQ5aVlv?=
 =?utf-8?B?cHZuaTgzNEdqLzhxWUY4d2hzUm9wK0FWOHdNVjMvS2VVc0xYR0o0d0Y5a2dy?=
 =?utf-8?B?N2dFVFdqR0x6MXJ4R1BCRnpRdzhOV1o5WDQrbGt4RXNSRjkzRFJtbjlWMWZR?=
 =?utf-8?B?bHRkZUo2ZjI1aUdBRlpFbnJILzhON1V0MUxrZHVYS0pSRE1wRURXR1pMUVl2?=
 =?utf-8?B?aGdsN2N4c015Vkx6Qk1sMllvL1hLRjlRMWczSDNlTGRwY0dQZzhjeFc3L3Nx?=
 =?utf-8?B?VnduM1MvQStXdHp0L3g0OGtJMUd2QU0vUHI5bGZzQzZVakMzQ0tHK3hBd1Nh?=
 =?utf-8?B?eUVrZllxVGJSZEdkRlhNeGVLZmQ2TGRpbENLQjJrVU5IYkZKWXhCSUdLZzls?=
 =?utf-8?B?YTUyM0JtbEV4U2d0UHhVUUlBZ1ZGWmtTUjdSZzNxM2lOL2tFVWVnY01LMi9o?=
 =?utf-8?B?VmpFZWRIK2tMaDVXMVAzVkJaUCt0c2ZBZnBTaGRlNmtta0xFd1lUb3dUd2Rj?=
 =?utf-8?B?MEtHcG5MOGFOZWhiSHdCdGpFdVpxbXYrY0dIWWo0S0V3Qkp6Z0pDek03QTdM?=
 =?utf-8?B?Vlo0UVlnMHJud0RVdGZBOU1oNHFpbGVHWDlFZE9wak9tYlViS2FXQ1BrZlZT?=
 =?utf-8?B?SzJ6ajZEc1IvZWd1amFjQ2lZYXIrZWJuUnZiWHhybGwra2F5L2dmbjR1ZThO?=
 =?utf-8?B?eitPVTg2NjM5ci9lT3VtVGIrTEpYdXdOOUdnQW1DbjRrR21xaHE3Y2tTUjl6?=
 =?utf-8?B?Q29wckx0VXJOaGRyRS9FSGh0M1dabDNZWWozTXRObkEvb0wvN21JUU5BNUFM?=
 =?utf-8?B?UHVMRVhhK1FaVVZ2VFprYVRxRWJvZVdqYUpMY1Z3TmY2cXBwWGFqZVZpTFBU?=
 =?utf-8?B?TDZpWitPWllUSTcvSDgrd1Foc0RrbVNabEt0ZWFBZDVCdDB1L2MybWJaN1Va?=
 =?utf-8?B?Z3BJbmZXdmdvRnk0NXM5SllpNlVZVitueWtpSWRrdGRKUFBLaE43d1lUV1JJ?=
 =?utf-8?B?RFRjR3lGejI0VTYvMUNucGhjajdWOXRYdWMvKzNQR0d3QmdFSlFpQVd1dHNq?=
 =?utf-8?B?TWNFT1hqODZBYTY4UkdqTjBWRS9UaXpWelB6ZWtJckdjZWlyVm9tcGhucmZU?=
 =?utf-8?B?VDhEMjdqcFR3MXdsbHVLQ0k3T3pNMlFudUwrWW9iQWI3RkdmNXhPR1ZoVEgr?=
 =?utf-8?B?eDN3UER4M2lQdy9HcUpzSE1QM2pTNFNMNHFWUGpaMUo1VUNsRlV4M0FTaVVs?=
 =?utf-8?Q?V3mdT1eMikHtOnR5ZO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8758e0-a0f8-47e7-657f-08df04db5d23
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 08:07:11.8724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/XvJfOEGCM9ak7o1spc75iRD51tOGCBpV3GSqRSOdXzt+Jp8zSnS8dwFtjuWjaW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9138



On 8/28/26 06:47, Arunpravin Paneer Selvam wrote:
> Clear-on-release only runs on VRAM, which amdgpu_ttm_map_buffer() reaches
> via its direct MC address without programming a GART window, yet the wipe
> still forces a VMID 0 flush. On GFX11 (e.g. Navi33) that spurious SDMA
> flush can wedge the engine; only flush when a GART window is actually used.
> 
> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> Cc: stable@vger.kernel.org
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 6c07cee8e8777..2e6c98c2f1efa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2578,6 +2578,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>  	struct dma_fence *fence = NULL;
>  	struct amdgpu_res_cursor dst;
> +	bool vm_needs_flush;
>  	int r;
>  
>  	if (!entity)
> @@ -2585,6 +2586,8 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
>  
>  	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &dst);
>  
> +	vm_needs_flush = bo->tbo.resource->start == AMDGPU_BO_INVALID_OFFSET;

It would be better if amdgpu_ttm_map_buffer() returns if the VMID0 flush is needed or not.

Apart from that looks good to me.

Thanks,
Christian.

> +
>  	mutex_lock(&entity->lock);
>  	while (dst.remaining) {
>  		struct dma_fence *next;
> @@ -2605,7 +2608,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
>  
>  		r = amdgpu_ttm_fill_mem(adev, entity,
>  					0, to, cur_size, resv,
> -					&next, true, k_job_id);
> +					&next, vm_needs_flush, k_job_id);
>  		if (r)
>  			goto error;
>  

