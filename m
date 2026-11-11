Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416725;
	b=E123X0AoBQCk1dox1o0yxZ4gIj0nccAaci7P7C9k8+cGcoW+pn6kctUfc/+WRMHhLgE4
	 RbtuPeG6yjW4/feNSZaU6giiv+3xYMhrzLefpiqLz4MdSOiPsC3e3IXcctB0mN7J1WB7R
	 0lyNxuftqNAO/E2VyQO+/3tgvs6D0Axu7hkoI3d1nSgyxGpuoOgyBWG3IF0Jfa6WJoB07
	 j8e6jHBP5anE+jHDuQIWZpL29Wk4z+Gd/8J6OF0F/HOm3QRJscBZ8l00NtFnm9YBemfTg
	 z17Th+WO1dbL+1SJCHpQE7IjrgLgSBa/7980iIGRKI8TmqNzU2bvQMYb42uRlLLw7FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416725;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cnMlyRzyptQa+m9ZBMV15UJU9jtsL5NmWf0SGdjY2M4=;
	b=wJRIm4AhoDt1WinSsjm0BpcTwEAwzkpUDAvP0t8+N34D3I4BzbgGCRbovyyw/re58U1A
	 Nl4ra+6Bqvo0z81L6BO+FF+5v7vpqIaALDoquKa7qYGjvu2rmbBauEp6XwN+G7aSxYsM2
	 AkBCOtVm2hKiG6WbfzIZlmA4gB4Zmz/Ef6rdKZ848tvPWNUmHWTFyQzf7EGkrag4NAeSA
	 5WNfYt+wVK57yyIt26fzNhRm9DvkV6gjqQbU/WPwldpFVdQJs4/7jKK9yQHg0BprMvxQn
	 t4m5I03xGpgMGoZeKTWXipVvRaPUdUlTLdfTaS8H3utr/QTKlrUbkKueB96gl/a9zYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k3E69y0S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C4B606A330
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k3E69y0S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A3A1F00A0A;
	Wed, 11 Nov 2026 17:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416725;
	bh=cnMlyRzyptQa+m9ZBMV15UJU9jtsL5NmWf0SGdjY2M4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k3E69y0SlNw0TFBQ/xf7Dc2VO1+eCZzLILapY5kR1726kMt6YAhjY1QfWFeZzALXe
	 MGK3D1zLOciHKbSAuVAezQXT4Q8hlYQF8rwxpZ5sXbBGqBInikMnWmM13/9K0UCYFy
	 bodZ14bg1vD+hlizLVWflqTYkVERSJm7Kr8a1sS2/lgz7r9FozvOA7d1Ohf7cbPNgO
	 YV80Q2I7dhOkIEnVb/jhIvT4Yq/vvEARWj3S3R0pkAkun4GiSQPdBcjhWz7AnhlyeG
	 9YxuAxsBh+wH39HqpWcGeYGfeDDG7Dff12qWD7hhbTiAb9XJCVKpKkCHnAhQJNukQI
	 bV14OwwBxjaFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sumit Kumar <sumit.kumar@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] PCI: dwc: Set DMA_BYPASS bit in outbound IATU CTRL2 register
Date: Wed, 11 Nov 2026 12:05:22 -0500
Message-ID: <20261111170509.3407616-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111170509.3407616-1-sashal@kernel.org>
References: <20261107050445-failed-7.3-efadda401c5c@kernel.org>
 <20261111170509.3407616-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 2 ++
 drivers/pci/controller/dwc/pcie-designware.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 855d2a54b3c6b..074b007dc2963 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -577,6 +577,8 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 		/* The data-less messages only for now */
 		val |= ATU_INHIBIT_PAYLOAD | atu->code;
 	}
+	if (dw_pcie_ver_is_ge(pci, 460A))
+		val |= ATU_DMA_BYPASS;
 	dw_pcie_writel_atu_ob(pci, atu->index, ATU_REGION_CTRL2, val);
 
 	/*
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index aa79f000b1607..cf05206b563cd 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -217,6 +217,7 @@
 #define  ATU_ENABLE			BIT(31)
 #define  ATU_BAR_MODE_ENABLE		BIT(30)
 #define  ATU_CFG_SHIFT_MODE_ENABLE	BIT(28)
+#define  ATU_DMA_BYPASS			BIT(27)
 #define  ATU_INHIBIT_PAYLOAD		BIT(22)
 #define  ATU_FUNC_NUM_MATCH_EN		BIT(19)
 #define ATU_LOWER_BASE			0x008
-- 
2.53.0

