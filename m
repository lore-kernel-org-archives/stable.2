Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AC04D990D;
	Fri, 18 Sep 2026 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726018; cv=none; b=GI00JsROWgelWF7n02Ynt2abBwgggwCkffkOsR/C0IlM7YOceeyQzrDnzY7pAqn3JYfF8admOBvEvT1B8AKr+ujJ63YkI6FF+pom+udnnDM9jZTsRHkwZxNpfsBj7+29qDaJw9w/sx234NCaIPshMxvqpWmvKZb/nx0rld768qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726018; c=relaxed/simple;
	bh=rl84C4ONuIM6uvedwccwpsIKbrFWDQorasJcY+NMHR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Z3SB+/bCIbL3KGcSBCh7U26XW+TRzkiqti99ydfNhOZKh0pOwtgfEjskNvv3iQAWQ8uigH+yHRnv/f2Czz5WUO7oaKDA3/aGBRkGcvXe8Id8ND0RAEhjsMxHjT2fj/I/uTHqOqpCmxLgwYRXR8MuLCnwFaI1vBs7wGfH1sEmWMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=RPgNjGPc; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="RPgNjGPc"
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I9dWtV2866830;
	Fri, 18 Sep 2026 11:06:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=W
	FZDtpGn0hp1sx5qqrvhGry+sbXQlcx/KuBrsyBaufo=; b=RPgNjGPcLrLQVeDND
	zfCZctL342JidAs2BQj+frXsAOCusXCZxcSDQSxhIW1LSwiXFTbb2EPQH7rm/LRc
	llmC831a0KelRaikD0l4flZrnRWqdNFMyk0+8HEegpW7VtsUonIQLeM1x4yUJjzp
	jBPVWHpMt+9xovT8IltRokTtlSx0XMJLSKRtgJq4Ikblw7oMLV/r+r2EuzP9EOCx
	WZsOgQhxwWIxL0OsZJZ7JR1gU/gIOsuqDEs5pL+A0wz5udAnwOda/6xmAmwPw9V9
	7eNLujAbzwt77uCJZqqRfy6kU6aHM9sIAhBgJdZIHvFgzYpAMnYYkehVm3aZ5sgi
	q47oA==
Received: from hhmail01.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gmw0q4y2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 11:06:32 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 18 Sep
 2026 11:06:28 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Fri, 18 Sep 2026 15:35:39 +0530
Subject: [PATCH v2 1/2] drm/imagination: Propagate map failures correctly
 from pvr_mmu_map_sgl()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260918-mmu_fix-v2-1-f7c004fbe203@imgtec.com>
