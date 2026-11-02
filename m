Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793638097;
	b=yZAuewMQqAV/gE2aUDVwpSbXyrtrNJcvQaFcFcArAupUkIHGQjP6IzFGHLcdtMWg2C8x
	 PrgpKNAOKAk7WMtsfdyQlQBUVD1tQQ4JVtwXVJeLhz0FwlkUkNarbjKCOWMvggA+V2Kd8
	 BlnWUu+977EFE3X0g7kO+wcZulJG+qfIlCH2x7Nr+Qlik41O9qQWuJKZSiRjD1hXRYPZa
	 nw9ZPOimr7kY33IfLANmfM3viFQ8pBtKV+biW0YWGYQbrbH1Mefq8eZMUiTCFJBNV7TTX
	 WS54g2sDli5sX+TXF2FfSMwXG+eJWXg0f5IEwmZqKMdsqSL/nC+efkT1ozXRt9tOQUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638097;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=wyGoShxYRaYBKZIJpYvIWwmSQnNz4S7v7I1GDlrX13s=;
	b=PkVk4cEVkVq+YB4xfKR/AsPg0+98wnEB6xnIGMeJ/6aDTAimrBelXQhB1NRLHcTNlZxV
	 eqlYLqE632U4UG8XOzWZju9y0Qj2IWpdr4iUTlsy5rijUU7l7NWsQfgbvUfgKXlezzF60
	 eCenYs+9jUz75e2vzHlkIsNcw+mypVp3tVEPH8Uds58TbnT/9VuBIJiV7qucaaVfz25g+
	 nvAulO26ZSGIk+OtP+2Z8acPDg+A49CAJRz42tuN2APS1JGLoE21GjusWCtVktq9Rh3Tx
	 Rhdc+GpdTDZIHp8Dnm0d8/SWOs/cov1ZGvw+UT4a54wbRtlH0MCyU4RGUnQfzENW65A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=msQm7fbT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.4
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBCE606B1F6;
	Mon,  2 Nov 2026 16:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FBCE606B1F6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=msQm7fbT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7wHqnxEnojwSpwpcWsygtWUQit5PtCg79LUWJ/1whogo34At4yfFEbJXylfuc/EeH1wg0vVPPskU6oH45Zrut22uyyxhaMyyochxnbpA1qaLwDO7pFZlGQ+e5QgL2l/9EMUNwLQpbIsj7mgXatzDC09kWAltOwWkv5r4wZ/JpFcDvHZFFqOzondJcXW4t0/8CzJEOOyZz6LFiU3oDogjfyKwnZe6mtGwQFZQeXxqGh2K66O9Z7wMkQ7kOivGwmNUKnyk2Y6+3D5+wsJsYznSF/IWJCA1Y9aMDaEyOCTBjQJA8c+2ZQ8ac0WpcL6VqO+DexUyPDIghFQ2AcF2sOyTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyGoShxYRaYBKZIJpYvIWwmSQnNz4S7v7I1GDlrX13s=;
 b=O36Iureca91gAHK/tWEgVqc54pYXxHmQGw/Bu28GMZvhrOQWFVUN+tcWc3w8nqxN1PWZbS4LXApxxFd8kWDZaI0+GmtZ86ChoWNRiUHfgmwdMq0XG8OMQfnmtVrnQMyZUI46T8hLN0S0xezsBGIsFY9XBZc/ENHHS/ALbDQtVokNj54JaqEvuo//dG0Mtte3eLHn7M2PorRvHiEFF5r04Ay7m3+mwwqezPDUQULSsL+NcuX+U+0Hfbp3jUbxY23wJUP/+nkpEzktNMKg89WiExUvSdr3IYtRCHtwiFvrlqDMoKWhol4KuDxT5jV3GHfW+qHMHnSk1ZFPkHLixPrdJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=posteo.net smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyGoShxYRaYBKZIJpYvIWwmSQnNz4S7v7I1GDlrX13s=;
 b=msQm7fbTysovlqHbMd3x80BzZuEooxwkiSXJBohjVuYdHBAFdJYTklZiORWfzh0s+LgrpZrkOEVOlB9dGPXa8GS3quo0HFzYul2Nja4EzGHA36rxu+3iUmwzlCjLN7lGhrQlz1Dxb5rEmro659q8vaOTkG1TBeR5PvY8Tyd5hdKF5yMDq9L8JpA53JZFHG7xPLdO1PG20r6auhdrpG7GH7WU8Iunz8dIhPuT9UFRNcEQLhVPiUmNzgI3y4lXaOySOiQpFv70jKLGQS4Oe84A9DFfRbivbFcwOCrisstMdC+HATynx+AXyn+IYd0R7sQqEmZSJAKHmNuhnIbIUnfKpg==
