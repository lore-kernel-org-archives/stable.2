Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010014.outbound.protection.outlook.com [52.101.69.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B0F392823;
	Tue, 30 Jun 2026 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814109; cv=fail; b=EKcazsUia7QLOos96Q82yV6BnduiFzre3aPS5FQQZkaetq2810ln6DXMtrAGtH48NxINklXxWV1DQEcJ3yM7rlZgbe4Pofjl64yywdZUV1ysz2kh59kAIgB+Jn2m94box4FSwnKcF4+g1RogOAXcRvn4+cP+taNUcFcHEri6BJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814109; c=relaxed/simple;
	bh=18kxzLZ2njX1rLkyLYUAnKvGaKr/peUvP+bMrr8HpkA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=TiljHWO5hx9oKhR99cSxR2xtVCsTwNvmUOURxfr6mCvZxwBYM8gV1l0B5k9ksWNfMck/BBSFG8j7v2qxyQOyL7pUkTxz3ZhNBxOjH7Ft4uiXqgC7iOkwtcgQ9x59A8g/tZ+trRKpWCgoRt8F0ZDplA0ZBjec7ikKe2nyPO4IyS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=U7UUmKVg; arc=fail smtp.client-ip=52.101.69.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="U7UUmKVg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfWEuRnUMtxoCezBkXrZYDlAR63Zz0rTwmaw+qhDktZOJjr3TyONoqFkQ82Zzo+De3XyHInN5IYkXAaNzotkEFcuIw+6ZBdMnUviQP2XlfG+hhot6xmRLVkDPRuGP6ba5oBrTzEuQ4G15fzs/Bv7npqD1dmvwfKyCaJZJSnh5c7SWNYE/x6CbqJS5w5efmZPJe3bUkwUk6jFActdxQ0KBjSRCGTC6v/tlSnRLm9OXrN+5ZVh9ZC3ZtKRKcNjRchQbPdpzl5zsmh7uQY3ys2K9bTINN6IihXM6WyXZZRBLGZbPgzHFlCOkWCCW2dvmTxPs+/NMoF1GCT+nQSJbsfvbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnSWt7Am1oIlrp6yusCdalohKmrnvHnZOFTY9NYxwb8=;
 b=fXEbURPbfHrgRcsIWw11NKhDUZOZpRCI+mo8DBo287wgrA0Dw7Q71nsfmqwUiALkpOEsEZvw6+LzsofJP/0Fe/d8AWe3rWivvKsVdZu0rs+VjkDrIgj5YTi9vIm+AV+dNN2ych2+o6H6nulcALucuDpQSq28kYEqVhs/NLjlvdl2cW4S52/oNxvbORxV7PxS218+2H51eJs4AMfbuje5rFfT9NsUlK2LDoDaW2DtWQXr7I2HgZ+K0+cjYL/Vyh3+PoksaEuh9mPJPIQMETCNepuClO/co16psfyj6nhFqNOtHBzncWJrZfpwlVBBIKdSZ2LRpU/ixEmGCeCbfdZeYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnSWt7Am1oIlrp6yusCdalohKmrnvHnZOFTY9NYxwb8=;
 b=U7UUmKVgLhznAX42zue38XbfY7fwDSm9I03QUFWBpNBV5mtnA7neqNcoJYh0LteIw3ABON6iIc9gQavKeQR+2tD2Mjz151H7ag1wbS+Pfk10Ov4bnR4e1ypaKqkntHtZTHh8nG/WEEuDl9dZePEnzjucVlbDhhGhtN4wmgxZNN1K7fi5k/h9oGI8ZWqo3VIZvvNxx1iwd5CXSfu1PFRgpYNu6lrVA/fWh3JLDO0U+vkikyQ8HPb+ffsmL/Wcr6qSsNuW/COs5KkvslnX4ZsVcby3dT05DYZDjDPEEX7FOqSfNxQrw50KyrZZYtg9eus4i049/Hr/4XAGdsn2SjcHgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by GV1PR04MB10991.eurprd04.prod.outlook.com (2603:10a6:150:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 10:08:20 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 10:08:20 +0000
From: Xu Yang <xu.yang_2@oss.nxp.com>
Subject: [PATCH v5 0/5] phy: fsl-imx8mq-usb: few improvements
Date: Tue, 30 Jun 2026 18:11:27 +0800
Message-Id: <20260630-imx8mp-usb-phy-improvement-v5-0-25d616403844@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE+WQ2oC/33OvQ6CMBSG4Vsxna1pTqFUJ+/DONA/6dCftNhAC
 PduITE6Mb5neL6zoKyT1RndTgtKuthsg6/Rnk9IDr1/aWxVbQQEGGEEsHUTdxG/s8BxmGvGFIp
 22o+4gQ4UJVxxBqgCMWljpx1/PGsPNo8hzftWodv1y9IjtlBMcNcbwQ2/9kKyu5/iRQaHNrQ0/
 1B7CDUVEqCUAUPrj/IHrev6AZOr770LAQAA
X-Change-ID: 20260602-imx8mp-usb-phy-improvement-4272d308d862
To: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jun Li <jun.li@nxp.com>
Cc: linux-phy@lists.infradead.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>, stable@vger.kernel.org, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782814305; l=1781;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=18kxzLZ2njX1rLkyLYUAnKvGaKr/peUvP+bMrr8HpkA=;
 b=6h9DYm99OhchzfPqn3TVNo0+vfBo5/I7MtTCr1A5NFPRh8VCtvIZJllNvEoO2foXvsaZnLE6j
 Tv5KWqCW8LHAQKdHEiiqMzxuk16Yr7iNVm/PVHzwe4DSAOvqemv16K8
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|GV1PR04MB10991:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a2abaa-bb68-4032-3fc3-08ded68f82fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|19092799006|1800799024|18002099003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	KxePcuI40PKaPP1RzLf5OQOFUbEO2DalL1amYoxkn3n+Jib/bmiJIJErPPkkN/GrxowSmL3CoGpPfofT50SDZdAxd5y6wDBAa62+zzHFpNOuYkwsy5DXkMJLaGJ5L59o40lrOADk9YzRRRuV4xnzxN8TS6OC+Mv6t/4dNlJVyIeXF/Os1SN9d4hSHt4vn9n39TOXdJqCdLtbp3hmx4tyvVL8rtKw8KAQW0s5h/ba82fVZNUzmHrPS5+FoeXjk2ONRnlA2Hmt6vAlZ3dMBaCoS+vHHfmiRY16ADZkOJ4l1ZyDCsTzVs9XAuAw2hgmzv+Vk0YurqxGI1PuWMY9D8BBybGVqaZydBHp2Q1+Ie+ZBdi/LbXNUFH0+IUJA7i0OIzfwusjIACAXq9d5RbnEqc+jnaGcvLm5FWjnnF8KlPtSthLN3NCpfVXaT271TRdbtTbOuuVgq7zumkguTZj+/jElGmNZYnvrTiOc5WwLeyrMO5dk7FzMvmN2rog3b4LIsqjLq6djKi86iJo9EH9jedSjBodyKLK/xr6nozjmOzLXSoBmoHFHVeSnmYcK8BxOQ56yboi0YNDlzADD21lqFtFwvtXog3rG7dYX5u2MCJM6n8Rh1HDjY5X6ua5nglmMc27
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(19092799006)(1800799024)(18002099003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXVVdmtPOXNjRmJwb1ZKWGQ4Q1ZrSFlsY2I4cU52aHZSMmVVOVNoRmU1UENM?=
 =?utf-8?B?SG02RG1ZeXhZNVVzQSsvTDk0anhmZ0xXRHNPQVJXN3BpZW8vNnNPVzJEbjYw?=
 =?utf-8?B?TEJvYU1WRFZkSDRUbFdkR3VZd005eWlCMXJOUjA1KytVQms0VTZYNUMydVlh?=
 =?utf-8?B?SC8yWW9lck5CUHNlQkxZeXZnSmtKVHQ1aVN4SEhsWnhVNEdmcEI3cDduVDcz?=
 =?utf-8?B?RE1MSEFzb2l5N01kMHpEUGh6NjExOUg2NXJhVEN4Z0lHRkdnSzZsVmxNQm9i?=
 =?utf-8?B?R0cvRHcrYVhUZy9oSlhINFNadzMwTS94UEVKQkNsclhuNzRTZU5OZnVJelA1?=
 =?utf-8?B?U3ZhanhFQXlHM09LUUwyWjhpQkgxM3RzYzVEK2MwamJRU29hdCtVRUdwWGRl?=
 =?utf-8?B?d21qVHBBUjFEajBRb0NmSTFYa1g2Wk5VelVUdE9RY1RPY2sycnBIMk15bnp3?=
 =?utf-8?B?WDMrQm1HODN6NnFOaUxzcmIyUmRheXkvVWZaM1JYa0luVDBOQzlZV09SOGNV?=
 =?utf-8?B?WlFPUVhtUjdxV0RremFLSzVINVRnL1ZJTXQzcmNjRm5XMWdLeFhvSC9xTEpw?=
 =?utf-8?B?WjRHc3NZOVlsQzJDMC95NEF5OEljd1dkNFVjSjM4a0hkeHZoS0hjb0NsK04x?=
 =?utf-8?B?Nm5jY2FsNmN0UW13VzRWdmwwcHBHK3dDd2liUExKeXBsbm91Z1ZQeW1XQVFk?=
 =?utf-8?B?RHlVUUErZEhDdmFldXNMay94MDZ1SXZnMFNOSHZsMkJZNjNBbUNXa01hN29D?=
 =?utf-8?B?ZXViMEZpOHVJZ1k3QnV6RE9Bbmp1enEySm91eHVRYnlidDluc3l5ZGo4RmUr?=
 =?utf-8?B?ajAwU2FuL2RaYWhvY3VtQXpybVdZM0F4QTVJYzBYRUF2WU1oNFFpS2hoVXox?=
 =?utf-8?B?ZTczaWdNSWVGQmdiVzcrRGp3dEtvSFBsaktMeWdhTzMyTjQ4Y0tRNXNNaFRQ?=
 =?utf-8?B?SmpFK05IN2E3V0V3VkNxSmpTQU11Zi9zRVJUdEY1eklPa0VQK1ZpU2dqS3Y0?=
 =?utf-8?B?dnZpTjhuQ3pNOWFubzh2WHJnMTRVQ3hhTXdON0EvSk1SWnAvRUI5akxmZ2Ix?=
 =?utf-8?B?cW9DUi9ydGxJYUhTVUZaTUE5b1F3d1lDaVFiZnQwMkxQcHBHVVIxTkxUVEVu?=
 =?utf-8?B?UjM4bk5rL3hicHd3eTE3bDcxdnMvdGhrZUFZenhvL1RGY1pCM01iNHVKUVVI?=
 =?utf-8?B?aWdpaFEyUmN6T2pIYm9MbHBUekNGcmZTSWlrcUtyTEY2SlpKdGF6WlU2THQr?=
 =?utf-8?B?aElBSGpNREZOL0YvcVNtYTAreHNQREM4Ync3bVpoVVozdnVxQ0RPKzFSTkpG?=
 =?utf-8?B?QTdDaWJhRUtDVjBhR2ZvUmJVM1Q4QVhWdUFyS29zbkNoRk5pbDRENStmaDBN?=
 =?utf-8?B?SVA1WmUwNlVuZnVXN2FrakFZSTY1UjA5cUVsYkpBajZNNXVYV2FYaDFSODRh?=
 =?utf-8?B?dVYxMVpUOTFYdFEzZWxiTExIcU5IcUxlYVNRNVN1d3BjWDZLaU5aOE05QWZ1?=
 =?utf-8?B?RUtNRlBKWnJQaUJjbTNUMkJzamZpbDBiYVo4L3BmWTE1VDdidGFvcEhvUkdk?=
 =?utf-8?B?aHZDbmxQdUN6WVdBUFgyNVBzL1hVQ3gvVXhOckp0aDBDYkhidUZSQWg0bFMr?=
 =?utf-8?B?UkpLU0xVK2ZXWm1UTi9IajlKc2JKV1hNSTBNMlkrS0ZaLzZ4Q09USk9JZFVm?=
 =?utf-8?B?bXdtZlJXMEsyV2hxSTNPTWI1RkNjcWxTTS9nK3hLTHpNa1JaOGE2bCtyaVlD?=
 =?utf-8?B?YUh0SmVXY2J5RkFvdHJET0xKb2p4TW10Wi9GektwVWFVbWtPUmwzS1dqdVJm?=
 =?utf-8?B?SFlUTk1jNDR5Qlp3OFdYS0lodWpYbVduYTVEaElDY0dpTWFTQmw3T3U4MStv?=
 =?utf-8?B?NVZVMEEra2JNbnNjdXAzSmI3YkxXZ3dVNlgyazg3dmZOUzNQVU83ZVJ3MFV0?=
 =?utf-8?B?RlBpZStkRjFxcllaTmFrVWROWElBYmZLblpVTGI3SFV5aWRaT2twMG8rWmsr?=
 =?utf-8?B?Sy91UmwzSDJ4YVNhY0sxbC9YZnd2Si9yNTcvTmpzcXVLNVdvZHdkWVJYUnNm?=
 =?utf-8?B?R2NTQSszTFQ0OExoc05rS0dvWHh4aWdVVkhaOFE1YU51bnJsODNyczBsekZn?=
 =?utf-8?B?bzY2aXpiMDJ1L2Nsa1UxWEdZSHBHcDM4ZngvbHcvN09VTUszTnQ2Mnc1U2Vt?=
 =?utf-8?B?RGNUbFBJbU9CNlkvaE9SMndUMElFVU5rSDl4Y29GOGgwQXlKSDI2V2swbERU?=
 =?utf-8?B?STdEWklHMWVCRGx3cnRZQUtNTEQ3TDZNeHVTaVIxSHg1WnNKNGZZR3dIb2Vm?=
 =?utf-8?B?ZUgrMmMrT3FmbEdBYzRsN01FVDgwdzNlTWh4Rmw5QnkxbkxNOFd3RW5qMy9m?=
 =?utf-8?Q?0QsLXnib6MAU0CFeVBP8TyK/42TZ4lbYiMMc6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a2abaa-bb68-4032-3fc3-08ded68f82fa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 10:08:20.2899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CSl1VKDq3ffXVst2xL7ShlUCvrFpsprGlEQj7Earr03S366jZHSfObxv6RxUvsMha6IeTtcLdu+O67WWpyCELBQ+xwdoFhyukPxWLXCPDYN1EV1oxFplpbiFXQlAfI4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10991

This patchset is a continuous of v2, it mainly resolves some concerns
reported by sashiko-bot.

Patch #1 fix Type-C switch resource leak if probe() fails.
Patch #3 add runtime PM support to avoid register access issue if the
      USB controller enters into runtime suspended state, in this state
      accessing USB PHY register may lack some resources. This will also
      avoid regulator leak if power_on() fails.
Patch #4 add debug control register regmap
Patch #5 correct i.MX8MP USB runtime wakeup issue after introduce runtime
      PM support.

---
Changes in v5:
- not use devm runtime callback to avoid clk enable/disable imblance
- Link to v4: https://patch.msgid.link/20260605-imx8mp-usb-phy-improvement-v4-0-b2ddf2f3862c@nxp.com

Changes in v4:
- add Rb tag
- replace guard() with PM_RUNTIME_ACQUIRE()
- Link to v3: https://patch.msgid.link/20260603-imx8mp-usb-phy-improvement-v3-0-7afb8f89abc6@nxp.com

Link to v2:
 - https://lore.kernel.org/linux-phy/20260512101046.1498096-1-xu.yang_2@nxp.com/
 - https://lore.kernel.org/linux-phy/20260512101212.1498223-1-xu.yang_2@nxp.com/

---
Felix Gu (1):
      phy: fsl-imx8mq-usb: fix typec switch leak on probe error path

Xu Yang (4):
      phy: fsl-imx8mq-usb: set usb phy to be wakeup capable
      phy: fsl-imx8mq-usb: add runtime PM support
      phy: fsl-imx8mq-usb: add control register regmap
      phy: fsl-imx8mq-usb: keep PHY power domain runtime always-on for i.MX8MP

 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 131 +++++++++++++++++++++--------
 1 file changed, 96 insertions(+), 35 deletions(-)
---
base-commit: 7de6ae9e12207ec146f2f3f1e58d1a99317e88bc
change-id: 20260602-imx8mp-usb-phy-improvement-4272d308d862

Best regards,
--  
Xu Yang <xu.yang_2@nxp.com>

