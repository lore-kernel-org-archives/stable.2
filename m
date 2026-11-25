Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795641995;
	b=MJHjxYGwyB3HbOrT5PZdSdotqVLwT6UW1nFjMyfP25XgHeyE6qF9KF75ow5ECN14Yx14
	 xV5udGTzvrx+eyI+0KLYCKy+X22iiBW+mOpfwKcJyPe/1Ok81TXPPJRZZLH/JDMnlHn3P
	 0JJovnyAMRHIPRq8TiDNZcEp5aRKZKaeJOQMFjce3RbN+cXT+KMocozv22ARdz4LR5UEw
	 lCbrLN5gUnZDhhkuQzmY+nAXrwsIGgZbtbTdSZKnPLK/dL6Z3hXglFmeeNewf9VYRR0wL
	 UtOSealYg+/14JZlJnISC8N3IuaVNWU/V13vPN7iIg+djopCFI7aomzbxTOjNd3I6fA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641995;
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
	bh=7zx6nW22fIwz8UPplznpyxhE3VIhEi/9xNXODxW45M8=;
	b=4hK73rg9Te/EcV/Ndy8HN+vIpA94G30Ekju51thkm432gdoYwxpEfFUP4pPk2pZBTN70
	 SlAnFFa1V8siZxHVzI+155o7UHCd43Lkj86FL16mygbXPW0qyv093v4k9+vFXb8TR03xm
	 V+5hlvoK703B7xOSrFkcoqrUUxLTgNJQa1QDkBMO30nqCmHbVf+hl8XU/1/KrAy2vaFMY
	 hcCHdkS20qy+OR41Z7UE3QNUC6WNZfOVxM4Y5sjN0YzxOZRT1C08LiiI0D4e5KPEiJtMm
	 NTL4XIiDi4LAe6W3a7R6lGDgZKyRaytsjdMtTswhok2Ppu6dGR7ClBMQuCgCcflvniA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DtcchiGP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.39
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F66606A31E;
	Wed, 25 Nov 2026 21:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4F66606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DtcchiGP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hij9FsogHieRN/09Fijp5bMsM/VUUYhghj2zIJlRCQe/lNaNBCMt7s8UdXfFFVI6iQ1mtFko79IVAyWNgG0LW4yeQfSMQ6+gCDhcNFzsEIAEvdFdMAjB8TJWK0Uweumx1bL3BXNH5s0Dgy9IPigazDd31OH3MkYMidVINTQaaw+6xmCCN5/fcKo5LvRYErcGrA664InaIiuIhrvPJXMyRHx9o3tpw1ZPyexkzpv+zjQsHl7uOIr8hvdPRr9aWM2s1LPtOM6LNs7epix8M7LAY7kYlkOSO02p4TJYtl0kvPl3GkV/2rv6gdxydezd2DJmugC5C45rIjdL8mtlvW+KGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zx6nW22fIwz8UPplznpyxhE3VIhEi/9xNXODxW45M8=;
 b=SRNpt0Rxino1FwVDfylniUqXhgyCQ+jRqqwftR6vYs+5IsZgDlsyutdLekG4WsMeZ8QsGVrZoqhQXCzWfkKM18s9A8fSHrRkMnojP8E7g3pbaEqLVrTkPmhqTDukMsqc74ZkqH8GNjwMaAtw/CbuXtfKsIkz/FRM7skDK7OZD61qcl80M99aAgE0wFy7Oy6/2OQKX6W95szkg6XQq2xbgiYB0lKWGLJvsoBj7hFZDJC7KAsqpK2htAG4Rz6rHiE6/LGhN+fBfshlPX9b24MYMSB7cye5Ndu5W7KBDJ3ndRsM+WD3CZWTE2Xu55rxRj1GVGk3eTABTlU8hT8NAfSheg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zx6nW22fIwz8UPplznpyxhE3VIhEi/9xNXODxW45M8=;
 b=DtcchiGPbrbtGngUHAgOX75+xNATsFys6fT1VwhsGQWLnb7iH3KFQWWvoKCAZ4LH33U+wFRAiF/0l3TW6wjMsv0XRGhq9a7DfWjWG744BDTgdszvla1/IVorcbzx7XKtCdEcL4GW2qKA9zk/BSXtbdFwuRb9kyb3AcHJA3xYxL0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 (2603:10b6:303:2fd::15) by BL1PR12MB5996.namprd12.prod.outlook.com
 (2603:10b6:208:39c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Wed, 25 Nov
 2026 21:26:31 +0000
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167]) by EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167%4]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 21:26:31 +0000
Date: Wed, 25 Nov 2026 16:26:22 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: bp@alien8.de, tony.luck@intel.com, rounakdas2025@gmail.com,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] EDAC/altera: Fix Port B error injection in
 altr_edac_a10_device_trig