Received: from PR1P264CA0128.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2ce::14)
 by AM8PR10MB4036.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 16:48:12 +0000
Received: from MAD0EPF000008C2.eurprd05.prod.outlook.com
 (2603:10a6:102:2ce:cafe::11) by PR1P264CA0128.outlook.office365.com
 (2603:10a6:102:2ce::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon, 2
 Nov 2026 16:48:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MAD0EPF000008C2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 16:48:11 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 2 Nov
 2026 17:48:55 +0100
Received: from [10.48.86.101] (10.48.86.101) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 2 Nov
 2026 17:48:10 +0100
Message-ID: <a5fff7cd-686a-4fef-b9f7-87e19b870fa9@foss.st.com>
Date: Mon, 2 Nov 2026 17:48:09 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mmc: mmci: stm32: do not use NEGEDGE in HS200 mode
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>, Ulf Hansson
	<ulfh@kernel.org>, <linux-mmc@vger.kernel.org>
CC: Russell King <linux@armlinux.org.uk>, Linus Walleij <linusw@kernel.org>,
	Yann Gautier <yann.gautier@foss.st.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20261031120700.42576-1-mateusz.nowicki@posteo.net>
 <20261031120700.42576-3-mateusz.nowicki@posteo.net>
Content-Language: en-US
From: Christophe KERELLO <christophe.kerello@foss.st.com>
In-Reply-To: <20261031120700.42576-3-mateusz.nowicki@posteo.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008C2:EE_|AM8PR10MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: c99f029b-6394-474c-cf90-08df39011508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|36860700016|82310400026|261102123227099003|261021121427099003|11063799006|4143699003|56012099006|261009223027099003|261028144727099003|261022105027099003|261021123027099003|261026140227099003|261026121527099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	9IowxUPLnleLduOYSZ/tYJEZlOAcrIIEiXHcVOK7Mc5dDo8SYJBS2GTL0QXPHb1FBWEcF3eQJ9t9+mbNPHgW1KxdfoN0sgl03ngdIoWR2hKWC1K9ZVft7H1dE/GHyTL9X0NAANCjU9oquvGNy4uikndODJY89GWOYZdz4pFJG9kr4Obq35rIvBOk78YMNvWjwoACoWt8Hp/zXFmYtdaDXgG6GiZS457hYsNnPL57n89zQSmweg7nLCqO5212GZewijdrzurxKxfPdBR+gJfe2WzqXDqnOtH4Yl2c59bdn+lCfAjm96GW07z97+vi8rQXqaD01YXlV3ApKE7wOeuC9XJA6o4LrRp2J3EyFIWqxEiCarE17OhJn4HbmxZHXmEa7xUR2Z3cE2wJfdSpG8X9xh3muRL1+KwxM1eMTeSZFmKsT5vtOSbaiR112cx2Wb1pQguWkkeeOeXmGZV3hv4WzJSCq7iC+54GLhvrs1C1Ga0IUfsBsBR3+lkzNAojdKqFR9P/8wHBdCDG0/CAXRZYY+2EwSLeeUhuReyYjWmPJtptb8kFPu0a5hLXMYftiNHOYixa5SIj2VqQwvmFXat7AzqMfvsL0MympyG2aBrJjQ3xET+CcnRsLQLEWdmNOttkPzphtxVjpyNc2uYITvNcqFN5da0Zw9ZsVMAI5nwteWand5tqPk33C/22MyYf3fS3+jD0VxA4/S4wBj/fuDBnKA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(36860700016)(82310400026)(261102123227099003)(261021121427099003)(11063799006)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261022105027099003)(261021123027099003)(261026140227099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Une9ZxMcnuZ4Fkgp1uVoWrA0ew9WGZsOHcqGf0uchao3TqrCdVElCwTUTN7xRUJVS7GpB/kFqCBUdcc0aDbPwmlm12jiKGSI3NNCqggpG9unziHbDP5m/umosLd4ZnOyNSeu74LmeiSdo5/1KQpOrcfAPoEKll8Q+IoPhyg6EFeLW94CW3zoUacVqaqTmn4wN8/ByJD4hmJ71JJYL/I6H/isTC+RLYxVpvDSUp9kP3j7OQPoFS0wjSwX4e7fAY51peyli+vgyEcidNeunLm2JaunC8VeSqoqo0N6KSDonPrbjq9sHxti/C7pnUiY5ZTAzci+EWeeFUvQVF6Nm0Yjxz0FlKuxU1ShYEvgrQJo4xPgemrpcKVBgHm7Fg/PMf12urSTwBVOuggp1mHxZrts4dx33DDIeHBwwZFcw1Q81/H9lqrf4d411CF4IOxY1PZe
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 16:48:11.9489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c99f029b-6394-474c-cf90-08df39011508
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008C2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4036

Hello Mateusz,

On 10/31/26 13:07, Mateusz Nowicki wrote:
> RM0457 marks NEGEDGE as not applicable in HS200. With a clock divider it

No, it is not what it is written in the RM. If clkdiv is equal to 0, 
NEGEDGE has no effect.
NEGEDGE has an effect only when clkdiv > 0, so it can be used with HS200.

On ST downstream Linux Kernel, you can find following patch not already 
upstream:
mmc: mmci: stm32: use the delay block above 100 MHz on stm32mp25 SoC 
(Commit ca3b1cf)
By applying previous downstream patch + patch 3 of this patchset + 
using  original slew rate that was upstream on
this board (slew rate set to 2 for the clock IO, 1 for the others IOs), 
HS200 should run on a ST MP25 DK board at 100 MHz.

This patch breaks also MP13 SoC that is supporting HS200.

Regards,
Christophe Kerello.

> corrupts multi-block writes: on the STM32MP257F-DK (st,neg-edge, 200 MHz
> kernel clock, HS200 at 100 MHz) written data read back different. The
> same writes are correct without NEGEDGE.
>
> Fixes: 36240ef8665b ("mmc: mmci: add hs200 support for stm32 sdmmc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>
> ---
> RM0457 describes HS200 only without a divider. If HS200 through a
> divider should not be used at all, the alternatives for the DK are:
>
> - Drop mmc-hs200-1_8v from the DK device tree. DDR52 is tested and only
>    about 5% slower than HS200 at 100 MHz (read/write 78/66 MiB/s against
>    82/68 MiB/s).
> - Drop st,neg-edge from the DK device tree. This also changes DDR52,
>    which was not tested without NEGEDGE.
> - Set the SDMMC2 kernel clock to 150 MHz in the firmware (OP-TEE). HS200
>    then runs without a divider (tested, 119/86 MiB/s).
>
> Which way is preferred?
>
>   drivers/mmc/host/mmci_stm32_sdmmc.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index 9dc51859c2e5..d74efdff6ac2 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -342,6 +342,10 @@ static void mmci_sdmmc_set_clkreg(struct mmci_host *host, unsigned int desired)
>   	clk |= host->clk_reg_add;
>   	clk |= ddr;
>   
> +	/* NEGEDGE is not applicable in HS200 (RM0457), with a divider it corrupts writes */
> +	if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200)
> +		clk &= ~MCI_STM32_CLK_NEGEDGE;
> +
>   	if (host->mmc->ios.timing >= MMC_TIMING_UHS_SDR50)
>   		clk |= MCI_STM32_CLK_BUSSPEED;
>   

