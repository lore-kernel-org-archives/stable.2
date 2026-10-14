Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011064.outbound.protection.outlook.com [52.101.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5565226AE
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791993127; cv=fail; b=SZWbz5SNs9l6fTz/Hivb2U2G1WW8e2y4mDFM3mdY7aekxA+2LMYoIzlkvfEPKKhQDZfhbuRXJQTKmCMnkpryXXlaaW7cRejNUnXKUKnSqVZ7F2SqlXS8NKkiU6MnEzgOU6spAyf4IHCSo8vH9odqsU7VerPiJlKpxQNJJIqTmUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791993127; c=relaxed/simple;
	bh=BC2O91FaqzX30eytKxODLJd1veiAf59tuNpQYQf9nnQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rGU98BEXTwED+3qV2PuZVY7jGmsluv8j8mW0avFX+R2a3mUYJrsCv5pUJ3xjq8i+2e+1Ye+SEPGp4cWbUhT3yftcfzBYOUbjDlc7bG3I+tvyEMxbmeuEEILywE9W+shzJ3DxB0MdzXncVmC3rptkSb8bi4SedOoLxs+CxyMe85M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q+ioGayk; arc=fail smtp.client-ip=52.101.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q+ioGayk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6S4HcqzccbiI314qvz3r3/fN8PAglcyb8FkYvu6pE//f8lGf4Ap0ks5AlU3KiuNvgQZjX9xQG1C4U0Ng3jeX6SxPgKzhw5QovxYAokdhb2v8vuyS8mGsrZAxEBzwJuozECXXXvhaO9UPFomqZCssXm/XTeDjzC1awrvYDvG8axa2VNsOePdv8qdiMl6FmAWsAuVXA/5Uml9cvFgipcjgutuXRiEZdx1+jEm2YPK3uOSAZ6T5uIr1ZmBbb2hRE+ianMEKVm+TKgiofRsM0CVYeq5N0p4jb+oEGoNAeabN5jRaqFSFNzu2TnN7tsl/QWgejnil3hL/dUfq5wn9Y79MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHCm+kCDdnjWEylUt4n26mgS6oVykkEuWlKFX2/ROqk=;
 b=sD9W9TwViW070fL87BnIYJVY4OZ5YtACrmNeigLJimPZnfESo5zjIEkAoN6YviFK8yWy4rUVA2hFba6z6+fMiMCHEONHHzgG1TZSQomto/H8TgVSNT6QFODzAIi1GUfo3/GfpK7U/UZASDgVKlAqhCAQhQS1M323xLbNY1eP3evNHLN40m1nu4ETPN04rtEPxAdu/O0irrGNqIpXti8pmO/kQ5np7gsh08h+sUAtqN1mm0HqmYrE2MaZQSRb+HZzXK9pTC5h0+PZJccS2Neh5l5Dk2KEBo/EFn+BKyxcLM9X7w1IcV9KyVlyudyJSK9M248CuSr1nL4n/DQIPRCZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHCm+kCDdnjWEylUt4n26mgS6oVykkEuWlKFX2/ROqk=;
 b=q+ioGaykYP+mWhPcm6Hwb6uZSGuKwTtKDAVH40T9u58nTMYRdi2Zr72cMng/+cQumNOefpV49WHy6J3y7hT87R7uNK+yOypymqU2auEE/Kd0VQK47CoHz/dxoo3UgYwQpp48bGMX4oE+CNJlJL5vUAJzE90IhiajIqs4okbCY70=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CH1PPF0B4A257F6.namprd12.prod.outlook.com (2603:10b6:61f:fc00::605) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 15:51:53 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 15:51:53 +0000
Message-ID: <064d84ca-26c9-479c-8380-18c133c339ab@amd.com>
Date: Wed, 14 Oct 2026 10:51:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2.y v2] drm/amd/display: keep HDMI 4:2:0-only modes and
 automatic 4:4:4
Content-Language: en-US
To: Miguel Mesa <miguel@miguelmesa.com>, stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, Jerry.Zuo@amd.com, harry.wentland@amd.com,
 mgorny@gentoo.org
References: <20261003131523.1502250-1-miguel@miguelmesa.com>
 <20261014153914.275253-1-miguel@miguelmesa.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261014153914.275253-1-miguel@miguelmesa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0139.namprd11.prod.outlook.com
 (2603:10b6:806:131::24) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CH1PPF0B4A257F6:EE_
