Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012030.outbound.protection.outlook.com [52.101.66.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719C433122A;
	Tue, 29 Sep 2026 01:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790646212; cv=fail; b=tshyOU+yUfTpVsc+h7NKUENQnr8dtwlaVIpTCTzbXxMSgBO3Po1uTxzInhyrwrjHxeAMEPSyY854JWaBvjol8fGRzzB62mAqponABJuVo19gchiZ57MhygJEjYTmYE/lq5WCa2Q5AgF2VSA4xjQSPYgvBNNACJpz0HphHJp5i7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790646212; c=relaxed/simple;
	bh=2WaHQDNm8+qPuCyl360/Bo7bLsWBQpCm+TeluvqQjaY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=evGIUjExflNLGzm6Se6F+jrPsyH69fEudHaEnNrUfgTDthgefRnb2d3+J07UcTZgAFv6qzx+eCbjT+ErVSucLPQL3/rOx0s3wXw9DJlQnr8HSiGK7wOyrNfZFpkJ1hS2yEvhP2oiyck0eXMKqHOLDg8soWFwIZsTpB8dEOP3CcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Po+v7UjF; arc=fail smtp.client-ip=52.101.66.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Po+v7UjF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+wJyZLkf4hwGoYQCW3RZtXZbFwr8gGYLRp/iczsqQb8hq/Gi+GtA29WtRzpJ7ClWvLPH2+KdMBL6sfU7YBpPR8R95vQ/PbvCC8+8Z6Ty3jJfg8tOXfjj/UE88Pu2MoO6l99oRNP0c4duZKQs8bILiBqjFZy19Hj0nQxvdCRltwa4/wixZD7oBDyAlVwUHkgUU3nBx0gV59GJKRQOynESup/RynrVtiPzzG0kkFZrA8ksyZnCQWGY9bV9kig5yDcoxwQmhFvZ6twFV/2tSArFs6fk1Nf8Ze+r1rVLN32LrdoLQy5LPY2VXO51zk61Dx3rpifzbQgixT8XIH96eCjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFR8WeA+cWmmTbQG/T34QoaoxAtJIA2UZajR+eMaVN4=;
 b=Pou3YpUhrE9pOh9Kcb61gmM0vs3fMIpZb3EseciooD0lbY2EIFXq96sY5Dm+ksY1kYQvDUmYScjQrJhUE3spyc9OrQGl/U9Y3g5axagem5oD+lKkvAjZ6pXGqF4ghXmRzZm7LrLr5HR04kidt+/NqzfvE0gnLxguF1D2txC87NYU2Qe6jhLGFDhQiuUkZKpehv6CQepJaAXfeAE4j1j4DBxqp/IDA2kPbGCrc9PeDyj5MUsHYJXBc6Sc0adesCEgwyuSUST/62XQmzRDMqW89bFuBsrqfUaIZnNX16jIKuSnVfWNUbB2eTKiKPVp4Kl09Jan90s3JUlBQTm5jLciXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFR8WeA+cWmmTbQG/T34QoaoxAtJIA2UZajR+eMaVN4=;
 b=Po+v7UjFaG5ozpnNS3fzIS14NGZZgfjJiDjb3B8yWOmKpuMvp1o1wHuKSoLEt1BDRBNnAvTdynnf5gwD8nqfnw9rnwFj+mNkqOREG/9Wd7LPqcJWCcU6D09dVwrcroFmwLOBOVhveN0SeiEbr3wPWWl73qCvEZQG8MfXnAcLb4p3aHsdlJfPKbjR+HXzqHIdfLnxgSYyVubwYreCLUoa0zLN1+/yMz2PXW/dF8pS/9dakdjD5qVm14736wzHBo6EyVVlPzwGAIay535+FjhIFKPP4dhKgE69yfh39EnXlYehTYAzlwHOiFg5TPA3ZqtyvHZxXeCj6fMfO4xpZ80Lcw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB9791.eurprd04.prod.outlook.com (2603:10a6:10:4ce::9)
 by BESPR04MB12562.eurprd04.prod.outlook.com (2603:10a6:b10:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 01:43:26 +0000
Received: from DB9PR04MB9791.eurprd04.prod.outlook.com
 ([fe80::806a:199b:49ec:b4f3]) by DB9PR04MB9791.eurprd04.prod.outlook.com
 ([fe80::806a:199b:49ec:b4f3%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 01:43:26 +0000
Message-ID: <11eb0652-9d90-42e5-a7a1-d1e0c7535896@oss.nxp.com>
Date: Tue, 29 Sep 2026 09:43:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] media: amphion: prevent unbind while video
 instances are open
To: Myeonghun Pak <mhun512@gmail.com>, Ming Qian <ming.qian@nxp.com>,
 Zhou Peng <eagle.zhou@nxp.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
References: <20260925191706.3144437-1-mhun512@gmail.com>
 <20260925191706.3144437-3-mhun512@gmail.com>
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
In-Reply-To: <20260925191706.3144437-3-mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0272.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f2::11) To DB9PR04MB9791.eurprd04.prod.outlook.com
 (2603:10a6:10:4ce::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9791:EE_|BESPR04MB12562:EE_
X-MS-Office365-Filtering-Correlation-Id: d27958fd-5a3d-4944-ec4e-08df1dcb0e37
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|376014|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	q+dS9XIvcbtuiNN6ZJ4MFdpXH2YPM+KYGBxSs5ZSMIakEXZbx88FhZBeNg9wuq//EwtE9f/YDbeTMlMzSO+kmZwvAkXgh2NSDZF9ezIyxNxu2riWYsjl/Kmb7FwhBHe/b5OoRbA+Jp01baTAgq6qpSdzHnJcTrWJnbRyfgaV8+KNM0jiy4FbuflhFVkDHS8oY0F0txDIzg6F812FLgbR1Q3j7ZOlJJ6YaBdZ81RFIl3sc6djMQ71Fzb0bnjijhvHT/190/xQ1/fSgH/24Ag1WMW33IrVpS+V+NwZHvm7l4dOdPTQFmBZACv0MbkXBztMyTzeAxgopaLBYPsnY9O1zh9vgRq0QczDVdoDEsnt22oosGN9C0n+tH7KFIHNi14gED3rFn2750o12/HLkZkC1ND/EjQ6Cx1W9LjvQ/ejSL2UGwLG6d9eU7IDtWDHNwrEjaE02ghNXpp48MQTscxE4r6ltJSoMxy518zOXRbYG0zrotDjyrtfiVxFNo439hJndazU+whne3r40piJpIkJssZSK3W6a8IAE4zMp+WC24L5/UZWF/bs/lGPEU9LXoa2mw6d5ntt24EFE2p2JQFkrktO7a8L43ZLdmG3eAa7IZTlV/7XVJPFCnTgAKblwXQqH17qmmhpIKFimwnb3cnqpfgj7qbhfBMl6BFE/YZ4g7c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVJYdklTQzBLc2ZCY3NNdnFobW40NlVrYytiMTVGMDJ4c09SK3NNQzd4ay9P?=
 =?utf-8?B?UHV0SEZzZ0lkc2xrVTVqdHR0TkdQa1IyREhWTTkzYWdSMGlZNGlWOUhMZ29F?=
 =?utf-8?B?a0c5MDNWUUMvalVGMEJnamlQWUN6dWQzWHU5UE9Fc2pFYWdHWTRJN3RwRmNh?=
 =?utf-8?B?MEpyNFgvK0xBY2dVYVBQTks5bVgycjlzS09ick1ReE1UTUQrVkdhd0NBRjRX?=
 =?utf-8?B?aEpYWmV2UmNtRkN1cjNaMlV6K1pMM2JCd1A2eWJGL1JRY3FoS0E0M09wSHh2?=
 =?utf-8?B?bmdMamE2bHBobk9JMmdEWUhKRGIwemwwNTBEaVc4bzU0N3NOMktrSHdBdXdj?=
 =?utf-8?B?UHZEOHFYZWlLOWFING9HMlUySi9rbEFzQlR5d0V6cTVIV1hwMjg5ZiszQ0RT?=
 =?utf-8?B?WVgybnoxdlZsaXBaZ0JZQlUrTE1Cb1lPRmRJaFF4Mk1xdTVGb3RiR0FuejZJ?=
 =?utf-8?B?UE81ZE5jQ3ZiMHFZS0x2MnVEQzAva21UZHhWMGtPQTJla2pkMTA0TVI4M3ZE?=
 =?utf-8?B?MXIxUDJMME1Eb3RZSkdwUXB0andza2dyajkrY3NmWnZud3pTZnJPVWFxMW1D?=
 =?utf-8?B?YVE5OEIrRkVqdU0ySnRmRzZIZTVzWm5UWDM3a1hETHFrTmNsYm1lZEM1Rmt3?=
 =?utf-8?B?Vkp4STl3ditZNlQrTXhhcCt5YWNrUUFPb2pZQnhQNGk1Z29aOWJ5ZUw3aSta?=
 =?utf-8?B?RFlKME5EbkpYUjh4RTAwUXNQbGloNDZCcFZ2dGhvUkZSYUJCSUljeVJ4VjBi?=
 =?utf-8?B?VHRWVldhYVQvK3h5L2VyOGZ6QmVwVXBDaTB1eEFYVVhUcDNLOTdUenJTY21W?=
 =?utf-8?B?MG1kcUxrSjQxNjU2a3Z0dFVWZEZseDBsc2VQSWNXdWpGdDFBUmVNWGVqOTEv?=
 =?utf-8?B?KzVDRWh5YlU1QzI1cUhFSjlieTN2STZjMTJ6TWhxQ1cvdG1OY3gwLzBaNCs3?=
 =?utf-8?B?Uzg3Uys5MWZCVXZ2UjZBeTk4Q3V2Q2duOWJGb3NiS2U2NEttWWMzT2RubGR1?=
 =?utf-8?B?T1oyaDNoNVljV0ZlYjVBaEV2V2NBTmkrcUxNSWdZN2xvOXZpZ3dKWEpTRitm?=
 =?utf-8?B?bWJTTG4wYlAzekp5UEYxak5DdnM1cVlxWjhkQzBMSVB0b00yalVjbWR5R0Mz?=
 =?utf-8?B?Vjd4NUJhU2FjRTNzMjArQVlEM080Zm56c0tudDdMRnFJbnRNeUtJOGVIOTh1?=
 =?utf-8?B?WWNuOTFmUDk1d3RzOVc4UFhzakxpWW9rNE9CTFB4VWI4VDByYm4yYW12dDYw?=
 =?utf-8?B?MFVmbVJ5TWdRKzBoQ292THREbzNoVCt2V2haOXJvNVpaUmRacVZhdU1kY2di?=
 =?utf-8?B?aFdnUWs5ZnFrNnRNSzF0eitjVldRVzlUQWM3UXhKVjVDZkQxNkhtMlIySnFC?=
 =?utf-8?B?K01BUnJ2aVZrRHh5K09aMVBUTlFqK1o1MzdFemlPWGxTWW1JTDBvMjBBNXVK?=
 =?utf-8?B?eXZLVC9WK0U4TlI0QUF6V2Q1YXY0WE82OGFVdTI0SWVyWVVSRmQ5TUFncWdn?=
 =?utf-8?B?Uk03WjBlU2NJRkE4aVRhZUE3VXNudnBQWHd6Vm94bjI2NHVWL2MzNWo0cWQv?=
 =?utf-8?B?WkhWa2pIM0pwTldTeng1L1k0R0l4Q1VteXpwYXdBanRaUkhjeXMza3F0dHBu?=
 =?utf-8?B?UHFub0d6MW4zTDI4ZXJ3UUE2Wm9Pb3RVM2pLdkpDcmw1WDJkVlJORlZieGFp?=
 =?utf-8?B?MktIMlRwUFVKSGVHbjFoTkVWUndpVVB5bmRrd1RRUVJ3MEpGaXdQVlVZbnJL?=
 =?utf-8?B?ZjNrMXRKeGNBcGQrYWFTMjRWZit3UlRQSDFsWTNoelphTkRLRHpiU25SWExI?=
 =?utf-8?B?eURCdUZZclRaTEhrMjRQR3padEZRcFVQYS9TS0F3aWdJOWJpa0lIS2l1N0Qr?=
 =?utf-8?B?TitybzVoSHYzK0RSdVRZdmRwT1IwVlZDZTAyUFhRQkhvMzYxNzdVWmRzRTY2?=
 =?utf-8?B?WGc0d3lDMDdnNjk0amlTR04vYmRPblh6eW1ab2ZnR3lESnNLL0tEUlJ1MXAy?=
 =?utf-8?B?d2VPTXZMc0NFZmJZd3FxeUhjaWdHKzNjK1FBSjdaTjdpSDZibzBqZGZQdDRS?=
 =?utf-8?B?b2hlNnIyU3Q2RjRKMjNTa0pUa3Z6bFV3eWdwSk9RNmNNRlhkVTdPNklISkla?=
 =?utf-8?B?NlpTZTdhNTZCQnkrcE5RZ0cwd3dsYVc1cmczLzhJbUVObnNGWndNelRTVUNh?=
 =?utf-8?B?R2RCUWZJS2dVSDNkY3Z5eVdvT3VDd21SUldkQUw3Z3BBRGdqNkorYmdSZzFh?=
 =?utf-8?B?RWJQUHhjQ1JBbHpiWmtDUWVpd0J4UURDY2hZNDdBS1JpVndSL2FuWlFiTUFj?=
 =?utf-8?B?WCtwUWFJOXNuRWFsU1YvdXI3RGJHeGZwRmZPSno3Y2RjUXlndXFWQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27958fd-5a3d-4944-ec4e-08df1dcb0e37
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 01:43:26.7270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jB9JTpIX6F8unMV7pxGspWc9HbLStCY8j0sdDGFuSXdkOHVMJ7VXa6fwQ58XOsWFYCyip2bORrjAWKEHtC7a7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR04MB12562



On 9/26/2026 3:17 AM, Myeonghun Pak wrote:
> An open video instance holds a plain pointer to its devm-allocated core.
> Unbinding the core or its parent through sysfs can release that memory
> while the instance remains open. A later ioctl or close then uses the
> stale pointer.
> 
> The video file operations pin the module, but sysfs unbind bypasses that
> protection. Suppress manual bind and unbind for both platform drivers,
> and warn if core removal ever encounters a live instance.
> 
> Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Reviewed-by: Ming Qian <ming.qian@oss.nxp.com>

> ---
>   drivers/media/platform/amphion/vpu_core.c | 3 +++
>   drivers/media/platform/amphion/vpu_drv.c  | 1 +
>   2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
> index a0c58ec97a42..2e8e08e05de7 100644
> --- a/drivers/media/platform/amphion/vpu_core.c
> +++ b/drivers/media/platform/amphion/vpu_core.c
> @@ -696,6 +696,8 @@ static void vpu_core_remove(struct platform_device *pdev)
>   	struct vpu_core *core = platform_get_drvdata(pdev);
>   	int ret;
>   
> +	WARN_ON(!list_empty(&core->instances));
> +
>   	vpu_core_remove_dbgfs_file(core);
>   	ret = pm_runtime_resume_and_get(dev);
>   	WARN_ON(ret < 0);
> @@ -846,6 +848,7 @@ static struct platform_driver amphion_vpu_core_driver = {
>   	.remove = vpu_core_remove,
>   	.driver = {
>   		.name = "amphion-vpu-core",
> +		.suppress_bind_attrs = true,
>   		.of_match_table = vpu_core_dt_match,
>   		.pm = &vpu_core_pm_ops,
>   	},
> diff --git a/drivers/media/platform/amphion/vpu_drv.c b/drivers/media/platform/amphion/vpu_drv.c
> index 2cca61f41bea..9c6f32c5eae9 100644
> --- a/drivers/media/platform/amphion/vpu_drv.c
> +++ b/drivers/media/platform/amphion/vpu_drv.c
> @@ -205,6 +205,7 @@ static struct platform_driver amphion_vpu_driver = {
>   	.remove = vpu_remove,
>   	.driver = {
>   		.name = "amphion-vpu",
> +		.suppress_bind_attrs = true,
>   		.of_match_table = vpu_dt_match,
>   	},
>   };

