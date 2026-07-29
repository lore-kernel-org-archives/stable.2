Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA4128688C
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336372; cv=none; b=Hujzy32OJFbwwKX7Xpx2UIRaZ/bnWAhsL3jBVASAJDA82z8Ng0vyo+ySlyuiFtvJCggApNOqyQ/k0cfeK0fTFVRl6Fi0BYV5n56HLjssFLXB+qIZieuNqBlTOVmxNSzelPbwZIXhX38Wt3gm3+ZDZ8idaoWtf1Ql1HRpVczruqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336372; c=relaxed/simple;
	bh=z17EjzkxMe4MohISvMo15M5lROhGgHh6akBlRAhJHAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jN2eFaIi2jeyusjDE2FZOsnqO36Aeopp408rneIiP7R5SmRfRsXHTgjWlV8JyWZJ3dia/qu6UwE/UjMugE6N+bfb//qrAiZ1k38y+O2QBrH7HRTcLs3pUEgiUyJImYSA9a0RVeKF122iXE+HoYMS0ICA2aFYBOCqfCpvSNJ46aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C2ar6fbW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Cowxi9d; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xrDkZ0xk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1IEEQE4G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C2ar6fbW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Cowxi9d";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xrDkZ0xk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1IEEQE4G"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A8A207B82A;
	Wed, 29 Jul 2026 14:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785336364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fwLl9tePNDtFdDzKevW2f8uzsHgX10NUMhlPI5gohe4=;
	b=C2ar6fbWtmOjBdc1WRB3nVoTZP8VxKjbh2S39qsgMHjnOGSXozny/ZrrnJaOx61V/DOVN7
	4U43IE8L+j576iRm3tm6chDmvKBa44tNfjzUW3sAGTZn0bO/5HgUn5PjDs+ZEkejENC2wh
	xg77weTcXYa0HD1PmEwTVWqK5zoCB9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785336364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fwLl9tePNDtFdDzKevW2f8uzsHgX10NUMhlPI5gohe4=;
	b=1Cowxi9diDWfjAYl/pfyAHO8PEOcZRZOeWno4YMCP1dq7w7WBIPwCZ+kFZKMTdKvXj9LZ8
	8+/gxlrYY0WSXEBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xrDkZ0xk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1IEEQE4G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785336360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fwLl9tePNDtFdDzKevW2f8uzsHgX10NUMhlPI5gohe4=;
	b=xrDkZ0xkWt/YMSJvMqiZBGYv3uCuOISx7ETVqH0Yt538xNwwf9xN17eygOV3rpBY3om8bd
	c8cBoG2rxGjZ4jVNSC3k9w04e3FbLIaXDuzDyDILs5hyckyxZ6baBZDHst9z1j/qimcxga
	h4buHxjLTJleM1c4S8FiK2uChxroItE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785336360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fwLl9tePNDtFdDzKevW2f8uzsHgX10NUMhlPI5gohe4=;
	b=1IEEQE4GqFTUyxjx7qvmMJUJTZ6wASey49rKVvLHOQUV7fBaxmBePqGbdKk4gjW/2ECZaD
	FSMyU5/lAuS90SDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FA4A779A1;
	Wed, 29 Jul 2026 14:46:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q+z2JigSamo2SAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 29 Jul 2026 14:46:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 45B8CA131F; Wed, 29 Jul 2026 16:45:56 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	stable@vger.kernel.org
Subject: [PATCH] udf: Fix data loss when converting inline inodes to out of line
Date: Wed, 29 Jul 2026 16:45:48 +0200
Message-ID: <20260729144547.4028292-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2203; i=jack@suse.cz; h=from:subject; bh=z17EjzkxMe4MohISvMo15M5lROhGgHh6akBlRAhJHAs=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBqahIbt5JCCC+Yqlm25wXa9LCVF7337gFSLxzRf a5scbMFe/OJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCamoSGwAKCRCcnaoHP2RA 2bDpCADHsUoqvaZBAXDJvrY7S5zTVb6JD3efnUwUHVd9Vko7M6HhWPuQSN1/u+NzFRFbdR2XHT4 B+HmhSPeXRpL4rBvMOQuHEmd7MY/lIAe93zYoezfDxm6rIciujxi2faZAnO1zA6XaUw923wMXjb omOJTHLrZq9wrlFq7sdC2iJ8HGkj8qXhTMh0krwC1nfx8WvfakGur4Ff4mzvyc3lZvKYqmIrLLG Rzhsn+lKTTFKb7IOhGv8WMRVYGJi5IKN7EtC+E36SPqM0QVCIVuvfh7WOAO3G8N76tg+0IMum4K Y1bEw5R4aasBdHjxZCTjs9MOB7v0G348seTS+vgTIQLPE9oy
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: A8A207B82A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

When udf_expand_file_adinicb() converts file from inline format to out
of line, we use filemap_fdatawrite() to writeout the data to the new
blocks. However since 36580ed08776 ("udf: Do not allocate blocks on page
writeback") the writeback actually doesn't allocate the new block and
the folio dirty bit is just silently cleared. Thus unless the file is
written to after the conversion (as it can easily happen in case of
truncate up), the data is just lost. Fix the problem by explicitely
allocating the block underlying the data before starting writeback.

Fixes: 36580ed08776 ("udf: Do not allocate blocks on page writeback")
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

I plan to merge this fix through my tree.

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index b8b9b7132115..b5e374f355b2 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -405,6 +405,10 @@ int udf_expand_file_adinicb(struct inode *inode)
 {
 	struct folio *folio;
 	struct udf_inode_info *iinfo = UDF_I(inode);
+	struct udf_map_rq map = {
+		.lblk = 0,
+		.iflags = UDF_MAP_CREATE,
+	};
 	int err;
 
 	WARN_ON_ONCE(!inode_is_locked(inode));
@@ -434,20 +438,27 @@ int udf_expand_file_adinicb(struct inode *inode)
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
 	else
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
+	up_write(&iinfo->i_data_sem);
+
+	/* Allocate the block underlying the data */
+	err = udf_map_block(inode, &map);
+	if (err < 0)
+		goto restore;
+
 	folio_mark_dirty(folio);
 	folio_unlock(folio);
-	up_write(&iinfo->i_data_sem);
 	err = filemap_fdatawrite(inode->i_mapping);
 	if (err) {
 		/* Restore everything back so that we don't lose data... */
 		folio_lock(folio);
+restore:
 		down_write(&iinfo->i_data_sem);
 		memcpy_from_folio(iinfo->i_data + iinfo->i_lenEAttr,
 				folio, 0, inode->i_size);
-		folio_unlock(folio);
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
 		iinfo->i_lenAlloc = inode->i_size;
 		up_write(&iinfo->i_data_sem);
+		folio_unlock(folio);
 	}
 	folio_put(folio);
 	mark_inode_dirty(inode);
-- 
2.51.0

