Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA6A24EA90
	for <stable@vger.kernel.org>; Sat, 30 May 2026 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780151878; cv=none; b=RAUgWqzU6BS+BEPocOxAyo6Ka+eG0qtnMmTZeHyikrlgj6aXiC4+sKrXA/60JjZR+CV/yeDArQq6pZtRyiCOoUYjRjSoEkUtKuy2GdzDxYkYDcI6rJKgiwyygyRbj+hcQDmy+iB/CqOhtUp1RDBoYPMFocNFCuaDwHtApu1hemw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780151878; c=relaxed/simple;
	bh=tGOuAEbPM5VjKncF7bRFADEH0U3+mRn/9r9CaQvX3AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndphp8PutrjlFPbYvrlKQhMybx9QEl1z7DdG2St+sMKTv9nVwsfiRQrNn3aiAbtNi4Y9+jiQ9l8BaejQpSZaFIE1BqtlOdFl74V0GIxvZxKL24oRkjr0raVTPgBsVjNDSaN7A3fS71pgAnhknRkAMSSkWtlb15HvwTM7+mX6CDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4zHTy7D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4zHTy7D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2781F00893;
	Sat, 30 May 2026 14:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780151877;
	bh=5StsogrSqWrcalsbV75MEJvfvq6t+8GKMDTXp1jfdlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M4zHTy7DXebLzRN1NaOOmC0CaoSS7pGPhTZ2VMi9nBvwi+G9eVPWKSKsAJT5VG0ky
	 2UIyNGcgBLM3vcEl3isB1WNq0Y4beKodCa4owf8Li1BHg59k1/XAgRuxmKLOAsYcbJ
	 IGlyCJSTK//KTN6EpPC821gIblJ3/3ZwEYgORICcgj5QGmeZK9ms1Rzw7fE5fJLQfE
	 2+EkyjtxL32AW1mJEnbO8SgdDyIQzm6oZXN6r8OFZaipsQbCtNzP5w5zsu7JnPr2DZ
	 +yRlQwoC9e7Xyx3NiOrkZPDXHw0RUoAkowoLEU4C6ozUnRyE7q3nIyxIzgWY80N476
	 IGBBliOXguEGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] platform/x86/intel/vsec: Fix enable_cnt imbalance on PCIe error recovery
Date: Sat, 30 May 2026 10:37:55 -0400
Message-ID: <20260530143755.2478131-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052830-recital-jaws-341f@gregkh>
References: <2026052830-recital-jaws-341f@gregkh>
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
 drivers/platform/x86/intel/vsec.c | 34 ++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 666ed3698afe7..66f5637c45f7d 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -358,20 +358,10 @@ static bool intel_vsec_walk_vsec(struct pci_dev *pdev,
 	return have_devices;
 }
 
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
@@ -389,6 +379,23 @@ static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id
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
@@ -492,10 +499,9 @@ static pci_ers_result_t intel_vsec_pci_slot_reset(struct pci_dev *pdev)
 		devm_release_action(&pdev->dev, intel_vsec_remove_aux,
 				    &intel_vsec_dev->auxdev);
 	}
-	pci_disable_device(pdev);
 	pci_restore_state(pdev);
 	pci_dev_id = pci_match_id(intel_vsec_pci_ids, pdev);
-	intel_vsec_pci_probe(pdev, pci_dev_id);
+	intel_vsec_pci_init(pdev, (struct intel_vsec_platform_info *)pci_dev_id->driver_data);
 
 out:
 	return status;
-- 
2.53.0

