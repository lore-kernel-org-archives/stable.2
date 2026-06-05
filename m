Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1733F9F22;
	Fri,  5 Jun 2026 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780657810; cv=fail; b=W5IHeNnLjbR5jX2/YCSx2f4hYNCwL/nkvPpEO9/zxmNtHtChH3zafW8FQQx9v7RBpu2D5KaJb3gW0GdkLEigekHg4gnjMobmrr1JiDXiI4AZdgObkgwbCMA65DRdmMm0GOTh+L8AVMss9Yy1hrGd4IY44PRp4rB+7oIYEO2NAJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780657810; c=relaxed/simple;
	bh=2ZKIwuazRGW6fe946+oE4oPI14Ov9VJ2ILWsmPPE34I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FCzrfRHm0/upWxvXT0MarFhjs74F62RZqveJy4W/BcPdtI2hhB5kahlPhN/iAeokeIDIrYgPtwrNbTU5Ax2bU68sKOddHa//InkIxs2JU4avq2r7UICFTwNr5m5HeXPxzjEyNcZWZCePVPEFaUs2THdxzM1LtXNw0C2wDXjO9so=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JQ5uI+yG; arc=fail smtp.client-ip=40.107.130.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JQ5uI+yG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/czWndQdZNflkuRwD/TZnDyjtzMhmRquWllzkVJDyo3hBhq/3wAD9l4fT3MCjYwOL6iNzFHTB1Gev9Fr+1fLDptqkI3EmIgM8E1FrkgvzczRAuLmIVgnI1Wkf7VZoxWij8CNp01UBj30j0K+fS1bjotL2A3ts/lGDKlElfF7/SrdfeaRAtdYH0I3VK7yAUNSM2NUEF2EkxW0yoKadLXGceKOWgGdS5+OeSXKaxwiPNmhmMh26ZDLzrgawx5PIqcqJJR/9/5ZTfKf69fprzeM3Cd8Dg3nUjyYrr0NGXCN6cYWSj977V8/WRChpWU0Rh5qcQFvU2zVJYGB4oQ4uTXEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5b6BLz0p6WpWd8+HpT3JO5IaT5Daq3wrXq4NxEWqlk=;
 b=ptmEB8BByTSXItMokM43E+L9fWkFXUFICE2KJVir+9i7nnG2FWFR/mkbexwUZ6xZ1QYZUxswp472bw94qhr4x95JZgLkFHtBJVZY45ReBKPI0jbVZtIdQAdz0iqCn2MbvCyZBx4MmoyUkRtOntLZLheiCvh+EFvWIQuwvmVtDXQWv+E9lDt6bD7XTc8Jh/Ez/lU26X/igRgofk3T84IoIwIP1LiCNeyvNCRNccLFCuwHwl92zEcHUF1ZE8MYsmjcuDXoTtqAohbIVfYDw0DD3oTpS+PHMsDjLBcFAQYXYQ2UCWDr1z2jrf2u2ngUmswalbl8NShKnqwCCHMYmS0lpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5b6BLz0p6WpWd8+HpT3JO5IaT5Daq3wrXq4NxEWqlk=;
 b=JQ5uI+yGHhnwjEZSCalUJKAKWjbxSw6FUCQTSLVMa65v/mpeO0fC16DtRV9eTtMQjUPbr+D/aHGWevcdLU9h/PQtcj40d3DBiR5flseZf0PUdyujko58gH+bVHEr9keLexAUM6z5jyD3q2zMpniafbzjMsxVJigA2wdvNT/NaQIJKSdutOde5HB/DivsJJPPiyGD4UUgS7CL9x5cl2IgC8K/6HYoEDI+X0W3ZlAiH6QC7Xz+UVjoBxGoM9PUFjGrV8Pv2ADuSKLzzeDStjqkdDnfud0M/xATJ5CNCVc9GaepFf6oPWzJfMqXjxkzA5BpeX8HDTMoOtLo+vpHROBVXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by DUYPR04MB12689.eurprd04.prod.outlook.com (2603:10a6:10:661::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 11:10:07 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 11:10:07 +0000
From: Xu Yang <xu.yang_2@oss.nxp.com>
Date: Fri, 05 Jun 2026 19:13:02 +0800
Subject: [PATCH v4 1/5] phy: fsl-imx8mq-usb: fix typec switch leak on probe
 error path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-imx8mp-usb-phy-improvement-v4-1-b2ddf2f3862c@nxp.com>
References: <20260605-imx8mp-usb-phy-improvement-v4-0-b2ddf2f3862c@nxp.com>
In-Reply-To: <20260605-imx8mp-usb-phy-improvement-v4-0-b2ddf2f3862c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780657990; l=2922;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=qOA3gj0TWYdDeGXgFIXNdtsZjA5h2wt3bcYdtlRjhFM=;
 b=szdXS4V2ttYIWGq+1ZRG7Ytt7knMlZHhGwrrerE2w0YiWcymqSwKEOyt624ZWwngZ9k0YV5W7
 lnZwUF3AvT4DNwkkY5HU66l+xELUKnSJs5dkCfyPz7UyWLf2+N83VZn
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|DUYPR04MB12689:EE_
X-MS-Office365-Filtering-Correlation-Id: dd852fa5-b650-4937-98c3-08dec2f30069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|19092799006|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gGkyVK0QTgrBCGEk/oX7Y+3K+drc9z2ywnV2JoILG6mHV1PAp7cKzHiDOVW23+DKLf3PCgo64h4gURFnODlrrFDP+/OJgPhUlDV4gvbUFSIh5BRK0K7mfQSJWjt51VAyBBjlxbMv/OE1vcQ0+h+k4HLgcF6HJDrcSgOBRcl8W0gFY87CtnZE1iD2EwWtv++cGAGbP/DwPc0VSrCiC71FE2k54BHt5181BX+thsuN4TQIImEcY8y9NhgEstXbDtYw/90oiuPmpxRUx/qDmLKUb41CFipvDxtKCO54Qzq6LhAiWtC41ZAj3KP4+00xlIcUl2RiT9eRqgDDp91qFoKPK2HOYTQe0RZ4xbEcSs+LGM+dFy3/2TMU3qoiXv+/YrhiKmOaZncbNoCUNEYAwj8eydUJ3J4bw9Ie2kvWKBQcyG6lZRlA9kbsMmjDflUAwmkQRAh7RM29tJnL/HoHpogds08F0xy6QM1n/8fjuXDQb3AysKQcCBWwV/x2l8srvqVViXpidHqmsEKRlk4tyoLKxrBdW6J+QVnr6FPpgEvKGpF86KaPwnaw7654n/UNcJNi2wGt9n1zDTyXzQgTcJpILs5hAJ+5RVju2JEH/frvQf8uaSC4a6JTaq0PS5vYOa+4EQR38wlPwktyhN9jR6ZF4KhRGDdH4qBBsdjuG4LsMvd9I24D8xf31Tegmiy7+sbI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(19092799006)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2ZHd09XcGc1ZERhb3RTdENyY2pWWGtDQnl2N0txY0lkWVFzRS9KZGhjNTZq?=
 =?utf-8?B?RiswMyt0TFJoQm80OXFOdU9jajBDQ2tWRW1SbGphaXZUdDR2KzBCVVhZM0Yz?=
 =?utf-8?B?REwvVXhkNW1DdXNWZ3VQZ0FIbHQ5aExHMmNsRW1iZW5wdXJqTEJSNDcvOFpB?=
 =?utf-8?B?eVY0Y3AreTFnRTFlVDBkS0xsZDArNktUSmVITyt6WGF2ckVxb0loWmU2VlJL?=
 =?utf-8?B?cnJKYTI4dDdySk44Ti9aRUJSdTQrS1hjYlpRdm50OHlSRGc1dEJUZWpLMERp?=
 =?utf-8?B?VFJFN2p6RjUwS3EyTUxUeXlKKzBTMUNUZWFYNFlrZDhoV1VNZmhEbi8vaTho?=
 =?utf-8?B?T1U3RjNFb2QrajlUMVFzT3JzZy96N1VOUEdrNVdta0RhdUVSTTAwUjd1YUV1?=
 =?utf-8?B?WE81dGQzWERQcE12dTdwQit0eTFnRlE3VTFkdTlvNXY0MjZTQ2ROeW41NVRJ?=
 =?utf-8?B?ZHYrckJIbHZ0Yk9IRk0vdHhvN3BFQXR5QzlrOWxkNzNHYjg0ZkY0eUpVc3lU?=
 =?utf-8?B?dXF2NVE3K0U0NVdyZTZlSFd1akZXTkNKVVlyY1c0N2NRb2tvcFFFVHpXMHpu?=
 =?utf-8?B?ZXVuaTZGSUo1QU5OVlc1OTlLaFU4T2FHWWxOaHFkbytVckUrRDBmSVc0RXdE?=
 =?utf-8?B?cTRid2pmS0VPakpUTWpuT1FMaHdvMEt5Sld0dlg4eVZrWTczMWFsUVJGYUNT?=
 =?utf-8?B?Ykp1YUYvLzFFbVZXREdTeWNFWmNBZENoSlBRbGJuZW5FWlhSa3kwZ3hNS0Qw?=
 =?utf-8?B?QlIxWG9RcGplV09DblZlMkVZRDZGZnY1cmtvc1BpeHkrQ3QzalpqZXo5WXpR?=
 =?utf-8?B?YTc0bTQzYUxsYzZZMUJ0UzRXQW50R2cyWkI0WVBHcTNld0VZcWY4d1F6eUp5?=
 =?utf-8?B?UnRYOHVZaWhnb01XbjFVQS91QWRZYm9sd29UT0lhZ2ErcGw0dEkyY1JUaDk5?=
 =?utf-8?B?cnlZYjJkaEI3VkxLZ3NmaHR3TmZuWSticDgweHZzdUFVOEdpSDZyWkJrUWlI?=
 =?utf-8?B?T1VyRExoSkV4RUZlTWtVM0dmaTJkNjFuK2dnYUxPMEhqR1NsZ3lGT2dXUm41?=
 =?utf-8?B?ak1aNCtHcFZFWEtiUzV6d3Rzait5dUtGZVlOYlBwMUl3Q24wZlFsWW8zcTF4?=
 =?utf-8?B?NXhsVjVJU3BPYVFjakhhRVBHakJHRXBNdzR0K1g0WGtjSThZUFh1Y0Q3YXA1?=
 =?utf-8?B?TjFlN25GWFF4M1F1MzJ3ckFpMGNwODYzSHRiTUl3Q1BycVZzd2kzOWdoUTRD?=
 =?utf-8?B?bXpIODVUL3FPeXl4MzdmNmFybHB2VGtFOFBjbksrTkFNU2FRV2l3QytWSFNB?=
 =?utf-8?B?OVRiM3RqcEZwZmFOZGpaaWxNS3F1QlVkendkWjZOUmlURzRlTy9JcGtaYWZB?=
 =?utf-8?B?YTdlUk94OHFpYjhmMzJEL2drQlJsUVdqdFBMQlhVZ3NtNXdicEs4RDVOVXhk?=
 =?utf-8?B?NGJJUElYR0VZaVNsLzdOZExidXI0cTkyOFdFc25kVi9MYWU3eitlaHYwa1ZZ?=
 =?utf-8?B?VGdDL2VIbmF2OG5ZU1IydDdQU1RSRkhMdzRUN2t6QjdRaVF2bEU4ejg1Y21s?=
 =?utf-8?B?SmlDdEliVGdmb0NxazFxTnJGcUI4dThDSG5qTnFzcy91aHJaWVZrODhralE5?=
 =?utf-8?B?Y3pmSVRDRTZoVTB5VDZNM2Y0Skk5UzNtdjJLUkFadWRUNWJVZkRQUno0dXVi?=
 =?utf-8?B?bG4zVDUxWFFTL1pLRHpMWXE3NDFvQisvYkM1RGlScEJXSWJkazZ4NDVkbnA3?=
 =?utf-8?B?MXBUME40bitGL0dBaytOTS8veWVLWTlCbFdmQ09FMnpESlBFQ3ZCSnEwaVVR?=
 =?utf-8?B?QTR0OHJjT2RVTjM2TTBCeG5JUnp4K0RWUEJKWWoxcHhFV1Z2UlhOQ1pjSGJN?=
 =?utf-8?B?MCt5ODQ4K3BDRDJBZGF5TVpPcVl5T3pkMFF5am03b1VHQlR3K29UZ1pneitZ?=
 =?utf-8?B?b0dvM001RGdXNDdoeUxwcEpQK3p6TnpCUm01NktncFNVL3lpdWdhRWwzNHNr?=
 =?utf-8?B?Rm9YQ1lpbzhNRDEzNmZ6RDJEbjBnRHBvVUF0a2JObGUwYlMvSnVON1F4WjRP?=
 =?utf-8?B?NW5sZXFwWDlaOXlkblFERDhTQk9kT2pPYlFLeVNFQU83YWZBTXAxd3lGQmhh?=
 =?utf-8?B?STR6Sk9vM2x6U2x0UHZIWnZzRFN1VEVTMTI5L2tpcEdxMTRzOUJXdHJlTHQ4?=
 =?utf-8?B?b0xtMnI2M1JwK3lVSzZNZzgxRzJYSGY1Mk8yL0NNNkY4TjZOVkhsWmY3dERL?=
 =?utf-8?B?NXdDRE9ZVEFnaWVKOE9VSHQ3dkNlQnJTemhtQm90V05pN1JEdnl4cmMya0wr?=
 =?utf-8?B?c3dkRWQvaXlDZzJJVlZDSlllYy9ORVVMT0tVQUNmbThNc04xUVZyclFQa3FD?=
 =?utf-8?Q?8cJhQDel9t/rCv2c1+sXtKooIZ8xtgWGzZTJS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd852fa5-b650-4937-98c3-08dec2f30069
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 11:10:07.5624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1+GcszuKJ5+uiqAWXQUTwqFf11cDDEDjDlXuP5VzE+ncWHvlsXXfw6jkfyLA8cCILBqkrqdZj1Kr8eLFruAWw5xxp4n7UCnLCxjjcT0zNqkbygt74tHHbROjoBwtB54
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUYPR04MB12689

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
Changes in v4:
 - add my signed-off tag
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

