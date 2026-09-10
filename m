Received: from smtpout9.mo538.mail-out.ovh.net (smtpout9.mo538.mail-out.ovh.net [51.210.91.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431784A43E1
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.210.91.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052609; cv=none; b=gA2HVW0OjxXvkTFDNYsox60JWzcB1ybwo63sMsLbGKmWeFnEph/DQq6pwloMKJPzX3/tpBCd06OR5UCz2M8JFbxNVhZ6KF194ZS5QdCPQZo0iPK66vcEOex5vkMQILdUOSEJznzU6PYxbNiwnTSZhftoRDkuzRsEMTengVvY9SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052609; c=relaxed/simple;
	bh=0tdk4eA53rbwb/VzePOHD8uJojap2TS4+qeqML8ltA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=imWXV3PhxJRv6iE+nN/3UxNNdV5d4I3dDOtBChkvZs37CnJm5/VIV5BkiR0JNHMHb9DcBqcaWV7O1hQq+2QJ4qFGH4CNIZIQavm83LnpJrx6bw+32eUTQ033XEk+Su79EmcIvxvI6asG6N9JRrLyW6989iGnCdLBRJm1b3imaU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sicoop.com; spf=pass smtp.mailfrom=sicoop.com; dkim=pass (2048-bit key) header.d=sicoop.com header.i=@sicoop.com header.b=RxoLap6c; arc=none smtp.client-ip=51.210.91.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sicoop.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sicoop.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sicoop.com header.i=@sicoop.com header.b="RxoLap6c"
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net [79.137.60.36])
	by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4hgg0L1DfNz5xMy;
	Thu, 10 Sep 2026 14:24:02 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net. [127.0.0.1])
        by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <bcm-kernel-feedback-list@broadcom.com>; Thu, 10 Sep 2026 14:24:02 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.101.1])
	by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hgg0K6yTrz1xp5;
	Thu, 10 Sep 2026 14:24:01 +0000 (UTC)
Received: from sicoop.com (unknown [10.1.6.5])
	(Authenticated sender: michaltoma@sicoop.com)
	by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 4B878941C3B;
	Thu, 10 Sep 2026 14:24:00 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-106R0068dd60d49-3a7b-4cef-993d-6e5cb923b62a,
                    D184D1A0A1014A0D56F8A815F0DE21A15A548AA1) smtp.auth=michaltoma@sicoop.com
X-OVh-ClientIp:89.91.4.113
From: Michal TOMA <michaltoma@sicoop.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Michal TOMA <michaltoma@sicoop.com>,
	bcm-kernel-feedback-list@broadcom.com,
	ian.forbes@broadcom.com,
	martin.krastev@broadcom.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: Release PRIME import in the BO destroy path
