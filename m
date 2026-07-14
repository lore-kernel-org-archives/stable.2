Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F878286D4D
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043497; cv=fail; b=BuUDPRAm7gKJCkHxby8k9EdzpcejNpMAZVvGQCMeXTc2lS5YXgOOiT+0g3Ht0pL/31v/sTv00+5VncTBxw7Ug3ZmIa9wcgTRzniWg+vq2UkPT6+ugyubA8ZdhcIjvSLzA8UjK8/7McEHhYEZRmxz/tyX6DnKOXq4uPvOVfVXU0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043497; c=relaxed/simple;
	bh=uoNvtJYQQ+SvOfxns/A1Dq8Msrnx0LSWlSH7WAWJT5k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dpvn42YTzKa6crDPyyYapoVyUR0DNFGkhNRhDb4fc/e8YcRwflhdGf2ek3MExnsvE9nN1l6znsxX1fwRS0xp2fdqe1waTrfu38/5WQC8IGb2ZnCw/wCS6SODVNUy0eKVPygQRBjEkiQuW2wu4pNrxVU+IECOP7wNPbYSi5cgpTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EBHvpIzC; arc=fail smtp.client-ip=52.101.48.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EBHvpIzC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmHYnbb3JTQgFnUr/+Ex1aXHLI+WBcseC33UMA852hHHsStMDbar9cYcJ9eE2npyPnBsYYsALXB/v6BxhdQvidGjG/okK87XG24/G+YRojdvgpwaZeBOMRCaBP+SbPuXvnkvRsqbt34pmdbL4n2EF/6ZXbUAcVFA4VGiCmsj4p147FdX3EFwfMvPEq1PNXEvmO2mnlvz0w2Xjjshm163wh7ZBsEDkZ4nzLqJX54eLTFIkLIsswGV0lPsVHvB5CH3SArk1rBRnuCIgpuINGYTXFj+81P01jYw/ldEYB66UKpptHZmp+J/gvVtqUb9CB7VkjLZj1WQ7Z5jJ4bue93KSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkrrDHOmRZ2mKy6GWwwjY1FlbYv2gHznc4eKVLlGU8U=;
 b=YJm+e/VYcn1sjIEjQWqdJwL4M5G+rvGzAhG3oO2766W06OJlyxWAWB9ogqg0UCpCm6lXbyJqe4+oRhyaezM4rliUnrnUFB4UyxKXyEakyb7LbQddl8GP8tAGJCtilLhImpK0ClM4LCvwFfHqwqvCcC8sFXLwlsgK287359unOC0qaipavSkxmG3NuYtGNzhz2XxZULPy2N3a/fgDeUGa6jbbXWRPEOcRHlTAVyWkTRu+UU+v28xF4HAcP1aQ11ysEpi7O+lcDM2VNEmue8iby+UNAmbM7uhBD3DkzJjmB4QFc47rEYBaQoV+UkfanZ8/GvDbazgMNuWmb3beoJvWpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkrrDHOmRZ2mKy6GWwwjY1FlbYv2gHznc4eKVLlGU8U=;
 b=EBHvpIzCuyHXWIWIfY/kVqYCo3X9AOSYRoTq8iFu1EpuA0pB/2Fmqxysv9gpDcQhvWQsUtt6inXWjJBjISXhkyitR67NvrpFN2ss1smW5xg8RksK3NHAcev7iWfVqQD0axONbtsCL6/3E8bXzntCTFNL2QhaOT6r8pYjQReGSYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 15:38:10 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0181.019; Tue, 14 Jul 2026
 15:38:10 +0000
Message-ID: <f50d304a-c9c5-454c-a4ae-f4b6e9b85f4e@amd.com>
Date: Tue, 14 Jul 2026 11:38:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] drm/amd/display: Set COLOR_SPACE_SRGB when fixed
 matrix colorop is bypassed
