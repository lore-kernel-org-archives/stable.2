Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFBD423794;
	Wed,  5 Aug 2026 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785959832; cv=fail; b=eeii3DZm1jsObgjJ5DZjocWjdq9ikzlAaRWVJujqOmihiqrOpe84kgjk3ByYoD9Sjg5ZZqksbAKdS4Z6ovHdDe9DETwmIlOOBTaT5i/qa0lQBp9y09PeYS+GTthFtTugsfxW/H6JWf6Q+ta9aFfEwyNGgscmnOZBLtxy5tI4X7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785959832; c=relaxed/simple;
	bh=xIjzbd7sY1ykMMJVUaKok3ktPKHtBQfWpBlZM4JMWCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fnjKhARfb7yg5zX35CPvcYQXcHCBkNC+iZetJCjSun4YR1qc37MuiUUmOUmcTn68Ce98cvv5+PA6RVVycR8ZqxyS43ilp1ONa6nWJItGCOGVTVyGIvLGIiTrGTDz4HCUE3FHhVcU9XCwQII2UwNQvcvMh1MwmKZNZTUaVSRlFZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VCqFCZV+; arc=fail smtp.client-ip=52.101.70.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VCqFCZV+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vED0tqD5V6GpGm/0qLc7TEGFWIxBxcg+kt8iF2GAzU/maDDVpOK1EMrCb84ebCtcCXdWxGSSdwvFS1fnXd89QZgBfxsVUCCFnr+LzMyUcdhD8dDbqz/wyWAUArP70Y5LccBrdvsEKb7/S04cyf7L1z24c5rbKKZ4kju2VGgpg+M/a0ENqwxKl6/icqcXdeW/m10I5a5+2gmqJ+VmSOrPJFjFeatasgpJQhnM0dS8nU3PKJleA0dXx4Hr1jN40XiCGf2XBge9dRNV9CmwYmDdPieC39KqdKN4W9pqjF/oqdvFRmJ3/rONbNwNbQLpfM9GJZ6SXwKuutoXefOsdZ78ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RACngOTFEUnsP7cx9qavAwl1c6f7lgknOMCglcR/ME=;
 b=WGtdER8DMarhWp/TrCGHUPlGRRycsd/tHxfhKvKG1sTN4IacF/PFEqPc0x67g5SUPw1lSrafVGAmsQj+F8BBYJ5SzCeZNhfbr7TajvpNlROzBOb732cqfn4u8cYRErlmD/Vx1mTLVcIs2NZWjLQ0LmBppX6AoiYbgrIpsCuIf3INrsEuD6rB+hLNhNT7d8HqEqgLUXmaj4bgOnluIShFPvzyKMIgWmQwXHb6yFFCQkYDjt9rzS/I6VIt8Rz/ran2a4C0ByWya7r/AtzeF/r05LrhcM67PUYrAP7LdzWPDeI2+1Q6vH3X5f2Mp7gd3rO0tqtXEo7PU/KeOuqFwwggjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RACngOTFEUnsP7cx9qavAwl1c6f7lgknOMCglcR/ME=;
 b=VCqFCZV+xZ46f7Wqddwph9Ks0YjqJIE1MXa7lbSk69jfaG3dhkdMjv4mmI2pJMXAEJA1QPlzrgR+EJcnbtuDfIcujJyGIOUsGpy8HcH0TgNL3pdPePwZFNIZsCDfgj14nzyt8CXbTD07H6HlpmD+V56AUapNjOFJ+KxRJp2sPJiFElDkGsXh/P3l0WJrCDeU5Hd5LtfN1D6OC2zwcrEZ1wGbSZX38o64y8yQw2XVAdXmBW9vs92IZI25gM2m3noJ18P+Rei5k74qD9yJH/+4NbdxQkXbPXVoPKJcJ2IauOBIhB/ucTauQIc87SOfH8O5Zkyz1XpYb2Id2Mx5DLtnOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB9149.eurprd04.prod.outlook.com (2603:10a6:150:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 19:57:07 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 19:57:07 +0000
Date: Wed, 5 Aug 2026 15:57:00 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sashiko AI review <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 5/5] i3c: dw: Resume the controller before unregistering
 the bus
Message-ID: <anOVjJD05BCpli4A@lizhi-Precision-Tower-5810>
References: <20260804101301.2975911-1-akhilrajeev@nvidia.com>
 <20260804101301.2975911-6-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804101301.2975911-6-akhilrajeev@nvidia.com>
