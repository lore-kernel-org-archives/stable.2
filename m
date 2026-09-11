Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EE7372B26;
	Fri, 11 Sep 2026 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119030; cv=none; b=m7DI6XlKqZCSPQd6Ddb8mhJzkY/fjtlbJC/U3sm9DiRZXhiovw0ilbGT7HtNBFuK7xW5U2FwsGdOQ9rzLRWMvClQfz4lxyAg/7VjWSzgMdudxQFGoXsn5ONiVcLLZ0v2yR9euuNQufHHsooz74gm5/Wz5m5sj9tOfMMsKr342lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119030; c=relaxed/simple;
	bh=ajYr5SO5G2Ezh9ZbAC+1UlKiopRQF8Xf4UoyRxdoB2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wx8YzJ07SmwirwYc5L7dpCd/UCir9O446p1jg+TCmeleLsgClLlVDzidgTpoOxJa2dIASuvrLcNLmuzfOrqTpGP2gbdxDbeTcdPHveFkMu0EIcL404Zrq9sDncqedonmcCwQJutYtcq/R4Z06BPdmy5L3UzPfCyd5Qf0wVM2y1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=WWI1OsCL; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="WWI1OsCL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1789118952;
	bh=nl+3kTEA6kG+Ya0Qebsmh5RZwS1Ke2Bdvprd1eODfmg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=WWI1OsCL83ydbSN9iSyd2o29+jrs0LWzij9JO2owBCdCIVwwKWY444CRILB8bjZ+5
	 AZRTlCToq+zuvDKtDETlo7z3kZYqJTA+7w9mBbfe2XXzKFTAkQxn8OntE/BEnP+QKe
	 ooBPPRPazR4LOXWVfAkGBSWOnmeju/JMTVzTOaM0=
