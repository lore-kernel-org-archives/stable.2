Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795371594;
	b=zcM83mfCjUPDcnsPzNCvai0PztWBxLI+UM/NHEFzA2b4LZrVn8PmWV5D+643Nxr6/mFS
	 ZuihDxGlelqujl6RFtDuikEuFCM7Sz1ectWYflj5TM86l3c3sX7fsD6fhrxIUoK9NWp24
	 bTRs2ASU+xcMNtjTytR/3IkLjD7wgsHx9RI8bK6A88SW6rRQ4dmApITxXgFCSK0RAc/8a
	 PYj/ZzDRR3h8DW/K2UMmgFkKk2ITddSIkvDErGG9yDIK2OMPL6sUySysa9SixFmekb+u+
	 ehuNUZHyyqGYyz8mNDe0FRwt8z1Bjg7RzfBh+gagj87DzMiK8XRhKOMgQ5W6XrByrjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795371594;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LwOLZT0yZls4qSknTvgbh/VunVz5eSP1RQX7iDD7b6Y=;
	b=O4FCYdrkFv828tMHdzjzIsqnVgQSyHCCDw7Cr5Eegz+FFpqlwDBy0uK1SbraCFgsx5YH
	 jbMCt6Ib6OLzoJdrfzbVujlWS4ZJ6kVi6GtIoxAAmFAtMmN9S1o9LJP85lh+7+W6dFxyc
	 jcMiqdsOl4MHlddV7mtymG18CSQ+dxv5SpdPy78PJsaJmMHaak2aWIwGARB63aqjoP1dT
	 KIURwgfB7zajbfciEj/hiZ6kPI4WmfRKZNyIHEMZ6slJ4ByqpBSybUAi7VlzhfAqyWAmT
	 wrckT7yoI9Fq1SBM2sy1vVEDvlef7x4aTqWwXFz7cdSgIkuXqxLnP7p5kBImOo8+4Nw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Tk1TUsi/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE07606A692;
	Sun, 22 Nov 2026 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tk1TUsi/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795371594;
	b=DgQMdMquBujVIPYMGDUTFATkfANh/GTjCaDXzbIcjHFmAiI6dQmfmzzU0MP7cELMHgZd
	 mXta+7jDpEFRVAtMS/3c7xxqfWYhx+XpewFRCikaNHlVsPr07ejMgy+n9Abz00M4QsFYJ
	 zXyWQ/cGRn54J+0aitgF6drq//dTH8mwMi2e6tbZ8YzQiEJjLMmpMjq9VzqKDmrZ28Id9
	 bYW3Og+ncyTmih9OE/AZrGL25XuuBPCNxABl+zOLAaemTmllHiC8TJujNYzxzzsP9Pueg
	 fzr56MbHUKNFZkoFp7oFN5ZwifXL8YSZSz4eEaCEtwHNr22YZwM7z73Px6/rT4dsU5Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795371594;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LwOLZT0yZls4qSknTvgbh/VunVz5eSP1RQX7iDD7b6Y=;
	b=praZriNIMhq4D35PYqxYB4wKkEFiAJKQHjcLYWNYeh8VDbo73bM2zw5hVHqbIT17ANnU
	 mFxfUB+cmUzmNo9XFfxRVw7eo3MOjjLHcxfKEN1H5wCJCXLadhbJ+AKuTTPQ15NucWtgc
	 dhi3YLEOO4dx/7KlykQqZ/TpY93UFgV51ugLscUKIKFht9ppxIAkbT2OEEyU00nnGDofb
	 jczw40cvVX3TkgqwkgOBv+Gz2TW605o77YIfzWwFx1P7gEJZ1IG34pq9kn6nbaCqbLdba
	 5OtqV0bQbYmjEllHSRWIKQnwVR1WpWeUP2u7riCHOZqiIRaOKZsfnIblaKM4t3K8IJA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BC7CC1F000C4;
	Sun, 22 Nov 2026 18:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795371594;
	bh=LwOLZT0yZls4qSknTvgbh/VunVz5eSP1RQX7iDD7b6Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Tk1TUsi/paeu0LiNj0vnAYAbRRrSG69tERHDTiFCqyX5NzV3tzytYgy+muxuVndFb
	 ytOegGHYsXYXYO2RkbAm9a4Ni+lIc/prrsCvofGE8igAUTWIYsFVq8hTePBLE8k4rZ
	 IPjKAPflu9DcKmRMCDxi572vgIpinDYLHfs4zxDN7v/x5+6pqT0lxZlVB7xFZ+mmCe
	 Ur47YY1rlCB2ar6HKAPHEGGWko6apPAS07RT1ACmP6lY9aQG8D4wqi1IOea5PTova5
	 5SxCPn5MMgQ8AHgzMxdM3ArdQ7vA73rMDgjTj7Xou63UkZqX+v4MdoecN7YK4cHBtu
	 ZTxvu7mtoTsaQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 383584C190;
	Sun, 22 Nov 2026 18:19:39 +0000 (UTC)
