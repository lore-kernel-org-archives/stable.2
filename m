Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDB441D13C
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576006; cv=none; b=syagam4W6r3E1xo01wNctSqA0Usyj2vGPGxOFdlNBIDgIJDlYppHdr+4ZF45hA2bmWU+QmrGGk7c+aCyXIbpRAQsb1QsgJ+y1nuwbJLRFpNmfpoCxueLJriDV5vdX5OeOH3WDFMMTPoz8Xnmellw2IQ+SjN4g3uyhqOYfRMbEuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576006; c=relaxed/simple;
	bh=UuExT21d9mY3xeAQtLEc9F50YD4OwkrIaRTu1DGM89c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWNrV6LmBGM+anVmBMIPtGL5D1DiNwRC/2rP1cl+wtRPADXLOCV4P07mBnUV9tUkgheUWooIZPrOIXgFMSOdufV7wGAI2ht9fXs+iOQJC25caewGL3iU9qVRTTGV3DWNGRRz7Hrdae1iDHvZNqKRJG8FyrnAJyMp0/qGzvn3CsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o94tW+dS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=x1GwUmd5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vYjkh/rr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m6d6k4ZR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o94tW+dS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="x1GwUmd5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vYjkh/rr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m6d6k4ZR"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B7B2E86823;
	Mon, 24 Aug 2026 12:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787575930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nBNm64Do0yMi6eg+lktNipkmpIXwtijB3dY2IOtN9Kg=;
	b=o94tW+dS1XyV818RG7hX2fE0xNtuyNTS7rGx6jkSG1x1RxGzbD6xkxquSZFd7VfCT1Bkag
	5RLmH5XohflnKv8A3TNtagfRbI8iFtJaO300RahK1ddmTa4yCB0JusHSmRz291BbqxUXLz
	mKTFSsEpEC3gzJrcwuGPG1iDoPHiHbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787575930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nBNm64Do0yMi6eg+lktNipkmpIXwtijB3dY2IOtN9Kg=;
	b=x1GwUmd54pcBD1kzhHqE+7Xyvz4Y2yjrBkk/6BLz9ZXaSqY4i2TN2kwy8BU+d708NDKRuk
	abpZ+QJBZHgFmKAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787575926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nBNm64Do0yMi6eg+lktNipkmpIXwtijB3dY2IOtN9Kg=;
	b=vYjkh/rrdb092WXxmm3APEe+u8e91ejm0wyq685FYAt0bQqjhT4sb87UuLd6rmEYyigkvr
	kcVrww68Vcbz3wi37CSF2yRHK7Cuu8HKQ6wBVzVm8fpkbuPyUkBPp4utFyw/3/58Nr68fg
	m0BemhHw/D8H/XsPFIYJwCarkK0t7RA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787575926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nBNm64Do0yMi6eg+lktNipkmpIXwtijB3dY2IOtN9Kg=;
	b=m6d6k4ZRT7y2gDom701TpE7liTcsQCL2yNDvLod9kpod2abp/fUg9UQH8zobQ54RU6JQZZ
	SEmoLlioPV5GKzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B2771333B;
	Mon, 24 Aug 2026 12:52:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OJxLDXY+jGpyNwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 24 Aug 2026 12:52:06 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com,
	javierm@redhat.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	geert@linux-m68k.org,
	rdunlap@infradead.org
Cc: dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	nouveau@lists.freedesktop.org,
	linux-renesas-soc@vger.kernel.org,
	virtualization@lists.linux.dev,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 01/13] drm/panic: Do not use un-escaped URL as format string
Date: Mon, 24 Aug 2026 14:43:32 +0200
Message-ID: <20260824125201.218863-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824125201.218863-1-tzimmermann@suse.de>
References: <20260824125201.218863-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,linux-m68k.org,infradead.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

Replace the direct use of DRM_PANIC_SCREEN_QR_CODE_URL in snprintf()
with a %s conversion specifier. Avoids a possible vulnerabilty from
a crafted URL string.

As the attacker needs to control the kernel at the Kconfig level, the
potential for an exploit is likely low.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: cb5164ac43d0 ("drm/panic: Add a QR code panic screen")
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.12+
---
 drivers/gpu/drm/drm_panic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index e576c4791861..ba21df4be338 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -658,7 +658,8 @@ static int drm_panic_get_qr_code_url(u8 **qr_image)
 	char *kmsg;
 	int max_qr_data_size, url_len;
 
-	url_len = snprintf(url, sizeof(url), CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL "?a=%s&v=%s&z=",
+	url_len = snprintf(url, sizeof(url), "%s?a=%s&v=%s&z=",
+			   CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL,
 			   utsname()->machine, utsname()->release);
 
 	max_qr_data_size = drm_panic_qr_max_data_size(panic_qr_version, url_len);
-- 
2.55.0

