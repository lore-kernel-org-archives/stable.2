Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E92B483815;
	Thu,  6 Aug 2026 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031693; cv=none; b=R4nsioe8SoB4poPjrMovUe4v71f6fegVs9tiDkRi5cwxZdctckK0nHup8QJxX36D0KWCU0iqKovEx915y9CuE0YL9HmY0OFuUdXoVGv1mJ46hfqU79OR6swOGx0V/j1NcBzKbb2Wihx0qLC05684/j2s+xZs3IAys0dFYXu3YMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031693; c=relaxed/simple;
	bh=06j2gpu4umBpwkjj8hjl4gpaEcP90LVzzK0kC/1ZFno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7oylwbvBOlo0bOoiT18N+wwKsFj0k02621lCbBqx78M8EKoXLhClYtcqLobe2qza7gvTTMSE78YPCBnEiQ9rbAWQyGUa1J7bSBnHIMCR5FvQP4gtvYvGUGO7KrijmZp94k6QBxPjMlypfcZap0Y8RA+7+YGahXIlLBYCrSp0DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEVOEg7i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEVOEg7i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C231F00A3E;
	Thu,  6 Aug 2026 15:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786031677;
	bh=t/VRxkHHxFbRZakWbYvezpbjDo+InjUdt2X5B1+qbeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FEVOEg7ii+FfpP5fYrZ300x++3ornc0HPKk8r55IkSpZPXMh9MOfgYLV4AW8qJpVM
	 Pc4KgMGFxDbrBIJ0+naWMKJ66wuVbpNaUeNgTT0WvqeSudHYQrnL4z7R1ZpQZeX0LF
	 VgUlgT2iDIo/3DYu4CRJKJs8gbFdCno0/o5SQZyPSvFJUUo3TiHMyUvon/4jwPX+qy
	 xQvPrK+u0pFKc0CZ/R3Mi/4s2JVo2YHgyzThjqTCVHGrVgtLZwrNfhAeAEDKkW2sG9
	 EN/ht+Fr6m/KWZPdJ2Nau5TGbncpgR9IAmNAn+J3QuCDWG7nph1wiZfyJ2I/L0wadH
	 pJzIGktNBBnew==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	rounakdas2025@gmail.com,
	niravkumar.l.rabara@altera.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv2 2/4] EDAC/altera: Drop __init from ECC setup paths for re-probe safety
Date: Thu,  6 Aug 2026 10:54:10 -0500
Message-ID: <20260806155412.1518582-3-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
In-Reply-To: <20260806155412.1518582-1-dinguyen@kernel.org>
References: <20260806155412.1518582-1-dinguyen@kernel.org>
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
Fixes: 788586efd116 ("EDAC/altera: Initialize peripheral FIFOs in probe()")
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
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

