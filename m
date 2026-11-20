Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795142112;
	b=KZ115cLx4xlzOzvT6hDxsWGaeF4nKH2DMR+MP4sRCDUuOtTIIxtFbngTPPfvsNJRI0ta
	 1QBOBpbkZ4WG0Fl+xYJLZESQUsgawlpQurj/fXHlAKuEIDD4Xe5b4Rl18F0gormAIxyZ3
	 pHolscNBSZiWx4ZzOgyO/Ur6/khWW1WYkLwcIcYNp0G63yk/0hPqTE/E8+aBlfob/+k8h
	 2H5s1j8zi/TW68572J4Ry99uqOYsr+6O+A50AAHRKfSIFSvARybDsF3eZXM6Gk5EFrqH8
	 Xx/oVxNCVEsCN+6hQciPn+nlP9AaIzmnZjzawdNAQiWraxP4CjzLSI3PJVBGBoON8QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795142112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8D8ZB5yQxIaNRwlGKjqxBBOd9kO26aIExfLd52uqAFU=;
	b=3dWPLwBu07V6qRN185ZyY6wdGqVtwn8SmxIu9f1VGrDPL6awsbkTnugPNW1TgBJJD+JG
	 sltN3NNSrbCoBjNBCX5FpsEihOxvm+7B7c2B76fq9f3XxmT3K3XDXVR2Q8pwm+AUlJsop
	 3D3nOQFq+NfTKg8dWisjwCFgW76fku5zrAxG1zTn96TVc56Tt2SRVoaNzomhlkZCtJ5N2
	 SgDrx5QHHaBGcfrhAinw/O6LBYY0p5yeboHvlQuPXqLna1PSHOBajcHSux9Qwhqs5NXr7
	 IYwMuuLjDNev0QerQ3XFaW7vMEPkMLA0wkGOP34MSUX2+IG21j1Acd12IVCUWgdD2Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U1rrXvrW;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B6606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 02:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 313B6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U1rrXvrW
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b40d23e1adso395918a91.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 18:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795142110; x=1795746910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8D8ZB5yQxIaNRwlGKjqxBBOd9kO26aIExfLd52uqAFU=;
        b=U1rrXvrWYcMZX7BB9EoyzILEd6R3asTGPlYVU2Yvi/IZzFpilV9gd4lbD4j2Duvlry
         fZHy7U9kp4jls1y3kq8s0jjGv+YeaUeJvfr/whjRFcJ8qihf2/UWkE7C5qi4PqejDG03
         Vw9b+qlDl/9hy3o33sc5FrdkcnSZ+ZbtwCmxCILKH2apHXZik3wsXC+hjuQUblU2ZAAZ
         DSIdvT1sm6HYGLWG9jbE+Uq6AMaN1GOSJ6PWCTGH7umcgnQbI3g6jn0G9aR5k9oXMpsi
         uIIFf1wC4gkiDN0Amd9qmL80y0fXCZvHHwcvWLN82iVnGmt03U61lcgwcOKPYJEMwsKt
         /lYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795142110; x=1795746910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8D8ZB5yQxIaNRwlGKjqxBBOd9kO26aIExfLd52uqAFU=;
        b=Ex8nhTFyBLlDfk+B7vc6xV0mHwFQdjVgQfZ6XqjBHWoeHDQb172Zo0LLKZDeMHCrN3
         I2e3ldsyqWQysyBEe0QTZpVogiVuSVZ2eoNLKWopN4RYVfjGoFofPu39YNl61L+pzsQ/
         qXrfDMJ0icnrOgzIRoSjY6J8UH3355jxE+RYK6/7/FpOjj7oMlJJHx3NdkLdjnyVYLG5
         85ZyjF68Z4V1xgay4zWLmDzxLTkQgcHCj+QEr6mY2+ZDbTLvjTI6hAMc6Ls9WJfgQOCY
         CJhXBVSb4GNt6buBMxeAyS3V5ypDN6XwXxAsQ5cvabn1VoQiY95I81KkYTErCyvyRIwS
         NlyA==
X-Forwarded-Encrypted: i=1; AL+hErGWx5EZeTbqSRzQGsIXoXNIkR+aExhB7c8QiX7vGEc7umqBbbqnwspHy/y3dy/o1gp0//wnxFs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ehboi5G6ukBlV19XjqKq2fRwgr0OJSAc5AjQ6zi75h02sJOI/
	0X5rgDwcnQsYDk2F8rsfHDlABpJc5uxQBuPnLZKi1zPRPa+s8ruz007R
