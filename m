Received: from smtpout4.mo538.mail-out.ovh.net (smtpout4.mo538.mail-out.ovh.net [51.210.91.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFDA3B4EA1
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.210.91.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059154; cv=none; b=m0A8RpgkLRdhDCpnmLbZVHwbXV2ICNJq6eNIgHVIUnapcz5Ri6050I1qhlAu/wiUxzvzW3wswfWK9RJ3UNK8gvi/XHl5/eaz5xIbeiBao40o1WcTQimp3hJ4KJiMmWildHE4yn2yh8M56OpamrTuAWtUyUdZuNg6jJ8FIyJDKf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059154; c=relaxed/simple;
	bh=2dMOQ1vx6rLMO4qsV1MwGfT3wfsbDmnSKHx/gffVTps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUYk96nvrmv9HgFfwQsQv1kgNFYRRlwKo/TM2HqxvEVPZVeSjnSykMvzbs5iEdbn5+YJ3rysZ/JX0n0SDpbEXXqgHvrIUzVD4MVoBAM+JOrfj85fsZ+8Omq2LReH9Jx1204eD21wvpDgs/5o1kpF5YtRBwe5z94dZl2MbEGRymk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sicoop.com; spf=pass smtp.mailfrom=sicoop.com; dkim=pass (2048-bit key) header.d=sicoop.com header.i=@sicoop.com header.b=QSPT4AZy; arc=none smtp.client-ip=51.210.91.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sicoop.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sicoop.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sicoop.com header.i=@sicoop.com header.b="QSPT4AZy"
Received: from director5.derp.mail-out.ovh.net (director5.derp.mail-out.ovh.net [79.137.60.225])
	by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4hgkHY2HKVz6DM8;
	Thu, 10 Sep 2026 16:52:25 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net (director5.derp.mail-out.ovh.net. [127.0.0.1])
        by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <christian.koenig@amd.com>; Thu, 10 Sep 2026 16:52:25 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.188.184])
	by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hgkHY116qz6GrV;
	Thu, 10 Sep 2026 16:52:25 +0000 (UTC)
Received: from sicoop.com (unknown [10.1.6.2])
	(Authenticated sender: michaltoma@sicoop.com)
	by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 76158941C3B;
	Thu, 10 Sep 2026 16:52:23 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-100R00350eeada4-356d-4531-b89e-ad671e8ca1bc,
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
Subject: [PATCH v2 1/3] drm/vmwgfx: Don't map or free the exporter's sg_table for imported BOs
Date: Thu, 10 Sep 2026 18:52:19 +0200
Message-ID: <20260910165221.7558-2-michaltoma@sicoop.com>
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
x-ovh-tracer-id: 16161448740256764187
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGg6wAZ5z5m4YdOZGlRvPlWvQ83qxrX0rycDpYlbiCAYEpx32LeXRz6zw+UeX55tidPV15i9F5JJX63eEc1JCT6wHVaKV/OhSN6LgwM58uI8yevCLazs8kKF9On9E4ThlTFZNkPOQ6mpgxNIBwb7hWHF/0E4+YW+s+/GZBnJCHjjNhGt9qzJ9+Dc66SkgCk2DdRRZ//ZY2nlpCJ5DSRYat8+/GO5Lgvp//nPcYh81iq7GWZiK315nkZFDCOgv20EiLuiJcuIH6EBIl+FPFLIr1p1SjOXj8KYsEa9ySW43cYk0cUc1nhxRsLzhm7RgCzFiB1KJ/GM4G0cGyhLeeNE9/aJ55Rvp0OwdgfYjyIyVOA4GjkJ3AUayJQ12PN/0LdjhCHM4nNrCbH5WIwuv5d0SLWxwsrSrMMM1TsxIx/S9bmyurSJBaj0ipwTfXjT4MgVdCci/mSA5AK17ODDLAp8ctX+dW1jSkTqtet7YwqciO+N+zY39IV/eTOQ0yJ97HiI82ce/TMW91sbwrdodVWl+uciPPF31rzaUdgK4zWmMiC7Thp4/aySHkgHnnv5stVPaFHXqBnUSaIM9dhOl/rkK0kweNEx7ge1GnDzxwlpO6Iy53UPFOIcN08lp8FRhUbgu2xKFED0RJgItP1zFi8vyMqePNyvpmxg0Kl0aCYDZSY7A
DKIM-Signature: a=rsa-sha256; bh=+q8drlTkuKqRhIVJc6wlGkRTMV5udQFSe+F1A2psgEE=;
 c=relaxed/relaxed; d=sicoop.com; h=From; s=ovhmo62391-selector1;
 t=1789059145; v=1;
 b=QSPT4AZymfn5UJcS5IAbzMaOT8wzseb0NpFwAoqjuwsIL631VhML0a18W6O/HCO1RvzhAzoe
 xuAuYtFWZi7zoYbSQ1k0pd2bpRRcg9qxXn5lT4yPJMOrW2RWs+6Z9jpU4neFz8I0ysn7MWS8KcE
 cpNnb+PDWS0saf9rOpiqi8rx7mM6/5K9EiCKtTCsJd957IWRjJgyAZi0d4tk5krAvitfsMBa6SG
 BtWMDzgJxf0rkciscxSY+y1Ec809b/jRT8rd0T+cKtIfCwxPLAv06REyXFya3Eo8IYLDhWGlwdd
 wXIeRBWz7YlaeXyOZo3mNjpYr8qs52BisrzF1QCnknc5Q==

