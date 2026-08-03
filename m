Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012027.outbound.protection.outlook.com [40.107.200.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D06E2848AA;
	Mon,  3 Aug 2026 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759999; cv=fail; b=ebanQ5UhWHktlJTihHa1ue8FB7Gu6Skj8GoJ4K3OcFg8yMoBay3kCCDtmLIpR8T8uT93kiesIqkogaEe2lKNdZh9XbDNZtOlAPgyNZw0Yv1KrKxEsVLBXPetfyRvoiRmKq9enpj0JB+prCAfnvMvQZUK43lQceCY3vCtW+bGTTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759999; c=relaxed/simple;
	bh=qT+pLYQwS3sTznqBSMnttYdcnZylMddinc0tHeSGpuY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XiOIwal4ZvqgQoZWLg+MjwNR4ZPub4VEHpwRJ5QFB5iHouJhC1HCj5y0kxeLCbARq1Hc2ssESeg1KAfEek2R0MQHYk4VwjDQ6FY9daAPno1G2joe+N9qIN5mUyGA+ryCAWJvc7gAK9yel+V/nOddx2VZ/jGgt0rhoEVfrzbqEyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tTTIpK/L; arc=fail smtp.client-ip=40.107.200.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tTTIpK/L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyrGYagXHbXMqIGeOkqvHCgJibKg4aYhmF5AWxI2eWTlN+7MaGAfWoRsgtckyaz9COdL2+1V538ZTtQHsSneAZVnZDlpxv/7t2PuxB7tv4EFX+IHmHT9EBEHgYSvpXBBn06kFAKVMYUre8bhUGEZoLIcvkaE7PpDr4fb0GfKBmo4iflIJYpGiqvQhAzOl1wiNpa/U6hFXd12R5C5GHbaR8ocklaj+wiLAg1LL/0mn1IOKcoTxLVbOvyB6UxS/+NK1kZVUdXlZbxuRNDrIYNUhD6duzCwYKEjh8lJ70Pt/kElB+J7pDtr5EdzFxCmm6aiM4y3fWTvhtM1O87baOjc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfU5Nx3Kh2ifQVKWvnfxkACHpShKMvPF86hb0aZ4kmw=;
 b=e6Cgga8s3md7eVmeHul5kmwOKMD6d6UmyigQkJ4h5B9/mFPqT6K095uKu4SeI7natf9xY+5KHC4WEZSyMRpvPUxdolK6BSn+rFJEUqvNla4gfZHUb/0ruvv32SPYuQMnYxvRQtvrkjCI509uFXVlJNHezyDNmMj1DacVzx1CBLIzgzpAN8kyw4czyQXKfrcBZvb+BEi+R+bTMuF1zKEcf90LMMwaOvipbg5URxeZuXAG0nSVWPC8VjhjaIPVPpl/OOFK63pqYuIaz5xqXNKQvOULWTwSUSoUr5qOBTb/4bp/1YQ2BvlYGsi2Ach8qsky898bhefaLPz9RdF6RDNIpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfU5Nx3Kh2ifQVKWvnfxkACHpShKMvPF86hb0aZ4kmw=;
 b=tTTIpK/LDeOXbXVlKMOGPJo/ZgwjpzDf0emX1kDbsTGVeMezpR2EfhEGl+4dMTOV0cTetAtWLrW1j+KgNIrHg8VyEua49OYMB1WU4vGjCF3NbY5rfLZ7prMfGjHLMX/DztK5BnVDBRQWQtm2M6RIe5xFRiS6R/BQGT78fkqd35E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 12:26:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 12:26:34 +0000
Message-ID: <5beb0994-556c-4715-aa1c-c8a31b5929b5@amd.com>
Date: Mon, 3 Aug 2026 14:26:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/drm_crtc: ensure dma_fence_ops remain valid
 during device unbind
To: phasta@kernel.org, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, Sean Paul <seanpaul@chromium.org>,
 Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>,
 kernel-team@android.com, Simona Vetter <simona.vetter@ffwll.ch>,
 stable@vger.kernel.org
References: <20260721-linux-drm_crtc_fix2-v3-0-afa8c71506e6@linaro.org>
 <20260721-linux-drm_crtc_fix2-v3-1-afa8c71506e6@linaro.org>
 <d2d9aca41c4f0b9b6e5ae4e9b8e5de3c2d8f95c6.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <d2d9aca41c4f0b9b6e5ae4e9b8e5de3c2d8f95c6.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::17) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2a0922-e155-4fb4-6dcb-08def15a749c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|4143699003|56012099006|11063799006|10067099003|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	sOfBtrTJPBrF6arjPt/n4xQDs8pJevWUd5eJk0oYhmGU+z7+YEKvAcLgEbA5WCGDSVElJ4Eq3cYwsaazxRZjyH6+E5foZmB3WiF0dtD07kBMn2udyoMiKrSNEkVOqYT1AxKpVR+skQLDRFQdHvRNZFuXhb7Rj3gA3gyi2wHMFFf7rpnsFSJEB1hP0AoPbteCEMdG2JTfjL/93HvWCSY/ogXABV/MXvfefRgv8HQqGAorU8LFNCWMtrM7KrHXDV1wTF/6ISl+m4mGdh0QfrXSTtsrSJMv4KTo1UFvNI6B2i2yMyqI7NtbGmkTdTk9utwmA06+nvP8TXNf4S/EpMfXBzwUy25hEI7hSlKZpBQUoMO6ui+M2Ax5LEo63+jr0kVL3zAJD85veoZzOY0JnIexyIctFWrQ9JIvKEEhKhIezX8BqCS7z7kqjTYggTS2I9DNdMUFhiiYqXldoEnjXUuBonkgaSG+mCIFPFZU6sOIykpR81Gq/VnMGAf0NnCwP++q5LUYywyq0bsGD5HjEeC2wDjbXnaPy07rpP54BylPAaIud/AAZ45B4kKyNb+vH6J/BoCT5oruMRoy7gVDPqimfTMiFl0wjP4p3v2eYgenY+dVgJo5z5328WAXxuJUSGSqvkdC1Q1Uh7qTJc1hjBiUsQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(4143699003)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXYweU9Sa09TVVliTWhid1pHYUNZTjBHMFJNVEV5QkRRdEVqeVMwdzNLdmtY?=
 =?utf-8?B?RlRYMUdlRW5FcGZjLzFEZXZkcXBCd3k2Wm1WOU14WVFveXVuRnNPR3NuYTND?=
 =?utf-8?B?Z25wK0NWTmtEM05GdnlHOXg1U1FVN2lYMVVzYXc4U3NPdEpBRmR5WVIrYzdI?=
 =?utf-8?B?T2lqQ2F2MzF4WWFEeHA3SnlqVVdKUnp4QSt2SnNzL3pBcDRHMktRZlhBUHZi?=
 =?utf-8?B?QmFCZ3lIaTJRM3piVDdDYUZXTVN5dzcrMkx4L0xpQWtOSVBEeG0zY3VxZnFi?=
 =?utf-8?B?Q0dacDBqVVVaUmpVdlI5Rlg3UFErc0pScDdLSVgyRS9YMXA4ODdqU0h1RzlO?=
 =?utf-8?B?YVJPSTBlU2U2QjJtY1pVUUFsUnhzQnZtSkR1QlRXeGl4bkY2c1RKVmJwajFX?=
 =?utf-8?B?dGhDMTRJdW9abGxybDdiWlBCOUd2VUZtMHBXRFFkbzFqaHQwcGNiTldTWHpE?=
 =?utf-8?B?azZqVTdLNzU4Y0R3OGM4YTZ3OTk0YjFsQzVGTDdCY095MVAwZ3JaT0lmWFVj?=
 =?utf-8?B?S1Y4bWRmWE91UDhBTHdkbVhpU21NSmZjdU1nQ0JtQk02c3FTOFQzQnF3K21Y?=
 =?utf-8?B?VndtcERuWUJHQ2EydEZUZDZkc0FFWXFTTFBsamtlRXhtMVN4MStQNjM5TG4z?=
 =?utf-8?B?amNaQjY0N2ptSDUwVnRLNWtpTnZScGpUdEVWNXBMRFVvaCtqNDd4Z0tPL3Bh?=
 =?utf-8?B?Ym1tL1VsT2hTVU9PRitqWHZURE44K2tVRnJzcnQzUjhwV3FSYzhjVTJBSE5t?=
 =?utf-8?B?dFpiZFdtUTB0c3E3Zm5zSXVQZTJpdFlWdUQyTXpPL2IzZjR1K1V2SE9DdFdK?=
 =?utf-8?B?RGVVNU4xMTdzcDVvVUhCS1dTU0RFc2lKUUR1RUxMUDc5L1g2MkVUZ3pZQk9I?=
 =?utf-8?B?OHp4RFpweWYyODZqMmtsNDQvNnRhYVZpQ0hDWGlYaWF4SzNvdUxTQm9aSXNQ?=
 =?utf-8?B?YU15UEh5OG9LNHkrajFWYlN4UGhsSDFKWDMvSVFYaDRkRDBSVUJLSmxuY09K?=
 =?utf-8?B?N002RUl3c2VFQU5qQ2lZWUNrRE9VaFEzRDgyNXJIWVRSUldFR2dpUGg2QzMw?=
 =?utf-8?B?L0E0ZUgwaFc3S2xzNHk3VEptUWhQMG4yOWRET1VtWmoxaDRVeEhuRFQ0bUUv?=
 =?utf-8?B?WmE2STJFSldhWDJESzZnSkZnMjBGNjJrVTQzQU54S0dOT3QrTlpmQUR6c2VG?=
 =?utf-8?B?UHE2c0tQZmtRdXNzVlFMWjFTQ0RmVzlacmw5THpER1g2YWF2Q05SRTBtcExJ?=
 =?utf-8?B?K0RFSUg0ckoxZ2pYNE1sOFUwVmNRcEJ4VTl4V0tFNzhLeU80dGpzdVJQQy9x?=
 =?utf-8?B?Z29JTG8wUVVJeW53Q0V0aTRhaExaY0t5c3ZOa1ZCbXQ3VGF2TTVjamZlVG9Q?=
 =?utf-8?B?eEhBNVRuZGRyRTdGQ3hqWGFLVmVvZkFibzNoYWN1TlVjcThuZjQ3VTBLQkY5?=
 =?utf-8?B?bDVENlpyNjhrZm0xZEVieVJ1UTMxRzNDZU5IQ0dDUm1RYURaZlE4MWZvaEtp?=
 =?utf-8?B?YWdFSFpuNU1GV25rQWUxYWxPQ0piWmFESGJQajdWcitiS2kxL2tBTFFKYlVn?=
 =?utf-8?B?ZFdqUnIxSFVybHRRQXRIbDRiMzBVVUdqbVdQVEJHUGZsdUVHNmd0WlZtU0lu?=
 =?utf-8?B?Y0hxMDRkMW5DeGJnbTd3RzhWUDJkV0hHenZFVWJZNEh2UTNJbzFxK0FhQzAw?=
 =?utf-8?B?aUdnZGZUdTJoZ3Q5ZmhENTV5d0VNMnY2N1dFSjB4NzNDRGRoYXpGbDRBQ0Nw?=
 =?utf-8?B?WUVRSUVKSjc1NGg5b1hVZUJiR200YlhEYUxaZHJEa2QwdUhvUWZZaGMyeVBk?=
 =?utf-8?B?dDd0VVNxMW1tQ3k2dXRnTGtqVzRBOGFkbW9vQktsRXdTNzdaWExKb1hUVDUv?=
 =?utf-8?B?eG5WR0VlWk1KRFhvNklLNldpTEVJY2hsdjMra1dZUk12dS8yc3IwYXJpUW9D?=
 =?utf-8?B?bDlvalN3eG40T0pYZjVJSUU4UnBjR3pPVEdLN09qVWd4NDZRMWNBS3ZYYzNy?=
 =?utf-8?B?K21XZ3ptekxKbzR5UDl6ZjRYbHk1bk5vV1YwMFpaRnJsZjJUR281TEtTbjVW?=
 =?utf-8?B?bnp3akZ1d0Qwbk9VMzdEekl4MUtrazZxNlQyRHVPcE52aE1XblNVSGlUa1J2?=
 =?utf-8?B?L09tWTZnd29NMGZEVWU1eG1pVU9kanc3UHQ2MktJNzhDUU9QRXJSMFlCblJ3?=
 =?utf-8?B?V1A0dnJMOTFidWpkcDZyQUFkalYwZTF1YUxLQWxldEFkS0ZaMmE3bThOd1ZU?=
 =?utf-8?B?WWRaaXhOSFVwOFBHRW1sM09YOGZMeWUyb3oxY25GS1gzbzl5Y3RZVEY5Zjhj?=
 =?utf-8?Q?1kEV7gEQK/Kde4bYQ+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2a0922-e155-4fb4-6dcb-08def15a749c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 12:26:34.7295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CmZqGL67c4rEa1ngRN62QIWZVkN9WyvEECIMN/RLl1iGTB/10wM5GuS2hzwwV+F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446

