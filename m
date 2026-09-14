Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazon11022077.outbound.protection.outlook.com [40.107.40.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAEE44A403;
	Mon, 14 Sep 2026 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.40.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389356; cv=fail; b=Ct5E6JasLvPSOyihdVdraL3EKMYEm948cHsUNOJlbDedZsoAAZmq48ki9B+nsGnvVwAEBGR9soEHT/EPK+NMke+m1zeMoua87NW2O5BB6aN/QWRBrgr5gvaWPaU0Sj+QPVaNtBtEFAe20UXVApr52qpFXjkFXye/l/0fFhyUFiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389356; c=relaxed/simple;
	bh=Q11u85dRZedGZpHkzfRqDnKMCPktDmC5PoC1O7gnRTU=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=e+b2kU01MpZU3LObl08iSCCK7hryB3b9H5DU3iXhkNXdre/0Hk92nsKB+IcrYR9PVGjWsxGbid0NCxrCtnbttxHxtd0cck8Qcp+DACuU+53qXLRtprvK7f4eKGye/hL6Hl62fisd4lKyq68REeHPNwyu7nh5kDRADE3HmfIU5vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; dkim=pass (2048-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b=E/2kkizr; arc=fail smtp.client-ip=40.107.40.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b="E/2kkizr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liJJ7AMHUelOuYpkzKLGEZB69JPTwpDLy3ettXTN019bTSp177ryjZ4t+R6RbxuPnYmQ7DGaPqscKF7vGlTAEUj8C4nGGb9onFZVSi/tYdwrv/2m0ywEE4qvbw93lzWnDeCcnN0qVc2VyJXhVYWB+gIl9KGB8NmIPGgSevLFR9BNgeozuvUL0Il9IiDc42bxFVppr88PFyVbCgpWlrflpk4FmL0l7MXaDZWpOlsQhZK5taXlCyjLM3RKEpUT0ht4AP5GMMuVh35Hm5Rv+X+CKi/ELny8s3Vu4UHV2yaSsm9E1lZNyHLJ6411qeYi/351YvZJQYnzNfPTJB+zzPPJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxwdgAYf8qumvyZPyrlj4fssq1NeJmda/2oztAp8sMg=;
 b=dyZeSfgI1Z/5NL7pGHugDc1XdvQJgxSimqYeQQDKP+hScrN8FmAvDYACJIevNGwb7pGl6y5/qw1wT5QZMEJ9/ghPFr6j+RqzfqINEqRdnsN1LZNVk69ETv88L/xLEGfuq8767+OyFT6xO7XDK4xkZRRZ1qu72u/rAbtkYseOO22pZ8gMHp+GnEkNf6dB+Q5ItBLUL8aKq8XVU2kdbSycFnRMZwKrkR/+9jg5Tj0S4MWVXVKC16rbJVi6jn1mqL4yfoY/MQ4xvFVRjiW0q++z9MjOk2g6pOLbmUVqL79DGNzYggUqksM3EWHAnVvn/ot2oQxIgZRTOI9RlkhgvWr4WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heitbaum.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxwdgAYf8qumvyZPyrlj4fssq1NeJmda/2oztAp8sMg=;
 b=E/2kkizr/9vikfHVtqFajF0MiSd0ILJD7msvAiJ8hoVSVo5KiYeLnXoe/2jT0YzbEhO+gtvrBaojw2ZmNGGhah39pWjNult1bBuvZQsItjHHgr7u+kjw7vinjtYH2Ly8riCsLl21lXNjA1sKPn5zfGL7y7zqtUlUmVfHI+bSlTzzci1hrbWR+y7KM57YaRoSeLpyLaj821w7A3Rb8SgpUMa/JB2f1VPS3yfBY18Jtm6G4RHM9r0YPZDOunjXhrw0BLtkL5w3WqK0Fa14DcAbKXlqSq+1iuVIVPCdcBQwJ5UQcOR36WAuO323ONq2CnlZ31GROka+XtVUzT5CKQWh1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:279::22)
 by SY3PPFB162C4180.AUSP282.PROD.OUTLOOK.COM (2603:10c6:18::325) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 12:35:47 +0000
Received: from SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 ([fe80::21b6:91f8:614d:1fdd]) by SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 ([fe80::21b6:91f8:614d:1fdd%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 12:35:46 +0000
Date: Mon, 14 Sep 2026 12:35:31 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Richard Zhu <hongxing.zhu@nxp.com>
Cc: Rudi Heitbaum <rudi@heitbaum.com>, Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] PCI: imx6: Avoid dereferencing a NULL clock name
Message-ID: <aqfqE4OLhnN4a1lW@b65e9c1eb12f>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MEWPR01CA0048.ausprd01.prod.outlook.com
 (2603:10c6:220:1df::16) To SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:279::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P282MB4909:EE_|SY3PPFB162C4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a5de2e2-4788-4284-00c1-08df125cb329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pZCQd8xh3y/9fceZeYnGdQvFkgLHvnRi+VX2vqxR0WJHV2CAkLVHB1WZ5oWwLVhhV9d+Fgdp5XSZJoqKeKqwNBoLxZTBSPh6W41U5N7Sn9Y/ac3TvgNkUd2OekKzBSM2pG6GQpMxepCyjlBweuhbjHOLueCIDCZgg1jrsV6Y2t2v3vx5CWfc+KVX5tEpoWLAuHY3FuuumZuYawfrogyqWw2uLesuFIGulWysj6LzQnhz8OfjdagWoRmEN7S4N/ggTHRIfW17TkLdlPXehwMWYzMixOplHoyb+iwAxF/OVlCepNuVyqI7uVh3scL930ptoJhKyXeSLPIJuXkEp7UcjKdMW7rfW0Epq/JVUeB3b6JS862YkI78W6qPzU/ExFteW5EU7vaqdNJBb4+zWVP5HXF8kkuCMWaGz50iKh8PKz4cdHkHKDzcCjQz19gGmx5R+APGmQnHwPiWEsv6TL27c9iGGryjU2tgJPhKyv2b53ZkIc3QvegJyT8a5vKkvONd9fPws24g8tWTU3VN7MzVYmfU9hhWFn/rVx63fHmD4cTMnAKP97MKnrhqzxVisMzNQG0KCohcKeIb+TC+sPwBZ/jTN0+nqPuf4c/fEYDCpeUCRNd3fdVPreef94NQaShd1ueVUXxofCjvoC17QHCzBtoPJBuuBwygRtVUgs2G7no=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/69SPYWlMD9uDVKiQhf98MUHWpiujou+ShkAkE8mOzJd78FbPJAKhjgSUCd2?=
 =?us-ascii?Q?iwXXDw4korfvKyrs57fNAYi/vCMn7ZRqFgGZs3A5IgG3b2gAOic9sT9ccE//?=
 =?us-ascii?Q?nsGEEz9RXJFkP3A9FBLrtjARwjMim8Z0qoWfASotxiklACLbiwMKvY88Auu3?=
 =?us-ascii?Q?eo5WO5QYvDC/HojHY1fnbqqjQAr83a30I19JrpiKh++4aGCkOxNgS7yEtcSz?=
 =?us-ascii?Q?20+QRTIyCSYUMMWk8HdSjfRkxhBv/t6obMuZlj19s+0cnX71IrFniiNwd9Ma?=
 =?us-ascii?Q?fMY38Z66i+OE4Dk6VzrB9o6t3mA+SLWYTQxR5zlrBCQ5T1+zhkddP1ASiXaN?=
 =?us-ascii?Q?lloCAwNR+a0ikrkJwbZ6NM20KePxRIwcJp6Q/YoFio4YZn3kc4KFZ3TJPhR5?=
 =?us-ascii?Q?drCZQrSmMIWyP6PnAyoeJkWNa0qJd0JBSKDJeXp2meqQRqkLp/pk1RImp5eE?=
 =?us-ascii?Q?gkg8ShwHDUdXm2HazUWshdrukYThYewUhj1KSp+mndnAE1F/Y/u9mzbuSf/f?=
 =?us-ascii?Q?I9jTJ3TsjVJtbVyNIyUSFliGXlAiLOfeUszKZc5OpBWpH+rnatJg4UMFuQvK?=
 =?us-ascii?Q?twvnfx0DM8spnAMeJ7P0u4lEVsBBxhNSkQyxnrTT2ElSmqXhrAj9bE1dheox?=
 =?us-ascii?Q?YZhAhJWJCtNEUY+NybyPL88f5YGuu4DVLdUEB3oCe5hAYyx/gOeJCCszbJ23?=
 =?us-ascii?Q?SGUykAyERlKXQVuGEulc/kjXX5BYFHm2okpMk11akQa/GR7+n1xdV/Gha/2p?=
 =?us-ascii?Q?UrxBQH+vvdnFmHyQJi0s9v4hB5TAMR64jZ5VKJSFwJS9p/kMbnzPDRWjdPGH?=
 =?us-ascii?Q?8ZV7zKB227ddcGnG8oako5YBPlznP+Q6IXmrweFLpsO9Z6n8HY1Yhg7RRtHU?=
 =?us-ascii?Q?xnqFWhOU61thDGg2MzAWd2v3BkbfZTQWboVgu6ry9MtzoZmw6jJM7IxqVTah?=
 =?us-ascii?Q?xHa373GPpearDUjxPxYYx7x+B8p5KNWzjf2XjGHBJ0quzUYBI0HzDLsTY4La?=
 =?us-ascii?Q?eVDIfh3O0XBBlOJCtGYzAESitqyrG3psd1foHIK7kuM6zo99xe4xsU70iKA9?=
 =?us-ascii?Q?qZGpgTMrJdIVbPnPS5jM1t9qcFyKe8zzusD6aeEbW/Pd9OP2EzGYXhR+kBbs?=
 =?us-ascii?Q?CkZZoJFyq3o/f1Kg6O+wf6iZMJhkrHnuV8WGmGozGXXD1OASxM2AlnPo8Ve6?=
 =?us-ascii?Q?KqaOH/e4GKOj2lpRS2Xx1LTMIUjXcGyf/kfcTHSgJjPKShWxyJAEk6NHj0PO?=
 =?us-ascii?Q?U3KjlAbjbiZ2WZo6ORJ9Qtmr4W68L3Vao1T4ZLXrgbFXxNRgouBHPwFC0Mgm?=
 =?us-ascii?Q?8A8/JNWLQodpLbrbGHW2FZRPVXcOooXthMdg+9PyhjqpbxTWjDrxWDvhSi+J?=
 =?us-ascii?Q?hgMGNSNYpTWBI1SF4tb5rkMbF8HqdQzd4FM1tZIqllSt2vYmVxoJ9PCDrXLS?=
 =?us-ascii?Q?CNd60A6ivizEKacjWO7z2+WShQ177mkrHvF3h/gDe6V9IiMblOYgoHbznYnZ?=
 =?us-ascii?Q?R50NRsRsjIxXJ3GcI3fBYN0cpXOTgYlZoeQHz8cu+j+vJkec6n96AP4gQHvB?=
 =?us-ascii?Q?kA0cs60ZW5nUOqnCYIr6EOlQtBFFrxfJuV9Xa/vnUDmvH5CsB/bDKYipKB1M?=
 =?us-ascii?Q?ITDHuLaWAxvvdkXa6q2av6acb/bbYo23SfwomOuMJSuxaBh8nd1d5FXxEcQO?=
 =?us-ascii?Q?A6WN1P4GiZib6K05LehCmuW2l9gqnwUmg7Z4+Dc7fVyh+GOA?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5de2e2-4788-4284-00c1-08df125cb329
X-MS-Exchange-CrossTenant-AuthSource: SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 12:35:46.2804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eY8rjEVm4dJIJjK+bRGwYCr9czi8IBdpCa7Vfc/QfciaMoMXi7TBLIz7kONCooHJRBDEnLplwjtAIbJw511ZLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PPFB162C4180

of_clk_bulk_get() leaves clk_bulk_data::id as NULL for every clock that
has no matching entry in "clock-names", which is legal: a node may list
more "clocks" phandles than it names. Both scans of the bulk array
dereference that id unconditionally, so such a node oopses during probe.

The loop in imx_pcie_probe() has been wrong since it was written. The
loop in imx_setup_phy_mpll() was not: it read a fixed clks[] whose ids
came from the driver's own clk_names[] and were never NULL, and only
became wrong when the driver moved to the bulk array.

Check clk_bulk_data::id before dereferencing it in both.

Fixes: f6a1fdfc78e2 ("PCI: imx6: Use devm_clk_bulk_get_all() to fetch clocks")
Fixes: d8574ce57d76 ("PCI: imx6: Add external reference clock input mode support")
Cc: stable@vger.kernel.org
Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
Changes in v2:
- Also guard the identical unchecked dereference in imx_setup_phy_mpll(),
  reported by Sashiko and requested by Manivannan Sadhasivam.
- Add the Fixes: tag for that site.
- v1: https://lore.kernel.org/all/am8iBwJSEhYhWTqk@6cfee64030a6/

 drivers/pci/controller/dwc/pci-imx6.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 39790e66b98d..f8dd83a88ddf 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -542,7 +542,7 @@ static int imx_setup_phy_mpll(struct imx_pcie *imx_pcie)
 		return 0;
 
 	for (i = 0; i < imx_pcie->num_clks; i++)
-		if (strncmp(clks[i].id, "pcie_phy", 8) == 0)
+		if (clks[i].id && strncmp(clks[i].id, "pcie_phy", 8) == 0)
 			phy_rate = clk_get_rate(clks[i].clk);
 
 	switch (phy_rate) {
@@ -1836,7 +1836,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, imx_pcie->num_clks,
 				     "failed to get clocks\n");
 	for (i = 0; i < imx_pcie->num_clks; i++)
-		if (strncmp(imx_pcie->clks[i].id, "extref", 6) == 0)
+		if (imx_pcie->clks[i].id &&
+		    strncmp(imx_pcie->clks[i].id, "extref", 6) == 0)
 			imx_pcie->enable_ext_refclk = true;
 
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {
-- 
2.53.0

