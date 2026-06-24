Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9994E2472A2;
	Wed, 24 Jun 2026 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782317180; cv=fail; b=pjZwC9JhsAZ67+SL0Vs8p5OSGW7reuNtWLD1aZ3f7kRATWWRWKVSh7rOmKC3dAdaPhziRi6YKfe0Xj4Gtxeu7BMCa3lC05yw+qjhzCMi8qiTstdcmX3IYKPO7wpSYGEGytDs6VACxsqyVIB920h5+73I1IhlIhH80jerGlGbtOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782317180; c=relaxed/simple;
	bh=PHiTP6a5fz4jWjIKhMMyzkpgOBKGSZCPM80zdcu78ts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jHKQ0mCfxjK3axywV9Gq8pUMNoN1YvDF84HqXsZ8R4YAgN5USD9pCzfLG8ha2D2DhyETZxn8sDRNBJ4IEkP1lAZC7yGlHObMtk/4mtQhjwzfanW30wpRZ8VKhdS0Ep+G2k/hSMCNiZm7otFSiGNllO8yMfVkQp0z5Xp97fLf32w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TBblVmJj; arc=fail smtp.client-ip=52.101.85.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TBblVmJj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbPK4n79dIq8BlwIbb+IxdPK18sFIudFtd/RwsZ+AWWHLi5Hll5jM+ShellZMU3NUOnTztAXzeSDTdYiBFZ5wzdWl966k6M6UL8yGXGyfj9WAweDhipEsU7UWa6aA9+O5q3BYZP79t8g5jogwaND31+B9dwMjqaRKHqm8xaYGjDN04Y9Gs/MqmFHenButk6KDkVrO8+cNx1bhOoEPggIjo3mR/E4OpooCdxliDJ2z/0ENuoYNPhoprUAZd5IorCuoGT87OgNtdgewDpdAyky4PmfO8keiwvOstkqcFvg6Q6O3A7UHSWoJMyox3sa6cMaBKjG+FsukkTqnhc3q6+KpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdUrrqULep6MhF7cE9TjgShpa1hSivDoozD+Kc4K3a0=;
 b=a8FkXWjInSMkLEk0XeLQxDilMRq2ZmkYk/+/Fcr2MVU5FSpWcewfegsRMMPXgFcXDjBP1fE2seGBrVHRBUzFioYg9wE5B1KdjlVCtr2T1zUvOVPAek6rZjLkYNDl0HRjPKvR4kvjk9oEhS/sEWtOTR6QHkbC9urVMK/3hhcJSApaevc69Z6/FkRxBArEdj2l/by0r2njPEg8cHNBuLparl4ytPwZNR3b9Xay/4H4js6PvrFBbK2aTmBwAFkoP85BnAvQdtTPrmDIqC7B7KaDygfdSs/TDAUTxRdEKIAJqUrUxdFNWEysPHY/CPl2G1uS+UlwchFJCgyhiJWPwvtOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdUrrqULep6MhF7cE9TjgShpa1hSivDoozD+Kc4K3a0=;
 b=TBblVmJjbP68GIi0WwiGFWAdLihB6JNzHrR8s5Ug1I2p4vvunu7RokbtJpGHOl7vEJMdEfkPKUjWFAQ07iw1RXh7dt6atTiuIG9hK7AIs1QmgY1SN4sSOI9P7eCmM1IPBXDF5iKtADlrACvuA8t6yNhcUBMTLn9qA4SSazyKvDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 16:06:15 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 16:06:15 +0000
Message-ID: <ad39a114-98bd-4711-8795-00409f3175b0@amd.com>
Date: Wed, 24 Jun 2026 12:06:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/15] drm/amd/display: Handle struct
 drm_plane_state.ignore_damage_clips
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklkml@zohomail.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, javierm@redhat.com, dmitry.osipenko@collabora.com,
 gurchetansingh@chromium.org, olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>,
 stable@vger.kernel.org
