Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794188583;
	b=Xo2GB8r6XJTvJIBSLSHNVIH2jAd1N7BxVdn0Dw6q/SlZXEtNRMliCvApAoabHSr4Jv0z
	 4ZM7akki9y8i6jvQUwKX/7ULPuVPbhF1jCVdWB3iwkmRvbanQpMUv5AcyOER0l/wdLda5
	 UzWVkVjqMtFAdAI36g6vKCL7iYpP3BgYhc9mNDl4vT+MUnOX+bSxh85o1UzIMEfzqvFGS
	 nTvagIRRnArZpizCSk4g97/3H+daILWl5+3pHa1oCvoZN6+JrFuyaMQRzB0GWdYAGgDoh
	 hkbBYaSQQDYRxTq3jF+EFX+gHHFogHkLWb1w0RjO730suIz1EFIQs7H+EUCZK59dxcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794188583;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lcmDctdGM+ZPmo4n0zBEpFAnirakx/N74Fvc8cihL8M=;
	b=J2GtegpjdAoUi0s6rien01lVhX1xu6vh8TUzCCfTBp161s57kngUvZAEI0jTvQaGji0g
	 LuuHJOm7kyyHuGMzHBdqUATkVwpc3fS+qMbJ70PJbRzM0qghtIMKb6xsVWhtSQnlOofRN
	 Gpz8EyOrpXqDe+DZ65D6jN6f9SToQEX0q4cQXlpY8CyomKzzKg729Z0EImnYsmA3MJzts
	 76ummiQQjralpD6OqPjfIUnULvZPvPjQ/jgtpVxlxt18ZXIGz0P/AEqv8iwg0XQ2BIptX
	 lwdfKd5WlcvTj/Tpajzb8Nvb3GuvjfSrzN2M+kmsdomnQL4RzALvszIg5mKj3GuoIHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gQ5QmdNJ;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02617606A332;
	Mon,  9 Nov 2026 01:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02617606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gQ5QmdNJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794188582; x=1825724582;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wsAa2/L/mbiZWmbfru9q1ls/zeEYONCiPJqJ3XWh7fE=;
  b=gQ5QmdNJpwYyo/babJjWUC2iU2U4V0wNFDLkAu7wVXaSNxgF3si2wsJQ
   XuVBYqCoKFaUBZDmnHUZd3eckmeVAYE2Vo8UJhUxBU0aYXBnq5qFeZBmy
   9YsDtqRqiehn176D+6UUnBCSSxeUFQPwmUXLFU/qLoZFFrohE6b5v44yW
   mQaLMsoNJGxBpZwDMfOatJLMWll+kYuHYt2lJDeClfrklqyhxJ3dRSTyr
   g3k46hFASU16QsZpTfk2Ry2kv0czy3bmci2BS/N9q4gFuziHJmkUF23sG
   c81WnyYH/xOPPsCt4Dp5j83oemquQ9k9mPcvK6Ni8Lo5e0ZxFGzBt2RtA
   A==;
