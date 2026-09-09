Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6E553ECF1
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958006; cv=fail; b=V8b9siqiyzqXzJFOUvub2VRZASN3F+eE6W/UyuZ5LguNxZUt+gDiAwfIRDqJw7+lQ99jX2ozGfzFawUs1iq40Qk+7fF+RJywZy1TsaPnQwVZnB3ZIfzQYqtbJWIWyzh7jpLghd2vyynBqspIHtIu8e7rXmSZ+5EjGjx8ekZn6B8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958006; c=relaxed/simple;
	bh=kVoK3A9sWI2yllRyHihjbpNKZLL3D7IYrx7NAf0dN4g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hRN5AGWQdfc4p8ZdNf4QAkoXRuFXnwXtnDOW8c5gjpbAJy9Lfgo/pPBFNvoioNdt7iazO1Y4rAjqCKtY1L/KNH1C3dUyejg+OwKZ2reFCLjVVIG5qjeVRlKig9N2vion1HqORY59h5wPIyfwNLnvvQGqNcBkOZbrlPWPzH3j/pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L+dcn1uS; arc=fail smtp.client-ip=40.107.209.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L+dcn1uS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V22dYnH/tIfXn19WNLbWwmETVQuhP1yoFQK+Wd2IsIXkoTYeMRfa1ilVEA9UASXCQj8HzWG12eD0QC+wc+Ci+WSp1pp3oNHDXjiQvPZJXOHrC96xvbiTegnBYT5S2rPpSCKg6xYgsPBhZm+J1LiYU4/GC+Y8jKipNQOP1I+rCvteQsImvbpmdFQYF2umPbgeuCRFzWqYvQsoRnWd+QtUlBclBfJxQ+eGfcQOeIP0qrmfCKO7bHCPEX6dTEirjWG4Xvg8oOpmSIaPfzgXwg7vMP5pwMCJata5w3JXLW8qAouW1Jrbv4zELbuyVMXHDQbH+W+KMOQ5wf4tt/SCzLYY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oGIQMo+WLd9zVt7lebo274xJIUgWrS6sG44LNEij6E=;
 b=Ffk/cM7uESAgxXmtpFlyr8U64uN5y45WdwPykRi0HU44ZGmU380MoD3LF5WbRsfemHy5o6p1NHB5sdGzXmcufEU0RKr3+LIra2+/YLQAWaaeDDhFHGjbfFex3eO79sgxOmhF+0gCwFASggj/BHOiw500RNvmvQ+Qhrvqt6ER1o9soSAtgZXYYfED5aOSI1ZYMZZlMCxdODGV13CsHNmiNS4+mageqo4GeSzQ1l1y7pfGr3szpiZlEtyubmDA5bS2o67K7B6ZjT5aM4FIUvsiNa4jb49892F3Ausit9JRVV9IDoKvcWvDAH5P5iNWwS7DF16CRDx7FC0/IunzVUgJBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oGIQMo+WLd9zVt7lebo274xJIUgWrS6sG44LNEij6E=;
 b=L+dcn1uS5Duivu/zAhdK1kxCQx/sdrb8WnKdyKBdU1mhmBxZO8dk72Lf7lwwFtruQ5516nnTh4w0cVlO3MNT3G8r7p1p1qQIzPCJEnZPZLtH34N0r4o56MjsYp1GzQpjmp8rkhIIKbW2v1TssaADOlX4FB4sriQ93M3gsjKC3UE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 12:46:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 12:46:35 +0000
Message-ID: <e63d8ae9-f102-424f-88a5-0fd6837d79d4@amd.com>
Date: Wed, 9 Sep 2026 14:46:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: don't migrate a dma-buf into VRAM while
 runtime suspended
