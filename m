Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C34547887F;
	Fri, 25 Sep 2026 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790334484; cv=fail; b=Wdj9k+E+0YWw6scs7lMin391y8DHac7ezENZQiF9QR0U71y6qXsDOXQRKSYsJCoU+2mZFV1TRce6/MZlSKQpcNCz2WQX1sMaDY/jGaPefzho0tP0wK1zLorRbqjtfJ9+bAgy3BsS5C3EEg4XARgt0EhFkRyGC44d7BjeZ6ZJsJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790334484; c=relaxed/simple;
	bh=a4ImTzBPRev2j1koqJ23ZmFVR7jRCXpeWS07vbMBBuQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=msaD2gWc3pmYKz3of9rvZZtdVFmG2HfpsybmVub12rsi6JM8rXWFDMY7C+35b2wGiV+VMbNSO1As0R207yvG0n/hBzqejTU/oTMv92TO1Bfofhhi3cVXJv8aeIisjPqvdU6FfacPpX43/rReBmeQrkkbefaWVReKuU0szsAFuwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=erH1c85h; arc=fail smtp.client-ip=52.101.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="erH1c85h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykJuLkoB6pvNy647C/e4BJ+fb+RUYtbg4ZGLTu/Ll7fOE44+Q6nDqTcqiINev2uqL0+5jKhy7FztsQGQRTU4egrtN4q8U/aNq7L+88thBdfHu7G+6yOcrpa95E2NemGuBizvG14tm05BFoeCdJZyVQexjG9t6dJojnPdkOgVXOKG7bymzMAZG3K/soTO2qTkamrQYRsIFEgMQxr218lwNXgxWzh+T8WqcX1d+38ok9+fhDTiqu5lVRLXccwKDyu6gV/WR/NrSdMJm9VDZtnekwDvLisf0QD2ZXtbGTRxk4v3gUsRnvGxixBxXqkife1rAaIC0XsGXhKcUXL8aobQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AaUjuPrkzLcb5Ad1iw9KIhs8NoeEZWXAkbseKFMVfM=;
 b=jzJklCIQq9B7k3K6hUDVvuhFjKnRIcfpgtsfCNOoa0zE8wL5cRARbZrGfYuow2/fWnwEwE7SITmR/0D3Rjjt7CxnqEjS2Ggl8YDt7obUPhz7aEjq0sBC0ZPzQipU3y+5DzZQFclGHMUjaMPHf3EKTT41LFGWkcHs88VgKn48EEtowmCKAM/FV0bcEg/OMXbB8QOY2XGDjWgY6pDXjZ20+nU8BdzccrcQq1lBowBc9o16HA7RjQeqwcpKlD/yz8BekI625BJZ/kaCIZoFJTcDMXMKDwiOlAf+s0L+bh07oVogbKVLSsZPAXVNMJ2/d9IXbORt3ocnkBgt2GDgA+q2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AaUjuPrkzLcb5Ad1iw9KIhs8NoeEZWXAkbseKFMVfM=;
 b=erH1c85h5iIBtydgdeeapr97KKoy7NXmH6/TKlFL//WDXEsd4jDo5psnh7miz+41chw4TULOJ8GM9qca/I27Xw3GXXOlEknS6aAWWwr+crHzzEg8u/FkyJIfHNGZLC/UhH3i8y7v/DfXv7EOz9ITGJNeA4Zl0m7oBeQd3e7Z7aE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9804.namprd12.prod.outlook.com (2603:10b6:408:303::8)
 by IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 11:07:59 +0000
