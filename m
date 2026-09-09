Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD60C23A9BD
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973231; cv=fail; b=lhSp4GiZyqD88XIyAPjAvY/S6gXxr6RFffw6IDSBOcvW4qd9IG5sEIzIsNkV5GoKy68xIf/KoFzH91Xg4t+PDji2wCwilwYYkAzn7Yrgo9+y3QSrfh1WjMIBSYYoMXXIN9KvjPlMhJzM2/5yZLvRglysPGL6SqMzd0dnrAs6faw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973231; c=relaxed/simple;
	bh=kFKvIyM/s7ja+o6CkP/BzR7aBiEX9Lj1vS0B0GMY6gE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gWx8ShVnisrUVa2ngvGqrubqev3Ogra3CxLq3+E/5zZmgIPhGoav2qCP+gracw1itFjYPcRuH0u9BBdCWofbGkkTstPqVJWpJ1mJfy3lZ5GypnKKLpkKU3h5dnICVDmsxwlgUJrjF12ilm38J082XK5AVcWpRa6q/mvB+se2mFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JWN0X95n; arc=fail smtp.client-ip=52.101.46.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JWN0X95n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SaS83gpabi87YQMC3qIaTzDXNj4I54yxkfXSHwMtD8K8iAmRPZeQNoaXBmXAzLvuubHOB1TF6QCWoh1X2w56mp9sYf3NGgqzV2zxWtMrbqGcGOxA01EU0EctuVWn/9G/AfsbP+tAELXuc3eHn150unbup8YAq8cEaPAQERwBO/Ju0e8a+WcLpIJepCcvUxCVFaLZwL2T+Q34rrFqJ/fr4kBSKhAKd/K4uEk8akIvz0M5fUzJU7+9gJMN3Zl/q7Gf4X7jU8+g5PCrgV/VQE1TUTcqYoBPB812crNwwFPVqw23owohy+lqkIBaODEHTubDE76oiWTdC24at3tJSECbLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8knhCNiUIyuBWCq3LEnXi+Papl5+cxPg4jf6mY194qc=;
 b=bdKJ+JJJngtcSaRcf5oGtMiULyonI4l3diTZcpuG/ha1/LIlTAknvRRoYElB0N2jxeMEV/r3KyY0SKYZzGA44DIvGbT8x3aIGCmoHe3yXiqebOy/sGDe1wnezxQFieeRq59bVz+eOnNrlUkaNETgsT6Nhiy/9Kgvdw5Bf/jSQbQ6Qm2N1TN5TaXOx2yWk2ecYvcvN8f4fryyb12/CVa2oci95W8CmvH0XJm3sDEy/pelp1kWfM+XCzEvMf38J7SwCETNsm587gtYB8qV4yumczfY99exPaxN5Ykt+oVoB3fzM2iOIi9/bRtIa0VCbITOYBTQ11LWXI8GQ4JuKz9qig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8knhCNiUIyuBWCq3LEnXi+Papl5+cxPg4jf6mY194qc=;
 b=JWN0X95nOsMFPlLrLORJ5InSGfEdsS3AoJhtwSIZpWUhiG2TWNzJsudrE4dQRLVPrkf9CxXqBGLXCf7dQUuePSzJtibo8td34mBi7Ev6WFyLNpbaJa3n2jLVqhe7M1oWQJWzEX/zWrDeUm5miLCmxm6Zh4t2zWsysaKeG2ZuZmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 17:00:24 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 17:00:24 +0000
Message-ID: <b2f45802-99cb-42ae-9da8-93b36c6dcc9c@amd.com>
Date: Wed, 9 Sep 2026 12:00:21 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: FAILED: patch "[PATCH] drm/amd/display: Set gpuvm min page size
 to 4K on dcn35/36" failed to apply to 6.18-stable tree
Content-Language: en-US
To: gregkh@linuxfoundation.org, Roman.Li@amd.com, alex.hung@amd.com,
 alexander.deucher@amd.com, daniel.wheeler@amd.com
