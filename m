Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013053.outbound.protection.outlook.com [40.93.196.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5163537CE
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789383086; cv=fail; b=mZfjLLi4OjDjG/gt2tuQXHIcuVkRnlomYNLZGLnIDbxehyogq02ZJ2r2SAuq/rhWsLXvyO4zKB7eg4dA2LtD95rYKtwgiOfFVJOU1Ne5XMIEiy1nGrdmT4bm0i8+9STqJ7+TXTIZurDhWTwb62WI9ovrwaeR/DyWs0zoeil8LmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789383086; c=relaxed/simple;
	bh=fvhNcVVgeybN/a43//K6UPUrGesTX3hk7ra1kRsion8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K7Ss5TK6gk2Eu6d9YK0N4HLt96lTUJw2dbeJ2U5ABwThs7FjH/Q1OkFPLsoAktMs1d3xo/AnWAEguST9gdT3La2hqPtHMpgCIvyM5UfwDemLPbxhyC+PfeY3+k3XieJ24vHIfLeb+tS+qnUGjuRm7i/LH0DNGMbRLSZunNTtB7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v2b6mtlr; arc=fail smtp.client-ip=40.93.196.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v2b6mtlr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ec0ulXtTFJ/w0FCM6f6Bt0HaBHW6eYjYXPe65b0tBvD6LgLFlN4GrdP92mc5G+AeYaFjdkiYUvPjzTJkckWD0zJKBDgIvWcmf9eiW4gek4SUcBEQKXtvNgIS+3Bkjw+a1+LcVpfMo4bVmb8djfw1HHka55TEgBd/sxB+1BDprv8d6w/ZIararU+h9W/mV8niBuitLW+LUb9UUMBdYH7N27WTqcqdspOdL+ocnF0eiKdI/GjVR8Y9irL7xNSmb/sJ0MH7s0p1PQ0RaXv4x4JNSYOv/q9yDl0rshgMert4suripubv6yCqxLjJ29itk+rSMR3fdVHZNYudCVsBO3CEXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+bcMVF1Z2rYLuGd+h48J18MVrpvWKMe/XXsyvgl9K0=;
 b=QcK6PAtGq+GOK/WtwcA5Y9DUiBZUW4kLoX0npLGT3EJdr7sUaB/GU1Mq1934k6A3i7jClDMvBCqcnJQD8BihjdCvnpKuC1EpZkxWVBllRQJldYxpJR3rS+0566aoH93SUX3qDbl+5PAfyojqG8M3DI0uSdOocMglYY2L9ZYeBM3KXaAEvkqOWstsMV1WGqvi8iSsS5qPBQWcwcC99knQBUpBxCJTn2wWT2DFzccgn0ME+dtS9Io1ZFVBRV8x7tYDIt7f2ntEN+wBaG0TFfzbzf6WmARvsPTQyWRFd0imAzHvcaWzYyChJGJ7ps6qNaT8amGBvg2Z584esi5RCJ5wXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+bcMVF1Z2rYLuGd+h48J18MVrpvWKMe/XXsyvgl9K0=;
 b=v2b6mtlrStMeAlxykRKUUgomL6bfEQ7aXgMDTbeauZ4GztqTE89mXgtvodj0wnh1p8bIZB1VAhbbUIUbXJkTTaOtZTcghegln3kU76WDVQD3t+W90rZsJ9SvDXcf/llLuifVqkfMhybwadJcwTyo0mv6uVnH912ENnpAXNjvNOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY1PR12MB9625.namprd12.prod.outlook.com (2603:10b6:930:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 10:51:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Mon, 14 Sep 2026
 10:51:17 +0000
Message-ID: <afb6cf0f-ca0b-4fb9-b7f7-2355ed45386c@amd.com>
Date: Mon, 14 Sep 2026 12:51:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: hold a runtime PM reference for P2P
 dma-buf attachments
To: Mike Lothian <mike@fireburn.co.uk>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, kevinyang.wang@amd.com,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <358a518d-1490-40ba-bbe3-7f3696c1d696@amd.com>
 <20260911183825.935140-1-mike@fireburn.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260911183825.935140-1-mike@fireburn.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0430.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY1PR12MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c92262-f347-4348-8ed0-08df124e1a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CmTS3Dlhdd8k6OvMUG0BT/5yoUX6E481br1EtMyRbCeF8Z3mtAYimDELcMgRjIbHSlhRbRBwUZertlMMniL/Z4TmhrReaebgSeHIYsHHmAkixLxAlpI/xr8GUmijqus53X2zoc5pYQrE9/OhtKEnJkHFBem+H880j0W4UYxQHNa6DHy7GD0t3cUf8gt6gchmL8aPRNSgJ6lkiABXw6RC1TMHK9fmH8r3bJQfxrThXFMfqDNBc2BizUDo1BxknfCx7e8bx0H4X96piQrBIErOw8yOaVI0/4HCvbDDnBTcoCrgl+YffqnqPJkW07tiIywCHRAC2avU/7slXUJoWN0xlR/7MZ5T3j4Cv4SAxKUEluqEgT84WmLT8GKZdujAwbswYvwiv1php5oUJFO5BLNlbbSO+5ZIdmwvG9t4qobZucZkFRHJMv5r5SqUNkrVTuh1tBCVYcqLEYGB6kPHpOly1zbeeV8uBlNFTc1d9P9Z9zC84a8NdPQcik6GEuLnzQnaj9TuAjm/vsGbp+3Ctc0rE6PsaiYOq/fDDVuQ95yuXMoVOQl+syja+UO+dfAPTAMRtamuARvW2H+NEd177gPKSsSfiDoYKF197F996I0lfo8ilJUApd4nqOaPawoGAkUPTZeMvfysJEJ1f7VnBHynougZVP57sf+NOY8XYOwrQbo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUJYVlFBRDNrZFc3OTVBSFpRY3RPcElPWmlITm8zM3JXUHNXUGZZQi8zQlF2?=
 =?utf-8?B?b3graEZtSXhGZXV1NG5LWnRwdkJQcXJOR2RqM0NGQUc2NEdXMEhuMElSQUFl?=
 =?utf-8?B?STBTY2w2MURJOVJZT0Zwc0hOdDMreWRjcC8xTG1ndk9HeHB2R2VLOENKNVhO?=
 =?utf-8?B?OWw4ayszRHg3cHF5NnR2VmFzaEN3SE1xM1o0UTY4c05uUGUyNXVKTkdmazN6?=
 =?utf-8?B?N3Z3aVVnNHBCVUFsWDBjbk5pTVBmQmhtSlpGaXRXTXIvRkNiUHZrd0t0aXpE?=
 =?utf-8?B?QVNnR2pJVXFrV3FTYTNYejFVUGlVUk5SZW5CUlBmQlF2RzI4RE9CQ0dGb1hi?=
 =?utf-8?B?OGtoWjBiMGZ2UFJqb1JmTE94SXZiMjYvZzdJVWhPaTkzdXJEdFRRQU8reWFX?=
 =?utf-8?B?a3h0bnFTdUh6RG9DSlZOTDJrMU0vN2JhTkdtTzJaU293UlJyL2FpK2UwRzBy?=
 =?utf-8?B?ZG9EK1B4ZmVwQlBVMUpyY1RHTTBwdjYyRlRHMmMrMTJ6M3NiL2ovMlFkY3Np?=
 =?utf-8?B?OS9uRTFhNTgxcnRScC9YYlNTNGZzdkxPYnZYODZWMi9VRUJlMDhVWGNhanAx?=
 =?utf-8?B?NDBCdXFlTmMyUWovYjIxaXMvdCt0SnBZL1FMMjR0aTVBQkNwaktEaDc2YzR0?=
 =?utf-8?B?WjVXR01SdFJSMEFlRkorQ0IwNm1JcEd4VjV3bzdlWklzT0JQOVlaOWh2ZndO?=
 =?utf-8?B?SW5NTzVEYnFLbG16NElwNUZmUjZKdmNtaW80TFVjd3BMTHIyVm11Qi8wVmJ1?=
 =?utf-8?B?c08yNW8vS0VNOXVUOGxKTy85bWxkei8rRDl0VUdJSnE3N3puaDlMWHlndjhv?=
 =?utf-8?B?TWhBQ3QvNkdObzltZ3N0dmYrYnBqa0JwTlB3aU9JKzVObnJLWkJGTlZsNm1o?=
 =?utf-8?B?ZlRxbEMyc3lyZXpMZDA5QStwZ1JXTjFnOHlPaGhtb3pYS09ERElBdytSVUVk?=
 =?utf-8?B?ZFJKT1k3OGRzTGhNYmc0ZDA1bWxiUHI5bjNSSDMzM2xzWm0wOWxFZDNpbkps?=
 =?utf-8?B?L21KaXR4bFR1RmszVHBEU1lJQWF1VjBPVjI1QzRad2xncmFVR3dyQy9VenJI?=
 =?utf-8?B?di9ZVUtSbUgzOXZTT0dkNlRieHhrc0RhOFRBTzJrM3VpU1g0OHZpelFLaEw1?=
 =?utf-8?B?bnhQQ2IyN1JOYjdEUmY3Q3FhY2ZhOVVySStWM256bVE0V3lOK2V1L3d5bGdk?=
 =?utf-8?B?RlNkVGEvS2FXUGxvZHNsNS9vL2NQV1duZ2JURzIyelpZc2hJaG1yS3pvUy81?=
 =?utf-8?B?Z0lOcmtCczF3Nklxa25aTTdJYjhORUpxL2JyRmdZWGFhOWdObm1hVWhSSXhF?=
 =?utf-8?B?Vll5RGRTT3RMOVZjQ2JJQVg2R2V0c21DZWQvTlpKYVVOQ21XM3J1WWw0MmJM?=
 =?utf-8?B?NXJEdDlndjlROHZyTDdUL3BCN2dwOXRQTy9MZFFyZkRuamVhd1R1N1pNUkFF?=
 =?utf-8?B?dkdHeEd3MDdWdmxpcmF0bDYzNVdHV0dIeGFGdnNxZXI3SG9RWkMxREJKcmlZ?=
 =?utf-8?B?dmJFdkpmU0U2aCs4SHdLZU8yTWlTR3orcWJYLzYwbWpZRXNyeHhBa0tyelI5?=
 =?utf-8?B?cGNTNEtsbmdoSHpHZG1oMjhkbi9OSHhZemt2Q0dZTVl2aEc1M2JOUWVodnBO?=
 =?utf-8?B?R0I1TDRGZEF6bFFiMW4vRDNaNTYrNEZ4allNY1kvYnBEeXR6MDlLY215eGhi?=
 =?utf-8?B?eDVpMjNrRzQ0dVpjL0RiWUJkNjBTOUhpbXRQQjg2OFhLM29VWmZSUk9kZ1FN?=
 =?utf-8?B?ZXRsK3hXTE5zNzNJaWFwTVRJcE5DZWJudkVIQ3VwUG5zeFNWeTUvUnBTcndq?=
 =?utf-8?B?VEsxWVhyNUMwdWQwVFVjSWZQUXBmd0U1MWpQNEh4VllSZ05hWW95ejlUcVhG?=
 =?utf-8?B?MFRqUUVjemplQS9JVzM2ODRhSlJRc0hEVlFicmR3TFlZQk1oZnQxZVI0bFd2?=
 =?utf-8?B?Wjk4Z1VCclJUdEdKTHRJNUYyYTJwdThSRFhoRkVqNmJGOXFidTFuZmRXMlNj?=
 =?utf-8?B?djU4U1ppamdOaW9DS0FuNlowYUFQVlQrWmZhdUlZa1pidjM2UjlIZlVkN2xE?=
 =?utf-8?B?amU0WUZKeCtGa3Z5clkxVnp6UU9MUEMrZWg2RVJlY3hUU1RxdlowemFpUzdP?=
 =?utf-8?B?SnliUUhZQ3Jjc0JyalhiKzRkWnVOcmh1WVdmZmgzMWpaeldWQ2dtdE1uTU1n?=
 =?utf-8?B?RkhDU1BnWEMyeFdYL0J0OHhGNkJUMmxyR1dqMmRldUZiM1RXM3pnT3NjMlNo?=
 =?utf-8?B?K0ZYeEtNUUNVTzhYeUdBNmNwZ0xha3FJWXNTTDJhUFQ3OHpVcXcwNTQ3V3pH?=
 =?utf-8?Q?zKWNvYNkfS1T8MND6B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c92262-f347-4348-8ed0-08df124e1a6c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 10:51:17.1943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PU7PEvocksnStBPBBiGrBVb20+5gfAulESaEKJW+GSllvOVhGGI2HUvw6Kgf0fcB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9625

On 9/11/26 20:38, Mike Lothian wrote:
> amdgpu_dma_buf_map() adds VRAM to the allowed domains for a peer2peer
> attachment.  GTT is only a fallback placement when VRAM is preferred, so
> ttm_bo_validate() migrates the buffer from GTT into VRAM.  While the
> exporting device is runtime suspended its SDMA rings are down and the
> move fails:
> 
>   amdgpu: Move buffer fallback to memcpy unavailable
> 
> An importer on a second GPU reaches this holding no runtime PM
> reference on the exporter, e.g. a compositor on the APU submitting a
> frame that references a buffer exported by an idle dGPU:
> 
>   amdgpu_cs_ioctl -> amdgpu_cs_parser_bos -> amdgpu_cs_bo_validate
>     -> ttm_bo_validate -> amdgpu_bo_move -> dma_buf_map_attachment
>       -> amdgpu_dma_buf_map -> ttm_bo_validate -> amdgpu_bo_move
> 
> Pinning a dma-buf into VRAM has the same requirement, which
> commit 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference
> when we attach a buffer" v2") called out as the one case that would
> need the reference back.
> 
> Take it in attach and drop it in detach.  pm_runtime_get_if_active()
> never resumes the device, so it cannot deadlock against the reservation
> taken during resume, which is why the old pm_runtime_get_sync() had to
> go.  If the device is not active, clear peer2peer instead: the buffer
> then stays in GTT, which remains accessible while the GPU is powered
> down.
> 
> Fixes: 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference when we attach a buffer" v2")
> Cc: stable@vger.kernel.org
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
> Assisted-by: Claude:Opus-5 [Claude Code]

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> 
> v3: take the reference in attach and drop it in detach, clearing
>     peer2peer when the device is not active, as suggested by Christian.
>     v2 only covered amdgpu_dma_buf_map() and left VRAM pinning exposed.
> v2: use pm_runtime_get_if_active() instead of testing
>     adev->mman.buffer_funcs_enabled, which was racy against a
>     concurrent suspend.  Reported by Sashiko AI review.
> 
> Reproduced on a HawkPoint APU [1002:1900] driving the display with a
> Navi 48 [Radeon AI PRO R9700] [1002:7551] on oculink for render
> offload.  Without the patch kwin_wayland hits the call chain above
> within a minute of the dGPU autosuspending and the desktop stops
> repainting until it resumes.
> 
> Tested with v3: Chromium rendering on the dGPU and composited by kwin
> 6.7.5 for five minutes, then closed.  The dGPU stayed active while the
> window was on screen and suspended six seconds after Chromium exited,
> with no fallback errors or runtime PM usage count underflows.  After
> an hour of yuzu render offload the dGPU also suspended once yuzu
> exited.
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 39 ++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index b33c300e26e2..fae695c3e531 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -43,6 +43,7 @@
>  #include <linux/dma-buf.h>
>  #include <linux/dma-fence-array.h>
>  #include <linux/pci-p2pdma.h>
> +#include <linux/pm_runtime.h>
>  
>  static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
>  
> @@ -100,15 +101,50 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
>  	    pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
>  		attach->peer2peer = false;
>  
> +	/*
> +	 * P2P access needs the exporter awake for the lifetime of the
> +	 * attachment.  pm_runtime_get_if_active() never resumes the device,
> +	 * so it cannot deadlock against the reservation taken during resume.
> +	 * A negative return means runtime PM is disabled and the device
> +	 * cannot suspend, in which case the put in detach is a no-op.
> +	 */
> +	if (attach->peer2peer &&
> +	    !pm_runtime_get_if_active(adev_to_drm(adev)->dev))
> +		attach->peer2peer = false;
> +
>  	r = dma_resv_lock(bo->tbo.base.resv, NULL);
>  	if (r)
> -		return r;
> +		goto err_pm_put;
>  
>  	amdgpu_vm_bo_update_shared(bo);
>  
>  	dma_resv_unlock(bo->tbo.base.resv);
>  
>  	return 0;
> +
> +err_pm_put:
> +	if (attach->peer2peer)
> +		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +	return r;
> +}
> +
> +/**
> + * amdgpu_dma_buf_detach - &dma_buf_ops.detach implementation
> + *
> + * @dmabuf: DMA-buf where we remove the attachment from
> + * @attach: the attachment to remove
> + *
> + * Drop the runtime PM reference taken in amdgpu_dma_buf_attach().
> + */
> +static void amdgpu_dma_buf_detach(struct dma_buf *dmabuf,
> +				  struct dma_buf_attachment *attach)
> +{
> +	struct drm_gem_object *obj = dmabuf->priv;
> +	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +
> +	if (attach->peer2peer)
> +		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  }
>  
>  /**
> @@ -350,6 +386,7 @@ static void amdgpu_dma_buf_vunmap(struct dma_buf *dma_buf, struct iosys_map *map
>  
>  const struct dma_buf_ops amdgpu_dmabuf_ops = {
>  	.attach = amdgpu_dma_buf_attach,
> +	.detach = amdgpu_dma_buf_detach,
>  	.pin = amdgpu_dma_buf_pin,
>  	.unpin = amdgpu_dma_buf_unpin,
>  	.map_dma_buf = amdgpu_dma_buf_map,

