Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E3E5476FD
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954251; cv=none; b=D4ZR+o/6vGe1m1RtpCIWXN6mHSIY0uDxgBis9j18BNfC+fLnOlwKXTV7y2nSPp5jejZDggWf+JaobctS8n6u6vaOic2byEb+flA7fzjTi0Y8DLxqwMtG5o9V7+E7xUrlP0BFSyy3AoVXrmKn3Lrg2i4lV8LNjzJx4Cn7QSbO5I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954251; c=relaxed/simple;
	bh=+TV3F9sskdDiv36MHae4gGbQReR6wOQCsmpdPLugDLI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MF89QDy2mjXtfTTiRm2vywfgyKHsYigg2unYP7vPxXFkfddKEEHcsntPmj5zJ878vR4V16ZQgTuG6XxnNcRc7LZkCcDDz1HxZGqZYxEq/amQdVvF4ZBmesPi6Zlghb1OAMq9SqfsxioqpyAFcusKN2+8FWJy5zFhnxI8J2ibyZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kb5MbhYk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kb5MbhYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32101F00A3A;
	Wed,  9 Sep 2026 11:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954250;
	bh=lhKwYXDU57fszHBde8bC1brF1YFP1MbcwE3khqWEEkU=;
	h=Subject:To:Cc:From:Date;
	b=kb5MbhYkz5ZlCmYgQi6YwrGDFmx5A9ZT5h1ly0Ia/rU54piq4RVbDDUlsTavYcxGV
	 MNwE0T5My2kebhRkqkwBm/dOu8Rxkkl8+JSmxqFOYP9mCE+PAqM7K0tg0XEiJX3CQo
	 4trFcfA/0WmhV+q0IeYsVd5YadaN4N9efCmw0tQo=
Subject: FAILED: patch "[PATCH] f2fs: fix to migrate all curseg types during" failed to apply to 6.6-stable tree
To: daehojeong@google.com,chao@kernel.org,jaegeuk@kernel.org,s_min.jeong@samsung.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:26:46 +0200
Message-ID: <2026090946-clumsily-stuck-0ea2@gregkh>
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
git cherry-pick -x 8ec06f50ddd8d201bd7e55b896ae28ed9d4cb7d1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090946-clumsily-stuck-0ea2@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8ec06f50ddd8d201bd7e55b896ae28ed9d4cb7d1 Mon Sep 17 00:00:00 2001
From: Daeho Jeong <daehojeong@google.com>
Date: Wed, 19 Aug 2026 11:06:35 -0700
Subject: [PATCH] f2fs: fix to migrate all curseg types during
 free_segment_range

In free_segment_range(), the curseg evacuation loop only iterates up to
NR_CURSEG_PERSIST_TYPE (0..5), missing non-persistent in-memory curseg
types such as CURSEG_COLD_DATA_PINNED and CURSEG_ALL_DATA_ATGC.

Even though these in-memory curseg types are not saved in the on-disk
checkpoint header, they still occupy active physical segments at runtime.
If an active in-memory curseg happens to be allocated within the segment
range being truncated during filesystem shrink, failing to evacuate it
will cause subsequent writes to the curseg attempting out-of-bounds I/O
on the truncated storage range.

Fix this by expanding the curseg evacuation loop upper bound to
NR_CURSEG_TYPE to ensure all active curseg types are safely migrated
out of the target range.

Fixes: d0b9e42ab615 ("f2fs: introduce inmem curseg")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 3215630c353d..5917ee917d87 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2240,7 +2240,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	f2fs_reset_gc_victim_resource(sbi, start, end);
 
 	/* Move out cursegs from the target range */
-	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++) {
+	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++) {
 		err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
 		if (err)
 			goto out;