X-QQ-mid: esmtpgz12t1789118950ta17ba4e3
X-QQ-Originating-IP: 74Cznb4R1YCb91v6oqvm5/Nsioh1HIbE26jAmimgBZA=
Received: from hepeiyang-vm.wu.lxd ( [36.152.24.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 11 Sep 2026 17:29:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8586802869201418434
EX-QQ-RecipientCnt: 9
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: lyude@redhat.com,
	dakr@kernel.org,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	bskeggs@redhat.com,
	airlied@redhat.com,
	Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [PATCH] drm/nouveau: fix memory leak in r535_gr_promote_ctx
Date: Fri, 11 Sep 2026 17:28:51 +0800
Message-ID: <DFACFA54B3906F4E+20260911092851.1201981-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NAeO0+xU6W76Ayry0UF/ArnN6+9gQoytP5DS40CO9rQ180r2sb3lwnLB
	jca/floIY4NQMYggenaGeZDotUYINZbbmLhanJoSzIjHoEIRkoFHE1q8Vymx6+37oECWKhc
	X5STVgmnFs9R++jpRWy3W0j3IRDXi8hie8wFb43HD5PLpV5RvCSujzRtHDBqdYriixw3eZt
	M6fL+oFTRCciqtejFtN3M5l4XKfsaqE0ckwIlmsoWDFxk6ajaFKH5a74ePWyKDwK4Xhk/6w
	eayl0mJh90Bk5qrSS2Hhe3R1qqTYZCJ1Nxb+RxPjqde+ttT0Onx5jq8RRtt2V1HvCnyTASt
	iR/2XVX/VWrf4xEYka2IcYtcZ1aCfcBP5BXGhfamS3oAkEII5OFlgXN8cbRf2yILaAQ3gJX
	5m7i97pezxbVz6mSy3IDHRDISvn0yqYlOr9NtymYAJik0WZpNBbT4sAcPkwYwktN74xRlV7
	27fDyS7ClGzNl7oM2BrKPZZKc9XEF6goIIr8817K944bot1pXauswuxTwZDPDSb2IDYIIFn
	krP61eyiX1CeZa7xMRq/MTbs+l9htbwvnIZrYBmgvvMAzfpo5cexkftX2VJy7LGa3mU+/jS
	+5vSgN104shTTtxeqsjqab7BkaQWGZe3aLaO/1xYx5Y9k1LayWPNN+UMugOobkSggw441+H
	4QiTgUODS/cVUhDMY8O267sDoqrW4Yoo6KqitVCbKA7FcmKUT8KCuVk1WYAAgdfLn5wzmDV
	44DS0d5jopgIj+zA8C0ZZhczuDWAp/J0uZ7Vm6FpZXx06SJaUmGN+9AiQPnVVQ5UrOenJrC
	4OCFEZwDMUSc8Y1ozKRF6WdtWPEwO0ZTpGeN8JMmTdKYPqG2pjZV4qb/bQCrMIrpKRot1Zf
	xI7VWX4Xc2kUC71sAK9rgzDUoM9p/wuPgrfvOU2k5u5Df12Owx6Nim0QLweEVKcdL6DnHDr
	QymkBG4hTwdG337mpwkFgTm8uN41dr3URSzOr63yAMibF0y8xNxug3BjdyAdwpT89zEz5jv
	c8VLEZhFEYeoPPlA6uVn0YeZMmKusyZS4UUko8ePTxxpgcXgGN
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

r535_gr_promote_ctx() gets the GPU_PROMOTE_CTX RM control RPC before it
allocates and maps the context buffers. If nvkm_memory_new(),
nvkm_vmm_get_locked(), or nvkm_memory_map() fails, the function returns
without submitting the RPC and leaks the request allocation. The leaked
allocation is a 4KiB GSP message queue element. This leak can be reliably
triggered by a non-root user with access to the nouveau device node,
and repeated leak can lead to a local denial of service.

Found when fuzzing the nouveau driver with a modified Syzkaller:

	BUG: memory leak
	unreferenced object 0xffff888019cb8000 (size 4096):
	comm "syz.6.42", pid 2747, jiffies 4294720158
	hex dump (first 32 bytes):
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	backtrace (crc 43f743b8):
		kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
		slab_post_alloc_hook mm/slub.c:4597 [inline]
		slab_alloc_node mm/slub.c:4917 [inline]
		__do_kmalloc_node mm/slub.c:5333 [inline]
		__kvmalloc_node_noprof+0x62c/0x9e0 mm/slub.c:6905
		r535_gsp_cmdq_get drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c:426 [inline]
		r535_gsp_rpc_get+0x3e/0x230 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c:617
		nvkm_gsp_rpc_get drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h:281 [inline]
		r535_gsp_rpc_rm_ctrl_get+0x138/0x490 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c:75
		nvkm_gsp_rm_ctrl_get drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h:323 [inline]
		r535_gr_promote_ctx+0x1c5/0x1700 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gr.c:68
		r535_gr_chan_new+0x140/0x1c0 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gr.c:159
		nvkm_gr_cclass_new+0x99/0xd0 drivers/gpu/drm/nouveau/nvkm/engine/gr/base.c:117
		nvkm_cgrp_ectx_get+0x48a/0x860 drivers/gpu/drm/nouveau/nvkm/engine/fifo/cgrp.c:82
		nvkm_cgrp_vctx_get+0x252/0xd00 drivers/gpu/drm/nouveau/nvkm/engine/fifo/cgrp.c:136
		nvkm_chan_cctx_get+0x2ae/0xb70 drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c:112
		nvkm_uchan_object_new+0x285/0x840 drivers/gpu/drm/nouveau/nvkm/engine/fifo/uchan.c:177
		nvkm_ioctl_new+0x378/0x930 drivers/gpu/drm/nouveau/nvkm/core/ioctl.c:132
		nvkm_ioctl_path drivers/gpu/drm/nouveau/nvkm/core/ioctl.c:278 [inline]
		nvkm_ioctl+0x286/0x9b0 drivers/gpu/drm/nouveau/nvkm/core/ioctl.c:300
		nvif_object_ioctl drivers/gpu/drm/nouveau/nvif/object.c:46 [inline]
		nvif_object_ctor+0x3cc/0x5c0 drivers/gpu/drm/nouveau/nvif/object.c:269
		nouveau_abi16_ioctl_grobj_alloc+0x43f/0x9d0 drivers/gpu/drm/nouveau/nouveau_abi16.c:635
		drm_ioctl_kernel+0x192/0x350 drivers/gpu/drm/drm_ioctl.c:817
		drm_ioctl+0x4f8/0xb40 drivers/gpu/drm/drm_ioctl.c:914

Fix by splitting the original loop in r535_gr_promote_ctx() in two.
The first loop performs all fallible allocation and mapping work.
After the first loop succeeds, allocate the control RPC.
Then use the second loop to fill the promote entries and submit the RPC.

Cc: stable@vger.kernel.org
Fixes: 361c3cd8ae12 ("drm/nouveau/gr/r535: initial support")
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Assisted-by: Codex:gpt-5.5
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gr.c | 54 +++++++++++++---------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gr.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gr.c
index 034db286d285..8b3474733311 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gr.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gr.c
@@ -47,97 +47,109 @@ r535_gr_chan_dtor(struct nvkm_object *object)
 		nvkm_memory_unref(&grc->mem[i]);
 	}
 
 	nvkm_vmm_unref(&grc->vmm);
 	return grc;
 }
 
 static const struct nvkm_object_func
 r535_gr_chan = {
 	.dtor = r535_gr_chan_dtor,
 };
 
 int
 r535_gr_promote_ctx(struct r535_gr *gr, bool golden, struct nvkm_vmm *vmm,
 		    struct nvkm_memory **pmem, struct nvkm_vma **pvma,
 		    struct nvkm_gsp_object *chan)
 {
 	struct nvkm_subdev *subdev = &gr->base.engine.subdev;
 	struct nvkm_device *device = subdev->device;
 	NV2080_CTRL_GPU_PROMOTE_CTX_PARAMS *ctrl;
+	int ret;
 
-	ctrl = nvkm_gsp_rm_ctrl_get(&vmm->rm.device.subdevice,
-				    NV2080_CTRL_CMD_GPU_PROMOTE_CTX, sizeof(*ctrl));
-	if (WARN_ON(IS_ERR(ctrl)))
-		return PTR_ERR(ctrl);
-
-	ctrl->engineType = 1;
-	ctrl->hChanClient = vmm->rm.client.object.handle;
-	ctrl->hObject = chan->handle;
-
+	/* Allocate and map all context buffers before getting the control RPC. */
 	for (int i = 0; i < gr->ctxbuf_nr; i++) {
-		NV2080_CTRL_GPU_PROMOTE_CTX_BUFFER_ENTRY *entry =
-			&ctrl->promoteEntry[ctrl->entryCount];
 		const bool alloc = golden || !gr->ctxbuf[i].global;
-		int ret;
-
-		entry->bufferId = gr->ctxbuf[i].bufferId;
-		entry->bInitialize = gr->ctxbuf[i].init && alloc;
+		const bool nonmapped = alloc && gr->ctxbuf[i].bufferId ==
+			NV2080_CTRL_GPU_PROMOTE_CTX_BUFFER_ID_PRIV_ACCESS_MAP;
 
 		if (alloc) {
 			ret = nvkm_memory_new(device, gr->ctxbuf[i].init ?
 					      NVKM_MEM_TARGET_INST : NVKM_MEM_TARGET_INST_SR_LOST,
 					      gr->ctxbuf[i].size, 1 << gr->ctxbuf[i].page,
 					      gr->ctxbuf[i].init, &pmem[i]);
 			if (WARN_ON(ret))
 				return ret;
-
-			if (gr->ctxbuf[i].bufferId ==
-					NV2080_CTRL_GPU_PROMOTE_CTX_BUFFER_ID_PRIV_ACCESS_MAP)
-				entry->bNonmapped = 1;
 		} else {
 			if (gr->ctxbuf[i].bufferId ==
 				NV2080_CTRL_GPU_PROMOTE_CTX_BUFFER_ID_UNRESTRICTED_PRIV_ACCESS_MAP)
 				continue;
 
 			pmem[i] = nvkm_memory_ref(gr->ctxbuf_mem[i]);
 		}
 
-		if (!entry->bNonmapped) {
+		if (!nonmapped) {
 			struct gf100_vmm_map_v0 args = {
 				.priv = 1,
 				.ro   = gr->ctxbuf[i].ro,
 			};
 
 			mutex_lock(&vmm->mutex.vmm);
 			ret = nvkm_vmm_get_locked(vmm, false, true, false, 0, gr->ctxbuf[i].align,
 						  nvkm_memory_size(pmem[i]), &pvma[i]);
 			mutex_unlock(&vmm->mutex.vmm);
 			if (ret)
 				return ret;
 
 			ret = nvkm_memory_map(pmem[i], 0, vmm, pvma[i], &args, sizeof(args));
 			if (ret)
 				return ret;
+		}
+	}
 
+	ctrl = nvkm_gsp_rm_ctrl_get(&vmm->rm.device.subdevice,
+				    NV2080_CTRL_CMD_GPU_PROMOTE_CTX, sizeof(*ctrl));
+	if (WARN_ON(IS_ERR(ctrl)))
+		return PTR_ERR(ctrl);
+
+	ctrl->engineType = 1;
+	ctrl->hChanClient = vmm->rm.client.object.handle;
+	ctrl->hObject = chan->handle;
+
+	for (int i = 0; i < gr->ctxbuf_nr; i++) {
+		NV2080_CTRL_GPU_PROMOTE_CTX_BUFFER_ENTRY *entry =
+			&ctrl->promoteEntry[ctrl->entryCount];
+		const bool alloc = golden || !gr->ctxbuf[i].global;
+
+		if (!alloc && gr->ctxbuf[i].bufferId ==
+			NV2080_CTRL_GPU_PROMOTE_CTX_BUFFER_ID_UNRESTRICTED_PRIV_ACCESS_MAP)
+			continue;
+
+		entry->bufferId = gr->ctxbuf[i].bufferId;
+		entry->bInitialize = gr->ctxbuf[i].init && alloc;
+
+		if (alloc && gr->ctxbuf[i].bufferId ==
+				NV2080_CTRL_GPU_PROMOTE_CTX_BUFFER_ID_PRIV_ACCESS_MAP)
+			entry->bNonmapped = 1;
+
+		if (!entry->bNonmapped)
 			entry->gpuVirtAddr = pvma[i]->addr;
-		}
 
 		if (entry->bInitialize) {
 			entry->gpuPhysAddr = nvkm_memory_addr(pmem[i]);
 			entry->size = gr->ctxbuf[i].size;
 			entry->physAttr = 4;
 		}
 
 		nvkm_debug(subdev,
 			   "promote %02d: pa %016llx/%08x sz %016llx va %016llx init:%d nm:%d\n",
 			   entry->bufferId, entry->gpuPhysAddr, entry->physAttr, entry->size,
 			   entry->gpuVirtAddr, entry->bInitialize, entry->bNonmapped);
 
 		ctrl->entryCount++;
 	}
 
 	return nvkm_gsp_rm_ctrl_wr(&vmm->rm.device.subdevice, ctrl);
 }
 
 int
 r535_gr_chan_new(struct nvkm_gr *base, struct nvkm_chan *chan, const struct nvkm_oclass *oclass,
-- 
2.43.0