X-Gm-Gg: AZFdTZcUjKkyngqNOZkZ8LX/YwT33QK7CyNDumzJqzB53mgoLYVlTRs9U2ndOCcASeI
	yT3UsLMYBWT0bI24YPeb9XJ94zUicAuPxkd4oamG+thIWblwdll0NKBISl2xCJTqU0qEpwTKp6L
	ece/42z0S0H/3QzV0BRfIEkMZP69l2owGHsv7Y5WPm9ZeA3yxuXcwjeZs11uulIJu9xYMzEP8PM
	kJ+gXgJ+LbNuu8QXJrBXjYSKRLyXmn8/TVfZd7ptNJEf4rBRFZyy1PWumezNu14RWiRrxYIjkGp
	ir+PnFxIpPDyoRjnznQzjZHkLUTZ43Psjl4vPHLNobgPlo6BgHihQt5iFio9yZGBKcycYIWWX3/
	CaTO8DDGJGmCyi2tvvwQS0q6HNyDsnI3Oux2PRJRAJHXDOVyd7nH6nuKxWNNFWaLPeasMn8U3UH
	OJyes6cMOCuCfcVoz81wFkZ9/qOEH0a5HmVGJ6zTqRiPgCtR0tTQfEZePTILMVLXGsKcjl6p5G+
	zO/myzh63HC4+UiGXcRrglx3KxRYDrdUhoPrYszl1KwgDM00VDBxsAB9FNifKuLQW/AOQ3rtVmY
	CWmwr/28kACQtD1wvKvyXG5W+Al8B4qc0xeAS2aL43g0qw==
X-Received: by 2002:a17:90b:2f8f:b0:3ac:9f24:44be with SMTP id 98e67ed59e1d1-3b41c92a3dbmr1353098a91.29.1795142110314;
        Thu, 19 Nov 2026 18:35:10 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41cfbaf2bsm736019a91.2.2026.11.19.18.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 18:35:09 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: liubaolin12138@163.com,
	ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: [PATCH v8] ntfs: trim the sizes after a short write
Date: Fri, 20 Nov 2026 10:35:04 +0800
Message-ID: <20261120023504.4134966-1-zhanxusheng1024@gmail.com>
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
size back to the end of what was written, keeping the clusters that were
allocated on disk before the write, such as space reserved with
FALLOC_FL_KEEP_SIZE.  Keep the initialized size, as a page fault through
a shared mapping may rely on it while the write is stalled on its
source, and zero what the write did not reach, up to the end of the
block holding pos + count.  Only if that fails, take the initialized
size back to where the zeroing started, if it is above that.

Fixes: b041ca562526 ("ntfs: update iomap and address space operations")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
v8: when taking the data size back without truncating, mark the file
name dirty as ntfs_non_resident_attr_shrink() does.  If the inode was
written while the write waited on its source, the size in the directory
index otherwise stays at the extended value (Baolin).
v7: when taking the data size back, keep the clusters allocated on disk
before the write instead of truncating, which freed space reserved
with FALLOC_FL_KEEP_SIZE; a failed write already did so before this
patch (Hyunchul).  Holes and delayed allocations past the data size,
such as the preallocation of an earlier extending write, are freed as
before.  Baolin's Reviewed-by on v6 is not carried over, as this
changes the data size rollback he reviewed.
v6: cap that fallback at the current initialized size, which a failed
extension before the write can leave below pos (Baolin).
v5 (Baolin):
- start the zeroing at pos, not at the old initialized size, which
  overwrote data stored through a shared mapping below pos
- do the same for a direct write, instead of truncating the page cache
  and taking the initialized size back
- if the zeroing fails, take the initialized size back to where it
  started, instead of skipping both rollbacks
v4: for a buffered write, zero the unwritten range instead of
truncating the page cache and taking the initialized size back, which
dropped data stored through a shared mapping during the copy (Baolin).
v3: clear the cache up to EOF, not up to the extended initialized
size, which left the rest of the block holding pos + count (Baolin).
v2: also clear the cached tail of the last block, which v1 left in
place when the write stayed inside the old data size (Baolin).

v7: https://lore.kernel.org/all/20261119022715.3636699-1-zhanxusheng1024@gmail.com/
v6: https://lore.kernel.org/all/20261117082021.2947603-1-zhanxusheng1024@gmail.com/
v5: https://lore.kernel.org/all/20261116091121.2547497-1-zhanxusheng1024@gmail.com/
v4: https://lore.kernel.org/all/20261113050148.1466682-1-zhanxusheng1024@gmail.com/
v3: https://lore.kernel.org/all/20261112093233.1118469-1-zhanxusheng1024@gmail.com/
v2: https://lore.kernel.org/all/20261112030815.982026-1-zhanxusheng1024@gmail.com/
v1: https://lore.kernel.org/all/20261111093459.660484-1-zhanxusheng1024@gmail.com/

