Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429704195DA
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574491; cv=none; b=bw26wQACh+UfQ55uFQabjVMjjbjWfOkrxYXf4cW9dgGG8QmdKl4IbzECZAlHfFZq+MkHZ2eh3jMfyO/Z9QTWFv/u9TR4BIUFHRxcRNvZFx1k8Tm0rEaIHSRSyhi3DzA79vYqbrVjJySQ0MY+ybqyRlwELO4OpgjA2OifKk47vHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574491; c=relaxed/simple;
	bh=GEuNBoSTHgSlLCpkAcHyh7s+F4wowQsCI93T7A2tnEc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fd1/BtutbCZCpuj3B+zV7aRoftD2HIaO5igIohr2MTMc8AJYIk5tJ2MtQGcF2hfiJiNFpabP5Xi8HA7niQLIvhE3t/NplFMchkWYm2vXbK2bM6QTuVJ9eWSRYROdSLYWuFXlkm84g5i2Im9rMGIrS6ZIZCUhwSEH1T6qBvvjD4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EuDTObVU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EuDTObVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44ADA1F000E9;
	Mon, 24 Aug 2026 12:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787574489;
	bh=XoScflC63+cShEUPgH16i4HJrdqd9X2bmOM8RAtNgeA=;
	h=Subject:To:Cc:From:Date;
	b=EuDTObVUDQcLZvGNAiTIb+MCZ4clpQp04NkdQarIUKvPphTwKOvzDCDHLQ1q7LOOf
	 /+AO29Bdl0g2sLmpOFCc2XYg+cLU83oqv6vozbxDPdr21nnFjdGl5fUgbbVEmPrjNN
	 h1I9GDD5wMrG7LLnDYWt+BaVnD5ZVjm1ksRpI3tE=
Subject: FAILED: patch "[PATCH] ext4: write back partial-zeroed edges in WRITE_ZEROES" failed to apply to 6.18-stable tree
To: yi.zhang@huawei.com,jack@suse.cz,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Aug 2026 14:27:53 +0200
Message-ID: <2026082453-darling-postcard-97fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x d19d239ada9b7c92d086a1f051b7566538ee0089
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082453-darling-postcard-97fc@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d19d239ada9b7c92d086a1f051b7566538ee0089 Mon Sep 17 00:00:00 2001
From: Zhang Yi <yi.zhang@huawei.com>
Date: Tue, 14 Jul 2026 16:00:43 +0800
Subject: [PATCH] ext4: write back partial-zeroed edges in WRITE_ZEROES

FALLOC_FL_WRITE_ZEROES requires that all blocks in the requested range
end up as written extents with zeroed content. For unaligned edges that
were partial-zeroed in dirty unwritten or delalloc state, the buffer
is left dirty while the underlying extent may not yet be converted to
written. As a result, a subsequent SYNC write to this range would still
trigger metadata changes, which violates the semantics of WRITE_ZEROES.

Fix this by calling filemap_write_and_wait_range() for partial-zeroed
edges to flush out the zeroed data and ensure the extent conversion
is complete.

Fixes: f4265b8d32c4 ("ext4: add FALLOC_FL_WRITE_ZEROES support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260714080044.4038124-9-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index d62fc4543760..d5f87a7f6c05 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4791,7 +4791,15 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	if (IS_ALIGNED(offset | end, blocksize))
 		return ret;
 
-	if (((file->f_flags & O_SYNC) || IS_SYNC(inode)) && partial_zeroed) {
+	/*
+	 * In FALLOC_FL_WRITE_ZEROES mode, edges that have been partially
+	 * zeroed must be written back to ensure the entire zeroed range
+	 * is converted to the written state. In SYNC mode, writeback is
+	 * also required to persist the zeroed data to disk.
+	 */
+	if (partial_zeroed &&
+	    ((mode & FALLOC_FL_WRITE_ZEROES) ||
+	     (file->f_flags & O_SYNC) || IS_SYNC(inode))) {
 		ret = filemap_write_and_wait_range(inode->i_mapping, offset,
 						   end - 1);
 		if (ret)

