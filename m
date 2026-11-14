Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794683856;
	b=sv6ElzOhwmVadpvlyNz4os9ylc5rej8fEmyouGOzSv0AAU7MO6DR4l/SkkPyEBrsB2IJ
	 8AIVcpYNTtJm0KSB8PppePvsAniV7feZhFZi7nmIw65GaYZ1mEGsnBZdrM4gyTu91wlRR
	 hilDYez10+M59PTKFvjmcx+Uhp/zSeemdZ+G8NrrJaXCnw/0ks7vNzLkNOUEg+d3mX4gw
	 R+ER8qm/UkVuReQqSfp5L3Dw+CtTdm2XmNUJPZekceieeOvrYq7hwsg1BgrM4UcMK/zvM
	 EuoZtHYfylpab4lwYrcHT7xnWbGLhq1tatFmJnejwXN4wOYrItItw3eVaA1YhexLylQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794683856;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=gc5Z6gN9T1zRiO8jOARI7bBD/WlDAtzBF45Ir4fmwrA=;
	b=30g1DS33ivC5l74WffOpSzAjrftWiGk6Bq15ulwA7KkC4dgbSyhJIEE+CquCbkpanSMM
	 S8hgFZJ6WR+BpXDVe0LDPQA7XJXWMLPooPLVR7kDn/I0PMbgxRSo3Ll3Yk627yTm87f/9
	 loS2psXg5XQAZfZ+ZZC1qiJu5KAQAjdOIrLoQGmUU73yJkrqtPQfjXEprWLkZDWMXqqnB
	 LSX5mlYG5fBAFjv3mhKFoawjNhGfGFH9HBNabU3ROHgsFhenFddESnUscVLvpV6VGKxFl
	 aef2jY3+kleoEqlKB27bQKf7DPDKsLT52eg0TXVY4YDu1Ebp0h/M3km+vSDOBDTnMyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=d3yNbaEl;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B608606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 19:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B608606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=d3yNbaEl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Reply-To;
	bh=gc5Z6gN9T1zRiO8jOARI7bBD/WlDAtzBF45Ir4fmwrA=; t=1794683854; x=2110043854; 
	b=d3yNbaElBKbo98xDdBuK+BqfFaNHHRmxr4fpkkH5GavoBxD0fudGiBBZldHwRMxI8g1RC4yRF51
	0Moa+VxlGarV9Cxn7FKwoRTCjCIb1A7p8og2rLTYX2ARiA83sofdqm8GBq3bpST53qYPvfzxLpO95
	GSmd95Z0rxz1kxl2vVOUajLmxlcR7rOpJAF6zehp5SfCXeIr0yAePD5gOeBQ8r82bjhzrkXXEdu5k
	jJNjWpZUBMQHPqDEtqDz8Ft9DxhVLLhkkNgo8dtdTDyeuHK28iAWBqQzlf+NxXkhTVLlic81lpWDB
	0/+AiLTRAbppY3HKA3OGbIoJbU2UeOLvKbYg==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xSJFi-00AgZ4-8m; Sat, 14 Nov 2026 20:17:30 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v2 0/3] drm/vc4: Fix async page flip completion
Date: Sat, 14 Nov 2026 16:16:49 -0300
Message-Id: <20261114-vc4-async-flip-fixes-v2-0-d33cbe99ed5d@igalia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQ6CMBBEf4Xs2TXdWq148j8Mh1IKbIKUtKaRk
 P67lcSbc3szmZkNogvsItyqDYJLHNnPBeShAjuaeXDIXWGQQl6oCJNVaOI6W+wnXrDnt4tILZm
 WdGd1fYZSXYLbg9J8NIVHji8f1v0l0df9Dcr/g4lQoJJK1UaL01WJOw9mYnO0/glNzvkD1aHCE
 bkAAAA=
