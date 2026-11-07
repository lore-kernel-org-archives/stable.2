Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046290;
	b=ZwRNTa7f66vyPLconWoYO9cSCby9F7pVQGrC8n1thvzKd4YfXOAvhwFdRjN5ODhx+bqw
	 Kmw8vV1mobsmI0FoRwW83LdP31KnIFPz1apVDy9YoQO6PvfTPzqTsrq0XN/Y2sZTi13Jt
	 XXqLfanfTZZfyrbvk+bxZzqgRrTo54mh+u5QBZD5/dvAP0aJkwyOHKrEmkkD0Xu+8b+gE
	 L8WHd7pqKCq1t6LMIrE8CKZIv7OMCHKb6jlqVIokn5Qo3w3wZgYXV2gLueLAdHMvp7E1w
	 LWgMJtxnhe0XGL3z7+9w7l38SkDVO9rPrOImigj+ZvDzFOrmigLQcZSI1cVCll8n0ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046290;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=suoOt8gAMQ2tkUBUV6xOGnSUbXM6mXND7klHxG2xHls=;
	b=ooABWebcwgmvnfDYtL5uxYb5flAECMzFodzRHFcwgqM1y8nrDjqL0Znh5U1vbkqNpRjq
	 EnoTkgC1E/Q58Q6xScVOAsQwZ1ZpBVttOjh+AuQhscUKJxbSPlsv6nFnnVn2n7TR0oHBF
	 D4b32YaWCHvN82ta0xecZDTjymQwVE2drrrsnQrdPOxuljbqChf8kbyIJjbOSzdAjsHrX
	 kpFZoMXLZaU78camE8fSU5k1LkvE+c4nIm9MrsOIAxHGtWEAkXBMP9QCLtFzjJphYyz/Y
	 RhmefzdoV5IuiEwyNFtWuy7YS04MLkLBSt85ysrMIW04glHJg0SVLwI72yre/7wExbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BCCtTkFj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ECE606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BCCtTkFj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2341F1F0089F;
	Sat,  7 Nov 2026 10:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046289;
	bh=suoOt8gAMQ2tkUBUV6xOGnSUbXM6mXND7klHxG2xHls=;
	h=From:To:Cc:Subject:Date;
	b=BCCtTkFjoNoF0dMeSvaLES68mXcuTsbGyABibvj7ZTDRdqz3HfWzhiiYSm+86iV32
	 WqENuNLSLDlWSlWBunXrT0WA+rHzhPwBxkrZcWKKP8atVh1PBe1eAR5MkR3iGh8NWF
	 w26+etYzzAF7FBI6qMXaJOyuC/UxkKgcM6ECVTOhTA/+fiS+Hxagf2BUUdHpRM7Xbw
	 Gn0Lq9N4j13IkoBhtPf8KZjUDTywC/NyCD8YeYlZX2IGI6pvcDbubf9LxsKnVKwmdU
	 4AKKpOK60q7tsuwvles2khQPFI8dEFgeT0z8jeIXKUc83WdSEeyoX6nzfJf4Xmd3qa
	 XgnbW8LjXUXsw==
From: Sasha Levin <sashal@kernel.org>
To: sumit.kumar@oss.qualcomm.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	bhelgaas@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] PCI: dwc: Set DMA_BYPASS bit in outbound IATU CTRL2 register" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:11:28 -0500
Message-ID: <20261107051128-failed-6.18-efadda401c5c@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x efadda401c5c8e2390ba66508eba154dbd0db5a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051128-failed-6.18-efadda401c5c@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From efadda401c5c8e2390ba66508eba154dbd0db5a9 Mon Sep 17 00:00:00 2001
From: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 11:48:22 +0530
Subject: [PATCH] PCI: dwc: Set DMA_BYPASS bit in outbound IATU CTRL2 register

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
index aea474ad803cd..61e9c4e979af6 100644
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