To: Mike Lothian <mike@fireburn.co.uk>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, kevinyang.wang@amd.com,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20260909020854.58462-1-mike@fireburn.co.uk>
 <20260909094609.1541-1-mike@fireburn.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260909094609.1541-1-mike@fireburn.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a77297-0deb-446e-b913-08df0e706217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8dx7JiS0nh5XbzNZL3VjzCOsE8DMYagnUJLBTNzRRSd3v2mNko7I8+i02K2CdBBK1U9ltXXJJtxxNz65qic35vQhKRf0y3Uld2WzlLLZJEgzCnYCE2KJwNrWWSvostixxwkzKVSu6+//JFPCEbqel3TQhBzqguyN6LtQPr+yFbzzA3DJmDHWy8dO3dbV7fJY7cdcT+CmwERWxM7R7U6d9OZlMXcXS9MZhRMtHuPt3IS1pvTy/yR4qu4Nvjue0ECUfkSUY4SaJ8lEvSJL4cn1s+O0x7nt1OMusnO1WwYbRZTB6ZyQ26J6/Z+w3f4Sv+6mUJf7TmlCFVVEKqzt2iJbqtjkjtYlRuk5Xlv0kfV+OacLRVn3SUiyEF7SE4g5qo3RuomDhCIda/kgFgyceh2bKGzOA/sR+BHxBiEZh6131Z7FiUfGD4l+HYLNwL/t+3cRa1MMNvqlft/LX3eMGw13dV2hypkKN3OVol9alnhGYgzujd9HFSkRbA/vG9TUIwXMYgXvY0gWe2NHK0L6/IazTwQ+DwX+kzg85ObkylrvnIPgn7n8oe3fXabc/Mhsvxnp3Cg6yGCKjSD6ikFtWB5oY39c1Z8NuaLnz1Qc1+FHqDydWSv2VVnLYazyNu3a3jiLUQ0+VhvgpzvyzawTMgnvLmHzBlWwmOWPOeSEnraknzE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW95UFd2SkhkQ24vRTJXOXRlSkx6R0luL2NCeWJ2alFXMi9oMW1xT3RHMDZC?=
 =?utf-8?B?Ly9HOUE2Nm90bU0xZXRDOWNzc2pNL2ZiVGpBS2prekV4OHlmZnExeVBWd2Ra?=
 =?utf-8?B?ZVR4OUhYYUtWeW84LzVRQ3M4OXRxNmdaWVg0eFdzM0hIWmlxWEJVL1prcWVS?=
 =?utf-8?B?S3crTnVJS1NobmI3WXZoZ3FDdkNMY21pQTRnMnZEMEdsWC8zMUFLaDNtTFZM?=
 =?utf-8?B?SEpYZVd0OTJ4bEpocWtsZnIvZkxnTHZTNU02M21JUitQbWVaWHVhVUxMOHNG?=
 =?utf-8?B?VE9FekVCQlRrUVVyUnlyK09JNTUxYzk1U3RsTFhwSGlmandRNWpaU3lWeVF0?=
 =?utf-8?B?QmhDdGV4QXZFUmpOaERWVjROa0EwMU5LdUdtOTFaRnozb0hEMGtnK3NQc01H?=
 =?utf-8?B?TVpMMzh3RWNadFNiTnEvZE5PUXI4WGh1Z1h0b0c1aEcwcHZZNm9DKytaM2lD?=
 =?utf-8?B?TWlLdzhhclBUMTZGQ2lwa0RvNlJJUlFtd3FtcGZaK09CVXhMOFhnVW5zSDEz?=
 =?utf-8?B?TzMxZUt3TmhRbTF5cUIwRnRDYklsZWNXNU5lMDBwSWN5dFpSRjFyUkdDVCs0?=
 =?utf-8?B?emVEMVdNVWJvY0JzbmUzNlhYU2dyNCtDdnBzNXdqQm5malo4WmFLYmJ0Rmln?=
 =?utf-8?B?NURrdUtnT1d6ekhvWXNNcDMvK2w3YjZqSDJmMll5RnJvM2FVemc0OWhldkVx?=
 =?utf-8?B?MnVDWEdCTmRBemtWWFczTnp5dk9TWVpJSkRSWEVzR3kyM1c5ZHlMY2M5c28x?=
 =?utf-8?B?T3AwTmpJWlByOHFMMnA2dG1TaDlJQXdldlQwNndORUtISjZDSUxMZzVOcTRU?=
 =?utf-8?B?b1M5YXhpWlZPWnExOFQydEx0a0orRDM4cVZ5L0FrQlpiaTNkeGVmNHgvRDdu?=
 =?utf-8?B?NVlTbTN3YzhaZVY0NXQ3OGt1ZHAwVGxucHovUWpOL2ZNRjBpZ1ZSdUc3bDBa?=
 =?utf-8?B?TndRaFFoU3ZEMzFINWowbExwOGp4YkQ2OFpDdHZueU9TMmF5aFczSFRxTGJl?=
 =?utf-8?B?VTR1VE1lTjltV3JWajhUaGZLNXJWbzRmLzZUMVVtYjdpTFN0ZzZIV0RnWThr?=
 =?utf-8?B?Q0xibWhIUlVlelNFaGxpby9zemk3SU50QXZqbDZQMDduZ3JDZ0tIUGJZNldn?=
 =?utf-8?B?MHFGckZmekVZWlBDVDA1L01rNXRHUkJSeVVqR2NKVUordXprdzhBclY0bSty?=
 =?utf-8?B?eitmN3BsRjFCeXMxYTNhK3FHY3RMVjVrTFJTSS90eGxDaXBFRGdITUloeS9m?=
 =?utf-8?B?Z3MySm1xeTREYXFMcVpHeVlUdEhiY2QzczI2eFA1THpFZDhvZ2MxZ0dhbFll?=
 =?utf-8?B?aE1hRmhtelllUVo3UkNWNXprVUJEN1Qyay8wRlBaeEJOVXZGMU5NSDk0V0Fp?=
 =?utf-8?B?ZmJYbldGRXB3emZSRDZ3N2ZMTVZHWjVpVmlHRUduSFp2TGgvUXYxSnpOZjdN?=
 =?utf-8?B?dDRuMkU1SE8xVDI4M2ZocFVoclR2cjJDZlN5UDBpSFp1RzBSVUY0OVIxUzI2?=
 =?utf-8?B?NnB6Nzg1MHJuNHlhRy9MaUMrYkdhdzc1c2laaGs2c1ZieVdPd3BXRm5SQXJi?=
 =?utf-8?B?b09XeSt3RXdwTXNPWXVwNDR3dlV6cDliaHZvSzBDRzQrNVhLWkV4SWNsc1do?=
 =?utf-8?B?TTZiS2tUbi9KZXR5U2Q1ZzdvWk5JVVp5V2dPb0tSeVc3TzB6Ni9uN2lLK1lu?=
 =?utf-8?B?K3c5dXdiL282cGJpRmFMVVJJZ2huMGt0MjV1Qm9pR05EK1AzbFMvaCsySENW?=
 =?utf-8?B?aVN0UzFha2ZieUw0SnU2NGpUNzB1dmVVMVhVYnV5M0lMeVFEVW1GWEpLdDdI?=
 =?utf-8?B?RnZyUEFhc0xXNTliQk9adjhqblRpWXRWUHpndTVhMXh2RWFmKzYySmI1OHc3?=
 =?utf-8?B?N0JpMjdFQ0RRMm0wL0M1Ym5xQ0JoTDB5M3ZROEI3aityTUJqR2ZHblQ5SkpS?=
 =?utf-8?B?S2VRd1JoR25mZHBYNTRIYzd1SXdMK2JDUUZPM21nMHFUNUJ5R3BiaWJ5OVdp?=
 =?utf-8?B?ZGMwTjh3MWtCc25wbVJiek5ZYThTdE9zVnU3cGtNTTYwRTVmQXQ0dDZQUkly?=
 =?utf-8?B?RGNDQXVHTEZBMVZYblhZU2hNb0w4OEJLek5xUm1MS1JxZU5EdXlubEpBTENj?=
 =?utf-8?B?LytvOS96eEQ1R1FkT0JvVUx6czV2Tm1OdW5GendFTlc1czNvcmhMenF4R3cx?=
 =?utf-8?B?NjBDTVlTV0I5SUpLbzhZbWJzZWVlcDlwcHNMSnNhUzl6U0JFZkZscmlBdEU0?=
 =?utf-8?B?YkpiRTlTNDlTc01hcTI0cDUvcXl5a0NDLzRjSWZ6MTF1RmVtZStycmFLNFRG?=
 =?utf-8?Q?QUrGlz8pu+i5yQRiKy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a77297-0deb-446e-b913-08df0e706217
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 12:46:35.6534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S25PH1aPPAh6RWIACR9KotoEXzsEn2OlPWdRZJk5m7ugqjtWKHpoIBunHCS7wnR5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6486

