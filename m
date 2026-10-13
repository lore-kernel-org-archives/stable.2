Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6BC3F23D0
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903126; cv=none; b=f2VcCQbhWox+GkfUPz8n1meuWVAMCTxrN63afRovCAb1D5ObIcbe4ewRC1B+IwfKkiVbDBi2TjmYUQG5hanGggpJ3+kNVa7TkTyh/oSoMjAj+bU2DnfZjDE6hYAbDEbWp/xC/Bey0iU7htIzKhf2XwZrJOabEGYDbQCh3hkPeFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903126; c=relaxed/simple;
	bh=fU08obKl3a4YuEB9FSUVOjXLs6Zcwkg1qN2EuLv7ktM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzslEsOZnTJ2FHkbGS3UnSQzVPPWaq2fuL8Rx2ICX3SpDsi5mDP+w8qi4yBuBQpJe4lB4wddZ61IxTDX4F5dvvCR6zMxmrVYz8UwfBHL4YhmoNulJxVuypxdrESTYDqRM5r5YCxc+wtXlSlB7+a9bCeU1i2WB0IHW2ZgX+HhqsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJbTgpXD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJbTgpXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1A71F000FF;
	Tue, 13 Oct 2026 14:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791903123;
	bh=T2ONHepImDdfOlp2R5vLGGWiaajWblbWFctm8uK3D3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AJbTgpXDnbu4/Tb3Z9slk3dcnOSY5gDPKS8FVQk+3O4yLAwc386t8074S7/tP0L6l
	 hVgo1RLjwlMexmFR1Svyz7+JfzoAx+kJeSL82f026fIJ/Falo9ZSp3XZHotPP/CbKt
	 rCMwBs/aXlpwHb40hRHfXzrvB6Gy7Gzc5BNiWVSZ4oh+nkgQ7lgu+sQR2RWxfbdc88
	 2DAV/8xXt+Vf8EEYZpQuiiZpujNFquacWkHL5/ezoQc2tjpc4+DqcNvl2JHVmaEP9R
	 PExVeC3L81JruMKMdSNQhwXSvTOCaZwZ10XEb2ZjUyTK1frAruxkZH/Vxc5X37ozuw
	 mhe81YAXocJPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ming Qian <ming.qian@oss.nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] pmdomain: imx8m-blk-ctrl: Serialize power on/off across sibling domains
Date: Tue, 13 Oct 2026 10:52:01 -0400
Message-ID: <20261013145149.73367-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101234-smile-observant-e7bb@gregkh>
References: <2026101234-smile-observant-e7bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Qian <ming.qian@oss.nxp.com>

[ Upstream commit 51c2db3ef0cb89a49ab7f47a40efd5d5b074ce8d ]

On i.MX8MP the VPU blk-ctrl exposes G1, G2 and VC8000E as three separate
genpds, each serialized only by its own genpd lock, so their power_on and
power_off callbacks can run concurrently on SMP.

The sequences are not independent: they share the VPUMIX bus domain, the
VPU_NOC and the ADB400 handshake. On power up the GPC cannot ack-verify
the ADB400 handshake - the ack only completes once blk-ctrl sets the bus
clk-en bit - so it just waits a fixed delay instead of polling hskack. A
sibling transition landing inside another domain's reset window disturbs
that shared clock and handshake timing, the victim's reset does not take
effect, and its block registers read back all zeros: the decoder times
out or the encoder fails its format check.

Serialize the blk-ctrl reset sequence with a per-blk-ctrl mutex; the
driver deliberately avoids a genpd hierarchy, so the genpd core gives no
cross-sibling serialization.

Fixes: a1a5f15f7f6c ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/imx/imx8m-blk-ctrl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 1b87823d835d3..65315bf908b36 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -13,6 +13,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/clk.h>
+#include <linux/mutex.h>
 
 #include <dt-bindings/power/imx8mm-power.h>
 #include <dt-bindings/power/imx8mn-power.h>
@@ -32,6 +33,12 @@ struct imx8m_blk_ctrl {
 	struct regmap *regmap;
 	struct imx8m_blk_ctrl_domain *domains;
 	struct genpd_onecell_data onecell_data;
+	/*
+	 * Serializes the blk-ctrl reset/clock sequence across sibling domains;
+	 * their transitions interact through the shared VPUMIX bus domain,
+	 * VPU_NOC and the not-ack-verified ADB400 handshake (ERR050531).
+	 */
+	struct mutex power_lock;
 };
 
 struct imx8m_blk_ctrl_domain_data {
@@ -87,6 +94,8 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 	struct imx8m_blk_ctrl *bc = domain->bc;
 	int ret;
 
+	guard(mutex)(&bc->power_lock);
+
 	/* make sure bus domain is awake */
 	ret = pm_runtime_get_sync(bc->bus_power_dev);
 	if (ret < 0) {
@@ -146,6 +155,8 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
 	const struct imx8m_blk_ctrl_domain_data *data = domain->data;
 	struct imx8m_blk_ctrl *bc = domain->bc;
 
+	guard(mutex)(&bc->power_lock);
+
 	/* put devices into reset and disable clocks */
 	if (data->mipi_phy_rst_mask)
 		regmap_clear_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
@@ -184,6 +195,10 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 
 	bc->dev = dev;
 
+	ret = devm_mutex_init(dev, &bc->power_lock);
+	if (ret)
+		return ret;
+
 	bc_data = of_device_get_match_data(dev);
 
 	base = devm_platform_ioremap_resource(pdev, 0);
-- 
2.53.0

