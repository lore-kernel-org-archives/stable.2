Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418761;
	b=VlFhurizoGkvZsvV1K7u6sflTxVgjpLCvYWyzy3t9UxP9JaZ9rPqaVz8wD17M0FNWudz
	 CemrI9cUp/HYer4TIBcHBXMOHb7IzNw6RhM6vAA5CoDEp6ZHBHkizW6Qd90JZi+ULqwwb
	 Pp8O/HbEnk0KXJyqXBIp+BvbTM/KyBmNzZD7xwob98TO0DradB7DRclyzmehJlwKISrHh
	 h1r0fjqtq5tqsWIgbe7e/HyppGjvbvRDJ6/CfA+99yBNaUfjyu0rjykJF4Wc+vAzuaKc9
	 VPcA7Gt2lQO/fbBkhlrNW6SOgkgdwwdRjxtgHSDY4zU5IRrZqhQY5V9w2y3p/K92GfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418761;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lpRmLNLK2l0o+WZoWHJNyJhoIAQ4xuZviVMxZmqnKzI=;
	b=Bh0MFqtem8HpS2+zL0lf6Z+oP1uuYoYXW0cqZuFIsKN1+DwLNMgYDTUAxKMh4/YEhB+0
	 aGBzwXCSn/o4Mwee4cxghui2+vQ7dV0zoWw8Tt4T5NLNWJEuimr+xeaB5NtG6/qz8p3Ao
	 VOhg5GRowJDfe7FVTyRnmjiJUAHpFr2nkvqPfFwtMfkfwFxPzq4BXYR/VgisoOIagZxrI
	 +QzDpOt2n3WhpmqDjk9uwOgG8LlP5fsipQQlSGvVSwMGy6S2ECEaxMMkhJ54yd5iH/SZw
	 7dO5szqrKEjk9M2JjcpgGvopAeMGGyCbmV0Vn5vyvJWKR2IcQfTWxytrrSZtw4hYfRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G3OIxFyC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1E1606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G3OIxFyC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7584D1F00A05;
	Wed, 11 Nov 2026 17:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418761;
	bh=lpRmLNLK2l0o+WZoWHJNyJhoIAQ4xuZviVMxZmqnKzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G3OIxFyCrH/wBDimeN/OAPKRjWRpYmJFWJPHxddC5QNoLbL+QcILjKanNuusnmqVs
	 MxMH/Nz//zuqzNvtv0hirHOLtSG1PrTo9YIbRP1ukhHT8ajlp4XYvShDLZhAD9UjPN
	 OZKIr5hJdAphvwGhoxRaqXWi4jc6hpd3TpQSFgQAlMkk4ZykVLkxZ8mRnHkWchnmY/
	 WWYFb/zhe/ewEc5Nn0/H2jKEot85yIdbWixmhU8UgvLW+HjZTLFUSl7GPRQvaeplBB
	 zHdJtVo/Sewg+e8qT5S3tU/WhaObYEEYOcRCgEgOwf3CUTv8HOzHBTaLyUzKpsh1xE
	 Df9NBsXogxUwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sumit Kumar <sumit.kumar@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] PCI: dwc: Set DMA_BYPASS bit in outbound IATU CTRL2 register
Date: Wed, 11 Nov 2026 12:39:19 -0500
Message-ID: <20261111173856.3609238-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062314-failed-5.10-efadda401c5c@kernel.org>
References: <20261107062314-failed-5.10-efadda401c5c@kernel.org>
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
[ sashal: adapted unified outbound iATU programming to separate viewport and unrolled paths with a numeric version check only in the viewport path ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 7 +++++--
 drivers/pci/controller/dwc/pcie-designware.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 28945351da14f..27e4020ef1774 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -248,7 +248,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
 				 type | PCIE_ATU_FUNC_NUM(func_no));
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
-				 PCIE_ATU_ENABLE);
+				 PCIE_ATU_ENABLE | PCIE_ATU_DMA_BYPASS);
 
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
@@ -294,7 +294,10 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 			   upper_32_bits(pci_addr));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
 			   PCIE_ATU_FUNC_NUM(func_no));
-	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
+	val = PCIE_ATU_ENABLE;
+	if (pci->version >= 0x460A)
+		val |= PCIE_ATU_DMA_BYPASS;
+	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, val);
 
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 2dfeec79c6718..9766032dac942 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -92,6 +92,7 @@
 #define PCIE_ATU_CR2			0x908
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
+#define PCIE_ATU_DMA_BYPASS		BIT(27)
 #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
 #define PCIE_ATU_LOWER_BASE		0x90C
 #define PCIE_ATU_UPPER_BASE		0x910
-- 
2.53.0

