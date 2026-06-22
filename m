Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5222C11E4
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782128085; cv=none; b=WghivXPSMjdmXljJgTeMrqnEw9yylYw6mm5tD5UAzwsHTgLi94U6r7YtKboiFIM2S4hxghBvPMcYCfIqzooNtIZxg2b2UwCY5Fyubzyx/DXmGYtB/cizb/Iydlnn46nNlqAnsFa8KSygnsd57BGpJWsxBa0JoTR6ursXFf6WA5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782128085; c=relaxed/simple;
	bh=uFIeNcJrsG5ILCPROyzQY0lcI35uHaJbQM5vZxqIdlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TQx1BPNmx6S5mLZDYqtd2rAFZIUOYhqn9yvs0SDe4spVskhHj387ZP/QCOw5lPVJ6P4UmesmyKRP9GpiBEI8kJq1FKLJNFt2d82+kWmMvlMkf+3R2/63wyb0BGPfJClRu4qNvJhe5zPPUiDeDJdGy2qskDgLAl9ERDj9QwGcFQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bFPd0yJg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z6Z3ewk7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bFPd0yJg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z6Z3ewk7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bFPd0yJg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z6Z3ewk7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bFPd0yJg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z6Z3ewk7"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B8A1A75CDB;
	Mon, 22 Jun 2026 11:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782128082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ApwvU5GMovLK0hG8yQ5DHcqrbeO+YvCNdwhWkQszi7Y=;
	b=bFPd0yJga0LbPmwP00kIBHP4hioB3PqQl9CK21rvQbIph9XT/FKHAC4UTRP2fSTj9/jsM6
	B/5h2d1R3F80dfnviAxRgzZ4/gFTFvLevgylRFwmsukB6SkdMk5wJN4JGCgAtPz2FBlWE6
	Xp7fUBrqkW7x2enJ4SpG8W81aijKZJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782128082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ApwvU5GMovLK0hG8yQ5DHcqrbeO+YvCNdwhWkQszi7Y=;
	b=Z6Z3ewk7JgHd7oTVuyFhtZp3ZbF9Eyrp8NiOnwzkx5Ipp5E7GTMyfTgvrhQBQmm+T9Qw2q
	C6r34Ahd0ff84+Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782128082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ApwvU5GMovLK0hG8yQ5DHcqrbeO+YvCNdwhWkQszi7Y=;
	b=bFPd0yJga0LbPmwP00kIBHP4hioB3PqQl9CK21rvQbIph9XT/FKHAC4UTRP2fSTj9/jsM6
	B/5h2d1R3F80dfnviAxRgzZ4/gFTFvLevgylRFwmsukB6SkdMk5wJN4JGCgAtPz2FBlWE6
	Xp7fUBrqkW7x2enJ4SpG8W81aijKZJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782128082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ApwvU5GMovLK0hG8yQ5DHcqrbeO+YvCNdwhWkQszi7Y=;
	b=Z6Z3ewk7JgHd7oTVuyFhtZp3ZbF9Eyrp8NiOnwzkx5Ipp5E7GTMyfTgvrhQBQmm+T9Qw2q
	C6r34Ahd0ff84+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62B54779A8;
	Mon, 22 Jun 2026 11:34:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d3z5FtIdOWrEMgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 22 Jun 2026 11:34:42 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: hns@goldelico.com,
	zhengxingda@iscas.ac.cn,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	akemnade@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	letux-kernel@openphoenux.org,
	kernel@pyra-handheld.com,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/fb-helper: Only consider active CRTCs for vblank sync
