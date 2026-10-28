Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793204899;
	b=RoR72a8j5/pI/L1zC8p2oUgUH1+jUaL28IThHLSRzcUf6MKtI+oiKtRp1lqaTLqpW3Un
	 a+maUB4LN7hcBgq52Cazq89ozAmNnZ/J7CPQt6BS+LzdzcxBYxaMIfiUVRQPrUKwHm3hB
	 MvHM78lVh20ec0WA2YJA35UwcXjdhnOERAXIz+hyXjzMsa3qjHyNtimgfpkHerZi3Hggd
	 6fDq0NrY/tH2cc3khawEIFlFcrS5MV7PVRd+pUC0UOvCNQQd/CIFZ4+qllkJosAPXir/c
	 UXZHuAE6hw/K/MC6RbEq6y44AxRSqhug7qY4k2YpCAlHXf5Vfxz/u27FNw7miashvGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204899;
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
	bh=WxrzUkR89kb4ZSuawQsPt3zhZaExkAicMCRUDaOSKuk=;
	b=MjXrpa+fRCMMNXUvOOIAt84MNZ32oYKFo7xRmM8pcFFNS3ZcjCaLjcLxdqs+UPEy7Vbn
	 vOzeeYB40WcFhAI68u/C3qBB+yYe+q06OzdLw88t7syv/UZOdCeR/wFBmpuXO25jZLeVo
	 FcJN8rlqz8r2QXOohKTBG7Xws6WetiKyeH8ppwlXmiJA3m+nYlcgDMt8e8wqXPJuaAaHr
	 HIYAdit+6E/DTL+Bk5r7QySgIbatuaewk24FEYkNU9n84ed1IkYOZAx5AiGZ1XguSrLK9
	 84VaUawsgSE+HMTBYq8pZEj9QPD1XJVVV2wMo5EnVk0cN5dcXU3t/gbirZqKxQ6ij0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=icQdiQgq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.30
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F446606A32A;
	Wed, 28 Oct 2026 16:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F446606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=icQdiQgq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ry7y6usF1Vjpqy9huzYpLyicmVQ3dqtwyYjvtog3n9UvANdVS9An7qwsaf39kWoQj8YS3Su/CpET4UB+uALNGXCxLUCheXeoBa2ZYDKwHLymY8ggP230tEM1U8fTaeQ50TWZa6GTyHDdWz9KZ1YbVYlBwVr+iF7oX2OqQVK2SHno7rfb2cIucXDRqqVrFb6Po4zcz9F3EOjdf0XeFRdoxMXPiw3PEeDjb/O2x0XSgHZeuqsYjw4ZjtXZXkmj6Gojy5eCjwfUeUJgkSjPIQgW9mnWCRv6hffHQMCAKLyitktWbpzvugEAcsu5WhJL5HOpEkOVGaPMmSaADN4dA5+bwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxrzUkR89kb4ZSuawQsPt3zhZaExkAicMCRUDaOSKuk=;
 b=iRgZ/dv2PuI48WCREsLi3L4nh/wX0FmaROycRNDvfq2mxgFsgmeBoWdsiTZifoYotjmS1j0NbfmzjGh/nyCDFXqWTYkqZPCtK+RA8KkS6UZ0Bc8f/+cxqRfgsPplMqAGEfOESW8ZCIrMp5yaFi/GuGgga+GInBMsZ8g0VNslCSfCftHkZJyoh0kiJg55NMo7C+FYfeifeeTK1dnjz3GUO6JS06h9hk9ZReNN5/m00g/oDefoxE9oqy+KbOiLNmxV2463oC7QaS12rjuM85yrbJYQeCMOXElvY1eIzMOpJVnsUuJisYralPnBk6xSZxNs2djJcI/pLjIY2bisrlF/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxrzUkR89kb4ZSuawQsPt3zhZaExkAicMCRUDaOSKuk=;
 b=icQdiQgqaIi+mnLUTZbUqZX5hrjfc8wddavtUxNOVhomPGlchW4WLV4A9Z72PVlcq3qeVB3C6irjLlCLdilwOKuFTivF7WG+ZHpUHmrZR7EzX8YXLCqN6zaQa8pX2OlTb41dOOT/Zf+/JHMzFalJG2C5cztbZ+DS42rC0M6l/ux1tYyLkS2YRIYgowohFuvyfnw9j+9ZBGJsLEirCApjCYXbRIG0uk6sWWEeTQcVpcT5M8nwN5YnMsLowmvJXC7yOv0uzsnzKyfuZizBO4snxIwpSGkkyMMnwy5bhNbxKCF1T3CKhJg2tQNBCl1J6vVGJfkGfRvh9ucn+TbAjJ/BxQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV2PR04MB12068.eurprd04.prod.outlook.com (2603:10a6:150:303::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 16:28:12 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 16:28:12 +0000
Date: Wed, 28 Oct 2026 12:28:03 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Maciej Sosnowski <maciej.sosnowski@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Haavard Skinnemoen <haavard.skinnemoen@atmel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, stable@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dmaengine: dw: Prevent tx-status calling DMA-desc
 callback
Message-ID: <auIikxvNbveFhXum@lizhi-Precision-Tower-5810>
References: <20261023-submit-dw-dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com>
 <20261023-submit-dw-dma-synchronize-v1-v3-3-c62bf048f5ce@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-submit-dw-dma-synchronize-v1-v3-3-c62bf048f5ce@gmail.com>
X-ClientProxiedBy: DS1PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:8:44d::12) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV2PR04MB12068:EE_
X-MS-Office365-Filtering-Correlation-Id: b334c4e1-1926-4dc7-2b98-08df3510759a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|23010399003|6133799003|22082099003|18002099003|5023799004|11063799006|56012099006|4143699003|261021121427099003|261026140227099003|10067099003|261021123027099003|261022105027099003|261022075727099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	mslBKK72DUhNmy54aMtDu39skTiH0MUsSyIq+//nh4xkDP3lGaMK/CWlfTVLljpu1jzd2yQa+s0RFMoWvZhxdMzbFeEZmZE5PKaXTytkfDQsEO73GGVsZrmca8DXJiE6htTuHu8AqdQz//dXlnlc/odCFmGJ0un9QQ273ExxaezPO7OBeYCb2mh4qPoCl143gDg4z4Zu+AehJe5jm9E4+hPcUr23K03b0KZEhq93phKypswNHnfJapUH+6cSpwsn7FRw7TcBEVLtSU9Q+dU109qtTOqWshXD+IK4FEf8h8ZuCEP3JUOPSVBi42D/9oUrtXVWq7C7Blqqg01p4iO0x285FATOIXjt3xdsmYLsREKTFaJWirlJd+kT9GXXmrV1Ck/hfrcUjOdk7TtAwr2pkiTcn3TrnBqfOaDsAGXMYSAdPvhAteMLI1vCnFGKhsyAKHU4RkuGFOGtkP4U7myJGr1KxBVNEkva7//fWguYe0RUOeQglFWG1vXeJWeeTBeXmavKaODTXy/3gSmVzm8qjNZ8RBa9jICseMTWh8oHJMOldn8FigGUO6gMlmR74bGeGhCKKCYh+JGU16ZII30PHwpV68O28LOlbsxXs4FNVRAXVW6TUhYlvVfQ21bcmLNcQPR35TfLbETqKH5j25MFHaWEJL5kYxsf8lhv2DaQGqY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(4143699003)(261021121427099003)(261026140227099003)(10067099003)(261021123027099003)(261022105027099003)(261022075727099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n1a/JUQ0ovBqmvjfCbgOPbDF7rmJaskLCdILayOVE8GY+5o4CiAhbqpvBNg2?=
 =?us-ascii?Q?D3UJjllYVT+OpybpZ3tFYuhdOXaMhy23EkpJBqBbBZxt0PO1gI3NC+P+QkhQ?=
 =?us-ascii?Q?l+K18EkyT53foUfvJJwtu5mGE1Mt9ddlycUB3stBVEv24xS8LzhZAIh6LB7O?=
 =?us-ascii?Q?mxz/G5tUQDAbXVta6M9iqEXCxpCG5Wauh2dKLceQXeJPk9H5IMlHpYwvFGBA?=
 =?us-ascii?Q?p/S0Y20LZBBSdhlQMgSdT6PGIAYOy4KEdMAHKb2m+IE+a8BuCcZvr4FjlVyk?=
 =?us-ascii?Q?rARkDMqB0liKF6EKMBvGF5dYEGAj4sDQ0+/hUdBSQxxM6JwHx3UaIA5zZ7Q9?=
 =?us-ascii?Q?WHvRGOENGpkI7YB7ilpZb+EbfINit/m7rkYXaxqAThGAb4YYZQrTd26xRurl?=
 =?us-ascii?Q?fsm6oFfZKHM3mOcuUAS2Cox8L3hW8WE6IGCgzCb/UOhxosjj7wRz+z9AgxH9?=
 =?us-ascii?Q?YPp48YjvO+ZueC2go3wbQl9rA4rS6UbdTzfCBCrQBywqjwakSVmnkziqKoOT?=
 =?us-ascii?Q?YVtspWWkqtJUHtHZPP/eR1fAnw0VHERDm7RJI6m2eXaPbRzvyqZWMTvLV+Bh?=
 =?us-ascii?Q?XkBYDK/6M2pPPwSS/pO9TtowDu/vUvFWQ4n0/AKgwwKn6UOPdV077g9TtwMx?=
 =?us-ascii?Q?MMaR7D9V9i4SATVO5hXQd78DATEp/TdSJXeyrsimm4Bgimj/2QzYGfj68Uz9?=
 =?us-ascii?Q?g8m/Aj8MhrxQsp5/8E78h4OBwTUWLYPrTvBas6+Apr++9cN8GvHPnbyjSzpY?=
 =?us-ascii?Q?kMm7InB1sGev1R84hWQgGaNs0OvSBUwaWXqM6/H5ytW1uMp/vLODg//bBZi0?=
 =?us-ascii?Q?VeWRJQTFEfJegJdeALsZH/yp1PABI8R3b6uSVastv1xvciB5ZQsWjKBC3cG/?=
 =?us-ascii?Q?rBVw7YuqkamhpWqNCzfsy4XWjJ4cKdJZOOcwAEzzQgP6Ke7gnI4jPulNRgO2?=
 =?us-ascii?Q?YEQQdA2Vmftbj042D478qiMkRahMO8p/cLGAMl7oXxxOCKpSdO3stximKiM2?=
 =?us-ascii?Q?OsVGN/sH6EUV09pjI62thkryP5lB4syxEA9LzkOoCZxkQIQmcfiKH/KjVj84?=
 =?us-ascii?Q?7L/RPLMpxtowAjkc5JFngpAIk6G7pt3aaAD6KGimgdXXc8u/htMde0ZS+xiu?=
 =?us-ascii?Q?CiSE7YYaMHHPm7VZQX+ejS+IVZXGPOwWOeWV6hnj2qAqeKfIuleUqTKFicMe?=
 =?us-ascii?Q?n25g4VpBZ4Ai1l4mqhQHQ0i/em5iqJKDEEEWQFkAwUb8jnEaW9oM5Qxmd7c2?=
 =?us-ascii?Q?GEsaeTTpnOtydOt+B3gKrPkla5KClUVG4R9yn95kS+d+/5/2WPksK7zw5VzN?=
 =?us-ascii?Q?nXVs+sUW2Xnihk6KakDTPPyDp5PmQEWiL7xCYh+IkN0J4Vi7jfgErvN/rF2O?=
 =?us-ascii?Q?5znIlRHloqRoYTRatEP9rVeiVPnLYNWgjokxB77JxErDTT0qkzr629mmySU/?=
 =?us-ascii?Q?+5Xrm5YbbRF08C83CmEyiATuUhSDqo+U+lpwwkwYy9RB0ELuHJZlFJvT8gHM?=
 =?us-ascii?Q?IKDGdr0N6yxB4Nlrw77F8RSQfFb8wzrAX9+XRzk9p14XvQp440qKTkDGxNuc?=
 =?us-ascii?Q?8X7vxLLqAV6zdHf9v/qdgcLLDWsQ2DkWCGE20qiLzO5CuX4OLR/lpR3BRfRH?=
 =?us-ascii?Q?r09GOk55sEq4hEt3oNyY+tsvgE/iHS2p99k7fp2CsHzmO6GTeooeUDRsPN2c?=
 =?us-ascii?Q?zl2k5bQ67bUVtUmepyJnESHFIvOsHEp2QqYTmTPNCsx6UhKjc2WjDR9sYDWv?=
 =?us-ascii?Q?CqC+ObV2UBAvi87pxNy1aWUhFH3q5/N0osvl8Oc2C1rZTDWr182v?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b334c4e1-1926-4dc7-2b98-08df3510759a
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 16:28:11.9583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53wYfwnrYoIP956/aHHI3jr+OlPxmq4fUYhOcxU4wwpPYDnk9z5ihxwitCTIXQ2N+RoUgpcQkTm9X2Yn5VWjs684qGOVJj8CA0wc6Pwbmr70EBGIdIvZ1R2D11Sj7/6W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12068

