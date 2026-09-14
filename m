Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010011.outbound.protection.outlook.com [40.93.198.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33747F78B;
	Mon, 14 Sep 2026 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396880; cv=fail; b=M9xk16e5ojatZxiWHaBKj59tVET5pFxMI/9vufNU8Tc4M7D5u/F84wmmtWerg6umhF+E4z51AknTvW7o0JmcHPccNVLjARt/7ON0PzQ1tXEpOWWw0KwAxi+rA1Cjcnjn4h/mcN5ccUTIUZb0OtQEvrRYw0ulVDQH9gOc7g+9jdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396880; c=relaxed/simple;
	bh=ly6QgjFFFxm4O7iOnzvpqye8bjBTVEe89C2bmUIpBgw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FiOgl+yFsENu3FXO1c+aJod9ULoD3sVkInSsu+jxEwZbwUvc6Mj+sXmO6ZBUbI024AslH/SPe1y2zBRPK9oBKifUB0hWRVeHneRMjjt97cvsdhHJviWibphgvmKmdQDwzLaSh2+4FpJnBTD1A6FNM4FOSFJnBnIM+NCjGgxJYMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4L5fTVfx; arc=fail smtp.client-ip=40.93.198.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4L5fTVfx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjZRgX5lmjbj5Rv6bePPPRk/9T6p4ErOUdCN52zMCe3ZmR9Wm5q96mFJe09XCkNY/OjogTTYBSPolNcnz5iF17gJWWW5E1zflvzZQcsGx1M3lb4N+NQydIfkpIQ183TRUj8HRu+p4uHzBOyTiXWFbfnmFpjWqTZ4U3i+VM+zgjtQwnNVKrRNrYSKfRBAq9oHFcdRUI3Gv5i3Yxd+/b7r+omqwx5aazn86R2H8xwmMnSVpsCoxUCViu4Ta1/9/BtzCRZ0/OEsbYFwro+q5VDnd5obptFaoDVQPerUIpdAwzJceY2urKNWoXSFW/0CoVidoE8VagOtOmleOI3BGyeMJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8n2GXVF1lMDJ9IO7+q0ShqrflCbdd6fVOEgbUIvvjQ=;
 b=Pe/MGvIP8nQ3fVQwW4COlZisY6me9fUwWyf1Bwn1sUUB5apvAnGDKBZDC4AtjBUJBcUJu/pdGd2z/b/SeqCZWT9CKRNvx7TwbjbRwoPQ7pMfIJZN7SmRErD83cFcPjEPC/wl+3G8zovGVlg1JNOwwHoyosgEgwKgRnlDdCaHKA/kcSjhrqDCpVL/YY+4usTVaKaOHi6BlTw8tzimVUpUaN9wZjnG9XWMItMtZyPLP5KMWT4AUFK7yUP5q8A3cy5RtLo0xUs1VS5S4p0VvSyuC5wyWAXUtokPhEv8CUH+CGIG6n7Q6abkhoZ6UMSg4eGGmZXyshm8m+CMNKROETpTOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8n2GXVF1lMDJ9IO7+q0ShqrflCbdd6fVOEgbUIvvjQ=;
 b=4L5fTVfxK5xuSBNGPQg8POSqCMWi0it/vGadTyaBO01H8jnfQIoqIXerRKsUDQlgEYHZU5xAonV8idjsaTbrAuya3HDRXUSWDjkl/A4hLoe0ZSthrkCS+RRhp6nQ4UU8P94zEjP+VmehFnO+eFsyoO/JUwRCwjDaxpyFhW2XtsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SJ2PR12MB8035.namprd12.prod.outlook.com (2603:10b6:a03:4d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 14:40:59 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:40:59 +0000
Message-ID: <96aea084-ed8c-49dc-8a79-e05f8412c904@amd.com>
Date: Mon, 14 Sep 2026 09:40:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd/pmc: Fix RTC reference leak in
 amd_pmc_verify_czn_rtc()
Content-Language: en-US
To: Ma Ke <make_ruc2021@163.com>, Shyam-sundar.S-k@amd.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, stable@vger.kernel.org
References: <20260914122002.1701233-1-make_ruc2021@163.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260914122002.1701233-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:510:2da::13) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SJ2PR12MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5ef3d3-d7fc-4a1e-cdc3-08df126e3149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UABaCTjU1UzjvJtAppZ6mMJrS8gW7wKYFx5bfYvWWLnXW3B0tKHdScRQVbp0LNKU2ekrpKaoZ4FLsQCF+GMBfIjcjzgqHH4aMEDYz75E56ChcoZfalFuhQKmxC9Gc4ZaEDORSy06PtrNC0upduydNspNBBhYsDY47Zi42XdpW5uJH3LFKhYz6c8MDibUJs8FIiVz6qiKzLfdcLuY7yrO1aqj/yHIo8lG4pB2wAnWEZdlct+vWoFoGTYELYYDfzU2rbWEfscXuyJ5MbR33CVKvUOcsjQkWbw+edh9c85e0nf5zGVC4Tj/YLYok9eo0W/pGzNrMoR+XvQoMOWYbzU0L8h+zQFckYoG2pTs77oYDVjIRA1QXm+yT/lYuj9/H2532JftIOOtUG3Xvoi+ON2loB1blx8Cymo9dbFi9K+7D/WcqnDPR5AFkHLoa3xAJoBNCZ7T42QYOrBjDBpYVlxaTNMjhmp2Z7xMo/RaF5tQTmUBaVLLg/q1nyQON7e89S7TBahpncuFRnDtsCPfIllz0MJHYX7jmJzk7BEOQNnc8qV1LRFqF5BEfAMYisaCSuCIN/9mooZpq65hqGJ5N/2XbR2Hts5XugG1gJTtkjHOrbWkj6brbwm+WD7wZGT4sHcRV3G6pve1HugFQwjK/MdcgWTdqZtfXPyvIh3T2LT/X2g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHgyV21MY20vOFM2VUtpV0w4M0U0K1AzTXowUk81OWxqazRrZWt3dWFuMkNT?=
 =?utf-8?B?SGkyZWRlRm9mNXJJU3J6QmVtdWNBR2Y0a0VnM2R3ekM2cWtSU0pOb1R4MFRq?=
 =?utf-8?B?WjB6UnZ5d0RDeXZIM2lLSHcraUREakVpeXZrRkJ5enhNTFpESnE5WEFTemtD?=
 =?utf-8?B?WVMzaHBSaU9RT2JoUUNyYmRMM1RBRVFEV01iSU95bERpdWFXeHRpMVNRRkVy?=
 =?utf-8?B?UUpITTk0aUYxaHVrc0phOVdDenM5WmJURjBmVlR1Uk81TUU5QW1wY3lOaytq?=
 =?utf-8?B?K1ZYd1dLRjdhTWJ1dzQwNVJ5bmZ5amRpWU5lRlhYMGw0Rk9jVGoreFdydkdz?=
 =?utf-8?B?ZzJ5WS9XRDJodnplenVURzRpZkV2Y01YQXRydlczTmtwcW1BckZ3QkNvL2VY?=
 =?utf-8?B?cXdYS3hrbVNoaUxyN3lwb0R0SGxqWWRaUkFJdnJ3akpsc3ZTYzVtQzMvRnNr?=
 =?utf-8?B?dGxBUzdlbktWZmx6WlhPS3NWZWp6aEtkeFB3eENrOWtMaVZLU09ud3VrQThJ?=
 =?utf-8?B?ZmhPbVJpYWg3ZjdZZFYzcmlLZ25uQ1RGd3Z4cTQySnZoOTdlNmUxekhNQ3hU?=
 =?utf-8?B?czRhbHBwL3JaSVI5eWEwcU0xdDh6LzVpazJVdWN2c0RCUC81WUZnRnMwTm55?=
 =?utf-8?B?OVVCKzA0dkxYaUY1WEtpUWxFanBXQUd5RFM4TzFJaDZjZGJsemZsUHdVdkla?=
 =?utf-8?B?QXI5aSszTllxYk4wMG9NOUlQTnBsQkw4bGZpclJkMGgwM3Q0K2NsUE0wS2V2?=
 =?utf-8?B?U21BanFWZXM5b1pNV2NTSENpaDdpc1c2K0QvMzJublBQUmJ2TlZSbE9HM05E?=
 =?utf-8?B?Qld4aTl5ZFhodGZiK1dtWnNSTmZDdXI2c2pNb3RGYzBBY2UybE5zbjJQdUJC?=
 =?utf-8?B?RkJkUUJLRngwOTUzZTY1RUxDWDcwZW5XMkh2dGlyY2UvejFEaTdST0NxOUxY?=
 =?utf-8?B?Umo2UHI4T1JoWnlCUEl6MUYrRVRZNkNOMSs5cVpKWDg1OU9HZFhNNmpPc0hJ?=
 =?utf-8?B?RTQrWkNMQVRlK2VhQnhxMVpFYnpwcm9ETEJjL1dzaWQxTWc0UUxiaUF4RTRs?=
 =?utf-8?B?dklydWRTRVo5U1lFdHp3OXUyLzh1aWRoYXNmWE1VL1dlY3dwQWRnSG10UkJq?=
 =?utf-8?B?RzdwYTkwTFBWUHNva0w4REYxMGZ1OFArcmVYcUlvRnhFRVpUMVppd0FTNHg4?=
 =?utf-8?B?U2xHWm92eW40RFNpR2gzdE0yR1BxekE5WndVR2VEZUhLSXFTQ01od3hmZlV6?=
 =?utf-8?B?ZUFQMk1kVGhDSVF6bHRJeWxDQ3hKc1dJVjNyNVl4Wi9JZFJNRnFDSHlmNEhI?=
 =?utf-8?B?V0FrTjVNbFNhNmNNd21CVWNEdW1PUlhLOHBaNm1DZWxqK2ZkcHJPU3A0Rk9h?=
 =?utf-8?B?Wk5lQ0ZWdmM0ajlWMmVVdytadzBySGl0ZyswNUkyclZUbEhwdmZnQXZiK0Vs?=
 =?utf-8?B?RG0yd2htOEx3cGNIMGRiaGhUTTZyZzdnc2pVbmhaa0J4Y01VRFU3dXdEdjFT?=
 =?utf-8?B?eWRQTWFYa3VjSTR6RzR5NzBmcXloWWhDN2pZaCs4WHdYZktnRThDVU5IQW9t?=
 =?utf-8?B?RHZEa3BHNnJMb3d3bGZnZ0ZYZWVSaUNPUjdRcTd5MFNvVjZvNTdNTmVmalpS?=
 =?utf-8?B?YnpBbGJBdWRwNkNWaVdzMFUvdGVDRWxaZ2lqVTBKSHNFUjhEOGlTa2JxRm43?=
 =?utf-8?B?OEhBT1NkaUxBdVhUZU9DNDVtck5sN2FxQkkxdXBvcS9hTStqWWtuSmdpeDdD?=
 =?utf-8?B?ekRCZ1k3eWNyK2Z5TlViK2ZxMU9seGIyMzVSVkxNNVNHRTJ5dHpHYXNvMU0r?=
 =?utf-8?B?QThETW1Zdm5pODFabWlxMFM2VlF5aU1PbFJEd0E1YXNUVFJYd0VkSThDZUZI?=
 =?utf-8?B?QzJDenpML3BPUHh3S0F2UThnY1J5aU11SHpGRWJ4b0NWNHRpNitvelgzczZ4?=
 =?utf-8?B?VDM3TWdzb0xFckZSYXExWEd3c29VcDRjRlJIQmxscWFZUUlvWE5zYlZTL1NU?=
 =?utf-8?B?b2ZqV0dBM1J3LzRmTFJqaUZ4ZE9LYXQxNXFEaEVmaVp5WTVHajhCVGFGWE1E?=
 =?utf-8?B?Q3pJc09SRTM5SlgycEdzSE9qV1ZPTDVYWEhmVE5Xdzl1QnFxSkVMbmYxT1Zt?=
 =?utf-8?B?YkkyamdJWVFSVjVaVyttc3dlNG13Sy9ONWxQR1ZudEkvSDRycTloZSttTGt0?=
 =?utf-8?B?M1pXRHpQS3BUQnQ4S2svUGdOQWIzcy9pZjJlaWxhSXJyTThRd28wQ3l5UmRV?=
 =?utf-8?B?cWU1dEo1dHpJRzdua3pleVFPYks4MFlZUktsK3FLcnlBNU9jSmpBd0tpU01R?=
 =?utf-8?Q?Kp0xuh3AqVaTHJMHnJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5ef3d3-d7fc-4a1e-cdc3-08df126e3149
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 14:40:59.3998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RKis5wPaLil+jLzwBBr1A+J98KVOp8/Q0CbxS+cDQpHRsDSkbcApUDLrDlbzeVXBZ0w2WVnO1Mt8r6+JtlPlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8035



On 9/14/26 07:20, Ma Ke wrote:
> amd_pmc_verify_czn_rtc() opens the RTC with rtc_class_open(), which
> takes both a device reference and a module reference on the RTC
> driver. rtc_class_close() is the matching release, but it is not
> called.
> 
> Use a single exit path and close the RTC there, in the same way
> ntp.c:sync_hw_clock() does with its out_close: label.
> 
> Found by code review.
> 
> Fixes: 59348401ebed ("platform/x86: amd-pmc: Add special handling for timer based S0i3 wakeup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ma Ke <make_ruc2021@163.com>

Rather than adding all the gotos, can this be done with a __free() 
cleanup call on the declaration?

> ---
>   drivers/platform/x86/amd/pmc/pmc.c | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
> index 6792aa2c6187..543bd95e4766 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.c
> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> @@ -671,33 +671,41 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
>   	if (rc) {
>   		if (rc == -ENOENT)
>   			dev_dbg(pdev->dev, "no alarm pending\n");
> -		return rc == -ENOENT ? 0 : rc;
> +		rc = rc == -ENOENT ? 0 : rc;
> +		goto out_close;
>   	}
>   	if (!alarm.enabled) {
>   		dev_dbg(pdev->dev, "alarm not enabled\n");
> -		return 0;
> +		rc = 0;
> +		goto out_close;
>   	}
>   	rc = rtc_read_time(rtc_device, &tm);
>   	if (rc)
> -		return rc;
> +		goto out_close;
>   	then = rtc_tm_to_time64(&alarm.time);
>   	now = rtc_tm_to_time64(&tm);
>   	duration = then-now;
>   
>   	/* in the past */
> -	if (then < now)
> -		return 0;
> +	if (then < now) {
> +		rc = 0;
> +		goto out_close;
> +	}
>   
>   	/* will be stored in upper 16 bits of s0i3 hint argument,
>   	 * so timer wakeup from s0i3 is limited to ~18 hours or less
>   	 */
> -	if (duration <= 4 || duration > U16_MAX)
> -		return -EINVAL;
> +	if (duration <= 4 || duration > U16_MAX) {
> +		rc = -EINVAL;
> +		goto out_close;
> +	}
>   
>   	*arg |= (duration << 16);
>   	rc = rtc_alarm_irq_enable(rtc_device, 0);
>   	pm_pr_dbg("wakeup timer programmed for %lld seconds\n", duration);
>   
> +out_close:
> +	rtc_class_close(rtc_device);
>   	return rc;
>   }
>   

