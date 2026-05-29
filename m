Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16EF375AD0
	for <stable@vger.kernel.org>; Fri, 29 May 2026 21:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780090967; cv=none; b=XrtZvc3zNuy8YvBoBNCz1bxOo2pbncUuYpB4fcKCB//kt9+Y9ad+gbji7IF3uo50N+bq+KHlf2KybSVI8CbHtFM2B5BASfc+g1tpmzk9ckwL86DPTLAk9Rrh44yKGmeij4naUYKNQKGkjmhjhz5LDINsZrT6ucjJG7gP2jweqQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780090967; c=relaxed/simple;
	bh=DB3YBQVPi4rdGS2RVUKhhojE8xW6Uy2Rsj3yOID43lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rADcSRHvPjFpGlLW2gh8IIxMcuPXhyn/BMYNoPwolwBHLmigAVkm9SakwUbqteYUyg/oDrT775Y6Cki0B/HzuIksOHkpjJVlfuAldw/RvGujCcOlVBbSayHPw9S80iRviuGbdy4PRHe3tRyGr588Og66+nMJrKKUKPUp9j5929c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PD36wlLM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PD36wlLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B12F1F00893;
	Fri, 29 May 2026 21:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780090966;
	bh=zw/mRc02qM/zxjFAbPtdYq+goxzEgzG6J/j9Z8traa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PD36wlLM1QkcT56vMw18xLxEnk531XWgidJ/0c8OgeQ4vjsWGx8VeAeP8NPMikmP0
	 44FHu29a9fSyZEJTPbpWnD9xEciuFPK9FtVX774OK75XU7OyX3q+EY6XG2qUm6i5Cp
	 OXBfEZ/NNGOKkKVEye/M1eF3J4OvQKtjUiiD5HGc948nnuJsAHyicu4cLfgpwilsti
	 AP7RFjfUIfyo2JEpnqKvizCx+yPl2mx4VpcowbVDRXCIrg50IRXHJEVaFiDVe8Iuk8
	 TrhXP2uPlN0wjjV2T93r0Y9nDladQiJKcThlJnpuKmoUyNcRNtMcT8W4In+l/cN+KD
	 Q6SJ9pfaJ6iMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] platform/x86/intel/vsec: Fix enable_cnt imbalance on PCIe error recovery
Date: Fri, 29 May 2026 17:42:44 -0400
Message-ID: <20260529214244.1795477-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052829-shadiness-viral-ee81@gregkh>
References: <2026052829-shadiness-viral-ee81@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit 348ccc754d8939e21ca5956ff45720b81d6e407f ]

After a PCIe Uncorrectable Error has been reported by a device with
Intel Vendor Specific Extended Capabilities and has been recovered
through a Secondary Bus Reset, its driver calls intel_vsec_pci_probe()
to rescan and reinitialize VSECs.

intel_vsec_pci_probe() invokes pcim_enable_device() and thereby adds
another devm action which calls pcim_disable_device() on driver unbind.

So once the driver unbinds, pcim_disable_device() will be called as many
times as an Uncorrectable Error occurred, plus one.  This will lead to
an enable_cnt imbalance on driver unbind.

Additionally, since commit dc957ab6aa05 ("platform/x86/intel/vsec: Add
private data for per-device data"), a devm_kzalloc() allocation is
leaked on every Uncorrectable Error.

Avoid by splitting the VSEC rescan out of intel_vsec_pci_probe() into a
separate helper and calling that on PCIe error recovery.

Fixes: 936874b77dd0 ("platform/x86/intel/vsec: Add PCI error recovery support to Intel PMT")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org  # v6.0+
Link: https://patch.msgid.link/bd594d09fa866dc51dddc9a447c3b23f9b1402cc.1778736835.git.lukas@wunner.de
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/vsec.c | 36 +++++++++++++++++++------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 55dd2286f3f35..06e9888df4003 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -348,20 +348,10 @@ void intel_vsec_register(struct pci_dev *pdev,
 }
 EXPORT_SYMBOL_NS_GPL(intel_vsec_register, INTEL_VSEC);
 
-static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+static int intel_vsec_pci_init(struct pci_dev *pdev,
+			       struct intel_vsec_platform_info *info)
 {
-	struct intel_vsec_platform_info *info;
 	bool have_devices = false;
-	int ret;
-
-	ret = pcim_enable_device(pdev);
-	if (ret)
-		return ret;
-
-	pci_save_state(pdev);
-	info = (struct intel_vsec_platform_info *)id->driver_data;
-	if (!info)
-		return -EINVAL;
 
 	if (intel_vsec_walk_dvsec(pdev, info))
 		have_devices = true;
@@ -379,6 +369,23 @@ static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id
 	return 0;
 }
 
+static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct intel_vsec_platform_info *info;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	pci_save_state(pdev);
+	info = (struct intel_vsec_platform_info *)id->driver_data;
+	if (!info)
+		return -EINVAL;
+
+	return intel_vsec_pci_init(pdev, info);
+}
+
 /* DG1 info */
 static struct intel_vsec_header dg1_header = {
 	.length = 0x10,
@@ -467,6 +474,7 @@ static pci_ers_result_t intel_vsec_pci_error_detected(struct pci_dev *pdev,
 static pci_ers_result_t intel_vsec_pci_slot_reset(struct pci_dev *pdev)
 {
 	struct intel_vsec_device *intel_vsec_dev;
+	struct intel_vsec_platform_info *info;
 	pci_ers_result_t status = PCI_ERS_RESULT_DISCONNECT;
 	const struct pci_device_id *pci_dev_id;
 	unsigned long index;
@@ -489,10 +497,10 @@ static pci_ers_result_t intel_vsec_pci_slot_reset(struct pci_dev *pdev)
 		devm_release_action(&pdev->dev, intel_vsec_remove_aux,
 				    &intel_vsec_dev->auxdev);
 	}
-	pci_disable_device(pdev);
 	pci_restore_state(pdev);
 	pci_dev_id = pci_match_id(intel_vsec_pci_ids, pdev);
-	intel_vsec_pci_probe(pdev, pci_dev_id);
+	info = (struct intel_vsec_platform_info *)pci_dev_id->driver_data;
+	intel_vsec_pci_init(pdev, info);
 
 out:
 	return status;
-- 
2.53.0

