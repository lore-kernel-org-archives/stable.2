Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792464459;
	b=oqiGZd7hZ+MiM2LK3/DqcyUEnXdsX6M0cml01VkVoAVWf93DYejtse0C4KqXHq+FG/LN
	 7CZV0ocN1RqRcpnJew9ILyCWDlvLbb3QrYlpI+F7cpaY3WzpBmMVckviu1ITLV4lsqr0P
	 jt8nJzAzX2mH8ujWrY0NyCWyisEeN7t5ODWmjFsJ2EjUuLmOKEFcgbvdODX/5hZgAVvGY
	 6gR9fTfBKln2iCo0Mp7zCH3o2eIelc+aqGL4/Gvpp1yyU4YZ4y5DzAdcbVqx7Uh+1bqEX
	 PtvB6Z8Oj711cksQ33609CRVpgD0sW5fxJhfQOrVpEFrD+Y1/KyClmzqCR+uW+zhR1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792464459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QXaPhUMmKeWG8DuIUSmDwV9SB0ZMGDge3lOsVfysPhg=;
	b=E7VBbxHQkiFWEBCqBgHftRlYeCR+AR5Sy+8vDi7Wsz/As3vTze2dwcVJ85MOmKvEK8QS
	 w1F8dimZwmApXfEbWdpC4n50Mj2johMAt9bvG+spqbQ+eQ0cWCZI26tIBG65JomSzZlbW
	 ee4hAYPIM7YXuT6PGfNEyV+pWY8wKgvsP6RkFiooSvhW/mqiMOW4+1KVKgPrBBdjl0Y2k
	 hibj6yokWtaghqU/1XfT8I7r+koDOewGJXHzJASWu09XU4CMWcpAzvjh7C/1kDI9KhBbc
	 rWFDy1OGEgH2tis/k+a+NyyouGa1w6KCSo4cdu7xATO0w/ZNaUU+vPdxRYQjgdkDNlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qzPHn9Do;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC52606A326
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 02:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BC52606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qzPHn9Do
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd60d155070so1225578a12.2
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 19:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792464459; x=1793069259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QXaPhUMmKeWG8DuIUSmDwV9SB0ZMGDge3lOsVfysPhg=;
        b=qzPHn9Do8/iTolnzesbcoLFUaj8DxLzXLOXlXcuy2wU1jv91EAUkifwSR17mS9i+a1
         sO37WRpuiSIDK2sNnSM3k5ydhZkSpE9afe34eKX18A0MI45rkzgX/x6Ve1rilzEDeKrK
         IHl9mjDawHxVK9x82RZwDfO7QSP8zV+dZi1Om69s2n2ZZnJcYq4NTbUuCmWvPrxGbVwG
         ZwR6NZhGBhILgTSAvY2NFe5bvAuukqHjfC1iSgBEECDNJIcjm1MlmyXBIAP1HWuxSPvo
         tbbc3eASP8b2QwyDomWpYjw7j/QASX8YhHaZPqYn/zxwc8+EqqPNLjQ+vm+sZ706MHhp
         KDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792464459; x=1793069259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QXaPhUMmKeWG8DuIUSmDwV9SB0ZMGDge3lOsVfysPhg=;
        b=zPkbhqRNOWsieXXSyyNpA+poUC4C3900qs3mo8eZm3efuap8VRd6pTwQM6JGXCWHjL
         Q50QVDgvQjkPAVfprlB2mJ5P6SbY3AaMRKXYxiHzKxIoPF/p3qQjJUlbROnDVKQKg2AH
         CUSLDgDxiRQlp4NcFZGUy+PXysOpQ5QYalfpTsPX9DXwy/yfqJTOhi3waBA2QHtSL/rK
         /zO+2SwmTsa/95rtlsbRRCfMxt1ZG/pKIxHwS1CFyxUR7YudnG/7f0++/SJ5lVLhdcSz
         DKbzKmu7SFEzIbDT3qoWFxeg/ROkbCuvlJ2NQcmbn6IT5ls+5OGuRz8wwd7WEsmvc8TT
         H4NQ==