X-MS-Office365-Filtering-Correlation-Id: dc16b355-9054-4061-cb97-08df2a0b10f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|10067099003|18002099003|22082099003|3023799007|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	X6mOYSNnzx9EMZ54z5rRyIOiOSgWwQ6Cb6A1Y9KtGTOIBNKV/y3jCuhV+iyO7jSkC0ECjv+zncZfEDivttAH/u/LhTA6/FpDBFiYyQ95dd2koFHE9MW3pAqDqyc3PPruvMOtJQ767HYReWBlRumG274CmbOcWfMugUdvJmhY+yYQM/zLtpYab2QWvDW8kK3h+vPU0rJ+0F0QwCw32g6p11FHnww2ettxNMR5BtdNQWHp0nWidImPB35pMBfYUmGiv116iWRBnmgyKPT42bFa2TB6WUn8bOI7GrU0HjKAcEFb91RHAe4n+f7ewBeTgjwDfQJCF0nTJT5RrxXgG+5L3n4/Jo6bIMqVOX/nqgmv34mZLHKAVN20cfBKMIT+n3LHu/gQiHGA7aXmapz8b7qLmfUszRSYM+BqIDpoAhskYgqsJcG9nd7ILBSg3mZpIcEyE3SnAdSm4sNZb+HEbIcJnjHhIsM7T7EozPs3heQLFVxKTkeJunuUfXFMmNtSMp6NdXGZHljGU5voCRKSSKBYRaKXlKkHhI4nr2hys6M27Hk4xDTam1+rahySLOnqJfTD+LAwcf+WhRyRwsowtGSwA+AWraarDGf+3L9Xi1elX4EXDWoKMwTFUv1PIpoS1DLj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVExbTI3M2QycHdjbDQ3KzNia2djSzhhMDFuM2VPYlhnWGJPTytkakp4bm9a?=
 =?utf-8?B?U3B0dE9MOTRWWTMzekJwZDNVcVoyMTNpTnJoSERmRFBNWXBIQk80UzhxUTJo?=
 =?utf-8?B?ZU43VTErbml1NnB2aHVHcmwwNFZKTmtIOUVuLzRUTmdFNU9qN09WSG9HQ3Jz?=
 =?utf-8?B?R3hOMHhSRkxiMG5abzllN3lEbVAvMnVnRnBEOGlOZkNxcFNjL1Bka2c5bWg0?=
 =?utf-8?B?S2RsZW5VaGtqZ3pIaTkyU1ZrbDFianV6S1BYVXZFQ0RBbGtoNzlRazZ1aTBU?=
 =?utf-8?B?UlRDNENFTWoyQzR6ZGlIWlNMRlVFeFNEZWo5Zks2M3RRUmpicTJucUU2eVdU?=
 =?utf-8?B?d2NZd2RZRGNqN3hXSmZ4YjFtSHFXVlVtYk9OSmJWc1pyRXZ2WlI2R0lKOWpp?=
 =?utf-8?B?QzFhTDFWSE9vZ0J2SGtnOXlTeTAzT3ZBczVBa3pMMHk0OXBjTExLcGFscW13?=
 =?utf-8?B?OE5vdThaMVpKYWxVWk93Y3dDazhLQjJXek9laWZYdm9PNk5mSUVYWGxSZFZs?=
 =?utf-8?B?dWhyUXBXSDdsWjVwMGh1V25PVjRFR256VVQ0SllMcFIvTm1kc3NSTWdUR1k4?=
 =?utf-8?B?QXVlUVRIb1lVdDlRUCtXVEZ4VmRvait1QzViK1VPVURITHkwWmovR1dkdDVN?=
 =?utf-8?B?M25zNzB4b2o3eWxUbTRmV3dzVndDeWx0WmhIYVVDa1JjRjl5NFhRY2JPYmFQ?=
 =?utf-8?B?eTIzTUdlbklxTlNVSzdUczBFMWFKR2FEWnhJaDI0dTJBQWlneEtLbzJWU3o2?=
 =?utf-8?B?QVdVZUtzZlFGRTE5VDBzOXBPTXQzNzRqY3pDcjhSUERabitZTlhrdVFhKyt0?=
 =?utf-8?B?SE9nL1VnakM5YStkSlVTRTJQeE9ValgzUHhsRGZ0Vk53N0Y5eWVrbUl0Umky?=
 =?utf-8?B?YUVhVDNOY05mT1JFbVg5dWZLN3VsNTZ5YjdZOXIrZGdHN21uSmNiRVkrbndp?=
 =?utf-8?B?d3g1cXBIRldGZmdMVEJBaGRLdElvQzRWTDVzbXpka3BhUzF2aWhobUk5Y0tE?=
 =?utf-8?B?bzg3aCt5SWYwbDBya2lSVm8zSjFXR3hQNWphVE8rNlpXWTloU3F3Umh5NzZP?=
 =?utf-8?B?ZUFySm5SUmk5NEFCam1YQ3kwUnI5dUtFVm40L2ZaUU5mOUp6MFFvYnBjeWtG?=
 =?utf-8?B?Z2xUTGFVRlJYazluMWVlOHlMM1gxVVhNbEJ2eXdVT1RNdXlyQnJqeUhpWC84?=
 =?utf-8?B?U2JmK1hETGVsNFJqUXJIcHdaanZ1TFQ1Szd0Vmx0YnZpcEp2cDU4d3lUcGJ1?=
 =?utf-8?B?bDA3Z2FkdDhwM1FVbWpkS08yclNDSnVOQUNEVHN5ZDEyTVFJdU1lSUhKTW1v?=
 =?utf-8?B?c0Q0L21MemFtWnFrTmdnRDYyUk1hWW5kb0dWMWNDbWE4ankwZXJaN0RvQkND?=
 =?utf-8?B?aVBUMlFPQ1g3MlJsam9TUXR0cE5wK3lBOHFGbFp6aHNvWElNYWFDcjlBQzhL?=
 =?utf-8?B?RkdMRTJTWkdhdTZhcFM0ME81Qy9ZQiszNjFFb2RwWVBhRVV0ZW9kUEZHMGk2?=
 =?utf-8?B?dUtDZTUxdU9sNU1pTGxoYkUzMXBjS3lEVXFuZXpMd1BLSERrQ0RPaXZpdUtQ?=
 =?utf-8?B?RzNvVGFSNXVEbGhWamlNNHM5ejBjbjFLemNuY0I0aXlXdHhrV3hVVGlVR1g3?=
 =?utf-8?B?S0pNNTNmNWtJWCtqL1YrZm55VmdSWFMwcXY1WTZremFtT0FDcG5jMFQrZzRa?=
 =?utf-8?B?b1M3NXZVSmlVcVVHZXM0dWRqYlpIWm9xMWdxaWZsNDBST1NjVG9SUU1veWN6?=
 =?utf-8?B?ck9aV04vdUxtK082cDd5elVFdmdObkRNL0hDWHdYZy9ndGVjUEJhaGVEVU8y?=
 =?utf-8?B?SW1sT0sxS0IzWjRPYi95Q0tVYnZjVnVzSUJXYjNyVVNnWXdva1gvTy92Mzgy?=
 =?utf-8?B?S3Vmb3R4SkVXbGNzbWg1azJXbFNFeFZhRU40MFdNSHpKd0o3dDFRa2VHWnRL?=
 =?utf-8?B?YmpSNDRmWDZRNEFWVmpmSjRZZmptNjk2Q2UxYURqeWQ0K1B1Q3k4RHJ3SkYw?=
 =?utf-8?B?cjl5VDFmbTdqQW96MVE0alZCaXZyRnBLL3pjaWxobDlkYlN4SG51Nzd4N3J2?=
 =?utf-8?B?ZnU1bGlqd2gyajZHdW5iYkdPODBGaXRBdWpPK0JhTnBZNlNmNlplR2pldXRX?=
 =?utf-8?B?SDEwaDNtQkZrVDFxbUE1ZmtnWHJOKzJzYWQ3ZjlyVWtUZHhPYnBYRlVweTNa?=
 =?utf-8?B?bjAzTm41aHA3RStFb3I3WHpNTlB0SUtJb1VKZEFGeEl1QnZDeXpRdW1aR1lQ?=
 =?utf-8?B?RWpqczl3Vk1tOW9NK1p1Z1FFL0tKUDU5YUo3aFpHWjdDRjdUV2hNMHB4ZmNR?=
 =?utf-8?B?Wm5KTFNidFdGMG1CV1hDMmxOKzlNdXdlMDk3YU1ON2JtelNyYS80UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc16b355-9054-4061-cb97-08df2a0b10f6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 15:51:52.9050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSIbHc+0fXNMGhj/87REBCTZRZ9LlTueCfwFJwEVoJkad+STENyHpyf1wewXh3U8UDjgvkfO1O3XU3yj+OTHRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0B4A257F6



