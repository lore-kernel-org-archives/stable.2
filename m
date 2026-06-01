Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFBF3546D9
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780314486; cv=none; b=q/8WM9HYpJxyrGWU7HTN/BdvNbi3k9MmlY+8d9deBMwMcJumsDuOtr2Lky/YKNhaFfDIWNPdUwboJN4OOrUoq7r+MOBHSx7sFkniy0GDzqIDAd0PYTCPxK2CGwfGdmd8icagVJKptcpHTjJtQgLkNAh0UTK4cldTcWeyxuI47LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780314486; c=relaxed/simple;
	bh=otMyTGzPNefDNXsxc+KHyPw2W2HBmgKvh7/2nzNpf1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzNsRT6UqvGcvMMZWXB4lI63QNGrQez9qkuBsA3vVzdwN1M/jElZyjkOc9FWMGB3pvgmpvIXIks6y+Eg9d1XrmI7Um5xu2LcoXF0pOIIV+9u+l7XMaKmPldDVA5g6A8Y1v8DL6d2U8ihMEzV/pLWVtFMZNQi02NOhA+ZxA8j/X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=asC3wH4F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fbO5WhBh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=asC3wH4F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fbO5WhBh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="asC3wH4F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fbO5WhBh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="asC3wH4F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fbO5WhBh"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3C51A66D6F;
	Mon,  1 Jun 2026 11:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780314482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puXDryzmvm+hScsn8xQG8yH6VqIBFkvdIaDgwIfkaOA=;
	b=asC3wH4FNbsNw/G2PRK+sErZd2vb72F1f4zx1LqzfOWAyLh0bVPoclMP/ZpDqJK47qO10O
	p27VEhidDb/qVU58+Sav1pRaLGrU+suMTO3k5L8jmPTw0tqCFz/kkmkFlWpQGa14EGMHxU
	1gfdPD7ryUzOTFeO8xthF12I0bT83m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780314482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puXDryzmvm+hScsn8xQG8yH6VqIBFkvdIaDgwIfkaOA=;
	b=fbO5WhBhxDSj6X76VfZA+toFfkKWbkaFyE/KDGOeumC9Y2CYjexphOs+ah7IFMHHyM8oXx
	jty58i7GjVRbTDDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780314482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puXDryzmvm+hScsn8xQG8yH6VqIBFkvdIaDgwIfkaOA=;
	b=asC3wH4FNbsNw/G2PRK+sErZd2vb72F1f4zx1LqzfOWAyLh0bVPoclMP/ZpDqJK47qO10O
	p27VEhidDb/qVU58+Sav1pRaLGrU+suMTO3k5L8jmPTw0tqCFz/kkmkFlWpQGa14EGMHxU
	1gfdPD7ryUzOTFeO8xthF12I0bT83m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780314482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puXDryzmvm+hScsn8xQG8yH6VqIBFkvdIaDgwIfkaOA=;
	b=fbO5WhBhxDSj6X76VfZA+toFfkKWbkaFyE/KDGOeumC9Y2CYjexphOs+ah7IFMHHyM8oXx
	jty58i7GjVRbTDDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5505779A9;
	Mon,  1 Jun 2026 11:48:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WNkCK3FxHWq0XAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 01 Jun 2026 11:48:01 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: shiyongbang@huawei.com,
	xinliang.liu@linaro.org,
	tiantao6@hisilicon.com,
	kong.kongxinwei@hisilicon.com,
	sumit.semwal@linaro.org,
	yongqin.liu@linaro.org,
	jstultz@google.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rongrong Zou <zourongrong@gmail.com>,
	Sean Paul <seanpaul@chromium.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Baihan Li <libaihan@huawei.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/4] drm/hibmc: Fix list of formats on the primary plane
Date: Mon,  1 Jun 2026 13:45:16 +0200
Message-ID: <20260601114756.51953-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601114756.51953-1-tzimmermann@suse.de>
References: <20260601114756.51953-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.986];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RLwm3j518m16mxt9fsoq4gfmy8)];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.de:email,suse.de:mid,chromium.org:email,linaro.org:email,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_TO(0.00)[huawei.com,linaro.org,hisilicon.com,google.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,suse.de,gmail.com,chromium.org,kernel.org,huawei.com,vger.kernel.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

Remove all formats from the primary plane that are unsupported for
various reasons.

* Formats with alpha channel: planes should not announce alpha channels
unless they support transparency. There's no transparency support in
the primary plane's implementation.

* Formats with BGR order. The common format is in RGB channel order.
There's no BGR support in the primary plane's implementation.

* RGB888: atomic_update programs the format from cpp[0] * 8 / 16. For
RGB888's cpp value of 3 this returns 1.5; rounded to 1. Programming
the value of 1 to HIBMC_CRT_DISP_CTL_FORMAT sets up RGB565. Hence, the
output is distorted. This can be tested by booting with video=1024x768-24.

Removing all unsupported formats leaves XRGB8888 and RGB565. Both of
which are supported and work correctly.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: da52605eea8f ("drm/hisilicon/hibmc: Add support for display engine")
Reviewed-by: Yongbang Shi <shiyongbang@huawei.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Xinliang Liu <xinliang.liu@linaro.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Cc: Yongbang Shi <shiyongbang@huawei.com>
Cc: Baihan Li <libaihan@huawei.com>
Cc: <stable@vger.kernel.org> # v4.10+
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index 7c0b88c774b5..2e6e189bec1a 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -135,10 +135,8 @@ static void hibmc_plane_atomic_update(struct drm_plane *plane,
 }
 
 static const u32 channel_formats1[] = {
-	DRM_FORMAT_RGB565, DRM_FORMAT_BGR565, DRM_FORMAT_RGB888,
-	DRM_FORMAT_BGR888, DRM_FORMAT_XRGB8888, DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_RGBA8888, DRM_FORMAT_BGRA8888, DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_ABGR8888
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_RGB565,
 };
 
 static const struct drm_plane_funcs hibmc_plane_funcs = {
-- 
2.54.0

