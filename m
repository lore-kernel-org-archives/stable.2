Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0810367285
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974266; cv=none; b=hs+yhu+L/jk9KmZzfyo/GgwK1LPTC95V8s7vf2vQgT3aIzAo+iP+tfzZCqBEl/3/yiFnTEcCnDTuX87muu9grDKMR5ZFwiwejIq8xyws9B4QbJjQFdEwwoE7bi4t7GggHpR+/z1BGe8Dd8Pv+fyPSOhvM8Smyu9fHv6Dc9gwRDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974266; c=relaxed/simple;
	bh=+D4CAuWID6UqoOH763g4Jq8xn0m38kuD6UzkeNIqcuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BID3Qu7gILYHolvfYtcBNqPh+/qIhppd6zRm0ZVRb2BiPj/r0rlquUsjmagrUgmuthF/NMJoavwu6ErgEW3RArMbfENXgMSIRFT7q7oXEdzW89+J1Sdoe+RD2JiGDHyGHrV7dJXwnLnvNVNxc9HlGrzLSScimJzidZxv7qyLhrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mILvcDP3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mILvcDP3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9E71F000FF;
	Wed,  9 Sep 2026 17:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788974265;
	bh=/LFpWzKwtfLE5dhw3ibBaeypdzWyXBieb1CXaiVjTgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mILvcDP3RfH59hlfvFDMS5raqwKGWjfKhHD/yib/iADRDHfxK8qZrSzTIMA/kDIzO
	 6Jp2z0HdmI5dxDYBBl1iVAm+oZ4WYjzGmwSEds5bgZNJbsyHxiJ+2KREGwGhhUnqUY
	 L6YMxR8PKxkClFQr42sEVmmQ7b6EBNRH9rJJmu9DV8+lTYjJM88/DgLGCkgQVTeP/C
	 gGuHuk8mRsV5omwEkGa0JGcoMYScRoWH/SKvvmhKj0UYv59FuzhP2/UTt0EEwF4hfY
	 7L4u9yGpJUCC7KFs16jLXMrJEdwF5g9FLqcf5dCZwGbZo9G4id5BC6GgDJb0iJJgaB
	 pe+rJ43+/W1iA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/7] net: ravb: Rely on PM domain to enable gptp_clk
Date: Wed,  9 Sep 2026 13:17:37 -0400
Message-ID: <20260909171743.3248398-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090333-magnolia-munchkin-24b0@gregkh>
References: <2026090333-magnolia-munchkin-24b0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit e1da043f2b2d956818728ca74c8eacd17feccf5c ]

ravb_rzv2m_hw_info::gptp_ref_clk is enabled only for RZ/V2M. RZ/V2M
is an ARM64-based device which selects power domains by default and
CONFIG_PM. The RZ/V2M Ethernet DT node has proper power-domain binding
available in device tree from the commit that added the Ethernet node.
(4872ca1f92b0 ("arm64: dts: renesas: r9a09g011: Add ethernet nodes")).

Power domain support was available in the rzg2l-cpg.c driver when the
Ethernet DT node has been enabled in RZ/V2M device tree.
(ef3c613ccd68 ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")).

Thus, remove the explicit clock enable for gptp_clk (and treat it as the
other clocks are treated) as it is not needed and removing it doesn't
break the ABI according to the above explanations.

By removing the enable/disable operation from the driver we can add
runtime PM support (which operates on clocks) w/o the need to handle
the gptp_clk in the Ethernet driver functions like ravb_runtime_nop().
PM domain does all that is needed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 1cb9663789c5 ("net: ravb: serialize PTP clock teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb_main.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index fe9d1461f6ea6..bc893fd6eb023 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2819,7 +2819,6 @@ static int ravb_probe(struct platform_device *pdev)
 			error = PTR_ERR(priv->gptp_clk);
 			goto out_disable_refclk;
 		}
-		clk_prepare_enable(priv->gptp_clk);
 	}
 
 	ndev->max_mtu = info->rx_max_buf_size - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
@@ -2839,13 +2838,13 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Set AVB config mode */
 	error = ravb_set_config_mode(ndev);
 	if (error)
-		goto out_disable_gptp_clk;
+		goto out_disable_refclk;
 
 	if (info->gptp || info->ccc_gac) {
 		/* Set GTI value */
 		error = ravb_set_gti(ndev);
 		if (error)
-			goto out_disable_gptp_clk;
+			goto out_disable_refclk;
 
 		/* Request GTI loading */
 		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
@@ -2865,7 +2864,7 @@ static int ravb_probe(struct platform_device *pdev)
 			"Cannot allocate desc base address table (size %d bytes)\n",
 			priv->desc_bat_size);
 		error = -ENOMEM;
-		goto out_disable_gptp_clk;
+		goto out_disable_refclk;
 	}
 	for (q = RAVB_BE; q < DBAT_ENTRY_NUM; q++)
 		priv->desc_bat[q].die_dt = DT_EOS;
@@ -2928,8 +2927,6 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Stop PTP Clock driver */
 	if (info->ccc_gac)
 		ravb_ptp_stop(ndev);
-out_disable_gptp_clk:
-	clk_disable_unprepare(priv->gptp_clk);
 out_disable_refclk:
 	clk_disable_unprepare(priv->refclk);
 out_release:
@@ -2964,7 +2961,6 @@ static int ravb_remove(struct platform_device *pdev)
 
 	ravb_set_opmode(ndev, CCC_OPC_RESET);
 
-	clk_disable_unprepare(priv->gptp_clk);
 	clk_disable_unprepare(priv->refclk);
 
 	pm_runtime_put_sync(&pdev->dev);
-- 
2.53.0

