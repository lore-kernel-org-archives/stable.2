Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546115;
	b=E2i2HFhHk1Ri1u7ZUzV7f+QSUeUQTGeuojn99wDwd/fbjkmIgG8xgPqZ5YP8VF3bqSAi
	 w5aCi+N+fFQNrVhfbkadjb3G+Oe0XOtUmg5+WH5lAUtg6s+zy2TWttDJ55MnKTVrOyRCg
	 CZ9fSBUtGN1wt5bpQlnSwiWsAtjOe4bOMZzWkViy0cG5Itqxp+NUB8uwLCFEWf+H+Ot6i
	 0AdpjZBu/aEYtHuTsNWXlYPiKTa/rck9+l1bfLkc2cYUc+WUzp3mboid0uu2wsubppr2f
	 HpVqogP+DXmVIdMWLLnu/f7/GU7l2UbrdP0BNRclLrli4KLFqN/hzCRTAhZFdooWpWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ymo7yRI3qo02ZHVhmUVN7yVG+3FBZDE8ll04DLo8nJw=;
	b=BOR2ZATPVx1CLZozuJWMUlOJS7xVAbtHzKq+tnmTSFpK4PqsXIsO257zz9MrJg/JBkVv
	 qFs7+fOJpmjvQaR3I6ml6HIpe2mNTHPQ29UyBz6eITDP/ufNmDGWHeHScGNU1rR+VuSMt
	 S4cYQDGsZB4rBKRYyfINi/xGCCyaRF+218xZU6q76sAfp75UHqN5+1keI+unga4CCydhx
	 i0zYNtOw1prgi+qPBwDiqRjqFJGl8xwvpICcXXKIZmFdnl9cjXTSrGrP87b+0Rmfq+sUb
	 64For9MN0Y93VeZtLXggsbxCC95W+YYBXWBkl/NNTvnG/XjeEevQBfoAFG2fkbwHZ9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QdryjBKn;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB689606A321
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 05:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB689606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QdryjBKn
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3791619605cso1266579eec.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 21:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794546114; x=1795150914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ymo7yRI3qo02ZHVhmUVN7yVG+3FBZDE8ll04DLo8nJw=;
        b=QdryjBKngUj1g0YwAIoSQ3RST/ep9ftJ1ZZcaX1fH9HHWMsmugSTznP0hO2Y0zWc63
         k24XKKBdBEM1Bx7C7WckPuVp25AhDLNM17RVFCb17plJJt6MAUF/u1foJd9PPp9POmp6
         rwduakuZHtQm6fbs9SXjKKU+WGtmPoHRCmrN0SL7sngZcYrMMzpWtSzrNACI6ZxQWoiJ
         RPR30XHiUDAWrtqJbDyCS6MWs3tUJbQJLgendtF6xC5LVIZPQcSlThY4xv/4c/9AT2px
         PI7a9ijdsd5JhLE976lHSlfhn3a+fr+bUeo4ddqX5iOVv8joHBx9Ay8yw+A7+risAczv
         ydag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546114; x=1795150914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ymo7yRI3qo02ZHVhmUVN7yVG+3FBZDE8ll04DLo8nJw=;
        b=2Mt4/kLB2Zd5rOE1p+nFugEzIhLoDarvCGucQnm3QLpQM/jFIXHeLjYZF1i/aRyTWx
         926p9NKWol67T3JcemTSOotHU79zbLe1SWOBWrJM+ndBj+AAKB57xml+r+HBPJLRvp9B
         XY+knY1OSee7IFXR3CYWxxfl1D4lY1g/RgSHaUdqBEf0U+8PCTStV7hhtC4wm0TBZphk
         elFpCkv+zDDXJYkz0NmDir35Tr3EBF+33HhrQ+boAHgkBD7/j07jkhxHExqPubeHVV1V
         XLuSp2SpWnhFi+BPt/pu5VbTCgQC+Gnv06eFAaQGs7hMmjA0DBQXTBm/MT4D9+g5lCyj
         vaSQ==
X-Forwarded-Encrypted: i=1; AL+hErHVLczRNf07tqlb96FIE5WFF5hfQF9BEDYyFaPWibyhI6DZCHZPeSvgOKmnuhzDrSUQEGXIILg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UKAZqDzxMNtpY+OpTeS2SgoBKGS9MkHmf+617ThT+mNlmX+Oi
	imlR2QEYD2xNEbfsWJaWdRQNoFjVNGgDPS8mjJ5vira45viOpMjt0ejt
