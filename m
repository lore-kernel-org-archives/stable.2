Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F219B2D9484
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792058; cv=fail; b=f3jxzOMoY5L9nKRFPaZhJcyEuwQ21VTAyVwkd7z0osfSJBrR40uuizBFMdf3buqw5TsZRfYkzqhCu6YE6yzLj6glzMmoMYCz29v0FaKqDyZC1zo8dYM/udn01FnBuD0wOdZDQaG4YkycSzKR76Td2hFXbQfbnYET7K5rxckZPKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792058; c=relaxed/simple;
	bh=doIouv00N0l4tgExdT/8Kv/4OJzeXkglpJcsEus8NF8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JhpaA7kNi4a2S+PyAhCikhmMs6ciTFLF/PlYzf5fgVNd7mVDgxPlABhrsT92dRU5Xjo/mWr/QeW3bg4ZNMmaeY5o9R8onxD/nEBmKf/7SAo2T9lbvGRXJzo5P8C/rhLjZoEXg8AAKJDNGelzKGtap5KIGvD9f5yPgzIPgSIFcJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bI1LEdWM; arc=fail smtp.client-ip=52.101.52.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bI1LEdWM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7T+rbhECJStrUTG577v/Ww1VzU9H/ejHId4HR+0S0TSdPb/6F5zF9fYbxUfPnSUefLfysNv0NKimZpNgLZX/9XZ4gMaJMqwwyi46LP4SN0pqLkBmo9s9mCLF8DIXKevPcKv+Vo+4GL2dVqc1XZpi8IoYX1OLlY06fTXeeP3n/Us1dXK5r74zaivxvoKQq7QI9SNWMiINVt3qNE/RDz9uPsaiFkDsTtsBsAiagYgcHh7TbTCr3yo/RCw86wJ/3tkDPVTrQpMPb0e8JM5q6MySWf9i2TRCxR1OtYJJNKHjAyUK6idq9TohsnM2b8WdwrMMgdjt1fnpGsgrWDMofkLAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WifL1xvh3x/k21h3wNzpJyQylcj2WsUqBPUV736NDh8=;
 b=Aa0xURWNYy16ATW51025TXXaHeA5wLvCrqaoi4JxGQh9SZ3GQ/nRcf2ntDVcj3htEScY4B0uHbm+yD7Qg0YGBYc7vJxdJXCL/bvWMJTF0Oh4DPEuU5lMv12VCc7cTqR4bdDOjN9LAsSTGYmVFWE0+Hu6fgddQMuXvqUDA7HQP7wjmNRBrz8kn2ZhGGH+BcT+xM/w0/1SIyJTRFQsLzDwSBncKzp+m4KVKbDfSYdM607nI3mznM0oz5Zc6tMgB76VH7jLD4CVEyIp5oAiZ2k5gw0XEciOfC4r20ilHfd5v+mi63p18dvrFvgCwmooyfuHrmI+ysdAjYeA5qBsRN4tkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WifL1xvh3x/k21h3wNzpJyQylcj2WsUqBPUV736NDh8=;
 b=bI1LEdWM/62cF/bEEfvk99auW45eEjQfWdt76wjYiZX52vwL7aO4gnU7nG5mLKMT7+croz80A7GQF8HumG5AgJ4UeF0x9NZcoCKbA+xELARWM5wEA7FoSLef6mXu3eYvl3dBReu7jlLcWwHWUygBFzMTvWwugpKiP80NRvcP8rU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 18:14:12 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 18:14:12 +0000
