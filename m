Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBFF375F82
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565369; cv=none; b=o+ucRYa8vF2IBWT4UT6V6Ni6WSL1wwOYtVT29P8doY5oLteuiQwxS/fBQr+3AyYaDc+IP30KamP798ZR1LgWp28t5bE4c9cwfB4e1Mf+e7Ngp3Hi2qU0o1hjasAIV8lZb+LcRPP2WdswdFuhH39KYJVJfkbS/HH814QMa8mFCsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565369; c=relaxed/simple;
	bh=LsdE6dymnHPCQFD+TL1ZaB1LoGEF3AP6GTUanmmvuZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUclQ0tsrXEhdu6auxDtw8ajtUyvDhLMine290KhyYcZ7YyCk5n9Ohz1wDsNP53SInUct2+3EgQpmLw+qYq91C3DU6eEwIa1x0ohtyIDRv7xPq25AZmHQfst1yR7Bbm7fh0u5FjKV/cLyEobxSndjs9OzHxcIBm7H1ppDAk+Y+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNT7EuWr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNT7EuWr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A871F00A3A;
	Mon, 24 Aug 2026 09:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787565368;
	bh=g+cc9yWX5i5aqwOojzgfH3vmdnC0S1cNGeKW4qYJu88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XNT7EuWrqOhru6tmWeJugZuKD8V8uOCj/WOZBu5QVnIn+WmBwSOiDb5hxuopKArWQ
	 ilLgMwpFL+STFgPMr5eoY5nOc9GHqG7XfjmNUSGroJC7L6vCzBgEy/GkxH0VZAWEuI
	 RRxaRR30apE6Iie6sDfwfoT3CDqMV/8avXnznM6+zHWo0hq44jyQ4r/GGe5JwBnEn0
	 pm86DAooUyXY/vAMYOrI+JhyvQeQuJgnDMRaYU7m2kwRXgb+X84aHGlYmXTJgX4IxN
	 /gx2rMRC1AZ5j5c0mKm3WvVzg2hr8CAMN3d+AwLVnWTt2EBYhH0xmYdFY0oP8ZfpF1
	 t+bzQr0zpN/VA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Wang <kevinyang.wang@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] drm/amdgpu: check ASPM on the dGPU host link
Date: Mon, 24 Aug 2026 05:56:05 -0400
Message-ID: <20260824095605.4065946-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824095605.4065946-1-sashal@kernel.org>
References: <2026082029-wanted-saddled-c60e@gregkh>
 <20260824095605.4065946-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 50 +++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index eea9b7e348aac..892a40c439637 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1324,6 +1324,31 @@ static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
 #endif
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
@@ -1336,6 +1361,9 @@ static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
  */
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 {
+	struct pci_dev *aspm_pdev, *parent;
+	bool enabled;
+
 	switch (amdgpu_aspm) {
 	case -1:
 		break;
@@ -1348,7 +1376,27 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 	}
 	if (amdgpu_device_aspm_support_quirk(adev))
 		return false;
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
 
 /* if we get transitioned to only one device, take VGA back */
-- 
2.53.0

