Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013029.outbound.protection.outlook.com [40.107.162.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E81539A061;
	Mon, 28 Sep 2026 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596305; cv=fail; b=u51PgTLSnExuqQaBYCplP+NEuYYDsRIq/ZEWNq+8A5iW2ayzlIl/XpczxnKdtRA1yjgVMcUC7Y+rd2Q0Zwbpg0NsiGKGjgRwrIlKxrDKzCt/0sCP7xDaLvEzaM+R2sMWPKMtMkIQwTE3x73p6FZl/mYf0qrnecdh360XRTEi1vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596305; c=relaxed/simple;
	bh=KwWgVuBCXZGkS5Z1zbRcqXA3syPh0RW9XTSTHiVwA0w=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=join2NXZZHLEZBT7k6fJDe0C6exOM8Ww1ZiR/SBfG4M7ajZPb9ZFMPRWKEOvO/4LhjzYSOgw1hSg1aFoV77RyqUh8opSnlXS592kLiiMiLyy4IlEIhmn9zuz0tUmbqzjPyx0gKzZWQdwG0YZdcqUM+/TCrSFh70LRQpL0HXnY5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XGyoqt0L; arc=fail smtp.client-ip=40.107.162.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XGyoqt0L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9+qz6snYShQWLovr4/GLBdFrZ9s2uFvs7NmZfuwXhBt1zDB8A3oGzDZqZpP+zcLzjZYZXSA6Pnf37qX0+QwmLDo3xefmnBIiyhxPAtnDFgdwzuQBXZQR7nEHyoQskZBBg02GgL9paxKfuCm3lBHPlMGNVBQzW/qfINRMxtJ6TP9SYVJ4UnxNVA9SLvKyxTMHsLAwvlGjx8iYkDnsLgxNAZva0ZdlHBj88z/z30p6xVmUkoe7wF6ZIeXYY/89wx+kGhj80LkmK452W/x/Nv6vR7CslmWVLvZW1DKkp0BfAh12cReuk4yRCG4fYViXLJc5uyDEoAzt3tC5H1AuBAunw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eu6ylcsOt/B85XgEHYHtC5TEmFcPDxrupi//y40WRY=;
 b=YtYMwMBK5tFBYquv59wyMcHaSDvuSaT2MrtI1bGmAKsa7DliC8dNaUqDHN/DHkR0KyUP4trxKWqV4zaFrBLr3Ls4McoZxiDBuGAHRuc4q4Al4XaGM8Vn7TkVxVTGH9Eeufd0s1ucbcRtJbwVAVMEXYSvVThTb/Li4TNG3Xd7LOGWUjLAwz9IfQR7DRXHWSGULfTqoa1ChzHVlu5U72gLfmrEWLs6ehz11wst3NEo2XTA7OUWrAHVg/JttCfjUMVjFa1f7OlixoZRnpOdiaTa1Gad1u39zR6ghz5kcQDBsQIYn9eDRmfxUZPC6DwUTh9iwKmvFNfdqU9INI4GrbdyhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eu6ylcsOt/B85XgEHYHtC5TEmFcPDxrupi//y40WRY=;
 b=XGyoqt0Lm9uejk8wg8XHkLFMLAGiGjtpezy59nGeKl5GVUabXdbXZD5j/z4jJ1F689jm9y/gA4APdzVPQaG9tzzAFsLEW1EQ56gQIHzdNnGMP5fgOblJ80GxKhiTHgEu8LBaOHLVrqJHVNDyYclN1xn6Gq82wZiaJFuN3uJiTcBz+NnYADvfSFkwuSeGzK9AbkRLllfACTetiAZ+lckvNiSuU5du5PG1tThTVGashiTWHexlHIqCk97IfCqDaxaBKT9IjXPqfy/Fm1RfSp64mdr+v7ZUz4mBVa+czRmkOpv1RUrs63V88YlGIfwnKtIf2LF9Kp6J+mvBsBB+PieG2A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI1PR04MB7184.eurprd04.prod.outlook.com (2603:10a6:800:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 11:51:38 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 11:51:38 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 28 Sep 2026 19:49:01 +0800
Subject: [PATCH] driver core: hand off fwnode ownership when shared fwnode
 owner is rejected
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-driver-core-v1-1-0846bb8e0f32@nxp.com>
X-B4-Tracking: v=1; b=H4sIACxUumoC/yXMQQ5AMBBG4avIrDXRLkRdRSxof4wFMkUkjbsrl
 t/ivUgBwghUZ5EEJwdelwSdZ+Smbhmh2CeTKUxZWFMpL3xClFsFatDewloN3xtKxSYY+PpuTfs
 7HP0Mt78Luu8HJBRzqm8AAAA=
X-Change-ID: 20260928-driver-core-f1d9e991edb2
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Saravana Kannan <saravanak@kernel.org>, 
 Sudeep Holla <sudeep.holla@kernel.org>, 
 Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Peng Fan <peng.fan@nxp.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI3PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::6) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI1PR04MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f5978e-a16e-4e0c-fbc1-08df1d56da7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|19092799006|1800799024|10067099003|11063799006|6133799003|3023799007|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	3uNTkV506PTK0awifC/u+1CpfmM6DLuOIHxCn7ctFy7aAm588Okh865dObT6KJYa5yA+okpcSBx26quA2Xog56FVH9hK6kDnyaFJ9ExF1ozFEG2iXBf5cNSfz1y8aCdSmMhAAEkkkWvdom7fvneVm+dnH0uGIlJjIwxQPa5eMGLCCC9bVivAwSC4SAFE7rqhXBqjhxiH06oHUDi0yLfnJriTiegjD21nK69i4/6zqtkezbaYtbt6VejcNMgU0Nhr+lK166+Cbk7zCe/+VJbR8I1GzRdegQkU8RXqW7AEbLTM9esLuJnyoPWNNHv/8EDSwcj/fLSMV7hnw3ekbHmjw1CJN3fdckITptaMTcdoPUzN/SlCusB5pxaWj11+/SnX5co9Iv2cbkOXbwUUhQF2gigsAB/IfW97cKVqndCIT0nvO49b9juciBDRj3erraOxapvucQLl7HfhqXV3q2r3F7AQ6J1VeW2lh6AQydxPEE9waCokAHUxvSNMpsVUPLAvgRd8kt2/lPwZ0MQocTzmmVgKG2OFSJerlV0GBe8DTFXjEOYPgCyQTA9wzXuFMgvrKmSyM1o49xDWhkbVrrm4BWpwDO7Na7bWXGpf7oqXQ07NapGpl8X+zdm+4X40Ldtg4u4PTzK4l2UcnuTzW0i2gLEgZ525A6BghCxa276A938=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(19092799006)(1800799024)(10067099003)(11063799006)(6133799003)(3023799007)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWxUOHJ2bmJSUjNTeUR1b1lLRWFKTUlnTm9zdmdhNlhadTVNenVEQVVIcG1z?=
 =?utf-8?B?WUVWOWtpM3BwY1VqbHVIc2owb1cvWjBHc3h0cWtaVU9rQ0loSys0N1lISXFn?=
 =?utf-8?B?RHdGbU1vR2FlR09iN2FCdXNDZms3TGcveFdLY0NoaVE4SUtMWm5YeVl0ZFRO?=
 =?utf-8?B?V1R1WGtHcVFFN0RWd2l0TllMcWhZNUJLTkJvOWs2Wkl1eGk4RFg1aTBXbVFE?=
 =?utf-8?B?MG4wd3lXblYzdVBWS0F4NXFJb295OC9xR3l2c00xNklTbDFhbDQxNnptaU5W?=
 =?utf-8?B?ams4WGszb2Q2RDI2QjZVdkJxaThCckRHc0RReTVJK3dubjVJTzUxdGZSakdS?=
 =?utf-8?B?VHk3cWliU1NYZU9SS2FRZXYwMHBiL0NvZTJoanRBU2dxZGFuSlRFK2p1WXJB?=
 =?utf-8?B?dkVoYU12V2hZVUs4Zk81bEZIRW85YTdrVlNvMDg2T2tRckhqTCtOMVdFVGJ2?=
 =?utf-8?B?UFU4RXdyTGlzb0J5RHM2NFhCR2lQL25Ba0ZBR0IxajdEY1VYL0lnZ1NDd2Q2?=
 =?utf-8?B?WTRuM3MzVmszekVVVWVPY1JkdEtmVEZPQWhSZXUySDlnelc3ZEw0ekpFNXBo?=
 =?utf-8?B?VFJ3WkFqMHQ4MGFyeENBWHBTZlJzQTlVa2xVd0ZJUlFaZzV0ampFWFZ2VmtS?=
 =?utf-8?B?U1R4OTM4OEViTkdoamdzSHk0RnVxeEx2Zm5ZZmhTdGs5Ti9UUy9YbWMzdDRi?=
 =?utf-8?B?OS84ZjBnZWltVnhmQ1dVRU85MlVKU1VOcytoajFTOVlwSFlZUmk1dzJkU2di?=
 =?utf-8?B?N2NOVk5Ebk9jbHBtL2R0c3Q0RXBGcFMzd2RYYW1DNEFnNWtmeVR3b2ZnWWlr?=
 =?utf-8?B?b0lKUjJKWitIemhHdjZpTFlsQWJ3TVdJdVZUc0hXQmZnNlMyRGNtZTZ5VHow?=
 =?utf-8?B?YnNycUNqcmhUTVhOb0FYY3NxNHNRNzFPNmROcmpGK0I3cGpHRVhhQmZQWU4v?=
 =?utf-8?B?OXV6eXpjcjFzSzg4S1hBb0tMVVZKbkF1YVFLczRjNjZYeHBLT1ZoY1FVRk5h?=
 =?utf-8?B?UEIxWDQxUkZveVVyVWZJeXh1Qyt4VEl6RTU2RnB5T0s0dFJpZlNwMHRZamdh?=
 =?utf-8?B?TDdEL0p0KzB2QmNUbFBhOGp3TFo4SGE5M1AxSUphVVNwbWlnUlRLNGlOL2RY?=
 =?utf-8?B?RGw2ZDU1elhqK1NMWWtWUmgxU0dDNGRiT3o2V3RGZ0s0ZFU1NGlVVmxWMlpY?=
 =?utf-8?B?RXpvOXJCbHY4UXEySmROTStsQm8wQTgyc2tTeHlBc2s1K1V1UHVxQVJ1TkZE?=
 =?utf-8?B?WG5YSDhVOWVVb0VFczJGMzZkSDJFTDZUT0lVSGRSeHpCTlRUYTZjSFF4Y01p?=
 =?utf-8?B?MSt5TTlqSDFmM09EL1RSYStZaWtJcVdiaWdSSDd6aG9CNUdTZjgvem1USzJ0?=
 =?utf-8?B?YnRsTXhtdzdpM2hiaGJpcWcraHhYeUdKNk1EVGF0azFTZ09aRTJMR0pqcjdY?=
 =?utf-8?B?a0JKSDR0U0JQR3N3eWxOQ2VIMi8razVRSERmRGkyVk5lZ0QzekNNak1EdDR5?=
 =?utf-8?B?U1VYaytEUHlWeENxSStaT0NvMDJsM1p0d05DUC9PTFkxRjl2QVhORS9LTG5S?=
 =?utf-8?B?T0V0N2dLZWtvRGdkR20wMFRZMWtjQ1dKM1c5eVNleFpsQ3dWZnFqRlBPVFpN?=
 =?utf-8?B?Sm8vZHJIemZhZkpMeUpvNC9uQko4aGd1VFZjZTJKTUozYW9UekgwRjdXSHJE?=
 =?utf-8?B?TmUxNmlWQ1FPT2dobFVENm8vK3RySHhQUUwrTlppVWc5dHgwdjdQYlNpWUMv?=
 =?utf-8?B?clVaNmtOcTBMeDZqVmFDTDdwTzhBcE0wZEIzMi9IWEtPbzRoS3RwZHBYcWYx?=
 =?utf-8?B?SHNRaDgwTElKWm5XbUprYXdJRDZLWjgrVnlQM05pUXJHSDZ0YmoxSng3MlNY?=
 =?utf-8?B?RkpETldOTXN5R2Q0aWZySW8wSXJYdCtITUU1KzVlZEtnRmpwQ0NpWlcvekFK?=
 =?utf-8?B?N2VnUGY4QmhQSkdyWUhiOHJhaElUTWpVODc0MkVkbmtYSTBFQjlBSU9Sd0RE?=
 =?utf-8?B?MWJUT0hvMTI3dTBDMFpJUXYwU1FxUEZMTUZrMUx1Z1ZVVExSdU5HZlF1Q2ww?=
 =?utf-8?B?ZzlZKzFxKzdHMlNqY2hwN3ZmS1hnRFNGcFJjTEx1SWlxWm8xYU15ZUtSOHMv?=
 =?utf-8?B?eWJvRVdGZ2w3TjlvL1pCN1IvOUU4VjBJT0NJTHZwMDVCSjRlQzFDVG1NeHFp?=
 =?utf-8?B?aHk1eEcySHFLVHdFTTJwNXhYaVdBdDRwZloyWmgyNStJUk5WM0xJOGxEcDJl?=
 =?utf-8?B?d3NsZzJXbTQyMlk1QWdUYmZ0R1V6cVFwUVNrTGlZMkV4enViQzRCWWcrNURz?=
 =?utf-8?B?MEJYZnVqVnd4R2xBMjlqd2NRU2lmMzBoSmV0NWVXZTNLQlhJZVo3dGhxMnpL?=
 =?utf-8?Q?zHgWE7gjPOM9d9LDesbxb6Ww3ByGg67JYfmFS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f5978e-a16e-4e0c-fbc1-08df1d56da7b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 11:51:38.2072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zzz3ib+FKXnGSBiXEU1g3LEj9uv4m0AaR20UrcATSsORfqT+3Cc93V3EzrOvJVbS/pVQsGbrLRh6asXSF29ZlS7RKm3THO9G/HWbbS2uE3HGss1Ju0Zu6W5URN1C/2J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7184

From: Peng Fan <peng.fan@nxp.com>

When multiple devices share the same fwnode (e.g. the SCMI bus creates
both "pinctrl" and "pinctrl-imx" devices for SCMI_PROTOCOL_PINCTRL), only
the first device registered becomes the fwnode owner (fwnode->dev, set in
device_add()). If that owner never binds -- for example its driver returns
-ENODEV because it is blocklisted on this SoC, or because its driver is
not compiled in at all -- then driver_bound() is never called for it, so
fwnode_links_purge_suppliers() and fw_devlink_pickup_dangling_consumers()
are never run for the fwnode. The child fwnode supplier links (pin group
nodes such as lpi2c3grp, uart5grp, ...) stay unsatisfied and every
consumer of those child nodes defers probe forever.

On i.MX95 this manifests as a complete boot failure: the generic "pinctrl"
SCMI device claims fwnode ownership but its driver returns -ENODEV, while
the vendor "pinctrl-imx" device binds successfully. Because
dev->fwnode->dev still points at the rejected "pinctrl" device,
driver_bound() of "pinctrl-imx" skips the supplier purge and dangling
consumer pickup, so all I2C buses, SPI, UART, MMC, USB and PCIe
controllers wait forever for their pinctrl suppliers.

Fix this in two places:

1. In really_probe() failure path: when the driver definitively rejects
   a device (-ENODEV / -ENXIO), fw_devlink_release_shared_fwnode() is
   called. If the rejected device is the fwnode owner, it either
   transfers ownership to an already-bound sibling (and runs the
   purge/pickup on its behalf) or clears ownership so the next sibling
   to bind can re-acquire it.

2. In device_links_driver_bound(): re-acquire the fwnode when it is
   unowned (!fwnode->dev) or when the current owner has no driver at
   all (!fwnode->dev->driver, meaning the driver was never compiled in
   or loaded as a module). This covers the case where probe rejection
   never happens because no driver ever matches.

fwnode->dev is not serialized by a lock; instead every writer only ever
touches a fwnode->dev it already owns (== dev, as device_del() does when
it clears ownership) or one that is currently unowned (== NULL, as
device_add() does when it claims ownership). This patch follows the same
discipline: fw_devlink_release_shared_fwnode() only writes fwnode->dev
when this device is the current owner; device_links_driver_bound() only
claims fwnode->dev when it is NULL or when the current owner has no
driver (and therefore cannot be in the process of binding).

Fixes: f9aa460672c9 ("driver core: Refactor fw_devlink feature")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
This issue is triggered by 
aac4e67d6eb9 ("firmware: arm_scmi: Always create devices for standard protocols")
in linux-next next-20260925.

But I think this is a fix to
f9aa460672c9 ("driver core: Refactor fw_devlink feature")

Detailed information could be found in patch commit log.
---
 drivers/base/base.h |  1 +
 drivers/base/core.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/base/dd.c   |  9 ++++++++
 3 files changed, 73 insertions(+)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index a5b7abc10ff0..36d34aa328c5 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -292,6 +292,7 @@ void device_links_unbind_consumers(struct device *dev);
 bool device_link_flag_is_sync_state_only(u32 flags);
 void fw_devlink_drivers_done(void);
 void fw_devlink_probing_done(void);
+void fw_devlink_release_shared_fwnode(struct device *dev);
 
 #define dev_for_each_link_to_supplier(__link, __dev)	\
 	list_for_each_entry_srcu(__link, &(__dev)->links.suppliers, c_node, \
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5daa88fa724a..e76153d5f124 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1376,6 +1376,20 @@ void device_links_driver_bound(struct device *dev)
 	struct device_link *link, *ln;
 	LIST_HEAD(sync_list);
 
+	/*
+	 * Multiple devices may share the same fwnode (e.g. the SCMI bus
+	 * creates several devices per protocol node).  The first one
+	 * registered owns the fwnode; if that owner's driver is rejected
+	 * it relinquishes ownership (fwnode->dev == NULL, see
+	 * fw_devlink_release_shared_fwnode()).  If the owning device has
+	 * no driver at all (driver never compiled / loaded as module), it
+	 * will never bind, so it is safe to take over.  Re-acquire the
+	 * fwnode here so the purge/pickup still happens.
+	 */
+	if (dev->fwnode && (!dev->fwnode->dev ||
+	    (dev->fwnode->dev != dev && !dev->fwnode->dev->driver)))
+		dev->fwnode->dev = dev;
+
 	/*
 	 * If a device binds successfully, it's expected to have created all
 	 * the device links it needs to or make new device links as it needs
@@ -1390,6 +1404,7 @@ void device_links_driver_bound(struct device *dev)
 	 * consumers to defer probe indefinitely waiting for a device for the
 	 * child firmware node.
 	 */
+
 	if (dev->fwnode && dev->fwnode->dev == dev) {
 		fwnode_links_purge_suppliers(dev->fwnode);
 		fw_devlink_pickup_dangling_consumers(dev);
@@ -1474,6 +1489,54 @@ void device_links_driver_bound(struct device *dev)
 	device_links_flush_sync_list(&sync_list, dev);
 }
 
+static int fwnode_shared_bound_match(struct device *dev, const void *data)
+{
+	const struct device *rejected = data;
+
+	return dev != rejected && dev->fwnode == rejected->fwnode &&
+	       device_is_bound(dev);
+}
+
+/**
+ * fw_devlink_release_shared_fwnode - Hand off a shared fwnode on probe reject.
+ * @dev: Device whose driver just definitively rejected it (-ENODEV/-ENXIO).
+ *
+ * Several devices can share one fwnode (e.g. the SCMI bus creates both a
+ * "pinctrl" and a "pinctrl-imx" device for one protocol node). Only the first
+ * one registered owns the fwnode (fwnode->dev). If that owner's driver rejects
+ * the device, driver_bound() never runs for it, so the dangling consumers of
+ * the fwnode's child nodes are never picked up and defer probe forever.
+ *
+ * When the rejected device is the fwnode owner, relinquish ownership so those
+ * consumers can be resolved by a sibling that does bind:
+ *
+ *  - If a sibling has already bound, transfer ownership to it and run the
+ *    purge/pickup the owner could not do.
+ *  - Otherwise clear ownership so the next sibling to bind re-acquires it in
+ *    device_links_driver_bound() and runs the purge/pickup there.
+ *
+ * fwnode->dev is not lock-serialized; this only ever writes it when @dev is
+ * the current owner (fwnode->dev == dev), the same ownership-gated rule
+ * device_del() uses when it clears fwnode->dev on the owner.
+ */
+void fw_devlink_release_shared_fwnode(struct device *dev)
+{
+	struct device *sibling;
+
+	if (!dev->fwnode || dev->fwnode->dev != dev)
+		return;
+
+	sibling = bus_find_device(dev->bus, NULL, dev, fwnode_shared_bound_match);
+	if (sibling) {
+		dev->fwnode->dev = sibling;
+		fwnode_links_purge_suppliers(dev->fwnode);
+		fw_devlink_pickup_dangling_consumers(sibling);
+		put_device(sibling);
+	} else {
+		dev->fwnode->dev = NULL;
+	}
+}
+
 /**
  * __device_links_no_driver - Update links of a device without a driver.
  * @dev: Device without a drvier.
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f6525a7ee8c5..e19cfc91ebe1 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -762,6 +762,15 @@ static int really_probe(struct device *dev, const struct device_driver *drv)
 dev_groups_failed:
 	device_remove(dev);
 probe_failed:
+	/*
+	 * -ENODEV/-ENXIO mean the driver definitively rejected this device
+	 * (errors are returned as positive values at this label). If it owns a
+	 * fwnode shared with sibling devices (e.g. SCMI creates several devices
+	 * per protocol node), hand the fwnode off so its dangling child
+	 * consumers can be resolved by a sibling instead of deferring forever.
+	 */
+	if (ret == ENODEV || ret == ENXIO)
+		fw_devlink_release_shared_fwnode(dev);
 	driver_sysfs_remove(dev);
 sysfs_failed:
 	bus_notify(dev, BUS_NOTIFY_DRIVER_NOT_BOUND);

---
base-commit: f5f84daefcd92d7a630066635ecea1433ed5eac7
change-id: 20260928-driver-core-f1d9e991edb2

Best regards,
--  
Peng Fan <peng.fan@nxp.com>