X-CSE-ConnectionGUID: KfF92RuzSF2O7zbYndk7iw==
X-CSE-MsgGUID: MTx+2aBoT3qkSFaxObw2hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2956319"
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="2956319"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 17:43:01 -0800
X-CSE-ConnectionGUID: YOYE8PXER66Ej7YgwIwDNw==
X-CSE-MsgGUID: VFN7djWGQLKyEGqawQqt8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="9502877"
Received: from yufei-super-server.sh.intel.com ([10.239.92.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 17:42:58 -0800
From: "Yu, Fei" <fei.yu@intel.com>
To: dri-devel@lists.freedesktop.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	syzbot+95416f957d84e858b377@syzkaller.appspotmail.com,
	Madhur Kumar <madhurkumar004@gmail.com>,
	Fei Yu <fei.yu@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] drm/syncobj: Limit the number of handles and use kvmalloc for user-sized arrays
Date: Mon,  9 Nov 2026 09:48:52 +0800
Message-ID: <20261109014852.2127723-1-fei.yu@intel.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Fei Yu <fei.yu@intel.com>

The syncobj ioctls allocate several temporary arrays whose size is taken
directly from the u32 count_handles provided by userspace:

 - handles and syncobjs in drm_syncobj_array_find()
 - points and entries in drm_syncobj_array_wait_timeout()
 - points and chains in drm_syncobj_timeline_signal_ioctl()

These are kmalloc() allocations, so a count above KMALLOC_MAX_SIZE /
element size trips the WARN_ON_ONCE_GFP() in ___kmalloc_large_node():

  WARNING: mm/slub.c:5459 at ___kmalloc_large_node+0x10c/0x170 mm/slub.c:5459
  Call Trace:
   __kmalloc_large_node_noprof+0x18/0x90 mm/slub.c:5502
   __do_kmalloc_node mm/slub.c:5519 [inline]
   __kmalloc_noprof+0x3f6/0x710 mm/slub.c:5556
   _kmalloc_noprof include/linux/slab.h:995 [inline]
   _kmalloc_array_noprof include/linux/slab.h:1211 [inline]
   drm_syncobj_array_find+0x3a/0x440 drivers/gpu/drm/drm_syncobj.c:1241
   drm_syncobj_timeline_wait_ioctl+0x18a/0x640 drivers/gpu/drm/drm_syncobj.c:1356
   drm_ioctl_kernel+0x2df/0x3b0 drivers/gpu/drm/drm_ioctl.c:817
   drm_ioctl+0x70e/0xba0 drivers/gpu/drm/drm_ioctl.c:914

The wait entries are 64 bytes each on 64-bit, so with a 4 MiB
KMALLOC_MAX_SIZE a wait on more than about 64K handles already fails
today, with a warning.

Fix this in two parts:

 - Reject more than DRM_SYNCOBJ_MAX_HANDLES (1M) handles with -EINVAL in
   drm_syncobj_array_find(), which every ioctl taking a handle array goes
   through. The limit is a fixed number, so it is the same on all
   architectures. It is above what these ioctls can handle today: with a
   4 MiB KMALLOC_MAX_SIZE the 8-byte arrays already fail above 512K
   handles on 64-bit, so no request that succeeds now is rejected. A
   static_assert() makes sure that the largest per-handle allocation, the
   wait entries, stays below the INT_MAX size limit of kvmalloc().

 - Switch the six allocations to kvmalloc(), so that handle counts up to
   the limit (64 MiB of wait entries for 1M handles) no longer depend on
   physically contiguous memory.

Using kvmalloc() alone is not enough: the reproducer asks for more than
INT_MAX bytes, which hits the WARN_ON_ONCE() in __kvmalloc_node_noprof()
instead.

Fixes: 3e6fb72d6cef ("drm/syncobj: Add a syncobj_array_find helper")
Reported-by: syzbot+95416f957d84e858b377@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=95416f957d84e858b377
Suggested-by: Christian König <christian.koenig@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Fei Yu <fei.yu@intel.com>
---
v3:
 - Use a fixed DRM_SYNCOBJ_MAX_HANDLES of SZ_1M instead of deriving it from
   sizeof(struct syncobj_wait_entry), so the limit is the same on 32-bit
   and 64-bit, and add a static_assert() against the kvmalloc() INT_MAX
   limit (Christian).
 - 1M rather than 64K: with a 4 MiB KMALLOC_MAX_SIZE, reset, signal, query
   and timeline_signal currently work up to 512K handles on 64-bit, so a
   64K limit would turn requests that work today into -EINVAL.
 - Keep the define kernel internal for -fixes; documenting the limit in
   the uAPI struct comments will be a separate patch for -next.
 - Add Cc: stable.
 - v2: https://lore.kernel.org/all/20261104030930.3852781-1-fei.yu@intel.com/

v2:
 - Drop __GFP_NOWARN (Christian).
 - Add DRM_SYNCOBJ_MAX_HANDLES, return -EINVAL above it, and switch all six
   arrays to kvmalloc() (Christian).
 - v1: https://lore.kernel.org/all/20261103085002.3100723-1-fei.yu@intel.com/

The vmemdup_array_user() conversion and the points array cleanup Christian
pointed out are left to Tvrtko's series, which he will rebase on top of
this fix for -next.

Testing on v7.4-rc1 (x86_64, KASAN, virtio-gpu in QEMU):
 - syzbot C reproducer: base warns in ___kmalloc_large_node(), patched is
   clean, the ioctl returns -EINVAL.
 - 1048576 signaled syncobjs; wait, timeline_wait, timeline_signal, query,
   reset and signal with count 200000, 1M and 1M + 1:
     base:    200000: wait and timeline_wait fail with -ENOMEM and the
              warning, the others succeed. 1M: all six fail with -ENOMEM.
     patched: 200000 and 1M: all succeed. 1M + 1: all return -EINVAL.
 - drm_syncobj.o builds for i386 with W=1 (static_assert holds).
 - checkpatch --strict clean, W=1 clean, kmemleak clean,
   DRM KUnit 667/667 passed.
 - IGT syncobj_basic, syncobj_wait, syncobj_timeline on virtio-gpu:
   202/202 subtests pass, same as base.

 drivers/gpu/drm/drm_syncobj.c | 44 +++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index f1d4da168545..c8a8c49d12fb 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -199,6 +199,7 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/sched/signal.h>
+#include <linux/sizes.h>
 #include <linux/sync_file.h>
 #include <linux/uaccess.h>

@@ -220,6 +221,16 @@ struct syncobj_wait_entry {
 	u64    point;
 };

+/*
+ * Upper limit for the number of handles passed to a single ioctl. This is a
+ * fixed number so that the limit is the same on all architectures. The
+ * largest per-handle allocation is the wait entry array, which must stay
+ * below the INT_MAX size limit of kvmalloc().
+ */
+#define DRM_SYNCOBJ_MAX_HANDLES	SZ_1M
+static_assert(DRM_SYNCOBJ_MAX_HANDLES <=
+	      INT_MAX / sizeof(struct syncobj_wait_entry));
+
 static void syncobj_wait_syncobj_func(struct drm_syncobj *syncobj,
 				      struct syncobj_wait_entry *wait);

@@ -1051,7 +1062,7 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 		lockdep_assert_none_held_once();
 	}

