Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E43CF1FE;
	Fri,  3 Jul 2026 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085110; cv=none; b=IXGyaHPsfCRmaZ3gf3ubn3musYoAYwDSmvkjA6vLNulVh13/4bXyJu+noLFVDagCV1NKCyNzfEPQa1oIwX7I+ZPamH9BAXF25Rcj4qTnDgOq8FEJX+eD5oeL9erQOzqQ696+6SqhXS2udoU5OA5YovFs4O4iMx1dX4NuE8ZpSIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085110; c=relaxed/simple;
	bh=ADoLaptI6LLUquolKO3/zjfysh5WgUmpAxBP73Y9qlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pM/G/sqLJ+jLdLf433peB4bAmcZ1Ltus0dpOT8AnU1JBaOkoQqTv/3qz4UJdtwb6yRzVadG+r7d2X6WiWmMbLXU1+aNPOl8Uy/VJfpHiqWBYqJwZS9IfuzPHR9pccUeX4oxiliUXLrqaQ8fKlqyvheHZBP7dE3DpX1Seg+cSt44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=aXn/+Dz5; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="aXn/+Dz5"
Received: from mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:340d:0:640:ad51:0])
	by forward101a.mail.yandex.net (postfix) with ESMTPS id 5AA3980F7F;
	Fri, 03 Jul 2026 16:25:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net (smtp) with ESMTPSA id XOhxaGOeKKo0-Ya7LfL2p;
	Fri, 03 Jul 2026 16:25:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1783085101; bh=5w9HQXUJC9QndoLFGLwX8OwvXmeuBM1nXTtZDoVET94=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=aXn/+Dz5jX9+50//SiAHXYNZiBxo3FYT4GoM3MKQwVf297nFWN5j/sh1LiwuSWb/j
	 oN0JgFssW6HgYgoHa7J5yqGcMe2AeTMjxZvI9353irj+BqOQh/6ao1MZWvWL9DHYSy
	 lmMXbzRz4BnC24PpAxBFqlS5B8VFyb0dsZCVZ7gc=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] drm/radeon/rs780: avoid potential divide-by-zero in refresh rate calculation
Date: Fri,  3 Jul 2026 16:24:12 +0300
Message-ID: <20260703132413.22873-1-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The refresh rate used in rs780 DPM display configuration is derived from
drm_mode_vrefresh(crtc->mode). While connector modes are validated through
drm_mode_validate_driver(), crtc->mode represents runtime display state
and may originate from restore paths or transitional modeset states.

In such cases, drm_mode_vrefresh() may return 0, which is currently used
as a divisor in rs780_program_at(), leading to a potential divide-by-zero
condition.

This issue was found by Linux Verification Center (linuxtesting.org) with SVACE.

Fix this by enforcing a safe fallback refresh rate when the computed value
is zero.

This change ensures robustness of rs780 display power management during
resume and display reconfiguration paths.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 9d67006e6ebc ("drm/radeon: rs780 DPM display configuration handling")
Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
Changes in v2:
- Add Fixes tag referencing related rs780 DPM display configuration commit
- Clarify that issue is related to runtime crtc->mode state rather than
  connector mode validation path
- Reword commit message to align with DRM state model terminology
---
 drivers/gpu/drm/radeon/rs780_dpm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/rs780_dpm.c b/drivers/gpu/drm/radeon/rs780_dpm.c
index 64bb4cafb8b5..ad7161972e37 100644
--- a/drivers/gpu/drm/radeon/rs780_dpm.c
+++ b/drivers/gpu/drm/radeon/rs780_dpm.c
@@ -63,8 +63,11 @@ static void rs780_get_pm_mode_parameters(struct radeon_device *rdev)
 		if (crtc && crtc->enabled) {
 			radeon_crtc = to_radeon_crtc(crtc);
 			pi->crtc_id = radeon_crtc->crtc_id;
-			if (crtc->mode.htotal && crtc->mode.vtotal)
+			if (crtc->mode.htotal && crtc->mode.vtotal) {
 				pi->refresh_rate = drm_mode_vrefresh(&crtc->mode);
+				if (!pi->refresh_rate)
+					pi->refresh_rate = 60;
+			}
 			break;
 		}
 	}
-- 
2.43.0

