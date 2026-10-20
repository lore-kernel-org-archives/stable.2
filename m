Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792478184;
	b=mz9Vd3qtbBNBb3NsehA6oJa4LGPM7EjtbQafY6/2KuyeT2IajxjFE323kncy5cU9wWZw
	 d2GtqG2mho7e1vqaAHjQbk6DSPHfonB3klblnaG8XosL9xa3ydEDyVupCJoc2Bmt3yUMC
	 voNRNgNE3FusqG51yQ5PlMx1CDyR44oSUvm/zOS5998fF8YY9Qcozdj3BVQ54HGDX/rqG
	 lRljP5XxVx+OfTTNb28qi+Th4MSu71+jaCpvJRU0Fa038JwdLNP7KYwb2d8iDGBwU7D2B
	 VovO+r2nTJdKkFY8QJpBwRcsXhs5+cJOdbm0JeRv91AkgrCQMxg8sHEISSe7FBrkEjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478184;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:
	 Content-Type:CMS-TYPE:cpgsPolicy:X-CFilter-Loop:X-CMS-RootMailID:
	 References;
	bh=cMOyDvJ+4IZMD7M7ive4vsZM0ebqLEDD0cr3Jg1jYiA=;
	b=a9pMie6bqnNPsLq0nKh6VkYSPvyFa2VtYGaWWNY/qLnar+rR5Uc/VxgcVcdD3SHdBKX3
	 ana/8EyVdvWgeeBYsaDJ3LglA9rVSxW+HShY2hbn1+O0NDEpRdvAJtBy0ShViftJZilAn
	 YfgNB9Z25ob7LnTI2b2FiKGbqe1xaY2oIXL/t9Es9tzqjYFL5EM+S+WrCtHdpog2nYwEk
	 w4uG1tINLrNNZX24ZewdiL6i886voRauifAJFhgcjsrkVQOEbg7VCoVHnPE+YLAyDV5i0
	 57dmuylAPAoL176CYMG4aOpLazpEtV8DoRbRxqhs/4yArDetW7KcmyNA04OlfBr2eyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=DXurnG+O;
	arc=none smtp.remote-ip=203.254.224.33
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591A3606A324
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 591A3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=DXurnG+O
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20261020063620epoutp030d811ed85c53df1dfc44f02f811a8468~gKWiFMERV2307823078epoutp03M
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:36:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20261020063620epoutp030d811ed85c53df1dfc44f02f811a8468~gKWiFMERV2307823078epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1792478180;
	bh=cMOyDvJ+4IZMD7M7ive4vsZM0ebqLEDD0cr3Jg1jYiA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=DXurnG+OrImuFVOWre/IHvrEtrR52MixdRlAxE2Mybikle6I4OhJ9ttoIkS0h+vP9
	 USuIKfMQIJoAvLz4KHwp6ditcFMCwWfD0XgwNgP2/3QoDjwebIggA3uQqtFobZn+pf
	 WeBDmINrF3DqXaqMNUSkKI5nSxYDh/F2j3GdQGek=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20261020063619epcas5p3cbe87da155138f7d23f130a048e7700a~gKWhUrZDm0682806828epcas5p3G;
	Tue, 20 Oct 2026 06:36:19 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.87]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4j82kB4tdfz6B9mB; Tue, 20 Oct
	2026 06:36:18 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20261020063617epcas5p4ba00854fcd38bf211c573629ee062621~gKWfYcTjq3015130151epcas5p4j;
	Tue, 20 Oct 2026 06:36:17 +0000 (GMT)
