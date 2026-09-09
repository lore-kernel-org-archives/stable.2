Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661773B2FCC
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944375; cv=none; b=ESUMhJ0dTvtAlyBNJAr4nhDd/jexjqI0OPbNCuE41981C1Gv6BZ2lDdMlqU42fBfO4MuykUHk4J+Cmz0hRbD4fZhLMZno7wu7TW9k7+Z9OLhmMbDldMyY8ad3cVf4ABokBR8w2hNNEJ50H4cHgTwubYNptYqyfNa00zKpUrl1jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944375; c=relaxed/simple;
	bh=hQOCZQiQWVV5A4rMwrEaIRzRYQ6fIzgr7nYUd02QFAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1Tq+1c6US+kqKX1yf5djncfK0ddJ2XZ5rTOTYTEnPSQZUYNDqylNvbI1cpZ9zOmkS1+xjR9I1gQkDAX/qBvljnRfShuAurTX3w5ymOIfkG0cr2sa5qy9aVK265vKlJbG/jh7aPXPUkGzat01lUWnxORpnkNLgMv6d90qlnUOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R8Kqqmv1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6f5rm7+w; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lsDTzoZ+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1QcHaIDL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R8Kqqmv1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6f5rm7+w";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lsDTzoZ+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1QcHaIDL"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 972C71F810;
	Wed,  9 Sep 2026 08:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788944317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTrzt/jaZvN9VkFIcS6JMzdZ6BhpAj1Od+S6kV1K9r0=;
	b=R8Kqqmv1/c9SIX2tNwFkk5FAKjhgepQkQtkiXQu65SPWh4y/1BIenkTE8UWNK1N9fFEovL
	vianw1tDF319z2CrhcpauqWZtYnYoqrmZAupgJna7zohaAZPo6kf3HFqDHdODVouKF7eqf
	/0BnSiwdYOs0IgaEvgyVDh834nu/p9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788944317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTrzt/jaZvN9VkFIcS6JMzdZ6BhpAj1Od+S6kV1K9r0=;
	b=6f5rm7+wJHSRct/XJoBOKNShF5FVN2tJvZjtCOSaUXisZERvDjsB7S/dXEMsTOmCO40mjs
	VgWJd/Zsj8mt+/DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lsDTzoZ+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1QcHaIDL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788944313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTrzt/jaZvN9VkFIcS6JMzdZ6BhpAj1Od+S6kV1K9r0=;
	b=lsDTzoZ+nR9qzJKHx7n1yxIR/AJ9OwkABpxDsDboY4c8uOhEI+K1I4TQ1hgQj2BO8JPfdR
	cxQd/aCufB4JDHJ/6wJ1ChY+ZrqNAeHbKWz7tUAQgWrONZ2c0sumq7Bsv+Ooo8VY/QBKV+
	qljwpXZw8pioeq+/hnMGqxOYyKQinyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788944313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTrzt/jaZvN9VkFIcS6JMzdZ6BhpAj1Od+S6kV1K9r0=;
	b=1QcHaIDLc0B0rJynKND3RaakbxWmiz+XDP21X3i0kFcvnoYXZt5wouZMpz7e2FfbjCwckh
	dLjkJgVovHt6qFCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9EAA13668;
	Wed,  9 Sep 2026 08:58:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mFUUMLgfoWoVUQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 09 Sep 2026 08:58:32 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com,
	javierm@redhat.com,
	airlied@gmail.com,
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
Subject: [PATCH v4 02/14] drm/panic: Test address from kmap op for NULL
Date: Wed,  9 Sep 2026 10:55:17 +0200
Message-ID: <20260909085826.64529-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909085826.64529-1-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 972C71F810
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,lists.freedesktop.org:email,suse.de:dkim,suse.de:email,suse.de:mid];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,linux.intel.com,kernel.org,linux-m68k.org,infradead.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLo585esf9b7txaosbn5shab9z)];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

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

