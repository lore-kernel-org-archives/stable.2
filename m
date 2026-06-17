Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013035.outbound.protection.outlook.com [40.93.196.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71B4303C9C;
	Wed, 17 Jun 2026 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781685738; cv=fail; b=K7ItCihJvUH20lek1HgSFliUYI1+2Qp/o47IpAspjPsIrWIkwVZYI3OeyP3L9YDfMfvOFpuS7LNJLi5Nd1mkWGosUYzsqXQZSF8xSSK5VAANS3g+w66D4d/itftb2Z7ngdLZmN2rMGof7bwNOnSyULWr8x9DsL1VGbgE31zoGpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781685738; c=relaxed/simple;
	bh=js7ewTi2Aj5l/Ek1gIG1wFAdBpjBOeeuEyFuVLpXRZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OQl4uWNqapUHxXIoVibRHg2A/Uu/U7EVq7yV/DXZoqCM/Sqw1hFX+VHkdDkeoeurqo1b/OFmgzbHKtF1j98v71JrEVUdE4Y4wSor8W1y6a4f4nDvUCIuB2KhUc6UbzmvA95Bx58XkTtSXiF18JQPs+fSKd4tR20MRkku9TP4WhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XgHaLhPo; arc=fail smtp.client-ip=40.93.196.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XgHaLhPo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxf8hWdjdb4PJ27tRu4BARuhw6SsQxH3qB7d+rqRc9HEaVNMDbUus8a3cI8DFE9ZDEsoJ3/RGePg1Pc+hyGh4KdLrCTQ3OOUwNSyOUG0XRDlqKT0fiBKQ5UqyJJh3yB3w7P/7ROelS6kSZv0NX6hHZSmsN8+cE03pQMGHwyet9MomB8Q1sHXGImU+e55qNAtx/dj5RKQsbSJ/5I04ILMSaKWocQFno+4xejBpY8fHv+7g3v9Tl5D14OJvHJWkvLJ9apYm5R9dgWf5BQULflnRKCKQ97S5IzmC3EKiqhhxozlbkyD4zlQhC1hlvXsPUqOhEBL4Tp2+nE0fruW2WvNXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uJiETq9EyIqt8B7mb47LcTPX67d9mRzy3kfEYVZpn4=;
 b=ZH3Xqa2XXzGqZWKnY7SZsAxfx3e1Da6DM5Wzyt42rWcHQe94h5p2WQH+AaO+3Lr5iY6Qg0Dc6cTTLricmK3v55PCyaPdLyH7HWMrpUZgJKEfka7xbfUTm5JohFG0vteSc4Mf9eFdAHs2a5c2ypV/HPr9qOPhsNhK74WVkLDVGswsk/NwR4KzfGm1tar6JkIB4S1j4tkUo8fxBcIEnxEH1ALqv7yeAUvKRfQpMBpVr8RxehonbHIL/fUanvVEabcbUWLwTzjmbyIo87S+pFa5G9T+1PBdPAsHO1czahLDCKClfpGV123n0IWDSUDQu4UyojyzCRqEDjuV64WC+hh5ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uJiETq9EyIqt8B7mb47LcTPX67d9mRzy3kfEYVZpn4=;
 b=XgHaLhPob6eCJQELB82CMzNj+b1jZLaDj21JKO+IHl3HuyrST9+RX8wxIeH0KK+mIHsheTr3rty4GTQhGNjA88CEVBxRytpnT5aVe9cRpFcNC0BAhuJnCd9kT9Z55vGR2F9LOuq3BzDb5E/8O2wpKVh8yYi5j6klcs0ujcu6Ucw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:42:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 08:42:14 +0000
Message-ID: <b65e026c-6864-478e-856d-9acfc254a5f9@amd.com>
Date: Wed, 17 Jun 2026 10:42:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: fix fence reference leak in
 amdgpu_gfx_run_cleaner_shader_job
To: Wentao Liang <vulab@iscas.ac.cn>, alexander.deucher@amd.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: lijo.lazar@amd.com, aurabindo.pillai@amd.com, superm1@kernel.org,
 xiaogang.chen@amd.com, chongli2@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Victor.Zhao@amd.com, Jesse.Zhang@amd.com, lang.yu@amd.com,
 Jack.Xiao@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260616153506.1713376-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260616153506.1713376-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 465155c1-042f-46e7-0583-08decc4c5452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yXU0hJO+yXA8ygx9Nq91L4LkB0/P37XYzBR2x7wChuRBRK6ZcabxWgHw4ya05Li1WxEwQF60XADRlMsgjpkKo7WtxQJ6AKNWQymDYFdZrBIuaLuwpKxB1XF+yAt4OgSP1CepqZDkGj71p0yy0fVyAZH6dK8PsQxl3Pt2dzklMSaV2tVQtgT/Vu3J30WkwNmKEmMfpJZMPBxEGbaJZ1AMuC6ip94dZFA2ZnL/97aJJn7N/O0qp8Mmh7HYx8oEOCAczKvQDCU6hfdtVREt/ZJr+0mHTZigrWN3bJEIn2EfWKK2EiTulY5T7StuUz6KoHuwAbLaHJ6Pnu5v1Kbo+EU652L/ud1eYOg6fOVRyK6dpWLFX67/aNzg9Nx5EJtS4bsOO01pxXeeJLvMgiGaMNI7Dzs+19h1ngxCh1EhH+q6CVb51he4e+ox35bbZ8n/YBpHBDyreaK8LNr7Cdd+I/wn5Md1wEuy5ELcUGCt2odzUPABY3qdm4Z0/cNqj8DYGZGEEFTLpthFWrl95ZkG5osp9P+LPHnX3cyos+2Wd2gthApVlJ97vS3IpQVAb+7JPJVLsHTO6cb4jpYCozaTADkOirlBS1GvZlYbsYuKhi9ZMsMKC2IfGa/C3edJgdRDdwYp6uH090UwpOX0DXWIdGMOi1ffzUqjpGtkeePlBYnrcKQr+foHxJ82AUMRNkJ+Bb9k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekU4OEVVTUhQMktCQmVabGc0QmsrL3AwaHlwUjNGeUdETXpyM0hUemZHNys2?=
 =?utf-8?B?UjdSUXg2NkExbnRtK05qSlB2d2Y1ZmNOSXhiaTUxbmhzVUttVUh1SEZ5WExw?=
 =?utf-8?B?MldZazVKTFNXcHE0Q3BWS0pxZThGZEtMZW1nU0luUk9VM3JmeHBkV25iUTQv?=
 =?utf-8?B?c1l0QzU0akN3ZFBpd1V4M0FhTHdGWkprem9oaTR2Y2cyUDI2Z3pQZEd2dVdq?=
 =?utf-8?B?VjBsNzJRTDZyVDNPN29BWGxpSkgrWmxaWTZWY1R2K0hIUmFGZkg2QXVSWFBh?=
 =?utf-8?B?ZUdWb3lyOXlsOUtHaUx1M055Y2VWcGk1ZklJbjdnaE85clNuYjlsKzV6TWxj?=
 =?utf-8?B?YXF5V2VTd29GbWlUd2RRc1M5WStsL3VCbDNaeUovaHF0NEhHSTM1MytlR3NK?=
 =?utf-8?B?dGhQazJhaFFRNU9RdThKNEtvOXZycTU4REljZVQ0eDU4Q0JFSTdEUDBacTV0?=
 =?utf-8?B?c3NVdFR2WXRrWkxTZnZxM2FGSkY3ZzN2M3lVYzg5WDhEemxwVldJVjN5RkRU?=
 =?utf-8?B?Zm41Q0VaU0p6T28xaWg2NVZvQ2FhNGR6aUtuZDBSVWQxTENuMUNnbVVsRUh0?=
 =?utf-8?B?ejRXbWlSc2hoNTVVVVBEeW5KcWU4TUNvcEJucHhiZktob1N0cmdvd0lKaWxF?=
 =?utf-8?B?SGpCdEZBdkRKbGt4ZXdzeG5wQk0vWXNyYWxmZlF1Sm9QV2pzcm56d3NUaUZC?=
 =?utf-8?B?TGdQSnVKZjBWcGk1Z0liNGcvbDZKNlpNMkdpaWRiV1ZwSk5vdzY5dnE1SThJ?=
 =?utf-8?B?WTRCdmtwUDI3MDRXSExVRlloNUZIeWtOeFdmUi9reUJXVXh0WU5Ed0piQ2ky?=
 =?utf-8?B?KzRnVytzZjJaVTQ4UGRWZVBKUVZFU05nSS9BbC9ETGt3R1YvNXdKM1lZWTJa?=
 =?utf-8?B?VTM5SEZCK0RDVzJlNzV5R2wwM0xQa1pzeFRqekJWSG5TTlhEb0ZKMVBYSFFE?=
 =?utf-8?B?M21nSFRyeEhVS1BwUVkyN0FJWXhKZ1lDOUo5SDlWRWZEb3B1cVJQeTRpbWVF?=
 =?utf-8?B?ekQybUFtMXB4RERRc2VGeEp4dWwyVHRMTGRPSUlIQUZkQ3VpWGhVeEdpbmhy?=
 =?utf-8?B?OHA5WWFXUEh1YkMxS2xzcTdjOFVpNWE0cHdoRXh3a3MvU0pjdWxzbzNab2t4?=
 =?utf-8?B?S2x3UncwK1ZIS1pyODZnWVY5R3lFb0VuR1hXR2RFaE9FakRXQk44MjZLRUl5?=
 =?utf-8?B?SzRMeFc2VVc1SGFlOHVlRmlIWCtIaXVFTHp4TXZpUWNObXRrTUdvcmkvOU9V?=
 =?utf-8?B?dEhydWxkVkVHbVJ2dW9lRU9IZThpOUl3cnRsd0NJem92WmxLRTJyQlJOT0NR?=
 =?utf-8?B?ZURUOEpET29RVGg0RFg1RzQ1VUpvSCtVZklVc3NCaElNSWhWVDVmaGVnVkFH?=
 =?utf-8?B?akEvRnFDUkxOVFNRQ3VMaUlRMG5jNXlSTDNHSm1EWlFwalVFNCtOaHg3emVT?=
 =?utf-8?B?RTNNcUgrZ3BlaktGT0wwdFVpckU3Z3JsaFdGbDJhOXNVMGRhQXBHdVJ3bmQy?=
 =?utf-8?B?RGprT0cwb0FOMlhlS1JlV3FlTTJ3cnJtWTFSV3M5VEc2anNzNkltUkkyM1hW?=
 =?utf-8?B?TGcveFZETTdCdmJuNWR4Y2ZJYjlSQ1pDS0d3WmNxbmJXTUFmZVRWc0hUazZW?=
 =?utf-8?B?SENLYnZzajJJdHZMMHI5a2RlUGlrVTBZb3QzQVRURVRGL3VOZVpZT0xHUTdT?=
 =?utf-8?B?aHAzMTFmVmhWeFlqbTc5WkE2WDVwbmlJTG11NkNHUndRUDE2Z0ZhMU0vVFRa?=
 =?utf-8?B?TXBCTnlYK2lrdXhUaVVDQ0lNSkxIZng5WkZZWXdMZEh3NVIvT1RiVkR4WW95?=
 =?utf-8?B?Ykd0SG5ZZ3FsSEtRektJVEo5akJPOGY3T3dXZi9xaldhb1JFRjhQbWdPVm94?=
 =?utf-8?B?aUY1WisvRElQUDJtaHFhcDlXdmpGdEdOOFFPRDNlMnlna0pkbER5TXI0ZTZu?=
 =?utf-8?B?NlBndkRKM25uRk42NFBndFAxUXZBWUgvMUV5ZXZRUXZka1pkUGtQUjdVYTN0?=
 =?utf-8?B?ZEtnZlJldzM0c0k4TlRTa3NEYzNHUndkNS9rSVBPUlBJMElzRGFsZCtLNTJr?=
 =?utf-8?B?R0trcWcrK05uazhKeVhaelkzYXIyY29reVFxNFVWc0RQWThJSEpVZHBWZEpx?=
 =?utf-8?B?cmxGZVNSaG9UYXJHakRwK21zMnhLMmNGa0huSllIZEh5aEN6d0lIaTdsc2tT?=
 =?utf-8?B?dnJDdW9LejJBVkNJblo0Z3llMTcyVk9RNmd0eFMvbEs3bU9lZnRxQ3RxUW1U?=
 =?utf-8?B?dTl1Y0RMaGJQdjd3N24rOWZRTDdyYjBkaldxenBJRW43OU5oelZBK2tuQndT?=
 =?utf-8?Q?NHRQHtQd25N8GbnyHG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465155c1-042f-46e7-0583-08decc4c5452
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:42:14.1566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSRzHWbQYc9eD9CdamChvjFvJMMZrXS0grog0Wful/dIspcCujh4tyUlm72BcLS2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855



On 6/16/26 17:35, Wentao Liang wrote:
> In amdgpu_gfx_run_cleaner_shader_job(), amdgpu_job_submit() returns a
> dma_fence with an elevated reference count. The function correctly
> releases this reference on the success path after dma_fence_wait().
> However, if dma_fence_wait() fails (though with infinite timeout and
> non-interruptible it never does), the code jumps to the error label
> without calling dma_fence_put(), resulting in a reference leak.
> 
> Fix the potential leak by adding dma_fence_put(f) before the goto err
> when dma_fence_wait() returns an error.
> 
> Fixes: 559a285816af ("drm/amdgpu: Replace 'amdgpu_job_submit_direct' with 'drm_sched_entity' in cleaner shader")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> v2: Also cleanup the scheduler entity and simplify error handling paths.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index b8ca876694ff..be13ce6ce377 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1658,7 +1658,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>  				  &sched, 1, NULL);
>  	if (r) {
>  		dev_err(adev->dev, "Failed setting up GFX kernel entity.\n");
> -		goto err;
> +		return r;
>  	}
>  
>  	/*
> @@ -1686,16 +1686,13 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>  	f = amdgpu_job_submit(job);
>  
>  	r = dma_fence_wait(f, false);

I would just drop checking the error code here. A non interruptible dma_fence_wait() can never fail.

> -	if (r)
> -		goto err;
> +	goto err;

That goto does looks correct to me. You are now always skipping the dma_fence_put(f) below.

Regards,
Christian.

>  
>  	dma_fence_put(f);
>  
> +err:
>  	/* Clean up the scheduler entity */
>  	drm_sched_entity_destroy(&entity);
> -	return 0;
> -
> -err:
>  	return r;
>  }
>  

