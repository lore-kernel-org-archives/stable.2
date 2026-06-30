Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495513EEAE5;
	Tue, 30 Jun 2026 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811650; cv=none; b=ZI7FfucxK0u3Jv4QQXR/gvuSAkAlIeOmei2emojRjn+KYX9OlYqM1ymxsFD8Q67/zrtvkJ8wD91aTD0F61zEy1KGfYvYr1PbISAubm8izTZj6OaFj/wDdcrr/e7JwFAhnly8yYE95Oo/HsCeUZSNRgZqHzUZA6A/2fQDA3N4S9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811650; c=relaxed/simple;
	bh=GduhRvfG0QzsuvgcVco1uZuIp0l3DXJTI++cEOWs798=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=kbeRbcIBASDTjmKMzCDb2hmhFkPtKM5KbQN1b3/P1h5RuGcjSweWVoU/MKagBU0ODZblnDLyW1LuVVH9HwFi3iMzaurDRGd2y1jIPpGFdfRPWgS/wlvfPRk4gzhTjAHUlngYgfOMNTbfnRgckyk/ym/D/ZAYsSW2s48hJ4MnhDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=jrjF93WJ; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="jrjF93WJ"
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U5eYYq874592;
	Tue, 30 Jun 2026 10:27:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=dk201812; bh=QO6McH8r7hXIXf6T2Fn09cg
	BgSq04y2vLP/sIy9RH8I=; b=jrjF93WJGi+8RR0fLYgpK9PsuSWgznhURZ43QWe
	bL5SL6Xel7HYUlmevZeXS2JhITDh5H9dIiFxfswRqhvdFqMKiUNMEvC8IuP6Yxw4
	aoM6UkuViJ6QrJ7NWRsNKVD8hhM3P2gEWW9aUQNdk5Zl60dAborzpOZ0W4sQ60wA
	Hy4vpsehmKwKiStV0YHjOVXESqjQY5h4U6v6Ewz2tOtOAoWOH4U7uWhbqsHlxAJr
	5nh4VAF01tEqvwnjD6ophvx/20jsYwqLONqB187+Qkc6h1d3Aa6UB45RNBStQWsx
	765g+fATmppzwM+O4IryY5SrVoWAYN6t8j7rV5+h/+CbKRw==
Received: from hhmail01.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4f26kuk2jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:27:07 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 30 Jun
 2026 10:27:04 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Tue, 30 Jun 2026 14:55:49 +0530
Subject: [PATCH v5] drm/imagination: Fix double call to
 drm_sched_entity_fini()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260630-b4-sched_fix-v5-1-2a84cbf18bfe@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAJyLQ2oC/33NSw6CMBSF4a2Yjq3pu+LIfRhj+riFDgBDCdEQ9
 m5hhBAdnpt8/x1Rgi5CQpfDiDoYYoptk4c8HpCrTFMCjj5vxAhTRFGCrcDJVeAfIb6wcdwWjAS
 hpUWZPDvI5yV3u+ddxdS33XupD3S+/ggNFFPsZKG1UUCscNdYlz24k2trNJcGttZ0o1nWVJuCW
 zir4PxO83+aZ61mayUBQ+hOi7UuNlrMWnqQlgWv6ffvaZo+pFpXFmMBAAA=