Received: from LV5PR12MB9804.namprd12.prod.outlook.com
 ([fe80::cab9:7e9a:fc29:bcb2]) by LV5PR12MB9804.namprd12.prod.outlook.com
 ([fe80::cab9:7e9a:fc29:bcb2%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 11:07:59 +0000
Message-ID: <99797539-45aa-49c4-9e16-e96206127cce@amd.com>
Date: Fri, 25 Sep 2026 16:37:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rtc: zynqmp: Enable crystal oscillator when setting
 time
To: =?UTF-8?Q?Daniel_Via=C3=B1o?= <danividanivi@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "Simek, Michal" <michal.simek@amd.com>,
 "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260925052015.22019-1-danividanivi@gmail.com>
Content-Language: en-US
From: "T, Harini" <harini.t@amd.com>
In-Reply-To: <20260925052015.22019-1-danividanivi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::14) To LV5PR12MB9804.namprd12.prod.outlook.com
 (2603:10b6:408:303::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9804:EE_|IA0PR12MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 9141436b-a902-49af-699d-08df1af54207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hnSRN5xu6qYO7/nkYozlHiVTgbF+LyhDqtgqQDO6eMTZbLEBLpKIaSOS5SQMsLSAJvMqdNoahsAbqKWEu3IsasPT22aKORge5k+Vg2ByQNeidaZ+Czr5CMancQnPCLzfBQxix4kETMb74nSYBFGIrhCy8RQIsHHUvoiQqvgr1IG5ZIz5o1HzMIBLR+se9sfzYWuB43WN0hyB4cDh1K1Ip8Zo2m9v35INXg5bGUvoPI7z/hJusLd5JELY51wQv19Gc1ceSQ8fjwzbUjEVbRla0vRkoVCSwOUfKlThidwHeUnKMa0qCbFQEMmT2/QVvVj7A/0UR5q1FLA9O8EWRaKZ0Bc+KqEFU4KY/RvWzElb7kzo+H6eoobYe3HjPFBDFr+bSqhBlLsSVAcuXKDqdvu6FkDhkrv8CpxSUv6QGJ9Gua+9md9o0l2XQml379IHqLQlrRpsqw9XpsEyVJjToIMvb/ve7DdKYwHw/kpjj9HaRpQYmCcUbtAf+G66S0NjEmk4cn1/mxzkNa04fJSdSPAtrfy3QUD90S3/9lwl0eQQ12P1YqHzJhgnIE3BwMNvoQWAGf17eiKjZ2u1bdIo5DtGSNvEo4ITjw/h3r4cEdoctg2uWdsVFIs9p8i5j48UoRTtKs1kgp8vhxbVqI7Kuw06kvrMpN88xF5rtlwuRtJfDJc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9804.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHlZcGFnbUZZSmZxbHgyTHhlOGgxb1UyUHM1bWtZb2Yxb2I0RmVYdFhtYnVi?=
 =?utf-8?B?cTNRMUFEM2lvakNWandidVFzSEYzZDBDa2RuelpaZ005YmM5VHkzYzJQVWEz?=
 =?utf-8?B?S2JDOElnMXB2TlFaT1lKTEgrQTk4UzBVODBONGIzY2Z0Vzh1b0NHK1lacEt5?=
 =?utf-8?B?aVljMEliRWI1cWFaL3dlQWxVY3FTVWp2N3o1TlhjZEhNNXJhaGtzRE5KMEZG?=
 =?utf-8?B?d0Q2enhsalp3RFRzTVVUb3B0Z0dTMHN5aVpSV0RHR0w2UEh5M2dOdG11alpp?=
 =?utf-8?B?SWF0UHJNclBsTlJhemk4aGxHV1VDN2Y3SGJUNGk3MWE1cGtsWUlIbUYxbklH?=
 =?utf-8?B?NGswOGFNTUp6Ukp2aEVmdElKUGszakRpaktZNVloem8wTFpwdUszUmFWbVNo?=
 =?utf-8?B?QzVFQ3lYTmRLdi8xbXRvT2tkTWVEdDl1di9lK1BiSG1SL2FIby9MbXhGc21J?=
 =?utf-8?B?aFdmMWRiU0xiR3padDFIVHNXak8wK1RzK2Q2NDllSmlsa2dBd0ZUczkxUDVr?=
 =?utf-8?B?UTV0OXdERGJXYkh1cmV2S2RGTktWWnkvaSs3aWlaT3BnUHRkZXQxRk9OS3RD?=
 =?utf-8?B?ZnpkSHM5a1BHc1pNbjRpbU9LdEJCVG1sVFhNWWRTRjlmazZtZDNYK0JSSXhK?=
 =?utf-8?B?aW1EdXB4emRDQURXS0lnZHZaTFpneTdCcU5jWjQyRUtHQ3hxR1Z4UC9EZ1Fk?=
 =?utf-8?B?emVOL0lzZ1E4R1BwMDl1Y2R6NkxZUjg2UHlnTWVSNUloNzd0QWR5RTFyeWZU?=
 =?utf-8?B?aHhJdUlDWnoxRGcxaUZtT0VqVFlMZHBRSG9pRVNwb01BNFBjaVYzNVhPSEtK?=
 =?utf-8?B?clFoQXdrQkJPcVNmcE1xQ080MGxzbmhYRlVENDNScTBtNS9rVEh5VzN3bytL?=
 =?utf-8?B?SlUrVWpKRXJMVVM4R0lIU1MrOWxUQ2R6NUxrVHRteFh4akFXMko4Q2ROeVBR?=
 =?utf-8?B?NVZZVjNpdTBTNDNMNTNaVmxGU3RTOS82YlNRUnhmWXZVTnhrL0piMmpEcnlR?=
 =?utf-8?B?MGRmTGVpVE4zMXhCbklhaDlrSnFnMEwrdFlKY1YvZG1taHZibG4zZFl3UjQw?=
 =?utf-8?B?cG1ObHRHMm4wR0ZpVkRPbTVPUjBlUmpHNFN3WmMzbFZjMi9CYnFVb3ZVeEpP?=
 =?utf-8?B?M1RHeFMwc3JRV25nWlk2QkJ2K1IxdElLekIrOFRzMlhXWWNoK2dvdng5dS9W?=
 =?utf-8?B?QjFRUnBHL1Z3NjM1Nkh6LzdqNXRzbGZRYTVCMDNTc2ZsNmg1WGFqSXI3V2FS?=
 =?utf-8?B?TitZc2dEblVmMWNCRFpmam5MY3JxQzFRSW03WWM0TDZFZXBxOFh2eU1jOGpM?=
 =?utf-8?B?YjhzMURCSlF6MjNPVjh2SlgzaTJSZG5CRVo5NkppeHJXN3c0LzFZdDI4cGRq?=
 =?utf-8?B?SjhzNTRSazV5UkVmZGtDVkx4cFo5cHFLblJrVGlNc2ZralZ1Tmx2WkloUERl?=
 =?utf-8?B?eWVpQkVtYXFUOCtkYkUrSTJRZkJoUUlOcnQzRGg5NjF3NTFVYm1iRzRReWcw?=
 =?utf-8?B?T1VrbzJZLzliQTNKdWFUdjN1ZW44ckJxK0Z1Q3h2bUdrdVFFZ0VzMVVlZVpq?=
 =?utf-8?B?MlRobENSdTZOOHFkbnN3NFgzU3NxdkJSdnQvNkZLKzcyK01JV2RNQjVOaWcr?=
 =?utf-8?B?aU13M0dlV3h6TzNWcmlOTW01RlBsaFJ0Mm4yenV1RmQ3TWpjbExuSGxlYmVF?=
 =?utf-8?B?VEY2TFk5QmNXNVZPMzJhRko5WjF2ZXRobUtVdWgyS3hHNnVJdVlnZ3RrZG1n?=
 =?utf-8?B?eldXUjNlTXhReXpvRGtzZEVkajBFQW85SVNuM3BBWGJGa01DSzY4UExxWEZo?=
 =?utf-8?B?YUVTWXBUSm9wQS9yQkJDTmtLOVd3YWx6NzRQcEVvcko5YWd4UkZvZ1hrbkVC?=
 =?utf-8?B?ZjVzc1hPQ3pYT1Z2QVkvL1NxakJwWmZFVEh0TXFROHN3dW5mUEQxRTI5L3Ji?=
 =?utf-8?B?cGFjWittQ1VQam9ZU1NTUGFESHRBemYwYzI0bFljNnhYZDdoYllIRE04TmpG?=
 =?utf-8?B?S2NxcS9Kd1ZZSThnWjVBYmNqWHE2UWM2eDBSVDF1T2l1YnVaSDBzTE5ycGpo?=
 =?utf-8?B?OVdkN1lBenNLclNMT2JlUmY5VmV1QkVUNXZXNlo2dlZYeXBxblNvY0VadWtF?=
 =?utf-8?B?c0FJaEtHNlhEWmE2U2JZcC9uTkxGb2p6SHhoN2lVMjZvTFpteVJNeGJOWFRS?=
 =?utf-8?B?Ny9MbnMwZkdIdjd2bklLOXVmVTFBRVZVTDNrWTJjc0tXdlZzMlVmV2VleEpU?=
 =?utf-8?B?WXk2dVNDTkZWbGZRbTFWM1NKeTQrV2g5SThtRVR2Nm1RdHZINlV3cHJnbUd6?=
 =?utf-8?Q?EH6qkb0aHur9CE3+Ba?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9141436b-a902-49af-699d-08df1af54207
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 11:07:59.0165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3dnsLwfEHlJh3t4G+XQ9ln2aod1JitKB5oqQbTM4X53rfCuWYbii7O1tt1qtSWx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602

Hi,

On 9/25/2026 10:50 AM, Daniel Viaño wrote:
> [You don't often get email from danividanivi@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> The RTC_OSC_EN macro was defined when the driver was originally
> introduced, but was never asserted by the driver. On cold boots, after
> battery exhaustion, or on platforms where firmware does not configure
> RTC_CTRL, the oscillator remains disabled and the counter never ticks.
> 
> Unconditionally enabling the oscillator during driver initialization
> would cause the RTC to free-run from an uninitialized or stale counter
> value, reporting an untrusted time to userspace. Instead, keep the
> oscillator disabled until a valid time is programmed: guard
> xlnx_rtc_read_time() on RTC_OSC_EN and return -EINVAL when it is not
> set, and assert RTC_OSC_EN in xlnx_rtc_set_time() once valid time is
> programmed so the RTC can free-run.
> 
> Per the Zynq UltraScale+ TRM (UG1085), bit 24 (OSC_CNTRL) is a static
> level enable for the crystal inverter rather than an edge-triggered reset;
> asserting it from set_time() is non-destructive and will not glitch an
> already-running oscillator.
>

Thanks, but the premise doesn't hold: Osc_Cntrl resets to "enabled", not
disabled - ZynqMP reset 0x1 (bit 24 = 1), Versal reset 0x2 (crystal 
mode, bit 24 = 0). So after a cold boot / battery exhaustion the 
oscillator is already on and the counter ticks from ~0;

- ZynqMP: bit 24 is 1 out of reset and never cleared, so the read_time
-EINVAL check is unreachable



> Tested on Zynq UltraScale+ hardware, confirming that read_time returns
> -EINVAL while the oscillator is disabled, and advances reliably after
> setting time.

Also, how was the "oscillator disabled" state produced in test? With bit 
24 = 1 out of reset I don't see how read_time hits -EINVAL on a real 
cold boot.

Thanks,
Harini T

> 
> Fixes: 11143c19eb57 ("rtc: add xilinx zynqmp rtc driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Viaño <danividanivi@gmail.com>
> ---
> v2:
>   - Leave xlnx_init_rtc() unchanged so the oscillator is not enabled on probe
>   - Return -EINVAL in xlnx_rtc_read_time() when RTC_OSC_EN is not set
>   - Enable RTC_OSC_EN in xlnx_rtc_set_time() once valid time is programmed
> 
>   drivers/rtc/rtc-zynqmp.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
> index 5bcb7536e973..6c3ba8f1aa57 100644
> --- a/drivers/rtc/rtc-zynqmp.c
> +++ b/drivers/rtc/rtc-zynqmp.c
> @@ -59,6 +59,8 @@ static int xlnx_rtc_set_time(struct device *dev, struct rtc_time *tm)
>          struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
>          unsigned long new_time;
> 
> +       u32 rtc_ctrl;
> +
>          /*
>           * The value written will be updated after 1 sec into the
>           * seconds read register, so we need to program time +1 sec
> @@ -78,6 +80,14 @@ static int xlnx_rtc_set_time(struct device *dev, struct rtc_time *tm)
>           */
>          writel(RTC_INT_SEC, xrtcdev->reg_base + RTC_INT_STS);
> 
> +       /*
> +        * Now that the time is valid, start the crystal oscillator so the
> +        * RTC free-runs.
> +        */
> +       rtc_ctrl = readl(xrtcdev->reg_base + RTC_CTRL);
> +       rtc_ctrl |= RTC_OSC_EN;
> +       writel(rtc_ctrl, xrtcdev->reg_base + RTC_CTRL);
> +
>          return 0;
>   }
> 
> @@ -87,6 +97,9 @@ static int xlnx_rtc_read_time(struct device *dev, struct rtc_time *tm)
>          unsigned long read_time;
>          struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
> 
> +       if (!(readl(xrtcdev->reg_base + RTC_CTRL) & RTC_OSC_EN))
> +               return -EINVAL;
> +
>          status = readl(xrtcdev->reg_base + RTC_INT_STS);
> 
>          if (status & RTC_INT_SEC) {
> --
> 2.53.0