Date: Mon, 22 Jun 2026 13:33:34 +0200
Message-ID: <20260622113434.682292-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[goldelico.com,iscas.ac.cn,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Score: -2.80

Only synchronize fbdev output to the vblank of an active CRTC. Go over
the list of CRTCs and pick the first that matches. Fixes warnings as
the one shown below

[   77.201354] WARNING: drivers/gpu/drm/drm_vblank.c:1320 at drm_crtc_wait_one_vblank+0x194/0x1cc [drm], CPU#1: kworker/1:7/1867
[   77.201354] omapdrm omapdrm.0: [drm] vblank wait timed out on crtc 0

This currently happens if the fbdev output is not on CRTC 0.

Atomic and non-atomic drivers require distinct code paths. As for other
fbdev operations, implement both and select the correct one at runtime.

Not finding an active CRTC is not a bug. Do not wait in this case, but
flush the display update as before.

v2:
- move look-up code into separate helper
- support drivers with legacy modesetting
v1:
- see https://lore.kernel.org/dri-devel/1c9e0e24-9c4a-4259-8700-cf9e5fd60ca3@suse.de/

Co-authored-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: d8c4bddcd8bcb ("drm/fb-helper: Synchronize dirty worker with vblank")
Tested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Closes: https://bugs.debian.org/1138033
Cc: <stable@vger.kernel.org> # v6.19+
---
 drivers/gpu/drm/drm_fb_helper.c | 71 ++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 7b11a582f8ec..cbf0a9a7b8e5 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -225,16 +225,85 @@ static void drm_fb_helper_resume_worker(struct work_struct *work)
 	console_unlock();
 }
 
+static int find_crtc_index_atomic(struct drm_fb_helper *helper)
+{
+	struct drm_device *dev = helper->dev;
+	struct drm_plane *plane;
+
+	drm_for_each_plane(plane, dev) {
+		const struct drm_plane_state *plane_state;
+		const struct drm_crtc *crtc;
+
+		if (plane->type != DRM_PLANE_TYPE_PRIMARY)
+			continue;
+
+		plane_state = plane->state;
+		if (plane_state->fb != helper->fb || !plane_state->crtc)
+			continue; /* plane doesn't display fbdev emulation */
+
+		crtc = plane_state->crtc;
+		if (!crtc->state->active)
+			continue;
+		if (drm_WARN_ON_ONCE(dev, crtc->index > INT_MAX))
+			continue; /* driver bug */
+
+		return crtc->index;
+	}
+
+	return -EINVAL;
+}
+
+static int find_crtc_index_legacy(struct drm_fb_helper *helper)
+{
+	struct drm_device *dev = helper->dev;
+	struct drm_crtc *crtc;
+
+	drm_for_each_crtc(crtc, dev) {
+		struct drm_plane *plane = crtc->primary;
+
+		if (!crtc->enabled)
+			continue;
+		if (!plane || plane->fb != helper->fb)
+			continue; /* CRTC doesn't display fbdev emulation */
+		if (drm_WARN_ON_ONCE(dev, crtc->index > INT_MAX))
+			continue; /* driver bug */
+
+		return crtc->index;
+	}
+
+	return -EINVAL;
+}
+
+static int drm_fb_helper_find_crtc_index(struct drm_fb_helper *helper)
+{
+	struct drm_device *dev = helper->dev;
+	int crtc_index;
+
+	mutex_lock(&dev->mode_config.mutex);
+
+	if (drm_drv_uses_atomic_modeset(dev))
+		crtc_index = find_crtc_index_atomic(helper);
+	else
+		crtc_index = find_crtc_index_legacy(helper);
+
+	mutex_unlock(&dev->mode_config.mutex);
+
+	return crtc_index;
+}
+
 static void drm_fb_helper_fb_dirty(struct drm_fb_helper *helper)
 {
 	struct drm_device *dev = helper->dev;
 	struct drm_clip_rect *clip = &helper->damage_clip;
 	struct drm_clip_rect clip_copy;
+	int crtc_index;
 	unsigned long flags;
 	int ret;
 
 	mutex_lock(&helper->lock);
-	drm_client_modeset_wait_for_vblank(&helper->client, 0);
+	crtc_index = drm_fb_helper_find_crtc_index(helper);
+	if (crtc_index >= 0)
+		drm_client_modeset_wait_for_vblank(&helper->client, crtc_index);
 	mutex_unlock(&helper->lock);
 
 	if (drm_WARN_ON_ONCE(dev, !helper->funcs->fb_dirty))
-- 
2.54.0

