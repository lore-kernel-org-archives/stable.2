Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890794;
	b=EXRCPDWq4R7zjT07A3g/QFg1qjNRG9NH9rQG+GP52ZZrNLBePUygRR7qFRq2SzTkVPa3
	 Tt4I2GUgHhTZ+/3y9xJQo+8fvRHSdwGtHnsKZ3KaTMI3Y9VtbKRhW0nKm4HqT5E60zlvr
	 JH81ROE6Sx3Azqzyz+QNco9mZqROHwskl5BQUuj+fk2UOBsShmfasAiA0L6GTbv+Yt/Ik
	 XUDhIYK+imozrhpL9wImlQWoCEjaUXEby4nDAgE/DA9vsrcCUCMGCsz8hgKOLJaJLadQE
	 M76+tPfc2ShjosQBWkQdxS5NINq5Aap+rD7zqgq40u/U01ig39ELSLum1TgcjF6fqhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890794;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Pre-Result:X-Rspamd-Queue-Id:
	 X-Rspamd-Pre-Result:X-Rspamd-Action:X-Rspamd-Server:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Flag:X-Spam-Score;
	bh=6cUVptpHv3XOVaNUbbyHyVf6R5LgqLqMQhFeVA4GL+o=;
	b=1dJifh6zkruOh3cwCyNy+hHp2JPb6CYYpssb0v/oXL1IHWXTNIRDlX/8dPQT9LNb4t7s
	 lz6BoXERWuLTfeDBJicLt4om4i73ne/gD0Y5cTdlC7HAKa6WGwI4Dol7kzCCNO5SqinWU
	 fJmP1J+LLRSAn5UmUyOnZ88zfSOsztrzK/IDT7N8HHZ2B8snmnlqJBb2hIg99Cnz+AduR
	 ZB2GYradcA2+XI7Qq+9uBJA08dts1rrTacmI/3AFO1hPLrXUrO/dEo3vyhbSaSYgxciho
	 2mIAY9pvrJA7WXu4q+1iuknsQrP5nm1vYRLYsvnOXNze8Z1yZH42sZlNYKmZepNraCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEAE606A338
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CEAE606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8F30721EB5;
	Thu,  5 Nov 2026 14:59:52 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2347C134F6;
	Thu,  5 Nov 2026 14:59:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x+n9G+eZ7GrlSAAAD6G6ig:T2
	(envelope-from <tzimmermann@suse.de>); Thu, 05 Nov 2026 14:59:52 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	ville.syrjala@linux.intel.com,
	javierm@redhat.com,
	zack.rusin@broadcom.com,
	louis.chauvet@bootlin.com
Cc: dri-devel@lists.freedesktop.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/vblank: timer: Do not block within critical section
Date: Thu,  5 Nov 2026 15:41:32 +0100
Message-ID: <20261105145946.896674-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105145946.896674-1-tzimmermann@suse.de>
References: <20261105145946.896674-1-tzimmermann@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 8F30721EB5
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

Remove try-to-cancel loop from drm_crtc_vblank_start_timer() to avoid
a possible livelock while spinning within the loop. Hold interval_lock
when starting and forwarding the vblank timer's hrtimer to avoid
forwarding an already queued timer.

The vblank helper drm_vblank_disable_and_save() and the vblank IRQ
handler hold the spin lock vblank_time_lock at some point. This can
result in a deadlock if the vblank timer's disable code in
drm_crtc_vblank_cancel_timer() calls hrtimer_cancel() directly: the
helper waits for the timer function to complete and the timer function
waits for the helper to release vblank_time_lock.

drm_crtc_vblank_cancel_timer() works around this problem by calling
hrtimer_try_to_cancel() instead. For re-enabling the vblank timer,
drm_crtc_vblank_start_timer() currently waits for the vblank timer
to stop. It runs into the same locking problem while waiting for the
timer function to complete.

Resolve the locking problem by removing hrtimer_try_to_cancel() from
drm_crtc_vblank_start_timer(). Hold interval_lock while starting or
forwarding the hrtimer. Without holding interval_lock,
drm_crtc_vblank_start_timer() could set an interval and start the
hrtimer; while a concurrent timer function forwards the timer with the
old interval. This can corrupt the ordering of the hrtimer's internal
queue. Holding the lock prevents this from happening.

When starting the vblank timer, it is still possible that an already
running timer sends out a vblank event at the previous vblank interval.
This is merely an inconsistency and not critical.

Closes: https://lore.kernel.org/dri-devel/20260914111129.300691F00898@smtp.kernel.org/
Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
Cc: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.19+
---
 drivers/gpu/drm/drm_vblank.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f90fb2d13e42..8cc8d018d353 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -2179,19 +2179,18 @@ static enum hrtimer_restart drm_vblank_timer_function(struct hrtimer *timer)
 	struct drm_crtc *crtc = vtimer->crtc;
 	const struct drm_crtc_helper_funcs *crtc_funcs = crtc->helper_private;
 	struct drm_device *dev = crtc->dev;
-	unsigned long flags;
-	ktime_t interval;
-	u64 ret_overrun;
+	u64 ret_overrun = 1;
 	bool succ;
 
-	spin_lock_irqsave(&vtimer->interval_lock, flags);
-	interval = vtimer->interval;
-	spin_unlock_irqrestore(&vtimer->interval_lock, flags);
+	scoped_guard(spinlock_irqsave, &vtimer->interval_lock) {
+		ktime_t interval = vtimer->interval;
 
-	if (!interval)
-		return HRTIMER_NORESTART;
+		if (!interval || hrtimer_is_queued(timer))
+			return HRTIMER_NORESTART;
+
+		ret_overrun = hrtimer_forward_now(timer, interval);
+	}
 
-	ret_overrun = hrtimer_forward_now(&vtimer->timer, interval);
 	if (ret_overrun != 1)
 		drm_dbg_vbl(dev, "vblank timer overrun\n");
 
@@ -2220,7 +2219,6 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
 {
 	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
 	struct drm_vblank_crtc_timer *vtimer = &vblank->vblank_timer;
-	unsigned long flags;
 
 	if (!vtimer->crtc) {
 		/*
@@ -2230,22 +2228,14 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
 		spin_lock_init(&vtimer->interval_lock);
 		hrtimer_setup(&vtimer->timer, drm_vblank_timer_function,
 			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	} else {
-		/*
-		 * Timer should not be active. If it is, wait for the
-		 * previous cancel operations to finish.
-		 */
-		while (hrtimer_active(&vtimer->timer))
-			hrtimer_try_to_cancel(&vtimer->timer);
 	}
 
 	drm_calc_timestamping_constants(crtc, &crtc->mode);
 
-	spin_lock_irqsave(&vtimer->interval_lock, flags);
-	vtimer->interval = ns_to_ktime(vblank->framedur_ns);
-	spin_unlock_irqrestore(&vtimer->interval_lock, flags);
-
-	hrtimer_start(&vtimer->timer, vtimer->interval, HRTIMER_MODE_REL);
+	scoped_guard(spinlock_irqsave, &vtimer->interval_lock) {
+		vtimer->interval = ns_to_ktime(vblank->framedur_ns);
+		hrtimer_start(&vtimer->timer, vtimer->interval, HRTIMER_MODE_REL);
+	}
 
 	return 0;
 }
-- 
2.56.0