To: Frank Binns <frank.binns@imgtec.com>,
        Matt Coster
	<matt.coster@imgtec.com>,
        Alessio Belle <Alessio.Belle@imgtec.com>,
        "Alexandru Dadu" <alexandru.dadu@imgtec.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Boris Brezillon
	<boris.brezillon@collabora.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Brajesh Gupta <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782811624; l=9016;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=GduhRvfG0QzsuvgcVco1uZuIp0l3DXJTI++cEOWs798=;
 b=Je9cUdZT/E5MFaiX4ll5RZ8eHMSA4/ozqMX0mP4Tl6hsldOreWdyefTizNL0XyYQF95G5P3RK
 sgB6lTsZPJ1B70quB3H/Gr/6x0DZ/+po3TOgGcV6iDtbRwRUDxXlBZW
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Authority-Analysis: v=2.4 cv=epXvCIpX c=1 sm=1 tr=0 ts=6a438beb cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=HYrZrZQ_E1YA:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=28r1m_Knvop3wzSJsIkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: qXehpBGzRX0n6WvbThtF6sRMvhodT-tt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA4NCBTYWx0ZWRfX8xjgKC2r6JPe
 45A8Terjaa96/jK/Pgj8OwoyVtb25Oyf22p23wYb3YlzimSYLHRkoRLBQzrg2QKz2aCfkS6G6L4
 4lBFgRNdHTxGtqbexYRxzICF4cqPYlHQAzYjnxSy4RHv5MUR9eVmZqBP5yt2HepaOVWnzT29giA
 zkfRCA8L1YR8VI9NeLdzDxud33wK+XoH+INdzPMVT4KW5RbAWiPw3CfsyIYyS33E8e7QPyelNQf
 RO+9nxy1JaRAhOzLESXCA4mFDApDdX01dUyJCof9Q3AFBh5qGy6QML75x328aVjhItCMbBJHzN9
 qF/emjh+2Tuv3925GClxgVZLnL/DjWPh6JRbmklHP4umjnE6lL9bsmTEcDR9VFnGekpK+/yyfde
 TPW5LdgCgrcoPhaxzWdZRA0izpPag6LvRzsPkeAazoyyFLDAA3asMs7iPsjocEgmLuO/f8iPT+f
 LHfh8sQaM1Yk6xUcW1g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA4NCBTYWx0ZWRfX5n3uLyL0c/Uq
 lpaxXhfjo+BSEjqn6Vn7roe9OXFAEUmESzNo2KViaqDLQLlRGpRqOEicoybCpYTs8BzFmAja+zY
 xey20DNYNs/xrbAKMsD0JracVGCsN0U=
X-Proofpoint-GUID: qXehpBGzRX0n6WvbThtF6sRMvhodT-tt

Call sequence of double call:
pvr_context_destroy
  pvr_context_kill_queues
    pvr_queue_kill
      drm_sched_entity_destroy
        drm_sched_entity_fini // here
  pvr_context_put
    kref_put(..., pvr_context_release)
      pvr_context_destroy_queues
        pvr_queue_destroy
          drm_sched_entity_fini // here

Call to drm_sched_entity_destroy() from pvr_context_kill_queues() calls
drm_sched_entity_flush() + drm_sched_entity_fini().
drm_sched_entity_flush() ensures all pending jobs are completed and
drm_sched_entity_fini() ensures no further submission is allowed as
per expectation from pvr_context_kill_queues(). Double call to
drm_sched_entity_fini() is misuse of the API so keep call only in
pvr_context_create() failure path.

