Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012053.outbound.protection.outlook.com [52.101.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF7943D4F7;
	Mon, 14 Sep 2026 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398771; cv=fail; b=f3K2E/aZXrZNqcjq20n/XiB9ao3Ld2/jNPW488F6pah7uTLGKYdh5yv74DtIUT9wi1MEO0mItMQsm3VGg0W14pAg/f6Ebi1eXxrVQ2IiTbW+bGxnHC5drzK2I2748DnoGSNHKhJUzjHsWwHGe8Xnqz2Tcb7nUTCIh6O1odbNGzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398771; c=relaxed/simple;
	bh=93Kwl3+iOwTDkKREEzmjoHWdu6adrv58Z19JyagcEkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=boxf//0iUW6UqtkotqQ0wI2B2tjg02A9mRxP9VhfPucMNuPohPGvJ4UTh/87hUlmYQpBvh/qp+Cl7FAk58K6gmkdQK2aC79dhBV+MSaM5McVqI/1EkiyEtiLxNqutpFsoojp52oQn160SyQhJhHBNS7g9oQE6rBC1G7GhsxgvhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=b/g7WfV8; arc=fail smtp.client-ip=52.101.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="b/g7WfV8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kj4XCU1tZHbbf1GYgL7Q5LYyB8qaJhsG6aajWJ2vet29nd7UZgOf30c8SZYry1t7EwoCa8FvbEyK02uty6QNQiL1qJTQNpd/duADcWOMpn/ymPp094UGTYXCsVWO1XuntzObJXf020/DY7/d/FG19is2BEtZBp7+UTz87RmIgKxNH/iXOwETf5Dos2MZaP65OMYVzARfBTiYXIen5m3ISjdNL2D5vyqH3hz4kWLx2B7XMPRPScE/ZExYgXDvqJg7qhP1k32z0pYbCxpO1nEjzw0RFwARTgwbqUYiAE8w+3dSkjiocpVvd+uKQ1cICBYFAIz+0+LmYZaPtb7s7KVZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAfF85wqHVSwdawC+QtRXfkNA0B5eDKCG8CczImeeUw=;
 b=DZ/qoc1d2vE+MrwfBePBRSu7o+HrlUsIstoS2+q3/1byHr0h/asjnvh7Pv1ZMyUtLK3CmFtFgVu2gTb+0DvxnWVkn63qaY+zhjSEGGLZCEKGXUHjBMrnd18obh2jg+sRoeOo6Tz/NlS2okP+s5rcUUja5tHKE7KiPLm2yKWO0ksZwWQ045k+ETXcL9lsUK9WAeB0g19GcnUWhy7BZyvwvj/XTuGnpBfY7zfbMLz8tHUZH74Cbrq/uimkQvRl2ggWXtqMuCl/7SB6KgUvAeJNAb33xUy+MTp3SJ+c2Gg6TaTs4Vwq1Tou8t1vWne5ofb5RLReihkEv7ptEe/Jotw0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAfF85wqHVSwdawC+QtRXfkNA0B5eDKCG8CczImeeUw=;
 b=b/g7WfV8qQDbq4FNZBU1Q41IB5DmVpV458pCZkq/lm0cSuuWYWIT5ozONa7/Z2CWRsAsL6JZpGSfIhf8fzMNpNQSP1A8TS255ypxqwSTutfqcgackd12QIsnGYelrQ2Kkg3suqakFdE/yWeY7urfdo9hTv0yGQdwf8C2CMJQA0bs0UhYWafjKl7SCmkHuhy7Jo34DnuBSJBEWV5PeYiqQna/Yoewm2xIoYFs4j2G9KE2nSEHd3sD3DvnMCiWhvLv3MZ664/GMF6g6hzt6Vs5USFQPqrgBJI0CoPuXUvd58MFUQ6EA9bEuHPlsw+tqGwt+F1uYQncZorIEhnGF5aa5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVXPR04MB11691.eurprd04.prod.outlook.com (2603:10a6:150:2e5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 15:12:45 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 15:12:45 +0000
Date: Mon, 14 Sep 2026 10:12:36 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>, Peng Ma <peng.ma@nxp.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsl-dpaa2-qdma: fix ppriv memory leaks
Message-ID: <aqgO5PfShs5FG--f@SMW015318>
References: <20260913045001.1126563-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913045001.1126563-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: CY8P220CA0041.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:47::28) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVXPR04MB11691:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a99f59-9eeb-4c1f-0c12-08df1272a14e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|19092799006|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Lp6FSlVW+Vx7N5OlfZREK4tDsl8NZASAkOfNzqkmk6UjdbvDm3XSO5zYj/vRCVWljhViCDh5QITIPbEoKUViPbObOC7NMBCx63QdQd76XFtCU/6egdMX8NeU9SJkEtjdcv9od0EgNFyV9jMMzuIWzPe6R/788yzIven74TwaSmxF2w2adPaN/RqxFpoVADelI4LFkhlZWxX6SuG7ghD6wvlY4XFaU/SnzRmeLi1C3T44hj230Yr3D52zvwg2mxh96bhGZlBNnlNJNYbBRYjD0fqJDPPbB2GBLGcHU7+dxz2cROXA3FvMl109/UNX6jWSqBVmjuh+rWBWaLqN9Xm83dVnHLgzbivxoBGDbFiyQSfV2CecbkBys18UzJRrXemTx/6+DlUwyvvyotOWZZrOF/UzwW1btb4oe+UMSI6Ve3sedIuxv2xFw42yruUbNYNoclUU8cALeKRHHwSAB5CCX7AtJMgyzA1HYr3ijsD0rvkPL4pSVDzrg/NCzrkOHTTHNGtxOo3OMQP4oKYzudoV9g2vS0/5FY4a97tc/LSdVdlS2LFF9Y/ylqhM+fuaWbxynqXqBnndBqKfUxUthFf6Bgo6UMr7U1Efn7SKx8JgodZ65zc5uR/+M5Pjq2HX8MN6vX2h/GCz77/f5lculF9bOt8IjpC/Q7Z9TL+yRfmU6yg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(19092799006)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dC1LUc82citwxbA2anF/vuTGBR/K19voKCjrtthGbtMZFcgtC//lbfuIGIiH?=
 =?us-ascii?Q?2FbVHzUV3mNlD+JiOh+Yd3h5xdm0Hv37p+EDG1Yy09+B1jinengWpzqOoTL+?=
 =?us-ascii?Q?r7Wt9/zTrVPcXnOKzY2kwUURQGJm/6ex8/j8KghUH7hd4aYHkcDFMFrkGiAs?=
 =?us-ascii?Q?OWQiXwYE7oJ+PKDWn39JDy4atXtoZfjt+rNmJeR7vQdMltfy/i/TaIdJOwtB?=
 =?us-ascii?Q?gT2bXJecUtORH0LuWZxYK3Vnah+yJwnTDlowtJOKHs4ebKg6V0xXCO9syFLu?=
 =?us-ascii?Q?XyAYjK4OhHrODaLyPdhCmk6E2iPCMP9zlvgRG9kmGefUc9YiZ0cfJ3l5AoBe?=
 =?us-ascii?Q?8QdYOr7bjwS9iRZGaRS6hQPepvPaYfcA/jrFWi7ZT/XH4WE3Wd+c2MA9T7zj?=
 =?us-ascii?Q?/xVBlk8cwWk3GbEP0eXZjupednfkC2g7cC/S/wV/d8unv9k+vO5L9U3dFro+?=
 =?us-ascii?Q?z+w/S34py36Ar+pdLqfzXVysh5efPKnASrjMkyry47DAiRuCXhQurPt0sCIn?=
 =?us-ascii?Q?ZuWKmQgG6lN5UveOoxvPZ2mtlH3i+AXpPiMEfDYXEkBtdGQzdFgx+VZEbGiE?=
 =?us-ascii?Q?8kivJQ04+5gPmXDDK7CLYLICsrSYc8eeED4NxT+h6PY2w0btmbn03P6ufHLs?=
 =?us-ascii?Q?aTtZ8uWe2wwUQZwXQukyRu5ExYQ5E9PPJJ++wEKAyt1c1JcTxeUBiKWWJNzl?=
 =?us-ascii?Q?NH3kq4AUYiKSSRt75AygDDljL7qoS0Ke/8LB6fnbAz+K2y1OIUnUEZpPvoA3?=
 =?us-ascii?Q?uNGs2EkxB3+XnJul9MFGUHrQGAMQGHOV1I/0pCS4Tt1C4hjq8c2sz0XFl11b?=
 =?us-ascii?Q?p225KuFKTAD/AjRACSF7KDgU9RkaZrOrraSb/EJA2D0UDR+g2Kno7kYFlPLI?=
 =?us-ascii?Q?Y5vGOpGseUFkDGhGZ1Nfdj4pgwcssK/ee1vB4GZfiwZfBvvQOZtq2jAmJTPS?=
 =?us-ascii?Q?wbraY15fnLfv6itfpWI3c5Ot+peFEYBALHQKk0pTyFLKr6og77NzTgj2G1j+?=
 =?us-ascii?Q?RQPMuYJDTITM0wtmFVXKhJlrl44vEVbM6Yd8aAQDdy556iHP0THngtRuxKEr?=
 =?us-ascii?Q?i2C2d2Wf687fWFgLF19kO+rfAN1M7+hS3izPTg5g/7VANAo9qxIgUIuNQnfi?=
 =?us-ascii?Q?NQrB65GcDpR0EE/9tpoPquq4LgJF66CFMHT4Moap/hc0Kzb6dBvCeVEgTQSm?=
 =?us-ascii?Q?eEfXyNu0+lq38C1QzSFskLhDc9xQN1+FZpp7uIwMbz2zLsXcQqjISYi+ScH1?=
 =?us-ascii?Q?0Dgyisq3ZC51Ye5s3rCcX3GlhAgtNpvymDUI16oidkyiiSWdnIhv4z2oFqU6?=
 =?us-ascii?Q?9PQLkjftS7ricC6J4ldmzWkTQqRxlrbA1gfZfUomJHbbRaui7aVi/u9dyyEs?=
 =?us-ascii?Q?VcZ5XDZQ/P2LG8Rb1Pys5SHWpravdfB38zG4rQ0jSdLnbVliMaQGGwOZPYXH?=
 =?us-ascii?Q?8/WlHqKW33lBq0UucygTC/Hqb5+do9v4JMQGqnnCMO/qbox8YBRVa4etGdhq?=
 =?us-ascii?Q?J3rpWvfTj7lQn3B51k8fB2rCx1E8Kwk+/iVYBhMiE/XW/m9ynckY5pwAovIN?=
 =?us-ascii?Q?lG9i8UYf0nU1l7G1yUzHf81bWrgBN4OdPYBWlOx9CqEk/saW2aq6ot42p0u+?=
 =?us-ascii?Q?2rEdVYSSwhKnR1yNvBeVKtp8S3/VErJZxzMUfzesPNQ9HcXXHbZXZqhqljKM?=
 =?us-ascii?Q?DExUHNKw5RNB5AodyLSBlZXYr03JV0wz1cd2F6J6iS8K8pyoDHpoq2v1Cyq+?=
 =?us-ascii?Q?14BENIkYSBXHf1O/dA2CPurrbxR58F+SKuLx04V9iQiTuytXPQkk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a99f59-9eeb-4c1f-0c12-08df1272a14e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 15:12:45.4500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: foylxteNJQrww79NYd6DMLiWfsxNXXNymZVmfD4/cY7tsyGaYA7ZePdd+VU0iZ94/2CU9mAj05g+9FofWFJotfjOmJkoVRISJ0ZU2jxJP74wxSZnsxUxs9iNyN9h2Rvd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11691

On Sun, Sep 13, 2026 at 12:50:01PM +0800, Guangshuo Li wrote:
> dpaa2_qdma_setup() allocates priv->ppriv separately from priv, but the
> allocation is not released on all teardown paths.
>
> If dpdmai_get_rx_queue() or dpdmai_get_tx_queue() fails after
> priv->ppriv has been allocated, dpaa2_qdma_setup() returns through the
> error path without freeing it.
>
> The normal remove path has the same issue. dpaa2_qdma_remove() frees
> priv without first releasing priv->ppriv, losing the only reference to
> the separately allocated array.
>
> Free priv->ppriv on setup failures that occur after its allocation and
> during normal driver removal before freeing priv.
>
> This issue was found by manual code inspection.
>
> Fixes: 7fdf9b05c73b ("dmaengine: fsl-dpaa2-qdma: Add NXP dpaa2 qDMA controller driver for Layerscape SoCs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---

qdma_setup() is called by probe() only use devm_ allocate function

Frank

>  drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> index bf771251264d..0f0fe0291a06 100644
> --- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> +++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> @@ -365,7 +365,7 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
>  					  i, 0, &priv->rx_queue_attr[i]);
>  		if (err) {
>  			dev_err(dev, "dpdmai_get_rx_queue() failed\n");
> -			goto exit;
> +			goto err_free_ppriv;
>  		}
>  		ppriv->rsp_fqid = priv->rx_queue_attr[i].fqid;
>
> @@ -373,7 +373,7 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
>  					  i, 0, &priv->tx_queue_attr[i]);
>  		if (err) {
>  			dev_err(dev, "dpdmai_get_tx_queue() failed\n");
> -			goto exit;
> +			goto err_free_ppriv;
>  		}
>  		ppriv->req_fqid = priv->tx_queue_attr[i].fqid;
>  		ppriv->prio = DPAA2_QDMA_DEFAULT_PRIORITY;
> @@ -382,6 +382,9 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
>  	}
>
>  	return 0;
> +
> +err_free_ppriv:
> +	kfree(priv->ppriv);
>  exit:
>  	dpdmai_close(priv->mc_io, 0, ls_dev->mc_handle);
>  	return err;
> @@ -787,6 +790,7 @@ static void dpaa2_qdma_remove(struct fsl_mc_device *ls_dev)
>  	dpaa2_dpdmai_free_channels(dpaa2_qdma);
>
>  	dma_async_device_unregister(&dpaa2_qdma->dma_dev);
> +	kfree(priv->ppriv);
>  	kfree(priv);
>  	kfree(dpaa2_qdma);
>  }
> --
> 2.43.0
>