Message-ID: <56bc07fc-6163-4fb8-944d-912d5977d5c8@amd.com>
Date: Wed, 30 Sep 2026 14:14:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix direct scanout alpha on some
 DRM_FORMATs
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: xaver.hugl@gmail.com, alex.hung@amd.com, stable@vger.kernel.org
References: <20260930162803.555299-1-sunpeng.li@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260930162803.555299-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0389.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::11) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|MW6PR12MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c1d7c88-6176-42c7-64c1-08df1f1ea0dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	a5FGzjc8DMBlP3Afr+EhfhBCfzyxAoKnudb6Ff+tcN+jkkp0qWBHjD5DbGEgv3wx4o8md3yC/7yPfWZLfQu9e3t6sZKkpLURTSCAZr4xorRHIFLUSAo29O4G3W9+twu09qYznND67y8rMNZuoS0ge33lPOX3/ThJK3ffFGOLl4qmaVKDxFEgRK3O1mMRnTYPJL4DoJGX74ag5xGk/tYB0hzIwe0gKqkQzJneA8ew1n4e9lTBm9oheiAPlpqcvkAfaZoPkH+YAkI8bbQqL/PeLWlqEvHt+BQtDFExWOWUDLw+TVgt8hokSNrXQrRBa8f2TXNc6mGCPxQGiDzIbj+mtups4WdCcxYkEr96yGucHDRZRW7HLjd2vJ1lyvFWdSdJAG44HQEVKdAsO8gDoCRYK4AuIcJKu1f3oOLGoLsFpO8x9dgxMltyw3fzLviNFjyVOwhm6rAWvAWO93EBBSGxzuFaJJZHaUTDZQ4vXarTVVpmdP5hiBtZED0YX5JX3/g3vbbIWDrfo2MStUctYRkoHvbswdQy67CR1pxxVmxNdFFnzGJU3jajfJdZ+/nSFNxWmDd0hY9tYttXK/HOFGtxrkVrz1+henT5Pd8rduwWYZeGWCxm27h3bWRcB9nh78rfs8sX72B+yM3CP00BKn3WDAPwedptmcUDn2rMLVpqlRw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB7007.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmZoakJMTEpGZjdFOGMyRmlTUFpkSFYwc2xNT1pzenQ0THVwN25nakdDTEJH?=
 =?utf-8?B?enlSczhDc0JJd1lIR2xJeUx5aEhEMGF4RHRvak5PV2lhWFZrMXhwdHBodXdG?=
 =?utf-8?B?WGp4cnhXVDNDRHhPWlFLa3VwVnlGTDJVM05XN1RCNDk3WEdjNld6U1Z3cmRi?=
 =?utf-8?B?YXdXK3BpRWtRejhjblhxenZDTUw2ZlR0SGpKUFFhN1Urb292amZTNmxZc09o?=
 =?utf-8?B?TTVScndKNjZ6Mlk0NDI3aG84M0phSFgzSUI0ZkhQSk5lWkhhbUllYll1ZTl1?=
 =?utf-8?B?NjhGckZSS25ZYms0d2tJVDRWTC9KSENXaC83VHpMRzdvek5qMDF6OGVzV3RY?=
 =?utf-8?B?N0V4VEwrVzU0RHBKZHkydncrbmQ5ZTBuaUttVFhlY01OQmNhbEZ6bmE0ZzVB?=
 =?utf-8?B?N0EzdDNxeG5pN0tkek12RGo3S1E1M1FYUnY4MXNhTi9YMER2YWF4SEdxenM2?=
 =?utf-8?B?OXBld3FXMFdwTTFsNEpZakxMcTlxeUhPWkZDZ0VNUmZiNDlVbURFNVJoL0Vk?=
 =?utf-8?B?anVJc0g0VUhYMy9vcjAweXdhczFHenNkWjBEMVVjRElsN3RSRVlrMEtYVVgx?=
 =?utf-8?B?eTZXWTJvL1czZ3J5U042QlFrUFFSRzZ3QjUwNTFscHlKcFVvN0c2RU4ydDln?=
 =?utf-8?B?LzZvS1BWZXRwUFNQMHlpL0E2OUpDeXZHOVRYN0Q1dHJwNHNpcmc3TTFjQktS?=
 =?utf-8?B?VnhJenNaeG5iWWpYTThtUGhqMnZJTzdQbnZsN1cxL0pFdmtZQm9LQmNVdU9n?=
 =?utf-8?B?NFJvR3B2WWl3L3dHZlhjemJJRHc1dDZmSDQ0aHdvVE9ON29DMUk0Q0Z3dkNV?=
 =?utf-8?B?Rmw1a0ovSGdpMmRqOUJySzFHOVpWRW1jT3pwRnRVOTFOaFVkNSs1YTdDWDZu?=
 =?utf-8?B?VUZwVytnUXhkdW8zNU9ZZ2QwNjVsck5TYnNYMmYyWUxocUtHVnBSb0tEYnR4?=
 =?utf-8?B?VllSUWVzN2xIZlV5MXFxYjhLSDEwZDFINm91NEtULytEZlJmbFpZQjdOUS9P?=
 =?utf-8?B?c1FmOEVPQlRuL2lZV05TdzNoTm5NTEg4aDl5RVdwbGlvMjUyOVA4U0g1M1pD?=
 =?utf-8?B?QkNlNE1nMjZiL3lTRGFEVjNhNGRvaGdNbGx0WnBqY01VYTY0bzQ5a011SWxs?=
 =?utf-8?B?eUk1QXdoUzJ3ekROWWw5bE1UQmNSRVBZQWJ1aGZ0dkJTbTM2RzNYeVFqWlZ2?=
 =?utf-8?B?RFFSOFN2dk1zaUhWY0FwdHFraUd3M2JGaW1kT2Y4RDVGL0p1TGcxbm1FNHli?=
 =?utf-8?B?UHNLREVwV3VFaTdOTHhlalZmVTlJaXEvVzF4VHB0Rk5CMmUxSE5ZZktzbmRY?=
 =?utf-8?B?dzB6SElkRTdPTFRoQUlEMFRCK2JQV3dKOWkvTkp0eVFKWUpDUzBKZFhTS21C?=
 =?utf-8?B?c1NUcEFlc25IU250amZSaWdJSHN3ZmRtWG13ZlU2SEpMajFORkxBOXU3cmpG?=
 =?utf-8?B?a0ZHQmxxYVVuaWM2QjF2eHJnWk1mMFFabzAzNHBLTUU0RE92RkR2OUorYldJ?=
 =?utf-8?B?dVZ6UTlyNFRtM3pkY3puNkp3Q0d4WVRCMkI1d29zTnlmNWxEK3F6LzJDYTZH?=
 =?utf-8?B?S2lORWtVM0FIeEh3b1RMVTgzV2ZVWDlyWXZ0U3EzMm5FT3p1M1Zvb3U1ZXcr?=
 =?utf-8?B?cVloNEVOWmFSM0hMd1ZYWUJ2VkJCRFU0TDFmTUVZc3ZtaG4vdjR6MUlnS09E?=
 =?utf-8?B?U1JEVWw5OUU4S3NhUllkUVl0L1JZbU0yNlN0VC8rWlpsVVFBakhJOG5GU3Ez?=
 =?utf-8?B?NkhpNnFuK0tTTWpzOE1UdzlkM1VhSE9XUFBGTVhJT2JxVy9nL0NzNWZuQ0dO?=
 =?utf-8?B?QUdYUHcwQ0NuNy81eE1XRWMrS0N6aURRWDFoZW41QkhRSVI5K2IxZSt0L21l?=
 =?utf-8?B?QmtyWDJhc29wb0tveFdNNUhWRWZDK3h6bmRyMmVHUkFTVjRHSTVTb21aNGU2?=
 =?utf-8?B?b09ic1JUSXV3alhKdC9qWFZ1RkVjWHl3d1daclBmN1IyWFBqdlhlSkZlK0NC?=
 =?utf-8?B?c2JMT214eVplMjRtSWdwdGR6ZTdLZGhmVXRocmxmZzNnSlRwOFY3NHRxNzRv?=
 =?utf-8?B?aWtuNU9CMXRwbUxWZGluaEVDcEw4bWNXc0N1WHBGdjQ4aHNBa0p4SVZ3ZmZ0?=
 =?utf-8?B?YU9jaUtNMmJRWUtzMitlTTVaSitxbVdITnF2Q2ZqUWJTbGRQNWovNzhuOFVN?=
 =?utf-8?B?ZE9ScmlTeDY5UzBtZE5jSFJGL21LMFFwcERwWldhQ1Q1NjdMY0pHaEJycit3?=
 =?utf-8?B?TEphUFN6QjNwZHF2ZzhRSXl6clpzS3pKNkxTc0pGOXprdFVvdWhCWDFEQktt?=
 =?utf-8?B?akdvNFJZZEhyWlhYQzJXR1lKeXFyOWUwRjkyc3hvWmZzQ1ZiYlAyUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1d7c88-6176-42c7-64c1-08df1f1ea0dc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 18:14:12.0656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPeRUnZnzz3B88tcEgY3TmP1h/bbCyyJfLYQMcKckTF1+OU9pzItPqyuQ1e53sQhYffNB/Jl/Bxds4sbjifujA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071



