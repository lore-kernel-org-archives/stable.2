Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426488;
	b=KSaAv0rt47q8Q40AMLQSy5Ip1YXjL5K1H/FDz+YhJVMRc0ansQPfq4grKlc7QNln9a1O
	 RVOn0Dtf9oy1pZeys2CdDck27+phIwv+e9io/8aaRs2Y0JZcz31r2PBSYXtAdhsCi1GfH
	 6yiV1SymeopYa4lMDKw+72Ng7f+76wiDkylwdr+oRn/FS6jRP1d7GjK6kMtaNZKH5vuVO
	 sXrnajdc+F2TH/1SbCZiyEJvNVfJF8nFsJnD1MhyYpfxkpooEyiLtLimNJgyQBc7oxOS8
	 +mBGvDX/RGgK6MixATF+Yd/dyyeXzTanv3Ip0UNRYxAHM4sw5tZscIA1+2e5uQqPwEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426488;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DWksmEDScsCattqytA8LY/p61NG/YAOesboCSTezK2Q=;
	b=OsdhyKc/nVcbtjvAMvD+mncpITkH7CIhnENx0n7/zcAdb6ji0E4qAovQ9IF7sMeF1WQ1
	 OuhsCN1hrjKX6E3DwdNdU2SyOy4ypWfcDHB65z/w+FPhL+z9tFBij/7+inOyRY/OcsL6F
	 WcCvLcPKLsar2y8n9O5s08IZ5Rp9y6Sp2KJqMR3786HMV3IR0Lk3OneWUuJcdQGMq2qlY
	 pdTPdgYiL+KYHwFjq29e4rsseGQ8MuV98XE3WfoJ2HkFZQxJ3MXMtn/tyfXpOHpfMQHI3
	 ctzOIw53rOfI0nP3nA4mShqKEKvQqFFnPlI84/CdTwGdizcDz3oJZKurm4Iyb6CuJFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhgUngev;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF969606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhgUngev
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1408E1F00A05;
	Wed, 11 Nov 2026 19:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426488;
	bh=DWksmEDScsCattqytA8LY/p61NG/YAOesboCSTezK2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DhgUngevcL8I5CA9NUPoe2RgKVCh5Tt6P6HW9mU5JnSxsOJkT4yT+OQ81WkchRNZ+
	 wv+B+09JAjSNBhV/lXzCfYpfots+tWvJMNFiFdaeJznHhPKaaDjsafgR4KyXFdf6j+
	 0KtfzCFZ1V8EjjBpQtneF647NRXnjBZTGyweucSj2V0DLXhWe2oZuPQ6dFAxI3ESmG
	 IvBFsDtf1QCBhkYGP4Yc6rhSlBWcb0SfQUt7RftUutmc/BP7vAnxu+ILYNIFx9Y7ac
	 7bZnuCumFOC0t9RK8psjAFjRo+IAeqySs9gnYOyTDz6mJIcv0TGv/mbh4Xdkk+ESjR
	 qlFBzzffbFE0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: William Palacek <William.Palacek@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/amdkfd: Validate the control stack of a restored queue
Date: Wed, 11 Nov 2026 14:48:06 -0500
Message-ID: <20261111194726.3991358-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051527-failed-6.18-90d91a192751@kernel.org>
References: <20261107051527-failed-6.18-90d91a192751@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: William Palacek <William.Palacek@amd.com>

[ Upstream commit 90d91a192751cd9a7d9d2286299bc72ec1c28179 ]

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
[ sashal: inlined the upstream helper into four existing restore functions to avoid adding a new function ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  3 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  3 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  3 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |  3 ++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 30 +++++++++++++------
 5 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 4a621791da230..99fdbf666c87d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -293,6 +293,9 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 	addr = mqd_mem_obj->gpu_addr;
 
 	memcpy(m, mqd_src, sizeof(*m));
+	m->cp_hqd_cntl_stack_size = qp->ctl_stack_size;
+	m->cp_hqd_cntl_stack_offset = min(m->cp_hqd_cntl_stack_offset, qp->ctl_stack_size);
+	m->cp_hqd_wg_state_offset = max(m->cp_hqd_wg_state_offset, qp->ctl_stack_size);
 
 	*mqd = m;
 	if (gart_addr)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index ca90454b01acc..2f4caf637a065 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -344,6 +344,9 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 	addr = mqd_mem_obj->gpu_addr;
 
 	memcpy(m, mqd_src, sizeof(*m));
+	m->cp_hqd_cntl_stack_size = qp->ctl_stack_size;
+	m->cp_hqd_cntl_stack_offset = min(m->cp_hqd_cntl_stack_offset, qp->ctl_stack_size);
+	m->cp_hqd_wg_state_offset = max(m->cp_hqd_wg_state_offset, qp->ctl_stack_size);
 
 	*mqd = m;
 	if (gart_addr)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index f0e7a7244a33f..e7bb62a0ac7e1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -429,6 +429,9 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 	addr = mqd_mem_obj->gpu_addr;
 
 	memcpy(m, mqd_src, sizeof(*m));
+	m->cp_hqd_cntl_stack_size = qp->ctl_stack_size;
+	m->cp_hqd_cntl_stack_offset = min(m->cp_hqd_cntl_stack_offset, qp->ctl_stack_size);
+	m->cp_hqd_wg_state_offset = max(m->cp_hqd_wg_state_offset, qp->ctl_stack_size);
 
 	*mqd = m;
 	if (gart_addr)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index f0de0893bc597..ae3bd2bb410a5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -305,6 +305,9 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 	addr = mqd_mem_obj->gpu_addr;
 
 	memcpy(m, mqd_src, sizeof(*m));
+	m->cp_hqd_cntl_stack_size = qp->ctl_stack_size;
+	m->cp_hqd_cntl_stack_offset = min(m->cp_hqd_cntl_stack_offset, qp->ctl_stack_size);
+	m->cp_hqd_wg_state_offset = max(m->cp_hqd_wg_state_offset, qp->ctl_stack_size);
 
 	*mqd = m;
 	if (gart_addr)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 6f3cfb9245c4a..b2a0caa7e1ca0 100644
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
@@ -968,7 +969,7 @@ int kfd_criu_checkpoint_queues(struct kfd_process *p,
 }
 
 static void set_queue_properties_from_criu(struct queue_properties *qp,
-					  struct kfd_criu_queue_priv_data *q_data, uint32_t num_xcc)
+					  struct kfd_criu_queue_priv_data *q_data)
 {
 	qp->is_interop = false;
 	qp->queue_percent = q_data->q_percent;
@@ -981,11 +982,6 @@ static void set_queue_properties_from_criu(struct queue_properties *qp,
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
@@ -997,6 +993,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 {
 	uint8_t *mqd, *ctl_stack, *q_extra_data = NULL;
 	struct kfd_criu_queue_priv_data *q_data;
+	struct kfd_topology_device *topo_dev;
 	struct kfd_process_device *pdd;
 	uint64_t q_extra_data_size;
 	struct queue_properties qp;
@@ -1033,6 +1030,24 @@ int kfd_criu_restore_queue(struct kfd_process *p,
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
 
@@ -1062,9 +1077,6 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 	mqd = q_extra_data;
 	ctl_stack = mqd + q_data->mqd_size;
 
-	memset(&qp, 0, sizeof(qp));
-	set_queue_properties_from_criu(&qp, q_data, NUM_XCC(pdd->dev->xcc_mask));
-
 	ret = kfd_queue_acquire_buffers(pdd, &qp);
 	if (ret) {
 		pr_debug("failed to acquire user queue buffers for CRIU\n");
-- 
2.53.0

