Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240A742253A
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948769; cv=none; b=VTKG3Jpt1AHU6W08c//I+Mt4RRPvwQYm9QDMSFt5H+yfPToNQzTX6pEGhm0YP/eXyCCiPJyYOhaC1X2CdSmRllqqnlO6UV4K9mfBD0NpaTN/W7FaqLQ9aaY73UtAQCUh7huaVU8OdlCXNyg3CLVVenZZ/+q2VT8X5JK+CY/U0hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948769; c=relaxed/simple;
	bh=EYzqX3YShRZ7iHNIkWx+CePCPNSDcD5Eju9trXOmukE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=g+mzf8+9rNXgv02vSK7gx7OJXN2XZqvPN0HQCLVZxukpgs45C/5E+ayzDUq0mp9fHFhuZ90AFiJ/kTzVDdgpmPiHWRyCxrb10TuvLAv+Gm7UTeyImbMPE4AdkuqDztkgFPSAtgSV5186+m0aOVwy1JC4B1RRbqq2CmMSCWPsDqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m+z4Pjtk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m+z4Pjtk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891751F000E9;
	Mon, 13 Jul 2026 13:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783948768;
	bh=ltqI6qOOEBExQ0RQzmRwLXudrVUPPhzSq9lRlLAYow4=;
	h=Subject:To:Cc:From:Date;
	b=m+z4PjtkWG7mVGg0E/hP+UGk8Danmz7CBK3bBOqUQdtbW6qDzSuDW7UtIzjL1z2kg
	 8EYTOgcUU7/T6YvV8vANc7TxXyPF/TzYm7/uFBG9fXPZLx9yEXa0YbXiPfY7h0r6cA
	 g9XDX4EK1Drt3SSysRscUMEJTUseCjlthecWJ/yI=
Subject: FAILED: patch "[PATCH] vfio/pci: Release the VGA arbiter client on register_device()" failed to apply to 5.15-stable tree
To: alex.williamson@nvidia.com,alex@shazbot.org,kevin.tian@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:06:18 +0200
Message-ID: <2026071318-parasail-contents-0b7a@gregkh>
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
git cherry-pick -x daedde7f024ecf88bc8e832ed40cf2c795f0796a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071318-parasail-contents-0b7a@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From daedde7f024ecf88bc8e832ed40cf2c795f0796a Mon Sep 17 00:00:00 2001
From: Alex Williamson <alex.williamson@nvidia.com>
Date: Mon, 15 Jun 2026 13:12:30 -0600
Subject: [PATCH] vfio/pci: Release the VGA arbiter client on register_device()
 failure

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

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index f8d1755de2ce..dab82c078580 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2254,6 +2254,7 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 		pm_runtime_get_noresume(dev);
 
 	pm_runtime_forbid(dev);
+	vfio_pci_vga_uninit(vdev);
 out_vf:
 	vfio_pci_vf_uninit(vdev);
 	return ret;

