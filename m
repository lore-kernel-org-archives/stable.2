Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14122432E97;
	Mon, 20 Jul 2026 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560189; cv=fail; b=FNjaolN2AJfROil9D/0flX6+OdNpAZjL5f/MaXO2ixXTTa5ei+rNlWDFIQWyUgxQq3r7vYvKnAe/GrPbvwyFcECSkbzygTgukK0quzTGvfCHuqjZBRvFyn/0sv/rGVoVt+4LkZlj0I447annQH7LvaAVsuruA3c8JyU7Vxzpi6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560189; c=relaxed/simple;
	bh=EpRwP/Q/5ziFA2HCDqoefkBxsjUfCpZZnCLhUkrXkSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eHPof5gtzrHSVf4BHsC0j6loAduKTocACvyh3SmzBK7+vkWIPsEWGXzA5z4qaUttUNWke8hvZJNZSAhgnimoLrpsDWqGjcE95Zax5M/KkJxvRdyeJCTn4Tny1nAHJXNhXBqOJbHGs99hwg8xL1zgOiQ7Jps9iZiJT1o/tnKKPD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Pw09Wcmh; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Pw09Wcmh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvoMh7lvneVM+A5vNG+JN21XYdP/rC880YHIhO7aUKlysFWO//SRDAj0O5++bi1iX7WymkvUZPeKyNqS+t+tr3diXvNIqIWtdghmHDqxFmX3LTCW2UPUlEi6FUEDlf+qvJhMHHBgP1ZFhSAO4KmWhI0w2YhlGLULKH6PzDTuSREzZWtStU8611JTOz/vwi5+G2WpzYJR3Yq2+iDH2+UGFb8IrawaZZznrzpNdNNh43L8oF7EupBvM0s/f9sc66gxVKq3yLZAmGWPNq2+ziKXtO0TSzjLK3oHwVxHFd1NaMry6obJaASd7G/fg27JfDhLKZybzCNSTKr3B85sHn49Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2qrkOn8lR+mg0m8yQSXJVw1kY+B7jZVD0FjIpHlZEs=;
 b=u1W6OYZ7ooxKtApGFxGDpFsJEsC6TMcciDBM52TjsBOfswTJw4sYUqC3mIGkL539jwoI5sSPeFhKHyepcX4IUvTBOB4n098DNQm6zZEUZvwnLRT5Swma24NWGwovuJochZYRu0jk7Eo+xVSlIg1QKUQQLlrJGvPFaemngUvv6Z6HVHrhFbF9e8OKpODUvGUycj674JsZTv2jmTzYdc8hJSNs+mGX24hx3AcMNHBRoioTfMgJ2dyMbiGgD+fQDr2gaUrdsppflVhkIOquvTsbmvVpcta44bCtqfI+s8thsSepu5ph2M9HKunEU/lRBrZL9pEu2tSSQADnuZ5PTCoCag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2qrkOn8lR+mg0m8yQSXJVw1kY+B7jZVD0FjIpHlZEs=;
 b=Pw09WcmhDwX3B8KjyPZa+RK+x/ls4nPXIbwRAUe5xkWjxuPhY3E7A+YfgMJjgGyyHPyvzlHodDAXtmFero77hPHLcJ0sk4JoAPtsMkuvc9knQq+2HlZqm/JwDkOmZ34DDjzlYNRYWxnPpQNJMNctMB7RmUdLjOSs8nkRRgr26MFE+/V050rsggjGpSMpL14mREamL1wXim43keEzA8i+lTDW8i6S03NjKdeEeRnIps9BPri2tomHYnllcAsXs1zcBaZCDDqj3ygHV1+90S04ALRxh7m/cZ/q3SrDZmKwo9/ntwGG2O0w037fTYSPeuW+gsGXJ4M5dP9hDHVJjUimEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8006.eurprd04.prod.outlook.com (2603:10a6:20b:288::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 15:09:44 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0223.012; Mon, 20 Jul 2026
 15:09:43 +0000
Date: Mon, 20 Jul 2026 10:09:33 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Christian Hemp <c.hemp@phytec.de>,
	Stefan Riedmueller <s.riedmueller@phytec.de>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Guoniu Zhou <guoniu.zhou@nxp.com>, linux-media@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/6] media: nxp: imx8-isi: Fix stream ID validation
 bypass in crossbar routing
Message-ID: <al46LcL-wo5_-fhk@SMW015318>
References: <20260720-isi-v2-0-45845bc5d4fa@oss.nxp.com>
 <20260720-isi-v2-1-45845bc5d4fa@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-isi-v2-1-45845bc5d4fa@oss.nxp.com>
