Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0D438757B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089955; cv=none; b=VbxILXrh/E0EccHc06erRnd/caPdKrxCakqsNbdORTsOfwTLxZvmJPUaHT2jS9dUks9l2LFN/iYvCH9swCuHeE9OSpwJSW/Q74+t8ZBoUd08xqz+OKQzAt4qA8Mc0Jx8WsWQK74HpPN5PjBYbRDa3IhmkXEYbmymGFKV+JgBjAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089955; c=relaxed/simple;
	bh=oNU7y6TN8zHVkBeRYIgKYFYrV+N8RBpTyW9X+0mzpYw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PNQ249Ur9NGsUDSqtCvmkzhckAz2r/eUqGeyEt1KaQfNshuowkAgqQYPCuF2SwM9z4Z3J7YZ8SZwz/vjIVE8ZtNq6DackIPXyUHm11GOYcP9AEXEg8K/iggT8sQk43ymRLG6Ygi3WPSV+YrDa4f/o/EEp+CY4fss0S1npriyQcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d/Kan0ni; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d/Kan0ni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D561F000FF;
	Tue, 22 Sep 2026 15:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790089953;
	bh=C0O64Zyv2YW25Xs0cgZu91mckC9mn8D5rhOiXuZfay4=;
	h=Subject:To:Cc:From:Date;
	b=d/Kan0nizJeyT51jc/6n/I4hwu08W8gBEC6XahsYhJlYICQBYAR1fAK2q8oEG6ORs
	 ymyldWYBisx1IRHuvYCFEW7RrWblYM2hp9ZjMTJa4jpc7Ou0f5IE9wRap6TKs3m9Jd
	 GYoWrZG5Nq6YpyAM10P5aqPsnKC+eVasW2eBVhNo=
Subject: FAILED: patch "[PATCH] drm/amdgpu: fix rmmio iounmap skipped on device removal" failed to apply to 6.12-stable tree
To: Chengjun.Yao@amd.com,alexander.deucher@amd.com,asad.kamal@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 17:03:41 +0200
Message-ID: <2026092241-jolliness-reputable-efa6@gregkh>
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
git cherry-pick -x 5155002b03b24ba3ef91c5c313b8cf0171b24904
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092241-jolliness-reputable-efa6@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