Tested in a VM on ntfs-next 4862a81576e3, with all free space filled
with a known pattern first.  Short buffered writes of 4M, old data
readable after drop_caches and after remount, 3 runs each:

                                    unfixed    v8
  fallocated, ends block-aligned    3137536    0
  fallocated, ends inside a block   3141332    0
  fallocated, unaligned start       3137536    0
  same, pos + count in that page    -          0
  append                            3137536    0

Marker stored through a shared mapping at 64K while pwritev() is
stalled on a userfaultfd source page, state after remount, with and
without fallocate():

                                          unfixed  v8
  buffered 4K at 128K, EFAULT             lost     kept
  O_DIRECT 12K at 0, EFAULT               lost     kept
  buffered 12K at 0, short 8192           kept     kept

1M reserved with FALLOC_FL_KEEP_SIZE, then a 12K write at 0, 512-byte
blocks after remount:

                                          unfixed  v8
  short, 8192 written                     2048     2048
  failed, EFAULT                          0        2048

A short write past 8K reserved this way frees what it allocated beyond
the 8K and keeps the 8K.  A store into [pos + ret, pos + count) itself
during the write is zeroed, as that range belongs to the write.  With
iomap_zero_range() failing (injected -ENOMEM), a 32K write to a 16K
file that returns 12288 leaves the size at 28K with no old data, also
after remount.

In the 8192 case above, with syncfs() while the write waits on its
source, the data size in the directory index after remount is 12288
with v7 and 8192 with v8.

fsx (buffered, no-mmap, O_DIRECT and mixed), compressed files,
fallocate, insert/collapse range and punch hole give the same results
with v8 as with v7.
---
 fs/ntfs/attrib.c |  37 +++++++++++++++
 fs/ntfs/attrib.h |   1 +
 fs/ntfs/file.c   | 121 +++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 151 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 29eae1eb3d02..ccaeb484aaa0 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -2456,6 +2456,43 @@ int ntfs_attr_set_initialized_size(struct ntfs_inode *ni, loff_t new_size)
 	return err;
 }
 
+/*
+ * ntfs_attr_set_data_size - set the data size of a non-resident attribute
+ * without changing its allocation
+ *
+ * The caller holds mrec_lock.  @new_size must not be below the initialized
+ * size or above the allocated size.
+ */
+int ntfs_attr_set_data_size(struct ntfs_inode *ni, loff_t new_size)
+{
+	struct ntfs_attr_search_ctx *ctx;
+	struct ntfs_inode *base_ni = ntfs_base_inode(ni);
+	int err = 0;
+
+	if (!NInoNonResident(ni) || new_size < ni->initialized_size ||
+	    new_size > ni->allocated_size)
+		return -EINVAL;
+
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	if (!ctx)
+		return -ENOMEM;
+
+	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+			       CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (err)
+		goto out_ctx;
+
+	ctx->attr->data.non_resident.data_size = cpu_to_le64(new_size);
+	ni->data_size = new_size;
+	/* Update data size in the index. */
+	if (ni->type == AT_DATA && ni->name == AT_UNNAMED)
+		NInoSetFileNameDirty(ni);
+	mark_mft_record_dirty(ctx->ntfs_ino);
+out_ctx:
+	ntfs_attr_put_search_ctx(ctx);
+	return err;
+}
+
 /*
  * ntfs_make_room_for_attr - make room for an attribute inside an mft record
  * @m:		mft record
diff --git a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
index bee91c9f6f81..edb62826a6ab 100644
--- a/fs/ntfs/attrib.h
+++ b/fs/ntfs/attrib.h
@@ -102,6 +102,7 @@ int ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u32 data_size);
 int ntfs_attr_set(struct ntfs_inode *ni, const s64 ofs, const s64 cnt,
 		const u8 val);
 int ntfs_attr_set_initialized_size(struct ntfs_inode *ni, loff_t new_size);
+int ntfs_attr_set_data_size(struct ntfs_inode *ni, loff_t new_size);
 int ntfs_attr_open(struct ntfs_inode *ni, const __le32 type,
 		__le16 *name, u32 name_len);
 void ntfs_attr_close(struct ntfs_inode *n);
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index a52483d16c6e..25034735d249 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -843,6 +843,34 @@ static int ntfs_expand_for_write(struct ntfs_inode *ni, loff_t end)
 	return err;
 }
 
+/*
+ * End of the last run of clusters allocated on disk.  Holes and delayed
+ * allocations past it, such as the preallocation of an extending write,
+ * do not count.  Falls back to the allocated size if the runlist is not
+ * fully mapped.
+ */
+static loff_t ntfs_allocated_end_on_disk(struct ntfs_inode *ni)
+{
+	loff_t end = ni->allocated_size;
+	ssize_t i;
+
+	down_read(&ni->runlist.lock);
+	if (NInoFullyMapped(ni) && ni->runlist.rl) {
+		end = 0;
+		for (i = ni->runlist.count - 1; i >= 0; i--) {
+			struct runlist_element *rl = &ni->runlist.rl[i];
+
+			if (rl->length && rl->lcn >= 0) {
+				end = ntfs_cluster_to_bytes(ni->vol,
+						rl->vcn + rl->length);
+				break;
+			}
+		}
+	}
+	up_read(&ni->runlist.lock);
+	return end;
+}
+
 ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
