Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011040.outbound.protection.outlook.com [40.107.130.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4FD3C1F4B;
	Tue,  9 Jun 2026 06:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986245; cv=fail; b=d04UcTg3hZqC4qs0UfAlgBKt7ehIwl6s8Joq1qwHOOARNeAt8bEnk8Oyb/bVq0V3G08QbuNkFKjhz+O9IGJPcdaDBsLTxEUka2x2u1lTpAHNq8Howbmkv7J1nMsCRYxwnxdEr76bBO1x24y74AK/dJouwrnG1MZSHIrO7Wpdo50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986245; c=relaxed/simple;
	bh=ChM6Xmi+OrpaDaZRR4LuTgJsBnkzKDxUww4gGYslkUU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Zd0SgUdsAPjejLkTPm+jcsSh9lkN9UnWryUlVvj9cl8WQ1XAQpd614S+SEL52LS4aj0I944cgNqlPx+SrK8jByrXGrx8c+O4yFVgI+mPPByXwlSl7/AsbJaI1MYTJva0xJa1dO7297IzOkkjTmFht4U7QFb6prH2tyd9/K1me3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Sl9UNKTJ; arc=fail smtp.client-ip=40.107.130.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Sl9UNKTJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjn2XSLkjLLBBO3r/tP3IyEpAlS+M6jqgigysfOOlbE9ILJ8ykSvHGdbqEonjjJjQ6qMHQYRPxXQ0lNNSFtEgnlLXu55ORTJ3jq6UnVXIlQ9IR3IB6QNPPZ9SBbkjI9PCat7sX/ayZm8+KgEr5dZkuYL2x3sD/elIR3f7tuoQPAKbdJfCixERJXySCrhPlG+j/4jITLgBW9h+70H2DaOGazXe/SPS3rDRpRJGGsch+kETps2U3Ol1/weinQN4BQQtjQaPekqPRBG5yiP6el1gKRFVZU4/Gx7o61asTKDgtj6HEReRpTWbtsFUeYTsWJp0vpB+cTFsphatl1vxrul+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zkwn2/QscLRTm4kq0gOmeosHPcn/UH9WZ/Z4eIQBSUU=;
 b=xuX7dvzLsFExT1/oMGWrhluPd0ne6qfT61wbytkolWf9SIUebdV1M9iMRZSAIMB9YxF6Nw6QxNaJqj0dqCdEfwy61N+qNwTAgQrLxNoz+4ohF4eXEBBundi5cuy4IiPkOuUFLRkd4T9mNu6QEL5fcwkHWUqW7OD+623Dj17rZRBD1jSkUxkOYjx6+QIKGn+vRUlZ5cPDIn1wnxPRMw1wXa6lhLiMTJ696pxJFpOvJvLLlyChTxoSforLfGo7a/wflzqvI48VNzXV6AyvJ+AmMwKCVCHHjSRqPgZZ89G5TH8vADys8c1hgx848V1uL+79UFeOgEJeVK7zkP0uCZ/lKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zkwn2/QscLRTm4kq0gOmeosHPcn/UH9WZ/Z4eIQBSUU=;
 b=Sl9UNKTJPcbBAOK2p/s84cCEXcgaO76+CPo5epEMCPyqZT34rn858nE4JC5URJyIpHmFsaR4iZluVGzs2E5JermuAVx7jU3gKwwG9qaaOVDDU5eDPGZgz+t8kltnZUVXMBbjLOlkDU71KGW6N8HA5NfMdKNdRmx79MQdieQpu/fL/vXf3eICze8J7KKmNJipeayT5BGmCRBXLr2IQ9PbLhb4TnAqepUVM5B9y9POPvvw7+0eAmaEZA14UEqG68xFm4q5r7Saw/uMKsyj7VBq8FXMWKkEVpm7OVf46NRi8YPIJVrVf9iJiHpvLzZsMaN1MovyoTu2HUUeTw7Rl+Vn4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com (2603:10a6:20b:447::16)
 by VI0PR04MB11670.eurprd04.prod.outlook.com (2603:10a6:800:2fc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 06:24:01 +0000
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb]) by AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 06:24:00 +0000
From: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Subject: [PATCH 0/2] pmdomain: imx93: Fix shared MIPI PHY resource
 management
