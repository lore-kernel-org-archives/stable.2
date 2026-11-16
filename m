Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794860420;
	b=I0jSDY/zSDy/TzIybAGoxZMwB9yZuqLx1ELdy5m71D7UhlwTfDkGHrCc0WeoFHxdolgJ
	 ELi0LJqxhVfGnBUJ7rz1fv9SFSxY3Hoh12BxkmrfOQuJ2Ba0f69iRVN6R8fgQSn0cy5PO
	 lSRqDojr1ZyS7kEQaadMrbQOkWcPbKeD2EOs0HHQZwpl9llVPCpYL+8ma64xiQ6EA8aAn
	 de8f+HBxXp4FF521c3sWH5IdX9omLvK4GpTRBLn59qRTvBCaNhf9hgAQpeNGEadhKDICn
	 5+LztzoRQKIYhaTdot5Zf82ZZsWVcaFUaWxJzYY46EfZgAXSLoIK5r2U2YpvY4k53Pg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794860420;
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
	bh=FhLGT9/+slW2yShW1ivyE3TuTUmdxEcfTxRnZr0JPII=;
	b=nRHWhiG026bSiflkdgv72g3hxbtn77ouO/77zflUBNtMRi/jZRQPEPIu2ZeeOZ+TXLBS
	 6PQF5F5FvqAnrdRdXTAPhPOXnXQU47wKqAQE19naQrGD3FS7avcm4rObyV57Jae1BK4P1
	 VwzYHfkJiT1z9trWNo92EDdEEoIujj3bhDyhYVjXxroduztf4J3mhnMvzYu816wHXh0zj
	 /mJ1LeumC6sijcnUU/Iz4Oqst9aSJtTini8sz39sJwuCnkOQjjw4C3ftmhbQi6kN2dNhr
	 xeNNO+90SQUPsioZg0K/F0Tk0NZgis/mksYc9f0IV9kz2qulRdzUT9HG5sO2IjNHXhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=H+7QX5oO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.27
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013027.outbound.protection.outlook.com [40.107.162.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23C3606A331;
	Mon, 16 Nov 2026 20:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F23C3606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=H+7QX5oO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zK6F1fZKbjQJZPUnOFwyMB1qLEMWa9MR4u43xn001mm6s6gI0lxPR9yo+tXebc0JjV1FjcimWQtTZy91jw9esmK+79aQkW+KrqlJR6kqzEwlC5uknYwhXcD4a5bAzXurZQC+eP9zvt4YYk7D/JA32yh+PWASW28COJmUz+LtpubDsGSFjJfUy+JVQBANOAwv0qRAv4WKFBnmvgtEzrtELC0h2UGnLSUDxKJMvAXF3/+/QrLfXpjx7v+yktieS9s5GZyGzdLT90Ww3qPMeO55WWmMRPkY1vOgnPkXsWfbzoD40m1LHPAQa4KD2x9gI3hG+LezE8SV4p9CjlSyyLjZzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhLGT9/+slW2yShW1ivyE3TuTUmdxEcfTxRnZr0JPII=;
 b=LO1PrYxAwLwG3v8iaNuIdz6Np2ENDkft4gN+5nqMudy41F0CJ1Oza4LKEc66bwOgSWxrqcYgE6beY0tNGjewOdhdO1ahFPzh2cYVLuQOZPEanHDK/Q0iWX87BLpJVoOcJcklMhFcYMyqCLnWsogfrqnBnXxEdY8YCqJs5dsw9v87Bf390q4H00/di9Ms9CSK13/QD5puQJCFej/TzkAe+3fpPIM9ClAXBp5b3KLPYF+HSRMHvvtxnH0lZFZ8jfA02tZsOvKTZjxJ9twC9wgH3W+ABvIKpOfUoGVRg3ZngpAGuOzZYG/3Zbjbs2mX1Rhk9p+SJveG3ACx3Plldi2DQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhLGT9/+slW2yShW1ivyE3TuTUmdxEcfTxRnZr0JPII=;
 b=H+7QX5oObvW8GTxzXm5ZMxQlQrHqO0L7coKqKNpaDXEphIcqxBpwdqtRqTbOpuujzTKoa/jNMlkUuK2R+IC34bSORh7pU7fJPx8tpgNlpX4KmRssWwXJoGsz7P5oyYCp8Wd0m4Or/f2/1zMwHzJ0Rz5x4L5XWw6+D3CRqqMmsy6BIRI/xJ2KA+Cvvox8Ymc877phC06zfwaJ+EAsYiu0/R+HLvMMwBkYAA+gBcko38Dwpw2e5UxyIXJ3QrMYxiFQVBWRi6qHQgMjzsIRYa0Vd4GC/N8EkHdlQq46juLAumKSTB4vuRawuGNz4SmKF8pf2dN6f8LS62oVpJTqcRW/uw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by FRWPR04MB11198.eurprd04.prod.outlook.com (2603:10a6:d10:171::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Mon, 16 Nov
 2026 20:20:17 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 20:20:16 +0000
Date: Mon, 16 Nov 2026 14:20:06 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: fsl-edma: Fix channel leak in
 fsl_edma_xlate()
Message-ID: <avtlduHQA1_llfis@SMW015318>
References: <179395206206.2118334.5568431940571202082@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179395206206.2118334.5568431940571202082@iscas.ac.cn>
X-ClientProxiedBy: PH7P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::27) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|FRWPR04MB11198:EE_
X-MS-Office365-Filtering-Correlation-Id: f07c901c-24c9-4f73-9606-08df441f06f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|376014|22082099003|18002099003|6133799003|11063799006|56012099006|10067099003|261022105027099003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	50DVcYPvDQniINt4szUHG3xM9ORvkJMj+kjdy/DsRa1GaERv4MnXXLZjSDHvBkMd9HkALEXdWmN2fi2NnBzMJvUy16oJAOgy/Ds12TxwLtXIjkYuoFF/lL4JiI32bN2uIy5n560xxXBloTcaFqtYGcO7YMYN2N5Vx8rmrBB3WBMyyHUY/YlC2frCE6bBT1M49TfcSKKA8mW3QXL5ENn//YavsX1XuBzMtQZvKBxfBSEB+JHmMzETAyQ/7+d37CRenukZMSSsYynZmwJTaiID8PYc5QJU6nxSYQVk5Sk2HjopikXiZSYy5RwLKTFM9AF4+QltcFg9jhA3U5g9Ypm5qTXmPYmK5yMBcKKndWQJA2SXD8K2yK0pupfC1zTL9npa6B+y+CKq+U+Ae1NWdSO3rIA6MunEStknZjG+1DPZxoxKCgWz+X6yepu09UKBV9hbqxCatoMfG6uaB3DmPSJ/WowLyFddmSz7HXFL4m/yZ/wkLv1tIaBnz1rCRuh0KCl40uXAdyyAEsFT6HCiY23mqTSKN7adLPMSkwMySpdN87HulrNNR84diB6JYTYkvz7V7ZQKR//dhCEvfkTSNZ1fLjkuJbKpaDyFjBURL2eFdWWbYYLi+LJw1GJwCDYN3fGk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(10067099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yQdjNuPogGTNZ8oFmtgqm/43LHad7SrhwN2zSgeuDUNFAMSM6/LYFKTUbK/t?=
 =?us-ascii?Q?/IBPmPnUlTpYivLp4HqgjfiiV7UQIcNM+tqNAWJSARCBxGIsNc6jOl4j6nJR?=
 =?us-ascii?Q?9SQ/XJj2K/lQa6lUiBEUdL2NqKcq/VSi2o8rnd7SDHBx/0KkarIuP8QIDQf7?=
 =?us-ascii?Q?QdpXx3Z6f4HxQ/QRvaK/cbxrx0NO2dAFUtP8cOd8DEVHxKwxqVJYW+uXROLf?=
 =?us-ascii?Q?t06dls670ywmctHHEgdGpxbpZklhY0y2bPjp1DvISWVUWWGU5jTc5ZMieiCA?=
 =?us-ascii?Q?bIIpRJi7XVh+zzpKNAeExgGIlEt6rw5ZBTUvsM+OhnKfmPosuHTEj6itc1qg?=
 =?us-ascii?Q?CNqzdnd67OkDpAIoJteKKN9chAAZ3AhtX7htRYZ8S6AmPWt94CvPZpqJtlik?=
 =?us-ascii?Q?jb/iCBB/UcXMgI5taf25bNKRC+ca+UOgZ1eINm2TLVR6ZWmOW2Q22ji+g1qU?=
 =?us-ascii?Q?cfkloIVAqUtaz2qJl9IUH9LXjgK0sXTPDaZATGl7IwoC9ibgHukCZTvj5vcl?=
 =?us-ascii?Q?z6IXmO111y6YxEeLQcKQQK2Ahtf11dfIuNS1pu2PwhEFdL+WPWyuyPDUBoPa?=
 =?us-ascii?Q?bbyDoH1UsGHwIqIKmwt2bycKl+wRx7hCSgqq4WQPZhZnNwE8t0iQ/oA+0n2R?=
 =?us-ascii?Q?IhTWteJOWNtiIl2QGXjAxefZDfP/Ham/Fc5OaFaH3kQ7uQTQ6wMEjGaQo7Z2?=
 =?us-ascii?Q?yRaA/fSGnnHML/1JzfdUnYqpUrV8V2Ay9klYJ113kdDNrx8Wz3UuKdh7zJP7?=
 =?us-ascii?Q?VmMHtEqGiU/WNMS0saBxq+AUEees+vAt5jseE3aX8ZwIyMWvIYKdY+neLCQd?=
 =?us-ascii?Q?SnqTomMaDGy3YXawojdmgYTsZsG+vKlGeF3vTwEivu/CADydrDd1Hdj2r+yC?=
 =?us-ascii?Q?KZNbDMZuCoLVB3exnreykj1KBsjAAwiJXtegSkyjJYkY3t+YtKLkr295b6K/?=
 =?us-ascii?Q?AePC6eMMJ+Ab8+UP2DlGESZpup6Z5aVFp9+BgDE7piYOV9WMp4CsdjjYLsaa?=
 =?us-ascii?Q?IUBEzysmjZNehUNgCfUXY5cOAExwifxbSL4QGfjHXzDkngTbOLXuWV3Hk4rP?=
 =?us-ascii?Q?Rda9gtTI1UVqug5ZPK1mSsv3VvZgHARid/fcqOAndVeJpqkNCpp4VkC27GPH?=
 =?us-ascii?Q?DknIx8PIbiPlm+nppJLURhik49wMOsWhOZFlgqTNfMiU1UZIX0rWztT1nxHg?=
 =?us-ascii?Q?D2ogzfFbrBm2JT5einlUWakwcUF4zScZJbstdP5dkZxRcrXFsAD9mOaTdrf9?=
 =?us-ascii?Q?2V5b1G6YLBF6pY5n5+gGk9+KxhEVqpNXPIFoj9GRpBxuOsvqk3fRzvYM/Cqa?=
 =?us-ascii?Q?m4HE0pl/o/E+YeiyMWYUxhTZYbrHzlB2tjgRvxSZ6BoYxTNsIg+eubMqJgZX?=
 =?us-ascii?Q?5eFvoDRvMkWlp9plsRhVGbV4Yn0jfmlxG0LJ1tVVgk8NKDFGz4jr8edv/ZT9?=
 =?us-ascii?Q?etX9lAjMLvM+NKAYGS9zYJ0xwm4xTaSEwea7pnX6fbTNsLBq6pTGn3ZM5+6r?=
 =?us-ascii?Q?EEbeYV7Y11PhtU6WQyPSAZi/col4LmnLUAyGROLEynOdBBIJhnB86eaww8Q9?=
 =?us-ascii?Q?GIkKRLwcvwQt6/AQVCX5VL4tuPBqlW1cyGwoy4TGRbbUbODPDG+++qt2q51S?=
 =?us-ascii?Q?9zfWY1AyeQJnEwz4T77o0wGgDJ93Qg6X1ADQMEZW5omGRB/5WxtVOGoyQPAB?=
 =?us-ascii?Q?2p9xqL4hoyv1aSe4a4fZR7WNmrzGhyaYgLeZ4D/6NnddS4/ac2wVW9HioJok?=
 =?us-ascii?Q?PXnKxoPhHnTVS72R4REcjHmeQZjP6gtXiTnvwb06BnwnZqWCxvPE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07c901c-24c9-4f73-9606-08df441f06f2
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 20:20:16.3323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQS1lCwmyOulsejkilZtnj7TlUlWD50+yh3N6Rf4WVoHf/AIg4gXxINK/1wT7tY7X1FTj53H+N0rlU/uhToHQyAc+ayhvDGdI3oPAVfT0TgnL3EhCZ5geTsOjI5ZY+qv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11198

On Fri, Nov 06, 2026 at 08:01:02AM -0000, Wentao Liang wrote:
> fsl_edma_xlate() acquires a channel with dma_get_slave_channel() and only
> then validates the srcid taken from the device tree. When the srcid turns
> out to be invalid the function just returns NULL, leaving the channel
> with its client count elevated and marked private, so it can never be
> requested again.
>
> Validate the srcid before any channel is acquired: reject a zero srcid
> and a srcid that is already in use up front. With that, no channel can be
> leaked on the error path and the release added in v1 is not needed.
>
> Fixes: 6aa60f79e679 ("dmaengine: fsl-edma: add safety check for 'srcid'")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>


> Changes in v2:
> - Check dma_spec->args[1] before dma_get_slave_channel() instead of
>   releasing the channel on the error path, as Frank Li suggested. The
>   zero-srcid test is folded into the existing fsl_edma_srcid_in_use()
>   check, so the code stays where it is.
> - Link to v1: https://lore.kernel.org/all/20260916092733.2002700-1-vulab@iscas.ac.cn/
> - Sorry for the very late reply to this review.
>
>  drivers/dma/fsl-edma-main.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 630285c85482..e2ef18ad1a3e 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -266,7 +266,8 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
>  		if (chan->client_count)
>  			continue;
>
> -		if (fsl_edma_srcid_in_use(fsl_edma, dma_spec->args[1]))
> +		if (!dma_spec->args[1] ||
> +		    fsl_edma_srcid_in_use(fsl_edma, dma_spec->args[1]))
>  			return NULL;
>
>  		if ((chan->chan_id / chans_per_mux) == dma_spec->args[0]) {
> @@ -275,13 +276,6 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
>  				chan->device->privatecnt++;
>  				fsl_chan = to_fsl_edma_chan(chan);
>  				fsl_chan->srcid = dma_spec->args[1];
> -
> -				if (!fsl_chan->srcid) {
> -					dev_err(&fsl_chan->pdev->dev, "Invalidate srcid %d\n",
> -						fsl_chan->srcid);
> -					return NULL;
> -				}
> -
>  				fsl_edma_chan_mux(fsl_chan, fsl_chan->srcid,
>  						true);
>  				return chan;
> --
> 2.34.1
>
>
