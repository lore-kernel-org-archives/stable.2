Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52D1397923
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 11:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570524; cv=none; b=K5YgqaqM/J0csWOHhyJJfqB25vIfar7zLZZmgO7pxAQDxtQhvza8G9n1j9jY3COVo8uUNXcaZY7UzpT1u8/+D85bRLqwkTwE48ELNmjZE3jRG58wNQ87cZuheS0Qst3j8vD30jWVW7CMCx2SvOfSSUMVdGKDzNtylbjHdJdqRbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570524; c=relaxed/simple;
	bh=lNoeHQCUHzm0okwiBl+FM1Uu7m/etESKbDynINrk3ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ma5WjnusEDS2QGzSBENJL4DhC1g+Kq9pBBMBkL2aYWbI32u9kyLH1rOhjqCWhfy8tEmDswUZ6h7kHsTP7Kq9AgKnlpHvFSGlS8Hy++ggciQfLkF7qB8hoqAbnvBtPZ+ClvGq+yChHTZnvMUYwqX34TDkBS9zpuFid/tMa/y+8H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAXOcGC8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAXOcGC8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3EC1F00A3A;
	Mon, 24 Aug 2026 11:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787570523;
	bh=zHC3NFdn9Uyyg8HZA0OrfrrwbWyjuBpnBZja2BW/1IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LAXOcGC8HYd03nYzKMyZgen/Y6mrkVBhZPeTeq5/d4t/0/OSXzA3iVUj8TYzfcTFM
	 K/Q04nYomqO9IfUTnBAxYsAlCtSUZSuzJk2WRwJyAXn3C8yA7fapCnO8a+ZQgh2Xtd
	 lyrKxpmidjKrWoWxOuTYUl6mtIYYgy6pM07kXU8vjRaSvS9JUcgKlXJ1NBiXDE+iEO
	 CsIuu5S5mOSHHkFi6oPTAIYi4bB7y5jmx9zcvRKmOya9TAIVJtgNb2Y6XdqtXEU/4i
	 /SYQETydQDgPK6zANkP1T5pxz5HV8Q4wDlvWPmPiIRpUNDrguYCOuVB9btO+fKiqiO
	 eVMmYt970StXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Wang <kevinyang.wang@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amdgpu: check ASPM on the dGPU host link
Date: Mon, 24 Aug 2026 07:21:59 -0400
Message-ID: <20260824112159.414999-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082029-grading-pelvis-81de@gregkh>
References: <2026082029-grading-pelvis-81de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Wang <kevinyang.wang@amd.com>

[ Upstream commit 2a9c5154a5650c09ad44ff5e1dff74754e15a3c6 ]

dGPUs with an internal PCIe switch expose graphics functions below the
switch downstream port. The automatic ASPM check uses the display
endpoint and evaluates the internal link instead of the host link.

Use the switch upstream port for the check and report the selected
link.

Fixes: 0ab5d711ec74 ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per device")
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4e0d6f2876e704fff707b18c40dbd383aea4a1c9)
Cc: stable@vger.kernel.org
[ Dropped the upstream APU and `amdgpu_device_aspm_support_quirk(adev)` context lines, keeping 6.1's old-signature quirk helper untouched. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 50 +++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 45636d3118c48..55d869ea718a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1375,6 +1375,31 @@ bool amdgpu_device_pcie_dynamic_switching_supported(void)
 	return true;
 }
 
+/*
+ * Some dGPUs expose their display endpoint below an internal PCIe switch.
+ * Use the switch upstream port to query the host-facing link.
+ */
+static struct pci_dev *amdgpu_device_get_aspm_pdev(struct amdgpu_device *adev)
+{
+	struct pci_dev *swds, *swus;
+
+	swds = pci_upstream_bridge(adev->pdev);
+	if (!swds ||
+	    (swds->vendor != PCI_VENDOR_ID_ATI &&
+	     swds->vendor != PCI_VENDOR_ID_AMD) ||
+	    pci_pcie_type(swds) != PCI_EXP_TYPE_DOWNSTREAM)
+		return adev->pdev;
+
+	swus = pci_upstream_bridge(swds);
+	if (!swus ||
+	    (swus->vendor != PCI_VENDOR_ID_ATI &&
+	     swus->vendor != PCI_VENDOR_ID_AMD) ||
+	    pci_pcie_type(swus) != PCI_EXP_TYPE_UPSTREAM)
+		return adev->pdev;
+
+	return swus;
+}
+
 /**
  * amdgpu_device_should_use_aspm - check if the device should program ASPM
  *
@@ -1387,6 +1412,9 @@ bool amdgpu_device_pcie_dynamic_switching_supported(void)
  */
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 {
+	struct pci_dev *aspm_pdev, *parent;
+	bool enabled;
+
 	switch (amdgpu_aspm) {
 	case -1:
 		break;
@@ -1397,7 +1425,27 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 	default:
 		return false;
 	}
-	return pcie_aspm_enabled(adev->pdev);
+
+	/*
+	 * pcie_aspm_enabled() checks the link between its argument and
+	 * the immediate upstream bridge. Use SWUS for dGPUs with an
+	 * internal switch so that this is the host-facing link.
+	 */
+	aspm_pdev = amdgpu_device_get_aspm_pdev(adev);
+	parent = pci_upstream_bridge(aspm_pdev);
+	if (!parent) {
+		dev_dbg(adev->dev, "ASPM: no upstream PCIe link for %s\n",
+			pci_name(aspm_pdev));
+		return false;
+	}
+
+	enabled = pcie_aspm_enabled(aspm_pdev);
+	/* Report the exact link used for the automatic ASPM decision. */
+	dev_dbg(adev->dev, "ASPM: link %s <-> %s is %s\n",
+		pci_name(parent), pci_name(aspm_pdev),
+		enabled ? "enabled" : "disabled");
+
+	return enabled;
 }
 
 bool amdgpu_device_aspm_support_quirk(void)
-- 
2.53.0

