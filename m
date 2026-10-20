Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792512418;
	b=MIwLDN3fLAUkGj+Wg7WAjIUj7/gjs2iSSvXgDDyn/70+fLIZHm3yVTC32GMGrGO0IQ03
	 jmR3o09HA8P1SM9S70IgaIrQSpVY3sBhZDmFkBfrBy+8u1MNhOkoz4J59huKeJ2g8tEOT
	 Okzofknicow3MNPcKK1OLh3HxIxJ2gcfkeABHYdJ4v5Tr6QkTnKpsre2z6lw4Ra3E1xip
	 AVJoCs7lZU/YTrWfClb7GE3+C0G8AeRCJ8mjCely6VnHsAgU7d43gzmqFu1dKu4qwdMFi
	 n4bJ7TQ3i3MQH3TU84fuVvu/LNqnfwM8F3nO+2zZ7+PROotp1tBmZyGQDrGG+suz1GA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512418;
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
	bh=5BCnk88S0aGlsS8RoQkcoP/wYU7AczF+WG5JZl73g0w=;
	b=aaNMQkAJ/IfqD6IXkoy/yuGjDa6BWVWmpAY2DuVORqtqnKJY/yNkmQxwjc1hz8sZDGN+
	 xQuQs4KC9wXQ0O4UYiXgkf+nkBMPC00g99F4xXrRUSmSUfTUPG3YFGEpUAQ0bkjll0ncL
	 LIK9TnRtaW6NehtvlRb3zxzwqfpDRJV6fGdkwBIQp+KjIS5NG6ED3gm6C3e29vr1i8NTL
	 bc7DsIrlCqSxDyZfxdgHfOfPO706seKmZcKNHN/bhVgE8xGRRucKcsEVd9rnM6mBNOEDq
	 4dO6ssagcwp9XPrStGh4udhN2vbbBOHJR/aRU/3fnF9vMaIoIO++VItzYlMibFeRBmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Jfl6uNgO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.52
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AD8606A31A;
	Tue, 20 Oct 2026 16:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06AD8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Jfl6uNgO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tx2G4LO25ITP49Takbz28jJ6op+kKY6vlH8cJGiJ3OD9WTcg38Ng4QhsdzTZmg8pwnvXf24pX4wZ+IBwi7g+Wli6MBu1XdU9mgkk7TWI33SemYX9C819Szd6Y+Jiv5WVCJ4EEpUgvblNv3syo5IZbrYjZ0ohyt13Bx5APozpaw3KiXejHtq2EoRvQdeLpX/n3936/NtI2H5sObFpe0YbjC8MUlcnDaFB2ShL1a5a4e9lfVfSXZfMteQDJG+5t8DkVN91Ga4osH4x1MXaarL58qAhw+NAvPbd8BqfIBtpSTLLhc4BJHc+QrPG4pcmEhZM4+5rKzvqWdmGXOhU2uaxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BCnk88S0aGlsS8RoQkcoP/wYU7AczF+WG5JZl73g0w=;
 b=ONYONIxGc9azqkxC4Fp2KbJHeXxwy/P5A9sHcyKwjirlungzzZLxiPi+zKe0PKOk7SiRMVpvMqQo49+bSL0v8KrYhXa1dPheb98xN/8VKIkJyZcp0vHpbgZo+9Dif0tiFF7adfoHj/xu8eGsuShwcEh/WF8Vj0sYGfkMjja5fTRHVew+jRZ94rLpQ8/AN5emsShDUIR3r2as4Kp6+JNc3GamtG6rrbTIT0XF3ylCjOH7slk0ppKPhHHsYrDfQSLrbqiu7QXARxjG0YZpnNi7Xrc30E5xlty0ysRoXhmLZrKvqhewsXZB0p5X8CpswWK+IWoFITN4QugR5rZMDIYCdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BCnk88S0aGlsS8RoQkcoP/wYU7AczF+WG5JZl73g0w=;
 b=Jfl6uNgOpbxkXg+lXhfMdaa4zWIyf7+VxiBo8RZTMg/U6D+nGFgc46XQJyTgtQq18cLhOeOeYLBkY1bqOqeIqx2snM2ULb/HgUSDuchAPy2dxsNwmiphT8M6e5lutTwTaIzUMWXW8Fc/VZqltezay++AUe2zznt03PMkgFjmaK6gOkq5A5P5qZLixjfMtelekkDUBppAJgqIpO5HBIZGoNNUT1g4n2xgDcOuECLUT1Skbi326Vlqjl2/QmIoxUdtvbYeBL+DOVEzDYGkkPQi4aWCMNUsu+SlYfFjgbVTkCnWbjQjResFK9GhyyDc6ab4Vwd5Qcqm7eSHfIlRRM3kPg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by MI9PR04MB342248.eurprd04.prod.outlook.com (2603:10a6:290:d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 16:06:54 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 16:06:54 +0000
Date: Tue, 20 Oct 2026 11:06:46 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Jiale Yao <yaojiale02@163.com>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Huang Shijie <b32955@freescale.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/3] bus: imx-weim: reject devices without match data
Message-ID: <ateRlt9Na6qDfjmT@SMW015318>
References: <20261020093637.1654161-1-yaojiale02@163.com>
 <20261020093637.1654161-3-yaojiale02@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020093637.1654161-3-yaojiale02@163.com>
