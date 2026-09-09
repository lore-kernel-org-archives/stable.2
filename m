Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B30A55D864;
	Wed,  9 Sep 2026 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788959592; cv=none; b=kTtGOYgtUGD+ywrW94eor3CPthUAJtQaO14KRgGN+8+drLiH7nMrbl4fLmfVmEBi2c/0G2UO+m+gps6j9QYbKy6e0JBW1mpwhQyu75PN3g6AnH8ua0u38Zk5lBJb7fB3nTUHoVFC1y7UPZzTsUm3hzwHa0vn5L5SCKSUchgvPTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788959592; c=relaxed/simple;
	bh=wLRsMKY8OEFYi/qpDoXeA9FEh4qReWhoZVAfNrO7wJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxS3AEZ3qO12uBJF6II+193HCABxe7hI9vQkKiOfh6taknCI70TEe3QasKzQ920I+ASw02NMEOk7rjl+HWqhEFNF/RZQKgRP8f8euYowSxPveGbxzbfyGVMIfs25CrlSSfI4iw+lrWjUTLDGWMm6/4cYQyg4+8V6T47crQfYuVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REV+ikR6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REV+ikR6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19DB1F00A3E;
	Wed,  9 Sep 2026 13:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788959591;
	bh=8TPPTfwBtiaYCUK4EzlWzn+yAl6kg3Gs5FBkRSt9/E8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=REV+ikR695iv2Yn/vw+epDqUgyGHmoYlVz0kqEn2itk/fygs3bHLYnJdB3UlJCx1L
	 SEFjW9t/CFKB2i1UBl6VbYJFjQFqTJolkv4XK2NCX8nywN2EEljtwuGnKri3VKnXEI
	 gNIpd+GddSWt8eUTO7J6YvtfyoF1h/TW93IRvu+BORgXLdsB6u41dk9bGzu44Dejcw
	 bcg2iutKc7CMTIDwIiWf35l+3FcecZVizTK6nTwtr+HLQxLWsz3zmMwGBu/zSMVaoN
	 k/p2jff80ToxGHKThbAMV86ysT8JNqvGW/JbqqWhunGIEHr0sDB2yGmKs/G7kSz7ca
	 8Ey2zpQfyjxkw==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	rounakdas2025@gmail.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv4 2/4] EDAC/altera: Drop __init from ECC setup paths for re-probe safety
Date: Wed,  9 Sep 2026 08:12:51 -0500
Message-ID: <20260909131253.2158486-3-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
In-Reply-To: <20260909131253.2158486-1-dinguyen@kernel.org>
References: <20260909131253.2158486-1-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sashiko reports: Does suppressing sysfs unbinding fully prevent the
execution of freed __init memory? If altr_sysmgr_regmap_lookup_by_phandle()
returns -EPROBE_DEFER, the probe is deferred until after __init memory is
freed.

The a10 EDAC .setup callbacks (sdmmc, ethernet, nand, dma, usb, qspi)
and their helpers (altr_init_a10_ecc_device_type,
altr_init_a10_ecc_block) were marked __init. These run from the probe
path, which may execute after init memory is freed -- e.g. a probe
deferred via -EPROBE_DEFER that only succeeds once a late/module
dependency appears, or a manual unbind/rebind. Calling __init code then
dereferences freed memory. Remove __init so these functions remain
valid at runtime.

Assisted-by: Cursor:claude-4.8-opus
Fixes: 788586efd116 ("EDAC/altera: Initialize peripheral FIFOs in probe())
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v4: rebased to edac-urgent
v3: no changes
v2: reworked v1 to include only true sashiko hits
---
 drivers/edac/altera_edac.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index fe501c89dd0dc..d8a3438fb5f44 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -926,7 +926,7 @@ static int __maybe_unused altr_init_memory_port(void __iomem *ioaddr, int port)
 	return ret;
 }
 
-static __init int __maybe_unused
+static int __maybe_unused
 altr_init_a10_ecc_block(struct device_node *np, u32 irq_mask,
 			u32 ecc_ctrl_en_mask, bool dual_port)
 {
@@ -1001,7 +1001,7 @@ altr_init_a10_ecc_block(struct device_node *np, u32 irq_mask,
 
 static int validate_parent_available(struct device_node *np);
 static const struct of_device_id altr_edac_a10_device_of_match[];
-static int __init __maybe_unused altr_init_a10_ecc_device_type(char *compat)
+static int __maybe_unused altr_init_a10_ecc_device_type(char *compat)
 {
 	int irq;
 	struct device_node *child, *np;
@@ -1330,7 +1330,7 @@ static const struct edac_device_prv_data a10_l2ecc_data = {
 
 #ifdef CONFIG_EDAC_ALTERA_ETHERNET
 
-static int __init socfpga_init_ethernet_ecc(struct altr_edac_device_dev *dev)
+static int socfpga_init_ethernet_ecc(struct altr_edac_device_dev *dev)
 {
 	int ret;
 
@@ -1360,7 +1360,7 @@ static const struct edac_device_prv_data a10_enetecc_data = {
 
 #ifdef CONFIG_EDAC_ALTERA_NAND
 
-static int __init socfpga_init_nand_ecc(struct altr_edac_device_dev *device)
+static int socfpga_init_nand_ecc(struct altr_edac_device_dev *device)
 {
 	int ret;
 
@@ -1390,7 +1390,7 @@ static const struct edac_device_prv_data a10_nandecc_data = {
 
 #ifdef CONFIG_EDAC_ALTERA_DMA
 
-static int __init socfpga_init_dma_ecc(struct altr_edac_device_dev *device)
+static int socfpga_init_dma_ecc(struct altr_edac_device_dev *device)
 {
 	int ret;
 
@@ -1420,7 +1420,7 @@ static const struct edac_device_prv_data a10_dmaecc_data = {
 
 #ifdef CONFIG_EDAC_ALTERA_USB
 
-static int __init socfpga_init_usb_ecc(struct altr_edac_device_dev *device)
+static int socfpga_init_usb_ecc(struct altr_edac_device_dev *device)
 {
 	int ret;
 
@@ -1450,7 +1450,7 @@ static const struct edac_device_prv_data a10_usbecc_data = {
 
 #ifdef CONFIG_EDAC_ALTERA_QSPI
 
-static int __init socfpga_init_qspi_ecc(struct altr_edac_device_dev *device)
+static int socfpga_init_qspi_ecc(struct altr_edac_device_dev *device)
 {
 	int ret;
 
@@ -1598,7 +1598,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	return rc;
 }
 
-static int __init socfpga_init_sdmmc_ecc(struct altr_edac_device_dev *device)
+static int socfpga_init_sdmmc_ecc(struct altr_edac_device_dev *device)
 {
 	int rc = -ENODEV;
 	struct device_node *child;
-- 
2.42.0.411.g813d9a9188

