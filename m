Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011038.outbound.protection.outlook.com [40.107.130.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF0946A608;
	Thu, 13 Aug 2026 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614379; cv=fail; b=GMtKJXaCtC6Vb1vkGBYOrhhyxZUPBAJ01p8qfYedV05YbxQc4VxWmGOUfntH5mDuKJJI77DSdOphcr/toWchWitaE6Oybr5mc1eUUor/EpOsoGO+Hn5iow9m8S5DiQRhE/xcHmLkGwK8aa4qZQGMxJC5yRuwyS0JxgBG9MCoiSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614379; c=relaxed/simple;
	bh=AE6TAp/Oh2f6Wzqb1t+ZdyJ4NIPKHfSEAdO87+UnloM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=F7guCp/GyMcNg3qO/898/iQixGQHFAVoHsrtmf73JP9wxSyGHUriAc6c0d9RFs5V/RhaYA9wCfHCVR0/7ApPVZpsTJNKGHCUnVc1Hs3nYvRA71djcvt2Wp9K4c1r8YWMF/LWldtRN2+/gYxu75u4AjYav23r+XjgZeDGS1hmN9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uaDeloqc; arc=fail smtp.client-ip=40.107.130.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uaDeloqc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+yLqiGqU5QNv6UiaTzUv1KX5VQCIjm1yaK9myzhOyT6feB31u+IecJlUoNolGstGVneINfvahEZuIM4XfoMnC9J65jw2yLviLq7qCSHResKUj4VHvBSzWHBJf4lTbAaB1Y/Je48GbX3g24wY58JnpkYSW8kmX2pih58adZmRvakXU5A9E+cGowbGRbDh37wKdmp9TBOJtVRQqt0xi1Uh5SgOhyTyV/lxIsEeamDAeG4xp5oaTYKPguZT2cHS7lq82LsLqK6wrj3kPaNbrdQz9sO68Q107A7RcDFmX2ppmmE3thMil3vbFFQlOmONd2ITqcDV2etXm285vrw5F5e1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DBNgyspf7CVwOO3j0Sv8iuGpTx0TKoNg2cpDdG0ejM=;
 b=E/FCXoOVY/wHNzLNRHFc0oIUQav4SNmqXrLZgbmMy9LJHaVZ5+TgNOY59g0gx+tUF3MVc0n5iVpjrEZyqYFumBaK1l5ZaYA9UT3KwyaXKvzMNZPdRmEk812U3ILghiolMMAysMOsUn5p9NjRsivOQPcMj/h29ryoX2S9P0a2H+TkDsAHeRndB1o9/AWV3NdTYpPm7Pm+90nprLsZuZcSv3dRzSUc9PbOBhois2K0xjXxslLE5Gc12rkh7rKUVzCJmAWaeWJ8zTPAP3fa7Z87AIULqJgSFGmxCtU5pvVwcJHDsHlhYyLxS1sEyjs+xkwecy1bua+4DbohBkobpV/MHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DBNgyspf7CVwOO3j0Sv8iuGpTx0TKoNg2cpDdG0ejM=;
 b=uaDeloqcf+G08s/m9uJnqdhVI9/B9TyQjAsDLH96DCpzCHt+/NineOJ8iMHmyy8YcU68AA68QTXIL7fvo59wswE4JHgLqdjk2kzCz6EgckyOIJss3W0iAJKZ1S5aPdyUImhjsQjkhRzZBeq9mi9dKgdlU795mCJRcih8BZ00bCffhHWHL+GLCrzH/dxkbPHlrpvt+o/vmUal8CeO7cQkViYt2BotqU7CsDPvwgFKYi5taKy5C7BfRqtuyStQrdiED7xgPJpj0FZYdPg6LYuX084/baoXaaXe+0aWqTOI6O5lm9BV2c11Wa2hX7TVIK+3p14eGA7byE03wxZK7uDlQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 by AMDPR04MB11607.eurprd04.prod.outlook.com (2603:10a6:20b:71e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 09:46:14 +0000
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d]) by PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 09:46:13 +0000
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
Subject: [PATCH v2] PCI: imx6: Move clock enable after core reset assertion
Date: Thu, 13 Aug 2026 17:50:03 +0800
Message-Id: <20260813095003.356062-1-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::9) To PAXPR04MB8096.eurprd04.prod.outlook.com
 (2603:10a6:102:1c7::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8096:EE_|AMDPR04MB11607:EE_
X-MS-Office365-Filtering-Correlation-Id: 274198a0-7cdb-499c-7905-08def91fb67e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|19092799006|1800799024|921020|6133799003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	jkZeStTU7lxBa2x3BCdFpB9dq/kua7kSbmLUoWgC/OdpVIhybZwLdvIJ65e/uWwnnhGJ37lcgGvY3JLZcLiClmBRxgyUGde1n3ni3dx24Q+06r1PiqChABcebc8KM7QCKrkdZ0kp5xRIRX1aCZiogt4Z9SlXlmmxvGZS1MZJQa9ANDG76nN3MWShZ0LHkBBWzBKggo19lEVLlRKKnpHgRGOrh9hhfs0k/EG52KeEx5YSA0Lg+IVbqERW6Uz6IUDP2l9XsmSVid4Vgwse0JZU0Pf06kkLlo2qioUePW2tjgIifnoNCSrNsXiBQTkJIOm/jUlCKEATBRr1Sn/9SnlEnO+EuxX39K5ZvEzA5bL7DqOrQJy+OjgK44CEOVSaBuMr6Yx6PikAx8EKhyRry4/mG8vnsHCX0z/5Jm3Ef8iepE1rdLFUOdgs1ubGYv907XuU0fGbaBL7VjIzaH/7036+tSGkobVX3x0A6RyhxhwL8gWhWPDZWpJ5O6Ypzcjw4cPri31wrnq3+gHhzsWCkg5Erw7s9KMgm7jsQvQ/J77/NPVbI+pxF2RkfOfzYov0fO7A0iqQaxbW0Rm1HzYIWQmIudz2WPHJZYisZ+eT06pHaH3C9l6KFwJSFIR7o2BB8c54b8dt8dBGa2lApoAyjoeJ/QySkLJSHcDOtdIrvbQaigLhNJGsmd9RZl3HM9iKX+DY2GrWUYg0eGVFfThE5K7IZQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8096.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(19092799006)(1800799024)(921020)(6133799003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uJqlUYKm1DPY4oMJt1pM9BU3J8aKx0mhNGg/0B3MT/B2vFcBLZvbCiWYaXO5?=
 =?us-ascii?Q?4NkCtF7VL0ud6iuStn1FRklX8lW1xDZWrnShF33tBg8NwFIEImbMxOzMzGaD?=
 =?us-ascii?Q?9FpEcFqXgpvgRi6VPRWleFMeFgg7fpkWmEzryL++YIiXGYN/WqO8LrizZMrT?=
 =?us-ascii?Q?C2iY6v9UW0kNthLObuMdbyOiUiPUF+loOtAVz7QQ7XXW4NP7ojgCUytJBFe9?=
 =?us-ascii?Q?n245TMsmDrF6mFKPAm3YitTy7yGB3mrQ3jJBI9GahutCqPyOvSRiO8J4aSfC?=
 =?us-ascii?Q?pIXCOjRem8GXnPqqMHqa0eIRqMxrHVONcKTxP0wrOiwb5DpEp7Ocj9vL2fKa?=
 =?us-ascii?Q?maOHnqXdvk4b5WIFCLRWlYpaJ1zDmkUsOAuVp5aq1iazAH3QhnKDACKZyeYN?=
 =?us-ascii?Q?5qdl/zHUSGBoaO3BInZiN4VDxU+e+lNoF07mXb5rmRNOhUNdekHQNwiSN5yK?=
 =?us-ascii?Q?9UQ98906N5CHv1IrwrJoM54k7g3eDbGJuKucugi75zn5c/8HlNG5aU4Invj1?=
 =?us-ascii?Q?t7mfWhuRx07BSl/naNtEEu/Fl2gSxqCEubwM9jDZ0ZHRFqfph8YKqgxW/+jN?=
 =?us-ascii?Q?tCMRdJwBoqpUv75tB9Sccx5tR1yb1Sy2mEmW0U48qmKpSUcK/4J1HpBZbQEA?=
 =?us-ascii?Q?J1vpGv3EM1ULuiZrL/xxZPebQ898v0cWs3KDsOZ133U2a0wvuQWr7G8CvrDg?=
 =?us-ascii?Q?fD8uEmuUoloC70Xn6uFnjuS0OY5hWJZQNjPxpOZz0KoI3RgBmwcu6ESQr7G3?=
 =?us-ascii?Q?18fxGYbeJ1vvzXnQ3jqBRQWY3YWf7hjI0bmER9VjsCVEyimiB6TOa6J5Fvua?=
 =?us-ascii?Q?ABE/wz/WGg+qs4RtX1Vb/R7TidDy00FQAcnDTVHh6Lygw5rf8bLHqqpp+ZPO?=
 =?us-ascii?Q?/WAwzh2wDG0S1x8iBLOzOrg9hMAL3CASPGtq4hC2S0SfBXcTt/92208W56lz?=
 =?us-ascii?Q?elmDCp6Hh6zkyI+STUVyMd4dwXsD6rDWA1x5WlRSOufdFlhjMzUPr8ZsGiTC?=
 =?us-ascii?Q?xO1bbpc5+vw4LX6ZWZ5MP28/IANceSegbjarNJPygPtyICLJU6PxHd0z2yvn?=
 =?us-ascii?Q?mx5kq+1UCHcz/ts2l6CFBfP2HXq82IB94+OsU7ekM4VKQWoyjMutPxPoHKqf?=
 =?us-ascii?Q?ZT5Kvh+pZdNpU77p1OpU3TpFLKURrqus6TZJxvDCYU2HgAn/i7YdFA4lSUDl?=
 =?us-ascii?Q?/2+zM0A2ZTgOeXTR0usfmUETkW+w/adg0TFxZshcU01Qf1VUtAe5ATAiRR7o?=
 =?us-ascii?Q?JgOvxBawAC64+6ynq0/H7S5qM7eorNM3+7uKnQID11WzO/Z+JEeatuVACik8?=
 =?us-ascii?Q?NxLhwXyuJXVMqbYzSiucYI1KXp+/OZhi8qbmicNjxuR0MrtRp63qZF/zR78h?=
 =?us-ascii?Q?RUX1y6tQzn03sNoWe+hLB1WWB7j/u5fYeH4rSEbWujLLcNZml8aDmjmqf8BO?=
 =?us-ascii?Q?lcSVXhI8AyifKQ49ZbkwbdC1k2gv1o2YHSTsWnyPt9O4B0Q8cPcjNVaoXE5K?=
 =?us-ascii?Q?tD2wDBqGz5iwMN77DzNeRz/fDLWDQewcnhybFwXnbmTUU9LBUneNZtyX0nfl?=
 =?us-ascii?Q?ITbYmdPG4aDttZ/vOERQEKvQtrJJPnoT5q/oqa9UosO1fwKee7ryqJORN9eL?=
 =?us-ascii?Q?peqkNqYTbPllOzCpgC+Fres1iJXWZVniT4Ukmd0N60wX/khbq2iDHwCM9JoJ?=
 =?us-ascii?Q?276mrGeudtsQQ8LfHjtIEO6HwU2Ry2ZhzXpTGkiEjG8FdledKC+2EEj55hl4?=
 =?us-ascii?Q?HVBtBJypj0crb10x1D5fzdGBblcSI0GUA7Kxc7VJLKF9qpS1iIQn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274198a0-7cdb-499c-7905-08def91fb67e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8096.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:46:13.8339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wst8dX3HCetvEmhKSL3EGneclwmJ8IfQb78PiNGibcYFgOteY4/9QlqecaNRVrxQ58toUrN+GhhFMBeCj6HyPyyn22oIh6V1MBwGivoRGN4uZlcxZdo6kkICmsHKCjD7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11607

From: Richard Zhu <hongxing.zhu@nxp.com>

Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
inadvertently moved clock enablement before core reset assertion, breaking
PCI device initialization on i.MX6Q Apalis platforms with
ASM1061/ASM1062 SATA controllers connected.

NOTE: It is not 100% clear if the issue is specific to the ASM1061/ASM1062
device or on the specific power-up sequence (reset vs cold-power-on).

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
Cc: stable@vger.kernel.org # 7.2+
---
Changes in v2:
Update the commit message refer to Francesco' suggestions.
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