X-ClientProxiedBy: SN7PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:806:122::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB9149:EE_
X-MS-Office365-Filtering-Correlation-Id: aadf4eb4-ee55-4ef4-1a6c-08def32bbaa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|19092799006|366016|1800799024|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GSN1QtnYpd7svOnsARSZPSld3gC0FlakzH+NovFqr9mQ9mCNIEg2wZOtcmS6ZZXk0Bkqbt1WJjo6QGrB7nLp8sgh6aD+EMJmb+CfUzSpZMijgzgaeN9cC8B6DhfGt0ios77BJI3jxJcjCVrB0hFxWirE7oB/n66//hrX4EYGApIdJ8tdV32BKqfrD9g6IfVzLeW0aPlbTqr9DPNlhPMiDMRqnX0SPgPLR21Hs77ijx7BJHlbPqmkfFb9u+MykznSLuIiWe0UTdjNeXwdF7lJddbX3TK63fI5MejOuZvrCi9427fUPKkB+tP6VrWNgjYeL0enME23vGFfmSveb+Q6b00sio0E9SSSbH34HDvD73pwp4nRbuIdBB0Jl24wfdIfoZXGSYEvuS04VQ8lDfppkY9BFKyW9HGkMvi6EKqIAoX9oZNuxS/mZ5i7uu0rikt9ogXdFcQNRtDifxRnmJjAeSv1dW/K+Eo51nw+lT8E/Z6/CGiY1Th+IcbYRiAOAhpOUqLru/SFSUCWrZsnOuE6eN+OkZ1GZtvX1Dg5nDV9OnQAWQlC48rRq70eYCSrUu/deOlYStQmd6WBLgCYnmf7KnDtpltQxvgB+bXAXee9LLw1G6mHx9bseJ1M8r82Ot/w1Y9RlDo1jX5fWmhPPJF0hw6RnwJ7kBWFbVDkMd9OT08=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(19092799006)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZwBb5N44dfUp+9s0i5cVe2XQLiOkG1a19f9KtMsMIwGJ6pnlx6hXUVyW/Fqx?=
 =?us-ascii?Q?ACTCwV5dcb5u8yt5FRL1MsyNzJ0SSc8s3mtI6+gNURwVMUP881eqhDeNgm1o?=
 =?us-ascii?Q?8G0tsg3yON1gBte0vNs1NJMa7M8ZLpgMvkROxeIjfaX/JN/M3S2BIhAY182k?=
 =?us-ascii?Q?ddJPCSC9RdrbJku/mNw5n4vm4KNJ08Zg+AoyKw4T9VZfHUAu060y3t60mPvr?=
 =?us-ascii?Q?UoHR1xozFpRrcbyoOKZIUepjJFoSIUygJwSZs2A/U3xOioMY4w8HngvfCz4J?=
 =?us-ascii?Q?G+7+W4tNxcnRWdhlJ6UEHBu/k8g8YQc+wkJtZ+ZJmOTnGzW8vft5M4HOlAGv?=
 =?us-ascii?Q?f6shiwu2lrQubLoppz1NY90c+IomfqPamqg10S3KongD4rJbknnies/2RX9A?=
 =?us-ascii?Q?BQgqj+BWgHIVTaznvTN9qU25yUZdml3iIWgWY5+xWJP3FUrB6wH0v6TzesYT?=
 =?us-ascii?Q?GsOG7Lrhe35DAa/+h4mKp+yAwRS056pnutxbSKYH3iQ2RBqM9AYruLeayu8D?=
 =?us-ascii?Q?L4fgN9AGiFRbazA28kFV5iDdS3sHUhBB10HDvoEI6h61jDd7agg721TwkIxi?=
 =?us-ascii?Q?Fem30wy3Efotlh4jAhswFcs9x/aQcxHkfTcqPfLPxu1GW8LjPZpAqBxgNYyU?=
 =?us-ascii?Q?+sEmqkV44i/7Vz/kWXCOQ6DXDTtZlDGXWiWTkdlcZUuqhA1LhiMg33OZ0G9S?=
 =?us-ascii?Q?S06X6T4tvGJ0jOuP+ZVwY34E3HUFny8h7uc6uKUBWxVRQja67i4ZpFi4Shx+?=
 =?us-ascii?Q?x5E7/oGlWZZfmd8iJo+yCIgzfQyLvKEGySXuQwHLED6rjdTT8e8ubpVjFYeq?=
 =?us-ascii?Q?0wd+Fti3LcG1p9mgcfwqxoQEs/qCX53qOXFGS3fvHvoz8u0CK+aP1XqVl/gd?=
 =?us-ascii?Q?FEensyZnJ6eLEdftRyuFy4GjlFWfGe8u1ObC+SOVrNx1e8XAPN0cwIbGJHkH?=
 =?us-ascii?Q?9KHoKq+ZyHfyciolcJV9pEfb5b4MOaPTo7LS4fpa/FYZXQ1z5MYUHZpNfxUC?=
 =?us-ascii?Q?FOkFGMuHt/zdDLH/Ht5RsdTlMczsu2MgVc9H2ADR4UWn9J+iCVfe3NV5A3/m?=
 =?us-ascii?Q?IdBQ2uQfrJ7yQzXrpfMsF1jex42W8g4i5T7urjG20XeA81t0ZPP3OB1ZjGWc?=
 =?us-ascii?Q?o5i6zmXm9yYWJqEdMrs9fvSO2nljGbFAaQk6GPaZB6tr9NWoX9ZcQHEa55cN?=
 =?us-ascii?Q?2w02T/pe0nPansLCeJ1IinmkY0HWh4cpvKxTA2cVHlG9hIMHoLbHT4a2IcnW?=
 =?us-ascii?Q?0vtTY4qheiPngaeSEKoZpPQTzoBm2N5K4xpJtM8Oxm3Vu41/B/E3fZsgR8ku?=
 =?us-ascii?Q?W3B6c+PUGBeJOGlgpsmeawI1eMmRaj9cTotW29OKUiJwFzNmnEi5TIabhUCs?=
 =?us-ascii?Q?dx7enQqN0d0zP8UzmTVwouVzEj/GBGN6UQ7hKlfJREsgFf8zXP7K9g8lSsjP?=
 =?us-ascii?Q?v8JCUjlFj/ygb/LZxrFV6KsEjrLS6H+MY2CbMKU0y5IyY9pHEqGFVh4fOxpE?=
 =?us-ascii?Q?eju6fTFrX828meId6++WAbXAuxB9Hjo+da1naScQSh15FnKhEu9bAK5EktxX?=
 =?us-ascii?Q?tjzb8of2rb4/OBOaceGtODHNDDfDu9ABFULEmtsEERKpnawS/trZ+sS8jfYT?=
 =?us-ascii?Q?/1OKp8BIZK9+y+PbUJFe8OyzVT7biR9OuHszofSYjVITLnRU6IgvqvshRUyz?=
 =?us-ascii?Q?c2qwDewd0KH/AJTLaNuI3ytBKPkXNC/a0V1PKDIHag6uVhKn8N6uoNeYW1YO?=
 =?us-ascii?Q?XIJcvhZ3nR7RDer5zC/yI7MNhQbAQ/z4A+XCutdYVaNRqGBgvVKQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aadf4eb4-ee55-4ef4-1a6c-08def32bbaa1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 19:57:07.4940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdAgjCJtdBF771jEwg0YAQKsf8un5Y4TNfGr1vaaf9M8d0N1qad/+A9iHtbgH0oK9PDGygPCP0l3h4ENFAqyqaDnLAJvHXfFmXBxVky0xO75r78fjuRAysFSNMeVwJ5C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9149

