Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF68D331203
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574562; cv=none; b=JMet2DvYy2AnHi5YYCVfgkWgu4xR0IE0BpI3tGdhklBnqENg4Q1qYN2wkcjJOnZhnVmjBTgTutmMyha/vD/x8QSxswNiyxnZIqRN4tFSSUsUWURiP6NjNwytvX3XET1qYcTyhPiF7BBJBW+bToj+oc0Lznv3/SWZVVN5WO5EdTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574562; c=relaxed/simple;
	bh=7ko014YelCWGw/SskPGMDwpWGC09TPf0Wv3PzYErgsA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UihiaeEpPJ4N3sRsz3rd6WrC0eZrrlLXkLWyoTR1wH2lgdTtN2haE6Z0DNxGX2bS+E4FuBrxGSdnpgd43fCo3a9F1UUJxsHTwZhH6zP9ozqAbzODywHhCgi4/3M7KSRePSe5gGLxfi+BWZM36vufiITHe0ggYhvQDc+sA+pDfoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H6sOViQQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H6sOViQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7361F00A3A;
	Mon, 24 Aug 2026 12:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787574560;
	bh=cuQB8U5/M/fggpcgJRxYrx53NjXbgDQCepH7b6O2Aak=;
	h=Subject:To:Cc:From:Date;
	b=H6sOViQQozW7SPUlpPs1CNQ3cND5FMeOZqYIjNDNnvXgelYbfWwkJMcBN868JX/Ga
	 QSXCJYNaOhQNBrMX37GK5UlUc2px1GZ9TFZ4mkaaT/oGbqpDpKlNcY4CWtYKnQR6hX
	 OMEWnH373cDmAsydKrwlfMjlt/+MyASi6S2d5H1M=
Subject: FAILED: patch "[PATCH] ext4: zero out whole block for clean edges in WRITE_ZEROES" failed to apply to 7.2-stable tree
To: yi.zhang@huawei.com,jack@suse.cz,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Aug 2026 14:29:16 +0200
Message-ID: <2026082416-sanded-frenzied-3051@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x a5179156ac1d9a6646da42254e4c461e1fc20096
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082416-sanded-frenzied-3051@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a5179156ac1d9a6646da42254e4c461e1fc20096 Mon Sep 17 00:00:00 2001
From: Zhang Yi <yi.zhang@huawei.com>
Date: Tue, 14 Jul 2026 16:00:42 +0800
Subject: [PATCH] ext4: zero out whole block for clean edges in WRITE_ZEROES

FALLOC_FL_WRITE_ZEROES requires that all blocks in the requested range
end up as written extents with zeroed content. For unaligned edges that
were already allocated, ext4_zero_partial_blocks() zeros them directly.
However, for unaligned edges whose underlying extent is a clean
unwritten extent or a hole, the extent type remains unwritten after
partial zeroing, which does not align with the semantics of
WRITE_ZEROES.

Therefore, when ext4_zero_partial_blocks() skips partial zeroing, it
indicates that the corresponding edges are clean unwritten extents or
holes. In this case, we need to expand the aligned allocation range
outward to cover such edges, so that ext4_alloc_file_blocks() can
correctly allocate blocks for the unaligned range. Edges that were
partial-zeroed (i.e., written or dirty) are left untouched.

Fixes: f4265b8d32c4 ("ext4: add FALLOC_FL_WRITE_ZEROES support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260714080044.4038124-8-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 9b6efc8f769e..d62fc4543760 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4760,6 +4760,21 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	/* Zero range excluding the unaligned edges */
 	align_start = round_up(offset, blocksize);
 	align_end = round_down(end, blocksize);
+
+	/*
+	 * In WRITE_ZEROES mode, edges that were not partial-zeroed (clean
+	 * unwritten or hole) must be allocated and zeroed as whole blocks.
+	 * Expand the aligned range outward to cover them.
+	 */
+	if (mode & FALLOC_FL_WRITE_ZEROES) {
+		if (!IS_ALIGNED(offset, blocksize) &&
+		    !(partial_zeroed & EXT4_PARTIAL_ZERO_START))
+			align_start = round_down(offset, blocksize);
+		if (!IS_ALIGNED(end, blocksize) &&
+		    !(partial_zeroed & EXT4_PARTIAL_ZERO_END))
+			align_end = round_up(end, blocksize);
+	}
+
 	if (align_end > align_start) {
 		if (mode & FALLOC_FL_WRITE_ZEROES)
 			flags = EXT4_GET_BLOCKS_CREATE_ZERO | EXT4_EX_NOCACHE;

