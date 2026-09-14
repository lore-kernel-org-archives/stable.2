Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84233468C16;
	Mon, 14 Sep 2026 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394588; cv=fail; b=qB1u0zMsCD7deflT9YK6sMyX+m880SOMzenxytn5WJ1yCgPX+13qrVNvk20gMhA1gzgUwf6pN37o9F3tlNGo/nSPYpTvAQ3KPAxD/ATy5KbIg3b+N6pb+0x/WMo04Fortxz+CtKs98gS0kja1kQ2MHUUwMefi/P4DBrGSN8J1I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394588; c=relaxed/simple;
	bh=4HVNoLlCliNamp/smTL5NLwHeGb7aFVsdtRvbKJgM9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iCR/baumbud+qc4q7WEKbEFmA2sKp+ANuEb1ANfs0ca147s4TytXBofPuKvBY8ocJ8DYEtccm0d2izuiFSpWIbjg7mJtrLpGaeL0Y55oH3h2Y8pCddBSooNtub1kor2LQYbr96ciPjjMMUUDdTuFu4+KQYhnVxgP73+QTY2v54Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LgtLVCeO; arc=fail smtp.client-ip=40.107.130.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LgtLVCeO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gewbdNG4IrLndvhx6+sjrxepKvNa9y67x7dz4pUeihGQ5CQckdZ5enhub7etdgwIsqkApoutlpQAw8bW/tn7cY9JHt50xSxdVIfmwfMt4/qUZu0o6CXZNbJ5YIJqlkifqzKm+82HpolbPdn3vzOZXp5Did9O1p5FHDAoK3hFuPqRnV80hgbJEMBAeA2OxdSQYw42NrLHL5BDP7x2sXBe6B0goIt2OnPo/Wr3wETuD5752bFHygeph5Qz3i2zkCP0WPTsCT6ua7aDSzebpuagHX7KmUMnaK6eAP6UTAesUvfJ0egLMDoYaUQl2emNDHiMaR24vw1ZGx3+xZl71t8vyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0XqH5mnTIMc1ejcPkekCcmTdYVa/8fjkLrJjlt0b5g=;
 b=PYZxhCa1iDorNKIMhOhekbWZAzUT6icVB0fkCt8hhTWBRNiaPyffHQOgUNl1vocIK+AcC9IseV04etLaA9DN2jbKAUtMAhRQjgCO1a4PRFMwhNjdZgDRn1bTR++QZN6owD1TXrl6fuDLpZ18qdw6y9qznTISQQcTbBiH2Imy4uPy/RxFUcJH6Kije3l6+pzeN6C9zp3JPcFefod/oNq0TJRUxzaSkZpOiFAtIwuPFEQlaTk+cgXt73B+j/k89zFXFOjYggugAhXSvQikvG/TekjpzgKYvAqOG5d3H+PmdTRyt2oHkeNpEnTMRqwN9untvZWIu7KvuKBLK3OfVOhSZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0XqH5mnTIMc1ejcPkekCcmTdYVa/8fjkLrJjlt0b5g=;
 b=LgtLVCeOkHsWKhJCIBXzsW6lsJ81EJpYk8IatFe956xxJhKtcuJk6rG16kZyFHiUMYteOq/renDIQFFFHW5j8KPCcDOQ9IacakNok5FlyXqwvvq8fv003l9QPAn9XxhTjajjkQJ+Q5/jz3BSzIyvXFAFQfPrggz1JHgBf5bBVjUzA6uLvPSKeOVBdueqXpfmqKYEDxqh29fAg9fT0lF/vmIx888aQENH/9vdtE38MNdBlt0qabIfds0PnnIomQFym38ZNevvLlXlkII2v6sLnu8hcAm3CxocraXgokwA0TEfjITth12s3vJXJz8mjAOko8M6HBtMqaKNiq0aSVAxAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB10486.eurprd04.prod.outlook.com (2603:10a6:150:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 14:02:54 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:02:54 +0000
Date: Mon, 14 Sep 2026 09:02:43 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Gao Pan <b54642@freescale.com>, Fugang Duan <B38611@freescale.com>,
	Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] i2c: imx: disable autosuspend on remove
