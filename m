Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9752039E175
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772215; cv=none; b=F/uhphQeG0mEbFL5aLoFfBMKoHUpnF07zRH+LAV2y1l2jCMwgmbSPEtIh0AE9AqMFAjSRTEvjHC4edrNAWDnZ/QjH+k22r5v1uCakPy3FNK/ee5+MAUpNumJYYNk3Ztd3lKogaLWJL7pxcMXvLLPGURt6JnDhdP1DUAwZsGAq9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772215; c=relaxed/simple;
	bh=TvHusb0g939oPosC320VvvM65kScmHjEVsYI8sTCMWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAwmACCV2JwL+at9FtJsYY1x+xYK3CsJzmqzZAoIxb82aYahnkkWuZi/qaIGDHBXi2H3QAcb1fZlhznF5ftZE1NAKkDYLOp2z1klqbmEqw8Up2BDEcswN6ei9zVJS4usL94cig+sO7oolA8qcWkP2J8u/R+bWIgUiHRYn3nB80w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D9A5775EE4;
	Thu, 18 Jun 2026 08:43:32 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95726779AB;
	Thu, 18 Jun 2026 08:43:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iGVEI7SvM2pAPwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 18 Jun 2026 08:43:32 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] drm/sysfb: Do not page-align visible size of the framebuffer
Date: Thu, 18 Jun 2026 10:41:57 +0200
Message-ID: <20260618084327.46567-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618084327.46567-1-tzimmermann@suse.de>
References: <20260618084327.46567-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: D9A5775EE4
X-Rspamd-Action: no action

Only return the actually visible size of the system framebuffer in
drm_sysfb_get_visible_size_si(). Drivers use this size value for
reserving access to framebuffer memory. Increasing the value can
make later attempts to do so fail.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 32ae90c66fb6 ("drm/sysfb: Add efidrm for EFI displays")
Fixes: a84eb6abe2b6 ("drm/sysfb: Add vesadrm for VESA displays")
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.16+
---
 drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
index 749290196c6a..361b7233600c 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
@@ -67,7 +67,7 @@ EXPORT_SYMBOL(drm_sysfb_get_stride_si);
 u64 drm_sysfb_get_visible_size_si(struct drm_device *dev, const struct screen_info *si,
 				  unsigned int height, unsigned int stride, u64 size)
 {
-	u64 vsize = PAGE_ALIGN(height * stride);
+	u64 vsize = height * stride;
 
 	return drm_sysfb_get_validated_size0(dev, "visible size", vsize, size);
 }
-- 
2.54.0