@@ -853,7 +881,7 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t count;
 	loff_t pos, end;
 	int err;
-	loff_t old_data_size, old_init_size;
+	loff_t old_data_size, old_init_size, old_alloc_size;
 
 	if (NVolShutdown(vol))
 		return -EIO;
@@ -901,6 +929,10 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	old_data_size = ni->data_size;
 	old_init_size = ni->initialized_size;
+	old_alloc_size = ni->allocated_size;
+	if (NInoNonResident(ni) && !NInoCompressed(ni) &&
+	    old_alloc_size > round_up(old_data_size, vol->cluster_size))
+		old_alloc_size = ntfs_allocated_end_on_disk(ni);
 
 	if (end > old_data_size) {
 		ret = ntfs_expand_for_write(ni, end);
@@ -928,10 +960,21 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		ret = iomap_file_buffered_write(iocb, from, ntfs_write_iomap_next,
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
@@ -939,14 +982,59 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		 */
 		filemap_invalidate_lock(vi->i_mapping);
 
+		/*
+		 * A page fault through a shared mapping may have used the
+		 * extended initialized size while the write was stalled on
+		 * its source, so keep that size and zero what the write did
+		 * not reach instead.  [old_init_size, pos) was zeroed before
+		 * the write.  Past end, zero the rest of the block that a
+		 * buffered copy may have read from disk, unless such a fault
+		 * already moved the initialized size past end and zeroed it.
+		 */
+		if (NInoNonResident(ni) && !NInoCompressed(ni) &&
+		    ni->initialized_size > new_init_size) {
+			loff_t zstart = max(pos, new_init_size);
+			loff_t zend = ni->initialized_size > end ? end :
+				      round_up(end, i_blocksize(vi));
+			int err = 0;
+
+			zend = min(zend, new_data_size);
+			if (zend > zstart) {
+				err = iomap_zero_range(vi, zstart,
+						zend - zstart, NULL,
+						ntfs_seek_iomap_next,
+						&ntfs_iomap_folio_ops, NULL);
+				/* A direct read must not see the old blocks. */
+				if (!err && iocb->ki_flags & IOCB_DIRECT)
+					err = filemap_write_and_wait_range(
+						vi->i_mapping, zstart, zend - 1);
+			}
+			if (!err)
+				new_init_size = min(ni->initialized_size,
+						    new_data_size);
+			else
+				new_init_size = min3(ni->initialized_size,
+						     zstart, new_data_size);
+		}
+
 		/* ntfs_attr_set_initialized_size() rejects a resident one. */
-		if (ni->initialized_size != old_init_size &&
+		if (ni->initialized_size != new_init_size &&
 		    NInoNonResident(ni)) {
 			struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
 
+			/*
+			 * Only reached when the zeroing above failed or did
+			 * not apply.  Drop what was cached past the new
+			 * initialized size, as __ntfs_extend_initialized_size()
+			 * does.
+			 */
+			if (ni->initialized_size > new_init_size)
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
@@ -955,13 +1043,30 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
+			if (NInoNonResident(ni) && !NInoCompressed(ni)) {
+				/*
+				 * Only free what the write allocated, not
+				 * clusters that were there before, such as
+				 * space reserved with FALLOC_FL_KEEP_SIZE.
+				 */
+				loff_t keep = max(new_data_size,
+						  old_alloc_size);
+
+				if (ni->allocated_size > keep)
+					data_err = __ntfs_attr_truncate_vfs(ni,
+							keep, keep);
+				if (!data_err && ni->data_size != new_data_size)
+					data_err = ntfs_attr_set_data_size(ni,
+							new_data_size);
+			} else {
+				data_err = __ntfs_attr_truncate_vfs(ni,
+						new_data_size, new_data_size);
+			}
 			mutex_unlock(&mrec_ni->mrec_lock);
 			/* Like ntfs_setattr_size(): stay on the durable size. */
 			if (data_err)

base-commit: 4862a81576e3b20ba40cb94a38c5df0450047ffe
-- 
2.43.0

