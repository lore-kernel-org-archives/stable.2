Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012046.outbound.protection.outlook.com [52.101.53.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBBA383C85;
	Thu, 13 Aug 2026 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786643143; cv=fail; b=RYZ2HsbD5mZt1yYsXDFAZEqZOq0pzb8R5lVe3EFarVZHGzl4sq7GGbdZsJcXZ3Zn2YkFDfJnthVDquu5qzKyCUsKK034FYYOvKMjx4Tl95qdArNlgfVcvI/jTvbI7iI5yqc3fEx9OyetpFea/AixVao4sB0bLi1eWHgCXTUOukI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786643143; c=relaxed/simple;
	bh=8qG9RryLRT3J9eWOl0HSNf70+6m/pD0KoQuPbcZLEAY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AN9njWm9kqRfQFh9Jsfm1J3wuT+i05Z40KzWRFNTOUOcECK0LIV5UfjX7blLTT1I1LEo83XwN3ObY+sE0YfCutZzMDjS8AuzKTiFbV6q6SEOgOT7/XLVhEOzuRHnCoyLGPQwdsdTBdS5sCB178hpNb12bg2bA6b7RGIT7zIp/9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r/c1iNrN; arc=fail smtp.client-ip=52.101.53.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r/c1iNrN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWN+7f14RMU2bNax7VsCwk7cSiDXWzBEBo/4nEithW47iSJNlDuR2v2qI46/hJIsq2b9Fi4g2b4pPEGvNNyrEJr11fJ/jDxDn6yPLQ6p71rIbgx4E7iq+dDHmTwAeudT8uZMXaX8UAtEcYUIiqywBGcnmzL6dQYcShSNDjyWK7ZIhW30MfOrYkcqJH1bQL4iG1GdDCBE5oGu0C/QnH8almHeI7fZjNyPBnKAZrHH1SnS9AwaP8CyVrGzrOTBpXO1OOP2d7lEPdfouXhUWvfi8aWQheJJ6cmWmQyawuqYcBpArqMm1cdNFolDBp6CvIWv54rkIeOjoQt8prUp/gme8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUfxBTxzhSz4G0gdilYDBGOvDoOEwYVztntJJcjF1r4=;
 b=TRlylZOEvSQdjwFAnGZb4RqZ76Qd8sJtQw+jQSJ8SROcH4/UQkYv/9hg83qJGY63OjSijKdt9rTD5FEiGnwG7OOGtGUHiNoqYGmjF3W8H+EYnWWkMSGkiRYdbP7dT5q/iLvtva2sSnpxss71ARIjG9YBaIWU/A/sQe3XpNsWOouKzR3/UseWO9umk6yanpFa2IyyzAyHUVnpYHjRND7j4i05uip3eLaVUJvGMTWFV/Ds/A9mzNkx9O/OzOzEefGKhSho18+6SKuoFhlFQDep5/4YpSIs/cU4W0zqR3fuaTD8ZHAxt4v5Fdovkrwb4duRu3mG15J5yl3FqhNMENT7oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUfxBTxzhSz4G0gdilYDBGOvDoOEwYVztntJJcjF1r4=;
 b=r/c1iNrNvxIBECjyOzeIaVKSUQ5Ez9PxYO9fyLGq24VBmJYSB9R/IwJbxovNNV0iA34zQ99/oL6MbSSw0H/WXKoR4/X3aT1aQWsGC1aqz0EK4v4SV6rmZQQqCUnCqvjxBO8fXYp3N3+5hvSIHXQ6hR/X6fKMjHqPUJhswuR4gtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 17:45:35 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 17:45:35 +0000
Message-ID: <20f0d0e6-c551-4982-9820-68169039e504@amd.com>
Date: Thu, 13 Aug 2026 12:45:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Scale custom brightness curve from full
 range
Content-Language: en-US
To: Akhmed Zhitaev <zhitaevakh@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, roman.li@amd.com,
 stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260813170959.22073-1-zhitaevakh@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260813170959.22073-1-zhitaevakh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:610:74::26) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DM4PR12MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1582f2-07e8-4a68-a2a0-08def962adb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Sq0q/c9k2ShPrKn8PLHp+FTJRV9vePKgM90r4f2fTCk6C5kcgtusYyA+uDb8NhqlpNRQJ/h2KINgJ8i/CGWPIBan+LP4XPXhj439/8THQ0hqqJYZy67zailqgyc0pLMjHIbqrvsylZDQKoleL116jOQXfFly27aRsidWawWxl0sOE9uJMLv6CYyAqVfevmXl5mt3aHpF9KrOd6MKfo2Apus57H3XABCg848r/KyrX/oVj+cn3eyKcNV826Uulz9sQe2Y88APAOYw9njQ3GCePW1sjI+sjzDMog5TYlzTugyfKKKdJlF1XOsKKj8N85Vkh9Tk5UPpJPT4lBoXPkMdXeJHHV4opSyvnu6gu1h9qftHpX/SHKrigt9sUM8WuSli05uXj24OkMfgXt4fQa39jI5nAVw9w9pzaEXBl1dlnjVu2LoNsC0FgaH0GiFC/CoMFo602jqWmLkIgi4dz3z8pvesatelQtzTMrrVTf86PGrHectC0MId/0cQ1138A5n5yqu+uwVQqmn/yEbOSme1SFGZB5c6KIwHH5Qwgz62vJWExu/1qyVDyBgdJz+q5rktA2lezoqu1LP5hyE2RBPIiMJSl5pLVgCj0W/8RRNxTOQcgbiyelvHHtSMx9fSiWqz8GbVAbshpRvzYhL+i0mdclyYaCtUpQ080hc0q/Mq9ew=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3JRSkg0Z0NVVGVSUzR5aE1aWkdPR2QwbWZRWTlXT0o5K1QwZ2dSVWJvRm90?=
 =?utf-8?B?K1NrZUdGWXdVMDBDV1hEL0hYaXpTSklQbnJhZ2xhQnJzUEsrNi8xMytLdzBS?=
 =?utf-8?B?MzJKNzRBczBMTXRCRnhBeUhUcFUzeXdDSnA1NkgzakZvT2xSR1E4Wlh4elRr?=
 =?utf-8?B?cnhaZkFKMFN4T3lBL0p5bGdmUDVyRDlNM0h4ZjlqM3h2SUw2R3djRlpqb1ZF?=
 =?utf-8?B?L2FHYjdoTnRsNUd1YjB2QlpoWDc5T01GWElMTUhRT2tyY1E1enhhaEVKTWZQ?=
 =?utf-8?B?ZUtxamo0c2g4U0pFYW1QL3Nvemp5dUl0d0RTelpaRlNZRldIQ3ZQdlJXTDJ6?=
 =?utf-8?B?YUtDK1VmSTBSOWNidERSOEdSV2dGeTZyR1VETW9rVDBlaDcwclZySWNIWWwz?=
 =?utf-8?B?Z1BLNDB3ZXpNMFl6am5lWmd1c3FhNW13L1QvV2hkaVZ1ZGNwY1V2YVdEOEcv?=
 =?utf-8?B?MTJzalY4U285TTFSL0tXcDRTMFNKdUlYVklFSm9ZS0pnR0Vna3llWVZWTkhq?=
 =?utf-8?B?Sjh2NTFNMG5BbnVDSEtGT3NORWZlRUFkQ0hucWlSWStodk9iSkhLMHNZVXBh?=
 =?utf-8?B?MFVzUG5reW9Bdzh4aUZVaWhPcytUcXFWZi9CR0RDaVBhdWh6czhNS2NPOWNu?=
 =?utf-8?B?ZFFLa2xaTVpjYU5VbU9aZEFkNU9GdjZIajVFL0FkcGRlS21IMWNkNW56Z3VX?=
 =?utf-8?B?YjZWWlpOSW5WMjdweTN5ZG1DYm9lMlJ1N1lZNGMxdFMvdkwrWkpVSnZNdnBl?=
 =?utf-8?B?SDhyWmxaUEQ2Yks3aUdBSXNqeTAzcThuK2FodnczZ0V2Y2hHVy9pa0l1cmY0?=
 =?utf-8?B?NlJZUFVObWxtN2ZBa0VlSWZMVnBoK29QZWpjbFBQOFNKZ3VZRElkQ2ltcTZ2?=
 =?utf-8?B?dTJKdkZyOEVGWWtKYXAyckRNZmNvY002cmFIYWdrN2QwWjl1THEwN0NkMlZl?=
 =?utf-8?B?d1I5am9qNmIxeUpueldxZEJWaG5PZ1BLQjRnSkFaVnM0ZURYZWtHYUEwVk5t?=
 =?utf-8?B?aGlCaEl5Z2Z0b1labHRjaWdORFVEMHFLUExuL1BTdjE4bkp6TndBV1FrQTcz?=
 =?utf-8?B?Nkc0UWxVZEx0cXFROHdzZnFXTVBjL0IyUVNtMFp2eFh3MXd2enMwbW1BQVp5?=
 =?utf-8?B?ZTlETjFCVmxVdUlQMXZkQTRjOGxGck4vaXNYeHZvUzh4Q3RzYks1azJGejZ6?=
 =?utf-8?B?WCtvb00zMzRLYmw0QlNHNXBmUlZaazRKM2o2djRDaDcvMXNONkZjeE1uRWZF?=
 =?utf-8?B?MWNEQkp0RkpiODVRaGNKZDRlWUlWeEhIVXI2NDZpYmVQWG9QbEJsNEhUc3JU?=
 =?utf-8?B?ZFYzNkVHamJlL3pHdE9oS0N0YUxwKzFxR0lhclpEb0p6cVQycThmMjh4SzhX?=
 =?utf-8?B?NXZZYXBxb3l2ZjhMS0Jpc0JQWWVlVE5YWDF2YU9HZEVRdmJpMXZTbE9FRENW?=
 =?utf-8?B?aEtNK0FOL2FlTkE0UEh3UVU3ZWwzcTJxSW53VThheXhNY1IybjY0RmhMUEVh?=
 =?utf-8?B?UTZFRVJraGYrUkJvZ2JEQ0UwbHN0NmZzUTNYWSs1SU5VVFM4WllhQWU0TVBC?=
 =?utf-8?B?RE5GOVZ5RGxMbVp4V2xHQ1BrZ1hqQ1lpeGFtNDJxZkhya1JtanM0Z2xueGZU?=
 =?utf-8?B?UXkzai9TbUt6WFQ3M1VncXJmcXlmVyt2aFFFT0RhSzlrK3JNOFIxRHFuL2tV?=
 =?utf-8?B?OFdWTGo3UjBwWlAwN3dFS2RRSTRmVTArR0thK09UWVNtTGRyaFQ0SHZaUk9h?=
 =?utf-8?B?cDhwSytKRktRZG9wc3JJZ21VejY5Z0NWMUhJWlZNOHVLK2QwUGw1QlAxa2hX?=
 =?utf-8?B?cmdubDlxLzZvM1VXV0hmVGR3QjNsbmJXd0FmcUJ5Yk9Mb0x2TzJlRHl3Tk1v?=
 =?utf-8?B?aUo4SUM0UDBWSDU2MmR0ZVBKZ0xObUVyd0VaVU04WG9nZnIrL1lJZHhqQjAr?=
 =?utf-8?B?eEdkR2xudXNJSFg1T1hldUpjcmtMbXZ6QlJJbHN1RW1JRU9xQy9YdXhnNDhy?=
 =?utf-8?B?T2thZzR4YUErNUFtV2RNSGtrK3VxdFhtdzRkZW96VWVCajNTNDVHb1pNWnhM?=
 =?utf-8?B?dVFDcEtpTDhEMkdoTXpuZ2R5ZWk1OExqZFBoanhUQWRLblExcEd0UkVTS2t2?=
 =?utf-8?B?UWZtL2pnWkI1a3RlSDFhVTlyQ2loWjIwdi92dzArdE9iNjdJckJZdmNVYzQv?=
 =?utf-8?B?QXJsS1FUN1NIamJQN1dENDEvWllTY0dDVnZ4RUlTa2owZmlScWtoWTJhbTNG?=
 =?utf-8?B?V3hxNGxaS2pGb0ZYeWhvRW9tU0Q1U2lLYUFnNDhwNzNMRnVWbmJGQm9GZU8r?=
 =?utf-8?B?dFFLYWNESFpiMEZHaVlLZVV6MnNrT0h3RXNnQjdwTnIxS2tjRE42Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1582f2-07e8-4a68-a2a0-08def962adb1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 17:45:35.2247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdBZmsX0i2AHbaaMX9ybmRRPhbGbYCip9NnEul7TYX4TV+3gS83QruoVAsqfZswm+Y5KRh1mskg51VpYYRsdIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767



