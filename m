Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDED12D1F1;
	Wed, 16 Sep 2026 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574751; cv=fail; b=GATWkrg2HORpYc8UBE/OtihkotZbnjoNaxBnEszCyoCdebVjP3BnczSQJDpWzhq4rVYhxbYS07NM9uCSfcq2kPgyEOyEy2taccg/kNZzWQoQa3NWlaEyNK07W+IAWK+p2129QI/TBDJqs3iU1Ucr4uwXSgijN+i9pEbu++41V2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574751; c=relaxed/simple;
	bh=+si19X+3Yndk0rAcsGeTliJQPjQMZppqARHObWyNE4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pTiSECfexgaIpLHmh6KsdfP77vs7OqK5RM7iRUq8G8tit8TAxFjkqD/xNDNjFoXXO0IjNNIlWT6q17HSgDAr0Q2qu4kzc7D7wcfpx4j0h/N/VdljWXVKrrH/qV8iCBaZ+yzLbAwomMahUU7V9C9rG1Sa4i5Zl8InCCQ00mm+sxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=r/V4+Hos; arc=fail smtp.client-ip=52.101.70.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="r/V4+Hos"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDFFolXSkwcaalhAa2BtD6CxvwL6WLhw/8gfuO6p5FDFLmW2rz1Cx/jjiPyrz8QeSr5wwj9x7h42oh+4+ZpUq8eWr0OWtsT/Y4tHjhTEAxg7Zf/fMxaWKpA2mBVol9c8YxkUyaevTToq+wlVPt/K11prkFK/JVYRkyfIsz+okHdSTZfY7J6/QRegnxXd9a5ZK1HWeZLMkrKO+cJk/ZC43RtJfdScW42aTQNoUpN6fDHQzl0dTEQ7QFIoglsB4JZA9Vil2q3T016+IDZ8d4vmE7VTc9dzOE2R+OFz9kfXUlt+/Yp+pvSUokNx3RFiEAydhyYSgPG86ty9rXVCEW+7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJM1fq1jmU1MSEMgZ17caV3NB2MRXb/FsM/nTtzyq5g=;
 b=PIy4191d2aP2SSbhb+LNz862cuRq1l16PqP9QebIBmg/VNoLsq+H14PPO/DignP66hyYkb+3rVeanzb7kI775uNh8UILl0AbK+Ca9bK+f4Zod/tRPZBtiqsIgctaB/19xFNPx1lzEYY7fh4zZ6Bq2hLDw88D90xMYh2WcHzkaebH4BL7Rg4JBgW7k5IBT1sLPcNw4dTn3YfawpL55HYZp7aApQLOhLEk5NAWGyas3jx1eqAp7edbO+1vkPjLpPDv+pQFEFLVu+xubi4sbv7GDOp1vLcTlKkP8TYUUzShfNlEqPGBFqrpDN2ag2OFLDz0ZlF7bfwmkH2B6IOcQbn5Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJM1fq1jmU1MSEMgZ17caV3NB2MRXb/FsM/nTtzyq5g=;
 b=r/V4+HosaU80SUOx8ilt83Q3CdGWWd6GKhPQ/OI5tXcQSL3L1SgaEs/OeG1MoMoMS88wGAblaKcOSfPTuQppsyjw5Hda/T4fWzE09u0abAFt5Sfs2T5edlBLFrE/UN02xkpoaBOBZje9kqY8Wkr/Djuiv/yx3llqFua0MYwf4MmnglPjgPzCV0zP7QNhmU3xtJp1XY7LN0Flf0K2SMFmbxLRSdURhqD9PNuKqq0/GGsby2LuZBA//BS4HdTG+boZdmoUUIBovU43+UfyLvwNiy29y2gXT2KLK6hHfs2tvNeJOApn1owiVfhFkUM4+e12b8RwDDpxnzjNw+R1ZG9DYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB10558.eurprd04.prod.outlook.com (2603:10a6:150:20f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 16:05:40 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 16:05:39 +0000
Date: Wed, 16 Sep 2026 11:05:30 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, george.ge@microchip.com,
	kelvin.cao@microchip.com, linux-kernel@vger.kernel.org,
	logang@deltatee.com, vkoul@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: switchtec-dma: Fix device reference leak in
 switchtec_dma_create()
