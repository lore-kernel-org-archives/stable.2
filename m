Received: from smtpout8.mo540.mail-out.ovh.net (smtpout8.mo540.mail-out.ovh.net [51.210.91.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9696C50C29E
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.210.91.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059162; cv=none; b=UOIB4FLgA+861awYja1+uyVks8s9DcZCbmSoF2LzKT9PlYdljw1Ii7l/AHpbffZu7giYroWP2XueyCx1lNfePuwHmzEaLIihAR5QkV+Kc6IpluTgc5SuPE/lY4BuDxH/+BhGYHDQKcYrZFKVih1yDkHu2zSLoXQt4IebaKSA86c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059162; c=relaxed/simple;
	bh=shNexhU3+91h/nfk4jHmpTFHp5feiax3mrpPpYJuB6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAdRwW2EuJ93M0QxZG14mG6rTPHKVwM/dcY/pzil4DFuH12mhf4b+um1qbr3RiIwTlaFHYHJXhOfkg27dK1HOrO9yauBEzylgH37yPpPzHpgYP/nVKzYIY1h1YUQe4wTo5gXaJyNrxUkKo03ZSoF/Kh8fkewvZzWLiqEvUCvJH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sicoop.com; spf=pass smtp.mailfrom=sicoop.com; dkim=pass (2048-bit key) header.d=sicoop.com header.i=@sicoop.com header.b=eHuLCaJM; arc=none smtp.client-ip=51.210.91.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sicoop.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sicoop.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sicoop.com header.i=@sicoop.com header.b="eHuLCaJM"
Received: from director5.derp.mail-out.ovh.net (director5.derp.mail-out.ovh.net [79.137.60.225])
	by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4hgkHb5gdxz452h;
	Thu, 10 Sep 2026 16:52:27 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net (director5.derp.mail-out.ovh.net. [127.0.0.1])
        by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <christian.koenig@amd.com>; Thu, 10 Sep 2026 16:52:27 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.178.248])
	by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hgkHb412sz6MbM;
	Thu, 10 Sep 2026 16:52:27 +0000 (UTC)
Received: from sicoop.com (unknown [10.1.6.2])
	(Authenticated sender: michaltoma@sicoop.com)
	by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 0D7F4941C3B;
	Thu, 10 Sep 2026 16:52:26 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-100R003a667408e-8f09-46f7-ac05-eac24a551907,
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
Subject: [PATCH v2 3/3] drm/vmwgfx: Don't leak a GEM handle when referencing a surface by fd
Date: Thu, 10 Sep 2026 18:52:21 +0200
Message-ID: <20260910165221.7558-4-michaltoma@sicoop.com>
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
x-ovh-tracer-id: 16162011691840459035
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGg6wAZ5z5m4YdOZGlRvPlWvQ83qxrX0rycDpYlbiCAYEpx32LeXRz6zw+UeX55tidPV15i9F5JJX63eEc1JCT6wHVaKV/OhSN6LgwM58uI8yevCLazs8kKF9On9E4ThlTFZNkPOQ6mpgxNIBwb7hWHF/0E4+YW+s+/GZBnJCHjjNhGt9qzJ9+Dc66SkgCk2DdRRZ//ZY2nlpCJ5DSRYat8+/GO5Lgvp//nPcYh81iq7GWZiK315nkZFDCOgv20EiLuiJcuIH6EBIl+FPFLIr1p1SjOXj8KYsEa9ySW43cYk0cUc1nhxRsLzhm7RgCzFiB1KJ/GM4G0cGyhLeeNE9/ao2fRm+hdRKsfPiXwR6JtPvE9uBwWaUZGfOuYkoIaNwSABKYA4FYmqFzX8LXG8sNY4aL3OYy0PDsoE9ZPIu9x0Dy4AE4M3iVSH9Hoegxy/nPDe9moS4EAD64MaxOGzMoCYxtmQn1G7Bnod9owt3hZtTTVL+1Ir4efHM0l2cv4cnF1O1j8nKHok7la0l/Pj/N2RSInIhRHon05lDGezlMonevEAcGfkk6zmj3UyYYZ5jwUcNigAbaPUGHSzxG/02ZhpS9YDrY6JgYHRpw21c7f0NO4544eUQ3Msfo190FJ4saBIVi0+ikA43aDEQXEH3nC1nilyBUMerjzPNIzgFltlw
DKIM-Signature: a=rsa-sha256; bh=VgeMh5kbh20ZiKkQLJh6YqAh8e02PiCBUeJC60hC1Iw=;
 c=relaxed/relaxed; d=sicoop.com; h=From; s=ovhmo62391-selector1;
 t=1789059148; v=1;
 b=eHuLCaJMoWoP+OzjUgqU3rkTjhTSQ/xCMPD0o6rDpIhcZYr6C3yJwRe9u2b5qn2x27/wE62X
 +44dFSB1aHtgiBtZg1SLw6Ah1ZYtzwf9b1NQ0jT72Dd72HokDX/4oukAIE7ItLGwejAi8x33taq
 qvC5LWzfL+I9U795oHyJwr3YAlHkf/CaL6V+Y5OWfuly05QIWJRhDlQz1DQkiD9dbq4DbyTc+4s
 UzPb8+pzlfCzCZn8eIZjLFc9LdRj9YLzEktESqqp6aWP990MlCXy2zKa6qviGMhFIGQ5yLtauxm
 QWrOdrHUm98F36tKOBk+cOyVsVwS/xTgaPtVMpJOq07Ww==