To: Robert Mader <robert.mader@collabora.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20260623164812.81110-1-harry.wentland@amd.com>
 <20260623164812.81110-11-harry.wentland@amd.com>
 <eae10264-51ef-4e0b-9774-a694bc7f95b6@collabora.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <eae10264-51ef-4e0b-9774-a694bc7f95b6@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0203.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::28) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|CH2PR12MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: 99debf5e-f51c-4a90-8cd4-08dee1bde88a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|5023799004|3023799007|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	0Wq5K+w4ZkKNqa6PNBvnj19yO2iumxU9h22OAmMP6eodxilvY61n/fNc7QIN5pJO2i3lVDHgFPfuB+cU5t4k4ZfjnO6LioyQS3crPCkwP9uH63bIrJohuCyZucQDAfovanzH35vfXcaz7K7nCOdphtEJ6I/KyY8H+rscMZx6v1Pazydg7TIQlA+p4v0X7FXrVirkqEsMgpBqfQXmJeBD699ThrJFi5YqM4pJnKHIMq0vEZM72JQLHDtM9b/Y89/z/nB6YgVJPTJIJgxkz87OQ2mw1BYA390pyiKYppVb0XFc8Ts1ujaLaShc9V3mWqxHIWnIclzLIsKUayVTjP47uK+ZrwWKDWyG67IJEBxzzIM3vdY3dWW8JFu+kkSrmW0XnkyISvkeHDfY4b/uOlY/2bnrC4jHrUX22JvVFzvVuQD28zCyp/5iuioUJ5vEomCzvVCgfBX2/C82HoaA3sSASjD/OZJpSxrlPea+jZwZtS5e4W/+8Vr+W/IX2ijaySI8cZpZRfdD0yLqEuOKycVYyBlzWk9iVBX6+XDfPLJ03VixRN/Bkf9ThOQC+PpP5cJAkUk7JY2N+Z0lUgf5wLSLRp4jOq54e1Ypd18JBCR82d8enNYHZN+i5VcPoqEsRi9CkyJtugrbpxKAM13Hm2zKdLBA42GATisux5VC4shlp8s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB7007.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(5023799004)(3023799007)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHB2TGhNUXBxZVhVcTdJSUtaV3RqNHBPV2lkOWZuYnFic2p5R1QyM1ZPU0cv?=
 =?utf-8?B?WUVHeHBWRFVtQWtPR1lTRzY5eXAxY0ViL0NSQmc5WWVWSTRCNDExQy9JREpV?=
 =?utf-8?B?WXpIU0wwYmxpNlFSNk1XeUVwRjlRWkt3WktaQWlxRGswNWRwUVNhOGJMb2k5?=
 =?utf-8?B?aUF5RkZ3QXBLL29BWG9OcTkydlpZRytoS2NDbnRXSFVhT0hLWWFSUnVBQUR1?=
 =?utf-8?B?YnRSSWJ0K1VZQXhLcUhpMEx6MUhieXpYb0xtbXQ4QTBsbEFFNEkrWnU4RmJD?=
 =?utf-8?B?dVowVzQvZXRPdEQ1TENxZUVmckpSa1BjQnpVRXQwdUFrckw4c25tYkg0YjZw?=
 =?utf-8?B?WGVRVm9BQ1ZhZFkwTWMzcnh6eTNsQ0wvZnN4eWhsM2E5elE3ZkNSS2ZDSUg0?=
 =?utf-8?B?eFRNTFlPZ1YvN2NyN1dSc2wvTDFhQnBkbEZpZjN2bUNUbnB1V21hM2I4OXhS?=
 =?utf-8?B?N29MTm1ZMUsrN1VMN0RWT1BXUWk2SE5QZlZaajhWdTVrd3dsUUZZNTZ0YStN?=
 =?utf-8?B?amdMUW1mRG54TER2cVRWNzExMFM0UEVZbFlJckNxVmE0WWxtbEUxazFpSFpq?=
 =?utf-8?B?RVNDN3k4cWhON1dDNmFmS1pkRHBXM0Y3dzI3OUJwSlJYWVVhVTZzTXd2akVv?=
 =?utf-8?B?anRNNFJXTTRtbGRQVUtEN2laZmhTaTVwdzdSUVNxdnZlSGZjMnRhT1dWOUpS?=
 =?utf-8?B?Y2NIU1dSd0JBMVlTQjlJVHArazBEamN0K3EzZHRDdlNCemRUbGxqbUw5TzZu?=
 =?utf-8?B?VGMraFM0dFdOV1F2OVBLTnRzei82WXFMdktyQ2NIU3VGR3FpZWtXN2VVQnRz?=
 =?utf-8?B?elFLTHdDZHZ1MnRjWnBGeFkwRTlVS3ZzSEdhVjJpbVZuck1KMFhleGVocVhF?=
 =?utf-8?B?WnQ1QU1PczBKNWE0OUVySHBxZHZQUHMxM3FESVUrUS9DZzFMdldkUnpjSUZT?=
 =?utf-8?B?UGNRV3hGVS95SkNQeWl2d1ZqK1NaQjZCaDh6K3NHa0YvTkNxbldSVmtmMnFh?=
 =?utf-8?B?ejhuaHNxZjA2UCtRL2c3SDN6QkU0dTI4ZERsRjlHUXZkV00waDRiSFRBU3E1?=
 =?utf-8?B?UkFyd0RkdklpblFWZERCMnYwSWUxWkhpN2V4bmZTQzJsaS94dzgwd05oMElU?=
 =?utf-8?B?emZhRmlsd25VaGRQQ0xIcCswejdva0htRXh3UVFXMnBEL2QwV1NsLzViUUtE?=
 =?utf-8?B?cGY1dEs5V0VXOUw5MXU1RW5iUWYxWDhyYkVzMGxZdXNGMFhYd3NiY2VtcU96?=
 =?utf-8?B?REs4QWVLZllHUWs3ZmF3M1VxS2diT1FraDNOa2JIejE3K1QyR0VDT05UdW1a?=
 =?utf-8?B?OVNqTFNjbzYydURMTndtK2FOK2tyNHQxdVI1OGljS0pIMDZoZDhGR2VFVGY1?=
 =?utf-8?B?eml3REk5R3dmVHhRUU5FdTBjUURhVkZscC84VFdGcktUQWg5YWpoOS9xRHpi?=
 =?utf-8?B?c3BJV200OUxzZi9QT0x1UkFaSk1aWi9iUDBGK2JtUC9Lc3U4QnYvR1NiS21F?=
 =?utf-8?B?aWw5TEJQdDY3WjhzVFoyN0VBcWMyODZ6M3dHSjhMZjBiL2hVQnVRK0ptOGxm?=
 =?utf-8?B?TDNHdEdGVjB5bVVXRnd0c0RSNXhFcVFJd0kyZmlZNzFzbURuMFA3K2psRUF2?=
 =?utf-8?B?L0JrMGZuWTgwZ056M0VzV2Q2ek8xeTJUbG9YaStsTEYvMW12enNYK0I4cDY3?=
 =?utf-8?B?SUVrbkNtd3Bzd0htRVA2eGp3WlFHNG90TFV5MFpDb3JIdlVXRVJVVjNYSjI4?=
 =?utf-8?B?Rk1XUklUN3FjYlAzeDRjUnpGYVBWeXpmUVRqWDZYUWs1UU1vRzNCT0V3d0h2?=
 =?utf-8?B?bm5MUCs5MGhvSzB2TUxPSVByWnNvdE11YVcram1UTFA2Uy95WEcvVnNYWTk1?=
 =?utf-8?B?U2JCV08wZUc0SDVTV0RmSHVsbjVXMkUwNVBLc1crNjFielFabVRzNlJubmhS?=
 =?utf-8?B?cGxBUVE0OXZRcnpiUUNzQjRjUytrbHFMR3A3b2hOL0hhdFJwSDNzdnFDc0hu?=
 =?utf-8?B?N054MVd6THR5am9Lc2IvbCtiZk56SkswRjAyUVpKaVJYWDA0T3p3NEFLakE1?=
 =?utf-8?B?NUhCU1poZzNvRFJzWWJJaXhienJZZ3gzbnIwa2d6eGpEY1pMbFhlMFNHMWJZ?=
 =?utf-8?B?WjJ1anhYcTE3RnRScUFNMUovTHpVUVhJWTJaWmZHL3BkTXFtWEc2VFBpVGRi?=
 =?utf-8?B?VTFMTjFKRFRPcWxOSjdyWnZTZFQ3S3B4WjNUMUhPdVFPRENGcVZNTkVadTV3?=
 =?utf-8?B?TklETmZZMHpLd2lIYmFlMnpZWk5VK2JHSGhERGpldVdyQzljdUMzdlpDTDlV?=
 =?utf-8?B?YWgxTFVCZldENnhkVnVWM01NZEY0WTFXSVR5ZXN4UHdacXVWb1pCZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99debf5e-f51c-4a90-8cd4-08dee1bde88a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 15:38:10.2129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yw2Do5w3BY0earQohyA8a2cLjh2/96U7EXw54WZMgIvqHtXuTfggsYAqVBJREKAtR1+UBlCdnusXElezxINDow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166



