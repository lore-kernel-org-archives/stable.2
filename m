Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC1B3CB56B;
	Fri, 28 Aug 2026 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787907103; cv=none; b=LhgLw2MrLY09xjRo7YpTAfJhybxPALyzO3/ANMzkZU1mk1D4Jb8NiH3tyrOzdBE5on1TLFJh2BFiosWtJKCnMgH4IJBizdQNp+LMaKLzoUT50YeVHdiIKJiVDRFcFHzOvFTzM95QtuWrjBdXYQbStqnJ0iT/oyzcVZIrXEQFY78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787907103; c=relaxed/simple;
	bh=Lehy00NdNljvDsHtHs9Ikhbdp0KCBAIDSAWxSxpM5Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oHVVg9Ug5JgQaKEp6i/I4VFOaiZrpSqyQs81l/BTStxAnKq7SHU1Z45M54b/hvgdGSSUOHjYe45hqDOY05Gkx1TwBG31R7fi8Otvv64JiQEqlIQYysZuzUY0qSYfCVYh4dXBVL2S7touz1+0Kl1k7lDI06ls8ILThwl/5w6Lp/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwwoebXP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwwoebXP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDB21F000E9;
	Fri, 28 Aug 2026 08:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787907101;
	bh=iHBSUDDx1WbolXW0Nyh2IRj9cxuhb4M6H5r9hbv6v5w=;
	h=From:To:Cc:Subject:Date;
	b=MwwoebXPHKhkZn8W5TgPtCIHt2/bh0gn5bc3Op2iQ31YgzRxFScemnTxhXARslqi1
	 Yr6FVrT05g5hYx0UTnd8lheht+h9oqNXjqp1uFdgM5hBslha1xIAi3O/pfSCvwaAZG
	 13tIaTynKi1BrzAbc27OhQ01GK/rWqjFrEHtfJOgUtvDo/bTwLSA8PsZNf0vBlA1JQ
	 lDHEo+YlF66FWIZ0wAMlDVeggU+Fbbvv/ddBithXCM83xLYAjMwytdgVZWB3MgjNtj
	 bM1XyS4iXqTwQB7FsXYefGA4qA1uSKbJlym1Gp+tgtLZGCbJ66dn31s4GB6/ybmfwd
	 c4NC5D8Hafz6g==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: devel@lists.crash-utility.osci.io
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Gemini <gemini@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	stable@vger.kernel.org,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/qxl: fix use-after-free and NULL pointer deref
Date: Fri, 28 Aug 2026 10:51:36 +0200
Message-ID: <20260828085136.128561-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When allocating a `qxl_release` structure with `kmalloc()`, the underlying
memory contained uninitialized garbage. Specifically, `release->base.flags`
(part of the embedded `dma_fence`) was not cleared.

This garbage in `base.flags` caused helper functions such as
`dma_fence_was_initialized()` to return true even for releases where the
fence was never actually initialized (e.g. via `dma_fence_init()`).

Consequently, during release cleanup in `qxl_release_free()`, the driver
attempted to put/free an uninitialized `dma_fence`, leading to refcount
underflows (`refcount_t: underflow; use-after-free`) and subsequent NULL
pointer dereferences in `dma_fence_signal_timestamp_locked()`.

Fix this by switching from `kmalloc()` to `kzalloc_obj()` in
`qxl_release_alloc()`, ensuring all fields (including embedded fence
flags) are properly zero-initialized upon allocation, and remove
redundant explicit zero-initializations.

The dumps in question:
 refcount_t: underflow; use-after-free.
 WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90, CPU#0: kworker/0:0/1534
 Modules linked in: af_packet nft_fib_inet ...
 CPU: 0 UID: 0 PID: 1534 Comm: kworker/0:0 Not tainted 7.1.3-1-default #1 PREEMPT(full) openSUSE Tumbleweed  b041a6527f6e58424f4cd3de0fade8d408b378fd
 ...
 RIP: 0010:refcount_warn_saturate+0x59/0x90
 ...
 Call Trace:
  <TASK>
  qxl_release_free+0xee/0xf0 [qxl d93e9381353e619799d56790f5f8dda6cce491f6]
  qxl_garbage_collect+0xd1/0x1b0 [qxl d93e9381353e619799d56790f5f8dda6cce491f6]
  process_one_work+0x19e/0x3a0
 ...

And then of course:
 BUG: kernel NULL pointer dereference, address: 0000000000000028
 ...
 RIP: 0010:dma_fence_signal_timestamp_locked+0x32/0x120

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Assisted-by: Gemini <gemini@google.com> # only commit log
Fixes: 2bcbc706dfa0 ("dma-buf: add dma_fence_was_initialized function v2")
Closes: https://bugzilla.suse.com/show_bug.cgi?id=1271081
Cc: Christian König <christian.koenig@amd.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: stable@vger.kernel.org
---
Cc: virtualization@lists.linux.dev
Cc: spice-devel@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org

[v2] use kzalloc_obj() instead of bare kzalloc()
---
 drivers/gpu/drm/qxl/qxl_release.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 06979d0e8a9f..07dc6eafe6f7 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -89,17 +89,13 @@ qxl_release_alloc(struct qxl_device *qdev, int type,
 {
 	struct qxl_release *release;
 	int handle;
-	size_t size = sizeof(*release);
 
-	release = kmalloc(size, GFP_KERNEL);
+	release = kzalloc_obj(*release);
 	if (!release) {
 		DRM_ERROR("Out of memory\n");
 		return -ENOMEM;
 	}
-	release->base.ops = NULL;
 	release->type = type;
-	release->release_offset = 0;
-	release->surface_release_id = 0;
 	INIT_LIST_HEAD(&release->bos);
 
 	idr_preload(GFP_KERNEL);
-- 
2.55.0

