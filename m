Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013021.outbound.protection.outlook.com [40.107.159.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C993A5E6C;
	Thu,  4 Jun 2026 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780599290; cv=fail; b=GTvupUX3HVDfjozqLGX3vxPrpSU4pDcF6QSN/6CYLqQ9KQVxhB70oPlB7qHLspz1VHMmZGv1SAAYRiCyUGJz0eWlHr2UDNiI1qgkYc5ehTsUBFdAOmjIrEY9Z1daxGPVbQPCZWLgyMQbQgA6oOo+RMvyvTf6os+6vGuV7Of2M10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780599290; c=relaxed/simple;
	bh=Jc2Md2yJk4FtkYFpO3Jp3yAGSfaam18J4NapttbycwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fuzgkDvOv3sPozHC1WCWUOYsIeQEJlDA+Nb+dJ8+kfpaqqfo08icqUjx6M8X72Mv9BiUQ/SJORGfKfvnPoyzssxIgH9WnP/z5dODZTndEkd3fo6zxjIOpEBJWMAJMQix+0vUwnVe09EILPbVJ9liKFnIMnRr6BiMW7EFq9oRNpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dI26LU1f; arc=fail smtp.client-ip=40.107.159.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dI26LU1f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qk3azYnBDK6DpYJJKyOrp2TmlDpVysOw1vxX9/4zChFbVoQYZ0W2lEVUhDGPE6l0rhHV2w33v+TM3FJzJou1QafIF7d4Lyzn/nEPMedjKQxlv/k/wHTkLWsCdqRGpIZCzGKajANO8PgnXHnMF4lWSMqHC426QuBxcZ78ExiHtxpVZpVMuYBArFhF7X4v2k52WqltXW7lVPtCKZPewcg8i6EG3weLRy4j2PXXWujKrD+otxAokZzJcVvP9fbZKxjiBU5Xo6/HSlpe29GRgafYXXEWfQO9nnSuRgR5skOws04YRzWMvIYAfdolt8rHkmynOED4c+Am0J72mrjt6zWHtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDCWmDXGDjgZwSm73HjxwRS2SAfJPjaDV5Ojg7IhTfY=;
 b=sILWuUMc1+GH79IOlSuPH24N3L9tRHeR7TyRh/hW9m2NSKFAIJCCmmIevqkS/gJX3Uy80VGjEHw4J/qg3xLkf1dbgt45B1mlDQoKKFWtgaOUm37eTdoVb56ruTivA/qfHo6n2U1/V+wAcDeqZpilzO4zoup4CVxhZScdLA8jssLeyUB/RUPxHFfpiTe1x+PpHtsungDt6ccTu3Blo+I7seav/68+0ZzfDV+6ynvX/13nQ3vCqIHnpaLC3FqPLUVMOPQKLVkH7pmJNGnaZdUwbf8V0CN56KewlnnUh1mpzRlqfFazzUxJUaSGZ5yE+ymnvNlYQU7Y07soSX+w5fr5ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDCWmDXGDjgZwSm73HjxwRS2SAfJPjaDV5Ojg7IhTfY=;
 b=dI26LU1fqQBoXpotwuJQ6tFoNMElJ0s+4iNKScehNY1FavTSWSZKAs9YN6anOxVzVIMWI3oADyGS0t6E94r4fdnJiO2q93QvPGZ6cz42jQQLwyhGllDxfdMgUWgZT+zj9lQwva0wSBMY/8IANjHc2ktdfyck5kAatcdfty6MR06k3LteE08DIu4GUtjB30CaIeooQNHiB8r7kdR8sW8pzsX4RlF5o/IrFdHOqwRK+SkztP6gQV9U9MiXkd3hIDzIp3afusJIRBdPHvDwLrEaegPKPtU/RSsEC6E7AvqyghmQFCdtsBVGy9SyDLTnb8n9pO2JtIKiLAXqezpQrYFkZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB12055.eurprd04.prod.outlook.com (2603:10a6:800:325::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 18:54:39 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 18:54:38 +0000
Date: Thu, 4 Jun 2026 14:54:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
Cc: aisheng.dong@nxp.com, andi.shyti@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, carlos.song@nxp.com,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PACTH v2] i2c: imx-lpi2c: mark I2C adapter when hardware is
 powered down
Message-ID: <aiHJ6EWeXYqGEXE1@lizhi-Precision-Tower-5810>
References: <20260520090910.2879570-1-carlos.song@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520090910.2879570-1-carlos.song@oss.nxp.com>
X-ClientProxiedBy: SN7PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:806:120::19) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB12055:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d6a6c9-2fe4-47c5-fdbf-08dec26aba98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|19092799006|366016|38350700014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vk0hGNFtoLrUY4z0AbzRxoFRsiXefwjKDbZ71shaxBEVgeRaqWE7ju9d05MeR62E4i6pidNWemCVu+6b4zENyUA/CH6TLExGNTeD3bNDY2802GTcersO7vyz8tCydjlSdcub/8XlZKIB6047X+x6KG7kx4G036WOMyTG3fJ43ph/MLPR7HQ/9fokLeoWG39geYA0USaDboBoSiT0WbexGYjE3KfJYPSYBSQamMDdUzZgV00+Md94tqbM/Zi4T5brv9HrVOyZTSs1VGT0aAwoICy0a/Gil+eJ4OH0H0ke4tJxRZ2LC3X8GgsMbkJOhVO7BLWkAh4TEinf/ENtOswWw/vIwRjglF5EpUdF6mYiYatORr4P3rQxdH7urq2Mioc1oLUkO4yPBR+9NqGA/zh2h8i65c/+fQTFJPqbHqfN0vncnYAmhDkOt5cpl/qaOuTUT3zHKTNm5WIO82yp+ENFfXGUZL9T12zu0lN53Het2k5yxsy6raq2ChooKekv7McA1pStah7eMQ8er9lLkdSrIAq15kh+IM/alzQzOv8WCHmE1WGEw9hgEpuYnzipMekXgU4mS32i4+uZ6pslu3JEYG/WXzQZrYJyQkDW0rbtgZE8WrSjTfT5BjSplyUlYh+Fd2uep5KKhcHdT6+ZoiDpA/4lPJa0uRlG1zIOooXJzLDHrsH/ACsBrgOlzrPxgG8AAcktpR6JgAyXHinAwZBT4ZtbMDGyHI85WqQka7KnpySTl8hwin6W6XhGiMeaNGCe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(19092799006)(366016)(38350700014)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UDXy7fWgqeOG1QNt8J5FkIOdnOn0kRXLB85S/QU18ZLAgvQTgKhexntReehT?=
 =?us-ascii?Q?HkdFs+SmyMDpHq0lcZ5jqtvNSd+lBEHYjWY3zLjud1ii0kBXnSo5O8vnAn1F?=
 =?us-ascii?Q?2h81v/rH25Y4ljrsJSKhpdzPll8+7D9w0igiJkcUvdWKGhaLmZ3WplFLpCkC?=
 =?us-ascii?Q?5MdXYUHRg0dA5dTOtKxH6+X03k/L+8SaTHETV3fCRs8ARwPiJcxQQYronw68?=
 =?us-ascii?Q?hbORPwog1DQC6CYhVNZj4Yt7SoQIINoUqHlWDrqXgLH89I1/8orxXKdK/f36?=
 =?us-ascii?Q?XtqpJu0NjMRAwKuOQaNIwmT3UEPnbRNhy4PV61Z3Tq21e78J43iICd6dPcsU?=
 =?us-ascii?Q?5TzgcWo4tU9/EHliY4I5a57o+6dMFHIiemr0f4E7eNxWc0I1aNggyrc74yLe?=
 =?us-ascii?Q?/QfIHP3um2akGUOdnLgCk2W0oq49pGyi7C9JjL6LSQjYwrI+AyffgfMwCvLd?=
 =?us-ascii?Q?PGG2reB0nCOAE9lgOtbNS4f5fHxQLyxh7tEOz3wotYrX2ItH0fTkix6K2BZ/?=
 =?us-ascii?Q?kboqUztRRcH7T9O+YH8AqCcEjngzKHLyHxu3/Fwv4/JnptPDLihhl9DiICTA?=
 =?us-ascii?Q?QrpjJ02gjYzYzsxLkc2Up2D+jCdyzFlBiW6aKY6Hx0W0T+Bg7qAqihpiC8Ez?=
 =?us-ascii?Q?5xErm0gGNb2xADd5JgFFwaa1zalOs24bGaJcJhvDwmSqTVJ1OQLJkuIF46m7?=
 =?us-ascii?Q?QTk667Q5X1ZfUtWgxJVylWg6NbU+9MjkBKffiA3jJS7r0Cl5GHvf+b/tUgA0?=
 =?us-ascii?Q?iS2YUd6tFtRy7GYC7K5Vq2hvb/C/rtjpij/maWEI3M01CpuOlx5bDRtbWox4?=
 =?us-ascii?Q?mv4NldtNo0r5oXY8Gdzq50PItafQjWI60Sqoc3QOYiPkPCF0rD0/Q8WUk2ZC?=
 =?us-ascii?Q?iyfn8xCGfIOI0tvI1+Ig9W69n8zdDMPdffe7ZlyADY1/cYrMcN1oRz+qwPHJ?=
 =?us-ascii?Q?xPARwnkvOnpShLndJ0zwCqn2QdjvNnk8TzhyYcQjrZmNBRgNQkDSEU5rVwwT?=
 =?us-ascii?Q?T9gESe9H8GKOpntt+g1FcINTCRlF++BBiQw00IFMKaQsAnP5+bCjC59AbwEq?=
 =?us-ascii?Q?v6XDsbkq2h5FIhpz96Z00hBx1B5ph1SIa1DRNHhkVI3KQfLFIHt2rtpOuhxj?=
 =?us-ascii?Q?3U1NOaNWXdChGYHVhqagwlbhjXwV+ZatSkzSCr/qIZJMtH0eGJxnBo1vAJ4y?=
 =?us-ascii?Q?9esaJc6ERzMjpVcA8LCnu5b5XpCflp+m9cisTC5Jl/RK0Yw9D9CgesTAb4fP?=
 =?us-ascii?Q?xVO17kkNXP8CaAfAsOQgsw+skM6+YXOn+VEcXmYA4VHSyzr1D32vvgYr/1M9?=
 =?us-ascii?Q?5v8dNdC77ATbnTn49GEk/riLz2LMHki67q8vu5Y+56Jx8LI8kP3mA10OfVe3?=
 =?us-ascii?Q?MsajKUM34N4Zv4hwxYVp1BBk5cIkKSyT2f9JWbqHGA7bqMrEq/CPqAyHOcgr?=
 =?us-ascii?Q?wMK8DU8RexifSSBUWhM0wBmvJZi0Z35jK3HARiZKafsk6Ap01fS3d8tB/s2E?=
 =?us-ascii?Q?SW9xopn4enqdi8VHOOrLuvHzzaHw6iW0AZ85DTP9uLMrPsX6dzXSRydvS2uv?=
 =?us-ascii?Q?4UCrNnDRbIXmv+m/w5eqrpYvyzxprufjmvPnh6dWcqFGy9vBy3HpzIPn7qxg?=
 =?us-ascii?Q?Ci3Ah6ajQX6A3tU8FuR3Mpvyhu5ptU0+arIxJ0QpxpTbvP7ZYDtYeXrI+d5S?=
 =?us-ascii?Q?zKzqb9v5IEcielHNhJI+O/3LsZXUFd4nZed1RM92XbL7trd/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d6a6c9-2fe4-47c5-fdbf-08dec26aba98
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 18:54:38.8233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OOl1F30J+CeeADabTYAO8Kd/CZLWqWPvAj8Hvg8gVajev7iO3uTutQxlBMpQSspcROZZgdbrfMDuPt9Szvyag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12055