References: <20260918-mmu_fix-v2-0-f7c004fbe203@imgtec.com>
In-Reply-To: <20260918-mmu_fix-v2-0-f7c004fbe203@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>,
        Luigi Santivetti
	<luigi.santivetti@imgtec.com>,
        Frank Binns <frank.binns@imgtec.com>,
        Alexandru Dadu <alexandru.dadu@imgtec.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Brajesh Gupta
	<brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4877;
 i=brajesh.gupta@imgtec.com; h=from:subject:message-id;
 bh=rl84C4ONuIM6uvedwccwpsIKbrFWDQorasJcY+NMHR0=;
 b=owEBbQKS/ZANAwAKAdAmd1l+AvFwAcsmYgBqrQ0fOER+EDvEsLJYPVMvIZl50/oPLo0/2/m2U
 yCh/SxmyJeJAjMEAAEKAB0WIQSQIkZAwD1cxcAsz3LQJndZfgLxcAUCaq0NHwAKCRDQJndZfgLx
 cJdNEACjZYEuX0lf/nqQGNSEhQ2nII5frEVv0TaSDDy8eRnQO9K5Jcfea5jTnyJDJSZLR+8ovnQ
 LVt3vsE7lSdh67+6fbO2SoH1A9ATuIArrfTxGnzAepFc3aGIS17AlBWXQGgj8V1jWT6bUenEqc/
 A/Ol82QW37xdtcDxlYntJUYrK1ssghF8/+AQcRnKp31/FCnG0Yqs2kBHIjBLw6FBQoya22uU0Au
 CO0lPF4UZS2r14aVSO5aRLsescjrpNfuY/slAvI2DL6ChJ6wCHMbULv6Bh3IRH226Ate5aTv2nP
 rM0rIdnFERu1NO6JVj/uQGCvT1uNekUvjDu7ze/6QiBU5nCS4ck0pPHEGZ3f+BJ/M7EfsgKDTYL
 sW7zNZuj7+66gvyysm6jim710g1BJmuD6bz/IhJxHTIYnglUBugg/Vt35aew3dmdxZoSy0ajEOt
 gsza1eQW6uYyLPySGJ6QWgQsp7AElW6Wu0AbkC4dPnSzlbIc+OwWvu6+Io2zXjG6Zh+yFuWwhNr
 O3ZUSbIUQ5bYZZkyL/JHnm9H96Ayp5kbmcyZKdhHvzrkESfmX2LtzhIIEVo45uG/fe1S7JKOu+w
 x7zwmbMxU01HodJ0TlkEHv1gemkDazStyP+0j6jwmRFSVOHNIVY0MuoC3QTlQOHQroMT2dhO8qP
 UkCSaLOaBVP4Sbg==
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=openpgp;
 fpr=05BAA300FD5C580EFD3F8D2F073292BAD0D39671
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE0MCBTYWx0ZWRfX0J/Oj2383U5R
 S/ENZ5xbIJHb8h4D7dSeu4me/o4W2RMouoMGy2YWD0M8IKSMcheRbd/RdTdrT2hoojpHOxFafKN
 1NuZDh39PI59EB5RQPc56US7IwWpd+i9DKP/O1udt0hXT+yx7FiNi4j4BFF8JYxrYfSj08KtxR9
 pS91BR1HmusRZMs8m5HH8RicA9nh2p+FFPQ6bdZNokLXwVACE0aEIMXgqhZzBsD21t79/ojQsIm
 tP3XZOwjIKU2WsqjGiQHavXTbeOJoBGTCEBScF053g+0Qwcvx1uP1F8/ze17MsSrKBnX5f2VPY2
 ZaNZRTGZmRhLysriew7QCaNO5+mHDcO32InZRyppqQgbjKgwDx/ROZVwu0mcNu4pAOrfXDilYNS
 M1RDbKHOWXJ+5e1QCQ7gj20tFnCbgdJ8TveXNuMqCe1QOCOzijfEMRgOoVGGmYWYA+BhH8DspMt
 F9rHV03KS2o5on7xyQw==
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6aad0d28 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=HYrZrZQ_E1YA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=MA1SxRKIldkD5NN-sdEA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: Xhn8UgAZYqZrWUWqe7oi5sO-ZTMJlZ0D
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE0MCBTYWx0ZWRfX7qa7MoXhSNu/
 TwhcsK5pDv/01axN1HqlKykWUw4cpX7BCMwE6CgqdL9iA5/ZSfUM6crnJvYVM+Pao/dQc7W/Ff+
 3IAvQMj2O01/etPnVpZ/CcLce4vu9e0=
X-Proofpoint-GUID: Xhn8UgAZYqZrWUWqe7oi5sO-ZTMJlZ0D

Map failure from pvr_mmu_map_sgl() interface was not returned correctly
to pvr_mmu_map() interface. This resulted in pvr_mmu_map() interface to
continue instead of returning an error to caller.
Fix it by returning a proper error code from pvr_mmu_map_sgl() interface.

