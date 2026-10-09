Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0F43AFCE5
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 04:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791521241; cv=none; b=P1h4ApZQwSXZB8WDVay+nGAuIudDKmg3glNyk/fGkXj+N5PpZKUGLcAUDmiIHne23IGHR3dRFLa4qcZhxLAPOSpaDnBujCGHVMPxQEEewG1yUdebDwqJGpil+CgjEfyqq8BbjnQAg04EOKpk+bpL889NPSQykdxiX2ElIJkPuQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791521241; c=relaxed/simple;
	bh=L1saLHbBDlhwh2dYd8IVRuZXsAjOA/gPjL4RZrhZkXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nnI5w4qA+yOUFJCoHp7t2XNUb5JbdJARMfozUZ4uNnJAUCYQwUFwyjmKfbstJeRhSXunwHd2Z/wT/k+GT4V6iZCAP1YPN2yGxnB9spyk157BrU14pDflkeZXbjN2M4ZhenvWUcUWaSiW4du0urgVUVZnqy4dNUWsvyAQD8/lUaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=JxljPbdu; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="JxljPbdu"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93e706a6ba9so450603285a.2
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 21:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1791521235; x=1792126035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iwfGogYRFIyzaf6fWKpsQX0/XPwp5O/xWsEk6hWT+9o=;
        b=JxljPbdum9RdTb0AMPdkUoU2h69jbiK+j5szqdoGScw5E2vAP3DUzXn4nCkYJquakt
         IuXikEQLYQWwXJ2OcSCJ6foe7N+UzbF0zUqZA+UQTMaqKx6j88Gxh9PrzbOMGlAtEON8
         PbUqQYcDfn97Xiu9qeyW+LkLf/SmaEDSfLQdVh/NuPtQApQU5+oOuA6NhfcyeT+zNsVd
         t0Waf66oWPz4fHUNySnTGLk/owWjjO3uLLfyPqjYQuMBsQgXSEF6IZdervB8QwpdheJD
         SgdNDOg/GFVUigQxB8wrbIyheqyWbBKgi8X1HaiQMbLFjv7z1FfEIOWBjgOizTNA9kDf
         Fntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791521235; x=1792126035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iwfGogYRFIyzaf6fWKpsQX0/XPwp5O/xWsEk6hWT+9o=;
        b=ycBvm500OY3A996HEp3CQfOwoJv7wZKgViwL4yu3b4sbRl6rHue87YVGR0Zpj21VeQ
         EjX+Uh9IJtORt7M3DJfcV+F0ZidESNVWQfrLgYBizBQMnrI4/NwLqRCSfWB88O/P0Ewx
         DgahSAVu5jWsK8sEFC1BaXatNYP5JelYIwZ4efsCg1iQKBrGVSsh8FOaNd8DMhMR/wQg
         7U9k6erDQkZSTjoQcZDDr5Zuwk9wYIOTh82ghF2Mx4m6bsntnzLRa8XwI2Qn5/fBoR3p
         rDJlF4FqiR7Zv7fMkXGIXxHY5745AebaNuzAqmXJgAx0jdJiCIPNMJgb6azsbRI7ONti
         M9nw==
X-Forwarded-Encrypted: i=1; AKwUvByKDCpIUF9hyRlftfo1KwMEmM5020GNnjf4pVkHPSBt+OjwfXZvN5j6ybgUSQGTshirEtt82uU=@vger.kernel.org
X-Gm-Message-State: AFuF++mkAJb2axkNUYOthrDVFWl0o50wLA4AhrB/2UACEalgelSzjliY
	1juZAbockfMjddASsud8Uj6pg5exbgM03tZOqRqEw0xYpqBX1L3E+5oF+WDtS4GJVQ==
X-Gm-Gg: AYBFou1oJNQFz7ewXDW4OS0zVa+Ccz2f2hJ1in4dOXv6C4JcvFARsgWhcq5sRPziGIX
	JtReSEH7+tm7t2NOttbO/0sEED/XCXdMvnHmC0zMRy2Z7HbAhVfu2Oh95m1jOLTCYXEFc7dWaRO
	5UnWMtQC9xeZFbdmUaO6pGArZbDFbX7A0H8n/m9fv4eljEw7wsMWT42KNsTYl6Fs3d5moVwZZwK
	NrpBrXkpQyi8ldkyoXBYiEKlUUJTxU+L+vdipdIXVSntPbeRE/fCWwUEjky6Z/q1pPSRw5M0E2Q
	+ZckCZLf120cJIRjGD+tniSw91nywGK2QOLwnANecbJqoScJR6v8JqndtmQhGuo6/anHEx4rshh
	NSuWLhH0A/c38WrM4Yt6WezvHL8wr1J/6BjExoDchQNpT1jVds0rDYE7L/upqwh1QjRVIixoO9D
	B4LHTmbnmV7n2C6D+iEZnHWjC02sM6RFoslB+3tedyaIhCUmsLcG14aK1bRoQsUutLvm8MdND+V
	9LyhxpFiQTD3bJ3yf7E0Q==
X-Received: by 2002:a05:620a:460d:b0:93e:4ede:8976 with SMTP id af79cd13be357-93ebd224c25mr109453085a.26.1791521234940;
        Thu, 08 Oct 2026 21:47:14 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b5501f2e3sm8804606d6.8.2026.10.08.21.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 21:47:14 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: tytso@mit.edu,
	linux-ext4@vger.kernel.org
