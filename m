Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135415;
	b=TZYvOqrZmZ/mX0dagykGAtO62SHJyn4jRTBw8DADHViYHQkqRq9kRjiJdJOKyb41tdHQ
	 rRrAF0IwywPFKKi1sVjfpheQxnqfnTGpyovfIHDQeIS0dWl8t/qwgA+To1J3g4+8z2HfS
	 NvQjVyTd8RZ8cboa6mqvFCtQvMnU/SaySWSYAaiG+Xi0vy6ewLcaXkbND0mSJYt7mC+lT
	 8bP2MAwjnwPDe56uSw0XKfBSnalLl0I1hvZEq9PE5CoHQNHA2BSKkK5BG0cf0zRW3qrm3
	 Y47oSvS1QzNSgXh/BroXRX2Dp49sIP6jHG5W1Y/Y1dK7Z5OnBOETvKPwJ2VucNiRXrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135415;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=LQfWZFMR9WFMzlyRF7ueDqFRTYrzGXVUt1ZgeBbyRAQ=;
	b=ld4CdQ5euh5P/JtIZ0VTvWz2fRgzr4bnku/OTHFlCuo7xyUEPdzPn8r1ET1tP73aYeyl
	 PuM8jFrTmn6jJOif5/OrGabAExt4lwPuP1n4VxlEOIcuKsiq2Sq4Q5jplgjQck5pmEUJE
	 JbuCWxoOdOop9/nBjGgH6MUS/ItMKHHTyjMDSkiuWsnJFltDQ4+RFL/03qRQPL1vW0ghC
	 8ZEPxYORLQIJ306+AH9kwuR/mFAaNilxV1atb4Rw5cVYm3bFc2U16n38D8nG35HtEOs2n
	 O9bV9JZU0Ks/NKLQdXxu0UxQyllrlbk7T1uqa82lgRZhbyXuUPoHulMvT05Kl2EUGxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=TkyLtaea;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA715606A33B;
	Sun,  8 Nov 2026 10:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA715606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=TkyLtaea
Received: from LAPTOP-99KJFSET (unknown [223.75.64.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 53e3dfdda;
	Sun, 8 Nov 2026 18:56:43 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Robert Richter <rric@kernel.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH 1/3] PCI: apple: Fix ECAM config window use-after-free
Date: Sun,  8 Nov 2026 18:56:37 +0800
Message-ID: <20261108105640.875-2-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261108105640.875-1-getshell@seu.edu.cn>
References: <20261108105640.875-1-getshell@seu.edu.cn>
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
X-HM-Tid: 0aa1bacdac5103a1kunm546e4281ce699
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSU1CVhpMGUJPSxhMThhCS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTE5VTU9VQ0lZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQk
	pVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=TkyLtaeaGRYaWaR08vym002xhqiPJty9Igz67U9WHKDH1KRi5m4YECuVnF87xHBMvmRijKYmt1SsdDcbQcsSO6ezhfRTl0Vbn8aOZ1F9/KLgLpLf1IjsgD9T52MrZN8E15wtVobzquPYDHYYwUPuqBb11d3SESEw7482kYZ8Q4k=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=LQfWZFMR9WFMzlyRF7ueDqFRTYrzGXVUt1ZgeBbyRAQ=;
	h=date:mime-version:subject:message-id:from;

pcie-apple.c has no ->remove for pci_host_common_init(), so unbinding only
runs devres_release_all(): gen_pci_unmap_cfg() -> pci_ecam_free() frees the
ECAM config window while the bus tree stays registered - only
pci_remove_bus() unlinks a bus, and only pci_host_common_remove() reaches
it for a root bus.  The next config access is a use-after-free in
pci_ecam_map_bus(), which reads cfg->ops->bus_shift.
Trigger: CONFIG_PCIE_APPLE=m; as root, one command: # rmmod apple_pcie

Fix: add .remove = pci_host_common_remove, as pci-host-generic.c does since
commit 01fcb7f777a9 ("PCI: Add support for unbinding the generic PCI host
controller"), so pci_remove_root_bus() unlinks the bus before devres frees
cfg.  Scope: cfg lifetime only; its IRQ handlers stay unreleased, so the
module is still unsafe to unload.

Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/pci/controller/pcie-apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 2d92fc79f6dd..805171551e01 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -884,6 +884,7 @@ MODULE_DEVICE_TABLE(of, apple_pcie_of_match);
 
 static struct platform_driver apple_pcie_driver = {
 	.probe	= apple_pcie_probe,
+	.remove	= pci_host_common_remove,
 	.driver	= {
 		.name			= "pcie-apple",
 		.of_match_table		= apple_pcie_of_match,
-- 
2.50.1.windows.1

