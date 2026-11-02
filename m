Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630368;
	b=eLTOfjNcv5WA2/cWYn8Z5VDt5Mc3UIYZCiOQjmKA92eig8kpHZhGuslNR59SeiqcbaAf
	 vik3C+HJaGDvYnsj49+BSaHn9tpdp3zY3AMkIM2cehCs9TvW/ctWQMkNfWqz8NMMkzrJ7
	 spqfMmI7dA6n4Ku2/Nj67TU44lWtZSKIeQMlgg5O/Ulkay0V2Q/kBlmM5SAyyF+c21RhC
	 bHIqaATLgUSjLaqlcs6RSFAzvDvpahCxXdgwEI1+z8PCZ32xXntG+snQG7B7Ym1FFCkxn
	 nEZKgqiXGVbrdXnNoy11ToZTWIv1XNWKvUnF4LQv8fn0AcFEXEg7aezNLiFAhDiZixQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630368;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Spamd-Result:
	 X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=Kk/m6s2n0EULcCDaOH1q1j9/CXF2sCn36I0TyIZGQiU=;
	b=sHglbYR3B+iXoE/F3FnVx4hFldNObeA4RdPP8stQevBOWQusEcNJ5q2cSSOvICSzVUJu
	 rMesr3+LBVW7fIHXtFrDX8fOVgiZS6PTM/dksXmY2W0DEwhRPxt3Vfz8Gbb4W9HyXDkCE
	 XaszC+m19JfjLnICjo9kI5wgPkniq+ikG4q0WbRgkAb0clD0RFuYPJe7Lwo9OGlYgN6jM
	 b1hHhlzswATNt0UzLQ99iOqSkGbmzdFLHX036jOMN3kcr9FQRNwBjk2wks5Lau9lAZbeu
	 2db/if6xj8qGokvm0t7KUaVmlLCo1TtvDjdREvd+M51vXfj4Pw0l9Kb6kC8OD8jsWLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=k1c6KJf0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XBBdu16R;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pgvPrly2;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NQPMzwH5;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2024C606E011
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 14:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2024C606E011
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=k1c6KJf0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XBBdu16R;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pgvPrly2;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NQPMzwH5
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 120911F38F;
	Mon,  2 Nov 2026 14:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793630365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Kk/m6s2n0EULcCDaOH1q1j9/CXF2sCn36I0TyIZGQiU=;
	b=k1c6KJf06lLMjANzjsRckqX3a1g93Ie8HyY088UzjjrtT4894T8Lk3meHRPN+FpQrdrDdf
	lHPCUiaq2W2evnfa8OgWPELmf77dNLmbjTDf5L0ozbHgxcsMcRRvWe6iQpuEeHx0CH/cq4
	NaG0GlaV6LnS+poZFVqHEN4RP/JiyJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793630365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Kk/m6s2n0EULcCDaOH1q1j9/CXF2sCn36I0TyIZGQiU=;
	b=XBBdu16Rfz4pJ5smXefKsiA7G/hsn5pKRl1tSZCquvKXxLd0i0d5jUM0kWPL6ymA2y27U3
	E1yZMn9WVRPw3NBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793630364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Kk/m6s2n0EULcCDaOH1q1j9/CXF2sCn36I0TyIZGQiU=;
	b=pgvPrly2W0ITJAIbfpbT7pL9CjFjivBu67eQWBZZ7WwBvnhbx40lkTkz0gBVdJ5XzMx0sO
	Vpvnzfn2+ciqv9gEFImpAO338i1zmU8dmH6ZRIn2fxELyLsXtIXHLyGTThUbBF5XHk4/fE
	Aio3PoRwT4qj9X01AwJI7+4zMUuE9fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793630364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Kk/m6s2n0EULcCDaOH1q1j9/CXF2sCn36I0TyIZGQiU=;
	b=NQPMzwH5uWaH5aybTWsxDTZhTH37+xqSEDAYHigOcqwknOaaw3WqVtBe7TwJSSPAYXCWCZ
	GL66YlJGXwHv0jAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97D78134B8;
	Mon,  2 Nov 2026 14:39:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +68lGJug6GrWRAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 02 Nov 2026 14:39:23 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	ville.syrjala@linux.intel.com,
	javierm@redhat.com,
	louis.chauvet@bootlin.com
