Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9443FBB6D
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105139; cv=none; b=g43hbA+KhvbbvYvaDaUQ9hSxhs0RGiQLrMIGbX6SFy6QriMm+++DR5L35IWw1O0zLk6Z2Si2k6wOA1IjXUjvsA/h2LeKvjjqL/1OM//NQj8CDDG0uwz+8rrMp2OXTUVHFoYUyUTjYFFuY8TroefseWXDp0rzzZr2gGPuSErh1T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105139; c=relaxed/simple;
	bh=9oI7yQjEMTDsgtYW1iYwPyg+nF4Ft2duylE+yzLMirs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkycKQ8ejXPf+SNZlRCH+tdsE7pqHN4vyaUzx6Ayno+6AkhE0Y4+ctlx63HIeHDDxjNFx63uo32ePP1W4woEJeIMlFa849FNQEmIYAl4sD/v4IOiJltZFY/SwBAuegwZLfPc8+Y8YVNAml3ZNlrEE3Gz9NTtMUmHsxZM3MlMXdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cYJM53QH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S8dJMu2F; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cYJM53QH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S8dJMu2F; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cYJM53QH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S8dJMu2F";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cYJM53QH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S8dJMu2F"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A34975930;
	Wed, 10 Jun 2026 15:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781105117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjwGX6z3tJCo308Dz+aztE3tds3H/V7JXljLnaLRabA=;
	b=cYJM53QH/Edy+TKbtl5clijlcL4dAU/0iKP+jBI6uBrS1eaBTnbzHgGBzKvIIH4WCXJw2P
	Z4+b4iOmOOQFu32R62IIC2Hmud4gizooaYkN9ane1kraQCHAhqlckWcSHxNPXR0FMGGTo8
	3w2U5BcBmNxun4bCv8/Obt77ZmEhIxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781105117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjwGX6z3tJCo308Dz+aztE3tds3H/V7JXljLnaLRabA=;
	b=S8dJMu2FjHJLuRrC35tutYqL4TkF8gHENf4VBLJlLBqwodDl1kfqeNkClDn1q+gOzQZhvC
	uo0ep3qtbK6xprBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781105117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjwGX6z3tJCo308Dz+aztE3tds3H/V7JXljLnaLRabA=;
	b=cYJM53QH/Edy+TKbtl5clijlcL4dAU/0iKP+jBI6uBrS1eaBTnbzHgGBzKvIIH4WCXJw2P
	Z4+b4iOmOOQFu32R62IIC2Hmud4gizooaYkN9ane1kraQCHAhqlckWcSHxNPXR0FMGGTo8
	3w2U5BcBmNxun4bCv8/Obt77ZmEhIxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781105117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjwGX6z3tJCo308Dz+aztE3tds3H/V7JXljLnaLRabA=;
	b=S8dJMu2FjHJLuRrC35tutYqL4TkF8gHENf4VBLJlLBqwodDl1kfqeNkClDn1q+gOzQZhvC
	uo0ep3qtbK6xprBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62BDE779A7;
	Wed, 10 Jun 2026 15:25:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KAOlFtyBKWr3HwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Jun 2026 15:25:16 +0000
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
	stable@vger.kernel.org
Subject: [PATCH v5 06/15] drm/damage-helper: Clear ignore_damage_clips in plane-state duplication
Date: Wed, 10 Jun 2026 17:18:22 +0200
Message-ID: <20260610152505.260172-7-tzimmermann@suse.de>
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
	NEURAL_HAM_SHORT(-0.19)[-0.935];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,lists.freedesktop.org:email,suse.de:email,suse.de:mid];
	RCPT_COUNT_TWELVE(0.00)[32];
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

Clear ignore_damage_clips when duplicating struct drm_plane_state. The
flag track the state of the damage clips during atomic commits and should
not be kept across plane-state duplications.

Fixes a bug where ignore_damage_clips was not cleared. Once set, the
damage iterator would always ignore damage clips. Only happens in rare
cases in virtgpu and vmwgfx.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.10+
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 07686e94aae0..3e26e208e784 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -409,6 +409,7 @@ void __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
 	state->fence = NULL;
 	state->commit = NULL;
 	state->fb_damage_clips = NULL;
+	state->ignore_damage_clips = false;
 	state->color_mgmt_changed = false;
 }
 EXPORT_SYMBOL(__drm_atomic_helper_plane_duplicate_state);
-- 
2.54.0