Message-ID: <aqf-g0DtUAkn947r@SMW015318>
References: <20260914091544.1667137-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914091544.1667137-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: CY5PR16CA0016.namprd16.prod.outlook.com
 (2603:10b6:930:10::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB10486:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e97a8c-2be2-4a8c-0ef4-08df1268df13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|23010399003|1800799024|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/la91tcT2Rxi62mlB+o9IgwJbqzkanYqqq+c8dvb/rzeZyNBd/3GnuwUjuW+FGUz6x5ohI9rsgC8ARHw0s5hBjGSVpe3fHgS0e4i905eIHw0ei/LRGJ2qJ2PWa8Y2DJgcUeeKF1GpEJt8uEVeAALNKBUs62z69R1ZyhZzJEuqCjWo/6XN/k3cqCCss1LResx0oAVDxt9BGyDUHjTfybiDIu0tGPhmdBSkY35/ZSXtxcBD+kv2aBwhlKX2YCVY8mN84SGjSiuUtvtpNsXY/DoTBa6miB153mMB/u9hfnZs8QLIllEBLPKAHExGKMS9MDipoXFci2hA61AqH1mhuO5E7sjxFQg3oiuRCAVIILerRFneIGFwC8tCHzYQrGn0HI9YeCR8hCNNORZWNaRNwDkPrSvpU7IhBSS526ec75/O2S8UZMYjxyBvwoFSMHfFMJSzfvpPFIsq971BA725fKSnS4BfutBk8bru9TsbK0c5iaF5kGHmf3gwblVHcn78wdjM4dg+hvtkHxqVyJQWTSPEPc7vAiSRL2SidheaczjCB0oOSizdShxlP+iLBx+mQssB/sjbx2rvZObxmMzbXWpXOnO92Nypo5oUE2WO0vXEjG9ogsajoArcL0mWnBQw80IbFzDEVeuKzZ1RpdPaxyhL+EbQiHz4TNbLVHBwOX0x9E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bsr7uFjykTcxV3F9lNr0k4SgDXQoFjmWnSx9OLo7Zu5/F3UnRTV8g+n3a4bP?=
 =?us-ascii?Q?qYaba28r8C3Srf8SACQMAgV017iF+gOT0jBCE/VyQLjfipMBo9XfsmJ3NnE6?=
 =?us-ascii?Q?Y3p7BDr/l7l5ytenL/mnMuMKXTc1njI4DrOMyR/JRbIKx93ljuT24XDNcBlG?=
 =?us-ascii?Q?4UuAGiJIaVmha0gSfR33OhB9FbSHHCGVt4MWaRRF8wKsBb0i5ed3GGWzNHTq?=
 =?us-ascii?Q?yT1UmxLQJpMzHrv43QgPe1Twgsfyk9qCsX+UdMkp5ZxL2ttITe430z38e6Bg?=
 =?us-ascii?Q?dU/b1vGmjv1pIUy/7vZ+KwkfZxVuT3PYZk/NSmptsJ6sZok0CzJyqojCEKDD?=
 =?us-ascii?Q?tH1MLAxbMsYv/TefJLVKD0IoRKDn5ZGeks+jnBG8ijzsysH8Cu9CBUz1bdXY?=
 =?us-ascii?Q?ZqmhazjgWClw42OetPPvqCPw6F5md9qJU/A+QlAuz8eCWFwqQkd39jULm7aO?=
 =?us-ascii?Q?j/yAD5xdqFEdo/EKED8zm+DeUGZWZIz5YUPtBKsdQcTt+AxjHls2R7f1EkQH?=
 =?us-ascii?Q?Hnzz6RFLX0M+Fw+BecinAZShZQVbBPRfR6Ibx5Q+lk4SpPL6y2qHMAekDAjs?=
 =?us-ascii?Q?TvxCVvaNIYzQZtn/pVYTHboyMIF5J1DV0wQrl8jvoo9RxT4tELqxKA7GhrpY?=
 =?us-ascii?Q?G0MrF2AP90w//j+BQXLtAY/HMsLMk0eEOU+eXRM5RdrujH3NfjVV0b4AWiIW?=
 =?us-ascii?Q?oei3A0yhku/tOU05MwMMTxfP1o+UdE6YgLcXMAFcZXLtdhOzQeNZoKkUFw41?=
 =?us-ascii?Q?aG3qTsDzZ9shiCicY8jN3TpMS3LuhR/IgolCQPFP5GhrcwDgbTK+091PegPC?=
 =?us-ascii?Q?ec6pj4yC0G3Y4w2IAKHD7fOrcxL/vYr3YYSk1CeA17Lel1lalJNy68w6eU6K?=
 =?us-ascii?Q?UGZfmiRmdPfhbkGoS39BGIyzHhO07IHOEkGAc6AvgAkOtkiOnweJYMcIaROC?=
 =?us-ascii?Q?nz0xXbAmMW/zCxhd4kMBj6Q8OOagcRnTHAyAxrf5ZSjHgbXEuN8kVcCmGwdN?=
 =?us-ascii?Q?ZkDNMje51GYNZRtTC/7TIDcqyl9nyF+NJqnQArWXiuIq69IZ2X+2W2ltNyjr?=
 =?us-ascii?Q?jBXC7bgBUNbQr5N6E1OF9ltOr4fM7tZewqUFyULl5C6hY1GzTH9lsq/6Rcyc?=
 =?us-ascii?Q?x/PIRi/MBQUL+9JvfC6P4ZQtqjrUAuNfCRHZeUZ7Nb6RhQkA1G2bYnkZQYce?=
 =?us-ascii?Q?1aL3I0nhoxT4bnLMMueTukNRFFnGzvs+ocXO4Fiwrzz8TilqiENbdzdwPOHO?=
 =?us-ascii?Q?7epH8aWZeL5xSfopPWIKIpK4Wla5qjCnDOV/xVZLxKijVWEORPHuN9Hg9ZYn?=
 =?us-ascii?Q?z7VmxoclmY4448zOT3W/pmNOr2QYVgvh+SciPn7s3Qzeut2aIIF+urBkl+2/?=
 =?us-ascii?Q?Q61cT4m2PoSz9xxOqewaJICx/xN5t9GWwOE6QpCrjzkiw6qd5LuU4z/WuKah?=
 =?us-ascii?Q?zA2GRcAhh4VT1SmqMyfymgKvQju9RLAfUxXNgYY8PvO5DIOkuEyXb32x3R+H?=
 =?us-ascii?Q?YXOUPPHk+Gblc4xW5yYuu6azOrHRGZ9GxMcosCHhd5TiOm+ndBrhedkxKBpr?=
 =?us-ascii?Q?K0T2MWufLnTdJsmRcgeFNV7BYBdKMKwelKtF2o38GSuw25umJ6ARA+le3ASo?=
 =?us-ascii?Q?mfkgaoCrS37PqBPwBqAuJCcaisXuCWIW6KLmIWAYECmhPC5p3/N6QsK/MPvk?=
 =?us-ascii?Q?R+3lxd/SObTWpM9bNZp6j7pQDDoQa2UiAlKNQ7NqbJDZX1WJ35wNkxMkeKIr?=
 =?us-ascii?Q?2vHHJOKO/T410Dy86jh1ZNNGu5YuNSUQwAS75oWiBRSa3koSW/3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e97a8c-2be2-4a8c-0ef4-08df1268df13
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 14:02:54.1171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZyQjgGJSaj/HTZHtgO4jzNmvT6kiJsbfS62Q98NIRtWOM9mP00CiZVJ95NXmMinysz2soooZo1K1/TKs1G8ecbmX5cY4Y2kOkLgaNxUU8JnTxzvGCGxMjUgRcqPl+Ly
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10486

On Mon, Sep 14, 2026 at 05:15:44PM +0800, Guangshuo Li wrote:
> i2c_imx_probe() enables runtime PM autosuspend with
> pm_runtime_use_autosuspend(). The probe error path correctly undoes
> this setting with pm_runtime_dont_use_autosuspend(), but the normal
> remove path only disables runtime PM.
>
> The runtime PM API requires pm_runtime_use_autosuspend() to be undone
> with pm_runtime_dont_use_autosuspend() at driver exit unless runtime PM
> was enabled with devm_pm_runtime_enable(). Leaving the autosuspend flag
> set therefore leaves the runtime PM state incompletely cleaned up after
> the driver is unbound.
>
> Add the missing pm_runtime_dont_use_autosuspend() call to the remove
> path.
>
> This issue was found by manual code inspection.
>
> Fixes: 588eb93ea49f ("i2c: imx: add runtime pm support to improve the performance")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/i2c/busses/i2c-imx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 19ec056b00af..4dc3df6a41a4 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1920,6 +1920,7 @@ static void i2c_imx_remove(struct platform_device *pdev)
>
>  	pm_runtime_put_noidle(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  }
>
>  static int i2c_imx_runtime_suspend(struct device *dev)
> --
> 2.43.0
>
>