On Tue, Aug 04, 2026 at 10:13:01AM +0000, Akhil R wrote:
> dw_i3c_common_remove() unregisters the I3C bus without resuming the
> device first. i3c_master_unregister() ends up in
> dw_i3c_master_bus_cleanup(), which writes DEVICE_CTRL, so unbinding the
> driver while the controller is runtime suspended accesses registers with
> the clocks gated and the reset asserted, which hangs or aborts on most
> platforms.
>
> Resume the device around the unregistration and drop the reference
> before runtime PM is disabled, so the clocks are running for the
> register accesses and the state stays balanced.

common driver already support i3c_master_rpm_get()

Does it fix this problem by set rpm_allowed true?

Frank
>
> Fixes: 62fe9d06f570 ("i3c: dw: Add power management support")
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260728071757.5B3CD1F000E9@smtp.kernel.org/
> Cc: stable@vger.kernel.org
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>  drivers/i3c/master/dw-i3c-master.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index 17e1dd4fb5f3..df542ab7744b 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -1723,8 +1723,20 @@ EXPORT_SYMBOL_GPL(dw_i3c_common_probe);
>
>  void dw_i3c_common_remove(struct dw_i3c_master *master)
>  {
> +	int ret;
> +
> +	/* Unregistering the bus accesses the controller registers */
> +	ret = pm_runtime_resume_and_get(master->dev);
> +	if (ret < 0)
> +		dev_err(master->dev,
> +			"<%s> cannot resume i3c bus master, err: %d\n",
> +			__func__, ret);
> +
>  	i3c_master_unregister(&master->base);
>
> +	if (ret >= 0)
> +		pm_runtime_put_noidle(master->dev);
> +
>  	/* Balance pm_runtime_get_noresume() from probe() */
>  	if (master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)
>  		pm_runtime_put_noidle(master->dev);
> --
> 2.43.0
>