Date: Tue, 09 Jun 2026 14:26:39 +0800
Message-Id: <20260609-pm_imx93-v1-0-d06c004b0f51@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB+yJ2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwML3YLc+MzcCktjXbPk5GTDxERDQ0tjIyWg8oKi1LTMCrBR0bG1tQD
 tA+hoWgAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
 Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Guoniu Zhou <guoniu.zhou@oss.nxp.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780986431; l=1185;
 i=guoniu.zhou@oss.nxp.com; s=20250815; h=from:subject:message-id;
 bh=ChM6Xmi+OrpaDaZRR4LuTgJsBnkzKDxUww4gGYslkUU=;
 b=mu8XZ2WlvAI2WQZOsiAaeE/xnj6UjeY9bAsm4maGdfAn4csLZEFlMcyauLiOhizdDQcQd2deV
 YsNSO/HgxbLBZM1ink9DYyScFvNkUhowBM4LXXHqLCp6lKHL2yWODVC
X-Developer-Key: i=guoniu.zhou@oss.nxp.com; a=ed25519;
 pk=MM+/XICg5S78/gs+f9wtGP6yIvkyjTdZwfaxXeu5rlo=
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To AS8PR04MB9080.eurprd04.prod.outlook.com
 (2603:10a6:20b:447::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9080:EE_|VI0PR04MB11670:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a408dc-38ec-41ca-ed63-08dec5efb1e1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|38350700014|921020|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	eWKLmflaf1wQhHL9xo5aWV3xoIHgxV51kMnTzUF8a9Kg71rguTA0Vrr8kP9ZlUHziI1TJnglADROt2Od0AkKD9KbBKKz4S1/7NZ7B0lq3PWaLaMtHshycQ9PaI37YosFh2OF/mI15Zvl3TgX5PIU6bKRnFiuyyfbh8d4x79Z+E49icGJeK8INIdNGGpDftZizWjeTeJv/YGhBUiHWOgS+TvNSsC64FJjuriDCPVIinSV5MtBO0QvJbYrWQkxPSubEnEhxTVplpxnMtP+7HQtgOkijO+/7A2yywtjVhWPUyIH0FkQX9mjagx6+zu8xpP7uBdvEhLr/2EHRdh/1NHSi8c6NOFYUJu2b1Iokw6Ix0WPKf3dAD53ufwqJ4y/cMchOLUm6VQQiGM/4sXMsXi0e2CjDfvZ0h5DAIVGQGloW2LyiBbZPXTSeZp1YhSwSUp61WaVzbdmwuDQtmA/emWdRVYRED2M2q9yncAz5tyFF79wa8+V1DnUBxGWKS4MyzqB35cfmk7/KgCmGy1/hUR48/WO1GzbqT0A7DL2mUIUKhLE0rrYrKzooia2MZef0JWKVcNwD3xXtfcJvR5joisksK3ZAbxbJyiMVcB1O9eqTZZq3TKmMUJ/cDCDfwz7CQYNNpjUMtS0pMlUY66WPzmw2/adXEV7tBoUaDp8uT/t3QbDHGNfQH7e6dEncfsL84n/dEE1IbY0TxZf6UOx8ZJtyuT+iFgl6nkUBOr5ID+MOUinQmf4GyvywDziYCPnIJRO0xyOHWHZ5udTV0covzeKkA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9080.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(38350700014)(921020)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmVnUmJqQzgvV0hQQi9BN3VwUzlIdTcySEx2WUJFWTd0a3dxcmdSSFNDNEVm?=
 =?utf-8?B?MTROZ2JJN3M1K0V0dE9rZzZaVjFRMHRmbHZFaTlkL2lCcDIwYmJnNjRMMndK?=
 =?utf-8?B?ODRncjVMTzFqa200VVlWeFRmUkh1UmRYVDkwS3duNHF6WmtXbGVRejdwSFlN?=
 =?utf-8?B?NURVcEszZFJidThPQ3F2K2pMS1Z2R2c1N1k2V0JabU8rbDFpU2NRbnJrd25z?=
 =?utf-8?B?S3dkYTVML2E1eUVzS0NveHZJMXhjb1NkcE1GdG5yV2tlKytPQXpEdEVvRzJU?=
 =?utf-8?B?T2NnalBlMW9PNWxQNFNYWjlzRkk3Ry9qakc3bEtrTmNrQkYzWW1jMkNRMm0w?=
 =?utf-8?B?Q2NQTkFMdlQxYzg4QWllTElVVlMxTFZtcW93bkg5elo1L1hPYmtoL0RHaU4r?=
 =?utf-8?B?N2M3RVZsMVFEY2MzRWJmNEdRd3A0K2E1cXdmOFRPekFXMm4zOUhXb2tOYnNt?=
 =?utf-8?B?VGxpclJvd3VwTzdQellUTE55TWRYT2x0N0FqdVB6ejQ5cVJ0R0NwVlozbkh4?=
 =?utf-8?B?bmF1RUQ1U1NYQSt6RkhzZjdCN3REWlIzbW1ZU3drd0FBSFFoRkFvMTROYzg2?=
 =?utf-8?B?Q2YwaUtVem9rc05hUGFVSmxzejA0NHNkeXJ6MTJzUmNtVGI4YmZ6Q3dqMmxY?=
 =?utf-8?B?NFIyU2VuTjVaOG50MWowTnFTYVNwRm00QTEyTG93YzBFYzc3U3lCRHE3eUFP?=
 =?utf-8?B?dDhoZ01ybkdNNkNubG9xZWpQck5nU1Z0WElkbVdaMHNaVlJidFk2R1Vhc1Nl?=
 =?utf-8?B?V3R0eVpZZm1KQWx1cVp6b1NLSFVQMDZ2OFd3aTNvR1RaeS9DVFpnTmpQREdY?=
 =?utf-8?B?REd4R0NEaVc1ZHBCajk5bjZ6ZVZPUjlDT1dFWnRhTENQdG94UVdLN0JHTFln?=
 =?utf-8?B?cGVqSDNnK0tzK1AwbURUNzZPV1lITVVtVG1yRFhlbjQ0eDZob1NWaXl4VGdv?=
 =?utf-8?B?YWxWUGoyRFlZQmxpcFFIektvN2w0K28yMU1xMzcxZEM0VDFwc29jazQyMGRj?=
 =?utf-8?B?QVR4L2ZSTmw5RW0zWDFxK0ljd0tlMjZYK25aSVk5a04rTHZqWVdBNmcyZnJG?=
 =?utf-8?B?Vk9NNXByckM5ZlRkMmNZQWhVeUZwKzlwVERNYmZ5c3JCdGxzTlk4WG01SVlw?=
 =?utf-8?B?aTZOVEJaRi9DdDI3ekgyVU5ueDhWTThpYzgzUlgvTUlzbXB0dWFENStzcmxt?=
 =?utf-8?B?N1NmT0RSZU44N3YvSGFhaElvRTRMSEdIL3IyaklWOGxvVk91R1BMeXNHRDRK?=
 =?utf-8?B?bGpjcUYrOUFCdDU4RUg5bzdVa1dna1BCeitVOVllRmlVS3pUaHV6Qi9tKzNB?=
 =?utf-8?B?NlZ3N0I5TTA3Q1B3eEQ4aWVldjM0bGVZVUJOYXFvSTdaa3ZuTjQwZGVxSVpk?=
 =?utf-8?B?MUNkSkcrSGNFR0JXSWpZZVk4Zm9GZExpVDU5MjRuYVVkd3RpUE8vakFmNzJk?=
 =?utf-8?B?aEdqSGxjZEJKTGJtc0d5YnJHZXRKWlVtMVYyeU5XT1pVUmM1RSt2OXFRY1R4?=
 =?utf-8?B?cDBqZlY3VGlkQTRWQ2lMR0w3QUNZY1BzVXJoV2ZtU0l0YzlFcUUzNlVIUHdZ?=
 =?utf-8?B?RGVuODdTaVVCODM3LzZCN09DOE9paWxZbDI1bDB0YUgyeVlROUhHTTFDWDFn?=
 =?utf-8?B?OUkxVzRtd3VmMFNmbkhrRnBGemk0Y3FCcGREN1BKYUo0Vm1jdjFONVVlNWJy?=
 =?utf-8?B?OEJBMjlIUXlNbHlISDNSL25kS05FYjRJNytqK0YyZlZtZmFOWllOb0J0enlZ?=
 =?utf-8?B?MThpWkhCQ2FERU5yTFBoampSV2c1VWc2NDJUWVFidnFCWE80OFhodDRpZlFN?=
 =?utf-8?B?QW0wWXUzaVMwUTdxSVlQR2hRNEFqTEZZRXJaOXJzRG5Ub3lxRUkzSHJnSzNa?=
 =?utf-8?B?ZllNdkE1SGxuVnUramJ6aFdjZGwwY2RSRFU4NUNaN0ZSMHMzL0dsQXl5Y0hv?=
 =?utf-8?B?aHQ4VHdLU3lkTk9nMzdwUkNDREN2eVZqU0NtWEp4enVBTnJZMWtaUUtObEFi?=
 =?utf-8?B?Rk8xWDNPV0RLMnV4MUIvbXVZQnVFaklVak1MalJpeVBTdlpMTytqZGkxbmJY?=
 =?utf-8?B?U2VFQjJiM3ZrQXFBUVN3a1VNSW14bytvN0lKOGcxbUhEb3VqS2ZVZ1F3aTFW?=
 =?utf-8?B?cExFUGIxcW1hT2RzSkhsR1NvZFFNemk4bDZLdzNJTkpLUmpXeThBZFB5OGN6?=
 =?utf-8?B?aEVXQk9ERENDNkp6Y1V2enBSdUVRd2txQWlIeldwenJ0ZStqd2Z0dTJHL2th?=
 =?utf-8?B?MVRlNjFrU2U3cU9xQXBzWitYWUJ1T3VtRmpqMEZac0lQNTJrcGc3dStaZzF5?=
 =?utf-8?B?RUpUYUp3QlUrQXdDZnhSM09ONkdqVUFQU3VtUy9mdnZOd1l5dndWQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a408dc-38ec-41ca-ed63-08dec5efb1e1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9080.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 06:24:00.7401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ln82O4WjcBkntIyb8OMA4EwIfss6z/DsKrQxCeDeEnqcEXhae025PQVhSmvOfixXkoLqcWn/5pSEW5dtkJjeLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11670

The i.MX93 MIPI DSI and CSI domains share control bits for clock and
reset in the media block controller. This creates a resource conflict
where one domain can inadvertently disable shared resources while the
other domain is still active, leading to system instability.

This series fixes the issue by introducing a dedicated MIPI PHY power
domain that owns the shared clock and reset control bits. The DSI and
CSI domains are then made subdomains of this PHY domain, ensuring proper
reference counting and preventing premature resource shutdown.

Tested on i.MX93 EVK with concurrent DSI and CSI operations.

Signed-off-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
---
Guoniu Zhou (2):
      dt-bindings: power: imx93: Add MIPI PHY power domain
      pmdomain: imx93-blk-ctrl: Extract PHY as shared domain for DSI/CSI

 drivers/pmdomain/imx/imx93-blk-ctrl.c       | 60 ++++++++++++++++++++++++++++-
 include/dt-bindings/power/fsl,imx93-power.h |  1 +
 2 files changed, 59 insertions(+), 2 deletions(-)
---
base-commit: 3b7a18a34e8d3b14c7c926f033488a0350de9759
change-id: 20260608-pm_imx93-6ccc1aa11932

Best regards,
-- 
Guoniu Zhou <guoniu.zhou@oss.nxp.com>

