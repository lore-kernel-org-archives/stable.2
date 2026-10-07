Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C595391E73
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791403437; cv=none; b=PBPmw9lCmD4gPvMg97byoFEjdiYbpo3ZLmCEUkVF5iY08QPqAvYXeFM2z/rMCq7tP7UldmN+aE05BFczXq+ALZwWOHgMyzaI8shX9jdxauiZ45P+5j2S4E4tE0vDBTO2hZkItcABj4VbVUHaKnMq4K0EhLcih6sCaK6uzcOjntM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791403437; c=relaxed/simple;
	bh=0eFXs5BpgVVmA+sCY1Aihq/Lqq68ISyBekwM0BdvAHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hB21DTmESNAV85yTiyDIW4Oke9TIDAhRGgBuus12XHYWTQnFQAWzw9y2SfBhAICmu69DokP0J7mu/xqQME/hrCugchkeQU+vpJWcBszuaOTvrH+4JKSaajYvUUqWcj21pT9TMomTuay/GII7etr4vMlQ7yJjEt5I7WSWwiBma5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sx5Dcsul; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sx5Dcsul"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e4a341d177so25650095ad.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 13:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791403435; x=1792008235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s7lDZIBY8lMNVjYdiqzEHceMRcM1xIgWuBduaZnZSEc=;
        b=Sx5Dcsul/1UouUTOgQTYSUJFL0ipe5FPriuB0Ezh9ZUx13O2jckzAbHPEVuIyzNXj/
         4n7v4d/KkqZbmIJDT7wUryJVzDClN/IWuH0yy7iBYyK+SXRTx+UL29VMVbUYXcJf8VBv
         PEXMom7bIB6A9ByyuWhEuIrpILG5ZuE2oLqa3PnVpXJgjUZKbUC/6XeNHEWszuQrRscN
         Ld9lC1+P+aoH4+m7JhYOe1fyTqlNKVDg/3/+98pxYBnHcwuTfHt29xVb7lfI3R+g102h
         ee6jiFoJcFfBobUenTZiwwxPrPdomVnbFV/sSk+afHTkmR+/29vSes5Ugzk/YHL43Dj9
         8DOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791403435; x=1792008235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s7lDZIBY8lMNVjYdiqzEHceMRcM1xIgWuBduaZnZSEc=;
        b=u2foESNZ/EBkc/ASQnwci36bK2ZLspPj4QI4LZGSAMbr3ArxknrxjSHMYgtFmSfNBK
         RHCZoKGzPX4+eCxmLyeII1wvZJ6LaAh3hKcCCXXZj87veCJea9YS0ABHlREYZZbJ+Al7
         RQctQktRpu6w4xQewA7cMIu5LxO6802KksgoyR1glrml51GhPy0S6C7kLeCYi403i0os
         D4A2KkfwT/MpkaQMj4K0Pf+dJiz9uvj7f4/R9GP+xR3cJ69Ca/oFBesAHg308ii0QPUQ
         u0aCgYFMARp3y0gFzyohF44fEqRGZtNYCbmBFJEI6R0yCGsS/iZHC6NgRcbAlzFNWvYo
         3XwQ==
X-Forwarded-Encrypted: i=1; AKwUvBxm98nkMrbqm7cOMKEE0mdBI0oNWIgfOzWy3psKBL0QGzXOG6fT2a+ECL5V3WqGsZgmM6I/vbw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcI/B6X+dNj4uwjkB5rTlZvL+lnbMSjqiZ5BuLvzdiloQtN3qi
	FzPs8H9SwBCysegoAY0B0+i2kI/ay3dwDx+GOpsrvfaA+9gF57vLgWAN
X-Gm-Gg: AYBFou1Rf350Q5dZhmUaySDNS76uoU7rcfyMiH3Vfpab25ACNp7GdLALijVm8DWCvRw
	E5PKYb3qGzn3BeWSo/SzeZf0i57D1PV9YWS8IWr+27Bzl1vD9UxL6BI4mroXIJoAeMDk/ecstyq
	/r3R89YoJ4kMtacFtt+KNO0QQC/TcgM/RWNBPX+Bp06SHc0fS1dj7s2WsMCMmwTTQJ8icX9hStB
	mqzKRPAWcL693buwczR90i67dfXW85uY1AXeCNvya2tNQC4YnNJ8qLhaAcnbBaREET+HjjgX9yM
	fBJIsnztw2EWXghqmb/2Zl5oY8/krlObMu8JVUXGbTKv5qXxNb8d/lQ6yjrngfgyD4qaKNcX2Qp
	nma+GfGqgf2dlCkteJFdpXH4MdejuSiLGEoidkmF/bzAAotyaGb2il+olKNDCQdU+oCQKp6b6RX
	YF9YQwPyftCESTP4n/bT5Je6tebZjNnpJI9byAOl2Oa6+MQ5dum12zTAD9xA8lexnn
