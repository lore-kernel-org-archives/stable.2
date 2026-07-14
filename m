Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7018373C0E
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059366; cv=none; b=Lnfa3M0WxEkuNm4FXVh7HyHNd2o5OVeCEGOA0slDvJh0gtygFDjeS0RXQFMfsp29aKRiix0FUINes80xo80Qrb0ucG1uyUKJSe58kt0xBE9ypBxw105iVrGlcsKmPro4orZzGxgpJAQ+RxYmeHTB4tLz152/KJIOIG+NEB5eEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059366; c=relaxed/simple;
	bh=cLRFnHj0shNT8ATnrymX3Xf/MPm95Tn7CeR9jMBZZ24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBxlY6aHXra/YYOg5CgXpSUGRt01Pkn4SsB+jsSv755DoR5O4wOJeB2j/pcbtx3/M+N39QGz/x5aWj7h63/LS86nvkecbvKJBWwdmryCr8Z03pOzomykB0LpDsjWii8Vhxt4iFt+pCvuiPQn6h2cLyMhZp4iZYmLXrDtbZK2s8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYFO3uXm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYFO3uXm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A30C1F00A3A;
	Tue, 14 Jul 2026 20:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059358;
	bh=67gMxIIeeQeYtO9upPVokfGrGv9RiT4S2BWlyVEADQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nYFO3uXmRTfR8YXSa8aUOjwDV+7YIuQEJ5PGBp3AaBUpIXveLY+hbWRJzhPv9q7qA
	 MG5ze6xuA3COSkqRhcXjgZRqbwmMxavqJ18ALQaOwbsN1/MBigQNQDj3+MabCl4jZh
	 ju1SKp5C+LzkrUwDJ2EUfXYLThmgr8TpWsRS/TXX7i8wcOlQsqLr25ONOf1KlVehnE
	 l4CFH3fPFv/47JatBcP7tnmSFkwHFm5pm1qjQ8AiRl1wzi7MUs4LfyI6VIfxJQDGHY
	 j3Bnu3USNTCkalHJlxPSTVISQGHxo2LtfTKWXyVtPOBoEsUe06wTwH3xYvKvMkCtWe
	 MLPY5nInxsucg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/8] PCI/IOV: Adjust ->barsz[] when changing BAR size
Date: Tue, 14 Jul 2026 16:02:29 -0400
Message-ID: <20260714200236.3153778-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071350-unfold-lather-d66a@gregkh>
References: <2026071350-unfold-lather-d66a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 4687b3315a3f76647746f5b7f92684cf1045b085 ]

pci_rebar_set_size() adjusts BAR size for both normal and IOV BARs. The
struct pci_sriov keeps a cached copy of BAR size in ->barsz[] which is not
adjusted by pci_rebar_set_size() but by pci_iov_resource_set_size().
pci_iov_resource_set_size() is called also from
pci_resize_resource_set_size().

The current arrangement is problematic once BAR resize algorithm starts to
roll back changes properly in case of a failure. The normal resource
fitting algorithm rolls back resource size using the struct
pci_dev_resource easily but also calling pci_resize_resource_set_size() or
pci_iov_resource_set_size() to roll back BAR size would be an extra burden,
whereas combining ->barsz[] update with pci_rebar_set_size() naturally
rolls back it when restoring the old BAR size on a different layer of the
BAR resize operation.

Thus, rework pci_rebar_set_size() to also update ->barsz[].

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org> # AVA, AMD GPU
Link: https://patch.msgid.link/20251113162628.5946-3-ilpo.jarvinen@linux.intel.com
Stable-dep-of: ee7471fe968d ("PCI: Skip Resizable BAR restore on read error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/iov.c       | 15 ++++-----------
 drivers/pci/pci.c       |  4 ++++
 drivers/pci/pci.h       |  5 ++---
 drivers/pci/setup-res.c | 10 ++++------
 4 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index c6dc1b44bf602a..1092a31bc39a22 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -158,8 +158,7 @@ resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
 	return dev->sriov->barsz[pci_resource_num_to_vf_bar(resno)];
 }
 
