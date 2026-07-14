Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1670D3F39F6
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 22:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066659; cv=none; b=lhezUupXXHI95BSOexc/x4ZuwbMsB585B9fnR8n9VIL+9UoLgHPVhle75YYiq7D0pv0E66DErcyis1o28GNuHVmnrFvY+s01GcOHFes2+aN0wOEwziwWTCVOZOfMVm0YQmueiBpFw1WUs2qSZJXQUjQgcoCLwyQ6Cpjvrez/HIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066659; c=relaxed/simple;
	bh=M90bVnJMqGhBJLhfJM2Yd6yOnnRHmF8w/bBIsJSBPEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sp0FZfP1a9C/IRhM2AjQUhVB5HxVd8pjOe430hvEZpnhONK7rsml8IxBJHmq4CbFRRSGY3nuv5Rs6VcR9CBY4YHvmBqv9FM0vsaRO9d1BOJQMsQF48swkqlCZvnUbqiRop+lAUVoxZzXqyDa+IJjgBi2pQ363N8Fr62f3TgMEuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/oakvm1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/oakvm1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657631F00A3E;
	Tue, 14 Jul 2026 22:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784066658;
	bh=oiADHwS4qSY4ucZjEPPhaKwiqWG/79+hKqaEZKsQ0PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g/oakvm1pbQj7R7DK3KucaMYcODX392z4a0LQS/L/7HwLcz1xzDfHASKnBCqvbwtK
	 PVBCr5kSgOlLljHwaYdgMW6K1664Edf/05XrdsnLRaS6vHGTeSRRqbbSZU0RJ2/J+m
	 Tcj0qI5nqTWrXS7ZbeNziD9YoqeeUXXYtas21WkFYxV7Y7SyZW4dOYF3JOKz4xwfsg
	 V9gfOQUAgW4KJU2ZLzvGxmTcqvdgM3g/LvMdDi7127boN6P5gGOkocYhv4k3a1+BlN
	 Mk8wKyP4F8UQf4F8nyh+J5+VjZQRq4k/9Rdv9vyWlI80LQvcLa2NdvNuN5KQA9/obZ
	 cizoZMWep/abQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] PCI: mediatek: Use generic MACRO for TPVPERL delay
Date: Tue, 14 Jul 2026 18:04:13 -0400
Message-ID: <20260714220414.3333873-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714220414.3333873-1-sashal@kernel.org>
References: <2026071354-duvet-skimming-764e@gregkh>
 <20260714220414.3333873-1-sashal@kernel.org>
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
index 0e08e3104c347c..c0231c64e15e43 100644
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

