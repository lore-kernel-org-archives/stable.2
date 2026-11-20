Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795195407;
	b=WZSAdh0+oVhtuYC9ng1tng9AGPf/neXILIYmfrjJ87IJVeK8DMssSK9cpE3GFLbwm0/A
	 72WO46RmX1IfXheEU0R11O6T6p3o1SErFxDEHF8pqRKP0POOr11GrkqhFEFm1bHVpZKL+
	 w07ZABgoQpFVAshCxEKYkCW+IgV69KMbY+LXHv/IeQAQwWpfycLyIZhCAOMcl1iJHYaS1
	 6Lywgwqk7KRSQ7d7KFQFNgdanM81giia4SlSvVBYE79ocPOUhacY3Fc4dkxQmwwQzgGac
	 zpxHXNjHwRpWgDlYwl+dzul7TMRDXe7YFuG9fFty2Sh+zKhoZwU0QSJaEhAgj02X85w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195407;
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
	bh=ECX/M3b0zoA5P7uoYxeaKgZNgDL9zYrC51KrOZWaWJ4=;
	b=m1D3KsKSeVYpH7ujWE+l9wNyMQ5wvTLurwY4CVIEGcMdkyuC+DkSp8qXzP25JhLLjT56
	 YfgZDI0uiMb/QibKU7tQwl5etbzqd6sadisyMG+bcUEsj+XuX1jPhJaV6YiERimT0fTxs
	 oJw0pbEaBeGvRZrjidgLfb3BYZf4xMVMZmt7scBQEB0s+WZ3GeQRRW2zYmmkvTALEb7Ho
	 soP8O1hxtX2O8psfTT2zN7bFte/Uq+5V9sJUK3pcb5wh+NWNhFutUTDm9yGD7pHX3Bc50
	 HvP/QgCh6YGajo9zZXts7vefWyfGhrDaZ4vRt6HOgmMNtGzFFQewuJIVuf4PzYgeApQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=KSrKavxC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.9
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010009.outbound.protection.outlook.com [52.101.84.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36861606A333;
	Fri, 20 Nov 2026 17:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36861606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=KSrKavxC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkMKtbD43slWw5nkvHMX6sogspu9s4Vqonn8gbnW+ZAGteWsh9skBDwtL5uNzaISwYHQcOcK8RYLnmgNOxjhVD2A559XcRIcOnoitjYz0EOH0/tbLIFVKbC6U6+20syk3N1NVkkoE4PMWB7aNmIaEDdZhNjkYkS1iSevHTZnxUP50hN8kKu3d3ZEcHqv1G7v98NgKDi+TyW0c2hq1UuhDbos6suHPUaSiPG+DOtVwcQjiUzLTcbd74VNItrP0PTOE1+pqfzvZcBfggWBmOybwFqkVqe9+lEQ2RsoHaIbn6B+eWX3dyza+iObqEc+6YUlMXQE6e4jyFVC85Xn05o4Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECX/M3b0zoA5P7uoYxeaKgZNgDL9zYrC51KrOZWaWJ4=;
 b=pX557OMs3J4PQO0UTS8i3YxB+hWWBpDelwbG+IltvzFwWOP1u0uK1P7XiSUy7XrcanXTWTPgBjlu8qjkF/CnIwV/1acG+Z3JeQSHQFgGxnaVQpSuEZ8OlzjHdCuAPKYVvuUEF0DgHd6MZo/RHa1yOpuPpsvewslAzTI3I1qT9apqhjceqb2LBiVX2cPBbyHNMauatE+spOAiEweB8gfg7/qtX1/Ao/jpchC5nIuOv0p/Tk9/J0H+udfJB5Ct8WwrSfP5gJz1o55ShfgnpD9PqL0/WJJhbcetr7q0rxF4MinzPrd+t+dz14WCTp7BspnvY6K+wcdaIDYkfVA7xGVtWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECX/M3b0zoA5P7uoYxeaKgZNgDL9zYrC51KrOZWaWJ4=;
 b=KSrKavxCxjRpIuLqWUTvGwpzqoVfGrn7Su4qNme7IIhEA94LFtN1K7zBNOYfAjh+YZvFaBCmOMz671okX1fdvPVcG09eKYL3476/uEbGXokMYq4gxQ+s0ixWcytZKIia00LIOdZKTS67CqRYKjRzGxIDiZpM9Dk9NgeEJd02eBvuP5bDD55RqOHwaEypybOzccKIumfJZrNMSUrman0nBo6XvMuE+XkbD4LmUUwx+jIpM5kmdSKdz8oygm2WVqpWeIAAHkwIwfSFkIMXTiG3fWtcrevQB0va5LGBg/ZnlkHbZV/BBXMdMYqzWZYXcMUOQHRAaHywaiCfb8UZ6ynK6w==
Received: from DUZPR01CA0341.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::11) by GVXPR10MB8701.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:1e1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Fri, 20 Nov
 2026 17:23:21 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::84) by DUZPR01CA0341.outlook.office365.com
 (2603:10a6:10:4b8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 17:23:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Fri, 20 Nov 2026 17:23:21 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 20 Nov
 2026 18:24:23 +0100
Received: from [10.48.86.251] (10.48.86.251) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 20 Nov
 2026 18:23:20 +0100
Message-ID: <a449f513-5d7f-4478-a389-9c47dd0ecddd@foss.st.com>
Date: Fri, 20 Nov 2026 18:23:19 +0100
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
Subject: Re: [PATCH 05/10] iio: adc: stm32-adc: Detach chained IRQ handler
 before removing domain
To: Lee Jones <lee@kernel.org>, Jonathan Cameron <jic23@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<linux-iio@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20261119153151.1397003-1-lee@kernel.org>
 <20261119153151.1397003-6-lee@kernel.org>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20261119153151.1397003-6-lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F4:EE_|GVXPR10MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d5426d4-8f44-4234-fa44-08df472af9c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|7416014|1800799024|376014|22082099003|18002099003|6133799003|13003099007|921020|11063799006|5023799004|4143699003|56012099006|10067099003|261022075727099003|261021121427099003|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261021123027099003|261009223027099003|261009221227099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	Un6QfLTXrNxOCzV1gNecc225Z7SLxkSssQL9Fg5P8Urty/WPSUAQrTrW0HgRY0LioPWk9XKU6DDZEaeKfFVeYJFiAaHf44YNARGv03cmwaRqyovk90Guuqt3Ejnxw7YwoLxwta7due0wpLKKZjjOzPq2X4uGDNbeh6aZFt2ufVhKqEQ9dK21P3MRx5K0KHI1xSmYCUKahGv2K6Xq8Bi6MsqsTbvL42z6E65OLgoprO1Y2Gt74gKQnZ60n3xLrXIK6RptXfUdtHzpmAFXQvEfY2C2LrLdUgJ6ZUq2SJ5CMXbryXbp/iI+7Y7zgd60BUtj3Q5Q4G0ZJo5T0sOJpF6k4pM/kDKfI0uyQr1QaaKrQjKW3AFpXAu9yKNF2qew0JYq54wZNWGgk6304G228RinKsVvXpFnGpOQCqZaM6asyycLUKieV5gZd1CiFb3AhkLlCgEwVWKwpc033zawWpZ8mG+FYJKSOhbgJPqf3xf15S3dcB+qwudsncXNYpoW2bAF/fNbwim/43dHOWLsf8wuCUm6n2dkl3vaE5t6Z8ILVXHfkqevvlczp3s6PRUUjCOkQ6w1ADmbZ9rKX+zcp0mWy2fwZVjiXQebQgBlF3NzLzuSuDEJlFxgnk1L5chmzmUzx/FYBBI1nWW4m73nSNZgQVMmGrRjhDbE6razQw2OtUP4I4With/6a9fkMnHJdJaS
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(7416014)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(13003099007)(921020)(11063799006)(5023799004)(4143699003)(56012099006)(10067099003)(261022075727099003)(261021121427099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261021123027099003)(261009223027099003)(261009221227099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3ShLnDxmoKZxMqSK/JEgq6VrmkkfYNfgBQAxgvtquadImAqUuRuQ741D7dQ4rBbZwdfA/nt/tPZHGgXzn45nRfp8ZX9UsLLDGCzH4Lu0YDd596zVPFlARP3ExNHCswHm9R6VJn+TDapZK8nSe6cIqkkrllz4tLIKMwXIlc66p3nB/S9qckPq7yQii1QIHoDR/dqyvcOevytbjZre7PH3lbF8I0QDtpK9BsPRgtkZXK43DEZoOILSzj+yH+vA/xmuMb73R1VJGrQ35jNxafEgBHINn43Shf8DQNNHjOYA0JelP6C3FOSoG/MUpEISBqDBXX7uEZizv1RFvrDovjDiHNursa4jgPefhhJ8DnZJsfpHvHvT4itVrI5zH0eaaF5t3YHu+t1WYS8FBBh/uTDrUCzNcpzVPBFWE6v7MihLcqPVLgm1dHeyz2NpxMTAgJ4k
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 17:23:21.3312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5426d4-8f44-4234-fa44-08df472af9c2
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8701

On 11/19/26 16:30, Lee Jones wrote:
> stm32_adc_irq_remove() disposes of the child IRQ mappings and removes
> priv->domain before clearing the parent chained IRQ handlers.  Because
> the parent hardware interrupt lines remain unmasked while child devices
> use dummy_irq_chip, an interrupt arriving during teardown invokes
> stm32_adc_irq_handler() after irq_domain_remove() has freed
> priv->domain, and irq_set_chained_handler() also leaves handler_data
> dangling.
> 
> Detach the chained handlers and clear handler_data with
> irq_set_chained_handler_and_data() before tearing down the mappings and
> removing the domain.
> 
> Fixes: 1add69880240 ("iio: adc: Add support for STM32 ADC core")
> Closes: https://sashiko.dev/#/bug/linux-27c38690-bc20-43aa-a3fc-1ddd6f1bb74e
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Hi Lee,

Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Best Regards,
Thanks,
Fabrice

>  drivers/iio/adc/stm32-adc-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 4b532db3db62..13b75475046c 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -467,12 +467,12 @@ static void stm32_adc_irq_remove(struct platform_device *pdev,
>  	int hwirq;
>  	unsigned int i;
>  
> +	for (i = 0; i < priv->nb_irqs; i++)
> +		irq_set_chained_handler_and_data(priv->irq[i], NULL, NULL);
> +
>  	for (hwirq = 0; hwirq < priv->nb_adc_max; hwirq++)
>  		irq_dispose_mapping(irq_find_mapping(priv->domain, hwirq));
>  	irq_domain_remove(priv->domain);
> -
> -	for (i = 0; i < priv->nb_irqs; i++)
> -		irq_set_chained_handler(priv->irq[i], NULL);
>  }
>  
>  static int stm32_adc_core_switches_supply_en(struct stm32_adc_priv *priv,