X-Change-ID: 20261111-vc4-async-flip-fixes-1b1ab17dc795
To: Iago Toral <itoral@igalia.com>, Melissa Wen <mwen@igalia.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3372; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=k9c7fjRnDZfH2KZDLdxlR4nqcUEFKDoSPfRPfYSSyFI=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq+LPGQAr5eyX8M2bytNlzNJALeU7iRQ1ntnmJV
 Kv06rVenGyJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCavizxgAKCRA/8w6Kdoj6
 qqAyCADaH+eqRrSh3X8Q+Gnt9bBhDOq3rIAQEz4KlugrDnNF8CnUEYZpaASOEyEId3sJ7+aeBU7
 a4S/16G/+aeAst2IfoAVFI6wZfauP7FdwG/Tidoh1Sel/rTyFF23cFJGKYY78voYQxmZEua63p5
 fbaMt8UZ9JNkXnkXfenQac+J4vAyPY9XpMsIkt3fA2HPb74KKbcf1pfLorDq9g4/zVcyhn1yfrp
 BM7utgdK4G1QYAmuUwmt20tbVrJKfWwu9P60VZpYGjrZ7ek9Ax/6vM8lTEY1E+Gy1eDC8EDjNii
 Oufz4SmubGocurcA/GIcNIfzDTyTykgPEAxut87RnI34aHXC
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

VC4 implements async page flips with a custom code path that waits for
the BO fence before completing the flip. On VC4_GEN_4 (RPi 0-3), the
completion also decrements the usecnt of the old FB's BO. This series
fixes three bugs in that path.

Since commit e8941ac97f28 ("drm/vc4: Remove BOs seqnos"), the completion
runs from a dma_fence callback. VC4 signals that fence from the render
job IRQ handler. As vc4_bo_dec_usecnt() takes a mutex, running an SDL
application with SDL_VIDEODRIVER=kmsdrm on the RPi 3 triggers:

  [ 2511.636319] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:623
  [ 2511.636667] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/0
  [ 2511.636681] preempt_count: 1000002, expected: 0
  [ 2511.636689] RCU nest depth: 0, expected: 0
  [ 2511.636698] locks held by swapper/0/0: 1, on CPU#0:
  [ 2511.636711]  #0: ffff000037183198 (&fence->inline_lock){-...}-{3:3}, at: dma_fence_signal+0x88/0xec
  <snip>
  [ 2511.636892] Hardware name: Raspberry Pi 3 Model B Plus Rev 1.3 (DT)
  [ 2511.636899] Call trace:
  <snip>
  [ 2511.636991]  mutex_lock_nested+0x24/0x30
  [ 2511.637002]  vc4_bo_dec_usecnt+0x40/0x124 [vc4]
  [ 2511.637070]  vc4_async_page_flip_complete_with_cleanup+0xa0/0xc4 [vc4]
  [ 2511.637102]  dma_fence_signal_timestamp_locked+0x118/0x290
  [ 2511.637116]  dma_fence_signal+0x9c/0xec
  [ 2511.637126]  vc4_irq_render_job_done+0x24/0x114 [vc4]
  [ 2511.637158]  vc4_irq+0x16c/0x274 [vc4]

While looking into this issue, I also noticed that, since commit
4d12c36fb73b ("drm/vc4: crtc: Move the BO handling out of common page-flip
callback"), the old FB is released before decrementing its BO usecnt. If
userspace removes the old FB and closes its handle while the flip is
pending, vc4_bo_dec_usecnt() runs on a freed or recycled BO.

Patch 1 fixes the use-after-free, patch 2 moves the completion to a worker
and patch 3 returns fence lookup errors to userspace instead of leaving
the flip pending forever.

In v1, Sashiko reported that a flip waiting on its fence can complete
after, or concurrently with, a later flip that has no fence. This has been
possible since commit 82faa3276012 ("drm/vc4: kms: Remove async modeset
semaphore") and isn't changed by this series. The best way to fix it
would be moving to the generic async helpers, which is on my TODO list.
Until then, this series keeps the current behavior and only fixes the bugs
above.

Best regards,
- Maíra

---
v1 -> v2: https://lore.kernel.org/r/20261112-vc4-async-flip-fixes-v1-0-42449a703840@igalia.com

- [1/3] Add the refcount underflow warning to the commit message.
- [2/3] Allocate the workqueue after initializing the CRTC, so it's
  released before the CRTC is cleaned up and named after the CRTC (Sashiko).
- [3/3] New patch.

---
Maíra Canal (3):
      drm/vc4: Drop BO usecnt before releasing the old FB
      drm/vc4: Complete async page flips from an ordered workqueue
      drm/vc4: Look up the async page flip fence before committing the flip

 drivers/gpu/drm/vc4/vc4_crtc.c | 136 +++++++++++++++++++----------------------
 drivers/gpu/drm/vc4/vc4_drv.h  |   6 ++
 2 files changed, 70 insertions(+), 72 deletions(-)
---
base-commit: d48ea86919434695da12d280dccab72b094397e1
change-id: 20261111-vc4-async-flip-fixes-1b1ab17dc795