Stack trace for issue with addition of refcounting for DRM entity
stats in commit fd177135f0e6 ("drm/sched: Account entity GPU time"):
[  789.490527] ------------[ cut here ]------------
[  789.490559] refcount_t: underflow; use-after-free.
[  789.490657] WARNING: lib/refcount.c:28 at refcount_warn_saturate+0xf4/0x144, CPU#0: kworker/u16:1/440
[  789.490695] Modules linked in: powervr drm_gpuvm drm_exec gpu_sched drm_shmem_helper xhci_plat_hcd xhci_hcd dwc3 usbcore usb_common snd_soc_simple_card snd_soc_simple_card_utils sa2ul sha512 sha256 dwc3_am62 sha1 authenc rti_wdt libsha512 at24 sch_fq_codel fuse dm_mod ipv6
[  789.490798] CPU: 0 UID: 0 PID: 440 Comm: kworker/u16:1 Not tainted 7.0.0-rc7-02049-g5e2c0700091b #22 PREEMPT
[  789.490809] Hardware name: Texas Instruments AM625 SK (DT)
[  789.490815] Workqueue: powervr-sched pvr_queue_fence_release_work [powervr]
[  789.490868] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  789.490876] pc : refcount_warn_saturate+0xf4/0x144
[  789.490884] lr : refcount_warn_saturate+0xf4/0x144
[  789.490892] sp : ffff8000822cbcc0
[  789.490895] x29: ffff8000822cbcc0 x28: 0000000000000000 x27: 0000000000000000
[  789.490909] x26: 0000000000000000 x25: ffff800081b1e338 x24: ffff000004541405
[  789.490922] x23: ffff000004bea950 x22: ffff00000042e400 x21: ffff000007123e30
[  789.490935] x20: ffff000007123000 x19: ffff000007a80d50 x18: fffffffffffe7768
[  789.490948] x17: 74736574202c6e6f x16: 697461746e656d65 x15: ffff800081b269f0
[  789.490962] x14: 0000000000000030 x13: ffff800081b26a70 x12: 0000000000000211
[  789.490975] x11: 00000000000000c0 x10: 0000000000000b50 x9 : ffff8000822cbb30
[  789.490988] x8 : ffff0000014e7bb0 x7 : ffff00007725e780 x6 : 0000000372a05f49
[  789.491001] x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000010
[  789.491013] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000014e7000
[  789.491027] Call trace:
[  789.491032]  refcount_warn_saturate+0xf4/0x144 (P)
[  789.491043]  drm_sched_entity_fini+0x164/0x18c [gpu_sched]
[  789.491081]  pvr_queue_destroy+0x64/0x134 [powervr]
[  789.491110]  pvr_context_destroy_queues+0x34/0x64 [powervr]
[  789.491138]  pvr_context_release+0x70/0xac [powervr]
[  789.491166]  pvr_context_put.part.0+0x5c/0x7c [powervr]
[  789.491193]  pvr_context_put+0x14/0x24 [powervr]
[  789.491221]  pvr_queue_fence_release_work+0x20/0x38 [powervr]
[  789.491249]  process_one_work+0x160/0x4c4
[  789.491264]  worker_thread+0x188/0x310
[  789.491276]  kthread+0x130/0x13c
[  789.491287]  ret_from_fork+0x10/0x20
[  789.491300] ---[ end trace 0000000000000000 ]---

Fixes: eaf01ee5ba28 ("drm/imagination: Implement job submission and scheduling")
Cc: stable@vger.kernel.org
Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
Changes in v5:
- Update description of the issue and added stable tag.
- Modified variable name to align with behaviour.
- Link to v4: https://lore.kernel.org/r/20260619-b4-sched_fix-v4-1-65de5b2fd71d@imgtec.com

Changes in v4:
- Simplify logic in v3 by pushing new flag to pvr_queue_destroy().
- Link to v3: https://lore.kernel.org/r/20260611-b4-sched_fix-v3-1-693beb50ea01@imgtec.com

Changes in v3:
- Fixed a typo.
- Handled missing memory leak for RENDER_CONTEXT.
- Link to v2: https://lore.kernel.org/r/20260611-b4-sched_fix-v2-1-17a93be86fcd@imgtec.com

Changes in v2:
- Fixed memory leak identified in following error path handling of pvr_context_create():
- pvr_context_create()
-   ...
-   err_destroy_queues:
-     pvr_context_destroy_queues()
-       pvr_queue_destroy()
- Link to v1: https://lore.kernel.org/r/20260610-b4-sched_fix-v1-1-c5977a6e0b4c@imgtec.com
---
 drivers/gpu/drm/imagination/pvr_context.c | 18 ++++++++++--------
 drivers/gpu/drm/imagination/pvr_queue.c   |  6 ++++--
 drivers/gpu/drm/imagination/pvr_queue.h   |  2 +-
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_context.c b/drivers/gpu/drm/imagination/pvr_context.c
index eba4694400b5..b6f9e078315d 100644
--- a/drivers/gpu/drm/imagination/pvr_context.c
+++ b/drivers/gpu/drm/imagination/pvr_context.c
@@ -161,22 +161,24 @@ ctx_fw_data_init(void *cpu_ptr, void *priv)
 /**
  * pvr_context_destroy_queues() - Destroy all queues attached to a context.
  * @ctx: Context to destroy queues on.
+ * @cleanup_queue_entity: Whether to cleanup the queue entity e.g. context
+ *                      creation failure path.
  *
  * Should be called when the last reference to a context object is dropped.
  * It releases all resources attached to the queues bound to this context.
  */
