Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38902305695
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791492327; cv=none; b=a4CCWYWCbJWliEPOvtrXK+oTJsSe382SR9OTFaRDyXX0g9k5cpiwNORSilF6LywSUloqAgcNj96EwEkpYK4eziB2qxysSyvjRWAPfuNTO0nkeYtyomUmGQ+I4CzJqIFWUoSNgWsbLkj0R9ETzZT84c17SpTiE/oTYjw/PMRv9bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791492327; c=relaxed/simple;
	bh=ieMheF/3z2iE6nEdu50rT9jZFBJ6aTbgS79OR2UhemM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T3XgYHEI1XeADDvLcNeLcJEB5vJbTcT847pJ6HKNma5HdT8/i76GPu0iHGA8sNq9QIPWbxzaL655hJ2Bfrfg9aFyHsd7qWJoEH3ShyT0Vwg1tF67Ez9EuLhXWLQhg3xCxhn6yDPNDiIpMtm3JWH6Zb6o3g0mFSkT6BLW1UfdJhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+Ei/KK8; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+Ei/KK8"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so757249a91.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 13:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791492325; x=1792097125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t8+7YdessJC4L0ZspddIBLuS8kurtI2j+Ug8+4jdPNs=;
        b=O+Ei/KK8sABvDlTgnQ9CuopjVM8Eu+qRtrSh4k8ZuCRhBMk+Lc7OLRL1ULC458ERG2
         M2Dtn9Jwgfs8VTWP4SPI8js0uzzcIr2MuptYSeo9zg8ddHw1ECnPdcis5izfv26DVUI+
         ZG2+HT2LZ/9Ly5meR3Sbi3I76N1yLFzm0jPE6pj2fFl7VVPxBoUjtD/h7ukt+FhSWzbL
         gUzBKDsOBb8ApVDoJOGJ3ICWfLdJVxRGDkFG9n9nO6sEBI9OHtDwf1VC6MK6d0u/ZmI/
         BDGm/D10FJmSp47z5ws9xbAP6BKuIhvhq0q4puPe7Ni0I2MwaD82/bweI9c9is3aOaBD
         Diqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791492325; x=1792097125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t8+7YdessJC4L0ZspddIBLuS8kurtI2j+Ug8+4jdPNs=;
        b=alaGQYkDzmKxymFAU5uHcACw077hyUB5FqnZxVRYHegy36MVaFgsv3XnitPrVRl8RE
         riczz6Jtf4rP4PzRGW33+BTv5DdtjzcP6CdqPCt/Q4x5Pdf9fo8Irm40a86mlCz0C/Jq
         utZi9wFITysuWhUgXh1hyXOytbwpvWytsqrXsWOXNyxz3d/n1Dz/r0pEtSL3Boc6kcHO
         S8lD9Dt2hX1axU8zJoE0jbEA9Su0c+qDWhYy+sXLPWKvvZumzcep9QIC9eeu1Af1E8YJ
         22PVKxmKCqY8z9POJyWucIeBKjD5p6tv0/WOucDU0TS6Ufer6sHcVX6nglG4/CVWOmkz
         cSnw==
X-Forwarded-Encrypted: i=1; AKwUvBycRmYIQp4ENrcgF3yDE+Tqhdl//PkUwzqOMjvNZpeciy7/DFPbbykMg+NAR3IaD+6BQt98PfQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDSKAHVa2jTRZYr5mIBB6dJyzujQ7caBfyhokhpNB/+gUaH9QO
	wF2qtp8m/rw07u3O2tLOdxz2aK8nsBSWJuatqrpxDUpkoeEj1K1BSbyE
