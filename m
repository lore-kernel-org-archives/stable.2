Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048970;
	b=5KFKYLiYN1VlDExVEJz3FHQXX8dW3q0uAGU+VSRWsTsgcWJUjy8KEvQAr6WHlshjX25c
	 9I0HLuPJO8zljASAKnv3gMpyS7KLT+ZTaQQqZ7qyQSmwNMUaQvlIj+5HPNOfQQZ8hQmNG
	 4dbwsqV68yfwC08ibPwa+RsCiPJrsr25PCWXPCGifQDEMDpXLfOEU/piFQKUVHEtu7Ghj
	 L6NXdBSvIQ0x2XMtX+jSs40fTvcZp5THgMe0+sKJaHJW4Ti/589CRaIKERMt06sh3cocH
	 PeLghO+8tWSBnysZaEeNyNWCIDXejV9GZnTeE/swopk3utvlq06cdDSZZoHhMiA+SUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048970;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AUXtqNpBfdF1oS0JWkRLOFwUUDcxIAhLyXIBfGfLdj4=;
	b=j7vBbqOqfcHGvTmwdDbh+S1+P5+XjwZEHeM/hPo4//ERRD4SgBtiQpmIY6bHWOM/ogKY
	 RC/lE4eB1XpjsfidNUfy6/CxDF01W/gq/zvgAPwMXsony6GzYZZZtkZkmarB2L1T/7+k1
	 Gklu2BoB5GTITA7Nc8snahu2tCeQZM4HstRywVY6pdLOfGMCKioZWkpF9RjYwWS1Idw/P
	 JOpMOuf84yh+7Q5QYF1pJsGzvAV/bLZbdTvd5/85Cv2iC0eoEnoOrV2PyST95yLN4fnLR
	 w3Zh6fZi6OsCrLsei0AODwFC6rFKNc9YwBJAko5Kd+qCII4cByri055Y7xAVQ9yr6XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJDgcu78;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EB6606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJDgcu78
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C63F1F0089F;
	Sat,  7 Nov 2026 10:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048969;
	bh=AUXtqNpBfdF1oS0JWkRLOFwUUDcxIAhLyXIBfGfLdj4=;
	h=From:To:Cc:Subject:Date;
	b=eJDgcu789hwgtOdo89w6beIzUyRolr/9lBw6TfWSOF2s11UZQr0bNp9LZCVdjyIJo
	 wc4Ix111wKDtGD0gBoZvQFXWS0RZfByFkkqS9S0eY7WiTyuhqACMc0AdPIDwpgsKPi
	 7kPr4+6EP4+BtLdeZQ3LHYT7U7HsW61g6i8kHJwPlmnzIhYgM7j8bExwMxXaZA8Xcz
	 Xe741cKRLiRs8vN+bn8tzVSvsqQ7O8awavgDutl5JNOi/NLOMe5zjODbWfMKlS4h4a
	 ocHWdAZ6P3uSQ8Rk+YIaPzwybShd37iENaQKnJYrj1Ie3xa7lP6gZHp68WBw7jUbBE
	 6UxiOP/uLmN0Q==
From: Sasha Levin <sashal@kernel.org>
To: william.palacek@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdkfd: Validate the control stack of a restored queue" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:56:07 -0500
Message-ID: <20261107055607-failed-6.1-90d91a192751@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 90d91a192751cd9a7d9d2286299bc72ec1c28179
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055607-failed-6.1-90d91a192751@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 90d91a192751cd9a7d9d2286299bc72ec1c28179 Mon Sep 17 00:00:00 2001
From: William Palacek <William.Palacek@amd.com>
Date: Mon, 19 Oct 2026 15:41:15 -0400
Subject: [PATCH] drm/amdkfd: Validate the control stack of a restored queue