X-Forwarded-Encrypted: i=1; AKwUvBxLNSaxQj90AGOTuV8uRG3wp9/PRFI0+bRTWkAOCbvtRpvy1mwbKp/QP6uE/bAKVgfRqBROvcw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHRO3lwwGA1IqoxvIiG7Xzap4yn7IhAC55PY6QkYkdGDyqyvK9
	OUAX8hoYRWXAr5ioSZFO/UtCCPcktxD9dHH/5YZDy2qL7fXjHM9wJSXP
X-Gm-Gg: AYBFou3VQTjaNDZclyvcpp1mFBYsQqFqS1Umr66I+RCt2dCTEirJyrjASmgHoWam2qb
	dRsXgrypZLvrtdOGo/Y0/AtkKNHYSqulGGj5PtHgRh/I/T706aziWb1lGT6asU5RgkPDu+i42P6
	WujfJn76N1PSDIoKKFXSQBi/dfKxrTEllQlO3FT3jGFlVCWCuyYwVcw0+cxTo50QVmFKQv+ItZq
	wPChvoDsUnlvOasjAXnTnWV6HnJc6zeXY9PCNeSV2r/17I2ElsMSpIeArjaZ0pwWq1pbu00Yjzk
	k9xspRx6K8wxUhSNvdRTVrr0l4Bh3/KmE4BuwWsSKDWGvkfwDPTilOtBY+8TYE/mGKDGAt0xoFl
	xqRjtLsFf7EFydFwtJxXBRVQFgEoGTwscCifKKFQdTXi+f0rVtsYcIp4BbBNccQpqbXqIMN5nl7
	qsGxWBhu2VfypT07KHTsPpBkVNYcKND/1F+JBdMVt3tW4GCPxazC9xlqyVSxYb1H6S19VC5iN2S
	w03zluOfOcsB1NXpRcE0o5/jTCprElVB4WfDaxCtJ2LpkVN9//20n3KLlT7/wONRTU=
X-Received: by 2002:a05:6a20:a127:b0:3e1:1e2d:88d2 with SMTP id adf61e73a8af0-3e2660baef7mr1856048637.70.1792464458360;
        Mon, 19 Oct 2026 19:47:38 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654a33681sm4580970a12.29.2026.10.19.19.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 19:47:37 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	mark@fasheh.com,
	ocfs2-devel@lists.linux.dev
Cc: r772577952@gmail.com,
	heming.zhao@suse.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] ocfs2: validate the block count of a local quota file
Date: Tue, 20 Oct 2026 10:46:50 +0800
Message-ID: <20261020024651.3217554-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Every ocfs2 node keeps a local quota file made of chunks.  A chunk is a
header block, whose bitmap marks the entries in use, followed by up to
ol_chunk_blocks() blocks of entries, and only the last chunk may be
partly filled.  The file header records the number of chunks in
dqi_chunks and the number of blocks in dqi_blocks.  When no chunk has a
free entry, ocfs2_extend_local_quota_file() works out from dqi_blocks
how many entry blocks the last chunk already has, and puts the new entry
right after them:

	chunk_blocks = oinfo->dqi_blocks -
			ol_quota_chunk_block(sb, chunk->qc_num) - 1;
	...
	*offset = chunk_blocks * epb;

olq_alloc_dquot() then sets that bit in the chunk's bitmap, which fits
in a single block.  This is only safe while chunk_blocks is at most
ol_chunk_blocks().

ocfs2_local_read_info() reads dqi_chunks and dqi_blocks from disk at
mount time and never checks that they agree.  With one chunk and a
dqi_blocks of a few thousand, the last chunk appears to hold thousands
of entry blocks, and the bit lands kilobytes past the end of the bitmap.
A dqi_blocks below the last chunk's header block makes chunk_blocks, an
unsigned int, wrap around to the same effect.  dqi_blocks is not checked
against the file size either, and a dqi_blocks past the end of the file
can make the kernel write the new block of the file to block 0 of the
device.

