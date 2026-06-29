Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711F93AE6FC;
	Mon, 29 Jun 2026 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724264; cv=none; b=NiOvpPWaL5THQzhj94anvjFCne0zV2p8+9UMISRxfl/xNAuBN/sGp63md/yYzCOsPT915SdAntxhguqsymv0N522fRP4k7QtyFIOztujxmWzISsYPlGB0iu/vvHjmPJBkNjwgeJegPcA7aYOCWZVR5OBvAtyJd+zJnzoYtgwRuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724264; c=relaxed/simple;
	bh=JQWfRBaTHIfEGArwPLkR5YHf5htkDdrB2wFUiDUyO0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p70mCnOUrgGTskJ6Piq1TwjEctb4tQ1uhN3R2UYAw6UbLdPrV0OpNUsUDlgW4+q4e1JYOPMocOMPozOSdF5r8tRWe5FIXQkSn8OR6ymmmXJnrHi0GZnlyuwCBva5/UQvmbDAwlNbbndqxpQb9Z7EHGexzPC6SIE6R8ypha0/rfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ks5im5QQ; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ks5im5QQ"
Received: from mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:bb8b:0:640:6ac7:0])
	by forward103d.mail.yandex.net (postfix) with ESMTPS id D8A06C4701;
	Mon, 29 Jun 2026 12:11:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (smtp) with ESMTPSA id ZAZXGGsiDOs0-e82wDVD8;
	Mon, 29 Jun 2026 12:10:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1782724259; bh=ozXm2Xvy6K1ZkZFvOIsIPVVdHjDSCB8gUTLLJ0/7c0k=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=ks5im5QQyUQzg9JH+aa30cTczRyFk3Ww3tnmluw6+PVrv+1Qf1qBsm6DesF7wkzoP
	 YfRrVxvvohrCvZ/QT+MdaeD6MJ6BgiPGX+ZWVcbiE3fLR4QiT8AVf8w8RI4C4/4MNw
	 Hr8SpgnsjrBNK1TPYsZoZ9hv0P3YFoZR7OOqqDXk=
Authentication-Results: mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	mario.limonciello@amd.com,
	alex.hung@amd.com,
	superm1@kernel.org,
	timur.kristof@gmail.com,
	ivan.lipski@amd.com,
	ray.wu@amd.com,
	aurabindo.pillai@amd.com,
	chen-yu.chen@amd.com,
	mripard@kernel.org,
	Dillon.Varone@amd.com,
	mwen@igalia.com,
	chiahsuan.chung@amd.com,
	kenneth.feng@amd.com,
	srinivasan.shanmugam@amd.com,
	tzimmermann@suse.de,
	Alvin.Lee2@amd.com,
	dmitry.baryshkov@oss.qualcomm.com,
	chaitanya.kumar.borah@intel.com,
	ekurzinger@gmail.com,
	pierre-eric.pelloux-prayer@amd.com,
	HaoPing.Liu@amd.com,
	Tony.Cheng@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	mdaenzer@redhat.com
Subject: [PATCH v4 2/3] drm/amd/display: Fix dangling pointer in CRTC reset function
Date: Mon, 29 Jun 2026 12:04:30 +0300
Message-ID: <20260629090435.9729-4-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629090435.9729-2-evg28bur@yandex.ru>
References: <20260629090435.9729-2-evg28bur@yandex.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amdgpu_dm_crtc_reset_state() frees the old state before allocating
a new one. If kzalloc_obj() fails, the function returns without updating
the state pointer, leaving a dangling pointer to already freed memory.

Fix this by allocating the new state first. On allocation failure, the
old state remains untouched and the function safely returns.

Fixes: 473683a03495 ("drm/amd/display: Create a file dedicated for CRTC")
Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 3dcedaa67ed8..5b5c4023a514 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -437,13 +437,13 @@ static void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc)
 {
 	struct dm_crtc_state *state;
 
-	if (crtc->state)
-		amdgpu_dm_crtc_destroy_state(crtc, crtc->state);
-
 	state = kzalloc_obj(*state);
-	if (WARN_ON(!state))
+	if (!state)
 		return;
 
+	if (crtc->state)
+		amdgpu_dm_crtc_destroy_state(crtc, crtc->state);
+
 	__drm_atomic_helper_crtc_reset(crtc, &state->base);
 }
 
-- 
2.43.0