From: Ernest Borowski via B4 Relay <devnull+ernest.borowski.git.proton.me@kernel.org>
Date: Sun, 22 Nov 2026 19:19:43 +0100
Subject: [PATCH 7/7] ntfs: zero the rest of a new cluster after a short
 buffered write
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-b4-ntfs-delalloc-fixes-v1-7-0726f0dce403@proton.me>
References: <20261122-b4-ntfs-delalloc-fixes-v1-0-0726f0dce403@proton.me>
In-Reply-To: <20261122-b4-ntfs-delalloc-fixes-v1-0-0726f0dce403@proton.me>
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
 Baolin Liu <liubaolin12138@163.com>
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Zhan Xusheng <zhanxusheng1024@gmail.com>, stable@vger.kernel.org, 
 Ernest Borowski <ernest.borowski.git@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8086;
 i=ernest.borowski.git@proton.me; s=default; h=from:subject:message-id;
 bh=SIuoyumwdVQAIkLosER9C52F/l7mvPhg9EX1v73MzkE=;
 b=owGbwMvMwCVWzJ65uCpJ5D/jabUkhmxmI8ukzmsXhaes3bJOVeiF+7mXydbz0nPUvvGlJyR35
 Vww2X+mo5SFQYyLQVZMkaXj/40Qn5Bvn5bFafXBzGFlAhnCwMUpABMRf8bI8LxtYXSPw7X5L+OD
 bTTXfwneLizyuegHw7Gc8zcaJ18u5Gb4p5/4PO00UxXDcT0lWyHRHHMxn+B5a0vzQ5VKL/4rFXr
 AAQA=
X-Developer-Key: i=ernest.borowski.git@proton.me; a=openpgp;
 fpr=88FFD8544C54F6F2A65E2A8E730769A37A6214FF
X-Endpoint-Received: by B4 Relay for ernest.borowski.git@proton.me/default
 with auth_id=1589
X-Original-From: Ernest Borowski <ernest.borowski.git@proton.me>
Reply-To: ernest.borowski.git@proton.me
Content-Transfer-Encoding: 7bit

From: Ernest Borowski <ernest.borowski.git@proton.me>

ntfs_write_simple_iomap_begin_non_resident() turns the holes a buffered
write covers into LCN_DELALLOC runs, and zeroes in the page cache only
the parts of the first and last cluster that the write will not cover.
When the copy from user space stops inside a cluster (the source buffer
runs into an unmapped page, or a fatal signal), only the bytes copied
are dirty.  Writeback allocates the whole cluster and writes the dirty
blocks, and the rest of the cluster keeps what the reused clusters held
before.  Below initialized_size, for example a write into a hole of a
sparse file, reads return that old data.

Reproducer: fill a file, fsync, truncate it to 0 and back up, write the
last byte, then pwrite() 2.5 clusters at a cluster boundary from a
buffer whose readable part ends 5096 bytes in: the write returns 5096,
and after fsync and drop_caches the rest of the second cluster (4 KiB
clusters) or of the first (64 KiB clusters) reads back the old file
contents.

