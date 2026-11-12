Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452902;
	b=EPIh0EAvU/XXqp5oKLc24qBLuh+Es9MvF4CnlQyNhC7SrIl3AA5ydFHl+meB3lfiqcEb
	 aoyP+408teHT6judO3BxGXn9wUMe8n33A5S1jxkva0lPhraQ5clLu2CR5jWl++sIxKoMW
	 L+nB5n8cpZ3t8JoBb6siaWYqfdyV+SSUKCC/H/HumClcnZe0j01xDhmpVb1z0c+vVf+L2
	 xSPHA40MSAfhx0627p7strDxlZi5lBQRmWbIUMPLK7rRTqCEPNMTX9XSF73DC1v26Ts5e
	 q2pjO0TdFK0cOGXICrvS7s//KSULqLG8M39EWbwZ57B8LVaQgbLok3rRhQqt3cyKP2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UeXaSvr4SrCTOf1iO2sie7UdIT4yjGWoYerMUs70xPo=;
	b=UL8JCj7A3ht6k9tlbHsHPrskZ5ehjcGRIMeN3kXxcrxsaxhe5SWKUDFsKoPLk55Om+9c
	 8RlzXLbt6LiBBibPSnCHWqZKBLIklq69SPLzMBOBOcYCAwSeUy2T+lOdebxfnVHw52jAq
	 q59s9rl+j4UGaUlM2YirBUrqEC2no4N/o0nP/GwOEhRy8pjIklDkM1BLmhEUNLBg+pGvg
	 FD0W7pH9LgiuXnAglSCRTT5LWkHlAAZ/VEvsLn0e3k42PLKiuJGP0zmP7jX7vfaEYEvF+
	 bFy/tTusAg4yMuNuKOPsRJ25Fbj4QvzjOlyu63v8XLOMvLQK09FUXDt9e7gbVF9jenA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vdpjTSsd;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B40606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03B40606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vdpjTSsd
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36dbde64409so7656201eec.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794452901; x=1795057701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UeXaSvr4SrCTOf1iO2sie7UdIT4yjGWoYerMUs70xPo=;
        b=vdpjTSsdvfq0rjq3o32YqhchwDrQfUeCgA3g/VNqySe5KDnAFreNsIcdqOJpTogRZi
         PtXQimxXqJpjJzolRRmrW0AGtrxeWj4cpWBAmcmEwp59qoWHtFbUtXyo6+CS3PoRt+CK
         PQ1IED9andLLO9c6xRInaU47xKN+8CEY1Q0SoJ90cngYFEUZlvaVXXm1Z9RE59kI4vox
         amu9A2THiD/UO+CwKIPmhsq9Z/nT7bRmk9piwzUScRWXVvCdW1K58Z7NM4R2k0jSM2pn
         YmlmukTdCxrMjqkZV94GPO4c5TCFzCQcSiKdjOTpqVBaKzS62rQzMZc/OACLobQW6HnD
         dkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794452901; x=1795057701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UeXaSvr4SrCTOf1iO2sie7UdIT4yjGWoYerMUs70xPo=;
        b=tfTD8K57ChiEwYSeluS5thW7+2U7TOgzWktOd6Tsl5TJnV4eEhTcJ7QzJEypzfa5GY
         X8S3OJ6s4goE41Ub/uxCUYEocQNtjCW7BSd9V84VnMkr0MirbkzbypUiiKsYz29LAW5J
         cvkIHMYcn7t6Tab4XfMrX/wEnR+jKercvX+Nvjwt00aWZc90pP7lpDa66nQstJ9iQNjt
         iJs9JHnvnygypV9RltAxFN5fWKgF349rYkqX6wjTTJuoPuocZNxlJ1ONGNC1ieNZ1s5D
         Wrp19Be39zuZ2uUGU82PiNE8eLHQ0WQ8HxknyFdaggfn8rUthp6e8Zjtw1saFBLNNndq
         ybgA==
X-Forwarded-Encrypted: i=1; AL+hErGLxcdrZyZHUnSWA4m29RPo+qUgPD6Ar/35ZHknrO0B/6hfw4OH0Nc71nYu9b+/3+y5GG7Tqfk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9MF1uYpCh6hMt2SmxYy3g610P0rkKRT3pv+ydFItcmOiayS08Z
	9OW0W0ivxbctA0R1cg1pgu0lQqF+6DuGx+hT3Xyn6ojNNiv5N6QeZS2X
