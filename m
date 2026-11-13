Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794600000;
	b=kH0v3Eox8FokjZR0mFuDJT/Fapptj21p3xumIyLrdqpQfUgMaseXxsF17kX43BRDctPF
	 o4aEOrDxQG8T0PrONJ/NITiX3NqmP+Ht2GLHG5yIb8YQ+8Iz1LYFwNgSNQebJfo8KCDy5
	 GS1TxzcZxAis3Y5sg99qgsjqeFY+IYRhuaVPxjaDn+zlObOz4nhpzoVWhrQCYVJvi3WRY
	 1c0Xz8nxfyj1/92wAUC7d3n98cAPkIL3ncILdziWeQx/61Nz/5ps3e3JvF9Zrl7jpiiae
	 DaPF7DE/44fihWOklHLQDVG8GW4riHzP846NEUhufy7RAGv/dgiL8irC+5gaIrl1NEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600000;
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
	bh=bcyEaCTJB5x2lTTiE9sRVpRFqS54gJwf/dcFY/Dj5K4=;
	b=AJP+KevZpHum0fpFzlvpOe6eoAY6F2d/tYCajJQelDUo0xO0rsUCDH/0CsF874arD3j+
	 LJGWmfh6E7ZE613F3xe6qZgAdDToNPw4108YjU12oGcL+TkL89CA2Wo+dnmoMUenz8wsM
	 9STsxZNYnczZl1LVlCqNcQZbhIhOAekej9n3YtW2jM0OPiz+qXfMNpcptBt+h1McKoP8o
	 lzp1B5qkx7hdnnhyyl+Jc0ZmW3n51zNSqmDebE4bJvRE49qIDZfDM1zzsyk/OochaFH5T
	 aLkV5LemIwZxzz4BaYYAjA/ulCjp8wVKpVHeaDNf40ox3zxtqzTi6DBMtwKui649RSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=EHbVxTWv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.59
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011059.outbound.protection.outlook.com [52.101.70.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32F9606AE97;
	Fri, 13 Nov 2026 19:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E32F9606AE97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=EHbVxTWv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGo773YY+YT2x9m17tJFt3hHl8C7IZM08MPD+nigmhtvq5Aq0+iTPmbUlKsSOdBEzeNsBWI7hRP4pQcUJ95lDZkqKjdScDHI2N9wbHg8cyUz4rptMWlrPNYIadgNb8iXNJXyOB3AXy4UQIX8dac+mdGzJvfGvl7suxnM+KbPgJ/liAsaC1jguHHwChz4nW5c1qSzS+iy3Up8Z/6Afs6YwuMmyELj1D88785XcnJNhA1vyQoP69kbpXZCCQ9yYGUzSwn9iQ4WEuh5O6R6rmisT29ezg2YMtgxD0Acq91OoAPwiQm0Z6OTgZxNgmsQFFZ/G7s/nywMoakfasAgwX1jjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcyEaCTJB5x2lTTiE9sRVpRFqS54gJwf/dcFY/Dj5K4=;
 b=TgIjM86CW0UiM0YY0O++iC5QxZ/RyHPHZZ0ol587IdYvuDfAvESqMAI+EbmoB0JSqQBz39NMCFev3L7agmWNzCBJhgNuYAQoBn9bLeZ0tHa+QwU32a/GaXNLAolvLH7AKP3MNqabK2daKdG/YZFP45Xzkb/Bjn2BCOu4Hg4osM/ki+/hm0dg0kChXeuHV8u5nP53qGSUbRzkZ4dIm8nGxVutaBrIvnQVE13dScJpSn2kv9Hs9mOuhuEoMZPrnRo5UjKiQ3h6mJZgXQYhWoEzxh/MzHMnzS0+E4WPm8rEZ1vMbbRyJWmxmKeU5C2NODS1XnNMjNlx4bPbLktL0xmzDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcyEaCTJB5x2lTTiE9sRVpRFqS54gJwf/dcFY/Dj5K4=;
 b=EHbVxTWvuS0c+voJojBbHpG5huFK4qZM3kbnTDWYw+qTSSFPUKqqe5076vTl91GOxOx1VAMA8yjH9TXmJYdOfDulzLg5JHnVyvtqPfodM5Sajr+E4DHZHS3yM/0VQhz/kQ8QzZEVOXld93QPRKvDQiuTvxyJ+s7uH75xrsp/LmboVtOQDFTA1KHZL+88WW/rH2d+D2qws6hHOQOcztOl5pHj8un/I60thOA8sQ665ouUDT8kWJex8TdwpBihLBaEskGluzIviISR5VkKvfPydAWmB2imXva5/9apDNvs6AzntQuqqUq0MguvSWwtv5qHR4TbQBLsrhvtPR0RGgnPWw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PPF06182BE30.eurprd04.prod.outlook.com (2603:10a6:20f:fff1::a04) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 19:59:56 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 19:59:56 +0000
Date: Fri, 13 Nov 2026 14:59:48 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, Keguang Zhang <keguang.zhang@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/4] dmaengine: loongson: loongson2-apb-cmc-dma: Fix
 cyclic residue wrap NULL dereference