Cc: dri-devel@lists.freedesktop.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH] drm/vblank: Restart enabling vblank timer on possible deadlock
Date: Mon,  2 Nov 2026 15:38:52 +0100
Message-ID: <20261102143919.1672293-1-tzimmermann@suse.de>
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,redhat.com,bootlin.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ffwll.ch:email,intel.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,bootlin.com:email,lists.freedesktop.org:email];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -11.80
X-Spam-Level: 
X-Spam-Flag: NO

Return -EDEADLK when trying to cancel a running hrtimer as part of
enable_vblank(). Reacquire vblank_time_lock and try again.

The vblank helper drm_vblank_disable_and_save() and the vblank IRQ
handler hold the spin lock vblank_time_lock at some point. This
can result in a deadlock if vblank timer's disable code in
drm_crtc_vblank_cancel_timer() calls hrtimer_cancel() directly: the
helper wais for the timer function to complete and the timer function
waits for the helper to release vblank.time_lock.

drm_crtc_vblank_cancel_timer() works around this problem by calling
hrtimer_try_to_cancel() instead. For re-enabling the vblank timer,
drm_crtc_vblank_start_timer() must wait for the vblank timer to stop.
It runs into the same deadlock problem while waiting for the timer
function to complete.

The solution to this problem is to release and reacquire the spin
lock vblank_time_lock if hrtimer_try_to_cancel() signals a running
timer function. Releasing the lock allows for the timer function to
make progress.

Signal the possible deadlock with -EDEADLK and perform the necessary
steps. No other driver uses -EDEADLK in their enable_vblank, so the
change should not interfere.

Tested with bochs on qemu.

Closes: https://lore.kernel.org/dri-devel/20260914111129.300691F00898@smtp.kernel.org/
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.19+
---
I also tried to move hrtimer_cancel() out of the critical section. The
result was fairly fragile. So returning an error and re-acquiring the
lock was the easier solution.
---
 drivers/gpu/drm/drm_vblank.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 5162250e8813..135efde86298 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1182,10 +1182,12 @@ static int __enable_vblank(struct drm_device *dev, unsigned int pipe)
 static int drm_vblank_enable(struct drm_device *dev, unsigned int pipe)
 {
 	struct drm_vblank_crtc *vblank = drm_vblank_crtc(dev, pipe);
-	int ret = 0;
+	int ret;
 
 	assert_spin_locked(&dev->vbl_lock);
 
+retry:
+	ret = 0;
 	spin_lock(&dev->vblank_time_lock);
 
 	if (!vblank->enabled) {
@@ -1199,7 +1201,11 @@ static int drm_vblank_enable(struct drm_device *dev, unsigned int pipe)
 		ret = __enable_vblank(dev, pipe);
 		drm_dbg_core(dev, "enabling vblank on crtc %u, ret: %d\n",
 			     pipe, ret);
-		if (ret) {
+		if (ret == -EDEADLK) {
+			spin_unlock(&dev->vblank_time_lock);
+			cpu_relax();
+			goto retry;
+		} else if (ret) {
 			atomic_dec(&vblank->refcount);
 		} else {
 			drm_update_vblank_count(dev, pipe, 0);
@@ -2232,11 +2238,14 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
 			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	} else {
 		/*
-		 * Timer should not be active. If it is, wait for the
-		 * previous cancel operations to finish.
+		 * Timer should not be running. If it is, signal cancellation
+		 * again and restart to release locks.
 		 */
-		while (hrtimer_active(&vtimer->timer))
-			hrtimer_try_to_cancel(&vtimer->timer);
+		if (hrtimer_try_to_cancel(&vtimer->timer) == -1) {
+			scoped_guard(spinlock_irqsave, &vtimer->interval_lock)
+				vtimer->interval = 0;
+			return -EDEADLK;
+		}
 	}
 
 	drm_calc_timestamping_constants(crtc, &crtc->mode);
-- 
2.56.0

