Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE1F423A88
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105122; cv=none; b=gRA6HBISi+mMbztBV6+FTFMgcVif9ZFWCj1GkcXrTFzed5x5yXkcQWHg3hvG/eBhwCrFf8iOwrbX+gd6DDZQAKXDMq2gQJXLsIfx7iaCgHeqOQW28I06+HvjjltjCEyTgOtu01rMZmpX1rETep1TyEn0PMqez71Y0RvNSoxTHHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105122; c=relaxed/simple;
	bh=rGLYgtPbunLRB6JNiWAfpWdSdNQsaGQMN8ZT2VWOkY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCpIv64tliDCKujx6FO/0nB4MxbfEvuiuk9gjIdpYk42LFGkBE25yCem600JSjzw05fvbbkDR9Z7Y1j7YJglFg4O1ql7ASgJ2ckv4FQAVOSQf2nCKSAiTNKFYI7AYe5tJHTPbY4k1xbLMKRzoISp4M4vVT4OaZ/4QtAqQBJhKIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bdQ2QY0k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7bC5Qcyb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bdQ2QY0k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7bC5Qcyb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bdQ2QY0k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7bC5Qcyb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bdQ2QY0k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7bC5Qcyb"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 933AC759E1;
	Wed, 10 Jun 2026 15:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781105114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZGezr5Co9B8J8+jzYz0W4GyFfVCvOXtoGeqWqMngcE=;
	b=bdQ2QY0kGkfYcjt6g/RTcosNn/eXJRfLrnc7KqvWRKnAaR7KaTI75WSTY50R0dJvYAil7P
	AcwZnEDz3SKP8jKUAIdBYLrXAkWrRaCueol4A31wFLnQyu6n5MkEbBjSIgHFK6Pjd/7gcc
	eLnhaeH8AO7nJY5uk5fqUwbcdK6717k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781105114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZGezr5Co9B8J8+jzYz0W4GyFfVCvOXtoGeqWqMngcE=;
	b=7bC5Qcyba+ePGGRfuZage5g6XVg85qIUv16ywkzCV/eELO9ePMd/5v8JU7JKXguBT/fm0h
	xMK0PYgUQsM6wTAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781105114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZGezr5Co9B8J8+jzYz0W4GyFfVCvOXtoGeqWqMngcE=;
	b=bdQ2QY0kGkfYcjt6g/RTcosNn/eXJRfLrnc7KqvWRKnAaR7KaTI75WSTY50R0dJvYAil7P
	AcwZnEDz3SKP8jKUAIdBYLrXAkWrRaCueol4A31wFLnQyu6n5MkEbBjSIgHFK6Pjd/7gcc
	eLnhaeH8AO7nJY5uk5fqUwbcdK6717k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781105114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZGezr5Co9B8J8+jzYz0W4GyFfVCvOXtoGeqWqMngcE=;
	b=7bC5Qcyba+ePGGRfuZage5g6XVg85qIUv16ywkzCV/eELO9ePMd/5v8JU7JKXguBT/fm0h
	xMK0PYgUQsM6wTAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5931779A9;
	Wed, 10 Jun 2026 15:25:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QPDqKtmBKWr3HwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Jun 2026 15:25:13 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	airlied@redhat.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	admin@kodeit.net,
	gargaditya08@proton.me,
	paul@crapouillou.net,
	jani.nikula@linux.intel.com,
	mhklkml@zohomail.com,
	zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	javierm@redhat.com,
	dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-mips@vger.kernel.org,
	virtualization@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Zack Rusin <zackr@vmware.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 03/15] drm/vboxvideo: Handle struct drm_plane_state.ignore_damage_clips
Date: Wed, 10 Jun 2026 17:18:19 +0200
Message-ID: <20260610152505.260172-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610152505.260172-1-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.79
X-Spamd-Result: default: False [-6.79 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.936];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,lists.freedesktop.org:email];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,zohomail.com,broadcom.com,amd.com,igalia.com,intel.com,ursulin.net,collabora.com,chromium.org];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLq3cifbxyhc6qbbynzfc6amns)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 

The mode-setting pipeline can disabled damage clippings for a commit
by setting ignore_damage_clips in struct drm_plane_state. The commit
will then do a full display update.

Test the flag in the primary plane's atomic_update and do a full update
if it has been set.

Commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers
to ignore damage clips") introduced ignore_damage_clips to selectively
ignore damage clipping in certain framebuffer changes. Vboxvideo does not
do that, but DRM's damage iterator will soon rely on the flag. Therefore
supporting it here as well make sense for consistency.

While at it, also replace uint32_t with the preferred u32.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Zack Rusin <zackr@vmware.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/vboxvideo/vbox_mode.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/vboxvideo/vbox_mode.c
index 8e4e5fc9d3c5..635777f1ca23 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_mode.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_mode.c
@@ -283,8 +283,9 @@ static void vbox_primary_atomic_update(struct drm_plane *plane,
 	struct drm_crtc *crtc = new_state->crtc;
 	struct drm_framebuffer *fb = new_state->fb;
 	struct vbox_private *vbox = to_vbox_dev(fb->dev);
-	struct drm_mode_rect *clips;
-	uint32_t num_clips, i;
+	struct drm_mode_rect *clips = NULL;
+	u32 num_clips = 0;
+	u32 i;
 
 	vbox_crtc_set_base_and_mode(crtc, fb,
 				    new_state->src_x >> 16,
@@ -292,8 +293,10 @@ static void vbox_primary_atomic_update(struct drm_plane *plane,
 
 	/* Send information about dirty rectangles to VBVA. */
 
-	clips = drm_plane_get_damage_clips(new_state);
-	num_clips = drm_plane_get_damage_clips_count(new_state);
+	if (!new_state->ignore_damage_clips) {
+		clips = drm_plane_get_damage_clips(new_state);
+		num_clips = drm_plane_get_damage_clips_count(new_state);
+	}
 
 	if (!num_clips)
 		return;
-- 
2.54.0

