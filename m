Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013015.outbound.protection.outlook.com [40.107.162.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E560837207F;
	Mon, 29 Jun 2026 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742509; cv=fail; b=s9qtFwjgnwr1WNa1E/Km0EBmShHN7z4M485KzJGdZ7g9nBvScVwlXhHZ+1NJxR5i7z2//PJyuXBxoIKtNkumrQxllcTaqiWYNgGzoU6T6z6U8gBGOtY9q1YfZyxkjQu9Z1bM8LpJTu6VQTA6rICmjzoiAUIwNPnoNmS9slEAWBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742509; c=relaxed/simple;
	bh=W2Ygi4IwIqUboPeTl2bOt7w9PbnZf6x8a4Dvargf1Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S12zSzpQM61qhIj1I7qALCb3eUgVxX6M5rKtwx66+R0J6IHChkWKmk0TayjjLt7c3aKg6B3oBB5HNKIU9UdN9xGwH2DoOYZS4X2gcwoVL9f9IJIqXyO1hJ7bmWuFCU3G4nmL9SWWHH1HvAvUz+KeZHun9x3pmcCJiU+XzgBLurY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rebjZIY/; arc=fail smtp.client-ip=40.107.162.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rebjZIY/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZeNNqtph8V0foAUVZOZE3TA/IUtIR7jhR1hnxPQjZXsJk9As9z73S1a+bj+q1dujTZTtu+LP4PRmSKPc+W1bTVbxJ0XKrUBaInGpSj0SDCacu1A0Bq089X28C5vvjp2+Qo0GKMmDGj9o/m0GLtwJnbRgbVtqrg5f0ON+6j2KcwgqdimF/Mwp/ThvUuBHtyqK7VMLkZ1JzzePo3Jf2koNWd56QUoFMCreTydaVDFHEpMrCJfqFx2hSj1nHLtKegiL97c8JDw4cKHZfeJzpT4zyC5O8W93fkxSCvY3hQyG/x92K9UCH/FLkaz31sqU0vnMlzcLA9Rjik7zWkz6mSRYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqQwvJZ7qa7PjIiEfI3D98kQxmbMHLEHz+JGvfbd088=;
 b=sNMwRGxcoogVZUgLEnqst4vS0soZ5m3H53E1QHqkATKYi2CgoCyxtPNgM+SHe87BNFbX+W0Bwtw4tgHREQMZDt5C9C+bJHQwbjAUoPLwGAhfIlroH0IuvxFfOZvwmTDxI8YABfjNuRN8MnD/kEuaawzjLma/7WUbZC5G8lnjxKMw0IlW5+JdR8QeyHfvv94mkAD4UM/KvfYvjOqLbwljxyDQ5x89SIQVyvVx72bu4Hnms2frS8OD1SGJ+4Of+PJrKIDO6YCq+DQyMKkWEkQJ/BlJoO19stOL1K40IUFNvtX4yKnCJEr5IqKMRyuJ6P+woasrG+LikAsbuddEbD7UGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqQwvJZ7qa7PjIiEfI3D98kQxmbMHLEHz+JGvfbd088=;
 b=rebjZIY/q7UFPvrX68XHBvzDfjWYF20TZAvYgU33r8U4pd7ockKRKs0EihQp8kFFOHYCadKKVkgvieYaNLUDtDNbwlnQr6mXeEZ3Q3iGT0UhKu+APHKVIVFbz2+JuWZUXI7j8jLDabPnCSMPtGayoVajP7xfwmDPO25wQeoUOSgYLy2BEI4aJmLiGKpFB4TdN+IkxyyVBYs7/NZKZNoOMPjaIW2gD0eBOnuiLPgEnEqEzJKpsHs4VNLr+d1so2B4RhTGhvHWKao/E1Ebw0/WNs9LctGlhCdrm3y9Ar1+9HlUCwmJqYG5LnM/B0qBkCljgHBO33974QJfPBkcgGudfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM8PR04MB7217.eurprd04.prod.outlook.com (2603:10a6:20b:1db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:15:05 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Mon, 29 Jun 2026
 14:15:04 +0000
Date: Mon, 29 Jun 2026 09:14:53 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Liem <liem16213@gmail.com>
Cc: carlos.song@oss.nxp.com, andi.shyti@kernel.org, biwen.li@nxp.com,
	festevam@gmail.com, frank.li@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de, s.hauer@pengutronix.de,
	stable@vger.kernel.org, wsa@kernel.org,
	Carlos Song <carlos.song@nxp.com>
Subject: Re: [PATCH v4 2/2] i2c: imx: Cancel hrtimer before clearing slave
 pointer
Message-ID: <akJ93egAq-F-t1xx@SMW015318>
References: <AM0PR04MB6802B863CD9B9AE1609C1785E8EB2@AM0PR04MB6802.eurprd04.prod.outlook.com>
 <20260629023829.152651-1-liem16213@gmail.com>
 <20260629023829.152651-3-liem16213@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629023829.152651-3-liem16213@gmail.com>
X-ClientProxiedBy: PH1PEPF000132E4.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM8PR04MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 85564bb0-6c68-4c83-62ef-08ded5e8d0b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|23010399003|7416014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	IMTTcNjvm0k+U2E0Rru94awp8ITAo/Gvfym70vz05pyDv5+n4DJCPmW3LrksZ7TIzBYXx2sAQbDV/eVXJ4kE01terKYvSlezWTmtsNFKz+022HKm7mDaI9tfIT7t42Ku7oPre1DCRwxAvW1//qxjCVtm49LD1dir5CmbOvWdA1II3oOHuHT/s/juPxmbeN9LVXYZtDC2RPh/E17ggnTt24XlptMQjWrH5b7N8wIKxY1peVuqsqteyUOY06iJtbZnSFIYj35Xu6zS4pttIovTpLC5Kddvk4UQFytOPh7jvmtrTxz2Tg+Z+/P/bSiTi6VoSZjd77JWudtHoh5nT4Cp3P4LXUGlvsxbAgepN9+aQrr1eTIxkQVbHakdMo3kazIAo9rCdqcvaYV812TtjAA5a3sxXpV+tFyEq22lQ+CweaBRLQZTDNcXShk2WvWtmAW3caXe4X/MQlCiz9/xEiRUzVF2BZZ7wVdEBfc2+H1u7g9m/CPXx9cy1Wdsw4EMUfYIsVjKoNO+XABIp1sRyTZx4X7drlQedH2iSAQMfl8Wts1R2VPIiXY88CuGnpP8iUNV5TXZnXBPoCXVpvyhdYy6oH7sJJydoCESALuR9N62Us8X2NO1Azx3c5JHbMGKYaMyJ2mhpq2PGQfGj25f8CKbzuTNc83VHgj1TD0aeAKIaKw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(23010399003)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BCJZnQ5YNvus81dGslMUYLvwFqGeuGgNHnj4TINx/73X0vK3ElqGtMjBpeWT?=
 =?us-ascii?Q?Jz+B3o9brPGdXw91QQV5LCFLE7RMvqAqqMsyo+QLFnzLr4EhZsNULtNtQ+rM?=
 =?us-ascii?Q?OZFoR6rwLckF0JZ3f68opryglYvORMYRY+WXikjaQjc2vC67nRVaRMcI6qfN?=
 =?us-ascii?Q?xfFzS9jJeRc3p1dRs1Pe4NAul39Oq4PT2wEuUPjTgviDczKVtjZFnw8fAjDc?=
 =?us-ascii?Q?2s/Ub1QxAuroLgT9Ep+1wpk+eYJpRjrlrtChjLWovyQ0A4qZaLn1adtMTDIA?=
 =?us-ascii?Q?nbppEQ8TcInXdDcPFE0ABiElu2f2o4z/wbNBCVFDPWAD57ejHg4IAz5tKwpi?=
 =?us-ascii?Q?F0RFiUbVGIcI8pQADqnyTLXlZwIVlnh5twcRCWwPfrojLh1ddRmK4vMr5Vyq?=
 =?us-ascii?Q?zrp7852hPOeeaixBqVi3D2gRs7P56/do4tbfgxamxABBkrq/oQxSzqJzjIWS?=
 =?us-ascii?Q?0YaJEW/G1npkpH+yriIv3aCpx2dPKOskZx0CXI1qQX9oepF6JoI9fEu52i76?=
 =?us-ascii?Q?Bv6xhQfbcwBEasfIWKBok9aY+CuSq4SDA7RRGmayH+FZ5FElBzn9PX+5wWiq?=
 =?us-ascii?Q?OPTDeNyiT4iBN60j7sV2tER2dCThtkxhU3nOdBUmum9akKqgjaGJc27nyuRG?=
 =?us-ascii?Q?Yiu8itzMy2l3XwfwEXJs+qRrWVsdgBb+iuETVrajtRJJkTYDDCs5XWrvJ+mq?=
 =?us-ascii?Q?GsRKxuG8a4HO1oqQ13RZr/opsnM4UybY5srlGjbN5gwHMqvlp7CyD2FAO5R0?=
 =?us-ascii?Q?3Wq5WyaZuaM/cUDDKkHi2yxp0ekZZ7qthRsJNFadO+YdfkpNh1HuoA0IeiAF?=
 =?us-ascii?Q?jjotbgTrezEuc7SPSnCLe4ecXuXYZyMKz1/JcqZ9ltmu/jlaNizyx6s8F8uA?=
 =?us-ascii?Q?rriYS9IgpvT5MKY0CrIf1NsMiu/4WftrS5LdHTQkpQifjKn+SGxEi5UhWYTq?=
 =?us-ascii?Q?0V5CB1+ZL17DguEEdLG2JnULWjivnxq8Qi+ab82RQv7ZbdkASLvDLWvQDEyr?=
 =?us-ascii?Q?iEkL5UATYkL/miEtlUrb9hnur0VJbu7k2OVdYmpO5aXQgEDxVzEH5yfMfbnY?=
 =?us-ascii?Q?s6TwXUpfqdAV37l6o0zXDdIwV5ve5bn57pzXR58fzy3OW0kYeceugmEws/kF?=
 =?us-ascii?Q?96nuOqrpIYKFD8EUCLV79aDw1alXahy/JYgXjl4rGCkRo/ZW4TyJ0Ch8jxSf?=
 =?us-ascii?Q?2ngSOMMViJcaG1xouORVheTrLgYElXYpwmF85ZcxIu6XvU2Fp+Y8safUZ5jP?=
 =?us-ascii?Q?QRN7L5hiGJ4aIppxu5bsaKQ1vvr6b0KUxZXQn07pfeZ0if9Uj+uZ/cqaFuTp?=
 =?us-ascii?Q?lm7nmdQ0EagLmh0z63TtNnXsMxlJmjb+F/QQdU/FDXigDQ7wm3aQxIhMpiVO?=
 =?us-ascii?Q?4zMPMbhvGSffrOlC7TV6N7GZ5KhZYyM0dvW3lfAposIrFL1g9OPCwpcH+Fxz?=
 =?us-ascii?Q?nzUiIlYajKf0Vfoq3Y+QnI0bWmRIAOGBUKlBiJtkC86nsc7dhGmfK42/6ITq?=
 =?us-ascii?Q?MSrJQu/kQc7RTHlJyhtVoYzDelHy797LY+eZM2fTchM/7SIOrULkOrHSVx36?=
 =?us-ascii?Q?1OyhPso+JK6yzrg8bxPGGvQkx7TK6iLhdhCBfni6PCGS288W1cA7fEKcvY05?=
 =?us-ascii?Q?UTgb/lzDqZhi2j4F0IrsuNrHQf3VQ6RInPzvOHoJrmd3BRriRxF+6spr35RA?=
 =?us-ascii?Q?rOx8dxKLm8fuHtz5zWETVELmMvkGfSWk1quOJ0tfzDPrbNB7iwBghsdqZA/L?=
 =?us-ascii?Q?NTY4BMlSCRibrXJmrRbNMEq1FWN1kCPuq9W98JAry0wTxr7CH/p1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85564bb0-6c68-4c83-62ef-08ded5e8d0b4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:15:04.7097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOeAmMNQre6KxSwfnvxUtsqHX5ekYdWnXMm5Q6NwurVFWiAk3UE7OMsHaoIHJTbc5NPniNB6805Xv2KijwOr+VIuhOSg++bJEyVjGCeaUUjH0ilskIfSoYy1BcIO3o65
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7217

On Mon, Jun 29, 2026 at 10:38:29AM +0800, Liem wrote:
> In i2c_imx_unreg_slave(), the slave pointer is set to NULL after
> disabling interrupts.  However, a pending interrupt might already
> have started the hrtimer (i2c_imx_slave_timeout) before the pointer
> was cleared.  If the hrtimer fires after i2c_imx->slave is set to
> NULL, the timer callback i2c_imx_slave_finish_op() will call
> i2c_imx_slave_event() with a NULL slave pointer, which results in a
> use-after-free / NULL pointer dereference.
>
> Fix by canceling the hrtimer and waiting for it to complete after
> disabling interrupts, before clearing the slave pointer.
>
> Fixes: f7414cd6923f ("i2c: imx: support slave mode for imx I2C driver")
> Cc: stable@vger.kernel.org
> Acked-by: Carlos Song <carlos.song@nxp.com>
> Signed-off-by: Liem <liem16213@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> v3 -> v4: No changes, added Acked-by from Carlos Song.
> ---
>  drivers/i2c/busses/i2c-imx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 2398c406e913..b1c6581db774 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -960,6 +960,7 @@ static int i2c_imx_unreg_slave(struct i2c_client *client)
>
>  	i2c_imx_reset_regs(i2c_imx);
>
> +	hrtimer_cancel(&i2c_imx->slave_timer);
>  	i2c_imx->slave = NULL;
>
>  	/* Suspend */
> --
> 2.34.1
>