Received: from vega.samsungds.net (unknown [107.108.73.84]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261020063614epsmtip2fdb85f2c138d315a3425597013416486~gKWcIzNpH1615316153epsmtip2_;
	Tue, 20 Oct 2026 06:36:14 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: vkoul@kernel.org, neil.armstrong@linaro.org, mani@kernel.org,
	krzk@kernel.org, peter.griffin@linaro.org, alim.akhtar@samsung.com,
	pritam.sutar@samsung.com, andre.draszik@linaro.org, kernel@lvkasz.us,
	pengpeng@iscas.ac.cn, kishon@kernel.org, linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, h10.kim@samsung.com, dh10.jung@samsung.com,
	akash.m5@samsung.com, hongpooh.kim@samsung.com, eomji.oh@samsung.com,
	shijie.cai@samsung.com, muhammed.ali@samsung.com, thiagu.r@samsung.com,
	Selvarasu Ganesan <selvarasu.g@samsung.com>, stable@vger.kernel.org
Subject: [PATCH v3] phy: exynos5-usbdrd: Use dynamic phy_cfg size to prevent
 OOB access
Date: Tue, 20 Oct 2026 12:05:59 +0530
Message-Id: <20261020063559.3530901-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261020063617epcas5p4ba00854fcd38bf211c573629ee062621
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261020063617epcas5p4ba00854fcd38bf211c573629ee062621
References: <CGME20261020063617epcas5p4ba00854fcd38bf211c573629ee062621@epcas5p4.samsung.com>

The probe loop currently iterates using EXYNOS5_DRDPHYS_NUM (2),
creating both UTMI and PIPE3 PHY instances regardless of the SoC
capability. Several SoCs (Exynos2200, Exynos7870, Exynos850, Exynos990,
and ExynosAutoV920) provide phy_cfg arrays containing only a single
element.

On these SoCs, when the loop reaches index 1, the driver reads past the
end of the rodata array, populating the second PHY instance with garbage
data. Since the configuration structure contains critical function
pointers (phy_isol, phy_init, set_refclk), any subsequent access to this
PHY instance via exynos5_usbdrd_phy_xlate could result in a kernel oops.

Fix this by adding 'n_phy_cfg' to struct exynos5_usbdrd_phy_drvdata to
store the actual size of the phy_cfg array for each SoC. Update the
probe loop and the xlate function to bound their access against this
value instead of the hardcoded EXYNOS5_DRDPHYS_NUM.

Fixes: 59025887fb08 ("phy: Add new Exynos5 USB 3.0 PHY driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
Tested-by: Łukasz Lebiedziński <kernel@lvkasz.us>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: André Draszik <andre.draszik@linaro.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
---

Changes in v3:
- Added Fixes and Stable tag
- Link to v2:
  https://lore.kernel.org/all/20260918103147.2628614-1-selvarasu.g@samsung.com/

Changes in v2:
- Updated 'Assisted-by' tag to follow the proper kernel documentation
  format.
- Link to v1:
  https://lore.kernel.org/all/20260831070309.158069-1-selvarasu.g@samsung.com/
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 087d552eb511..f10cf7b6e0aa 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -477,6 +477,7 @@ struct exynos5_usbdrd_phy_config {
 
 struct exynos5_usbdrd_phy_drvdata {
 	const struct exynos5_usbdrd_phy_config *phy_cfg;
+	int n_phy_cfg;
 	const struct exynos5_usbdrd_phy_tuning **phy_tunes;
 	const struct phy_ops *phy_ops;
 	const char * const *clk_names;
@@ -1173,7 +1174,7 @@ static struct phy *exynos5_usbdrd_phy_xlate(struct device *dev,
 {
 	struct exynos5_usbdrd_phy *phy_drd = dev_get_drvdata(dev);
 
-	if (WARN_ON(args->args[0] >= EXYNOS5_DRDPHYS_NUM))
+	if (WARN_ON(args->args[0] >= phy_drd->drv_data->n_phy_cfg))
 		return ERR_PTR(-ENODEV);
 
 	return phy_drd->phys[args->args[0]].phy;
@@ -2021,6 +2022,7 @@ static const char * const exynos5_regulator_names[] = {
 
 static const struct exynos5_usbdrd_phy_drvdata exynos2200_usb32drd_phy = {
 	.phy_cfg		= phy_cfg_exynos2200,
+	.n_phy_cfg		= ARRAY_SIZE(phy_cfg_exynos2200),
 	.phy_ops		= &exynos2200_usbdrd_phy_ops,
 	.pmu_offset_usbdrd0_phy	= EXYNOS2200_PHY_CTRL_USB20,
 	.clk_names		= exynos5_clk_names,
@@ -2034,6 +2036,7 @@ static const struct exynos5_usbdrd_phy_drvdata exynos2200_usb32drd_phy = {
 
 static const struct exynos5_usbdrd_phy_drvdata exynos5420_usbdrd_phy = {
 	.phy_cfg		= phy_cfg_exynos5,
+	.n_phy_cfg		= ARRAY_SIZE(phy_cfg_exynos5),
 	.phy_ops		= &exynos5_usbdrd_phy_ops,
 	.pmu_offset_usbdrd0_phy	= EXYNOS5_USBDRD_PHY_CONTROL,
 	.pmu_offset_usbdrd1_phy	= EXYNOS5420_USBDRD1_PHY_CONTROL,
@@ -2047,6 +2050,7 @@ static const struct exynos5_usbdrd_phy_drvdata exynos5420_usbdrd_phy = {
 
 static const struct exynos5_usbdrd_phy_drvdata exynos5250_usbdrd_phy = {
 	.phy_cfg		= phy_cfg_exynos5,
+	.n_phy_cfg		= ARRAY_SIZE(phy_cfg_exynos5),
 	.phy_ops		= &exynos5_usbdrd_phy_ops,
 	.pmu_offset_usbdrd0_phy	= EXYNOS5_USBDRD_PHY_CONTROL,
 	.clk_names		= exynos5_clk_names,
@@ -2059,6 +2063,7 @@ static const struct exynos5_usbdrd_phy_drvdata exynos5250_usbdrd_phy = {
 
 static const struct exynos5_usbdrd_phy_drvdata exynos5433_usbdrd_phy = {
 	.phy_cfg		= phy_cfg_exynos5,
+	.n_phy_cfg		= ARRAY_SIZE(phy_cfg_exynos5),
 	.phy_ops		= &exynos5_usbdrd_phy_ops,
 	.pmu_offset_usbdrd0_phy	= EXYNOS5_USBDRD_PHY_CONTROL,
 	.pmu_offset_usbdrd1_phy	= EXYNOS5433_USBHOST30_PHY_CONTROL,
@@ -2072,6 +2077,7 @@ static const struct exynos5_usbdrd_phy_drvdata exynos5433_usbdrd_phy = {
 
 static const struct exynos5_usbdrd_phy_drvdata exynos7_usbdrd_phy = {
 	.phy_cfg		= phy_cfg_exynos5,
+	.n_phy_cfg		= ARRAY_SIZE(phy_cfg_exynos5),
 	.phy_ops		= &exynos5_usbdrd_phy_ops,
 	.pmu_offset_usbdrd0_phy	= EXYNOS5_USBDRD_PHY_CONTROL,
 	.clk_names		= exynos5_clk_names,
@@ -2084,6 +2090,7 @@ static const struct exynos5_usbdrd_phy_drvdata exynos7_usbdrd_phy = {
 
 static const struct exynos5_usbdrd_phy_drvdata exynos7870_usbdrd_phy = {
 	.phy_cfg		= phy_cfg_exynos7870,
+	.n_phy_cfg		= ARRAY_SIZE(phy_cfg_exynos7870),
 	.phy_tunes		= exynos7870_tunes,
 	.phy_ops		= &exynos7870_usbdrd_phy_ops,
 	.pmu_offset_usbdrd0_phy	= EXYNOS5_USBDRD_PHY_CONTROL,
@@ -2097,6 +2104,7 @@ static const struct exynos5_usbdrd_phy_drvdata exynos7870_usbdrd_phy = {
 
 static const struct exynos5_usbdrd_phy_drvdata exynos850_usbdrd_phy = {
 	.phy_cfg		= phy_cfg_exynos850,
+	.n_phy_cfg		= ARRAY_SIZE(phy_cfg_exynos850),
 	.phy_ops		= &exynos850_usbdrd_phy_ops,
 	.pmu_offset_usbdrd0_phy	= EXYNOS5_USBDRD_PHY_CONTROL,
 	.clk_names		= exynos5_clk_names,
@@ -2125,6 +2133,7 @@ static const struct exynos5_usbdrd_phy_tuning *exynos990_tunes[PTS_MAX] = {
 
 static const struct exynos5_usbdrd_phy_drvdata exynos990_usbdrd_phy = {
 	.phy_cfg		= phy_cfg_exynos850,
+	.n_phy_cfg		= ARRAY_SIZE(phy_cfg_exynos850),
 	.phy_ops		= &exynos850_usbdrd_phy_ops,
 	.phy_tunes		= exynos990_tunes,
 	.pmu_offset_usbdrd0_phy	= EXYNOS990_PHY_CTRL_USB20,
@@ -2661,6 +2670,7 @@ static const struct phy_ops exynosautov920_usb31drd_combo_ssphy_ops = {
 static const
 struct exynos5_usbdrd_phy_drvdata exynosautov920_usb31drd_combo_ssphy = {
 	.phy_cfg		= usb31drd_phy_cfg_exynosautov920,
+	.n_phy_cfg		= ARRAY_SIZE(usb31drd_phy_cfg_exynosautov920),
 	.phy_ops		= &exynosautov920_usb31drd_combo_ssphy_ops,
 	.pmu_offset_usbdrd0_phy	= EXYNOSAUTOV920_PHY_CTRL_USB31,
 	.clk_names		= exynos5_clk_names,
@@ -2691,6 +2701,7 @@ exynos5_usbdrd_phy_config usbdrd_hsphy_cfg_exynosautov920[] = {
 static const
 struct exynos5_usbdrd_phy_drvdata exynosautov920_usbdrd_combo_hsphy = {
 	.phy_cfg		= usbdrd_hsphy_cfg_exynosautov920,
+	.n_phy_cfg		= ARRAY_SIZE(usbdrd_hsphy_cfg_exynosautov920),
 	.phy_ops		= &exynosautov920_usbdrd_combo_hsphy_ops,
 	.pmu_offset_usbdrd0_phy	= EXYNOSAUTOV920_PHY_CTRL_USB20,
 	.clk_names		= exynos5_clk_names,
@@ -2719,6 +2730,7 @@ static const struct exynos5_usbdrd_phy_config phy_cfg_exynosautov920[] = {
 
 static const struct exynos5_usbdrd_phy_drvdata exynosautov920_usbdrd_phy = {
 	.phy_cfg		= phy_cfg_exynosautov920,
+	.n_phy_cfg		= ARRAY_SIZE(phy_cfg_exynosautov920),
 	.phy_ops		= &exynosautov920_usbdrd_phy_ops,
 	.pmu_offset_usbdrd0_phy	= EXYNOSAUTOV920_PHY_CTRL_USB20,
 	.clk_names		= exynos5_clk_names,
@@ -2895,6 +2907,7 @@ static const char * const gs101_regulator_names[] = {
 
 static const struct exynos5_usbdrd_phy_drvdata gs101_usbd31rd_phy = {
 	.phy_cfg			= phy_cfg_gs101,
+	.n_phy_cfg			= ARRAY_SIZE(phy_cfg_gs101),
 	.phy_tunes			= gs101_tunes,
 	.phy_ops			= &gs101_usbdrd_phy_ops,
 	.pmu_offset_usbdrd0_phy		= GS101_PHY_CTRL_USB20,
@@ -3052,7 +3065,7 @@ static int exynos5_usbdrd_phy_probe(struct platform_device *pdev)
 
 	dev_vdbg(dev, "Creating usbdrd_phy phy\n");
 
-	for (i = 0; i < EXYNOS5_DRDPHYS_NUM; i++) {
+	for (i = 0; i < drv_data->n_phy_cfg; i++) {
 		struct phy *phy = devm_phy_create(dev, NULL, drv_data->phy_ops);
 
 		if (IS_ERR(phy))
-- 
2.17.1

