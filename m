Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795023115;
	b=fJ9QqFRo1zcM/XsTj47i6wkgXkfPbo3jYHLQFAD4FubGNt6eZCYtH3YYbzb0KcrTjmTg
	 VTKJN+/3byucnfIkpwDcZXo98FC2H3eTyv8t+Mt2wsPq9Fim5WHRVbge2Yri4LCD8+ppe
	 2WAm02n4wbpG571/JI5gLBnpbPwo4TqdAjchNT/x5FTsPyZ/oOBp4YokTMJZCuSjHkakD
	 Xpb27Kq4ZnJEP0tZN5XLF414T1jnARZzormf9+TjCHLdlYKrWRgyf5RYqZSPvDMQuB5ve
	 xPynQdxcISuFfSPcOjZgN19xB+zMVTUzGZodSAHHUD0DZjVa9h7yoO9whZ7k9oq7Rtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795023115;
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
	bh=9/XVrLCVlMRreZxd1JxcN5WbtW0cykgrdELv0Qozql0=;
	b=wvQ/osYbev7reZ4m+CtONHteoLISJcR6YTOSFJAGp0OEje2QISHZeFJpoj6JMvvG0nTq
	 S2HAe9t3t8lXQmWSNk+2GufJ4yBFxikG4QGZ+b5PwNToTrB7pL2hBSPS/lCs7QqDm5rsW
	 L/I2G/UoknZon+5az/y+V77uJd2mSvKY2WdlwTgdZ+uchh9gQFpCh+1mFlHPwrpAzGC4+
	 LMn2bfLyj0dZYEEeKUjNAeue1QTCF1ieWUtJ4KQnKmCtGyAnZWmSGRBYF9mi48gvu1Jvm
	 hIBa9nrvA2emLz43sfqFnchs6PVC90xFUvUCUfevPs1ylpo/XPPbhQUxlheqVic7WkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GlKeIzWC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.47
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBFA606A320;
	Wed, 18 Nov 2026 17:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CBFA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GlKeIzWC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HP2tSbw0nXFSaSic2DUym5NQxvID519fXgQvevNZ+kV/zcktHgfccPQlGPqe+Oxg8Bi+gIaz8u78GLWaxILssW/Jy2vNvL445REpheXy68eW+ql8koEairIH/vmOf4UUgOY1w1H+DJUPUvzGJIq69aldrQzdsEUeizzZmv5xGxETIV6YgHJLQva8iJUBIQhksjOgH+WQS7HZVG9MgDKpbq7gYh+1Aui52kuGUSvWvvTvYOH23o7astZvZKRgCZNoKeCweLlIJOOGQI2AQUx+/taekBsvRc4x/el9jRmkobSHQjHTSfLroDS5n4dEWnAeT4Ut7ucJ6iClrs89ygJitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/XVrLCVlMRreZxd1JxcN5WbtW0cykgrdELv0Qozql0=;
 b=BA4xIIK65wZbBOmx4PfWnwD15te9YX5cAMLd6+Xv8KsHd5Cc1+wjwSQJm5ZO2F/fSApHJ2IZTzxFLAR0o14z/+e4/xZHlIAlGR/ZqZpLsYwZJTMXDuwSXJb7L4iNGvtKLcv+ejbgRtgRsViwjTX4o2ycgDNfD8cdwDU8++sbel8DJXqfn5RGwHKibXOgv7iLfPKFC1+ssRaQ897SrYYfHpEyPRu8xoIsYZzCzvskY1NHGaNoBPjkIXcJksLFPIj4nvtd67xHJ/RlqrpAmvw6rqKRWZwAHwQHTpC/qOygEmmv5JrJpbZuNR1SvWT6Zb0X8BhcsUXazSrTGkeEVt5wBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/XVrLCVlMRreZxd1JxcN5WbtW0cykgrdELv0Qozql0=;
 b=GlKeIzWC/RazPFWmFn4N/YfRscIEWu9JaLfj0C9jj0JyG2v3ApCzRfmAEASJ/qGqBDFRi35rXnd4ap09+tszzs4s75IlbgiM6dAqyRjmyUuQcBuJERDlRV+gsdbnYGI31TOSKKzYCdu8qwM2xc/MUr8cgq2Ft9gjtavt3n0vk/dPsRZWzgyyos8mOlk6rBfQ5xAe7RvKW4SRqDWY6/C11TpoSIzbG86VJVB5Ef+RtGuBF52PEFRIVIUwy5ZTNNCLNf7IxCjz963meTR259m1XKusMoh8DqXm5ywUVjexjTn3YS4AQvPXNQOd4wsqMkMuNnLWtQGH3uclMOKGhfjQqg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PA1PR04MB11360.eurprd04.prod.outlook.com (2603:10a6:102:4f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:31:50 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:31:50 +0000
Date: Wed, 18 Nov 2026 11:31:41 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Sergey Khimich <serghox@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sia Jee Heng <jee.heng.sia@intel.com>,
	Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7 3/8] dmaengine: dw-axi-dmac: retain descriptors when
 termination times out