kfd_criu_restore_queue() takes the control stack size from the
checkpoint image without the topology check create-queue does in
kfd_queue_acquire_buffers(), which restore stopped calling in
commit 1cafa8b29e02 ("drm/amdkfd: Don't acquire buffers
during CRIU queue restore."). An image size of 0x300000 is accepted and
sizes the MQD allocation, and 0xFFFFFFFF trips a page allocator warning
in kmalloc().

restore_mqd() also keeps the image's cp_hqd_cntl_stack_size,
cp_hqd_cntl_stack_offset and cp_hqd_wg_state_offset. With offset > size
or wave state offset < size, get_wave_state() returns wrapped sizes.

Take the per-XCC size from topology, 0 for queues without a control
stack, and reject larger images. In restore_mqd(), set the size to it
and bound both offsets as init_mqd() does.

Fixes: 626f7b3190b4 ("drm/amdkfd: CRIU add queues support")
Fixes: 42c6c48214b7 ("drm/amdkfd: CRIU checkpoint and restore queue mqds")
Signed-off-by: William Palacek <William.Palacek@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 92249023caee17bfc6f29c71d6aaa5f2298cf507)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  9 ++++++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  2 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  2 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c  |  2 ++
 .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    |  2 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  2 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |  2 ++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 30 +++++++++++++------
 8 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index 38b46b696243c..d63f7e9fae303 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -138,6 +138,15 @@ struct mqd_manager {
 	uint32_t ctl_stack_size;
 };
 
