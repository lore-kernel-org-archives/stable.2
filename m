Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5755A382385;
	Fri, 21 Aug 2026 05:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787290026; cv=fail; b=JSKbqoCMzPLBM8XLD2vVw001E/9waRKQ3Kjn4YDr96Vd/awuLwrVnAjrb0AxeQeFUDDXWLq+npI7sNuS4UDjbgpX/LBph6on87M6J7st5+fMFxIBwAekBO4bDWvbuYa3Sv8W9+smVQvKAaX029GrpyJ9PKvvP+Y+si8B2+XPUnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787290026; c=relaxed/simple;
	bh=eJtKrqLrsasCJIIjVVH8HHKxBZQr50/sg1VJCI+QF1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lKSW1ytIvXO2clsJi+0uP/ipVHqp7HRf/rOk9E1Fd/umEUQOtHEJiPp78SouGnazjm0z6pIdfLi4ysYuV6WP1VWN82OPndC4vKfcpnViRTAdxKGGgK0OorXcBPhtjEYg6DAohAMHBHyPPjjS/XYn5yM7NswC0AAWfpHxJ7GYHak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JsejO8pg; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JsejO8pg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPnw/LYGxhNuMULWO7Hj7JBTzY+tq38qNVokV4QcfQztyNAVOWa87ACmJFIoXUC/fXYSEfV/mlfoA5gYtsFxkSsh4sB8lg4d+MUM2iS3kIjnLfq8fWxwYEmFDN+Lw+EcTr/VRUuDmrAxND7VsT/TtrfJa+c+4w9cu/VhbaijEQsgjfTS3ecLunCVn7zfp+qn+1kMA0DfjKNhjBogEkjC9er2/AV2DXw+eN2fmkre8LzT1SY7oq3C0Xh8Guz5dWmUxsBz4cv4HXZyZBzPI6wEHhWpojJmC6VSGL6NMSRufwiRcReGljYAMndsS37dwMO+p0QLhxJnW+BUBNAQIdTozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBq63GOOFsF8cLySDm08wKi3d7HM3jPQBSLVy3lhl7M=;
 b=w6f46DElugaL3oHdGUk871qN17O0MnRdYsCH7NG9CzlOUdNIxeQlsJdpOJizOxE1e8oH2m1wS+IamGJjpCA9jfRHJRqrXWq5aZltYcDBlXSjUf0558NQ8XZ9Tvd61RLbYn0gQcoCIMuZz/VzeBMuFmLWpElRxujoCQHd4jA2zUOM72geqXP0wIZbPySd6X9H/xFPuBdc2HCJWTh0WtS6VKXaHMLCyEKVuHjpNlBYU+2Or3Qx+IdmE7ajlEUPpJ937vi+o0uPc0K4wiF4VQK7UvztnpaGeqdnsJdwp/XHHIJUUR/Vpk5tvmgXBO0JcjFqvESIBR7hO3xsuXnVAtGSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBq63GOOFsF8cLySDm08wKi3d7HM3jPQBSLVy3lhl7M=;
 b=JsejO8pgjam5wcE2wm52Ac1f95+iLrJp6J/yyh5sH19HNUqyn+wsXGDyRwBTD0AJ/8un9JfmoDieooSsH92fnNOUhfof0escx1cb4AORMsaN8Bj8MiN92rXd62ABOjNfE5BTymP6bn2ZJU+N6nXfBIjQ1Dd+YRheNwwJIf9WjlCpjuU7h9ghid8nWQ4UrsO8KdVmoRmSTOxMdC9xOM9f20xNoUOZDUZmbW0UWtjaHtir8RbUAB89SJHAdzPnS+9JMOVMvpdH74Z4AeeBVFDSZKBrL1jtHU9qo6a7OCCjPpFP1ImlkDaWPEPFZ6N8zhCN6gKll37WCh4RIVsoE5bxew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by PAWPR04MB9936.eurprd04.prod.outlook.com
 (2603:10a6:102:38b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 05:26:58 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0339.007; Fri, 21 Aug 2026
 05:26:57 +0000
Date: Fri, 21 Aug 2026 08:26:51 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>, 
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/imx: dcss: fix autosuspend cleanup during teardown
Message-ID: <iqr75sl6j5g3lkfoj3jeznaqsm55bl3qciwujivwm7mvgefvil@my2gr2rrsqcz>
References: <20260808122354.2825209-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808122354.2825209-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: AS4P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::10) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|PAWPR04MB9936:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3ed1b9-14b7-4c8b-356a-08deff44d1cc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|19092799006|7416014|376014|56012099006|10067099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	iTUo9vllusC9hgWP/FBNJhDrCox+n3L74WraGd1RFeRAyzFF3uNJfz0xfQ2ByjxJmJUcC7KPPkGXPTVw6NK9ydP+kfLcgVgVD4QITXBHDD0PP/LILyU2Zo4DcvsIetU4fD76k8laAKTFJLNfh+tsyjLwxV6inunkWl7XmSatqFgKjEzlhg+u0RDlUy7JL3gS6F2rFKvjpGDrsPaIhSvA3gQVwAoXC60017GWhs0Amo17HxDJaxUeOYsSx7TwritHKvskWRWmxl5yXP/Sl2R/SH7sFfmAGrEqmFh2ZWlk1NgBgZryqjYjUySg/Rl5KV9v2KPRL8sKhtn7SoXlfH2/kT6Yc+WJbxn/EII2k+lxQ73xqWtXAPQcfdIz8i2fd0zo0d0nrkR5/0kT8/tbX7M8Zj5OwG1vW9avYgGMMMKBUn8rmuyp6kmj1ed/1FX7eXELwlW+VhwSXQdBMBrSNpsi0zwAqu2PAis3OYU/YzOIAqBMNvndDQWidr9Y39OgNRZItBzigKPo8NhLVzB8JkivkkFNZbWwDODteguJhN8pATYhY7lmXNdA02sET6CMNWNtzAX9jZBP44CfC1OoY8VclcIOls5EXeSbAxV+d5Kt405s6TroT8HSUUDR2LCoEKS42GoazoMzA0+N8emUzmgwNMImueER0uOsU++UbGpvRLo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12318.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(19092799006)(7416014)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X1I8f+aeVM3cAWqi8AOUFrOkf++10YjTSA0cwWHuO9wlT8z9SEltxymBH558?=
 =?us-ascii?Q?lhfSrrkm9oDjWv7Uk7omPjJUjuHqugKnivl3kiBmS5dzPvtbOtRIJM8zJ6v0?=
 =?us-ascii?Q?CeEqY1kGRwoucIt/UcwMlFtQ7sMT/XLqzTXRV77J58zPihfQDiqkSxuz4nc/?=
 =?us-ascii?Q?ZMyEmUCV87u0ei0UOY7BWzqTFFaLjwZQiou7KWEsO5IaXwykBqpL6t+VtfyC?=
 =?us-ascii?Q?gzTajONzK51PEn+gypz1vTrlyEvcn9HywLGNq3djy7CLWeGTlXI3FNeEnQR3?=
 =?us-ascii?Q?gliU8lkVb+tdBXHye8XAGoNrYTV47tuU7Fk63kg4mkYATeeHmx124xGt86nZ?=
 =?us-ascii?Q?XfmdbkOJSDfYesnXMNNcjd6JjeCx2k41pJA713jRPcA7i4c4vv7zDYv9xhVO?=
 =?us-ascii?Q?gdZ4D+Wh6UrWHUnKeaLOIRg8omZwGp5cWaII3X59v52gexPRWnNaI8WS9kJG?=
 =?us-ascii?Q?0K+ji1DOjjmNb35jazKNxhWoWIuaK6Gnzb+lvGmE/Nb9Wr6WkeSuU/3ieaWK?=
 =?us-ascii?Q?ExGPP29Q9qqWKqlN+97d0EhWrdodWIjVYJwwVMLGgpo/WJtagyitV/363Tqr?=
 =?us-ascii?Q?D0/b/5FrbFhtTUkYhNWk/Yp3JunvAbhS1f+RNx4MDKbbDS/IeFZYhOhbVtaX?=
 =?us-ascii?Q?839IJQxr3Q80VLDb5ft2GsDwNJiTQIo/iJfMqiD1++NlEcfYzSXpZ8X7bc2h?=
 =?us-ascii?Q?Q3YQamhfc4b5IBQD/4xKx9qjZtt5LwpKjsE+DXUwdmBNxXZE5SH0vgLUs50o?=
 =?us-ascii?Q?E7ARQ1g4VY1bLDD6ZIO5q8O1xoMSwB8utYzokK15jZ/zo4APJ1rPUgvKLR1Z?=
 =?us-ascii?Q?hOVrVXKuSwu+qe0SeRJVWGqpLpc507JDoKAxMQgiPV9oqFO0wq2/lF+BjGc0?=
 =?us-ascii?Q?1vzkNrEdTt1Dulft5dSY/dj7CbKl07C7NF+RNeyMV2qxGOVu+G5/ZVLWNcK7?=
 =?us-ascii?Q?HHPsE/4a50WVChzPURCC6TgmJfCGnM9oJVCzw6kJJFBOPg3TUkweFW6nnllH?=
 =?us-ascii?Q?i4HDVucbGstIqMe6Las45QosispMYOfpireWYA132a2zLiUZ+6tHnxqNlXTF?=
 =?us-ascii?Q?4drXTSWyAigpV7wSBfVVspNdqzOlZCVbvUtYxGs2HxHL9KYh/c8R34GsYCGk?=
 =?us-ascii?Q?dnJLV/g56juOHXyaUHTT73tck4vhS+4BUCbBl+bcoVh2EbktJO5ZiPYR5hVt?=
 =?us-ascii?Q?VhNCo3igR4l4579p/J6p88tsI7G1aBSKAFfvyNhrUd2VwXvt6YG2eciDOio0?=
 =?us-ascii?Q?FDRGQi0tUvn7539EpeRJxvUAeQB1P6fTx1WtY1tXyP82SdVsqrqzAcMcbXzw?=
 =?us-ascii?Q?Bk4Vck51BFOphIzhFsCCWsl+7W5qbykp7KP4M7HdHXax/MPdYsKJq4I/on3n?=
 =?us-ascii?Q?hruiYcHOzYreXCAvdS4pMgsiq9VB1wpitAxRpHCwV1rZPlN0mRDUGAXIfJxe?=
 =?us-ascii?Q?89Z4mFwrsZ+fkoNwA0NT35ZD8Jh/WPf04kmeOX4ur39tAwwQLZRdCJkAH0OL?=
 =?us-ascii?Q?u4o9/PSmCC9eOtHQ4iIvVs9627cS/F55ucKbYlU4DtdJvsT6sMNV+CdgPGRk?=
 =?us-ascii?Q?w8LNwPVRTSeeFxBmRdVRg6tn+ukuHDkHjAET4fFCqIjO7dED/EhMieDeoShY?=
 =?us-ascii?Q?5pftfOG8eV59G+BTzS/sUOOO/UgbPAdBN8YFrjmZnksVkTD7HTFugWmZRqoW?=
 =?us-ascii?Q?sPToKucfzsKEI2/N38wYnfsmYKDmlac4FH1vBi2FKhGHNTpBK4VCnx2kbVII?=
 =?us-ascii?Q?gLQYU7i3aO7/c4VoCK8E/gEzB3gf04g=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3ed1b9-14b7-4c8b-356a-08deff44d1cc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 05:26:57.8478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPOi7LJjvQQcKtQdit3CJttEpGq0I7NlZ8VcWBV9RiSdde/SpTe15LkwLO35CZSUvfMLcqJ2WL2AJDqLw1bJCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9936

