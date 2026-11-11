Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417348;
	b=ZstfDtgP3pzEnaR3UtH4sTrLr4+b/PfHkqU7PSDVymBgQ4E4bWOk5S2MGMeagqhpXvUj
	 W6BZ5JUHn243lFdagfPlw6Fon2kr2Xy6x5O41j+lIZlJzclvf2xNhmn4pdA/EW9eKkbQ/
	 ifPQXCY+6bC+umz8OiirC/4o8GxnAknReysbMUPPWE7FsFYHEaAvpj8iQJY1OW1wfpqoG
	 wsEeaIf9Dwt1Gv8QSarcFw8IrhgFNArl5v2ZB+eLO/Yslo/zXrXLf2AXeGUAgvez5UMt/
	 2oGOUPMg0AZ7am0IaAXqMD2Dv42Qdhsc2q3UV5OwvqyH5KlAjR+gP5LvCLMNTEiUK6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417348;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zHSn5G2SzztnHSibLtDCJt5XYTbPTU29spGfvvTJZeY=;
	b=WgtsAVRzT8k7dRvpLYtQLXt7V655xC8PBSigAW2ChyRHNoVjCbFNKdMn+A4YsokkOgVl
	 Wyvh0yjFeiviOU4kjlBKcWZYjuJqUn5Q29Rxa6Tk2JAZbZb9fE9Bc/u58WfR+8/K8OOFq
	 Ej8R9O3GunrSk/n1LmSlSBWlmA9gPwGcLpDXZJmlIOaxplL2+xhgr+gvcnrtNnVfqLJsa
	 VVx6xg8ADcJEUVfRO82zP0gYnPkPvCuk4wnaRUF0RhunYOCUTBXXM9MmhNzZVSo3pr2t4
	 rLakMsWvPApBrgl9vuD/Kubaaf+SOI/kVJNuQ8XGjoQo6zQk9qdimMjB+VbByyle9Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e4IGSOLc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FAB606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e4IGSOLc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB2E1F00A05;
	Wed, 11 Nov 2026 17:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417348;
	bh=zHSn5G2SzztnHSibLtDCJt5XYTbPTU29spGfvvTJZeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e4IGSOLcGxFqPoGz/8tSkQnL/+sC6N5iOUYTl3/DK7GsctF0DgdNzkPYLfWwHBdJK
	 8vgsgvTEGkcWXpPftpT57pMhYM+byOWg1FPmTFL5WWcijpKoi3BFFlZ7JxXvKUenu6
	 FV331sWD4wuqttc6zULodTbgw/6ucclYEfAIITOaz04M2YweKWMbqK9w1EbGLoqfwV
	 X3dOSeh752Sl6L/1xlgoMD+xyQTGO4xfK14qMuOPJHtIry2ygUxnk2+oZAMWnR+hyZ
	 TuxLAtyPZ1B+rReuwrv37+c0ZZlLo1GPrpcgVEhYq9wdUHSAWfKxUesPltFXeix4qW
	 3C2KECqT84eEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sumit Kumar <sumit.kumar@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] PCI: dwc: Set DMA_BYPASS bit in outbound IATU CTRL2 register
Date: Wed, 11 Nov 2026 12:15:46 -0500
Message-ID: <20261111171514.3482713-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052243-failed-6.12-efadda401c5c@kernel.org>
References: <20261107052243-failed-6.12-efadda401c5c@kernel.org>
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
[ sashal: Changed ATU_DMA_BYPASS to PCIE_ATU_DMA_BYPASS to match the existing register naming convention. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 2 ++
 drivers/pci/controller/dwc/pcie-designware.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index bc3d6269f33bc..1dad7d69de910 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -514,6 +514,8 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 		/* The data-less messages only for now */
 		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
 	}
+	if (dw_pcie_ver_is_ge(pci, 460A))
+		val |= PCIE_ATU_DMA_BYPASS;
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
 
 	/*
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index a5f58ac8ea941..728f15cebf9e6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -173,6 +173,7 @@
 #define PCIE_ATU_REGION_CTRL2		0x004
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
+#define PCIE_ATU_DMA_BYPASS		BIT(27)
 #define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
 #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
 #define PCIE_ATU_LOWER_BASE		0x008
-- 
2.53.0

