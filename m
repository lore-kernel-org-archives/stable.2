Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D54035E92B;
	Thu, 30 Jul 2026 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785425996; cv=fail; b=BgKx6zPM55jRY2ZQ1hw0Q14VBHlFrOOBJHpW701MjJ9ddUAk/OI7VVk/Wr3NzofK1lo5EJ19FllkAS3hqPuB4vnt2WU+io58He4FD5i7OlVnebCVF2bV9kDJdehQsOhcBLImq8iNUkJtW9/2m0UQTjGLvth2adxKEMsfGRK8agg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785425996; c=relaxed/simple;
	bh=Ko108alT2WqZUrIEVb2AOVLLQvR11sFAfyYSZlKGL0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HNfaBuzBTnvnVc8NnHnmJw5zn9RlDAyE19AZfGqsbN3efgZRJRDQyOIzn7borKfNYkzOTX9bzWhkuuOib48t1pc+NqoMgL66v/PmB8qlJOzz3ouZ6YYKHWUbiAXKAq2onRVcYEspR2z/81cGyIeFshRj/FeOlhHSMsITKoMYGFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dahXXi08; arc=fail smtp.client-ip=52.101.66.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dahXXi08"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5MoSRrUnSoDc9lcCoYyX344R3J0A6fdHjlynko0WadU73mk2B+bBJ+9j5bn2KIMelPIPYjlR1b7q7s8ioli12cCpATvcA5pEnD8N/UTLNJCKtVoxEyEJoWKR17t+RTaUlLSNJmZUvnMJq3dYO1nszsPZc6jR9g6QV1oGFqOKSrmKC4nNHx7oWhWWp7bjz+Lg9J3Lah5q4+YjK8clyWBdZMpyAgmvEjeBusC60VPzrBBqQiyh0A7vc8JZ+Lfu3+RlINECM5K9+w6fouJELo+jMYIOLpiAgrBHUtnP5c5e2O6NOeSBEGhKajl2BAIf+mViDl2bq4u4spVrcXn5vzf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zg43jLV6qjLRLJR2Hk7Bbg/lS5gdMg884Hx6LCnktv8=;
 b=B1zDiuu6OudLAGNUT53caxVLjAewsNZRwz3i4zQzGksHg9A/GsvknSvLud6JC0YdGrszWDoyfgifiA3SYkluctpC5FhLxI4UZ3OEbcTIOIxz7f/R5Y4x3J1ieSM4GYf5oz+K5G2lc7KCHqsLi0J3U1N6ZMAgpx64ORbduIColMAyTiP9p0cu2BciJ2zmt27F546ERQsQxL8uAF9UuQ7cti9daOWkMRM7l9MHbVtq3jJThW7RZfvryU9TLdLI9begLa8QOfjUqIqWG9WMdMFYKYrbzRL7WzNDrxWmh9hd22Ne/5Pg490dq69VOB78j2edIZ9gtXdCoFCqg8q8nH/QWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zg43jLV6qjLRLJR2Hk7Bbg/lS5gdMg884Hx6LCnktv8=;
 b=dahXXi08cYKEfdvyaN/paGb7np400gOfoGD/dOxJvdFDj/ZiGHOs59UrEntCsEcIga+w+i24TbupIqX34eifWO530K7BYcfM+wk7wuCLaiDzFgE4Dyb1Zd8VasQhviFXg+jHeBfJmvKwUajncpxogcnoqMw10YTmPfQTWucG416ZKsna5dh+dz83GSwruJaP/k2UyUhqVCfQpneg/7PQtz/6wQTj0uPHCvWW8fJjHKByFXwMIesIOEzsAs+C4h/LL8rGHokF2p8ivPUHn+NKgBWE5odPFyXdfmI6JE0gtRxbl6FASqHykq7634LONeev9VH7/myZ7/FUACTv2BAR9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by AS5PR04MB9754.eurprd04.prod.outlook.com
 (2603:10a6:20b:654::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 15:39:50 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0245.012; Thu, 30 Jul 2026
 15:39:50 +0000
Date: Thu, 30 Jul 2026 18:39:46 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: vjardin@free.fr
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bogdan Purcareata <bogdan.purcareata@nxp.com>, 
	Stuart Yoder <stuyoder@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] bus: fsl-mc: set dma_mask for the root DPRC device
