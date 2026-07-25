Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B5826B74A
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 06:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784959917; cv=fail; b=ap28oH9H+bZgCIlQUCT3HRAqz6YtTuc+wLDsYKU+D+bJY0Xrl+ZcHt34SYdhrfb9bA8eKMTqYqIg6fpG5BAqnTi1+HsK5RNRZzsuQelAzbCoyFApctiGdevq6biGRsRBKJ6tDmemfg5k5l+jflFPcnB7F+2hQfCdW6FGthf02XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784959917; c=relaxed/simple;
	bh=6BLIUNP45MFRywFIvKg4EdOD6XlLi0mbgnOZcQnOpEs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hgC6xPAQUyhFO/CN+oTTYzbAA70lmjDmyPhY798r+cQ7Jm5+PF+KWtUsk15hHEEtEZlS4g3/AedjurS5aygjEO10zLQ7gK4CldK8xZvoOe7DxQBf6T2dpJN63WOssD5ZbhEFoqA7tK7eWAM3qvZ9EdVoRm2bQGIf4mPO5LGhyiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bj/h2HCY; arc=fail smtp.client-ip=52.101.62.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bj/h2HCY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDrxoa3gf/zon9b/WIDJ4D+B1U08PkYk0xYbzzTwQhsG/f8f1hXufNDv2S2jtvhvl05tNw5iM8Zy0r7lFPLyOlleqD89jlAHj5IdQE+bxRqI18EC6ZvDYvWRzkt/liQ2X4zj3OUyJblnYOnmntOkRHKhe0p8KLZQgqaWie+GWlQbOPkEN+nISuLJLQmg7lduORc49ddWKgzk+8zHnT7cy2LYu2WeWa43yHX+IAgw/woc6AlUDwtkojRLYCe6tvaVY3dWYpmP7eaOJwGUBJMAhppyjvpHgZyt3PSwx3Qj6mWcOSRe4oTQmOvpFBl9RbGEtADnigU6Fa4eXEFkhSpXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpT26J+1CcL3/dOp/lGfQtC3YMvVuUsLCcAwzL9o+Kc=;
 b=fmh4BFlPe0k8KyyfRc0zB7/gNzmKxcWEo8veXEhh/Uny/eTfRv1Hb9K6ZFFC9wYboCKZAwZdBC0+8xZLWYwRKC/IvwR9fYPqpGKqffK+0ozSyZpoQzq1+EmS0l/2kMbWBlrs39hUIGGTrfVKpUjBtmlVAFN8lLGBSCoH80Gb3MBQQqMDt3+1ptX7buPQbb0YXssi8bLOFoNoO/QcMhF1DJwsrnVTuLuTy/o6CwvsFGzAogvT2rywhxH5JA7b44qXJ/Wq84NAnpZOv254vu82dbd0CS9bj/lbB9E09e186CpGvN60CZwulzQAHelJW34e/bgAR9d5NabeWufdbLAjEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpT26J+1CcL3/dOp/lGfQtC3YMvVuUsLCcAwzL9o+Kc=;
 b=Bj/h2HCYf3SbxHmH+5JTa2qzRIaYTnnbL+6idcAlw4zKnM3LYw+sEl0gURpncGbBbIJ5gWGS6u4ivYSMvxj5yycSx7g6tP+dzCk6G2UA53OfrdpdHc6pd/TIgyCzZ+0bfC0ggwZj6LDbL4X+ygGBqT8TB4eDpmnZKpTeLwrBd+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by IA0PPF1D04084C7.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 06:11:52 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 06:11:52 +0000
