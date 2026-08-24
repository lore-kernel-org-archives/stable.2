Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C49A36492D;
	Mon, 24 Aug 2026 02:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787539375; cv=none; b=gdmQ1dYp3UqGtfuiLw3DX9H2yBg6zLc8nyMI0KlOhsGKFDElmqjgeFdcUA0DqDKpPN/8ubpde1AsoSTrNYf+ihUV76j26+2S798hPCUnmLIaSszzuI2uokZFRTsV1y1lnkiEVvWHUWJfeg23PgMGbiIhCDA2gvmR7DEPflpYUiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787539375; c=relaxed/simple;
	bh=RlxiTc6ufbAPp2W9fkd50aRtYznC++m4JM40pI/YrqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Et9wE66ve0xuquxPlhLCF1tqCgdqPPW2QRJzzD1oV51S2GqG8f63MCuoHVDhBXwPZeCxF7eVWrmF9jYjp9gKv+oKYY/l1yi8cbIRTLIkavrIPWzMGPz0rDL9OD1V3kWd+FlcNKrFhHiWpT7iA8DcmLHoS5vmrju4rqX/Fro7f4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 24 Aug
 2026 10:42:29 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 24 Aug 2026 10:42:29 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 24 Aug 2026 10:42:30 +0800
Subject: [PATCH v2 3/8] EDAC/aspeed: Free the interrupt before the
 mem_ctl_info on remove
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260824-edac-v2-3-c8d8bb693586@aspeedtech.com>
References: <20260824-edac-v2-0-c8d8bb693586@aspeedtech.com>
In-Reply-To: <20260824-edac-v2-0-c8d8bb693586@aspeedtech.com>
To: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	<stable@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787539349; l=1363;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=RlxiTc6ufbAPp2W9fkd50aRtYznC++m4JM40pI/YrqE=;
 b=gpm27cUcRMtuWzCYAMZDJ+ZRjHayMCjYlYb1GvBw7j/JjEkz5DoJugDkwdsgHS1YKJBXoglg0
 LrgCW0p3PfhD0Ihn/PVxqB2zZL+Dut7Vd3Y6FJ9p6NtwOpzsuoeFiW4
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

The ECC interrupt is devm-managed, so it is only released after .remove()
has returned, and masking the controller does not wait for a handler
already running on another CPU. edac_mc_free() can therefore free the
mem_ctl_info the handler uses as its context while it is still running.

Fix the ordering and synchronise by freeing the interrupt prior to
releasing related memory.

Fixes: 9b7e6242ee4e ("EDAC, aspeed: Add an Aspeed AST2500 EDAC driver")
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: stable@vger.kernel.org

---
Changes in v2:
- New patch.
---
 drivers/edac/aspeed_edac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index 83d60414f89a..e05ebed5c2f2 100644
--- a/drivers/edac/aspeed_edac.c
+++ b/drivers/edac/aspeed_edac.c
@@ -359,11 +359,16 @@ static int aspeed_probe(struct platform_device *pdev)
 static void aspeed_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci;
+	int irq;
 
 	/* disable interrupts */
 	regmap_update_bits(aspeed_regmap, ASPEED_MCR_INTR_CTRL,
 			   ASPEED_MCR_INTR_CTRL_ENABLE, 0);
 
+	irq = platform_get_irq(pdev, 0);
+	WARN_ON(irq < 0);
+	devm_free_irq(&pdev->dev, irq, platform_get_drvdata(pdev));
+
 	/* free resources */
 	mci = edac_mc_del_mc(&pdev->dev);
 	if (mci)

-- 
2.34.1

