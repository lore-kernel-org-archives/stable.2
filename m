Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10A94A2E2D
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359858; cv=none; b=l88b5sgRTy5mw9phFfMBwjSGsDsvJ5WCn2O8u6QSNKnRystn5NAasiwKqvlmeRRQy4dXpxPslf2nfKVFeZdMAGyAdPv75M+rk9YRLs5gAMj9Su0Lx+LPL6c07szYki/Ny5FjZcnnXbtBorvGLMTYg2F8T50apAnCQyKyAobApks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359858; c=relaxed/simple;
	bh=y4xU+XhtATT6snLXLBfTuQolSrXX8oyl3SUW4D/uI90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k4PHQQJ3NlITJ7U0c/EZ0hWrS/7c1L1yoZjoGqpxx1u1g1hFV9YsiWA6S/C77j5CAq+qtoLtQuIhVSxN+xxhmohb8bNsHhwS3J1Txbl26K6J//HJ9afCUWHoioKrCoiD54t9DWtedM7JKtHMydYObuxTu/gAmUk3RB/1KgUTooU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wlh35too; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w/Gi/gm2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IEUg0vF1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nKfw6V4Z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wlh35too";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w/Gi/gm2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IEUg0vF1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nKfw6V4Z"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BF48121E32;
	Wed,  2 Sep 2026 14:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788359850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NR7y+r/gQ5mUvFUEA64kozoqRQKs7SRD8x4IZ7I5eGU=;
	b=Wlh35tooI2wlia/mm/nhkLCkkQ9SJY0lJwsPrS5Gk/cZhoq24m3gXlliZKYxGF/CMekZ0T
	qG8fQxE/ui4O7IwrnNtXN4y/exOvXvKz3o7yKV2R4i3orLJPizrMb8C5inL6tB6YT9+1h6
	Qq3uGEt73Pm+FTlxMvdspVKoccz0ZG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788359850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NR7y+r/gQ5mUvFUEA64kozoqRQKs7SRD8x4IZ7I5eGU=;
	b=w/Gi/gm2jkqpJRnVb8yZpswSe6K2UPf6Xmm1V++R6baOK1DgPG1MVJxXKmfQ4WAVuTy1fH
	+xwxWD5Bn6XQU/Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IEUg0vF1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nKfw6V4Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788359846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NR7y+r/gQ5mUvFUEA64kozoqRQKs7SRD8x4IZ7I5eGU=;
	b=IEUg0vF1W5reXpzH2jYs9FGnALOC8Xdy+F91rsHO69LVfnjaNYt8qeJ3hVzVXwi9oBSDFE
	fcefjGfYkvYp5G8ZWyyN6NXxDLsyatw68ldjo/QpQE+Advi/hIe5alTrAkaveGnwdGUW1k
	RodM3S66OInJrib1qHFdUR8UNucExjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788359846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NR7y+r/gQ5mUvFUEA64kozoqRQKs7SRD8x4IZ7I5eGU=;
	b=nKfw6V4Zsf7ZgPC03tUcV87Qt5+pfXET7SDoxLYkzoxovSjSA+1X1j/LX6po8TbaNOLNmo
	fDAiBzf7pfY9HjCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AAA8136E6;
	Wed,  2 Sep 2026 14:37:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SXp6HaY0mGr3HgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 02 Sep 2026 14:37:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0CEFEA13B5; Wed, 02 Sep 2026 16:37:22 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	stable@vger.kernel.org,
	VEGA <vega@nebusec.ai>
Subject: [PATCH] gfs2: Fix journaled truncate range end offset
Date: Wed,  2 Sep 2026 16:36:57 +0200
Message-ID: <dd2fb3c26e999922ebb6413cfdde212903e204b7.1787225676.git.vega@nebusec.ai>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407; i=jack@suse.cz; h=from:subject:message-id; bh=y4xU+XhtATT6snLXLBfTuQolSrXX8oyl3SUW4D/uI90=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBqmDSI5occ0yaYDF+bIEbYxGri4gtlmlCW9j3v7 LeeW8Ar7diJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCapg0iAAKCRCcnaoHP2RA 2YQ/CADbHWPUCOOmlAZlfSslDUEb11nzV5cr8ZD4tkLhhojMiopMe6ANWZ6lBlYL7gv6fgNOGj2 bhabUJxdRSckgUpQCXq76CQSPgoT2oDMgmKydk31UXb+GmpMEny4JTE2wuvFMNIWnZA3VliV9j4 myx47Crsqxoj/3W6EMP/tB6WFDRDTM09Wg1pGR9h8D0LyS8Z2wIRT+EXlFcMN36yLEoc0otRiCG nDLSIqxqRFe22ngxef+lJrHctJnJQqu7aPwCNq1h2HL/0C7P7MP83fjvpynDRKeqOQbM8EJ0a9I cbuf+sw8vDve2iF9gb5KX1yNTv7mOEh2bZs1EXF3PiCLA5nl
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BF48121E32
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01

The third argument to truncate_pagecache_range() is the inclusive end
offset, but gfs2_journaled_truncate_range() passes the length of each
chunk. A hole punch at an offset larger than its length therefore
creates an inverted range.

The MM truncation path then underflows the unsigned partial-folio
length and passes an oversized range to folio_zero_range(), triggering
a BUG. Pass the last byte of the chunk so page-cache invalidation
covers the intended range.

Fixes: 4e56a6411fbc ("gfs2: Implement fallocate(FALLOC_FL_PUNCH_HOLE)")
Cc: stable@vger.kernel.org
Reported-by: VEGA <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/gfs2/bmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

This was actually analyzed and fixed by Nebusec AI bot and it looks like an
obviously good fix to me.

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 51ac1fd44f78..375595235aac 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -2414,7 +2414,7 @@ static int gfs2_journaled_truncate_range(struct inode *inode, loff_t offset,
 		if (offs && chunk > PAGE_SIZE)
 			chunk = offs + ((chunk - offs) & PAGE_MASK);
 
-		truncate_pagecache_range(inode, offset, chunk);
+		truncate_pagecache_range(inode, offset, offset + chunk - 1);
 		offset += chunk;
 		length -= chunk;
 

base-commit: 24ef02f934eeb48830cff6b739abc3c62b1d107b
-- 
2.47.3

