Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010019.outbound.protection.outlook.com [52.101.69.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E202C0296;
	Thu, 13 Aug 2026 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609541; cv=fail; b=AX2y3KcIgiKc4VqZQFJneicUBSfHUTPdopRVUx5HPWaZ4E9vWoCJ5+fReQnIMwGF+XbPCHmfqVhaP/UXleCRUozuUCgIlIKTqqToKisMh+hrODef5zBQqxTyACnVX1YkRm2ZDRLAfz+tmyj9zLjZCRqezqpjRgA+lE20Sx8LxJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609541; c=relaxed/simple;
	bh=gWNOvAVgNBnKsvDTlwyncYr6WqS1u3Eq+UAyXiXb3vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=K4GL1aU58mj4j0N/jsGip0Haz23LywJ++h2avo1z6srPJqycKrAY2IdF7/0R/XQ8oAsUbSsyUH/aZr/pIvVWe5lGpw2fvGK99uL9PIW70NJkuJslF8KvbMfxBXBC83zkrRFOwRGRdtxmH7zVF4E12OWMgxTbElvi4PDghzL+vQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EZNKK8uw; arc=fail smtp.client-ip=52.101.69.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EZNKK8uw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0i8IoQuT7gnHcuE5qcPQeT2D2Z5srOQ4ETsJMmyQp3TffnlVAcMi7jdnvzbW9AM2RZtGJuyiMQojDBacqi83ECbiQEPwZxfD3rWF7JltHIYQWjVLHU0s9MtTGngTkk7fjJFEakt8X3QpEQrRcGxY38wmKNxH879N8rBN4iwy/L85IlV5aoOrmEgtxLL+6eKKg4+zT6dblXZsvMnbAaYHCNKSqlN5uEWLV4ZjYmDAhQqwIdScwE+/P4HUwGglxHUPboKnPX1kPyXw+wE89U0DqBbEE3q2icNOX5BnnbiNIXk+0+O4HZwSutUgiMkzHvooZniz4TJFqzavrPihnOT4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejniql02SfwwOOOcI7+HB/qQKUEdal0G1+U3LL775ws=;
 b=mHZfpzUlf0IBVKFTEvEThhnYLWDW5kD3Yf0RwGZHAOjp6EpyxGQWBLkyr7hxnTZgVbHDWts6MLmttiYPMtDayXT4JIg4GaINKoRYgZmyUaYPMeTjxFO7jkNJtX4H7XuM6dhSKLsYLJA8DctenQCBtIvOjqc1nTowUlHOv4p9gYb37z2BgTovEL+wH1lucXMl1yq/AmkoY3V/ztSeWJx0Ddi68p4mSSqkqI4+t7XO7m/gqyQh2ghXPnj53XOibOlY2Jxo5pZCU8MXNRbdTXhMOUayWtfIle76LfdpxRBKgrK28COfON4wSftG/M9lQIXXxAw6bDdpsyTYuH82rPX6CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejniql02SfwwOOOcI7+HB/qQKUEdal0G1+U3LL775ws=;
 b=EZNKK8uwriQ2kk+uAnqm9o5A5KYhsW3Dsp4nQ5ndpaZfvNeAxlfpdIu3S91SCApJ37HemhYUkSxeYW1YqfRya4z3bIbzGHBUHeZJPpm8u3evYRKptNkjt4WK/1vPqjQUaS3DijvqBo2SHztcEsD2DjSrK/qll6cK/CtChW2f0068dBeS5ooS6yGkEflpOoNMPdzAClV65JZ9aeHbzDgJUamWVj1qWgjV40GU8VjJzD2Uf9GNXJTb2IgHDOxskmygkANlActZyH1k3jqLWKjmWuJy0iqyhooJQ3cLrmBUFDY2MZi+LBS7Vj7XubeSt4qTYz874mR0lsCymjnegIyHow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 by AM0PR04MB12142.eurprd04.prod.outlook.com (2603:10a6:20b:744::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 08:25:37 +0000
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d]) by PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 08:25:36 +0000
From: hongxing.zhu@oss.nxp.com
To: leoreis.costa@gmail.com,
	fra.schnyder@gmail.com,
	francesco@dolcini.it,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] PCI: imx6: Move clock enable after core reset assertion
