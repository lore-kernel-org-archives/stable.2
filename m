Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010014.outbound.protection.outlook.com [52.101.69.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F96E395D8E;
	Tue, 30 Jun 2026 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814111; cv=fail; b=pUXIHV9actEBRzAarD5fDxVdYg36dpy+g9QX1x19RGLbonb5SQ5QefpJmWDSMEm3iuiceLCOZKdVtSacl3SqRShKZRMHlPOtk7Uzcq0/02N7g3w84y+bA5qEMKRq6CebFKsxJQc3QvhCSrKWRHE99810hhuXxM9b4s9YRYLdazA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814111; c=relaxed/simple;
	bh=asp6OUZXq7HNhxcftcuDMkQY7T7B7wYTOIW/giuZ1SI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WSEbhSj8r80o4Y8cRKfYG/9ZFHPdLXOvw/Tg9pmw5zhZQODKv24yVCOZ1PYSDBe07y69rVugLKeETW5r/VyT5VARQD9uT4O8PM/K1GoEdji30D3CoVhnzgY0oCu/QPTviEN+uMgteEyQsThFURSUv87uiBhdSHJtTaoEI+Y89dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=tbxBaZWs; arc=fail smtp.client-ip=52.101.69.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tbxBaZWs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ar6axYN1ytSyae+a+bFAC/BDXZdGEaM/5ikyCtTIl9fBH2JGGH6N4UW8PHWHZJDr0xFA3GeV51MvT8GP4PyJeZhQLWcvuTvFsAy0XzD4kNRdxvZy9/dKhbCnAEUTWe1LPg5/QWV8PtwRMc6XR5WWso1FwsAbyi0GLABb+AiWsiTLMhKR4NkWbCyeY9c6nuKM6KUFUkHPKD75j5L5M+t9gRGoOeI6mat10+Fo9faZ39o3dQyXaETCZ+taK7+MGJJ6daOZtUk794T0EBspFBaQUpA3W64gb5k5IuuI5O2ZVYsuRk7NDOTiaAqO7niz+Gp02g41cJppp0+ij8XdivTz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsAwIdcRzLQSSuoPlFTgUIS0fFb3ny7t/oWSNgCMddc=;
 b=f2h9icaDrSRk9SL9JGSiozvUBorwjtqI4EV9CAo4bgGZZ02kW6RQ0eEnTwrSFj5RVusxpSD+JTk7lO92s2okLrOdjKdfrQv0HQF2W7JERMFjY1f+2SAEUC+3W/2Pfsf0L9DKgBDECC210GxM5ifQePafv1EddSWOG5+yDVSQHbRWJXhT1rueNnblcl4NJ1WJxGbN/ywPVwUESC5KRR7KoD2f2K0Gks+BuMeFpaNmukhj9MTZ/ir5mHVgJtN6Ssj3iKJdrxqQad3UklUgei6VNX+jCT1LoButfC0bwjU4vRaUgDwOFXQ0qnJyapDIK6Sv4SF87bXi81a/rhbzFZ0zYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsAwIdcRzLQSSuoPlFTgUIS0fFb3ny7t/oWSNgCMddc=;
 b=tbxBaZWs1Ca7vHYjd/GtaSqYCQgn72HCnsSKSy0XnCzzSq/NPzB4anCujX2wz8ulrRQ45onMusz5xNUwJkfVJsqPi1vJj8WtVPHCHpRdfV16Noq29FKxQBZBSU8qYPA/mRUyOC2HXG3lObOnutoXSDJ6lqjErno+08/koZNpC8pkNVJYboQgQu5AL0BcT/+yJMBb69PqLRTY2820x1hHNm7c1WXlni6+hgXyebYrt0L4qxG1uHvTpCJmVcNpxIi94jopM5FLHjpbBE1tTF9FxYgBVlihNJS4thh38MX1VOfic29nDOvVaa3FcbG9FguRNTW+g6gjMuYFmvCEBkzqEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by GV1PR04MB10991.eurprd04.prod.outlook.com (2603:10a6:150:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 10:08:26 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 10:08:26 +0000
From: Xu Yang <xu.yang_2@oss.nxp.com>
Date: Tue, 30 Jun 2026 18:11:28 +0800
Subject: [PATCH v5 1/5] phy: fsl-imx8mq-usb: fix typec switch leak on probe
 error path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-imx8mp-usb-phy-improvement-v5-1-25d616403844@nxp.com>
References: <20260630-imx8mp-usb-phy-improvement-v5-0-25d616403844@nxp.com>
In-Reply-To: <20260630-imx8mp-usb-phy-improvement-v5-0-25d616403844@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782814305; l=2772;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=hgj+TrREdOALikJMDoQq0uH1ivsCUZ/lmK++agAs5FY=;
 b=oDSFE743r4G2pFOI9bQKGS1NfXCzqqtZwrd2W+s0Lfkc4hki04YIg09QZjxyEr7WPhrNnxQQ5
 L/oCYW9T590A84KFRtBFut1aUmKuHVwTG3c7G300puTEdCPUpQG9UQh
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: MA5P287CA0217.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::13) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|GV1PR04MB10991:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bea8938-f56f-48f3-95b8-08ded68f8676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|19092799006|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	uhKtmfqBollMNxdiiydKJLCGXZTL/9sWLuYxixjykCjjY3TGE8dCdxHnGSHe7ekUtMmqnhPzI7sJo1qG/NfsjTFmnTR+0yk2oH4+SezN7doNgdic6DSGrYWReHxcqBo6UVMeofpqYD22M+1cOWn+V0DavPFiNmOoaAxt9aDOouN3Jy7DUB3qFYzSS9qDNTcXA17YMWvkTZ/+uON1NtPu+i/XBKQGO6Z1DqqhpBjBeDf3VMnP/LpCwXmc75L0a2ofnchIHT4Zx50seMMg+hzfZQEmcTSH/h5/OzrprWUCrcY7m8/6USO6BSYmhg4JKsso7vtG9QB6O/tWj38N1d7zhVQ1yIhebs1yERPNGVR3QeawkwXp+Ov9g37vyzvq64do5wwvMvdnd8YGE6hylrt5S1zK4IuncKoF2nX0suLxwpNsBWffV8p0G964tGqGUUBaw0JhiBg5zFvZSgHiVsbEhjDQoZ6cswxerNr0veD4dwlGvqKKL8/oZKFkSkkt9Nc7rPmc7hav9qNuSaDwkiyka+msxwS5pdgdjMCYcHl3TxiexoRrLyIKgv4NVqJF9mgZwbD5Gl2GX8H9BXi69UREwuruoNWLQRM9Nq3mqoPpJW8Syhzd06YOHXyvNvr/ONsS0wNZNZIO3pUiZ7P5xY7+MsROOPJMhJ1xrJ1TovmDNf4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(19092799006)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ly84M1NMR2hTbEZoVG95ZDA0d1N4YlQ5NC9mczJUblJPN1JFVnBxK0VLQWdl?=
 =?utf-8?B?bnFvRWFST3JJcm1yR2JOZm5Wd0NFeHpKSFVzczFqNjR2M2lmV040a2VDRDI3?=
 =?utf-8?B?WUZjM2tncDA2bG5zbFlsQXMyMHlINXZvOWt0ZnptOVpPdUhLdE9oRW9LcGJY?=
 =?utf-8?B?SFE5TmU5ajFKSnNXak90VkdQNTFnczQyWEVRYnlaWFRxLytXb2tlNjdFTlgy?=
 =?utf-8?B?V3hHRTIvWUhHMmlBVlU1bFNxZEpzYmcxb1ZVTFRjNWNQUXIyNkFzalBEcjB2?=
 =?utf-8?B?VUpJdW4yQVNXdmZTR3JLdU42d1VpTWh1WW1PN2owV1FRaEg5enpHVzlXV1R4?=
 =?utf-8?B?b2htM3FIS04yWVNSSk8weXRQaU52R2lMNGg5YWlKazBrbS9mTXNQSDk3cmJr?=
 =?utf-8?B?QUFLb3NkOU85bStvYlJlZU95V2RNdXRwZEE0bHZzNEYxcWxseXZUaTJDRkYz?=
 =?utf-8?B?TUVpdlluRGR6SmswWGJlNEViQXJ3aVROWURGSVo5RkZtdDg0U2xBUThhR0JF?=
 =?utf-8?B?ekE5YzJjQ3pZUy8yb1BEWDhhdFRJV01RQlloZUNYbFdiRlkzdnZReisyREMx?=
 =?utf-8?B?S0tFRUpwc3JzZ2JMS1c0TjIxS1F5c0xTYzd5NXBrNCtLRU5RclhPaXhwbVdu?=
 =?utf-8?B?U0RVdVBnSVI0UzM5OU9PVFpyUWczQU54VS9EcWh0ZUtDN2RORzRUSnVEeEZP?=
 =?utf-8?B?dWEvTU5YQ2U4Kys3aUxKNGhLTnVUdHc2endiaTl1MmlBS2hmaVZOdHhzS3BZ?=
 =?utf-8?B?aE0zaDVGaXJLcVVqT3VkWnlyUW8ycXI0S1RubjNOUzRTV09YczR0WWgyMlFm?=
 =?utf-8?B?TEcxc0ltVXAzQnZKQnFZK0hxMzZjbEtZM1FvRFZuM3dwVWszVU5pWnZzYmZ2?=
 =?utf-8?B?SURTMitNZklPRDBKTVljdmk2R2FYQTBabWl5SkttblhaZGs3V0ZKcVJmaGN1?=
 =?utf-8?B?K2E0NE5rY2RjYlFWU21ybTVrTzFlOUxqYXZHV3g2Wm5DVlBQRk9rTWIzaHlN?=
 =?utf-8?B?bWNmcElXbnpsUlpQWUlaMlhXVnk3MUxaRU5DZ05XWkIreEtNSnJkdUY0T2la?=
 =?utf-8?B?NTVySitBWUJzc2E2WXhONmNYamtBdHVCUDJ3M3d0Ujhhcm9penRGYlphRDZM?=
 =?utf-8?B?OXlxUHA5QlcxakJQSDk5bWcvZ0ZIb3RjQnU0dG1JWklTeEZEajE5TVlpOEZh?=
 =?utf-8?B?T1UyNDBUL3FaMVY3cjE0N0M2QzRLR1crQlJmZy9hZy9qVjdTdy8yaTZRVW5x?=
 =?utf-8?B?c0xldzBMS3Y2QlBxU1JDQXA4RmlDd1FjeUc1Z21TaXU2ckc3L2tSQnZQeVN4?=
 =?utf-8?B?SzZjTHJ3dFpKRW0vbGFQWDZ5Snk2RWNtYkNRMGFGemJ4bUxjUWg3a3h6RCtl?=
 =?utf-8?B?aEpGTFhpYzNwUDN6NXF1MVhBV21iS3BQa1VWV0pPaTljR0JpVDdOUHd3ZjV1?=
 =?utf-8?B?N0hqdmRjeTgxTWxKc3hkVFloRXRyVkRybUQyMUVidnZWay9CZ3Q3WDhNdXRu?=
 =?utf-8?B?emRweHhjTXNRdWYzMEZ4Y0lHem1MYnF2ajZ6VDJlMzVqd3ZSMjhsSG8xemcz?=
 =?utf-8?B?M2RUT0VqL29jWGlsL0VJUFVFTEhYL2greTVCRTR5bjlLVlpTZTQ4WDgxOE9a?=
 =?utf-8?B?YWtKNWYvL3J6N1RaNWNTNWd2YzhvblBsZVArUWJaZitYUUFhVHo4Tnh0dHk0?=
 =?utf-8?B?cExPSS9QWHFyS0RWc0haQlZsQm16UXNwYlllK0d4U1hld3FsVmdKYURGTmZV?=
 =?utf-8?B?NlBhbUJaSmFvODhlYUZITkZGdzNVZlhaOXR3am55dTNvK2E0cW5sbGE0bDgw?=
 =?utf-8?B?elNKVWYrSTlOcFNzalNGK09HaUtnSnRZN0JGcS9iK0ppQmlGTlhtT1p2WGdK?=
 =?utf-8?B?c2lQazhsRWEvdUFIVEF3K0lla2dWNWlTUDYvMVFneTI2ZEN6cFZGb1p5VFJL?=
 =?utf-8?B?Z3AwcTd1ME9yRjNSMDc1OGU3MlF4cUFtVy85OXRnMk5PK3AxRitvRXpreW9M?=
 =?utf-8?B?YWlHVS85REdtY05Ha0NRc09ON1NXUDBrd0RDVzhNbFR0TXFYZjZ2dmYxZlU1?=
 =?utf-8?B?ajlJdnVTNWV2U0tBN29QM1BoUlRSUWg1RlZaT3E0Q2RkNTFUd3REaENMdjdy?=
 =?utf-8?B?ZzcvbmdTcTBlOVJMYkUxRDFrYjN6ZlhEYXg5STBMcmtGNzgwK1FJNkU2c0Ru?=
 =?utf-8?B?VXc5QlZzWlRKT1pWb1h5YmpMWGtubDBqQko2amFzcUxrTFg4WWxORHU2Rk5U?=
 =?utf-8?B?Z3dwWXdoY2k3aVlrV3NYTEVESDB2eGFIVUxBcTh1QTl3cTRxNW5YMTZiSVdN?=
 =?utf-8?B?Z0lycmIrbXhKbW5rL2dFZE11bWtsZE1BQ3lXN3pFbElDRExjZkJmSWNjZnp6?=
 =?utf-8?Q?Zwdn8XdAGjw29hX3pPzXthjW5Qz1l8aErVuk8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bea8938-f56f-48f3-95b8-08ded68f8676
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 10:08:26.1028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OqoQvfVA+w0sGhBfcYsKVNCues4uWAYs0N2OmOgs1HcedWuT84Jkm6GxwiKI+ONFD3Z3IzYcdjxJLpJMH7ppiEBzndZZDjgHVlqJfMWrHB0lRVMiFok7fYnXuTuakXR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10991

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
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v5:
 - keep remove() callback as patch #3 needs it
Changes in v4:
 - add my signed-off tag
Changes in v3:
 - add R-b tag
 - cc statble
 - drop "sw = data" conversion
---
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
index b05d80e849a1..9a33c06d6fc3 100644
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
@@ -741,9 +736,7 @@ static int imx8mq_usb_phy_probe(struct platform_device *pdev)
 
 static void imx8mq_usb_phy_remove(struct platform_device *pdev)
 {
-	struct imx8mq_usb_phy *imx_phy = platform_get_drvdata(pdev);
 
-	imx95_usb_phy_put_tca(imx_phy);
 }
 
 static struct platform_driver imx8mq_usb_phy_driver = {

-- 
2.34.1

