Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C157A5505C1
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089963; cv=none; b=BZ+9fJ7HEHt2yycJp+9jLhE240MNABali1UsKDYUb62XMHBziCwwcgjZOSDrHRxmWXj+ivgxCrSl42NGt81KzyykdkTbZEFuGHBzOM+3ra/hjo1lt6HoZHOP5BgJ746niqX/pJAQvL+ZtQ6rUdPuElXpQNGc7vKYhL29/CWHDIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089963; c=relaxed/simple;
	bh=OLxo9VF1iVzdR6QQpWTasReolFGd4cLTcCRKBM61PZ0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uQtNWtFiwCuou+7j0DgGumLopyg2HGzLHKJn6uG3woz1+PlOy22X8Ws9jNIQR8n6ladk/6hVDcXFIYbtNPMHRbIs5s3PnRcRpRKQVH0Qebg71ihz3Urkoeu7YdA8+QamrU3HkAiTESc3TXS1zIxYfTT1dQancdjF4je/muxH6uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ScE3NQvu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ScE3NQvu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DB11F000FF;
	Tue, 22 Sep 2026 15:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790089961;
	bh=F46tBlamG5J9ZWIZSmCcSWUNIFyenatbgU8JkfwqCHM=;
	h=Subject:To:Cc:From:Date;
	b=ScE3NQvul1mssBM+VrGluGZBb2++RPWb1+yE1T4hjNPSIs0gyOJo7jFz4F9GyGMPT
	 P8FEzilTSdghduh1Qzer7sF9I3+fTpai0WEFcHE93eZ+75l3ON7hKpxVLyhIFgl+rp
	 rGHRPlaihdVKzBE33HDfT1C0uh9vxPAy7H8/D0vE=
Subject: FAILED: patch "[PATCH] drm/amdgpu: fix rmmio iounmap skipped on device removal" failed to apply to 6.6-stable tree
To: Chengjun.Yao@amd.com,alexander.deucher@amd.com,asad.kamal@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 17:03:42 +0200
Message-ID: <2026092242-mantis-dragonfly-bdca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5155002b03b24ba3ef91c5c313b8cf0171b24904
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092242-mantis-dragonfly-bdca@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5155002b03b24ba3ef91c5c313b8cf0171b24904 Mon Sep 17 00:00:00 2001
From: Chengjun Yao <Chengjun.Yao@amd.com>
Date: Tue, 8 Sep 2026 10:15:43 +0800
Subject: [PATCH] drm/amdgpu: fix rmmio iounmap skipped on device removal

amdgpu_pci_remove() calls drm_dev_unplug() before fini_sw(), so
drm_dev_enter() is already false there and the iounmap() guarded by it
is skipped. This .remove path runs on both hot-unplug and plain rmmod,
so the register BAR ioremap mapping leaks one instance per unload.

Unmap rmmio unconditionally (guard only on non-NULL) and drop the now
unused idx.

Fixes: 62d5f9f7110a ("drm/amdgpu: Unmap MMIO mappings when device is not unplugged")
Signed-off-by: Chengjun Yao <Chengjun.Yao@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit dd6f86a97260e5207d3329ad03aa89fdad61b1e6)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 933804349dbf..9269e780feb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4335,7 +4335,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 {
-	int i, idx;
+	int i;
 	bool px;
 
 	amdgpu_device_ip_fini(adev);
@@ -4377,11 +4377,9 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_unregister(adev->pdev);
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-
+	if (adev->rmmio) {
 		iounmap(adev->rmmio);
 		adev->rmmio = NULL;
-		drm_dev_exit(idx);
 	}
 
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))

