Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418416;
	b=tCPstDa+OaBBjjpFIiqYhjYyKY5gZxBv26bPTbN3ljtlowpSbyar0pchGqKHEdpgmLQT
	 KRTJL4p37B9/AMs/1Umf2shZOiqX4xqqBM8yagr9+LvSaba9SfKK7e7cFrvbkyDlQPPTe
	 8jggm+NysemQJBwwgh2WCGNwZDaCkdE9/OssF/YEeuDqBydEtpRbNilQ4rSDFyABz1bek
	 E/S+AcIYFel5PBYrivp8uaSPL/ON3/QGSjCO4aLrK+UOAD43GYnGeAuTo3Z9DRtoSNYha
	 aHe61HU3U1LiB6s7+YNMQU8saoXAZ63KFs3CDLNLRoA+B7uosLXCLZh8AU7/lEIarNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418416;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=C6d8IYQC8dyoJDUP7G0uiq4suMOtmZ8EulZbGfX4H28=;
	b=pg/lh3nmnKgDqvc4TwWtVDxRwi0XFmDuVAvTIjeuI/IUhTebiBE5ERN+mOeftO3JutWV
	 IsDOJzM0xb2FCo5f7/0RBy36FX3QH8auDO4FHY6w1ES3V/zbScCNna9KUrhA8ySagFQy6
	 Bin3+SUx2G7pjiQvM5xxssbKndUFYTfMmHL2OkQmAlQUHsoxBjguZwr3xv+EyNSycN6GF
	 R/P96l8oMVH2SFYMI/R7wqxhef+P0Tq9gEL3PglHeCx1HAl31z0cBApboOCIIXeDNi6Vn
	 sC9DBluu/RrI3k/BMNUUU/MZPZKAjosriER3k7Og8Ka8GcEQKTpLNsTEsjdh3MPH4WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IRGdPnQU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFF1606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IRGdPnQU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13081F00A05;
	Wed, 11 Nov 2026 17:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418416;
	bh=C6d8IYQC8dyoJDUP7G0uiq4suMOtmZ8EulZbGfX4H28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IRGdPnQUUsuUQdFbh4CH4r3yhIQrGldZfUPZP7lvVMpT+mat90w390fmDw5MoGHGL
	 rR10QDSGz0B9Ifvv9jGPqnrmf6akm0BD/W8ncHvpMx1+AjHUZM8125J4qDjFCeXoTh
	 0EM2MMtR1EybqdX545eNQmjdrF5Kik/kcJuCT+67GPzwesR2nnEQ8bGWBzwQkiOJ5r
	 Cwqh7iVLh4uGLRBVUo3MZWxBzhhyV5uOJ7/NL4SGZpZ6yBEwEqa60Em1zWkFpuEWPP
	 TVRw/JBsRVjPEIoA23MxNOKATDJAfC2lESr5ou0lnOy7HbOd77pFIxZIgSJIBQs0dG
	 uVagxs6via8QQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sumit Kumar <sumit.kumar@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] PCI: dwc: Set DMA_BYPASS bit in outbound IATU CTRL2 register
Date: Wed, 11 Nov 2026 12:33:34 -0500
Message-ID: <20261111173321.3585676-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060622-failed-5.15-efadda401c5c@kernel.org>
References: <20261107060622-failed-5.15-efadda401c5c@kernel.org>
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
[ sashal: adapted unified outbound iATU programming to the existing separate viewport and unrolled-register paths ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 11 ++++++++---
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 00972a7bc9768..22fc8ee305eec 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -292,8 +292,10 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
 	if (pci->version == 0x490A)
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
-	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
-				 PCIE_ATU_ENABLE);
+	val = PCIE_ATU_ENABLE;
+	if (pci->version >= 0x460A)
+		val |= PCIE_ATU_DMA_BYPASS;
+	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2, val);
 
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
@@ -350,7 +352,10 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 	if (pci->version == 0x490A)
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
-	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
+	val = PCIE_ATU_ENABLE;
+	if (pci->version >= 0x460A)
+		val |= PCIE_ATU_DMA_BYPASS;
+	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, val);
 
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 5960ae40b0f2d..4807efe73f2ef 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -91,6 +91,7 @@
 #define PCIE_ATU_CR2			0x908
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
+#define PCIE_ATU_DMA_BYPASS		BIT(27)
 #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
 #define PCIE_ATU_LOWER_BASE		0x90C
 #define PCIE_ATU_UPPER_BASE		0x910
-- 
2.53.0

