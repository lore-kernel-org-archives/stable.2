Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793373413;
	b=kCacosK44rhn3XefwWfDlDsOT8fiFk7UPHSBTmqCuBwshd0L5gpCPhw2+ezUfhDW5YjP
	 P0n6P2SRUQ5lJtoA7TqhBrYnVQ9YnCB6A2tMYZ+Zbc8WQIeBfLntVpuubORErcOOgvj8c
	 8CURHFaX00PfbUij9Zj4/4d1zYJ+Og/qwSBZdGEvGcblT7xWX4ehNtM74Nlm/PnFliI69
	 6BpkJhzIS/6ZORreII7IUWgR+KlNofdz48HVnr8xBz7rUVrcBywIc1OIlLySyF5whGAuB
	 /Zj/hP12IWlU85l+cxm+MYERtjstEYD4+NcXyWGYOa8VKBHaWWjBVSE+b2oJXP0LCCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373413;
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
	bh=FdY1F5DdjPISd9Qg7wQGWOZVWGwLHnKYxLWv6t1q/x4=;
	b=Tsn0JFECkRpyuVRriL9ZdE7DKwApDTIAryHVjwRB7U8I+ETPcaha5+D6ksy7erGrBw5b
	 Y4USJTmswfpK0oS6+BfaFTQLYmgmmctwpI5+0H/tlwgq4qFmeX3Wag4P0lcKMLcaFps9k
	 Bxy9NJ+DemfHMt6zQjzM2zRiBn3gA9VBk/evQu3KzLIEcnSiLFyXdYupe1rbc6DYt5OY2
	 mNPzySaMefkr0UH+75GzcX3TFHxk+QjheDUZ68EFMGG7x2J1G4EtAXTbXrjR/B4QRoeEi
	 7JBYUbnMVLHUjoMvhJWi16JDzC74QKkPIDuY0xcPJAa6LONr6Wzk57C+y/5QvgO+rzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=e9FdvSmt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.8
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE72606A31C;
	Fri, 30 Oct 2026 15:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EE72606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=e9FdvSmt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQ0+B5qzrDQbG2ClxNFgRlmNUawg38/Dc24SET4+Y/GSkMSAsbs7avsU2I1Am2fR4jB+vht0IWFWoHuDO3/K1zBt0zl1bSZDLV+fK1Z8YBWFL7z9bGEGYj6D7laXRRQUFlTEvdC41i12bDJ2I27X0/22WDwq1Qc287jwWSZN971Ws0eyjRn6yKH1AkYJ6XlQeFU1HcVZOKitSKK7nEiroW5Rl1PX03SLdj+ByHf3c2jW2OKdO87prfOR4mpcV6Hm9ngaCZWQ3SS3kc3h7F/+2XIvvGqbRnOdbLdPIhZZFUvMjdO61bZizuA9thZupLLMQ/aUtnu+OgCIG3WjCe57eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdY1F5DdjPISd9Qg7wQGWOZVWGwLHnKYxLWv6t1q/x4=;
 b=KtCsDiX+PPyIKwyZbTOjWR7d0d8JQT2+bjA21JjTzCa6aAaX7jrhIYjBjGhbueA9EiAaTMxRgOZPeMopfOIouYkGyaDu6g1xVQCOUnN5aVZN52t143a7n3nYnpGVJGxxlnfnVG89YShKieIPKLVMySMaGGtpIx2ynF4meikpoaUEQGHjfk65KFa69n+tuBF3kgjFngokFxNiQivzlfAeA2qPFS/cHxs6mX9As00iE+tauauaDSDRK0to0Ccy4zTLdSsHbUfKfH+WGaaUcAW36UyxK3crauLlokZAOCz+bLY6DWIxUZgZlL/OG2pkXBULXshnaZwchjnMdeMGhhYJSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdY1F5DdjPISd9Qg7wQGWOZVWGwLHnKYxLWv6t1q/x4=;
 b=e9FdvSmtqAvcRzPFunrqFrVFgLyU7sCIjVkkfieAf+TkX5yByoT3W4+QY8sE0fNgEbMtiqiGGROm5HIl/bismNdpMet+cMUV9dOO+oRTmg0MLWo5N5nB/Vwb0Zdg6y2OSqq5fX+a5lHtgO8VZEgKlK+Xwt8PySg9XqfRBn0xcR8kEPsGiBBmPjyQ3l54cn/JYZLZ98AZnFbrP7lwlcvXEYgYNsQx33xavm4SoRgq1pwVkfbpProKwZJ/ZckzMJs3dOrXVHXdN+jCp1T03V+nxS0VwCnRx6wbTBYxEg5exV3+ZctV4oDqWvDQHS7+talwXgoxWQJ1QBNf8T+s0TNTwA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21) by VI2PR04MB10713.eurprd04.prod.outlook.com
 (2603:10a6:800:275::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 15:16:47 +0000
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06]) by AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 15:16:47 +0000
Date: Fri, 30 Oct 2026 10:16:37 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, stable@vger.kernel.org
Subject: Re: [PATCH v4 4/7] dmaengine: dw: calculate residue separately from
 completion
