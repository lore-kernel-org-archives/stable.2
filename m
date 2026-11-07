Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045766;
	b=uQpaeHzjvek0ZCjlKtTuYJJWYx2OvkYAaCT4j5qq7TerN6YNnvVJucA/kQu57tGRXKH8
	 ADAsp8wYis91OjIFvckENyh4uM9XT67/q9llzEM3SQ/L0JnBrmUYNkCKLiIo3hEb+YORo
	 cUwVAxyLqjGv0Gtr0WOK6xYh4K2BYmYTwBzXdf2x7GTFnNuLNhmQ/w7A2eQ1x1u8Xvwdu
	 KRk5kLwsQffcO4DJmUgpst0wtq2Sxh8Dt5QUynWg8+G6YDiBv46NGsuhGmS4oyTtkjMP+
	 yF4pZjFxX0gUTDB6gRcwIGIrt3mx+uJfAMzIBDRkzsaoXJjVZjC5j3CmEW8QyvtXUeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045766;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VKpUcx9HUS1t2zCY49tw8S2aNrc/OarMzDib6MPigZg=;
	b=wHRdysxECaJt+QtbZkcxfjhrj+KLP50gBqXY5XRrKOvv/rIQ+wINiNHw8jWe3kGBrO7l
	 pfd0JMiCKK7KM5Uu/xspgS70Gt9LiV0Se0CeYY4VS3hb3o2egXkHWiFt871EnjOKDgwQF
	 cg5SQPEXjA4Q8KwmWFshN9OC33c/CdsV4o6rM+zAWrbCx1OJpkqYr/m62bGC9v2ZGiMty
	 KYW/luRplk0iP3YTbm+z8q6NWHowVsx+5aBr5BqIxqvt5mRWmtoVaOxdZgcvcqHnDxSNe
	 K+RpK0PxLorcBgwcEqXTktWr7qavwoylh6e63x5xoVME58cQtIgrmJBK0JcuOMtKoVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KE2GkkEm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACA7606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KE2GkkEm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C574F1F0089F;
	Sat,  7 Nov 2026 10:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045766;
	bh=VKpUcx9HUS1t2zCY49tw8S2aNrc/OarMzDib6MPigZg=;
	h=From:To:Cc:Subject:Date;
	b=KE2GkkEm75+cwrmW0EouPOkpSKmSRuuLSr4Wx/XKFfUT9mUEbSCxTTcfnEuiJkA9d
	 8kgnjWCP0kD3fZKNXbMowiF68g3ZzW4OxidkR6r4WDT/DFp0d+ZOwoQJEqiSikKHot
	 FQprznSbfiMZS5e/HwYDC3PdldA2wDyTgAUiuK00m6Exq/fm3G9yOy+rpFkcZG3wMH
	 mulWzfZuSKhg6fxQtk1wUu2EESR1ipxcHxbT5yPUPogXRE3hfYF04bndIafze6sudB
	 f2WiWDchuKt50pBzqqPeL0/+Qdtd+dOEFP86MiorrftR79TM7AK/XjtImOCCJbR6uS
	 dmDXdMswYO82Q==
From: Sasha Levin <sashal@kernel.org>
To: lyude@redhat.com,
	airlied@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Revert "nouveau/gsp: fix suspend/resume regression on r570 firmware"" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:02:44 -0500
Message-ID: <20261107050244-failed-7.3-94097122bfd7@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 94097122bfd701976bc1a62ccd434c13f3f67cde
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050244-failed-7.3-94097122bfd7@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 94097122bfd701976bc1a62ccd434c13f3f67cde Mon Sep 17 00:00:00 2001
From: Lyude Paul <lyude@redhat.com>
Date: Fri, 14 Aug 2026 15:43:48 -0400
Subject: [PATCH] Revert "nouveau/gsp: fix suspend/resume regression on r570
 firmware"

This reverts commit 8302d0afeaec0bc57d951dd085e0cffe997d4d18.

It turns out this looked like the right fix on some systems, but it's not -
as this causes runtime PM to actually fail on many a laptop.