+/* Keep offset <= size <= wave state offset, as init_mqd() and CP do */
+static inline void kfd_mqd_restore_ctl_stack(u32 *size, u32 *offset, u32 *wg_offset,
+					     u32 ctl_stack_size)
+{
+	*size = ctl_stack_size;
+	*offset = min(*offset, ctl_stack_size);
+	*wg_offset = max(*wg_offset, ctl_stack_size);
+}
+
 struct mqd_user_context_save_area_header {
 	/* Byte offset from start of user context
 	 * save area to the last saved top (lowest
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 4f8a8a1a61860..6c9bafa3962ea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -305,6 +305,8 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 	addr = mqd_mem_obj->gpu_addr;
 
 	memcpy(m, mqd_src, sizeof(*m));
+	kfd_mqd_restore_ctl_stack(&m->cp_hqd_cntl_stack_size, &m->cp_hqd_cntl_stack_offset,
+				  &m->cp_hqd_wg_state_offset, qp->ctl_stack_size);
 
 	*mqd = m;
 	if (gart_addr)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index bf015dc5b8684..5709949de2eb2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -340,6 +340,8 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 	addr = mqd_mem_obj->gpu_addr;
 
 	memcpy(m, mqd_src, sizeof(*m));
+	kfd_mqd_restore_ctl_stack(&m->cp_hqd_cntl_stack_size, &m->cp_hqd_cntl_stack_offset,
+				  &m->cp_hqd_wg_state_offset, qp->ctl_stack_size);
 
 	*mqd = m;
 	if (gart_addr)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index 6ea09b031caf8..aea80266d254e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -393,6 +393,8 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 
 	memset(m, 0, AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size));
 	memcpy(m, mqd_src, sizeof(*m));
+	kfd_mqd_restore_ctl_stack(&m->cp_hqd_cntl_stack_size, &m->cp_hqd_cntl_stack_offset,
+				  &m->cp_hqd_wg_state_offset, qp->ctl_stack_size);
 
 	/* Update MQD base address to the newly allocated location */
 	m->cp_mqd_base_addr_lo = lower_32_bits(addr);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index d508ac5a18f85..33f0ecbe6b0a8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -690,6 +690,8 @@ static void restore_mqd_v12_1(struct mqd_manager *mm, void **mqd,
 	memset(m, 0, AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size) *
 		     NUM_XCC(mm->dev->xcc_mask));
 	memcpy(m, mqd_src, sizeof(*m));
+	kfd_mqd_restore_ctl_stack(&m->cp_hqd_cntl_stack_size, &m->cp_hqd_cntl_stack_offset,
+				  &m->cp_hqd_wg_state_offset, qp->ctl_stack_size);
 
 	/* Update MQD base address to the newly allocated location */
 	m->cp_mqd_base_addr_lo = lower_32_bits(addr);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 6e6bc1ec0b645..fca43017ee7e6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -462,6 +462,8 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 	addr = mqd_mem_obj->gpu_addr;
 
 	memcpy(m, mqd_src, sizeof(*m));
+	kfd_mqd_restore_ctl_stack(&m->cp_hqd_cntl_stack_size, &m->cp_hqd_cntl_stack_offset,
+				  &m->cp_hqd_wg_state_offset, qp->ctl_stack_size);
 
 	*mqd = m;
 	if (gart_addr)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index 029572548c149..5ead0d5613b6d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -317,6 +317,8 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 	addr = mqd_mem_obj->gpu_addr;
 
 	memcpy(m, mqd_src, sizeof(*m));
+	kfd_mqd_restore_ctl_stack(&m->cp_hqd_cntl_stack_size, &m->cp_hqd_cntl_stack_offset,
+				  &m->cp_hqd_wg_state_offset, qp->ctl_stack_size);
 
 	*mqd = m;
 	if (gart_addr)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index a15a826519ad6..78ab759ad8549 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -26,6 +26,7 @@
 #include <linux/list.h>
 #include "kfd_device_queue_manager.h"
 #include "kfd_priv.h"
+#include "kfd_topology.h"
 #include "kfd_kernel_queue.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_reset.h"
@@ -983,7 +984,7 @@ int kfd_criu_checkpoint_queues(struct kfd_process *p,
 }
 
 static void set_queue_properties_from_criu(struct queue_properties *qp,
-					  struct kfd_criu_queue_priv_data *q_data, uint32_t num_xcc)
+					  struct kfd_criu_queue_priv_data *q_data)
 {
 	qp->is_interop = false;
 	qp->queue_percent = q_data->q_percent;
@@ -996,11 +997,6 @@ static void set_queue_properties_from_criu(struct queue_properties *qp,
 	qp->eop_ring_buffer_size = q_data->eop_ring_buffer_size;
 	qp->ctx_save_restore_area_address = q_data->ctx_save_restore_area_address;
 	qp->ctx_save_restore_area_size = q_data->ctx_save_restore_area_size;
-	if (q_data->type == KFD_QUEUE_TYPE_COMPUTE)
-		qp->ctl_stack_size = q_data->ctl_stack_size / num_xcc;
-	else
-		qp->ctl_stack_size = q_data->ctl_stack_size;
-
 	qp->type = q_data->type;
 	qp->format = q_data->format;
 }
@@ -1012,6 +1008,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 {
 	uint8_t *mqd, *ctl_stack, *q_extra_data = NULL;
 	struct kfd_criu_queue_priv_data *q_data;
+	struct kfd_topology_device *topo_dev;
 	struct kfd_process_device *pdd;
 	uint64_t q_extra_data_size;
 	struct queue_properties qp;
@@ -1048,6 +1045,24 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 		goto exit;
 	}
 
+	memset(&qp, 0, sizeof(qp));
+	set_queue_properties_from_criu(&qp, q_data);
+
+	/* Per-XCC control stack size from topology, as create-queue requires */
+	if (qp.type == KFD_QUEUE_TYPE_COMPUTE && pdd->dev->kfd->cwsr_enabled) {
+		topo_dev = kfd_topology_device_by_id(pdd->dev->id);
+		if (!topo_dev) {
+			ret = -EINVAL;
+			goto exit;
+		}
+		qp.ctl_stack_size = topo_dev->node_props.ctl_stack_size;
+	}
+
+	if (q_data->ctl_stack_size > (u64)qp.ctl_stack_size * NUM_XCC(pdd->dev->xcc_mask)) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	*priv_data_offset += sizeof(*q_data);
 	q_extra_data_size = (uint64_t)q_data->ctl_stack_size + q_data->mqd_size;
 
@@ -1077,9 +1092,6 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 	mqd = q_extra_data;
 	ctl_stack = mqd + q_data->mqd_size;
 
-	memset(&qp, 0, sizeof(qp));
-	set_queue_properties_from_criu(&qp, q_data, NUM_XCC(pdd->dev->xcc_mask));
-
 	print_queue_properties(&qp);
 
 	ret = pqm_create_queue(&p->pqm, pdd->dev, &qp, &queue_id, q_data, mqd, ctl_stack, NULL);
-- 
2.53.0




