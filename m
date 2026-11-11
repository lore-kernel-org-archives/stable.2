Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418176;
	b=RXmQNnIb3apk+wUYym58vgkRqxh/bEmuIiftnu5WytHBDnMG87YKRs8NB3DXR9s16nj8
	 rihVOjoVph1ShRBBo6AOsqizocanqPBVNawNTjmvFSStePV1wq+8o9GH3iyjhucktqAsE
	 8LGkoOx/IKyxk6tr382vryTBua7Ie4lhMiXkgWcEiHfKS+uBXKYc4OsV+gVIZo2zPa52j
	 GMqi3lmBNgLu9v39e/iUxh5qpzYm80yFVDJEL8w0OPg5mVI+dIyXeg8LZsymDgFs4YuEr
	 rpiFWWwrBONo3sCBZfdKGye0ywPXhpkV6isHCfzq4XG8DDJzc4GZjSMkfMvZpFid55g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418176;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+AvUN+UylYj6Rrs6tbRGzmKgQcsCms7CltebbXBGWEo=;
	b=u4yUvtNtZT/DnZm0fhOm8U/e7oTPqPtxzaN3J6tHpPj84EHLK34koQ4+FtgNeAsGTn98
	 Y2L3B8y+v/rp6LbTxQEx17yvwFwiLMDASnJaQldHn8M5FnzCTW8eScIChomgLss/u0qQ1
	 gxpBQ9MTPJrE8XLGLzQZPZSyWhjHYIjj9QeLnmaQw4Bs0qYUooqpz0mawdZi5jnfSD65P
	 sn6xlA5xdvSh0lM9oSP1hwILPd7Y+Yy/Hwcst9WHRSGfIbH8YXEvH7Hy7DnQnDacL7FyL
	 OFadMZ0+s+CJJvtCAnAB1rUO4OO0CpP5DPMnLu3EGd+OS+r2/+6s6CPSRD/kmhlLA0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HJUSpEaV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA748606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HJUSpEaV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B881F00A06;
	Wed, 11 Nov 2026 17:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418176;
	bh=+AvUN+UylYj6Rrs6tbRGzmKgQcsCms7CltebbXBGWEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HJUSpEaV9csy/jsSJC6+UhVI1tqBtn+E5IjmY9fKsH7fbhsgKyOP0SoD15B4vzOzk
	 vwxU1P+Hkru/1/sZCZf0RdYw5/qSozGDBTET94L21cbzKZGkODWBPoR4P5tgjtCud9
	 0DJ8P9pQQXg/phIkZEugYmita7Ah6R1ApknKqZs/wRQcaaiUv1pSKr4rbV8IoI8BRb
	 H51YtAoXFMetycTVPPKwY/TZwKBrRt/YaStWAuIRkwGoi0gq4LbIByFZdW1P5laYdr
	 65TPfWQ2iFdeK54ofNqaaF3mncE9T3VqWj41UjwxKbnGLC2Zqx1n4mpj1xoRuP4YwV
	 V93fjf95XLtUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sumit Kumar <sumit.kumar@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] PCI: dwc: Set DMA_BYPASS bit in outbound IATU CTRL2 register
Date: Wed, 11 Nov 2026 12:29:34 -0500
Message-ID: <20261111172916.3550434-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054916-failed-6.1-efadda401c5c@kernel.org>
References: <20261107054916-failed-6.1-efadda401c5c@kernel.org>
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

From: Sumit Kumar <sumit.kumar@oss.qualcomm.com>

[ Upstream commit efadda401c5c8e2390ba66508eba154dbd0db5a9 ]

An outbound iATU region matches any local (AXI/application-side)
address that falls within its Base/Limit window and rewrites it to
the PCIe-side address programmed in that region's Target Address
Registers before the transaction goes out on the link. This matching
does not distinguish CPU-initiated transactions from ones issued by
the internal DMA engine (eDMA/HDMA).

Example: outbound region 0 is programmed with Base/Limit covering
local addresses 0x8000_0000-0x8000_0FFF and Target 0x1_0000_0000, for
CPU-initiated accesses. The DMA engine is later given a descriptor
whose destination is the host address 0x8000_0080, which happens to
fall inside region 0's Base/Limit range. The iATU matches the DMA
transaction against region 0 too and rewrites it to 0x1_0000_0080
instead of passing 0x8000_0080 through unchanged. The transaction
then lands on the wrong host address, causing data corruption or an
IOMMU fault when the rewritten address has no valid mapping.

Set the DMA_BYPASS bit (bit 27) in PCIE_ATU_REGION_CTRL2 when
programming outbound iATU regions so only CPU/AXI-initiated
transactions are matched against the region; DMA engine transactions
bypass the translation and go out on the PCIe link with their
original address.

Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260908-dma_bypass-v2-1-c3c81d408c0c@oss.qualcomm.com
[ sashal: adapted CTRL2 value construction to the existing __dw_pcie_prog_outbound_atu() helper using PCIE_ATU_* constants ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 5 ++++-
 drivers/pci/controller/dwc/pcie-designware.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 575834cae3b9e..ef88c9d8553da 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -348,7 +348,10 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL1, val);
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
+	val = PCIE_ATU_ENABLE;
+	if (dw_pcie_ver_is_ge(pci, 460A))
+		val |= PCIE_ATU_DMA_BYPASS;
+	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, val);
 
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 44254f31b5ac1..535205b8d1596 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -135,6 +135,7 @@
 #define PCIE_ATU_REGION_CTRL2		0x004
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
+#define PCIE_ATU_DMA_BYPASS		BIT(27)
 #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
 #define PCIE_ATU_LOWER_BASE		0x008
 #define PCIE_ATU_UPPER_BASE		0x00C
-- 
2.53.0