Cc: stable@vger.kernel.org
References: <2026090953-attire-untidy-c602@gregkh>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2026090953-attire-untidy-c602@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7P220CA0111.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:25d::15) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e63e266-ed13-4ac3-635a-08df0e93d6b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|11063799006|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	7NUstmcLFkXzo/zH4RrFTrkEf6+fWlGDGR7CMnq3zob3U3A7PTH/+epqmx131yMBpTDAPfiHoYdIFRLJ7g4BnCnFiY5rPBKZYqJVTg99+DPPiQk03NYbpIjSWhm2tEmjsuRCOMzmUdhVYTuoB8+Ls6xsFWiL+heWLooQX4TAuzq8qWlc3AVD6v47aVPyqWBUCGXlvHCQACRD+2eZkO+ZTO1gdbFc+QVqo8IhWz3/7+CBdSNVyve/HRdhc4P1GyHUPZWCkblJOX3fl7WeGvFoioNsi0rwvO+iyPNXhiPsouJsVzelB6W3PndY9FX/nHk89IVJ8NoGGd9ev0dYNywINEYLEilMn/NF/dTzP5BIvzQJc4b6e5K24Y90t8fwi10HeecassiWNHvCID/pUincZZ2McgI6fAQRv4ohC5hSchM4znAkWqgfTWAAdgtIE7vnmyPj9J61JEV3nP6PYq7pnpta6s/G+6eqqfck7kRd1hlb6Y5v2GIyiwhh0bzw9Kf/Tv0n7O3P+nAaSigWaxE6WFS8ISKQtkUyF189dNydDx5XBH47ELGwWzyG9x2FVTDpcM4Y9kNspGH2M2+su+z7qL9UIuLkwKZeqYeAOzsnzJ88ejB+UXnev4+UYCphk9vWPeTxwQsXR9U8dZLOXhxv1g7anbNVnAEa3r/IMOJWI7U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0xUbUpUZDZMM2RKUVhPdUZOUFFKamFrRHZldGlNNGNqUEZQc29GczJxckxN?=
 =?utf-8?B?R1dxL1dwVXJya2VnMC96Tzc4YTJlVzB5R0dqYmc5cmY0ejUzSVZCN25jRjBE?=
 =?utf-8?B?V3N2dFc3bjhXWWNxVXJTSHQxN2JIcUtHWGs4ajNhaWQ4VmtFUzlBR2kzYnp3?=
 =?utf-8?B?cmsvRE82bnl5R0cvbG13dGFLc3dhcmg5VmpycGFNN0pmZHA2ZzZtOGtlS1pq?=
 =?utf-8?B?RjJwTzlNNHNZOHprc1U2Rjc2WFdXbUowSUZJdkFzMXU3STlLVVBoM1RNdjlB?=
 =?utf-8?B?RkpId0dJUWxOcm16ODRWVmhBVlp5RkZwZmFNZlFlTSt2SlBkV0pUMVVNclNB?=
 =?utf-8?B?aVZpbjRBRE8ybVRWK2pGRVpmWlBBZHV6cXpGKzh6WVNYRmxWbWVLQ01OZWxL?=
 =?utf-8?B?dC9SSC95N3Bqdi8ycHRNeE1CSmh4ZDlnZmVyb1QzUmt6eEhMK2p0VHFPNXcv?=
 =?utf-8?B?TU1pYXlrV0E5ZFNjaTBsM2ZCWTgwdTlQNkNJRndJSFRoajBIbVRQZEdVRXlv?=
 =?utf-8?B?Y1Mrc3NiMHV3cW9rQ043ZjlzWStGdERYMDJpSktnNk1PSjc3TnN1NTlocmdH?=
 =?utf-8?B?bW9FK3cwU2FKd0ppVVpiR2hrL1ZadEtzMWFsWGljNFE0M1VRUFk3dzNMMHp6?=
 =?utf-8?B?aDdnV2dvdnNtaUlDa0M5RDZSd1pyNjRRS1IzYmMybXhlT3JIVTI2dDd1QURY?=
 =?utf-8?B?dzNrVWoxRGdOdVg3cktmU0JnQjMxT0dBL2VTNmd3bEdid01ISHZRQzhNUHRl?=
 =?utf-8?B?NjNYdWVvdnc0Tkp3TUNhS1R1Z3ArTVpLV0dlZ3l1OXBqdzlHZnFxRlJvMGQv?=
 =?utf-8?B?bS9WczN3Tmo1dHJKRmNoQTVMTFVjWWFuM0gzU1NwL0Rac1ZKTWFkUzRoOUFV?=
 =?utf-8?B?OUo5NkRubkRxU3JWTVNWVFZVVFBYUjUyazc4ekNBVE9mUmR3ay9KTFpISjFa?=
 =?utf-8?B?WUxqZ1JMT29HTytFRFd3Q29UdlNvclNmOHJtblFUVnpWVFlQcDdYZDV2T1c0?=
 =?utf-8?B?WUR6ampzUURpcUtJWFlxMEpxR2MvQnh3dUdrdmNHMmxBVk5hbS9WVXQ3QjF4?=
 =?utf-8?B?b2QxWk4yOW81VUhPY1NlQ1JOVU5CSURMenpkQ05YdFlNVURsTWVVb2pxQ0Vj?=
 =?utf-8?B?VXE2Y1hxKy9jYTVuQXBhU3NYbWQ4MmlJRnF1cEhheGhtWHVoZjZpVHlSNk5Q?=
 =?utf-8?B?WHhxVUgvS3lEOVVEaGt3VXg2aHZPejJHV0dwSGVkN2RoOG50UkdCVVczVFYw?=
 =?utf-8?B?a1hKekxueTdvWDRlejdBNmRJSGYzTk1xZjNWMG5HU29uemRTem80ZlZKT2xI?=
 =?utf-8?B?djdZeDRkb2RoU0xuLytCdHB1aXpZeUFjWE1GV3dMeDJNVDlnbEVMQ2pLdmRu?=
 =?utf-8?B?Z20xZ2lBVHg5TS8vSDcrRERoMFVnNWZveUlaSW91cVdqV3VKTU1PMFNyY3Av?=
 =?utf-8?B?N3BEOEMwVlhiTGhMdWlUMWZseVNmaEE3M281NWIyc3d4dEdSMEhVVzZDQ1Rj?=
 =?utf-8?B?bzN2NW1udmI0QXR2SGJJcUd5MlNjQkU3REJYSFJVNjVaYnVUOGVaYUpiZ0Vt?=
 =?utf-8?B?OTF1ZFpPaTFYSXlhSGNMbDFvdjNydytpQSt0U3JneHErN20yamphMlhENzds?=
 =?utf-8?B?aGhJTWZKcHI3YnVzMm9aVXB2MDJrY2JJMjlkVndxUnZxTmxaZ1hWaGYybmJZ?=
 =?utf-8?B?U1ljMjFITVpCSDZjVlRTc1NMek1OckR6K0FjemYxTm5jTUU2SE9na3ozT3Fv?=
 =?utf-8?B?M1h4VjdtK2hrMld3YmdVNGNLWVpTT2RBemRvaWFBNEVFMUFqV3h5OVY2MWVq?=
 =?utf-8?B?aFNjYXVuc0dpRVF2OGhLQW92ZVNBVlRjSUVPTE51dzdxYkF6VHpMWFlEMkFS?=
 =?utf-8?B?YWVLOHZ4djN5ZkxwY3Nra3MxMEQ2VExWSkRpMyszNFVPRHFaSGFjY2I4aExV?=
 =?utf-8?B?MkR2ay9LajR2YXhQMGpWbkh4cXZ4dW0xc3BqY3BUbmNhY2cyQlU2OXNNL0lZ?=
 =?utf-8?B?ajR2aG41dk81endYSldZdVgvYkxrWjdHTHRuOUU2N1NnL2RMeUpNTk9haHV4?=
 =?utf-8?B?K0JxY2o4VGtReE1XMlI5eEJuZjJhOFBvTVFGNjBndEpyeXQ1TFVKRXdMM3Jt?=
 =?utf-8?B?SFRqQmhHS0Y1VFZpeGttdnRyWEZQN3NST2c2c2gwemkvMlBLejVqRkR6c09E?=
 =?utf-8?B?VXFMZVRGcC84MVZZUThWaVo0Y2ZRUEJzQ0xoU3ZEc0RqUTNJMUpsbFhvTnBl?=
 =?utf-8?B?d0xCMjFOYUw4dVFkMWJOeXdOdFlqelpEQTY5S2RKeE9WaklOaVVvSm5XM21B?=
 =?utf-8?Q?GV3Q2c8VGMeFOMgcEj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e63e266-ed13-4ac3-635a-08df0e93d6b4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 17:00:23.9703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZysM/UruSCrxFTVn6nfPw/0xQbdlNQkjjR7xeulMRgnstlME5zyJVMST8T6EaN23fd9Jd9awA0hQsYQpr2LZXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282