Mark the mappings that ->iomap_begin() made out of a hole, and on a
short copy make writeback write the rest of the cluster the copy stopped
in, before the unused delalloc clusters after it are punched out: under
the invalidate lock, folios already in the page cache are dirtied as
they are (they hold the zeroes __iomap_write_begin() put there, or data
an mmap write added meanwhile, which must not be lost), and the rest of
the range is zeroed while it is still delalloc (once a write fault or
writeback has allocated it, an mmap write's data may have left the page
cache; a follow-up series makes both zero a partly written cluster on
the disk before mapping it).
When the writer has a fatal signal pending, iomap_zero_range() refuses
to run in its context (-EINTR), so the zeroing is done from a worker
then.

Fixes: b041ca562526 ("ntfs: update iomap and address space operations")
Cc: stable@vger.kernel.org
Signed-off-by: Ernest Borowski <ernest.borowski.git@proton.me>
---
 fs/ntfs/iomap.c | 138 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/fs/ntfs/iomap.c b/fs/ntfs/iomap.c
index fd94d4b34f..9547136cd5 100644
--- a/fs/ntfs/iomap.c
+++ b/fs/ntfs/iomap.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2025 LG Electronics Co., Ltd.
  */
 
+#include <linux/workqueue.h>
 #include <linux/writeback.h>
 
 #include "attrib.h"
@@ -12,6 +13,9 @@
 #include "ntfs.h"
 #include "iomap.h"
 
