Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF2D494A03
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333050; cv=none; b=Oqxcn5qwGRCgFLs4DVDwp0xDE0XCRLP5qHnIVJ9VP+Yea2Kxzb5kSo290NL3gHvt3fOU/+3u5zFeVGdDCpkYAkvO3u1+g5oA40JKVBpKTPmpvvPZQNWbPi82Ngv/pQkcMDK/uaVqWnAD4XOWhcHm4SYiaVa/BQSwuMbFESL+460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333050; c=relaxed/simple;
	bh=5OvR86fzlJn5Qf5EB8X/C8qS1jk8rZyrGOa33fvAkyA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pX4gu2JmZjWex7qCx9PUqzmpOPdgTfD08Ou+dx8RTr9AGrfIxGKYHu1xtQrOXd+4mha1KbFrEndDLRpye4r2RqsMLlcuGNVMYihWfDbfvJab3Z5I5ib0X9WSRS2tcZvw9Ss2lq6Fisf3EXrKG4wl8QDpRTU1waBIVVQGdcvt6O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jV0hHkM4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jV0hHkM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C411F00A3A;
	Wed, 29 Jul 2026 13:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785333042;
	bh=V06Udu19xUqDdprGJfClkCwS2AxXhbAx7TNtd4KCwFE=;
	h=Subject:To:Cc:From:Date;
	b=jV0hHkM4L3LLDpCfV7yiGoTRLcqQj6m80w5xYH85Vhv16e5xhTLPHLyVQM2A2S1kV
	 Q+FEzP8kdZZ/HcZ76McCSxgspeSvSsGklYE2d0fFastu2BNagHx65jcQ1UHL1kKZ4e
	 aNlUSLT+JvcA9b2DyXb7I56K9ir/j288pqykiUt8=
Subject: FAILED: patch "[PATCH] iomap: fix out-of-bounds bitmap_set() with zero-length range" failed to apply to 6.6-stable tree
To: yi.zhang@huawei.com,brauner@kernel.org,djwong@kernel.org,hch@lst.de,joannelkoong@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:50:23 +0200
Message-ID: <2026072923-divinely-glorifier-714d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9c7d8f7c8994c790fca501dc45ce66e7356cbe05
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072923-divinely-glorifier-714d@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9c7d8f7c8994c790fca501dc45ce66e7356cbe05 Mon Sep 17 00:00:00 2001
From: Zhang Yi <yi.zhang@huawei.com>
Date: Tue, 14 Jul 2026 16:23:24 +0800
Subject: [PATCH] iomap: fix out-of-bounds bitmap_set() with zero-length range

ifs_set_range_dirty() and ifs_set_range_uptodate() compute last_blk
as (off + len - 1) >> i_blkbits.  When off is 0 and len is 0, the
unsigned subtraction underflows to SIZE_MAX, producing a huge
last_blk and nr_blks value that causes bitmap_set() to write far
beyond the ifs->state allocation.

Regarding ifs_set_range_uptodate(), it is temporarily safe because len
cannot be passed in as 0. However, for ifs_set_range_dirty() this is
reachable from __iomap_write_end(): when copy_folio_from_iter_atomic()
returns 0 (e.g. user buffer fault) and the folio is already uptodate,
the guard at the top of __iomap_write_end() does not trigger because
!folio_test_uptodate() is false, and iomap_set_range_dirty() is called
with copied == 0.

Add a !len guard to both functions before the computation, so that a
zero-length range is a no-op.

Fixes: 4ce02c679722 ("iomap: Add per-block dirty state tracking to improve performance")
Cc: stable@vger.kernel.org # v6.6
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://patch.msgid.link/20260714082325.325163-5-yi.zhang@huaweicloud.com
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0cf62e516827..3a3ac3051fb0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -68,11 +68,13 @@ static bool ifs_set_range_uptodate(struct folio *folio,
 		struct iomap_folio_state *ifs, size_t off, size_t len)
 {
 	struct inode *inode = folio->mapping->host;
-	unsigned int first_blk = off >> inode->i_blkbits;
-	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
-	unsigned int nr_blks = last_blk - first_blk + 1;
+	unsigned int first_blk, last_blk;
 
-	bitmap_set(ifs->state, first_blk, nr_blks);
+	if (len) {
+		first_blk = off >> inode->i_blkbits;
+		last_blk = (off + len - 1) >> inode->i_blkbits;
+		bitmap_set(ifs->state, first_blk, last_blk - first_blk + 1);
+	}
 	return ifs_is_fully_uptodate(folio, ifs);
 }
 
@@ -204,13 +206,17 @@ static void ifs_set_range_dirty(struct folio *folio,
 {
 	struct inode *inode = folio->mapping->host;
 	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
-	unsigned int first_blk = (off >> inode->i_blkbits);
-	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
-	unsigned int nr_blks = last_blk - first_blk + 1;
+	unsigned int first_blk, last_blk;
 	unsigned long flags;
 
+	if (!len)
+		return;
+
+	first_blk = off >> inode->i_blkbits;
+	last_blk = (off + len - 1) >> inode->i_blkbits;
 	spin_lock_irqsave(&ifs->state_lock, flags);
-	bitmap_set(ifs->state, first_blk + blks_per_folio, nr_blks);
+	bitmap_set(ifs->state, first_blk + blks_per_folio,
+		   last_blk - first_blk + 1);
 	spin_unlock_irqrestore(&ifs->state_lock, flags);
 }
 

