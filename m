Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EBB37B032;
	Wed,  3 Jun 2026 05:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780464861; cv=fail; b=TXE5lfx9egcYuxVVIUeczk+MDK6Z5qgO9tvQgEx3xQxw7yO7cXkZeuo812RNX+zLhPacM3JW8jQhfZJAxGezCYztd+fqvI840w1mBL1xdJzwxgnTqAZs8Azry4/JAa5zbh3rF/LpbxxSq/PpGOyU8OaysJS5bOO947gXBNUePn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780464861; c=relaxed/simple;
	bh=LxWvs2ZDP9+Y1cZaL4e8N88ZPhWjGXB1bYSf4IBmMbI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=kILSEaglzPiG2YH+5i4G/cOweYf6OFCXXNnsOWMra3E6s6fw543hndolw+Tgt0STEo/YFE+wZ2NdekHsj+reVNNErAEUq+aClGBR15jmkLTwrZcyBujMZrqHjJ+WFezegAoJ04hMVfIO+rmhYWGAPvuX0ZD4eZEToiqUdtGyZMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Jj7AXLPp; arc=fail smtp.client-ip=52.101.69.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Jj7AXLPp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTqi6N3pMuidDFfjEFWYWnLa6yLAeTWF/5qrNyt/88QZr4FefTh40vFgi8dH9uOGt/KFGMrx4BRkeU/b5gXaFnjqRPheMz/h2onnSGgzQ2RwaIjDYrk305jPkRLB2SrChO+1hFb0zv2m2wnZIVhraDgd9H4Hkv1xlfEQoR23gWrf2PxFTNcsr1YrGILlmwwuEFnpwvY1MgmrutG3X9Kjye4Xpi2ezDwJwM7X1eEI6JMHxSL+cvTQiA8FugBG4dIlPj559dMO7gauzoeBL2hIC1m4eybVjsrYRWWzRSR9JPQ+my+KyFahYbqyMpo2wZUaSMZn++SOWus+AQIcfqzu7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXcRDt0+BRrzloyW/TfQQg6sB41JhWRlezZf/6kAUnE=;
 b=lSaEJ869sKGxiDg24yZK56iZDesAkmnXhxuWot3JBFIeLP9hYW0/vUT2fzM8ilk//DAeRObwWGrhbz8EYh/9npM1KbvC3XwXqXeEM3It8/5EniyuUQMC589kLUyZl06V9sKucUpPSyd4QLoVE0dWZdydebVXpCE9qGjMeEnoqdDahNi+fiCncta7Ix+hqc5oQRK88TTA2/x/pqJBVv49+lybMH/9pcdALGj06G5PEqiaM/XfVcaC32CwPZCssLW7RY/0/Aprb1y6tIvhi000z4KjXsBEXvds+4ipVTGi6Z/rs1nipE+HGS8/JFTtnhGjqstZRL7cS7S1+DDqlaxTWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXcRDt0+BRrzloyW/TfQQg6sB41JhWRlezZf/6kAUnE=;
 b=Jj7AXLPpIXbHAHpXwcehRlV6QJGOKTHh1eSESOeBFpi3qmO/ugsYKGrfdRP4yBRNTKkl57VEZG7odJtr37Xk6r/0Pczyzsn3uqdrYAREs0sAc0oOiTxcSr9omXO1QQG7zCkPpwsClzgS3rVPbylpSURVSW9SovAnSEhJUczkEEl29mZfythWMUt4LCdCgj16gJdZfB788R6MsJ+MTfvQU7lQPpwnsGPLTV5KiL+aVAIcsh5mCya2crLb5STAnEvqKWkSCxksHhrkr3pzlnu++zkFGbfQxuJ2U9uil5GuPyWXUhcYgdHXTIPQwbkhtLMUyzT0H2Y+hO3uNzgBmJoKQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by AS8PR04MB8150.eurprd04.prod.outlook.com (2603:10a6:20b:3f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 05:34:15 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0071.015; Wed, 3 Jun 2026
 05:34:15 +0000
From: Xu Yang <xu.yang_2@oss.nxp.com>
Subject: [PATCH v3 0/5] phy: fsl-imx8mq-usb: few improvements
Date: Wed, 03 Jun 2026 13:37:13 +0800
Message-Id: <20260603-imx8mp-usb-phy-improvement-v3-0-7afb8f89abc6@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIq9H2oC/x3MQQ5AMBAAwK/Inm3SLKnGV8QBXeyh1bQIEX/XO
 M5lHkgchRO0xQORT0my+YyqLGBaB78wis0GUqSVVoTiLuMCHmnEsN6ZIW4nO/Y71tSQrZSxRhP
 kIESe5frzrn/fDyDmC9VsAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780465041; l=1407;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=LxWvs2ZDP9+Y1cZaL4e8N88ZPhWjGXB1bYSf4IBmMbI=;
 b=9JC93FCNNwsURamMYZKL4hEcXa7tC9CFWyk1cEBashF/KrceHZN7rLbEqT9YOLD/ioBXKDkHh
 OkFyNTslivID0bAst4puW16jHe67KtS+XurVJyIH4qZgWJnMoKXUL/t
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|AS8PR04MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a6e2ba-6c21-4f7f-ae6c-08dec131bfbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016|18002099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	kAmzCVs+1Ip2VyBJn9WWyrgLqVkr5999bc5u9Y2PwLadnpEANuP9FbaVv0HU1B0zJkgbP/cYoRszSPPA/THYZt0tKMD3u+SCaxMDNsGwmwl+R6HtyWmZNO7dS7iw6vdcyWs4F3xOmUT0sjTRR8uFPRFTz0i/MBXcEGLGpUvEa8cYSdz0O49FramtgF3kc3jpSufDa11lFjDlv/FF0BOkCv6HJPlqqVKP30fXsQgw0HlCphMzK663oNO+gPVsXxUuNYfIbLktVOj3VauhYI+fRHRz80woXv9BUoiR3S2QKTyn+yE22ZbFv5GUDVkpvG7CHsnniLkD+aPWy+zzPzYCwgq+jM36WZGfVqoX3fwLqGt+uJGYwPn3aX+MBsDkz6aoEO0TtTphmmp66zeP14rimmQpw+xFCpwNswbXTAWemTQ/uqqP6j6jW/86jQP5QwnhO5rA/v2wN+R+lo7APMvNLqDjvMAlTDNxjcEeBi+KAm44gzRxWBRrqdoPyvxwDQWfjPnBMjROngp8fVJv3j3LeAxXrqvgrD1VAPRQ1QTyfCUEr4rzoMIzBp0onteNnAk4QuOwd/lGki02VqQ8HnJZfo2QLZhP20Oh+jhyDPDxnHIFEozy591yIY87nfnRMvvVgD92cyu0Iyn0gIqwRRkRV2auKJxkpF0znTLR/IBM+H2sW60FWNkKjh108BKjXQZI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016)(18002099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWduZFpvQlJLTEttaHNKRGhZa2xIUXlVSzVrbVgrVjNEL0VrdmY4VWJUbnJi?=
 =?utf-8?B?UTFPQzZOZ0pFMjU0RTBNdGR0cHFXL3F0S1EzSHZzejRBckYzZjZOZWRXWXFz?=
 =?utf-8?B?OXo1Nzc4YnJIUHlvZVpKbTllU0g2N09TQ2pkT20rVDA5UlpVUnJHenFKV0tK?=
 =?utf-8?B?QzVkTjY4aFNhQmk5MVM1Z3RnQzVvK3dYQVZZR1ZnUWdyRTJDd0QwRHZoSE9I?=
 =?utf-8?B?WXFwK2UzdXMxb3VseE43NUd5MHJ4N2ZRUmNGMkZ5MUpxVEU2QlU0RnFudUxy?=
 =?utf-8?B?NlBEeGpNbTBRUHRBY0ltUkUxR1BPZkFFc2s1MTM1TFAwUWpYQWVna2g2T3JM?=
 =?utf-8?B?WU9xRnAvWWJkU0RmaXlTK3d4dkFscFYwTE9jZTdPcVFaRWNCdE50ekQvbUkw?=
 =?utf-8?B?NXY1WmJvbEtSNFpRbHdReVlMRW91YTdyc2JxTXNveGt6Vm81cFdTOUdKaEhO?=
 =?utf-8?B?SEpiOUxUanUvR1dUODY2OEU1U3B6Y3IwbUdoOERHb0VzWU5XTlJvbmZpdDRs?=
 =?utf-8?B?NEwvUUZ1S2N4VWludmo3OFlZcFZhbDN6U1FiMWlDSGYwd1JCdGxZVHJReW84?=
 =?utf-8?B?S000V05xdkF3MTFHNCs3cDVRZ0JBcFhrSXVKaGt1dmhiNm8wN0xFcG9lYm5P?=
 =?utf-8?B?a0J1U2U0NVZYWW1jMGxIYS9mNUUwSGY4UjhlUnRUVlBsVEUxWE1GSUFNNW9n?=
 =?utf-8?B?Z3VpalhPbzlCUGYwSFV1RkJGMnFBdmYrR3ZPUWlzeldLNllaNzBPZHRkVkkv?=
 =?utf-8?B?OU1HUXkrQ3VhUTd5RHNMRWNwOW53Y2J0VmdqMXB3ZlNCSFQvakNUU2loSThP?=
 =?utf-8?B?RGVhMXgrUXJzbUVqWHVLVEhUZy9LS2VnUGFPejhaZVlXTkl6SldKVlo4TnR2?=
 =?utf-8?B?MWZZUERrTHN2ejYrZG0xNjkvWlFieUpuY08vQUwwTTdQZGt5OXNEalhOUlNL?=
 =?utf-8?B?eTN3b2ZmQ2tOUTc3YU0yQlQvQnE2cDNKY3BsN0sxSFR3eGE1dnNCT0RKOFV0?=
 =?utf-8?B?OG9lTFZkOEZoUldOWEQrT3FtZkcyT3BKRUttbmFSQmZiZ1o2WWRwSXF6dWFK?=
 =?utf-8?B?UXRmNklJTGNjU3pQQm5SdkNLTTA3ajFUNVJwMkpGaXZscjZIc1R1RmV4Znc2?=
 =?utf-8?B?bEo2UHorb2toNmY4YTZhUmtSQ3Y1STFYVjlzOUJLMTh5L0NBNTdvV1hDZGd3?=
 =?utf-8?B?cGZCUlpaeldHZitXMFI4RTI2bUJZUEVPeU1vbjdsdmZOMHp0akUwVVBiWlhZ?=
 =?utf-8?B?c3pNK0czbFhNSU4xd2JKUXQ3ZktkWEhRdExNdUNUOElxOVNYRDZIN3ZYaVho?=
 =?utf-8?B?VmVmVklhaXgwcU1SVUlESkY5aVNMME1QT0E4bG9aS1hTWE1oNlVKdDc4bEJV?=
 =?utf-8?B?RFJpOTZOVFhpUFlQQk95dVB4bHlEZ0M0Vk5WbUQwZnNUUjl6VXI0WWpKR2Q4?=
 =?utf-8?B?K2lwd25JMGlab01jM0dFbkNPVTYwbExOWGw0QlB0RVZudGFjVS9NQjR5WTE1?=
 =?utf-8?B?YTlLZDhZL0dMQ2hDemwzWFhjREs1dlFTM0hQWm9Ta2lYdmVxRFVTVFBxSTJK?=
 =?utf-8?B?cTBsdE92eFJFcGJFWTMvS3BrVU4zOS9PdWFES2twRExWTVNJdE1oWlhrUzdz?=
 =?utf-8?B?enBlUHh1TTJmWC9XWHJmTlJucUZsTjdqcThMayt2RXByNnFKaFh3enpDVXZo?=
 =?utf-8?B?TGxSTWpnZndCZ2x5azRjUGFLUjVBZTBIcVBQRUFZeW5UamhXTVQwS0tVbmsr?=
 =?utf-8?B?ejZpMXd0eTFJbkx3STFXZG9YdnZiMVBwWmdodTBsZzB0NG9TYkZJUXhKL215?=
 =?utf-8?B?VlhsVUUvNlZWRHpBMjRhajVYOVZBZzFTYzd2OXlqRnpxM0RwQmdpbS91VGdE?=
 =?utf-8?B?U0tmUWsya0V4QWh1T0xTQlJkcEZidzZsZVBaK0JOZUJJU1AyUFozTTEwNFNs?=
 =?utf-8?B?elI4bE5QMm1FNHNuaUhLc0wzNkhFZWlXVE1zMnlaeEdsNXpaK0dYcjhBUHZ5?=
 =?utf-8?B?RmlQUUdsdlY3L1ExbzYrMi9RVXlLdmYrWkl0YmJXRGtHSm5sOTloTlh4MkFi?=
 =?utf-8?B?d0NXZytscTNUSW5KYWxVb2cvRGc3RDJGSVh2VWIzeTN1UjJGdDRJV1J1bmsy?=
 =?utf-8?B?T24rSzRiY0s3ZjVrNE5QdzdYQ0ZvMHMvenRXbjVsVnRWTTl1RDdMMFJrdGtX?=
 =?utf-8?B?RGJneHZmc3M4MTYrRUNwKzlmZ3VpbWppWEZEckpGdSs2aFJsSTRGa29uTlBP?=
 =?utf-8?B?eGUzdHcyMG02ZFgxaHJyWFZKSjJhS3JjS0FVUlZwdk5XcFNpWjh6eUg2b3Z6?=
 =?utf-8?B?VkYrZXlVR3djV2s4QlNXTEErN1R2RTYwb1YvR2hmQ29MY2NjY25jeFFscFdj?=
 =?utf-8?Q?DLevklNMA6oZIidtXyUy00J3DO4QeS44gAIaO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a6e2ba-6c21-4f7f-ae6c-08dec131bfbf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 05:34:15.1145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yarG2S4AazaLqBLKgsp3Ej3W4psPEiuowUXpeJ6iYrgcQVrwuX5VDOsyuPCdtEk8JVRht8fReMBk2QJkGubaOQB/tKQiOMkPQcwgpmD8zr8xpDPkSJfFhti8CPiCwvYC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8150

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

 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 125 ++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 37 deletions(-)
---
base-commit: 08484c504b55a98bd100527fbe10a3caf55ff3ff
change-id: 20260602-imx8mp-usb-phy-improvement-4272d308d862

Best regards,
--  
Xu Yang <xu.yang_2@nxp.com>

