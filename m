Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24685439332
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523644; cv=none; b=s9aFfCsPPFReJr7qXnu6Ctd+t7c0e4vfNQSwo7Xqvv/c2FGh7cO5v7eJ/FcI0Al3ziyoDtixHMfH97md2XAjuN79/LWXUEsSp+ApLwvDmKnrzszRk4hzNWIqvzfI2m/Dr9Rnrwsfb1F0vtOkB5SCIQ/bm5+2knY0TJlbCkI4K7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523644; c=relaxed/simple;
	bh=i2gPbW9LCVgFfB4Z7e9IeKDCtST6OInAsRz/u1+6GdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B/dWVJUZk9e7krzaNsoKaEArivpR2f3Q1zH4Hr/7njqoBozNd1I8b0UcZFPFqs9r/2UnpNaOv8VyCVS8k64zG95XDBu/VvZ6WZbYuXVBYKSCfhv2ZnchARIf0EwFQ7/Yqsk++gf5yF3xUb1Lmclpyf0g1uN9frIl6VPAw8DcD/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZWy3N8Uw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p+YNGRJu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZWy3N8Uw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p+YNGRJu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZWy3N8Uw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p+YNGRJu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZWy3N8Uw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p+YNGRJu"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5040C75E7E;
	Wed,  8 Jul 2026 15:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783523641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wQy7yDgdq9Z/roCwYuyv8+aMjSsm8rVgT4zef9CjDk0=;
	b=ZWy3N8Uw+02AbAgf6a7+uw5cKFXVuTKGxOMZGXlnPZQlLoqP52I3EnU9T46wviV6Sv5uE9
	plWKp6+M37mYCv9gLuTbABnILOQudSQA+7QM2h332VhP5wvtBq7B03ckqPur4j/hGG2NfN
	YoLQ3Md9qBYylNVH5fqKz+xIB2Sbsk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783523641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wQy7yDgdq9Z/roCwYuyv8+aMjSsm8rVgT4zef9CjDk0=;
	b=p+YNGRJuSNgJriA0iJ4MSEpQyGB6ATzbn0oYm87Z7EQlhu507LaoDHc6SuDOXEXBnkjh1F
	Aw75bhAWEY304SDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783523641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wQy7yDgdq9Z/roCwYuyv8+aMjSsm8rVgT4zef9CjDk0=;
	b=ZWy3N8Uw+02AbAgf6a7+uw5cKFXVuTKGxOMZGXlnPZQlLoqP52I3EnU9T46wviV6Sv5uE9
	plWKp6+M37mYCv9gLuTbABnILOQudSQA+7QM2h332VhP5wvtBq7B03ckqPur4j/hGG2NfN
	YoLQ3Md9qBYylNVH5fqKz+xIB2Sbsk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783523641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wQy7yDgdq9Z/roCwYuyv8+aMjSsm8rVgT4zef9CjDk0=;
	b=p+YNGRJuSNgJriA0iJ4MSEpQyGB6ATzbn0oYm87Z7EQlhu507LaoDHc6SuDOXEXBnkjh1F
	Aw75bhAWEY304SDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63F59779AE;
	Wed,  8 Jul 2026 15:14:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K50YFThpTmrWLQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 08 Jul 2026 15:14:00 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>,
	stable@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Song Liu <song@kernel.org>,
	Eric Hagberg <ehagberg@janestreet.com>,
	Zi Yan <ziy@nvidia.com>,
	Gregg Leventhal <gleventhal@janestreet.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH stable v2] mm/khugepaged: write all dirty file folios when collapsing
Date: Wed,  8 Jul 2026 16:13:57 +0100
Message-ID: <20260708151357.353173-1-pfalcato@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[janestreet.com:email,infradead.org:email,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,nvidia.com:email,suse.cz:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

[There is no upstream commit, as this code was removed by upstream
 commit 044925f9b565 ("mm: fs: remove filemap_nr_thps*() functions and their users")]

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

As a side effect, move the nr_thps counter bumping outside the i_pages
lock. This is correct since the counter itself is an atomic_t and the
producer <-> consumer correctness is provided by a full memory barrier:
smp_mb() in collapse_file()/memory barrier implied by full ordering in
get_write_access() -> atomic_inc_unless_negative().

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
Tested-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
v2:
 - condition this logic on !mapping_large_folio_support(mapping) (Baolin, Lance, Matthew)
 - explain why moving the nr_thps bumping outside the i_pages lock is safe (Matthew)
 - pick up Tested-by from Lance (thank you!)

 mm/khugepaged.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b8452dbdb043..d6e04041f5dc 100644
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
+	if (result == SCAN_SUCCEED && !is_shmem && !mapping_large_folio_support(mapping)) {
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

