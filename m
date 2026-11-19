Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795104891;
	b=Efzig2KP7IphhzP1Bq/6EysRCABUGw7Y3A215rBHfUeQUvJQ9+SUmR6o0CXMO1vv4P8b
	 tTtzMCElCe0vsyuFCJOjz1tMBSHiZtyJp2wWwXXN9x2nfpk2E7kfx0+G1az7Ch3BHo3Y6
	 mAKIYV8sbQCIaQzIiJNS+VbHWlI2VEGhTKjVITPupotKmrT3TzH36zgdfRFZF91NkJVwk
	 cehlq55Y315+StaVFbHNXeXXBgeYdnXfq89dT7nkQVJ+iadH6oRLPQiG8JATKoadpK5V8
	 W+BLXB3lo6Km4Ovp8XaNvbpMUkQVrkmtNTNy1o3YvQ8NQgUbB/Z3QMHkGDDYw0QZ1GQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104891;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=piUJvATNGX/m2Rm7/tS5OF59EfqAzztOqGy4Rlz1rQI=;
	b=DXZ/32LK06x4bkcCLh5Qbn0JfBpgf7gcATv7OGlSxUIAFViQghkwO17lAYudojFyePnC
	 +uqpv41ttVFUpnVqp7fb6qYrzIHkqQ5mJDUWyZxLC9BuR8L09zEQ4MzAwmcHgMxEInpik
	 Hh/PWbcWdB5JIytadoqrU7nJU8YqyuL4g6cgTIPn+Hki5B+NKo+xJCgxXE9vkV+sBKNER
	 tBuZTBnx5bIQAPyXUOhVDWMudNMkBpE01pMgnAEP850UB3AGBpSk5IKcn5M6VnjPgcaCi
	 205bwiZgZr5pWoqKpqoYiFYl7ndzzAdEGTlUtN4QFQFE1NsuiU5S78Nyg9ce5d7ldZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=sSl3z+Ku;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.24
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB35606A324;
	Thu, 19 Nov 2026 16:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BB35606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=sSl3z+Ku
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYL58UKBKUsf1PpI+WPxfn5TdzXoozjgxGAgwG6CT8meyASqcKIVNdpZoW9l8LPSKXrJmpDwQOmrXbWi27abCYtfmBXqpCVFXb3+8JZEieyUsJc+BufjdYVKIGCP/66Lv++UuFB/EWqrzRYlgpAs7Nljo1V8K2MRn2fqPN1yMiNQBdw+HY0EeixBYriwa2i3taJIudwT13Og72Ma/IKYoUabd4ahYkaE9RdAWkKqCjUHUrhTEB4EuVeLWnfk0S7iqvAne/ADMKxVz94yr6ro3a9UsVw1A6+d4gYTL0m6k8hNvLWiCbn3TSXPOT/TccJdv+lScBiDys+H2D39RupgSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piUJvATNGX/m2Rm7/tS5OF59EfqAzztOqGy4Rlz1rQI=;
 b=ONis64OZ6VqfNrwm5L9zMlF2hqhUdjH2MZkmD6Icl/UEIlCEW0gDLniglot/1djHIf0ZCUmzZJ0LxYwN4c3Rluys+1+SaPXC5en4NDzXzBtTCsIZpgYZ5R6y+mxVdJCaLYYuqhDcuqYQNhrEi0yGI8V0Ni9N8iTaiKpNxvklvjE4CNIm/QOVPxZKFeZl60vg1nvLeJD0+NeRkYNB9NOTvVJj+gedOaeymyMYfYhWgDUx1h+DuKQ1A1yDzUJSsBDXk07YNPKf9Nwn6e2ts6/dF6baUQMw3R3bxwFELQT/fVNd2rQ/2wi+MLDBPhYtmwYP33ZINZNqOtI0KjlMFsUM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piUJvATNGX/m2Rm7/tS5OF59EfqAzztOqGy4Rlz1rQI=;
 b=sSl3z+KuqmgStDsiKRHB/9WlnFLd2ELbJjXlY1hUQoLeSo0h1sBisGJ9e6VdTXJLhL423JIYolQ+iBAOX6u9hx/JBUFgziydZM1asJ2iZQcTiBRfbvigtFeD5CD3ReJtepbKrP/ntJZ8fDLI3fgWCK7YkZI7vFv3+QA0oAz6ls0ZfkguiRC4VHl7NTTWMg8WxJDA2yf8+YZJf0AtOPm9pcnJie071vioQiOl72eIyP1di5npeGLpHzAGqgeuFO66fagrDx+zVhpjG4i1yAKzovg/ZpcvRtDjqHBmUM/v6g8NKwwjw8R5+g733YhwCm176VXYfVqSIy3mpDrn7PHEdg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV1PR04MB10478.eurprd04.prod.outlook.com (2603:10a6:150:1d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Thu, 19 Nov
 2026 16:14:43 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 16:14:43 +0000
Date: Thu, 19 Nov 2026 10:14:33 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: lee@kernel.org, maz@kernel.org, andy@kernel.org, jic23@kernel.org,
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
	mfd@lists.linux.dev, linux-iio@vger.kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, crofts@kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	stable@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v5 3/4] mfd: mxs-lradc: Pass parent IRQs to child drivers
