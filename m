Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C0A2DB78C
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072063; cv=none; b=hFxyyFZ85d5SGn3adocxASHO/RZrg4KkXMPB1XOjw68R5bRzLWV3qsaJ0qL/e7+DDQ0ZU5Cf/PItQoo0yWBM5tj1XIq5sl4m4vSdOe6huw5NrpLt57L8YwM8JiuMsvTSs/6Aw5oREknxiXMA7tKdleKy9ZVogQrkqhX3GhNv/ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072063; c=relaxed/simple;
	bh=QUmKuznBoERo38IGc9uv9QJi+u1kdOVjtjYTM1K3p5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNEQ65bSt44gW40PW6r7SqRbSEfjgL3twQf3aR3N/nS/PCEfFrLxoTh5q/y1Uos9sQ1RJUOLO1DYgmFnOtBLhSwnZCctP579dzPA8GeM+1+tpIICeqR2Jg3C5YCiR6YOurZnUp92x+FcxmNB40McOBrDjSP9KhtlOAmrDRdL0GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gP5eYGg8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gP5eYGg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8181F00A3F;
	Tue, 14 Jul 2026 23:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784072061;
	bh=aFqMNBR8xqRix4oSLujHgBcnh1A9+Tyz1o1WPL2lFj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gP5eYGg8cf2I7mFb9MllPo1GujdPi8exeW7IxJljfQIF1hPj8ouG6ngZVoaf5Khj2
	 1kdriS83TPK2uG/5YprmwekzbEfiFCO1Wb0GRVFsQjx/eW+O9Q1/4ADil1Z+DTmqYh
	 PPQ8M8AQpugDqEOS58W7iDUcIOmZ8WyWrfEX5NFJaWlu/flLy46DUApbL6CWekPAQ0
	 ak7ClOxbvM1VLq+wnAPEyvpXW5GEmPx+GWZ4ZfTOlvPfdiiBpmMjJ52sr1Fm5NwlWY
	 /WxztTqLD/B8p+0PIEYuW6gVaj8r/CfGF6gJAS5lUFuQHTSzfZ1hZY1TFLww+gEDJy
	 WnISYtrDD3YjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] PCI: mediatek: Use generic MACRO for TPVPERL delay
Date: Tue, 14 Jul 2026 19:34:16 -0400
Message-ID: <20260714233418.3592225-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714233418.3592225-1-sashal@kernel.org>
References: <2026071316-untidy-lily-01f2@gregkh>
 <20260714233418.3592225-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Marangi <ansuelsmth@gmail.com>

[ Upstream commit 2d58bc777728bfc37aa35dce7b90e72296cceb9f ]

Use the generic PCI MACRO for TPVPERL delay to wait for clock and power
stabilization after PERST# Signal instead of the raw value of 100 ms.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patch.msgid.link/20251020111121.31779-5-ansuelsmth@gmail.com
Stable-dep-of: f865a57896bd ("PCI: mediatek: Fix IRQ domain leak when port fails to enable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-mediatek.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 97cfec33830f61..afda83372beaee 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -711,12 +711,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	 */
 	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
 
-	/*
-	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal) and
-	 * 2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
-	 * be delayed 100ms (TPVPERL) for the power and clock to become stable.
-	 */
-	msleep(100);
+	msleep(PCIE_T_PVPERL_MS);
 
 	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
 	val = readl(port->base + PCIE_RST_CTRL);
-- 
2.53.0

