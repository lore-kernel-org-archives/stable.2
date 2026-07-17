Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013019.outbound.protection.outlook.com [40.107.162.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FAD33A6EB;
	Fri, 17 Jul 2026 03:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784258958; cv=fail; b=jt0DxWvqpdSJGPd3uvwRxlQoD+yXKxk/4ZLWJw17RmlciZK0tZvphU1sYxrrJ/1PseSoFc/Gd8UDG86S9pjOJlZL40a1J7MsFumX9K9PqBdeKp5fDHW0MLBQ2w0NDZqqAYCPgqOg+c0nurvpZyB2lcK7OyEjd79dfE9mZjj33gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784258958; c=relaxed/simple;
	bh=jGq5FDmXuG9hdrBjMZuDTtmbfqEp6LU35C6+BQrV7fk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MyKvGwEbKM46zf3ZCt63vI640UO0/U89aT77DO0969gVlVEC7rRhiWo4lJZV7+wAwlPeaIkEVJYwC01YlnDox01pRanAi7OGY9NedLfYdQvq25/k/SsPIb7bY2wIV2XT2mYk8yOYeFFFxC2ztY17hyraSP0LFnbNmea+f65iCYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=vA7pJd16; arc=fail smtp.client-ip=40.107.162.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vA7pJd16"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vs6VMrCzWJgl49Zj2YSYy0OyagtTLMSPU6YB8TOsuT9TQpI7BXTNkTiArVRVhAOXNZAYGlDu4Qe6dbvY8d5eKPhiMHh2EmlhF+/+8mUa5thH5RLrWHmRo0+82N81G158HMINVc0f3IbKIPna3tvmQuEMvVQ/fwoxrU9e5r1b2lbWVd9DQR8ZLHCpkH72vhkFPZSF6i0OTcfsxSFDFIdEc1gSzapi2YAJDoxDnnirbCyXqPJ1dY4r93iwjlDrJTUoBQ6YF/gEC2BxWSphkqb6WW7roTpsa/5EVgf94JjPxc1Wph8Sg9RnIO3+BiAYSFnwXyHECiG5kUe0379ejHWvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vovqymC24lsh7WEhnvm0s+MaJD2xLhfJFjDKpeYHuY=;
 b=NOVKQy+CrD+sJqssKhBoI84KN+35X6PI9zr6Pvghej4USengxLHiNC+Gs513kmG7vTQWiQYSo+oY4gsUCR+usB0ThMaDrO6IZNcHxphDRO8q2hn46U4wzg9wB2kwu4AKCXH8UnqzC2R/vlYSFcQiJvfd7MOiMPsMrBEMoSkPsWdoKSoCn58lWciaDflLB1qv7uqRdelCsXDF6oIGLgKFowhUVpiOluIxgOolfUgzG0mGfT6MbibqH4rvxkT+wV5yc9MiptJ21/5T9NaxN4fExfJ+8GTXKeIW22hTEJHdoslYstiVEXClqpHVnQAaV53b3HieObDFcD8lxNdODygG4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vovqymC24lsh7WEhnvm0s+MaJD2xLhfJFjDKpeYHuY=;
 b=vA7pJd16M/7AUcl5QOnkPu8Oh9TrnHDl4IB3OY8t4O3dV1BdRGcajJv+gtAR4WCLbjPBfzAVLGtRYWKwSc/5dVtIhanVvgezw/ZqNJonBP921ffpDgP9POjYLPeBD4eRfk7B94Ol7bUGSMxbjWh44WlPR3rG9crZpG3/PDsZdV4y4yfeC8AxSGItK/vHlzQC+9Npjb/d/6VWJlBfbvdbHzV11axCnOPBOHvnQrwxfVoNosDeDhiQoHbIcSSL7fNeWZnMLhGcfWhZafHYpt0GcxYtlnSgbuoF6vFrKrJlHwMVevVJdPOD8GjBM02hHwfIBx4XYNri0n8opnHYLvsGwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 by VI0PR04MB11482.eurprd04.prod.outlook.com (2603:10a6:800:2c9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 03:29:12 +0000
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d]) by PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d%5]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 03:29:12 +0000
From: hongxing.zhu@oss.nxp.com
To: frank.li@nxp.com,
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
	Soeren Moch <smoch@web.de>,
	stable@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3] PCI: imx6: Keep i.MX6Q Root Port MSI capability with iMSI-RX to work around hardware bug
