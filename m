Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1B935E1B5;
	Mon, 22 Jun 2026 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782118547; cv=none; b=pf34SyCZGJYd5kZIET/IKlRQCvP4QL5YrDepP1ov33VwXGNZDi1CJY33tN/C5S4KujPPJmbqgorhC6lIzJGR/VlGkrIV5IwEjX6eysTlpwwcUxfNWjSCtU4XH2SB5Q9uchkf++jzLFItK79rYC1RuLoyCk93jgMw/+mW15HS6aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782118547; c=relaxed/simple;
	bh=r4bodF9U8oMEN04T0y18dysLerS4jks16bI6avdd++w=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=LksZW7WgSTMyXfwshNE68a6GP9bl9EXc8wTAOsGVpmrgCH95kEYXOl019VUEbiRueD1OQ2jcVQtyPdYTn5F6CTcG1aCrFvga8lQ7/4Cgcb27q899VQq7ESouJ2pCi0iss7f+fiwCke5fRmPK4lifk1MmBeAjCJrmMRwzaOpmBiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=none smtp.helo=mailgw.kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mailgw.kylinos.cn
X-UUID: 4a0426106b8b11f1aa26b74ffac11d73-20260619
Message-ID:<1782118512967996.3955.seg@mailgw.kylinos.cn>
X-Spam-Fingerprint: 0
X-GW-Reason: 11101
X-Content-Feature:
	ica/max.line-size 85
	audit/email.address 4
	dict/adv 1
	dict/game 2
	meta/cnt.alert 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:54b7c1a8-4e26-4de3-9828-59c9a56bcaa4,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:4c2eda3750725ae7bc323e2f32abb649,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|850|865|898,TC:nil,Content
	:0|15|50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4a0426106b8b11f1aa26b74ffac11d73-20260619
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 677852642; Fri, 19 Jun 2026 11:02:21 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: vkoul@kernel.org,
	neil.armstrong@linaro.org,
	johan@kernel.org,
	kishon@kernel.org,
	rogerq@ti.com
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	Sashiko AI <sashiko@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v6 4/4] phy: ti-pipe3: Fix clock leak in init error path
Date: Fri, 19 Jun 2026 11:02:14 +0800
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619030214.1779043-1-zenghongling@kylinos.cn>
References: <20260619030214.1779043-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When regmap_update_bits() fails in ti_pipe3_init() for PCIe mode,
the function returns the error without calling ti_pipe3_disable_clocks().
This leaves the clocks permanently enabled since the PHY framework won't
invoke the .exit callback on init failure.

Fix this by adding proper clock cleanup in the PCIe error path, consistent
with how the DPLL program error path handles cleanup.

Fixes: 234738ea3390 ("phy: ti-pipe3: move clk initialization to a separate function")
Reported-by: Sashiko AI <sashiko@kernel.org>
Closes: https://lore.kernel.org/all/20260518023657.41852C2BCB0@smtp.kernel.org/
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Cc: stable@vger.kernel.org

---
Change in v5:
  -Add Fix ignored clock enable return value in init patch
---
Change in v6:
 -Fix all clock leak paths comprehensively:
 -PCIe syscon update failure path
 -SATA DPLL lock check path
 -SATA errata path in ti_pipe3_exit()
---
 drivers/phy/ti/phy-ti-pipe3.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index 9ec228c2a940..860058f31594 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -518,6 +518,8 @@ static int ti_pipe3_init(struct phy *x)
 		val = 0x96 << OMAP_CTRL_PCIE_PCS_DELAY_COUNT_SHIFT;
 		ret = regmap_update_bits(phy->pcs_syscon, phy->pcie_pcs_reg,
 					 PCIE_PCS_MASK, val);
+		if (ret)
+			ti_pipe3_disable_clocks(phy);
 		return ret;
 	}
 
@@ -531,8 +533,9 @@ static int ti_pipe3_init(struct phy *x)
 
 	/* SATA has issues if re-programmed when locked */
 	val = ti_pipe3_readl(phy->pll_ctrl_base, PLL_STATUS);
-	if ((val & PLL_LOCK) && phy->mode == PIPE3_MODE_SATA)
-		return ret;
+	if ((val & PLL_LOCK) && phy->mode == PIPE3_MODE_SATA) {
+		return 0;
+	}
 
 	/* Program the DPLL */
 	ret = ti_pipe3_dpll_program(phy);
@@ -555,8 +558,10 @@ static int ti_pipe3_exit(struct phy *x)
 	/* If dpll_reset_syscon is not present we wont power down SATA DPLL
 	 * due to Errata i783
 	 */
-	if (phy->mode == PIPE3_MODE_SATA && !phy->dpll_reset_syscon)
+	if (phy->mode == PIPE3_MODE_SATA && !phy->dpll_reset_syscon) {
+		ti_pipe3_disable_clocks(phy);
 		return 0;
+	}
 
 	/* PCIe doesn't have internal DPLL */
 	if (phy->mode != PIPE3_MODE_PCIE) {
-- 
2.25.1

