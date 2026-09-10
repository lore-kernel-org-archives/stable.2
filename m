Received: from smtpout8.mo536.mail-out.ovh.net (smtpout8.mo536.mail-out.ovh.net [51.210.91.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE69549382
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.210.91.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789063907; cv=none; b=drXejtAwvDS6gJNNBxe3qljCkR6ZIfEeHvkiUqIagyMhTc4nkQpfDDKahIwcLX/32f3DzcD2kpG61xDsdN0hEQRsQrNXUUf1Brup5IGCU0l99TiPSjv0g3GVHAKvaO4lc1KX3Cwyo+56jD/nGRIjkw/8K76sq92qSv+5xrJuwNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789063907; c=relaxed/simple;
	bh=gIKX6TDOBdFxDOz14E2FVc2SqTSSOWSA0OIAhBYHJTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/WuIqUarP/scpBtimE3rQ1XYN3SDy6c9xc7ab0BhvXM//YlRJ+DOvkyInCwJmr1UXjwtzqxPBSeuoAvp7rt0Z8b/jvLjf3rcXQNg3OBO7nFZHk3+bEmUoskC0LIYOIJPRjwRdAy4fAD/GhEIZyjA1waNkFDWPIUMGuKZO2QzWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sicoop.com; spf=pass smtp.mailfrom=sicoop.com; dkim=pass (2048-bit key) header.d=sicoop.com header.i=@sicoop.com header.b=DtS/Hwto; arc=none smtp.client-ip=51.210.91.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sicoop.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sicoop.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sicoop.com header.i=@sicoop.com header.b="DtS/Hwto"
Received: from director5.derp.mail-out.ovh.net (director5.derp.mail-out.ovh.net [79.137.60.225])
	by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4hgkHZ3t9Lz81p8;
	Thu, 10 Sep 2026 16:52:26 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net (director5.derp.mail-out.ovh.net. [127.0.0.1])
        by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <christian.koenig@amd.com>; Thu, 10 Sep 2026 16:52:26 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.118.86])
	by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hgkHZ2Z6bz6GrV;
	Thu, 10 Sep 2026 16:52:26 +0000 (UTC)
Received: from sicoop.com (unknown [10.1.6.2])
	(Authenticated sender: michaltoma@sicoop.com)
	by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id D2220941C3D;
	Thu, 10 Sep 2026 16:52:24 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-100R0035100abae-58a1-4818-86d9-510bfad2885a,
                    D184D1A0A1014A0D56F8A815F0DE21A15A548AA1) smtp.auth=michaltoma@sicoop.com
X-OVh-ClientIp:89.91.4.113
From: Michal TOMA <michaltoma@sicoop.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Michal TOMA <michaltoma@sicoop.com>,
	bcm-kernel-feedback-list@broadcom.com,
	ian.forbes@broadcom.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] drm/vmwgfx: Release PRIME import in the BO destroy path
Date: Thu, 10 Sep 2026 18:52:20 +0200
Message-ID: <20260910165221.7558-3-michaltoma@sicoop.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910165221.7558-1-michaltoma@sicoop.com>
References: <20260910165221.7558-1-michaltoma@sicoop.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 16161730214470242587
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGg6wAZ5z5m4YdOZGlRvPlWvQ83qxrX0rycDpYlbiCAYEpx32LeXRz6zw+UeX55tidPV15i9F5JJX63eEc1JCT6wHVaKV/OhSN6LgwM58uI8yevCLazs8kKF9On9E4ThlTFZNkPOQ6mpgxNIBwb7hWHF/0E4+YW+s+/GZBnJCHjjNhGt9qzJ9+Dc66SkgCk2DdRRZ//ZY2nlpCJ5DSRYat8+/GO5Lgvp//nPcYh81iq7GWZiK315nkZFDCOgv20EiLuiJcuIH6EBIl+FPFLIr1p1SjOXj8KYsEa9ySW43cYk0cUc1nhxRsLzhm7RgCzFiB1KJ/GM4G0cGyhLeeNE9/aKmehTmst5mpd6wa3AMMntN/pO+wvCw2son0GCMudqp5Ra4cXUpQtcElszFg/9ehvvt+7rEA1Z9lPK5POcjs9mV8gxjYKMJCBfyj9mlYbId/iN3gvqqcqjfLnt/Kqkcar21QFcaq+dQQcLLdU1Pm2WPzBIYeISj5qNIe9acCCY7WF6gMMfAtke8mUpLXQyAb+MrLSCaZt7uXHxM8ngYd0pk6YK4ubo4DckID00v6UBCE7A5a7Iv4BJyfMrMneLMh6mVBgqTRybeXYqlWCh9yeBzZbh5BiAEReyeXOZzlV1G483EoUdsWQpGLFjyvqgLW/267n85Wk9eU7Z5wj25y/SQ
DKIM-Signature: a=rsa-sha256; bh=oNgvdIjXenpFeV/paVDrELbuNab+1ePKbm0+q9vDIwE=;
 c=relaxed/relaxed; d=sicoop.com; h=From; s=ovhmo62391-selector1;
 t=1789059147; v=1;
 b=DtS/Hwto0Pp7We+ky/snyzOrUBa4NOC1LbeatC5KkVvc6BLdabN7mfLw/h5E9DreheFGMhx1
 d/s4wCgekHFO0M6i0C+rmsGQYxjuKa33M5II29LqgopkoOEGcj0Y7W9bMO9a93kb3eqrKBIEMPA
 qDu472coQQcffoiTs3OZt/zvQXA2Uju8nCds+81n8zpCK4pHuLN17/pGzY/Uz4/Sth5HhJ3JLfl
 FB41NPUcTnpYOdvEoong6ydhJ8c3l2vcxx4nF57y9ynT0DIJMDBeJp/rWwskruKyn5FuipyQA87
 ABV5+3BKARBnL30qg4DW5wKwqUOZgpd4U2b+lrhp/rJQw==

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
Reproducer (results and environment are in the cover letter). Compare
the 4 MiB udmabuf entries in /sys/kernel/debug/dma_buf/bufinfo before
and after: without this patch all 8 remain, with count 1 and still
attached to the vmwgfx device.

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

The same loop without the PRIME_FD_TO_HANDLE/GEM_CLOSE step frees
every udmabuf, so the leak is specific to the vmwgfx import.

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
-- 
2.55.0