On 2026-09-30 12:25, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> [Why]
> 
> DM was declaring it's own list of has_alpha DRM formats to check against
> for enabling alpha blending, when the format->has_alpha already does
> that for us.
> 
> The self-declared list missed some has_alpha formats, causing
> direct-scanout planes with such formats to appear opaque.
> 
> [How]
> 
> Drop the self-declared list, instead use the format->has_alpha field
> directly.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Leo Li <sunpeng.li@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 20 +------------------
>   1 file changed, 1 insertion(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 0b5c4be1b3ec1..df6784d58c382 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -113,25 +113,7 @@ void amdgpu_dm_plane_fill_blending_from_plane_state(const struct drm_plane_state
>   
>   	if (plane_state->pixel_blend_mode == DRM_MODE_BLEND_PREMULTI ||
>   		plane_state->pixel_blend_mode == DRM_MODE_BLEND_COVERAGE) {
> -		static const uint32_t alpha_formats[] = {
> -			DRM_FORMAT_ARGB8888,
> -			DRM_FORMAT_RGBA8888,
> -			DRM_FORMAT_ABGR8888,
> -			DRM_FORMAT_ARGB2101010,
> -			DRM_FORMAT_ABGR2101010,
> -			DRM_FORMAT_ARGB16161616,
> -			DRM_FORMAT_ABGR16161616,
> -			DRM_FORMAT_ARGB16161616F,
> -		};
> -		uint32_t format = plane_state->fb->format->format;
> -		unsigned int i;
> -
> -		for (i = 0; i < ARRAY_SIZE(alpha_formats); ++i) {
> -			if (format == alpha_formats[i]) {
> -				*per_pixel_alpha = true;
> -				break;
> -			}
> -		}
> +		*per_pixel_alpha = plane_state->fb->format->has_alpha;
>   
>   		if (*per_pixel_alpha && plane_state->pixel_blend_mode == DRM_MODE_BLEND_COVERAGE)
>   			*pre_multiplied_alpha = false;

