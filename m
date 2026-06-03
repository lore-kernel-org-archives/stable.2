Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013016.outbound.protection.outlook.com [40.107.162.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB2E3AC0FA;
	Wed,  3 Jun 2026 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511158; cv=fail; b=WPV+bAW+2BxJ4wzSQEJoEJZPw0ThHOunv3Gtprd6izeTYN/4F0Qy7RkeP0utEFDRS2f5slEgqRPLlMHPKNJHf8dBd7RuiV5YPKTPmPNWeW+6J1Yy+c8MZNt3w/AK+IDBpfz5jzp4Z8N7b9x9dqaSSEdOsinF4Q12JwNgE8CKE6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511158; c=relaxed/simple;
	bh=Cte4IibdxZvE+5HLuwt978erQCM4QScIWC7wULxv1Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gt4IuvJtgKdmtTMLDEeOmZ7MNGChosA5ELffdyt/CSRrtFVDbsEJv0B89IHkwVSZjE8I3Hpu2/bNlHAWyzsPj0R/Ea+WYAS0NLO8Ae/8kf1mOZ0MX0Vopg0/Km4Gkos9TiVJB0hYnpQTyz6CbKOHz312TlssUQbyaVE+o0Yh2FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OL70jeNR; arc=fail smtp.client-ip=40.107.162.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OL70jeNR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQRwmqSr2UoazxyyXz8vaJVzMLcPHcMxne3tO+9vL0abDoCjP64NUi+31ONl37IssP2hUd/DdD8DYRX1KzUBLeaP2KOiW3uZIB9J1mV1LgtctZSfCWLgnh7HZhHRUY1DlGZAgSnve176w0lRXkxxTxueqEeapxusY7L0HLi4CxTdS+IGw9mvl9Zy9QTxdGJBotcY/+GBNMtOexq1TdPxeJxM6Uesrq8jjW7WPwtUyfjAZZAaeZmIckynFkxlLHWzZkfHL1WAUcAPD01C+jemzp0O3CXyltP7hgs5923R9Ju6p80Kf3s7qUydNk5vQG0BV4fWZWUANHAhz6UiywYHKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYf9zqAkwe4A/uwWbD1D1D08fPtGbuiKj6p4y3N/f9A=;
 b=TnJoTGuWFh/8kjd7crlu1V3USJqymzmjVzva4S7tdA3fUEz7odCOAGXD9k20prLaNze4VrrvDoObFpSFLtM7eFU9yju73hlfKlFLx+L/4Fx0dbRNBiO5LHX9/OqrTL1vgNA39CcEVTvQLJkvk6lqPZi+oI8ofkR/nWxQ4IaIfdBVjfys5Vhr4HPye9/cJvTtFgNy7qpvNBd/NMwdRrbDR/aSyhiLstYxmwz/aZdxeq4zMOEDkWhtlLxsFulryDVPYt5LbH8/w+SH2fsbV31c4LpXvSnk11e08Vu246AB7gPL39tHjc8IZz19Nzld7FKz10XcMOtklmiNZVdT9+Ozrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYf9zqAkwe4A/uwWbD1D1D08fPtGbuiKj6p4y3N/f9A=;
 b=OL70jeNRkKBPc5tFBb/jbs4FRGNrBQZ6U842TfBX3fnLmx/TYOPSW4ATOwpiICO+XkEkSMQjbU0X2lZwrsqxA/jU6qShyZWyezlUbxxlG0y0sD1y4ZI5P+YblkjpfHx1vPQ9n3iX/3qtZISFnalEbQKe2oNh2J754wieF+9T4Nx8mF+4r4LFdFh5EsUAj26o5OpMuL7+9pNUJVgowb4ng9bIjR+a5Cw1sySlHZ20uB8yoaBGO5ENxYcO7a7zBpYrWZ47RLkw2t3bAxi3puSeDTjvKIbxuT6eThGNNrylQYmeN2HkdpeJAHSrwUeNW9L+MkZtAW9hIh3jKG8ScZ5ZDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AMCPR04MB12669.eurprd04.prod.outlook.com (2603:10a6:20b:76f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 18:25:53 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 18:25:52 +0000
Date: Wed, 3 Jun 2026 14:25:46 -0400
From: Frank Li <Frank.li@nxp.com>
To: Xu Yang <xu.yang_2@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Jun Li <jun.li@nxp.com>,
	linux-phy@lists.infradead.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Felix Gu <ustc.gu@gmail.com>, stable@vger.kernel.org,
	Xu Yang <xu.yang_2@nxp.com>
Subject: Re: [PATCH v3 1/5] phy: fsl-imx8mq-usb: fix typec switch leak on
 probe error path
Message-ID: <aiBxqjm5lsPDXEtW@lizhi-Precision-Tower-5810>
References: <20260603-imx8mp-usb-phy-improvement-v3-0-7afb8f89abc6@nxp.com>
 <20260603-imx8mp-usb-phy-improvement-v3-1-7afb8f89abc6@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-imx8mp-usb-phy-improvement-v3-1-7afb8f89abc6@nxp.com>
X-ClientProxiedBy: SA0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:806:130::35) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AMCPR04MB12669:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a824984-e165-49d9-181d-08dec19d8b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|52116014|4143699003|22082099003|18002099003|56012099006|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	ULK+BLQ1rTPqeg7nCzM3SgafC0qle0ceDcMxhYLOXg+Ihp9196NVg4Bg1Q2DX47LaKyeCcMhgt3aGQ2PddxKmI4PljwXSf5MUsorWc+/PP3Q3wLuOw+yZtU97A4ymKmVS60YlP5CxdDPMTdl9aIgcobYJw57xKDIPcvj5b8ON1pxoFqFIR6MGjL2iqO6XQqXRDstroj+MdBhX20+NaHlxy7DK+DjiB9q2VLKuFm/QOTh01pBFZ6JoORuChwV7PVmdpd33pOFaAhj52yPLxSKwdYpAZr5VEC1SIw43KBxItta+Jfp4CdhdGRfkN6Ni4XxeNfmzeFv9P/GXagkYJvivkeasbJFZWNg2Pz8n1YUri2iaSe10Nbz7tB0/6No57yz5pr8I0ieeUgqIeRRI4T7oUYqwCRDaBn+NbAIhmEJN+iXqE2sA3Avw+3OJ3RJ72QZIReogPsdyFzdeNrmBk5N9ehTiPkfufMU9DKx7F8SOvTzB9GMZUm20ex2FaVcO8v7GDMqFmqcaQHFN3vnrMXTFf0fdELLqZ2nTcNsi9PEElzba1ExTG1DZKFF2YT+n3TG1/9YddpOaJu7eckrSnSsPVHiJjWZ25CeqwxKYnjzN6G8mNob7AIeMgdcAOoc+9pTYaFgjpgmxhvE5Pz42RmmgIZT/D5/g/Rz/jUk+1NDCWNnA1TVHQf6og3Dq4FyZbGmpz9S04LV1G55NhEOWz7uTKY8tRfywVjOoeKaP9hZ0NezNR8Xpl0xsHEoo2Yef/6Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(52116014)(4143699003)(22082099003)(18002099003)(56012099006)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VJv8cZLQWMYJb7WyIK6xM1/tJbcrnjl8wM1h3me8qmq36ap9dPH6njqjQQig?=
 =?us-ascii?Q?KQfxCXTM5b6J8u/tPdW04Hwczfr25arYn8y7gkLKdDZzCbV9BKZHjoHqqV2M?=
 =?us-ascii?Q?UD8vK7/+UpOYc6gqPF1uKC/aLjyTQSG9mSVzmejhXPjVH+wT/CRzUgojWJxb?=
 =?us-ascii?Q?VwnEGpozETobxxpNQ2G9plB6nfK/VW3wSPfqpJuQh2tIQThrGDvgM1SQZF4A?=
 =?us-ascii?Q?GSzjAewocRuR+oJPBPh3D8T28ypRcpC6mKO3x/ENejjbUe07sWzBIlsq8Z7W?=
 =?us-ascii?Q?53RUik9cg82YprNngvixAcPO+0XJLNSA+p54iYF5CkNi8pqBWq8bDy/1g12Y?=
 =?us-ascii?Q?M++P+nLQmPhPTGqHcWXxNlWszwSJvTFdSSGUJ7CWMv+mVayQncjPWqZMuSgM?=
 =?us-ascii?Q?SXNiohblbBo3hZ9/ZC62DWc7Cft4MC2ATVXmouLzFw+6Ucna9e0IQRs27sYf?=
 =?us-ascii?Q?r+xOR/7+NHObjNDidAaxFB6PEO3xSJP/lP8H3qQz45xKdnpf2h0W8f96k5vk?=
 =?us-ascii?Q?NyYw7auYyvxi/jo9w2aCTipU+0dH0TIycl0rQJchhMh/UNGIsnGgFhoMkfgL?=
 =?us-ascii?Q?TrW9cpcsrasNPmWlIAhpBFhjSZaRo2zFVKR1IVjjoeVchnK7wBKpIhKVE6lz?=
 =?us-ascii?Q?hsAl72uctWhNRiryX1jbSGmihAv6ahTjxTq4psyUwjrbfristFKNA4b71PUc?=
 =?us-ascii?Q?FKAlGTBWkOF9e09UV1p1fPYRriT4yOfdXozewla9cnEKCdXC2v85urVPMC26?=
 =?us-ascii?Q?Ayjeu2iBL5zvfWW94z+efuU7z/kVKYF/SoWiVHj3rRVRiYeVqLcettlx3mvy?=
 =?us-ascii?Q?y/o7u7U9vpJ4APxB0q3SXQrOr8DcduakacwcWXu8ZPF07XuUlyWnm5RPped8?=
 =?us-ascii?Q?RGP6GT5PxPnNlb3OmPRHATD/BBvda96Lyqmiuz9+ScDS8UyYLlSelO/Y0bA+?=
 =?us-ascii?Q?AW0hOtf9hIUqJYI7C8vrGCHeYFWurI4HpXA0p1AHsa5KL7Tz59zeC7olEGm8?=
 =?us-ascii?Q?RgKSYcmW9VnyDjYuwy+iygPKB2jhhD7jIj4IXKDEfTGUmqHtV2QkIlWV84lA?=
 =?us-ascii?Q?5mNy+woyqPnQblhgBRYxLtz7Go+T+shmGR9QvpsqNFfeein9wgO2+DgjWZdw?=
 =?us-ascii?Q?6iBgWlWZgR1Ql83BtJkbLhvO9+++Zk9A1fS521Hh6fbieWLnDYVCGePirCme?=
 =?us-ascii?Q?ukUSfNNa1+2v/5ODJa274LO2D5G9STdyKNCqfcMrieWsONeZuWbsbMatJc+0?=
 =?us-ascii?Q?P7FGjlwCh6QD9omdquMRaGrOBN/zEK3wywx3Vd4U5ZwQkEoAL9mENEiC7c10?=
 =?us-ascii?Q?Y3nKUIsHeXqbeti7WM8XRS+6fI6ciFIznL0HzhnoYk6+yeMnTNmVcwYxCBXB?=
 =?us-ascii?Q?JNpCkOrrUR6CKYbZHyiYML1Rs4pH4WLkEcjdhXiT6pTqY0rRXDLhR673MVx4?=
 =?us-ascii?Q?FRnYJ0cpHDzbKTJZ+xO6XR0uOSZDQ7qACwIAJUScB5AqzWzyUDhInDJiyZpy?=
 =?us-ascii?Q?gSkRmgCpFuUjUlWVS3LhkJHpenuzPyzfg0bY8zoEx4aIo0vx83h4grscgEW3?=
 =?us-ascii?Q?UjoTWSHEVebhDvaD4w3hQoh3xjG1ZfhEuOM9kjI+XeF+GO6v677Mnk7wpqNQ?=
 =?us-ascii?Q?D3Y+lfVdNMlOTkCdsDoC1mAKCmUv+OWO3r/0qZeK4zIHe+PJrsZJ1fAjZfrr?=
 =?us-ascii?Q?CVZsECsIlXgGsRsY4ST/5XyxabV0QHB3uNxxdXag+Ys4SopH+sHW4l8ndvSC?=
 =?us-ascii?Q?LGpMsXORMA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a824984-e165-49d9-181d-08dec19d8b7b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 18:25:52.8951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQBd2i8Heqls0hkthQaHP8KH0ZjC9nvXrOQx7EdsWDSOvXinu6U1WrCGfJDYswUL81ogv+Rv5l8tMAZXctzdVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR04MB12669

On Wed, Jun 03, 2026 at 01:37:14PM +0800, Xu Yang wrote:
> From: Felix Gu <ustc.gu@gmail.com>
>
> If probe fails after imx95_usb_phy_get_tca() succeeds, the typec
> switch leaks because the only cleanup path was in .remove, which
> never runs on probe failure.
>
> Use devm_add_action_or_reset() so the switch is cleaned up on both
> probe failure and driver removal.  The .remove callback and
> imx95_usb_phy_put_tca() are no longer needed.
>
> Fixes: b58f0f86fd61 ("phy: fsl-imx8mq-usb: add tca function driver for imx95")
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Xu Yang <xu.yang_2@nxp.com>
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

Xu yang, if you send out patch, need your s-o-b tag

Frank

>
> ---
> Changes in v3:
>  - add R-b tag
>  - cc statble
>  - drop "sw = data" conversion
> ---
>  drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> index b05d80e849a1..88b804b2c982 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> @@ -173,9 +173,9 @@ static struct typec_switch_dev *tca_blk_get_typec_switch(struct platform_device
>  	return sw;
>  }
>
> -static void tca_blk_put_typec_switch(struct typec_switch_dev *sw)
> +static void tca_blk_put_typec_switch(void *data)
>  {
> -	typec_switch_unregister(sw);
> +	typec_switch_unregister(data);
>  }
>
>  static void tca_blk_orientation_set(struct tca_blk *tca,
> @@ -248,6 +248,7 @@ static struct tca_blk *imx95_usb_phy_get_tca(struct platform_device *pdev,
>  	struct device *dev = &pdev->dev;
>  	struct resource *res;
>  	struct tca_blk *tca;
> +	int ret;
>
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>  	if (!res)
> @@ -266,17 +267,11 @@ static struct tca_blk *imx95_usb_phy_get_tca(struct platform_device *pdev,
>  	tca->orientation = TYPEC_ORIENTATION_NORMAL;
>  	tca->sw = tca_blk_get_typec_switch(pdev, imx_phy);
>
> -	return tca;
> -}
> -
> -static void imx95_usb_phy_put_tca(struct imx8mq_usb_phy *imx_phy)
> -{
> -	struct tca_blk *tca = imx_phy->tca;
> -
> -	if (!tca)
> -		return;
> +	ret = devm_add_action_or_reset(&pdev->dev, tca_blk_put_typec_switch, tca->sw);
> +	if (ret)
> +		return ERR_PTR(ret);
>
> -	tca_blk_put_typec_switch(tca->sw);
> +	return tca;
>  }
>
>  static u32 phy_tx_vref_tune_from_property(u32 percent)
> @@ -739,16 +734,8 @@ static int imx8mq_usb_phy_probe(struct platform_device *pdev)
>  	return PTR_ERR_OR_ZERO(phy_provider);
>  }
>
> -static void imx8mq_usb_phy_remove(struct platform_device *pdev)
> -{
> -	struct imx8mq_usb_phy *imx_phy = platform_get_drvdata(pdev);
> -
> -	imx95_usb_phy_put_tca(imx_phy);
> -}
> -
>  static struct platform_driver imx8mq_usb_phy_driver = {
>  	.probe	= imx8mq_usb_phy_probe,
> -	.remove = imx8mq_usb_phy_remove,
>  	.driver = {
>  		.name	= "imx8mq-usb-phy",
>  		.of_match_table	= imx8mq_usb_phy_of_match,
>
> --
> 2.34.1
>
