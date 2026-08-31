Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022140.outbound.protection.outlook.com [52.101.126.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9504357D1D;
	Mon, 31 Aug 2026 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788142643; cv=fail; b=QUwTyHU1+0YhpmKumrsPKAwYBOa1hEmgLQdpXSw/kkTFkBV+dX1bpl5dRKiCR9LUZxig8K6iFN3g59iTnpunLxSQrt39bqih92AlngmMn/OM0Fr/zG+9P+X35udzyi8loqHAORYm0pxLJMwsVVd+tA2dhNW66pOVbr2pV4fNS2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788142643; c=relaxed/simple;
	bh=w8hKYxQ9YdFJbW4BGTpBfCYlI46sKXlWwM8IOQI1DL4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a3+N4r/78yoITYWkLg64wVg4QWI7iV8mf0UHM+KfyzWXA6N96dPnnzuJjd83KuVZQz/2UINOhIwcwBbkLHL8MfSt2PIF76bBE51PGpwuDpakLe6N0DWoQh75X98rqDpttFlEN3pbfhjGMhtI9ISIsPUGkddnxDzqgJY3VWgAzNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=H2Hm9YM0; arc=fail smtp.client-ip=52.101.126.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="H2Hm9YM0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9cxWr5jmBRxBKE7CT6egMLGw2y+IkQztODSFSjlfNB3IynCRV0blcxcNh/mDmsfca5l5ODysI00DeOhL5ftm3gcayw1UYvzafldONtnc/H026vkp8IKa8vZHDXlNaV/6G6q2y/giTeC4R1vi6EgrgvfMqfZX4/70foWDX0XJJLWfOiFyO35H/dWcFKDA+FCZpp+or/oFGLuXnF6qmMM30tbNRKP87LS6kKFw9N35dmIQ9gGoVOw0DEqoxe8bVfaMeX9QQ8WTUNDY/DlikxqTlnKAX7qdWxEoIMfbEokFyNqtxKdVG8bbcTIZsuX5P6ycfYTpZTM+jA8c7fHiL2PVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3r6IxTkidNgOwDbybbsKMOg6IcPcJD+Q+CfUUKQeAM=;
 b=xBWnZkQ1Poh2rj5U1mtslaWjIjkO9OqBKZNE0lATExVw0cMjco8VcJ7t7byZQe1536EszstGt1vJLSSzBXGti69rs+t7EaDxSY8cXJn7wbA6pNPvS+5espYkjUgFMqkkuBEYUSHBlNSjCBSPbK1VV3RZX7Jb0sgpyAW5uQDk6c6bfHVxSA/LX8I7gf6+aGjUxgN7RIH1lybyEQ7wpZ5rEc8Tea5ApqR2+cd9O23WhZmQClcZ22MaEE+m806zuXLkKdQx7OL0IRnzJVMi+ikp22zPV9862bBqFJuNO2lZr2quyjBNPgUqOI8GyiaWyjmN77kypkml8m9fATJ/vlQLDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3r6IxTkidNgOwDbybbsKMOg6IcPcJD+Q+CfUUKQeAM=;
 b=H2Hm9YM0IwnA7wRzvPW6ZEfJNO8E3j2jZBs4OPprffJyAYUgD0MbX89v6g+edqeL39fba0cMPvc43p0mV+tnmm/EcwT5OgRyChieDbAS/wP0sUJ9sTEtNt9vQmWZRcesPcTa9MlYuvkoJx+xtVyYJPlBjtjFvK18L4NVqE9resM2PSjD83IHsQuiJNTC35TePCz3ZCMg84MJj+XsiNuKiylzbVHjPXNDqd9NvkRvEBkZTk2KNza7Kubv0g7MpfaOsvpyICcYcKHp7zvq5qFhTMyRpgJ6tXZaonw0IIld31n5yeSq3HW6Rflt3z+grZ/eXpDmxKSpU5OqJpLaXzStGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYSPR03MB8627.apcprd03.prod.outlook.com (2603:1096:405:8a::9)
 by SEYPR03MB8744.apcprd03.prod.outlook.com (2603:1096:101:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 02:17:16 +0000
Received: from TYSPR03MB8627.apcprd03.prod.outlook.com
 ([fe80::bc0e:21e7:ef9e:e77b]) by TYSPR03MB8627.apcprd03.prod.outlook.com
 ([fe80::bc0e:21e7:ef9e:e77b%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 02:17:16 +0000
Message-ID: <09dd4fb7-ec95-440f-9d6f-74ead72cde4f@amlogic.com>
Date: Mon, 31 Aug 2026 10:17:14 +0800
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
X-ClientProxiedBy: SE2P216CA0123.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c9::8) To TYSPR03MB8627.apcprd03.prod.outlook.com
 (2603:1096:405:8a::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR03MB8627:EE_|SEYPR03MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b212e8-2683-464f-98dd-08df0705f9e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/zLgRHZ82zcAR1XiRL+qBTgJu/HduPIBeq7+7nUdIYPH8Bj9dLGijrnqk+yYmAytgXAv+SqW/dOq3eblo0CG+ODX8y8X4qutY5M0iPoEAxZwOqKxfZowok565Om5lWSAhzgiq+Tp7PYtxpcK3N4Qu2B+uCFrrNfSiALCUXDA0HURuDDpBU9GQ1y/Ns8CcNGpVLy/Hjcziv6gqpeQlujR6oFupR97c6Op8V/qnRrEK1W462bk8zGGe9je/ouJpvrWYcFDTI8YNScc/fixpU+w4shh6OBMOQ6H8iUrKJsmL+ctQRBXaofBr7YtujoOhzGHA24WiDCLAeZouBF0RfcchDkM7YN2eHYgW5MnYe8H3Vg030LsVFvpQM0k8breYdRjmQ0iG4mDe6T/vCFtKUQKjeULcBbWAqPrkFjJE1jxX+GOqIPTN9Oa04cCfKSFayLKTohEoMwUi55oysVrcJKW8kTbrMtlPZW2YfEXeui4YabEPyOp9xt5VGn+BWw5q28+JWe4b56z1My80lkIxkTCELV75dryzR7I9qUBKGMgiemDlb9JS7n4tIQ6dumVaY+Riex/yPx89IQDHbrhtlAXaIrOBqT8NVNPFyT2GtlVwDL1q82RS0jN9QlRoc27VrQ54QNfVYvltGMXo8XLnQcOvtygXb92BVtHQ7pD+IxNijc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR03MB8627.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGVHM3JFUkRVWEllSjVhNklLL0w5eWhLYTFUbmVMSHlabjZGYXR5WUM1MjRV?=
 =?utf-8?B?OUI5bUliU0huc0x3R2RpbTE2YjhuNUpvSGQ0bENTOUFma0dhaDdFRVZsSjh1?=
 =?utf-8?B?VFgwRkt4eFJWUnlLZy91ZkVMcHIyUFlOZW5MVURkeWM4MHdteUtJZ3RRQXI0?=
 =?utf-8?B?NGFuNE1kUHU0eHNLOG40YWo2eXVaK2pKdEdOeFdSYVNVdkNLcDFWV0dpWG1E?=
 =?utf-8?B?ZjB0aXd3Z0NTUnBwS3g1R1dibXNnY1RaZ0dtRjVnK09XQ1lQL29oWEp6VmYw?=
 =?utf-8?B?TW9KWVhhVFVHWDVGaGxlT0hCeGYxNzBPTEhEb25jMStWelJkQTdNTVgyaVM5?=
 =?utf-8?B?OUV1WEhtaFJqRWExd0FhelIvRUhyZjJyT2kxZHdsSS9WNDhpNDdWTVVxZWJU?=
 =?utf-8?B?WStUNVVzRTIwTStZOTEzSVBBcXllOUwyQXRNS1pJaUxhUTNWUm14UDhxdGNh?=
 =?utf-8?B?dmJyWEJrNzdhelRWV3F1V2RvSUtGZzJxb21CeWo3OXQ1d1hOTVNiQ0Rtd2Fi?=
 =?utf-8?B?T1ROQTU1Q2l5akx4eUx4VThHUGxmYldtbGMzaW9QRGJBVlIvNFNJbHBkOFky?=
 =?utf-8?B?NWU5UFdaNmkvaU5xd20xYlVDbnoyMGdqd1lST0p0dVM1SHZLRmxmRmpxUVB4?=
 =?utf-8?B?d3MvdXRXT0FzVGtoYlBxSzBHRVVkd2pnaHRka01xOHdWRFJrRmVSVDJDRUtH?=
 =?utf-8?B?ODQ1NXIwSVQvM2pmVm1CWmZGdXRPaW9KMHZIMlRGNUQ0MGpCc3JqSmRnUjhC?=
 =?utf-8?B?TVdIWCtPQzk3cWFOZkI5M2g2ekx2OVN0TG0vRTh4VW9WNnQzUXhNbmc0ZEs4?=
 =?utf-8?B?TndZSnpNeG9kRHIzRDFZc1pQdFNabCtaNUhkSDhVVXFlL1NtTktONHo1L0Fx?=
 =?utf-8?B?TW9iQXFRZFdaMHVSOTBIVTdKclMvMkV5K1BWOXBxZEREUS8wOFMxUXBWRkR4?=
 =?utf-8?B?YUowY1I5dHJ6bk5ESGRCRTh6WFdmOXNLT2w1aU9rUmV4RnR2Nk5GRUJiLzc3?=
 =?utf-8?B?eHZFaDc3Zm9xTElEY09JNnl2dWo5SW5IcWdNcUNDYVc3MzVZMXFzQ0pxakts?=
 =?utf-8?B?TGpjdXhuWDI5S0dSZXVYNEo3dkRRcnVTcjU2QW8zejBJdk5aRTVQeDU3KzAv?=
 =?utf-8?B?WGNjd0xnVmJFYm1RZi9IR0IzSTRuMmdXYUZtY1RUUXY0cmlwaHVXcEY4dWRo?=
 =?utf-8?B?TVlzTXJnREkvb2RhSUtwN1ludnBIS0t1NGpBeXhhNkI3RUkyQTRHL0hCQVdv?=
 =?utf-8?B?bHlRemJtT0ZUOXhSeTJKaDRYYS9BWW0wa3ZCbTFlZjB4aGFxNkkwcmh6MXl1?=
 =?utf-8?B?cjBuZ1g2ZmJaay8vZWY4RTVBTCs0RTRQcG5UR0FxdDlvVGR4RmljSHBoMWRo?=
 =?utf-8?B?STM1K0JKeTZ2MENSNlhyb0Rmd0NSbmxScnEzcUJkSkNwdUdtZ01wRktML2tO?=
 =?utf-8?B?cmtwTzZ5Z3JOWVBiZWVWU3pZdFBIKzUzUCtkbkovMDlPYWl3bWRYWlRBYnd4?=
 =?utf-8?B?bURqZFRzcWFyVmU1dVg4cFZDazY5QUxVbUFENFJJdXFzZ2ZOSk1pNmR3K00v?=
 =?utf-8?B?bDhxazVPSlJUSldjQmxlSlcvd0syUWJ0SEd4cGRvLzA1T3Y0L2VValpHSTVx?=
 =?utf-8?B?TUdPdE5lZGpISHhkcXJvdGdnUVZTS09NT0p5RDdJc05CN3gweG02QWUrT0I0?=
 =?utf-8?B?OTVFQ3pmRk1VTzRBZVRjNmUrZjBqbjFtclJ6NWphR2trNng5eHQwL0U5ekJh?=
 =?utf-8?B?eXJFakNwZHFQcUtwOXNoeExEczI2UEpwb0NjUm04OFdwK1FXVEcyNjI3a0c5?=
 =?utf-8?B?SzVFTUF2ZHlLK1pka2pMcXZhejdPNUJEVEdjSDFJc2U4d0tmL1AzRFlpMUZi?=
 =?utf-8?B?NGozbGoxUFdhSmY1Z1RYMW9CRGxhS1FpQnJNK1ZLMGoxMzEzTnE5UzV1d01x?=
 =?utf-8?B?amp3ZUk3WFJjakpKeTQzbXRZMnV6cml1ekhSQnovakI2SW03eXRhcUU5K0hs?=
 =?utf-8?B?RnZ0aE4xOGVtVGpuKzlia2N0U3ppcVJTcGpZK05GMnN6eFoydmhjblVrc0xK?=
 =?utf-8?B?bUhpMExKU2FxYTVmZnBiYlZxSUh2OGFoWWM1NzFETUlxUGtOQVFQTUhHeDFY?=
 =?utf-8?B?NGlpanFzSFk4NEtMVTVrbG9lVFNZZklvQzhTZ3c1NXpQcE9LRmRDNWFRaGpH?=
 =?utf-8?B?cnU5MEVJd3F5aHhxMUVlbnF5Z25lV1pVR3JIc3VsaStKZUtFMm95TEJod1I0?=
 =?utf-8?B?UUFBNE5CcVFaNFpqcFBTaUdYVkdkdUk0LzVoOE51Q3F4MU9SRW1FSWRXM0o2?=
 =?utf-8?B?Uk5naVZXWCtyTVJlTWhHVGdXaWtGWDJRQlF4U2JUNHpNZkVCbTVBQT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b212e8-2683-464f-98dd-08df0705f9e8
X-MS-Exchange-CrossTenant-AuthSource: TYSPR03MB8627.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 02:17:16.0117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rh9FVOM9gRHWQClkFIHbBUSJYyoA7QrY0ROwugjxXJ9ykLj/gN+HGg8v0BdeoR9ErQYoEeMcM3AbnHyYT07ftA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8744

hi runyu

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
Explicitly calling devm_free_irq is unnecessary when using 
devm_request_irq.

Thanks!

>          c3_isp_videos_unregister(isp);
>          c3_isp_async_nf_unregister(isp);
>          c3_isp_core_unregister(isp);
> --
> 2.34.1
