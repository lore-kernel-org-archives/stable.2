Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965119D074
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 04:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791348219; cv=none; b=okfuUO6MIGqGDoDfrXRn/3h9jv0F3AzzDNqCYAn77Dfxfj1I8gKxLe7MOoLonSlXDHXR6PkK5igpg6fGLiRhMUwSq6wGa4KDTWFBbzW93E3ElgKuDXSr9W52YrlaOCzgvbuphgTnAZ9tA2grEYVZsKDq+cqoe39zXv6GZbR+Kgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791348219; c=relaxed/simple;
	bh=Abhf7wQedAA4mjmyfSLKzCZm0fqlmiPwwk+pPhg/lpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLPUNq0PYj1bzHj8fmkpgD7aexWyePkk92X3KMVp8sK0fYhGAJisuHWF23LdO8zWnSgFdOR2WlCBwMeF7yRy5ZwU3qQxm4dYJ3AMThvvxRIRDgs1+RtW46krktfSyZyKJB2uVADxt6ldIMKfXHHgpwIKSElLyNU9SwP9iMHsm6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFwlsSum; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFwlsSum"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso13901855e9.1
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 21:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791348215; x=1791953015; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b1HuFR8agEXVgqM+as/BjvLma4ckxiqs7rJca0XX/ag=;
        b=EFwlsSumnp5R+d6TWwtU3CgLqWOh/oUALwbLh+jY8ftL8jrEv6K+t4mGd/cIeAByuU
         721Tb9J1gw0eg53bEN5fCt6/RBsTyw/X4DoFhvnsJjhDQqTO8EfRUL2ZPvLA5NTLl00a
         VSl+zRqLNGBwrOwfDUuNeivsGK9l7DMBBIBsFA85yXg6t6ycTtuD8VdHQnBoCSoWjLyh
         +XQW9R0lmnYn8TJXhgmFda3j38zEexLBKRauQ3iAyG9tkHfgSK5Os+B738Kbv2svCEf4
         hV1j3ojFgyyGMVxQPngacTWR27JC6PpctA6Wf5O5auRhcpQPoiT26S/nZhAMmnGtb4mv
         gwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791348215; x=1791953015;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b1HuFR8agEXVgqM+as/BjvLma4ckxiqs7rJca0XX/ag=;
        b=bxlLaHjpSmCySH+oeamUxu+xOTUwmxJnYjLqliapxHkWfAA22fMhNQUaG4m00cV+2G
         56wJWU5+zhT0mK2dc1ORO0gGBPzravkWhHJlYg1jD3SvhG8QM+cmXBhvZ1grNKCkvZyF
         8Wt+dhMRtlj7IAZOpzzlg7+stbPK4/TL53r+fwhlsbviybjpPvONjTB0/HMKoHrZf8Lv
         gBwp+5pog/FijkfORix2CM3bd3/xJHo8XcJYgwnymAOcX/jtG23f53F+COEazTovWlWb
         uh+t7xmz4D26zxZmHmwZu72CU8cwXqe9Rwlh5WViSufIgeCqOLVVPIGa3tEv0NBhOkC2
         puvw==
X-Forwarded-Encrypted: i=1; AKwUvBxKz/9L/DmF5GRQtSM5C7WFCuxRGuIa09gDkfQcv3vjk88wAnEz/4F+wR4Wh/910THxCABoKho=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlhvkYtYB46EuFCyOdLA/EFy9z+IpqHqXJJ1d5VashOzCpBlQX
	iEY2hTvBOgKvn/dLL4PILtOvd0c0g7NlibaYHDkXqM9utkv1RNzBaV58
X-Gm-Gg: AYBFou3gXNM4GubnPTC/UIZD3WbBb7nXa7pq5+6dqXisTAOr7G2hJIGpR5TcwKFQVkh
	UXjbxsgj1bfqTsK9dYd3ypgqBVBE1JoWJlyzMaPalcfq1oGHWFZ6TpHoS74tXrLA2B+E2ufJcMd
	jwuTuvnwdrcnou14cueOTAmtxBz3tz/i3CisAXkS74CFSKCKiIt0zQER6XJM8Zi2s0gA00CZWw6
	JqJgyVYlF+Vchp/4BUAltQO0xuRPbxoZ5+WePui/6NHUlA27Kls2QqDA4Iz5jYqFBZAZA6qNCVW
	4yMTMDES074Nz+PFv7b7bxTs4A7e3/lqLoY2VQa/tVeSns6tZuMhwk85HH1F50Xd2w6IVH90tM4
	9BSS6MPRu2/OfdoN1azSszJBUgVH5CwX5HAkIV2SMGNvztQX/p5XEorbTVrlQovgYxRVo53ANpl
	uanipfM4+ZkBlgHUwMcgK6GTbOYFLTXBewoFVKzAA8mNdaAJliaJV/hv/msno/WN9v
