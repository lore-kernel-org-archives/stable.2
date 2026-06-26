Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F6B3F8890;
	Fri, 26 Jun 2026 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484805; cv=none; b=aMMfpzHGmpdv9AwgAzOzykzrMOSvGIELC4KXLVqMQpA5CfvyuP58Ib5ztRCMmNFqsk+pdaXscPduQyUE5KTtmYovHyvKDtBIAFuCt033NSDrJCoct0Y/MhCnBetX4XjnSukD9PsBaNStCIOZSspMMRqmCZwnIlWVHpKJFQsi+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484805; c=relaxed/simple;
	bh=GRCAC9LJ9JApB/VrF+US8BX3nkWc8vLxOYw1Ki3uBrY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xr3fvraqhspsxYyItPcw8/e/ATpHJxLdCUX9FzmQE3n8iBR4S///q2tY1HdjllvyFT6wUQByogXa51jWtNZBdlAf5OVg4r9ynrm0gykPOLPW1U09hQ9zx1DQ+5Otc0XTzLdw+l9NP16GgWtMxsdJ3pGex6MUn6gN3RM4ZA5ZANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAA33NQ5jz5qf3RqAw--.18622S2;
	Fri, 26 Jun 2026 22:39:55 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Ben Skeggs <bskeggs@redhat.com>,
	nouveau@lists.freedesktop.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: drm/nouveau: nvkm_chan_new_: multiple error paths return without   releasing acquired references
Date: Fri, 26 Jun 2026 22:39:53 +0800
Message-Id: <20260626143953.48952-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA33NQ5jz5qf3RqAw--.18622S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGry5ur18urWxZw15KryDZFb_yoW5WryxpF
	43WayYkr18trsYyas2yr48GasIyw4UKw4jka4UCw1SvrnxXrW8Cr4rAa10vFZ5Jr4xGr45
	GFsIqa4SqF15Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUOlkVUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUKA2o+iCgR+wABsK

After allocating chan and acquiring references on cgrp, vmm, memory, and
  chid, numerous subsequent error paths return ret directly without calling
  kfree, nvkm_cgrp_unref, nvkm_vmm_unref, nvkm_memory_unref, or
  nvkm_chid_put. Every error return after the initial allocations leaks one
  or more acquired resources.

Cc: stable@vger.kernel.org
Fixes: 06db7fded6de ("drm/nouveau/fifo: add new channel classes")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 .../gpu/drm/nouveau/nvkm/engine/fifo/chan.c   | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
index 418a8918bcb8..1bf595bafa9a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
@@ -410,18 +410,18 @@ nvkm_chan_new_(const struct nvkm_chan_func *func, struct nvkm_runl *runl, int ru
 			      &chan->inst);
 	if (ret) {
 		RUNL_DEBUG(runl, "inst %d", ret);
-		return ret;
+		goto done;
 	}
 
 	/* Initialise virtual address-space. */
 	if (func->inst->vmm) {
 		if (WARN_ON(vmm->mmu != device->mmu))
-			return -EINVAL;
+			goto done;
 
 		ret = nvkm_vmm_join(vmm, chan->inst->memory);
 		if (ret) {
 			RUNL_DEBUG(runl, "vmm %d", ret);
-			return ret;
+			goto done;
 		}
 
 		chan->vmm = nvkm_vmm_ref(vmm);
@@ -432,7 +432,7 @@ nvkm_chan_new_(const struct nvkm_chan_func *func, struct nvkm_runl *runl, int ru
 		ret = nvkm_object_bind(&dmaobj->object, chan->inst, -16, &chan->push);
 		if (ret) {
 			RUNL_DEBUG(runl, "bind %d", ret);
-			return ret;
+			goto done;
 		}
 	}
 
@@ -443,13 +443,13 @@ nvkm_chan_new_(const struct nvkm_chan_func *func, struct nvkm_runl *runl, int ru
 			if (ouserd + chan->func->userd->size >=
 				nvkm_memory_size(userd)) {
 				RUNL_DEBUG(runl, "ouserd %llx", ouserd);
-				return -EINVAL;
+				goto done;
 			}
 
 			ret = nvkm_memory_kmap(userd, &chan->userd.mem);
 			if (ret) {
 				RUNL_DEBUG(runl, "userd %d", ret);
-				return ret;
+				goto done;
 			}
 
 			chan->userd.base = ouserd;
@@ -461,7 +461,7 @@ nvkm_chan_new_(const struct nvkm_chan_func *func, struct nvkm_runl *runl, int ru
 
 	if (chan->id < 0) {
 		RUNL_ERROR(runl, "!chids");
-		return -ENOSPC;
+		goto done;
 	}
 
 	if (cgrp->id < 0)
@@ -475,8 +475,17 @@ nvkm_chan_new_(const struct nvkm_chan_func *func, struct nvkm_runl *runl, int ru
 	ret = chan->func->ramfc->write(chan, offset, length, devm, priv);
 	if (ret) {
 		RUNL_DEBUG(runl, "ramfc %d", ret);
-		return ret;
+		goto done;
 	}
 
 	return 0;
+
+done:
+	if (chan->id >= 0)
+		nvkm_chid_put(runl->chid, chan->id, &chan->cgrp->lock);
+	nvkm_memory_unref(&chan->userd.mem);
+	nvkm_vmm_unref(&chan->vmm);
+	nvkm_cgrp_unref(&chan->cgrp);
+	*pchan = NULL;
+	return ret;
 }
-- 
2.39.5 (Apple Git-154)