-void pci_iov_resource_set_size(struct pci_dev *dev, int resno,
-			       resource_size_t size)
+void pci_iov_resource_set_size(struct pci_dev *dev, int resno, int size)
 {
 	if (!pci_resource_is_iov(resno)) {
 		pci_warn(dev, "%s is not an IOV resource\n",
@@ -167,7 +166,8 @@ void pci_iov_resource_set_size(struct pci_dev *dev, int resno,
 		return;
 	}
 
-	dev->sriov->barsz[pci_resource_num_to_vf_bar(resno)] = size;
+	resno = pci_resource_num_to_vf_bar(resno);
+	dev->sriov->barsz[resno] = pci_rebar_size_to_bytes(size);
 }
 
 bool pci_iov_is_memory_decoding_enabled(struct pci_dev *dev)
@@ -1339,7 +1339,6 @@ EXPORT_SYMBOL_GPL(pci_sriov_configure_simple);
 int pci_iov_vf_bar_set_size(struct pci_dev *dev, int resno, int size)
 {
 	u32 sizes;
-	int ret;
 
 	if (!pci_resource_is_iov(resno))
 		return -EINVAL;
@@ -1354,13 +1353,7 @@ int pci_iov_vf_bar_set_size(struct pci_dev *dev, int resno, int size)
 	if (!(sizes & BIT(size)))
 		return -EINVAL;
 
-	ret = pci_rebar_set_size(dev, resno, size);
-	if (ret)
-		return ret;
-
-	pci_iov_resource_set_size(dev, resno, pci_rebar_size_to_bytes(size));
-
-	return 0;
+	return pci_rebar_set_size(dev, resno, size);
 }
 EXPORT_SYMBOL_GPL(pci_iov_vf_bar_set_size);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0b6a23405f167a..b161d0560bad1f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3800,6 +3800,10 @@ int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size)
 	ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
 	ctrl |= FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
 	pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
+
+	if (pci_resource_is_iov(bar))
+		pci_iov_resource_set_size(pdev, bar, size);
+
 	return 0;
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5510c103be2d39..549f60d2198648 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -826,8 +826,7 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno);
 resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
 void pci_restore_iov_state(struct pci_dev *dev);
 int pci_iov_bus_range(struct pci_bus *bus);
-void pci_iov_resource_set_size(struct pci_dev *dev, int resno,
-			       resource_size_t size);
+void pci_iov_resource_set_size(struct pci_dev *dev, int resno, int size);
 bool pci_iov_is_memory_decoding_enabled(struct pci_dev *dev);
 static inline u16 pci_iov_vf_rebar_cap(struct pci_dev *dev)
 {
@@ -869,7 +868,7 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
 	return 0;
 }
 static inline void pci_iov_resource_set_size(struct pci_dev *dev, int resno,
-					     resource_size_t size) { }
+					     int size) { }
 static inline bool pci_iov_is_memory_decoding_enabled(struct pci_dev *dev)
 {
 	return false;
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 60da129d714f94..53338eb45f038f 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -452,12 +452,10 @@ static void pci_resize_resource_set_size(struct pci_dev *dev, int resno,
 	resource_size_t res_size = pci_rebar_size_to_bytes(size);
 	struct resource *res = pci_resource_n(dev, resno);
 
-	if (!pci_resource_is_iov(resno)) {
-		resource_set_size(res, res_size);
-	} else {
-		resource_set_size(res, res_size * pci_sriov_get_totalvfs(dev));
-		pci_iov_resource_set_size(dev, resno, res_size);
-	}
+	if (pci_resource_is_iov(resno))
+		res_size *= pci_sriov_get_totalvfs(dev);
+
+	resource_set_size(res, res_size);
 }
 
 int pci_resize_resource(struct pci_dev *dev, int resno, int size)
-- 
2.53.0

