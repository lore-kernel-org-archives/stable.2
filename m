Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794944628;
	b=YTEKxTLmNoGH5c4xdo5Hq7Qr5s4r1xjaey41hQnBtBRuFVQ28VgbUWgXleRJP8X4aTs3
	 dg/uCvSRQwuYfMc06r9nADJPnpMrbNn4FBQQtEp+L666jxAW6HC3/eowNUtS9CZ+In4x+
	 NXsn7s/6DVk9YOaIG1arjFKrHvizJTXeGWDtN2AFlMzXobFNcXVjTn6m2UCmi0Rd0YTRM
	 xe4weY/cFOBQLhwycMNmD23GbwMTKfavDHS+5Qon8qZLsCLeF3r/gQJ5uIKjJPG6i5V0P
	 ohG94I/tVZj4kFEbC8vD0NUpc9q6hVMnZ631Iaety3gpHyhFr/lBETsN8GljKczg7ig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794944628;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=K9xb7ZQ0srMLZ4Jhzai5UUxAzKZWHrQldEuGT+UIljc=;
	b=RtgssEoiFDgmaciPicROFKFejemRe5alIBeHFtSbyc/Nnqzr7NQJbfMtIswpTHKvQAm7
	 bF74IXpQ5YLNmIZawCgi0OztUMsJHN9AmozGwGXv/I96NZ/puNrnpy7BqmJKE+QuOBkHl
	 /A4rK4l5dcWB+isV5h2kYponZx2YV097jqSp2pAZZCc6RQzoBtbLJtnpwhLR4zdRPQHKd
	 DlMfcjfywKU7qZRrY0R2S0Sv/b4MiO6AeWl5BlQfmIBjf4lpN8dsIPp0hS3yVqyYe0/mO
	 cn1nNUJq0owKF/JZ4fmE4wcSa9C7dLYiJTUdLnZLJnHpCSTnenul60Tztu669q9uP0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HkJWO89N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.34
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010034.outbound.protection.outlook.com [52.101.84.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E23606A32F;
	Tue, 17 Nov 2026 19:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31E23606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HkJWO89N
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPDRSGpW0mZXm+TnyTqcIrcdRvgWijgXDoEZ8FhEe5ME458N500IH8LG/6o9jjcSmi6Q5RD6h7OPhNqofuFFW9CMoNNqiJPtMrZtjeZ2/5zJYvBs73BLtB9orYGgbB9CjCXIqjT2YCkc+UwKEtnzAoaXuXqXblV49PYBUyQ2m9xjCHoiivLVK7Eqwd0yNRC0npJBeO6ycUSdGj87LYkRjPicYPRKRDD4zUbjQYz30Blp9Vx6iHO+g16csFZIBvnLOG1WIwNBTFbyu/9dHdEmN6RGJoHL/VPMgPw+cDbd6M7Wl5C8xPFG0WQzUKBlxz+S+JNIcRYpvnsQzN512CuklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9xb7ZQ0srMLZ4Jhzai5UUxAzKZWHrQldEuGT+UIljc=;
 b=m9HCga7+d4O3Ldb1ugJM0o0hNWb8c9s8u8ZGk0zM/lnL4sRwEJs1xk93j2af3r/Ul9fqI2wDIiL+8+exQZuhBdSnI4kOZ47bz+daR6w2uKMthw6QaPoT8vZI+eDly9MOmMXCSHo5oRP5+79xbXbvqPsRmcVxQ/uMpHFF651kRO4Ezpz3T3Kpx+9o4Ierf4emoNJxU9zV5oDjo9RkzwDx4jcgNKwK0vJIte++wnZqmWY/TITHExBtP++eIFbUeHKHYRadihjtJWeUw40izv9upTpNgMygxrQi+XVGRu+ZNO5KRicjvY2HS21PlcDEgQuP0AMu1Wibi1JSEnkSqyfUUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9xb7ZQ0srMLZ4Jhzai5UUxAzKZWHrQldEuGT+UIljc=;
 b=HkJWO89NeSWEXMdu+972gNQNSXjyEOnatDww51ofYmrnuSqaB55Ex9rbMZNToqaOxnWVqZzXrtWhTw+jV7Q4QoszLSUrpJHLmm+edpSdLxf7zClgDuUUlKHy3zeBukXdmE2bfzy8afd7bcd2C6n+rzahEk2WVqk+4x9o4gKAv+a2Kc+cmSUO2GfffQ0+03vA8AGCATxjxjnInaF9j61R1P7JDT3LzNlsP4nYTNc+iOLxV0nxVIRmIB+0mQ22GHv7fSwM5L7jfalwXa9/SvD5OUeNGxXKq0Ktx1YjkH7xT6SfD91lUQFtITFENIgQRtZNyn/jPuUBqQsdFO+ZqdEW3A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV2PR04MB12191.eurprd04.prod.outlook.com (2603:10a6:150:33a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:43:45 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 19:43:44 +0000
Date: Tue, 17 Nov 2026 14:43:37 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: Xianwei Zhao <xianwei.zhao@amlogic.com>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, linux-amlogic@lists.infradead.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 06/11] dmaengine: amlogic: Destroy free_wq after
 devres DMA device unregistration
Message-ID: <avyuaSzbqYrloiNp@lizhi-Precision-Tower-5810>
References: <20261117163809.622249-1-lee@kernel.org>
 <20261117163809.622249-7-lee@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117163809.622249-7-lee@kernel.org>
X-ClientProxiedBy: PH0PR07CA0098.namprd07.prod.outlook.com
 (2603:10b6:510:4::13) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV2PR04MB12191:EE_
X-MS-Office365-Filtering-Correlation-Id: 723d0de8-7354-4a72-7b6b-08df44e31745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|376014|1800799024|22082099003|18002099003|261009223027099003|56012099006|11063799006|10067099003|4143699003|261102123227099003|261021123027099003|261028144727099003|261022075727099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	tgXVdAgAvJcnMMrNV+TjoZozD0PYwkPtasGlzP3G8W6XjNjXwbgI9YVpTurPkJ1HDPQBWoYy0TP9aiyhZZS7T3Z50Pz7MVksoIdAjCYgqcJPoMgxLZ2nOjXY4TvQOnMPrMBikkjhDmAQ+wJ4Vhw1Rrp60F1MqwECPvG8kVUH+NlDyk3Pok/G3l6e8CRNx0WjpNKRu+iZLVP3+S8rBynZPz8BQstQdFAjW7hBeqPXtEunJdhURRySiw8inHD6o/myOfTnQR9gBQAnIlvC7XRWjgxXZmZqGteH9UrwgigpMsQK2quiMgBifqfYVbUa4XYg0dj409Bvoq9LWjhzuQuay8hagwDywewi+ITfGgElzzD+X7fyBRzgcC8iuxlZa+1eXLgwCQn8YLKjmAts/ME0/2T3J9Gn/tZAvQrZDwj5Vt/tQFmNe33CSVwcDagzsFGG1SqI9xVlJIJF9vRKNRHbMpPVkHERZ7sv+BXVhmQdYb8Ey92jPFYd/nmw/Rzgft//u1jB7CTyVxKNBVATDTo+3IVtwZOfod7UiORXRfUFoybhAJcVFDbnBV/l8n2y4KroFna1aop27wN3gx3savrNqFnq1PcGLIc1igHcWO5slNA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(56012099006)(11063799006)(10067099003)(4143699003)(261102123227099003)(261021123027099003)(261028144727099003)(261022075727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/kcihJ7x5lEr+qMqjpCsywTzovXcg6rBnOkyyI/Dz8exd6LqRsmVfg7brlKN?=
 =?us-ascii?Q?8Dp6h3FTvtgITJrWJ+qhaatMp33BFGznOmi4d62yl0epZFUWt3YWKFY4Y0mj?=
 =?us-ascii?Q?K45c+lqZZkddlibBavyA/2y2fBPPkD+TZEmvN3eDE7PZyIj8zIriHKaFY41/?=
 =?us-ascii?Q?yw600gBYldQgcHZNNo890ZCZ56+31ZSTyVNsnt4u2Ft8dy+hF+pH/M1iiXCv?=
 =?us-ascii?Q?avHH1wTx4t32hFT5Z4xQtVHjA7C/6HRisTgvkZgtCK+PB37XwLSXwextDINh?=
 =?us-ascii?Q?DtDO/RJ/f9SX+FjWN0h9t4xjqXWXR6eG7jP2sEKDS53GSRdpA8hpJe0LIrPF?=
 =?us-ascii?Q?z25o7OiFg9F8lC7/30vX4Fvbn9MD1LDl7wSUeYKn1UBUbL86WMQW5M2frDxn?=
 =?us-ascii?Q?Xk/Cu0+C6G1aA951JYkA+QuAjEROxa0RjT7bonoFmFFNYkLwfg3XFd4m/+Rs?=
 =?us-ascii?Q?IRLVmOjaDtLe6Ub6U4mTuNC4cw8idmvOfzjMjb7kyKAGUcRLREmrgCdOIYFA?=
 =?us-ascii?Q?KC+M8VIq0g7lYOKAJdMYfZ1dgl+XhG1J9ZuEmfXzmsMGkfgldy63YE0ZJ8jm?=
 =?us-ascii?Q?2mjGodvT/LNKM4Ug0jKO0aVn2CPO/H6mxF/pewwThuT6yILv4SOMrJ0CDonc?=
 =?us-ascii?Q?JSXcDPS6RY77EUHmjrGdG+V2kWVj6DkbZt7pHpRV/jMqzhJ82RWmaI1KJQcZ?=
 =?us-ascii?Q?iDRYCOEWClspopVa7RCpIPCzctMZbcnzcGs0PmNofAiK3KRcJIVUncvrelDj?=
 =?us-ascii?Q?72f2MMfNHpjFcnSAO+bomxr/s3iumL0hinfcrsCQ+shJVUPTL+/7dLwunyCs?=
 =?us-ascii?Q?jLaJytLZfmNLfsyMqEiMUgDMQUu+uNX2mCbSfVLSTI2Ck7SKLizZCdNEMEKo?=
 =?us-ascii?Q?SPfQO9OqbUwNJQYjXmo3aV/I4JHChFTJqeUKF2GgNoLmEtcAvm0DsOVOF1d/?=
 =?us-ascii?Q?FQq6udo36R7h2AQK4PD/xhUccYlStfHUKeCVtRRuP2MocBQCo/Ye6YAsPww/?=
 =?us-ascii?Q?DvxiRivfQdVf7KJCdJSlWsqSmx2u1d3yqr5EXnm2dhWk06wYyHG3oOvCjv9T?=
 =?us-ascii?Q?lrS2Lc90Z5qzxphT0BvDJ/UojtV62qkZkcGqauZMvfuxe/RIvrTAZF+6LU2T?=
 =?us-ascii?Q?jqs7DDgJl/8cfe/zhQUKjZCzEr4wU26Hh1m+9+/jdoKew6rfW4Fgk5IdVmgb?=
 =?us-ascii?Q?kBKGJ+ugV8GUIM4IpvJzTw7cuPcD6THazfE5jY+hxZITlb7BPwAXGlbh/sqV?=
 =?us-ascii?Q?GgyMTadN0pIs/K16RPLMoFJ+5amcus+cQy1fZP85Vxn7jDYizaH5R0Jr/hZ4?=
 =?us-ascii?Q?Si0xJ2b2SEHJBo2clNVylEWOe2Q8GFLZ/EcFVvRi9ptY3EDEQfgY4FhYIgw+?=
 =?us-ascii?Q?blRseQ7HhHUknkg9BRl9pwfZ+d0EbUEiuGzTOEZ7on0jVrIF6G7U917yYHlp?=
 =?us-ascii?Q?93XfVTZbtLAOL9wfRtFSF7pVL70pPI5jbKUy8w2NQq0lBkiBt/hpuzOPPZBf?=
 =?us-ascii?Q?jS7WdRFvVsfgNhZMVmmABj8L3JM/V62pcTyU7eu8PhscWQFXEC5gM8pvbsG4?=
 =?us-ascii?Q?dy61W5T4Bw4fZ68pCRQfJVz8XAcS0EzxxMtAVwT4vDlKkfej6GhILEwpzOsQ?=
 =?us-ascii?Q?YPzHr0Tyf2rzm4bWP0yE9iATOacknwuaKH1xdZ5dMutHPAUYwnJOhXNjjavV?=
 =?us-ascii?Q?hpUZLtEZRDkmMN7Ox5TELMtMVum7Zy9eN0C+X7UtNBDq2Z0ytrKXXAlkY9xz?=
 =?us-ascii?Q?zCT45lRF9ODLpzHoKB7kuHReEFC1L/b+l6I8GyvQZqV2daJIJ08u?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723d0de8-7354-4a72-7b6b-08df44e31745
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:43:44.9159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTIqKg8EU/raKAU3ijEjUC1lsHxAjq55aHaFKiloAzQAhujo4SZ2UKGKtbuz+l93VvhM8GeiTLsEVaTDwB/++Ubjv46W94dk+YxiS5LNhX0UKWRjv//lnfZANfs9mecH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12191

On Tue, Nov 17, 2026 at 04:37:07PM +0000, Lee Jones wrote:
> aml_dma_probe() registers the DMA device with
> dmaenginem_async_device_register(), so dma_async_device_unregister() is
> deferred until devres release after aml_dma_remove() returns.  However,
> aml_dma_remove() destroys aml_dma->free_wq directly, causing
> aml_dma_free_desc() to queue work onto a destroyed workqueue when
> channels and descriptors are released during devres teardown, and early
> error returns in aml_dma_probe() also leak aml_dma->free_wq.
>
> Allocate aml_dma->free_wq with devm_alloc_ordered_workqueue() so it is
> destroyed on probe failure and after dmaenginem_async_device_register()
> unwinds on removal.
>
> Fixes: b84b5197e344 ("dmaengine: amlogic: Add general DMA driver for A9")
> Closes: https://sashiko.dev/#/bug/linux-c216084a-f89a-48d5-bdea-584522d1bdda
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> v1 => v2: No changes
>
>  drivers/dma/amlogic-dma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/dma/amlogic-dma.c b/drivers/dma/amlogic-dma.c
> index 684121d13fca..791bd82743d3 100644
> --- a/drivers/dma/amlogic-dma.c
> +++ b/drivers/dma/amlogic-dma.c
> @@ -620,7 +620,7 @@ static int aml_dma_probe(struct platform_device *pdev)
>  	if (!aml_dma)
>  		return -ENOMEM;
>
> -	aml_dma->free_wq = alloc_ordered_workqueue("aml_dma_free", 0);
> +	aml_dma->free_wq = devm_alloc_ordered_workqueue(&pdev->dev, "aml_dma_free", 0);
>  	if (!aml_dma->free_wq)
>  		return -ENOMEM;
>
> @@ -712,7 +712,6 @@ static void aml_dma_remove(struct platform_device *pdev)
>  		if (aml_chan)
>  			tasklet_kill(&aml_chan->vchan.task);
>  	}
> -	destroy_workqueue(aml_dma->free_wq);
>  }
>
>  static const struct of_device_id aml_dma_ids[] = {
> --
> 2.56.0.679.gc527c65306-goog
>