On Wed, May 20, 2026 at 05:09:10PM +0800, Carlos Song (OSS) wrote:
> From: Carlos Song <carlos.song@nxp.com>
>
> Mark the I2C adapter as suspended during system suspend to block further
> transfers, and resume it on system resume. This prevents potential hangs
> when the hardware is powered down but clients still attempt I2C transfers.
>
> Fixes: 1ee867e465c1 ("i2c: imx-lpi2c: add target mode support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Change for v2:
>   - Call i2c_mark_adapter_suspended() before pm_runtime_force_suspend()
>     to prevent potential deadlock if a transfer is active during suspend.
>   - Roll back with i2c_mark_adapter_resumed() if pm_runtime_force_suspend()
>     fails.
> ---
>  drivers/i2c/busses/i2c-imx-lpi2c.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
> index a01c23696481..01ee38131ef2 100644
> --- a/drivers/i2c/busses/i2c-imx-lpi2c.c
> +++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
> @@ -1635,7 +1635,18 @@ static int __maybe_unused lpi2c_runtime_resume(struct device *dev)
>
>  static int __maybe_unused lpi2c_suspend_noirq(struct device *dev)
>  {
> -	return pm_runtime_force_suspend(dev);
> +	struct lpi2c_imx_struct *lpi2c_imx = dev_get_drvdata(dev);
> +	int ret;
> +
> +	i2c_mark_adapter_suspended(&lpi2c_imx->adapter);
> +
> +	ret = pm_runtime_force_suspend(dev);
> +	if (ret) {
> +		i2c_mark_adapter_resumed(&lpi2c_imx->adapter);
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>
>  static int __maybe_unused lpi2c_resume_noirq(struct device *dev)
> @@ -1655,6 +1666,8 @@ static int __maybe_unused lpi2c_resume_noirq(struct device *dev)
>  	if (lpi2c_imx->target)
>  		lpi2c_imx_target_init(lpi2c_imx);
>
> +	i2c_mark_adapter_resumed(&lpi2c_imx->adapter);
> +
>  	return 0;
>  }
>
> --
> 2.43.0
>
