Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BC13BCD09
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 22:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217594; cv=none; b=QIJKhJwR8Z0NkdtyCsPjLk7r0TZUEXRcTi/fZi2UAh53d3UhtQxgSbB22CAwmWwMWgkzxlMi3FhokdQb6v2SONCnu+ZeGOI1VGmV5HIP0OwR5GOFOjCBbBJLE+v+CkEdgidZnZa0kOSPlEQGUYAnOBzteidFA0a+p2/T1i6eeCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217594; c=relaxed/simple;
	bh=gsMzBOaJyRU1/Ca0SCSplUiou7aCZpmxsBDYp3KeRXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kD3iW0Qe3ooN/+AyOHlQerqWpKD7XLfc20KcTJPuTtCYhmpzj36KJPZzo4gFkcDEI09adiRVUkvvjGIUyGMKu/ywhCHbY+ws/T0Z0RmGsV7QqECi9P8Jlq5bTMBWqZ0o8WtXvalrn6zPGL0a5Lhp32WUvGlxmPYRqq1c335s2Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=asCtrLpD; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="asCtrLpD"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-91578c374ecso31141685a.3
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 15:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1781217590; x=1781822390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dQPZpOEgrPteE6UqsW+CtGgkjUVsZvUAQVIa+dsvrmc=;
        b=asCtrLpDU+dRqGUFxRS0PFUhNjCB+4FCSbfjq+sXtSakb0q/F55VU0YhEX/K3MsrDc
         4MNRkdqzKN3dpbVlJcdWWaqMLcvNoRwnCzNh/GwLcncBg0JCtiSyugaQlNhXg8Wzzlkm
         5AWRcXlzgel58Oq/Zvg4M8QQJrHcqjEL25zcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781217590; x=1781822390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQPZpOEgrPteE6UqsW+CtGgkjUVsZvUAQVIa+dsvrmc=;
        b=cKmKTXABRYEKFEYX8Z38MLZHM4+HzC1KA7Otsx7dl2eTqjrPh7T5gP+19QcQ/T1K/m
         eHmY3Coick0sRDcE3Rk/mvO7mgu2mPX/BKt0kN46TohJuI7SZ0VtE8QiWFk8m8Lgrqe1
         ou/WGez66sBWrBniCrL/Ax30ZS8vRzfgLYph6Cik65iyKH8grrBTrdZjiCddlvKXauRG
         DK6TYqZ0xHv+/jHZ4pLX2WILxogwG9T+G/alDhKf8joGmxgO0467mVeSJo74nT1C+xAN
         sQvYHiNZvrOduYXIAkU972QVGne3fBaBLhPEvbRMf06Wjsm39bEFgRabKDdr969PsVNP
         dhTg==
X-Gm-Message-State: AOJu0YynyRAlspV4/roaT+LoiSKhybi1Y4auyqs05YPzyInvcGb88wFB
	CzFZ6PvpSuUKLZjzGwp/fAkjE/p1GJdzN7CzeTo4FvsYTwbEduOERQ5QNhXbQYP43K9dA89sWAD
	Rbxc1D/w=
X-Gm-Gg: Acq92OFzEJ6wUxg76l0hElVYXEmJWDce7sqMnkT90RTg+2z5SZ/CNBcA6iZyLZYTt3v
	/4fj2yfaqKjX8EJ2km1M3j9QV5oTMW4e7OVwNQJVc0JB4zkwE2xiidPRTpXRMA2F/sHp/KheLcZ
	kJKpLnDZOfEFMh2RFPaPeFCkH3VrQXWpEWf2d49WG7x00DrM37/L1Z1QgiiKM3a0j/SUzycWrPj
	pzXRToC9PAq3hmQVa+nayohRQla3mqjumQFAkMwJFJDlZuFc6a7dorW1ym8F4yGLGQIxyCd4in9
	r2xVBvV+nFpagISpDn42wZwcn2PEwuAuQQZdUrLBTLuM36JkUlPNjUxzktyIRWgiG+J+cPkbVHZ
	o3KGqpErRWoL0j0+x60o5mnQeC+H/bQMWBeZuRUjGNoTaOPPFGH6QuxfoX8dCXDl3Phd9lO2/wu
	LGkr85c/ckR+EkM8eyDxA8ROkh2ds7XAkEJCHXHTEMg9oNcKoBQnKHgqBSR7grIeQYVRDQ1LVOF
	uCjyqt+BV/xr07+NgZJytCDyRtluLWRj1nNYtdUlm2R2Q==
X-Received: by 2002:a05:620a:272a:b0:914:b65f:6b00 with SMTP id af79cd13be357-9161bac4e82mr10390985a.6.1781217589592;
        Thu, 11 Jun 2026 15:39:49 -0700 (PDT)
