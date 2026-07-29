Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B9397949
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342158; cv=none; b=I7DwOy71cODnDwxTEHffMorj9aFm5G5vOjVsGNoDgRaf6RxmYsPX1EPUqMLIpIGwZHBrNXTb+Tuh0JTswVPWqEcZtpOd62bK8skl4yg5j58epiaaXd9vjn7k3B9H7sFP59m8KYWaLZ43j7u0QYKGsjIvCZzD9xxZbYevqZqj5zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342158; c=relaxed/simple;
	bh=SQzTK6zGNrCXoF3nsVhIivhs1giVLlRZYktKZqpUDxY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GBmzrdrkeelL2shxVEZCbjyDnhgwCwGfjhR/q9+Hhy6Ixs/UtwwHgwc/aCaXNqt5ck/MUQWl1DUwzhzR22B01Fk6U8EVAUOqsNcaRbVlDkg7A6RYRCUXuIftafF3APlWx/mf+ndQHfWo2hmbFsNvMNHrJJPVW8VU0Tf+SmXLRhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nXSsB+Sy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nXSsB+Sy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B40E1F000E9;
	Wed, 29 Jul 2026 16:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785342156;
	bh=M4tjUuwyHH7Of2t/u8wv5QJHrVRltmwM3ObatCQ8qKc=;
	h=Subject:To:Cc:From:Date;
	b=nXSsB+Syk7CYw1JMM3nIVUP7DZ9SJmnu6h1MEu8+0J6lQ3EZC2j5SromGPCxsQbyr
	 y52enh6MsI6K3Yl20vaEwjEc/8cJsl7kLjPcg3EEWO1s+alCQKMMOGxeTSnL+FOGJQ
	 D7HE6jOtx4wMd12sLosK2csppljjy7g0HXf3+P68=
Subject: FAILED: patch "[PATCH] drm/amdgpu: fix aperture mapping leak" failed to apply to 6.1-stable tree
To: asad.kamal@amd.com,alexander.deucher@amd.com,christian.koenig@amd.com,lijo.lazar@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 18:22:23 +0200
Message-ID: <2026072923-squeak-tying-6839@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ea772a440d56b285f4d491affac50ecd41f6b402
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072923-squeak-tying-6839@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ea772a440d56b285f4d491affac50ecd41f6b402 Mon Sep 17 00:00:00 2001
From: Asad Kamal <asad.kamal@amd.com>
Date: Sun, 14 Jun 2026 12:50:28 +0800
Subject: [PATCH] drm/amdgpu: fix aperture mapping leak
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

amdgpu_pci_remove() calls drm_dev_unplug() before invoking the driver
fini routines. This causes drm_dev_enter() in amdgpu_ttm_fini() to
always return false, so iounmap(aper_base_kaddr) never runs on normal
driver unload, leaving an orphaned entry in the x86 PAT interval tree.

On connected_to_cpu hardware, the aperture is mapped write-back (WB) via
ioremap_cache(). On reload, IP discovery calls memremap(..., MEMREMAP_WC)
over the same range. The WC vs WB conflict causes:

  ioremap error for 0x..., requested 0x1, got 0x0
  amdgpu: discovery failed: -2

Fix by switching to devres-managed mappings so cleanup is guaranteed
regardless of drm_dev_enter() state:

- connected_to_cpu path: devm_memremap(MEMREMAP_WB). For
  IORESOURCE_SYSTEM_RAM ranges this takes the try_ram_remap() shortcut,
  returning __va(offset) from the existing kernel direct map. No new
  ioremap VA or PAT entry is created, so there is nothing to orphan.

- dGPU path: devm_ioremap_wc() registers iounmap() as a devres action,
  guaranteeing cleanup at device_del() time.

Also remove iounmap(aper_base_kaddr) from amdgpu_device_unmap_mmio()
since the mapping is now devres-owned.

v2: Remove redundant x86_64 guard (Lijo)

Fixes: 9d0af8b4def0 ("drm/amdgpu: pre-map device buffer as cached for A+A config")
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit d871e99879cb5fd1fa798b006b4888887e63a17a)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 211d30f03d25..8d6502a94306 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4184,8 +4184,6 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
 
 	iounmap(adev->rmmio);
 	adev->rmmio = NULL;
-	if (adev->mman.aper_base_kaddr)
-		iounmap(adev->mman.aper_base_kaddr);
 	adev->mman.aper_base_kaddr = NULL;
 
 	/* Memory manager related */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 16c060badaee..00b5317f77f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2118,18 +2118,23 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	/* Change the size here instead of the init above so only lpfn is affected */
 	amdgpu_ttm_disable_buffer_funcs(adev);
 #ifdef CONFIG_64BIT
-#ifdef CONFIG_X86
-	if (adev->gmc.xgmi.connected_to_cpu)
-		adev->mman.aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
-				adev->gmc.visible_vram_size);
-
-	else if (adev->gmc.is_app_apu)
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		void *kaddr = devm_memremap(adev->dev, adev->gmc.aper_base,
+					    adev->gmc.visible_vram_size,
+					    MEMREMAP_WB);
+		if (IS_ERR(kaddr))
+			return PTR_ERR(kaddr);
+		adev->mman.aper_base_kaddr = (__force void __iomem *)kaddr;
+	} else if (adev->gmc.is_app_apu) {
 		DRM_DEBUG_DRIVER(
 			"No need to ioremap when real vram size is 0\n");
-	else
-#endif
-		adev->mman.aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
-				adev->gmc.visible_vram_size);
+	} else {
+		adev->mman.aper_base_kaddr = devm_ioremap_wc(adev->dev,
+							     adev->gmc.aper_base,
+							     adev->gmc.visible_vram_size);
+		if (!adev->mman.aper_base_kaddr)
+			return -ENOMEM;
+	}
 #endif
 
 	amdgpu_ttm_init_vram_resv_regions(adev);
@@ -2246,8 +2251,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
  */
 void amdgpu_ttm_fini(struct amdgpu_device *adev)
 {
-	int idx;
-
 	if (!adev->mman.initialized)
 		return;
 
@@ -2270,14 +2273,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_FW_VRAM_USAGE);
 	amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_DRV_VRAM_USAGE);
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-
-		if (adev->mman.aper_base_kaddr)
-			iounmap(adev->mman.aper_base_kaddr);
-		adev->mman.aper_base_kaddr = NULL;
-
-		drm_dev_exit(idx);
-	}
+	adev->mman.aper_base_kaddr = NULL;
 
 	if (!adev->gmc.is_app_apu)
 		amdgpu_vram_mgr_fini(adev);

