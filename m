Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8765F4AEBF7
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443280; cv=none; b=ACEXeRdMwHLj0ZV1F4d3Oa7od4mx6J1paZ48Qx1ZWl9h2A9jsK2k5IBr+V2KAyDyakFU5GXwvhEznasYWu1A/9JOD6PqOVpqrT8YT44TZFV1QsWm3qlosMbHuPh7kZKkLoqVVjdyYKDoiythntJNYAFSBYjoC7CP6gJFWjC9550=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443280; c=relaxed/simple;
	bh=nbX7w4j/RGBvXYCu71pynoA39SKijtPf/VG8aKFL8nI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ufKmEVMidEBmjcyib0Sw2dfN6dLUCpiT7+TdvxQBzqQWPrb72Oghj9Jw+KkjUyPxfE0/9bSwlTWoKWLcSbj+gOZbTQAhmr2rbpKtKDZl6m1yS7iZ/TxzQadHQJB/3Ca9BX3CYnvHxkUA+oZGocKNHusRizNnriJdP36G6DI/Yh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AF3sKCzZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AF3sKCzZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B0B1F00AC4;
	Thu,  3 Sep 2026 13:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443259;
	bh=XvvA9JjxzPzB5ThOWJd6SP+ck4OMPPi4/kE/HQtuaXw=;
	h=Subject:To:Cc:From:Date;
	b=AF3sKCzZiahuQPKgOWjlEYwJGDm+1ntByii2b7naXJAThGh5topWtaPOu7TPho/cx
	 CLjPueJcOeAQhptpScUZ4YYSwRMXeegZocJrpA0wb9FlsdDxYdhdT2s9us+h7hTvD0
	 a0yjryPi8glVaBf9odGsGxdChTGIceeurbz6Qx/E=
Subject: FAILED: patch "[PATCH] btrfs: fix extent map leak in NOCOW direct I/O write" failed to apply to 5.10-stable tree
To: shuangpeng.kernel@gmail.com,dsterba@suse.com,fdmanana@suse.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:24:11 +0200
Message-ID: <2026090311-oblivion-chunk-24d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3f950867c307c5413d628a153ac44915bd117ffd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090311-oblivion-chunk-24d7@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3f950867c307c5413d628a153ac44915bd117ffd Mon Sep 17 00:00:00 2001
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Date: Sun, 5 Jul 2026 01:46:35 -0400
Subject: [PATCH] btrfs: fix extent map leak in NOCOW direct I/O write

btrfs_dio_iomap_begin() calls btrfs_get_extent(), which returns an
extent map reference that must be dropped on all exit paths.

For direct writes into a NOCOW range, btrfs_get_blocks_direct_write()
keeps using that extent map and asks btrfs_create_dio_extent() to
allocate the ordered extent. If that fails, for example because
btrfs_alloc_ordered_extent() fails, the function returns the error
without dropping the input extent map. The PREALLOC path avoided this by
dropping the input extent map before replacing it with the newly created
one.

Check the error from btrfs_create_dio_extent() before replacing the
map and drop the input extent map on failure.

Fixes: 5f9a8a51d8b9 ("Btrfs: add semaphore to synchronize direct IO writes with fsync")
CC: stable@vger.kernel.org
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index b80dc45c3ff9..27d227f5bdc0 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -280,17 +280,24 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start,
 					      &file_extent, type);
 		btrfs_dec_nocow_writers(bg);
-		if (type == BTRFS_ORDERED_PREALLOC) {
+		if (IS_ERR(em2)) {
+			ret = PTR_ERR(em2);
+			btrfs_free_extent_map(em);
+			*map = NULL;
+			goto out;
+		}
+
+		/*
+		 * True NOCOW writes don't need to create a new extent map,
+		 * while PREALLOC writes must replace the existing one.
+		 */
+		if (em2) {
+			ASSERT(type == BTRFS_ORDERED_PREALLOC);
 			btrfs_free_extent_map(em);
 			*map = em2;
 			em = em2;
 		}
 
-		if (IS_ERR(em2)) {
-			ret = PTR_ERR(em2);
-			goto out;
-		}
-
 		dio_data->nocow_done = true;
 	} else {
 		/* Our caller expects us to free the input extent map. */

