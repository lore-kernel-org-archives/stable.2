Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427490;
	b=hC/Kkyj+hRLQb7igBNAAu97odmIc4+91q2P6VDoj/egnMqfULqWzN5TY0wvNzxP62qGm
	 XbcOL0eYFjwn9xU/0myas7JU7VRxCr+DWMYGWIcVvdZi4tkquga7boA4hwpgYsDy3eG9e
	 MKJBqGW3cXXfFLO/S2rokzxGY4N3znc9iYAulqeJX+Q03saJXw+WJm+Fyj9U7CWBaXD+j
	 0QjiisMqPO8q2iT+crxD5pCph+H79vuXrK9x9C0v1HSLBBnoxjTGNDV60p8RIi9bDRFuY
	 bvzU3GbSg45kRkU6OufQc4w/3S9G9K130hfcctWQLu8jcHx1DGED3t+2grJwjR4TkGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427490;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=38QkhjhpKBsH2ZMqbX/Tz3AdWK3WaUJwklzBFpRGUCo=;
	b=O01io88Q2ovIf0p+H2yoA7GEbJzOPiN4LInBrpBkVUiGs9/OROuMpn/Iq/zjX+YODB5V
	 NS6KtgzgntDHEpnVFAeq3kHqxhFTAWCOCIJ2MWAZDhjUtr4YYM1GH1i8D9RSKM+OPjeTJ
	 wH77aFRTIb97Sg/fYvvtSKr7ucsmN9gYJ/TJ7LO9qNUP0aSL+gdkdr1N5Z6a5fcKNLvcx
	 2UHfjvK1eltHMZRHzC2hr7Py3pLeNy4CPXP+Uq1LqgL22l+0+a/D5kihr7YFL/PZ9ZxrU
	 BxBP2R/JOmZs4PkIaIM7QJWUQrx6/f7426NcGpr+kePjip6Om5SSLVTXyLlwOyjrlcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILbSg7jN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623D7606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 20:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILbSg7jN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7952F1F00A05;
	Wed, 11 Nov 2026 20:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794427490;
	bh=38QkhjhpKBsH2ZMqbX/Tz3AdWK3WaUJwklzBFpRGUCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ILbSg7jNz8aVzwZ8Is1MVJLn8WK25AEQWouJAy5avNqaliRdC0+LSFLFMOABFjGJF
	 84TlkTuzy8296uARYKa47OECe9+xFOnOneb3dSiH158azI22eIbt3shXtyO+eVJR0Z
	 JIfW9mXXJlB058ny+KTzf6L9rWg61FASS7yg2fxP2OrjKD/3DKpzhwrwwDshQSG+oI
	 pSLyeQ/pXDo7NiPksAZ0LqJrqBdimYyFt3tFkK+CN03yvR6N7CL+cckJrl+kqMmUkd
	 kIHE5ngMGtLmYXn0pAVX0KfY6Hre46g5jHhhSdbK+o5D0OfxdIvOpE8ebO9tkUZR1b
	 WfO5DqYlrTonA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: William Palacek <William.Palacek@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/amdkfd: Validate the control stack of a restored queue
Date: Wed, 11 Nov 2026 15:04:48 -0500
Message-ID: <20261111200359.4024885-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052723-failed-6.12-90d91a192751@kernel.org>
References: <20261107052723-failed-6.12-90d91a192751@kernel.org>
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
[ sashal: Removed the NUM_XCC() multiplier because the existing restore path handles one control stack per image. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  3 +++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  3 +++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  3 +++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |  3 +++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 24 +++++++++++++++----
 5 files changed, 32 insertions(+), 4 deletions(-)

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
index 1e220e8810922..0d22a377f3e33 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -416,6 +416,9 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
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
index bf3c7d055fc33..445fba8e4bbdd 100644
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
@@ -984,7 +985,6 @@ static void set_queue_properties_from_criu(struct queue_properties *qp,
 	qp->eop_ring_buffer_size = q_data->eop_ring_buffer_size;
 	qp->ctx_save_restore_area_address = q_data->ctx_save_restore_area_address;
 	qp->ctx_save_restore_area_size = q_data->ctx_save_restore_area_size;
-	qp->ctl_stack_size = q_data->ctl_stack_size;
 	qp->type = q_data->type;
 	qp->format = q_data->format;
 }
@@ -996,6 +996,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 {
 	uint8_t *mqd, *ctl_stack, *q_extra_data = NULL;
 	struct kfd_criu_queue_priv_data *q_data;
+	struct kfd_topology_device *topo_dev;
 	struct kfd_process_device *pdd;
 	uint64_t q_extra_data_size;
 	struct queue_properties qp;
@@ -1032,6 +1033,24 @@ int kfd_criu_restore_queue(struct kfd_process *p,
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
+	if (q_data->ctl_stack_size > qp.ctl_stack_size) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	*priv_data_offset += sizeof(*q_data);
 	q_extra_data_size = (uint64_t)q_data->ctl_stack_size + q_data->mqd_size;
 
@@ -1058,9 +1077,6 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 	mqd = q_extra_data;
 	ctl_stack = mqd + q_data->mqd_size;
 
-	memset(&qp, 0, sizeof(qp));
-	set_queue_properties_from_criu(&qp, q_data);
-
 	ret = kfd_queue_acquire_buffers(pdd, &qp);
 	if (ret) {
 		pr_debug("failed to acquire user queue buffers for CRIU\n");
-- 
2.53.0

