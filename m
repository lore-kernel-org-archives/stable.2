Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4130F3E4504
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781785917; cv=none; b=Msdopr2YrlSN6nOVdQV8YomjYJBOdJ+IDgHPPIkek3qi9JTirJUhNMp9gWrpy+jtU0maftNh6gD9gOrtzyOoNds4+aHKiWPvghES/7NgmAoYhg9GJOziFyqDoTMzyWjAzDUHe9hy97ektqa3lBJqydoa15APggSXG59fp69VYas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781785917; c=relaxed/simple;
	bh=otMyTGzPNefDNXsxc+KHyPw2W2HBmgKvh7/2nzNpf1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWBQkR0jcClrlkKzK4Vmx3KkfiMXmQBTA+W+pbpWIAoAd30RsbhAabAoAHgPRpxzEjqi8+8FNeWk3+saUM1CLYH1niCd19vQlgB7XICIuQZYpwGlys3oZPGqf6C4rJUEXi4wkgbX/Ubqwl2uZOoh7e6/gZxmqOGuwsx4iWV+gjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GJDazzry; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1wjnnoyn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GJDazzry; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1wjnnoyn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GJDazzry";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1wjnnoyn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GJDazzry";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1wjnnoyn"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B9D5375E26;
	Thu, 18 Jun 2026 12:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781785908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puXDryzmvm+hScsn8xQG8yH6VqIBFkvdIaDgwIfkaOA=;
	b=GJDazzryCET/HO4aVNxQ0YI/ZL6wfOBWbWza6dgF3R441mCAFEAyXktczW75IQA7vuJMyo
	AMAH0xnR+YmyZU+JtuAFwB3I6azyHJwwOCR1YtdmKR7c+2MZnuyBwu0h0UZSVTcFn3FWgd
	47wmj2D+8GiCWBX7QfaU2Djba6BDSG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781785908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puXDryzmvm+hScsn8xQG8yH6VqIBFkvdIaDgwIfkaOA=;
	b=1wjnnoynqvSUUcSWMKD8pdTKlGwNXMgvtIdeq7IhjrHnyDqGcT+VPzW4p921ioWTBhKfKx
	QDTWmO6Yy/tZuMCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781785908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puXDryzmvm+hScsn8xQG8yH6VqIBFkvdIaDgwIfkaOA=;
	b=GJDazzryCET/HO4aVNxQ0YI/ZL6wfOBWbWza6dgF3R441mCAFEAyXktczW75IQA7vuJMyo
	AMAH0xnR+YmyZU+JtuAFwB3I6azyHJwwOCR1YtdmKR7c+2MZnuyBwu0h0UZSVTcFn3FWgd
	47wmj2D+8GiCWBX7QfaU2Djba6BDSG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781785908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puXDryzmvm+hScsn8xQG8yH6VqIBFkvdIaDgwIfkaOA=;
	b=1wjnnoynqvSUUcSWMKD8pdTKlGwNXMgvtIdeq7IhjrHnyDqGcT+VPzW4p921ioWTBhKfKx
	QDTWmO6Yy/tZuMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B755779A8;
	Thu, 18 Jun 2026 12:31:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8GUmFTTlM2rTJQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 18 Jun 2026 12:31:48 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: shiyongbang@huawei.com,
	tiantao6@hisilicon.com,
	kong.kongxinwei@hisilicon.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rongrong Zou <zourongrong@gmail.com>,
	Sean Paul <seanpaul@chromium.org>,
	Xinliang Liu <xinliang.liu@linaro.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Baihan Li <libaihan@huawei.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/6] drm/hibmc: Fix list of formats on the primary plane
Date: Thu, 18 Jun 2026 14:28:40 +0200
Message-ID: <20260618123142.92298-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618123142.92298-1-tzimmermann@suse.de>
References: <20260618123142.92298-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,linaro.org:email];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,lists.linux.dev,suse.de,gmail.com,chromium.org,linaro.org,kernel.org,huawei.com,vger.kernel.org];
	FREEMAIL_TO(0.00)[huawei.com,hisilicon.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Score: -6.80

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

