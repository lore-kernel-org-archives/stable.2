Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E6C34104B
	for <stable@vger.kernel.org>; Sat, 30 May 2026 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160616; cv=none; b=I6caSFfheXhANXmV2HIYpHgByeNjw8GUiqtxpjjNgIjzPYjSe/WilrF9aJyTrAo9pU9Owl3OkeJbLSuMPgkVjErCdg3jX+ph8yuPg/bTC5MlEBhxp1aha1QsUiH3v8DBSadsexompwrphNaRh+rmDyP+zB9DwoJ73nxP1r2D5U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160616; c=relaxed/simple;
	bh=3LaLoG+7csQw/g+pdGHmsePcni9TzVTDEQ8cSYsOu9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTgWWgh6CSL//GsMXlCiNwwnKhhWK60AAUeJCPkzgbV8jYLv9Datafyur9CAh5R4DaL7ZEGGUAWeZEdkcYDSA+RqMC0/kJ7IOp8SsIN6xaTv0mAWz2W+je4DP7CAfuTRC5sbooWh/rLONegWApKd3+dyODqn/lwz06bRpJKcirE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGi4ulZH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGi4ulZH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9021F0089B;
	Sat, 30 May 2026 17:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780160615;
	bh=b/6w5iAr5kmKOR+64BXmuiZx8udXHzP54yt6Jn8QsGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GGi4ulZHe38riiuL42A25K3JG8YMT4uDaH9dhgo9PN/Kc6d7PMeXli7cIVL4qdeiv
	 FCd9xgO3hNUPyoVDloyjUjTSv1rUvaxO2P5B3/w25V5dV0Jb2ptzJMQloXDkkzjDek
	 r3ixwiL7NW5HU7C9HfRfBBOnLmOzk/WlbjN7Ephaovcm9PGtzEsu0TxPWttYFZXQ5Q
	 Dr32IM9ramlreoKjONhzwLMvZqIKmHt+1TSE1JyGPzhmgRYO/Vd5HP5sqP1RgQvq41
	 FxL3A5nZN8bXn1qy7i+uCEFzSxcfPx3WuO8kbd17CGSI9AeOEIJ9xxIdDNYaS+cPuY
	 aDZ/OQ0ncwMuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David E. Box" <david.e.box@linux.intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] platform/x86/intel/vsec: Make driver_data info const
Date: Sat, 30 May 2026 13:03:30 -0400
Message-ID: <20260530170331.3037528-3-sashal@kernel.org>
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

[ Upstream commit 9577c74c96f88d807d1ba005adbf5952e7127e55 ]

Treat PCI id->driver_data (intel_vsec_platform_info) as read-only by making
vsec_priv->info a const pointer and updating all function signatures to
accept const intel_vsec_platform_info *.

This improves const-correctness and clarifies that the platform info data
from the driver_data table is not meant to be modified at runtime.

No functional changes intended.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Link: https://patch.msgid.link/20260313015202.3660072-3-david.e.box@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Stable-dep-of: 348ccc754d89 ("platform/x86/intel/vsec: Fix enable_cnt imbalance on PCIe error recovery")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/vsec.c | 16 ++++++++--------
 drivers/platform/x86/intel/vsec.h |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index e31e5db593401..9f537df15d3d4 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -74,7 +74,7 @@ static enum intel_vsec_id intel_vsec_allow_list[] = {
 };
 
 struct vsec_priv {
-	struct intel_vsec_platform_info *info;
+	const struct intel_vsec_platform_info *info;
 };
 
 static const char *intel_vsec_name(enum intel_vsec_id id)
@@ -203,7 +203,7 @@ int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
 EXPORT_SYMBOL_NS_GPL(intel_vsec_add_aux, INTEL_VSEC);
 
 static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *header,
-			      struct intel_vsec_platform_info *info)
+			      const struct intel_vsec_platform_info *info)
 {
 	struct intel_vsec_device *intel_vsec_dev;
 	struct resource *res, *tmp;
@@ -263,7 +263,7 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 }
 
 static bool intel_vsec_walk_header(struct pci_dev *pdev,
-				   struct intel_vsec_platform_info *info)
+				   const struct intel_vsec_platform_info *info)
 {
 	struct intel_vsec_header **header = info->capabilities;
 	bool have_devices = false;
@@ -282,7 +282,7 @@ static bool intel_vsec_walk_header(struct pci_dev *pdev,
 }
 
 static bool intel_vsec_walk_dvsec(struct pci_dev *pdev,
-				  struct intel_vsec_platform_info *info)
+				  const struct intel_vsec_platform_info *info)
 {
 	bool have_devices = false;
 	int pos = 0;
@@ -332,7 +332,7 @@ static bool intel_vsec_walk_dvsec(struct pci_dev *pdev,
 }
 
 static bool intel_vsec_walk_vsec(struct pci_dev *pdev,
-				 struct intel_vsec_platform_info *info)
+				 const struct intel_vsec_platform_info *info)
 {
 	bool have_devices = false;
 	int pos = 0;
@@ -377,7 +377,7 @@ static bool intel_vsec_walk_vsec(struct pci_dev *pdev,
 }
 
 static bool intel_vsec_get_features(struct pci_dev *pdev,
-				    struct intel_vsec_platform_info *info)
+				    const struct intel_vsec_platform_info *info)
 {
 	bool found = false;
 
@@ -403,7 +403,7 @@ static bool intel_vsec_get_features(struct pci_dev *pdev,
 
 static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	struct intel_vsec_platform_info *info;
+	const struct intel_vsec_platform_info *info;
 	struct vsec_priv *priv;
 	int ret;
 
@@ -412,7 +412,7 @@ static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id
 		return ret;
 
 	pci_save_state(pdev);
-	info = (struct intel_vsec_platform_info *)id->driver_data;
+	info = (const struct intel_vsec_platform_info *)id->driver_data;
 	if (!info)
 		return -EINVAL;
 
diff --git a/drivers/platform/x86/intel/vsec.h b/drivers/platform/x86/intel/vsec.h
index 330672588868d..7c807d58ff27c 100644
--- a/drivers/platform/x86/intel/vsec.h
+++ b/drivers/platform/x86/intel/vsec.h
@@ -36,7 +36,7 @@ struct intel_vsec_device {
 	struct pci_dev *pcidev;
 	struct resource *resource;
 	struct ida *ida;
-	struct intel_vsec_platform_info *info;
+	const struct intel_vsec_platform_info *info;
 	int num_resources;
 	int id; /* xa */
 	void *priv_data;
-- 
2.53.0

