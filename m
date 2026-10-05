Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AC037F301
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187875; cv=none; b=Auci+mN5xptVIPiREUC/A1vuFCHQKgeUdqXnhhqbWDPgvUAj3qM3H2Eq/SkfXkM41/GYBAlhsgoCgaReiuUl3KwrkOs3aFjfYrjzFjaEhz3i4FI6q7V1lsaCXrcX9d74LhEu1uY2G/CANEsxTtKz2A9jQjW/ZRMYJp19CyunmVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187875; c=relaxed/simple;
	bh=mDwBIqe6SNPZ/uhZR1hTQHNORYkpEvClnFjo2Zc93js=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SxLkuI9iDymikraIaLvEea9C/CmRii2FprTvAxD5Mt1ehNUDUctu41Zyc39dC6GX9QAKmfqdiHsIgL5Y3wWKNR+AlXpdIDLcJYHVhleilw9HPw3JzHboWJhuRCPCJ0tFikn++zrWsfkUNs7YjCH5jDPYcduQRMWErMqFx5lReQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Se+x0VWy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Se+x0VWy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DD71F000FF;
	Mon,  5 Oct 2026 08:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791187874;
	bh=nIXBxWubwCj9cvU9nlP/N68t1ZK/E4VB5XalpPeRw5Y=;
	h=Subject:To:Cc:From:Date;
	b=Se+x0VWys0XAgZupBfFSL21BPGo9upMiWi5aFmfC+UtAakXpUDBBrT7yk4Fsoto/a
	 7P48NL0PtQ/0E7mAGDjxbo0U8UX/ZLrwgo7i9hvAE12H7eFIbdULgxzxupVuEVrGjE
	 wCd4bkeMxZ89mFfnnkVP+OdtIyoL/MB8HuO5lnMA=
Subject: FAILED: patch "[PATCH] drm/amdgpu: skip the noirq suspend reset for a" failed to apply to 6.12-stable tree
To: andersen.theo@gmail.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:11:11 +0200
Message-ID: <2026100511-recital-body-6c65@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x eadb85cca111152bd334b861fb53747ab851d13a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100511-recital-body-6c65@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eadb85cca111152bd334b861fb53747ab851d13a Mon Sep 17 00:00:00 2001
From: Theo Andersen Carton <andersen.theo@gmail.com>
Date: Thu, 17 Sep 2026 21:15:12 +0200
Subject: [PATCH] drm/amdgpu: skip the noirq suspend reset for a
 switcheroo-parked GPU

amdgpu_pmops_suspend_noirq() resets the ASIC unconditionally. When the GPU
has been parked by vga_switcheroo it has neither power nor a PCIe link, so
the reset cannot reach it: pci_set_power_state() reports the device as
inaccessible and amdgpu_asic_reset() returns -EINVAL. A failure there
aborts the entire noirq suspend phase, and with it the system suspend, so
the machine cannot sleep at all while the GPU is switched off.

amdgpu_device_prepare(), amdgpu_device_suspend() and amdgpu_device_resume()
all bail out early on DRM_SWITCH_POWER_OFF. This callback was added later,
for an unrelated reason, and did not inherit the check. nouveau guards
every one of its PM callbacks the same way.

Bail out the same way here. On a single-GPU system switch_power_state is
never DRM_SWITCH_POWER_OFF, so this is a no-op there.

Found on a MacBookPro11,5, where the Radeon is powered down through
apple-gmux so that the internal panel can be driven by the iGPU instead.
Every suspend failed in amdgpu_pmops_suspend_noirq() while the card was
off; with this check a full S3 cycle completes.

Fixes: 9e051720f9d3 ("drm/amdgpu: Ensure HDA function is suspended before ASIC reset")
Signed-off-by: Theo Andersen Carton <andersen.theo@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 539d0558638a6dcc066f1cf592b6b9a52adc8ea4)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5c33c19fd9bc..d9d794a7db96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2664,6 +2664,14 @@ static int amdgpu_pmops_suspend_noirq(struct device *dev)
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	int r;
 
+	/*
+	 * A GPU parked by vga_switcheroo has no power and no PCIe link, so the
+	 * ASIC reset below would fail and abort the whole noirq suspend phase.
+	 * Bail out like amdgpu_device_prepare/suspend/resume() already do.
+	 */
+	if (drm_dev->switch_power_state == DRM_SWITCH_POWER_OFF)
+		return 0;
+
 	if (amdgpu_acpi_should_gpu_reset(adev)) {
 		amdgpu_device_lock_reset_domain(adev->reset_domain);
 		r = amdgpu_asic_reset(adev);

