Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D786A3EB11C;
	Fri, 28 Aug 2026 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906760; cv=none; b=Ev5nTgsVSE6tMHYAW8nmtqAg99dli449NlUUj2p0hjyb0o/DsOB3lXr/N/5C+7VR6S6QMu5kanzgpfBD8wO4p2xVlCD2EMmJOEL4QMSjHTbACN7JKfGM7u+Me16S79rHWfTzr5fXd81tT8Bq0jdXk8L8dRoalxIKoXl1QxdmrXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906760; c=relaxed/simple;
	bh=Vk/Jx5HL1xRIxo0j0/Ivy2To1Yi2AQV0lo9JC6GWpWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iKLa4t6otTPIPAoTs32kuUs4dVcWLIf/uCQY5+Q2AYHItUmlu4jtmyPk4jLULvCwP/0Qw+6REidyIdX3v0FQFzD++lAy8WDAnDDuJLHc5Iovn5UcROS+5BHd8AmK6RnW6scdO6KHowPusxdgLzTXdmU6XBP7h0ZJzakUkLl3PVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0GmtX80; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0GmtX80"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C351F000E9;
	Fri, 28 Aug 2026 08:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787906758;
	bh=0TR0uRWDlZn4hcSy+1eDkkclABFE/m9WQ+o6MX2CdCM=;
	h=From:To:Cc:Subject:Date;
	b=J0GmtX80uQS026ZsfQnLaoxoBfWyF6vVp48IDugUpD9xUxLN8qDIG/ssWecLbpjIs
	 sxV9ziTgc4hZVZDHMB5ymCey4Td+d7BXMyjcEo65YPjlC9Jy2kwQEWE7RQrTcWj+pF
	 qldTn06x4bF0fmquVfS7SJX63APOjM7y7eMtSH/CnpAsrmdw5WlS66e4DD4En7LWj3
	 Ar+YKM4yUE8hUkC+ugDir81mw38ld/b9SRyW5fJK71PZvJ9Tvg7aWa1omwqVSVvmMi
	 b5vEvjL0uLPavSIGD+5IBtT5g/XyEbzdAdRcJiYQ6nEaALcHTvHt7xmHsYdxHZ+A3Q
	 nn8YlAIHHP0iw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: airlied@redhat.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Gemini <gemini@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
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
Subject: [PATCH] drm/qxl: fix use-after-free and NULL pointer deref
Date: Fri, 28 Aug 2026 10:45:53 +0200
Message-ID: <20260828084553.124037-1-jirislaby@kernel.org>
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

Fix this by switching from `kmalloc()` to `kzalloc()` in `qxl_release_alloc()`,
ensuring all fields (including embedded fence flags) are properly zero-initialized
upon allocation, and remove redundant explicit zero-initializations.

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
---
 drivers/gpu/drm/qxl/qxl_release.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 06979d0e8a9f..92c88f9c17a8 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -91,15 +91,12 @@ qxl_release_alloc(struct qxl_device *qdev, int type,
 	int handle;
 	size_t size = sizeof(*release);
 
-	release = kmalloc(size, GFP_KERNEL);
+	release = kzalloc(size, GFP_KERNEL);
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

