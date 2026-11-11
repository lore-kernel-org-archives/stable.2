Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417331;
	b=n8xFFh8awMrrVMCnfBtcGSy01zxS98TvTpkoWOA3sKoaz5wWhvRKlOfwveRwc6vQXx+G
	 Opt8eeI9eAZwFA9KRrkVgI1OHWXK3Fpa1jD1HNRgiqhi5zC/zrltN3WHe5KuumnKOFcNz
	 h3PjYg7eNxElvNZuYWhhb5SfbxjPwPzLS7Qt2lQIBBeTWkh76UMqEiHEjjyaFpBcjbxl2
	 BIf/I5QMAUEdzhUUCXmouIWdd5kGjlPGV9dMXIVc1dABoZxU/Zg9trLWdzMVwlKIKismt
	 lDFRz2FruiJDqt6aCfzF07yv5STkVGiuxJIEhsI7e0F/NkaxuLai9JLyuQcTJHJKp+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417331;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9BmHX8urxtz/E+JGkF8VmUGJIggdyhdT4qMQBrpZcAU=;
	b=iOWVYmT2SaUN1yycDIEQBfXPD4bJOvFuQmxgWUK75ubLTitEVKZeHvrdV77b5RFN3ILt
	 zMiV4zXE0gScjf+eWt/G8e2qlofz57wHvn+IJS7C1RFZMgmuIoGq2JNOzRoLXHoPpNGFo
	 LUz7zCw2GXxsBJ1MuUB7FHRHXyweQSoSzDPBJ+yiRRovM1QOmEKn7fKi6+b+WKF1Dwbp3
	 p2VW2gpbU7y6YW38HK10dW3m6crMTlcg+xoNlBS8A422Pa5heukI1Eh287IhgE12/+K5g
	 HIKpptm+sqvWvURvQGX0QCS31V4x6z1d7+w+14zwoPxrY60LRm0MF8XBv6V1n7/oJWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhAYScJb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C91606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhAYScJb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D221F00A05;
	Wed, 11 Nov 2026 17:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417331;
	bh=9BmHX8urxtz/E+JGkF8VmUGJIggdyhdT4qMQBrpZcAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UhAYScJbnpUdG30WiuT/Rs7Lv2VDW6yr9GEw3CwSQ4KAgBhA6yZe+PO5YVe6LLnO6
	 kECaC9Yl/b22we8TIwkG+OGLXkUHx5CgE3lMoWo+OcwgW3aiHzsdx5CQ9tsY1c009l
	 dq/1FYmBtwqd+8RSeSVs+P15MxO7Q+xYnVKuv0kUfVZlowzYD6qt1XdsvABsMd00NR
	 NrE0GZEwGlsEVSK5R3lGOnVXtWOc6/Uxc87qAItkxCt452Eoq173f3VuGCjy6Vr5QG
	 MmNXMAAHp34DO3g7qi3KVoE2ccrPlXi4x3WA0J1HgrnkzzutUR08Wu3/xXe/x8g/Ga
	 hicg+Lit6odcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sumit Kumar <sumit.kumar@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] PCI: dwc: Set DMA_BYPASS bit in outbound IATU CTRL2 register
Date: Wed, 11 Nov 2026 12:15:29 -0500
Message-ID: <20261111171453.3471440-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051128-failed-6.18-efadda401c5c@kernel.org>
References: <20261107051128-failed-6.18-efadda401c5c@kernel.org>
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
[ sashal: Adapted ATU_* register macros to the existing PCIE_ATU_* naming convention. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 2 ++
 drivers/pci/controller/dwc/pcie-designware.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index a77d7cde4524b..f2e2dbae050b2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -568,6 +568,8 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 		/* The data-less messages only for now */
 		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
 	}
+	if (dw_pcie_ver_is_ge(pci, 460A))
+		val |= PCIE_ATU_DMA_BYPASS;
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
 
 	/*
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index aa27211b68dd1..c01634c0211fd 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -173,6 +173,7 @@
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
 #define PCIE_ATU_CFG_SHIFT_MODE_ENABLE	BIT(28)
+#define PCIE_ATU_DMA_BYPASS		BIT(27)
 #define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
 #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
 #define PCIE_ATU_LOWER_BASE		0x008
-- 
2.53.0

