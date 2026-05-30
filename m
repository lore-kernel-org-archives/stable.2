Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2460F32B11D
	for <stable@vger.kernel.org>; Sat, 30 May 2026 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160617; cv=none; b=dZSNXEJEtu/xFhUQ3C3iCJ2TN8zQaTM9A/YVuBWyHYggqSmecEZvPHxWogpdqWi2OlYPcv9mJZwZV3KFqseVewNILsxM0q7J3J9Yt5057twJgLo2pW2oYlq03X2Ir8dnNc8mwmUEFHw62Oali0Y2kpsGd5XcUyeOwwXBegveFtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160617; c=relaxed/simple;
	bh=yIJcJ0j3N+BqE7Cl4u8T3BS/p738S4k/VZffFRznK7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbB32YQejBy3OGaZpogGu9dRvAV4pE6Fv6rBPj+Fot1hqvFaNJy+skL3J95i9BQC3cs+DcXuhmSP8mBy/hC1pQzckbb4sW9yWGcMNLNWRCsjRCSoOaykCIk33HNCgrgmNFXQD+B7lNGbxkBuFxkZIwNvjtW87fvVIZ0/ms4lOHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9FxIcQ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9FxIcQ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3941F00898;
	Sat, 30 May 2026 17:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780160616;
	bh=dBF6gXu3ROoC1XCCxjQBnAPi2nQHOf+yd0FMjOxDwPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O9FxIcQ0MQEdtW1j5w/1LnKzixdwukW5LXeft7lV6rd5e7H0DzPvD11KpTc/bkX9H
	 VG8PuIQEKkcS0ZzyIqVl5Q9j6aqqtXuqBUgd7vT8zqXVEc3MHXdXiuqPxPK2MbtDZS
	 7VE51QNpiCaXpaaHNYuwn9d5JBKw6aimbrx2pxBQyQq0LvJ7JXdFTFyp6Ms9c04wuu
	 ofqEjkUfptXGKnzcEDb9vc7hlFSQQ25GtLkK9L0023soC2Ipj8obXGZPWI3sn55VD8
	 Rqf0XvaSDgZR7YNoQabsxWtav2eR5E7o0OkdiVeelbS2SEr9ujbQT9x7U3vtpvjqEw
	 ncoOLuIFX4xpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] platform/x86/intel/vsec: Fix enable_cnt imbalance on PCIe error recovery
Date: Sat, 30 May 2026 13:03:31 -0400
Message-ID: <20260530170331.3037528-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530170331.3037528-1-sashal@kernel.org>
References: <2026052831-compacter-avenue-4d0c@gregkh>
 <20260530170331.3037528-1-sashal@kernel.org>
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
 drivers/platform/x86/intel/vsec.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 9f537df15d3d4..32ef26c4fc9f0 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -401,6 +401,17 @@ static bool intel_vsec_get_features(struct pci_dev *pdev,
 	return found;
 }
 
+static int intel_vsec_pci_init(struct pci_dev *pdev)
+{
+	struct vsec_priv *priv = pci_get_drvdata(pdev);
+	const struct intel_vsec_platform_info *info = priv->info;
+
+	if (!intel_vsec_get_features(pdev, info))
+		return -ENODEV;
+
+	return 0;
+}
+
 static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	const struct intel_vsec_platform_info *info;
@@ -423,10 +434,7 @@ static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id
 	priv->info = info;
 	pci_set_drvdata(pdev, priv);
 
-	if (!intel_vsec_get_features(pdev, info))
-		return -ENODEV;
-
-	return 0;
+	return intel_vsec_pci_init(pdev);
 }
 
 /* TGL info */
@@ -489,7 +497,6 @@ static pci_ers_result_t intel_vsec_pci_slot_reset(struct pci_dev *pdev)
 {
 	struct intel_vsec_device *intel_vsec_dev;
 	pci_ers_result_t status = PCI_ERS_RESULT_DISCONNECT;
-	const struct pci_device_id *pci_dev_id;
 	unsigned long index;
 
 	dev_info(&pdev->dev, "Resetting PCI slot\n");
@@ -510,10 +517,8 @@ static pci_ers_result_t intel_vsec_pci_slot_reset(struct pci_dev *pdev)
 		devm_release_action(&pdev->dev, intel_vsec_remove_aux,
 				    &intel_vsec_dev->auxdev);
 	}
-	pci_disable_device(pdev);
 	pci_restore_state(pdev);
-	pci_dev_id = pci_match_id(intel_vsec_pci_ids, pdev);
-	intel_vsec_pci_probe(pdev, pci_dev_id);
+	intel_vsec_pci_init(pdev);
 
 out:
 	return status;
-- 
2.53.0

