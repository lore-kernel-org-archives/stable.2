Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BBC37CD32;
	Wed,  3 Jun 2026 05:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780464865; cv=fail; b=thcyMUp7AfQo+bbVP9MQxdICVsDqqcqBZZCz/83xvA2PVjnVjYHb0zdaY5WQks0SnbkIroNtULW8XZyIDf/bifqWkKtFBpx5DzeNprgFasFBMhdd+vObcN1OKrL5XfivDnjkssxSgWJNy1OVs14VDr0jYZDyJ/cCM3KqrRp6C0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780464865; c=relaxed/simple;
	bh=MH2mrFIkxStXxbTW33GqDqt1eq++h0baSrnWbjkqvfc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aZrWYv17h7Di44A/xVmDZDGfSKe2VBgEc+gBv6KFgISKgmC7e1DOxPtMYLrcLUGZqOkRkntzAcMhmds/md3Zb4eMbgbjLQBYTWD8AtN0GTti1vj9FdrfMl3Gr8kMrv28QC8iUFVuofVST6YSek7qAAP2GQB+xvcHlOolKhJTcAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AZSB9w14; arc=fail smtp.client-ip=52.101.69.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AZSB9w14"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWFUB6c3PwXtEBB7+UC7jpSelPt2/yqm/VGQf34NCUbn9dryjnDkOUHEzD9GcMQZrcAcPy2c/KW31WCk+YOX65trMD5+k49QwRmlOptjTbnVeMFeFxzEn1b10IQk7HSAd0ba3xOfeajpWxc/I2URzuvaFsvmWCeeIF6ypfwJNEQe8bWXtf7Moui1V0VQuEcqtUVygphv4nSckCxQaUasgKKk7xOTBDkNGU/jWP2mzB+IADIj06MshlkKWQjbabPHx2qz4Yw/jSnuwYNiLOAh1aM8zfO1hEuA+7PVuHNyHTsVZc/oxICDC9g4/AjBeWkGG/mtVTjTVevutKvZ8xDoHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NuiGbCBdeysNfrDec3PeO6dHqHxhRMOZo7mPAwvgA0=;
 b=iK0BPm0hixBPcCBWCKwagEEYlVNkCuBWQK9SurzPJAGViKMiP66oMELuoW4NRY4bs85KILsTpVAVDSa352WFxIjNixPHyZ+ajfr+PI5MuWHdhMGDFzAaqCW4lNNlTuwduIoXYaH4qxHyz6Cbhpr5TQ8PuWMBHhCarumzGLbJeATlzQcHnvv4+2FJ06i1ELXjKPYVoHTpQIbV/1KK9HSeiJMZneM+T94A4cMtk3TzUF8xBZfyox7+w73pBH5Wt41MmDn/K8nV5aOiB7fci/3NQd0zFJdPe2Rj/dVqglbPOpnA/936LvpLlBjrFu3Zra9T7fQeYRSK3cO8hbXbcytO5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NuiGbCBdeysNfrDec3PeO6dHqHxhRMOZo7mPAwvgA0=;
 b=AZSB9w14RdTqxTBnDCIUTLg41IfBZamxbuennoh7ZW6nXUp007A1GokxZHc4P8wiGJTcGseBZuP/SKxNaKqf90a3Fjirj8Mc9zPn7RA/phjfetB+1VcZ1XUZwBUUdzbnEs9XfIWxwgieI3ofz+7/JaoSca5gd/k9/60oqd89Hogvuw/C7ullx55IwG/xkfDAKYPUqsRXqEmMvvs544uXaOcgSoXdWBEYZKALNVbjw5DXdW/hdCBwo5MuVDQ/8dO/cfuSSKcomixXeDvaRHcaNlUr1uP4ssQa3Qc47cPIos8Hi8YbdpDH0joAAvmfTOznMpxjm28ArdQ9Kmx3we5FXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by AS8PR04MB8150.eurprd04.prod.outlook.com (2603:10a6:20b:3f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 05:34:19 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0071.015; Wed, 3 Jun 2026
 05:34:19 +0000
From: Xu Yang <xu.yang_2@oss.nxp.com>
Date: Wed, 03 Jun 2026 13:37:14 +0800
Subject: [PATCH v3 1/5] phy: fsl-imx8mq-usb: fix typec switch leak on probe
 error path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-imx8mp-usb-phy-improvement-v3-1-7afb8f89abc6@nxp.com>
References: <20260603-imx8mp-usb-phy-improvement-v3-0-7afb8f89abc6@nxp.com>
In-Reply-To: <20260603-imx8mp-usb-phy-improvement-v3-0-7afb8f89abc6@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780465041; l=2836;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=F5tZWwCCXccCYGGdg/r8AVNlU/mFAd4meggsWHjIQ9k=;
 b=TFYxtgT5dWTbBBvt1eU0sUT7e80uaTC2SM5bG05rZM9Usa4FVaXdOuKnfpQhge7ESe/IC72O0
 h7XQuFeNQVgB9tq9ju7sK92ccOVVlsPMWCOeUAac14vMPZueRKNsyrp
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|AS8PR04MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 770b497b-3a9d-4923-e302-08dec131c258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	3IyFA62WTWawbKEMqLaKZS/yImAorNyAhyt+pAhG3Dh3eFiurtPc0IcNNOrVeoLk2aOzVFYwA7T1mRvdQ6UWBn2cjDaqHUmFG/dw+aDdr2S4VM8Hgrgp9Y6MZKAATFn8/FT9FiRKcvu86xI41yO6Hui9RaPRoIgekcU8gwjL764R+VsgIPX/t0fOu3Y3vu04z9X/uaUmj2qcM3VRxADplf7LJ0MI92+PlfWxHptY79b3G530MHqFG6QFUwAQcU8gALm1b265WcHDtsfbmbg6ZWbLZT4z7e2BnB5Wg1OiTkCdK4/GZmiRPo+QwlVXCjIkYw3ugsaXs+j36Ik5MKgHnMnlH838uz04SVFZKb0J9BpLmMp5y6iExvTNBJVCfRtEbVzMDNqRa7nkdSiQo2wImVOmsfDst60eK7yQl4W/GnZJkCGOzVsAXAc4deI1GGIhzsIwws8fBEHL6YR07ih3EqrvH/5nhmjL8t/cjpkZ9vxgXHNjL+poxCTaVRipbERkFDeGnDivSdOuIfJbQ51jLOA+tFAwL/5slsr0RkFhK4wB08lsidOieNZKk3TF7vlJMurg30q/9EukfXGVKkq+V22f3zlEapK+oyMRfJX+GpRzef656Usc5bpuEa35lq7HJrL7aGasfVGF0Ic480oYLcUbAZMhU1UnG8rBZP3R03KaVQW+HF2qHKCi6Atznw+F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDVtTVl6WGwzYXVGczhHVTE4UGx2QmcrMjd2dTN1UG5Ia1IwYlZxRjIrVEk3?=
 =?utf-8?B?OG9GZHI0K2h2ZUxQNEYzMkd5UDl5YTMxSC83QnRlNmZBdS9RcXM2TGc5aEsv?=
 =?utf-8?B?Y2x1cU1uL1NsRzlySlNIU3B6VU1IOHo1WG9Jb0JHaUtqcHg5bVJLcXU2MlA0?=
 =?utf-8?B?bU85Y3RwRDNCVnVuRVFIWndDWHFHdEphaWMxb3JEN0MwMVY0QkcwckNuamY5?=
 =?utf-8?B?dW82WUsxNS85U0xweHE2c3VyRWNEMGdyTWlDUUN2bkNqdElyNmhWYis4Q3FX?=
 =?utf-8?B?TDlvdDYxQndNdFNUQm8vcFVaUXphQjQ2NmE1OVVoejdOL1AwZ2ZWTU4yT09S?=
 =?utf-8?B?WmxYTUJMSWNqb0J6WDNwbkROU2hsRmdPelRZSXNpT1JkL0llaEpIMUxRbTFY?=
 =?utf-8?B?Z1BvYjNyaERDR1BQTFdnY0RrbndLeHh3WVptMjFHYkJlaE5Gc2Q4eWV4dEZm?=
 =?utf-8?B?bzRtQXlocE9GeHBaNjNzYUY4UE85b2JnS1dUaWE3dGpSeTQvdy84VDJEOHNP?=
 =?utf-8?B?U1hpd1pMVENBY1dXYzhMSHBuZXRCd1k4ck9wVXNhVFYvQmR5Uk1mYWxVajlF?=
 =?utf-8?B?S09tSmRHS3pGSWJQaHVwbmpWcm9FRzZCdDRNanErb2dsa0FYR3JBeTNEdzN3?=
 =?utf-8?B?bEhYYzJ3SjBNeFRvdytmOU1OTkNXbDZqN01FTXFWNitrdFhiTEVtUXF5SG1W?=
 =?utf-8?B?NFZxTkEyZm1DYkFEblVQc1V3OWV3dWRRMjZOUmpVckQxM3hrY05BYkFNRjZ0?=
 =?utf-8?B?Zmpnc0dCWDVzUThBODhXTW52eXNqaDN3VGtkVzVGN0dVc1RFNktUQ0pQUnlt?=
 =?utf-8?B?WEdvZ2JhYUVxclhmL2psVmFiUklWdEh2cXVtMDg5dXhrMld0RnJEaURKdDFZ?=
 =?utf-8?B?bndWMjJoVTRQc05SRHE4L1ltMWFKejMvV3FhQ3MvNGhQYnpDTTdGVDRUeGdw?=
 =?utf-8?B?YlFrc2JJb292Q2ZUZkpLQnVDOGw0a1pXR1phQ0lrWmZxMXpKak5rd04zb3hH?=
 =?utf-8?B?bElXcEtlVUVLa01XZnFqM09tUVVndm9mNHZaU2FSQkRlR3dPY1RUWWZTYXZP?=
 =?utf-8?B?MnpqM2xUTjB3b2x1MWttM3BCdlg1VWxCUWF0eVdoZTBWYUh5d0kwZDdleVN5?=
 =?utf-8?B?aUZPSDhXK2ZkYTdZYm9pUlZkUFVLam9nVlRRdFcwaTJKRk94aldTNS9iY09O?=
 =?utf-8?B?MURqZjYyTWxqc3hwc2V5Y0tIRll1Zk9UaXRWK3VHZE1DaFRTcWJCN040ZXlp?=
 =?utf-8?B?dmduRHhON1g2dzRaS2tVbHM2aC93VUdMbHhSSnF0ZVg2TzVaWENHajF1MnpM?=
 =?utf-8?B?QjEzdXNoZC85Q2FFcWJaWHJsTDJyNmlhdndkb0MxQ0N6SWpBUkhtSk5zMzF3?=
 =?utf-8?B?Z294M2l2cmJncXBONzBZeWx6bHIxVFR0bnRlUXhrb28ranZiRFNhZmYyY01w?=
 =?utf-8?B?SjZqWmMrWnNucXZHN0hubFRXTEtRU21vUWhHNFNOOFNYRmt4MGhMQkFnaHh1?=
 =?utf-8?B?Rk8vbnBMeDczcUhBUE1TUlByS2o1WUNldHlHZDh6TUhZRzFNVG5NVkMwVG1W?=
 =?utf-8?B?RUJzVHIvQ1FrU1lYRjdCMFVZU1BYRlFOUGZhOVN2dUg0eUxhYWNLcTZNV2gx?=
 =?utf-8?B?a20wQXNRS1N3bEM3ZkJsYmsvd2lycXBaZ2tsbGpGMWtkZzJ0Q2RsdzVVVVJl?=
 =?utf-8?B?UStXRE5qSWlLNDNBZ2NCdjZoL1hkNlV1cWxwd1FVc3VnRjVROUxvaTI2aGJI?=
 =?utf-8?B?L2pNZzB5eTMzM1N0SUF6ZVk5cVY5a0lrM21Nd2EveC9wRXB2R2tMdm5zb00w?=
 =?utf-8?B?VFAyZyszajBHUUM2L1IzSnNyTDhuYk5zUm9HbVhNYUhrRTFpaFlWVFVweEN0?=
 =?utf-8?B?YjMwVFpzY0hkb2J1a2RhYlFIcU9TOHZ4QmVhMzZkSW4yY2hHR1pwM2FGOGxX?=
 =?utf-8?B?SVA3dFExa0hvUXMzRmVhQmIxalkrZlkycncvOC9UVno5Y2pHNmtTSFEzdmNE?=
 =?utf-8?B?SUs4Y1Y2VE9SdWVtaS9PLzdGbTBWVGxZRENEeHExc0pDWkNCQWVtN2RHRzRG?=
 =?utf-8?B?RjI1QkZIWk0xSHduNjJLU0x5WnoyZXRMMCs5VC9oa3dmNGNuRzFpek9Wb0ZC?=
 =?utf-8?B?YXlqU0MvYU42VkVyaS9EbnlIZWRuSWZrOXNHa0tqQzMrQ1lqM0Z4VDNmQkZG?=
 =?utf-8?B?bWRGeFlrWWF1V1BQYUJHZ05qclowQ0JmUUNuQXhpNzVVYkoxUVVzTGt4ZklT?=
 =?utf-8?B?NTMvRGpGajhISUpUWjdsYS9rYkJGT2hqd01NTkNRNW0rUEh1bDZWazRSa2Z2?=
 =?utf-8?B?Q2dtZkFwb2FXallENzlMRjZvMEYyUGhkM0UySXlQS2dxV1dSUFByYlBSMzdR?=
 =?utf-8?Q?iCDUpRAs8EdFmlDeqk0y/k12ASL1MVX7xWa6r?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 770b497b-3a9d-4923-e302-08dec131c258
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 05:34:19.3892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2UuXNW8vUlU7oI7fbHyd5qqhS714kPvEBcXX68dU5PxbXSc3sfcEka9Pm9HANOLjoaWP1gZXQrc9vaAO8Ut6ToL5ALvdfx2wtwDS1HfmJfAqIBsmIT9jmXwPQ+/5yLT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8150

From: Felix Gu <ustc.gu@gmail.com>

If probe fails after imx95_usb_phy_get_tca() succeeds, the typec
switch leaks because the only cleanup path was in .remove, which
never runs on probe failure.

Use devm_add_action_or_reset() so the switch is cleaned up on both
probe failure and driver removal.  The .remove callback and
imx95_usb_phy_put_tca() are no longer needed.

Fixes: b58f0f86fd61 ("phy: fsl-imx8mq-usb: add tca function driver for imx95")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Felix Gu <ustc.gu@gmail.com>

---
Changes in v3:
 - add R-b tag
 - cc statble
 - drop "sw = data" conversion
---
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
index b05d80e849a1..88b804b2c982 100644
--- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
+++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
@@ -173,9 +173,9 @@ static struct typec_switch_dev *tca_blk_get_typec_switch(struct platform_device
 	return sw;
 }
 
-static void tca_blk_put_typec_switch(struct typec_switch_dev *sw)
+static void tca_blk_put_typec_switch(void *data)
 {
-	typec_switch_unregister(sw);
+	typec_switch_unregister(data);
 }
 
 static void tca_blk_orientation_set(struct tca_blk *tca,
@@ -248,6 +248,7 @@ static struct tca_blk *imx95_usb_phy_get_tca(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct tca_blk *tca;
+	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	if (!res)
@@ -266,17 +267,11 @@ static struct tca_blk *imx95_usb_phy_get_tca(struct platform_device *pdev,
 	tca->orientation = TYPEC_ORIENTATION_NORMAL;
 	tca->sw = tca_blk_get_typec_switch(pdev, imx_phy);
 
-	return tca;
-}
-
-static void imx95_usb_phy_put_tca(struct imx8mq_usb_phy *imx_phy)
-{
-	struct tca_blk *tca = imx_phy->tca;
-
-	if (!tca)
-		return;
+	ret = devm_add_action_or_reset(&pdev->dev, tca_blk_put_typec_switch, tca->sw);
+	if (ret)
+		return ERR_PTR(ret);
 
-	tca_blk_put_typec_switch(tca->sw);
+	return tca;
 }
 
 static u32 phy_tx_vref_tune_from_property(u32 percent)
@@ -739,16 +734,8 @@ static int imx8mq_usb_phy_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
-static void imx8mq_usb_phy_remove(struct platform_device *pdev)
-{
-	struct imx8mq_usb_phy *imx_phy = platform_get_drvdata(pdev);
-
-	imx95_usb_phy_put_tca(imx_phy);
-}
-
 static struct platform_driver imx8mq_usb_phy_driver = {
 	.probe	= imx8mq_usb_phy_probe,
-	.remove = imx8mq_usb_phy_remove,
 	.driver = {
 		.name	= "imx8mq-usb-phy",
 		.of_match_table	= imx8mq_usb_phy_of_match,

-- 
2.34.1