On 10/14/26 10:39, Miguel Mesa wrote:
> commit 7e5760f084d0 ("drm/amd/display: add HDMI 2.1 Compliance Support")
> selects YCbCr 4:2:0 for a 4:2:0-only mode only when the IGT override asks
> for it, and YCbCr 4:4:4 only when that override is YCbCr 4:4:4. On a
> normal boot the override is unset.
> 
> A 3840x2160@60 mode that the sink lists only in the YCbCr 4:2:0 block
> then falls through to 4:4:4 or RGB, and the Wayland session cannot build
> the output layer: kwin_wayland_drm: Failed to create framebuffer (EINVAL)
> right after login. v7.3-rc5 selects 4:2:0 again for those modes when the
> color format is automatic. Do the same here, including HDMI FRL.
> 
> Keep automatic YCbCr 4:4:4 for the other HDMI modes, as 7.1 did. The TMDS
> depth fallback also runs for HDMI FRL, so a mode that does not fit at
> 4:4:4 can still drop to 4:2:0.
> 
> This is not a backport of a mainline commit. The 7.3 fix is the rewrite
> in 0b0ff65d3c ("drm/amd/display: Refactor stream validation"), which
> cannot be cherry-picked to 7.2; Jerry Zuo confirmed the pre-7.3 logic is
> gone there. This patch restores the pre-regression selection on the 7.2
> code, following the v7.3-rc5 rule. Mario Limonciello asked for it to be
> sent to stable in drm/amd#5760.
> 
> Regression: black screen after login on HDMI sinks whose modes fall
> through to RGB, e.g. Strix Halo (gfx1151) + TCL 4K TV whose 3840x2160@60
> is YCbCr 4:2:0-only (VIC 97). 7e5760f084d0 shipped in 7.2; still unfixed
> in 7.2.9.
> 
> Tested on CachyOS linux-cachyos-bore 7.2.7-3 (znver4) on that Strix Halo
> box: Plasma runs at 3840x2160@60 with the same userspace and firmware
> that stayed black on every stock 7.2.x kernel.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5760
> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5893
> Reported-by: Michał Górny <mgorny@gentoo.org>
> Reported-by: Miguel Mesa <miguel@miguelmesa.com>
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Miguel Mesa <miguel@miguelmesa.com>
> Assisted-by: LLM
> Signed-off-by: Miguel Mesa <miguel@miguelmesa.com>
> ---
> v2: Replace the Co-authored-by trailer with Assisted-by: LLM; a bot
> cannot be an author (Greg KH). No code changes.
> 
> Tool-origin note (Documentation/process/generated-content.html): the
> patch and commit message were drafted with the help of an LLM coding
> assistant (Cursor) during a bisect session on this box. The bisect
> harness, the boot tests (v7.1 good, v7.2 bad, first-bad 7e5760f084d0)
> and the final verification on CachyOS linux-cachyos-bore 7.2.7-3 at
> 3840x2160@60 were run and reviewed by the human submitter, who reviewed
> the diff and takes full responsibility for this change.