Message-ID: <auS01eEyWjGD03MQ@SMW015318>
References: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
 <20261029-submit-dw-dma-synchronize-v1-v4-4-fea447d9f285@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-submit-dw-dma-synchronize-v1-v4-4-fea447d9f285@gmail.com>
X-ClientProxiedBy: PH0PR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:510:e::16) To AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21)
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
X-MS-TrafficTypeDiagnostic: AMBPR04MB12445:EE_|VI2PR04MB10713:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e8ea04-d9c0-400a-1cd6-08df3698d078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|19092799006|7416014|376014|261021121427099003|261022105027099003|261021123027099003|10067099003|261009223027099003|261022075727099003|56012099006|261026121527099003|6133799003|18002099003|22082099003|5023799004|11063799006|261028144727099003|4143699003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	0602yOSxrYoR/7ebzqzU0tdthoX52e8u3kqz9Zk4JW+efuuKzM6y8QVcEul6DC4T98YDRr9VHVt2KhMu3Bb+ww0V7XXhK9sBFIW/vlgKM2I7kyQBx+IGKXBHZlQD6/PUphULZp3QOLLvuCHlS9QSdZPkI3+5KMdz2de7bMQ45jf9On+Sr0EgD4dU5qPK7CyLjlpXMhpBN2yP5wCRHZ4bCo443oMwSLYdpeiZ0jsvPUOOaf5OGfFxXkg96V2CKJ73kgIG9suCjlVEMhU+n9YJVln7tK2bCeH67akHbqNfn9cxDNuVVfN2mSLgkzIsD/k+Oo9yiVl4NlM8w/xSh8CFZgUMwjJFfiDFawuzrwwn7E4gkIMKV3zBwrxzBLG5y1XyXTzQL7kGtYY47jgy1hNwNKD9Mf2IfT5aFKZ9vRG/wMAFD+v2mqF+zNBWeNSH5vN+gvM+xMrtNl2dkIKRUQAerfqELYZMzc1lLFmlaxl0e3EPRrz1vH4n2YklMYmFaEgDv7ur5cnF0j2jLFGBTyURbaU8zqyi6sPY+zqKqHREwxuWf4VXMct5m/UXR13XtNpHViGRie9wZtB4ZScsgUdoJt71uicxwqm8TkG87r15ETGBjvrVhyX9lPRaY357DuClgzh/IULpmTIJhnDS2TclU80GJ/tH6T1kK4Fju6UPWDY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR04MB12445.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(19092799006)(7416014)(376014)(261021121427099003)(261022105027099003)(261021123027099003)(10067099003)(261009223027099003)(261022075727099003)(56012099006)(261026121527099003)(6133799003)(18002099003)(22082099003)(5023799004)(11063799006)(261028144727099003)(4143699003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WzyR3klOTAvkj+11MSU3d1dUzZoJDg5LEwkLdiNf9+SpwWFyoNH/ZMGeik+m?=
 =?us-ascii?Q?2GavHK1520zA/3quY1VSxwBi9hTc080BukqYZbWRH87V9N4kRxA4cTnEx95f?=
 =?us-ascii?Q?BWc+duqHRi983F5Liy7NXmiAzwbeq28s0vYrCLxvDn3bOuiNYaYlrI7Up96R?=
 =?us-ascii?Q?6rWQkqp6Kvw47Te4p1VwHSqmM7N5atLBYto0SXsO38RmUb0x7KOodLBpphA2?=
 =?us-ascii?Q?88aIQ1/1LlBD4kEIOuQyZCWX9ViM+Eeiq7nTDEY48mUII75HERpMIS4e66ha?=
 =?us-ascii?Q?jOEhbdaEp/EJCUF8/tlcveLIvmJlNlyJ8ab7gm4q8m8j1/iuCh9v411h3Byr?=
 =?us-ascii?Q?KuiwSTf9otLxdX1Ll/xpgpA0HkLKI8/T4L5aZrm2GT0NjexBLYj4Hy+yCFFu?=
 =?us-ascii?Q?A3rLJdFo+wtl/gQ2T7SLQLghDQfiMjotyRLoZDmrHtlqg/LTH/Cof7hbzOlz?=
 =?us-ascii?Q?Bq7WSm3DEo0uaHNW7Noft8aqdgDqDX3RXwQGVSIFtHU1X4W9QCGZoT/emcJu?=
 =?us-ascii?Q?XB5VIYeXraeUSrzfjtU9Gw8QBtY1tdVgD+rXKYubbi4pX2aX3qxeHD7PiQuA?=
 =?us-ascii?Q?jBG52SnIiX+HSschHQT8aQLz+d3a3UdzbK+Od1RuUK9P8DXUlX/d0COzmK/S?=
 =?us-ascii?Q?4vt3cLpB8eyw6IQ8DoWZlX2Jm/HjawU3ubRfFqg48pxwN7Jv0Xc3PVxZOzXg?=
 =?us-ascii?Q?UTfLKDn4703Y/BNZwZq1t3Tte86MxQlfOK3u5LOqbZrMEbeDcXUfUw3P71t8?=
 =?us-ascii?Q?eY9g/veEOKPARqeWpj5KrWPJ6ZYroUaibzJJzRhir3lKkBKercfkkOdO6ZZj?=
 =?us-ascii?Q?Rfkue9x0pzJWeuIy3BfbjhppV0FwoGPbCM3zoQy38R+33kmOEx0ayaojgJGq?=
 =?us-ascii?Q?yL7idgDE3fJX1QOPoEoHBex3IUXkORvh9JsqD5bQEMdfhKWS9okMGTRltdp9?=
 =?us-ascii?Q?LiQTEDCnm2jKOyjHEhX2iqgt0BW5pbXXVh0nr6YJhLOHhD46RiBIKX3sCU+w?=
 =?us-ascii?Q?d8OUVnbiA/JQ2Eu35ToxifXZwwnMopVxefdNAOBkj7PMpqyRhvy1cBW2FP7M?=
 =?us-ascii?Q?T79pdi3StLRmYXMfS6ZLrPcoknAvAqCmLWuus/vMm7l4I5ldB0WFFHWCkOMi?=
 =?us-ascii?Q?3s14jfTPVHc69bMdOaWqftxh3hgO5mjYxbc3AvpCGJDdvvJbIO6VAOKfEZ0D?=
 =?us-ascii?Q?40nXrP+M3UEvRvfEr0xylE5THB23XiDAYi5if+luD04UZC+hVR8Qfqu6HOb2?=
 =?us-ascii?Q?NaCAPalsVJL7fRpAwGJ6dJQShaPAR8RgqT7Ip8Zhv8t7zxlj5/CF6RLLGelj?=
 =?us-ascii?Q?o2+ZLcH1JCahQewCiNmiT15TVEgkw6tld2G8f4YUQcTYxwdQriUcao3BV1cN?=
 =?us-ascii?Q?z7S5cho43R7lfnxH/yymJnpkBihYY2WbnKwby5AJRAemexvAkyQsjkH+jWlw?=
 =?us-ascii?Q?WLTC5RbeZAl07GwPq4cNn3dzgiPQpD8S3BV3PBXG6OmtncYsMS+bEQLuuUlE?=
 =?us-ascii?Q?sCvxpDL2nLBQiNex9L0hsJKv02nCYFBFa/u5f1gYS/k8V7TRSdjRkELyr2+y?=
 =?us-ascii?Q?EU9hT1DuB8PgIOBYYTyX2bKOv8kawZ0SADjemEoiJneaNm8XtwDBECs2aNHW?=
 =?us-ascii?Q?o5FcsuQZddyPQhrBYxLxDT3N1c278X6R+YHCGFyzTCv83cx7YT6Fk8PVVdGh?=
 =?us-ascii?Q?H1hB0IeWNaCUYPDKdYv8j6dDzEa95tF3WFKXiqycXqn3tnKvsA/ABevwZRfD?=
 =?us-ascii?Q?pVGqHqk2VB06Vc/tolKeU7bprfXA/as/aBoopUw26HLM/n5XYx4A?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e8ea04-d9c0-400a-1cd6-08df3698d078
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12445.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 15:16:47.2397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tu9X8ELFH0LBA/Om7HwG2vm0MpNUpDmzJVWAkcbJ5ujUDvs90R3VgBKWpXgnXXMtwS4evaxom/v9Y8u0mP2diTo+BJ9mBBvLq1y0r7II+c2jSoqyUihXPqoeToge2czO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10713

On Thu, Oct 29, 2026 at 04:29:38PM -0600, James Hilliard wrote:

dmaengine: dw: move residue calculation into helper dwc_get_hard_llp_desc_residue()

> From: Serge Semin <fancer.lancer@gmail.com>
>
> The descriptor scanner mixes transfer-complete handling with hardware-LLP
> residue calculation. A status query needs the latter for the requested
> cookie even when no transfer-complete event is pending.
>
> Move hardware-LLP residue calculation into its own helper and call it from
> the status getter under the channel lock. Keep software-LLP progress in
> the scanner and subtract the current block's progress when reporting its
> residue. The scanner now handles transfer-complete events only, retaining
> the distinction between zero source residue and destination completion.
>
> Also search the queued descriptors so a transfer waiting to start reports
> its full length instead of zero residue.
>
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: retain polled completion and report queued residue]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> ---
>
> Changelog RFC:
> - Instead of just dropping the dwc_scan_descriptors() method invocation
>   calculate the residue in the Tx-status getter.
> ---
>  drivers/dma/dw/core.c | 166 +++++++++++++++++++++-----------------------------
>  1 file changed, 68 insertions(+), 98 deletions(-)
>
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 1f7afcd01565..1d6419e1cd3c 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -274,123 +274,60 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
>
>  static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  {
> -	dma_addr_t llp;
>  	struct dw_desc *desc, *_desc;
>  	struct dw_desc *child;
> -	u32 status_xfer;
>  	unsigned long flags;
>  	LIST_HEAD(list);
>
>  	spin_lock_irqsave(&dwc->lock, flags);
> -	llp = channel_readl(dwc, LLP);
> -	status_xfer = dma_readl(dw, RAW.XFER);
>
> -	if (status_xfer & dwc->mask) {
> -		/* Everything we've submitted is done */
> -		dma_writel(dw, CLEAR.XFER, dwc->mask);
> -		if (list_empty(&dwc->active_list)) {
> -			spin_unlock_irqrestore(&dwc->lock, flags);
> -			return;
> -		}
> -
> -		if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
> -			struct list_head *head, *active = dwc->tx_node_active;
> -
> -			/*
> -			 * We are inside first active descriptor.
> -			 * Otherwise something is really wrong.
> -			 */
> -			desc = dwc_first_active(dwc);
> -
> -			head = &desc->tx_list;
> -			if (active != head) {
> -				/* Update residue to reflect last sent descriptor */
> -				if (active == head->next)
> -					desc->residue -= desc->len;
> -				else
> -					desc->residue -= to_dw_desc(active->prev)->len;
> -
> -				child = to_dw_desc(active);
> +	if (!(dma_readl(dw, RAW.XFER) & dwc->mask))
> +		goto unlock;
>
> -				/* Submit next block */
> -				dwc_do_single_block(dwc, child);
> +	dma_writel(dw, CLEAR.XFER, dwc->mask);
> +	if (list_empty(&dwc->active_list))
> +		goto unlock;
>
> -				spin_unlock_irqrestore(&dwc->lock, flags);
> -				return;
> -			}
> +	desc = dwc_first_active(dwc);
> +	if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
> +		struct list_head *head = &desc->tx_list;
> +		struct list_head *active = dwc->tx_node_active;
>
> -			/* We are done here */
> -			clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
> -		}
> +		if (active != head) {
> +			/* Update residue to reflect last sent descriptor. */
> +			if (active == head->next)
> +				desc->residue -= desc->len;
> +			else
> +				desc->residue -= to_dw_desc(active->prev)->len;
>
> -		if (dma_readl(dw, CH_EN) & dwc->mask) {
> -			dev_err(chan2dev(&dwc->chan),
> -				"BUG: XFER bit set, but channel not idle!\n");
> +			child = to_dw_desc(active);
>
> -			/* Try to continue after resetting the channel... */
> -			dwc_chan_disable(dw, dwc);
> +			/* Submit next block, including for polled transfers. */
> +			dwc_do_single_block(dwc, child);
> +			goto unlock;
>  		}
>
> -		/* Detach the completed transfer before starting queued work. */
> -		list_splice_init(&dwc->active_list, &list);
> -		list_for_each_entry(desc, &list, desc_node)
> -			dma_cookie_complete(&desc->txd);
> -		dwc_dostart_first_queued(dwc);
> -		spin_unlock_irqrestore(&dwc->lock, flags);
> -
> -		list_for_each_entry_safe(desc, _desc, &list, desc_node) {
> -			list_del_init(&desc->desc_node);
> -			dwc_descriptor_free(dwc, desc, true);
> -		}
> -		return;
> +		clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
>  	}
>
> -	if (list_empty(&dwc->active_list)) {
> -		spin_unlock_irqrestore(&dwc->lock, flags);
> -		return;
> -	}
> +	if (dma_readl(dw, CH_EN) & dwc->mask) {
> +		dev_err(chan2dev(&dwc->chan),
> +			"BUG: XFER bit set, but channel not idle!\n");
>
> -	if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
> -		dev_vdbg(chan2dev(&dwc->chan), "%s: soft LLP mode\n", __func__);
> -		spin_unlock_irqrestore(&dwc->lock, flags);
> -		return;
> +		/* Try to continue after resetting the channel... */
> +		dwc_chan_disable(dw, dwc);
>  	}
>
> -	dev_vdbg(chan2dev(&dwc->chan), "%s: llp=%pad\n", __func__, &llp);
> -
> -	list_for_each_entry_safe(desc, _desc, &dwc->active_list, desc_node) {
> -		/* Initial residue value */
> -		desc->residue = desc->total_len;
> -
> -		/* Check first descriptors addr */
> -		if (desc->txd.phys == DWC_LLP_LOC(llp)) {
> -			spin_unlock_irqrestore(&dwc->lock, flags);
> -			return;
> -		}
> -
> -		/* Check first descriptors llp */
> -		if (lli_read(desc, llp) == llp) {
> -			/* This one is currently in progress */
> -			desc->residue -= dwc_get_sent(dwc);
> -			spin_unlock_irqrestore(&dwc->lock, flags);
> -			return;
> -		}
> -
> -		desc->residue -= desc->len;
> -		list_for_each_entry(child, &desc->tx_list, desc_node) {
> -			if (lli_read(child, llp) == llp) {
> -				/* Currently in progress */
> -				desc->residue -= dwc_get_sent(dwc);
> -				spin_unlock_irqrestore(&dwc->lock, flags);
> -				return;
> -			}
> -			desc->residue -= child->len;
> -		}
> +	dma_cookie_complete(&desc->txd);
> +	list_move_tail(&desc->desc_node, &list);
> +	dwc_dostart_first_queued(dwc);
> +unlock:
> +	spin_unlock_irqrestore(&dwc->lock, flags);
>
> +	list_for_each_entry_safe(desc, _desc, &list, desc_node) {
> +		list_del_init(&desc->desc_node);
> +		dwc_descriptor_free(dwc, desc, true);
>  	}
> -
> -	/* Residue describes source reads; only RAW.XFER completes a transfer. */
> -	spin_unlock_irqrestore(&dwc->lock, flags);
>  }
>
>  static inline void dwc_dump_lli(struct dw_dma_chan *dwc, struct dw_desc *desc)
> @@ -969,9 +906,39 @@ static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
>  		if (desc->txd.cookie == c)
>  			return desc;
>
> +	list_for_each_entry(desc, &dwc->queue, desc_node)
> +		if (desc->txd.cookie == c)
> +			return desc;
> +
>  	return NULL;
>  }
>
> +static u32 dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc *desc)
> +{
> +	u32 residue = desc->total_len;
> +	struct dw_desc *child;
> +	dma_addr_t llp;
> +
> +	llp = channel_readl(dwc, LLP);
> +
> +	/* The first descriptor may still be waiting to be fetched. */
> +	if (desc->txd.phys == DWC_LLP_LOC(llp))
> +		return residue;
> +
> +	if (lli_read(desc, llp) == llp)
> +		return residue - dwc_get_sent(dwc);
> +
> +	residue -= desc->len;
> +	list_for_each_entry(child, &desc->tx_list, desc_node) {
> +		if (lli_read(child, llp) == llp)
> +			return residue - dwc_get_sent(dwc);
> +
> +		residue -= child->len;
> +	}
> +
> +	return residue;
> +}

This patch still too big. You can create new helper()
dwc_get_hard_llp_desc_residue() and replace orginal code exactly, then
change gradulatly.

Frank