On Fri, Oct 23, 2026 at 10:27:24AM -0600, James Hilliard wrote:
> From: Serge Semin <fancer.lancer@gmail.com>
>
> The DMA transfer status getter can invoke a completion callback from
> dwc_scan_descriptors(). An 8250 RX timeout queries that status while
> holding the UART port lock, and its DMA callback takes the same lock:
>
>   serial8250_handle_irq()
>     uart_port_lock_irqsave(port)
>     serial8250_rx_dma_flush()
>       dmaengine_tx_status()
>         dwc_scan_descriptors()
>           dwc_descriptor_complete()
>             dma_rx_complete()
>               uart_port_lock_irqsave(port)
>
> Separate cookie completion from client notification. Under the channel
> lock, move completed descriptors onto a completion list and advance their
> cookies before starting queued work. The controller tasklet takes ownership
> of that list and invokes callbacks outside the lock. Termination discards
> notifications still on the shared list; the tasklet retains ownership of
> descriptors it has already detached.
>
> Keep handling raw completion events from tx_status(). Clients such as
> catpt poll transfers without DMA_PREP_INTERRUPT and can mask the controller
> interrupt externally. Polling must still advance software-emulated LLP
> blocks and complete cookies without waiting for tasklet execution. Schedule
> the tasklet for deferred notifications and calculate residue separately
> for active and queued transfers.
>
> Serialize cookie updates with termination so a delayed callback cannot
> move completed_cookie back behind a canceled transfer. On channel release,
> wait for an executing tasklet and discard queued notifications before
> clearing channel configuration. A pending tasklet run can then return
> without accessing a controller whose last channel has been released.

Can you split into smaller patches?

Frank