X-Received: by 2002:a05:6000:2506:b0:48c:70ef:e798 with SMTP id ffacd0b85a97d-48c72780792mr2048321f8f.19.1791348215206;
        Tue, 06 Oct 2026 21:43:35 -0700 (PDT)
Received: from beelink.. ([212.23.215.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d10309sm2999606f8f.22.2026.10.06.21.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 21:43:33 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: maaz.mombasawala@broadcom.com,
	zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org,
	christian.koenig@amd.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/vmwgfx: do not hand the embedded sg_table to the PRIME core
Date: Wed,  7 Oct 2026 01:43:10 -0300
Message-ID: <20261007044312.2152404-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DLX6J39ZERYJ.377I7R20BGISX@broadcom.com>
References: <DLX6J39ZERYJ.377I7R20BGISX@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Maaz,

I reproduced the bug on VMware Workstation with a kernel based on
mainline (commit 6edd14dd67d7, v7.3-rc4), with the vgem test
modification described below. Below is the setup, the KASAN splat,
and notes on reproducing.

Regarding your October 3 question about drm-misc-fixes: as of
2026-10-06, I searched for "vmw_gem_object_get_sg_table drm-misc-fixes"
and found no indexed commit fixing this function's embedded sg_table
ownership issue. The published drm-misc-fixes-2026-10-01 pull request
lists vmwgfx input validation and blend-mode changes, not this fix [1].
I could not access the branch's live file history, so I cannot confirm
that no commit touching vmw_gem_object_get_sg_table exists at its current
tip. The vgem import-path change described below can prevent the test
from reaching the affected callback without fixing that callback.

[1] https://www.mail-archive.com/dri-devel%40lists.freedesktop.org/msg641567.html

Setup:
  - VMware Workstation 26.0.0 (build 25388281) on Ubuntu 24.04 host
  - Guest: Debian 12 (bookworm), CONFIG_KASAN=y
  - Kernel: commit 6edd14dd67d76d39a518ad3bf1a98363690a5a62 (v7.3-rc4)
  - vmwgfx loaded as module (out-of-tree rebuild from same tree)
  - Second DRM device: vgem (with gem_prime_import_sg_table enabled,
    see note below)
  - PoC runs as UID 65534 (nobody), no capabilities

KASAN splat (the v7.3-rc4 commit above, VMware Workstation):

The runtime release string in the unedited trace below is 7.3.0-rc4+.

  BUG: KASAN: invalid-free in dma_buf_unmap_attachment+0xaa/0x1d0
  Free of addr ffff888104489960 by task poc_sgtable/354

  CPU: 0 UID: 65534 PID: 354 Comm: poc_sgtable Tainted: G  OE  7.3.0-rc4+ #16
  Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/17/2026
  Call Trace:
   <TASK>
   dump_stack_lvl+0x60/0x80
   print_report+0xd0/0x630
   kasan_report_invalid_free+0x9e/0xc0
   check_slab_allocation+0xf5/0x100
   kfree+0x166/0x420
   dma_buf_unmap_attachment+0xaa/0x1d0
   dma_buf_unmap_attachment_unlocked+0x80/0x100
   drm_prime_gem_destroy+0x42/0x90 [drm]
   drm_gem_shmem_release+0x71/0x800 [drm_shmem_helper]
   drm_gem_shmem_object_free+0x9/0x20 [drm_shmem_helper]
   drm_gem_object_release_handle+0xaf/0x220 [drm]
   drm_gem_handle_delete+0x59/0xa0 [drm]
   drm_ioctl_kernel+0x163/0x2d0 [drm]
   drm_ioctl+0x4ce/0xb10 [drm]
   __x64_sys_ioctl+0x135/0x1c0
   do_syscall_64+0xc1/0x560
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

Steps to reproduce:
  1. DRM_VMW_ALLOC_DMABUF(262144) on vmwgfx renderD128
  2. DRM_IOCTL_PRIME_HANDLE_TO_FD
  3. DRM_VMW_GB_SURFACE_CREATE_EXT 64x64 (BO size 262144 bytes)
  4. EXECBUF BIND_GB_SURFACE(sid, mobid=handle)
     -> vmw_ttm_bind -> vmw_ttm_map_dma
     -> caches vsgt.sgt = &vmw_tt->sgt (embedded member)
  5. DRM_IOCTL_PRIME_FD_TO_HANDLE on a second DRM device (vgem)
     -> dma_buf_map_attachment -> drm_gem_map_dma_buf
     -> vmw_gem_object_get_sg_table returns &vmw_tt->sgt
  6. Close the importing GEM handle (DRM_IOCTL_GEM_CLOSE or fd close)
     -> drm_prime_gem_destroy -> dma_buf_unmap_attachment
     -> drm_gem_unmap_dma_buf: sg_free_table + kfree(&vmw_tt->sgt)
     (drm_gem_unmap_dma_buf elided in trace by tail-call optimization)
     => KASAN: invalid-free (interior pointer of vmw_ttm_tt object)

Note on the importing device:

The bug is in vmwgfx's vmw_gem_object_get_sg_table() which returns
an interior pointer (&vmw_tt->sgt) that the DRM core later kfree()s.
Any importing driver that calls dma_buf_map_attachment() triggers it,
provided the BO has been DMA-mapped (vsgt.sgt cached by a prior
surface bind), as demonstrated with vgem configured with
gem_prime_import_sg_table. This was tested with vgem; the statement
about other importing drivers is an inference from the shared PRIME
map/unmap path.

On mainline, vgem recently switched to drm_gem_shmem_prime_import_no_map
(commit 660cd44659a0, "drm/shmem-helper: Import dmabuf without mapping
its sg_table") which skips the map/unmap cycle entirely. This means
vgem no longer exercises the buggy path by default. For this reproduction,
I set .gem_prime_import_sg_table = drm_gem_shmem_prime_import_sg_table
in vgem_drv.c to use the mapping import path (one-line change, no
modification to vmwgfx).

The vgem change avoids the affected path for vgem specifically, but
the underlying vmwgfx defect is unresolved: vmw_gem_object_get_sg_table()
still returns an interior pointer when vsgt.sgt is cached on the
tested kernel. The invalid kfree was demonstrated with vgem configured
with gem_prime_import_sg_table; other importing drivers were not tested.

I also confirmed the invalid-free on kernel 6.12.0 running on
VMware Workstation, where vgem still uses the mapping import path
and no vgem modification is needed:

  BUG: KASAN: invalid-free in dma_buf_detach+0x147/0x4e0
  Free of addr ffff88811813e250 by task poc_sgtable/521

  CPU: 3 UID: 65534 PID: 521 Comm: poc_sgtable Tainted: G  OE  6.12.0 #3
  Hardware name: VMware, Inc. VMware Virtual Platform
  Call Trace:
   kasan_report_invalid_free+0x90/0xb0
   check_slab_allocation+0xf5/0x100
   kfree+0xd3/0x400
   dma_buf_detach+0x147/0x4e0
   drm_prime_gem_destroy+0x67/0x90 [drm]
   drm_gem_shmem_free+0x71/0x520 [drm_shmem_helper]
   drm_gem_handle_delete+0xd9/0x140 [drm]

Patch used for the comparison:

UNFIXED means vmwgfx built from commit
6edd14dd67d76d39a518ad3bf1a98363690a5a62 (v7.3-rc4). FIXED means the
same commit with the change below applied to vmw_gem_object_get_sg_table().

This patch contains two changes:
  (a) Add a NULL-check for bo->ttm before dereferencing it via
      container_of, returning -ENODEV if the TTM backend is absent.
  (b) Always return a freshly allocated sg_table via
      drm_prime_pages_to_sg() instead of returning the cached
      vsgt.sgt interior pointer, which is the root cause of the
      invalid kfree.

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
index 39f8c46550c2..98c5e42cc762 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
@@ -70,13 +70,15 @@ static void vmw_gem_object_unpin(struct drm_gem_object *obj)
 static struct sg_table *vmw_gem_object_get_sg_table(struct drm_gem_object *obj)
 {
 	struct ttm_buffer_object *bo = drm_gem_ttm_of_gem(obj);
-	struct vmw_ttm_tt *vmw_tt =
-		container_of(bo->ttm, struct vmw_ttm_tt, dma_ttm);
+	struct vmw_ttm_tt *vmw_tt;

-	if (vmw_tt->vsgt.sgt)
-		return vmw_tt->vsgt.sgt;
+	if (!bo->ttm)
+		return ERR_PTR(-ENODEV);

-	return drm_prime_pages_to_sg(obj->dev, vmw_tt->dma_ttm.pages, vmw_tt->dma_ttm.num_pages);
+	vmw_tt = container_of(bo->ttm, struct vmw_ttm_tt, dma_ttm);
+
+	return drm_prime_pages_to_sg(obj->dev, vmw_tt->dma_ttm.pages,
+				     vmw_tt->dma_ttm.num_pages);
 }

 static int vmw_gem_vmap(struct drm_gem_object *obj, struct iosys_map *map)

IGT regression test (existing suite):

I ran the igt-gpu-tools vmwgfx test suite on the same kernel
(6edd14dd67d76d39a518ad3bf1a98363690a5a62, v7.3-rc4,
VMware Workstation, Debian 12), swapping vmwgfx.ko built without and
with the fix described above at runtime via rmmod/insmod. Results
are identical -- no additional failures:

  IGT version: 2.6-NO-GIT (source from commit 5e43e9d, built from tarball)
  Invocations:
    sudo /usr/local/igt/vmwgfx/vmw_execution_buffer
    sudo /usr/local/igt/vmwgfx/vmw_mob_stress
    sudo /usr/local/igt/vmwgfx/vmw_ref_count
    sudo /usr/local/igt/vmwgfx/vmw_surface_copy
    sudo /usr/local/igt/vmwgfx/vmw_tri
    sudo /usr/local/igt/vmwgfx/vmw_prime

                                                            UNFIXED    FIXED
  vmw_execution_buffer:
    mob-create-map:                                         SUCCESS    SUCCESS
    buffer-create:                                          SUCCESS    SUCCESS
    execution-buffer-submit-sync:                           SUCCESS    SUCCESS
  vmw_mob_stress:
    max_mob_mem_stress:                                     FAIL       FAIL       (pre-existing)
  vmw_ref_count:
    surface_prime_transfer_explicit_mob:                    SUCCESS    SUCCESS
    surface_prime_transfer_implicit_mob:                    SUCCESS    SUCCESS
    surface_prime_transfer_fd_dup:                          SUCCESS    SUCCESS
    surface_prime_transfer_two_surfaces:                    SUCCESS    SUCCESS
    surface_prime_transfer_single_surface_multiple_handle:  SUCCESS    SUCCESS
    mob_repeated_unref:                                     SUCCESS    SUCCESS
    surface_repeated_unref:                                 SUCCESS    SUCCESS
    surface_alloc_ref_unref:                                SUCCESS    SUCCESS
    surface_buffer_ref:                                     SUCCESS    SUCCESS
    surface_prime_refs:                                     SUCCESS    SUCCESS
    surface_buffer_prime_refs:                              SUCCESS    SUCCESS
  vmw_surface_copy:
    test_invalid_copies:                                    SUCCESS    SUCCESS
    test_invalid_copies_3d:                                 SUCCESS    SUCCESS
  vmw_tri:
    tri:                                                    FAIL       FAIL       (pre-existing)
    tri-no-sync-coherent:                                   FAIL       FAIL       (pre-existing)
    tri-2d:                                                 SUCCESS    SUCCESS
  vmw_prime:
    basic-vgem:                                             SUCCESS    SUCCESS
    tri-map-gem:                                            FAIL       FAIL       (pre-existing)
    tri-map-dmabuf:                                         FAIL       FAIL       (pre-existing)
    draw-dumb-buffer:                                       FAIL       FAIL       (pre-existing)
    buffer-surface-fb-sharing-sync-readback:                      FAIL       FAIL       (pre-existing)
    buffer-surface-fb-sharing-sync:                         FAIL       FAIL       (pre-existing)
    buffer-surface-fb-sharing:                              FAIL       FAIL       (pre-existing)
18 SUCCESS, 9 FAIL (all pre-existing, identical in both runs).
Every subtest listed individually. No additional failures from
the fix.

IGT regression test (new sgtable-invalid-free subtest):

I also wrote and compiled a dedicated IGT subtest
(vmw_prime_sgtable) that exercises the same PRIME
export/import/close flow from the standalone reproducer. It was
compiled against the igt-gpu-tools tree and executed on the same
kernel (v7.3-rc4, VMware Workstation, CONFIG_KASAN=y), with the
same vgem mapping-import configuration described above. Results:

  - UNFIXED vmwgfx: subtest sgtable-invalid-free SUCCESS.
    Immediately afterward, a TTM cleanup worker Oopsed in
    dma_direct_unmap_sg, with vmw_ttm_unmap_dma in the call
    trace. This is consistent with corruption of the sg_table
    used during cleanup.
  - FIXED vmwgfx: subtest sgtable-invalid-free SUCCESS.
    dmesg after the test shows no Oops, no KASAN reports,
    no BUG. A separate WARNING from vmw_cmdbuf_ctx_process
    (command buffer error during EXECBUF) appears in dmesg;
    it is distinct from the sg_table invalid-free reported
    here.

Full IGT logs follow in two replies to this message (unfixed and
fixed runs).

Standalone reproducer results:

The standalone reproducer (vmw_sgtable_test.c) was compiled and
executed on VMware Workstation 26.0.0, kernel commit
6edd14dd67d76d39a518ad3bf1a98363690a5a62 (v7.3-rc4), without and
with the fix described above:
  - UNFIXED vmwgfx: BUG: KASAN: invalid-free in dma_buf_unmap_attachment
  - FIXED vmwgfx:   clean (no KASAN)

Both the standalone reproducer and the IGT testcase were compiled and
executed as described above. The standalone reproducer
(vmw_sgtable_test.c) and IGT testcase source
(vmw_prime_sgtable.c) are included below.
Full IGT logs follow in two replies to this message (unfixed
and fixed runs).

Requires vgem with gem_prime_import_sg_table (one-line override in
vgem_drv.c, see note above) to exercise the mapping import path.

Let me know if you can reproduce with this setup, or if you need
anything else from my side. I am happy to send v2 patches whenever
you are ready.

thanks,
Aldo

---8<--- vmw_sgtable_test.c ---8<---

/*
 * vmw_prime_sgtable_test: Reproduce embedded sg_table invalid-free in vmwgfx.
 * Without fix: KASAN reports invalid-free. With fix: clean.
 */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <errno.h>
#include <stdint.h>

/* DRM core */
#define DRM_COMMAND_BASE 0x40
#define DRM_IOCTL_BASE 'd'
#define DRM_IOWR(nr, type) _IOWR(DRM_IOCTL_BASE, nr, type)
#define DRM_IOW(nr, type)  _IOW(DRM_IOCTL_BASE, nr, type)

struct drm_prime_handle { uint32_t handle; uint32_t flags; int32_t fd; };
struct drm_gem_close { uint32_t handle; uint32_t pad; };
#define DRM_IOCTL_PRIME_HANDLE_TO_FD _IOWR(DRM_IOCTL_BASE, 0x2d, struct drm_prime_handle)
#define DRM_IOCTL_PRIME_FD_TO_HANDLE _IOWR(DRM_IOCTL_BASE, 0x2e, struct drm_prime_handle)
#define DRM_IOCTL_GEM_CLOSE _IOW(DRM_IOCTL_BASE, 0x09, struct drm_gem_close)

/* vmwgfx */
#define DRM_VMW_ALLOC_DMABUF 1
#define DRM_VMW_GB_SURFACE_CREATE 23
#define DRM_VMW_GB_SURFACE_CREATE_EXT 27
#define DRM_VMW_EXECBUF 12
#define DRM_VMW_EXECBUF_VERSION 2
#define SVGA_3D_CMD_BIND_GB_SURFACE 1099

struct drm_vmw_alloc_bo_req { uint32_t size, pad64; };
struct drm_vmw_bo_rep { uint64_t map_handle; uint32_t handle, cur_gmr_id, cur_gmr_offset, pad64; };
union drm_vmw_alloc_bo_arg { struct drm_vmw_alloc_bo_req req; struct drm_vmw_bo_rep rep; };

struct drm_vmw_size { uint32_t width, height, depth, pad64; };
struct drm_vmw_gb_surface_create_req {
    uint32_t svga3d_flags; uint32_t format; uint32_t mip_levels;
    uint32_t drm_surface_flags; uint32_t multisample_count;
    uint32_t autogen_filter; uint32_t array_size;
    uint32_t buffer_handle; struct drm_vmw_size base_size;
};
struct drm_vmw_gb_surface_create_rep {
    uint32_t handle; uint32_t backup_size; uint32_t buffer_handle;
    uint32_t buffer_size; uint64_t buffer_map_handle;
};
union drm_vmw_gb_surface_create_arg {
    struct drm_vmw_gb_surface_create_rep rep;
    struct drm_vmw_gb_surface_create_req req;
};
struct drm_vmw_gb_surface_create_ext_req {
    struct drm_vmw_gb_surface_create_req base;
    uint32_t version;
    uint32_t svga3d_flags_upper_32_bits;
    uint32_t multisample_pattern;
    uint32_t quality_level;
    uint32_t buffer_byte_stride;
    uint32_t must_be_zero;
};
union drm_vmw_gb_surface_create_ext_arg {
    struct drm_vmw_gb_surface_create_ext_req req;
    struct drm_vmw_gb_surface_create_rep rep;
};

struct drm_vmw_execbuf_arg {
    uint64_t commands; uint32_t command_size; uint32_t throttle_us;
    uint64_t fence_rep; uint32_t version; uint32_t flags;
    uint32_t context_handle; int32_t imported_fence_fd;
};

#pragma pack(push, 1)
typedef struct { uint32_t id; uint32_t size; } SVGA3dCmdHeader;
typedef struct { uint32_t sid; uint32_t mobid; } SVGA3dCmdBindGBSurface;
#pragma pack(pop)

#define IOCTL_ALLOC DRM_IOWR(DRM_COMMAND_BASE + DRM_VMW_ALLOC_DMABUF, union drm_vmw_alloc_bo_arg)
#define IOCTL_SURFACE_EXT DRM_IOWR(DRM_COMMAND_BASE + DRM_VMW_GB_SURFACE_CREATE_EXT, union drm_vmw_gb_surface_create_ext_arg)
#define IOCTL_EXECBUF DRM_IOW(DRM_COMMAND_BASE + DRM_VMW_EXECBUF, struct drm_vmw_execbuf_arg)

int main(void) {
    int vmw_fd, vgem_fd, prime_fd, ret;
    union drm_vmw_alloc_bo_arg alloc;
    union drm_vmw_gb_surface_create_ext_arg surf;
    struct drm_vmw_execbuf_arg exec;
    struct { SVGA3dCmdHeader hdr; SVGA3dCmdBindGBSurface body; } cmd;
    struct drm_prime_handle ph, ph2;
    struct drm_gem_close cl;
    void *map;

    vmw_fd = open("/dev/dri/renderD128", O_RDWR);
    vgem_fd = open("/dev/dri/renderD129", O_RDWR);
    if (vmw_fd < 0 || vgem_fd < 0) { perror("open"); return 77; }

    /* 1. Alloc BO */
    memset(&alloc, 0, sizeof(alloc));
    alloc.req.size = 256 * 256 * 4;
    ret = ioctl(vmw_fd, IOCTL_ALLOC, &alloc);
    if (ret < 0) { perror("alloc"); return 1; }
    printf("[+] BO handle=%u\n", alloc.rep.handle);

    /* 2. Populate */
    map = mmap(NULL, 256*256*4, PROT_READ|PROT_WRITE, MAP_SHARED, vmw_fd, alloc.rep.map_handle);
    if (map != MAP_FAILED) { memset(map, 0x41, 256*256*4); munmap(map, 256*256*4); }

    /* 3. PRIME export the MOB handle */
    memset(&ph, 0, sizeof(ph));
    ph.handle = alloc.rep.handle;
    ph.flags = O_CLOEXEC | O_RDWR;
    ret = ioctl(vmw_fd, DRM_IOCTL_PRIME_HANDLE_TO_FD, &ph);
    if (ret < 0) { perror("export"); return 1; }
    prime_fd = ph.fd;
    printf("[+] PRIME exported fd=%d\n", prime_fd);

    /* 4. Create GB surface + bind (triggers vmw_ttm_map_dma -> vsgt.sgt cache) */
    memset(&surf, 0, sizeof(surf));
    surf.req.base.svga3d_flags = (1 << 6); /* SVGA3D_SURFACE_HINT_RENDERTARGET */
    surf.req.base.format = 37;             /* SVGA3D_BUFFER */
    surf.req.base.mip_levels = 1;
    surf.req.base.autogen_filter = 1;
    surf.req.base.array_size = 1;
    surf.req.base.drm_surface_flags = 1; /* drm_vmw_surface_flag_shareable */
    surf.req.base.buffer_handle = alloc.rep.handle; /* backup = our MOB */
    surf.req.base.base_size.width = 64;
    surf.req.base.base_size.height = 64;
    surf.req.base.base_size.depth = 1;
    surf.req.version = 1; /* drm_vmw_surface_version_v1 */
    ret = ioctl(vmw_fd, IOCTL_SURFACE_EXT, &surf);
    if (ret < 0) { printf("[-] surface create: %s (non-fatal)\n", strerror(errno)); }
    else {
        printf("[+] surface sid=%u backup_size=%u\n", surf.rep.handle, surf.rep.backup_size);
        /* EXECBUF bind */
        cmd.hdr.id = SVGA_3D_CMD_BIND_GB_SURFACE;
        cmd.hdr.size = sizeof(cmd.body);
        cmd.body.sid = surf.rep.handle;
        cmd.body.mobid = alloc.rep.handle;
        memset(&exec, 0, sizeof(exec));
        exec.commands = (uint64_t)(uintptr_t)&cmd;
        exec.command_size = sizeof(cmd);
        exec.version = DRM_VMW_EXECBUF_VERSION;
        exec.context_handle = 0xFFFFFFFF; /* SVGA3D_INVALID_ID = no DX context */
        ret = ioctl(vmw_fd, IOCTL_EXECBUF, &exec);
        if (ret < 0) printf("[-] execbuf bind: %s\n", strerror(errno));
        else printf("[+] BIND_GB_SURFACE OK\n");
    }

    /* 5. Cross-device PRIME import */
    memset(&ph2, 0, sizeof(ph2));
    ph2.fd = prime_fd;
    ret = ioctl(vgem_fd, DRM_IOCTL_PRIME_FD_TO_HANDLE, &ph2);
    if (ret < 0) {
        printf("[-] PRIME import failed: errno=%d\n", errno);
        close(prime_fd); close(vmw_fd); close(vgem_fd);
        return 1;
    }
    printf("[+] PRIME imported handle=%u\n", ph2.handle);

    /* 6. Close import -> kfree(sgt) */
    memset(&cl, 0, sizeof(cl));
    cl.handle = ph2.handle;
    ioctl(vgem_fd, DRM_IOCTL_GEM_CLOSE, &cl);
    close(prime_fd);

    printf("[+] DONE. Check: sudo dmesg | grep KASAN\n");
    close(vmw_fd); close(vgem_fd);
    return 0;
}

---8<--- vmw_prime_sgtable.c (IGT testcase) ---8<---

// SPDX-License-Identifier: GPL-2.0 OR MIT
/*
 * Test: vmw_prime_sgtable
 *
 * Validates that vmwgfx correctly handles embedded sg_table lifetime
 * during cross-device PRIME import/close sequences.  On unfixed kernels,
 * closing the imported GEM handle triggers kfree() on the embedded
 * (non-heap-allocated) sg_table inside struct vmw_ttm_tt, producing a
 * KASAN invalid-free splat.
 */

#include "igt_kms.h"
#include "igt_vmwgfx.h"

#include <fcntl.h>
#include <string.h>
#include <sys/ioctl.h>

IGT_TEST_DESCRIPTION("Test sg_table lifetime in vmwgfx PRIME export/import paths.");

/*
 * Full ioctl number for DRM_VMW_EXECBUF — vmwgfx_drm.h provides the
 * command offset but not the composed ioctl macro.
 */
#define IOCTL_VMW_EXECBUF \
	DRM_IOW(DRM_COMMAND_BASE + DRM_VMW_EXECBUF, struct drm_vmw_execbuf_arg)

static void test_sgtable_invalid_free(int vmw_fd, int import_fd)
{
	struct vmw_mob *mob;
	struct vmw_surface *surf;
	int prime_fd, ret;
	void *map;
	const uint32_t bo_size = 64 * 64 * 4;
	SVGA3dSize surf_size = { .width = 64, .height = 64, .depth = 1 };

	/* 1. Create and populate a MOB */
	mob = vmw_ioctl_mob_create(vmw_fd, bo_size);
	igt_require(mob);
	igt_require(mob->handle != 0);

	map = vmw_ioctl_mob_map(vmw_fd, mob);
	igt_require(map);
	memset(map, 0x41, bo_size);
	vmw_ioctl_mob_unmap(mob);

	/* 2. PRIME export the MOB handle */
	prime_fd = prime_handle_to_fd(vmw_fd, mob->handle);
	igt_assert(prime_fd >= 0);

	/* 3. Create a GB surface backed by this MOB */
	surf = vmw_ioctl_create_surface_full(vmw_fd,
		SVGA3D_SURFACE_HINT_RENDERTARGET,   /* flags */
		SVGA3D_BUFFER,                       /* format */
		0,                                   /* multisample_count */
		SVGA3D_MS_PATTERN_NONE,
		SVGA3D_MS_QUALITY_NONE,
		SVGA3D_TEX_FILTER_NEAREST,           /* autogen_filter */
		1,                                   /* num_mip_levels */
		1,                                   /* array_size */
		surf_size,
		mob->handle,                         /* buffer_handle (backup) */
		drm_vmw_surface_flag_shareable);
	/* Surface creation + bind trigger DMA mapping of the BO. */
	if (surf) {
		/* 4. Bind surface to MOB via raw EXECBUF */
		struct {
			SVGA3dCmdHeader hdr;
			SVGA3dCmdBindGBSurface body;
		} cmd;
		struct drm_vmw_execbuf_arg exec;

		cmd.hdr.id = SVGA_3D_CMD_BIND_GB_SURFACE;
		cmd.hdr.size = sizeof(cmd.body);
		cmd.body.sid = surf->base.handle;
		cmd.body.mobid = mob->handle;

		memset(&exec, 0, sizeof(exec));
		exec.commands = (uint64_t)(uintptr_t)&cmd;
		exec.command_size = sizeof(cmd);
		exec.version = DRM_VMW_EXECBUF_VERSION;
		exec.context_handle = 0xFFFFFFFF;

		ret = ioctl(vmw_fd, IOCTL_VMW_EXECBUF, &exec);
		if (ret < 0)
			igt_debug("execbuf bind: %s (non-fatal)\n",
				  strerror(errno));
		else
			igt_debug("BIND_GB_SURFACE OK (sid=%u, mobid=%u)\n",
				  surf->base.handle, mob->handle);
	}

	/*
	 * 5. Cross-device PRIME import using raw ioctl.
	 *
	 * Do NOT use prime_fd_to_handle() — it returns ENOSYS on
	 * some vmwgfx setups.  Raw DRM_IOCTL_PRIME_FD_TO_HANDLE works.
	 */
	{
		struct drm_prime_handle import_args;
		struct drm_gem_close close_args;

		memset(&import_args, 0, sizeof(import_args));
		import_args.fd = prime_fd;
		ret = ioctl(import_fd, DRM_IOCTL_PRIME_FD_TO_HANDLE,
			    &import_args);
		igt_assert_eq(ret, 0);
		igt_assert(import_args.handle != 0);
		igt_debug("PRIME imported handle=%u\n", import_args.handle);

		/*
		 * 6. Close the imported handle.
		 *
		 * On unfixed kernels this triggers kfree() on the
		 * embedded sg_table that was never separately allocated,
		 * causing KASAN invalid-free.  On fixed kernels this
		 * completes cleanly.
		 */
		memset(&close_args, 0, sizeof(close_args));
		close_args.handle = import_args.handle;
		ret = ioctl(import_fd, DRM_IOCTL_GEM_CLOSE, &close_args);
		igt_assert_eq(ret, 0);
	}

	/* 7. Cleanup */
	close(prime_fd);
	if (surf)
		vmw_ioctl_surface_unref(vmw_fd, surf);
	vmw_ioctl_mob_close_handle(vmw_fd, mob);
}

int igt_main()
{
	int vmw_fd = -1;
	int import_fd = -1;

	igt_fixture() {
		vmw_fd = open("/dev/dri/renderD128", O_RDWR);
		igt_require(vmw_fd >= 0);

		/*
		 * Need a second DRM device for cross-device PRIME import.
		 * Try renderD129 (typically VGEM or another GPU node).
		 */
		import_fd = open("/dev/dri/renderD129", O_RDWR);
		if (import_fd < 0)
			import_fd = open("/dev/dri/card1", O_RDWR);
		igt_require_f(import_fd >= 0,
			      "Need a second DRM device for PRIME import\n");
	}

	igt_describe("Validates sg_table lifetime during PRIME"
		     " export/import/close.  On unfixed kernels, closing the"
		     " imported handle triggers an invalid kfree of the"
		     " embedded sg_table.");
	igt_subtest("sgtable-invalid-free") {
		test_sgtable_invalid_free(vmw_fd, import_fd);
	}

	igt_fixture() {
		if (import_fd >= 0)
			close(import_fd);
		if (vmw_fd >= 0)
			close(vmw_fd);
	}
}
