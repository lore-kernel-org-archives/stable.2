Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011039.outbound.protection.outlook.com [52.101.70.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78EB2E2665;
	Thu, 24 Sep 2026 21:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790283992; cv=fail; b=ukPIM3W7c8DBRaAPqyaANNQvA+gYwDFAlFEUDHw8v81uWTsF5otHWvaXul6y2J8kQOnu2h8Sr1Kr7LaUfzShefJrOmrKD5wJhQApvoW0a5sENnSyu8M7T9WX+7irT5cBOGWl0tfO4fJLROidsupf3yC+wOD+yiNd/mtv6G2JNZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790283992; c=relaxed/simple;
	bh=e024FW0cmIc8Ij9/dOSPJgzzYb5vIzRUsywinkTbuGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SZEyVYyHQ9UmsxDzpDk8XplSiqLVZhuhE07YdheIMnoK0ToGb+/ACHbD49KvGrn9JIYveoWyirqjMRuUxMrK/dsiOEb7eGL2+ra0avf8W56aPe1e3URQ5eFe4zc6wvxIQ9sXgebfDKdfTCqm7+YNFzSHDNoDZ2zsAPNb9k6s8i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=f0KBi3Q1; arc=fail smtp.client-ip=52.101.70.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="f0KBi3Q1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYAPLVdG5Gjsyun82Wq8zYQHND/bT7yVQTnpFKh+u2dKfB3YVfXJyw7D7jVf2T2Xy1oxVp1ODB3uoNllVuA5o3mDIChxzPZ2TiAbt8RfkSRysIgHBTvUMUbr7A2c9JxBREk+8Py+NGeWryEaIk+lIlAk+Io6BUF7FKsdGoP279mGQqkYj4ZTP9ew1Try2mNDZJiUId+iEP15vw3TnsSoPo0kQg1Lw7HCF2YEi5VvABZ7aR1ylF4XENqiW7xCYy6OGtGE5C0L+ubl4SFJo8P8U5Y4Tp6SWEMnJftY099Nt/gEraUUq8BFIFy30T7MmJHu3aZZGfKXncGffWcknKk/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3GDyn4E7Qnd/dOHjYGl9PLGikgN8yu+/Hq75i3vUdo=;
 b=CV0ugOfI6lHTAamJ0KuORk9cUFIUtPkgzQLYz6SJPqPNdUP3K2m8MFxeFY2KtbNmA2oCzMxhul3ZLd3o76/2xQBenjJMYnZ2FPY7s1davwJ72HPcPMffFUKcSD5OsLamMEomSl0/RrPNTslMGp5atFktJAgMTggLcfiEJtHI7XsQc+gmOqn2H57fnphll7cCgd10A6/mxopN+8xc09EJQtam6N3cCVEjqyFfc68jvBJNIhHcirximy1NSpbxhT8zef4HjGaCeMnXVT938QZi8UICYINULW87fudmxP2ETKxgKVf/iQah2cMGddhcYv4zkp5syFDI/PDiJFUBcla9Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3GDyn4E7Qnd/dOHjYGl9PLGikgN8yu+/Hq75i3vUdo=;
 b=f0KBi3Q1ygZJ4y/YFfvhJ3MOZBHWWmi6zh1OoQ0klnCM3ZY72Tt4iYZ5wv1T7pmTwMw2z6vfyRpeXS9w1WhCKT2Ur+s/+Md9/NaWfhXwG6YqkqMtYM11xAW0FvT/0hZS8FO8j4ANA4oP9J6Hp2nQoX9YXr+/FV470RcgfaNUJyJCx+/P2mrzN6yx4+t1oXPTqcXDr18ztf8DKlGUBj1cy3sWhUiNy5P7InQ4+57GqdeS9h+JrggAQO7OOm+48vhNpQhaydsw2yVnHn/L2UD3hC+MoUSGsShSon7sFakQySWhMRhKy1AUs/pnAtKMtkEnKGa80mSYz+DVqdtVD6YJWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS1PR04MB9582.eurprd04.prod.outlook.com (2603:10a6:20b:471::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 21:06:28 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 21:06:28 +0000
Date: Thu, 24 Sep 2026 17:06:19 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Binbin Zhou <zhoubinbin@loongson.cn>,
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"Claude Opus 4.8" <noreply@anthropic.com>
Subject: Re: [PATCH] dmaengine: loongson2-apb-cmc: fix descriptor leak in
 prep_slave_sg()
Message-ID: <arWQy89hb-_fkMko@lizhi-Precision-Tower-5810>
References: <20260905062833.272484-1-diegomancera.dev@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905062833.272484-1-diegomancera.dev@gmail.com>
X-ClientProxiedBy: PH0PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:510:5::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS1PR04MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: a34dc1e0-a965-4351-b1c4-08df1a7fb313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|19092799006|6123799006|56012099006|10067099003|5023799004|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	nicHM6uUv6RsDa28ApvnOG//m23l72t+TgYxdJDp45I82Xd+jvTgdvRdg/oi38Ih1h2V8mZdiDViEYh12AG118YaUDmdx2z+5Kw2/R7De1C0uKGFNiPOBbmTYZhFqbvX9y7SicGnjLYfWBdZO8G6oHxJ+5EWLtoT9NMr7uHKnu+Y6s6Zf7MTLe0uYzlN6iXodfm14vaQTIh11VUzhe3HOjAMVkmaMcLHbixcv16raGUoMzDiKBnS01cAEHbs5/di67whEXPSbq5WHmne3SfwH2Urwq3nuiDXPSP+qxnCu3w5xmxfCWoNoEkNQA30tmM/oq5E7khbCcDmDo+LcaOXyFvu5qdHMWmuw+BaNP77N3cwaBlrY5GJnQuyrYTlut6F12DyKf492YcsvXlUSQ7q+/BmE4BimND+tauRAZde3rnL+WJl94BuW53qKY5z/Px6AWrMDiMefQBCUb9cklMqNnWVV9B3CqOESqeak/i8rRXdBWjJY7emtWlDlhdQf7PpWtYaWFHdPdmI/ixil2R91fsW5QOYAyuNMcNz4OT5IVOEOfl/b99V0r5l4kKqyllz2lS+buOPrfU1DkH1BvHwF6Qip9rRMjMHWNnCQSjCb+ZN7sXBdGTY/vEBlh5feQF+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(19092799006)(6123799006)(56012099006)(10067099003)(5023799004)(11063799006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/iEMluXxPMo0XJ3F5VI4vqXS1Np8ItghjkpuY2Q8Bu4I+PEkgiZ73PmlTC3R?=
 =?us-ascii?Q?ZrW2mWIREQDWyqCOMBaOqJd429fM869ySQ12f1DVrM7AX8tV3whFJ2GTXxhf?=
 =?us-ascii?Q?MG+2Zii/lep1Ewz/cfMr9t8hnvmfIktOmau47c4RYfHPY64FUD6z1S+2XUs8?=
 =?us-ascii?Q?kZwUCPcEh/LRJ2xNOXSpM7F7hFkt1XaIm8a737/W3z7B+PkHgw/eF17t/O9O?=
 =?us-ascii?Q?cL6yWsNuvp+aVkUGy4U1cX37iQdsnmBYyOWMU+cGMCqSjG/Xto9e+mNuPoVq?=
 =?us-ascii?Q?Q17DN02MHFqEIum4r8hY5J+vi6di2MXQ6cp9lGEQD/bXOaIKX04jAUUa+o/a?=
 =?us-ascii?Q?qmA2OyvUbXjGs0oDe1avtdkq2ziIj3AHZvPtpuARpLc4PEbkV0EIcyecJ/8e?=
 =?us-ascii?Q?+PvFFIwukF4ed9ofp0Ch3/aeROMV4745lp2WReXtlL1qYpE96t/6vEFFigik?=
 =?us-ascii?Q?V68xFRcqEXqyeuRBubMbtlQ8FhcRaU610d/gRzVPPTDRkxi3xNz0vvcwcy61?=
 =?us-ascii?Q?y0NclWIq2kGtNYgBbsDk+zMgc/KFxz3WLiaj5cM5mlzvH9Ifu6ynz/MeODmR?=
 =?us-ascii?Q?f8rc69LhDrSLjukA+mijrIfQWq+DoOtgDwUiE8LOWAjqJP0gLyXaI+MVE5/j?=
 =?us-ascii?Q?w6Qi7nfQMJ91q9OdWU/u+vmFfoGOPDclXRukZjkiHnhI+gNzXpEG+peOnsRh?=
 =?us-ascii?Q?iXt2FdpoXnBpY6zbY0IlG/ECZe+gFlX5aT728Gpn8IaSdkd5vAhgPwnlqugJ?=
 =?us-ascii?Q?EwBsRcTOY8LcTX+9CVI2gv+0F1yKiMb8FULJoAyeK/sX86jQj3kjHinm6NBG?=
 =?us-ascii?Q?OsP4rlgC8WINVJpqrE5qy7bNQYUFk4iyA8Ww5VF5Y07c7p1RQaMFXL3Onuk+?=
 =?us-ascii?Q?+6b6aeuSS/v9x2HPROLIlpCDruIocHeAYMpSk8NZydSDC7ZCumxu9ObKZ9uk?=
 =?us-ascii?Q?RwY2ogcadEzxriaV+mnw20ZjRK3Iiana79P7jzlnY6MwZ9j2jLflW1uW6mo4?=
 =?us-ascii?Q?rsKUEY7txVvrJp87jahJ+7LgU0EDdmaZtKMjyqEf2R+Da3JhtCeWLF3bpX4Y?=
 =?us-ascii?Q?8KRcLGbvN3ZeAAS+87Qcc9/OWdL5yIx7laULZXpitW0vvHsJiLOhud5wFoG1?=
 =?us-ascii?Q?Da2KHpkru6pA9s/SrBscgZ7BpnW/VPxCWWKlYcpiW1hmnwQPfw8updHBvgSE?=
 =?us-ascii?Q?saED7H1xuettScOsT0Kqr0jhYia2r48Sdwve4vJ+H919Bk+hbJ5qpWu3KGq2?=
 =?us-ascii?Q?NYBRqiZhcd5R46Uyf5qaSEzlMLpiSEq9CXP20T2n2Dr9DRxyD9JnLi6DGyJ0?=
 =?us-ascii?Q?21gskmJ/g7VJrkIa0y50Y/NxKgvPGcv86CFUVxFZH8jNcLhOifD7NVEWZ3/p?=
 =?us-ascii?Q?ndChjT+MAyplkeU1ph5P/io4O1z56IZ5HvnEdpw2APPomZ5rgvdQ1oB6G8Uh?=
 =?us-ascii?Q?DPYFPDJHiz40uWTMFQG/KjQ7PBBQKG+01yOcSLc9lVUqzB83OGCeH9SNOR1R?=
 =?us-ascii?Q?tp4D06TiBcM7v36DPLyIhpzOzfSt9ED7GQ3NT9byeacIQNIiu2YSsrgyN9j2?=
 =?us-ascii?Q?H3J0tG8pPfivq/vBbfHAow5fDjSz81uoci9XYYi+PCmL+usyOiBVEtJAFn5Z?=
 =?us-ascii?Q?Aad0GmMUQEsCCBd06BmuOBFODWQ+HcvW9cGOW5YSpz4Fst+7WD53LCQwh8qS?=
 =?us-ascii?Q?tymhhVVKcsPqemTo2Q/CGMjq/RtTalqbkAD+itmbmJp+BjsBwyr9TLGtwHOm?=
 =?us-ascii?Q?cvY4McIRCkqBrYs0pGgL2oPW5iNEru1D2bm+3PpqChn+pM7bqNDi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34dc1e0-a965-4351-b1c4-08df1a7fb313
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 21:06:28.0848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/JL9LN1H9oCB0/dD+gESOpAmJgFHMZ4MYP7t0bKK8nNUj5wBVFEKQS3ASPxT6+0qYZPh+wvdbptmVE7PF/zvBoZ7TFlbkNGK3aNvVdyR1xRDKr/8Kuqcek+7qlVHYSF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9582

On Sat, Sep 05, 2026 at 12:28:33AM -0600, Diego Fernando Mancera Gomez wrote:
> loongson2_cmc_dma_prep_slave_sg() allocates the descriptor with
> kzalloc_flex() before iterating over the scatterlist. If
> loongson2_cmc_dma_set_xfer_param() fails inside the loop, the function
> returns ERR_PTR(ret) without freeing the descriptor. At this point the
> descriptor has not been handed to vchan_tx_prep() yet, so nothing else
> will ever free it, leaking it on every failed ->device_prep_slave_sg()
> call (e.g. an unsupported transfer direction or bus width).
>
> The neighbouring error path for the num_items check already frees the
> descriptor before returning; do the same on the set_xfer_param() failure
> path.
>
> Fixes: 1c0028e725f1 ("dmaengine: loongson: New driver for the Loongson Multi-Channel DMA controller")
> Link: https://lore.kernel.org/all/20260818094957.7D2221F000E9@smtp.kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
> Co-authored-by: Claude Opus 4.8 <noreply@anthropic.com>
> Claude-Session: https://claude.ai/code/session_012bUV3WshMSfTq61n1cgh1i
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>


>  drivers/dma/loongson/loongson2-apb-cmc-dma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> index 1c9a542edc85..60eb4d961610 100644
> --- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> +++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> @@ -404,8 +404,10 @@ loongson2_cmc_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>
>  	for_each_sg(sgl, sg, sg_len, i) {
>  		ret = loongson2_cmc_dma_set_xfer_param(lchan, direction, &buswidth, sg_dma_len(sg));
> -		if (ret)
> +		if (ret) {
> +			kfree(desc);
>  			return ERR_PTR(ret);
> +		}
>
>  		num_items = DIV_ROUND_UP(sg_dma_len(sg), buswidth);
>  		if (num_items >= LOONSON2_CMCDMA_MAX_DATA_ITEMS) {
> --
> 2.55.0
>