For a TTM tt with TTM_TT_FLAG_EXTERNAL, vmw_ttm_map_dma() points
vsgt->sgt at the exporter's sg_table and then calls
vmw_ttm_map_for_dma(), which maps &vmw_tt->sgt: the inline table, not
the one vsgt->sgt points to. For an imported buffer object that inline
table is never populated, since vmw_ttm_tt_create() allocates the
vmw_ttm_tt with kzalloc() and only the non-external branch fills it in.
dma_map_sgtable() is therefore called with orig_nents == 0, which trips
the WARN_ON_ONCE() in __dma_map_sg_attrs() and returns -EIO.

The error path then calls sg_free_table() on vsgt->sgt, which for an
imported object is the exporter's table. Its scatterlist is freed while
the attachment is still live, leaving sgl == NULL and orig_nents
unchanged. vmw_ttm_unmap_dma() would free that table too, if a mapping
ever succeeded.

Any process that can open the render node reaches this with three
DRM_RENDER_ALLOW ioctls: import a dma-buf with
DRM_IOCTL_PRIME_FD_TO_HANDLE, create a guest-backed surface on it with
DRM_VMW_GB_SURFACE_CREATE_EXT, and submit SVGA_3D_CMD_UPDATE_GB_SURFACE
for that surface with DRM_VMW_EXECBUF. Validation moves the buffer to
VMW_BO_DOMAIN_MOB, and binding the tt takes the path above:

  WARNING: kernel/dma/mapping.c:266 at __dma_map_sg_attrs+0xdd/0x1d0
   dma_map_sgtable+0x1d/0x30
   vmw_ttm_map_dma+0xf6/0x140 [vmwgfx]
   vmw_move+0x1cd/0x2c0 [vmwgfx]
   ttm_bo_handle_move_mem+0xc0/0x180 [ttm]
   ttm_bo_validate+0xd2/0x1d0 [ttm]
   vmw_validation_bo_validate+0xb5/0x180 [vmwgfx]
   vmw_execbuf_process+0x852/0x1330 [vmwgfx]
   vmw_execbuf_ioctl+0x10d/0x1d0 [vmwgfx]
   drm_ioctl_kernel+0xa6/0x100
   drm_ioctl+0x2ad/0x590
   __x64_sys_ioctl+0xb9/0x100

  vmwgfx 0000:00:02.0: [drm] VSG table map failed!

Today the damage stops there, because vmwgfx never releases a PRIME
import: nothing unmaps the attachment afterwards, so the freed table is
only leaked. Adding the missing drm_prime_gem_destroy() call to
vmw_bo_free(), which is the next patch in this series, makes the
exporter unmap that table on release, and dma_unmap_sgtable() then
walks a NULL scatterlist:

  BUG: kernel NULL pointer dereference, address: 000000000000001c
  Workqueue: ttm ttm_bo_delayed_delete [ttm]
  RIP: 0010:dma_direct_unmap_sg+0x62/0x200
   unmap_udmabuf+0x24/0x40
   dma_buf_unmap_attachment_unlocked+0x46/0x70
   drm_prime_gem_destroy+0x28/0x50
   vmw_bo_free+0x15b/0x1f0 [vmwgfx]

The exporter has already mapped the table for this device in
dma_buf_map_attachment(), so there is nothing for vmwgfx to do here:
use the table as it is, and leave mapping, unmapping and freeing to its
owner.

Build tested on drm-misc-fixes (4600b4d1a9ee) with W=1 (no warnings in
drivers/gpu/drm/vmwgfx/) and checkpatch.pl --strict. Runtime tested on
a VirtualBox 7.2 VMSVGA guest running kernel 7.2.3, whose vmwgfx
sources for the files involved are identical to drm-misc-fixes, using a
module built from them.

Without this patch the reproducer above logs the WARN_ON_ONCE() and
"VSG table map failed!", and DRM_VMW_EXECBUF returns -EIO; releasing the
buffer afterwards, with the next patch of this series applied, oopsed in
the TTM delete worker and hung the machine.

