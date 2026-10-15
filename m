Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012043.outbound.protection.outlook.com [52.101.66.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945DF3D9DC9;
	Thu, 15 Oct 2026 21:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792099262; cv=fail; b=rU8XS/vXEiBHOxfk0UPVJFfGlYbeGPImn7Fx+zny9l3ZQO1ldcg13ZZa4Cx5/UGZYHeuwqiMGP1Qlw4sWchhKtQHkyac/WqXlnqcGf1h+6w1YMAKEOYuU25JVaMkxr5e6vRHuNulIAyT88kXYIQOD0lb7DOswpfABEFTERNrPAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792099262; c=relaxed/simple;
	bh=TAu2Yc8hJQB5K7yCOOURGD/eq443EneNEiPzqRaH7kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B+E5Fu57Lp1nhOFobrTA+giTxKCD2t/8jSmaFBFjHEqfS9f4g94rXA28oQODYhdQ+RmYLSIJpGRfiClWDV6g5X2Qqt0pCFMv1hX0YKYGlw81cKzFoWInD3E/r3zEopjH0TJnjtFmtHWbno/irChs2WBa6rCSZSEsON8mu9Qvp7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lYu3eTer reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lYu3eTer"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPErDv7BOa/DTWhV2pV+Jf3Z2mJtHvq61qDHjldqRlyTAcJSxXYlhlvirn6s7sNcboQ/cs21PfIJW5LL2rmaPEJXNeU7ka6mO70MWHb1fEPh3V1tCc3Cyli5qUVryuhYgcVXW6b72r8oUL+3DWH6NcQMboMtBdYhiq3/Q0DHOKHpNaGEoirncjkN285U7bBR1NL2ZSRP6DQhdgPYXyOVKViT0bGmiSB3LOtZJnH1Vf3pKLC3NWSKpHv5DWfLXe4PzNvlAth839tp5uhT4aT+lDz3WcyzQVSQi2cW2sIqXYZuetRHLbwTzx43rn6LUAswLEvAuQhc/d+z/L4fggipog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDtjVuNk4oKopgFv4MiOnufoBorCTv61zC2WkctDLkk=;
 b=ug9ewJNdeju+XQIkpj0pjCGe5dnHi3zZ4jSPfGGAtwGJxqu2zo7pBINvUGOWj6aAA57e2PgANYYHlmxzW9LNNoOTV5TmuSdcDVnr3jp6S+eQiSBE4aUSviDXP47HVqjACKh5B+6NbUty4JuzPp2MaHNagGqT2+4F9yAnxq8vmyEOkevv2E2iaunZ7czpn1GcuogpMc8l795NcY0Ur3yyOCo7MHkt/6V0Muhm+7w92rh5HgfOtih/8Oa8qL3awisX1SWK/Mmcua85134kogYWXC6BIdp4nzE7O1L2gUVdxblgo2P+y3qnvqP8xIoB++aIQ506J9Qf1V5kPyp+X/x2Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDtjVuNk4oKopgFv4MiOnufoBorCTv61zC2WkctDLkk=;
 b=lYu3eTerD97uP3qqy1fpNhSuscfzilgwbkyjsU/vlHL4ch9TLXLCJFkoMYJginD3HkosBGF4xmmoeXUf5WZfCNZs4J53W6mGLGSezVt2/qD17tcAQmXAh1EcAdQ86nwE3aTC2nFoDOiV4Gm40Z5BoSa+nRD9n/dxO2/y7qUAIRdmgj2u41O1NhFaPAdjVGbqwiJoJB7uH8U6/w6h3a/ucCAXNwXIfmGKvMHiIFNuZ82wXW1LSYdFqXX7+VmHYPdvVvJIKF5Pd0MYNyv/b/C65DQj+U2KOdHfc5Ow2WTq+DE0Gr0Tyo2IE+C2q5wUhqC3gc5R5ws0bggHLSHUMQWQxQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by DBBPR04MB8012.eurprd04.prod.outlook.com (2603:10a6:10:1e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 21:20:53 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%4]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 21:20:53 +0000
Date: Thu, 15 Oct 2026 16:20:45 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Richard Leitner <richard.leitner@linux.dev>
Cc: Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Carlos Song <carlos.song@nxp.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] spi: imx: fix slab corruption from undersized DMA bounce
 buffers
