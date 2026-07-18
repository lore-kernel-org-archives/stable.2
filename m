Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43423D6476;
	Sat, 18 Jul 2026 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784386339; cv=fail; b=ZNQ0WJLh00aKkyZhK19frAAg2SD7zGnxS+KeEITufsmQ5A3o7G4Kqg/MxR8AfTN2OgdJAFWSTAQAvY8sRdKUhMTqN+wnbwyuRqTJ96VGGOiiqJOuaE66AcOl64XL06jZdnNpD/RRjzKVCvFCu3uqXcP6wzQWbs3FNKzuQa1GfYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784386339; c=relaxed/simple;
	bh=21NPOp8PTqSCGM1xyr5wS8RpVhEm5yeDzVqPdEuQSs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eAl3blOiRpz+7GBnsWQzNqPijjvpmEh1P2AWMBvOmmOQfl0MSZrXJfEoCxtdAxKnMujpHZfQl/gjZ2Bv74ck1Lc8q2VTUUxZHiGIke2XKtnidvNmoVv4JMECFU+RTI0C5dLptPyy8+q2XI4S+r8fyxgt9S13sqXerV7v5EPx494=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GtGgwtJx; arc=fail smtp.client-ip=40.107.162.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GtGgwtJx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlrljI622I8kmhtnfRPx1IMtNot0bemiVh8w/Usdzs46MPmb91c+P3J6KssURoR11ARBH/6OnMZQKmuUZSJCYfArMd74n0sDatUqnwAeNY8D6EPfRcjnDSyQzgFLfG60kcss5ep84pHE0cL52YrP16kSInfwpU8YbHtK2vhFC1E54EmJqcgNW+/W3WdVKPVX8gXLAd4YpOo7sZFZlMsj29Im/Wj3PXKq+S/f7JWTej8JA0rdD7uEp3bl3GP16kkAnPm6bd08+5IorIVg15RFkwWncs8+omIYLy3kFBpbKej4SOuWoz8BvpKqZ87bC1rmMwSVIKnmSoeSKmAXY24p3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuxyRagSdZXGI91t2BPx6x8dzOetkcKwH6L6yVVtoYE=;
 b=G7jitHEotyThJdLHFA9ngtk89nI/05S48NGHIzOCoS7dS76MzVnPK62vVYGqyIpQrGs0YiEhMy1EsovfYVgBkECtTLWcmNpWLl2r00b2CL3dXfGDGzRNUGJZDBeMPIG+Aex5IZifC6Z2/v8X1ccOfw2P7mF9ruD5OaR26JPvlJMb25rxsMO/ptnLAIUN1pz5VjzFHHomOFIZ09vZPRA3QizrmxICZjPNeq80B+OPhB7D4Tv4TJTxS3fNjvDqOyi1lRWjyatORVChBqjCj1e6mcUq9R0LUpEVkiuI3OVMutLWOPgnWrivMwIfCzNVNp6yrOY7u4nxnN7CGzGgRGH7oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuxyRagSdZXGI91t2BPx6x8dzOetkcKwH6L6yVVtoYE=;
 b=GtGgwtJxE92zVWNH4yLCh1vR0GN/sPhpZGu7D5Baobcs9b1OV1mFkmqu88ZYZKIBCWxF42AqzUFGnTl8GsrJAumwnKrwIYQTVV2+GxwcHR90kaEsnWlPly83Z5OqVU4czKnaQXa9TnHUgjCrMCQOeYNYQPNB2ABh2HDvMdD5R/BcYtiev3AjXHoZ8im7W+ctXnLD9InzLVfKl4zMu6tWm8hBd1h7ZehhX1ALeXQLkKPpIQXsB7cVtvD33qLec2ateh9sHJgucoMnhsP8xBfiW73giAenSheahuNraeOfcwnKz/PUeAbspeXKy+ze+LC9C+fR189F+eDuRNU7WD30WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB6861.eurprd04.prod.outlook.com (2603:10a6:803:13c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.14; Sat, 18 Jul
 2026 14:52:13 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0223.012; Sat, 18 Jul 2026
 14:52:13 +0000
Date: Sat, 18 Jul 2026 10:52:06 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: fsl-edma: tracing: no ptr dereference
 during log output
Message-ID: <aluTFpOQPda_vKNJ@lizhi-Precision-Tower-5810>
References: <20260718130024.341243-1-martin@kaiser.cx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718130024.341243-1-martin@kaiser.cx>
X-ClientProxiedBy: SA0PR11CA0053.namprd11.prod.outlook.com
 (2603:10b6:806:d0::28) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 966c0e4e-5f59-4d73-b967-08dee4dc272f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|19092799006|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	NhdNrOgLb53dB+OF+HTyyMPn/hIkn8iSHleN9W22ic7fUujpPPNZR0Of6AzTQbh0g3UUqVeCk5yyyT31SeSua08amb9a0E8+daAwX3O3+WohjoW0rtuytD1BSqWSox2pB7PfjSJ4l/zib6DgYJxEhvzBDkmCkY+oMTCB3x0oNFM3vbcZh9NQGdfS3t5XEFbcYabR4/FWsHxnC3+aaT+7BafohrRsbBVqfCEQN+Nnshr8TnEQbwG1N+ZgGb0jkeeL53pu/UMk9vxNE19lIXVruPbyKNRn+U0lMQf2s11rjYsGRrctYS3GI5nnf8jYvA2KnOeZ2XvlkYaVgscqDLYmtUXXHCq3qghldFn8DPkJu3hqWQQ2A8a62vQ9H9ZdM32Jl7EalJO3ARAC1SxFbiiVvUIZhOL/VI+12Jdu+VvfZFMZFpR7XM7EM06H+9jFh3iuvvVJkbZ6HOpVZidMWYPu6Y4t4pgyqQcFo2dIezRO9FgGpB/h4xqXIqRt+V+TVx+SiJVZRzBpo5JeVcUPHNBMg1uWLU7ZMCa/4gyLjJuYSdO8jkt9hdOi39BoON93SZRhBDDeAd0zKf2msZqmJBjKSeZk7LtwZVxXE3cNdMiwdR6Gc9pnoN4GmZNzCAmeDYh6cGrcHI6cpCfZf7Jx0cEihARqlUlUyWGl4uiCAuKRXPg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FKxlx3NEP7SzBX4owT6dM10Vryii+OKPccVDkP9EKKjPwnxkn0llXF5JDNnx?=
 =?us-ascii?Q?yO+CXVznbUoEu39aIJYL+LjrqLV7YGExAV5DCWQbtIBq92zO5ZjSVJrK78aj?=
 =?us-ascii?Q?aL4SIzM9WACnhmIkMD3GBV70MzC+HUHhmEfM5d9SM80/lm3BxXU11C1wupGg?=
 =?us-ascii?Q?0PeD3uWkzR90LD1Ky5Mz2KRPGZFCg6dQlRvzpg1GwwY7O+rccrYeZVtNozzP?=
 =?us-ascii?Q?q0V3dyW1UnDR3JdhYyjP+549FdYuCYMjwE5hGx5VpK4lxwk7FXdQptgUg2pV?=
 =?us-ascii?Q?a44LaJ4gDqtn2T98YH7ddLwRFw8VCFij/Vfr0bMtHHwKAXNPpCF0k6VfnUht?=
 =?us-ascii?Q?IBOH+SSEwcbgr73y8LQjUTboDZUu/9di9amVUcAJY386aUDZgKE4Pw278mS0?=
 =?us-ascii?Q?nGrNFvlkPa54E2POpnyrFHsyfVetTS6aHGDC5s3DkCIPbeoVPrBH1FrZOMxy?=
 =?us-ascii?Q?AI0mQwczLffKfHqhD9HFlZ3wydTFESQtJyeiPdUbQW6TdSU0FbupoGnI/fPj?=
 =?us-ascii?Q?B9NyyGkHgPEEppo9Wz7dXcS1VMcjoOamDhxE+d2FJImEHPe34bx5UoNM5R70?=
 =?us-ascii?Q?OehfK+zuzIhXonJilR/F/77dwuR2PB8lZfRVt8Lqu0tZfuibw1sm3Vrkm/GO?=
 =?us-ascii?Q?30SkEeNrDAGYUIQ2Een6CIoSRxF2Y/pw4XSuH+mqJ7WYe4wqzWOzxEngJjsw?=
 =?us-ascii?Q?29GyRPsmPqKy/cio2j+uXm5etpVWY5ZPCcQWfJtiqeJHo2IWBzZuDMXBb1Eb?=
 =?us-ascii?Q?ohKomWa1T5DVz608/3OQIVR1FYVh6ixT/730y2C5z6/spPLERt1NimQEYhw2?=
 =?us-ascii?Q?8upPUG7cPbJnf7o4pfR4LxCpvZXoACI9CU+Ca4Q+aUNXwXXK49Q7vhCM/aO/?=
 =?us-ascii?Q?a4IKGBZ+UysnFZVkrBE7ATEGPO1JxsxevmCOFlf+1oVOHSiOIP9Db62aEN5S?=
 =?us-ascii?Q?ZVSFLB8LhgiJU0urv1MRhz8iIiD5zwHxva1ZdI6wu6Ch81OSNWY7bGoVjwMU?=
 =?us-ascii?Q?3F4l1+YvU89LweVn6AhULpDvCQuJSOqWvGy9mTt1BIm5ntZ4I4FA1I2pwc0w?=
 =?us-ascii?Q?FOYv+kBTSZ0ZhXcDemMm8foy7qkfiMJg/MJmqC3/6SAnARnR3xBmCDJBJBKx?=
 =?us-ascii?Q?lptanYUxNboOjO7IeUrKO3M62bvrHxmoLNIXPIaP30JLtqqereFZP7prjIZ+?=
 =?us-ascii?Q?dFK4xys/cPpjQnRqH8OWnsp7hYTys9/CXwIBlRUzTF13t0nHdpdFnVla+aGt?=
 =?us-ascii?Q?lwgJJPZ5yb1d5EKjk9gaXIonIp3fq+/fMVvP6DCLZAzJ7BKKHTV4jgOdNQvX?=
 =?us-ascii?Q?G9GuhUSyU1+Z4rheD6v766xMpHtE5CufVVr2qGkvkf2BJgiL9ATOwvoHSi2T?=
 =?us-ascii?Q?UTedPW+QUGsvhDoYr2vhy4ilIhqzvhphhXKUdbq/1TmHZwDkdCNyxexGUJ4c?=
 =?us-ascii?Q?AAWaj2+K4mJHQDyTJv0pTnBDygOcsXfwYWQaTC2fINjYcfveL11fQGFtgZJK?=
 =?us-ascii?Q?EbhltCHtNJ5q9wGg3vqtF3mOypwE5QGxbquTqexhHKIlwGP4pXOiO/gdryCC?=
 =?us-ascii?Q?HsSj8PzHj7VDoabmNexsZBZxPSx1xF64YNKKYi4qK0Y7H4ZDPEpjB3MaHbM5?=
 =?us-ascii?Q?dNHKJFfXad9rIKpBKb5o2ucwFj15MWiyZ63I6TWhm5bX0sbEyXrm57ACbQ4q?=
 =?us-ascii?Q?iIpnuTtsLmhyCFLCB1L1dK9ZLEX1RLEJRk3eP5/9zMtQAdDs3kQAHSXNuEW8?=
 =?us-ascii?Q?N0TPlZfamrdxAF7skYaMnEnmTfnWg6fSnJubsEbw1BAoAJs8Acxs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966c0e4e-5f59-4d73-b967-08dee4dc272f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 14:52:13.6188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0g19FJLt8s9i1tWXXc70YGd9nU8B58QNecCOAV2YNlH27o1YosCY6KGpqcT+5tuiHJOnWDAT1tnMc7eyf7VXMIaSUHoQmi04JMIfZrYmkBogSeA4qeE/JuM8/lCaazp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6861

On Sat, Jul 18, 2026 at 02:58:48PM +0200, Martin Kaiser wrote:
> The fsl edma events store a pointer to a struct fsl_edma_engine in the
> ringbuffer and dereference it when a log entry is printed. At this time,
> the pointer may no longer be valid.
>
> Event injection can be used to trigger a crash:
>
> $ cd /sys/kernel/tracing
> $ echo 'value = 0' > events/fsl_edma/edma_writeb/inject
> $ cat trace
>
> The log output needs only edma->membase. Add a membase field at the end
> of the event and use the new field for log output. Keep the existing
> fields for backward compatibility.
>
> Fixes: 11102d0c343b ("dmaengine: fsl-edma: add trace event support")
> Cc: stable@vger.kernel.org
> Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>


> v2:
>  - dmaengine prefix in the subject line
>  - Cc stable
>  - Steven's Reviewed tag
>
>  drivers/dma/fsl-edma-trace.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/fsl-edma-trace.h b/drivers/dma/fsl-edma-trace.h
> index d3541301a247..45d964a3726d 100644
> --- a/drivers/dma/fsl-edma-trace.h
> +++ b/drivers/dma/fsl-edma-trace.h
> @@ -19,14 +19,16 @@ DECLARE_EVENT_CLASS(edma_log_io,
>  		__field(struct fsl_edma_engine *, edma)
>  		__field(void __iomem *, addr)
>  		__field(u32, value)
> +		__field(void __iomem *, membase)
>  	),
>  	TP_fast_assign(
>  		__entry->edma = edma;
>  		__entry->addr = addr;
>  		__entry->value = value;
> +		__entry->membase = edma->membase;
>  	),
>  	TP_printk("offset %08x: value %08x",
> -		(u32)(__entry->addr - __entry->edma->membase), __entry->value)
> +		(u32)(__entry->addr - __entry->membase), __entry->value)
>  );
>
>  DEFINE_EVENT(edma_log_io, edma_readl,
> --
> 2.43.7
>