The stray bit write corrupts unrelated kernel memory.  KASAN calls it a
use-after-free only because the page it hits happens to be free; nothing
in ocfs2 was freed.  The second case overwrites block 0 of the device.
Triggering either issue requires mounting a crafted image with quotas
enabled, which needs CAP_SYS_ADMIN, and creating a file.  The first
issue was found by fuzzing and has not been seen in production; the
reproducer can be found in the linked report.

Check in ocfs2_local_read_info() that the last chunk has its header
block and at most ol_chunk_blocks() entry blocks, and that a file
without chunks holds only its info block, since the first new chunk is
placed at block dqi_blocks.  Also check that dqi_blocks does not exceed
the file size.  Refuse the file with ocfs2_error() otherwise, as
ocfs2_read_quota_block() does for a corrupted quota file.  The header
block of the last chunk is computed in 64 bits because a crafted
dqi_chunks can wrap ol_quota_chunk_block().

Fixes: 9e33d69f553a ("ocfs2: Implementation of local and global quota file handling")
Closes: https://lore.kernel.org/lkml/CANypQFbjcxXjiigMCCyErN=DSEh3ZG3NMWRpq=Hic8KJ76cwew@mail.gmail.com/
Cc: stable@vger.kernel.org
Assisted-by: Claude Code:claude-opus-5-5
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
Changes in v2:
- Reject a dqi_blocks larger than the file size.  Suggested by the
  Sashiko review of v1.
- Print i_size in the error message.
- v1: https://lore.kernel.org/lkml/20261019154732.3149351-1-r772577952@gmail.com/

 fs/ocfs2/quota_local.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index f55810c59b1b..f3eb366f8fae 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -678,6 +678,39 @@ int ocfs2_finish_quota_recovery(struct ocfs2_super *osb,
 	return status;
 }
 
+/* Check dqi_blocks against dqi_chunks and the size of the local quota file */
+static int ocfs2_local_check_info(struct super_block *sb, struct inode *lqinode,
+				  struct ocfs2_mem_dqinfo *oinfo)
+{
+	u64 hdr_blk;
+
+	/*
+	 * i_size is grown before dqi_blocks, so the file may have more blocks
+	 * than dqi_blocks, but should not have fewer.
+	 */
+	if (oinfo->dqi_blocks > (i_size_read(lqinode) >> sb->s_blocksize_bits))
+		goto corrupted;
+
+	if (!oinfo->dqi_chunks) {
+		if (oinfo->dqi_blocks == ol_quota_chunk_block(sb, 0))
+			return 0;
+	} else {
+		/* Same as ol_quota_chunk_block(), but in 64 bits */
+		hdr_blk = 1 + (u64)(ol_chunk_blocks(sb) + 1) *
+			      (oinfo->dqi_chunks - 1);
+		if (oinfo->dqi_blocks > hdr_blk &&
+		    oinfo->dqi_blocks - hdr_blk - 1 <= ol_chunk_blocks(sb))
+			return 0;
+	}
+
+corrupted:
+	return ocfs2_error(sb,
+			   "corrupted local quota file %llu (chunks=%u blocks=%u size=%lld)\n",
+			   (u64)OCFS2_I(lqinode)->ip_blkno,
+			   oinfo->dqi_chunks, oinfo->dqi_blocks,
+			   i_size_read(lqinode));
+}
+
 /* Read information header from quota file */
 static int ocfs2_local_read_info(struct super_block *sb, int type)
 {
@@ -733,6 +766,10 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
 	oinfo->dqi_blocks = le32_to_cpu(ldinfo->dqi_blocks);
 	oinfo->dqi_libh = bh;
 
+	status = ocfs2_local_check_info(sb, lqinode, oinfo);
+	if (status)
+		goto out_err;
+
 	/* We crashed when using local quota file? */
 	if (!(oinfo->dqi_flags & OLQF_CLEAN)) {
 		rec = OCFS2_SB(sb)->quota_rec;
