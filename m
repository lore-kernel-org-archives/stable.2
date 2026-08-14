Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011050.outbound.protection.outlook.com [52.101.65.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA1346A07;
	Fri, 14 Aug 2026 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734760; cv=fail; b=Vgh6vll577TdVn8ZVWF5zfF2Z9tRgx1pmZsuSn+xQ0Yjo8KueQS1UpwvCbWPSATsLzuU1nmVEJgkThj9AFUxCDYyKNKakpU2Pz5QIPB+HATqRS1HVhs9tKhXTHv6iIetNdQJuhW92fz56VstavRZ6qdHO5FXkj0n+2ByM6zIsTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734760; c=relaxed/simple;
	bh=9t54OnrVrTJp5U4AA4Xc8Y+0Jn0rGQCPUXNPImogE4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N8iwCRzlddfiATW/Vf1AFi+vFRJSfyOvCdvp1YZD2vSJCOlJ0dtXdPX4cG9HYWde65CXCm+Z/zoj2Ci8Gein6YGz2gwwKwhsvllQs+85F0adQ0SO4RC5wLww8eLz858EFl+zgGKiiRyrVGp3z5UmAQ0mLeRo8iWgS0zRHBhrnRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sOihlhYO; arc=fail smtp.client-ip=52.101.65.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sOihlhYO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7FrX+0yeplqUHPESF0B0Rn3RO+WvQURsWtLFboSAieBQ5KhMlWzcWoQK8YcE27eKe4vy1YHTTr+XXrokYqM8eJ1xu7uibucee65ZcJPfaR8od0ZeoaaNtSDHJiJRKDNYZTzWeEMJxda3wR4q8UCsxTy3S1VaakBZQK53GaSDlsEelxCVZwIb2uiJ+YROBr6n7gpq5A9oRsDu+xXzb+YGDKMT3Kq6Lb+MT8O7hMos6rrpl+XrqWbjHqZ87IbwJ+krIIPk6NoqtAeDo9yhVnQU6Ryc7OH8eZFn+hZBAj9Oc21GfV8xnKMM2/bbhDIhFcoXfE+30/TBymaibM4G8pYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Kj1XzaSx60wd/EWSGfJNg5MAZkwm1MmqAXTaN39Wmk=;
 b=YNRHLeVZ7hdk2dxFRjbX54Pg8WLaK6Uj4FVGNdKzuawTn4IkgwMvZCcxYI2qaIxaoFS4BMke4u99n5wDCAN10vZFD3XF8R0c0J2EVxPyiSqexsz0r7nzDh9hdQLiq39rYLuKegVdnB7X5O8HyqKvW1l3BW8ZYqsE75BPzJK7cg2RQsAqXrjGKAi7KEryYxaZSvWS+s68AiIBsF7IB89Aq8qWTRXFnmXLtbNN7OGi6eyPa6MPz/GANBBAcfZDJnlfZdbEZsyaIJJx7qQrtGJfGANBxTBssdwic+yx6i+NjHPkyjMaSJAau707yYVxVWMnTKe/5qnDsnurXT3J0LRcRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Kj1XzaSx60wd/EWSGfJNg5MAZkwm1MmqAXTaN39Wmk=;
 b=sOihlhYOaxv+I54nXdSdy78XiFe8sZeiCH5xX8SKwAQ+ikobqQ06U2BzzTrGplJEE8y1kkgqbpyVhwn0YD4d+0+v7rPwCwg4XdEaOIew+t2vrsZejdGXc9nTXd0ojHO6x1Ym/FHXhlAwxokCH75zzp89giWCpuzO6HOIEyOf/ZivEPvQLJl5qm9LN5oQ9IXxXWHXKpI2pdyqYqxWI5r68Gf73oEVtXtlVH0FySVqXZZdGgX/0gUOfHq1pLqYaymc8lwg7XdI83FfjHPv8IDwaoCQLMIw7ze1Vx9rg92miG2t224ZUmvWeixPIgP+ZGFkxKiRIlLz7mvhu3lnjZnQjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB10949.eurprd04.prod.outlook.com (2603:10a6:800:26c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 19:12:34 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 19:12:34 +0000
Date: Fri, 14 Aug 2026 15:12:25 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Abin Joseph <abin.joseph@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: xilinx: zynqmp_dma: fix autosuspend cleanup
 during teardown
Message-ID: <an9omZerM77tgWXJ@lizhi-Precision-Tower-5810>
References: <20260808115228.2798481-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808115228.2798481-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: PH7P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::13) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB10949:EE_
X-MS-Office365-Filtering-Correlation-Id: bd828f1f-9555-41c0-6ad3-08defa37feda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|19092799006|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	o1u2mUXmWvzexsYmY7sZBnw4o0YAU00ZnQ99O0x90UJS6/zS7FbQ/yyhQlWbxeL3h4+z8Wcd8xBhI7JvJcPbaPmovMWWrTPFaYMkddaGB4mp8tsoWezlp4FrLwyRSrWlvNhE7y2aLJYFFfsg1oOtgThg9cJzOXGXdcIMWUkDEzvnwRL2VyLgX3JxdxOsdYZ4uj6Zv6wqpFxHYMIVmHCpM1F1COyp2lCsaGhMiwVX3jp2NMDqgcRyhYZxJZBp3TbtwIIVbRmPeokbMoATuncusQaFfDGJ5viO383Lt19nocDfBn7E/miksN+eA+AmCLMAtE9jqhN5f4WMOSLfI2XER9bgZC+xzLwInxMjd3BBfd48pEr8J6kcWLPqngtqNOUNYFIzpy6cVBadAQ14mCOzUrrja3yBpS4o/X7Pp21XvLQMdehXlvc8OjH1EpEUGxpfdOWxynsHiozloVtsvj8BwRQeANMw5dVWYu2MzxVpEj9XIETv3IY/2vOPPMilXZMxVKXcf/hEVu2NvM51YYIsN0Lj7CVDqVG8aQj7QSsqQ/om90HjXwy6jIUXr/1vioPpMETpY363eDc5D9Abj8VGLNERBS7SjhfALYWAE26axB+6rdnAmLa+Oyg3cz1oH4ldRd5xgEIYCvdXXZGwEx2fyrMR5jLkv0LM84WG2UlusmQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(19092799006)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FOqq61Ukq7MCuWhKn2jsjGch85oRrvnTklt0qXGJmNv2RD59w9jgA7jpp2ZK?=
 =?us-ascii?Q?LxlrWCuGkrT8GFOG90sT5vbP08zEZs4RoKdNEZlPmPsspZ6FYV+3mdKY0cgb?=
 =?us-ascii?Q?iWR4EiF+le6jzE5Ya2X1SXR+4kHV9xpLHP+vJrDPKmQmlKp02WEVhhF2KPIk?=
 =?us-ascii?Q?NAZwOzOiAh1M/OqcdDi33zH5f3/iHVqzrFJX2HwUED5X4lHuJ8nfyJeOEcnF?=
 =?us-ascii?Q?Znna7hFQxLtBv6FfAeLqkoYWgVUrkxl/AWB5fNLG6CYofnVidGlzMfR9fWoV?=
 =?us-ascii?Q?vc5wqel+4eO1e+qGFPaAPAU9ItUVxpuNNRQJTP6kjqrntPNFPi51he76hHbq?=
 =?us-ascii?Q?f0TxhjLlDMpZnKKWzdDpCAEJOAxlR5C/wFpppA/zuqcmS6RUzCtd5njKe8+x?=
 =?us-ascii?Q?VAk/TRaOVgH40hd9mylFU/SQIX9CRH8iS4jVtvXPAn6fn/5UIV9ItyK3qPPl?=
 =?us-ascii?Q?swKbV1vG1PnX3Dg85ivSXvwDUwcbpkt0Lcz1O8LLO2jmB11Zk9UO9UaZiUtH?=
 =?us-ascii?Q?yknGnXUGrLgLVfej2hOtAEftbbWbTqltjRTNjdtzldQTIEbnz3+zOk2W/RPk?=
 =?us-ascii?Q?MDz8d5ceJzj8/YYR4Jea2mQ97zsKujTi5ggX4dBKx/QjCbQnlNpSMrfNmsUJ?=
 =?us-ascii?Q?SkZEUOZu8xoYq5vPzBInQceC0osOjcondBYaDXGGgSJEF4IOLEOB456uv25j?=
 =?us-ascii?Q?KxGUhAYooSTR3d/Rf3UQ9CcB81iqTbBzJS43jLCL2YtMPDGttgxZeea1jjnm?=
 =?us-ascii?Q?lh1fYrfRQ1C9ShiEJ6VmTkpWypBXpZ8IpTxt59Inw07ZhbHnUU0NWfAOvRw3?=
 =?us-ascii?Q?uKQ/AsWXXOq4dXpysjBJkufuDXHeGcbP6wqteCleT7Ac5X9Ae3hFkMVVPf97?=
 =?us-ascii?Q?C6ko7Oosr5NHrEpx0jygRaUnLmCTNIalF2ATs1/FQqQ6zYd4zVvkUAXm9DmK?=
 =?us-ascii?Q?rHU4NhyU9THCsczKIrOctC+pP2Nv0Cj7nRxCgnqLsukQf4aqNlGNNKs+b0g+?=
 =?us-ascii?Q?mJnq+Cio6jkYbYtVvg+d8yr1XIbYxGYq4Kr5HQBxmFryjvpe0sed8VOyDoTT?=
 =?us-ascii?Q?/qOe4OMGwRzTw+evC0j0x9sgeZ9sZnlli1gnXReupvo8R6d/z7SoV4ASNRbN?=
 =?us-ascii?Q?tJ6L/Vxd76o/LECknZOeMcvGr8ngZZJ5NolRoiFPtqcnoTsWKiBsZUvier3a?=
 =?us-ascii?Q?DjoAFbRbCfSbeT9MZ35DbZjGH1tl/c8WahQzVQh3trqCTVmS2SD84jxKzrp4?=
 =?us-ascii?Q?QxX5FngxYxQep778AaVY3cTgPZ8xLi7QwZQ/SZCCx+AkzXTA2ikQyzVS3Ytm?=
 =?us-ascii?Q?fdUNdCAvNLU0reG2/MHqhGnjhnyLELel7E0QP2fC6EVxBVOZCNVBwnrDBUU3?=
 =?us-ascii?Q?Y5PTSi61D0eNdxpqQ3XvcUNwecfmbTjej6NUFD3KJQntHa6FLgiXzLuRPgzz?=
 =?us-ascii?Q?NuCMGMgOmYhx+HekeRLti6gHxfRDTm7M5wycs52dfQlx2xVdkfIVayQFGAS7?=
 =?us-ascii?Q?q/vR8NjirY973K4PoZdRmgUH2oB0lpnQ7662GlzPJj0H2lEeFNAdBqi4eHHG?=
 =?us-ascii?Q?9W5srdpO9mZd54hlZDHpFneaoP9Xbz/gZP6ua9Ny/Jm6jQGXp4QHcn3WrsZA?=
 =?us-ascii?Q?1UvIHWocpjqEE+4zMepiYW2Pv5DDpQW/6JuNgScWUyb/YnuiZA+DI88JPC7W?=
 =?us-ascii?Q?dyZpbddhUmsgjxXBXDJRf0W9Qk+Y/5Z5JXNy3sW/SIrj3XJiUkKRzLprcyBk?=
 =?us-ascii?Q?UqWsSKvLYDfRgQdqc4xoGhE7r8MBAEYl9G+ipFQgECJRyGUS1rtG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd828f1f-9555-41c0-6ad3-08defa37feda
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 19:12:34.7507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akVn0N2oYafUvYhbD2RqR1LD/ZdlqRFkwIZr/z6ayf3D70T+RMEBph0nkTU2HHs/5kj8+HNPptRV6V9FXFSAhSarFZFSLCnm/2o3FL6Atrw2DfkivHcQHxwc3D7Br8Mp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10949

On Sat, Aug 08, 2026 at 07:52:28PM +0800, Guangshuo Li wrote:
> zynqmp_dma_probe() calls pm_runtime_use_autosuspend(), but its failure
> paths and zynqmp_dma_remove() do not call the matching
> pm_runtime_dont_use_autosuspend().
>
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during teardown, this reference is not dropped and usage_count remains
> unbalanced.
>
> The documentation for pm_runtime_use_autosuspend() also notes that it
> is important to undo it with pm_runtime_dont_use_autosuspend() at
> driver exit time, unless runtime PM was initially enabled with
> devm_pm_runtime_enable().
>
> Add the missing pm_runtime_dont_use_autosuspend() calls to the probe
> failure and remove paths.
>
> This issue was found by manual code inspection.
>
> Fixes: 64c6f7da8c2c ("dmaengine: zynqmp_dma: Add runtime pm support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/dma/xilinx/zynqmp_dma.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index f6a812e49ddc..635c3f6cc5c2 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -1116,8 +1116,10 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>  	}
>  	if (!pm_runtime_enabled(zdev->dev)) {
>  		ret = zynqmp_dma_runtime_resume(zdev->dev);
> -		if (ret)
> +		if (ret) {
> +			pm_runtime_dont_use_autosuspend(zdev->dev);

Please use devm_runtime_enable() to fix this problem, auto tear down already
include it

static void pm_runtime_disable_action(void *data)
{
	pm_runtime_dont_use_autosuspend(data);
	pm_runtime_disable(data);
}

Frank

>  			return ret;
> +		}
>  	}
>
>  	ret = zynqmp_dma_chan_probe(zdev, pdev);
> @@ -1152,6 +1154,7 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>  err_disable_pm:
>  	if (!pm_runtime_enabled(zdev->dev))
>  		zynqmp_dma_runtime_suspend(zdev->dev);
> +	pm_runtime_dont_use_autosuspend(zdev->dev);
>  	pm_runtime_disable(zdev->dev);
>  	return ret;
>  }
> @@ -1172,6 +1175,7 @@ static void zynqmp_dma_remove(struct platform_device *pdev)
>  	zynqmp_dma_chan_remove(zdev->chan);
>  	if (pm_runtime_active(zdev->dev))
>  		zynqmp_dma_runtime_suspend(zdev->dev);
> +	pm_runtime_dont_use_autosuspend(zdev->dev);
>  	pm_runtime_disable(zdev->dev);
>  }
>
> --
> 2.43.0
>
