Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190307;
	b=oA9ipmMHR0Fj4knVZW85WepDFhEJBufAWNaNcv2pVDoRCN5CHuIHlqcPQYZ3XXW+VDxv
	 Qyv/Wn7xfBZVOSyq5OPGzTesFlaCGE2ZRzBIJk9iiqW4kmBiYU9daRslaFYk7J3rGAfA7
	 Bjdfn6oyCU9ZOEuLmvyyadscGbrCPuM3ToIKF33zM3I2WYXmerJ7DWRPP2XqiCpWGFfg7
	 MSP6C+eneRTAca+Og6WwVz+2nnl0mP5cvXiykBgqFoHEBMLJk4QYO0LXl2vSqLy+zm8Dh
	 63h9AsKjsekQGgbn2T569Ut+cSHK5kjWTdwpW0KODVJegTROPJSZMyjIy2EpCxfoPZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190307;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spamd-Result:X-Spam-Score;
	bh=0hnuUq5U6ulpxWIKDfylKBbb7qMsyHDP/g8UrtzG0cc=;
	b=uHTNk7PONNEDmSG8KhdtOPnW2l+QBsD5DdLAL4tNIZ2gkgudm3JQr7ZGl8MJCEU8+bg5
	 HaVmJxA+2bZ6Nyj1JjxXg0Bt0O2EBwD1525Dpt/G7mRhfPBW/CwDftsh3I8ArKsFLr/kB
	 a7CXEh4MmRhZUg2dZmIVr22BvWflEPnxo4gu+8molQm0naBcOhfqjgrY6a+5/xefiJ8TI
	 xTlUpU9pHvN1mIcveXys9PTJiEB/2JDKqZK5ZoZh30CmPxkQSj5AHeF2tceMkIp3BZykJ
	 pxiVxhL+I1St3boU48spxXIDjeaBsa7GpBLa/frOwVhbAYnQgWtVEz/l66LtPAcBEBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LVloF5Ph;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hdfXVYss;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FMm+sDTb;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3ood98qN;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF47606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 15:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FF47606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LVloF5Ph;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hdfXVYss;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FMm+sDTb;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3ood98qN
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB00C2258E;
	Fri, 20 Nov 2026 15:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795190305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0hnuUq5U6ulpxWIKDfylKBbb7qMsyHDP/g8UrtzG0cc=;
	b=LVloF5Ph1ridCWOcv3hHQGDNMNvqy+2ERuwqO42C2X63IOp5LwL4MtHQGd8B4lWNVHP2jo
	tRH4ztfuwerOCZn4pUpRHUOx1GMZ0+UevYIDVXqAvtZZJT1Re3OoOBS1kujauHosqbm6/q
	a8zRYQi8X1oynwbQF5BsVy07ZTV3/g8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795190305;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0hnuUq5U6ulpxWIKDfylKBbb7qMsyHDP/g8UrtzG0cc=;
	b=hdfXVYss/zpHLS1ViHEH7Yqqls+lsdPiIWjLljS01HOcgKUITnq/O0tEiPEs1v/HqiuYLb
	QnQzaAZu8PkLZ/Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FMm+sDTb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3ood98qN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795190304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0hnuUq5U6ulpxWIKDfylKBbb7qMsyHDP/g8UrtzG0cc=;
	b=FMm+sDTbEA9wH+NiVby8McQfFIi+n2Kdq1fp+vipQXaMEcJuudkMK9Kkz2RdfjwkVpvRcP
	EEMGrMMq45t5nB3SnFxSL1Pvm+G+eMPJndWCQ8asIhqEAFaLKZLd1FsnC0oQ+Vl4FQs+S9
	3zVY7TJMLHBjLCfiCbjtQRpxmkALkok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795190304;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0hnuUq5U6ulpxWIKDfylKBbb7qMsyHDP/g8UrtzG0cc=;
	b=3ood98qNeHrV1GEyVo5U31EtjN78yaA6wRyMUMD80qZ/qAp6DVUDoQOBsZ4zOEZiOCY3y1
	WafwAtk4uhIcL+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BB841348F;
	Fri, 20 Nov 2026 15:58:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Dx6oGiBuAGtTCQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 20 Nov 2026 15:58:24 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com,
	airlied@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH] drm/ast: Add an option to disable Write-Combine
Date: Fri, 20 Nov 2026 16:57:58 +0100
Message-ID: <20261120155821.119377-1-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: EB00C2258E
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,ffwll.ch,gmail.com,lists.freedesktop.org];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -12.01

WC-mapped video memory presumably has PCI I/O bursts that interfere
with real-time tasks. Seen on AST2600 hardware.

Add an Kconfig option to ast for vmapping the video memory uncached
if CONFIG_RT=y. If set, video-memory access is slower, but avoids
I/O bursts on the PCI us. Mirrors a similar change to mgag200 in
commit b593ea940623 ("drm/mgag200: Add an option to disable
Write-Combine").

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: f2fa5a99ca81 ("drm/ast: Convert ast to SHMEM")
Cc: <stable@vger.kernel.org> # v6.2+
---
 drivers/gpu/drm/ast/Kconfig  |  9 +++++++++
 drivers/gpu/drm/ast/ast_mm.c | 13 +++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/ast/Kconfig b/drivers/gpu/drm/ast/Kconfig
index 242fbccdf844..f2c99e99b5b4 100644
--- a/drivers/gpu/drm/ast/Kconfig
+++ b/drivers/gpu/drm/ast/Kconfig
@@ -14,3 +14,12 @@ config DRM_AST
 	 is bound to the driver. These GPUs are commonly found
 	 in server chipsets.
 
+config DRM_AST_DISABLE_WRITECOMBINE
+	bool "Disable Write Combine mapping of VRAM"
+	depends on DRM_AST && (PREEMPT_RT || COMPILE_TEST)
+	help
+	  The VRAM of AST GPUs is mapped with Write-Combine to improve
+	  performances. This can interfere with real-time tasks; even if they
+	  are running on other CPU cores than the graphics output.
+	  Enable this option only if you run real-time tasks on a server with
+	  Aspeed graphics.
diff --git a/drivers/gpu/drm/ast/ast_mm.c b/drivers/gpu/drm/ast/ast_mm.c
index 0bc140319464..cc882d2c172d 100644
--- a/drivers/gpu/drm/ast/ast_mm.c
+++ b/drivers/gpu/drm/ast/ast_mm.c
@@ -74,6 +74,18 @@ int ast_mm_init(struct ast_device *ast)
 {
 	struct drm_device *dev = &ast->base;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+#if defined(CONFIG_DRM_AST_DISABLE_WRITECOMBINE)
+	resource_size_t base;
+	u32 vram_size;
+
+	base = pci_resource_start(pdev, 0);
+
+	vram_size = ast_get_vram_size(ast);
+
+	ast->vram = devm_ioremap(dev->dev, base, vram_size);
+	if (!ast->vram)
+		return -ENOMEM;
+#else
 	resource_size_t base, size;
 	u32 vram_size;
 
@@ -89,6 +101,7 @@ int ast_mm_init(struct ast_device *ast)
 	ast->vram = devm_ioremap_wc(dev->dev, base, vram_size);
 	if (!ast->vram)
 		return -ENOMEM;
+#endif
 
 	ast->vram_base = base;
 	ast->vram_size = vram_size;

base-commit: 7d502136b31169f6b5575f7f89c3da60cdf7891d
-- 
2.56.0

