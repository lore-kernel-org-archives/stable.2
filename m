Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE57545DA9;
	Wed,  9 Sep 2026 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953687; cv=none; b=CqaAG98I3tRWiXbpf1NyqqnmZ3E5YoyxUk/Zjss8xqUUIgxfVmuvQLWu4jND3v9PjPC7rPJPJ8Qxb8kZGZQGxCHHAnVOq3GmIh9k0SqLVUho9iSkrosj0puqjByJ8lLkqhgDJF0LBLVetAboQTttpD3RGeeI70aTIWGhuMj87Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953687; c=relaxed/simple;
	bh=7jWTrN7p2PthpHeS4Rmtj7mWhr5j0+jYw5jh5OLkoOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BI1FRpwrzi3zKJDVoWdLqLy7Q8axbVnI1MOeCJ2GGGZoxc9uor0TKC7z4vXYcvGaNoaySHpeo4BYo/eGWhEN3C5ohLLtZ6HF1+cCoQHcKCY0x0XsUBNX0cvkrsloZhMZuedPsXDeMtJkdYwftYMuDYUaxOCNJz0CIrY6Azbtm1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 71f60984ac4211f19a56ed5b684f684d-20260909
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:4e9c3541-075b-4229-a75c-24090aca1d47,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:79fa69263b627d5718ec32f951583d2e,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:-3|-100,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 71f60984ac4211f19a56ed5b684f684d-20260909
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 658264266; Wed, 09 Sep 2026 19:34:40 +0800
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
	stable@vger.kernel.org,
	Sashiko AI <sashiko@kernel.org>
Subject: [PATCH v7 4/4] phy: ti-pipe3: Fix clock leak in init error path
Date: Wed,  9 Sep 2026 19:34:33 +0800
Message-Id: <20260909113433.1287454-5-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260909113433.1287454-1-zenghongling@kylinos.cn>
References: <20260909113433.1287454-1-zenghongling@kylinos.cn>
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
Cc: stable@vger.kernel.org
Reported-by: Sashiko AI <sashiko@kernel.org>
Closes: https://lore.kernel.org/all/20260518023657.41852C2BCB0@smtp.kernel.org/
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
Change in v7:
 -Restore the original `return ret` in the SATA PLL-locked init path.
---
 drivers/phy/ti/phy-ti-pipe3.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index a67f5da43c83..fea64db93da5 100644
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
 
@@ -555,8 +557,10 @@ static int ti_pipe3_exit(struct phy *x)
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