X-ClientProxiedBy: DS1PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:8:450::16) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|MI9PR04MB342248:EE_
X-MS-Office365-Filtering-Correlation-Id: 10886205-3f38-46a1-ffaf-08df2ec428ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|19092799006|1800799024|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	D8iDL0YUdgw2O+fMLkXYRxZyWLd8I5nNSwhLE1sOSoYZNkfxrI02WQB2szOjfy0aVx9QxGnL4TZq7Qn0ibVU5AC5fQkiAps/Rrd8T+GoIS1jBx8hJ2RzXmnpYbbpf6bzFFnBT6hbkIc7+DtPvkL44Zk82MwyZW0OWG3RHGHJbV5CEX6K1rKdEbZQLWGjBOeuKGIqpnU3fh0NVI6r+EGdsgBsmaOcEqsrHiAU2lXVcIQZyep0V0Y3Ub07pJOUYI94eHzaji4fCar7wwzO6jyrgP7XTlurlziyNJdfJKEr8PidzGg32B+lZxJ7QcQazYPVz/lhASudZeiQI5ZTixcUq5vhIU1qcgtBpN2A/fsxr4Wb7NnYYTDyyoleLdkJB1vEOZ7qh1/4PAIPXw/KfwJXfCNPOJY9gATp0HEsSBt6+0iF47tf6mAstzdRlQeMmIl/9DJ8vYrBNErn2j3rdiAIfyNughuN9v7O+jYwwuRRw4ENB5Klu6taVM4le+jTlyqyqsRsHdkc36kEYnScCCNqNGOO9kAJuW2+lQJgGqO4rsLrj9KHMHdiHKkapriObCoQ0hqBurU9skXKWAZVZz9ZDyAIUQtA6PXIQOVLiJc6j/7yxIws4X6CitopzznhcnbZtUlqbTNnsooCvwZku63yM1xfEuZ8MStEkj8GDxXWim0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(19092799006)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wkz9tndMCFh4ibjcPCQ8bowXgUy8owclRCXBdTip0aUhlzYo45D6CQIHJQBX?=
 =?us-ascii?Q?oAKn65NBUMOS8DUFdVjlgMu6ttbpV3ltrCGzdq1xVYdLZOCafaszlIVmuzbi?=
 =?us-ascii?Q?VqORCVHgWj/aC24P8DAE6Dw3LWPoPhSNJZ+ZTyVa4XmXNa4cHFlW6r3mToa7?=
 =?us-ascii?Q?RG4QPMBzsfPCM9ZMto/2RLfcIG7rW9vxhw8I948Z7Dh7azwThjemsmusFUrR?=
 =?us-ascii?Q?9zT2mxvX6jdzjgpQohxWv/jUZa+4UArbFiROXQ3nGlIHzMptKTavpHxesE4m?=
 =?us-ascii?Q?jWyvhbmV8/h+044T5r47+jMRitS0Wa7x8qJhAIbDWB8ciNQglG8z5thkU1WS?=
 =?us-ascii?Q?XkSF/vRE6XfLPoLPUZaJh5YCjaIPDQkTdvOkaecOWZjlpi7o8F3vkY/Qj816?=
 =?us-ascii?Q?K499q3JUCvsJrkrFJ4EO35vxZ3KCKpqHu7f4nN7ORBlqeedhFPJXi5hWfqWf?=
 =?us-ascii?Q?Ua/puwnz/mXAvlHbclE9vFyoi84ApxMfR5NYaP/JmBZs3bNWfJP2qJmt1TcL?=
 =?us-ascii?Q?bE+hviTCUvHv206uoKj3++eoy7QeoVlC4xn8B6ZFsSutJQj2nrWrypa/tiiu?=
 =?us-ascii?Q?leNsfpwwD3ksll9lQqjfdRV6Hrcddj1Q3j4uVmhHtZ7S+oIEJCjhx/esw4iW?=
 =?us-ascii?Q?JOOF2bRzzXv/hImihObv8xbxW4n/iwY7HHukDNlL1qbqCS8bsa9G8fyUUK2Z?=
 =?us-ascii?Q?qVy2wk1WDX7kMCgp1K8GNPcdtJ9w2/DCOsqWlLXhKIM26lR/dS17sWgSIJwP?=
 =?us-ascii?Q?2653M7RlaAUI2by1sc/6tnFhad/NyAGdd78XWtBzofwOzmD/Gim0rOEZYD//?=
 =?us-ascii?Q?YJu5dC6yatTiuouBgJZghG3gjpbGYt/JrimIn4AAUoSqisUhf/JgwKX7It7m?=
 =?us-ascii?Q?cLfsdxmryU1/7ZkERP76ZwcwBydwGCxBLABS6UvdqufRT22OmRGZFTtiXbTN?=
 =?us-ascii?Q?7z5SqpcZku6yL2LVKz/xBd0KzJIb0R86Yxv3wTJaYb4XDsf6IRYEuINhcX++?=
 =?us-ascii?Q?ocEGJ+KL2lKoy+nygol9o+Lpq0vVx/QUk2ChqQ0JsJL3FQL6la01K8D+n/jA?=
 =?us-ascii?Q?2DdiR7lNevQ+A1GhokuNMvCBt4aMK6aUv4jbb++IeiGUj4uwflLnykxtYpwp?=
 =?us-ascii?Q?CxZg/M7vpyMtp0XMUMIofBJcchuEfTV1x/1EeKx0vjrYqJVaRV7CXDwFBu+v?=
 =?us-ascii?Q?YT+e5ZItF3oUHYMzS6L4e4h11Lol3PHbWrBtIW7La5fQ5PUBenLnhm436TDs?=
 =?us-ascii?Q?7XH5+UwfJW/X5SPEUgQylFZuH5uVE6kYvaZxvpIqP4enNEKXRaqbKq17IWY1?=
 =?us-ascii?Q?a2WNeyLog6JI7LBgAgvo6jYX9bITeAfFSy1vbmYPG11IG2flUe0jFyRX8+Kx?=
 =?us-ascii?Q?wXJjcLRiZJniBNlSdD8bPPDfrknufUaJWzSQx2eEjL2RVD4AR3RE2f4aLnt0?=
 =?us-ascii?Q?IG1F3nqHE5PVc5qX0fqXCsS0pVjYpzMOCtOo4ovM0uVIEdtn8uGpTLIllgfj?=
 =?us-ascii?Q?8h900Xge7fJ41HzEmZvedRWHarE1OqymMtYt+9DW0jTE85mu8JI0NMrobrdb?=
 =?us-ascii?Q?6jVZ1VdtnNUVarP5IW3mk/7dYUdARZfq4idq4eakNiewY9sCtY4PR98QU6zU?=
 =?us-ascii?Q?0po/0K5cC/oyDTIztutshI+mxWyV4s5hiVu08e6gcToZwDBjxTdoyfsTTJpu?=
 =?us-ascii?Q?q/bqYVfUI8m6pOkWeLHQU1rE1Eo7mj4vxmsPSpiXXBKEQ90HGd6UmGJIJlDJ?=
 =?us-ascii?Q?4nwjKTz0KgtumK64DU4QCRN+/Hcsx632oWZA3YkdAr92zEYQV31U?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10886205-3f38-46a1-ffaf-08df2ec428ff
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 16:06:54.8044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uqza651ixKx56Iw7rqhWFeRLPSkDcYUe948Ipqr3k2eXFnThlnl1tnSUyLXChGydqAd2CLom4GGKYo/AQ/ckXcDILr6YSxtXsizChZyoYFqXE+hHP694N8S0FVGNa3Jw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB342248

