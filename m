Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010065.outbound.protection.outlook.com [52.101.69.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74324657E5;
	Tue,  9 Jun 2026 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017783; cv=fail; b=ewZtlALL28AUdnbRfFnGq73LguLF4zngzCNif/VLj7Pv5olhPQ7Px3VH4e19dujhtwfVHcPW0mvOAxFHP0fyd/FtcJXov2Ripay0PiUgAGmVUILusrUMCn27drBTd9GOF/sJt9CAYfjsRlcW3OLL+tI3ezirJOreiqF1AKM7fnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017783; c=relaxed/simple;
	bh=Kk2FyDxPNIfBYQ6Ln+pPoYidnncWNg9ilBiqzquD028=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E1gKbKJf79XdDolcBhzsp7MVOT1ycTTLI5/rzQjpK4VNPCCamzsqWHX0K7cPzAt5KuKpVhJ46BnEXp6lwLJ21W0oJfNDS8wvI3PTM3k+wasw6XlAvMh3/MzjEM+0nV2a1D1XdZGk+odYxh6y2xIBWqGLy+MauDBpFeQwXOEWiTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=d/b2QOHJ; arc=fail smtp.client-ip=52.101.69.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="d/b2QOHJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtyvA/6EMm8RO8OyBOZvXXWInAOBU+HkMgxO0bzh+MAnIwLp0UNkNZUGJOmiuZ5Ojp+ZqvO1XHapBxJZU+XhyqEIKlL8lich+fA7KRKxuK0jW5qdQ1mWBmrh4EAerGEP7xJV/AHwmZ+EPqQTK9D280/Os9AKAIgR3jWDVr/y6atucWKs/pHJev6vECP9njRRKK/9CR4ys65Jq/Bdwc9J2DP6PCiWB/7gbSJPqeIoRuurZQq6RJSEgbo5+Dey6oA13AElT4sTXsFa6TCjxtOgwGjSsIxKQveYpRpx0fK6VT1oM6WwCNja6I3tIicxE2VQy5Us8L/WjknPo+NxAytZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3EvHfPfEgaxy20YgUSnW4NVbXF+8ONiAjCdl2IaDuQ=;
 b=LJx8PbI8ffKTdzEoObXOx1IqO6JzElU4HLMFSChwuZVYc+izo/QXLx3hhW6ifqy3ljrFRbzAHcCMOgl9f2BfBpQln0iqGlIsKhC1FcZtk+5DPz/6lYAGAQyaPgrEKr7oXcn2mASf99T3FpexRA98W0oVff+dyYYhnxxgluXITikaR0f/bcLwztF7H9/sCu7o+F/7Y3OlTnfRh6LD8kaR8FVzXlbszYJoHty1jWybYpJ2J4Z4uMp9AaTYh4wio+OBH95bxuHbStjZOeRmfCoj4WRQJRUr7NYT92OmmPetq3zqLe0zjbCbOmqH0ilI//9ViCX9fRQDyb0pMj+RC3GIiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3EvHfPfEgaxy20YgUSnW4NVbXF+8ONiAjCdl2IaDuQ=;
 b=d/b2QOHJqwBG7XCYhb6OKGO9DjnZEZbMvUNDPKpFBGyWRz/fUxUubPSGmXwaJgXczHhkb+pvTyvzQjsPj0jQuNq5sO224zjIYQv2TpUh7E9qW3LrKsRozh0tmPPsF+iDGb4HPJAaUuTI/RKDPBqW0m/Ne70DlW1RbASmZdIfHsx9ZhJR4EJnWE1DTrGUB5Pj+gtkSL9xO/thF9TPBlJyNJN/U+SFpsFKuIgoD1YwGyjRu6X9HV3PotuBlmVOdfrC6oGrgCVqgOhslTC0YyKfBxqJMUV1XRmUYJ2FWavT4atTL+NEEDR4j+tVcYV2b9hhOhHkV+9ztPezG3vZH1Kcfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI2PR04MB10089.eurprd04.prod.outlook.com (2603:10a6:800:227::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 15:09:37 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 15:09:36 +0000
Date: Tue, 9 Jun 2026 10:09:27 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] pmdomain: imx93-blk-ctrl: Extract PHY as shared
 domain for DSI/CSI
Message-ID: <aigsp1VYu1tE6AFR@SMW015318>
References: <20260609-pm_imx93-v1-0-d06c004b0f51@oss.nxp.com>
 <20260609-pm_imx93-v1-2-d06c004b0f51@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-pm_imx93-v1-2-d06c004b0f51@oss.nxp.com>
X-ClientProxiedBy: SA0PR11CA0072.namprd11.prod.outlook.com
 (2603:10b6:806:d2::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI2PR04MB10089:EE_
X-MS-Office365-Filtering-Correlation-Id: c27f076c-6210-4165-1d80-08dec6391ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pAsODAbELw5LpTnvI2Pum/Wrh76WzAZqZbi4Kjd2N/L0HZqCM4OMwd/9//9MQj8yN67z+WrAY0b7psvaNjHblFYzjRY5ibKP5XWXommxP99cUmCkbOsWwIfTZ4sRgCevjXtQ35bRzORwD9pV5WZeoaTZZfuYqU6W+/XtMJQ2TiQ+ip5i8RUKXt+I91Y0NpB6hMAehB4oXJN4yU14AmmQqwW8wX6LncK0RlNO+0KxtuBz13GyFyBaxPTVVGaUiSbLenFih2EdYg4hmWymfULQ8JVKq+gQ6ZqiFAcjcgzLBSdERcMHhFtQCAg7JfB3Mgr2MC51JG5teWfyfpllI5cfdMSsyC0um6F++dwD3212eqBEDZhnueNemdEBAD5bxRCcgGAEaPYqCkbA60kJGHxqr+BfxOH9UXbt1zC4sedjGaGbOr33kx+bWBLYm7eyAm4CaQ5g+M5F8BtbhP513iBfGSTO2O26QWn9baAsn8TzniQrapz4JR16NKo4CD1pmdoYEDDVP5ZFpuXGLAEQlffC4/wBxf97LO9uAc1KE/X1A5mQ6qj0A8GBJ8zmZnKXrCYjtPaZpqXQ1cjuBF+CMqIxFQbmU3FIRrzCDny2Z8IHmEu2nivSB1vtPPvykSuVlKJq6RS5QA5qyPV/BiwozGd9j3pkn3+zJEvynTy7IajZNlwtMAFzQ/3dlI2/W5riGcdh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lyRIQBQdlnjOEwt8AswPYTNCDkSuQWpQjzskuvABN61s/u+ZeM0VkH9doIyG?=
 =?us-ascii?Q?50U9oWHZM4dFqQ8Czki4yyKgGJSD/Jslx88tzsM4F3jykpG3TgaBCy8mpyuo?=
 =?us-ascii?Q?+HqluIqcPKv2C7ia1JDfadknW5+CFG9RYYCFrJAOmbKtt4GvdEzTeEQEZgmd?=
 =?us-ascii?Q?53Z/YEucDgozXuMHZ1aLV5Bl7lSzy2vZdaYSkhUX5Aahu/2MrdJS85GA8eKY?=
 =?us-ascii?Q?77EHyeLLsAtiF+CxbCyqsqdniPlKj1JlSE5uTBqg1zxcS2eu0y4KjTLc8AaD?=
 =?us-ascii?Q?3qHYrYmAKyJPMzQ/Q7LPu07Rrk6u3xQvBoHN4dYwUaauLJSS2FxVIjUUb8vy?=
 =?us-ascii?Q?VEHlCme4KrCl8QCb5Q2h19gSnpi+gL+k8YFErbM5fy1bGkqstQFDJxchB3al?=
 =?us-ascii?Q?e/Xg4I+juYe9xL+ocWTAoWBBma6C88nbyktWHm3CkraOfDjvJU8P5X2lC13M?=
 =?us-ascii?Q?WreKow+gDnJRb251SE1MCPfEki7/5u4BhaCto8iVmW5FY2nxbmRbiw11bbOh?=
 =?us-ascii?Q?zkDWTxs1/5dk/tt3iWbyaU96x3EmMJrUaZJTjKRKSZ8RdFbcqa0oYrnTAyRA?=
 =?us-ascii?Q?y2z6CpYq4p7NrCNsuLesmES/JCev1V4VxbQb0r3XwNe7OhIg0dlhvaj2IwqS?=
 =?us-ascii?Q?5FVQG+aDszPSjxQVUW+D+50CBbGoHyZk1kpOaMEi7M+U9dFSe2iO60mzxK0M?=
 =?us-ascii?Q?SgcrHt4TUmYtGMC5NWNWyQ66ZHcVI04/1Cqu459MgshDp+e/wxfw+ZU5/fgQ?=
 =?us-ascii?Q?/lKfI8l73CYjt2kslO7w5T3CppuilLcTBOIMVIUSv2g/N87k8MKOAQjLr8ys?=
 =?us-ascii?Q?nf16Q7D0cSUI5PFea7LkmSLCsDtz/cnI1qaVi3e++FO/m9AUF5+CkxeYmeum?=
 =?us-ascii?Q?JZsEcV/o4HfynZWCuX1fv4EqcqASev3q/kvHAhCCVhZiVkK6J2x+DWo63nMT?=
 =?us-ascii?Q?c04EHyxcIy1Odr9unLOls3BznrD34Stcj6eYWHfex5KAj5rIflGu0vg/zLLr?=
 =?us-ascii?Q?w+upEdvQ2VoP8shyXjJv9ul+dNPWpMsVPod/9JFpgLlPtJtmnYpJZd7DTJlQ?=
 =?us-ascii?Q?oFM7zs1uPY4UFRLCzrgrWp+ffrnb4pp0+nme92Z4mB7pw/4/qgxSuaahBIZj?=
 =?us-ascii?Q?WehNPi5YcHp3g/MUw4+F7B4VR3ewJbGd1Ja833vw6ePlmh8Q0JKUSPN4QvAX?=
 =?us-ascii?Q?TYevfHq4Gq+Hc1bKndYBEFMlwP3LrIPpWcrIG/Vxay6WoXQ3nUv0+YFTINf9?=
 =?us-ascii?Q?wjX3OFijNKF/J5vqhgcyI7rbYp6OX44RXuOmG3E+F3ox16YFZsZoqXjK4nyH?=
 =?us-ascii?Q?8VCNl+6AVbr4m63szM5EWOGHFiHft2OkpjyRqsAxR0vw8R9WoUNFjlKBZiw8?=
 =?us-ascii?Q?W6J4Ooz1MXf+LplKsAIc3TYQVb32YFkqYVOTzczjKQn8UFRj2Ie0bMZhJWu3?=
 =?us-ascii?Q?u1jJ7Vvq7Ktgvto8Uqhh5F1Q/boS5cU4b6IRS3Aog1Y4QizH+oIeX0LsMOWr?=
 =?us-ascii?Q?AXl59k4pTccNExRcSVEfiUI5Gl8jH8hJKGMjUOnSOG0+czc+FXv4JQ6draV5?=
 =?us-ascii?Q?QhP7Uxshu28mSkvAmtBoG3t37nNOQ5ieiHDUe734Ah38r6+rl/C3fQBJOQdi?=
 =?us-ascii?Q?ZmkjMMmxeY6Y0mr8Kz56KZtJpx/xGG88uzQ3VZsQAA8BE44lJ5rd1R8fZ6lS?=
 =?us-ascii?Q?ckR7zv/I0w/eKGzQJQSX5rBUF8gm4SwcPe8ARfqfUjHIeRZO/OcDhLQmlkwm?=
 =?us-ascii?Q?tB/v1A5qetKDY8wW3azj36RsZwwcD7O+O2Qwl+dxsjlLn45DlWXR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27f076c-6210-4165-1d80-08dec6391ed8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 15:09:36.8378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1pwm3tDUW72QXBhp+kNjhAx4WawhAI3Mrw9Yt/Mv3BntkkfY85fjB2r3Xpef3uPYvmMUZ/pfkVE3l+8EIkGfe9IEIgjx75+Wf4pgYHOUq2gma3/U0R+3cD9+zjbof57
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10089

On Tue, Jun 09, 2026 at 02:26:41PM +0800, Guoniu Zhou wrote:
>
> The MIPI DSI and CSI domains share control bits for clock and reset, which
> can lead to incorrect behavior if one domain disables the shared resource
> while the other is still active.
>
> To fix the issue, introduce a shared MIPI PHY power domain to own the
> common resources and make DSI and CSI its subdomains. This ensures the
> shared bits are properly managed and not disabled while still in use.
>
> Fixes: e9aa77d413c9 ("soc: imx: add i.MX93 media blk ctrl driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pmdomain/imx/imx93-blk-ctrl.c | 60 +++++++++++++++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> index 1afc78b034fa..243ce939ba68 100644
> --- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> @@ -48,6 +48,8 @@
>
>  #define PRIO(X)                        (X)
>
> +#define BLK_CTRL_NO_PARENT     UINT_MAX
> +
>  struct imx93_blk_ctrl_domain;
>
>  struct imx93_blk_ctrl {
> @@ -68,12 +70,18 @@ struct imx93_blk_ctrl_qos {
>         u32 cfg_prio;
>  };
>
> +struct imx93_blk_ctrl_subdomain_link {
> +       struct generic_pm_domain *parent;
> +       struct generic_pm_domain *subdomain;
> +};
> +
>  struct imx93_blk_ctrl_domain_data {
>         const char *name;
>         const char * const *clk_names;
>         int num_clks;
>         u32 rst_mask;
>         u32 clk_mask;
> +       u32 parent;
>         int num_qos;
>         struct imx93_blk_ctrl_qos qos[DOMAIN_MAX_QOS];
>  };
> @@ -203,6 +211,13 @@ static void imx93_release_pm_genpd(void *data)
>         pm_genpd_remove(genpd);
>  }
>
> +static void imx93_release_subdomain(void *data)
> +{
> +       struct imx93_blk_ctrl_subdomain_link *link = data;
> +
> +       pm_genpd_remove_subdomain(link->parent, link->subdomain);
> +}
> +
>  static struct lock_class_key blk_ctrl_genpd_lock_class;
>
>  static int imx93_blk_ctrl_probe(struct platform_device *pdev)
> @@ -302,6 +317,34 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
>                 bc->onecell_data.domains[i] = &domain->genpd;
>         }
>
> +       for (i = 0; i < bc_data->num_domains; i++) {
> +               struct imx93_blk_ctrl_domain *domain = &bc->domains[i];
> +               const struct imx93_blk_ctrl_domain_data *data = domain->data;
> +               struct imx93_blk_ctrl_subdomain_link *link;
> +
> +               if (bc_data->skip_mask & BIT(i) ||
> +                   data->parent == BLK_CTRL_NO_PARENT)
> +                       continue;
> +
> +               link = devm_kzalloc(dev, sizeof(*link), GFP_KERNEL);
> +               if (!link)
> +                       return -ENOMEM;
> +
> +               link->parent = &bc->domains[data->parent].genpd;
> +               link->subdomain = &domain->genpd;
> +
> +               ret = pm_genpd_add_subdomain(&bc->domains[data->parent].genpd,
> +                                            &domain->genpd);
> +               if (ret)
> +                       return dev_err_probe(dev, ret, "failed to add subdomain %s\n",
> +                                            domain->genpd.name);
> +
> +               ret = devm_add_action_or_reset(dev, imx93_release_subdomain, link);
> +               if (ret)
> +                       return dev_err_probe(dev, ret,
> +                                            "failed to add subdomain release callback\n");
> +       }
> +
>         ret = devm_pm_runtime_enable(dev);
>         if (ret)
>                 return dev_err_probe(dev, ret, "failed to enable pm-runtime\n");
> @@ -326,8 +369,9 @@ static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[]
>                 .name = "mediablk-mipi-dsi",
>                 .clk_names = (const char *[]){ "dsi" },
>                 .num_clks = 1,
> -               .rst_mask = BIT(11) | BIT(12),
> -               .clk_mask = BIT(11) | BIT(12),
> +               .rst_mask = BIT(11),
> +               .clk_mask = BIT(11),
> +               .parent = IMX93_MEDIABLK_PD_MIPI_PHY,
>         },
>         [IMX93_MEDIABLK_PD_MIPI_CSI] = {
>                 .name = "mediablk-mipi-csi",
> @@ -335,6 +379,7 @@ static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[]
>                 .num_clks = 2,
>                 .rst_mask = BIT(9) | BIT(10),
>                 .clk_mask = BIT(9) | BIT(10),
> +               .parent = IMX93_MEDIABLK_PD_MIPI_PHY,
>         },
>         [IMX93_MEDIABLK_PD_PXP] = {
>                 .name = "mediablk-pxp",
> @@ -342,6 +387,7 @@ static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[]
>                 .num_clks = 1,
>                 .rst_mask = BIT(7) | BIT(8),
>                 .clk_mask = BIT(7) | BIT(8),
> +               .parent = BLK_CTRL_NO_PARENT,
>                 .num_qos = 2,
>                 .qos = {
>                         {
> @@ -363,6 +409,7 @@ static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[]
>                 .num_clks = 2,
>                 .rst_mask = BIT(4) | BIT(5) | BIT(6),
>                 .clk_mask = BIT(4) | BIT(5) | BIT(6),
> +               .parent = BLK_CTRL_NO_PARENT,
>                 .num_qos = 1,
>                 .qos = {
>                         {
> @@ -379,6 +426,7 @@ static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[]
>                 .num_clks = 1,
>                 .rst_mask = BIT(2) | BIT(3),
>                 .clk_mask = BIT(2) | BIT(3),
> +               .parent = BLK_CTRL_NO_PARENT,
>                 .num_qos = 4,
>                 .qos = {
>                         {
> @@ -404,6 +452,14 @@ static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[]
>                         }
>                 }
>         },
> +       [IMX93_MEDIABLK_PD_MIPI_PHY] = {
> +               .name = "mediablk-mipi-phy",
> +               .clk_names = NULL,
> +               .num_clks = 0,
> +               .rst_mask = BIT(12),
> +               .clk_mask = BIT(12),
> +               .parent = BLK_CTRL_NO_PARENT,
> +       },
>  };
>
>  static const struct regmap_range imx93_media_blk_ctl_yes_ranges[] = {
>
> --
> 2.34.1
>
>