Message-ID: <20261125212622.GR2156781@yaz-khff2.amd.com>
References: <20261116131641.3064859-1-dinguyen@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116131641.3064859-1-dinguyen@kernel.org>
X-ClientProxiedBy: BN9PR03CA0887.namprd03.prod.outlook.com
 (2603:10b6:408:13c::22) To EAYPR12MB923140.namprd12.prod.outlook.com
 (2603:10b6:303:2fd::15)
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
X-MS-TrafficTypeDiagnostic: EAYPR12MB923140:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 06cf4de4-47cb-4e0f-7bb4-08df4b3ac5da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|22082099003|18002099003|56012099006|11063799006|261021121427099003|261009223027099003|261102123227099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	vwuvvpyZ2ttni7hezULKUL3G2AO7ndS6QG+kffYYsWTNEGPcG6eDicf2bPmG+Qw/AGAdqTxBYNhcWfABw0sjxAOstuT636AsXWMd1+qOymUgXc5GJXp8CORehURjc1LZzHyIib9sBhU0nOCH+wiUg8W6k//9xA78VHr9t+evfZJIFZ0wjCp4WafaoLm7QqJRDPC8g7ViTXjq2OXX5HjkWao97I2ge9dwBMZkGiAaDPQECGfQANU4TyXgJZV6HibkBKYZ/hlMmiVEtEUtYnEPVSRAiCA0Q1dKHD0xpSwsSGBbn6Fxs84EbrWCVXVyZvqM1VVfeqI5Wx/FYAde+L4LrXQG/pgtsVPAjmO38sWquLE232wCW1p3pV/6PTY/m2EVubYZ/wyLoRGFJOndaFefRXKFLjMrHF0iZLlG9VrIn7zSlI4bbH3w71d+LgNYhMM5kQb/w32FPlmeeAcmvpbuMINy6Ke9Q99SQRsbrRF0ieGVHnl1Bw9BimGPRrmoItRBklt+8TU1VcV8m2LWU2EydhPmJd++1eYEzxjm4VqORghQYFRkZA0oFaqYjjiIrMA4UQMi8GPYe4ZrVhqh3nQwj/KiBLlYnFjQqVJuIu6aWo4QrCGG3gUS/vr5xVEaIOMf4VMBNHCsAeYxzuVDQlr7RMOg0V5vGzPaGF+0RoS7X84=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:EAYPR12MB923140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(261021121427099003)(261009223027099003)(261102123227099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gln6igDvXgptFeKHt/KP1CcNtVeHQTt32c6JIdtJbtX9Dq0pt/hf9kvGrKDd?=
 =?us-ascii?Q?RafOusfK8FGQ8cyziTYXhy7fpfCVK/9v/e3EZ4p9YTvlByZuU4qFoBUoErC7?=
 =?us-ascii?Q?u8eegasM3PfT/J0D7oQyMSrF/7TgbOQz4BKUe3WTea3o9yIiIJqNKnJj2i75?=
 =?us-ascii?Q?t/R7uIe9d/sj4qfETSH7SJGIZeapfjzQYi98sAnR912lN8YoZLVGQrrXHTv8?=
 =?us-ascii?Q?BxyeLK2c6N5amxoth4V47T3Er21vaxYPv/w4bjhZrglah3IV/C4PKjzjHYMl?=
 =?us-ascii?Q?4WlK0p0+phaItN4hp4HFXf0AXy6gl4B0YOy+JJSERUh8V/yoxWbnvYX7Hg34?=
 =?us-ascii?Q?K1cyvcc0u+T5FfZKdssutOXwjQra0BvlxMIvBz1pfZUGMG8sEv0ghmQGIKnH?=
 =?us-ascii?Q?pkwzm3HlHnVE7y2/kqVCXrQyZvGPOdVUSp6l3xwsQK8bKHFqJSYp2VvQFRPY?=
 =?us-ascii?Q?2oscwE5eq+cwdaL8cZQ7fI9aW8uJPZHvkl02wNfCqhelSgmMULixpgXqgJeP?=
 =?us-ascii?Q?JzrBfboN6hqAOnKadX5GOjmXObqBkiCyRaqc09Zittl8vjeY19UcGnZa846m?=
 =?us-ascii?Q?y7MMnaZ7ACpDHvtx5g6dZabvyaI4//mrMLraPjADAesWKgIXEPbiRK7931zx?=
 =?us-ascii?Q?/dX2GCoFmte8v3VCXJ8yD2z5WBDcpGUiWyHLiYrsQQUMSGxLD+BLlonwHbnj?=
 =?us-ascii?Q?P4463IuGj0conIm67/VKCQfQNXsP+A6I7iYjx21vUkqi70E9NVIQDVsu/iH3?=
 =?us-ascii?Q?9aONy3N4gyvkhQwvl5tgoDu+/Kb8QnJDWlGMxyRxm5aXfCpnhT5IhxUi6iR8?=
 =?us-ascii?Q?DsN+wGM1ButobSOToYPoX5/k0kvELwBc2+bq3yJFf2Enau5MCceff9pjBpzZ?=
 =?us-ascii?Q?bFw6tg1UuFvbfhvatzce1AZ7fmrGC81IS6xhn4UI8wywtaX/TAD6dFWaIOPl?=
 =?us-ascii?Q?VVzZt1ACOUKMehiRKGc4myg1GQwiZmxP70ttY8ybC0N+cUf15PkDQM0uRReH?=
 =?us-ascii?Q?umJRoU24tG2wOyZs0f/SoZpO+1l6NuHc0WD9Hm2ZMvm/NMqN1cA8EjeiogqO?=
 =?us-ascii?Q?0QjaiP+Jj1QWEY39pt/Lh9jdLXCjAtzLW/ZFXI29epaAPigACgHZAHs6rIUm?=
 =?us-ascii?Q?hxOPLFE0FPExVQv6Y2VtAIztufPwyuhfWfmDBXJDCKRKJy/NNj9ehV4cbPOQ?=
 =?us-ascii?Q?dWDGTLIZvidTLJ7y1Hvp9GQDrWq/+KUznb1ckkn+xPiFFNNjqacUWhQ/8Dpb?=
 =?us-ascii?Q?BAXt7vUuQD+K0F6xLu2g/EYT91UFGlaC53XBi/uir4KT5mQHZSkEVg4iGh5v?=
 =?us-ascii?Q?5N6WK3GrnaERYRkSdfxPKNCoTVQDO9qsfXg4GNmPoFQ6P5fFd3T2JUpHRdN9?=
 =?us-ascii?Q?+iZm5ySovO2qWOuAkA3zpzMHgljd5IN4NWpZv4aQGNkvyDD3KQCKiy2779kX?=
 =?us-ascii?Q?pIDG+ldFBm2WmqtfR0cJKkhF0s8H8Hjyy6LyTqtvsH4YdkWFkk0nGlKJivWO?=
 =?us-ascii?Q?YZUw9Y97jgE9XdyJNUMLXpH5f/6TKcMPkFHyVBM8xYKfNhNeQaasCfalYvOC?=
 =?us-ascii?Q?CV8tCmPtxkM0RlFYLjSWtDfBJLq6CjYtdbXneTdsNUbkexIhQmuXiYcmKKXB?=
 =?us-ascii?Q?BLi+KZ+Is5PcE4NI6y2K1o0hqUbsP++dfOsBjOJ9P7T8a8RaSM2o2ler88Vl?=
 =?us-ascii?Q?MF1ygIxUlASK8v5sOe4XmqMXHfCiOG9fG/IynU1l8IbL+BVB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cf4de4-47cb-4e0f-7bb4-08df4b3ac5da
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB923140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 21:26:31.0813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7t8aCd4YoaAuWEA/PlI11rukvEFEKCHvVfaNYsFt5FlENV8IkQvABwevCMH5gnk5c48yx+n4TrKFkPmeZUZ2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996

