Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488231;
	b=ZE4oVUuMs1DG7ck0RtMPVIgiZy/BKta3PcRCFYCJPHDt18Qnm0fabDzId4y615j3M9TC
	 6GWIWShSTgtbdCZAQ9OabqNiQMNzhzdzlbO8FM97rMN6pvgUFMBsJqYUpS4nj/jVd8a3V
	 M1yal1pG5CFSOhO/KA+d0NP3+z9ftyshjI7D96IsXGCWfY7HjNidlOJsEZRxHfKXrx6t+
	 NTRvQRGmrIm88rELbl9IkwP8Bf5gfh+W6pTm2KfA3v3UqN0m3hfQ4o5rPKNwe8gCLJOgV
	 uVfdhqKc+lgSWhUyujPOlDLH8y70uKcdJc1jkPXXZNaj/pNyQPuTRSOiQ4IxVBiqJew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488231;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=3NQ59OMNKcd9t+j12Tee+t591FmbFKofgobaYbJuglY=;
	b=f8p3VcKMc+iiXjLYSlDGu9d8m8gqMH7aj2AwaG/PXuw8Y33zbI/cbl5sDnXdT7TlgWFG
	 o0tV4s54Quhr0nOmaNy2Vhg7XegTPOewuhnLgqptwBJcVAHe6GO0uGsAAFVSi/WRHjOfI
	 T9brSIo3wbF5HvuljBwInMr5zEDkfUaywdXgaIVJYrtgt7EtE5RViNCJ+Th/0ArkIfn9a
	 LbJjodP0/xLzI1ECWrcOi2V91pN9t2PkWVn3rFR30oV+fCIfAIHppLdd4CEhWKCcMgq5s
	 5F1Lptv2qax9U5gcoeb2HI75A+Y/5o0GFLA78wr99vandu49Pb/D9ikRt2fMH9epd0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=VPLuB1XS;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF04D606A32E
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF04D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=VPLuB1XS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Reply-To;
	bh=3NQ59OMNKcd9t+j12Tee+t591FmbFKofgobaYbJuglY=; t=1794488229; x=2109848229; 
	b=VPLuB1XSpIYTNjaQvzmlrrw3+64wjjCvYoe3WnT7ZPD9fzaLdd7uIQrX5y2/tv8Bxi3VQoTcwRp
	GZ2wHiZKvj3aMg711aWRmHz/AWEkEjCp830DU9hrly9bTgzHwI15umfLNa1mPOlzS6N3b5D77ZfiZ
	lxDkaiEN/9ak2JTpI25+0UPXUrB6Cma6nTaemVMNlKNsRWr3J0C5YkN8Jgxc2k05qHoF0QLUiig6q
	koDB85jVoJFQpz2Xkho8s/IwEHbn1L8g9IE/mGAM91vNzpl84jsbmkd1sQFoIIEKAk8P/LbP4aqWc
	gsgM1Ejwiu0M1/oY0j8jdxx69GcuFOHYTLBQ==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xRUMS-009Xxy-FO; Thu, 12 Nov 2026 13:57:04 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/2] drm/vc4: Fix async page flip completion
Date: Thu, 12 Nov 2026 09:56:54 -0300
Message-Id: <20261112-vc4-async-flip-fixes-v1-0-42449a703840@igalia.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2LSQqAMAwAvyI5GzDign5FPLQ1akCqNCCK+HeDc
 xuGeUA5CSv02QOJT1HZownlGYTVxYVRJnMoi7IhA89QodM7Bpw3OXCWixXJk/PUTqHtarD1SPw
 HO4fxfT+Ho0FeZgAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2520; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=clP/E8svD4QHx2DDpj4aVerbORgSn1ktcdo4AoG6um0=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq9beZcJn+SwfZR7BIPW10lVdnDDBmgGfrymuBe
 NzFoKmzIV6JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCavW3mQAKCRA/8w6Kdoj6
 qiMhCACCodUudZ+/m3kJb0PpvFa3ZKUnzS1EzSHpcmeMpMguLLBN3jie4HlzrmvNNplqKk/fMJR
 LoxDumJz0GjPh1ToGZaAbBo9iclXdnAEc8jIB5bY6kjVzuqn4lNbeeT4NwH8sY3erVTD/ZlAIf8
 yenU1uszFdx26sgrhyrW9Cg1np/7rnupr7Usf/EFLbQtJkkZSboJHY1/NvVvyHjKkiUBvsRV+GM
 R/KwHX/9oZzTjUXr0ovWJlJuIFJ703y8Hkgzbvx1sYmuUSUPpdHIljDZrvmXPMa1q7MHF3qBY/R
 fqihmyw6qXen6jWHJjyzaxnvW5z856UdlsLXmYBmLNdI8sra
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

VC4 implements async page flips with a custom code path that waits for
the BO fence before completing the flip. On VC4_GEN_4 (RPi 0-3), the
completion also decrements the usecnt of the old FB's BO. This series
fixes two bugs in that path.

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

Patch 1 fixes the use-after-free and patch 2 moves the completion to a
worker. The UAF fix comes first, as it affects older stable kernels that
don't have the dma_fence-based completion.

Best regards,
- Maíra

---
Maíra Canal (2):
      drm/vc4: Drop BO usecnt before releasing the old FB
      drm/vc4: Complete async page flips from an ordered workqueue

 drivers/gpu/drm/vc4/vc4_crtc.c | 108 ++++++++++++++++++++---------------------
 drivers/gpu/drm/vc4/vc4_drv.h  |   6 +++
 2 files changed, 58 insertions(+), 56 deletions(-)
---
base-commit: 8bf8cda54c08ee3693f4dd1e2b7607fe5e466c79
change-id: 20261111-vc4-async-flip-fixes-1b1ab17dc795