On Tue, Oct 20, 2026 at 05:36:34PM +0800, Jiale Yao wrote:
> Platform driver_override can bind a device to this driver without a
> matching OF entry. In that case, device_get_match_data() returns NULL
> and weim_parse_dt() dereferences it while configuring the controller.
>
> Reject devices without match data before parsing the device tree.

This should never happen, if run to here, driver data is always existed.

Frank
>
> Fixes: 85bf6d4e4b10 ("drivers: bus: add a new driver for WEIM")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/bus/imx-weim.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index 87070155b057..3ecad0e453cc 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -205,13 +205,17 @@ static int weim_timing_setup(struct device *dev, struct device_node *np,
>
>  static int weim_parse_dt(struct platform_device *pdev)
>  {
> -	const struct imx_weim_devtype *devtype = device_get_match_data(&pdev->dev);
> +	const struct imx_weim_devtype *devtype;
>  	int ret = 0, have_child = 0;
>  	struct device_node *child;
>  	struct weim_priv *priv;
>  	void __iomem *base;
>  	u32 reg;
>
> +	devtype = device_get_match_data(&pdev->dev);
> +	if (!devtype)
> +		return -ENODATA;
> +
>  	if (devtype == &imx50_weim_devtype) {
>  		ret = imx_weim_gpr_setup(pdev);
>  		if (ret)
> --
> 2.34.1
>
>
