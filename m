Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794323695;
	b=2g5B1RvQjITfeTNotqt6wEf91GV8O+TbLUxVakxX2zTlVYUz/lvmXlXIDUkX7Onv3DyF
	 6fuIb8RUmVZw1WhAn76ztIvzxqYnSOh3+StBOcOsI6s2fnoOvdljkAxZ1YLqZRBC7usW3
	 Qu9Th+PKF6IujXdJTtxKrM6TJ1TjKONSebD5Fmax+lJSFbKi/GKGbTAGoRiXWTSzuQckj
	 drX5Xw46JI09y757YLfABYsT3XsQKUTsJ9MP2a4gNpL4sXf1Dp7fzfA9SXcmQYst9kRbq
	 vFhJJ2Y6KDR6JSdH3jVEnkVZUhFJt/mgvJdsCDQffevNgJqSPrQ/umIiBYKjCAwGgbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323695;
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
	bh=uSjAL93E3yJGenoOyrPC2KDPVIsqypHmHHFvbfTSyG8=;
	b=N6iu+BlguUS1RXbV6KH6r7Y20D5fI74fKGE9ahFySZ8EI5Ratm4IYtCjaxSI9RTbBTCO
	 nOcPFTwlIsRNIkC6OObPDIgdsPRX6UGq0lvsit6jIjkWSnSZLN7nHiFciWGc8FR6ippqA
	 8TEsl2lUeBaBU416kTGsEzYKbKnue7WxdqmiKofAR2zpDz+KbDX1RKoXS7DbI3F/Fiady
	 Nz8ovsx/kzGvfB50arLDJmF9DK5MQ+P6XFfuqmybB/JeP28yfbzVPlfrHm4i68ltdIswy
	 oyyllTZlfbhuBD65GmVkrwHhN2EeUhYbAB28jX/ohOLap+bCoa6DkdiywHFnk3GLVKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=yLrQB47U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.52
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013052.outbound.protection.outlook.com [52.101.83.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5686060A262E;
	Tue, 10 Nov 2026 15:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5686060A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=yLrQB47U
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8zRPB/l3uuu9uRFgAOa2D5KS19Q3SItMIeE5jwGeWYoX9yVu+Hl86C08zW/6tufaIyHcUexqah9dZIrClvGKWqJVo0hw6eWhU1lFF+X4Iou7DRL9DUozVrOiE2CKphoLf8vvY0rqwnuHas87nodosJAxLQJp/7VeHxomjVdjMqwkqmT4NAirxskZ5Qo76yJgbpI6oMB4kDJT2OguEULI4xZfBSALM1No1F2JtwBYc38AUu2st7bm+MTmntkKlB4e/P0rrZO/hM+v7C2BFoV8hAJkhj6Ltjqk+PCWsElTHhfE6EkMf74cCtdMU5rhYd6NHH7v2MOW92HQOFVP+d5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSjAL93E3yJGenoOyrPC2KDPVIsqypHmHHFvbfTSyG8=;
 b=syghrhsvcETe6/6yTFx1DQ9wgkk6p/BZV/iBZHPolQG40aNbZR3hiWOXUClsRmZqGO44q3lIf4PvQ35KQsjIzYxDfsOJGjhshW2cbFQBUw/kexf0VhXODTXxXw/PUYViuPhn57Uar1KHpErYszWVKk9H9t8vKIJBzAT4XYyZ+xhWUY31H1iTP9f/8UjjmtJvwubfwdyNIKgj1z+9zGQemkUKrq3kwXmdGFZKEJHvCY+nL/mn/jcZDJavFm8HTVn8nFiRtS0FCH+q/S9dbjMgX2cSMrvvIpJ59CUxTXia2ZSUqg+BMSMnfADHOH0eDzehAcP2U7aUlntvnUDzZn76ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSjAL93E3yJGenoOyrPC2KDPVIsqypHmHHFvbfTSyG8=;
 b=yLrQB47UA0ZZqC2msVxPEczGGZn4AT5vSWUpEjv+opJAx9qJdJ9jKo0j7prE7PcEYVbv/wm9+MmRmXk+xLRoCGA7I3+SY45FrRMTsU6ZcU5OhvEga0qDnJZX8+Fzq15fwWITlxRYQ75BA1FKSrjISFQihSyaLNSQRQ0vlnCt8cUK7twadWNy890Rt7F3kgSra8KNeoMJvKITHk06lvLQSyTpDgS02l2Pd0j9EOk2xAVNoQlxjx2695YFplPBjxYpjR7VlLtSv6NHmdHtCKFGjPR1HOVI1HrjK5mn1AcItZx8ZRZOez34yoTZ1r2Ytt6w0Z7NU7ZkNsczRICz7G0HEA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by OSMPR04MB11293.eurprd04.prod.outlook.com (2603:10a6:e10:93::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:14:50 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:14:50 +0000
Date: Tue, 10 Nov 2026 09:14:39 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Stefan Ghetu <stefan.ghetu@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, daniel.baluta@nxp.com,
	linux-phy@lists.infradead.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Oliver F. Brown" <oliver.brown@oss.nxp.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] phy: freescale: phy-fsl-imx8-mipi-dphy: Fix hs_zero
 underflow
Message-ID: <avM033EsUfTpNrw7@SMW015318>
References: <20261110120546.6247-1-stefan.ghetu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110120546.6247-1-stefan.ghetu@nxp.com>
X-ClientProxiedBy: QR2P297CA0005.MEXP297.PROD.OUTLOOK.COM
 (2603:10b6:3d0:6a::8) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|OSMPR04MB11293:EE_
X-MS-Office365-Filtering-Correlation-Id: e2172428-c9be-4be8-ae32-08df3f3d5d7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|23010399003|56012099006|22082099003|18002099003|11063799006|10067099003|261009223027099003|261026121527099003|261102123227099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	+UW8be1B6LfQ5FlhX0NjHwUMJpJiC5KxwdbhXIC0CZD6YqSuk36NeImgmBl37SbR07IXZmz2KAjvAO990KzzNFzQDFBwgDlPFNrOtJmJ0co64pD6TJROij6IyVCz+mL/qRBzt+E34WStcGqK7cxMP6QqvVl+jvdRr2hoaQQW+/WnYTWdvS1pHj5ppUrd4QDjgFfEohchu8PG/fzNLZzrhuvZPwfg1gDuypC8glA62GSWjpWvWlaaHqyHk++7FyF39wl2QXAyucXDlB4EhXqEXg2xlNUiasGWWPHQRrcaDlXZ9DUi8ZLFjC2wUanmgUaGtjh4n7x36fAyorPnt+yKAegGyI+kVtHhpRQuTp7/1dPUOKcQ836G1i0oFAGEcJBcupdNlLoe39jfOVo0pqP6mK3FkUFDwG/xrbSXsv5jZo8r5quOX1VgFEWPY5bfJBNKJ2GTF/4mA03uMeNXX+WErJEU+cxX1LNUObobj9bs6dBsjx02Ezvh3la4RkRQ6FFND4Hf1x26vO7fDhXeem6FPiFnvkkCjhg1jn/tHcg0BdvDzAJKDQBpa3j+oDbkg0gpKRKqXZR3QZBQ5vy78AzrYHbkiQFkmEgbscUAeQwS1oPAVpxLR5M3bPBLFw7qxLNN/VMjGXDv93Sf+XzDr1P6Ek/WPUSfpWDnDBeLHE1qSpQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(23010399003)(56012099006)(22082099003)(18002099003)(11063799006)(10067099003)(261009223027099003)(261026121527099003)(261102123227099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JtBDoLAwREhQPHqNb2XRxIOJhque8+V/mo+iRe6OyYLDom9IkFfUU5LnfXF/?=
 =?us-ascii?Q?M3FJZlFaj/UpIYDNDnroGSqAA3g3pyVIdhTQdkW431Q7fybDY7yEDoc0US01?=
 =?us-ascii?Q?B7cxnodErlQ0K3Lu7wWrFj4bicKijAozm6hVXkbXDJoaZyCLCtIU89lOxte2?=
 =?us-ascii?Q?2BFj2uxLijTG00pbY96RWr087V6t3ifQ1offDCD/X+embSIa5DCfx9sw4sUi?=
 =?us-ascii?Q?W/BvfxcwixKGpDHUWzTvUzY3AtIeLDSUm5/lna6PVGdoOhwRIB0TExOudvzd?=
 =?us-ascii?Q?wEZSAGOd45txBJV01i9fkYXzILkmUD8BQJAF7j81mN7sbEc2a5bJXGOZX9Ui?=
 =?us-ascii?Q?b95yuWwn3wOdsjvYF2OQB86yLA0JbpSsvGFGBodDQL+ZsaZo/WOosmZr2BV9?=
 =?us-ascii?Q?qIDvr3PXr3c6CFg6Wu1g2eizWFSquW6lE98EYMyO859A/wc2EOi77fIIMPp3?=
 =?us-ascii?Q?wSLOH8pbnkpqvrRgdGcPxXS54APjowDgshNih9lk7t1bFKXkcqgXhXFD6itz?=
 =?us-ascii?Q?ndrBP9X+9+uZy6S0PI0LR29+MMSE5ujls8uYIerjIhcQDmq51euWwvnBp3ZM?=
 =?us-ascii?Q?AAwSKGn1SkxmnVhuf7hJ0W1EKmsRucaxvscvUiIhSJMG4W31iW2K1GmwV2qW?=
 =?us-ascii?Q?HCdElKfCbOmm0afgpfID1WEQk6t12mpqdiRFtrGqYVu24MBf4pVXGwVq4+2q?=
 =?us-ascii?Q?xUTpzlUJwKdDIM+vlhG2u4iIc8i6Oe4KNPv4ajdc0CKeC154KBJWOzYTPhEu?=
 =?us-ascii?Q?bHvK0PG3jenkicYwNse7L0UpHcO+s+Vnr0WuDZUq8bCT7x3fOYc21s7VGXOE?=
 =?us-ascii?Q?Ynn6D7vcNyVV3lrDRBajVOMdPqhBrBk6emovbNtEkzgNiXoAdmTf10dxzOVh?=
 =?us-ascii?Q?0IXNDuD3ZP0O3zxXtwcBPHthyAXbdkJg/r53El4lbaO4k1dBOeZDnAyriXwA?=
 =?us-ascii?Q?DT3XfwUIqbFjukqslG95u7/fL7SAdXVgsZ+KBPZcUnolleEPbfIsr0C0ozyB?=
 =?us-ascii?Q?H1nBVBMMETQ6I4PtR+SGH25OaZv/f6oBYOalapWlGojFU8qmosxk9xq2BCvy?=
 =?us-ascii?Q?YZ3jt3nkTF3WI/dAsKL8TX63xZbJRT1LMS1fwkO4fg7CGe/6LMvRKs1mxA6/?=
 =?us-ascii?Q?6T7nCZoAKC4H6MzPu6eZjDRJvo2oHNKVmzm8wGiCdY7W56xrUg3OOkNGBDzK?=
 =?us-ascii?Q?uyjUuyBKm3WKhlovThJeStXB85MtTgzWYPfF1jrqEu26llZ4CRDG7bSm9APQ?=
 =?us-ascii?Q?fE7tnuy0pZcVisMghLCeNtzLBYjNTBMxLZxMQcLPSQFsKTkKvS2a2ctkJ8ZB?=
 =?us-ascii?Q?TtNzeCNqMCbVB4QWGvkghoTgqWJIt6pI1XQs3ce7vVTM6yHTOCZfiythnl0T?=
 =?us-ascii?Q?4B1oHPx3StWvP3afwFk+vjQdd1VxtKGDH400ah4e37HhQzSlMs6ghGg9VMPV?=
 =?us-ascii?Q?Lefiscu+3eDT+ZT2Ykk1Kd9gwVkQisZixnR9kmrso3EikoDvFL6cX34Ff2NF?=
 =?us-ascii?Q?lRO7KUc2ouOUKE9P7D6BQIDlGQJyEBsdZ2CUVVO/5XiYKKj/YkI2MLcvFvgW?=
 =?us-ascii?Q?pnACenvjteLfl5xhM2VvabXnYnacx1o4EXq/Q/hAoKXFl1+NLbvS5FBfeycC?=
 =?us-ascii?Q?a5l8EnYHXsk0QiXHAEuidgX6rW0bKQD4/QIvHIF7nZj1FEi33Jh17aeQ9KG4?=
 =?us-ascii?Q?gaCV1spq9AbeMd9SBI/YR2qi684mJZh7jqFM4XB/Wu4vQF8U8PmN3n5t9B6o?=
 =?us-ascii?Q?DoWUq3iMRD1cjP111QKrIcJYQvUS4LI1nEpo6LTmt5ZsZlk21EGh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2172428-c9be-4be8-ae32-08df3f3d5d7f
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:14:50.5513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RghfAP9KFuqiS61pbb8g/DxTm1tNCTeoqf46IaW+NczrxY5Th/seZRTYZpOAwY1b8Jz0ZJPX5htd+LSpQN5eo3mRd5tGp91NyJ8QpYYUkVkO+ZjSiDcXuZI+5BuDU8TZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSMPR04MB11293

On Tue, Nov 10, 2026 at 02:05:46PM +0200, Stefan Ghetu wrote:
> From: "Oliver F. Brown" <oliver.brown@oss.nxp.com>
>
> The hs_zero timing is computed as
>
> 	n = (144 * (hs_clk_rate / 1000000) - 47500) / 10000;
> 	cfg->m_prg_hs_zero = n < 1 ? 1 : n;
>
> hs_clk_rate is an unsigned long, so the subtraction is done unsigned and
> wraps for any rate below about 330 MHz, where 144 * MHz < 47500. Because
> n is a u32, the wrapped value is never seen as negative and the "n < 1"
> clamp does not take effect. The garbage value is then truncated into the
> 8-bit m_prg_hs_zero register field. At the minimum supported rate of
> 80 MHz this programs 199 on 64-bit and 181 on 32-bit, instead of the
> intended minimum of 1.
>
> Make n signed and do the arithmetic in int so the clamp works on both
> 32-bit and 64-bit. The divided rate is at most 1500, so 144 * 1500 fits
> easily in an int.
>
> Fixes: f4c8116e294b ("phy: Add driver for mixel mipi dphy found on NXP's i.MX8 SoCs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Oliver F. Brown <oliver.brown@oss.nxp.com>
> Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> index 0928a526e2ab..84bd21aaf9e8 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> @@ -191,8 +191,7 @@ static int mixel_dphy_config_from_opts(struct phy *phy,
>  	unsigned long ref_clk = clk_get_rate(priv->phy_ref_clk);
>  	u32 lp_t, numerator, denominator;
>  	unsigned long long tmp;
> -	u32 n;
> -	int i;
> +	int n, i;
>
>  	if (dphy_opts->hs_clk_rate > DATA_RATE_MAX_SPEED ||
>  	    dphy_opts->hs_clk_rate < DATA_RATE_MIN_SPEED)
> @@ -276,7 +275,7 @@ static int mixel_dphy_config_from_opts(struct phy *phy,
>  	cfg->mc_prg_hs_prepare = dphy_opts->clk_prepare > lp_t ? 1 : 0;
>
>  	/* hs_zero: formula from NXP BSP */
> -	n = (144 * (dphy_opts->hs_clk_rate / 1000000) - 47500) / 10000;
> +	n = (144 * (int)(dphy_opts->hs_clk_rate / 1000000) - 47500) / 10000;
>  	cfg->m_prg_hs_zero = n < 1 ? 1 : n;
>
>  	/* clk_zero: formula from NXP BSP */
> --
> 2.34.1
>
>
