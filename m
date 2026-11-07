Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047245;
	b=CtqoUerm6WcpEO3E8pXNJANvvV+cjWoN6E6W/Pf9qEExER09AoSZ45sUapozEiTO6ju9
	 FBKCS0awVCX9UNKdlvVw6mmTK87RwRolHQ2ZuyEQFGVpv+7lTA/CO8lah5ix7XT55K0r+
	 786kMqYUrUuiIo2HPUFmaWBlHtFmDmLx2ysX+9gJEyWIsM2f8theZuq02GEV7xXgvhY3M
	 0hr3Ygt83mvUHxqFHS39V9nTwjjtXcND0SvZruUCTCdpCqGy2PsxdjiGHSr2IK+EjPXWz
	 hZ9wAdvnNcmmBa5mF2gHVn/adfcARfV3cn2B4Q1A7DRtvHL0GlTUL7MCSMr80ZJl73g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047245;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HtZ/KSW571o1g5ZQL29KzrVMZ/W7SHjTYMJgu/VqPUA=;
	b=ELxqkzClwYhVLCaXvGqZx3e23awwz+RlYKxLdmqhsUkFpMBok4s4KZtOzOmGhg/tJPLW
	 7ESM7mKSVl+gWfnzqX+YpNsfInGeUlLlyRI/yJvkQKibLCRtP+YImY2uSJxlJiM6eWVxC
	 aBZp1qJOl6qPNuoxcbrgSn7pYv+FiC/M4+JJP/CWFukMu38ckzlGdj2ZmnERHna1QW/0/
	 A7eOCocqpiz/6SABSjPEi9OE3NkvfcM8ByixOPrAX2hFkb3+W/aFYkuMgRNLeraJOu/dV
	 86CRoNkQY/+4r0jjNm8zjhhmIv9fT5Sa7zEFnahr17SGMJ+LHl4SlE/e4rlyajpIaHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nuxa0Ilc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78D4606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nuxa0Ilc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634561F008AB;
	Sat,  7 Nov 2026 10:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047244;
	bh=HtZ/KSW571o1g5ZQL29KzrVMZ/W7SHjTYMJgu/VqPUA=;
	h=From:To:Cc:Subject:Date;
	b=Nuxa0Ilcs4U1oNW3oc1l+d52eXVuqkq4UwSDqksCZDKj6Z8hwU2OsfUqF5g8iSRaB
	 rcQPvM6+1hXNUYKUlY9ojC/pjots78CZOxdqpu6dQV9A1c1fsZXuz9dCoEGGd8bOl8
	 RrXxTXQFs9ACrcWn6DDiYT/8E0RC8FqmEBXFIs34LIVzHpIbzgJN8mpRQgkVQfw70Q
	 1qOQnhhtf34zu8VvQZbaQGJlBhZJB6rIdguXRK3D29eIWYH+sTRSVmMUxJ1s4Saoz1
	 VY/OkO4qbFjvrd5GfaIRyyTK5fzws1e+MRX3O1hkqFjteSc1X3yMYHjd6eKCJSqF9L
	 YDBN7uSlO5aaA==
From: Sasha Levin <sashal@kernel.org>
To: william.palacek@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdkfd: Validate the control stack of a restored queue" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:27:23 -0500
Message-ID: <20261107052723-failed-6.12-90d91a192751@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 90d91a192751cd9a7d9d2286299bc72ec1c28179
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052723-failed-6.12-90d91a192751@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