Message-ID: <smvzffc65xr23fyozcahv4ifj643hxd6rj6uu6pi6ikc2tfvqx@ik4vkhhjytxh>
References: <20260724-for-upstream-fsl-mc-dprc-dma-mask-v1-1-6f08af883195@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-for-upstream-fsl-mc-dprc-dma-mask-v1-1-6f08af883195@free.fr>
X-ClientProxiedBy: AM8P189CA0002.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::7) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|AS5PR04MB9754:EE_
X-MS-Office365-Filtering-Correlation-Id: ab489b97-6ec7-43c4-4424-08deee50cb01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|19092799006|6133799003|56012099006|11063799006|10067099003|3023799007|22082099003|18002099003|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info:
	jqaZD6m5JAAEK0ChpuQKSh1Nkejet639mh9ruCsVMqEYQRNYY7zLsVX4/svRfVgXWJP3rSJB93iRAjC8/9GY4fnCO3Om0w98H66QG863fsGkC3Ow63F2xkwgLgQF1Oa3Bm9pwrpiURnFLQFH4IXcpTJ0R+FzTtpaa2Iwb9VkU8PMpnmI9EYqjIEZICo4SQ5HgqDKydr49ZTnuvunjokU896dvT+F4vkYWQh4D3H4u2nHFv/VdtwdH/pAD/iHBZhpYOJsr7RjvGwoVNfV23wx7aSKWUzXscubU6h8tXmS7/t0iVzbdmdxq+wqluvWVDF4FIAEHxv1CQAJqR6cpy5AP2w1O4pdKDVsPqEOkFSOSHTSYDHoprVdgn817wp5fX5WBlitD0E3NEHxYdZkEb7AdEdTOBY43tPbOeHCmVX4Um0KxwB7yArwVdy2cHrfoqqkSEPMMLmn2AS3LYuM6jYCYcx0OX0JqR6cmFuYmcqVf/uIwj+IKC+Wil+uw5IoBID7RQQjB6+3gAS60icyTmd3tN5u/PmdBE5+Yd5t5j1+F1l2LtOhT5/8Hm+25JoSFbPUmLoLKNsgEQ/jW5TEDm3qCKaMIrihkoZDS1q+5+Sgg/DMXrMvYwCEdPCT+zNa5nVlY5yp3YebTN9JdkiL9sg6JxU5ievgKU+51Kon86EPrOAg6808gggNJZsvX750JX9UuIZGqhgBj3V3TyBe85qjy+E4otoUAs9I8m2YHmcSTFgSn4CSkC2EiUE/13iBPYU2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(19092799006)(6133799003)(56012099006)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003)(41080700001)(15866825006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zX6kFbFg0NRHH1o/mq0JbHf8po7CkXPDyZIPR/JXyKncVdNRUZdNCGTKgwpT?=
 =?us-ascii?Q?o9C5pQMgvVEeUE3SVdcaRfKrQg99bW11CvqYUIndwUYtqWj9hGpgwI+MBGpf?=
 =?us-ascii?Q?I11pMEKa3OYbAKUOjTl1xYB3S0MAwrGKawfwd/naENTfeI9+ngeB/PCtSfC6?=
 =?us-ascii?Q?J1mqQsfRzMrH/rqo/OBIw4ttIz5YawBFdLq2nU/yqhds6GdkXiI9qmfwDTo4?=
 =?us-ascii?Q?HJEzGSO2LAdZi4xVX0+MhuO4jB+cO8VDep9DvtiqnnQqzc9SZxS7GW8g4osD?=
 =?us-ascii?Q?XBl8/dUTHdlWTNVkElDCNGn5c6IjgZx9/uj/8X+IY4hO7RfNGwHVV6ZPxuxs?=
 =?us-ascii?Q?VnNeuwMIH2RdjCI9DxcO0WPWb/DyQDZyrEMaoZm8giK9ObPl5Ec0aZcCHL23?=
 =?us-ascii?Q?ewibub6h41njdTrurxDCYCh9kPq0q/D4cRj6gegEV93dh5GBXVfeyOSQsYIw?=
 =?us-ascii?Q?JZmw5foCoaw7KbFY9WLrBS5PGeunBJ2VMXCnexUEvtw5oTaz2GVrLDIZy9t4?=
 =?us-ascii?Q?FM08Rbn5yN7q25UcZeU0M5vE7DzGI25Lzxd67ktAcvl3a5MNmVKva4JZW7Do?=
 =?us-ascii?Q?UWxJg7ZyU3q+BfZ5Aebt2MlnJ7jw93+Kc3LW6tMKq+4BiN2FPZDYTkligCwT?=
 =?us-ascii?Q?JXaeMk0rs8iqKlsRjp1IFPlRftcGX1LtwUWAEIJADaOWSHnN56p3ISllbLwx?=
 =?us-ascii?Q?jIQ7Alc4QJS943XbulkMA9eO53BBrw5aEOiqkZpA8rtQ/tFukzz5k9+/00dt?=
 =?us-ascii?Q?EW725M9ZqQGK7Sp1+DMqh1QuxMtQW7b7GODXq8U0fM7XsDbHNo0I8t/8zvqp?=
 =?us-ascii?Q?gXzBRazIUvSAQLa/ye0tzT+uYY1cT0CwAwJ49ZR1/bpU+WuBw85xd9w1Bc+k?=
 =?us-ascii?Q?knL6M1TbJof/1FhtPo1nilhUnQ8yfOHw/eAwxOGCJCPE+W1yZaqMLYR1jrbG?=
 =?us-ascii?Q?JNDq+GgizJJF/3ylQu7W5eXu63S5kgrLN8bGNo6axI4ZA8Vd5QzjK+KGKpNB?=
 =?us-ascii?Q?ZiKZhNJB7f/MBlipp1fHIChHeUJq4Ypc2Eo6Xu6ZR4Dv6KoCl7evK9SsrjFF?=
 =?us-ascii?Q?nBjbIWwY+2TiROFWECxXwsFMHIIIv8SdzVBwsREpey2V6DsuvYskhYVLaTxx?=
 =?us-ascii?Q?V9nt0zuS+Q3Bs8ePsugr22LbrmL+yf81MDdpBrir+1O0FmIlhlX+aaztWAUO?=
 =?us-ascii?Q?Fbc95v/mV0K343uiwL5mkHqJndw85LScgJPOzlDM48GhqFmaGrfxU2j0AWRc?=
 =?us-ascii?Q?zoOS1r9dE6r8uPWkXVYbXfILQ6qKMtlhmeK5LJtJaAj/fbc0jij5c2gmszrh?=
 =?us-ascii?Q?sGhBxoiW3EqH0sRNfx8iSQbXXOIF/5sMRdoO4NlvcTg6PotzPeIW1ylbwekR?=
 =?us-ascii?Q?m+W932wzdgVCG9wHk4+s7Xaj54wga21lJpinY7z6KhlVOoyjnnZp7EWGsPYa?=
 =?us-ascii?Q?5BiqUSB1YwLpUue9JgRiI8ttQUdlUQxqLD4gq20ksPxKGu/F9Xkk/hYVZdgY?=
 =?us-ascii?Q?xflyUqxBRh298DAx4f3JwheHd5apPUL98VMZzmVt84ax9DboPR/h4awaDH9q?=
 =?us-ascii?Q?7uPMqdyZ/Y2Bb8qT61SkvlUcoT8PCnrUPD0X1n3ejayHupW5SjTSPaoYleT7?=
 =?us-ascii?Q?kjJLM/oZ9wWDQYi8N8jkvxKvZLKzyucGtyzqGbrYHN64FDlICeUtJVSSJx3U?=
 =?us-ascii?Q?b4Qf3v2Opduu4bEFkQurdqJgqB+IxH9BQEY5HbQZ4oazJ1mmNxsvvm050O96?=
 =?us-ascii?Q?LILet4gPEg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab489b97-6ec7-43c4-4424-08deee50cb01
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 15:39:50.4775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YAQSfFal2L2rExmbO4ANl85lQk6qlelF50UUco/KBFK6i3HSVdh6YgrLN8c/UVpl6umcYZUGWbUU6YVh8fmaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9754

On Fri, Jul 24, 2026 at 12:56:33AM +0200, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
> 
> On Layerscape platforms, when SMMU is disabled,
> fsl_mc_device_add() leads to the DPRC device with a NULL dma_mask.
> 
> It has been tested on LX2160A, no SMMU on the MC
> domain: the root DPRC can probe cleanly and fsl_mc children
> enumerate.
> 
> Fixes: a259ed1618d2 ("bus/fsl-mc: support dma configure for devices on fsl-mc bus")

Is this fixing an actual bug introduced by the blamed commit or are we
talking only about the warning message?

Commit 4d8bde883bfb ("OF: Don't set default coherent DMA mask") is the
one that added the dev_warn.

> Cc: stable@vger.kernel.org
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
> fsl_mc_device_add() already seeds a default dma_mask for non-DPRC
> objects, but never for the DPRC devices themselves. When the MC I/O
> domain is not behind an SMMU, the root DPRC reaches
> fsl_mc_dma_configure() -> of_dma_configure_id() with a NULL dma_mask
> and the probe warns "DMA mask not set".
> This mirrors the existing
> non-DPRC seeding into the DPRC branch.
> 
> Tested on LX2160A with no SMMU on the MC domain: the root DPRC probes
> cleanly and its fsl_mc children enumerate.
> ---
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 64d75eed0d34..585345ac0179 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -832,6 +832,14 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>  		error = get_dprc_icid(mc_io2, obj_desc->id, &mc_dev->icid);
>  		if (error < 0)
>  			goto error_cleanup_dev;
> +
> +		/*
> +		 * Seed dma_mask so platforms without an SMMU don't complain
> +		 * with "DMA mask not set" in of_dma_configure_id().
> +		 */
> +		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
> +		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
> +		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;

Since as you said this is an exact mirror for the non-DPRC case, can you
move it to the common path before the if-else statement without
duplicating it?

Ioana