Received: from com-75606.node.ndb.openai.org ([209.249.37.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f05fe7sm45998785a.12.2026.06.11.15.39.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 15:39:49 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: stable@vger.kernel.org
Cc: outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH 6.12.y] reiserfs: reject direct items that span block buffers
Date: Thu, 11 Jun 2026 15:39:44 -0700
Message-ID: <20260611223944.74106-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Direct-item read, writeback, and tail-conversion paths assume that
the direct item bytes selected for one logical block fit in the mapped
page or block buffer. A crafted filesystem image can chain direct items
so a read starts near the end of a page and then copies the next direct
item past the page-cache page.

Track the remaining mapped-buffer bytes in the read and writeback paths,
and reject direct-to-indirect conversion when a direct item or accumulated
tail would cross the target block. Treat this as malformed metadata and
fail with -EIO instead of copying outside the mapped buffer.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 fs/reiserfs/inode.c           | 25 +++++++++++++++++++++++--
 fs/reiserfs/tail_conversion.c |  9 +++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index d39ee5f..d091664 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -296,6 +296,7 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
 	int result;
 	int done = 0;
 	unsigned long offset;
+	int bytes_left;
 
 	/* prepare the key to look for the 'block'-th block of file */
 	make_cpu_key(&key, inode,
@@ -392,7 +393,10 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
 	 */
 	p = (char *)kmap(bh_result->b_page);
 	p += offset;
-	memset(p, 0, inode->i_sb->s_blocksize);
+	bytes_left = min_t(unsigned int, bh_result->b_size,
+			   inode->i_sb->s_blocksize);
+	bytes_left = min_t(unsigned int, bytes_left, PAGE_SIZE - offset);
+	memset(p, 0, bytes_left);
 	do {
 		if (!is_direct_le_ih(ih)) {
 			BUG();
@@ -413,12 +417,19 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
 		} else {
 			chars = ih_item_len(ih) - path.pos_in_item;
 		}
+		if (chars <= 0 || chars > bytes_left) {
+			result = IO_ERROR;
+			break;
+		}
 		memcpy(p, ih_item_body(bh, ih) + path.pos_in_item, chars);
+		bytes_left -= chars;
 
 		if (done)
 			break;
 
 		p += chars;
+		if (!bytes_left)
+			break;
 
 		/*
 		 * we done, if read direct item is not the last item of
@@ -2363,6 +2374,7 @@ static int map_block_for_writepage(struct inode *inode,
 	int bytes_copied = 0;
 	int copy_size;
 	int trans_running = 0;
+	int bytes_left;
 
 	/*
 	 * catch places below that try to log something without
@@ -2375,6 +2387,10 @@ static int map_block_for_writepage(struct inode *inode,
 	}
 
 	kmap(bh_result->b_page);
+	bytes_left = min_t(unsigned int, bh_result->b_size,
+			   inode->i_sb->s_blocksize);
+	bytes_left = min_t(unsigned int, bytes_left,
+			   PAGE_SIZE - ((byte_offset - 1) & (PAGE_SIZE - 1)));
 start_over:
 	reiserfs_write_lock(inode->i_sb);
 	make_cpu_key(&key, inode, byte_offset, TYPE_ANY, 3);
@@ -2409,6 +2425,11 @@ research:
 		p = page_address(bh_result->b_page);
 		p += (byte_offset - 1) & (PAGE_SIZE - 1);
 		copy_size = ih_item_len(ih) - pos_in_item;
+		if (copy_size <= 0 || bytes_copied >= bytes_left ||
+		    copy_size > bytes_left - bytes_copied) {
+			retval = -EIO;
+			goto out;
+		}
 
 		fs_gen = get_generation(inode->i_sb);
 		copy_item_head(&tmp_ih, ih);
@@ -2444,7 +2465,7 @@ research:
 		set_block_dev_mapped(bh_result, 0, inode);
 
 		/* are there still bytes left? */
-		if (bytes_copied < bh_result->b_size &&
+		if (bytes_copied < bytes_left &&
 		    (byte_offset + bytes_copied) < inode->i_size) {
 			set_cpu_key_k_offset(&key,
 					     cpu_key_k_offset(&key) +
diff --git a/fs/reiserfs/tail_conversion.c b/fs/reiserfs/tail_conversion.c
index 2cec61a..cf11ec0 100644
--- a/fs/reiserfs/tail_conversion.c
+++ b/fs/reiserfs/tail_conversion.c
@@ -122,6 +122,15 @@ int direct2indirect(struct reiserfs_transaction_handle *th, struct inode *inode,
 		       &end_key, p_le_ih);
 		tail_size = (le_ih_k_offset(p_le_ih) & (blk_size - 1))
 		    + ih_item_len(p_le_ih) - 1;
+		if (tail_size > blk_size ||
+		    total_tail > blk_size ||
+		    ih_item_len(p_le_ih) > blk_size - total_tail) {
+			reiserfs_error(sb, "PAP-14060",
+				       "direct item %h for inode %lu spans block",
+				       p_le_ih, inode->i_ino);
+			pathrelse(path);
+			return -EIO;
+		}
 
 		/*
 		 * we only send the unbh pointer if the buffer is not
-- 
2.54.0