References: <20260610152505.260172-1-tzimmermann@suse.de>
 <20260610152505.260172-2-tzimmermann@suse.de>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260610152505.260172-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::15) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e78edeb-1d8b-45d6-a463-08ded20a8494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|921020|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	NCBSrW3aIfNukg7pEpvpT8iky1xJXIQXfwJXjXhVmSPfgAaLc82KoovXQAyvTe++J9Sj06AjpFKcgaUXzlSeG4ALQin5sr96oEBXogUbGmYPdtS4E9Rw8yGuJUnU/77bpNUWgVMiAk/2ZHf8tH+HEWDv+7RXi/ezEO1RMFpnpMsB9aXBBiMqYRiK6D7/fZQD20DBtye3n8TroEuMq9ZJIfu+mg73bYR0Yz7KwmVuuNw5VpkUhImf7TZfDB8NOnoarBwTExbhQg8WVjzES2ejuvRXF5EGGf+3nFk+r0JT9PUUV8d5HiXf5CMggA1uzJs/bzJqejVzfLqyRoNGDmJZPol8D9G9gWjVJyg4v8IjDHM+wKHNbyzwW9PfPVRa7tFZM1ocnIWlRKi16kirMuFcDTKKMOOdzrcnNDyKzaYpmfBWSavSdQojeh5E0iIzFiFdqKid/gSDiQflTIJ4aJQEz06bW1PlMakGFQpGmdND2JjwZWC7NVOR3KNJ/eCgLudjWeO77Pzi2Ch3lb9GdZ1TIXBGcpR3gPp9DIsTmhDkeQuurWKNJYD41WdYbKfSfk9H6EmTx/R9aqz19oTweykokhyFFTXKC37HYRJvOO/v2nJZEjQT8kFs3iUmvPombKEPKF+R07mjET/+e4Zm2BTGBuBQCQ8y0R7/9qwAGGssyFBIu0ObgkSAmOq4mh18n7/pRDorapseuYlb9YccEQNOQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB7007.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXZscUlRcERaTnJNeXIwdGdVTHhyM3k2WlNwSXZwYVlBQlN4WWk0NWRCKzFl?=
 =?utf-8?B?RXU2LzVjUkJ2WkxaaDU3dDZKdEZRV1lKWDZhbThLbjhKT3dTZXl0T014dTNH?=
 =?utf-8?B?MHJSakpGMHZKdFl1WmlUZTdjV3VTK2lFYUM2TjdOQ2dXRmRjSEowRXVLWVQx?=
 =?utf-8?B?U0Z2TTNnRFgxZ3VvcVJxdVh0UjZCM1ptQzlROWNiUzlzTWtxR29KMVJORXVD?=
 =?utf-8?B?bnVvb1BBTFBxQ05zYjczWWYwcjF4a2FMT3VPUURiS3kwM1dMR0ZWWmJ4NDk5?=
 =?utf-8?B?ZWJ1aEFpNkFBV3IwZHRQeWFTN1ExVDNJUVZFMmdsY1ZMREpaRVkrZFRBTW5k?=
 =?utf-8?B?YXBFdm9PNE1xQTJYRGhCSmt4eWtMUGlZcHFxeEpiTG41VmxTQzZsZmRyZHlX?=
 =?utf-8?B?dGJwMlF2RjhzYnVFQzI3UlJIZXFRa0gzNHRWbGQ2UzgwYVBrQlo5ekZ1YzZp?=
 =?utf-8?B?SlN0UjAxcjZ0Q3p2K0hyNlhPajhsMitsaEdpcTVRR3JCMTMyZEN0R3MvWDh2?=
 =?utf-8?B?U0cwa20vRm5NYVZTbnIvUXNrRXA2UDZ2eGRZVDFzT003RGhlckVMS2hzY0xF?=
 =?utf-8?B?cmdmTE9ZTU40K1VyRmh0eXg2dEcxampNU2pZMC9XNlF5bWpyaWlETnpaY1NM?=
 =?utf-8?B?dGtnZGxyWnJIdWcyR0hyOFdDN285L2wvQUdzK0hGSE5OSmZGUnlKZTUxTlNw?=
 =?utf-8?B?RTdPcTRQMHNrU0V6OFdiOG5XdVhQUER3b3dkV1VIZXdRZkRQcS8zZmlla2xN?=
 =?utf-8?B?NG5pY1JXUzdnYm5KSWxON0xhLzhZMEFTV1ZIN055UzcyRUhidWNRYVkybGs0?=
 =?utf-8?B?VldmU01CSnVWWkVQNG1zRzAzNnFKNjdTczhSdTRjelNUUUxiWUx0UHRvWU1z?=
 =?utf-8?B?bE93dG41UEVPZEpRZzhmSWcxeW95UGVzQ1pDSDlTckdlK0Z6Ulo1dmJ4RlJF?=
 =?utf-8?B?YlBDRTZIN3B1V3prelFuMzFXcUlRMTIvbFJXQTU3V1lsMkJtL1J2dVhhM0JV?=
 =?utf-8?B?TUt5WGtqWHgxMlg0Z1JFK1JCZzVubVNLaUFHMWxlQ3lpc0U4cUJrREpBK0py?=
 =?utf-8?B?TjUyR29tc1J0VzFwckpFVmVNYmkrdVNJcVNYWGk4RGNJQk9pTEZ1QlVCczI4?=
 =?utf-8?B?TVJTZUszcVZ5NHNBSEVZOFc2RUNMay9Ma0ZTTnZBK3l5b3d6ektydEdyZGg4?=
 =?utf-8?B?ZjJSK3hBWC91Z2ZDc1BjRjQxcGYwV0loTEtIUVlBYmp2eGNVS0FOVTZFMjRQ?=
 =?utf-8?B?NGNobW5DNTB1d3BSdEE4ZFFySUNJV1pVUTJEMHFHMFpORDBNdnVRQkE4MUY5?=
 =?utf-8?B?V1oyZHJyU2pvS203ZkUyS2JRa0kxM0lnLzJKUlBCOUhtR3V6dVR3NHl1MlFM?=
 =?utf-8?B?UjR1L3VkejVLSnBMc3Ard3JVTEFyTDNuYmpPWDZHZ3NEcUVNZFROUEhBdEVO?=
 =?utf-8?B?VmZmbzZoR0cxS1lxQzd1UEswMFF6dWhYNWVGYTc4RHB6R0NsZU1SbkxSa2Q0?=
 =?utf-8?B?ZW1HZ2kzeVpnaGFxaHh1dEhPMDVkRG1aVGJmV0xxanQ2anhIbHRwdDFXeVM0?=
 =?utf-8?B?VTBYcEx6dERTaDJUc09TMitheVdMU0t2SVp6WTArUld5MFpDcWM1VHJQcUpp?=
 =?utf-8?B?YjRMcWFoaUtzWFFPcmpyTzRmTUtnRUpEeHNnbEt2UWZBWXpwU3MvdFNqbjhH?=
 =?utf-8?B?bFZIeHp4TThNM3dPMGoyYWxoQzZobWR2ZWwzampaa28xQ29QZU52cFlHVno1?=
 =?utf-8?B?MlNuTFplSHdvenQrdWY3cXBKRGtoZ0JNZU5WUTdpbFZjamRTY0ZsSFVLaU5z?=
 =?utf-8?B?eGlzK1hBVGpWWHJiY1VEN095OVVZYmZYa1BRTWZSd3lwbGxybW81d3VDVmNM?=
 =?utf-8?B?YXBwMnpuZGRFU3dqZHRNSGFyY2Q5bk4xTTlhOWVuN1pHNFV5SmhEd29HbS95?=
 =?utf-8?B?ZFgyYVpWUEdZbTJYbWdiMmFSbDNGN25YbUFOVCszbU80N01LZzB1RmRNbWVy?=
 =?utf-8?B?Y2N2NUxLK2tGUTUrbmV6d2trK3lObWQ0TTVSRXZxME0rNUJIMW1lTW9yNjIr?=
 =?utf-8?B?Wk1JcGFyWXdoeUR4N3NzTHZmaExVclMrc0FqYWIvalYwMjNoUGxRVzEyOTk5?=
 =?utf-8?B?Y3VmL0lUaUVicjFjdGY0UnR5WWN5alhNWmZ5QUtKN1crSXdJaXN4cmZudzhF?=
 =?utf-8?B?Y1ovYTJ6eUJCSm0wWmdVRG5RRVBIbFRzMFA3cTNobENOcXRTQTY0dS9qYTVV?=
 =?utf-8?B?TEhKNGZRT1QyenZWN0N3QmxMc1lpK2RVNFlyZ1BIRTIySWRsaVlKSitvMitX?=
 =?utf-8?B?dUxpWWdTS1FMNzRROFBpRlNXT1l1QUR2akZQeGpXSVIzbEhuZVVEdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e78edeb-1d8b-45d6-a463-08ded20a8494
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 16:06:15.1149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVDnNUwNCZTIBsbc8ttGuT3Dx7IEa+dT5yCCjM2Hqrgyq7z0q5+iUHwcgbH2hNkA1PemFwsTCS3MZZ3+bMTFvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677