Date: Thu, 10 Sep 2026 16:23:59 +0200
Message-ID: <20260910142359.13716-1-michaltoma@sicoop.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 13655477022551134491
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEMYgBh5jAs2CqhmicLsFk6VAjE8McmgpxCm7G7Xlp2LR1OYnIrkEevB8t2xcM2fRNGBogZDQ2KC0s9TZBE9nAQkRou+AD++XnGtcPTSRalkKORA1T9DDG3cTUJYLDyWdooREfoC28gAHluAMahqxIKbomWdGDmCM8nztoHCHkU4nL+/QGrPypd1/N+Is7gTFLsLsPkj4Bom1eoR8rlt34hjlyMK8WwMYF2GRo6kVku/LtCEHhq7JTHoP+Tn2syGBuwRW/CfLMAws3HdSPtyVcKtNhC4popB3n803jaTwjeX+wjIsq5Sstt++/yjHO/nZrOnrZTziRcqRkP0s2XMjOIQWTP9v9vIVBk6FFxUKOr46iWJUc3w9SBkecHm/QaJuAmUIcCkKlPgIXeaLHks7g5/e9jzzuSn+xHd+/LeJ82Y4GqeR7OFJslNBdLiuyVIfaK83ZS9ONjMl042pzgUe2O/5NXuVpdvyP4LsxPboxFj1b94xIkbP8z0nY+0+ZPcBmIj/N3hYCt5Eaa8rzdRufSNvLnr9hAXDTAHrB55crloGKP0cIVWIP2bgBxz5QnxYCC2d7vSn9umc1b0HysFUT9xyd0HYpQhUGLdKu2vDPi3eQ4A6qpDuDowfKqV5F+idlV1XW89P2yb5/kXFkvu6GX7yIv3wQ/F3GwSqpYF3wokw
DKIM-Signature: a=rsa-sha256; bh=9oI3S3DvLqTfUvqstD//cyIYy5+Mq2YSKPAElvuGvFA=;
 c=relaxed/relaxed; d=sicoop.com; h=From; s=ovhmo62391-selector1;
 t=1789050242; v=1;
 b=RxoLap6cJkDBxJ/BmXn3FU0t82i5K5bcByFp7ZxCYz0TO2mliEcT8OFZxhXSvrWhifqKTAYR
 XkvFK1fkoCbSiAfMlpM7a5rMvQOMDNMIS2fM+07oEWJXFdf7chOkeu/4aUGplwUFypyKYs3uM/K
 SKUG5b9akue5qaEmLv7xTDawyQ6Q+4KABoVGsQ8nwIVKoqLGS/spazVhLTtYujoo4MlvFdREFeK
 O6i8g3P7PjrZpmK120jbVeGmvoJGh4X85ZxWdb1hvCthusZyCho4bT4ef4T7COAXj9Zhbm90MF6
 IhKG9nn1rdMkppdqM7uQ7veAMXPDhiGZpyCACcVMbWleQ==

drm_gem_prime_import_dev() attaches to a foreign dma-buf, takes a
reference with get_dma_buf(), maps the attachment and, once
vmw_prime_import_sg_table() has created the TTM buffer object, stores
the attachment in obj->import_attach. Drivers that import this way have
to undo it by calling drm_prime_gem_destroy() when the object is freed.

vmwgfx never does. The TTM destroy callback, vmw_bo_free(), only calls
drm_gem_object_release() and kfree(). For every imported dma-buf, the
sg mapping, the attachment and the dma-buf reference are leaked when
the last GEM reference goes away, and the exporter's backing pages stay
pinned until reboot.

Any process that can open the vmwgfx render node can hit this by
importing a dma-buf from another exporter, for example with
DRM_IOCTL_PRIME_FD_TO_HANDLE. It showed up as a memory drain on a
VirtualBox VMSVGA guest running a Plasma 6.7 Wayland session with the
host's 3D acceleration off. KWin 6.7 wraps wl_shm client buffers in
udmabufs and imports them through EGL on llvmpipe, and it keeps many of
those imports referenced while it runs, which is a separate userspace
problem. Restarting the compositor did not give the memory back,
though: with about 1.5 GiB of client buffers imported, killing KWin
left 211 udmabufs in /sys/kernel/debug/dma_buf/bufinfo with a refcount
of 1, still attached to the vmwgfx device, after every userspace
reference was gone. Their pages are no longer mapped or in any page
cache, so reclaim and swap cannot free them.

Call drm_prime_gem_destroy() for imported objects before
drm_gem_object_release(), as amdgpu, radeon and nouveau do in their TTM
destroy callbacks, and include <drm/drm_prime.h> for it. The check is
safe on the import error path: drm_gem_prime_import_dev() only sets
obj->import_attach after gem_prime_import_sg_table() succeeded, so a
buffer object destroyed before that point is not unmapped, detached or
put a second time. ttm_bo_release() tears down the TTM backing and
drops the reservation lock before calling the destroy callback, which
fits the _unlocked unmap done by drm_prime_gem_destroy().

The leak was found by walking /proc/kpageflags, which attributed the
missing memory to orphaned shmem pages. Those matched the udmabuf
objects in dma_buf/bufinfo, and the remaining reference was traced to
the missing PRIME teardown. It was confirmed without a compositor using
a small reproducer: create a memfd, wrap it with UDMABUF_CREATE, import
it with DRM_IOCTL_PRIME_FD_TO_HANDLE on the vmwgfx render node, close
the GEM handle and every file descriptor, then check bufinfo.