Hi Guangshuo,

On Sat, Aug 08, 2026 at 08:23:54PM +0800, Guangshuo Li wrote:
> dcss_dev_create() calls pm_runtime_use_autosuspend(), but
> dcss_dev_destroy() does not call the matching
> pm_runtime_dont_use_autosuspend() before disabling runtime PM.
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
> Add the missing pm_runtime_dont_use_autosuspend() call before
> disabling runtime PM during device teardown.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 9021c317b770 ("drm/imx: Add initial support for DCSS on iMX8MQ")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/imx/dcss/dcss-dev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.c b/drivers/gpu/drm/imx/dcss/dcss-dev.c
> index 7fd0c4c14205..51398852cdc2 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-dev.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-dev.c
> @@ -240,6 +240,7 @@ void dcss_dev_destroy(struct dcss_dev *dcss)
>  
>  	of_node_put(dcss->of_port);
>  
> +	pm_runtime_dont_use_autosuspend(dcss->dev);

This will call rpm_idle(), which will call dcss_dev_runtime_suspend(). So
you'll end up calling dcss_clocks_disable() twice... :/

>  	pm_runtime_disable(dcss->dev);
>  
>  	dcss_submodules_stop(dcss);
> -- 
> 2.43.0
> 

-- 
Thanks,
Laurentiu