Date: Fri, 17 Jul 2026 11:32:03 +0800
Message-Id: <20260717033203.2965045-1-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0129.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::14) To PAXPR04MB8096.eurprd04.prod.outlook.com
 (2603:10a6:102:1c7::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8096:EE_|VI0PR04MB11482:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aef7be3-944b-4dde-25be-08dee3b391fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|19092799006|18002099003|10067099003|56012099006|11063799006|921020|6133799003;
X-Microsoft-Antispam-Message-Info:
	okdJSTU5qstFGoQD6++QzfZR0bdiNSZuVsGf/Y9Q/JRaqUqQbLKlv+tu7Eu0WfLGqpS9CKtkxVmE/sYOXM4suPdaNUgF30QaExg/XFwUlQKfc43CU80/bbn1W4Z0Kf9o/aCek2rU53s6T/K6AAMNfE9yvlr+uDgii/70ClhlI6nILmMVPy80B9jwQb+JChV0yolhDCZYTaLMJNT7YaGwrzJny/qLXUaY1MlQwNxe0ZghP2k8YI+tkfio14Uj3pEE+2g+E2jxDQUyWsSa4+IETiFROyyDpewdzcrc6iVu16P6T2LGkdDlEV3g5dxPE3SNax+Ola5SnsroJQ01qkoufZBCsxmKbzUcLdiEHOwFNj8RDvxd++3nqcQzlTAwVrcEjnRy49/JJQ0QM2o3hSzJOO9Zu8nAiQGGm516nbo7D65+vJFK4lcDGwz7tvD3scgNlvtg396OQ94Py7dH+KJnhU6YgW0gUgu/Wpw1Ly434RI26NHIz7oXLl2mSP/3CycNvyoMWJaetqSGYVvGwdFdG3tD6Yjn+XUIsyAVvmH2gh5Ic3tKgZNj5/NSgoQ5euLrOfzWhMuwMLSAXW6gRuevF59YF7koCJbmFYPkqmDo4/1XFKlFQYeWg1vGUbH6eWrzC34wvMqzOhI5XrkvLCJ5FdaZ/RmtxYSoZ5kZdzUdMZdORveEWbu8KgHCmsYRgMiUcMRYaH5I6/xIj4ScYa4ueQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8096.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(19092799006)(18002099003)(10067099003)(56012099006)(11063799006)(921020)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KRDJXFx/fkN0bXg1sxQp5oden7BI8BMCh/hBYuB3wK9PyFqfjj3x8gK7LjHS?=
 =?us-ascii?Q?wz319qBjYSWXQ3wzUl/yBl/Ou2+3TNjaOMVnnIzasE4PKfmQ4FQsqQ/b+MAx?=
 =?us-ascii?Q?nHBt8jaaenBHQuO56vhFgpZxSTApgi5/2zmb5mY1hLa/A27Wo17r8KqL6GGa?=
 =?us-ascii?Q?6HFHp/35VyLTL/TnW8gwymJCTX7firfcj0eTqRwuT7OTdnR6ThMdbkosr0AU?=
 =?us-ascii?Q?KlOLexbbfVsoWBCeyLveQWr2Yn9ZSIUKW7J6MjnExIEbET4zDCr+VcwUnoXf?=
 =?us-ascii?Q?oGzz1L6MQ/smtxpMkvy/zoi+eDxV99I/Y+BMhGf1g7/KPpTnjVVkSk3V8Q4v?=
 =?us-ascii?Q?4DH5N3J58lmHV2+wiMDJwDWnzD4/15ktD8AfQ28P4CUCJ17MgFHfGeNLnsae?=
 =?us-ascii?Q?xLhOhNuMA4rfVWae5udKa/p64vL7NsYL8Q3PU+KoMj3mP6ItNlKIIq7La6D4?=
 =?us-ascii?Q?DgbdInIcKEbgyx6it7HDhuhtdLYXE2e/DPamY2JBZ5F099GdQcR9D4ZHUDYR?=
 =?us-ascii?Q?LDa0nLMzeYuSlIvYOjWevFQNL0xJKo3rDe2K737jwGZvd91JPpsGR7qsXOSG?=
 =?us-ascii?Q?iIXySUmbRIO7/WIx11rT5VAugSYjnOA4zvi/QYNcPJV+iDw0yn8Lky3glNOe?=
 =?us-ascii?Q?52ARnjgfHalj6PE6baHfJpptaIECxzSmnt/GW9ELP1LGgL2NVS+uzBf9ldvb?=
 =?us-ascii?Q?WTWua7dyg5spusUpr3mMIM7z4gLh3nBeJVUK8M5c81f3ldA+wOatIsS4veZl?=
 =?us-ascii?Q?7XopkaFHTppkFlm1b4bewc1mLkh625RiPdWTFHScsjEPNn567Lpmsc1tMCIH?=
 =?us-ascii?Q?Dy1SqYz8f3/7qQ0Vq6Nhnf/t48RetXDWRGJIJYsobYyg6+oyZd3FO6DCRn0H?=
 =?us-ascii?Q?JDI5AoPTU5Qb9etFC6hcCTA3ghAbBkfYAw91URKFWAMLuQgs8S1nraDDkMg/?=
 =?us-ascii?Q?D9qdPYSXuOnJrBijtvMUJRlGGuknfHp20fOF5ePPA/rTiY0IvX2vDSKdlMDz?=
 =?us-ascii?Q?DZXxJCztbp/kEieiE7UCYF2e1ve9QpmGOs8In+QgmONrokul3fB85RNVQ25n?=
 =?us-ascii?Q?zJKM78K/VRxvhIpFPqxQaaEc+kWSsgAb9Uc+fkN5IIf8hLolJHSIl2XxdkiV?=
 =?us-ascii?Q?2PhPb84n5gHDmEr0rnQrSXTDcuvk+41tK5NsX0uwvQr3IQrmnh2l2sfoa6kc?=
 =?us-ascii?Q?vOX0INfWxtSIzEzU0D05o8C3Q/lB4e+J0RcFVPAc39JkPr86RA4dkVO9nKcM?=
 =?us-ascii?Q?TDWa7x9DsV8ysA6w++8HVfolpo5SP9FIbbgCAlXRXc4qjWZCDHPYRxLBXb86?=
 =?us-ascii?Q?LWSc9A8DltwnnONFBJ4nbm7tIh0Q67xDcB8Ix3j21XHZzQlOVDWyesK+euQT?=
 =?us-ascii?Q?N6mwpO9sYsCMqQYOUm8c14FVRi7feqHmH9cXaVU3MjXvHgUqFLZOn4NTP9HK?=
 =?us-ascii?Q?F0dO4JycRwt4boQ8shwdsPVKQQDfTcGe3g2TGcWw3lEVbA6gqGz6xPq/qCgZ?=
 =?us-ascii?Q?spE7nSddgmVyWCZ4rJ3gQzEetuCrvXC3eA5fRHz0NSElRv+DDDR2ukVB8Ebk?=
 =?us-ascii?Q?DpfasdYiy6dCFKYVyADYMpbRiiYtzMnO9V5xMOdNl/GpNU6D9pP3456aBUg0?=
 =?us-ascii?Q?CqQSavSr4vPbjd1nLn5jWQUXaERsepDlqqrna107RSIIty8c8KN87pnnz/Wm?=
 =?us-ascii?Q?Jcg2+OLfVVL67JOx6+uVVeekumxNA7Cf4PzJVi/UT8zeIpRmW307e9VSCd6U?=
 =?us-ascii?Q?F4lPpl71JIXbCHrueqRfHE98N4JR+us+bkh01yGsuiRA+h7KN20E?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aef7be3-944b-4dde-25be-08dee3b391fb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8096.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 03:29:12.6335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BS8QYW6gudDbXkounQU0SCJ5POH4QikUuBHPXc5Am3lz6DJG8Vq8Jif5ie8AQJUNsG5SflDS5Fd7tvE0KJ9U1fflk/2UrfoeS785HfL48m0oml1RZAu7KsNOPu8ZPM1b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11482

From: Soeren Moch <smoch@web.de>

On some NXP chipsets, disabling Root Port MSI/MSI-X Capabilities blocks
MSIs originating from Endpoints from reaching the iMSI-RX controller.

To address this hardware bug, commit 3a4e8302e72f ("PCI: imx6: Keep Root
Port MSI capability with iMSI-RX to work around hardware bug") preserves
Root Port MSI and MSI-X Capabilities on i.MX7D, i.MX8MM, and i.MX8MQ
when iMSI-RX is in use.

The same applies to i.MX6Q, i.MX6QP and i.MX6SX. So preserve Root Port
MSI/MSI-X Capabilities there as well.

Note that preserving these Capabilities means Root Port-originated MSIs
such as AER and PME won't be received due to separate hardware limitations.
Users may need to use workarounds such as passing the 'pcie_pme=nomsi'
command-line parameter.

Fixes: f5cd8a929c825 ("PCI: dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI controller")
Cc: <stable@vger.kernel.org> # 7.0+
Signed-off-by: Soeren Moch <smoch@web.de>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
changes in v3:
- Extend the fix to i.MX6QP and i.MX6SX variants as well.
- Update the commit descriptions suggested by Bjorn.

changes in v2:
- collect a-b and r-b tags
- use correct fixes tag (Manivannan)
  (reference commit that introduced the bug, not the incomplete fix)
---
 drivers/pci/controller/dwc/pci-imx6.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 98e1db751132a..dba27eac6bff6 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1995,7 +1995,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
 			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
 			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
-			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
+			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX_PCIE_FLAG_KEEP_MSI_CAP,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.ltssm_off = IOMUXC_GPR12,
@@ -2011,7 +2012,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
 			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
 			 IMX_PCIE_FLAG_SKIP_L23_READY |
-			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
+			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX_PCIE_FLAG_KEEP_MSI_CAP,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
@@ -2026,7 +2028,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
 			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
 			 IMX_PCIE_FLAG_SKIP_L23_READY |
-			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
+			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX_PCIE_FLAG_KEEP_MSI_CAP,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.ltssm_off = IOMUXC_GPR12,
-- 
2.34.1