Build tested on drm-misc-fixes (4600b4d1a9ee) with the openSUSE 7.2.3
config and W=1: drivers/gpu/drm/vmwgfx/ builds without warnings before
and after the change, and checkpatch.pl --strict is clean. Runtime
tested on a VirtualBox 7.2 VMSVGA guest with kernel 7.2.3, whose vmwgfx
sources for the files involved are identical to drm-misc-fixes, using a
vmwgfx.ko built from them with this change. With the reproducer, all 8
imported udmabufs stayed pinned without the change and none with it,
with 3D acceleration both on and off. With KWin on llvmpipe, killing
the compositor now released 84 of 92 udmabufs (610 MiB) within 10
seconds, where the same test on the unpatched driver released none.

Fixes: b32233acceff ("drm/vmwgfx: Fix prime import/export")
Cc: stable@vger.kernel.org # v6.6+
Assisted-by: LLM
Signed-off-by: Michal TOMA <michaltoma@sicoop.com>
---
Reproducer
----------
Run as a user with access to the render node and /dev/udmabuf:

#!/usr/bin/env python3
import fcntl, os, struct
N, SIZE = 8, 4 * 1024 * 1024
UDMABUF_CREATE     = 0x40187542  # _IOW('u', 0x42, struct udmabuf_create)
PRIME_FD_TO_HANDLE = 0xC00C642E  # DRM_IOWR(0x2e, struct drm_prime_handle)
GEM_CLOSE          = 0x40086409  # DRM_IOW(0x09, struct drm_gem_close)
render = os.open('/dev/dri/renderD128', os.O_RDWR | os.O_CLOEXEC)
udm = os.open('/dev/udmabuf', os.O_RDWR | os.O_CLOEXEC)
for i in range(N):
    mfd = os.memfd_create(f'prime-leak-{i}', os.MFD_ALLOW_SEALING)
    os.ftruncate(mfd, SIZE)
    fcntl.fcntl(mfd, fcntl.F_ADD_SEALS, fcntl.F_SEAL_SHRINK)
    create = bytearray(struct.pack('IIQQ', mfd, 1, 0, SIZE))
    dfd = fcntl.ioctl(udm, UDMABUF_CREATE, create)
    ph = bytearray(struct.pack('IIi', 0, 0, dfd))
    fcntl.ioctl(render, PRIME_FD_TO_HANDLE, ph)
    handle = struct.unpack('IIi', ph)[0]
    fcntl.ioctl(render, GEM_CLOSE, bytearray(struct.pack('II', handle, 0)))
    os.close(dfd)
    os.close(mfd)
os.close(udm)
os.close(render)

Then look at the 4 MiB udmabuf entries in
/sys/kernel/debug/dma_buf/bufinfo. Without the fix, all 8 are still
listed with a count of 1 and attached to the vmwgfx device after the
script has exited. The same loop without the PRIME_FD_TO_HANDLE and
GEM_CLOSE steps frees every udmabuf.

Test results
------------
Kernel 7.2.3, comparing the stock vmwgfx.ko with one built from the same
sources plus this patch:
- Reproducer, 8 x 4 MiB udmabufs: all 8 left on the stock driver, none
  left with the patch, with 3D acceleration on and off.
- KWin 6.7.4 on llvmpipe (3D off), after about 1.5 GiB of client
  buffers had been imported, killing kwin_wayland (kwin_wayland_wrapper
  restarts it):
    stock driver (7.2.2 at the time): udmabufs went 212 -> 220 and
      nothing was freed. Their refcounts dropped from mostly 3 to mostly
      1, still attached.
    patched: 84 of 92 udmabufs (610 MiB) released within 10 seconds, and
      MemAvailable rose from 1.50 to 2.20 GiB.
  The module used for the KWin run also carried a separate vmwgfx fix
  (see below), but that fix is not on this path: with 3D off, KWin's
  imports go through DRM_IOCTL_PRIME_FD_TO_HANDLE, which kprobes
  confirmed.
- The kernel log showed no vmwgfx warnings with the patched module.

While it runs on llvmpipe, KWin itself keeps many of these imports
referenced through GEM handles on its render node file. A 60-second
trace counted 130 import handles created and 119 deleted. That is a
separate userspace issue and is not addressed here; this patch makes
sure the memory is released once those handles go away.

