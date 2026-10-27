Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793118925;
	b=tVglVS8U2TysYMPD1fcStNGYjEPROziSrI2Nox9WK5Xtj8PYa1tcK4J+kuKQpe3e8dvJ
	 s5DBiWV4a/3tlRxj/+TCfWwQ09Xdab+Q/l7ngkQFdPxcs87KGn4YNO5XtYtR543eXu1nG
	 QTq+3uuE2t/ynSTDppgQDzBxJIxdPXxQ6HFrWCdYrSma0Aszr+hT5swiOYljpx76nb5d0
	 CniUguNvWOxaYct/AT669UrAXE8iu/gePkDCesf6DnhAaCl7vduodwbfZlGSQt9gZyzCX
	 hzhxhtVmrPOXoDvCQQobOVWpXiVMM7paJXKUmazbiTUGIf48FoxGMYNTxwO+OsQwUpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118925;
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
	bh=fsZYIfFgk4WYetdMXm1NDJEKlFtStMd756fw9XYMzCg=;
	b=zK8lfEnAxHEHwM5EJTOzgpuF2QYSDAoOSXqlesGwb72xkn4QbHIyl4h3bFC4bJYkAfUm
	 frA7yaODmNy0xZboesDpvxrodMh8LdRt0b7+Ms9SXv9iATMyRBR0IhcEbfnAucGoPjRoT
	 JX6zq3eAUf3XIjNk3+FfMV4vN9Rft945bF15ZUKriD0/Qj2bntid7lwdSzoPpSVX5AZ1j
	 rHRuG394F6OMto2C0+0nHCDvDZ2YYSWqn9FHrfC+LLVK0eIMLIeJsnHS9WimeyssCZB64
	 NEhXaCNtQ8xxA7b+kPmhaNqsaM+73Jm/Ndp10nOPOyiL0Zpnii1Me6jPR2uN67wt0Jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Jsv7GN4e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.36
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011036.outbound.protection.outlook.com [40.107.130.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16656606A31D;
	Tue, 27 Oct 2026 16:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16656606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Jsv7GN4e
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzgRd9EFPebsujo9szvEWVZKAGhcgZZP6iK0GMmGbF4kchGIbJk/iZ06uDOkk7eDoZzjAbqicIcjRIDYvtasxIATce6860y6+1rYgJemc/kB7FVLEwNsWnBkOZz7hr5qY7KXXCCh4pS1Thit3U8/STLr/FXTXW+Lvgu0rBCWX3/SyMfbRLpcYOgAAfnNN+yx9cE0Xys6+I6Rdso3yJYzau2JeGz8uZb6uoDhzOueELtvHy3tu2jYggPKf/W8S1pDeDLEM9r9LSuzImoKH5nqgWehSlilMG1R3P74Jz/U4qwkHGoDcTQb7z7saJJVFZ52gi5U7FLrmdxCYhOK72UFgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsZYIfFgk4WYetdMXm1NDJEKlFtStMd756fw9XYMzCg=;
 b=zOXb+zDMGlpUmCKn5/pEPUp3NDyTqOuLnYFGjKi1BZ8ycTYdylr30PCvjhrVez631nzyl0AWz1Ku6CZh2Z8IGepSMFAEHHZOp3F7imNi8zIJqgomdIip+zO0n+20Bp/IX98B5f+RtIEIt2NsEMhJTIlXsVLdum/ue1GQI6M+hKj3W3KDllP/eChRQP0+WFeDTdsJRgNyvzFlg0F+GVQHIvf+f5eJGelD0qlHiH+5ZOuZeF4cQW+wHK3/IeWxnubGs7+qgzxfW6yktna64YGavkMj6F36gyee8BYio56GCehJH/x5WT/7+KSQ7F/O9mwPzmzK8sPQ3yMEjMJuWO/3aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsZYIfFgk4WYetdMXm1NDJEKlFtStMd756fw9XYMzCg=;
 b=Jsv7GN4eZwcXWIro9WsmnlfXLbEx9bL5V6pNjOGfb8saUkj3meWvYZe3pdBbIwcSyEOcuPNsXf/8xwjG2pMmaO0R4laoZfJx9lqWlEeZtkjnWcOEWikgqKffzEFtN/8aQKeRZ3pU7FrkqMbNpqmagUR3jmAKndmFJuzKnvxnL0jrPpI5pZhZNst+SQ3R4IPzPmCIZFvmXAq5aIw8fZXht32cat6f2pw33Eyr6P2zGiAJBi8gLBvt4V1PSwb5Hd+Rt3b20AEwHdmsAunV+gjU0gAxSox8q6yRZfXfq7xPN/Ud0p7SYCHMArbWEf/jTNHvmh9dPRX476e/4WVgR3N3fg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by ZR6PR04MB786831.eurprd04.prod.outlook.com (2603:10a6:910:dc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Tue, 27 Oct
 2026 16:35:21 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 16:35:21 +0000
Date: Tue, 27 Oct 2026 12:35:12 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Guillaume Ranquet <granquet@baylibre.com>,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: mediatek: uart: clear the active descriptor
 on termination
Message-ID: <auDSwHFea_ctju7J@lizhi-Precision-Tower-5810>
References: <20261022-submit-mtk-uart-dma-retire-v1-v1-1-3f9b99a9d89a@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022-submit-mtk-uart-dma-retire-v1-v1-1-3f9b99a9d89a@gmail.com>
X-ClientProxiedBy: PH0PR07CA0053.namprd07.prod.outlook.com
 (2603:10b6:510:e::28) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|ZR6PR04MB786831:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9421f7-8fa3-472a-4273-08df34484b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|7416014|376014|366016|1800799024|22082099003|18002099003|261026121527099003|56012099006|11063799006|261022105027099003|10067099003|261009223027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	bBQXM1h47NfflRBcLlicZ9aNCB9ym5FzVPvWegJ3++vmM6EoRaoFF3Z2ZlFegOYMmuFGV+l8n6GMCpCKNHF87jvh8iUqSIVar3sWXQPQCk8Ga28ZUOzyPw8pIvUzu74VYlNKzXXydyCFascAW+CRxz4ZtTIaL/4TdxiBAAE5YMOzeel3tM0o6yzrkk6wkrNmaU1TsLdvHmjFAu+3l+SOKz7zJwxTlDlzif8elYXs85n/xggCAPLVbv5Zh1nqO+T8YuUQsBR1pdg9f5NoQMa1cVdwZKrSloTtR3Fl+zvSf5HspQNVAjZVUFBD6x344iTRxE/F+yzw148KIvoP3vz+skVM9leFygvU7Y68c+clJYUKAN6aC6qtjc7GEE9ID6i79GIxGp0jo6snKMQ/6yeFzT7eLra/wU9KgqBbFtcyjXwASoAsC7az6hFaELFS4jxSkE7uEOtkafYZnDqbbyZ72s7qCCQS8StITzB3pStyE/P4JuLCeRnu3prTCRLeTLCep1d6gXkc8X/p8OznaDRsluDyy8PcrJTBbXvKwtoG0H2FiGPBZ1JnrQuxAbsE395cgDX69s/MU+wO2nyha7irH3qFJaEpPDJzZQYnWf7i1zFfuceUxIB6jT8ZnVLbSZz1ii4TdNHTi/FIQpN90J2VWZRfp+EDKlgrRIyO2GGVcC4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(261026121527099003)(56012099006)(11063799006)(261022105027099003)(10067099003)(261009223027099003)(261021121427099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TIlzxGgHtqBNHSTRlMbbpO8yixKlB8sRt+LZ0nFOs4y668qLiy20y7Zz6sAR?=
 =?us-ascii?Q?4oETvOfgRkVu297oRI2frtF9ivDnGgO1yBsYjXPKB4mA1akihtvRm+KxTbFM?=
 =?us-ascii?Q?BFz7gUKaAf/GcFaWIj3UUW1Z5ADOjfQtn5l6fz8SDMSsK8gU37QrcGtYpxen?=
 =?us-ascii?Q?BzfWYcM0ywRSvWo5W2MBKYHvFC3RhvKw0iTWSaHU2JK8yV0H3ry7Lext6fbg?=
 =?us-ascii?Q?X4J5d/VtNBBSOK97/2guHze+wmwulJST/WTrYThVWRcoqiulrY3v9Tou7hlj?=
 =?us-ascii?Q?3zp13Y5zrF9rjkWsMw91bpgboNbFNx9OTxju5TUBndDZrfAPLK4LAbzez8Jg?=
 =?us-ascii?Q?NOTrXME8jZLxuWNBFUPgGczIDsJ+S4mR5UBDh41nSqWB6+jPbsldOWV3h3P+?=
 =?us-ascii?Q?acxHNzIt2ACKFMzDy82ebpxb4HDhhTot6zNNpZoKHavdoKHIB5DSXBRsg7Yr?=
 =?us-ascii?Q?QnpnKYa5WrIoaiWEPyIt+egLPHk4YlcqlNr0FWYXGtTJY0PqeS1TAfi/EJRg?=
 =?us-ascii?Q?xwdH/H//X7dIkiTKwHkro83hT4kuxduiKfPI2vZqsUnjRSdpVu369bPLH+u0?=
 =?us-ascii?Q?1p11QU6sIpj23ZR/5Z59sa8lUJJ4GUbSx1OwcBCMFi4EyaT3cu5M1kbtU1L1?=
 =?us-ascii?Q?VUSxV68tRJu6FxALwMZt5DVpQi97jqBGzLbND/0zc0hjqHSxxPqUp4N/0dVZ?=
 =?us-ascii?Q?+xGHIgQThc08R+H5n84n4Fc9xTuAZYQLiOXitiIwMzw6THyeJL/B2Nb/PLb8?=
 =?us-ascii?Q?uEKyJ75+lQouRtJONyDjBxqTsfMiW4CpP/GSNshm0CXe3tEz1G668tLo5K4R?=
 =?us-ascii?Q?wCCJIMrxk2WiTqBKSOgB4D2D5BO4wlEG+fzRpt3SUizSTI2ZWJwXF7mBbgwO?=
 =?us-ascii?Q?/bHMHxhQvwKMgVOsGKlDTORaJmMGGfO6YxRvFP/3lxIAsKZ4rDz15TMLVNnK?=
 =?us-ascii?Q?eOr/TGlp0sEUvIIVhDrD1XRKtwTtdebakGDMgRV+U46GN8t3D82uDahn1KHk?=
 =?us-ascii?Q?Eefd1EtR+tvLJCWfK3l3jMYvfvxrdYgzzhMM9rTkobEaUKFzWTkLlWprSuxB?=
 =?us-ascii?Q?e/FZguVFlkLYnCS8BSkCyG65ql3ObZDhlIYooowUEdrXt3cuSROBLUOCVu5l?=
 =?us-ascii?Q?1ZNPPUD+cYkIrKbSqvCa+OEReGk6ZKdeDMXSH38e4W4ULGdDhIwQKpm3sJu7?=
 =?us-ascii?Q?UWrrXKPjymaM/P5uDGe+Tt5Z/WN/LNAX8kFcg20kCy+XIecowxa30hq7RbsM?=
 =?us-ascii?Q?ZR4gzO36c9I0EIHYUPYD9eUNoCiEr+ryre9BskcWfzIU+5/SqsWnAoOIuPip?=
 =?us-ascii?Q?wcrwcXhFMN5ljg9AjYZgbu9R+xzLwMZx1QlkfrwsnTOESfDgAZVDNgeFCZaB?=
 =?us-ascii?Q?wKLhEF8Gjs8ILLoZDZNWWksQqwzw1+dnh2XQ/ljK/DDDFYNqDwxbjmERLYCC?=
 =?us-ascii?Q?axWqZKk0Iqvcd0VJAmupQa6TVp7MnbIwcO2Hd9JTryREnLyu0X6gQh8D8PEw?=
 =?us-ascii?Q?rKg8hqZ4lFyKNKd61CXub0jg2FVcVG2NQeJfxQZBrWH9mQ5C/NSibAKeQVML?=
 =?us-ascii?Q?yqE9W9HKFvBm+h7ESH2cC7Oxw5NsDXAR+obBWOYXwXmEkSOdFrdy0Oy/0VGY?=
 =?us-ascii?Q?5PwMX4B4Vj2wMt4d4lXnFAPk8tMFSFdgPJfbyF757qm7mVXy4V8w0Np9GUGM?=
 =?us-ascii?Q?vNC2V6DWEgnX4O+X34UzRP08hNKJiN++MNDukndzceMuekwxm2xNVRZYAIa3?=
 =?us-ascii?Q?PocDC+KogAvA/o8hLiYzM6GU/fR/HXdYCegeymIANg/eceFj7zKv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9421f7-8fa3-472a-4273-08df34484b10
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 16:35:21.2394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMC6Q5L1YLDHmpa7dOZeKZoK6iIcjSLFaRG6E4U5yCB4DvAQf/hgBy0sknrJecs7hev3VnnwM9sly5LitLuiwhiT+JKR9sCOpcYdacIoccrqHG89mlFbaQy1FyUHF1c+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR04MB786831

On Thu, Oct 22, 2026 at 03:11:41PM -0600, James Hilliard wrote:
> mtk_uart_apdma_issue_pending() keeps the active descriptor in desc_issued
> and stores an alias in c->desc. Terminating the channel collects and frees
> that list, but leaves c->desc pointing at the retired descriptor unless
> the completion interrupt has already cleared it.
>
> The next issue_pending() requires c->desc to be NULL before starting a
> transfer. Canceling an active transfer can therefore leave the channel
> unable to start subsequent transfers, even after synchronization.
>
> Clear c->desc under the virtual-channel lock when collecting the terminated
> descriptors, after the existing interrupt shutdown and synchronization.
>
> Fixes: 2537b40b0a4f ("dmaengine: mediatek: do not issue a new desc if one is still current")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/mediatek/mtk-uart-apdma.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
> index f74e9a328588..d9427d56bc50 100644
> --- a/drivers/dma/mediatek/mtk-uart-apdma.c
> +++ b/drivers/dma/mediatek/mtk-uart-apdma.c
> @@ -433,6 +433,7 @@ static int mtk_uart_apdma_terminate_all(struct dma_chan *chan)
>
>  	spin_lock_irqsave(&c->vc.lock, flags);
>  	vchan_get_all_descriptors(&c->vc, &head);
> +	c->desc = NULL;
>  	spin_unlock_irqrestore(&c->vc.lock, flags);
>
>  	vchan_dma_desc_free_list(&c->vc, &head);
>
> ---
> base-commit: 93f51579e7df248780214094418f205253383cc5
> change-id: 20261022-submit-mtk-uart-dma-retire-v1-fe71753c51ff
>
> Best regards,
> --
> James Hilliard <james.hilliard1@gmail.com>
>
