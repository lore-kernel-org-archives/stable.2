Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011003.outbound.protection.outlook.com [52.101.70.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B7039B4A6;
	Wed, 16 Sep 2026 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574522; cv=fail; b=O56MP/Tg1nobZV11q9lztiNLnNn32KB/ybQTxZXBfThhvsm7nemPNk1OMnfZFtPkIZgq/CUdHcV+p+JJF57DQGoEaiX4X+lLMuB0BAilLg1n1uWRpC5g62ydvhXbzGQ37ImcpJqgvHKHAS4BYwaLwh/AUHmbWYHPJhB+fc/oFq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574522; c=relaxed/simple;
	bh=UDlIPAmyQrVjvQ7qYKQzOOuHbKKcOeuyA4/mfr2I1S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lzV9GAlGUj9SS0PI0fPQPFGsKM6ozPz3cptwZ5iV+++7tmUk7PYpT8nhh5bq5V9kOp3xkfP8XHKl4T/Ug9DytVx3hEbOTeTJRxZ6DFrq/0G83MbW7VR8sjTrM06GbDam+UiMYB/fS/QTJoDXosx4Vv4mgdDBHfMQtpTNzie8xjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HfUAhnO9; arc=fail smtp.client-ip=52.101.70.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HfUAhnO9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpQI2z2/kEH1cHGpmrHJLr0jEWhe1eyOHgOSnBkYs78ga/ev9y40V2xxKO3QmrpI3jP/U+ERUy22koSrmFP5aS2VhZ6WFTkbAZ3vElJEGd91taDmpP91+m6ixUjnTNXELkRSv2YckURmRC365QWgGgwnLKavHCZr4w6o36nAOKACmFl9lYsv62PZzVxjQFG8Pg7Lr/AgqUD9YEYNsjffPdixauznZR5nwZRR8mp5vWXtciUn16CrXvlC94zNqp8fJcTDTCbDb8mznx5WbilFtkBECQ0B6iIz6nrIM31Z4AlSfUEwROe/qYtPgqwXExEchwBEkbgsq3sRQe3PSjS/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IE2rpf4dZm6zaqxlToE8E+lMxovhZepk0Gln8+V9Fg=;
 b=XJ8BMyIshrMAjCrUDF2ugh5tYWuqTAsodanDImcYjQ9UAZhm6lCaPpYuMTdbWTycFsCnzIKk2tF8EjfViur+bFsPwSuZpqd4+Ixd9G8it0aWmPG3LnegLmOxYFlfy7Y2iIVwBLVeE8w6Wy+PXZgveuGunfM14cH7RR0FC0dznR+mtyYK+QasXFjZ35lX0eoMHRPiKVxuWnwAMUt+JS0pn8OdMZEZJRx+8T+suhAnYja3GwsBaE9jaAnKWPVlNS4D+tAU8aySM74Ntf0G+oBnXThW0iSQ5b/erHH7yh/XZZrhh2Lf9iEn9X5X/1iTz+485j8nYy0q1uAJlMa0oqWClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IE2rpf4dZm6zaqxlToE8E+lMxovhZepk0Gln8+V9Fg=;
 b=HfUAhnO9fYW6jHdPweVTQ29Yhm7x0LNV0gVlYglMsg7wtDqgHfU9XFO0c0Yv0MLbsONPRapUL3N3rJeE6akF/lox9tK9DHTFOZXrT/0iNq+g/l/8S6Wg+ExPKWJ6U/QPFFN8H/mOEPuvrjf5lWqL0oupb32IiGXJhAlWueCRJD3gQhPSm4XZWQWOi8w8EaTvFeLaYntSofZVJjANIsXGqDWU3HdF/iUbo8K85P5+N6Je5YgQiAMGacw6RTy0osnIeiOn29MSL1ta+pDIoffBISiEaBqXHlr3x5DgfXmNP5GQPLqjb8hXVdmqhieTdZuw9yvbVqDkYtTnym+Bm/S5MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MIWPR04MB166472.eurprd04.prod.outlook.com (2603:10a6:290:d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 16:01:58 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 16:01:58 +0000
Date: Wed, 16 Sep 2026 11:01:48 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Frank.Li@nxp.com, dmaengine@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, vkoul@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsl-edma: Fix channel leak in fsl_edma_xlate()
Message-ID: <aqq9bJIFvzb74ku7@SMW015318>
References: <20260916092733.2002700-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916092733.2002700-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: PH7P220CA0102.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MIWPR04MB166472:EE_
X-MS-Office365-Filtering-Correlation-Id: dca7dd11-acae-4d4f-7ddf-08df140bd5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|366016|23010399003|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	lMIdsa/EId4IZTMqx/JxYP5u2EGh35qdT1uXBM64K5IyRBRazNYx6eNgEDq23CoR5Ttg0THpHouqYz9/nzsDq5jCVea+/969ctwMfapc9LMvcETiaBmt0t5j6o1MdZ6nlgAGHD66BSRbcehyCBz1Hd8v8L48eQBEgU6oWSSY74ppxAVj0H6A7KRAuWno1pb5zUzqrVUTTOnZPFoTryP61ogihKzPg5G3FqLa2ZdZe0mUCgpWe55ZlVl/F4wDXXT9GuTvJ78nnMnr2PHeAOS8JX/rrPGX5akDxM56fzCKdiXjnjnDS1UNKfnFwkvi2FFm8rKTPPr7UhoESi4PwOKvV6+d/J2t8hDenAxiQPy6kEREGogpHlgn6aQKE0BRJOOerVTmUkxiGXeCpvFEEIUuHDtUopCvLHu64qb8Cxg0rHRQWdJPVCEuGa8ldcbSn5tI19iGIrxaw29z8lMZkdqxfF0jPdScVqU9ZsAfO4eZ3UIJW+MsqbYumd3m66s4Asl2PuELseCCJhOSA+MCIBqv4Mak9O9F4g7QyC9+60nD2yonuUu4XpA2jCniU94kq8XbNFArJMh/i6rrmSo9whuvLTa78fVI39MtUpvzn85J/96uaUBLj+pVai69hyV1n0sROnfwboIr32kobvxDkMfwUJd3SIU2dXPy+fzlMZaPdnE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vass/Vz7maissEB7pm9GEsVNXIxDHUo1fjhzKe73Lf4r7VaoIadVaK0vWP6s?=
 =?us-ascii?Q?+GMaKDz2Qw2t8AeuZFIBQGywjbarLO7DGhfNDz2elSUwKBPQe2jtTqzDKGEn?=
 =?us-ascii?Q?H6zav/p9KyTIWB9MpgvgGZHmuEZTAT3ivUD1xkwYXQyi4TS4qDhotXg9391J?=
 =?us-ascii?Q?YGyj9/he3lg0tjX2r8c1rDUwMYxtLyn+jC/olqIJTUurIOamsNNFD3XSal5A?=
 =?us-ascii?Q?mFrG2kl8zlyK09KyAEH7BlUMJeshPrhjd+HqTRtR/2A7CLG51ApyhLDM7LpP?=
 =?us-ascii?Q?N5B615XqtnuccJ23jd5WdLxUodHz3c0KwM3rQ2+zSNhqutieOe3bzEd1rySC?=
 =?us-ascii?Q?6FHSXyF+1iybxo7Z0aUtn+/qhYyAbru3z+u2lv55EuMd/ztNmWcp8pvaDMpq?=
 =?us-ascii?Q?MK6TGs6uPQO3G2YYs6+7F6cjTA803wwmC7r4oj12nK4GXll0nDufMgHlvELq?=
 =?us-ascii?Q?JfxK+zYxOHCX7LkqPXB8md2RmjCqaZ6B+p2wqYufZzA5PRR1rMWXArz3pm8w?=
 =?us-ascii?Q?FEL9Nhki7UyHHiwihizaUALDfy0IhBuVTL5/YFBAaifiEljKkv0oKwrQtx/I?=
 =?us-ascii?Q?sV/Oa4+tx6Qr/CeuuGzegnzAGDUSB7t+4yf9ufEADKjeFaVEgYSzk4+1CBvr?=
 =?us-ascii?Q?2eN42Dy7E6v8iVvUBgKoa/Ry/VrbwJYa/m1LArl9W1ROxtXu+e5hXYa73cRf?=
 =?us-ascii?Q?J/ulJqj31XUA/rl92vacGP/38Qnv+ZDdM/57Quc8sm+R5oZGFwp6dGrvqjRy?=
 =?us-ascii?Q?KF0DqBfZDt3mYtWordGKiDrVtIfvRQCS3RdYRNiFFc+4monESi9DRf5Go1lM?=
 =?us-ascii?Q?oyTZI2KEqsM7nHgw0LTtOMmtCRp/oebVqy3XOR/Cm7w9rQVB8K9nxn3Zgy5e?=
 =?us-ascii?Q?LjZ4pv3NCghjLzU1zls7SKhs2z9bQi7sdXr66fYIorxHv2AySfTl5gKgaWsr?=
 =?us-ascii?Q?wlJebKz4dD3HJbqF+lSF52Wpd1PyBSvaGKrVCHjxMJn0AOBLYdxo/XGpwhBa?=
 =?us-ascii?Q?jI3V0B7qvedhlfJjOtIV9kU2mg8PEH4sTnav/2k4VRfKFdIOYUEm4mVt6bqR?=
 =?us-ascii?Q?dzZQHKn7VGL0P5I8nAZNuTKo9/UOkhLNZwwf1AgNEvhdWaak7ibvL92EE/et?=
 =?us-ascii?Q?QsuPoRXmz2H5zOsIrHW/GMIUdx0nNOd5PUHCpHwWz2sRH9VbBqQw5MM5k5MU?=
 =?us-ascii?Q?xxSqUrBDPmOBUOOClz6lnzGh7wri8qXkLENzB9cWw5FgLt+a3FhvCc5jR0Di?=
 =?us-ascii?Q?TH1ftuWP24cbORYHHCpxfSPwckvTPQArOC+g1MYlgaqmGV9P9FeHOe+O1P6q?=
 =?us-ascii?Q?5QRhvD1iYq6X/KN5obn5kf/ZGfm6g1ydkrcYeth8oct6zGEVXzHd2GmxZY/z?=
 =?us-ascii?Q?Wii/BBqDB3QXVli//yMsd/9uZ8DWnxQ94e3LTZvbQv7P2QhjHFfXS7Cv/HWp?=
 =?us-ascii?Q?hj5ctC+UJ9jrbZByDjCS2sEIEPDstJ12EdIIL+/UVSmWywQac9CmD4Vf1eQb?=
 =?us-ascii?Q?wBamFL0a+zZGgoEa0jSVbeW0g2X7dl0kvl8VYLo+7H2APS/6YDagztgLP3nh?=
 =?us-ascii?Q?tK9u7KjxwGPt2TVFHF+yBt7K7OPhjeXOM0hEJpEJCwzFeb5Q6Fczb044rmGF?=
 =?us-ascii?Q?qmGBQIdYkzV00rnxblxIqXdobLR3z3axKlD8y+/exQmeg4a7+1N7WCo3j14W?=
 =?us-ascii?Q?eWPd9BiLzRout2eC1fJjLMVm26Y1VfXgfn27xY4wLp5HtcW276NHTLu6+tmV?=
 =?us-ascii?Q?XLxhGNL4yij7I2Yv/LPewbydtZcsI23yGrdT96YAISCBymfNz3M4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca7dd11-acae-4d4f-7ddf-08df140bd5ee
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 16:01:57.9746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25P//0OWzL+/E0PB5Tu8Etih8qjrXWqyhU0xKyPO/JLOyXjmYhmzMz8YogOVj5HCSpAmqQxfgR8qV3lAUJAGSqgB8MrLTd+ulrVJEhKtDZw5aCn0SIlHmnG7tXOPZGB6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR04MB166472

On Wed, Sep 16, 2026 at 09:27:33AM +0000, Wentao Liang wrote:
> fsl_edma_xlate() grabs a channel with dma_get_slave_channel() before
> validating the requested srcid. If the srcid turns out to be invalid,
> the function just returns NULL, leaving the channel with its client
> count elevated and marked private, so it can never be requested again.
>
> Release the channel with dma_release_channel() before returning NULL.
>
> Fixes: 6aa60f79e679 ("dmaengine: fsl-edma: add safety check for 'srcid'")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/dma/fsl-edma-main.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 36155ab1602a..11fbf6b1609b 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -279,6 +279,7 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
>  				if (!fsl_chan->srcid) {
>  					dev_err(&fsl_chan->pdev->dev, "Invalidate srcid %d\n",
>  						fsl_chan->srcid);
> +					dma_release_channel(chan);

fsl_chan->srcid = dma_spec->args[1];

check dma_spec->args[1] before dma_get_slave_channel(chan)

combine into

if (!dma_spec->args[1] || fsl_edma_srcid_in_use(fsl_edma, dma_spec->args[1]))
	return NULL;

Frank

>  					return NULL;
>  				}
>
> --
> 2.34.1
>
>