Fixes: 8302d0afeaec ("nouveau/gsp: fix suspend/resume regression on r570 firmware")
Cc: <stable@vger.kernel.org> # v6.19+
Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Dave Airlie <airlied@redhat.com>
Link: https://patch.msgid.link/20260814194542.781955-2-lyude@redhat.com
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c  | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c | 8 ++++----
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h        | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c
index f128330f30d7b..40bf83ea33ac0 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c
@@ -208,7 +208,7 @@ r535_fbsr_resume(struct nvkm_gsp *gsp)
 }
 
 static int
-r535_fbsr_suspend(struct nvkm_gsp *gsp, bool runtime)
+r535_fbsr_suspend(struct nvkm_gsp *gsp)
 {
 	struct nvkm_subdev *subdev = &gsp->subdev;
 	struct nvkm_device *device = subdev->device;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
index f544afa12b6bb..4a3b771ded255 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
@@ -1749,7 +1749,7 @@ r535_gsp_fini(struct nvkm_gsp *gsp, enum nvkm_suspend_state suspend)
 		sr->sysmemAddrOfSuspendResumeData = gsp->sr.radix3.lvl0.addr;
 		sr->sizeOfSuspendResumeData = len;
 
-		ret = rm->api->fbsr->suspend(gsp, suspend == NVKM_RUNTIME_SUSPEND);
+		ret = rm->api->fbsr->suspend(gsp);
 		if (ret) {
 			nvkm_gsp_mem_dtor(&gsp->sr.meta);
 			nvkm_gsp_radix3_dtor(gsp, &gsp->sr.radix3);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
index 8ef8b4f655883..2945d5b4e5707 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
@@ -62,7 +62,7 @@ r570_fbsr_resume(struct nvkm_gsp *gsp)
 }
 
 static int
-r570_fbsr_init(struct nvkm_gsp *gsp, struct sg_table *sgt, u64 size, bool runtime)
+r570_fbsr_init(struct nvkm_gsp *gsp, struct sg_table *sgt, u64 size)
 {
 	NV2080_CTRL_INTERNAL_FBSR_INIT_PARAMS *ctrl;
 	struct nvkm_gsp_object memlist;
@@ -81,7 +81,7 @@ r570_fbsr_init(struct nvkm_gsp *gsp, struct sg_table *sgt, u64 size, bool runtim
 	ctrl->hClient = gsp->internal.client.object.handle;
 	ctrl->hSysMem = memlist.handle;
 	ctrl->sysmemAddrOfSuspendResumeData = gsp->sr.meta.addr;
-	ctrl->bEnteringGcoffState = runtime ? 1 : 0;
+	ctrl->bEnteringGcoffState = 1;
 
 	ret = nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice, ctrl);
 	if (ret)
@@ -92,7 +92,7 @@ r570_fbsr_init(struct nvkm_gsp *gsp, struct sg_table *sgt, u64 size, bool runtim
 }
 
 static int
-r570_fbsr_suspend(struct nvkm_gsp *gsp, bool runtime)
+r570_fbsr_suspend(struct nvkm_gsp *gsp)
 {
 	struct nvkm_subdev *subdev = &gsp->subdev;
 	struct nvkm_device *device = subdev->device;
@@ -133,7 +133,7 @@ r570_fbsr_suspend(struct nvkm_gsp *gsp, bool runtime)
 		return ret;
 
 	/* Initialise FBSR on RM. */
-	ret = r570_fbsr_init(gsp, &gsp->sr.fbsr, size, runtime);
+	ret = r570_fbsr_init(gsp, &gsp->sr.fbsr, size);
 	if (ret) {
 		nvkm_gsp_sg_free(device, &gsp->sr.fbsr);
 		return ret;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
index a9af94adf9efc..0fb0e67406c67 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
@@ -78,7 +78,7 @@ struct nvkm_rm_api {
 	} *device;
 
 	const struct nvkm_rm_api_fbsr {
-		int (*suspend)(struct nvkm_gsp *, bool runtime);
+		int (*suspend)(struct nvkm_gsp *);
 		void (*resume)(struct nvkm_gsp *);
 	} *fbsr;
 
-- 
2.53.0