Call stack for crash:
[ 1179.286237] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
[ 1179.295067] Mem abort info:
[ 1179.297877]   ESR = 0x0000000096000004
[ 1179.301656]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1179.306987]   SET = 0, FnV = 0
[ 1179.310048]   EA = 0, S1PTW = 0
[ 1179.313198]   FSC = 0x04: level 0 translation fault
[ 1179.318096] Data abort info:
[ 1179.320993]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1179.326483]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1179.331546]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1179.336895] user pgtable: 4k pages, 48-bit VAs, pgdp=000000009822a000
[ 1179.343402] [0000000000000008] pgd=0000000000000000, p4d=0000000000000000
[ 1179.350243] Internal error: Oops: 0000000096000004 [#2]  SMP
[ 1179.355908] Modules linked in: powervr gpu_sched drm_shmem_helper drm_gpuvm drm_exec xhci_plat_hcd xhci_hcd dwc3 usbcore usb_common snd_soc_simple_card snd_soc_simple_card_utils dwc3_am62 at24 sa2ul sha512 libsha512 sha256 authenc sch_fq_codel fuse dm_mod ipv6
[ 1179.378992] CPU: 1 UID: 1000 PID: 680 Comm: deqp-vk Tainted: G      D             6.17.0 #1 PREEMPT
[ 1179.388120] Tainted: [D]=DIE
[ 1179.390994] Hardware name: Texas Instruments AM625 SK (DT)
[ 1179.396467] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 1179.403415] pc : pvr_mmu_op_context_unmap_curr_page+0x6c/0x134 [powervr]
[ 1179.410140] lr : pvr_mmu_op_context_unmap_curr_page+0x58/0x134 [powervr]
[ 1179.416848] sp : ffff8000839ab8c0
[ 1179.420153] x29: ffff8000839ab8c0 x28: 0000000000000001 x27: 000000008f386000
[ 1179.427283] x26: ffff000016d1df98 x25: 0000000000247000 x24: 00000000000001e6
[ 1179.434413] x23: 0000000000000002 x22: 000000000000ffff x21: 0000000000000247
[ 1179.441540] x20: 0000000000000245 x19: ffff000016d1df60 x18: 0000000000000002
[ 1179.448668] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
[ 1179.455793] x14: 0000000000060810 x13: ffff80007fffffff x12: ffff000004190480
[ 1179.462921] x11: ffff8000853f7000 x10: ffff8000811ae000 x9 : ffff0000041900b8
[ 1179.470051] x8 : 0000000000000000 x7 : 00000000990c4001 x6 : 0000000000000007
[ 1179.477177] x5 : ffff000016d1df60 x4 : 0000000000000000 x3 : ffff00000a7d8000
[ 1179.484306] x2 : 00000000000001ff x1 : 0000000000000000 x0 : 0000000000000000
[ 1179.491433] Call trace:
[ 1179.493872]  pvr_mmu_op_context_unmap_curr_page+0x6c/0x134 [powervr] (P)
[ 1179.500582]  pvr_mmu_map+0x31c/0x388 [powervr]
[ 1179.505027]  pvr_vm_gpuva_map+0x40/0x88 [powervr]
[ 1179.509732]  __drm_gpuvm_sm_map+0x250/0x44c [drm_gpuvm]
[ 1179.514952]  drm_gpuvm_sm_map+0x48/0x5c [drm_gpuvm]
[ 1179.519822]  pvr_vm_bind_op_exec+0x64/0x70 [powervr]
[ 1179.524785]  pvr_vm_map+0x1f8/0x2a8 [powervr]
[ 1179.529142]  pvr_ioctl_vm_map+0x12c/0x188 [powervr]
[ 1179.534018]  drm_ioctl_kernel+0xb8/0x128
[ 1179.537941]  drm_ioctl+0x21c/0x4ec
[ 1179.541337]  __arm64_sys_ioctl+0xac/0x108
[ 1179.545344]  invoke_syscall+0x44/0x100
[ 1179.549091]  el0_svc_common.constprop.0+0x40/0xe0
[ 1179.553790]  do_el0_svc+0x1c/0x28
[ 1179.557106]  el0_svc+0x34/0xf0
[ 1179.560159]  el0t_64_sync_handler+0xd0/0xe4
[ 1179.564334]  el0t_64_sync+0x198/0x19c
[ 1179.567996] Code: 54000300 35000360 f9402261 79409a62 (f9400421)
[ 1179.574081] ---[ end trace 0000000000000000 ]---

Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>

Reviewed-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
Reviewed-by: Alessio Belle <alessio.belle@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_mmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/imagination/pvr_mmu.c
index 3cac482e1034..23261d9ad3fd 100644
--- a/drivers/gpu/drm/imagination/pvr_mmu.c
+++ b/drivers/gpu/drm/imagination/pvr_mmu.c
@@ -12,6 +12,7 @@
 #include "pvr_rogue_mmu_defs.h"
 
 #include <drm/drm_drv.h>
+#include <drm/drm_print.h>
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/dma-mapping.h>
@@ -2553,7 +2554,9 @@ pvr_mmu_map_sgl(struct pvr_mmu_op_context *op_ctx, struct scatterlist *sgl,
 
 err_destroy_pages:
 	memcpy(&op_ctx->curr_page, &ptr_copy, sizeof(op_ctx->curr_page));
-	err = pvr_mmu_op_context_unmap_curr_page(op_ctx, page);
+	if (pvr_mmu_op_context_unmap_curr_page(op_ctx, page))
+		drm_err(from_pvr_device(op_ctx->mmu_ctx->pvr_dev),
+			"%s : Failure in unmapping pages\n", __func__);
 
 	return err;
 }

-- 
2.43.0

