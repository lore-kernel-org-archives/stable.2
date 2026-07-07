Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44C23EB101;
	Tue,  7 Jul 2026 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437496; cv=none; b=uExma2+gm3btHPTu8s4hXo0Zx5/58uAidTkpHR6LOTbPz08srtbZUr9ejzA+pGLghEhGB7TguEMpFEmk/tTuN6oyhbSZTnOUWkvO7TAuhMeejCOA8JV/tvQcnBDAIolDbFYET+/GE4OnYPzEHQxhtwLT9TUIG+juBKshh18QsRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437496; c=relaxed/simple;
	bh=5MxayHodnSGfkii7mi6rgUk0qIUOnLt1zbmRzeLEfX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=eL9/eed2zZ7YS1p4+B+Ct7GAl73I8VE10LHsT4Dk5YvWrcKaSPtx4we6v8DPy4RyJ6DQMmk4aKOXau36+XcPXVMs6lxlnA5wp2wp0U7Gxt1DPOQhOHOYSI10lvgUrMb9agyZDBsFswe5T41w+M42UPNDs8Rzf5/FFLDlXWh6j/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=Tb5FOq8x; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="Tb5FOq8x"
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667C5b5t2824049;
	Tue, 7 Jul 2026 16:17:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=dk201812; bh=aVN2AK7OQRW2KKVrIHBmc0d
	CluThQO7bdjJzLvFF7HA=; b=Tb5FOq8xPtvzpauYwJ2jgacRVdjj0SUw6Lf39qO
	zONczydkqJcZ45NlEM33KzZCb86qDjEi29n0PeZSn7G4sc3Uz/UnJ9tr5Bxgrd7U
	ebePFlm0I38zwDo9zIq6vBJrHSNK3O6xkIdsZZd2HLgcgWQ11tL99pVI0SsvUcCB
	MkxQKlalMdJFt5Al39oWE/J8JUa9DLAHBjGrw6tmW6SPv5ZRy3PlEnHk5toVXCBs
	SGq2qcmoP7v+HAqPfi/u20dmGlD1dGi2xUwVpDdYUda6miZqWcF5VjFRKKOF7EUV
	E5ta0m4rPyu6W5kY0Tn3D0d6JH/p8ZBRG5GP7GlR0KPQ68w==
Received: from hhmail01.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4f6t8ttxqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 16:17:55 +0100 (BST)
Received: from [127.0.1.1] (172.25.4.227) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 7 Jul
 2026 16:17:54 +0100
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
Date: Tue, 7 Jul 2026 16:17:16 +0100
Subject: [PATCH] drm/imagination: fix error checking of
 pvr_vm_context_lookup()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260707-staging-ddkopsrc-2435-v1-1-24e160d44476@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAHsYTWoC/yXMQQ6CMBBA0auQWTtJaRHQqxgX0BnKaFJIBw0J4
 e5UWb7F/xsoJ2GFe7FB4q+oTDGjvBTgxy4GRqFssMbWpjEN6tIFiQGJ3tOsyaOt3BVvhiqyZet
 a10Nu58SDrP/v43laP/2L/fKbwb4ft6P6X3kAAAA=
X-Change-ID: 20260707-staging-ddkopsrc-2435-90d4d218383b
To: Frank Binns <frank.binns@imgtec.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Boris Brezillon
	<boris.brezillon@collabora.com>,
        Alessio Belle <alessio.belle@imgtec.com>,
        Brajesh Gupta <brajesh.gupta@imgtec.com>,
        Alexandru Dadu
	<alexandru.dadu@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>,
        Luigi Santivetti <luigi.santivetti@imgtec.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783437474; l=4164;
 i=luigi.santivetti@imgtec.com; s=20260707; h=from:subject:message-id;
 bh=5MxayHodnSGfkii7mi6rgUk0qIUOnLt1zbmRzeLEfX4=;
 b=PIDzTxx0NBwSVyxbujiNethUYAk2dkjs158+tpiXMCHxlLV9S8k8B3JukOQ+t5fJ4JsNARkhx
 ohKCEXCNbDgAH09wiWA3ElRePktN10nsXPw3V9qpG67t2EtJuyC/HH6
X-Developer-Key: i=luigi.santivetti@imgtec.com; a=ed25519;
 pk=jS7sCDyWFMopn8iAXVN+AdJi+Z3fZPQKsS5NdQtI+sc=
X-Authority-Analysis: v=2.4 cv=DLW/JSNb c=1 sm=1 tr=0 ts=6a4d18a3 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=eoBRZU4O7WcA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=UMI-ymEwilg7gqftIucA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: KENzqHYRAbMUL8OPgmUYeWifjvVJc0vL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE0OSBTYWx0ZWRfXxtltwOMHTCRT
 rq7RZgKF0AM/H2/jcwWw1g8+YKLLEYXLW2vkUaVL24Sqc3A7XlHr9e3WZOtqdiFOwkM9vaUaRYg
 /q26Pazj2kZwcWAx3+QkJJXfbDAPc3s=
