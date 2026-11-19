Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795104499;
	b=a9aqMGsNsJG6vlYfAADhw9AcOQScf+ovtGvocN09mzHaT8uaDYUURAiq7U2MQ2tCT2PZ
	 reWWHkgxZTIBAS/HMY1oe8zhQb2F2j+NWaxXN3j3aDNlL+pRHZXoKuzhZ2NIqjmqYom/9
	 kYhSeE5o6Yg5k4zajnUZYMJ08D4O1FRQd/qqDG/DVfPWYhPwhq+T+PAbkbNRCBPYutV8H
	 RHBI3jPwuxf6T2xlhByHv+abkD2tUk57bAI6KcMKxFEA9BpAkNA1wLqm3WE7v7m789ujh
	 c4MMOwr+qoEJTipQIbXFSu5Jh9LQpiwKdvCK9zsyl4SMxGjPt1Kq9wFpT7SVnWtt9Xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104499;
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
	bh=zFgJjDdOrc2yLV+ipzuoFDHNUbmQv9wBPp75ZrV/ubM=;
	b=Kr4PT2hjoQjqPL1m51/ybqH8uSNV26zdmJMfnWmAZTyQf+UUg+usw2mdhdmKAwpx5ksN
	 oFZGZhtIGVznQBm6JbMn7gI9Z7+aXcimmS7h8ZEgONvdC5DqxU4uq3Qz+jyLYkJAkQLmA
	 yaSMo1vq8sdO47ujK7bmnVdZp9xCAp3M4eYi/j/f5hSzgaY9Tm++MTZ3Djt/ZrPUieptS
	 POKl0AFXlO/TV/RjitqijnFNG+kLqzBYsOHKDzfEgGuXs1jKe5MjpWiKS55zh+bbexFZ6
	 mh5IoTIgAB3t3vvX17Ew14Yo9THTKpSEmuYYYxTBgENVfBEAvuFwZYysrmadwdH6qKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="lkLk2/sy";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.15
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011015.outbound.protection.outlook.com [40.107.130.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62285606A32A;
	Thu, 19 Nov 2026 16:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62285606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lkLk2/sy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulpNM+VKjuLeFVB3Hbx9jHt5FwqDgDdkY3LZXLEfwqkw1z4de0w1hF6L7SzvvS+BfHa5B0QgemoG69l4jFkCxlLZFF5fQm7zYHFQcNShbVowcnAK0D/ZhEMg2Mi4tRrIwsQhKTvaztOK0N8RXswiSfSonSt3cHo7pr01m2O5iriuWZbWCGPJJ8Gl4BDrUD9zWIxSSDaioWJCFFOVNOKxLjrlkys0UClPT2/aS6soijcWXbk+C/wqi6pArCJnfu23wWgSILlvj8Qioq8TSekmgmbZBtVOZ5VS4TzZRq00Wmh8/rHQOCswDgs15saCCGIEE+OafZjIEeS20L8M7lBOOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFgJjDdOrc2yLV+ipzuoFDHNUbmQv9wBPp75ZrV/ubM=;
 b=Fawjor4MMI+0wd6Oiaa+N0NFaAYlTiqBeqN3ye0wJ+TMiIqMk9vifHMGDD+GIB2uIjz/pXtPH+aTe+A0jem1sECahhDPWcyTi/8xw+ToqRFv3/nly32tOuqb8vRnaP6RujWbbrW8P37G7wH1O2sI23TrdJsehb4JEN3PcVSGzEUcMlscE+lZ7tARyvu4YsTRrbzHTLBLv8McWnL2/b8GZpHZPVIGm6Me0aSJNMq0RrentdFGT0wwEWMa62WgZ+U9y/zWhnYOyOo0Am2x432pikOyjXsLrWTKjzd3xPaN/JNGtBWWfiuQ51fYXay8wZHtVUCbs3T5q2T4VD7CMqfQlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFgJjDdOrc2yLV+ipzuoFDHNUbmQv9wBPp75ZrV/ubM=;
 b=lkLk2/syw/CFePNaleNX2SfayVSweY/CQvI6XDtY+HWMN/NpJpc3DAaCB86vwp/jO1CL3PAGdmd1do6YvoN0etR0ApYJ9k+QxDQpE+/PAxK4Gd6UcLAZaEo5o7lMbfOcjHk02mp7vrT/Ncil6vHifRWeV1n63qQFgKzAhQDijz/bBq8wmxreRLQPcMlyA9oOtrOgB0ZFkaijPUgw5QRbusSIR//y0NUjsZUGg+S3+Z4zIAq0NFLNSPI1OlurlOCeU2zgU/1w2ZuW0gFynEwMRsPzFrFdkRLED4aixxR8P151SqOxEgOlypja/1lzoOYUkTpIzws0crd2LLgUALYLUw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV4PR04MB601625.eurprd04.prod.outlook.com (2603:10a6:150:411::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 16:08:15 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 16:08:15 +0000
Date: Thu, 19 Nov 2026 10:08:04 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: lee@kernel.org, maz@kernel.org, andy@kernel.org, jic23@kernel.org,
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
	mfd@lists.linux.dev, linux-iio@vger.kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, crofts@kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 2/4] iio: adc: mxs-lradc: Fix trigger use-after-free
 on removal
