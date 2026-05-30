Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910E732B11D
	for <stable@vger.kernel.org>; Sat, 30 May 2026 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160615; cv=none; b=s0Zu+ez355Y4MPmy/BpwG03SqUn2srXVbDb0gKeUJwYFiNJgWXrI5uhS5hf+17ZdpTrqB0qH46N2LZkdhNEAv/wsjiFRvMjryyoU3pjPvHHWhvTMwusOViz/Q6pITYqvmZLUdkDQ8j2fudfHSDJeMr8z7qhKb+ZYL/HGfc+tFlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160615; c=relaxed/simple;
	bh=kFqIJs2V0Wgfk0iGdAJTzzGuu/cRkwKfgqtJ+9afPQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kc3fQE1yoESJ9+0GGMHuF7o70wkA2ttb9wa488/dE+Z+VMDr0UesJyDS2Kfg9m1YHT5gfsdWtqXf9awudh0G9Z5DwNsM/AwlSPxlUA6hGmupxFeiDkY7FcIgo8CI1iZIbVLwYC1mt5fpTLfVtI+D0A9YQXorvfuar5ZMpkzfT5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpmzQ+qB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpmzQ+qB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF32D1F00899;
	Sat, 30 May 2026 17:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780160614;
	bh=vYDr6eJ2H7syDZRVQCiaXT6H8iO7fbAktzkcWg63wnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UpmzQ+qBHQowvqIBlGxVvjOsJE7KuHZOZPIBO8ZCxjb6VXSXulY5By6yxDo48QoVG
	 5Alv9nwu943xvDXMU2VnZuWNc7aPPYLsR8jyaEQkuKtUFGz99vVdrxriOBVlEfwBHu
	 XjGXZppMzHlaPqzQ3NLrnR6OtzAYw8Y7IGqpTD8nTqoiIJctQ/7ma5YFYwSx/IvCzW
	 eCXPgC3tgj8lX2iNjRtydZUe2010STYGRhYzEM0T7P82SZ3q/7Ooi4QJyuaaS/uUU3
	 CN/RAuRKlsZBxOee7cF/Aw0OSUR8n+HkTG1dpaiXquCSswa2xOKprTn2+F4ebVoToY
	 /IU2RZGdJgeFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David E. Box" <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] platform/x86/intel/vsec: Create wrapper to walk PCI config space
Date: Sat, 30 May 2026 13:03:29 -0400
Message-ID: <20260530170331.3037528-2-sashal@kernel.org>
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

From: "David E. Box" <david.e.box@linux.intel.com>

[ Upstream commit b0631f8a5740c55b52d02174cc4c9c84cc7a16a1 ]

Combine three PCI config space walkers — intel_vsec_walk_dvsec(),
intel_vsec_walk_vsec(), and intel_vsec_walk_header() — into a new wrapper
function, intel_vsec_feature_walk().  This refactoring simplifies the probe
logic and lays the groundwork for future patches that will loop over these
calls. No functional changes.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Link: https://lore.kernel.org/r/20250703022832.1302928-4-david.e.box@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Stable-dep-of: 348ccc754d89 ("platform/x86/intel/vsec: Fix enable_cnt imbalance on PCIe error recovery")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/vsec.c | 38 +++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 1a9f8267b0b07..e31e5db593401 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -376,11 +376,35 @@ static bool intel_vsec_walk_vsec(struct pci_dev *pdev,
 	return have_devices;
 }
 
+static bool intel_vsec_get_features(struct pci_dev *pdev,
+				    struct intel_vsec_platform_info *info)
+{
+	bool found = false;
+
+	/*
+	 * Both DVSEC and VSEC capabilities can exist on the same device,
+	 * so both intel_vsec_walk_dvsec() and intel_vsec_walk_vsec() must be
+	 * called independently. Additionally, intel_vsec_walk_header() is
+	 * needed for devices that do not have VSEC/DVSEC but provide the
+	 * information via device_data.
+	 */
+	if (intel_vsec_walk_dvsec(pdev, info))
+		found = true;
+
+	if (intel_vsec_walk_vsec(pdev, info))
+		found = true;
+
+	if (info && (info->quirks & VSEC_QUIRK_NO_DVSEC) &&
+	    intel_vsec_walk_header(pdev, info))
+		found = true;
+
+	return found;
+}
+
 static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct intel_vsec_platform_info *info;
 	struct vsec_priv *priv;
-	bool have_devices = false;
 	int ret;
 
 	ret = pcim_enable_device(pdev);
@@ -399,17 +423,7 @@ static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id
 	priv->info = info;
 	pci_set_drvdata(pdev, priv);
 
-	if (intel_vsec_walk_dvsec(pdev, info))
-		have_devices = true;
-
-	if (intel_vsec_walk_vsec(pdev, info))
-		have_devices = true;
-
-	if (info && (info->quirks & VSEC_QUIRK_NO_DVSEC) &&
-	    intel_vsec_walk_header(pdev, info))
-		have_devices = true;
-
-	if (!have_devices)
+	if (!intel_vsec_get_features(pdev, info))
 		return -ENODEV;
 
 	return 0;
-- 
2.53.0

