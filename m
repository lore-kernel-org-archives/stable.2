Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912F23FE67A
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922398; cv=none; b=bmgvpea7Wel03TyFj488gukzuX9YW4lwO+b0JyaSr9fy4jAGokl4qRN+ToECADRv0VxlxDhdzvrR0FvD3A4X3pHgWJkReG/c1Wpy2NAAbSM467Z+kW1hr3uUbaSxryFNI/3qjkrOMwpUZZQhLMw/1O7RWKqhmVjpbDZvcC65kgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922398; c=relaxed/simple;
	bh=qvX6U0tljyOTMVqiF3z66rX9fxZK87Jxc6HQR8TVamw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aRkjUFkJIFb9EvLBjhMTHrM2xe0gOAwhM36ZMbAP8RpfymFi0/UeSBQh340twpFzV51esyAYRsUnFwdUBjPgpIj8/Eq528dMOjEx2uAhBd0NZwRrQRkiputYrHh3krfPWAznf/e2TxiwErxjwKqXVYGSavKUiiAQM8/NKs/PUVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=06KRaoGd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="06KRaoGd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF211F00A3D;
	Wed,  5 Aug 2026 09:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785922395;
	bh=Xgy7O5fu0v8bpFzinZ43auP3U09nPsfgqRsjqTO5x8c=;
	h=Subject:To:Cc:From:Date;
	b=06KRaoGdwiacRSJz3oTyxm3s/SZIVcwjKq5dg55LQA9DiGZOvqMCtIhvkpWAwz9gS
	 mywgPyCW8CghPZa8jmSbEAJD9PqcyYJiQOjj9vimo8st9YesrLcdqCneuhGXiTRFue
	 6av8Bjvr0XRCr2lDqtd1E/mnZK3wfTApInySTDmw=
Subject: FAILED: patch "[PATCH] btrfs: zoned: fix missing chunk metadata reservation" failed to apply to 6.6-stable tree
To: 3497809730@qq.com,dsterba@suse.com,johannes.thumshirn@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:32:21 +0200
Message-ID: <2026080520-wikipedia-kindness-ddd8@gregkh>
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
git cherry-pick -x 8bc4d7209611e8aa9d5409b6a4a86a9eb91b69a3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080520-wikipedia-kindness-ddd8@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8bc4d7209611e8aa9d5409b6a4a86a9eb91b69a3 Mon Sep 17 00:00:00 2001
From: Guanghui Yang <3497809730@qq.com>
Date: Tue, 14 Jul 2026 17:55:43 +0800
Subject: [PATCH] btrfs: zoned: fix missing chunk metadata reservation

reserve_chunk_space() stores the return value of
btrfs_zoned_activate_one_bg() in ret. The helper can return 1 after
successfully activating a block group, but ret is later used to decide
whether to reserve metadata for chunk tree updates.

As a result, successful activation skips btrfs_block_rsv_add() and leaves
trans->chunk_bytes_reserved unchanged. Use a separate variable for the
activation result so positive success does not affect the later
reservation. Keep activation failures in ret instead of returning early so
the function uses the common tail path.

Fixes: b6a98021e401 ("btrfs: zoned: activate necessary block group")
CC: stable@vger.kernel.org
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Guanghui Yang <3497809730@qq.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index ab76a5173272..8def7abb728f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4532,25 +4532,29 @@ static void reserve_chunk_space(struct btrfs_trans_handle *trans,
 		if (IS_ERR(bg)) {
 			ret = PTR_ERR(bg);
 		} else {
+			int activate_ret;
+
 			/*
 			 * We have a new chunk. We also need to activate it for
 			 * zoned filesystem.
 			 */
-			ret = btrfs_zoned_activate_one_bg(info, true);
-			if (ret < 0)
-				return;
-
-			/*
-			 * If we fail to add the chunk item here, we end up
-			 * trying again at phase 2 of chunk allocation, at
-			 * btrfs_create_pending_block_groups(). So ignore
-			 * any error here. An ENOSPC here could happen, due to
-			 * the cases described at do_chunk_alloc() - the system
-			 * block group we just created was just turned into RO
-			 * mode by a scrub for example, or a running discard
-			 * temporarily removed its free space entries, etc.
-			 */
-			btrfs_chunk_alloc_add_chunk_item(trans, bg);
+			activate_ret = btrfs_zoned_activate_one_bg(info, true);
+			if (activate_ret < 0) {
+				ret = activate_ret;
+			} else {
+				/*
+				 * If we fail to add the chunk item here, we end
+				 * up trying again at phase 2 of chunk allocation,
+				 * at btrfs_create_pending_block_groups(). So
+				 * ignore any error here. An ENOSPC here could
+				 * happen, due to the cases described at
+				 * do_chunk_alloc() - the system block group we
+				 * just created was just turned into RO mode by a
+				 * scrub for example, or a running discard
+				 * temporarily removed its free space entries, etc.
+				 */
+				btrfs_chunk_alloc_add_chunk_item(trans, bg);
+			}
 		}
 	}
 