Message-ID: <aqq-SldWxcGqF1Ay@SMW015318>
References: <20260916093332.2003909-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916093332.2003909-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: PH8P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::18) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB10558:EE_
X-MS-Office365-Filtering-Correlation-Id: ee288421-1890-417f-a703-08df140c5a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|19092799006|376014|10067099003|18002099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	+MlULQ+GHBECk5NR/AuINqJeZr3ZrGg7u8G477AlLBnMuu+hsZLPzzBEXdIcRDoeFwFtqqAnd/ZhDhCA1jBA+sN8ShE+KCR2sYN5NWwsorQsV7DlUiO2uVpuaF0X4z8OzgoY61ZRstA6UcmKS9XY/KL0tIQxXOnErmfI3WKtTe0K5t6YsIybcd5upL+YpTW6MHsDjKOv3etyFbTCk88XgsZB/QoQ07NaUYBNjvV5snonlFsymagjXJj/I/ncn92HjwMH4xQBNDiXFtKBYqCCA0A8qF/0NuXDQudNy49K3IU91aozu5r9SPU3S/j0rH/Fyq/AbJyxVj/nP9kGtRVtDqQCCuKd4kPu1ksjCZnJWF6jUELLY77mAl6MZY5hBE0/bz3sx5SV/JTwrxa7BCxUNPZO/zIAgTZRx4f3p5y3O8oNwPu40N6p3gM0xcRVQde+t5H7uvFo6xw/T3wrA4PjwTLsPJpNAwZ4oOhiA0BLrJltLiu1oTxJ8pMyI7x1D4hEuBtgcKUTkBoQeRZjw7UN+NMNTRz0ckVM20J0d3kfB0S13yaQM26yDvztWj55y/eV+cTIH+sGX/iRqh+jkuqTAX4lsl0j1pI9V9hTcmAhjKn5zuYA7OinPHZuhaNG64zdp5+rNfi41tRi5rhokR59kHOYgrprajy5G5mZQVWYr24=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(19092799006)(376014)(10067099003)(18002099003)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KVZU7W5wDu6mAO/F7plLHuLS8JFfO93RikyZjO2l7ih5Xv1IXUEYoX4bqwu2?=
 =?us-ascii?Q?mIhFoEGyBIOpQtQVdkaO4tPtkuaK9G5vNk5YkCM0dfqoPq9ihByq+lhxSSUn?=
 =?us-ascii?Q?epjE9TCLxBlC5dIHD+A68SgJlZ5kaz3GzgxynBI9euldUykjPzAQXK448klR?=
 =?us-ascii?Q?a96N1VvcLu8BUCGsN/o4daD8GDWfdPZg43KVRP+ZIvbVa215/yIqYXUgfr7n?=
 =?us-ascii?Q?bh9CegZza3dvkOnGHLwmes+YSG0QhwvtacqJnnREbLAHbqGie4lyD5LmJ0jA?=
 =?us-ascii?Q?DAdLFvxUwmo3PD0nm2/FuoyTw859q/nLKClqg7Cp/1nZJZJJ7ihOUJxGpwLy?=
 =?us-ascii?Q?tEwFYGA6SOnudfGKRU9+ObC+kuN3KWK+plCdbnxlGwyD2csbC44XImn/YIaF?=
 =?us-ascii?Q?pWU5ZF3Nnc+I5YCXTk7KBuqGEE/YOYgwB7mkKMvF6EIflCXZd7cjEKLwMUSE?=
 =?us-ascii?Q?l+HIfbEv/enGp82k2UjNlbw+JoLR5/coAF3NmBEXxpXnYCGoD5LBagTwOmZa?=
 =?us-ascii?Q?NuC6+ZkMJgrDdgOX9VVaxMniA76Ybly5rQdiMaYGqG+n1caRXxT+vg6YzPMQ?=
 =?us-ascii?Q?WGGW1nHGiMS3CBefNqV6ZVdjbldvvdnxvaKJHTTWXHppcPFTB07xLiPOoesB?=
 =?us-ascii?Q?iLxMsMp5otO3MnphBHY18Vf4izzg1QAb54unK8j57w47IBJBtGKoXNk7zCyI?=
 =?us-ascii?Q?mmsY1ycODz03Xqc9xoKIHlgu5Ckd5NRBLr4Rmx3brl4EFNOE/k7uSkRtLEBr?=
 =?us-ascii?Q?sWH+q+xKF0kDBE59+XK/T6zsntk5eHWtHG7mnLqLardrI38PubLSPPJWffVS?=
 =?us-ascii?Q?/7p2GPpc0JjJ+4NtuVDqhX35uiiSJHxMXdGL527r/vhk1pNV48qg+1V7nNbn?=
 =?us-ascii?Q?Nx8EOy4OLUwClZ0xP0G1mooEhTXEKafNnLCpuHo2YSO3aE9FFLkU7W8thaJM?=
 =?us-ascii?Q?Bl0kS0p0T0zPcuNNwTSVO+7iaiOK2E6hKFWJTA8srw4vQtGp7RLa7YThLU4K?=
 =?us-ascii?Q?OI2ykMFv6j4w7/najLWCFLH+y2YZhMelKpb6R0fCiF7zQZa+GUI9HVruFsu3?=
 =?us-ascii?Q?vnQvsoAgVe9ItcuOaCnaXVjoGtXJiEZ7zdT4k8+gRXXSNttQskNLVXHFdGOT?=
 =?us-ascii?Q?d/+muJstYdsQFntpI5/WH0LXavgVBca2VRVsKN5BodMdaUKdo0CvDC5Xytur?=
 =?us-ascii?Q?YMp3wnGreYJqe7BFtekfHV7H7J/XMVA1EegpvrY9vFXeWDArrkjfjlfCiLmW?=
 =?us-ascii?Q?FAwDr5NRQ2WwBWWPm/NA0ZxMXq7oujg54XxNXK73zTWe5E4jzynEqhDd7Yy6?=
 =?us-ascii?Q?BPwn1CjcwvzIqnT7Ya08W10iPwSoIgPlvmojIMkrguKL5S8TmVsIa/i6yNAR?=
 =?us-ascii?Q?QYA91VLOpjsdbpL4HcFWEKcRZeJ7GDftVFUR3jOiYKgejDTOS6mPKpnqXjuJ?=
 =?us-ascii?Q?HBDeLOpVk28KMDLWXM0D8YR2p7W3ehRLQpWWcHq6XTonx18xkcpaP6CRHnY0?=
 =?us-ascii?Q?dynvQXpDTTjqb1EUTSPAUj+mq1q+lGocPOaMpU8GGaM7pWTcBl5U0iGJyBeW?=
 =?us-ascii?Q?677Eh337tA0jcmqefrNBz5EHIXoPvYjghFo6EFpFHw2XnMf8VUZ6elTJoTFS?=
 =?us-ascii?Q?dgeRcZ0QYIyDENrwtFCBK2TctNvgLfM7X/MJJNipXjjKBT4HPOdAUa3iNB8v?=
 =?us-ascii?Q?84abhsk1INDraWNShNGve7ysfCc1rCupANLhETaygjcELUf5rzgIE/o8XivM?=
 =?us-ascii?Q?ANY3/oQPT+nZ3vg582FfX8xzdXGeSTCHZq/aijzfXXRITx8oS6vX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee288421-1890-417f-a703-08df140c5a35
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 16:05:39.8959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61TN8vOYznQ99z/P6sc36yh8aO+nuurrqSyZAWN5LVG/vPmEeYthNaRl0E92NwuyHEsNwe2DPXOuF2LJldGtHYlXOZSJ42LCe0EB0Sv4bquch15GtzaPhqkPuNDRceUy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10558

On Wed, Sep 16, 2026 at 09:33:32AM +0000, Wentao Liang wrote:
> switchtec_dma_create() takes a reference on the PCI device with
> get_device() and stores it in dma->dev. The reference is normally
> dropped by switchtec_dma_release(), the device_release() callback,
> which only runs after a successful dma_async_device_register(). If
> the registration fails, the code frees the dma device directly from
> the err_chans_release_exit label without ever dropping that extra
> reference, leaking the reference taken on the PCI device.
>
> Drop the reference with put_device() on the error path.
>
> Fixes: d9587042b50f ("dmaengine: switchtec-dma: Introduce Switchtec DMA engine skeleton")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/dma/switchtec_dma.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 3ef928640615..b07bdd0ac540 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1297,6 +1297,7 @@ static int switchtec_dma_create(struct pci_dev *pdev)
>
>  err_chans_release_exit:
>  	switchtec_dma_chans_release(pdev, swdma_dev);
> +	put_device(dma->dev);

Does switchtec_dma_remove() also need put_device()?

Frank

>
>  err_exit:
>  	if (swdma_dev->chan_status_irq)
> --
> 2.34.1
>