Message-ID: <atFDrV-RQEd_ygz6@SMW015318>
References: <20261015-fix-spi-imx-dma-v1-1-e28259671392@linux.dev>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261015-fix-spi-imx-dma-v1-1-e28259671392@linux.dev>
X-ClientProxiedBy: DS7PR06CA0043.namprd06.prod.outlook.com
 (2603:10b6:8:54::25) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|DBBPR04MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 45986f54-39ac-44a0-a45e-08df2b0231d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|23010399003|366016|6133799003|10067099003|22082099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	fstp/qdAfme6UVLRzAUUGEJlsvJU4szyotdSm+e8NGoFilR44LMRstiPPx2JRm+mCo2VJgJ+L566P/rW2yG6stM9S22NJYAojNNpgs+x3axWl/kFeO4WsACrAVf5X8V5Q9uWt2D32PjVWxi6G/PCXcyHSe7tZsgyErGMo9JnuwcuivMISKtteplsWSKGu49nn1eXDfiKAr3SUeprieAP+JqKRElY9p5ogLWC/CuZtEfB21HxA094PmCYpJhvAl7tX4rqpPPWBikecSaPPvpccqKc9CbIe7Wdg7iwZLbj8MJB/NtX5kq3EmsqsZ0g6AXfnS5TF+qMsErng2GA2pNA7Gz/meRrkyCxfKjRK5w/aGjfoVxMSh0LIeGckMzJ7LxYm6iPp3TXkUYxPuOTah0HyGlFYcEpgCkb8zmcC18guIm/6tevwuDdWoU59UPWOUGTkC5BdKIPFAtebJJuAgRCAaDDB6FKShkb/xURme1me+PLLeh/CiYm3fEifnJ8jqhAW9+srtQlxqN67+HtfamYipu1X5HOpqfY+hzcnpcsKrsibd6ez5/9fUZVa+f0Dy2gezUMqWA+eIQ9pCEUl6c9zoBYTLv/OeMn1M8JIFTKsogPjGdMPT+Kqa+9CodVJXzuS29WOSyIFNYzBk/vMzJ+zGzIoA0buPDq4AGY29YeSMw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?K5zPjJFdWvBMWgbY/04/USzv1B6px36ksylEtYCyRjqqviys76qPLgtLKw?=
 =?iso-8859-1?Q?KMKlL/+qnBNQGO0NsyaHXEzfGTgcum/sbJ+xpMLUSe83JsiAJ2SIeeyjCg?=
 =?iso-8859-1?Q?p1S3yPkyGyf0yYs+03hH5usgeZNWjh8tuchIyeSTMAztPYPTQoixHl+RAA?=
 =?iso-8859-1?Q?ZqHlPDEBl529JZZFVq4KPtzI43aFyHmhGjLGTQC6nVDLX1Nn4Kpz8+wgfj?=
 =?iso-8859-1?Q?2aG8yZX6lW8lSPQ1UhxyKicoaC6jzSW+8lI4H56OxxsgJrgvKzoSIcEW78?=
 =?iso-8859-1?Q?LJrVe8iBQONaBZq7Epxw0A75A01wHe1P5ldTthNq2HTL/t8qEoegNELtIy?=
 =?iso-8859-1?Q?D7WRK1QTt6MyR0X4h6xxQcmF6dQUbPzFVS7CapNbViswPWvz7xxjDaLhIH?=
 =?iso-8859-1?Q?HmolFR3J0q/YGcMD8YGMwV+1AaF/IgCgPesrip/diM62Vp9pZ8h/ZZeKd3?=
 =?iso-8859-1?Q?wueNZEn2tG5qP38RS9FMkd0/D73TKS9SYJb+3KfrHkKdKKGic2XnH6JqwU?=
 =?iso-8859-1?Q?O6y5RZNiyYLm/cAxbh/IlgqDEMlQiYcBuLoYyCuIW1xM+q0rk8gtgKpv+O?=
 =?iso-8859-1?Q?aaxcpbojcH5j5xiLGNUMw+id0JAuIVvWVWUh67bp50gBpY+QbRwLxLDVP8?=
 =?iso-8859-1?Q?YA1ykCEmOgGayvDcLARB+p3aJ2BXAcyq1isV5wu3kGh9fjQt86C0RVTXlB?=
 =?iso-8859-1?Q?nkZ0FTzQ6rVsRc65udSC+IFb1ap4WnQxe0n6841AZluMcenMw6L15LSKpZ?=
 =?iso-8859-1?Q?mjtE8JnUoZFlZg31gWofpHcRifUO3o/M2qxHe8P6i18P93hNoeqzK/rgIA?=
 =?iso-8859-1?Q?L3TCUSUGSs9kqgdjDYCLT0asRk+FqwoOrd3cBVvgBv1P7zTFUATWC8djNi?=
 =?iso-8859-1?Q?zXP9LC1uaJ6p8t7g9SsUaQcEixFUgp36CF5IFglvI+XHXYLzquuc0xBQCi?=
 =?iso-8859-1?Q?WoGDkq4Bo+ZwNUEqBpnpvQoHxKaukvvEqZeEWZMLVpKIrGkASKiDaYLE3T?=
 =?iso-8859-1?Q?EFudQDl8QRez5nZd1+/N+b73tQYin0Tdjxi1dKGv0AAsLXq/3V1ICAxQPF?=
 =?iso-8859-1?Q?QpWz/zWO/z8UD837C+n8OMIWtuXv07tgnXtJtoDhRl+We1ueNPbdp+caCl?=
 =?iso-8859-1?Q?mJLZMDpgi13o/KNrxZd0isYksb+vZkMkI6RtAgDLkKBssrw14v2dZXWaJa?=
 =?iso-8859-1?Q?1QFSM6FhWvUIPjombmD5Uwk4VTWy7PcHJgHo81iKFlnOt9lLPAGeUmXjKJ?=
 =?iso-8859-1?Q?TFSAZp/EIysakgNJLg69jLv/USp1hJEMkeO9U+1TE5HZkrRd8zCV2LBkML?=
 =?iso-8859-1?Q?nLOLUigmdzhC5aoqMw83et3j9KSEwpEGREDEUV0RyijPeesMNnoqWqb4Xn?=
 =?iso-8859-1?Q?FTmJ9GF9LrnZAJO6j8FBU6mVPqPK4zYosz2GrFmIbDeVXxVv7dkMCVDSZ6?=
 =?iso-8859-1?Q?dbTJv7arAcPm3+BMFGkX+9BVPu6wPIhTK+v95ao4g7hgcKmtoWi7Y22Lmc?=
 =?iso-8859-1?Q?asFLLbMXhK3bDZtpDIEDFAObi3gxRxa4/Uj1zjFGxbqF6aE5jPspKUDFC8?=
 =?iso-8859-1?Q?c7OPyomTI7JM0hJJtXafDgwM9a40d4WMyCCHTITYfxUP9OaJDG10BjQO/x?=
 =?iso-8859-1?Q?1/YKcg2ZLNIWFgDU2jv2I+MphqHCvpWim1Ckx5DgDHYOJ9cYdN6s3XI0p7?=
 =?iso-8859-1?Q?8aG8kkf+QL8khl351Xl2kocCJ+S1ENUOUOe/0ZWUFnv2DluB8+Y39W5Rlx?=
 =?iso-8859-1?Q?4dgXRcZ81d68s1aYZE1M/XbNQwq+ISU6uEkRbzMwpz44oAeUpnzy4Us6e4?=
 =?iso-8859-1?Q?LJrANJRQeazPWb+AOTOBxudMVlEEa9E6ZiDuTWJhriYpQMNvAK2Z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45986f54-39ac-44a0-a45e-08df2b0231d1
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 21:20:53.7670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4e9o6PRZ0DE7iYH83r+dVC/bfMGayQWiH6ojjyE845we2EAIFlbyWCRl3G8khlKkX6UGTOQOtXH5sy3tG8sKoEO/mfoKHTzEhtdPs8KyZ8tUonHsTtXLVpfZJG1gqFt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8012