DRM_VMW_GB_SURFACE_REF_EXT with DRM_VMW_HANDLE_PRIME first tries
ttm_prime_fd_to_handle(). If the fd is not a vmwgfx surface export,
vmw_surface_handle_reference() falls back to
vmw_buffer_prime_to_surface_base(). That function calls
drm_gem_prime_fd_to_handle() to turn the fd into a GEM handle in the
caller's file, then looks for a surface attached to that buffer.

That handle is never returned to userspace, since the ioctl reports the
surface handle and a separate backup buffer handle, and it is never
deleted. Every call that gets this far therefore leaves a GEM handle
behind in the file, whether it fails or succeeds, and whatever the
handle references stays alive until the file is closed.

For a dma-buf from another exporter, such as udmabuf, this is an
actual import: drm_gem_prime_fd_to_handle() attaches to the dma-buf,
maps it and creates a new GEM object. The surface lookup then always
fails, because such a buffer never has a surface. The WARN_ON() fires
and the ioctl returns -EINVAL, but the import stays referenced by the
stray handle.

Mesa's svga winsys passes dma-buf fds to DRM_VMW_GB_SURFACE_REF_EXT as
DRM_VMW_HANDLE_PRIME, and KWin 6.7 imports every wl_shm client buffer
as a udmabuf through EGL. On a Plasma Wayland session this pins one
window-sized buffer inside the compositor's DRM file for every
attempted import, for as long as the compositor runs, and logs a full
WARN backtrace each time. On a VirtualBox VMSVGA guest with 3D
acceleration on and the previous patch applied, 103 udmabufs (750 MiB)
had accumulated this way 40 minutes after boot. 99 of them had a
dma-buf refcount of 3, were still attached to the vmwgfx device and
were held by no process fd or mapping.

Look the buffer up through the dma-buf instead of importing it. Only
GEM buffers exported by this device can have a surface, so reject
anything else with drm_gem_is_prime_exported_dma_buf() before touching
it. For our own buffers, use dma_buf->priv directly: the dma-buf holds
a reference to the GEM object for as long as we hold the dma-buf, so
neither a handle nor an extra object reference is needed. The surface
lookup and the ttm_ref_object_add() reference that the callers rely on
are unchanged.

While restructuring the function, also:
 - replace the WARN_ON() on a buffer without a surface with a debug
   message. Userspace can trigger that case at will.
 - drop the base object reference taken by
   vmw_lookup_user_surface_for_buffer() when ttm_ref_object_add() fails.
   It was leaked before.

Build tested on drm-misc-fixes (4600b4d1a9ee) with W=1 (no warnings in
drivers/gpu/drm/vmwgfx/) and checkpatch.pl --strict. Runtime tested on
the same guest and 7.2.3 kernel as the previous patch, comparing a
vmwgfx.ko with only the previous patch against one with both. Calls
from a second render file:
 - udmabuf fd: -EINVAL both times. Before, each call left the import
   held by the file (refcount 3, attached) and logged a WARN. Now
   nothing is imported and nothing is logged.
 - fd of a dumb buffer exported from the primary node: -EINVAL both
   times. Before, a stray GEM handle and a WARN per call; now neither.
 - fd of a buffer exported before a GB surface was created on it, which
   reaches this function and succeeds: the exporter's surface is
   returned both times. Before, each call left a GEM handle in the
   file; now it does not.
 - fd of a buffer created together with its surface, which is exported
   as a TTM prime surface and does not reach this function: succeeds
   both times.
