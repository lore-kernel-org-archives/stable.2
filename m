Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013069.outbound.protection.outlook.com [40.107.159.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C0432E97;
	Fri, 24 Jul 2026 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905726; cv=fail; b=ZVfzVwJy8GL1ITod/lxN1QyII2KiQloyM8apdFrXwSC36EDpE7ObA6M3TnjdyvRNK3uzIewfTZVsOPuHwyNt/vXPnplMzVspdSQGck2T/B3Dll1hjEPh+vbYGOJpPqj8sGwYCOdzgDhQfwcG4NnWHD/oJQW1Tmuod1toUHnVb1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905726; c=relaxed/simple;
	bh=biU/256I7eZ9gpEZkYrcZjHXhpM/1Wfnvdb1p7dtyp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FzVZp4cbsYP/ii9HpwDpbhUF+vor5i/mBUiXALFfzepEHSJ7Gy34etiZaVHV3DonUaR3/VZeg/Y8RNfOLj9fiqCUO8UaAUFK7QtH+8Od9nrpURJN80BWaGQk7TkJBtSdwbXKZdte47oHVMyDncaKJv4bIwohbPf2CsEeJlmzfgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OSPnR7YJ; arc=fail smtp.client-ip=40.107.159.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OSPnR7YJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNQxXvqXwSelZW8ldracrFAkomjmVbadCZSl13HDDJ6QYdLfPJUz3GGbTLB94k2+LDHpUnBRS5qT2IbhX0gXtqE+o/1gGXE2iLYp8xQtM69PjjmLHswLbrDMsuDs8vwOBPTZo+Ni5hoGCmgjc89npT54PsfNT0kpNVum+nXdd2GFjraagelfWpMo6ZYD78IUmf/sIbSejI3ivOPL9tg1TfR6O2nO3LSaMzHSmBiEeqZ339m1V7guU+8vvF7nBRixc/Sp5QNbOpCjPuQ8zNRx571GQN6GgQnikIcXk2HKCW4G4TxaI2jlZGG2waChFC5NQGKSjOaApZLXdXOnby/aZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJvFDPXNsfr8avVVcZ+kT27a7rR30PkpG2K3wNXHakY=;
 b=pgGbdbAPcUuLROpzXRbI/D/S7nByvi3OKH2GsSlncMxsHRnRwp/I5dChRpyu7Cz1zrke7mcTD29ZLb+WAuGEGpZhjPtC7aDwRjz3iiOXXMRoHnXcvT3qNq5kGDIfb6TaLj6b/GkBZAWktAbtEba5g6g8mcefP1BSfLTGUXCg0vjFRQgYgc8qGVABxpoxJ563XLn6MoTv92O/UfM8OkRGTaWMSd9yyiyokk9p7//DNite0w6v02q6dyRVt2agB+HG005PtukqoiUoKCCR0cwnZVWcD1nJrnvAa0DQcnc2g7WpIy+MxTBi4DxhwK3tFOwsrZ/kQ5eoouWO5oAcVK80rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJvFDPXNsfr8avVVcZ+kT27a7rR30PkpG2K3wNXHakY=;
 b=OSPnR7YJzg5LFODXfD8wroBckLd4xEqC0RD5MWoHZfbtJtdjBM8X3UeQB0bw5mR9al4DZ1lM1CCpwkeg4emRax7nC14enm9AS28VQCeaTDoYYschL5GU99sCc5qknHuEA90ejsaDKmKzuGcPDv/rye03O9W3WimOOtZ8A/L/NluHpoqZUYhMXOB0a1UBWTxkMfgI5hzALCbyY+hllu/vCbaV3jASYckKc5+gZ080tPco/sIetsVXtlfjgrJkMs1x/eqhrc4qFX0TUBmVW5VSd1M3aTBxFknXxcZU58aMOpjcuvcz+r/16rd+f0Vpd8oZXZ4SOy0YZwYSucd+NT0D5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB7566.eurprd04.prod.outlook.com (2603:10a6:102:f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Fri, 24 Jul
 2026 15:08:35 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 15:08:35 +0000
Date: Fri, 24 Jul 2026 10:08:25 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: raoxu <raoxu@uniontech.com>
Cc: samkay014@gmail.com, sre@kernel.org, imx@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: pf1550: enable charging when battery
 profile exists
Message-ID: <amN_6caUBd2TDESR@SMW015318>
References: <097F0559A936ACCB+20260724095437.368905-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <097F0559A936ACCB+20260724095437.368905-1-raoxu@uniontech.com>
X-ClientProxiedBy: PH8P220CA0057.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 8682200c-90e9-452e-2782-08dee9956ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|19092799006|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	k0eilmPMdQ8a04gLkaQZd99vk99r2rHQxkdh6c03Qz/Zw4AxPkhPbFcLVzz7CE0/U5sYg75YkrLBFFL8J/wfowj9jMUZM1y5pRMBj4gjPFuItlNue6Bs8d99MmdKfcog5OSteqja52S1qVmj5SCNmRBVgV1kUFv4OseK+5Dk4qn5sKnKiS3JDZWHCNq0yGzNQ7CezVO7I6LM9IQ8SFNGaAsRq/dPgPqyfZOIqGQ5gHLRJmk582k74JUJSwROTI843mfm09zJWig4gfC9fTQDvizadVt4Dls4IP0nFzpR4pxBxabu0KH2gRNYszZ1AquWUYikHFENZJizaPsx2VIRL54QD8fSg+EUJpLwEzlITirTNCqyl0HK5cE7ogW1ub+Fvhwo5cdXNsiaruW/Qmq+KXvt4OEimPSDgpSSArwCZWuTQgbC8NNA+4Iib5ibzRX5R7WRxX1e+9eqTCH3obARhXNtrJYw4mWlYZ3niapyu/NGMerIDiNyCSsb5LSwvPmnm7O89F014pIkdmxmTUJr2gk+0sUlS7qCmyX/zywMbdZN8EmpcQutliMK9gnoNDku78QNW5wjpCg2EFKJFscCQt72bttsq8e8ZZm/lXbtbmu6R24cH8VkmP4DREXxKqprAz7uEJLEPb5i6kWDqnTqpYS+ckPRCVLDXhDdEd6WU+c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(19092799006)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TJ/hy+DiaRydMzwxjWfP32GWtXToTWtgVItXCyNp/iKFiZ9YQ3IGYXQm1dgQ?=
 =?us-ascii?Q?Qaq0dneYtl4r2HqrdS+q7k509rCdHhs95spfW2504FtSj7wI4NjnZ4Yt++zH?=
 =?us-ascii?Q?kO/3JDbywCFZlAu57PUN6YSCeUjJIn4YRwkbWUfQaXFKke9rR3zV2DWSZDHe?=
 =?us-ascii?Q?zLh5XpQBJL3a7lO+XH5JHYoDIN5AX8mn9E7TSBht0Jr7c6hpCJ3DNQyT9akK?=
 =?us-ascii?Q?7KJT7BKqMi6heySp1WQzS69IWF87wzdzc1lGyyIIV1EWVE+FqaMR0VqMI5KR?=
 =?us-ascii?Q?GiqVaMd36q55RTUygGGrdMoBwGDQxVx7LyKHI6kv87QFvUl1dI3Q2hKU4qFA?=
 =?us-ascii?Q?ckFIKSf4JVLP+K40qCT6eOod0MH66Vk2hT1yU5OKbbpuu/1O/ykQKveP8c8m?=
 =?us-ascii?Q?5orSci8JlKutGUajYd9rG37d238deEXaY37zuEIbOcX8wDwtdYDtBDHzKM0M?=
 =?us-ascii?Q?4jWhPrbJQlkbwCeM4eHcZwq7Nk1psK44etroneDxG1/2DgRIqkt3UwnVJ+19?=
 =?us-ascii?Q?Y7b6o/uphyjkedDjqyyo6hwFFeeT8T5lnMqHsHhMnoz5lcduk8IL71cka3mE?=
 =?us-ascii?Q?unL02oLFYnSM29LL+b+VaYT72nmvIo7TZ61FU6LOgwAafYpzpkidr/yMeoUf?=
 =?us-ascii?Q?fY6Styoyv3nuxL1QuNIobJK/7FaCpYE5xwTxitF6b9ZbOY8H9QfXIRJHaLLs?=
 =?us-ascii?Q?St0/yFGEdbAtqGxlxZSsJJrZ7jcByti0iQiz5ykwyOoUqFWJSgmqJtIuWssO?=
 =?us-ascii?Q?m/alezq6mQyb5S+Qt9WDXofHVsFYTk1Nc7UgpDmlzutPnNHTRm7ZAeD1UUS6?=
 =?us-ascii?Q?oT8u1DNuenNg/A41WFjF3LBMt6tO1Tx8ZeSIG4312N+MldQTWJmjdTA1rjF+?=
 =?us-ascii?Q?yVR4D0JfI5koUBb4Ivksli0GAzzezBhOVyITYQxx+HLmYbkj+8OAkakfxrU8?=
 =?us-ascii?Q?fSWreUKwsdkppzp/Fo42O0jRGkXHhN0/xnFKF0HE0VoQyqw9vkfTN3ntWX3c?=
 =?us-ascii?Q?5PyRxX1xaea0TjMg8LYsXqyPrWvsDhcHeuKD0re+cCLHLZfG50BAU9iVN9mQ?=
 =?us-ascii?Q?pwkeZpl4UNj8OD9NHRJ06LAfPfrR+Cdj0xvMc0SJxzQmAh2L5MhGzPUgppEt?=
 =?us-ascii?Q?X8wFsKZJEn+tnPg8TeJtnzNUwIIjYGa9u0L74qQjlyjZFLXXSKXlUeVFLbB7?=
 =?us-ascii?Q?VzF+O+IFLn8IbDf8vUQlvZhsrloDw7yf7fkMRsl/4RPCQgRbRtv+0xsBaqrl?=
 =?us-ascii?Q?4HFHfVmdlt/Cw4LM0HMAOZeY/4Y3PyyE7l1uWyKwJ0aEXWu8VxbmEgUBJ0kg?=
 =?us-ascii?Q?QgWlnxOoDmTYeO05kMebuVyOxHzQUzmyH1kzqkb2HG6yAP8kY6PdcNKvn5bu?=
 =?us-ascii?Q?VMxJ5b6gsW9TJs192x7iguFmo66DRtO3Lg1dPZpl1aTE2NmIQ6O1751udrvn?=
 =?us-ascii?Q?NeAooI9BaUo2a/+7+Sq3EPNF1Q4CVsk/sB+Qvp6ahN1IrALiWxs3/hozGfow?=
 =?us-ascii?Q?cFzfSm/zbxl1Zb+hCz2MP2lYATaRAMz4O55KqHreAwnaAw+RyVuw7KZUWsHe?=
 =?us-ascii?Q?yvnZbIIYr3jSaaxoWwQvXtxIOt9D2Q2u7KehjKI5OlIJ6PVvC3qYyDPzhm2q?=
 =?us-ascii?Q?GDtDt1VxVMplLBaC/Qg4D8DF1rcvHLGNDZioimQPi5udEXN4SOmSfCtjyND4?=
 =?us-ascii?Q?hQh6HasKGmMjou4HFcPwab6lHd0H1A+Q3KEsCuyxaRg8bTZB1PhSys6pnGvi?=
 =?us-ascii?Q?aINeQ+s6M1PdqW3y1HkkKTWsQ0hxbMtzsJMlUhAVmyRI2xMQPpAi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8682200c-90e9-452e-2782-08dee9956ed4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 15:08:35.4786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VinkmNvu5z9A4f77UiWhT4zjJwPbr3QH7xVCm+EqKzy1vsHYbiybHWESDncLInC4CPeAc5+0T1yLYwgLBm1HxbgCddK+hBUivUrliKK3sJjvQKwW1P7JGqR70CoH4R28
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7566

On Fri, Jul 24, 2026 at 05:54:37PM +0800, raoxu wrote:
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
> enables charging with fallback settings.
>
> Select mode 2 when battery information is available.
>
> Fixes: 4b6b6433a97d ("power: supply: pf1550: add battery charger support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
> - Drop power_supply_put_battery_info() calls because static battery
>   profiles are not devm allocated.
> - Leave the pre-existing handling of an unspecified constant charge
>   voltage for a separate fix.
>
>  drivers/power/supply/pf1550-charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/pf1550-charger.c b/drivers/power/supply/pf1550-charger.c
> index 41036f4cb64a..38cac156d2e6 100644
> --- a/drivers/power/supply/pf1550-charger.c
> +++ b/drivers/power/supply/pf1550-charger.c
> @@ -514,7 +514,7 @@ static int pf1550_reg_init(struct pf1550_charger *chg)
>          * a battery. The other supported mode is mode 2, the charger is turned
>          * on to charge a battery when present.
>          */
> -       if (power_supply_get_battery_info(chg->charger, &info)) {
> +       if (!power_supply_get_battery_info(chg->charger, &info)) {
>                 ret = regmap_write(chg->pf1550->regmap,
>                                    PF1550_CHARG_REG_CHG_OPER,
>                                    PF1550_CHG_BAT_ON);
> --
> 2.50.1
>