On 2026-06-10 11:18, Thomas Zimmermann wrote:
> The mode-setting pipeline can disabled damage clippings for a commit
> by setting ignore_damage_clips in struct drm_plane_state. The commit
> will then do a full display update.
> 
> Test the flag in DCN code and do a full update in DCN code if it has
> been set.
> 
> Commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers
> to ignore damage clips") introduced ignore_damage_clips to selectively
> ignore damage clipping in certain framebuffer changes. This driver does
> not do that, but DRM's damage iterator will soon rely on the flag.
> Therefore supporting it here as well make sense for consistency.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Zack Rusin <zackr@vmware.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.8+

While I haven't looked thoroughly at the rest of the series this
patch for amdgpu_dm looks fine.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0e20194e6662..4cbb27f65a0b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6614,8 +6614,8 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
>  {
>  	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(crtc_state);
>  	struct rect *dirty_rects = flip_addrs->dirty_rects;
> -	u32 num_clips;
> -	struct drm_mode_rect *clips;
> +	u32 num_clips = 0;
> +	struct drm_mode_rect *clips = NULL;
>  	bool bb_changed;
>  	bool fb_changed;
>  	u32 i = 0;
> @@ -6631,8 +6631,10 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
>  	if (new_plane_state->rotation != DRM_MODE_ROTATE_0)
>  		goto ffu;
>  
> -	num_clips = drm_plane_get_damage_clips_count(new_plane_state);
> -	clips = drm_plane_get_damage_clips(new_plane_state);
> +	if (!new_plane_state->ignore_damage_clips) {
> +		num_clips = drm_plane_get_damage_clips_count(new_plane_state);
> +		clips = drm_plane_get_damage_clips(new_plane_state);
> +	}
>  
>  	if (num_clips && (!amdgpu_damage_clips || (amdgpu_damage_clips < 0 &&
>  						   is_psr_su)))