Message-ID: <av3g_VJ4TtxQTOI2@SMW015318>
References: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-0-d5f2309afd72@gmail.com>
 <20261117-submit-dw-axi-dma-stop-pause-v1-v7-3-d5f2309afd72@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-3-d5f2309afd72@gmail.com>
X-ClientProxiedBy: PH8P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::6) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PA1PR04MB11360:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4d9dac-4f44-4e37-86ee-08df4599d3f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|7416014|376014|18002099003|22082099003|261009223027099003|4143699003|11063799006|261026121527099003|56012099006|261026140227099003|261102123227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	wfFXW0JqmsNcPxeBUIc3LjIGcu+ecV7HOwOSQnifFI+pkXdtBy5T9t128YPmWe8o6qh14BBKsYbgq3Ocyb6cEwbodxrXERZObKyA3/IfzWxfWy/UcrUhjIVyVUpSElU/rSGauDbIFS1xO6Rjkiv1VI0EcU++obI6u9PUEblDE03qVCAIEohHxsudEwYbPETFG2yPQajRlXorKIbr8AJs8huNEElB0rwo5l0SEQYvGPERJy0OD8XCeKAwClfQJAJqztGf1CUHDCnEfU/0lgoyQoxM7xUyy0dPd/+fY5ye5zzUpYl1kFm+5OcmhDEthRkqDykVGYWlv/nRu5IoC1WP+xK9Ry8EV3GKNGqV7rzQhhhyXlMxEAQaiUZYZLUyOTrXOVY500WAnR3lmAh4BwXpAgCt1jZEiB7tSh6tgbozsGm+7MnpO9KthRCBV/M0cwD/QlAoOwvgQ+npBlKDfHic3cEE115dcToBS8+2l++ma5JMTLiSvnNEnMyg5gWlexVhu75yQ7tRzhYX9nDJXa2xPrqXPNMg/LVjf4+y5cIWSiodjwAhRR29qxtSy9S9sz5dqNOdHCZZcY0yRHIeTQyejyRRUmtXtowGlQRIdX7jkjAWmZwcjfcCc9w0mlh2hMm1sb/IntttpG0FWag2hwhnAqceLkB9Oq1x06mgkQVrTgM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(261009223027099003)(4143699003)(11063799006)(261026121527099003)(56012099006)(261026140227099003)(261102123227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4h0Iir5wrWmaXGWaQ41sHn333fgPozBn+9uLp0TlxsUULc0lGGCOnMvXT8Na?=
 =?us-ascii?Q?72B8RWPmNe9eMK7w+FCnq1nCZ/U6rf60AM1PLMMitf4aEHikUDHT3g1Ny8Fr?=
 =?us-ascii?Q?htktwA2Ji9CXfU3hI2U8Ovd7HvfzZMbgDwi5pWVBkSeAW3iT8jg5EyXV/hIc?=
 =?us-ascii?Q?t0uv10SFG4VB5Xuvjx7r0V2WJIXUkOB53rei9r7rANz1rHUhWdRiyV9JKNdw?=
 =?us-ascii?Q?rveM5BDwldJntn3+WCaJ+CxpASsaYhe4gMcHgVX8nFnKttA/uNxIIgwXjHea?=
 =?us-ascii?Q?eDjkXT4Ce2xih4AoAvGIX336i2RrqE53CcRYmecRlNgjLd6mloGmVaF5uam8?=
 =?us-ascii?Q?8VnUB1FznCOFUERhenu9X4jUFWwRRgWyk8wHWzlIG4p5smYp3ZYz0RrIJk+a?=
 =?us-ascii?Q?L1ScLOpo82TrkcJWX1kHZ8X4Xan0Y6GihbjmE082plSmlGmIlca2nKl+jF78?=
 =?us-ascii?Q?s+1Fz+JQZp5kmPESVzQCL1AIhhAR5/g6TuXbnBwB8Fa6tkOg9t17cmqah8in?=
 =?us-ascii?Q?IrzVIso8Zd7dWNK3lWAhCipLtUOnrTOTpxk0HXO7h4PY4aNpYCBMtHGetG97?=
 =?us-ascii?Q?M+b4G+sG2T3yeCo0FPKHhanF9Bzj6XPgdhWYwalaBhFZ0NpF3GyAOPze5ftg?=
 =?us-ascii?Q?OeGXLFGjT6DIh+SF8zLD8jEawSofFyOV28/wNYEXRkxqVqIfaynwrcpAXc4b?=
 =?us-ascii?Q?hT8ZLsVygbwiZgNUGhZDCOVxhnsm6Im0+iei76QbsWMZk6UmSB86iHLYCGMQ?=
 =?us-ascii?Q?/6gH6nYTC2KRs3jTZqWafhcaW0bo6k5MSuTaK1NHV4UKe26IXzFmCOJHmu+8?=
 =?us-ascii?Q?6emyxFYHP0aFCe54ZGgk7fNz5LWXO+FtgAzfb98M3l6XMDne+y5eXVs9BmT1?=
 =?us-ascii?Q?iz2w3bsancGcaCXX8joR7NsweDJrHGMc8O11eWAyQi9m9x8kzVjh2cEhIRKb?=
 =?us-ascii?Q?3RZgbT8wkuuQnmqWRCXr0OzSH6te7ho5pZDK+//lRjazPdIU0fVasEfOPtLE?=
 =?us-ascii?Q?zfi/gdwe9RGB67A/w11YAeCezdwMEj5d4NJhtP6IpRtiI0+GDWCySCc7dY7D?=
 =?us-ascii?Q?lSvccI3VHEI32OPC/+bkQhuJH2hehAKQ6J0koFrZ5eXwA8JG+YB8EOb/2hci?=
 =?us-ascii?Q?bEaa6aiQ+bNF3y+xhGijFkH9JvJeLcsw3Yx3cVRbDPopj+e57Uh7aMHHWQAU?=
 =?us-ascii?Q?ciUWkNbrW/S15HVVZN9faC47sUR8ROEHXzRrCCyJ3mCReIXyccg9hgujSamy?=
 =?us-ascii?Q?ubc8RBDhE/BKkC9Zi18LwHsF6ArVLqjZxVtQS+zBMYVxk9zs8xTX31GybOFr?=
 =?us-ascii?Q?rAjHu+vEmFa8V/Yfn9KRtlVLo2qstWntZRO2RQQ3L33279ZeTZ5SAK7gP+t/?=
 =?us-ascii?Q?YmTtqmBPYVIYSwdxuXzZZd73Mg4JNDZ5JRjpaPJlHeYJicc8S/B6sURD/q2B?=
 =?us-ascii?Q?sezfGvEkzzZDlB6eUX2GCTG6pgAcyEvfLpDxCIBG0FrOg9igK7aWg3cu3TrF?=
 =?us-ascii?Q?2X6witBXqvdHH6USbSfIDOuiJ4oGByiSEOosi4rI0H2WBtHHvCbD3Mpx3iuV?=
 =?us-ascii?Q?tN0Hes02fs9lNasC/GyIhvn9XqHKDqlNkUSwrs+0FDreGI38LW/ilqWfTqGb?=
 =?us-ascii?Q?YnP5GcjFY/5dDuH/39WyC3gq+LRZM208yRgpvW+ldGd1j2lZQbq0h7gNMYqv?=
 =?us-ascii?Q?BGaCQRrQazThVf/OZStQoZfJWy7DwfWC04tHFV7sSjpSD/HalOyuY12/MPXT?=
 =?us-ascii?Q?mnsJmsUhNhNB4OKvUVSCmwluvlIPU7lpzAy5PcFhxYRubV8N1OEH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4d9dac-4f44-4e37-86ee-08df4599d3f1
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:31:50.0129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 528XrIsQ7ptQ/5l6oyKnyL4KtYNupLtoNO3fNPqj14dT8PaD3hYl1R9/aHj9SVG7ebPXsjtVbJAJZEYIx/Hugdgh61C+g8gvpLHmqg7Io6vtd/fgj9szfiCo9la4b5QI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11360

On Tue, Nov 17, 2026 at 05:07:42PM -0700, James Hilliard wrote:
> dma_chan_terminate_all() warns when the channel enable bit does not clear,
> but then frees the descriptors and returns success. Its synchronize
> callback only drains virtual-channel callbacks, so terminate_sync() can
> also report success while hardware still accesses the transfer.
>
> Return the polling error before detaching descriptors or changing the
> peripheral routing. This keeps the transfer resources available while
> the channel remains enabled and lets the caller retry termination without
> treating the timeout as a successful stop.
>
> Hold the channel lock across disabling, polling and descriptor detachment
> so an interrupt handler cannot restart the channel between the stop check
> and cleanup.
>
> Fixes: 1deb96c0fa58 ("dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 405ab9a78955..040c12d07db2 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -1185,22 +1185,25 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
>  	int ret;
>  	LIST_HEAD(head);
>
> +	spin_lock_irqsave(&chan->vc.lock, flags);
> +
>  	axi_chan_disable(chan);
>
>  	ret = readx_poll_timeout_atomic(axi_chan_is_hw_enable, chan,
>  					enabled, !enabled,
>  					1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC);
> -	if (ret)
> +	if (ret) {
> +		spin_unlock_irqrestore(&chan->vc.lock, flags);

It is worth to change use guard cleanup.

Frank

>  		dev_warn(dmaengine_chan_dev(dchan),
>  			 "%s failed to stop\n", axi_chan_name(chan));
> +		return ret;
> +	}
>
>  	if (chan->direction != DMA_MEM_TO_MEM)
>  		dw_axi_dma_set_hw_channel(chan, false);
>  	if (chan->direction == DMA_MEM_TO_DEV)
>  		dw_axi_dma_set_byte_halfword(chan, false);
>
> -	spin_lock_irqsave(&chan->vc.lock, flags);
> -
>  	vchan_get_all_descriptors(&chan->vc, &head);
>
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>
> --
> 2.53.0
>
