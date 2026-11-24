Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533401;
	b=wxkHT1Qi+5uCtHBUnxmtj9qxc/WV7bGpvqFnF9tM/1rwupevhKpiiQdBuiJJ7QSeRIVo
	 hFZAsxF5a6I46Utn+kmN5gGsMkn0LZcSOkzlCPF/UStOmPkyXQ6vPSxI0JBuSGH0C4mjS
	 +57DY5xdXzHJhCqigY1RDL3OK0li0xxd/Qy0vH6jdd9A3eqtH+l1CMvLK9fvoHIUvxpyS
	 VJgIKumSuOZrimSmZQAt2bUPg1edtVwUwoW9cO4101itn9p8sSd6o3ZYi11NJeC4W7zX9
	 4be9JCDFSPpye9Vnn1eqD4x1AYo7eAjK6/sYclJvo7axNzsAQj5Ov+zKZOcxR1vjcJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533401;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spamd-Result:X-Spam-Score;
	bh=pqvAaGEjpt0IWpRB6w6aHQ4ddduicuAnAOViW9LYZuU=;
	b=WGJN/5nw/5I3kZzRIDl1rEumAZakD7WWDCDx1mn7TlyieyhIytu/j6+ukw8bDy8gh7x9
	 nIrrSPu25f+as1fSloaAmeaP9hl++NgHHiC/Nw9UlXXC/fNOk9sKhqNUV5boPM8DHTmdt
	 9yzFN3dEeAvPzOrJdS6JQMUUgaD26sV07i041LhgZPDlfSjW8x+UxChrTr5H+iqKsCLa5
	 64dgfKImfjTuxJw8Ux8/LKV+Ienzd6+MxOQEXT333fVlNckJI6b4pcV3ZXPGBObuJOvy3
	 OcVcy6gyxxuhejKS+4ia6dM3mdbH2PgErPDvMOmJhHoqjXs0n/j/hwkArHfqR99UVsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YHOI2wJa;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=y7SUBeFd;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zxzGQ5z6;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HPnRjVdR;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C540606A31E;
	Tue, 24 Nov 2026 15:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C540606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YHOI2wJa;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=y7SUBeFd;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zxzGQ5z6;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HPnRjVdR
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E6C5C1F808;
	Tue, 24 Nov 2026 15:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795533399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pqvAaGEjpt0IWpRB6w6aHQ4ddduicuAnAOViW9LYZuU=;
	b=YHOI2wJaR8bg0qDHCmTJaLQo/0jdmqx3HH33jgKd82XPPYp94eo3aaa4aHMmqVLKCfozbY
	0OQVRBWfDiA6lUq8G2EMUzV2plRlSrMIB6apBSh7egNq1cwPjckLP0gRuVnGas8mJkqkDk
	lsdIkrrFrzfYfBWGsZSMLzEpQY9eslI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795533399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pqvAaGEjpt0IWpRB6w6aHQ4ddduicuAnAOViW9LYZuU=;
	b=y7SUBeFdtHfvymMjUqn2rPG8y2Wf/tx8JKfT3zkBBmWztHeXLyPn00C+K9yOaCmrxPnIZy
	8ULOyHHsqvGOowAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zxzGQ5z6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HPnRjVdR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795533397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pqvAaGEjpt0IWpRB6w6aHQ4ddduicuAnAOViW9LYZuU=;
	b=zxzGQ5z6rUrhebFS2hTSdWoSlZzm7rhMNrp5TgvI9IT1PzZiu+sWfDhWImlTRkoTw4we7d
	G9q/jQKR4BBAdOjbqOZgcQT9GUXmYWoQDuECtpTvl5JlGqovkuLNkMQJ49UMwGM5EAh+Z3
	ciDeewyBELgSd00Hc55mvNUQH0GDK5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795533397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pqvAaGEjpt0IWpRB6w6aHQ4ddduicuAnAOViW9LYZuU=;
	b=HPnRjVdR9XJWZfZeVdIWSKlBLCKNZZk6bgYwH4fU22u5uC7mPVLU7BxOijMpWnjjjnmyZB
	a8ZP9oOkO1teHwCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCDA913505;
	Tue, 24 Nov 2026 15:16:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1PJAJVWqBWuIYQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Nov 2026 15:16:37 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 3ACB4279EF; Tue, 24 Nov 2026 16:16:37 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	stable@vger.kernel.org,
	Roman Yepishev <rye@keypressure.com>