+/* iomap->flags: ->iomap_begin() turned a hole into this delalloc mapping */
+#define NTFS_IOMAP_F_WAS_HOLE		IOMAP_F_PRIVATE
+
 static void ntfs_iomap_put_folio_non_resident(struct inode *inode, loff_t pos,
 					      unsigned int len, struct folio *folio)
 {
@@ -481,6 +485,9 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 		if (lcn <= LCN_HOLE) {
 			loff_t end = offset + length;
 
+			/* The whole mapping was a hole before this write. */
+			iomap->flags |= NTFS_IOMAP_F_WAS_HOLE;
+
 			if (vcn_ofs || ((vol->cluster_size > iomap->length) &&
 					end < ni->initialized_size)) {
 				loff_t z_start, z_end;
@@ -800,11 +807,142 @@ static void __ntfs_write_delalloc_release(struct inode *inode, loff_t pos,
 				     ntfs_write_delalloc_punch);
 }
 
+struct ntfs_zero_work {
+	struct work_struct work;
+	struct inode *inode;
+	loff_t pos;
+	loff_t len;
+	int err;
+};
+
+static void ntfs_zero_range_workfn(struct work_struct *work)
+{
+	struct ntfs_zero_work *zw = container_of(work, struct ntfs_zero_work,
+						 work);
+
+	zw->err = iomap_zero_range(zw->inode, zw->pos, zw->len, NULL,
+				   ntfs_seek_iomap_next, &ntfs_iomap_folio_ops,
+				   NULL);
+}
+
+/*
+ * Like ntfs_zero_range(), but also for a writer that has a fatal signal
+ * pending: iomap_zero_range() then gives up with -EINTR, and a write cut
+ * short by SIGKILL is one whose cluster tail must still be zeroed.  Zero
+ * from a worker in that case, which has no signal to see; the caller's
+ * invalidate lock still keeps page faults out of the range.
+ */
+static int ntfs_zero_range_unkillable(struct inode *inode, loff_t pos,
+				      loff_t len)
+{
+	struct ntfs_zero_work zw = { .inode = inode, .pos = pos, .len = len };
+
+	int err;
+
+	if (!fatal_signal_pending(current)) {
+		err = ntfs_zero_range(inode, pos, len);
+		/* the signal may also come while it zeroes */
+		if (err != -EINTR || !fatal_signal_pending(current))
+			return err;
+	}
+
+	lockdep_assert_held_write(&inode->i_mapping->invalidate_lock);
+	INIT_WORK_ONSTACK(&zw.work, ntfs_zero_range_workfn);
+	queue_work(system_unbound_wq, &zw.work);
+	flush_work(&zw.work);
+	destroy_work_on_stack(&zw.work);
+	return zw.err;
+}
+
+/* True if the cluster at byte @pos is still a delalloc run. */
+static bool ntfs_pos_is_delalloc(struct inode *inode, loff_t pos)
+{
+	struct ntfs_inode *ni = NTFS_I(inode);
+	s64 vcn = ntfs_bytes_to_cluster(ni->vol, pos);
+	struct runlist_element *rl;
+	s64 lcn;
+
+	down_read(&ni->runlist.lock);
+	rl = __ntfs_attr_find_vcn_nolock(&ni->runlist, vcn);
+	lcn = IS_ERR(rl) ? LCN_EINVAL : ntfs_rl_vcn_to_lcn(rl, vcn);
+	up_read(&ni->runlist.lock);
+	return lcn == LCN_DELALLOC;
+}
+
+/*
+ * Make writeback write all of [start, end), the rest of a cluster that was a
+ * hole and that a short buffered write filled only in part.  Folios in the
+ * page cache keep their contents (the zeroes __iomap_write_begin() put
+ * there, or data an mmap write added meanwhile) and are dirtied as a whole;
+ * the rest of the range is zeroed while the cluster is still delalloc.  Once
+ * a write fault or writeback has allocated it, the cluster was zeroed on the
+ * disk before it was mapped, and what an mmap write put there since may only
+ * have left the page cache: it must not be zeroed again.  The caller holds
+ * the invalidate lock.
+ */
+static int ntfs_dirty_cluster_tail(struct inode *inode, loff_t start,
+				   loff_t end)
+{
+	struct folio *folio;
+	loff_t next;
+	int err = 0;
+
+	lockdep_assert_held_write(&inode->i_mapping->invalidate_lock);
+	while (!err && start < end) {
+		folio = filemap_lock_folio(inode->i_mapping,
+					   start >> PAGE_SHIFT);
+		if (IS_ERR(folio)) {
+			next = min_t(loff_t, round_up(start + 1, PAGE_SIZE),
+				     end);
+			if (ntfs_pos_is_delalloc(inode, start))
+				err = ntfs_zero_range_unkillable(inode, start,
+								 next - start);
+		} else {
+			bool uptodate = folio_test_uptodate(folio);
+
+			next = min_t(loff_t, folio_pos(folio) +
+				     folio_size(folio), end);
+			if (uptodate)
+				folio_mark_dirty(folio);
+			folio_unlock(folio);
+			folio_put(folio);
+			if (!uptodate && ntfs_pos_is_delalloc(inode, start))
+				err = ntfs_zero_range_unkillable(inode, start,
+								 next - start);
+		}
+		start = next;
+	}
+	return err;
+}
+
 static void ntfs_write_delalloc_release(struct inode *inode, loff_t pos,
 					loff_t length, ssize_t written,
 					unsigned int flags, struct iomap *iomap)
 {
+	struct ntfs_volume *vol = NTFS_I(inode)->vol;
+
 	filemap_invalidate_lock(inode->i_mapping);
+	/*
+	 * A copy that stopped inside a cluster which was a hole leaves the
+	 * rest of that cluster neither written nor zeroed, but writeback
+	 * allocates the whole cluster and writes only the dirty blocks, so
+	 * the old contents of the cluster would show through.
+	 */
+	if (written && iomap->flags & NTFS_IOMAP_F_WAS_HOLE) {
+		loff_t start = pos + written;
+		loff_t end = min_t(loff_t, round_up(start, vol->cluster_size),
+				   i_size_read(inode));
+		int err = 0;
+
+		if (end > start)
+			err = ntfs_dirty_cluster_tail(inode, start, end);
+		if (err) {
+			ntfs_error(vol->sb,
+				   "Failed to zero [%lld, %lld) of inode 0x%llx after a short write: %d",
+				   start, end, NTFS_I(inode)->mft_no, err);
+			NVolSetErrors(vol);
+		}
+	}
 	__ntfs_write_delalloc_release(inode, pos, length, written, flags,
 				      iomap);
 	filemap_invalidate_unlock(inode->i_mapping);

-- 
2.56.1


