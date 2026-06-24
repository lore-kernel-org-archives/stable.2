Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013023.outbound.protection.outlook.com [52.101.83.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9596D5C613;
	Wed, 24 Jun 2026 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782318647; cv=fail; b=iACJM87xPQ33RowltF1HQWnu9gIi54dZ/ECC2RQuvD68RSRU8ldsR3we4BCSaVYlC1QiVJr/hY5f7/7aeJp6GVSSFY2ygGIag5xDTFpDksIWk899Vm4ZQ51iWt7xmTYUe2RlAzq7HIfE/6lZ3HaNkr4MiM+BSDnd3bHTPZUkzhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782318647; c=relaxed/simple;
	bh=Qc+lwEegqjIGHH2scvRZElq24b+v8B4n0c+sbD/ZHd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MbuKaLbMidxObbX938FKp/xPctanEjWiMn1FkDaqI2WcuxTqPZJckSRmhfUgAs1u9RKFFu6lneK5vsNpD6xugjlRc6qBugx+Zg5443gHS0tpwegL4GUC7fQdg2xGYuiOYegYrbl7nGcQueASCktGF1L/MIhmiDqN/LpFiKQDqsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lW1zSnh2; arc=fail smtp.client-ip=52.101.83.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lW1zSnh2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBQtelZseDNPT/iKl1Ses/8F0o7smjJmJDF71xk3pKhpU6PDsMEMTPWKFX913Rb8qM0S2LQ5zMKBnM4NCTYnN1FFXVLtNd7KI4Wl/1zPfrqm78Lv9Ek7aXH5R78BbVGI57/J4fCJJUHYhOj24LFmK75290finiCMvZlcSjitQ/jBWSS3oPEu6spXjNEP2dQv9tqPhqepmrsOfrqmzMP26gDSNCX/RhSVzV1/itFmx8M57SimcqC4CgXF5pNjYFL9paoOs+nwQVSynlPpKnbPeqk1U8bvKqfjdQObfBCT7FpON6oUAmcDo3XOmDtD7ByLiQ0ssakxoPKqrlOe9cPqxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2XG1wxdFF07gS26BmYmnVrmB4zvo0PwNNzXTi7R/lM=;
 b=XpjRbBdTdOhSq+YU0QAq8iB0RWQLWRfyvcuTaBUCxl/pi1YhS+G7CaQZfcdlv4mPFa5z93HLeWMPPupPofCXNVnpTkuTEipuEUJq5K1kmwo/cjK/cxie6sRS6tHtp0lpsIYVd5MemJpF03qbxLW5Zhapwdq0eWoRxwYdvoo3c3v2Mpet45FZ3hzn5FDQXSm+hD7PwmCiokicI6n7zIDBD3yakUNpbAQzBns2ED6kOyDL1CBtm/u3UJICcZx3Mz0fOc69St6ergR11lPp4UDwXcG6MUteON0OsaLFNWVWc3Fey5J0cdzAh8Fp1qV4Np32cNmkJcV4ipkPmOFdHbnOuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2XG1wxdFF07gS26BmYmnVrmB4zvo0PwNNzXTi7R/lM=;
 b=lW1zSnh2TCd6h9eYSetcM88PINZDxZmOEc5hecdYkFutoa7WsjwU85pmJGMl5NYI4T7Co2AC3ojAZPzXLX+hN0lUik9WEn3BlAyOztNvBCjprPchi3QinVm8lyWdBU0kZx5d/hNr0jmKO3wfrX+dH4qLXwZLBuBrRdfq+PWujSkGl48s3h6szFWeCX1DeQW5yYpjW1rmPgPu4LtYWJWJf15bq8o1C2RV8PSEECzAxamS22qKAI7j4dkpgnoDDNiRoz52Lw6TokbTMcsYwlTAtU6RSW4vkmlcyufHg+gQcilt6MCYZC8sNOqFh9j/OODNfB8CsfDY4zno6aESSZKTsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB9857.eurprd04.prod.outlook.com (2603:10a6:800:1d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 16:30:36 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 24 Jun 2026
 16:30:35 +0000
Date: Wed, 24 Jun 2026 11:30:26 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Carlos Song <carlos.song@nxp.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] spi: imx: reconfigure for PIO when DMA cannot be
 started
Message-ID: <ajwGIjGuyuvpjVib@SMW015318>
References: <20260624151958.18626-1-javier.pastrana@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624151958.18626-1-javier.pastrana@linutronix.de>
X-ClientProxiedBy: SA1P222CA0171.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB9857:EE_
X-MS-Office365-Filtering-Correlation-Id: dafada49-1923-47d2-3b53-08ded20deaff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|23010399003|366016|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	tBcVg69OFB+IHpE19fo/ajcLzyE/M8VC/ArfP9hX5INrM1IMUaTOyc45MIiQEGeBbwb/FeZnj3dPdEsCHi5XaeumRsGaz9oU4tH7klTDuqDP7wz3txUbBY/iWYS9E3SsUkbmyv5Wkg2pqLQHfJGVKBvIrkKxM8PdqzoN+ZDLO8ishRtiiDIwC8v5nFl10ISM1LEzSW1O3rm/5brertRZb/VtxS9zhHxpSoh0pZIe1oWImTmuEyKmxAEQFmxu30vFglhdZzPqq9c6v7OK6s+yLdj4/K0Bcf87MjiAkEUqDBO0+8mDQmOjua3RUwCtTx+uUMjI2wOQpy8BQvZkIunVFLIdoobCcD6Qv39PrQwmL842VRwfR+beZWHPqrwnwSJksR7hP3xDqHLR0u/qo9YpyP47KMqhKquulWxEXKIUFBQ6/dDhU7Y7PplRsAKK11h64ejIvxzgSrEVbyVcTcVlMcfJf7+dDUsSWRBYuhlX90IfWVKjgFn8J8NBLhpp55asrL4jlPPF3optPv2IpWo/Dt3XgSmaeObMoVMmb1+7dcKOq6TMO1pD0Q9woF3cO1O7Zay/sB94EeE/GXt4uzasF765zFWO87/B+jiLx0OlfwvDBZdTs3wlz4sK1HNuVbpP6ppkF0KlOAFnqIDigzEA925ElLEc8ZqsA5/X/BmlJwg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?byQReXRJwsdwESAFykKwS0aGc35PoS+Eq0aopK0EJB2aDcLH3stCIpENXFU5?=
 =?us-ascii?Q?EkPRd0scfFDLbJII7g4UJQxend5GlnKa7cCDO5El5zkab/BruuxO4MXvpByH?=
 =?us-ascii?Q?9cP2Wjj0jJs/+lezl57Lr/Grg+Vd8DwV+yYUehoWpj/xNLPMEyFLmFeMjFlB?=
 =?us-ascii?Q?C8f7i1DGa9ivC0B97xyx7jxEmkvqv7uf4wPAuSQEm35zTQeCwsMOaA0+qTm+?=
 =?us-ascii?Q?sAGPtJn4Rsu1SfhSM6OpLbGDtflaPF04yTL417w+MKEL/jY1ATPYnv8skViJ?=
 =?us-ascii?Q?Jta1Jj7h+t8wQ33pQvXVDdTLmP62pEojKP8knbSrP4eXwyZPesVeU3GaGael?=
 =?us-ascii?Q?TeJwVUE8mIWwR10jHRzDjghnMjhsQYjhUn7FDDHNbaYoc7qztFPLZTn4jaYR?=
 =?us-ascii?Q?R3MhHjhfLwsphs73R7Au9ciTkNTIcmU7QYAikln/9ibML+RloifqxTQV5lsx?=
 =?us-ascii?Q?dsHbTEHvjPYed98jA7peD7CJ38ldZsKlx+wa9oPNjR3OnyYaREvgKn/bNFEd?=
 =?us-ascii?Q?MbmfymUx/em0vrAIB5BSlW7ArT7xae2dm/ulpDtrmEIDgcLmW9je4vxFUFll?=
 =?us-ascii?Q?4nQmJp4FA4bH6qi9SZ0kiMMlAO6RB+dlNjroGVIcXcF8hDyFXrfa1jx/tiEB?=
 =?us-ascii?Q?jVXwbtqykaEfUGmWjF3Iuk3F+NoHtIXS+ZBiRYnPxBAY0wwUWbRqfIuDoYIh?=
 =?us-ascii?Q?kE9AnkDhgisQr9FVx/nVlG5U4noP49P0CFzXOTnV9/Vd1Tef2mRYZzgZOoze?=
 =?us-ascii?Q?igyghEiNRGlJ6Ms+bXTlxte/sP/scAdSS+eoyJGhhUbNaK5JwilclZYOr9p2?=
 =?us-ascii?Q?7EyU6fhyCL3W+b/5G8ONcsvYYWgsEWTkHEDwij6HugqotqTEM83KSIzF79qh?=
 =?us-ascii?Q?klT3BWnd4kjM/XtugnESfEkspUEw+hOG6RQmeNTFvgzbtwp1fmfa8uhRNfnV?=
 =?us-ascii?Q?Vyr3Jvs8cZZtoouI8lN1puub1lb/FheIcigcFoJtRIZthpvloJCC+h5B4MV/?=
 =?us-ascii?Q?kizR4hB6mq4GT68yATpoxTKrA517Jese8821AdJ18uV7hz7RJsYwYf5wpRUi?=
 =?us-ascii?Q?Kz6l/ZlcF2jIrTS5WKUTqjibHcGHm/bVncCaVj1rsO8jYNlOEM976c+Uzmz/?=
 =?us-ascii?Q?9TIt7JkuRJb5T+quM1Or3fLtaHtKt1VOEbPNye31ene34ECznmwrNwQET2Hx?=
 =?us-ascii?Q?aoxlcnsDCTjdeHnId5LK9dHS116QSV8/Nx06QHgQsV78ABdJHWNxYPGkGIES?=
 =?us-ascii?Q?z02DSNDgmVinoGqCku76PzgEHTBHyPIGwrZUi/TBQwf0wbpK1KeyGjttE/OH?=
 =?us-ascii?Q?S002uY0o6F0AfkOl1VWNpGS7/4FWML+JFqiskkK6jiIwrrFKanRYM+oTLAO1?=
 =?us-ascii?Q?dIoWj7aSSfBNb0NUgsNUJ8KOALqNOzGUI+O9gkOodg0YpVFlTX1q7Bzrp+mb?=
 =?us-ascii?Q?ifXVOQ9PAp5d8pk0/ivQJbWTNxk/WK65sAO17TTUd+6qD/4EgYCoKGi7syaN?=
 =?us-ascii?Q?m9MnNcNykT7gjaDlCC7Rm9s+Yzpo6qqN75/k0ErX/C0xphYWqWD2QRDPNRkn?=
 =?us-ascii?Q?AOEGNt6nG7ckyxryURXgErqsL+bJWdF5GF0jurge/3EAuVUrhfL130V6LP6P?=
 =?us-ascii?Q?ztNwHe2zyHG5D33o0Ia9ILxuSeDT8ElhNnlNYwXA6/bXtZA6t7K6MuX5yGuy?=
 =?us-ascii?Q?Y/oYT49qvD2OzRYvzL+jvoptFqIEtypsaCP7GT8UoA6ZBg736wpj/2nY6BAu?=
 =?us-ascii?Q?eX7g4Nya+NLSpb5xrhb9j32hoqFVDcwGFzJtWqFuc8Qra6ZVGRQQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dafada49-1923-47d2-3b53-08ded20deaff
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 16:30:35.7662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToAmWOCuVy9OPIqthe3thOY1HqBRkKJifMkg+lZ8y3ghtBJ3VhPCFpmDQ3yZQPE6l07CCq0ve4AVIN2dT/Y+RGoq89O/+eEoczIFBQTJKqOz484ExECfpqSrfBV0RE5t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9857

On Wed, Jun 24, 2026 at 05:19:58PM +0200, Javier Fernandez Pastrana wrote:
>
> When spi_imx_can_dma() selects DMA, the ECSPI is configured for DMA:
> spi_imx_setupxfer() sets CTRL.SMC and clears dynamic_burst, and
> spi_imx_dma_transfer() programs the dynamic-burst BURST_LENGTH and the
> SDMA watermarks.
>
> If the DMA descriptor cannot be prepared (dmaengine_prep_slave_single()
> returns NULL), the transfer is failed with SPI_TRANS_FAIL_NO_START and
> falls back to PIO. The dynamic-burst DMA path uses its own bounce
> buffers instead of the SPI core's mapping, so xfer->{tx,rx}_sg_mapped
> are not set and the core's DMA->PIO retry is skipped; the driver falls
> back to PIO internally. But none of the DMA-mode configuration is
> undone, so the PIO transfer runs with CTRL.SMC set, the wrong burst
> length and dynamic_burst cleared, and the transferred data is corrupted.
>
> This is easily hit on i.MX8MP boards that describe ECSPI DMA in the
> device tree but run SDMA on ROM firmware (no external sdma-imx7d.bin):
> every ECSPI DMA prepare fails. An Infineon SLB9670 TPM on ECSPI1 then
> returns shifted TPM2_GetCapability data, is flagged "field failure
> mode", /dev/tpmrm0 is never created.
>
> Set controller->fallback before re-running spi_imx_setupxfer() so the
> ECSPI is reconfigured exactly like a normal PIO transfer. With
> controller->fallback set, spi_imx_setupxfer() sees spi_imx_can_dma()
> return false, so it clears spi_imx->usedma and reprograms the controller
> (clears CTRL.SMC, restores dynamic_burst and the PIO burst length). No
> explicit spi_imx->usedma = false is needed: setupxfer() already updates
> it from the can_dma() result.
>
> Fixes: faa8e404ad8e ("spi: imx: support dynamic burst length for ECSPI DMA mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> v2: drop redundant spi_imx->usedma = false; spi_imx_setupxfer() already
>     clears it via spi_imx_can_dma() (Carlos Song)
>
>  drivers/spi/spi-imx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 480d1e8b281f..1837cc7b0b96 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -2152,7 +2152,8 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
>         if (spi_imx->usedma) {
>                 ret = spi_imx_dma_transfer(spi_imx, transfer);
>                 if (transfer->error & SPI_TRANS_FAIL_NO_START) {
> -                       spi_imx->usedma = false;
> +                       controller->fallback = true;
> +                       spi_imx_setupxfer(spi, transfer);
>                         if (spi_imx->target_mode)
>                                 return spi_imx_pio_transfer_target(spi, transfer);
>                         else
> --
> 2.47.3
>
>
