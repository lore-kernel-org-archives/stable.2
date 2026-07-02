Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B1E318B9D
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011257; cv=none; b=S0LZTQG3Ku6QM5FrQLvKjh3Hg1nxYPjdnlLSjJsoHW5oBOYG/AtmFYEYDl0feRF/PM7Jpv5zYtBWKdEh+PmoQmnJhkm6EDmvNGU/3aGKQJv0r/GBAsyfEBnOKCzGR3W7qhl9hXKFzObCI7pPaDz9CpqvMjo2MkwYmxcv+rfwDyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011257; c=relaxed/simple;
	bh=jX86nFiXli7OqYmNr8GkSaY/BfnwjYRyX7CwrJ6i0mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z5KoKd+AL+Snczs0wl2m8D2TjVrhTNUB6PI1+PY2kyr3B6VBLjXiPduGqNLwfa+8qKYEdB5T/C8nYpo3KQ/HmJ/BfTjs9tfQz8zvffz+zZ+4Flg7lVcC5ZMDZPEUQTsqTgQaCTYQjKv/aph/PWsMovcToZxbWL50oj50SJ90Mis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1izVBK4n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6uTqBlzX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i80g1EaL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O61y2J9V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1izVBK4n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6uTqBlzX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i80g1EaL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O61y2J9V"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7658C75FB5;
	Thu,  2 Jul 2026 16:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783011254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=heA6NlsuWwAqm6a7CgrmaEXikzhssH3mg744Z6Vx3HM=;
	b=1izVBK4nVCJ74vk0GUwiMAv0GlH+Ps2ASXq6SqAYaeWjK8PW5ZlWd6OSAcLlqMtiVIBUEa
	cSd5oQV9mUQl3GWMrCCyaTZEx4FPCpXWM4uBLp7hZkonWn/RY/aHQdxawvRDSs2mPlViDV
	SrKqtCd+GWMLNwmY1EcWQSfqqOJgTUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783011254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=heA6NlsuWwAqm6a7CgrmaEXikzhssH3mg744Z6Vx3HM=;
	b=6uTqBlzXnUFP3mTmChLkBqe9bSn2aV9bO5GZPaSJwxMPe2hHKRPdjxwC+vZWd4zUAyunz+
	VMNDWuCVoSd9ROBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=i80g1EaL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=O61y2J9V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783011253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=heA6NlsuWwAqm6a7CgrmaEXikzhssH3mg744Z6Vx3HM=;
	b=i80g1EaLCR84t4GJZWPKL6QND00ecxXrtiK9z4q8TQS+NWQohgoAxa1kY0V3lE8MaUmP8v
	W+i9mEj6mJepcuqBJ6gIqD3NXTlMfhAnx1iU+B5UithgtQwzoP6850iPelgEugyd/gM4ZW
	xkQ+27Ttbg/+EogYLdaQToHHKmrNSDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783011253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=heA6NlsuWwAqm6a7CgrmaEXikzhssH3mg744Z6Vx3HM=;
	b=O61y2J9VlyCj+9OmiKJmZFL1QCLCphSXO1xaHSug75JaSqB+QWHtxr4oIESNxRBIWlEZoA
	4DbvtMoAIhZYetDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F384C779AA;
	Thu,  2 Jul 2026 16:54:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HYAEOLOXRmrqQQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 02 Jul 2026 16:54:11 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Pedro Falcato <pfalcato@suse.de>,
	stable@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Song Liu <song@kernel.org>,
	Eric Hagberg <ehagberg@janestreet.com>,
	Zi Yan <ziy@nvidia.com>,
	Gregg Leventhal <gleventhal@janestreet.com>
Subject: [PATCH stable] mm/khugepaged: write all dirty file folios when collapsing
Date: Thu,  2 Jul 2026 17:54:09 +0100
Message-ID: <20260702165409.164568-1-pfalcato@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,suse.cz:email,infradead.org:email,janestreet.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,nvidia.com:email,suse.de:email,suse.de:dkim,suse.de:mid];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7658C75FB5
X-Spam-Score: -3.01