X-Gm-Gg: AYBFou0+XzPXJhhRcIiTSc08kyzDgpuHnCbTp/pJLaoT8s1GgiKAFJbEEOAaB3LWeJM
	N7cn6yaqzW0zA3eGWUul5fZ8e8TjwkBRXuoY6fJuVoz56Qown8KeFgmF0DJ5ijHe++yuide+GMG
	sMT0yYlm7E+jGFZ9x2jevDZKDUrj4Q12vB5soEX5uTgIjATRUo1WpvAGC5h+q/1mMEX2DSDKYJT
	n/aBROCuUyqL5mqQaVh6lHFqB2FlGEryVcm2DvGJufAztp1nN6qzP4rjDnONdlQXPhOoYgRWsey
	ol6YccSn46YFfglHXg6DBK2sk+zQIjf4tK0dvkuS6Dfy8Q0FI5Zc7OlkyNN4+RVcvywOHdNsm3z
	ssTSPZJQCCUjbCGwaSXseXkEeYoBh683KTcg590WkfIo94z21KTlHwKZAiDfqoBF9gpyo/a1jKJ
	xgfBQp1zZSsnXYTXP5zv2mlOetULgCtNMSKb+M9hU/+V2BhcZCvyCIeyHAzo8JKr1b
X-Received: by 2002:a17:90a:d604:b0:3a7:ed4d:afeb with SMTP id 98e67ed59e1d1-3ab3ab35683mr342a91.27.1791492325448;
        Thu, 08 Oct 2026 13:45:25 -0700 (PDT)
Received: from zeus.home ([101.98.37.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab395e11a0sm107248a91.2.2026.10.08.13.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 13:45:24 -0700 (PDT)
From: John Fisher <jfisher84@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	John Fisher <jfisher84@gmail.com>,
	stable@vger.kernel.org,
	Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2] drm/amdgpu: wait for pending page table updates before switching a VM to CPU updates
Date: Fri,  9 Oct 2026 09:45:17 +1300
Message-ID: <20261008204517.392180-1-jfisher84@gmail.com>
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
walks the reservation with DMA_RESV_USAGE_READ, and the clears of the
VM's page tables (the root PD from amdgpu_vm_init(), and the PDs/PTs
the seq64 mapping allocates at the render node's open) are added there
by amdgpu_vm_sdma_commit() with DMA_RESV_USAGE_BOOKKEEP only:
amdgpu_vm_pt_clear() commits them with a NULL fence, so they do not
reach vm->last_update. The CPU path's own waits (amdgpu_vm_cpu_update(),
amdgpu_bo_kmap()) use DMA_RESV_USAGE_KERNEL. None of them waits for a
clear that is still queued.

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

Record the clears in vm->last_update, as amdgpu_vm_update_pdes() does
with its updates, and wait for it, uninterruptibly, before switching the
update functions. The clears all go through vm->delayed, so the last one
covers the earlier ones; immediate clears are not recorded, as before.

With this, on 7.3-rc6 and on 7.2.9, the same client reads the handler
10 of 10 times, 8 busy queues on the 4 compute slots complete in 5 of 5
runs on 7.3-rc6 and 3 of 3 on 7.2.9 (1 of 6 before), 16 and 32 queues
complete on 7.3-rc6, and two processes with 8 queues each complete
together on both, with no fault.

Fixes: 926c79ad6ecd ("drm/amdgpu: promote the implicit sync to the dependent read fences")
Cc: stable@vger.kernel.org # v6.16+
Cc: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: John Fisher <jfisher84@gmail.com>
---
v2: wait for vm->last_update, in which amdgpu_vm_pt_clear() now records
    the clears, instead of every BOOKKEEP fence on the root PD; wait
    uninterruptibly without checking the result; keep the original
    comment (Christian)
v1: https://lore.kernel.org/amd-gfx/20261007200345.417281-1-jfisher84@gmail.com/

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 5 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 29187fabc..757a037ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2737,10 +2737,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	if (vm->use_cpu_for_update) {
 		/* Sync with last SDMA update/clear before switching to CPU */
-		r = amdgpu_bo_sync_wait(vm->root.bo,
-					AMDGPU_FENCE_OWNER_UNDEFINED, true);
-		if (r)
-			goto unreserve_bo;
+		dma_fence_wait(vm->last_update, false);
 
 		vm->update_funcs = &amdgpu_vm_cpu_funcs;
 		r = amdgpu_vm_pt_map_tables(adev, vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index c03327f12..cdbc2e931 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -427,7 +427,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto exit;
 
-	r = vm->update_funcs->commit(&params, NULL);
+	r = vm->update_funcs->commit(&params, &vm->last_update);
 exit:
 	drm_dev_exit(idx);
 	return r;
-- 
2.55.0