On 9/9/26 06:52, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
> git checkout FETCH_HEAD
> git cherry-pick -x 9ce3169430f1db035d491481086e2fae2552569c
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090953-attire-untidy-c602@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'
> 
> Possible dependencies:
> 
> 

I'm not sure why this fails to cherry pick here.  I just tried on my 
side and it works:

╰─❯ git reset --hard
HEAD is now at 1c732c6b94f0f Linux 6.18.49
╰─❯ git cherry-pick -x 9ce3169430f1db035d491481086e2fae2552569c
Auto-merging drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
[linux-6.18.y 40ba5915f3a5f] drm/amd/display: Set gpuvm min page size to 
4K on dcn35/36
  Author: Roman Li <Roman.Li@amd.com>
  Date: Fri Aug 14 18:03:17 2026 -0400
  1 file changed, 1 insertion(+)
╰─❯ git log --oneline -3
40ba5915f3a5f (HEAD -> linux-6.18.y) drm/amd/display: Set gpuvm min page 
size to 4K on dcn35/36
1c732c6b94f0f (tag: v6.18.49, gregkh/linux-6.18.y) Linux 6.18.49
5f08c45bdcfd2 usb: usbfs: fix use-after-free of usb_device in 
usbdev_release()

And then I tried to compile amdgpu.ko and it compiled just fine.

> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
>  From 9ce3169430f1db035d491481086e2fae2552569c Mon Sep 17 00:00:00 2001
> From: Roman Li <Roman.Li@amd.com>
> Date: Fri, 14 Aug 2026 18:03:17 -0400
> Subject: [PATCH] drm/amd/display: Set gpuvm min page size to 4K on dcn35/36
> 
> [WHY]
> Splash screen corruption on some 8K monitors.
> 
> [HOW]
> Set GPUVM min page size to 4K for DCN35/36 to use the correct DML2
> calculations, avoiding the corruption path observed during splash.
> 
> Fixes: 115009d11ccf ("drm/amd/display: Add DCN35 DML2 support")
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Roman Li <Roman.Li@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit 2cbfb03dead5088a7bdfe2ce392a5caa3d1b3719)
> Cc: stable@vger.kernel.org
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
> index 166f10b8862f..c82886323a51 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
> @@ -301,6 +301,7 @@ void dml2_init_socbb_params(struct dml2_context *dml2, const struct dc *in_dc, s
>   		out->smn_latency_us = 2;
>   		out->dispclk_dppclk_vco_speed_mhz = 3600;
>   		out->pct_ideal_dram_bw_after_urgent_pixel_only = 65.0;
> +		out->gpuvm_min_page_size_kbytes = 4;
>   		break;
>   
>   