As-is, khugepaged and writable-file opening exclude each other. A file
cannot be open writeable and have THPs (because the filesystem is not aware
of them). khugepaged will never collapse file pages for files that are
opened writeable. On an open(O_RDWR/O_WRONLY), the page cache for that
particular file is dropped. This is fine because nothing could've been
dirtied.

However, there is an edge-case: collapse_file() might not be able to
coexist with concurrent writers, but it can coexist with dirty folios
(from previous writers). Therefore, the following can happen:

open(file, O_RDWR)
write(file)
close(file)
madvise(file_mapping, MADV_COLLAPSE, some non-dirty range)
open(file, O_RDWR)
 nr_thps > 0
  truncate_inode_pages()
    /* THPs are cleared out, but so are the dirty folios */

When this edge-case happens, there is data loss, as the dirty folios are
fully discarded.

Fix it by fully writing back the page cache (and waiting) when collapsing
file THPs. Doing so provides the guarantee that no dirty folio will be
observed while there are active THPs. To fully ensure this is safe, the
invalidate_lock needs to be held while doing the writeout, so that
do_dentry_open()'s page cache truncation excludes this write-and-wait.

Cc: stable@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Song Liu <song@kernel.org>
Cc: Eric Hagberg <ehagberg@janestreet.com>
Cc: Zi Yan <ziy@nvidia.com>
Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Reported-by: Gregg Leventhal <gleventhal@janestreet.com>
Closes: https://lore.kernel.org/linux-mm/CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com/
Tested-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
This patch is written against 7.1.0 (because the code no longer exists in mainline).

Zi, I kept your Tested-by, but I had to move some things around and
use the invalidate lock. Please re-test if you can.

 mm/khugepaged.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b8452dbdb043..0707d719a270 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2094,32 +2094,43 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 		goto xa_unlocked;
 	}
 
-	if (!is_shmem) {
+xa_locked:
+	xas_unlock_irq(&xas);
+xa_unlocked:
+
+	/*
+	 * If collapse is successful, flush must be done now before copying.
+	 * If collapse is unsuccessful, does flush actually need to be done?
+	 * Do it anyway, to clear the state.
+	 */
+	try_to_unmap_flush();
+
+	if (result == SCAN_SUCCEED && !is_shmem) {
+		/*
+		 * invalidate_lock as shared excludes against concurrent opens
+		 * in do_dentry_open() truncating the page cache. This is
+		 * particularly important if there are dirty folios in transit.
+		 */
+		filemap_invalidate_lock_shared(mapping);
 		filemap_nr_thps_inc(mapping);
 		/*
 		 * Paired with the fence in do_dentry_open() -> get_write_access()
 		 * to ensure i_writecount is up to date and the update to nr_thps
 		 * is visible. Ensures the page cache will be truncated if the
-		 * file is opened writable.
+		 * file is opened writable. If collapse looks to be successful,
+		 * flush any dirty pages out the page cache. With the nr_thps
+		 * incremented, there won't be any new writers (nor new dirties).
 		 */
 		smp_mb();
-		if (inode_is_open_for_write(mapping->host)) {
+		if (inode_is_open_for_write(mapping->host) || filemap_write_and_wait(mapping)) {
 			result = SCAN_FAIL;
 			filemap_nr_thps_dec(mapping);
+			filemap_invalidate_unlock_shared(mapping);
+			goto rollback;
 		}
+		filemap_invalidate_unlock_shared(mapping);
 	}
 
-xa_locked:
-	xas_unlock_irq(&xas);
-xa_unlocked:
-
-	/*
-	 * If collapse is successful, flush must be done now before copying.
-	 * If collapse is unsuccessful, does flush actually need to be done?
-	 * Do it anyway, to clear the state.
-	 */
-	try_to_unmap_flush();
-
 	if (result == SCAN_SUCCEED && nr_none &&
 	    !shmem_charge(mapping->host, nr_none))
 		result = SCAN_FAIL;
-- 
2.54.0

