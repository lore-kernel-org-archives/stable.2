Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D71626AF4;
	Mon, 24 Aug 2026 02:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787539362; cv=none; b=EzDnANvpHKElGv4oi7kh294SNYMoCicZg1XaYq0UQbdvpMo3MH3WOnvfOLn7fGnSe51190tRQVvpmbAnoDHJ5YhV/am2IvQsoFtOVQM35dcxlQnmVwGTg23maHJE59iQ502qodm3sIlUM8io0rJ5OhoO8bNHm0UdpLV3eoF0r9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787539362; c=relaxed/simple;
	bh=V9vHnE3kH0gZ8K3oW6/dvUq+35N/saT/ANArt5Lrs9A=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=XMCYK2S04K4pscMfCxbZog81kaIbu88ZAlouX2TGBrlIPSxpbFBr6K0i7pvCJSbTNEtWkZjX/lCPv3RNqE3DvLF6HNh5LwmvYqi61rXPgIptPECG8+jk9A1d+BKuqecI8wCMeBZZcQaDAYFW25BTkkDTBJoh/gzTXMPO2CGK4kk=
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
Subject: [PATCH v2 0/8] Add Aspeed AST2700 SDRAM EDAC support
Date: Mon, 24 Aug 2026 10:42:27 +0800
Message-ID: <20260824-edac-v2-0-c8d8bb693586@aspeedtech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJOvi2oC/yXMQQ6DIBSE4auYty4NvqYgXXmPxgWBsbKoGjCkj
 eHupbr8J5Nvp4QYkOjR7BSRQwrLXIMvDbnJzi+I4GsTS1ZS8V3AWyc6GCUhGXrUVK9rxBg+B/M
 cak8hbUv8Hmpu/+sJdC2fQG6FFPJmDMPDstG9TSvgN7jp6pY3DaWUH420yfCdAAAA
X-Change-ID: 20260625-edac-8e960e02e7f7
To: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	"Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>,
	<stable@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787539349; l=2978;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=V9vHnE3kH0gZ8K3oW6/dvUq+35N/saT/ANArt5Lrs9A=;
 b=XXSvVnRUICHxI9DnJdoEdFOU8J2txiDs0wz1CkmDp2Xnhr8sCeqGajvULSJ0Riky30K3iF1sg
 3wZ1AR+N5Z/DdaY+lcmZxDf5h0utro6XciKLWKsGBdDRk1TKA7TiKlO
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add ECC error reporting for the Aspeed AST2700 SoC to the existing
aspeed_edac driver.

The AST2700 memory controller keeps the same overall EDAC programming
model as the earlier Aspeed BMC SoCs, but uses a different register
layout, a split interrupt status/clear/mask scheme and DDR4/DDR5 memory.
Rather than fork the driver, the existing code is first tidied and
generalised, then the AST2700 is added as one more per-SoC variant.

Patches 2-5 are bug fixes and cleanups to the existing driver. Patches 6
and 7 rework the implementation to accommodate the AST2700. Patch 8 adds
the AST2700 support itself.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v2:
- New patch: free the ECC interrupt before the mem_ctl_info in
  aspeed_remove(). The interrupt is requested with devm_request_irq() and
  is only released after .remove() has returned, so edac_mc_free() could
  free the handler's context while the handler was still running on
  another CPU.
- Acquire the register lock with the irqsave variant in init_csrows() and
  in aspeed_probe(). The interrupt handler takes the same lock in hardirq
  context, so taking it with interrupts enabled would have tripped lockdep
  on the first reported error.
- Move the dev_dbg() of the interrupt status register out of the
  raw_spinlock critical section in the interrupt handler.
- Opt aspeed_edac.o into context analysis in drivers/edac/Makefile. The
  check is opt-in per object, so without it the __guarded_by() annotation
  added by the same patch was never actually verified.
- Return IRQ_NONE from ast2700_dramc_isr() when no ECC interrupt status
  bit is set; the handler clears only the ECC bits, so unconditionally
  claiming the interrupt could livelock the level-triggered line.
- Tested v2 on both AST2600 and AST2700 by injecting a correctable
  error with the memory controller's ECC error injection; each is
  reported as a CE with the expected failure address.
- Link to v1: https://lore.kernel.org/r/20260812-edac-v1-0-03992edea297@aspeedtech.com

---
Ryan Chen (8):
      dt-bindings: edac: aspeed: Add AST2700 SDRAM EDAC
      EDAC/aspeed: Set the DIMM grain
      EDAC/aspeed: Free the interrupt before the mem_ctl_info on remove
      EDAC/aspeed: Clean up whitespace and include ordering
      EDAC/aspeed: Free the mem_ctl_info unconditionally on remove
      EDAC/aspeed: Replace regmap with direct register access
      EDAC/aspeed: Abstract SoC differences behind chip data
      EDAC/aspeed: Add AST2700 support

 .../bindings/edac/aspeed,ast2400-sdram-edac.yaml   |   6 +-
 drivers/edac/Makefile                              |   1 +
 drivers/edac/aspeed_edac.c                         | 426 ++++++++++++++-------
 3 files changed, 284 insertions(+), 149 deletions(-)
---
base-commit: 5464985e42c04e335fb30e38fbc409c997db9bec
change-id: 20260625-edac-8e960e02e7f7

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>

