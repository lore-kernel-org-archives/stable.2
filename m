Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3644D90D4
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059359; cv=none; b=OocJmnRStQH9qFBvrn2bL/y9uqJkOre0Emb60U4X2ME0KuZQ/pry50rNprZQDrl9akcNYaDfyhGv+iwysXQzOzN7AuqMHxxW0NTWDC2v97l+CqTqgR/l8AK5Vp/5Xglfp7nXWXLvzKgZJ5X1zWv+FqR0ryZbfl82SpMj/ZhYhKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059359; c=relaxed/simple;
	bh=qWKLrigXSJaynn8SKrOH2GNCMunYFrfXtz16iEw4pLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hfn+SdyHDOtU/B4bCHSVaj1uJtZjeO6MKFOLBaIEpY0HQvWwMXKv3x/oEeSjCiEbtP7fgn7jrgQLSarG8Mz5aaLKaYMCsfNOnBKWycZO3GWmIPscGK2u6r9qZiuyEeRNqRPUgotB/Rf8uwZT3CM9YtwM4Ewc6RqnXEIpFsF0psE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g18vp7xQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g18vp7xQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5DB1F000E9;
	Tue, 14 Jul 2026 20:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059350;
	bh=0kCQoHATNT0oPDi4caHYZ/JunInKziSbHULWxOwzTnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g18vp7xQVg8LYOHmnmav+glQ8TL7PArvNsDCuZ8fMvmonx0wpJKzHJqFKduSAVjtu
	 E1uzwbS0LFytWDCimrT0KYKZcyR6n8KrK/UMgCEhZogDp3c+5LP6CPgKwAEeuuHaDk
	 19Gl2LQGXZlwDSPkDZJnR37+FubHg3groxXnXSsetCBRekmH0Bqm3/0OUcAx+hocYR
	 PIRuKbEB9CZOC8JOALC8+AV1obNiBoMKHTvcWIsmBmGiAv3oUH0Pxm7deowUlQTssg
	 1tBMSyH19LtaJQEHJkP9HZSCHfuQUmDbY2W17wE70EBEVfRMCP0tG9cFcHXFqkLbNg
	 rJ/WFF9g4/vHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/5] PCI: mediatek: Use generic MACRO for TPVPERL delay
Date: Tue, 14 Jul 2026 16:02:25 -0400
Message-ID: <20260714200226.3152882-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714200226.3152882-1-sashal@kernel.org>
References: <2026071353-appointee-tactful-9ca3@gregkh>
 <20260714200226.3152882-1-sashal@kernel.org>
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
index 8483d854e6d1ee..c6fa43fb094175 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -699,12 +699,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
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

