Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417887;
	b=FkjKpy/kYPZOrQGD5WqnwjowGS8CjKtl6GgolXw6lsoaAdhLBaqtCnPjWj3bzb7EPbjr
	 H9btq0bUjwrYtm9mUP8svUi8zKi1E/GVQhaM5rdx21p51RbXYTFXImf6Hl8bwIRE+u94A
	 5a4MPqwTUEKDmDY1/H5/fpkwknicUeG+ZrFY0YzoZWldHEnvjXoPD+qZdINkk4K3B7LXB
	 DBENjznXwWIoqsqaB+ZEYTEgtjapSaYHjiIOhNmXfLp3oGZXZrMIYGD5asS3nPV3uvd5y
	 +mDHn80RRFMQbeJowxXPTj0zU17XK54ibcL9DMbvGaAhnTfXNnyTxE6R/ca5eoW6M2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417887;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hDNO7OSKKQgCyD1Fa5SXRI+F3L6swch0h33kU9nERCY=;
	b=JxU1DDb9903k3Tf96yM/P8Yx20CrJ8kj41uMdqEuONoPuhTvw7bi3ofBVTYnRj1OueTx
	 PnWXbh5Zkr4UIjHGb2fqu2TltM15YWsCaPYCO80zZmljEdGpUo93J5xxSuKP3piPuVvP6
	 N2uLIPoz3qmtarU5/F/i+R353KPA+aTozVmQA+jWPj1FpsddjWauhuwkH09ADjZCm/PWD
	 15w3r0LoQRtpp9iEqgd3jxB0we3nunXrpHzufSA1P69veiyWz9q8nJUaNUwaGmIIQii25
	 YviBfHSs8TTvVieSvHj5rrxyYme8nlld9olGdTohQojsytz8aP3FLoK7HnRwQCVkvyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CttGTvJd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C11606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CttGTvJd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4321F00A05;
	Wed, 11 Nov 2026 17:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417886;
	bh=hDNO7OSKKQgCyD1Fa5SXRI+F3L6swch0h33kU9nERCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CttGTvJdXdLpGHPPN1WfI/5/bB7a3KYDvbSnKmaURS/9CRs9UxyVMM+mam4+bFZ4b
	 d5LaOn73bQ8+2xJDWagzIWFRlsQgqF9UT3uL2DFTURINWatR+z15IFtVEXuTT5hZk/
	 M2bIjWGl/4sOywxnzBVyFLQfWkdq32yYmAnHF91VKm/v2jsILJBtcZp5nzMCTLwDAj
	 5KAwhu+sgZ6c8DS1QuSmTBw2w+gOznf+uzaHkWD3m6dxvbgIHWm8+icc07BVF1OA0H
	 1jA6PAthmlNWVwf7iJsi8bd5Q72IJf4DMB8f2fVCxCB1GKcuWe8g+tymmSykIjtnHA
	 EXtGRAige/jRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sumit Kumar <sumit.kumar@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] PCI: dwc: Set DMA_BYPASS bit in outbound IATU CTRL2 register
Date: Wed, 11 Nov 2026 12:24:44 -0500
Message-ID: <20261111172425.3549528-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053515-failed-6.6-efadda401c5c@kernel.org>
References: <20261107053515-failed-6.6-efadda401c5c@kernel.org>
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
[ sashal: adapted the outbound control update to the older helper by initializing val from PCIE_ATU_ENABLE before writing CTRL2 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 5 ++++-
 drivers/pci/controller/dwc/pcie-designware.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 504450a8b6a45..86326116d85ca 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -506,7 +506,10 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
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
index 1ffa31797a17c..bb481205e23b5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -154,6 +154,7 @@
 #define PCIE_ATU_REGION_CTRL2		0x004
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
+#define PCIE_ATU_DMA_BYPASS		BIT(27)
 #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
 #define PCIE_ATU_LOWER_BASE		0x008
 #define PCIE_ATU_UPPER_BASE		0x00C
-- 
2.53.0

