Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5E63502A6
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036167; cv=none; b=q0VRrRtD29H1f5NDin5Bq9n9o+b70PKmkh2fS4IJ/GectCroSe+Fj+CvH1NoGNAGz6PDJQZRmDZjZXqwtiLNirBugzfZWhh43//E8IbQcRcd2E7qM8unYfK/YO6v6eIsTohssty9oS917sdDlrBX37T5Lm/XVadsYAtKFqoJ/bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036167; c=relaxed/simple;
	bh=gmGsknYpjggyVcUxjH5vM4r2+SvlA0rJxmQ1FnG/JdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnkZr/4b5+g8tuKswgz6if/0m60dSZmXEmQPAuU0RdM3mkLFSOmFbATHnsfksfXKq6IvHSmYGNVnaFODRAurvL7eKbuNnsNxG6Z+W2uTxC2mNPU7ol6ZpbtiZj8DOeD0nk/CZzJkA942zrz06JFZn81D0lGMg895sm8L+2GMRyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7vRisRD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7vRisRD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D47D1F000E9;
	Tue, 14 Jul 2026 13:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784036165;
	bh=grriAsXiJxT5DD9hlL3W0jcmxJwhqS2rkEQ7ubHwLUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W7vRisRD+d9izb6xeMhhEbHV5y0GFl8mdHszLm1lfk8OkT13McNVFbeIZiF0irULA
	 ZmrJnA5gBCFvfx0Sczcv5YtUe1FU9Ju7sU7bdJvtu3W38OKINQe7Bc5GTsCkSp8yCn
	 y1CLpVL3NDrUA/B87fwDIKerxyuiBbYKkam0+PTFOlT0PCHNcnUbj24pOHG+2wR0th
	 NMEY086WjdiIt9rerGtpw2C2mN8Nlbrj7xaVXBujbsvobrAC1//AEqfm4zvw/bSYiE
	 J6sHo+MLigyIXroUkGpyvGbUrgscoQgNB+wyh52RX6nFhBViGJhAz2EIGizO1Hy442
	 9gDSXZAKUmQQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] vfio/pci: Release the VGA arbiter client on register_device() failure
Date: Tue, 14 Jul 2026 09:36:03 -0400
Message-ID: <20260714133603.2673230-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071318-parasail-contents-0b7a@gregkh>
References: <2026071318-parasail-contents-0b7a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Williamson <alex.williamson@nvidia.com>

[ Upstream commit daedde7f024ecf88bc8e832ed40cf2c795f0796a ]

The re-order in the Fixes commit below displaced vfio_pci_vga_init() as
the last failure point of what is now vfio_pci_core_register_device()
without introducing an unwind for the VGA arbiter registration.

In current kernels this is mostly benign because vfio_pci_set_decode()
only uses pci_dev state, but the original failure path could leave a
callback with a freed vdev cookie.  The stale registration also becomes
unsafe again once the callback follows drvdata to the vfio device.

Add the required VGA unwind callout.

Fixes: 4aeec3984ddc ("vfio/pci: Re-order vfio_pci_probe()")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20260615191241.688297-3-alex.williamson@nvidia.com
Signed-off-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/vfio_pci_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index ea4e75be1884f2..2da7067d5c34ab 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1899,6 +1899,7 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 out_power:
 	if (!disable_idle_d3)
 		vfio_pci_set_power_state(vdev, PCI_D0);
+	vfio_pci_vga_uninit(vdev);
 out_vf:
 	vfio_pci_vf_uninit(vdev);
 out_group_put:
-- 
2.53.0