With this patch the same reproducer logs nothing: the execbuf is
accepted, so an imported buffer object can now be bound at all, and
releasing it afterwards leaves no entry behind in
/sys/kernel/debug/dma_buf/bufinfo.

Fixes: b32233acceff ("drm/vmwgfx: Fix prime import/export")
Cc: stable@vger.kernel.org # v6.9+
Assisted-by: LLM
Signed-off-by: Michal TOMA <michaltoma@sicoop.com>
---
Reproducer (results and environment are in the cover letter). Run as an
ordinary user with access to the render node and /dev/udmabuf; it needs
no root. Without this patch it logs the WARN and "VSG table map
failed!"; with it, the execbuf is accepted and nothing is logged.

// Can userspace get an imported (external) dma-buf BO bound for the device?
//
// Chain under test:
//   udmabuf -> PRIME_FD_TO_HANDLE            (external BO, sits in SYSTEM)
//   GB_SURFACE_CREATE_EXT buffer_handle=...  (surface backed by the import)
//   execbuf SVGA_3D_CMD_UPDATE_GB_SURFACE    (validation forces the BO to MOB)
//     -> vmw_ttm_bind() -> vmw_ttm_map_dma()
//        external branch maps the wrong (empty, inline) sg_table, fails, and
//        the out_map_fail path calls sg_free_table() on the EXPORTER's table.
//
// Proof of reachability is the kernel message "VSG table map failed!".
//
//   vmw-import-execbuf-bind-test            hold the buffer, never release it
//   vmw-import-execbuf-bind-test --release  also close everything at the end
//
// WARNING: --release is the dangerous half. With "drm/vmwgfx: Release PRIME
// import in the BO destroy path" applied, releasing a buffer whose exporter
// sg_table was freed in step 3 makes udmabuf run dma_unmap_sgtable() on a
// table with sgl == NULL and orig_nents != 0 -> NULL pointer dereference.
// Without that patch the release path never touches the table (it leaks).
#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <linux/udmabuf.h>
#include <drm/drm.h>
#include <drm/vmwgfx_drm.h>

#define DRM_IOCTL_VMW_GB_SURFACE_CREATE_EXT \
	DRM_IOWR(DRM_COMMAND_BASE + DRM_VMW_GB_SURFACE_CREATE_EXT, \
		 union drm_vmw_gb_surface_create_ext_arg)
#define DRM_IOCTL_VMW_UNREF_SURFACE \
	DRM_IOW(DRM_COMMAND_BASE + DRM_VMW_UNREF_SURFACE, struct drm_vmw_surface_arg)
#define DRM_IOCTL_VMW_EXECBUF \
	DRM_IOW(DRM_COMMAND_BASE + DRM_VMW_EXECBUF, struct drm_vmw_execbuf_arg)

#define SVGA_3D_CMD_UPDATE_GB_SURFACE 1102
#define SVGA3D_INVALID_ID 0xffffffff
#define SIZE (6UL << 20)

struct update_gb_surface_cmd {
	uint32_t id;		/* SVGA3dCmdHeader.id */
	uint32_t size;		/* SVGA3dCmdHeader.size: bytes that follow */
	uint32_t sid;		/* SVGA3dCmdUpdateGBSurface.sid */
};

