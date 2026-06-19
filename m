Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56032857FA
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781877534; cv=none; b=nMcHFCAn9usUPhCHB8IK4shOvt+Ce0e5xWtQBF9qJB9qMEmeIyWVCE8+jx3sKE3/v3q57j9JxH7DLC7zMM5ZxSbpcD4fLm0wvnCeDVYC2K4w8jRgmBF0NajhmGpcsZdzl4K+eHRvo/tcfM2d2j9X7Gm5IwB+XLYNbbAiCe1/M+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781877534; c=relaxed/simple;
	bh=44+OeX8EVKg4uBX+uvGDFfevKVZNh/84Muhlb95wgRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpXV8rJvbiJE5kNEkkjN/X+N/bjE+HlZkOu1VpF73NgnFwVoCgr+Yc1xGIPTYT/GsnokKR8vgEN2auki/Pdn+uiT/dPDo+YyG3mDTov98u8wEmkv5HJ6x2mj/VfwQ54/PxmkXVkWA/OdQZbYqoLKSIEYrnjRU7vFfkVxlo0oE1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LVbmKnVy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i1TNEJiz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LVbmKnVy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i1TNEJiz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LVbmKnVy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i1TNEJiz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LVbmKnVy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i1TNEJiz"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 521CD75C75;
	Fri, 19 Jun 2026 13:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781877531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkdvrlHS3lnYj9qgqGygKFUVpGPS9nGNplKOGnyvVJE=;
	b=LVbmKnVy+H5L4f6ZoZiThOcXym//ySP2v1pWmN65EV5lCwcmX5sNExM5xdVMTGIBmiliRm
	H3rEbt4Not0zEHwHIusmeYHUH7z+pZrtmTK4/Jx0AWkx3TuaO3FdCvE+Z/Cv6qOoNg1y0n
	H88iIMc/Pe34L2Z1488hRgQp+GxBHuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781877531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkdvrlHS3lnYj9qgqGygKFUVpGPS9nGNplKOGnyvVJE=;
	b=i1TNEJiz1AP8HCdE+p+K9t6FrfS+45rB/jxLjpBvdYYZ3P69yZMjMkk15lpkE/47UyU5sU
	FHmJEj0jFOxVTjBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781877531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkdvrlHS3lnYj9qgqGygKFUVpGPS9nGNplKOGnyvVJE=;
	b=LVbmKnVy+H5L4f6ZoZiThOcXym//ySP2v1pWmN65EV5lCwcmX5sNExM5xdVMTGIBmiliRm
	H3rEbt4Not0zEHwHIusmeYHUH7z+pZrtmTK4/Jx0AWkx3TuaO3FdCvE+Z/Cv6qOoNg1y0n
	H88iIMc/Pe34L2Z1488hRgQp+GxBHuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781877531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkdvrlHS3lnYj9qgqGygKFUVpGPS9nGNplKOGnyvVJE=;
	b=i1TNEJiz1AP8HCdE+p+K9t6FrfS+45rB/jxLjpBvdYYZ3P69yZMjMkk15lpkE/47UyU5sU
	FHmJEj0jFOxVTjBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11D7D779AB;
	Fri, 19 Jun 2026 13:58:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eFovAxtLNWpvfwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 19 Jun 2026 13:58:51 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	rayyan@ansari.sh
Cc: dri-devel@lists.freedesktop.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] drm/sysfb: simpledrm: Improve framebuffer-size validation
Date: Fri, 19 Jun 2026 15:56:34 +0200
Message-ID: <20260619135847.309664-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619135847.309664-1-tzimmermann@suse.de>
References: <20260619135847.309664-1-tzimmermann@suse.de>
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ansari.sh];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Score: -2.80

Validate the framebuffer size from the firmware against the
limitations of struct drm_display_mode. The type only stores sizes
in 16-bit fields. Fail probing on errors.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
Cc: <stable@vger.kernel.org> # v5.14+
---
 drivers/gpu/drm/sysfb/simpledrm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index fc168920f2c6..03bd19fadccd 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -88,14 +88,14 @@ static int
 simplefb_get_width_pd(struct drm_device *dev,
 		      const struct simplefb_platform_data *pd)
 {
-	return simplefb_get_validated_int0(dev, "width", pd->width);
+	return drm_sysfb_get_validated_int0(dev, "width", pd->width, U16_MAX);
 }
 
 static int
 simplefb_get_height_pd(struct drm_device *dev,
 		       const struct simplefb_platform_data *pd)
 {
-	return simplefb_get_validated_int0(dev, "height", pd->height);
+	return drm_sysfb_get_validated_int0(dev, "height", pd->height, U16_MAX);
 }
 
 static int
@@ -144,7 +144,7 @@ simplefb_get_width_of(struct drm_device *dev, struct device_node *of_node)
 
 	if (ret)
 		return ret;
-	return simplefb_get_validated_int0(dev, "width", width);
+	return drm_sysfb_get_validated_int0(dev, "width", width, U16_MAX);
 }
 
 static int
@@ -155,7 +155,7 @@ simplefb_get_height_of(struct drm_device *dev, struct device_node *of_node)
 
 	if (ret)
 		return ret;
-	return simplefb_get_validated_int0(dev, "height", height);
+	return drm_sysfb_get_validated_int0(dev, "height", height, U16_MAX);
 }
 
 static int
-- 
2.54.0

