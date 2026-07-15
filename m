Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013068.outbound.protection.outlook.com [52.101.72.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1D3353A7F;
	Wed, 15 Jul 2026 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115034; cv=fail; b=f4srlVCtlb9v16vScMT0Fp0mQpOMG8ED00PTCICFKc7/fPoQT3KrncjhhcdmkrmbvMJrlkKWyRiHIdP5l5ua6OSHy1KNvQElKrEV9XVACcvXTtbnwlPITNgv7kyBGCje4LFO5kV31SO8NZPe7p8+jEUhmivMoXjPsdHyNK4AZew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115034; c=relaxed/simple;
	bh=1hc7hpppuXD3qASfv+sk9Z79rdi6tKFOgdwb+NE/DKk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=dkV6O/qdB1Whhee4uwpf/6Wb0oN5jQzQAK7qSVg4K1tOdnk54fXDMH+ABFWX28PYGtZpOEbbwGRcxl6Z1aheREX4sXFgcf//y5OAuDOSbjTkWf5zynVAh6AJhVDGXOysUH/4OSz9HFDLpNZysZ577yG0rbAh5HP7wONgGhQovRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VwQvmLXf; arc=fail smtp.client-ip=52.101.72.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VwQvmLXf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PunSms4zNYEZinTaFq1O3jC3KhFJEba1cppG0U5QxwtmFLPY7ga+Dke/XqUMxM6mRwegqVMfT3EPordKw7J0voqTXfZeVlAlU2hxxoG8taPr8uL057nEAIgAHEaGhnZrauWtqP/LzX9Whi9nF7fdBj0K852JMaN/dWHdcYNyH0GQ4ccyT1zh/4GIsYxEwbIlPnuAtBSQGd2sSpho8LvsrBciAWJAOqqGwFmX132BmsNEPIBvCamHfwqqDJfbWagZbi1UxdyCyjdj3AQ5Xij0yvbSe1WXXQkLVOfbyf+fc4zfbzqNNGRxsS1gd538r+bA+aB7vrHuhd+ZrphusEoexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrEoK95xb+2ZrH3XGzXeroxxZyUSkYn/xzGO08Wpo08=;
 b=aKGn2etskM29ni7RnlWdTniUoycM63LLF6YloTa39InVyD8bJpmw0nph3Hr0sGSUAGoaHx6YCGIDHKzbgs6X/qFtWglsADoSIerSv25kGrlG9Ux5pYBwiYXYfdjwuG23DUBIIYGl+GTMbz0qp28y5HSJPU156ZamjQ71wRUH3LOm4e77qKRyrARn9ysiiiR6YIXKjo2aQYttl7C8Xn7BPBqWNUdI/ZioI5pmE5JX8AYq5fQ2DK8c6y5ouMbpq8QSzVUGn5zkAlv/uqrwg3hdzO4A0gtOD0JKLBcR5AU6YpSzcf3TS9KhwC12TK6MBGz+UQfmdKqhwdxpUD//dTVPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrEoK95xb+2ZrH3XGzXeroxxZyUSkYn/xzGO08Wpo08=;
 b=VwQvmLXfmd0Xae7a6JYSpRmc1Qp9KmHb9vwB9HwUxfl12X7/x/6MPdPBN3pyfYz1HwbPOaQgsea/3lDSrkYkNDimVu3o2erM2nExd+Zo0a+99irPeRDtDFrm+fcjvrZyCneBVyEwpAdGSetsIavlREB27wca1vz0Aq9MuUEiXSFeSSUCPET1b3y02k/c2bc1PDXucSgO+xU5HfNFa7t/rPqGvepOzaY9VeTnWYT7mLDdsjXTrZVnd5/CoHD/D7VGktV4uDTjrK5TJgMFKjFifJYT1lZbOJJPCVY4C7nQleNT29tuPum5nKKyhFPOBuyPE9s/WJZEzOgFUprcqZ64sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by GV1PR04MB9134.eurprd04.prod.outlook.com (2603:10a6:150:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 11:30:28 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0202.014; Wed, 15 Jul 2026
 11:30:28 +0000
From: Xu Yang <xu.yang_2@oss.nxp.com>
Subject: [PATCH v6 0/6] phy: fsl-imx8mq-usb: few improvements
Date: Wed, 15 Jul 2026 19:33:55 +0800
Message-Id: <20260715-imx8mp-usb-phy-improvement-v6-0-00d95e270e4c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACNwV2oC/33OvQ6CMBSG4Vshna2pp6VUJ+/DONA/6QA0LTYQw
 r1bSIy4ML5neL4zo2iCMxHdihkFk1x0fZeDnwqkmrp7Gex0bgQEOOEEsGtH0Xr8jhL7ZsrpQ59
 Ma7oBM6hAUyK04IAy4IOxbtzwxzN34+LQh2nbSnS9fll6xCaKCa5qK4UV11oqfu9Gf1Z9i1Y0s
 T1UHkIsQxK0tmBp/lH9Q+UOouQQKjMEpeYXzggVjP2gZVk+K6D9d1QBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784115243; l=2097;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=1hc7hpppuXD3qASfv+sk9Z79rdi6tKFOgdwb+NE/DKk=;
 b=KDJxYae6xEd8hI+Z+FHv61mk4mRGqB4lhsLFTbeOrQv+XUkdxVB6c7in8Y2dGWfiMGa2/S6du
 O4nSRvo84HeD5ii2U/4rylHGEgqJI0/vJEaBIe/PepP6siAGUNvSCZo
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SI3PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::6) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|GV1PR04MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: 1319095f-586e-4792-5438-08dee264782a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|19092799006|366016|1800799024|10067099003|56012099006|18002099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	sRvut4AAlFcfn/Ncj5i232m5GwxW3bLFm9ZE3xVgAhpiGqGM8bCde1tbFZJiBDsNCIpcBkMycRpZRaEE1zWW4k3SX5hQtwJyBYOoTtbGD+IGp7agWUFnSKAh8jdG8XLvlSRSjcKRO7QRmqYLebML/rL6Eejgr6m3azpcvSwjo2cfs4hKSnlp6I97MAAfdmYdFxfio0pslo3hq3wqN3xnAC+f7KF+afD4cYhzq05OinZ2sOpk/W4t2s47mhAodHXrG7iQJSsvhKN8AAuyqb3n1knXuycTMQC4J2oqH30VuvsfIXKqgG8rfPqaRjS+hjr+LuahzsOuziO5qCvc2ADATlA5IqyT6K3Lc6GwLV2wemFATKHZtO0+XY9k9KKu6KJjusZW0jsZA6eL50Oy9z2Yp0ktiwbAgmvtZEnIK5H9xC/Sk+tzOu63CZj0h6b+xrhpiUfpdPRWylslxgpPT0CloPxVgj4d2M5SGjR7Ny1FipXCWpQfc5+LZkHWOreQCxz5ifEr+lPz7YRIk60d7VHZETcMwAzk/rk9RSRPWYpjs5E7ShW5S57c1BkX3zFmhK6JiJImEwIn5yIpFGyUpO/J+kjxaEWtRa2wu38iDH5/OU8v1DVhKBN/XTbLjEWYca9r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(19092799006)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3VRQnpIL1ZBRi9MNTAxZXNYOEN3S3hBSXRDTVlCaDZPdDk2bktUcUV2YzRC?=
 =?utf-8?B?MTM3YjlocHZqeVdIbUtFVGt6WE9HWTZwaHFnV0hBbEljdW56M2p3djJvQWhi?=
 =?utf-8?B?cTFzTGhTQXNJaEFZNUtrQXB4Tjh6d3JJSE9ORlU3UmFPS3VMUDdQaU1MZVVB?=
 =?utf-8?B?ZjIxVFFIK1owUmIzNXVXRERaMmZvQ0hyc3Rlc3l1UlJqTFg1dnJidzk4RTNx?=
 =?utf-8?B?RTNTalhiZXc1b2lNdkRXN0pDaXVMQTZhU2ZYWHFOeVdJM04ycGQrRkM1TWxk?=
 =?utf-8?B?SjNPbXFmSFlhbjlZbGJMNDUzR3UvK3R3anRRSVU2TkhHbjJqcVQ3UFQ4NGxt?=
 =?utf-8?B?dzVLOG96RzVTcndnTURHc0JGbURoeUVoUml0U053ZzE0ZVBLVjJLRkxRMWl1?=
 =?utf-8?B?Y3BKSVRLc2NXaE4vN3J3YncrRXpjK29jSExCUGJEazg1SE41eE9sL3lySGI0?=
 =?utf-8?B?M2JydW16REgyOWRXUzE3MzJqSS9MY24wTFp4YWZiVm5yMnZzU2QwalhnVGhj?=
 =?utf-8?B?WFdXdHkyaTRaSk5nZ2pVa3ZtZGZWcTRVRFl1ZUljMzRyQS90NFBxLy85ZVV1?=
 =?utf-8?B?eStPTU8xRnZIS1dxbzdUNkozUVRRTGJYOEZOeVhMc3RPSEFrMDlqVUFZMWp2?=
 =?utf-8?B?Wko2bDdRSkxFamlnVWQ3cFdFQjdTWlhFOGFhK09FWkk5TXE5OVk3WUZZbGFJ?=
 =?utf-8?B?Z2NuM2Yvenh6NXNTcDYrTXQ5bm1BSjk1clZReTdSQ2VWUDJVOEU5SkRSSTVM?=
 =?utf-8?B?ZDd3UnQ1b2Q5ZTNSRW5FSVMyVWJUM0lBUk9VOXN4bG5ZTncxQmJLeXBPeUJL?=
 =?utf-8?B?MUpBMWUzenk4Sy8xZnhteGJZeElpMGxYZ0NIWVpJUkFUOUd4ZUlaQVhVUXp4?=
 =?utf-8?B?aFBFR24zOUttSlAwbVlTVS9nZ1lDTjlSbDB3NmdzM2hQY1ZOVzZMVyt3NFNv?=
 =?utf-8?B?ZEQzUVcwdzBkN1l6WUVQa1hQSDZZZUo0c0x2UlJrT2lxSG5YRzBwYVRtZkZT?=
 =?utf-8?B?K2lYbTBUN3lJeEF2Z2tvdDhZb0kyK2RJN2RBSCs4YnQzcXJoQVJ4MUc1SVBl?=
 =?utf-8?B?YjVPempIZlFiUVUwaTdxL1h5MXUyWWordzhQV3pya3B4aCtiOVR5Q2Y5MFR5?=
 =?utf-8?B?MHNFbDk2K0FIUndQd2pJVXVaTUo4Ykd1eXlGd0h2WXRFeVRMSzFYMFlwc3RX?=
 =?utf-8?B?Um9xTG9LSEhzU01EcE42YkkzR1Z3dXBEVEZSR1Y1Y3hHSnBlMGJ2TUZqUkFq?=
 =?utf-8?B?SlJtcWFqU1pNZ2pNSVY2N0FOcE1CcVZyekd1dGRxbWFwTUVIWHRpZ21WNk5v?=
 =?utf-8?B?a1lFb25SbUJnUmdlVzJFcGhBbzIrTlhiOW9OMzF1NVEyTDQ5U3JzMHhpK2xD?=
 =?utf-8?B?OUk4NldhaGdJN0RsTlVMeWlQUjE3bGZaRWtxMzN1eU9YNE1aa1piRnp2WkFJ?=
 =?utf-8?B?eFE1dFFMYS91TEtuUlF0dzlZUnZHWG9JM0s4Vlp1bDJ0Q016VW41SWsxUDNl?=
 =?utf-8?B?S2JCNEVGeWY2Wmc5OGZxeW5TemJvY25IUk1wQVVINmlMSVRQUUZ4OFhqWUdx?=
 =?utf-8?B?ZVliTWV1TUZ5Vm1wZXcvWEVGc3JGVFJXdWM1a1hxQkJycU9xSmZaamFxNkJq?=
 =?utf-8?B?dXBXZ2oxUGhXZGUwYkthdEVXblA4VDJKYnJ2WkEwVEl2NGg1L2M5djZlNHpT?=
 =?utf-8?B?eTJENklhdTl4Um8rdlVXN21nL0tlMlE5cFNROHEwQnBVU2FRTXdOMXB5RGtw?=
 =?utf-8?B?SzRoaytnVnUxb25WVE1kakVucitZK2xXVUhWSUEwNFZFc2ROMjA5VjJha0xh?=
 =?utf-8?B?SWZtNGo1aFdsR1dGZHErNWI0QWdPMXBpbzJYV2N6UVZMLytyK1NvUFdraHdH?=
 =?utf-8?B?MXk2dk1QNGpuMWxXMUdBZy9ObTBjTTRKTkFObWc3RVhsZGxXTFJSaFY3QUpz?=
 =?utf-8?B?YS91RzJ1NXMzd01FQzdEZmRwTlQ3bXI4U1BEYkV2eWNJSkgyTnQ0NmZFVGhH?=
 =?utf-8?B?dldYejVtVkR3NlVLZkVJU2V2aExUakRkZDcvNnpPdE4waFJ0bnR6ck51ZWtH?=
 =?utf-8?B?dU5Pb0ZuSzZmMEk2UXpXKzBzSXFWYUR0WGdqMUJYd2djUEMrWlNiUGhsZWlX?=
 =?utf-8?B?aEg4TkdDSm5DQy92MnRBcElYbGdGVHJkOS9TQy9Zc3BwbSt6MCtFUmc4K1Zv?=
 =?utf-8?B?c1hzV0Zya2VDK0RIWXVIeGM5dVYxcEpXdkx4cmNVZG11SUx3WGdhbTdHWkFy?=
 =?utf-8?B?SlFYb3FQanhBb3dnWit5eGd1dUdWczNtNHdGU205aHVKajl3QkdSaThxdGRZ?=
 =?utf-8?B?UEtETlVtS0lvWi9WUHBnQWUrN1dMNXgvUWkxenFlbDZSc1VFalBoc1hWMXhM?=
 =?utf-8?Q?VPra+CnqD6lS3jYaZpjP/6FV5kdpwUJCTqzDZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1319095f-586e-4792-5438-08dee264782a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 11:30:27.7811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r16AlTCFYgili8WpjzE2VnpfCYFDduXTxyBkRebZ/rVVueq7b8sO/d/MEJMMdKWUEE+mXhDHoWw26VGAoq6D58UtDNRsu6Sc8ff9DC+H1kDNYqOPeRAT6xG4e3RHMHQ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9134

Patch #1 fix Type-C switch resource leak if probe() fails.
Patch #3 add runtime PM support to avoid register access issue if the
      USB controller enters into runtime suspended state, in this state
      accessing USB PHY register may lack some resources. This will also
      avoid regulator leak if power_on() fails.
Patch #4 add debug control register regmap
Patch #5 add imx8mq_usb_phy_drvdata drvdata for better extension
Patch #6 correct i.MX8MP USB runtime wakeup issue after introduce runtime
      PM support.

---
Changes in v6:
- use devm_pm_runtime_enable() to disable runtime PM if probe fails 
- add imx8mq_usb_phy_drvdata drvdata and need_genpd_rpm_on flag for better extension
- Link to v5: https://patch.msgid.link/20260630-imx8mp-usb-phy-improvement-v5-0-25d616403844@nxp.com

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

Xu Yang (5):
      phy: fsl-imx8mq-usb: set usb phy to be wakeup capable
      phy: fsl-imx8mq-usb: add runtime PM support
      phy: fsl-imx8mq-usb: add control register regmap
      phy: fsl-imx8mq-usb: introduce per-variant driver data structure
      phy: fsl-imx8mq-usb: keep PHY power domain runtime always-on for i.MX8MP

 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 154 +++++++++++++++++++++--------
 1 file changed, 113 insertions(+), 41 deletions(-)
---
base-commit: cc2b5f627e8ccbae1188ef2d8be3e451d7f933a5
change-id: 20260602-imx8mp-usb-phy-improvement-4272d308d862

Best regards,
--  
Xu Yang <xu.yang_2@nxp.com>