FWIW, I did evaluate backporting a clean set of cherry picks instead for 
7.2.y and couldn't come up with anything clean.  So I agree with this 
direction too.

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e594548..8f60df9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7017,9 +7017,7 @@ static void fill_stream_properties_from_drm_display_mode(
>   	/* TODO: un-hardcode */
>   	if (drm_mode_is_420_only(info, mode_in)
>   			&& (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
> -			    stream->signal == SIGNAL_TYPE_HDMI_FRL)
> -			&& aconnector
> -			&& aconnector->force_yuv_pixel_format == PIXEL_ENCODING_YCBCR420)
> +			    stream->signal == SIGNAL_TYPE_HDMI_FRL))
>   		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
>   	else if (drm_mode_is_420_also(info, mode_in)
>   			&& aconnector
> @@ -7034,8 +7032,9 @@ static void fill_stream_properties_from_drm_display_mode(
>   	else if ((connector->display_info.color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444))
>   			&& (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
>   			    stream->signal == SIGNAL_TYPE_HDMI_FRL)
> -			&& aconnector
> -			&& aconnector->force_yuv_pixel_format == PIXEL_ENCODING_YCBCR444)
> +			&& (!aconnector
> +			    || aconnector->force_yuv_pixel_format == PIXEL_ENCODING_UNDEFINED
> +			    || aconnector->force_yuv_pixel_format == PIXEL_ENCODING_YCBCR444))
>   		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR444;
>   	else
>   		timing_out->pixel_encoding = PIXEL_ENCODING_RGB;
> @@ -7104,7 +7103,8 @@ static void fill_stream_properties_from_drm_display_mode(
>   
>   	stream->out_transfer_func.type = TF_TYPE_PREDEFINED;
>   	stream->out_transfer_func.tf = TRANSFER_FUNCTION_SRGB;
> -	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A) {
> +	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
> +	    stream->signal == SIGNAL_TYPE_HDMI_FRL) {
>   		if (!adjust_colour_depth_from_display_info(timing_out, info) &&
>   		    drm_mode_is_420_also(info, mode_in) &&
>   		    timing_out->pixel_encoding != PIXEL_ENCODING_YCBCR420) {