X-ClientProxiedBy: SA1P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: 9612a5eb-eb85-4df9-a6ca-08dee670edc1
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|19092799006|376014|7416014|10067099003|6133799003|4143699003|3023799007|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 c8JV0Qok0tdqjXNK+BsoTdxDZx7BlA0jIWhif0MSfLB0rlroiXn9SEhXcb3A30CxTkEW5NyxmDCx+3jxkZ1bvv7WXc6xnI23PdrJKd1D4BYrlXoNs0bDcWjIDSpzQd9JJzx6zY6F8NbtB16N8yNcj4bFJwHcxxklFAiL45fGZ2UQvFcytiVkfLSRd4/XJTgdcgBHpu6UBVzjmeeUKOVYI9toDFFiNQdT7VvBJq3jdqTNWo6LBDu4UFfAWaS4yk+tZ2S2i8q55nsrwyzhJj1PZ3B7Z/d1QCIrAX0Ax9PIilfUFBKogwQMwuXx++A9Xi/4XuQkgz0U5PxH0j3YP76g3OuVXkfva67jrqncSCUt9qlizWg4dE+XRPruSwSvNAqst4m5qCPAk9HGYBZNnN8219RmwJ0/09SVjLln9gQiPH24guwaLtD4+CoY0D/h08hBt9pIcoPqCIgdeLyz9JTdgZXzDrkXW9/Yz0u7tLng0kxyg6ELmCTOhm2fAgXexSW2EKt348xOiCqdnBgXiTVX+HvS6eOf2Tmgq9ij24Fa5m55UXbhphPhrqPSoaR/jFPKWE+CeBtW7z3xIHhFJh5lPFIKKPLAXLDzpLuUpnNThMSFChteGWfHtGOtOp70u5E53lgt9vSMTiraC/KIUzOsv8/FsWys7PgTrMuoE9OCnDU=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(19092799006)(376014)(7416014)(10067099003)(6133799003)(4143699003)(3023799007)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Izcc38rmCrqaA4tC/WWkUGTiABdJLfgLmfMghKXxLs9pUd2kP5k0CRpA6Lyl?=
 =?us-ascii?Q?vniBosAXT4L6XTzHfLMoa4G57eNvjq2SMGcGW6w/EZaqaaoEfs6QmTcjJnlM?=
 =?us-ascii?Q?I5UZH/8XqJPiVyEV7jRQj5qJDMshimR6eHmePd2qjvDDgj2RUJvaU6J4jxzX?=
 =?us-ascii?Q?/160EKlrgrUu3eTRyVy09yJ2DqfCJyk2N65hG5D53OqWlCW1+wVmZFK/zMuy?=
 =?us-ascii?Q?TQAVr4ec2r78GX65EMZflKQ0ylo40iSzvmkTNHcpOt0EcF1hxOQvH0l96Xzm?=
 =?us-ascii?Q?HYhTvelptjfPszwYwRuxLpDoaZurkH6j0A429oEfoNV+02IuDELV3+KUSgnj?=
 =?us-ascii?Q?OBHQDgQaD4xpkUB3w/NBpPB1dbLlZmrjrJOUP2aRlabzKxEVgv9BxMnwCUfV?=
 =?us-ascii?Q?2jKKu6vwK54VUmX3fk9f72j2eWu4Lzq2ZAcTZ4Il3brBfHOaJuy0KSFMIzgo?=
 =?us-ascii?Q?rDkV2Jp3VUEtlSy/7W2wyhzYMI8bJpDxhJEPbmm9UCHb6uQ+1xuMMmof4Vrw?=
 =?us-ascii?Q?6F5d25PwLWC+rQcHs7XQfkJBlUK2k8xKfYrAfNMrRJxDRn2UniNSseSejo9N?=
 =?us-ascii?Q?IgEdblyDDHn+2cZZNMFgoQ9OK3kGh0CCIBsD40bxucRMh17/GpDynZyuW+wk?=
 =?us-ascii?Q?94fZTy2d1MLRYvCehBRvzyRY+sAzUObCWyhlhcjywBM/1Uqc1Ub/CJKv3fD5?=
 =?us-ascii?Q?FWhXd8DiQFQn6XxQBw0kd9tKxNBWTnuHKW70EN4cnjGNQ/sgqp0NWjPuou0O?=
 =?us-ascii?Q?5Jhyzsd3j4g4OdJnFbg+Q+zSkiax2VPlkwRhRvAKFGqdkEkS7gigD0LOwvVQ?=
 =?us-ascii?Q?QKLULwbxiDYkjvlnL9V5TX89Dzo6BzzyuDLoHwfbomVzy3eJploXziZGlDlJ?=
 =?us-ascii?Q?DHU7FV+Ii2D6toXMih4rWMFN4G8o7a2rdMhD8MeL1MssCvdPeJ0FRnCo15Tl?=
 =?us-ascii?Q?5wFpbCv6t9nHIlbkjYUbfWeaKZ75apV3xZZpKE/Rcppt4y49E2oFJiAIAFPr?=
 =?us-ascii?Q?OBpyIOqTne4f/nA9KgLYswGptK4NfIRBW05kLl1TxxyE/U4V+Vg8AmP8WSTl?=
 =?us-ascii?Q?PYYYb250YHqVmq3AWJ+4HAyCHsqWMpNNOLVPWLN9ySPOKYC/P3VxPlIobcwE?=
 =?us-ascii?Q?WWAefE5PVeiZCfxmK1a58Ca5VvRBY8YZRsLr90CAaapclWr1qILefuRRK8tF?=
 =?us-ascii?Q?FRSXONH6Wpo5GW4pMhvJZ0Dm4h1OZPxq8PzzdY1JMYrPD+G20z6Z7/zMkgWd?=
 =?us-ascii?Q?wJI5jOEe5o8u0RW4i9zU30GFgtNgcn9Ek+6JffSsW0BCYezkt0n0bEO300m3?=
 =?us-ascii?Q?1qpb5q3dYZVfDks3j4E/FsQJ11XIOseCgf/punc0//9rDNOMFI6M/KXprQ3M?=
 =?us-ascii?Q?DwcGrehuMJoG72eKteyFm76sWH1UAZmdO/vdZc7hkBBkR3aAjYb1YErbaHM2?=
 =?us-ascii?Q?sCA/fhgnvvCmo2srYtJq2IqI8Esfvf8q5n8ARzQEaKSagQrYxXAx8x6Ffv+X?=
 =?us-ascii?Q?73br4UNNY7r1Vlbrs26KXGgIQkgINtVYXN02I8T8V35WAQWw3U3uXVc7y5tK?=
 =?us-ascii?Q?5GlDVLUhXO4GHq2/zKY1+lI0dYiL6MIHE/SH/bNKuf44wcBhARk15mklAHl1?=
 =?us-ascii?Q?9MSB2FpPZ6YBnA7nGK2Zpzq7BdVOMXyD4qeKPJvd7I1S+OQNMiyS/smfwvFC?=
 =?us-ascii?Q?TUHU3V2wHOc5TH8w6iaV42z6OCEU38MU6OrzC8Ybz5Zu66ep65IzByi3JAKH?=
 =?us-ascii?Q?ufYKNMj1A50S51kTzN5xKS61CVqMTfgjIGflqspTt00lZWDRCviW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9612a5eb-eb85-4df9-a6ca-08dee670edc1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 15:09:43.7163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: py/BvqV9gVg2nwEFr2pVOw1Rzq3eWh3hLDDkMTqOXqoBQnNdaTzEatSqW0ZkHNo2x7wf55r1QWACo5uoyypcIwtcyvJ2ibmziB7h/c0cWibULeP5cBuVTEkOtvqGRNQk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8006

