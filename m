Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD55423ABB9;
	Sun, 31 May 2026 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780240247; cv=none; b=tGiHoKk1GR5ovCYrRCVmgKRQAuznjWPLN4et6HUQzAae3cYJ2NBgjwKllqj2Ra8/0vJJ0ayWQZzBQJcyPdSu0y0cw6SixaKnFNpoqQo2BE0uURp4iEPqrFdLkcaUrp43hv3z4xRGwOrtcr2rHvIsNp35qDdwlfNotHzCQyFF60s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780240247; c=relaxed/simple;
	bh=/WvQqRzLV6/31YRlR06Wu9LK7gnO1utmm8eK6Ltkcjg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uM1wLDUna3Zxsy8YVkDrdRCx/2Kz5ky35lAOib47iGlgO0h6qJ/2H1UsBWDAOKfqwPOPRH/7cMbmLIZ4Vv1/lZgKuOJRuQk+SKdhugLcIyqFqDoRyqyTael5NH6jh6MJ7fRwvM73n+/oRbX8teX2DGJHxBmapWHpPw9HWhbfXlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Xw1d5ZyY; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Xw1d5ZyY"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40796bd43;
	Sun, 31 May 2026 22:55:13 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Kalle Valo <kvalo@kernel.org>,
	Igor Mitsyanko <imitsyanko@quantenna.com>
Cc: Sergey Matyukevich <geomatsi@gmail.com>,
	Andrey Shevchenko <ashevchenko@quantenna.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: qtnfmac: topaz: defer IRQ enabling until IPC init
Date: Sun, 31 May 2026 22:54:35 +0800
Message-Id: <20260531145435.701703-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e7e88299d03a1kunmc8b7c3c910ac2f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGUNJVhoZHR4dTx9LGE9KGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=Xw1d5ZyYxJ4aUersYsAb/1+IGjVWgMgTCPBP7QiONKMypAV7smhjNHByFXwmRCtdvQDbsSLKPr3ZYb4eUNgR98P268yyb/+0p5vlEZeb1/zxym264IYL3dVWPNIRiX4n9C1ffCU7qAC7sSQAl7tiZzMUiNVZvBnSUzqCSWz+dwc=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=HX5NtF9cwr3M6zvvxorPVwS+U+QX6xEfSohkA7zvYdY=;
	h=date:mime-version:subject:message-id:from;

qtnf_pcie_topaz_probe() currently calls devm_request_irq() and only then
disable_irq(). request_irq() installs the action in the irq core
immediately, so qtnf_pcie_topaz_interrupt() can run before the Topaz
private IRQ consumers are initialized.

This window is reachable on a running system as soon as probe has
successfully registered pdev->irq but before qtnf_pcie_init_shm_ipc()
sets shm_ipc_ep_in/out.irq_handler. If an interrupt is delivered in
this interval, qtnf_pcie_topaz_interrupt() calls
qtnf_shm_ipc_irq_handler() for shm_ipc_ep_in/out while their irq_handler
callbacks are still unset, so the driver can observe an early IRQ
before its IPC consumer state is ready.

The issue was found on Linux v6.18.21 by our static analysis tool while
scanning request_irq()/disable_irq() registration-order bugs in
wireless PCIe drivers, and then manually reviewed. It was validated
with a QEMU no-device harness using
IRQ_SIM and a directed generic_handle_irq_safe() injection between
request_irq() and qtnf_pcie_init_shm_ipc(). The harness reported:

  has_action=1 shm_in=0000000000000000 shm_out=0000000000000000
  reached handler before shm_ipc init
  irq_count=1

This is family-level runtime evidence for the same early-IRQ window. No
Topaz hardware was available to exercise the real device path end-to-end.

Request the IRQ with IRQF_NO_AUTOEN instead and keep the existing
enable_irq() in qtnf_post_init_ep() as the point where interrupts
become visible. This closes the early-IRQ window while preserving the
intended bring-up order.

Build-tested by compiling topaz_pcie.o on x86_64.

Fixes: e401fa25cfa2 ("qtnfmac: add support for Topaz chipsets")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c b/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
index ef5c069542d4..a3a285f17dca 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
@@ -1132,9 +1132,9 @@ static int qtnf_pcie_topaz_probe(struct qtnf_bus *bus,
 
 	/* assign host msi irq before card init */
 	if (ts->base.msi_enabled)
-		irqflags = IRQF_NOBALANCING;
+		irqflags = IRQF_NOBALANCING | IRQF_NO_AUTOEN;
 	else
-		irqflags = IRQF_NOBALANCING | IRQF_SHARED;
+		irqflags = IRQF_NOBALANCING | IRQF_SHARED | IRQF_NO_AUTOEN;
 
 	ret = devm_request_irq(&pdev->dev, pdev->irq,
 			       &qtnf_pcie_topaz_interrupt,
@@ -1144,8 +1144,6 @@ static int qtnf_pcie_topaz_probe(struct qtnf_bus *bus,
 		return ret;
 	}
 
-	disable_irq(pdev->irq);
-
 	ret = qtnf_pre_init_ep(bus);
 	if (ret) {
 		pr_err("failed to init card\n");
-- 
2.34.1
