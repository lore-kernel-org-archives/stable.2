Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013070.outbound.protection.outlook.com [40.107.162.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C892944780F;
	Fri, 24 Jul 2026 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905610; cv=fail; b=h2wsR+MM2O2cJSuDuWcmtHcSCf3PR5A1k3GNvflrsPXzYHyKNc+MTTWJHRpbfsz8FDfTTNjq1xZfSPnZ+s+6x91/7ZQpCfB0bTuxhMbtreOkodYHTr3EleteZD/GliwkXL0ZbyEBRMBrvSgnCENYPdOKaXpu7ZIBRqve4QWgSuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905610; c=relaxed/simple;
	bh=DzeWda64dq41xXj1ZsIR31SKCWaRB1ziXpOoK9WgrBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o4gf4p45vq9kYKeX/Enkf6POvvaHTd+t2c/6MSjlMvBgVaqrv+MpoQUB0aTzRdMLDeYz5GXkOUOLDOvWaymPRSqRXLL7dR5fXdn/tXfacdPjq8S6dx6uhzhdmwwgaaGcG3pc5vNRu1Fw0YyFo8y8cFkcAE1ZZqsBcKsP1XR72cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gtTf0rlT; arc=fail smtp.client-ip=40.107.162.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gtTf0rlT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilVOBMyb4eiOLOSlQZYVk/bMJz06929WdKfCcif8KTCuo4TVDCoVHfcMNB3EzzXisF8GTYm9NgbzqLZKlY0tmbKSwkNZrhExnHrth9oIjIbNET1QzmNjBmtE2zWlAnRk6Csm1yBG+Cpx8HLF5IFnGYXO01znEWhP358gc2c/S/S0hqmX9PdasnH/PB+0v9ky1Lsb7uyp/iWXpAAuZGuwxKNPkqFz6opjeoZ1Nlq8MXK0hXYE3KtsUZ/3DZSprJjw5n2X3hG2o+biVDefjdpmIexBQIjJmob/Ufnk2Lp4HvRDZox6Zp94TqmznsdkyFN2l5mIl6DsJo52kwmSk/xgDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ns6So/MR9yYoUkMg1aaBezx1YokQRKtUkZ/9H5qCgh4=;
 b=oEuUWt6XRVKZe5oTiCwkrrW51L5Iw9DsqnHmvl7SmWOxZz0bSg4LDV2izz4FV9FW2ZkMsIF1dM2fl66Wueg8vCLLvFWlfjCqDB2ATiIeGtYvtJ2XsgPyxlZnayVVIbfnAznLeKGsAihsPlLobw4HRft2shwWtJdjocrYZhooy7i4Pg45/1FWjFL4NoTobtn3appr8TFKUnjlenZpVv+vrnGINsubVIkV/BmvBekOX5M5ss22fScQSXmEkpYzJCE3H+MQ2RJF9J7JcJ1m56YoHpTEmFZnkWphdp3+M+MPgy5pJsJRBa/o++28jW1WiGlyifk+YTrBVpqWPXLzELOqMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ns6So/MR9yYoUkMg1aaBezx1YokQRKtUkZ/9H5qCgh4=;
 b=gtTf0rlTMuT0krsQVeqQL+m2Q/EIzRQQ1StIZwye0xYK0aeNc+LcZp0IWGqPlcoV875Rolre4jGb9LKtfqDoUrGUKwZtgocj5PatK/CsGHL7xD6vihAwQE+jR5XK1JFOXOsj86e2VL2bV7z90em+JMreIxDOm/kqrkxDNvubUq2BBtAtQnygw/79kG7W0r8Q8g7xTu9cD2RLexJr3VlpAEHXXu0aI4NkeHIPRoruLdZwpL+GXRWblAn5xM2O84MhSqHsULYM85T3YdPLx4kOe+9zlnNGhRHHCGl1nGoxH03KG0Oa5QZpf9jQvXrCd3n8nJsg5/x5bJgN8bnXJjGSpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB10870.eurprd04.prod.outlook.com (2603:10a6:150:20a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 15:06:37 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 15:06:37 +0000
Date: Fri, 24 Jul 2026 10:06:29 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: raoxu <raoxu@uniontech.com>
Cc: samkay014@gmail.com, sre@kernel.org, imx@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] power: supply: pf1550: enable charging when battery
 profile exists
Message-ID: <amN_dZj1p4KWcawu@SMW015318>
References: <D5A5255CD2B683AC+20260724090341.297438-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D5A5255CD2B683AC+20260724090341.297438-1-raoxu@uniontech.com>
X-ClientProxiedBy: SA0PR11CA0043.namprd11.prod.outlook.com
 (2603:10b6:806:d0::18) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB10870:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff43a4b-7aa8-4b6f-65dc-08dee9952895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|376014|1800799024|366016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ymT7rTjrPlJ2TCFBIAXXJxRcw+vjofxhTEDvkBCarznXqVWdiD00OBDXVSpm2sUEIJB+nM3vUSzH7vAEXUmKwdWOOeZg4JvTCX2qiCdY8h7KoRFKoYM5kvc4AC7sVD6Oj3mQ3E1ZJzsZbL4QH6j87i2MYw/2hw/rcNK8Y3i+jgYFRjdpxJNmBFJjZJeAmxMxay4WHYbYJWSJXok8lPDbYYpV3o3vnON1vvFlvr5i110JTbZULnJ0H7zCiXcvHfBXnbpRaGb8XA5tL62BNx4HQ0M/Ao3d6LWrFqjZIYzBDNJFY6ymf2knwZmPaLCVEfGZsnf0es9e4guSXiPifWHyHWqai9GrlqAK8spbZNN4s8WfmLIXrkjKnPhUy5d7ojQ5yONSWibbTkEp7msJtyTc4uulN2ElA+FhUJVrY07W76BOATl/GdsgJCSVs8GXUSc4Zmc01zX2WuKIYdK6wDIVtrjJYRP+xxxiW41Kjs6XExNZNySPGxu1Qk7aPY6UhsXh3h2LHhBq4LXJIsc8GJ7LDOAwJCVtzbsSt3gPBOyXbiZI1q4vg37HUbQ85NL1Y6h46ycvJsfRxaAG2oRRQpVUeHbiScquYI3Hnq1I0qysl91LB2da7FLyEF130kHJFSK8cegkAba9gwIXgDipytR1oc/4Ms5bBGgNfvmy4U6Kj0A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(376014)(1800799024)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vJd1Ih6Eqk3y0dgS/5/s56Q7mcpRWgws8xwKPxYXXtOe8cZhennZFGiOsUII?=
 =?us-ascii?Q?XNKFFnOe5Wu0QiIV774ckFLiQl39ufU2qHr50u+sNrPrMOHHsGtZ6cNtIGYh?=
 =?us-ascii?Q?byWudUMuhVe2oM/EUJ0wzVNzcZHV/QZ7IODGsAlrpqwtnG/DZZUm1BFoJBJD?=
 =?us-ascii?Q?RvlLXXzDMVpBHO5vUq7btmzOJl3aOqCvnLayVlu2trJoWNCmYtv8ML6a0xis?=
 =?us-ascii?Q?49HRrzjR6hFZojE/CRrVXTl3s9isnzmGVzJiIs8pRK57vIYJTegD820B/csW?=
 =?us-ascii?Q?eCufCBIw3jdMciIGyabbMB11E6fScZ2oeab3Nl6BAfMt8KF5423L7LQF+Kae?=
 =?us-ascii?Q?fBrt35eVslfQS95ThxoFA52n9i3sj8fguZrrPKD44x/yK7Rpve5cY/z4YaBD?=
 =?us-ascii?Q?B5SJAPRbkXvQim/CpdBexhKsD8yhDVKRFlUyGNqhvPTsL7eHatV2ggyCamcn?=
 =?us-ascii?Q?lsmmPk9omQl9wwKjvA5zj0klwAjuruNXWqKDjJLeBnNQc1sXrPSG5KlelD5Z?=
 =?us-ascii?Q?RQ2l22LMb8hf0LUCod5tp7E8DbQRcCGkfLqb9xtalZ9iu1aUKkItN2WnpPi0?=
 =?us-ascii?Q?iXLUnd2pdIbhe127MixCknh3AyRmdlfEvGCcWBDWkQeqJxGOrUJ+fEVGbJoo?=
 =?us-ascii?Q?uVx67IDt4TkA+LoTArYlP/t136ehlX3JnngaDXPQ93WEXjK2V8zr5CN7u72R?=
 =?us-ascii?Q?LNEpp0ec78MBkN/TYWYjz9umAjz6CnWYoZymF81Rfh5vMX/txSvTZQsPugR5?=
 =?us-ascii?Q?4B9jRtKx5cg6Vt3r98LI8VP1Z5D2v2CVL5dAFcZLECwJC5ixFAWt0Q/sf6VT?=
 =?us-ascii?Q?UwWQWnFQrnA0QuioVFhXCyfFjuzth1C/TR9NMYbd0OJB5KCFBWNIgHRqdsJ1?=
 =?us-ascii?Q?6esRnb2Z1Xwu0NFQGVqDi+o8GnWudAOpAk2YMkONEKmb0wXx0CyFMWqshCcP?=
 =?us-ascii?Q?Dm166L4PCYiihRTFf7lzvt/afcL2UrlJtOZYyyk63lCCOdwz6EoJQq2x2T0k?=
 =?us-ascii?Q?bn/nOtY1O39+IT3PivQo94BlyM1wpJXCJ/q5SfdaDT2Eyixuet8h2emBQ+IS?=
 =?us-ascii?Q?8SMGQx1NDhQ2vMkd2On43dEX8GWucflev1O3MkjKiBElTy9rqdNYRvYuM2cT?=
 =?us-ascii?Q?o/tmuHascdU61+WYJzfUl9vRgYsJcn5KhMz6j0WQGvTKsnuRqLBod6IQ/FJK?=
 =?us-ascii?Q?4yiFo2ZRqcnVpOgkLUckcJSLISW4GF6CI62QZ9xfF94SwCSwOIlplrzEUzG/?=
 =?us-ascii?Q?J+QqP17pL1Tu0529eHj3ixSlRm6NGKi2JmxdVJwbc2cs8CS+xQLpfMJc/dI2?=
 =?us-ascii?Q?kWxc8NKFYp4uGsrWCePx81DElUdSaoqEgWIOlBY0QgiIhQRX6CpQHCtRP5rX?=
 =?us-ascii?Q?NkHjH4d4d23g0crb/MGBlqeXZURCR0fAw3f9gWoCUSm1a6MKlhPZOb6u1R7y?=
 =?us-ascii?Q?Ou+H+GfTtJKvXRSVsA/El71cv80DQ/cXYEAo/32y5PhUsp4IiBvahz/lhlO5?=
 =?us-ascii?Q?Guxx2mF7/K6YP+6Q9cNCJtPdB/5g00nzjv9D7PbiJ3XTg603Y5Zw8GRiEpk5?=
 =?us-ascii?Q?vFgz0DsUzWihKgGgFidNuCi8TrvGFiuBfrYiib6U+wGAtxyadI2eM5eY/Glx?=
 =?us-ascii?Q?hR6j/RSDqACecdz8gL4hpM5xZaFEfYXyAzXo0qoou+xrPGyyOGUC/eNpU43c?=
 =?us-ascii?Q?kCyEVlftdt3GrK9uMFdpGl4WiXyf93upVLczu5EV86YYWktxjT3YQULHNf64?=
 =?us-ascii?Q?vmINsK9wEE2O5iEkPLh3DFrY8wpJeqWuOXny89vMOXm//bWfQiC9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff43a4b-7aa8-4b6f-65dc-08dee9952895
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 15:06:37.6140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Muw2FJJCBNsYUkXAeO6cObtt9E2wMCHom7WW3GZa80rGFxjMzM3iIyOF5x3oJDxdFbI8c9YTscwdpteAEj/jHuFHEWuu6DajzpN5Ct/DW3y52zvwnQ3GJN54sdO0zDAl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10870

On Fri, Jul 24, 2026 at 05:03:41PM +0800, raoxu wrote:
> [You don't often get email from raoxu@uniontech.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Xu Rao <raoxu@uniontech.com>
>
> PF1550 starts in charger mode 1, where charging is disabled. The driver
> comment says that mode 2 should be selected for applications using a
> battery, but the condition is inverted: PF1550_CHG_BAT_ON is written only
> when power_supply_get_battery_info() fails.
>
> Consequently, a board with a valid monitored-battery profile is left in
> the default charger-off mode, while a board without battery information
> enables charging with the fallback voltage.
>
> Select mode 2 when battery information is available. Also release the
> battery-info objects after use.
>
> Fixes: 4b6b6433a97d ("power: supply: pf1550: add battery charger support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/power/supply/pf1550-charger.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/power/supply/pf1550-charger.c b/drivers/power/supply/pf1550-charger.c
> index 41036f4cb64a..f698becd662a 100644
> --- a/drivers/power/supply/pf1550-charger.c
> +++ b/drivers/power/supply/pf1550-charger.c
> @@ -514,7 +514,10 @@ static int pf1550_reg_init(struct pf1550_charger *chg)
>          * a battery. The other supported mode is mode 2, the charger is turned
>          * on to charge a battery when present.
>          */
> -       if (power_supply_get_battery_info(chg->charger, &info)) {
> +       ret = power_supply_get_battery_info(chg->charger, &info);
> +       if (!ret) {
> +               power_supply_put_battery_info(chg->charger, info);
> +
>                 ret = regmap_write(chg->pf1550->regmap,
>                                    PF1550_CHARG_REG_CHG_OPER,
>                                    PF1550_CHG_BAT_ON);
> @@ -540,10 +543,12 @@ static void pf1550_dt_parse_dev_info(struct pf1550_charger *chg)
>                                      &chg->thermal_regulation_temp))
>                 chg->thermal_regulation_temp = PF1550_DEFAULT_THERMAL_TEMP;
>
> -       if (power_supply_get_battery_info(chg->charger, &info))
> +       if (power_supply_get_battery_info(chg->charger, &info)) {
>                 chg->constant_volt = PF1550_DEFAULT_CONSTANT_VOLT;
> -       else
> +       } else {
>                 chg->constant_volt = info->constant_charge_voltage_max_uv;
> +               power_supply_put_battery_info(chg->charger, info);
> +       }
>  }
>
>  static int pf1550_charger_probe(struct platform_device *pdev)
> --
> 2.50.1
>
>