On 2026-07-03 06:40, Robert Mader wrote:
> Hi,
> 
> On 23.06.26 18:48, Harry Wentland wrote:
>> When the fixed matrix colorop is bypassed, the color_space was set to
>> COLOR_SPACE_UNKNOWN (0). In DC's DPP setup (dpp1_cnv_setup), the logic
>> 'input_color_space ? input_color_space : color_space' treats 0 as
>> 'not provided', causing it to fall back to the format-based default of
>> COLOR_SPACE_YCBCR709 for YUV framebuffers. This results in an implicit
>> YUV-to-RGB conversion via ICSC even when a color pipeline is active and
>> the fixed matrix is bypassed.
> 
> shouldn't a commit with YUV framebuffer and fixed matrix set to bypass always fail, like it does in the VKMS implementation?
> 
> If this commit is only needed for RGB formats, somehow getting a YUV-to-RGB conversion applied to them otherwise, then I think the commit message should be clarified accordingly, no?

I talked about this at Hackfest (with Xaver and Sebastian, I think) and we
noted that since this is simply a fixed matrix colorop there is no reason to
reject YUV + bypass or RGB + matrix. For all other colorops we assume
that userspace knows what they're doing.

Thanks for spotting the inconsistencies between VKMS and amdgpu. IMO VKMS
shouldn't reject that commit and simply do a no-op (or identity matrix).

For the RGB + fixed_matrix scenario both drivers already allow that.

If no objection I'll make that change for v4.

Harry

> 
>>
>> Fix this by setting COLOR_SPACE_SRGB (1) instead. This is non-zero, so
>> it overrides the format default. The SRGB entry in dpp_input_csc_matrix
>> is an identity matrix, so ICSC performs no actual conversion, which is
>> the correct behavior when the fixed matrix colorop is bypassed.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 93d922f4833b ("drm/amd/display: Implement fixed matrix colorop color space mapping")
>> Assisted-by: Copilot:claude-opus-4.6
>> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
>> index 561ee9a2e749..984bbfcf23f0 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
>> @@ -1534,7 +1534,7 @@ __set_dm_plane_colorop_fixed_matrix(struct drm_plane_state *plane_state,
>>           return -EINVAL;
>>         if (colorop_state->bypass) {
>> -        dc_plane_state->color_space = COLOR_SPACE_UNKNOWN;
>> +        dc_plane_state->color_space = COLOR_SPACE_SRGB;
>>           return 0;
>>       }
>>   
> 