Subject: [PATCH] udf: Fix validation of unalloc space bitmap
Date: Tue, 24 Nov 2026 16:15:55 +0100
Message-ID: <20261124151554.42698-2-jack@suse.cz>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2757; i=jack@suse.cz; h=from:subject; bh=t14vdnDcmj2MZXJxzlGdzOlqqxNmOzXA8J1fOqqz6q8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBrBaoq7/EBTyzrNsHVKk9FHNwVtVoxg9XPJZcj5 /7tkS+i+P2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCawWqKgAKCRCcnaoHP2RA 2X7dB/wKe38hJEbrZ8Qr+vrZQ5ExhGtIvrr86fw6vnqQ13ldtHF0zMxVSdhuIqKf8bN0IDby6Qy kaEj/cmHPL8dVvLn4NmUGwsiTKxvi3pxsfa3jRXunu7FRH87gxz4RpAjWi4tEIVCGroEtykzImS 4ERCaY84YQfDLQveoxeCpsSWCGS63WvMrz6NrTwozTdk5v2+pTv0sC1W4xjVFbQfNJZh8kYIAWP T8Gqg/gEedkOZYQR2paeX6+xak3GDMrLFsJrS+EpqW3t0DOPivm/lAkPaVZf68MuTntzS/J7K4r CdMry1tfqjgo2izA9YDcd1w7wj+qA9qO8CBSKecUTxV1C/z8
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E6C5C1F808
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
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,keypressure.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -12.01

The validation whether bitmap blocks are marked as used in the
unallocated space bitmap was assuming that the bitmap is located at the
beginning of the partition. That is not true e.g. for media generated by
Win 11. Fix the validation to properly take location of the bitmap
within partition into account.

Fixes: 1e0d4adf17e7 ("udf: Check consistency of Space Bitmap Descriptor")
CC: stable@vger.kernel.org
Reported-by: Roman Yepishev <rye@keypressure.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/balloc.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

I plan to merge this fix through my tree.

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index b6551cc7c6cf..94baaa8fc74d 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -33,8 +33,9 @@ static int read_block_bitmap(struct super_block *sb,
 			     unsigned long bitmap_nr)
 {
 	struct buffer_head *bh = NULL;
-	int i;
-	int max_bits, off, count;
+	char *bmp;
+	unsigned int i, start_blk, end_blk, bmp_start;
+	int max_bits;
 	struct kernel_lb_addr loc;
 
 	loc.logicalBlockNum = bitmap->s_extPosition;
@@ -45,27 +46,34 @@ static int read_block_bitmap(struct super_block *sb,
 	if (!bh)
 		return -EIO;
 
-	/* Check consistency of Space Bitmap buffer. */
+	/* Check bitmap blocks are marked as used in the bitmap */
 	max_bits = sb->s_blocksize * 8;
+	bmp = bh->b_data;
+	/* Skip header in the first bitmap block */
 	if (!bitmap_nr) {
-		off = sizeof(struct spaceBitmapDesc) << 3;
-		count = min(max_bits - off, bitmap->s_nr_groups);
+		bmp += sizeof(struct spaceBitmapDesc);
+		max_bits -= sizeof(struct spaceBitmapDesc) * 8;
+		bmp_start = 0;
 	} else {
-		/*
-		 * Rough check if bitmap number is too big to have any bitmap
- 		 * blocks reserved.
-		 */
-		if (bitmap_nr >
-		    (bitmap->s_nr_groups >> (sb->s_blocksize_bits + 3)) + 2)
-			return 0;
-		off = 0;
-		count = bitmap->s_nr_groups - bitmap_nr * max_bits +
-				(sizeof(struct spaceBitmapDesc) << 3);
-		count = min(count, max_bits);
+		bmp_start = bitmap_nr * max_bits -
+				sizeof(struct spaceBitmapDesc) * 8;
 	}
+	start_blk = bitmap->s_extPosition;
+	end_blk = start_blk + bitmap->s_nr_groups;
+	/* No overlap? */
+	if (end_blk <= bmp_start)
+		return 0;
+	if (start_blk < bmp_start)
+		start_blk = 0;
+	else
+		start_blk -= bmp_start;
+	if (end_blk > bmp_start + max_bits)
+		end_blk = max_bits;
+	else
+		end_blk -= bmp_start;
 
-	for (i = 0; i < count; i++)
-		if (udf_test_bit(i + off, bh->b_data)) {
+	for (i = start_blk; i < end_blk; i++)
+		if (udf_test_bit(i, bmp)) {
 			bitmap->s_block_bitmap[bitmap_nr] =
 							ERR_PTR(-EFSCORRUPTED);
 			brelse(bh);
-- 
2.53.0