During a 5-minute KWin 6.7 test replaying a terminal workload, the
udmabuf count went from 4 to 20 (140 MiB) with only the previous patch,
with WARNs logged. With both patches it stayed at 6 during the run,
returned to 4 afterwards, and no WARN was logged.

Fixes: d6667f0ddf46 ("drm/vmwgfx: Fix handling of dumb buffers")
Cc: stable@vger.kernel.org # v6.11+
Assisted-by: LLM
Signed-off-by: Michal TOMA <michaltoma@sicoop.com>
---
Reproducer (results and environment are in the cover letter). Run as
root, since it counts udmabufs in debugfs:

  cc -o vmwgfx-surfref-fd-leak vmwgfx-surfref-fd-leak.c
  ./vmwgfx-surfref-fd-leak

// SPDX-License-Identifier: MIT
/*
 * Reproducer for "drm/vmwgfx: Don't leak a GEM handle when referencing a
 * surface by fd": DRM_VMW_GB_SURFACE_REF_EXT(DRM_VMW_HANDLE_PRIME) with a
 * udmabuf fd. Run as root, since it counts udmabufs in debugfs.
 *
 *   cc -o vmwgfx-surfref-fd-leak vmwgfx-surfref-fd-leak.c && ./vmwgfx-surfref-fd-leak
 *
 * The render node stays open after the calls. Expected lines 2 and 3
 * (udmabufs left while the node is open / after it is closed):
 *   with this fix:       0 / 0
 *   without it:          8 / 0 if "drm/vmwgfx: Release PRIME import in
 *                        the BO destroy path" is applied, otherwise
 *                        8 / 8 (pinned until reboot)
 */
#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <linux/udmabuf.h>
#include <drm/drm.h>
#include <drm/vmwgfx_drm.h>

#define DRM_IOCTL_VMW_GB_SURFACE_REF_EXT \
	DRM_IOWR(DRM_COMMAND_BASE + DRM_VMW_GB_SURFACE_REF_EXT, \
		 union drm_vmw_gb_surface_reference_ext_arg)
#define N 8
#define SIZE (6UL << 20)

/* udmabufs of @size listed in dma_buf/bufinfo */
static int count_udmabufs(unsigned long size)
{
	FILE *f = fopen("/sys/kernel/debug/dma_buf/bufinfo", "r");
	char line[512];
	int n = 0;

	if (!f) {
		perror("/sys/kernel/debug/dma_buf/bufinfo");
		return -1;
	}
	while (fgets(line, sizeof(line), f)) {
		unsigned long sz;

		if (sscanf(line, "%lu", &sz) == 1 && sz == size &&
		    strstr(line, "udmabuf"))
			n++;
	}
	fclose(f);
	return n;
}

int main(void)
{
	int render = open("/dev/dri/renderD128", O_RDWR | O_CLOEXEC);
	int udm = open("/dev/udmabuf", O_RDWR | O_CLOEXEC);
	int before, einval = 0;

	if (render < 0 || udm < 0) {
		perror("open");
		return 1;
	}
	before = count_udmabufs(SIZE);
	for (int i = 0; i < N; i++) {
		int memfd = memfd_create("surfref", MFD_ALLOW_SEALING | MFD_CLOEXEC);
		struct udmabuf_create create = {
			.memfd = memfd, .flags = UDMABUF_FLAGS_CLOEXEC, .size = SIZE,
		};
		union drm_vmw_gb_surface_reference_ext_arg arg;
		int dmabuf;

		if (memfd < 0 || ftruncate(memfd, SIZE) ||
		    fcntl(memfd, F_ADD_SEALS, F_SEAL_SHRINK)) {
			perror("memfd");
			return 1;
		}
		dmabuf = ioctl(udm, UDMABUF_CREATE, &create);
		if (dmabuf < 0) {
			perror("UDMABUF_CREATE");
			return 1;
		}
		memset(&arg, 0, sizeof(arg));
		arg.req.sid = dmabuf;
		arg.req.handle_type = DRM_VMW_HANDLE_PRIME;
		if (ioctl(render, DRM_IOCTL_VMW_GB_SURFACE_REF_EXT, &arg) &&
		    errno == EINVAL)
			einval++;
		close(dmabuf);
		close(memfd);
	}
	close(udm);
	usleep(500000);
	printf("GB_SURFACE_REF_EXT with a udmabuf fd: %d/%d calls failed with EINVAL\n",
	       einval, N);
	printf("6 MiB udmabufs left, render node open:   %d (before: %d)\n",
	       count_udmabufs(SIZE), before);
	close(render);
	usleep(500000);
	printf("6 MiB udmabufs left, render node closed: %d\n",
	       count_udmabufs(SIZE));
	return 0;
}

 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 48 ++++++++++++++-----------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index bd0563741..27f68fd9c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -16,8 +16,11 @@
 #include "device_include/svga3d_surfacedefs.h"
 
 #include <drm/drm_dumb_buffers.h>