On Mon, Jul 20, 2026 at 11:34:03AM +0800, Guoniu Zhou wrote:
> The crossbar routing validation has a critical bug where it validates
> the wrong routing table, allowing userspace to bypass validation entirely.
>
> The __mxc_isi_crossbar_set_routing() function is called to validate and
> apply a new routing table from userspace. However, the validation loop
> iterates over state->routing (the currently active routing table) instead
> of the routing parameter (the new table being validated):
>
>     for_each_active_route(&state->routing, route) {
>
> This means userspace can submit any invalid routing configuration and it
> will pass validation as long as the currently active routing is valid.
> This is a security issue as it allows userspace to configure routes that
> violate hardware constraints, potentially causing undefined hardware
> behavior.
>
> Fix by validating the routing table that will actually be applied.
>
> Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
> - Split v1 patch 1/5 into two patches: this patch fixes the core
>   for_each_active_route() bug, next patch adds additional stream
>   validation (Frank Li)
> ---
>  drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
> index c580c831972e..84871bceb31d 100644
> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
> @@ -107,7 +107,7 @@ static int __mxc_isi_crossbar_set_routing(struct v4l2_subdev *sd,
>  		return ret;
>
>  	/* The memory input can be routed to the first pipeline only. */
> -	for_each_active_route(&state->routing, route) {
> +	for_each_active_route(routing, route) {
>  		if (route->sink_pad == xbar->num_sinks - 1 &&
>  		    route->source_pad != xbar->num_sinks) {
>  			dev_dbg(xbar->isi->dev,
>
> --
> 2.34.1
>
>