Message-ID: <7fde6e93-3d62-419b-b9e7-30696297d663@amd.com>
Date: Sat, 25 Jul 2026 00:11:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/11] drm/amd/display: Force GAMCOR for subsampled
 surfaces with PQ/Gamma22/HLG
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-12-harry.wentland@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260722134607.136293-12-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::6) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|IA0PPF1D04084C7:EE_
X-MS-Office365-Filtering-Correlation-Id: bd615a76-35fb-4908-1d32-08deea139eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+XMALWprvbkNJp4tuC+UVU6P/LTV0YNu2yJe0LFSU710AHaij0DT+rxN4O1hS2syzFe+59yNaFDSphcnb74tIUm0S5OReE9DEimaCxxov2g4xFZP8aUwPPISf50G0mfgveUDBYaOQ+xAltUGOoesrK7Uvbb/rXtsFxgpc2FhG+Jsq6NcKS3VOtn1o7mI/+WNiZTy8Vp1wjFLkFH+ne50hy5S+mz/S1Ou4/ybV1jRe+DJ2wco+MnfYyw7RgA9egUXyrS/MUddP0EjaL+tIhPBkjvG3O7xdQ17tgXNgasKC7dTx8UihFA+ar9bGMw6jy07wWhm4b7bya4vYLiBDVZOdQzIVhCXDZzSMmRmiAbX+BHUHCTWc8C/LaxwUo8mLtHAgIq/vBlUYtY55hsFUCqpKq8SOEGs8oPkoexS0zOGUrE+aKxlU2HCUQiLUxoQ5I0wLM3P4VFkgbaKfEUZJpot6EcBqGvkWN1yofcwifJlP2+r5UjK2TvNRNBHS+zLAVE+r4hfBvsE9ONzSo0yu+uDvjWx8sLHTTFOO/MShEaTnSa3SB4bR2n0dz6jiElWrlftwtNxebLR95oNWmxkTUF1h5MpkYh0jS6BF6g8ppn8Mt5VgK8VOzNEoAPg5wUdEgDSuq1dlaBuKdD17TtZHuIjSXD48vrFdJsKWWLdeDauUh4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8476.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUJKQTNXSnI4d3R5cDBjeXUyTjNzRmVRMW0rVEhZQzdCOUQ1RGtaZ2oxS0da?=
 =?utf-8?B?Q3l5TDd1VitwSmpmVGpEVUNabmIya1F6emdTbG45L1hGVURudWdkaWdCMXNr?=
 =?utf-8?B?WXpUaGRTSkxnbkhxeWJ6dnc0RTQ2ZmVjY1NMUTZqR24rRElua2tnZi81THBu?=
 =?utf-8?B?bWpxd1pka2YwUTAvQjI5aEFObjVMSGRNb3ZpU2hmaGF1cVZCc3duZHNYTDg4?=
 =?utf-8?B?eDZlUTl0bTdyZW9id3FYVnJ0UWYxL2p1ZnE5WXVNR1pDT2N6aWF2TEh3RFZh?=
 =?utf-8?B?TVE1VWF2WFhScTBFMS9EdXhYeWtQRUtMbitMMUhvOTBFaUluVlhVTTVGeEpE?=
 =?utf-8?B?K2V6U0hCOVMxYWJuVGxEV2V4WDdZVjEzV1ZHZ2llT2ZyeWdzTE9KSTRoeURr?=
 =?utf-8?B?Sk9EZ0RUbE1ZUkR0Qll1SjFpc3BIcS82MlR2d2RBVU81d3c4VmEvU0dZVVl1?=
 =?utf-8?B?K05UbFRBMnJwNlVKZDhkQlIvRmJ2a0RrUHZTNW5UUkxtVkJhc3hRemlpd2Vu?=
 =?utf-8?B?YVZ2alZEVVJLWXRYMks2a2NiUERLWVJUSU9JcWFMY1BjK01CbEUzWGI5QXF6?=
 =?utf-8?B?dU1hZitCV3N2TWhSRE9adjFhc0ZUaXd5QTN4Ym9RYTYzcTRhY0dJK2xRS0hW?=
 =?utf-8?B?bkJGazVFeVJHZ3BYcGw4ZFVmZUNXdzNUUlc1dnlwQkhVaVNEcHNsUFZjSndx?=
 =?utf-8?B?TXVrNk9xOFcxcXpSV1pSVEltSnZNYVhOMUM1eVdRb2NoQW1Vc01SK001N09B?=
 =?utf-8?B?OGRuUmhqNEZkeGczcGp3YTdKcDJpbXdyN09ZWnlLbXJLVkswZHZKMk0rSENy?=
 =?utf-8?B?cjhpR1B5NmdGTTBEVFRUUHRMR3BITnE3SlZVM3NMZ0JQSGJvaHFDSzNsWlZi?=
 =?utf-8?B?c285MFVFeSt6bjJlWnEwQ0ZOVFkzQ1owaVA4eC9lMk5VTVZlRkdpeGRvRzI3?=
 =?utf-8?B?L2RadWVOMXpKR2VuSXVMM2RFZGplWmdpRDVRL2xzV2RxUjJCNFNMSzh3alJm?=
 =?utf-8?B?Y3p1M0tJUkh4aHRRam40cjhnb005RjRmSklJdHZXSUp5Y1JTeWhJTmQ4eE1C?=
 =?utf-8?B?bEVmbGhmdldjbmFyemJja3podjk3YlUzN3hleWRBWXJtSkZ4cjcyd0xCeWdh?=
 =?utf-8?B?NmF0cHBiMVVmTzl5VzE3aUlEaDJNQWg3OTlGMW1CWFVOcjZiUkhhVGVRZFFa?=
 =?utf-8?B?SUNNdmZXQk5lMDd6Y3BoYWU4RzZ3dzFCM2N4Y0ZlV2dRdS9zQTZTYWlZK3g2?=
 =?utf-8?B?V0ZuV2krUWVWYzlCTk16dEVBSTNRZXVsVHdxVVUwM1NnU0tlVnM5TnRETXFO?=
 =?utf-8?B?aFVKRW13NThFV1Y3d3FTV1RlYmZOc3JjMjI5SlJTanEvVVd5cE1INFAvOVpR?=
 =?utf-8?B?c2RNajNDcU5GRmwxT2lvSnFSMVByODlrTWtDazVNb2JieFZ6ODZzRU5Da1BY?=
 =?utf-8?B?YjFkMmRIMUQyZXFWczhyOE91cGVacDdQakJuQU0yMUxxRG1NczRXOHl6Nmhh?=
 =?utf-8?B?V1VFRkQ0czV4TVNuQ3lybU43c3pHMzg1T20xWVlpWHV2V0ZRSmJUTUx6aUM0?=
 =?utf-8?B?U1NTUkdUQmMyazBhQ2g0ZCtRcFJOb2xIdWtBd09wMGFRaHVQam5SaGxNUzN4?=
 =?utf-8?B?OEVheExxOXJyaWZQa0txNmJwZHdoYjNiZ0g5Q1ZZajlnbUVTZ3VMYTJVNXNs?=
 =?utf-8?B?TXdpWm1KWHIraVZaaEJ2aFF5RDI0Vzk5b09OU3ptVjNKZm9vN2RBdE1YS0RH?=
 =?utf-8?B?em9jZk1LNkFER1g3V3I0ek5oVU0zTXl0U01BSGRtSklYMFQrQndWa3FsN2lM?=
 =?utf-8?B?WEE1SnFkaDBEQnArdk9RTERJTzhsSERKbjJqc3gzRWx1TWkyTE1aWG9pb1NK?=
 =?utf-8?B?b2JDaSt2MGFwbVVuWlhsNWZwaTRRV1BOMGQ2V3N1cnlxTHcrc1h6VlZUTFRI?=
 =?utf-8?B?OE5mbDQyZGV4UTIySHR5Z0VqdnlNeFZ4bzZrZzZlWkZHMis4NXN1ZXE2d1dt?=
 =?utf-8?B?RnFmTGQ5UlJKRHJKYXd3bHB0Zk5nNndzK1BKazYzMjZiMjJvQjlxS21jMGto?=
 =?utf-8?B?YTFOazM0YmVydUY2a280SVBoeHBGWHVYWTZrSUhuNnpmREtOSUVRVXNQRWg3?=
 =?utf-8?B?bkFvblkrcWxyWngwVVdmYjJoOW10d2g0b3BEdm1wYUgwOGoxWUloNGVqTk9j?=
 =?utf-8?B?TjNPYzJWS2RjM25Rc0lnRm5CVENBUHRuNHVsSVlGeHQ1YVEwcE1qdXNJZFVZ?=
 =?utf-8?B?bnFnQkMwS1N4ZU9tQ3VVbXAvV0pSdkxjMlZDVmdOOHpFRHhYODhEOWpEN0pq?=
 =?utf-8?Q?BddQ/SaW/HXD44hovv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd615a76-35fb-4908-1d32-08deea139eb5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 06:11:52.2185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdLnhf2L2UhBf3isvLrMDQCDkQSE0+haTxyZaROGwBb43iXeZTpFBvXtpkp/CTOMaWx714FreW35KbZT5lWS1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF1D04084C7

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 7/22/26 07:46, Harry Wentland wrote:
> The ROM early-return checks for PQ, Gamma 2.2, and HLG in
> mod_color_calculate_degamma_params() do not consider the map_user_ramp
> parameter. When map_user_ramp is true (indicating a subsampled surface
> that requires post-scaler degamma via GAMCOR), the function still takes
> the ROM path, programming PRE_DEGAM instead.
> 
> For subsampled formats the chroma channels must be upsampled by the
> scaler before degamma is applied. PRE_DEGAM sits before the scaler in
> the pipeline (CNVC domain), while GAMCOR sits after it (CM domain).
> Using the ROM for subsampled surfaces means degamma is applied to
> subsampled chroma before upsampling, producing incorrect results.
> 
> Fix by gating the dcn_arch ROM capability checks on !map_user_ramp,
> forcing PQ/Gamma22/HLG through the GAMCOR LUT path when the surface
> is subsampled.
> 
> Fixes: a8bf71649088 ("drm/amd/display: Internal refactoring to abstract color caps")
> Cc: stable@vger.kernel.org
> Assisted-by: Copilot:claude-opus-4.6
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> index 03d88e78165d..5786ef5787ac 100644
> --- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> +++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> @@ -1696,7 +1696,8 @@ bool mod_color_calculate_degamma_params(struct dc_color_caps *dc_caps,
>   			return true;
>   
>   		if (dc_caps != NULL &&
> -			dc_caps->dpp.dcn_arch == 1) {
> +			dc_caps->dpp.dcn_arch == 1 &&
> +			!map_user_ramp) {
>   
>   			if (input_tf->tf == TRANSFER_FUNCTION_PQ &&
>   					dc_caps->dpp.dgam_rom_caps.pq == 1)