On 8/13/26 12:09, Akhmed Zhitaev wrote:
> Custom brightness curves use an 8-bit input signal.  After exporting the
> full PWM range to userspace, the curve normalizer still divides requests
> by the physical PWM span.  On panels with a nonzero minimum PWM level,
> this can produce a curve input greater than 255 and send an invalid
> backlight level to DC.
> 
> Scale the userspace [0..max] range to the curve's [0..255] range
> instead.  This retains the full advertised range and keeps the reverse
> readback conversion unchanged.
> 
> Fixes: 8dbd72cb7900 ("drm/amd/display: Export full brightness range to userspace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Akhmed Zhitaev <zhitaevakh@gmail.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 40d82a3ee..533c69f0b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5131,10 +5131,10 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
>   	return 1;
>   }
>   
> -/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
> -static inline u32 scale_input_to_fw(int min, int max, u64 input)
> +/* Rescale userspace [0..max] to the firmware curve's [0..255]. */
> +static inline u32 scale_input_to_fw(int max, u64 input)
>   {
> -	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - min);
> +	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max);
>   }
>   
>   /* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
> @@ -5147,7 +5147,7 @@ static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *cap
>   				      unsigned int min, unsigned int max,
>   				      uint32_t *user_brightness)
>   {
> -	u32 brightness = scale_input_to_fw(min, max, *user_brightness);
> +	u32 brightness = scale_input_to_fw(max, *user_brightness);
>   	u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
>   	int left, right;
>   

Is this still needed with

"drm/amd/display: Fix backlight max_brightness to match exported range"

https://github.com/torvalds/linux/commit/f1b5d8f9cc54ae8a2567ac126867ae488e1bf625