On Thu, Oct 15, 2026 at 10:58:00PM +0200, Richard Leitner wrote:
> [You don't often get email from richard.leitner@linux.dev. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Since commit faa8e404ad8e ("spi: imx: support dynamic burst length for
> ECSPI DMA mode"), the driver allocates its private DMA TX/RX buffers
> with kzalloc(dma_len), where dma_len is only rounded up to 4 bytes, but
> maps, syncs and unmaps them with DMA_CACHE_ALIGNED_LEN(dma_len), i.e.
> rounded up to the cache line size. As a result, the DMA API operates on
> memory beyond the end of the allocation.
>
> This was observed on a custom i.MX8MP platform with an mcp251xfd CAN
> controller under heavy RPMSG load, as a series of refcount_t warnings
> triggered from rpmsg_recv_done() in virtio_rpmsg_bus:
>
>   refcount_t: addition on 0; use-after-free.
>   refcount_t: underflow; use-after-free.
>   refcount_t: saturated; leaking memory.
>
> Leading finally to an "Unable to handle kernel paging request" oops.
> Reproducing this problem took between 30 minutes and roughly 30 hours
> under the same workload.
>
> Hardware watchpoints on the refcount of a struct rpmsg_endpoint showed
> it was overwritten from 2 to 1 by __pi_memcpy_generic() in the
> irq/155-spi2.0 thread. Additionally it was found that a "normal"
> rpmsg_recv_done() took 11탎 +/-2탎 from its kref_get to kref_put. In
> the error case the same sequence took about 215탎 +/-10탎. Based on
> this, an LLM was used to identify the size mismatch fixed here.
>
> Allocate the buffers with DMA_CACHE_ALIGNED_LEN(dma_len) so they cover
> the full mapped length, and use the same length for
> dma_sync_single_for_cpu() to stay consistent with map and unmap.
>
> With this patch applied, the same workload ran for more than 200 hours
> without the problem reproducing.
>
> Assisted-by: LLM
> Fixes: faa8e404ad8e ("spi: imx: support dynamic burst length for ECSPI DMA mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
> ---

Thanks you fix this.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/spi/spi-imx.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 79a6c1a60b0a0..3851c50dbe314 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1578,11 +1578,13 @@ static int spi_imx_dma_tx_data_handle(struct spi_imx_data *spi_imx,
>                 dma_data->dma_len = ALIGN(dma_data->data_len, BYTES_PER_32BITS_WORD);
>         }
>
> -       dma_data->dma_tx_buf = kzalloc(dma_data->dma_len, GFP_KERNEL);
> +       dma_data->dma_tx_buf = kzalloc(DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
> +                                      GFP_KERNEL);
>         if (!dma_data->dma_tx_buf)
>                 return -ENOMEM;
>
> -       dma_data->dma_rx_buf = kzalloc(dma_data->dma_len, GFP_KERNEL);
> +       dma_data->dma_rx_buf = kzalloc(DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
> +                                      GFP_KERNEL);
>         if (!dma_data->dma_rx_buf) {
>                 kfree(dma_data->dma_tx_buf);
>                 return -ENOMEM;
> @@ -1920,7 +1922,8 @@ static int spi_imx_dma_package_transfer(struct spi_imx_data *spi_imx,
>
>         /* Trim the DMA RX buffer and copy the actual data to rx_buf */
>         dma_sync_single_for_cpu(controller->dma_rx->device->dev, dma_data->dma_rx_addr,
> -                               dma_data->dma_len, DMA_FROM_DEVICE);
> +                               DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
> +                               DMA_FROM_DEVICE);
>         spi_imx_dma_rx_data_handle(spi_imx, dma_data, transfer->rx_buf + spi_imx->rx_offset,
>                                    word_delay);
>         spi_imx->rx_offset += dma_data->data_len;
>
> ---
> base-commit: 62f482ff73bf3ae88b0c899115527752cf9cbf13
> change-id: 20261015-fix-spi-imx-dma-1bab95ea4863
>
> Best regards,
> --
> Richard Leitner <richard.leitner@linux.dev>
>
>
>
