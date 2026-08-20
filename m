Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C43435518
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225964; cv=none; b=XJscVgMCSHb6optmTQW5w7J/wHEw57qUw9zlvINmyVCbTdGBOe9Sgi0AeljJ2YCWac+zJxck8LwJPLvrTs9SxBoDQPA84EqA9jRK2svxx7f8a9hk+W/XKw64HxxyeUoquU/yrZNmZ6M9wy3xZB4WOF1Is1TQxOXOeUsPKxhUdbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225964; c=relaxed/simple;
	bh=A313AfdQq0bBxQ2HfCyVFig4dFCHmASTslJ8QEccz4s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qHFRWB/gaO49lFZuzS9bUXljFO4yD8mGUo4sp2abfi89zpBQXylAEjoxYBtfJ54Fci73yC+zX8+i0/6j13CBuhHtppe1BNfpPAceiKfYlULv9IFt3Y9glXqE8epD2GbDhwMp7o8Qy7q3TnWK8KZxBHw4HLNl7QaUcZ5ffbmh/hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YAL6jQgp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YAL6jQgp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023B61F000E9;
	Thu, 20 Aug 2026 11:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787225963;
	bh=0C8w5qo90tMo+TiLZqxXtIPM7hyxYmEwrzZjIgV1PSw=;
	h=Subject:To:Cc:From:Date;
	b=YAL6jQgpOhhP/Wk0928WI6uPJ1XVQX0yJFUgQybF10QPsve/HrK6SppeSiL2XEmoq
	 maSGWh4mkF7wMUtVfQpnEKLMtpGuxcyMAGXk/1jAFTp2Er8D4NxqotOnTzW+BKYrqF
	 JSf9rx9UaNshCxrKf2zJ7wM/c4yHbFN7Gp+ZaVQY=
Subject: FAILED: patch "[PATCH] drm/amdgpu: check ASPM on the dGPU host link" failed to apply to 5.15-stable tree
To: kevinyang.wang@amd.com,Hawking.Zhang@amd.com,alexander.deucher@amd.com,kenneth.feng@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:26:30 +0200
Message-ID: <2026082030-dollar-spoon-c264@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2a9c5154a5650c09ad44ff5e1dff74754e15a3c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082030-dollar-spoon-c264@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2a9c5154a5650c09ad44ff5e1dff74754e15a3c6 Mon Sep 17 00:00:00 2001
From: Yang Wang <kevinyang.wang@amd.com>
Date: Wed, 5 Aug 2026 20:39:18 +0800
Subject: [PATCH] drm/amdgpu: check ASPM on the dGPU host link

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

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bff3e06a756c..16049bfb627b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1370,6 +1370,31 @@ static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
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
@@ -1382,6 +1407,9 @@ static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
  */
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 {
+	struct pci_dev *aspm_pdev, *parent;
+	bool enabled;
+
 	switch (amdgpu_aspm) {
 	case -1:
 		break;
@@ -1396,7 +1424,27 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 		return false;
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