On Mon, Nov 16, 2026 at 07:16:41AM -0600, Dinh Nguyen wrote:
> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> 
> The INTTEST register on SoCFPGA only supports 16-bit writes; a 32-bit
> write triggers an SError to the CPU.  altr_edac_a10_device_trig() was
> already using writew() correctly, but Port B test bits (TSERRB at
> BIT(16), TDERRB at BIT(24)) live in the upper half of the 32-bit
> register.  Writing them to the base address silently truncates the
> value to zero, so no test interrupt is ever asserted.
> 
> Write only the 16-bit half that holds the trigger bits, and leave the
> zero half untouched.
> 
> Fixes: e5ef4cd2a47f ("EDAC/altera: Use correct write width with the INTTEST register")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  drivers/edac/altera_edac.c | 16 +++++++++++++---
>  drivers/edac/altera_edac.h |  3 +++
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index bb95dab847b3c..37ce2a87443e2 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -1741,16 +1741,26 @@ altr_edac_a10_device_trig(struct file *file, const char __user *user_buf,
>  	const struct edac_device_prv_data *priv = drvdata->data;
>  	void __iomem *set_addr = (drvdata->base + priv->set_err_ofst);
>  	unsigned long flags;
> +	u32 mask;
> +	u16 half;
>  	u8 trig_type;

When adding or modifying variable declarations, consider ordering the
lines from longest to shortest.

>  
>  	if (!user_buf || get_user(trig_type, user_buf))
>  		return -EFAULT;
>  
> -	local_irq_save(flags);
>  	if (trig_type == ALTR_UE_TRIGGER_CHAR)
> -		writew(priv->ue_set_mask, set_addr);
> +		mask = priv->ue_set_mask;
>  	else
> -		writew(priv->ce_set_mask, set_addr);
> +		mask = priv->ce_set_mask;
> +
> +	local_irq_save(flags);
> +	half = lower_16_bits(mask);
> +	if (half)
> +		writew(half, set_addr);
> +
> +	half = upper_16_bits(mask);
> +	if (half)
> +		writew(half, set_addr + ALTR_A10_ECC_INTTEST_PORTB_OFST);
>  
>  	/* Ensure the interrupt test bits are set */
>  	wmb();
> diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
> index 9387056fd65e3..fe6d0289f5c35 100644
> --- a/drivers/edac/altera_edac.h
> +++ b/drivers/edac/altera_edac.h
> @@ -244,6 +244,9 @@ struct altr_sdram_mc_data {
>  #define ALTR_A10_ECC_TSERRB             BIT(16)
>  #define ALTR_A10_ECC_TDERRB             BIT(24)
>  
> +/* Byte offset of bits[31:16] of INTTEST for a 16-bit write */
> +#define ALTR_A10_ECC_INTTEST_PORTB_OFST  2
> +
>  /* ECC Manager Defines */
>  #define A10_SYSMGR_ECC_INTMASK_SET_OFST   0x94
>  #define A10_SYSMGR_ECC_INTMASK_CLR_OFST   0x98
> -- 

Overall, looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
