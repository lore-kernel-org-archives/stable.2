Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4A7427FAB;
	Mon, 27 Jul 2026 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785185191; cv=none; b=FuIutB3wGL8KM/wEQbccx+ADa/ws8SpLgVbenk6hs+ZNRsDS0T1uvF7FScZBGyzXCF4FuksAAoAKwlvPG2LMm3NzeLG35JezXKI+fTLmJa2IJWJXpSsIWjxhcSdeLMKfb85yzVmN5crgfr/gkYsX7lgtylT9rBhGocCFbr1cj8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785185191; c=relaxed/simple;
	bh=BGK6zDJOt+Ou+GK6PEY++NZQulWjFBd446vKz/Palf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gsgrCPlqLa+0evhn2Caa5FTQnaTrIoRtDmFn5yMEcD8yyLucVBzEB07Jah6Td7jgd3sErmS9ftXI0jESXXlUTwNkcH4KlIJsqU6AwIF64kMT6A+cH6DAlc+cR6ye9G3EMM26RoTK9eYCzDbVP/yWXOCumX9hILHIgzzp2QOPzC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WIosT/Ov; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WIosT/Ov"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=yl0NUMr0TDqZO/IOU8fA9DWQn4BnbIyksUsi7vU4w4g=; b=WIosT/Ov5wZZCiXhk55/xVWVOA
	eIViSQ8E6CYKWKAtervfugn9S6xah6P4KmyuY3EqecmT+JguEKIyQ59cDgucnC67dQLQOq5aPfjCo
	/Iw6NBWO2gwJWs5bOlHIJ+5IVeGu3ptYrsZszNkRRLzgPJJfpcnBMVdCLUaafTRGN1XWXJsIWHJa/
	LSn8tpw9yNo/79/JrTSlBsMHtRxDKY+nv0rEPYUrLj7o4NnNCP+rCSU+n7DsPDgsU2J9w2B3IUgwG
	aJtRdQ9Oh735pWK2aItdew3e4yJNafzMRhWrwcmhD+3utWBqhWtCJViQ8JtYMDY2DF060wQl8qC0M
	X3Wgyoxw==;
Received: from 179-125-64-236-dinamico.pombonet.net.br ([179.125.64.236] helo=[127.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1woSDD-006gjL-44; Mon, 27 Jul 2026 22:46:11 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Mon, 27 Jul 2026 17:45:49 -0300
Subject: [PATCH] drm: Fix drm_crtc_commit leak if signaled when
 PAGE_FLIP_EVENT is used
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-drm_crtc_atomic_commit_leak-v1-1-23d9948a9d7c@igalia.com>
X-B4-Tracking: v=1; b=H4sIAHzDZ2oC/yXMQQrCMBAAwK+UPTfQxrYBvyIlJJtVV00jmyiF0
 r8b9TiX2SCTMGU4NhsIvTlzWir6tgG8uuVCikM16E5PndFGBYkWpaB1JUVGiylGLvZB7q6GQCO
 ZsZ+0P0AdnkJnXn/7af47v/yNsHxL2PcPyXMzOH8AAAA=
X-Change-ID: 20260727-drm_crtc_atomic_commit_leak-4de5e75162b3
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, stable@vger.kernel.org, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.16-dev-62088

Commit 1c6ceeee6ebb ("drm/atomic: Fix memleak on ERESTARTSYS during
non-blocking commits") fixed a very similar issue when the event was
allocated by drm_atomic_helper_setup_commit() itself.

However, if the event is allocated in prepare_signaling(), it will also be
set to NULL in complete_signaling(), which prevents drm_crtc_commit from
being put in __drm_atomic_helper_crtc_destroy_state().

Dropping the reference when the event is set to NULL at
complete_signaling() fixes the leak.

The leak can be reproduced by sending a signal to the thread using
DRM_MODE_PAGE_FLIP_EVENT and using a sw_sync fence to cause the atomic
ioctl to block at drm_atomic_helper_wait_for_fences(). It happened both
with amdgpu and vkms.

Fixes: 24835e442f28 ("drm: reference count event->completion")
Cc: stable@vger.kernel.org
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index e997917819e8..7b951af5ab32 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1563,6 +1563,8 @@ static void complete_signaling(struct drm_device *dev,
 		 * to prevent a double free in drm_atomic_commit_clear.
 		 */
 		if (event && (event->base.fence || event->base.file_priv)) {
+			if (crtc_state->commit && crtc_state->commit->abort_completion)
+				drm_crtc_commit_put(crtc_state->commit);
 			drm_event_cancel_free(dev, &event->base);
 			crtc_state->event = NULL;
 		}

---
base-commit: d5efb1e1b1d7cd27c642654042f80d19a7ba3caf
change-id: 20260727-drm_crtc_atomic_commit_leak-4de5e75162b3

Best regards,
--  
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