X-Proofpoint-GUID: KENzqHYRAbMUL8OPgmUYeWifjvVJc0vL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE0OSBTYWx0ZWRfX3GqAYpFzzws7
 AMecD1Su5X7u1+lttGbHnvj13Ej7fyGMvOkN2HWgXDs4DB3WRRJjIoCNfqyOe0k0dCn8MeMsdP+
 VyG26zDsVWyWM1tTbRa8aoDkKOXggadpR/wScpsC2Qf/IIQfhGeF7zA1t2hs811D+RCWL6EsxU4
 X3RXKxkzHUv5SzbAFSrf2ESOkSzHDDy5qcK5oq6s+ZRAWS9aKtEvZw+EX2JC/Sca3c2sOrUo9xM
 5hM6GerfNNSAed7nhsHQkYuwKqBw+izRhmdflPP2ahODl9wcXYWqy2QMiOpwdMF73NN52Nh5sup
 VzbYanZ76qsyeHL8vkJCQSlIYZdzoFLOVtKsxMF1EmGovuCUGjz05tvPvgUxQxunwMxmscYQzNc
 byZFYuAQKgfcUlRAOZqqTXqhvSAkgC4BngqGgLfOjvqCIItoP5Lyx/ibcWBURlSAKOwNb/9L2JG
 SbDaUPseSYeiO9VGTlA==

Since pvr_vm_context_lookup() returns either NULL or a pointer, then stop
using IS_ERR() for checking the return value.

Using IS_ERR() leads to the kernel oops reported below. It can be
reproduced by passing an invalid VM context handle from userspace to the
DRM_IOCTL_PVR_CREATE_CONTEXT ioctl.

[   92.733119] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000148
[   92.742042] Mem abort info:
[   92.744890]   ESR = 0x0000000096000004
[   92.748686]   EC = 0x25: DABT (current EL), IL = 32 bits
[   92.754020]   SET = 0, FnV = 0
[   92.757154]   EA = 0, S1PTW = 0
[   92.760337]   FSC = 0x04: level 0 translation fault
[   92.765243] Data abort info:
[   92.768129]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[   92.773626]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   92.778763]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   92.784098] user pgtable: 4k pages, 48-bit VAs, pgdp=000000088ed23000
[   92.790550] [0000000000000148] pgd=0000000000000000, p4d=0000000000000000
[   92.797381] Internal error: Oops: 0000000096000004 [#1]  SMP
[   92.803027] Modules linked in: powervr
[   92.852533] CPU: 0 UID: 0 PID: 409 Comm: triangle Not tainted 7.1.0-rc5-g98b46e693b91 #1 PREEMPT
[   92.861385] Hardware name: Texas Instruments AM68 SK (DT)
[   92.866766] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   92.873709] pc : pvr_vm_get_fw_mem_context+0x0/0xc [powervr]
[   92.879376] lr : pvr_queue_create+0x26c/0x440 [powervr]
[   92.884595] sp : ffff8000837fbb00
[   92.887895] x29: ffff8000837fbb60 x28: 0000000000000000 x27: ffff8000837fbce8
[   92.895015] x26: ffff000807f61a40 x25: ffff000807f61a00 x24: ffff000807f64400
[   92.902135] x23: ffff00080a5ab000 x22: ffff800079b24730 x21: ffff000807f61800
[   92.909254] x20: ffff00080999e680 x19: 0000000000000000 x18: 0000000000000000
[   92.916373] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
[   92.923492] x14: 0000000000000000 x13: 0000000000000002 x12: ffff80008145b298
[   92.930611] x11: ffff8000844e5000 x10: ffff80008165a130 x9 : 0000000000000100
[   92.937730] x8 : 0000000000000001 x7 : ffff0008076b27e0 x6 : ffff00080ec43b7c
[   92.944850] x5 : ffff00080ec43b78 x4 : 0000000000000000 x3 : ffff00080999e680
[   92.951968] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
[   92.959088] Call trace:
[   92.961521]  pvr_vm_get_fw_mem_context+0x0/0xc [powervr] (P)
[   92.967173]  pvr_context_create+0x190/0x410 [powervr]
[   92.972218]  pvr_ioctl_create_context+0x44/0x8c [powervr]
[   92.977608]  drm_ioctl_kernel+0xbc/0x124 [drm]
[   92.982127]  drm_ioctl+0x1f8/0x4dc [drm]
[   92.986098]  __arm64_sys_ioctl+0xac/0x104
[   92.990102]  invoke_syscall+0x54/0x10c
[   92.993842]  el0_svc_common.constprop.0+0x40/0xe0
[   92.998532]  do_el0_svc+0x1c/0x28
[   93.001835]  el0_svc+0x38/0x11c
[   93.004969]  el0t_64_sync_handler+0xa0/0xe4
[   93.009139]  el0t_64_sync+0x198/0x19c
[   93.012792] Code: aa1703e0 d2800014 95cb0ba4 17ffffe8 (f940a400)
[   93.018869] ---[ end trace 0000000000000000 ]---

Fixes: d2d79d29bb98 ("drm/imagination: Implement context creation/destruction ioctls")
Cc: stable@vger.kernel.org
Signed-off-by: Luigi Santivetti <luigi.santivetti@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_context.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_context.c b/drivers/gpu/drm/imagination/pvr_context.c
index eba4694400b5..512f3735223e 100644
--- a/drivers/gpu/drm/imagination/pvr_context.c
+++ b/drivers/gpu/drm/imagination/pvr_context.c
@@ -307,8 +307,8 @@ int pvr_context_create(struct pvr_file *pvr_file, struct drm_pvr_ioctl_create_co
 		goto err_free_ctx;
 
 	ctx->vm_ctx = pvr_vm_context_lookup(pvr_file, args->vm_context_handle);
-	if (IS_ERR(ctx->vm_ctx)) {
-		err = PTR_ERR(ctx->vm_ctx);
+	if (!ctx->vm_ctx) {
+		err = -EINVAL;
 		goto err_free_ctx;
 	}
 

---
base-commit: f7606400f19ca0291718ce4eed5770798890ea2f
change-id: 20260707-staging-ddkopsrc-2435-90d4d218383b

Best regards,
--  
Luigi Santivetti <luigi.santivetti@imgtec.com>