Date: Thu, 13 Aug 2026 16:29:00 +0800
Message-Id: <20260813082900.270003-1-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To PAXPR04MB8096.eurprd04.prod.outlook.com
 (2603:10a6:102:1c7::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8096:EE_|AM0PR04MB12142:EE_
X-MS-Office365-Filtering-Correlation-Id: e484df26-85c3-4d46-d1e8-08def914735d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|23010399003|376014|18002099003|56012099006|11063799006|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	Avl4AJvf87/5JeP9qDI6ikYlBc2H4tfD5tgluwX3MLumgGycVkWwPZQQa+pmr0jvCa0PIHZphQfwWJLgG7bUUvvJi5+G57dDaBPiZgRDPaO0wRaSZHbJjy/F7t/BYjIj3hPqoncj6O40SyvJUa4KUJFj0eiuO3BKpQAXFl71b5+MsSsmbot1wGGnR1/JubVsDAnyTDoQf55Ilt/uL1ejIKvsUXl2krIMRF+cY0AqfRB9geohl4j2QnNGrVaxH3daVEAOuUMl2Prg897Nzw14UXfjuSU+WOUTEv0sp3QiYFygShWLosk/ABTL+h7J/jIFy9nYmbP92Hq4gtRGFYVXKoS8s+vezwXA17LGn89iIFIbPYhl9O+bm8/GGw71qYoaWEyuEGcfT77u9AXm7j964IfaGUOx4i0n+t64gZmXhys3qEfWQyM3QCiX3b8x7Daeo/1mBNnCTugZLH/g4rqynd6r+IsaM1ajYdCYcgsxtCP6/CEQcfjYcTeTqy4UNsbddi2mAR4+dhXjYkE6V690tDqRky8kxblRhFFLI4/7g2z9qPZdQLbkbWMA0E8TsL6xMptXmVNUsueQSXKFzjGbpQnDKcAT/cAUqxSPZhWfRjVNQ9kki+iwMX4kwEhCCFOrLJk8dWKLyEi37harmRJiUhIae66rNC0NZ6u1Qcssntivh8n+Sc0DJgKhHZof2xlgxLPIsq+GwDb/9g/N7C1ZfQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8096.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(23010399003)(376014)(18002099003)(56012099006)(11063799006)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pMGcHnnuUi0qwljYQ8KIFraUMvcpt3M+ohyzCollUA+e4r6EkyTITgk/cCm9?=
 =?us-ascii?Q?kBS5NB4KrVtWy11xG40iL+kTSImz9jHU8trhn+bHEx6iO5TEcDF7lwrW5zSV?=
 =?us-ascii?Q?w1nbX8QqCvY+DnyAADYVf0mzMMbug+2RVnN4NDTk/AyarQ1ahanESzHlUaCQ?=
 =?us-ascii?Q?Pif5/hlPit+zgfpCFHN3tIjy9ZMWmXjZ8Q8vRF7S3AKdNzXhzDdZchHwZdQw?=
 =?us-ascii?Q?FQn1rniO4+loDXXxBM92t4+o9L2jIV1gY9uGsmN1QGyR8nu54Y9gdwbiPrOb?=
 =?us-ascii?Q?drIAlqyPJZqLhGMRLtsxuW416JO9Ut9luBieG8aWO89KL5CAwYymYvPSEINR?=
 =?us-ascii?Q?RXS7LyICwx/erYYNd3kEZQwVSmkG/+ni3RvuNC5TozmYQI9VrDNzQc6/Q1/Q?=
 =?us-ascii?Q?/hgPWwcsNeuiDGotxcMhFQrRDmm36rZPBF45KFcgLFkXTD1n4u1w23UchQes?=
 =?us-ascii?Q?ynPDVt+LNCPYeYQtTZCYZFbp4dvkRZK45dEwP4rSX9LLE7VSPHhEbRpWOan9?=
 =?us-ascii?Q?oyGsHq382zV21Lme/o7tlvdPZH0j3IlqKnSJZ7VbTVszQBh0WPxF9MIv/uUS?=
 =?us-ascii?Q?XSp/+4MsUICht5bKyLE+/BXghSck2CAHTF1eEiXO4ZGuZR1bHEGHjvymdROG?=
 =?us-ascii?Q?cHZMPaojAc079Wiwys7lahmgk1ua+gHB317pIGPVD/MOGpaXBP2JFYzUIO7f?=
 =?us-ascii?Q?3gohFCQvRgIFID40wvGKbHWTVDItzn5zKRoXps0kswVZhyhsi+3eOYplDkeN?=
 =?us-ascii?Q?m3tislb4OXVyoK33HMMjEYVRU3HDKL84d1C/rjJBUVxDZsdfosgvSlaOklm9?=
 =?us-ascii?Q?VMXM9SoEATbmMGHCGlcKyKaozZ13KcVBwa5gPgHj1ybwiZm0t9B6keHONJda?=
 =?us-ascii?Q?m4kvZJwSaqgBl//zhNHTQZ/pQxGQy9z/r03c4RTZe4KBQnl9kPNs/AzC3+dP?=
 =?us-ascii?Q?T69B52F1AEhZOx46Fsg2ORGQgRTL1Rr831iAiugIxN5kjYx4X50q5N6iyBVH?=
 =?us-ascii?Q?YsPaavu5UsFm3xF20LG0pRgRQsPXDqXrsTQDnC9h9xDPDcgKbb7zba12J5mt?=
 =?us-ascii?Q?PRVx7w1q6b6P/MEVxMgjhsCVTSd78KFWVcedJuyk8WiBESzd7yYx7pqkusSr?=
 =?us-ascii?Q?szYvPbktmMBpHJsJChkhbXkMMeCgg2cejrHtOsdxnYa1pKKI/zMVDSXmjJbZ?=
 =?us-ascii?Q?oGpAcD6OxkXmOTzUChS0HsgU5dujU+Ngx7c48GXwVS5KqqHF2ValCAGgZIcc?=
 =?us-ascii?Q?Ss2VyS2xmdJN+RB3G3UxjFIBz+dYjhl0LbyB17UY/uvYaIetPA7Vh09RE13P?=
 =?us-ascii?Q?fB8rfYSm2DldWPDc56uyfGChpHU5OQT9u+zC71CL8iUWOL4eLvmJrriwI7VK?=
 =?us-ascii?Q?f7McRIyYwkAXj9shgIoEjxBLqnXg/cGZGj4XDctZ1/IzqqdJwnITLEYezBod?=
 =?us-ascii?Q?T66DkjPz0js3P9rvbb1ZKiBcvgsYDTkXBwThJM9kbVLkaKJjxfLjaoz4z4w4?=
 =?us-ascii?Q?k4PP0nVI0jmZjYZrTazMIp75yWmxJ3aHyNdHpAbTzBR/uTe60kiLDPYNuWUo?=
 =?us-ascii?Q?NoE051/XzcyVVMN1o8ECkRBzJnv8lWXq6O7Gy5vnHhV5InypNyphaZ009j17?=
 =?us-ascii?Q?PsSLa9pBF8LDChdqnTePxv+DmEOZXBFbIuXQ3HNS9aydTxV1Uxn8pw6+CVhE?=
 =?us-ascii?Q?/k5XpApodLTTdjEztnzzHg0Ungw+pv6xmIRHChaA9Lmg1+weaO6DSVPNUfLP?=
 =?us-ascii?Q?Gm592/8cquT/MYpRgd9BLdUPFRUgzSy12nkgfnXhNgtvIwP+nEXf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e484df26-85c3-4d46-d1e8-08def914735d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8096.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 08:25:36.6795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztWhGPx3Bi1Mhm4/0vr2E6ALq0/Ju9t56NqHJ/k0VUO4ZlxuRqTvX7+LQIwb3j9sxbljNFOPvVQ3AI2LequOZF4dZJTqiIs0XjEFLwkzsPKNrACbsDmJQBoeTLTZz/Sw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12142

From: Richard Zhu <hongxing.zhu@nxp.com>

Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
inadvertently moved clock enablement before core reset assertion, breaking
PCI device initialization on i.MX6Q Apalis platforms when
ASM1061/ASM1062 is connected.

Logs:
root@apalis-imx6-11486042:~# dmesg | grep pcie
imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 ranges:
imx6q-pcie 1ffc000.pcie:       IO 0x0001f80000..0x0001f8ffff -> 0x0000000000
imx6q-pcie 1ffc000.pcie:      MEM 0x0001000000..0x0001efffff -> 0x0001000000
imx6q-pcie 1ffc000.pcie: config reg[1] 0x01f00000 == cpu 0x01f00000
imx6q-pcie 1ffc000.pcie: iATU: unroll F, 4 ob, 4 ib, align 64K, limit 4G
imx6q-pcie 1ffc000.pcie: Link: Only Gen1 is enabled
imx6q-pcie 1ffc000.pcie: Link failed to come up. LTSSM: POLL_CONFIG
imx6q-pcie 1ffc000.pcie: probe with driver imx6q-pcie failed with error -110

To fix this regression, restore the original sequence where clocks are
enabled after asserting core reset and configuring the controller type.

Fixes: 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reported-by: Leonardo Costa <leoreis.costa@gmail.com>
Closes: https://lore.kernel.org/all/bl7i3obu2clzsgeoct2a4mtfhv6typcjdqmgneropf3hpgwve6@n2m5uhlduw57/T/#u
Reported-by: Franz Schnyder <fra.schnyder@gmail.com>
Closes: https://lore.kernel.org/all/t65y5d54axtksbfs7r4olcefqhwm6m4dz3njgnrnf7fcotj74i@o7avoznlafbj/
Cc: stable@vger.kernel.org # 7.1+
---
 drivers/pci/controller/dwc/pci-imx6.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 39790e66b98dc..f7a2eb257c169 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1394,12 +1394,6 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
-	ret = imx_pcie_clk_enable(imx_pcie);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
-		goto err_pwrctrl_power_off;
-	}
-
 	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
 		pp->bridge->enable_device = imx_pcie_enable_device;
 		pp->bridge->disable_device = imx_pcie_disable_device;
@@ -1415,6 +1409,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 
 	imx_pcie_configure_type(imx_pcie);
 
+	ret = imx_pcie_clk_enable(imx_pcie);
+	if (ret) {
+		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
+		goto err_pwrctrl_power_off;
+	}
+
 	if (imx_pcie->phy) {
 		ret = phy_init(imx_pcie->phy);
 		if (ret) {

base-commit: 28d012efb4327f9c75d5e042a7c91e9a542efa98
-- 
2.34.1