Message-ID: <av8gaVpEWUMTS1hQ@SMW015318>
References: <20261119134041.16611-1-festevam@gmail.com>
 <20261119134041.16611-3-festevam@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119134041.16611-3-festevam@gmail.com>
X-ClientProxiedBy: PH7P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::15) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV1PR04MB10478:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0ff214-cdaa-4946-a92f-08df46583891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|23010399003|261009221727099003|261009220027099003|261028144727099003|261022105027099003|56012099006|11063799006|4143699003|261102123227099003|10067099003|261009221227099003|261021123027099003|261009223327099003|261021121427099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|22082099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	Jzno3LOIIX8yXF/09NjO4K/eBuv3m9bfW1B8t6/KiUr26mLJB2vGZbfOwrfEIjtL8a2uN2izaaCp6uUMnIchxTUklZkTBDqu9hwxhadAsa99Lu3rHErMqFQSY+EWzBmH+F193Flq3q6uK1lSRBj737VNyQilf6xbx8KRaI2v5rgn6h8IGe+uwgoTy1tCDWyUXeWLL0lNc6teg+B4WXooGOwlwoGW5g3EOBsKYiHHnvKQCOMNCHjdUJKcBHia7PayfBkmgQo8kvpgDwUxK68iHHFSDV/QlEap0V1M2YnTZAFZ3CqOp/KuCTsGzSG71fKWPR/a/2TsE9wmfWs5DEfWjizg+BbVZHr4dho+pNYtNtS1bPbiQvDzzJ9Yt4EzCsc/jvM0QWw2TUube+ApMdiovyXlZ+gfgHQ9qBbGuWErfZ/3VtbfkPUgM3C2yv6T6Qz2z3+0MdFsMKwGoe3OHMS4daCAxQm/DjLIfcgNPcmPzxB51HeQnJoQsssn6V3qEDJxWuFwPEe+VDGP3H2XFtmtIpCUgZEY6qYxKqRL8CgNsJAl8ki5cP2w8cali8Kxlm3ajNY001rNsLRioa1W4dCVhTuzVkCp870sDWWw6VjbAPBaQnoI9Ayoq35EbeJAtJNT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(23010399003)(261009221727099003)(261009220027099003)(261028144727099003)(261022105027099003)(56012099006)(11063799006)(4143699003)(261102123227099003)(10067099003)(261009221227099003)(261021123027099003)(261009223327099003)(261021121427099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(22082099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?50TaItr5gDmwg3d51iiFSclTQhfpXx7iCejxufHIDqqYw3HgF+PoIbj6sqqV?=
 =?us-ascii?Q?1mNc+NgGgOnZvMfpD+Kqin3kGg9FwVvwmNFHlKlHbYH7U917k3PnZE4UsOpM?=
 =?us-ascii?Q?9eJ2CZszg0TgkJ0JSRLPov5nZVuMIsV1iLxXsNyIhtxfipHhq1EiPUwlhBiy?=
 =?us-ascii?Q?AmIFG+tP5Z/+f62dJCC5eSIRwV2sYEBzAo4jEdw/hdSk81XUNavObYkVpBxj?=
 =?us-ascii?Q?WTjgHr3TyTrd0kqEgzPtWKeE6eiYcIl+ze6BgXyCZj7Jlw9sxc0SVO5HiLT3?=
 =?us-ascii?Q?CZG/M+M7WAyJ5X0tvtyNEyCbvReDR4SiI+dZzFf+/4wc0vf4eyHROKnJrFZB?=
 =?us-ascii?Q?8s62PXgKZiZjZPDEyasQ290EoMmulTt27wWOz8t0zW6NzbZV+iznZS2dwht1?=
 =?us-ascii?Q?WPYTiLFtoew5L13FvzfsNihm6nQ5RPpFe7EXVipZp9d7Qfh5OpeRCXWtq2DV?=
 =?us-ascii?Q?f/UXbh03JmXuXMCeQCWhsdLFNUE5ALmpamQFjLMCXQax1MUOakggqYGNrZO9?=
 =?us-ascii?Q?crsrOxsUqgX/XT8arESk5M2fwPbMLCH0aSmeOq6+uHI444O7dUItHsyLSIG7?=
 =?us-ascii?Q?KriAJYt1TKe4LlkiIN4yZOGrG9zVTMt7L6kjm9iyU6BKqE/IxbmxtnOZzbc8?=
 =?us-ascii?Q?bLGiNSczUBQ6FeoSC2Y3UOD8Z9ifeHDJtbKhtQG0LbqOrItCrSqGm1vwNByi?=
 =?us-ascii?Q?GeDEXHG7OV6ecrzx7HjT/PVHD2noBc+U7AfiHrFkBoJQZ1gNUPTlth4nscYy?=
 =?us-ascii?Q?o5hOc0YTG0w+uLSQP+zneIoGylO/SizUE25PW3+uzfd6fFopPN4tYiW3/eOX?=
 =?us-ascii?Q?R+EV5hWCOdNCviPk5IJfGu9ttwJL8kaPNPcg6aegg/SLi7+2bbjddLedRw50?=
 =?us-ascii?Q?zvdWrHCZjDBByUXwjA+GwLA8SlR/JjYQY91SXAEg23hHm/WDEhEU9Fir5aw/?=
 =?us-ascii?Q?4sthJ5tSkGMQqsteytfNVQsNFWP+BUSw19O4QAbb33NZWqEIpwoQ+apt2Si2?=
 =?us-ascii?Q?WhazqJbxHFjah56aXapw5fOBZrwgfzj8AjoBFnkEwRpLIzGFifKizFCytHzo?=
 =?us-ascii?Q?u2XCYVen3JVv6lbKlmxt5QNhFuftBHYEyoqMb1euBLbz043CHEvQ3hcPy2K/?=
 =?us-ascii?Q?9Mkllfu7MRR1ao5pEoPfErBvvD9cMBdaM5yr2dsuaNrl5NPqXQgEr0560Jn6?=
 =?us-ascii?Q?HPOq/A/6v2Tv9+QSASyK2eb4fthIUMFcELFGzfDqjjt15OMz4GuXw0W5jl8U?=
 =?us-ascii?Q?y9SjRXid6rdjxfYwhlBNvtkBs6BAmtlCfl/EP3BvpVBxkDv3loA38poO4FhD?=
 =?us-ascii?Q?mnwzN/F3o+RvQtWe0JZeETzddyB10U6bA3gkmJQjWKn1T7QBPSQl5EqHKrR0?=
 =?us-ascii?Q?aNXdSMpUUIeGSeHRJleG9/8Gk6jk3pL01l5WWjfo77JYfeKAax2JraRQbvkK?=
 =?us-ascii?Q?K85Vycuw2T9/3atGE7tDdRBN4ywaDfwxMUJxPAvYPTcuX2dArzmjtL8flWLx?=
 =?us-ascii?Q?lli2DEsJujiTXvpF5BJ+lltCxHVRAqRZ8xOOed4eAj140yFCDI9umw5kIgGj?=
 =?us-ascii?Q?xZWo2XZCWKE7ixkaknkNw9IpLrQ4242fK8U9urhIxldf53E9jzCb8A/aLNOc?=
 =?us-ascii?Q?ZJg/Quu5q5IurIAGSN/QslSkQZDNJ9D8v3b+qxDV/l+0rhASdysgYU31Kxzy?=
 =?us-ascii?Q?hjIRV00oDuocxuZbvknnNn6Mkvy7UkN16B79Z5uWd2ZruvzINiGFrwGIScih?=
 =?us-ascii?Q?HquopJE1vw0y6XAtxjXVL2qroyMaA1o3jIER1k+DxfQqTg88Q/sP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0ff214-cdaa-4946-a92f-08df46583891
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:14:43.1405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onpPVkdeLC8m3A30Hlr3eBwlQKSLxff/902WS9E7h6o92AQ7yLSWcEQWxasTr6IMYZl8XsuN0jRM42mx+bAqNCG9WYfMNCBw+rPzwNsox+iJisE3ceCeW9UJmrP1Tacb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10478

On Thu, Nov 19, 2026 at 10:40:40AM -0300, Fabio Estevam wrote:
> The MFD driver stores raw DT interrupt indices in IRQ resources but
> registers its child devices without an IRQ domain or IRQ base. The child
> drivers consequently receive the indices as if they were mapped Linux
> IRQ numbers. IRQ index 0 triggers the platform_get_irq_byname() warning:
>
>   0 is an invalid IRQ number
>
> The children then try to recover the indices from their resources and
> map them against the parent OF node. Besides duplicating IRQ names in
> the parent and children, this relies on invalid platform IRQ resources
> and fails when IRQ 0 is rejected.
>
> Resolve the interrupts with platform_get_irq() in the MFD parent and
> store the mapped IRQs in the shared LRADC data. Drop the child IRQ
> resources and duplicated name arrays, and have both child drivers
> request the mapped IRQs directly. Map the MMIO region once in the
> parent and share the mapping with both child drivers through
> struct mxs_lradc, removing the child memory resources.
>
> Tested on an i.MX28 EVK. The mxs-lradc-ts driver probes successfully,
> touch events are reported, and the touch-detect and LRADC channel 7
> interrupt counters increase as expected.
>
> Cc: stable@vger.kernel.org
> Suggested-by: Lee Jones <lee@kernel.org>
> Closes: https://lore.kernel.org/linux-input/CAOMZO5CgTzo6GuXptD4mFTN=UsJJqpkixDW1Q64gqZGrij8+uQ@mail.gmail.com/
> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since v4:
> - Correct the commit message to describe the shared parent MMIO mapping. (Sashiko)
>
> KASAN is happy now after unbind/bind:
>
> echo 80050000.lradc > /sys/bus/platform/drivers/mxs-lradc/unbind
> echo 80050000.lradc > /sys/bus/platform/drivers/mxs-lradc/bind
> echo 80050000.lradc > /sys/bus/platform/drivers/mxs-lradc/unbind
>
> This is a long-standing bug that I reported in 2020:
> https://lore.kernel.org/linux-input/CAOMZO5CgTzo6GuXptD4mFTN=UsJJqpkixDW1Q64gqZGrij8+uQ@mail.gmail.com/
>
> This patch touches MFD, IIO, and Input. Since the IRQ mapping is moved
> into the MFD parent, I suggest merging it through the MFD tree, with
> acks from the IIO and Input maintainers.
>
> The full backtrace:
>
> [   10.540505] WARNING: drivers/base/platform.c:492 at __platform_get_irq_byname+0xb4/0xcc, CPU#0: swapper/0/1
> [   10.555516] 0 is an invalid IRQ number
> [   10.559627] Modules linked in:
> [   10.562849] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc7-next-20261016-00003-g36062817a968 #17 VOLUNTARY
> [   10.573732] Hardware name: Freescale MXS (Device Tree)
> [   10.578934] Call trace:
> [   10.578992]  unwind_backtrace from show_stack+0x10/0x14
> [   10.586955]  show_stack from dump_stack_lvl+0x48/0x64
> [   10.592170]  dump_stack_lvl from __warn+0x8c/0x190
> [   10.597114]  __warn from warn_slowpath_fmt+0x94/0xcc
> [   10.602232]  warn_slowpath_fmt from __platform_get_irq_byname+0xb4/0xcc
> [   10.609027]  __platform_get_irq_byname from platform_get_irq_byname+0x10/0x30
> [   10.616337]  platform_get_irq_byname from mxs_lradc_ts_probe+0x18c/0x378
> [   10.623247]  mxs_lradc_ts_probe from platform_probe+0x58/0x90
> [   10.629174]  platform_probe from really_probe+0xc4/0x2cc
> [   10.634649]  really_probe from __driver_probe_device+0xa0/0x1e0
> [   10.640721]  __driver_probe_device from driver_probe_device+0x30/0xc0
> [   10.647315]  driver_probe_device from __driver_attach+0x94/0x158
> [   10.653466]  __driver_attach from bus_for_each_dev+0x7c/0xd0
> [   10.659280]  bus_for_each_dev from bus_add_driver+0x158/0x1fc
> [   10.665169]  bus_add_driver from driver_register+0x7c/0x114
> [   10.670901]  driver_register from do_one_initcall+0x60/0x294
> [   10.676721]  do_one_initcall from kernel_init_freeable+0x19c/0x24c
> [   10.683073]  kernel_init_freeable from kernel_init+0x14/0x10c
> [   10.688997]  kernel_init from ret_from_fork+0x14/0x38
> [   10.694200] Exception stack(0xc8819fb0 to 0xc8819ff8)
> [   10.699335] 9fa0:                                     00000000 00000000 00000000 00000000
> [   10.707591] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   10.715843] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [   10.723117] irq event stamp: 146363
> [   10.726729] hardirqs last  enabled at (146367): [<c00adbd8>] __nbcon_atomic_flush_pending_con+0x120/0x1c0
> [   10.736770] hardirqs last disabled at (146372): [<c0008f38>] __irq_svc+0x58/0xb0
> [   10.744618] softirqs last  enabled at (146362): [<c0032c20>] __irq_exit_rcu+0x148/0x1d4
> [   10.753153] softirqs last disabled at (146385): [<c0032c20>] __irq_exit_rcu+0x148/0x1d4
> [   10.761603] ---[ end trace 0000000000000000 ]---
> [   10.766374] mxs-lradc-ts mxs-lradc-ts: error -EINVAL: IRQ mxs-lradc-touchscreen not found
> [   10.766456] mxs-lradc-ts mxs-lradc-ts: probe with driver mxs-lradc-ts failed with error -22
>
>  drivers/iio/adc/mxs-lradc-adc.c          |  53 +------
>  drivers/input/touchscreen/mxs-lradc-ts.c |  35 ++---
>  drivers/mfd/mxs-lradc.c                  | 184 +++++++++++------------
>  include/linux/mfd/mxs-lradc.h            |  12 ++
>  4 files changed, 115 insertions(+), 169 deletions(-)
>
> diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> index 64dd3a9995ff..989ccfa4ec00 100644
> --- a/drivers/iio/adc/mxs-lradc-adc.c
> +++ b/drivers/iio/adc/mxs-lradc-adc.c
> @@ -17,7 +17,6 @@
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/mxs-lradc.h>
>  #include <linux/module.h>
> -#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/sysfs.h>
>
> @@ -39,28 +38,6 @@
>
>  #define VREF_MV_BASE 1850
>
> -static const char *mx23_lradc_adc_irq_names[] = {
> -	"mxs-lradc-channel0",
> -	"mxs-lradc-channel1",
> -	"mxs-lradc-channel2",
> -	"mxs-lradc-channel3",
> -	"mxs-lradc-channel4",
> -	"mxs-lradc-channel5",
> -};
> -
> -static const char *mx28_lradc_adc_irq_names[] = {
> -	"mxs-lradc-thresh0",
> -	"mxs-lradc-thresh1",
> -	"mxs-lradc-channel0",
> -	"mxs-lradc-channel1",
> -	"mxs-lradc-channel2",
> -	"mxs-lradc-channel3",
> -	"mxs-lradc-channel4",
> -	"mxs-lradc-channel5",
> -	"mxs-lradc-button0",
> -	"mxs-lradc-button1",
> -};
> -
>  static const u32 mxs_lradc_adc_vref_mv[][LRADC_MAX_TOTAL_CHANS] = {
>  	[IMX23_LRADC] = {
>  		VREF_MV_BASE,		/* CH0 */
> @@ -690,10 +667,8 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
>  	struct mxs_lradc *lradc = dev_get_drvdata(dev->parent);
>  	struct mxs_lradc_adc *adc;
>  	struct iio_dev *iio;
> -	struct resource *iores;
> -	int ret, irq, virq, i, s, n;
> +	int ret, i, s;
>  	u64 scale_uv;
> -	const char **irq_name;
>
>  	/* Allocate the IIO device. */
>  	iio = devm_iio_device_alloc(dev, sizeof(*adc));
> @@ -703,14 +678,7 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
>  	adc = iio_priv(iio);
>  	adc->lradc = lradc;
>  	adc->dev = dev;
> -
> -	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!iores)
> -		return -EINVAL;
> -
> -	adc->base = devm_ioremap(dev, iores->start, resource_size(iores));
> -	if (!adc->base)
> -		return -ENOMEM;
> +	adc->base = lradc->base;
>
>  	init_completion(&adc->completion);
>  	spin_lock_init(&adc->lock);
> @@ -725,28 +693,19 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
>  	if (lradc->soc == IMX23_LRADC) {
>  		iio->channels = mx23_lradc_chan_spec;
>  		iio->num_channels = ARRAY_SIZE(mx23_lradc_chan_spec);
> -		irq_name = mx23_lradc_adc_irq_names;
> -		n = ARRAY_SIZE(mx23_lradc_adc_irq_names);
>  	} else {
>  		iio->channels = mx28_lradc_chan_spec;
>  		iio->num_channels = ARRAY_SIZE(mx28_lradc_chan_spec);
> -		irq_name = mx28_lradc_adc_irq_names;
> -		n = ARRAY_SIZE(mx28_lradc_adc_irq_names);
>  	}
>
>  	ret = stmp_reset_block(adc->base);
>  	if (ret)
>  		return ret;
>
> -	for (i = 0; i < n; i++) {
> -		irq = platform_get_irq_byname(pdev, irq_name[i]);
> -		if (irq < 0)
> -			return irq;
> -
> -		virq = irq_of_parse_and_map(dev->parent->of_node, irq);
> -
> -		ret = devm_request_irq(dev, virq, mxs_lradc_adc_handle_irq,
> -				       0, irq_name[i], iio);
> +	for (i = 0; i < lradc->num_adc_irqs; i++) {
> +		ret = devm_request_irq(dev, lradc->adc_irq[i],
> +				       mxs_lradc_adc_handle_irq, 0,
> +				       dev_name(dev), iio);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c b/drivers/input/touchscreen/mxs-lradc-ts.c
> index 2970d9eb9c2b..25280f056fc7 100644
> --- a/drivers/input/touchscreen/mxs-lradc-ts.c
> +++ b/drivers/input/touchscreen/mxs-lradc-ts.c
> @@ -18,15 +18,8 @@
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/mxs-lradc.h>
>  #include <linux/of.h>
> -#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>
> -static const char * const mxs_lradc_ts_irq_names[] = {
> -	"mxs-lradc-touchscreen",
> -	"mxs-lradc-channel6",
> -	"mxs-lradc-channel7",
> -};
> -
>  /*
>   * Touchscreen handling
>   */
> @@ -601,12 +594,12 @@ static int mxs_lradc_ts_register(struct mxs_lradc_ts *ts)
>
>  static int mxs_lradc_ts_probe(struct platform_device *pdev)
>  {
> -	struct device *dev = &pdev->dev;
> -	struct device_node *node = dev->parent->of_node;
> -	struct mxs_lradc *lradc = dev_get_drvdata(dev->parent);
>  	struct mxs_lradc_ts *ts;
> -	int ret, irq, virq, i;
> +	struct device_node *node = pdev->dev.parent->of_node;
> +	struct mxs_lradc *lradc = dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev = &pdev->dev;
>  	u32 ts_wires = 0, adapt;
> +	int ret, i;
>
>  	ts = devm_kzalloc_obj(dev, *ts);
>  	if (!ts)
> @@ -616,12 +609,9 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
>
>  	ts->lradc = lradc;
>  	ts->dev = dev;
> +	ts->base = lradc->base;
>  	spin_lock_init(&ts->lock);
>
> -	ts->base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(ts->base))
> -		return PTR_ERR(ts->base);
> -
>  	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
>  				   &ts_wires);
>  	if (ret)
> @@ -668,19 +658,12 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
>  		return ret;
>
>  	mxs_lradc_ts_hw_init(ts);
> +	mxs_lradc_ts_stop(ts);
>
> -	for (i = 0; i < 3; i++) {
> -		irq = platform_get_irq_byname(pdev, mxs_lradc_ts_irq_names[i]);
> -		if (irq < 0)
> -			return irq;
> -
> -		virq = irq_of_parse_and_map(node, irq);
> -
> -		mxs_lradc_ts_stop(ts);
> -
> -		ret = devm_request_irq(dev, virq,
> +	for (i = 0; i < ARRAY_SIZE(lradc->ts_irq); i++) {
> +		ret = devm_request_irq(dev, lradc->ts_irq[i],
>  				       mxs_lradc_ts_handle_irq,
> -				       0, mxs_lradc_ts_irq_names[i], ts);
> +				       0, dev_name(dev), ts);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/drivers/mfd/mxs-lradc.c b/drivers/mfd/mxs-lradc.c
> index 30a66e268169..aa55f88399ef 100644
> --- a/drivers/mfd/mxs-lradc.c
> +++ b/drivers/mfd/mxs-lradc.c
> @@ -20,10 +20,6 @@
>  #include <linux/property.h>
>  #include <linux/slab.h>
>
> -#define ADC_CELL		0
> -#define TSC_CELL		1
> -#define RES_MEM			0
> -
>  enum mx23_lradc_irqs {
>  	MX23_LRADC_TS_IRQ = 0,
>  	MX23_LRADC_CH0_IRQ,
> @@ -52,92 +48,117 @@ enum mx28_lradc_irqs {
>  	MX28_LRADC_BUTTON1_IRQ,
>  };
>
> -static struct resource mx23_adc_resources[] = {
> -	DEFINE_RES_MEM(0x0, 0x0),
> -	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH0_IRQ, "mxs-lradc-channel0"),
> -	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH1_IRQ, "mxs-lradc-channel1"),
> -	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH2_IRQ, "mxs-lradc-channel2"),
> -	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH3_IRQ, "mxs-lradc-channel3"),
> -	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH4_IRQ, "mxs-lradc-channel4"),
> -	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH5_IRQ, "mxs-lradc-channel5"),
> -};
> -
> -static struct resource mx23_touchscreen_resources[] = {
> -	DEFINE_RES_MEM(0x0, 0x0),
> -	DEFINE_RES_IRQ_NAMED(MX23_LRADC_TS_IRQ, "mxs-lradc-touchscreen"),
> -	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH6_IRQ, "mxs-lradc-channel6"),
> -	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH7_IRQ, "mxs-lradc-channel7"),
> -};
> -
> -static struct resource mx28_adc_resources[] = {
> -	DEFINE_RES_MEM(0x0, 0x0),
> -	DEFINE_RES_IRQ_NAMED(MX28_LRADC_TRESH0_IRQ, "mxs-lradc-thresh0"),
> -	DEFINE_RES_IRQ_NAMED(MX28_LRADC_TRESH1_IRQ, "mxs-lradc-thresh1"),
> -	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH0_IRQ, "mxs-lradc-channel0"),
> -	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH1_IRQ, "mxs-lradc-channel1"),
> -	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH2_IRQ, "mxs-lradc-channel2"),
> -	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH3_IRQ, "mxs-lradc-channel3"),
> -	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH4_IRQ, "mxs-lradc-channel4"),
> -	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH5_IRQ, "mxs-lradc-channel5"),
> -	DEFINE_RES_IRQ_NAMED(MX28_LRADC_BUTTON0_IRQ, "mxs-lradc-button0"),
> -	DEFINE_RES_IRQ_NAMED(MX28_LRADC_BUTTON1_IRQ, "mxs-lradc-button1"),
> +struct mxs_lradc_soc_data {
> +	enum mxs_lradc_id soc;
> +	unsigned int num_adc_irqs;
> +	u8 adc_irq[MXS_LRADC_MAX_ADC_IRQS];
> +	u8 ts_irq[MXS_LRADC_NUM_TS_IRQS];
>  };
>
> -static struct resource mx28_touchscreen_resources[] = {
> -	DEFINE_RES_MEM(0x0, 0x0),
> -	DEFINE_RES_IRQ_NAMED(MX28_LRADC_TS_IRQ, "mxs-lradc-touchscreen"),
> -	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH6_IRQ, "mxs-lradc-channel6"),
> -	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH7_IRQ, "mxs-lradc-channel7"),
> +static const struct mxs_lradc_soc_data mx23_lradc_data = {
> +	.soc = IMX23_LRADC,
> +	.num_adc_irqs = 6,
> +	.adc_irq = {
> +		MX23_LRADC_CH0_IRQ,
> +		MX23_LRADC_CH1_IRQ,
> +		MX23_LRADC_CH2_IRQ,
> +		MX23_LRADC_CH3_IRQ,
> +		MX23_LRADC_CH4_IRQ,
> +		MX23_LRADC_CH5_IRQ,
> +	},
> +	.ts_irq = {
> +		MX23_LRADC_TS_IRQ,
> +		MX23_LRADC_CH6_IRQ,
> +		MX23_LRADC_CH7_IRQ,
> +	},
>  };
>
> -static struct mfd_cell mx23_cells[] = {
> -	{
> -		.name = "mxs-lradc-adc",
> -		.resources = mx23_adc_resources,
> -		.num_resources = ARRAY_SIZE(mx23_adc_resources),
> +static const struct mxs_lradc_soc_data mx28_lradc_data = {
> +	.soc = IMX28_LRADC,
> +	.num_adc_irqs = 10,
> +	.adc_irq = {
> +		MX28_LRADC_TRESH0_IRQ,
> +		MX28_LRADC_TRESH1_IRQ,
> +		MX28_LRADC_CH0_IRQ,
> +		MX28_LRADC_CH1_IRQ,
> +		MX28_LRADC_CH2_IRQ,
> +		MX28_LRADC_CH3_IRQ,
> +		MX28_LRADC_CH4_IRQ,
> +		MX28_LRADC_CH5_IRQ,
> +		MX28_LRADC_BUTTON0_IRQ,
> +		MX28_LRADC_BUTTON1_IRQ,
>  	},
> -	{
> -		.name = "mxs-lradc-ts",
> -		.resources = mx23_touchscreen_resources,
> -		.num_resources = ARRAY_SIZE(mx23_touchscreen_resources),
> +	.ts_irq = {
> +		MX28_LRADC_TS_IRQ,
> +		MX28_LRADC_CH6_IRQ,
> +		MX28_LRADC_CH7_IRQ,
>  	},
>  };
>
> -static struct mfd_cell mx28_cells[] = {
> +static const struct mfd_cell mxs_lradc_cells[] = {
>  	{
>  		.name = "mxs-lradc-adc",
> -		.resources = mx28_adc_resources,
> -		.num_resources = ARRAY_SIZE(mx28_adc_resources),
>  	},
>  	{
>  		.name = "mxs-lradc-ts",
> -		.resources = mx28_touchscreen_resources,
> -		.num_resources = ARRAY_SIZE(mx28_touchscreen_resources),
> -	}
> +	},
>  };
>
>  static const struct of_device_id mxs_lradc_dt_ids[] = {
> -	{ .compatible = "fsl,imx23-lradc", .data = (void *)IMX23_LRADC, },
> -	{ .compatible = "fsl,imx28-lradc", .data = (void *)IMX28_LRADC, },
> +	{ .compatible = "fsl,imx23-lradc", .data = &mx23_lradc_data, },
> +	{ .compatible = "fsl,imx28-lradc", .data = &mx28_lradc_data, },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, mxs_lradc_dt_ids);
>
> +static int mxs_lradc_get_irqs(struct platform_device *pdev,
> +			      struct mxs_lradc *lradc,
> +			      const struct mxs_lradc_soc_data *data)
> +{
> +	int i, irq;
> +
> +	for (i = 0; i < data->num_adc_irqs; i++) {
> +		irq = platform_get_irq(pdev, data->adc_irq[i]);
> +		if (irq < 0)
> +			return irq;
> +
> +		lradc->adc_irq[i] = irq;
> +	}
> +	lradc->num_adc_irqs = data->num_adc_irqs;
> +
> +	for (i = 0; i < ARRAY_SIZE(data->ts_irq); i++) {
> +		irq = platform_get_irq(pdev, data->ts_irq[i]);
> +		if (irq < 0)
> +			return irq;
> +
> +		lradc->ts_irq[i] = irq;
> +	}
> +
> +	return 0;
> +}
> +
>  static int mxs_lradc_probe(struct platform_device *pdev)
>  {
> -	struct device *dev = &pdev->dev;
> -	struct device_node *node = dev->of_node;
> +	const struct mxs_lradc_soc_data *data;
> +	struct device_node *node = pdev->dev.of_node;
>  	struct mxs_lradc *lradc;
> -	struct mfd_cell *cells = NULL;
> -	struct resource *res;
> -	int ret = 0;
> +	struct device *dev = &pdev->dev;
> +	unsigned int num_cells;
>  	u32 ts_wires = 0;
> +	int ret = 0;
>
>  	lradc = devm_kzalloc_obj(&pdev->dev, *lradc);
>  	if (!lradc)
>  		return -ENOMEM;
>
> -	lradc->soc = (kernel_ulong_t)device_get_match_data(&pdev->dev);
> +	data = device_get_match_data(dev);
> +	if (!data)
> +		return -ENODATA;
> +
> +	lradc->soc = data->soc;
> +	lradc->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(lradc->base))
> +		return PTR_ERR(lradc->base);
>
>  	lradc->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(lradc->clk)) {
> @@ -181,44 +202,15 @@ static int mxs_lradc_probe(struct platform_device *pdev)
>
>  	platform_set_drvdata(pdev, lradc);
>
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		ret = -ENOMEM;
> +	ret = mxs_lradc_get_irqs(pdev, lradc, data);
> +	if (ret)
>  		goto err_clk;
> -	}
> -
> -	switch (lradc->soc) {
> -	case IMX23_LRADC:
> -		mx23_adc_resources[RES_MEM] = *res;
> -		mx23_touchscreen_resources[RES_MEM] = *res;
> -		cells = mx23_cells;
> -		break;
> -	case IMX28_LRADC:
> -		mx28_adc_resources[RES_MEM] = *res;
> -		mx28_touchscreen_resources[RES_MEM] = *res;
> -		cells = mx28_cells;
> -		break;
> -	default:
> -		dev_err(dev, "Unsupported SoC\n");
> -		ret = -ENODEV;
> -		goto err_clk;
> -	}
> -
> -	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
> -				   &cells[ADC_CELL], 1, NULL, 0, NULL);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to add the ADC subdevice\n");
> -		goto err_clk;
> -	}
> -
> -	if (!lradc->touchscreen_wire)
> -		return 0;
>
> -	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
> -				   &cells[TSC_CELL], 1, NULL, 0, NULL);
> +	num_cells = lradc->touchscreen_wire ? ARRAY_SIZE(mxs_lradc_cells) : 1;
> +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> +				   mxs_lradc_cells, num_cells, NULL, 0, NULL);
>  	if (ret) {
> -		dev_err(&pdev->dev,
> -			"Failed to add the touchscreen subdevice\n");
> +		dev_err(dev, "Failed to add subdevices\n");
>  		goto err_clk;
>  	}
>
> diff --git a/include/linux/mfd/mxs-lradc.h b/include/linux/mfd/mxs-lradc.h
> index ada3d81ee277..ba90bf174ee8 100644
> --- a/include/linux/mfd/mxs-lradc.h
> +++ b/include/linux/mfd/mxs-lradc.h
> @@ -19,6 +19,9 @@
>  #define LRADC_MAX_MAPPED_CHANS	8
>  #define LRADC_MAX_TOTAL_CHANS	16
>
> +#define MXS_LRADC_MAX_ADC_IRQS	10
> +#define MXS_LRADC_NUM_TS_IRQS	3
> +
>  #define LRADC_DELAY_TIMER_HZ	2000
>
>  #define LRADC_CTRL0				0x00
> @@ -149,18 +152,27 @@ enum mxs_lradc_ts_wires {
>  /**
>   * struct mxs_lradc
>   * @soc: soc type (IMX23 or IMX28)
> + * @base: mapped LRADC register base
>   * @clk: 2 kHz clock for delay units
>   * @buffer_vchans: channels that can be used during buffered capture
>   * @touchscreen_wire: touchscreen type (4-wire or 5-wire)
>   * @use_touchbutton: button state (on or off)
> + * @num_adc_irqs: number of ADC interrupts
> + * @adc_irq: ADC interrupts
> + * @ts_irq: touchscreen interrupts
>   */
>  struct mxs_lradc {
>  	enum mxs_lradc_id	soc;
> +	void __iomem		*base;
>  	struct clk		*clk;
>  	u8			buffer_vchans;
>
>  	enum mxs_lradc_ts_wires	touchscreen_wire;
>  	bool			use_touchbutton;
> +
> +	unsigned int		num_adc_irqs;
> +	int			adc_irq[MXS_LRADC_MAX_ADC_IRQS];
> +	int			ts_irq[MXS_LRADC_NUM_TS_IRQS];
>  };
>
>  static inline u32 mxs_lradc_irq_mask(struct mxs_lradc *lradc)
> --
> 2.43.0
>
>
