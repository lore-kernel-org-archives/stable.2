Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013066.outbound.protection.outlook.com [52.101.83.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E725519E968;
	Fri, 31 Jul 2026 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785485266; cv=fail; b=YEPFHnzAnLPh0SUhhF0WR2Kuve1nNKXbkIaTd4ghC2gvAHsfWVbUpz8HYDVmA7yBFRM0cjo00JEr6bE99dwFSnRIs/lgzGE8HIP0TwnC57OImcdzZRvOOaGTLjAkLNL2OtJFNRmNlSzZxEEUgIM9UN914PrePnDQyRKrHmgAQO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785485266; c=relaxed/simple;
	bh=VRgjWsIiLPDqVp6/Z1tdZB7h5fR9JHrGXXbNB9tdhiQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=cHOoeSLl+P+dai2GltlLXC7sYbUFFStJk6hpOju2icdmSIY8V+N9iMx6k9PCgt8/qrnj+cQZ2VR8qIxbdKJ/bUxGShyG4Exg7+f1uhyJl0Dshf+SBRUmlkEdxF+Sq3GmwGOAX1dwsRq4NO7V5y5Mb6vkqgk6kVWGdLVO5m8b2Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=npRx+16Q; arc=fail smtp.client-ip=52.101.83.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="npRx+16Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ft1Bk+Ut6w5WJcGdbbGzUVD506KzFk35RBT/NxiHxdG4Azu2z8hSFdGqmic4ReO2jv4KGNqiSLDQjTyxxhjLwAM0Q/WXVLPNPXjXq4Vq1X02/J7CKzVdpKyhQyP/YZ6smheLl/8eUJAqX2wKlXzxZaVNeWQazRfnIYt7e1RKYiafVXd8IIbhXJlcohdU8KH/H2eP5ALPEUtTgzhayJLK3vpl+fikfIHMFb4HVFp5NwKv6R+vcwNSJrGk2ww5C6PGU04mT11Y6zy19/XApVCiO6oItEp2FU1j7eak69UnReAJgjfLx8iTXTMoxwxA6ZR4gfWnm03txeqZOqZ6Z2UZZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbfC18DKAG2xO4jYcJ3oNZBCiCTaE4c85HyN/qt1w+8=;
 b=dMuwRLrk95iDH4IMfc08WUAt7srDWGubJZBOgYShZ09bYRd/futYCDMwlLuOFvJPDE7jbj3D+1zM+nzuLrWUpgZUX9to7TrbspvKlYvq6n5vjjyViW4f313PsaCI6qenpaza5c1nIzs8YPkCSBYlqK9i+UqQ8Lw7VGq8Q5IpR2SEUtfpeTiI7qsCFsGqsm4aWdjh0gXAyFaBI1rfWn2hE0nz1eJGOrbXIfvY8qE5mI/Jk0hNtFRiSw/GxLovvXtDI6lvRhDdIyfXJrqgQBBHT0K0MT/x4AgRv1apM/1n9WvbbzboU8rDvAQSKXCqAiEDLlOK3JEhFeNdJ5Yjog/baQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbfC18DKAG2xO4jYcJ3oNZBCiCTaE4c85HyN/qt1w+8=;
 b=npRx+16Q/SZUehwGP33Yeq7BzK6KKAReSTqR5rzZQc9dGbItUaMl4Vu1wE051ecYYMhWmpfNONhDO5dEefaSZ8HlsU0oADkpMghO4XiCiULTqrtVlXm63+DXm+bZS9KrgPqQ0TfVyGuA/d3ZyagCb7+knQxe0HcygBc6mvtiK50zpg19nFpsHZXb8we2LV9hu8ZRZqso1zosbvAlkIOoGrPjCYqUDusPDyRXBvq/5vr1tpUiK1BECb6/SNR4wDWlusRYueG/Lh4ju64Lz335xjn9Rjan/1ZKlCUr1RabQughX9LcLBTjRIHmC3ia74+odKyT6BImHg0Sy0ayePJjuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by AS8PR04MB8657.eurprd04.prod.outlook.com (2603:10a6:20b:428::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 08:07:41 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 08:07:41 +0000
From: Xu Yang <xu.yang_2@oss.nxp.com>
Subject: [PATCH v8 0/6] phy: fsl-imx8mq-usb: few improvements
Date: Fri, 31 Jul 2026 16:11:18 +0800
Message-Id: <20260731-imx8mp-usb-phy-improvement-v8-0-2ec8d6b3854d@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKZYbGoC/33QTW7DIBCG4atErEs1GX7dVe9RdWHDULOwjSBFj
 iLfvSRSVacLL18Wz3zixgrlSIW9nW4sU40lLnML+3JibuznL+LRt2YIqEED8jitdkr8uww8jde
 WKS+VJpovXKJBL8B6q5E1IGUKcX3gH5+tx1guS74+blVxf/1lxRFbBQdu+jDYYLt+cPp9XtOrW
 yZ2R6vcQ+oQkg0a0PuAQbSN7hlSO0jAIaQahMrrs5YgrJTPkP6DzPl4kW4QgO8UoQGS/xaZHYT
 dIWQa5IRVRBJ6T7s/2rbtB6C/uUTmAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785485487; l=2729;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=VRgjWsIiLPDqVp6/Z1tdZB7h5fR9JHrGXXbNB9tdhiQ=;
 b=2+BuW1V1G+xHenRvKfpyL36pwfYoJYl5qsB1CuGZwzSi1CZxMNQ+/dJXke2JU/LyWSq8uEqwY
 VYXI9yyF6+8Agw6KElId5iUYZEGzPDDsBEKmFSPLmZRMUEkRoxERm9P
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|AS8PR04MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 52415405-8eec-4616-65b4-08deeedaca77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|19092799006|56012099006|11063799006|5023799004|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	f5R1zLCI+YfPUMzy6jSkzsC4zoKOyF50q4Wsj6T1IychWLKK7oLPgDFi3BA7OOHuN6xU0dDJjSgoGJyZ0O5OMZ6QCqZUZw8HHcm6VNEvXz2kcgCZDFDU8KxPw+gsJKTN5IVCo4+zTpgU4l4rh55nidG+UBP3IaTwC2GRfjUeRAu/yMUt/sVYF4ITIVf0y+BwCgwcHeFEXb08qkGw3GRekiHOO7wmnuXAi+HTlPUMpd4On7cT3HAwKza5k5vT/3GCkwwrCfZ4UPD4cgvnlMWhUXNEXCWZT6IqRoVU3P7Vkm03s7hj2TFyensXHXvRz2nQaBkR4XBMEvmCg/wb91fmBG6cqQCxxcYo7hMB7iJFhe6qiSJfFF3iv23kXgOxYsLgCuiskUif/NvDTCudr7VrhTS9mqG9ZFmkppUkdm0m76UkLCx4eNz2iaqvul+Cy3Ez2w9NaZPMaVWI18Ng7aoT5sdP4D+ZUt1tgeuBhkkEC06+ImHee+n+EvdshOE9dBZOGba4/BbDS+H7Kmj8DS0UUyPU1dCilNoINQOaic1GgAD+x338TFb6/xEApU+tZwEzqsgdUr7NO4i2qmvYaMpoPJTvFrtENDHT1cmGrUul0NjhK2uuCkJ3pWv/PsKw15SB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(19092799006)(56012099006)(11063799006)(5023799004)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDE2aHhDMFRwa3IwdkhVNE8yMTlxM3c5WkFNWitlVVRxczB1V2l0L2NkSUxX?=
 =?utf-8?B?T1ErRXBMamp1WTB5dnV6SXE3cWwraUNWYWEwcTdBNURLUVNnWUZBOTU0Mllt?=
 =?utf-8?B?Q1Z0ejBKQ3JZR29qUXRYcEhnb1BGTno4QXhpS0R1a0E4ZWE3T0REYyswS29t?=
 =?utf-8?B?cGY2RU1FNnhuaGJEMU5sTDI3bDlwTkpwQU80bWQ2SmhkbWlWTUNoUFR4THAy?=
 =?utf-8?B?bGlkclBUNzNQdW01NVVLODdqUVJ0ZDZrdWI4MkNxOGQxUzBVdHhsUmsxMDV6?=
 =?utf-8?B?OGgrcUw0dndSSnJYSE5kOU9jMk1BTVFJaHZsYitjeXFPZVpWSmEzMG5ObW1s?=
 =?utf-8?B?Q0N1djhPR2xIZ0ozRlVuUjNJeE8zZnAyN1VBL2tHRGJNanJNWG1GVTdzT2lS?=
 =?utf-8?B?QnM3QjRyQ21jQndBeGIxZERSblhnNHYrZERKWFl5VWp2K2pmZ3NUdi9aRVJI?=
 =?utf-8?B?dTFaa3BGRVc0eitOV2QzRUxXbzZ3amFXanJqd2ZtNHFnZ3daMm9vV1NySU5Q?=
 =?utf-8?B?bUJiaFFpUnVpdDlSKy9xT05kVW1hQ0dpeGorRmZ0bjFOcGdHVWtpcG5SL1E1?=
 =?utf-8?B?MzdBNVo5aHRNSFpZS0xJQTQxeW9vVVFCcUJJTkJNNGJONjU2YmJGbjVPVHdL?=
 =?utf-8?B?Ri9Sb2pLL2JuWkx1NjhyREZydC9YQlNWVEFNZEsyMkNqTjFIR1hrdmxCQU53?=
 =?utf-8?B?VERveVdTNEVNdUpybXZKNG5GWWZuUWFwV3JqYnlJalc5ZWE4OVJMMFI4U1dp?=
 =?utf-8?B?V2lMZ2FwYUtuczhzM3pYcWpmVmxUd1RFSStNOWkvb1F2bXl4Y2Y1ZDBhZWZR?=
 =?utf-8?B?dWx2NzVVekh6OVR6OGpVZ0YyOXpQZWQ4SW01OUJudnRWelV6Y2cvTGpnYWJP?=
 =?utf-8?B?Mzhhcnk1WHdYTFlyVklMTFlwemFQTjZwUWNWYnF3aDNQU1dzbERrVUpNamd5?=
 =?utf-8?B?cHFBclpJSmxjTVRwc1RSRHFyNDF4S3I2RDMxTDVCNjR6b2c1MmsrUnNack1Q?=
 =?utf-8?B?VGYyS3FNUndiQWRtMzZJYXdTSFlWT2hMemZtd1dxaVpDSVNsWVRTZW1DNmhp?=
 =?utf-8?B?T3JhbXZIeHVhQTVmb1hqTXpIR1BSMFhwNHI2ZHQzVXJ1ekJncUFCSTY0anp2?=
 =?utf-8?B?UXpFbXZXYWVudzlheDZmam9yWXJHOWs5SUQzZkZyWVUxTWFZT1ZyOVphbXE2?=
 =?utf-8?B?eDNicElDazFVbjlydGo0enVaTVRkOGNIZ1N1d1I5U1FSdGUxTDNmQWNPWTVw?=
 =?utf-8?B?YXoyMDJHTnhBM1RkVXRPU0lKNzFiT0FHblZIZHZWVWd2TG9wRkpjeTRxaFFE?=
 =?utf-8?B?ajdPamJhTk9SMklFOHhUbEpnQTFUQWlvWHBlVWJzL292UU9DRHc4L0VPbWlH?=
 =?utf-8?B?YVdjWUdCdnZxRXhnSXVNd0pxZkM3VHZ2NlUyaVduRHpnL2Jrbk54LzNRUnFF?=
 =?utf-8?B?UzhvaXFNT0pwV0xVMkcvWWJwaXRhVk10MUR0SXpjRkNtV1pwczRMeE4rZUxE?=
 =?utf-8?B?WUtCOE82NDR5MFpNMWJlTDZJemo4SW8xKzBISU4rNzlOSEkwejRoMlc4OFdl?=
 =?utf-8?B?MzRkMk54YkYveU5GT3ZnUDRZbG9xMUxrbnljRlExWWNkVEJrZldlNDF4Rlpu?=
 =?utf-8?B?UlYwdU15SHBqR0MzVDkvb1Bqa0s4MkxuVE80MmhIMFpUdUZORkd1OUtnNlIw?=
 =?utf-8?B?d21Da2UwbHBhOVlxanVnUXZsVnFJVjdLeGl3SEF2VmQ1YVFHdGxkRHRXQnNI?=
 =?utf-8?B?Zm8rVmJRTVhxQlFzVTlLNHZDaFhjZWw2K2wwemhKODhDVlhXVzU1ZDRCMHFP?=
 =?utf-8?B?KzBNcnZYVlFQK1dBK0dkcDV1UmJjRUVQa3BOclR3dERKem9NajNrd0tXWXN2?=
 =?utf-8?B?clpuemw4aE5EUnJialR6RFJTMXFRR055elhHQU5hNnRlZUhaUWczdjRtdCtE?=
 =?utf-8?B?dVQ5VVkwa3hjbEk3ZXhIZDVFWW9CUC9URHdMckxOeDdoaXV4UkFxTjJGZ0NN?=
 =?utf-8?B?WjVoT2pOSlNFT2gzNm5hcVk2Wi94NVF6MjFHaW5FZDNvMjhIVUdWdkc3MU1y?=
 =?utf-8?B?ZXNKL2JJTlQwM3E4UUQyRXNOZ0NkRHlVaHdMMmhJOUt6RUhTYkxSODkzMlpz?=
 =?utf-8?B?L2w5Z3Y5ZUJrZlFjOE1wejhjUFJvYkE5Z3c5cnVFajdJcnQ1MFdqK3l3U3hU?=
 =?utf-8?B?QjVPNmszbXU1R0RpY21HVU9OUFlhRmQ2ak1FZTYzZENJZy91R1BPdEJSZ0dn?=
 =?utf-8?B?cUh4VTRIRklQYS8wWUUrdWh3MFRTWnhGSWhhS2MvTHprQXVoM1pLekVUcHAy?=
 =?utf-8?B?Njc3bDNJcUYvSlZIci9uSC9CcDhNZVBLdjQrUXVQMFJWSElBZ3FaVU94KzZR?=
 =?utf-8?Q?/KSW9dSJ6OsBqogv9+wSdHS3CMQxnirzguJvC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52415405-8eec-4616-65b4-08deeedaca77
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 08:07:40.9085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1Yaj2YR/2//vkCKaBnVYDFlCl9GAwyaQOSL4SexK+rmHDGRQDtTG6SiUxlDwkaBKCVQWppbdRvRHBmgzZiWMPB+oNjbLV/LGMGayMa1ZDf/49zRMxu/BHsClaXal2Ls
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8657

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
Changes in v8:
- fix imx8mq_usb_phy_remove() if condition
- add "select REGMAP_MMIO" in Kconfig
- Link to v7: https://patch.msgid.link/20260729-imx8mp-usb-phy-improvement-v7-0-c385ee40ade6@nxp.com

Changes in v7:
- replase PM_RUNTIME_ACQUIRE()  with PM_RUNTIME_ACQUIRE_IF_ENABLED()
- use non-devm PM runtime callback finally, because the devm version will still cause the clock
  be disabled twice when probe() is failed or driver removed at device suspended state.
- Link to v6: https://patch.msgid.link/20260715-imx8mp-usb-phy-improvement-v6-0-00d95e270e4c@nxp.com

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

 drivers/phy/freescale/Kconfig              |   1 +
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 186 +++++++++++++++++++++--------
 2 files changed, 138 insertions(+), 49 deletions(-)
---
base-commit: 3652b49adac266a3d27cb41cdfdb7d8790fc3633
change-id: 20260602-imx8mp-usb-phy-improvement-4272d308d862

Best regards,
--  
Xu Yang <xu.yang_2@nxp.com>

