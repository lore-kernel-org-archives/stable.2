Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D8041D21F
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576030; cv=none; b=ewOZ4QOK3JZv9EfFxk34YwJjaAJnSLkAvGGQcxV9BPrWt7PjRp6R8fu6WFz0BHgZjZsAur2EsYloI3S2++yACNC/2APUDt8w0RtjakeTWXG8EJufSnIOgsCg7aCCVvI1FhHz0ic7iBvru6V/Q3vhVWjHuSKndTx9BnWw2uWLKN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576030; c=relaxed/simple;
	bh=hQOCZQiQWVV5A4rMwrEaIRzRYQ6fIzgr7nYUd02QFAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFVj34uuvKI+vtw7OSVkQMw0/rpdXWLJxQVzBUMX2vQfU6SvgldrzwD9U+lMgfot+f99Zn7NCdvQXdCCKKRtDjOf2ypkbls6pvetNIvlArQoZY6V3UBFdcuawWlypaU+TyGTIQTBMe/c+Aem6LMePac0WzTXv40yoyz8KonAu+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XeHf5Onf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xkjPY9AA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XeHf5Onf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xkjPY9AA"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53A631F46E;
	Mon, 24 Aug 2026 12:52:07 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787575927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTrzt/jaZvN9VkFIcS6JMzdZ6BhpAj1Od+S6kV1K9r0=;
	b=XeHf5OnfwEUyRrANU2SOcH4VgZOYIRChRYa4Bt21YmCBQVoFKA2wbGarCnW22i3e18dmXJ
	A5oEliuPyhPQAam7qYvnkKUW3oW8bdUUiSVhk4XZuJ+MlTRFR7c9gssgrDZSpOWVImnHVS
	C4WAFM/On3lSiZIf0/gWWaFlHpxRMVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787575927;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTrzt/jaZvN9VkFIcS6JMzdZ6BhpAj1Od+S6kV1K9r0=;
	b=xkjPY9AAgwbSSPohSquaRXhP7KTmucKrsraDn8dcLqCZWslkIXf5yj1/m1WgTFPZApgqwt
	BLOKw6QC9IiWFXBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD986133CF;
	Mon, 24 Aug 2026 12:52:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2H7RLHY+jGpyNwAAD6G6ig
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
Subject: [PATCH v2 02/13] drm/panic: Test address from kmap op for NULL
Date: Mon, 24 Aug 2026 14:43:33 +0200
Message-ID: <20260824125201.218863-3-tzimmermann@suse.de>
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
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 53A631F46E
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Action: no action

Do nothing if kmap_local_page_try_from_panic() returns NULL. This is
not likely to hapen, as the previous page from the same memory area
has been mapped successfully.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 23437509a694 ("drm/panic: Fix 24bit pixel crossing page boundaries")
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.18+
---
 drivers/gpu/drm/drm_panic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index ba21df4be338..d28ce8878e05 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -178,6 +178,8 @@ static void drm_panic_write_pixel24_xpage(void *vaddr, struct page *next_page,
 	u8 *p = vaddr + offset;
 
 	vaddr2 = kmap_local_page_try_from_panic(next_page);
+	if (!vaddr2)
+		return;
 
 	*p++ = color & 0xff;
 	color >>= 8;
-- 
2.55.0