X-Gm-Gg: AYBFou1+salt8/PfHQWKSK09PF4HOPPHXF5m/bD43i6WTEK4q58djqMbKON1gZrMzOy
	t5MUp+I2ce0m4XUWX/F6fJE9hWq27VX4DPVh1x8ETWGU69kydFCvB/Isuc5GD8n72yFU0JcsTDC
	+eg7xKcam7wu52zznm1JajkNush+tq2PASqoGSOpnBU4dJqfZFb5sz4EhzHwB43qLUaxJO+COB+
	XnVqauJNPD9ZqOhzq9Y5Z8lQGDsUi7wU+yfOTAVJ1uBklUomZ1i4Zbl8hMoMTCostx2iMAESzZz
	/2qabSyIze92bjh3n8U6Q1uy9r0mwBxncuMTRJsp/1sHmleoOZ9Ev2rRf45Yv9ejDwfF/72A1Kb
	VXbTiWFY8fQtkD6cXisYtmzukGqjCvVOtjEcYRaAqPmIwG1AlE5rKmvBHfzhIrj01ky/AMYcyIw
	XIIkqLJv6tRbflRsCHKzoVTNKCHsrerzRyPhflZYC/o3UYWZffH51ja11+G+2WWy1XxI0TuzgXL
	M5y7e0wd5hHopqvMOHhdA8hbCoyDLH/qNNTpcWDVZR2kEddK/gqWPu9NSu3U/lzeC0c8+UBh/Iv
	7Q0bkXVFaR6r0uNBA1ALfB09VO3qAiQKxnlGg5nymT5kOw==
X-Received: by 2002:a05:7300:6dac:b0:369:f9da:a70f with SMTP id 5a478bee46e88-37685b7f916mr6937512eec.17.1794452900796;
        Wed, 11 Nov 2026 19:08:20 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm20406158eec.11.2026.11.11.19.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 19:08:20 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: liubaolin12138@163.com,
	ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: [PATCH v2] ntfs: trim the sizes after a short write
Date: Thu, 12 Nov 2026 11:08:15 +0800
Message-ID: <20261112030815.982026-1-zhanxusheng1024@gmail.com>
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

Run the existing rollback for a short write as well, and roll the two
sizes back to the end of what was written instead of to the old sizes.
A short copy that ends inside a block can also leave the rest of that
block cached as read from disk, so clear the page cache beyond the new
initialized size before shrinking it.

Fixes: b041ca562526 ("ntfs: update iomap and address space operations")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
v2: also clear the cached tail of the last block, which v1 left in
place when the write stayed inside the old data size (Baolin).

v1: https://lore.kernel.org/all/20261111093459.660484-1-zhanxusheng1024@gmail.com/

Tested in a VM on ntfs-next b025f526c5d0, with all free space filled
with a known pattern first.  Short buffered writes of 4M, old data
readable after drop_caches and after remount, 3 runs each:

                                    unfixed    v1     v2
  fallocated, ends block-aligned    3137536    0      0
  fallocated, ends inside a block   3141332    212    0
  fallocated, unaligned start       3137536    412    0
  append                            3137536    0      0

A short write 1M past EOF, O_DIRECT, resident and compressed files and
full writes give the same results with v2 as with v1.
---
 fs/ntfs/file.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 3213a0c9f96b..1779110a0c4f 100644
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
@@ -940,13 +951,21 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		filemap_invalidate_lock(vi->i_mapping);
 
 		/* ntfs_attr_set_initialized_size() rejects a resident one. */
-		if (ni->initialized_size != old_init_size &&
+		if (ni->initialized_size != new_init_size &&
 		    NInoNonResident(ni)) {
 			struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
 
+			/*
+			 * A short copy can leave the rest of the last block
+			 * cached as read from disk.  Clear what is no longer
+			 * initialized before shrinking the initialized size.
+			 */
+			if (ni->initialized_size > new_init_size)
+				truncate_pagecache_range(vi, new_init_size,
+						ni->initialized_size - 1);
 			mutex_lock(&mrec_ni->mrec_lock);
 			init_err = ntfs_attr_set_initialized_size(ni,
-					old_init_size);
+					new_init_size);
 			mutex_unlock(&mrec_ni->mrec_lock);
 		}
 		/*
@@ -955,13 +974,13 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
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