Message-ID: <av8e5Arl0INpsv8T@SMW015318>
References: <20261119134041.16611-1-festevam@gmail.com>
 <20261119134041.16611-2-festevam@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119134041.16611-2-festevam@gmail.com>
X-ClientProxiedBy: PH7PR17CA0023.namprd17.prod.outlook.com
 (2603:10b6:510:324::24) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV4PR04MB601625:EE_
X-MS-Office365-Filtering-Correlation-Id: dc204fec-44f9-4e57-d8b0-08df4657516d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|23010399003|56012099006|4143699003|11063799006|261021121427099003|261021123027099003|10067099003|261102123227099003|261009223027099003|261026140227099003|261022105027099003|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	21GNyGzyJ1lR5JoYAAoRmIcBIFdApcgekjvSdYD7wG9FNEnMcAzP2VDpmaY7obKaXpXA9XME206b51moQd6CqunvbQ2xx7nf1xP3Y44KZBYkpGYE43ojcURijx51ph6rxIjMtZuPweW44GxKFt4fkUVg+GonmiMCR60IdCqEFeMJ9CXAqqgOazyEfcgBDpXpMMS+jGxz5fpDbXUHtn4Qkca+vm+oz5X8J5VQzF3uv5nrIc2zhxCAUnDenLuEzgLKuOchAxtGKVTBhJdOXmxaeFxzlXgOcI+S8h48TTEZy+zcpwq9BtkbMB5Nt7Rf08JJHrbu92TmxGVXtRbfOMAe1DJpLu4JLoqlIlvbYN/buD+EYRsg0VDQuLEzR97F3xVeAFRArT0pXzw0Cr5nuCEe0U8kkF5u0S3IgoafXIigDsHtsGFoNWGivhWCVFi1jBfpy1PZ046tuQ9N3AHEAOHv40bRMPiohIldq1hF/Oo5erHtdnrBC2OKh8x6Opzz2o8o36RCLaes9I5nFf+NhYGI/OWHjHpLFFzQBnzbcexGJEPRG+4HlV6lejvlKJi5eu5aYyFbHLWOdQMO2FXPbON+R07VE/ZIDaG+/axkoi1ckBOHHeFxGBQdfwsBg/E8n4tKgSf40SLmNcYgoravO1eCC30E+2lM/DHH+COL+kJvqZk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(23010399003)(56012099006)(4143699003)(11063799006)(261021121427099003)(261021123027099003)(10067099003)(261102123227099003)(261009223027099003)(261026140227099003)(261022105027099003)(261028144727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QnObOy75s+VSoR7m/ABkpHQ1Q8VLaiwUz9s+O8Z1EhjskdDaeuAj/FNxU2gC?=
 =?us-ascii?Q?sSftFu6sv09f7Juu/syDB02IZ83ie11RafNR58a4zKMQexCJnESwG7gQYjpe?=
 =?us-ascii?Q?W1KKjLngoAdshxv+d9v13K38U1RnyNhcHw7zH31qC8SiPvTyG8JUGbv0PXxP?=
 =?us-ascii?Q?goLyyHJHakU2deg+8n2S9S/B5Anw54OBM59d4UljC6MIplzr0HvrtNhGOAK1?=
 =?us-ascii?Q?9GDVuw5uWB9Wt+ZYDzxg5elbDXsy7czO1KyIyhFXuqVaDpUjcTXJN2dEwW1y?=
 =?us-ascii?Q?kUualNRZ8aJdpMLKBeRAXSZWdawuh3hWHAjfD+opflDRNNEW7htNuuMEEWDf?=
 =?us-ascii?Q?KkkiF7kbHEf6gEzm+OS0YKe8g7rDNHd32/qtIVIfyOTb6iSUK34Z68+I6smv?=
 =?us-ascii?Q?dT7tw5qmQ9BjWw5yelMX+5q7ywlBUenD5CD5yXf7HbTpHA+GZehRwOQoWvdM?=
 =?us-ascii?Q?RAhb+nD9oH5+du7HLFfmzjgk6uPTb+36aCo5aRrOlgg6+bhU7ATyGfC1nnd/?=
 =?us-ascii?Q?6yUHpLA4ChC95EChoPACqIORoS/rq8qbhKfs+Js/XW2T5xxugdZJGBBDs+RB?=
 =?us-ascii?Q?7asi0xE3vDdR8rkPfs6o5XNzTZ6gSl9stZhaOwV+oD4A8Ue7YGSaia8FeRnI?=
 =?us-ascii?Q?5ktYh2R11zIXClu3736TtKNZIzDDgteat8eTIQ41JMltl0f1XFJrUHOT3Ng8?=
 =?us-ascii?Q?z6mMwbwBX2D+jaUFYogDS7LITJtZOLucZt6GQec3AGkXtYaVsMK5HK4GcrrO?=
 =?us-ascii?Q?Ed9ncc0Bp810Giw4C0NHSNTNP3KPisUSVwK/JJFdKj2HyZEVgReHMvTQopFk?=
 =?us-ascii?Q?pXoRZK5ysdLPFWgDBPWKrnBf+XzlgjUMKaL7DEX7eA+Vlw67BWSloVpcDkap?=
 =?us-ascii?Q?RwlbsTZxs5vIRjNxAETuc6VYZdPcVVwFR1zBBcQZoo2OsMDbguaT/cRqzfNd?=
 =?us-ascii?Q?7lscKE2liXqAV8dSzkMh7Fm6PzP9AdWkb7wFBEFpnCSXsXaNQDFY/G7wy7EK?=
 =?us-ascii?Q?+EHsVl0/JbZBlZyb9HvC15RGSeUxCBZJVsxfB77Bg6vSCPc2OpxwGLKWSd7P?=
 =?us-ascii?Q?5LVvhYL3uEKqNtqAWgWMHrS2sYVOT+rn3zpJT4OLa3pR6y505UYa17PFGOEd?=
 =?us-ascii?Q?6562duRcXvtPxhJZlaqiUvZ6kQ+mSTa4YEKEE8NcHtKQY6Emv7/QjEGiLAE3?=
 =?us-ascii?Q?3B+q9H8qOgDQEpcgJjeH2ucSmJ3vFDWNdJjwuMy1dwRcsD9L0V14PIXqqHqh?=
 =?us-ascii?Q?Nl3gvYClN47kIZnU9l6s/O7ly35W50WB/7y7fhlLgEByWwr5uy3GxplpL3vv?=
 =?us-ascii?Q?ukmWHTORF6iYHO+HF/a+XeppyRosG3MSFeuuggWuPRRTWxcGa3CzLRluWwZO?=
 =?us-ascii?Q?LMLKPN2MAqwWz2j2TEBmZzreiHrFXZkY9t3QZFqnQ/E0bcPWT6cODub2D2an?=
 =?us-ascii?Q?pRccQDbJyNgPZfPi8xjtvusnWG+zA63BAaZLqpQeQldd66V3UzJvp+h+YoZo?=
 =?us-ascii?Q?ioo7KsPp14LtuNVynV8Lm6kJ0RqLQ/9KlSthLXwQ9XVFlSP8GrN7b+c7iIdL?=
 =?us-ascii?Q?yGL+QcyTgF3Y1VyL2Zys8qsFzm8K4H8lSL2cj4wv0GRwF7eDLy2NABlQ2TIE?=
 =?us-ascii?Q?jkurssJwM2g2ukKKov5mUmvSZCksmVveJjs65u7PbIeXXGwmQmPS7V2/ik9z?=
 =?us-ascii?Q?roet2w9IZlLvZk/QJpPFg4RRd3ySv3QrQ4c5Gy6i3noBI2p+jYaJUKBabQoj?=
 =?us-ascii?Q?ueng25cxTRyBN9qBnCseN6drjuVWfdvJGmAA4iSwsGW6TeNxDm3+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc204fec-44f9-4e57-d8b0-08df4657516d
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:08:15.4659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjyLd+Mc+0UeZ+ZsvYlex4ZuFG54oYNeujVMKRgcK12nSzf2dTVYynC8FXtYjR58cngwt1D2x4bPwLaGpUtCgEFOS22uN2XpMbLT8JdKmXf4J8Xf8Wch6x05vm83QQxh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB601625

On Thu, Nov 19, 2026 at 10:40:39AM -0300, Fabio Estevam wrote:
> The LRADC trigger is devm-allocated against the IIO device, but it is
> manually unregistered after iio_device_unregister(). The latter deletes
> the IIO device and releases its managed resources, freeing the trigger
> before mxs_lradc_adc_trigger_remove() accesses it.
>
> Since commit 699fb50d9903 ("drivers: base: Free devm resources when
> unregistering a device"), device_del() releases managed resources.
> Consequently, iio_device_unregister() drops the trigger's allocation
> reference before the driver unregisters it.
>
> On an i.MX28 EVK with KASAN enabled, unbinding the LRADC parent with:
>
>   echo 80050000.lradc > /sys/bus/platform/drivers/mxs-lradc/unbind
>
> reports a slab-use-after-free in device_release_driver_internal().
>
> Allocate the managed trigger against the platform device instead. This
> matches the trigger device's parent and keeps the allocation alive until
> the platform driver's remove callback has unregistered the trigger.
>
> Cc: stable@vger.kernel.org
> Fixes: 699fb50d9903 ("drivers: base: Free devm resources when unregistering a device")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> Reviewed-by: Joshua Crofts <crofts@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes since v4:
> - None. Only collected Joshua's tag.
>
>  drivers/iio/adc/mxs-lradc-adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> index dda5182a5076..64dd3a9995ff 100644
> --- a/drivers/iio/adc/mxs-lradc-adc.c
> +++ b/drivers/iio/adc/mxs-lradc-adc.c
> @@ -454,7 +454,7 @@ static int mxs_lradc_adc_trigger_init(struct iio_dev *iio)
>  	struct iio_trigger *trig;
>  	struct mxs_lradc_adc *adc = iio_priv(iio);
>
> -	trig = devm_iio_trigger_alloc(&iio->dev, "%s-dev%i", iio->name,
> +	trig = devm_iio_trigger_alloc(adc->dev, "%s-dev%i", iio->name,
>  				      iio_device_id(iio));
>  	if (!trig)
>  		return -ENOMEM;
> --
> 2.43.0
>
>
