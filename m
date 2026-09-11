Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBCE7E0E4;
	Fri, 11 Sep 2026 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128400; cv=none; b=aJ+PHHHPEy+hOBMKzEIKOGlarL/IyZM2qUZChBZuoQtXBVkCHR6TJi1VeFTxbG2tX6SQN4d/DdWNsPPdltYtYoMJE6jCp8Y9eYwj+mIsF8pitq18a2VDShW12fqUYdNATxtUNauYrG4Mbls4yM6Vrx7Ml4tCIZpR7+OCozFPMK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128400; c=relaxed/simple;
	bh=0M6DE4Vpn8wYzr52juZIp3gGE0Z9VWQK+lkvcA71kpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daG1Fuxo1BlWk9nE8Fsz7qi8Y5FiYGuvtB+TaJ02Y57odTik1c6HupMsoL6JLbjcF3zMUmEuszyygl6En/BaU0WMEQhYMXYqnvjmvNLtQJwlQw7Z/+vh4V75CiXP8DmZnEARb6lM9en4inG6DDKAjJxUThiiclXiqMxa2ebGOrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V371wl+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V371wl+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9662F1F00899;
	Fri, 11 Sep 2026 12:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789128395;
	bh=cCPYH56FM+XGcXAL9mtAocmMXfUZmjksWUv2xr1J/Lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V371wl+q561M1XGsZsUpduUk0l3X7l+4Ldc8Hjj3njiVLYRL62NVK1xF6DfsNp+GC
	 Ww4e1fJ00SCBlD/b+/ZbfsiTDFu33GHfuloMOj/if2qcjE2P5iUtLvgKfpz9gXeBi2
	 1CiAkvdNRS2FPgUVamcI61EikdLRiu8CfKfbxfaUHpG2T5qH1jQdztCAhaZtJNtLHg
	 VpFmTK/5FfwCIn1Db3LD427OXf1PpHTm/2E0LDjkB1vQvrmYDfEtOpsLeAwdBfsIwC
	 BISeQDyCPrExUZVojJAZwJXcOFFTwsYQK3KAD8xi+8fHwbbkrdOmVoPo7i/qGYdDeD
	 3wSBv6wivIQBQ==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	linux-edac@vger.kernel.org,
	rounakdas2025@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv5 2/4] EDAC/altera: Drop __init from ECC setup paths for re-probe safety
Date: Fri, 11 Sep 2026 07:06:25 -0500
Message-ID: <20260911120627.2634225-3-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
In-Reply-To: <20260911120627.2634225-1-dinguyen@kernel.org>
References: <20260911120627.2634225-1-dinguyen@kernel.org>
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

