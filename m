Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EC141A51B
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574488; cv=none; b=QQbJhnToveJeo9TyOUitskZGiM8/kUP+rqY4ywVgjR9I/C8JuCQ2/0FViSFaxrx8/vZhafvmlIlGoJzl9T/kim74rthb5Zpaa38Q52zJwFQsOzf1uc2Pwn1adVYx54D9Rtd1GLdN7N+zuSh9U7IjOIhgSdgtF5Ok7A+DVW4mxv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574488; c=relaxed/simple;
	bh=PC0xrJAoQGfu6DlHlwyuXMSMIe/uBhuJJzwqWuqnGCU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LyrEkz6KTURf6mbq80MB3hGw+iX15ymf3FV0zsBLpt9knjGKxJ8FtrRggeTSr2Bvd24GvYsnZYXuL7pf9XMKENCIHaYoKd93bz7/YeOoBuG9DITcie1oanpLtqLlK+KHher9NZMe6nAHGqJvjly4YDOqodXAPOO1R4MI/XCb/gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LDqdMkTm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LDqdMkTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B581F00A3A;
	Mon, 24 Aug 2026 12:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787574487;
	bh=IRMHFbLfqj+NFBRRtvv8GJ6KWJ/+Dbl9Lk54nl3MQvk=;
	h=Subject:To:Cc:From:Date;
	b=LDqdMkTmSszzNWQ5Y9dLpCFvGoRQN3pe2naqWsuV6/PpZO9keA7C2tE2nAyoyuVdI
	 NaPv2Mci+7vbFHsdNGym1sz/I9ch25xV5cU9aFIRGXlEe1V6tdOYS+9UQOuAVbuQgL
	 bO+Xq9Ri+W4Bodu3BTdkLIfXmfoN7uOlEZ9aVQrU=
Subject: FAILED: patch "[PATCH] ext4: write back partial-zeroed edges in WRITE_ZEROES" failed to apply to 7.2-stable tree
To: yi.zhang@huawei.com,jack@suse.cz,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Aug 2026 14:27:52 +0200
Message-ID: <2026082452-emoticon-groovy-0271@gregkh>
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
git cherry-pick -x d19d239ada9b7c92d086a1f051b7566538ee0089
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082452-emoticon-groovy-0271@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

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

