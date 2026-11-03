Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704320;
	b=NN79v6BJnunil2+O+WXYG+49jAtOS77lBLWdfkuAgbXHACc08HRhrU4tnY9CL3RK+1RO
	 +dTeP0Sr1bLkBMAg8m/rGfYkwBb61L0pqIkbT0aS7TXYZWqsVzI/EFprbhFIZJ0swUk7N
	 XtwhATFeXV4bzHOwBFkK1k2RaFYAjcQq90dhw6HUkBka58N02bW4A6lRik3+ZHfdRBGbY
	 m7Yp0LV8Da6OtSov+z8XSidFh9w1xlsQyE13gdAeyH4XaNr6yTdiqG5DE4EE4yGNfkoPW
	 tSbO8fBE7lPV4fIieBbyRzCtdvBgShkmkYjB9klSAUkDQ4L1K+Fs6ezU1KUk19hpz0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704320;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tn4EvUkvQ0N554yUW20DtCdORcTwQEym6yT5uKZBJKY=;
	b=4PH6kMRhMdtTDGmunHz7zyvyBLypsjzvt03LXdoX9ry/s0UER+6zGSry+5+IKo2632q0
	 Wp0TroGT1oAymIABE7k+48BOyrHYEu/Miw774mOuMhfY/zjfUg3OP+UhhVpS+cW3ppNEW
	 XCm1U9iY8PjzMl3jVfmpKUCIGG9Viq0oLB4RLJjj0/3JfIQLSKApJEMEVe4EkpbsdIr6j
	 lzHBeLhtUnKRQWDHld4g8/w6HzkbE5s57CqUuCb81DVCqwYe81q+9pjo0fvuluCRMfpqC
	 BpCvBVFQzC22iFh/iCRZ1ooE5UUwEWAj9RzJCSe+0rF2Je3vxdzxY/+JqUGPwmT+xQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CTCUUchR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1E2606C5A1;
	Tue,  3 Nov 2026 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CTCUUchR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8AF1F000C1;
	Tue,  3 Nov 2026 11:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704319;
	bh=tn4EvUkvQ0N554yUW20DtCdORcTwQEym6yT5uKZBJKY=;
	h=From:To:Cc:Subject:Date;
	b=CTCUUchRwbFZQnH9vAw3PFU/sp4dOPeDoyPj2on43HtsVp6zxYgOIu8jNaLZ3Yg2G
	 1Z99KfVrP9iSRHgfNP9TicUXiNGbqScZ17BOesR8STjuLsy++H1Abd47DprcOmf/uE
	 F1TkuvCiXV8gtnwx8YklQyQMZFtHC0THDNVzZ2xnfxpNbaNCGFuVxU21D19XSZ2k4C
	 VgyroI+WPzdv8N2z3dsDw95Ccop86L7JtuFQ/Wpz/YuKSWtBlsyE41RF1OANlTCM5A
	 r4e5FOd35UFLLB/k8SrUqWo+v6Z+4tdM7C6lY7+OT47SsXNVMfXLb1Ryp5YXsXkjnl
	 vLsgWxp/Dg3Vg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: airlied@redhat.com
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
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
Subject: [PATCH v2 -resend] drm/qxl: fix use-after-free and NULL pointer deref
Date: Tue,  3 Nov 2026 12:11:54 +0100
Message-ID: <d9930eabe544a4bec5d55113ccd6b1bcd2998bd6.1793704291.git.jirislaby@kernel.org>
X-Mailer: git-send-email 2.56.0
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
2.56.0