Cc: adilger.kernel@dilger.ca,
	libaokun@linux.alibaba.com,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	dave.hansen@linux.intel.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ext4: do not advance i_size on a buffered write that copied nothing
Date: Fri,  9 Oct 2026 00:46:56 -0400
Message-ID: <20261009044656.1993196-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 665575cff098 ("filemap: move prefaulting out of hot write path")
made generic_perform_write() call ->write_begin() and ->write_end()
before it finds out that the source buffer cannot be read.  In that
case ->write_end() is called with copied == 0.

However, ext4_write_end(), ext4_journalled_write_end() and
ext4_da_do_write_end() set i_size to pos + copied without checking
copied.  As of now, a buffered write() past EOF that fails with EFAULT
grows the file to the write offset, and the new size can reach the
disk.

The issue can be reproduced on an ext4 mount with:

    char *p = mmap(NULL, 4096, PROT_NONE,
                   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    int fd = open("/mnt/ext4/file", O_CREAT | O_TRUNC | O_RDWR, 0600);
    pwrite(fd, p, 4096, 1024 * 1024);   /* fails with EFAULT */
    fstat(fd, &st);

Before that commit, the result is st_size = 0.
After it, the result is st_size = 1048576.

This patch will leave i_size alone when nothing was copied, as
ext4_write_inline_data_end() already does.  The delalloc path does not
trim after a short write, so in this case it also has to drop the
folio and the delayed blocks that ->write_begin() set up past i_size.
Otherwise that folio stays dirty past EOF and writeback never cleans
it.

Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
 fs/ext4/inode.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 26f0f9714f03..36e75c89b8c8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1452,15 +1452,18 @@ static int ext4_write_end(const struct kiocb *iocb,
 	 * it's important to update i_size while still holding folio lock:
 	 * page writeout could otherwise come in and zero beyond i_size.
 	 *
+	 * If nothing was copied (e.g. the source buffer was unreadable), do
+	 * not move i_size up to pos.
+	 *
 	 * If FS_IOC_ENABLE_VERITY is running on this inode, then Merkle tree
 	 * blocks are being written past EOF, so skip the i_size update.
 	 */
-	if (!verity)
+	if (copied && !verity)
 		i_size_changed = ext4_update_inode_size(inode, pos + copied);
 	folio_unlock(folio);
 	folio_put(folio);
 
-	if (old_size < pos && !verity)
+	if (copied && old_size < pos && !verity)
 		pagecache_isize_extended(inode, old_size, pos);
 
 	/*
@@ -1571,13 +1574,13 @@ static int ext4_journalled_write_end(const struct kiocb *iocb,
 		if (!partial)
 			folio_mark_uptodate(folio);
 	}
-	if (!verity)
+	if (copied && !verity)
 		size_changed = ext4_update_inode_size(inode, pos + copied);
 	EXT4_I(inode)->i_datasync_tid = handle->h_transaction->t_tid;
 	folio_unlock(folio);
 	folio_put(folio);
 
-	if (old_size < pos && !verity)
+	if (copied && old_size < pos && !verity)
 		pagecache_isize_extended(inode, old_size, pos);
 
 	if (size_changed) {
@@ -3210,6 +3213,24 @@ static int ext4_da_should_update_i_disksize(struct folio *folio,
 	return 1;
 }
 
+/*
+ * Delalloc counterpart of ext4_truncate_failed_write(): ->write_begin() only
+ * reserved delayed blocks, so drop the page cache and the delayed extents
+ * beyond i_size and leave the blocks that are allocated there alone.
+ */
+static void ext4_da_truncate_failed_write(struct inode *inode)
+{
+	struct address_space *mapping = inode->i_mapping;
+	ext4_lblk_t lblk = EXT4_B_TO_LBLK(inode, inode->i_size);
+
+	filemap_invalidate_lock(mapping);
+	truncate_inode_pages(mapping, inode->i_size);
+	down_write(&EXT4_I(inode)->i_data_sem);
+	ext4_es_remove_extent(inode, lblk, EXT_MAX_BLOCKS - lblk);
+	up_write(&EXT4_I(inode)->i_data_sem);
+	filemap_invalidate_unlock(mapping);
+}
+
 static int ext4_da_do_write_end(struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
 			struct folio *folio)
@@ -3247,12 +3268,12 @@ static int ext4_da_do_write_end(struct address_space *mapping,
 	 * checked, we need to update i_disksize here as certain
 	 * ext4_writepages() paths not allocating blocks and update i_disksize.
 	 */
-	if (new_i_size > inode->i_size) {
+	if (copied && new_i_size > inode->i_size) {
 		unsigned long end;
 
 		i_size_write(inode, new_i_size);
 		end = offset_in_folio(folio, new_i_size - 1);
-		if (copied && ext4_da_should_update_i_disksize(folio, end)) {
+		if (ext4_da_should_update_i_disksize(folio, end)) {
 			ext4_update_i_disksize(inode, new_i_size);
 			disksize_changed = true;
 		}
@@ -3261,9 +3282,16 @@ static int ext4_da_do_write_end(struct address_space *mapping,
 	folio_unlock(folio);
 	folio_put(folio);
 
-	if (pos > old_size)
+	if (copied && pos > old_size)
 		pagecache_isize_extended(inode, old_size, pos);
 
+	/*
+	 * A write past i_size that copied nothing leaves i_size alone, so
+	 * trim what ->write_begin() set up beyond it.
+	 */
+	if (!copied && pos > old_size)
+		ext4_da_truncate_failed_write(inode);
+
 	if (!disksize_changed)
 		return copied;
 
-- 
2.53.0