+#include <drm/drm_prime.h>
 #include <drm/ttm/ttm_placement.h>
 
+#include <linux/dma-buf.h>
+
 #define SVGA3D_FLAGS_64(upper32, lower32) (((uint64_t)upper32 << 32) | lower32)
 
 /**
@@ -931,33 +934,37 @@ u32 vmw_lookup_surface_handle_for_buffer(struct vmw_private *vmw,
 
 static int vmw_buffer_prime_to_surface_base(struct vmw_private *dev_priv,
 					    struct drm_file *file_priv,
-					    u32 fd, u32 *handle,
+					    u32 fd,
 					    struct ttm_base_object **base_p)
 {
 	struct ttm_base_object *base;
-	struct vmw_bo *bo;
+	struct dma_buf *dma_buf;
 	struct ttm_object_file *tfile = vmw_fpriv(file_priv)->tfile;
 	struct vmw_user_surface *user_srf;
 	int ret;
 
-	ret = drm_gem_prime_fd_to_handle(&dev_priv->drm, file_priv, fd, handle);
-	if (ret) {
-		drm_warn(&dev_priv->drm,
-			 "Wasn't able to find user buffer for fd = %u.\n", fd);
-		return ret;
-	}
+	dma_buf = dma_buf_get(fd);
+	if (IS_ERR(dma_buf))
+		return PTR_ERR(dma_buf);
 
-	ret = vmw_user_bo_lookup(file_priv, *handle, &bo);
-	if (ret) {
-		drm_warn(&dev_priv->drm,
-			 "Wasn't able to lookup user buffer for handle = %u.\n", *handle);
-		return ret;
+	/*
+	 * Only buffers exported by this device can have a user surface.
+	 * Look the buffer up through the dma-buf, which holds a reference
+	 * to it, instead of importing the fd into file_priv: the GEM handle
+	 * that would create is never returned to userspace, so nothing
+	 * would release it (or a foreign dma-buf) until the file is closed.
+	 */
+	if (!drm_gem_is_prime_exported_dma_buf(&dev_priv->drm, dma_buf)) {
+		ret = -EINVAL;
+		goto out;
 	}
 
-	user_srf = vmw_lookup_user_surface_for_buffer(dev_priv, bo, *handle);
-	if (WARN_ON(!user_srf)) {
-		drm_warn(&dev_priv->drm,
-			 "User surface fd %d (handle %d) is null.\n", fd, *handle);
+	user_srf = vmw_lookup_user_surface_for_buffer(dev_priv,
+						      to_vmw_bo(dma_buf->priv),
+						      fd);
+	if (!user_srf) {
+		drm_dbg_driver(&dev_priv->drm,
+			       "No user surface for buffer fd %d.\n", fd);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -966,13 +973,15 @@ static int vmw_buffer_prime_to_surface_base(struct vmw_private *dev_priv,
 	ret = ttm_ref_object_add(tfile, base, NULL, false);
 	if (ret) {
 		drm_warn(&dev_priv->drm,
-			 "Couldn't add an object ref for the buffer (%d).\n", *handle);
+			 "Couldn't add an object ref for buffer fd %d (%d).\n",
+			 fd, ret);
+		ttm_base_object_unref(&base);
 		goto out;
 	}
 
 	*base_p = base;
 out:
-	vmw_user_bo_unref(&bo);
+	dma_buf_put(dma_buf);
 
 	return ret;
 }
@@ -996,7 +1005,6 @@ vmw_surface_handle_reference(struct vmw_private *dev_priv,
 			return vmw_buffer_prime_to_surface_base(dev_priv,
 								file_priv,
 								u_handle,
-								&handle,
 								base_p);
 	} else {
 		handle = u_handle;
-- 
2.55.0