int main(int argc, char **argv)
{
	int release = (argc > 1 && !strcmp(argv[1], "--release"));
	int render = open("/dev/dri/renderD128", O_RDWR | O_CLOEXEC);
	int udm = open("/dev/udmabuf", O_RDWR | O_CLOEXEC);
	int mfd, dfd;

	if (render < 0 || udm < 0) {
		perror("open");
		return 1;
	}
	mfd = memfd_create("import-execbuf", MFD_ALLOW_SEALING | MFD_CLOEXEC);
	if (mfd < 0 || ftruncate(mfd, SIZE) ||
	    fcntl(mfd, F_ADD_SEALS, F_SEAL_SHRINK)) {
		perror("memfd");
		return 1;
	}
	struct udmabuf_create c = {
		.memfd = mfd, .flags = UDMABUF_FLAGS_CLOEXEC, .size = SIZE,
	};
	dfd = ioctl(udm, UDMABUF_CREATE, &c);
	if (dfd < 0) {
		perror("UDMABUF_CREATE");
		return 1;
	}

	struct drm_prime_handle ph = { .fd = dfd };
	if (ioctl(render, DRM_IOCTL_PRIME_FD_TO_HANDLE, &ph)) {
		perror("PRIME_FD_TO_HANDLE");
		return 1;
	}
	printf("1. imported udmabuf as GEM handle %u\n", ph.handle);

	union drm_vmw_gb_surface_create_ext_arg a;
	memset(&a, 0, sizeof(a));
	a.req.version = drm_vmw_gb_surface_v1;
	/* HINT_TEXTURE | HINT_RENDERTARGET | BIND_SHADER_RESOURCE | BIND_RENDER_TARGET */
	a.req.base.svga3d_flags = (1U << 5) | (1U << 6) | (1U << 23) | (1U << 24);
	a.req.base.format = 142;			/* SVGA3D_B8G8R8X8_UNORM */
	a.req.base.mip_levels = 1;
	a.req.base.drm_surface_flags = drm_vmw_surface_flag_shareable;
	a.req.base.buffer_handle = ph.handle;
	a.req.base.base_size.width = 1536;
	a.req.base.base_size.height = 1024;
	a.req.base.base_size.depth = 1;
	if (ioctl(render, DRM_IOCTL_VMW_GB_SURFACE_CREATE_EXT, &a)) {
		printf("2. GB_SURFACE_CREATE_EXT on the imported buffer: FAILED, errno %d (%s)\n",
		       errno, strerror(errno));
		return 1;
	}
	printf("2. surface backed by the imported buffer: sid %u\n", a.rep.handle);

	struct update_gb_surface_cmd cmd = {
		.id = SVGA_3D_CMD_UPDATE_GB_SURFACE,
		.size = sizeof(uint32_t),
		.sid = a.rep.handle,
	};
	struct drm_vmw_execbuf_arg e;
	memset(&e, 0, sizeof(e));
	e.commands = (uint64_t)(uintptr_t)&cmd;
	e.command_size = sizeof(cmd);
	e.version = DRM_VMW_EXECBUF_VERSION;
	e.context_handle = SVGA3D_INVALID_ID;
	errno = 0;
	if (ioctl(render, DRM_IOCTL_VMW_EXECBUF, &e))
		printf("3. execbuf UPDATE_GB_SURFACE: returned errno %d (%s)\n",
		       errno, strerror(errno));
	else
		printf("3. execbuf UPDATE_GB_SURFACE: accepted\n");
	printf("   -> now check the kernel log for \"VSG table map failed!\"\n");

	if (!release) {
		printf("4. holding the buffer open (no release). Ctrl-C or kill to end;\n"
		       "   note that ending this process frees the BO, which is the\n"
		       "   step that can oops with the BO-destroy fix applied.\n");
		fflush(stdout);
		pause();
		return 0;
	}

	printf("4. --release: dropping the surface, the handle and every fd\n");
	fflush(stdout);
	struct drm_vmw_surface_arg u = { .sid = a.rep.handle, .handle_type = DRM_VMW_HANDLE_LEGACY };
	ioctl(render, DRM_IOCTL_VMW_UNREF_SURFACE, &u);
	struct drm_gem_close gc = { .handle = ph.handle };
	ioctl(render, DRM_IOCTL_GEM_CLOSE, &gc);
	close(dfd);
	close(mfd);
	close(udm);
	close(render);
	sleep(1);
	printf("5. released, still alive\n");
	return 0;
}

 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
index dfd08ee19..3e8bdf246 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
@@ -189,6 +189,11 @@ static int vmw_ttm_map_dma(struct vmw_ttm_tt *vmw_tt)
 	case vmw_dma_map_bind:
 	case vmw_dma_map_populate:
 		if (vmw_tt->dma_ttm.page_flags  & TTM_TT_FLAG_EXTERNAL) {
+			/*
+			 * The exporter has already mapped its sg_table for
+			 * this device in dma_buf_map_attachment(). Use it as
+			 * it is: it is not ours to map, unmap or free.
+			 */
 			vsgt->sgt = vmw_tt->dma_ttm.sg;
 		} else {
 			vsgt->sgt = &vmw_tt->sgt;
@@ -199,11 +204,11 @@ static int vmw_ttm_map_dma(struct vmw_ttm_tt *vmw_tt)
 				GFP_KERNEL);
 			if (ret)
 				goto out_sg_alloc_fail;
-		}
 
-		ret = vmw_ttm_map_for_dma(vmw_tt);
-		if (unlikely(ret != 0))
-			goto out_map_fail;
+			ret = vmw_ttm_map_for_dma(vmw_tt);
+			if (unlikely(ret != 0))
+				goto out_map_fail;
+		}
 
 		break;
 	default:
@@ -237,6 +242,13 @@ static void vmw_ttm_unmap_dma(struct vmw_ttm_tt *vmw_tt)
 	if (!vmw_tt->vsgt.sgt)
 		return;
 
+	if (vmw_tt->dma_ttm.page_flags & TTM_TT_FLAG_EXTERNAL) {
+		/* The mapping and the table belong to the exporter. */
+		vmw_tt->vsgt.sgt = NULL;
+		vmw_tt->mapped = false;
+		return;
+	}
+
 	switch (dev_priv->map_mode) {
 	case vmw_dma_map_bind:
 	case vmw_dma_map_populate:
-- 
2.55.0