X-Received: by 2002:a17:902:f54c:b0:2df:8f19:5db8 with SMTP id d9443c01a7336-2e6005e2f9dmr27584935ad.59.1791403435502;
        Wed, 07 Oct 2026 13:03:55 -0700 (PDT)
Received: from zeus.home ([101.98.37.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e604720e92sm16386455ad.38.2026.10.07.13.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 13:03:54 -0700 (PDT)
From: John Fisher <jfisher84@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	John Fisher <jfisher84@gmail.com>,
	stable@vger.kernel.org,
	Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: wait for pending page table updates before switching a VM to CPU updates
Date: Thu,  8 Oct 2026 09:03:45 +1300
Message-ID: <20261007200345.417281-1-jfisher84@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amdgpu_vm_make_compute() switches a VM from SDMA to CPU page table
updates when a KFD process acquires it. It syncs "with the last SDMA
update/clear" through amdgpu_bo_sync_wait() on the root PD, but that
walks the reservation with DMA_RESV_USAGE_READ, and the VM's own page
table jobs (the root clear from amdgpu_vm_init(), and the PD/PT clears
and the seq64 mapping from the render node's open) are added by
amdgpu_vm_sdma_commit() with DMA_RESV_USAGE_BOOKKEEP. The CPU path's own
waits (amdgpu_vm_cpu_update(), amdgpu_bo_kmap()) use
DMA_RESV_USAGE_KERNEL. None of them waits for a clear that is still
queued.

When one is, the CPU writes the first entries of the new compute VM (the
KFD trap handler's TBA/TMA page at AMDGPU_VA_RESERVED_TRAP_START, mapped
during ACQUIRE_VM) into a page directory the SDMA then clears. The
entries are gone, the handler's page is unmapped, and the first wave
save of any queue of the process faults in the SQC instruction fetch at
the handler's address (GCVM_L2_PROTECTION_FAULT_STATUS 0x008012B1,
PERMISSION_FAULTS 0xb). The MES then fails REMOVE_QUEUE and SUSPEND, and
the device takes a MODE1 reset with VRAM lost on 7.2.9; on 7.3-rc6 the
queue is reset instead.

The window is the time between the render node's open and ACQUIRE_VM.
ROCr spends milliseconds there and is practically never hit; a minimal
KFD client that opens the render node and acquires the VM at once is hit
most of the time. On a Radeon AI PRO R9700 (gfx1201, Resizable BAR, so
vm_update_mode defaults to CPU updates for compute VMs), a wave reading
the trap handler's page right after queue creation found it unmapped in
8 of 12 runs; a 5 ms sleep between the open and ACQUIRE_VM made that 0
of 9, and the same sleep after queue creation instead 3 of 3.

The wait covered these jobs until commit 926c79ad6ecd ("drm/amdgpu:
promote the implicit sync to the dependent read fences") narrowed
amdgpu_sync_resv() from DMA_RESV_USAGE_BOOKKEEP to DMA_RESV_USAGE_READ;
the VM's page table jobs have been added with BOOKKEEP since commit
4247084057cf ("drm/amdgpu: use DMA_RESV_USAGE_BOOKKEEP v2"), so from
v6.16 on the sync in amdgpu_vm_make_compute() waits for nothing of
them.

Wait for every fence on the root PD's reservation before switching the
update functions. With this the same client reads the handler 10 of 10
times, 8 busy queues on the 4 compute slots complete in 5 of 5 runs
(1 of 6 before), and two processes with 8 queues each complete together,
with no fault.

Fixes: 926c79ad6ecd ("drm/amdgpu: promote the implicit sync to the dependent read fences")
Cc: stable@vger.kernel.org # v6.16+
Cc: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: John Fisher <jfisher84@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 29187fabc..8d0c03a40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2736,11 +2736,20 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		  "CPU update of VM recommended only for large BAR system\n");
 
 	if (vm->use_cpu_for_update) {
-		/* Sync with last SDMA update/clear before switching to CPU */
-		r = amdgpu_bo_sync_wait(vm->root.bo,
-					AMDGPU_FENCE_OWNER_UNDEFINED, true);
-		if (r)
+		/*
+		 * Sync with the last SDMA update/clear before switching to CPU
+		 * updates. The VM's own page table updates are tracked with
+		 * DMA_RESV_USAGE_BOOKKEEP on the root PD, which
+		 * amdgpu_bo_sync_wait() does not wait for: a clear of a PD still
+		 * pending here lands after the CPU has written its entries.
+		 */
+		long t = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
+					       DMA_RESV_USAGE_BOOKKEEP, true,
+					       MAX_SCHEDULE_TIMEOUT);
+		if (t < 0) {
+			r = t;
 			goto unreserve_bo;
+		}
 
 		vm->update_funcs = &amdgpu_vm_cpu_funcs;
 		r = amdgpu_vm_pt_map_tables(adev, vm);
-- 
2.55.0