X-Gm-Gg: AYBFou15UFwO7Z68QD3WwKZHOVlAzj5dJmJHSrk98cLt0CJyTeDKSAO9vpB7b2PeYZE
	TfvFVwmpbQ9AeWQ8sSzZG9mZ541fnGJhFTh/LxlneTLQBIVF6Xbg8AsMCmjLDGWLW7vXfHDfjl6
	g/1S7Efl6WOLhqaf178EO3z9+7JVbQdHnAvHsmkzxi44YhG+YVF5h7X5ioaa84NdqcfkykN56pS
	dt4q2VEDN8i1HIf8xu/316W2kSeIhNwYoUU6s+Sax35mPjDzsjENaD0O9ZrT9m9OMDnoxoMa4Nn
	zKxofrz5ZDyOTokNc8Nniwq16e/ddwTe8B3zjBsobIJ+GmIKRuPiFPEpGlgRuIuUy5RxNArCsoT
	6o7RTdG4426MNt8oDiuLyl+FRhOkO71KrxGZhqJbZzmu1vVJ8O+JvxBk0UF4yvWHrBTl0m/p1RC
	Io2PMAIfu+1QmRf33T8TiBSWJYYlnxSKlP2XpBM7l7/x4r0xAu/k5crEQEN1/rZwt0StbMPpWY2
	KHgZMiglJFXMp00F5KSpWU8v1MOj0odaLgV28JzbalKGlJ0cMcLDIfYZ9SXoEiCbTsQU/TzXEzb
	kjwj4XEf4ZsHv6HSTvNzs7u9Gjf2dI0fo7zLafcWZbnDWg==
X-Received: by 2002:a05:693c:87d7:20b0:35f:8c5d:5928 with SMTP id 5a478bee46e88-37967125e78mr1109039eec.30.1794546113573;
        Thu, 12 Nov 2026 21:01:53 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d07b3sm3157060eec.22.2026.11.12.21.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:01:52 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: liubaolin12138@163.com,
	ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: [PATCH v4] ntfs: trim the sizes after a short write
Date: Fri, 13 Nov 2026 13:01:47 +0800
Message-ID: <20261113050148.1466682-1-zhanxusheng1024@gmail.com>
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

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

ntfs_file_write_iter() moves the data size and, for a non-resident
uncompressed file, the initialized size to pos + count before the copy.
__ntfs_extend_initialized_size() only zeroes [old initialized size, pos),
so the range [pos, pos + count) is initialized only by the copy itself.
When iomap_file_buffered_write() copies less than count, it returns a
positive short count and the error rollback at out: does not run.  The
file keeps the size pos + count, and [pos + ret, pos + count) reads back
whatever the freed clusters held before, also after a remount.  A local
user can read the old contents of freed clusters this way.

Run the existing rollback for a short write as well, and roll the data
size back to the end of what was written.  For a buffered write, keep
the initialized size and zero what the copy did not reach, up to the
end of the block holding pos + count, because a page fault through a
shared mapping may already rely on that initialized size.  A direct
write rolls the initialized size back as before.

Fixes: b041ca562526 ("ntfs: update iomap and address space operations")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
v4: for a buffered write, zero the unwritten range instead of
truncating the page cache and taking the initialized size back, which
dropped data stored through a shared mapping during the copy (Baolin).
v3: clear the cache up to EOF, not up to the extended initialized
size, which left the rest of the block holding pos + count (Baolin).
v2: also clear the cached tail of the last block, which v1 left in
place when the write stayed inside the old data size (Baolin).

v3: https://lore.kernel.org/all/20261112093233.1118469-1-zhanxusheng1024@gmail.com/
v2: https://lore.kernel.org/all/20261112030815.982026-1-zhanxusheng1024@gmail.com/
v1: https://lore.kernel.org/all/20261111093459.660484-1-zhanxusheng1024@gmail.com/

Tested in a VM on ntfs-next b025f526c5d0, with all free space filled
with a known pattern first.  Short buffered writes of 4M, old data
readable after drop_caches and after remount, 3 runs each:

                                    unfixed    v3     v4
  fallocated, ends block-aligned    3137536    0      0
  fallocated, ends inside a block   3141332    0      0
  fallocated, unaligned start       3137536    0      0
  same, pos + count in that page    -          0      0
  append                            3137536    0      0

