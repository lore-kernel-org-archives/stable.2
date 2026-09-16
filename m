Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6A651E445
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572449; cv=none; b=az8Ttpb+h++XcMZx76YJAwMOlFZDH11RDvskOZIyupg+TmBRkmz5KI3PbH5FGY+RRtfA3VsJRslrHhOtFbASKKhoAbF+aYB2LLE5R0nfMsP4Tlaeinz1AIzZnui5RF3JvhpVO+OluCQ4XMoLX51Fc8T6/Ch6ZYCm9mD0vpHEo3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572449; c=relaxed/simple;
	bh=yg5wyRdXlO0b4gycOm9xR99od+/mKv3rMJCGzBz4QGM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ATgoARKOoqAMEXRZCSqJU0Hy2qg9yEAY3jmLVq4CLJUA+OIVR2iedhl2mfAL8K3py8SX/XgxtRj4X2EcsH4f9Pl1O+wYJ93rcgDtUMXv0pqlsWzzFSrm0JEbDNjVW4DUtPb4PoU6wpkGJd35HTPflGUVpFQ/DRFUxaVUWiHAsLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s7PZ5HvQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s7PZ5HvQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3691F00893;
	Wed, 16 Sep 2026 15:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789572444;
	bh=YKur+fwnB9OFvhoo09nq1BcFc3NZ0wPmec+a3C7GISw=;
	h=Subject:To:Cc:From:Date;
	b=s7PZ5HvQuEzoM5arau/c9Yz+Netvzlx+h3SrROcsEgjsQ0YRRAKoobJwDpBxQgIQr
	 e51Gv4bFZW4C9p5usMNClQ9K9yphVRfQPc3qGOB9nS0s3EUHokzwDl9SrZgqcELs8Z
	 7BS6/dr10VYfP6NKLMuYknjp3xacV9/fR6GjLSr8=
Subject: FAILED: patch "[PATCH] accel/ivpu: Validate full buffer range in ivpu_to_cpu_addr" failed to apply to 6.6-stable tree
To: magdalena.schulfer@intel.com,dawid.osuchowski@linux.intel.com,karol.wachowski@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:12:46 +0100
Message-ID: <2026091646-nutmeg-dill-a3d1@gregkh>
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
git cherry-pick -x 3837c3f29fbc3b8c12bebf5c62741e2befe3482a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091646-nutmeg-dill-a3d1@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3837c3f29fbc3b8c12bebf5c62741e2befe3482a Mon Sep 17 00:00:00 2001
From: Magdalena Schulfer <magdalena.schulfer@intel.com>
Date: Tue, 1 Sep 2026 14:57:47 +0200
Subject: [PATCH] accel/ivpu: Validate full buffer range in ivpu_to_cpu_addr

Add a size parameter to ivpu_to_cpu_addr() and validate that the
whole [vpu_addr, vpu_addr + size) range stays within the BO.

Cc: stable@vger.kernel.org
Fixes: 647371a6609d ("accel/ivpu: Add GEM buffer object management")
Signed-off-by: Magdalena Schulfer <magdalena.schulfer@intel.com>
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Link: https://patch.msgid.link/20260901125749.404338-2-dawid.osuchowski@linux.intel.com

diff --git a/drivers/accel/ivpu/ivpu_gem.h b/drivers/accel/ivpu/ivpu_gem.h
index 0c3350f22b55..b1ae020a4fc2 100644
--- a/drivers/accel/ivpu/ivpu_gem.h
+++ b/drivers/accel/ivpu/ivpu_gem.h
@@ -87,15 +87,23 @@ static inline bool ivpu_bo_is_resident(struct ivpu_bo *bo)
 	return !!bo->base.pages;
 }
 
-static inline void *ivpu_to_cpu_addr(struct ivpu_bo *bo, u32 vpu_addr)
+static inline void *ivpu_to_cpu_addr(struct ivpu_bo *bo, u64 vpu_addr, u64 size)
 {
+	u64 bo_size = ivpu_bo_size(bo);
+	u64 offset;
+
 	if (vpu_addr < bo->vpu_addr)
 		return NULL;
 
-	if (vpu_addr >= (bo->vpu_addr + ivpu_bo_size(bo)))
+	if (size > bo_size)
 		return NULL;
 
-	return ivpu_bo_vaddr(bo) + (vpu_addr - bo->vpu_addr);
+	offset = vpu_addr - bo->vpu_addr;
+
+	if (offset > bo_size - size)
+		return NULL;
+
+	return ivpu_bo_vaddr(bo) + offset;
 }
 
 static inline u32 cpu_to_vpu_addr(struct ivpu_bo *bo, void *cpu_addr)
diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index 62607ec8ca8f..8e960293b77a 100644
--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -79,7 +79,7 @@ ivpu_ipc_tx_prepare(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
 		return -ENOMEM;
 	}
 
-	tx_buf = ivpu_to_cpu_addr(ipc->mem_tx, tx_buf_vpu_addr);
+	tx_buf = ivpu_to_cpu_addr(ipc->mem_tx, tx_buf_vpu_addr, sizeof(*tx_buf));
 	if (drm_WARN_ON(&vdev->drm, !tx_buf)) {
 		gen_pool_free(ipc->mm_tx, tx_buf_vpu_addr, sizeof(*tx_buf));
 		return -EIO;
@@ -420,7 +420,7 @@ void ivpu_ipc_irq_handler(struct ivpu_device *vdev)
 			return;
 		}
 
-		ipc_hdr = ivpu_to_cpu_addr(ipc->mem_rx, vpu_addr);
+		ipc_hdr = ivpu_to_cpu_addr(ipc->mem_rx, vpu_addr, sizeof(*ipc_hdr));
 		if (!ipc_hdr) {
 			ivpu_warn_ratelimited(vdev, "IPC msg 0x%x out of range\n", vpu_addr);
 			continue;
@@ -429,7 +429,8 @@ void ivpu_ipc_irq_handler(struct ivpu_device *vdev)
 
 		jsm_msg = NULL;
 		if (ipc_hdr->channel != IVPU_IPC_CHAN_BOOT_MSG) {
-			jsm_msg = ivpu_to_cpu_addr(ipc->mem_rx, ipc_hdr->data_addr);
+			jsm_msg = ivpu_to_cpu_addr(ipc->mem_rx, ipc_hdr->data_addr,
+						   sizeof(*jsm_msg));
 			if (!jsm_msg) {
 				ivpu_warn_ratelimited(vdev, "JSM msg 0x%x out of range\n",
 						      ipc_hdr->data_addr);

