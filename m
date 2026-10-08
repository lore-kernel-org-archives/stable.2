Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A939C3B05A5;
	Thu,  8 Oct 2026 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481015; cv=none; b=uhlQFo09DSMfwvSkrCTpWsRqh6yEMCv+EGfa+HZ1rDltYWP+6N6H8D4nBUcVp3FyRyN5SWuaHwICKe8aw5NAAj1Gh9vgueUou+kS2oNWoe+cK/4GyQaZQng1IOt3JLvLc1uSqFzVY/FInV/1JwrHlQNvSYpgnvu0bkaV4uNIvfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481015; c=relaxed/simple;
	bh=sGqOuJm8L0+gaTCh+pWJA5AoQg2y8B1Erk81m7k/dbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0lH7XWdDXKV24kcG4cUcM3aK1KTbwpRa0eyvUGBoHiL8RR+GBV4p/+ZwnbLnPhXPb+I+X2YpV0k9V84GDkVy/GTiJ6QjC2jLgV8I0HKiO1lH0OeCDg33D+a4fpnpYxKt2ZDNsqdO4iOJxcfgy1lRYmfGZUJaMcafQOA6mRIY/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ku5IO7c5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ku5IO7c5"
Received: from jeffbarnes-ThinkPad-P14s-Gen-2i.corp.microsoft.com (unknown [52.167.112.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3B66420B7166;
	Thu,  8 Oct 2026 10:35:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B66420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791480956;
	bh=A8RQx+fik1nAgLPhUlMGBh2lF8JrPl+XwdH5+V2+NII=;
	h=From:To:Cc:Subject:Date:From;
	b=Ku5IO7c54PeOmd/+DKb1ICtuJh3p36JqBkyT91r4A94vfZ5nxZXplA49YaornScpC
	 QH/cjtd8hyocTZg/651FgqckDZUOWqIP/R9FARHGJcO9j7iv9UAUo8c1ZEmquKbvx3
	 k02kl2+G7Bcu+TuKDZEM2SGVPuB9tayCbCrlNhd0=
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: linux-pci@vger.kernel.org
Cc: minghuan.Lian@nxp.com,
	mingkai.hu@nxp.com,
	roy.zang@nxp.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	Zhiqiang.Hou@nxp.com,
	easwar.hariharan@linux.microsoft.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] Revert "PCI: layerscape: Change default error response behavior"
Date: Thu,  8 Oct 2026 13:36:41 -0400
Message-ID: <20261008173641.199142-1-jeffbarnes@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 84d897d69938
("PCI: layerscape: Change default error response behavior").

The Layerscape PCIe driver programs the DesignWare
AMBA_ERROR_RESPONSE_DEFAULT register at offset 0x8d0 with 0x9401.

For AXI, the documented default with AMBA_ERROR_RESPONSE_GLOBAL cleared
returns OKAY with all-ones data for errors on non-posted requests.
Setting AMBA_ERROR_RESPONSE_GLOBAL causes an AXI error response instead,
with AMBA_ERROR_RESPONSE_MAP selecting SLVERR or DECERR for individual
PCIe completion errors.

The value 0x9401 sets AMBA_ERROR_RESPONSE_GLOBAL and maps Unsupported
Request, Completer Abort, and Completion Timeout to SLVERR.

A PCI configuration access can race with the link going down after
dw_pcie_other_conf_map_bus() checks the link but before
pci_generic_config_read() performs the MMIO access. If the transaction
results in a Completion Timeout, the Layerscape error response setting
propagates it to AXI as SLVERR, resulting in an asynchronous SError and
kernel panic.

For example:

Kernel panic - not syncing: Asynchronous SError Interrupt
...
Call trace:
arm64_serror_panic+0x78/0x90
do_serror+0x84/0x90
el1h_64_error_handler+0x30/0x40
el1h_64_error+0x68/0x70
pci_generic_config_read+0x64/0xb0
dw_pcie_rd_other_conf+0x1c/0x68
pci_bus_read_config_word+0x68/0x118
pcie_capability_read_word+0xa8/0xd8
find_device_iter+0x8c/0x160
pci_walk_bus+0x60/0xb8
find_source_device+0x78/0xb0
aer_isr+0x1dc/0x230

Reproduce the race by obtaining the configuration-space mapping while
the link is up, then disabling the link from another CPU immediately
before performing the MMIO configuration read.

With the error response override enabled, the overlapping configuration
read results in an asynchronous SError and kernel panic. With the
DesignWare default behavior restored, the same test returns 0xffffffff.
AER reports a non-fatal Completion Timeout, and no SError or kernel
panic occurs.

Restore the documented DesignWare default error response behavior so a
failed non-posted PCIe transaction does not become a fatal AXI error.

Fixes: 84d897d69938 ("PCI: layerscape: Change default error response behavior")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Signed-off-by: Jeff Barnes <jeffbarnes@linux.microsoft.com>
---
Changes in v3:
- Restore the kernel panic backtrace from v1, as requested by Easwar
 Hariharan.

Changes in v2:
- Change the subject to identify this as a revert, as requested by
 Frank Li.
- Document the DesignWare AMBA_ERROR_RESPONSE_DEFAULT behavior and
 decode the 0x9401 setting used by Layerscape.
- Clarify that the setting propagates Completion Timeout as AXI SLVERR
 rather than causing the underlying PCIe transaction failure.

 drivers/pci/controller/dwc/pci-layerscape.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 14d6ac4fc53f..d333f1ae8a41 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -28,8 +28,6 @@
 
 /* PEX Internal Configuration Registers */
 #define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
-#define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
-#define PCIE_ABSERR_SETTING	0x9401 /* Forward error of non-posted request */
 
 /* PF Message Command Register */
 #define LS_PCIE_PF_MCR		0x2c
@@ -103,14 +101,6 @@ static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
 	iowrite32(val, pci->dbi_base + PCIE_STRFMR1);
 }
 
-/* Forward error response of outbound non-posted requests */
-static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
-{
-	struct dw_pcie *pci = pcie->pci;
-
-	iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
-}
-
 static u32 ls_pcie_pf_lut_readl(struct ls_pcie *pcie, u32 off)
 {
 	if (pcie->big_endian)
@@ -180,8 +170,6 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct ls_pcie *pcie = to_ls_pcie(pci);
 
-	ls_pcie_fix_error_response(pcie);
-
 	dw_pcie_dbi_ro_wr_en(pci);
 	ls_pcie_clear_multifunction(pcie);
 	dw_pcie_dbi_ro_wr_dis(pci);
-- 
2.43.0