With the sequence from the v3 review (marker stored through a shared
mapping at 64K while pwritev() at 0 is stalled, short count 8192), the
marker is kept on unfixed and v4 and lost on v3, 3 runs each.  A store
into [pos + ret, pos + count) itself during the copy is zeroed with v4,
as that range belongs to the write.  fsx (buffered, no-mmap, O_DIRECT
and mixed), compressed files, fallocate, insert/collapse range and
punch hole give the same results with v4 as with v3.
---
 fs/ntfs/file.c | 57 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 3213a0c9f96b..5ac11d60be37 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -928,10 +928,21 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		ret = iomap_file_buffered_write(iocb, from, &ntfs_write_iomap_ops,
 				&ntfs_iomap_folio_ops, NULL);
 out:
-	if (ret < 0 && ret != -EIOCBQUEUED) {
+	/*
+	 * Both sizes were moved to end before the copy, so a short write,
+	 * like a failed one, must take back what it did not write.
+	 */
+	if (ret < count && ret != -EIOCBQUEUED) {
+		loff_t new_init_size = old_init_size;
+		loff_t new_data_size = old_data_size;
 		int init_err = 0;
 		int data_err = 0;
 
+		if (ret > 0) {
+			new_init_size = max(old_init_size, pos + ret);
+			new_data_size = max(old_data_size, pos + ret);
+		}
+
 		/*
 		 * Like ntfs_setattr_size(): __ntfs_attr_truncate_vfs()
 		 * expects the invalidate lock held across the size
@@ -939,14 +950,46 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		 */
 		filemap_invalidate_lock(vi->i_mapping);
 
+		/*
+		 * A page fault through a shared mapping may have used the
+		 * extended initialized size while a buffered write was copying,
+		 * so taking it back could drop that data.  Zero what the write
+		 * did not reach instead, including the rest of the block at end
+		 * that the copy may have read from disk, unless such a fault
+		 * already moved the initialized size past end and zeroed it.
+		 */
+		if (!(iocb->ki_flags & IOCB_DIRECT) && NInoNonResident(ni) &&
+		    !NInoCompressed(ni) && ni->initialized_size > new_init_size) {
+			loff_t zend = ni->initialized_size > end ? end :
+				      round_up(end, i_blocksize(vi));
+
+			zend = min(zend, new_data_size);
+			if (zend > new_init_size)
+				init_err = iomap_zero_range(vi, new_init_size,
+						zend - new_init_size, NULL,
+						&ntfs_seek_iomap_ops,
+						&ntfs_iomap_folio_ops, NULL);
+			new_init_size = min(ni->initialized_size, new_data_size);
+		}
+
 		/* ntfs_attr_set_initialized_size() rejects a resident one. */
-		if (ni->initialized_size != old_init_size &&
+		if (!init_err && ni->initialized_size != new_init_size &&
 		    NInoNonResident(ni)) {
 			struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
 
+			/*
+			 * A direct write did not use the page cache; drop what
+			 * a concurrent reader may have cached past the new
+			 * initialized size, as __ntfs_extend_initialized_size()
+			 * does.
+			 */
+			if (iocb->ki_flags & IOCB_DIRECT)
+				truncate_pagecache_range(vi, new_init_size,
+						max_t(loff_t, i_size_read(vi),
+						      ni->initialized_size) - 1);
 			mutex_lock(&mrec_ni->mrec_lock);
 			init_err = ntfs_attr_set_initialized_size(ni,
-					old_init_size);
+					new_init_size);
 			mutex_unlock(&mrec_ni->mrec_lock);
 		}
 		/*
@@ -955,13 +998,13 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		 * the uninitialized tail, so skip it unless the rollback
 		 * above restored that size.
 		 */
-		if (ni->data_size != old_data_size && !init_err) {
+		if (ni->data_size != new_data_size && !init_err) {
 			struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
 
-			truncate_setsize(vi, old_data_size);
+			truncate_setsize(vi, new_data_size);
 			mutex_lock(&mrec_ni->mrec_lock);
-			data_err = __ntfs_attr_truncate_vfs(ni, old_data_size,
-					old_data_size);
+			data_err = __ntfs_attr_truncate_vfs(ni, new_data_size,
+					new_data_size);
 			mutex_unlock(&mrec_ni->mrec_lock);
 			/* Like ntfs_setattr_size(): stay on the durable size. */
 			if (data_err)

base-commit: b025f526c5d04929212c9d5fb7ffc96608f3eacc
-- 
2.43.0