On 9/9/26 11:46, Mike Lothian wrote:
> amdgpu_dma_buf_map() adds VRAM to the allowed domains for a peer2peer
> attachment, so ttm_bo_validate() can migrate the buffer from GTT into
> VRAM.  While the exporting device is runtime suspended its SDMA rings
> are down and the move fails:
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
> Only migrate into VRAM while holding the exporter awake.
> pm_runtime_get_if_active() takes a reference only when the device is
> already active and never resumes it, so it cannot deadlock against the
> reservation held across these callbacks.  That deadlock is why
> commit 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference
> when we attach a buffer" v2") removed the pm_runtime_get_sync() from
> the attach callback.
> 
> If the device is suspended or suspending the buffer stays in GTT, which
> remains accessible while the GPU is powered down.  A negative return
> means runtime PM is disabled, so the device cannot suspend and VRAM
> stays usable.

That is a good catch, but your bug explanation as well as the solution still look a bit questionable to me.
> Fixes: 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference when we attach a buffer" v2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
> Assisted-by: Claude:Opus-5 [Claude Code]
> ---
> 
> v2: hold the exporter with pm_runtime_get_if_active() across the
>     validate instead of testing adev->mman.buffer_funcs_enabled.  The
>     v1 check was racy - the device could suspend between the test and
>     ttm_bo_validate(), so amdgpu_bo_move() could still see the rings
>     torn down.  Reported by Sashiko AI review.
> 
> Is this the failure that commit c52feb436539 ("drm/amdgpu: Disable
> runtime PM for externally attached dGPUs") was working around?  That
> commit explains how to detect external attachment but not what breaks,
> so I can't tell which.
> 
> If it is the same thing, could the pci_is_thunderbolt_attached() ||
> dev_is_removable() check there be narrowed or dropped on top of this,
> so eGPU users keep runtime PM?
> 
> I can't test that here: this box hits the bug by missing that check.
> The dGPU is on an oculink port off a native AMD root port, so
> pci_is_thunderbolt_attached() is false, dev_is_removable() is empty,
> and runtime PM stays enabled.
> 
> Reproduced on a HawkPoint APU [1002:1900] driving the display with a
> Navi 48 [Radeon AI PRO R9700] [1002:7551] on oculink for render
> offload.  Without the patch kwin_wayland hits the call chain above
> within a minute of the dGPU autosuspending and the desktop stops
> repainting until it resumes.

That sounds like there is also a bug in kwin as well.

The GPU can only go into suspend when the rendering application closes it driver connection and that usually only happens when it terminates.

So question is here why is kwin still having that imported DMA-buf as necessary resource for the rendering?

But we still need to fix this properly in the kernel anyway to avoid having a deny of service.

> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index b33c300e26e2..c89846f266d3 100644
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
> @@ -189,14 +190,25 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>  		/* move buffer into GTT or VRAM */
>  		struct ttm_operation_ctx ctx = { false, false };
>  		unsigned int domains = AMDGPU_GEM_DOMAIN_GTT;
> +		int pm_ref = 0;
>  
>  		if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM &&
>  		    attach->peer2peer) {
> -			bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> -			domains |= AMDGPU_GEM_DOMAIN_VRAM;
> +			/*
> +			 * Only migrate into VRAM while the exporter is held
> +			 * awake.  A negative return means runtime PM is
> +			 * disabled, so it cannot suspend either.
> +			 */

Setting AMDGPU_GEM_DOMAIN_VRAM doesn't automatically migrate the BO, it just sets this as possible placement.

BO migration is only triggered if the BO is swapped out or similar. What most likely happens instead is that we suspend while something is still ongoing.

But anyway the problem goes deeper than just the amdgpu_dma_buf_map() callback.

We have picked up pinning DMA-buf to VRAM for RDMA without ODP (e.g. exactly the feature I mention in the commit message of c52feb436539), but failed to correctly fix the PM handling.

So we really need to call pm_runtime_get_if_active() in amdgpu_dma_buf_attach() and fail to let some other driver attach if the device is already suspended.

Regards,
Christian.

> +			pm_ref = pm_runtime_get_if_active(adev_to_drm(adev)->dev);
> +			if (pm_ref) {
> +				bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> +				domains |= AMDGPU_GEM_DOMAIN_VRAM;
> +			}
>  		}
>  		amdgpu_bo_placement_from_domain(bo, domains);
>  		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +		if (pm_ref > 0)
> +			pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  		if (r)
>  			return ERR_PTR(r);
>  	}

