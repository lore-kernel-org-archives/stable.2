Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97D5421EED
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948771; cv=none; b=fqv06qerqwH/jzVz9GT7MCXyTBmGAToMtJLadnL3eJeAzKe0qIYmwz6xQvWelf4xrXA+gUpZF/wBAWZN6Juj6O6Wxg34MFO5gXOT+IVORhNcZ0H5/fD1IClzpkXqjWN8RV+BO0GT72M+CZ3mPrFk3UMULfIoGpMzBHGCcGAr570=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948771; c=relaxed/simple;
	bh=eJVnFsIPP6blew/D513pDfINr0Sfjy8ufMWViYH6bE8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SenTgL2ysLvwTjcWVg2fOB01UdLVFzJJHE9xc2k1KtPhBPZ2MelBkup7DcTXkbBxe0gz7us3jq0VDgYYNfw5B6yktkHvfhciZO6dqtVmUEcumcLu+qhDmFTPlAFFJ0XkM1EFOF5P04RRuRrAy74CWf2Iu67JONnOxYxqbiParxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1v1+5jPn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1v1+5jPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5DB1F00A3A;
	Mon, 13 Jul 2026 13:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783948770;
	bh=6duZNTXyp5lYtakL6pB6ojqAqFsj44IgUOM+kfTJrZE=;
	h=Subject:To:Cc:From:Date;
	b=1v1+5jPnfGlwLLJc9838GZj6l43Ba2B9XyrW9RdqUlxIdCpchBKlfQOnQobQfveOt
	 +YFKcxwNVdesLLPllMRMZxyP0uvg04tvbVp7GAmU2THSGz46nfEHOWkcui0RJo7e16
	 V1tj5hA4iHUCQeUy65yqyOuC4bsVvWXDRBi8hy6Y=
Subject: FAILED: patch "[PATCH] vfio/pci: Release the VGA arbiter client on register_device()" failed to apply to 5.10-stable tree
To: alex.williamson@nvidia.com,alex@shazbot.org,kevin.tian@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:06:29 +0200
Message-ID: <2026071329-outbid-dividing-1c8d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x daedde7f024ecf88bc8e832ed40cf2c795f0796a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071329-outbid-dividing-1c8d@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

