Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022097.outbound.protection.outlook.com [40.107.75.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F96C35975;
	Mon, 31 Aug 2026 02:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788144274; cv=fail; b=JdVD0uk1JdBGQe1JzHdUF8FOShk8ypGTb1U7kXFrATL6wuqxUKDAQm2Cc0MfLer31AQSOZmOfT/qSdypY0YKv37liibd/d5EH54we+wi8BgG5UuN0xScm2Tj86dN5P617FAGqZFgZEhbASRaVqrmKGQ6Sjboz4tiWhcrVcnejy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788144274; c=relaxed/simple;
	bh=rKekmUguL6stdyBtwVCWK9ioJFpAMZx/Bu8LSp+nFks=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MnaMaH6rSGHBAn3iQAPYOwx/rLHhmQrRa9P7EaDnGmGTTZOzod7rMX+ZfmwdzKpx3FdCeKUxmaYPY7qEKyNrttgzrjA+7iqKhVcD0xGtG3GavoXDHjW1LCXHyG2fB22OXGPQ6Z6NXNNZSXThweFiaYwo4uzATAynqtci+OX3BaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=gTyfyi0K; arc=fail smtp.client-ip=40.107.75.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="gTyfyi0K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRiLNqNL8KgcFpU/jdjNBYdzXuiJgbbjIBlKZI34tB9/J/l+MnJi/flBnS2uuRcq2GuGMJ8YGic5/HijBbW7oY5rGWHun2DNk3ETxuk0r28xaNEx9yfW7AsDumE1WtpwpTlSVCjcAHAgyPr85K7qZ28fcUSbqbqmDS+tdCbilj8nBUcijdFgzjsJbQ/DZvN8fakEEZ0IFg4JxoO13VwPcVqtlDTMGRLdk2GgJUTbVmK034SEhOBT9v1d6nqeXFGimfOw4+4c8+bDwCPfMdJpgMGYNG1Zp85Y7jKr/Hj7QkxMxMuazg9OoqmTYN8Jv0dPA5kim2NL1wH+BHInr3XVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vzrD9r7zZXzlIHzhjZxgG+GB8YxIMRjlD5dOjhsIGM=;
 b=JuPGh4B1Sfggouf1iZS0I2pOgSQZ2neN+6soh04UhvG1aIWl/IH9rHtr2svWclfkmXq2d2NpkZ9OR02Qeuz3Rs2x/fHRoEHSkakrsh8GLefECleQgycfoz7x4DtQXsWLBqLGbwHsFTjALOIpkpkMFGvHk5Pvyfjww5LMs7TRw4V96lZUK8YcHCwc6a7edxFWeB/pMEHae1szsQtu0+uicm0QL0UwPZEL79m067r1OlxHoK8OXLapUNM3H244x01pI/2p9YF61zUa+b3HOazZsinMu0qVJHawWFjWXFWr6OzC3I06aZ4a4Oh40WOszfvGAsjlBol+101ag7SBYdpILg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vzrD9r7zZXzlIHzhjZxgG+GB8YxIMRjlD5dOjhsIGM=;
 b=gTyfyi0KuITrOiaVNxecuYBOpWOX9N/n05/QemBtjUcaIR1uwzcCgCaQYLGZkj/2al7UuBJZnCTJ5tCjkOKzp8O2A9pMl5IXOiWvHj8vV7OqSllUyGkBLvIfcLS9GaVx666/myjODP4/CkDudpR6AaUIieI7VfERs1OMfrvB7dRL1jv+k4S18xltYn7keAcC+q9x4S9+iInTgie1wkyMTavwGUcWFelLAOOJB1WGDjrd23n63musjUT4uLTbg9oKYODT7c1sG3swdfBtSA5iCkNAiYm2HVZug8MydAOMepvt8w6CuMRsfDNlYrylgvumVGRnabzTxnOhXG34xHFHqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYSPR03MB8627.apcprd03.prod.outlook.com (2603:1096:405:8a::9)
 by OSNPR03MB10232.apcprd03.prod.outlook.com (2603:1096:604:49b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 02:44:22 +0000
Received: from TYSPR03MB8627.apcprd03.prod.outlook.com
 ([fe80::bc0e:21e7:ef9e:e77b]) by TYSPR03MB8627.apcprd03.prod.outlook.com
 ([fe80::bc0e:21e7:ef9e:e77b%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 02:44:21 +0000
Message-ID: <f3592219-2634-47b3-ba39-d1fb1a8bd2a2@amlogic.com>
Date: Mon, 31 Aug 2026 10:44:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: platform: c3-isp: Register IRQ after video state
 init
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org
References: <20260830143945.2700038-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Keke Li <keke.li@amlogic.com>
In-Reply-To: <20260830143945.2700038-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14)
 To TYSPR03MB8627.apcprd03.prod.outlook.com (2603:1096:405:8a::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR03MB8627:EE_|OSNPR03MB10232:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4f603e-8056-4f25-187e-08df0709c2b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MHcn6IOOxPsUcrCVcXh/wV3hOwL15qvqDnj8K++HjtBm9j+IfBVu8pIHo0ZWkFRY+pXfBRd5I4G7PFE9NmgLsDMaZEGSvBbvBJhfurt4KMesAXVZ/CYehbSad7LdMHsaZvX7eV1S5D6h1/nIir+5mxWYUEwejqDTP5DtNNI+VzTnxrl/OOjr7wWgfjTdnXoKjP1a9aUIRI6Xa2YMmNEbaKJ7RbVTlz/H2tfR8DQ8r38OMm6Gf2AyEQIzWmxkboXmlPMYGnIq4pDTtq7qG/Gc2lwWyjenQ3O5V0epvpZqZHY/fXZ0NqyqOolr1oq3zkKdDbREeKN8pYqGYS4wkTtNHCskdgjxVA96jikhQr/GLD621aJsiYFTVkVu4weEGZx7+Eq35wbOSJEotodnVQ2tgJee2sGMR66CqnqAKKN8zEEIVbO+bNoYoj5aSFh6u6WurWoLQadtP8TORnqiDhFdV56+/CHpniI1gYTwb/dZcl10sw5AUIk3L/IPrqu2o2zcLZs7NDN8FzE7WH3TmlrJI2nA4HFJcl4qd2lJdsbQ0hkuArFr94nBGUMhB0PdSz8zcDAoIwC7ZUqCzUGxAtAUUaO63Lu9kn3wW3pVu1+6ardPbsPhfVpiDXkjQCPc1Y3b1AbNJCGuNJaOEftbUc6RMj+5z05g6aPl0Diz1S5HIlI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR03MB8627.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2VtT1dvZ2h3NVFheXZFNXBRSktQMWNZcXNtdUYweDlDYy9uNC83RjFvRzBp?=
 =?utf-8?B?dDMzVjVURFUrTkx2UUtVbE1zejM2Y1BmbFpET29ldzQxRDFjb0FjcWllZDRu?=
 =?utf-8?B?U2lwVC9Lak9zSStmK1JEZURKWi9ueEVCUVhYZC9RUEd4NXBYZnZyVVpCeGhX?=
 =?utf-8?B?QmF5VkQ2aWEraEJoc3hrZ1R0RERLazdWR0VtODd6ZlFNWUNyVG1XRVA4QkhF?=
 =?utf-8?B?STNZUm90NUZoaVl6QThTaWRNTGZmUnZocnF4Wlh0dE5mZ082ZWxKYzE2dWhI?=
 =?utf-8?B?Y3lQbVZpblZrNGpGLzdyczhGZ2RBcUFlaHVLRlltdXRaa3FGOXcvMjRjcFJn?=
 =?utf-8?B?ZmtYaXRqeUpNVm1kN09GdDVsT2dWb0w2NkxtQVpwSkloS05EYnduM0tSbmhD?=
 =?utf-8?B?R1ZwV1N0K2QzUkhKZWxOYXpnTURWa2NPdW10aEl1djYxRDArdlg3VWl3bnNh?=
 =?utf-8?B?ZVFoMlVOMnphYzlWL09ZZlJ3ZDMxMHVLLzU1NlVEOHludlN5Rm14Z2IreU5r?=
 =?utf-8?B?RUhiYUZTaWlxamxaY05nK3NWL2dadm1NaE5oWFMwTjdUSTg2UXk0WWVOZ3Fl?=
 =?utf-8?B?cnc3UEZpVHZObWpndEpNYVRKM0VSZy84T0o2V1V1Z25IWjB4b1cyZ05XSjJa?=
 =?utf-8?B?SjRES3FPOEhHOW95eFdyUi8xN1ZYbWhRSkdzL1pMdnNXOFZHanp0R0FTbFE4?=
 =?utf-8?B?NUlyTHdkUFl4cDVSNVJxeEU1WkN5Wk5XQkFxUVJ5N2U0WGVoUVhCQzhiT3R5?=
 =?utf-8?B?czl2czd6a3BrbUJSY1M0cDlUUmlGTm5uU3pMb0lFVmVYZUNpU0lSVVRJRUgx?=
 =?utf-8?B?bUtDZWdDa3JQMmg1TjVieWUrNDVwRkNyckZ2M0lTWUF5blZpSVNyT08wbTBa?=
 =?utf-8?B?dlBqYkFOSWpNZm9sQjhRUFZhZFFUNDlZYWJzVVhndmVUM3hoRHVkOWE2SlVU?=
 =?utf-8?B?SFBqVkJwTklqOGJ4SnhNVU1COVUrRHFmclhtcHRWdzVzWnBmTzV3TnJXU3Yv?=
 =?utf-8?B?RGhDZU9zSlpYL01vTnZyNnByWW9xajVXbk5VZWJXcElJbURzbitXdzJQRGtX?=
 =?utf-8?B?OTBIL0U5aFp1ZDZBOFRsc3o2bTIweEYwM1lOYkdWMUVzcG4wWDg0TEFqTWVR?=
 =?utf-8?B?NHF0aFY3U1NtdGdMR2hPUWVBeERtWlZRNjJQU3VTYW9yaGx6OXVLeVVaWk4y?=
 =?utf-8?B?SFNTdXQxSk8yV0lkQ1dSMnZoMU5RTEt0YmNyMCt1K3hPay9IRzh6c25SR2JH?=
 =?utf-8?B?cHpjS3UvMFUvVjNpUXo1RW5va2dFa0M0WHF1VnZhMlc4a3g5dVYzSUVoNEpO?=
 =?utf-8?B?ZGJlU3M0UkJKZnRHdVZUWGorc0ZZTVB2OHJtRldyRlpUc2JIT0NhaEVDZGJK?=
 =?utf-8?B?NUpIQ2RURzU0NVVxUURydUNoblNEOEFXZjBrVVZqc0ZoeldUT1RjWGtKMG5w?=
 =?utf-8?B?R3A0K09kZWxSZ1ZvZC80NXJXbkE2NUtzMFRwMTdSTHQzNXBPcWFkTmVObTJz?=
 =?utf-8?B?MjlNZHNPSG9xblNyYytJSFdTaXJmQ1dwcVZxREVZczVpSnkxUGJZMVNlZDcw?=
 =?utf-8?B?c21tYU5mM1hZUEZPK2MvVXl3S1hEVXpwb2t2eUhlaytZZlVlWkZVeEwzWnk1?=
 =?utf-8?B?T28ySFprRVhsKzNPeGhCV094WFJOK0Mvdi93ZVZ4Ty8wUGVaRkkvQlNOUkJP?=
 =?utf-8?B?OERLN3FVZko0SGVaSlJrWHVVb2UvQXFDeWRORWFiSEU1b01nM0x3aTBGZ1FU?=
 =?utf-8?B?ZWhLSnlGT1c1VFhDY2dVTjdlK3ZxeHVWcytIeEZVNllLcU9remVIaFdkT3VM?=
 =?utf-8?B?UnhmYVhDeXRSZzE1Q3NFUkhQS3QweVd1d1Z1dEZQMWZXeitRMXkyaWx2TEEr?=
 =?utf-8?B?ODN3bjc4SFpQL2J4UjVzYlRyc2pZZVI1d3FjcXZPajRGSFZIMVUyQnErYU9X?=
 =?utf-8?B?WmFna05YdFBDUnh6VVgySW1TbFIvelprM21UUCtIbXNqdmYwcEQ3NVVvYmQ4?=
 =?utf-8?B?MnRnT2szNE1hbzhrcjdIbU1aNlZNT1J1QjdtRG91eXd6ZHIxWFZZMW55Tk9V?=
 =?utf-8?B?Szh3UjdXeVpicG1WTXpJRW1nQ09wczRncFhhS2Q3ZkxUSURvQ3ZpWlYrRUk1?=
 =?utf-8?B?Q01lYkNFeUVZTHBxdGN4UWxiSmIxY0M2MytJL0tKKzBvS3dhSEhKZ3N3NlZY?=
 =?utf-8?B?amhWd2RvdHNGM2wwTW1uL0VVRjhzUy9iV0ZiTlJiZnR3UDMzVGJvR2dvYXhK?=
 =?utf-8?B?VE5vY3FwU0lydUNMbldTLzhWY1c3UkRCeWRrMkplajFSc0p6eGpEWWkwbmFz?=
 =?utf-8?B?OEJRL2pEYkdjNWxKQVNRa1d2TGs2VVdseUJSWGFJQy9Tc1M1MjRpUT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4f603e-8056-4f25-187e-08df0709c2b3
X-MS-Exchange-CrossTenant-AuthSource: TYSPR03MB8627.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 02:44:21.7679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygqm91cOmuvfWV4OC3E5HNj2jcp6YGB4FwJn8FRqHbcr5lfcbYsGcXjBDRp5w6Lb2RwnQ4/5pjckottXlN0d5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR03MB10232

Hi Runyu,

Thanks for your patch.

On 8/30/26 22:39, Runyu Xiao wrote:
> [You don't often get email from runyu.xiao@seu.edu.cn. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> [ EXTERNAL EMAIL ]
>
> c3_isp_probe() requests the shared IRQ before
> c3_isp_videos_register() initializes the capture, statistics, and
> parameter state used by the IRQ handler. request_irq() permits the
> handler to run as soon as registration completes, so a frame-end
> interrupt can acquire an uninitialized buffer lock.
>
> Register the video state before requesting the IRQ and free the managed
> IRQ before tearing that state down. Store the IRQ number for the remove
> path and preserve the existing probe error unwinding.
>
> Fixes: fb2e135208f3 ("media: platform: Add C3 ISP driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>   .../media/platform/amlogic/c3/isp/c3-isp-common.h  |  2 ++
>   drivers/media/platform/amlogic/c3/isp/c3-isp-dev.c | 14 +++++++++-----
>   2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/platform/amlogic/c3/isp/c3-isp-common.h b/drivers/media/platform/amlogic/c3/isp/c3-isp-common.h
> index cb470802e..56b7d48e1 100644
> --- a/drivers/media/platform/amlogic/c3/isp/c3-isp-common.h
> +++ b/drivers/media/platform/amlogic/c3/isp/c3-isp-common.h
> @@ -293,6 +293,7 @@ struct c3_isp_info {
>    * @stats: ISP stats device
>    * @params: ISP params device
>    * @caps: array of ISP capture device
> + * @irq: ISP interrupt number
>    * @frm_sequence: used to record frame id
>    * @info: version-specific ISP information
>    */
> @@ -312,6 +313,7 @@ struct c3_isp_device {
>          struct c3_isp_params params;
>          struct c3_isp_capture caps[C3_ISP_NUM_CAP_DEVS];
>
> +       int irq;
>          u32 frm_sequence;
>          const struct c3_isp_info *info;
>   };
> diff --git a/drivers/media/platform/amlogic/c3/isp/c3-isp-dev.c b/drivers/media/platform/amlogic/c3/isp/c3-isp-dev.c
> index c3b779f63..66242544e 100644
> --- a/drivers/media/platform/amlogic/c3/isp/c3-isp-dev.c
> +++ b/drivers/media/platform/amlogic/c3/isp/c3-isp-dev.c
> @@ -330,6 +330,7 @@ static int c3_isp_probe(struct platform_device *pdev)
>          irq = platform_get_irq(pdev, 0);
>          if (irq < 0)
>                  return irq;
> +       isp->irq = irq;
>
>          ret = c3_isp_get_clocks(isp);
>          if (ret)
> @@ -355,18 +356,20 @@ static int c3_isp_probe(struct platform_device *pdev)
>          if (ret)
>                  goto err_resizers_unregister;
>
> -       ret = devm_request_irq(dev, irq,
> -                              c3_isp_irq_handler, IRQF_SHARED,
> -                              dev_driver_string(dev), isp);
> +       ret = c3_isp_videos_register(isp);
>          if (ret)
>                  goto err_nf_unregister;
>
> -       ret = c3_isp_videos_register(isp);
> +       ret = devm_request_irq(dev, irq,
> +                              c3_isp_irq_handler, IRQF_SHARED,
> +                              dev_driver_string(dev), isp);

No nee to reorder c3_isp_videos_register and devm_request_irq.

The ISP is inactive during probe, so there are no spurious interrpts.

>          if (ret)
> -               goto err_nf_unregister;
> +               goto err_videos_unregister;
>
>          return 0;
>
> +err_videos_unregister:
> +       c3_isp_videos_unregister(isp);
>   err_nf_unregister:
>          c3_isp_async_nf_unregister(isp);
>   err_resizers_unregister:
> @@ -384,6 +387,7 @@ static void c3_isp_remove(struct platform_device *pdev)
>   {
>          struct c3_isp_device *isp = platform_get_drvdata(pdev);
>
> +       devm_free_irq(isp->dev, isp->irq, isp);
>          c3_isp_videos_unregister(isp);
>          c3_isp_async_nf_unregister(isp);
>          c3_isp_core_unregister(isp);
> --
> 2.34.1