Message-ID: <avdsNCgta3XIY4FV@lizhi-Precision-Tower-5810>
References: <cover.1792988985.git.zhoubinbin@loongson.cn>
 <e094c8dc1d01af2f296457f6c18b5d85ae76905f.1792988985.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e094c8dc1d01af2f296457f6c18b5d85ae76905f.1792988985.git.zhoubinbin@loongson.cn>
X-ClientProxiedBy: DS1PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:8:452::7) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM9PPF06182BE30:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ef2586-8b9d-41c8-2d5f-08df41c0b0c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|23010399003|7416014|366016|22082099003|18002099003|10067099003|56012099006|11063799006|261026140227099003|261102123227099003|261021121427099003|261009223027099003|261021123027099003|261022075727099003|261028144727099003|261022105027099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	ctRxRYIqEp4mXrUnL4TME8FaRkF4kBrZUssyzYHvV/YgjC+NnS43QHcOGiDkDIDgDHj9walRcOwmcycK8seS0jRClNY3unGZuu4MkH8ah2Nu459enY0BOUJ5datYbjNib486Y7/cu9+Q5tnsNSo9FX0lhXTP+LKhwNrZMQ85rNN4WpjtvExD9Z9b8Sl5UWsFSkL+PCFVTwPtrQK/0BTqZNpj+zlKbmpEuAN222/Mu6Y/7WFOsrQGjq7Z+KGPKb87ub/+M/4zurGPK+S0Bir3VYTsuy4wjXDXk+S3m7sk/0odIod3ENOoCSgCMkMgG2ey+M8IgfeMm5tscWKSP/1243pKY8gu0v+rYz4OOIAqLu/Hyrh78YSOXM8R/ozkP09f76h7leI9d3hzxBpCg0i3rcrfEQFVqH+1Bun0ywiAlOTQTB652SlUeY9XktCxe7Ab1mXksiWmuwVMXe+9RvumzC7XPTFm9LWJkU52n3axuETuFmEXf5xguXq1i4EYR5h+OYfkiDmKoMDdIoy1MtZR0ZstMOK6MjPHu3N8tgjF2cUvQKETMisIdDSClUDlpFHJGZW/h8jh0GV3dMdJjANo7ritRLDVFjKU1eeFQFOIbv+shaeo01luJhz4E+1VrlA4tLJScnzkUb/Kn0zXrfWku+Y4tsi8ngXD7IxxBOVPEP0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(23010399003)(7416014)(366016)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(261026140227099003)(261102123227099003)(261021121427099003)(261009223027099003)(261021123027099003)(261022075727099003)(261028144727099003)(261022105027099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AhzEAtA8Wzc1At6ebHK2VgDvpF8uut7cIbpmpUZRC3gEiNqekVM+hCR99pcA?=
 =?us-ascii?Q?psNxjohUof2uiBA8NogaXmNgY90XnPPhE1x30kN1RlloDgbaE32PYFRA2PbD?=
 =?us-ascii?Q?XD+VuzYmFhJWUof4bNX635j3wP/aVaL41Qfhoz29cj0i5gm9j6gWDhBgGShs?=
 =?us-ascii?Q?Ct4H/9l2Mkgxolj/tEBQ2WUXGP6AgKPt5YYlLbpI8PAmxOVVWEL+9XCJHjiW?=
 =?us-ascii?Q?LJLiVhKWFapI67yj3PJFaxwf5k2moIHDvksXhm/AGHmkkdYxl6oMc0BEPwYk?=
 =?us-ascii?Q?B8BlE5TlUKgSbXVBHMwHk1cvVbVveOOeKJjmt/rC7tuFNEyr+UbhmCgM7KZf?=
 =?us-ascii?Q?nEIfOCKttQYUy7M8ERf3fegyeqkOOcCCZ7LSvdw20EN5CrbcpuRLow+htKsm?=
 =?us-ascii?Q?fQTHqH033slN/dnb9Bk3JG8BqWlVWD1dt1CbQDYcEws8uK0HoBBJe3qQh6KQ?=
 =?us-ascii?Q?vlnNu2P4ekzhDCLur1ZipmIggxRem7O4tHuA607temSt0NUpKYg2HmclYBvj?=
 =?us-ascii?Q?prZ/To3KOp9G/IMTHJJbt1IciyV0L0cwMvgWdDMd2d+kvFaf+tNeFSR10xya?=
 =?us-ascii?Q?RhqrHS+QTcRK4FypHHVhuwg+jxty4SEfKGyh4pV9R0G17pVF3HR3q+k0b4EY?=
 =?us-ascii?Q?yU4tjhEdaBNetVJvi/D5V2UJgA9/MmPU7k9g90G4aSETZAMTUu2ywBEem3sQ?=
 =?us-ascii?Q?9eawXurIcpSzEpYzAKVI5Q+2ar2BF73qblODYpa/5v/vK0w4AkMp/FQobMEQ?=
 =?us-ascii?Q?kbVN6BTmAcwCpYr/lCnd6DVVAQUBXrqm2ainxfDp8YDkD50X1VkbiA5z8y+W?=
 =?us-ascii?Q?eZCo4JFGx/r5JMIM8+9fTg4XIt4srYebB93HxFRXcaFCnf5IOz61P2UsCLMr?=
 =?us-ascii?Q?Q40eNC232u5UzRpJjFymbptJigBkrcqvh6Lct7zt7X5NU5q1yXNsHFYuxig4?=
 =?us-ascii?Q?7lpX8AMaR6GEb4M60uE91MhbVlwGhQ1jEyWKAfjfLJG08lPaHoJRmNb0w+s+?=
 =?us-ascii?Q?xcS8e5w3RyFhFp/hsAgiJs8Nxp87t0QpA0qOqgPECNQWNdQXGKQkp88EaMIz?=
 =?us-ascii?Q?JBTqclPlUU1KBOZhyP5iHBTAOhDaUtL/vYcedwAMxerKUShV+2FPmt2ET0DX?=
 =?us-ascii?Q?SXg94WmNJxgebUcW2TFjzOgTAb4Phm9B5TcGc9vRoXO2WdJeM9qRgDmAhY/X?=
 =?us-ascii?Q?zjMu8ymKovWMSjn20fdgB3lzRtBqamMfrPriPibDtOVKO0sErn/HB84Wo3v3?=
 =?us-ascii?Q?1loTtuLLDuIBy0Li7OqrkyUwdKmbv66jE5Ip5pTO4gMUtukV+Ntd06ukok+w?=
 =?us-ascii?Q?lEdE5SRpHk2OcvvCKhrj7WcvAgvB8z38l1MPVR9O+UR/DQNlJtGZTBcJWEcF?=
 =?us-ascii?Q?X1vuMqCn2uvUS7P1nA8cqEyqSIWzUd/jNNOU9XNkguuSXCSMTpluRnCvldJh?=
 =?us-ascii?Q?/GM9eg4U7S64QERrY7ddHK5GxyQDchQi+Y5CXtQKNDaBNdisRqMe4rKDrbr/?=
 =?us-ascii?Q?PkCjTu4ZknT5cl69oWsmL++N/GnE83lbR78Oi4j3aadkzwW3IYs01lCmiYVG?=
 =?us-ascii?Q?bbuKAQw6oIx8e+f1lAmQ4d2zLjifR1KyPpoJfMNFiWeNNr7T8JzjZDprroGd?=
 =?us-ascii?Q?pHz/iPfiBq9FZKlwRMODf5ZJsMGHygwZWVz5rBaVC2PTxWw3QYrHyf5yVsK1?=
 =?us-ascii?Q?9txfyqy8RUk7SF1437nsX3WWLbzKpvLNbrUvtFdPgx/ZOiJdNr42dn20yV+q?=
 =?us-ascii?Q?3MLUl+jCkLbaJxsHKDng4NEvrhPrgC5NxH3GdQ2ob1ALavfAz7Ti?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ef2586-8b9d-41c8-2d5f-08df41c0b0c6
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 19:59:56.6482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0nfKZhgtnbQ3t+IjZU+N3u2s4WC81tzvBE7FserXii1DGAJVCrASshi+8S/173cbztVgaEBuNcx+uW8AxMxLektDhNN9+JGWbxk3sC2mcSP5CT4FeLmXO5OcL0FXaif
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PPF06182BE30

On Mon, Oct 26, 2026 at 12:31:20PM +0800, Binbin Zhou wrote:
> loongson2_cmc_dma_desc_residue()'s cyclic wrap special case checks
> lchan->desc->cyclic instead of desc->cyclic.
>
> When tx_status() is called for a queued descriptor while no descriptor
> is active, it reaches the "else if (vdesc)" branch with lchan->desc ==
> NULL and passes the queued descriptor to this helper. The helper then
> dereferences lchan->desc->cyclic and oopses.
>
> Even when lchan->desc is non-NULL, keying the check on lchan->desc is
> semantically wrong: the wrap decision belongs to the descriptor being
> queried, not to whatever descriptor happens to be active.
>
> Use desc->cyclic. This fixes the NULL dereference and makes the helper
> self-contained.
>
> Cc: stable@vger.kernel.org
> Fixes: 1c0028e725f1 ("dmaengine: loongson: New driver for the Loongson Multi-Channel DMA controller")
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>


>  drivers/dma/loongson/loongson2-apb-cmc-dma.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> index 2037120b23ca..f090fbe0b8a1 100644
> --- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> +++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> @@ -484,7 +484,19 @@ static size_t loongson2_cmc_dma_desc_residue(struct loongson2_cmc_dma_chan *lcha
>  	ndtr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CNDTR, lchan->id);
>  	residue = ndtr << width;
>
> -	if (lchan->desc->cyclic && next_sg == 0)
> +	/*
> +	 * For a cyclic descriptor that has wrapped (next_sg == 0), the
> +	 * current period only has the in-flight entry left; the entries
> +	 * from sg[0] onwards belong to the next period. Adding them would
> +	 * make residue exceed one period.
> +	 *
> +	 * Use desc->cyclic, not lchan->desc->cyclic: this helper is also
> +	 * reachable with a descriptor that is not lchan->desc, and only
> +	 * the active-descriptor branch passes lchan->desc today. Keying
> +	 * the wrap decision on the descriptor being queried keeps the
> +	 * result correct and avoids depending on lchan->desc being set.
> +	 */
> +	if (desc->cyclic && next_sg == 0)
>  		return residue;
>
>  	for (i = next_sg; i < desc->num_sgs; i++)
> --
> 2.52.0
>