On 7/21/26 13:20, Philipp Stanner wrote:
> On Tue, 2026-07-21 at 09:21 +0100, André Draszik wrote:
>> In [1], sashiko reported the following issue:
>>
>> === snip ===
>> Looking at how these fences are managed, drm_crtc_create_fence()
>> creates a dma_fence without taking a reference to the drm_device or
>> drm_crtc. Because the sync_file framework exposes this fence to
>> userspace, the fence can outlive the CRTC.
>>
>> The dma_fence contract requires that data accessed by dma_fence_ops
>> (like get_driver_name) must remain valid for an RCU grace period after
>> the fence is signaled. However, drm_crtc_cleanup() and the subsequent
>> freeing of the device do not wait for an RCU grace period via
>> synchronize_rcu().
>>
>> If userspace calls ioctl(SYNC_IOC_FILE_INFO) concurrently with a device
>> hot-unplug:
>>
>> CPU1 (Userspace)
>> sync_file_get_name()
>>   ops = rcu_dereference(fence->ops);
>>   if (!dma_fence_test_signaled_flag())
>>     // Preempted or delayed here
> 
> nit: no one will be preempted here since the RCU read lock must be
> held. The Sashiko tool misses the point, which is simply that someone
> illegally frees up stuff that might be still in use, with or without
> delay or preemption, that's all irrelevant for the issue.
> 
> Anyways, thanks for fixing this:

Seconded.

> 
>>
>>
> 
> […]
> 
>> Link: https://sashiko.dev/#/patchset/20260618-linux-drm_crtc_fix2-v1-1-c03e77b36f34@linaro.org?part=1
>> Fixes: 6d6003c4b613 ("drm/fence: add fence timeline to drm_crtc")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> 
> Reviewed-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Christian König <christian.koenig@amd.com> for both patches.

> 
>>
>> ---
>> v3:
>> - Philipp: update kerneldoc, add Fixes:
>>
>> v2: new patch
>> ---
>>  drivers/gpu/drm/drm_crtc.c | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
>> index 63ead8ba6756..e8e80c936852 100644
>> --- a/drivers/gpu/drm/drm_crtc.c
>> +++ b/drivers/gpu/drm/drm_crtc.c
>> @@ -493,14 +493,23 @@ EXPORT_SYMBOL(__drmm_crtc_alloc_with_planes);
>>   * drm_crtc_cleanup - Clean up the core crtc usage
>>   * @crtc: CRTC to cleanup
>>   *
>> - * This function cleans up @crtc and removes it from the DRM mode setting
>> - * core. Note that the function does *not* free the crtc structure itself,
>> - * this is the responsibility of the caller.
>> + * This function cleans up @crtc and removes it from the DRM mode setting core,
>> + * after first waiting an RCU grace period to ensure @crtc->dev can safely be
>> + * dereferenced by our dma_fence_ops.
>> + *
>> + * Note that the function does *not* free the crtc structure itself, this is the
>> + * responsibility of the caller.
>>   */
>>  void drm_crtc_cleanup(struct drm_crtc *crtc)
>>  {
>>  	struct drm_device *dev = crtc->dev;
>>  
>> +	/* Ensure our dma_fence_ops remain valid for an RCU grace period after
>> +	 * the fence is signaled. This is necessary because our dma_fence_ops
>> +	 * dereference crtc->dev.
>> +	 */
>> +	synchronize_rcu();
>> +
>>  	/* Note that the crtc_list is considered to be static; should we
>>  	 * remove the drm_crtc at runtime we would have to decrement all
>>  	 * the indices on the drm_crtc after us in the crtc_list.