-static void pvr_context_destroy_queues(struct pvr_context *ctx)
+static void pvr_context_destroy_queues(struct pvr_context *ctx, bool cleanup_queue_entity)
 {
 	switch (ctx->type) {
 	case DRM_PVR_CTX_TYPE_RENDER:
-		pvr_queue_destroy(ctx->queues.fragment);
-		pvr_queue_destroy(ctx->queues.geometry);
+		pvr_queue_destroy(ctx->queues.fragment, cleanup_queue_entity);
+		pvr_queue_destroy(ctx->queues.geometry, cleanup_queue_entity);
 		break;
 	case DRM_PVR_CTX_TYPE_COMPUTE:
-		pvr_queue_destroy(ctx->queues.compute);
+		pvr_queue_destroy(ctx->queues.compute, cleanup_queue_entity);
 		break;
 	case DRM_PVR_CTX_TYPE_TRANSFER_FRAG:
-		pvr_queue_destroy(ctx->queues.transfer);
+		pvr_queue_destroy(ctx->queues.transfer, cleanup_queue_entity);
 		break;
 	}
 }
@@ -240,7 +242,7 @@ static int pvr_context_create_queues(struct pvr_context *ctx,
 	return -EINVAL;
 
 err_destroy_queues:
-	pvr_context_destroy_queues(ctx);
+	pvr_context_destroy_queues(ctx, true);
 	return err;
 }
 
@@ -349,7 +351,7 @@ int pvr_context_create(struct pvr_file *pvr_file, struct drm_pvr_ioctl_create_co
 	pvr_fw_object_destroy(ctx->fw_obj);
 
 err_destroy_queues:
-	pvr_context_destroy_queues(ctx);
+	pvr_context_destroy_queues(ctx, true);
 
 err_free_ctx_id:
 	/*
@@ -384,7 +386,7 @@ pvr_context_release(struct kref *ref_count)
 	spin_unlock(&pvr_dev->ctx_list_lock);
 
 	xa_erase(&pvr_dev->ctx_ids, ctx->ctx_id);
-	pvr_context_destroy_queues(ctx);
+	pvr_context_destroy_queues(ctx, false);
 	pvr_fw_object_destroy(ctx->fw_obj);
 	kfree(ctx->data);
 	pvr_vm_context_put(ctx->vm_ctx);
diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index 7ed60e1c1a86..941c017399fc 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -1439,11 +1439,12 @@ void pvr_queue_kill(struct pvr_queue *queue)
 /**
  * pvr_queue_destroy() - Destroy a queue.
  * @queue: The queue to destroy.
+ * @cleanup_queue_entity: Whether to cleanup the queue entity.
  *
  * Cleanup the queue and free the resources attached to it. Should be
  * called from the context release function.
  */
-void pvr_queue_destroy(struct pvr_queue *queue)
+void pvr_queue_destroy(struct pvr_queue *queue, bool cleanup_queue_entity)
 {
 	if (!queue)
 		return;
@@ -1453,7 +1454,8 @@ void pvr_queue_destroy(struct pvr_queue *queue)
 	mutex_unlock(&queue->ctx->pvr_dev->queues.lock);
 
 	drm_sched_fini(&queue->scheduler);
-	drm_sched_entity_fini(&queue->entity);
+	if (cleanup_queue_entity)
+		drm_sched_entity_fini(&queue->entity);
 
 	if (WARN_ON(queue->last_queued_job_scheduled_fence))
 		dma_fence_put(queue->last_queued_job_scheduled_fence);
diff --git a/drivers/gpu/drm/imagination/pvr_queue.h b/drivers/gpu/drm/imagination/pvr_queue.h
index 4aa72665ce25..5b07d7edf1c1 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.h
+++ b/drivers/gpu/drm/imagination/pvr_queue.h
@@ -158,7 +158,7 @@ struct pvr_queue *pvr_queue_create(struct pvr_context *ctx,
 
 void pvr_queue_kill(struct pvr_queue *queue);
 
-void pvr_queue_destroy(struct pvr_queue *queue);
+void pvr_queue_destroy(struct pvr_queue *queue, bool queue_entity_fini);
 
 void pvr_queue_process(struct pvr_queue *queue);
 

---
base-commit: 61de054a772a1feda6364931ab1baf9038abf1c8
change-id: 20260610-b4-sched_fix-ac3b920f475b

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>