With 3D acceleration on, KWin's imports go through
DRM_VMW_GB_SURFACE_REF_EXT instead, which has its own handle leak. I'm
sending a separate patch for that: "drm/vmwgfx: Don't leak a GEM handle
when referencing a surface by fd".

Test environment
----------------
- VirtualBox 7.2 (Guest Additions 7.2.16), VMSVGA adapter, 4 vCPUs,
  3.8 GiB RAM. Tested with 3D acceleration on (vmwgfx shader model SM_5)
  and off (shader model Legacy).
- openSUSE Tumbleweed kernel 7.2.3-1-default. vmwgfx_bo.c, vmwgfx_gem.c,
  vmwgfx_prime.c, ttm_object.c, vmwgfx_bo.h and vmwgfx_drv.h are
  byte-identical to drm-misc-fixes 4600b4d1a9ee. The patched module was
  built out of tree from those sources, which adds the E taint.
- The kernel was already tainted W+O before any test: two boot-time
  warnings unrelated to vmwgfx (arch/x86/mm/pat/set_memory.c:727 and
  kernel/rcu/tree_plugin.h:823), plus VirtualBox's out-of-tree
  vboxguest/vboxsf.
- KDE Plasma / KWin 6.7.4, Mesa 26.2.1.
- W=1 build of drivers/gpu/drm/vmwgfx/ on drm-misc-fixes: no warnings
  before or after the patch. checkpatch.pl --strict is clean.

Not tested
----------
- VMware Workstation or ESXi hosts; only VirtualBox VMSVGA.
- A full kernel built from drm-misc-fixes; only the 7.2.3 kernel with a
  module built from identical vmwgfx sources.
- Kernels with KASAN, lockdep or kmemleak enabled. IGT was not run.
- Stable backports were not built.

Classification
--------------
I'm treating this as a regular bug rather than a vulnerability, per
Documentation/process/threat-model.rst. The pinned pages are charged to
the importing process's memory cgroup, so the impact is bounded by
memory limits. The same class of reference leak (f739416dc555,
"drm/vmwgfx: drop dma_buf reference on foreign-fd prime import") was
handled as a regular fix.

Separate observation (not addressed here, untested)
---------------------------------------------------
vmw_prime_import_sg_table() returns NULL rather than an ERR_PTR when
vmw_bo_create() fails, because vmw_bo_create() sets *p_bo = NULL on
error. drm_gem_prime_import_dev() only checks IS_ERR() and then
dereferences the result (obj->import_attach = attach). This could only
trigger on buffer object allocation failure, and I have not tried to
reproduce it with fault injection.

Workaround for affected users
-----------------------------
Setting KWIN_DISABLE_UDMABUF_IMPORT=1 in the session environment makes
KWin 6.7 use its copy path again, which avoids the import.

Tool use
--------
I found the problem because my VM repeatedly ran out of memory and had
to be rebooted. An LLM coding assistant (Claude, Anthropic) did the
diagnostics that traced it back to this code, wrote the patch and this
changelog, and built the reproducer and the test tooling used to confirm
that the patch fixes the issue.

 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 9c7a73c0b..56bc94edc 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -30,6 +30,7 @@
 #include "vmwgfx_drv.h"
 #include "vmwgfx_resource_priv.h"
 
+#include <drm/drm_prime.h>
 #include <drm/ttm/ttm_placement.h>
 
 /**
@@ -69,6 +70,8 @@ static void vmw_bo_free(struct ttm_buffer_object *bo)
 		vmw_surface_unreference(&vbo->dumb_surface);
 	}
 	WARN_ON(!RB_EMPTY_ROOT(&vbo->res_tree));
+	if (drm_gem_is_imported(&vbo->tbo.base))
+		drm_prime_gem_destroy(&vbo->tbo.base, vbo->tbo.sg);
 	drm_gem_object_release(&vbo->tbo.base);
 	WARN_ON(vbo->dirty);
 	kfree(vbo);

base-commit: 4600b4d1a9ee730d03ddac5ce409cd2730ce8c0c
-- 
2.55.0