-	points = kmalloc_array(count, sizeof(*points), GFP_KERNEL);
+	points = kvmalloc_array(count, sizeof(*points), GFP_KERNEL);
 	if (points == NULL)
 		return -ENOMEM;

@@ -1064,7 +1075,7 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 		goto err_free_points;
 	}

-	entries = kzalloc_objs(*entries, count);
+	entries = kvzalloc_objs(*entries, count);
 	if (!entries) {
 		timeout = -ENOMEM;
 		goto err_free_points;
@@ -1185,10 +1196,10 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 						  &entries[i].fence_cb);
 		dma_fence_put(entries[i].fence);
 	}
-	kfree(entries);
+	kvfree(entries);

 err_free_points:
-	kfree(points);
+	kvfree(points);

 	return timeout;
 }
@@ -1238,7 +1249,10 @@ static int drm_syncobj_array_find(struct drm_file *file_private,
 	struct drm_syncobj **syncobjs;
 	int ret;

-	handles = kmalloc_array(count_handles, sizeof(*handles), GFP_KERNEL);
+	if (count_handles > DRM_SYNCOBJ_MAX_HANDLES)
+		return -EINVAL;
+
+	handles = kvmalloc_array(count_handles, sizeof(*handles), GFP_KERNEL);
 	if (handles == NULL)
 		return -ENOMEM;

@@ -1248,7 +1262,7 @@ static int drm_syncobj_array_find(struct drm_file *file_private,
 		goto err_free_handles;
 	}

-	syncobjs = kmalloc_objs(*syncobjs, count_handles);
+	syncobjs = kvmalloc_objs(*syncobjs, count_handles);
 	if (syncobjs == NULL) {
 		ret = -ENOMEM;
 		goto err_free_handles;
@@ -1262,16 +1276,16 @@ static int drm_syncobj_array_find(struct drm_file *file_private,
 		}
 	}

-	kfree(handles);
+	kvfree(handles);
 	*syncobjs_out = syncobjs;
 	return 0;

 err_put_syncobjs:
 	while (i-- > 0)
 		drm_syncobj_put(syncobjs[i]);
-	kfree(syncobjs);
+	kvfree(syncobjs);
 err_free_handles:
-	kfree(handles);
+	kvfree(handles);

 	return ret;
 }
@@ -1283,7 +1297,7 @@ static void drm_syncobj_array_free(struct drm_syncobj **syncobjs,

 	for (i = 0; i < count; i++)
 		drm_syncobj_put(syncobjs[i]);
-	kfree(syncobjs);
+	kvfree(syncobjs);
 }

 int
@@ -1572,8 +1586,8 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 	if (ret < 0)
 		return ret;

-	points = kmalloc_array(args->count_handles, sizeof(*points),
-			       GFP_KERNEL);
+	points = kvmalloc_array(args->count_handles, sizeof(*points),
+				GFP_KERNEL);
 	if (!points) {
 		ret = -ENOMEM;
 		goto out;
@@ -1586,7 +1600,7 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 		goto err_points;
 	}

-	chains = kmalloc_objs(*chains, args->count_handles);
+	chains = kvmalloc_objs(*chains, args->count_handles);
 	if (!chains) {
 		ret = -ENOMEM;
 		goto err_points;
@@ -1609,9 +1623,9 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 		dma_fence_put(fence);
 	}
 err_chains:
-	kfree(chains);
+	kvfree(chains);
 err_points:
-	kfree(points);
+	kvfree(points);
 out:
 	drm_syncobj_array_free(syncobjs, args->count_handles);


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
--
2.53.0
