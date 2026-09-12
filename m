Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFDC18FDDE
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176743; cv=none; b=YnZIClt8bvBEFbvSzpvkRpGRqgWwUd7/kDYhvrgsRUTd+kAjOu42tt3EQB/+zwQqQblwAN6bbI4OL673gVOo1Na4O9AZCv6RYvSBeSu+MgL1ltsz83X95fN1zCEOxmjJGCOBqhAT5Dy95Vdx5o5dhCY6zGQuYeBX+XwscthmtHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176743; c=relaxed/simple;
	bh=AbZXfEiIhKArtL5utZZ4sctOcjI+EUI+Q16ER6FuY0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8Fz01LjtZ1dtMF7uXh4J2FgL/xm34y4lPELzhJ4ED5VGRYKoOn/RSF/xbmzByAdCFNk5b/WRQrDB1frqPWcNClLgGf7+I75k1XPGCRQ5w6PH/GTQ9IHZ0nrbfb34tqcs/yVqOqq93ebBv1iaWNHcA48KS5eW3qW+uLHCgF8+tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=db4hoQyg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="db4hoQyg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D971F00899;
	Sat, 12 Sep 2026 01:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176742;
	bh=IM9Rf6cdBELy8yWXqLX4+zEnru29UySzrNGirWgDgoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=db4hoQygc50TuQCB0DZNeyIfoeP1fHRnFKj66fjuZQZLgxZEQtvmCKFlCrwLQHqcc
	 J83d3kBxEQOc4f+xUa3LcDJ01Z1KP3zbSbrkx8Zu5kt+ssps2pxNW2YDhuDj1I+cif
	 t2d3r675cl4QGnzzcF/HvQRFyOis0gpyVSzV0lwb4WzLuzt7yOcJorFeKMlrf8wZcw
	 cVdbDZaegGWPZEMOb5dvdRc4Sd7FIk8a8Q0L4ug8OJQNuu+9P8ldc/xpfdVud/bVAT
	 +yoJHiR/O9efn3T8ewki5YUW4lLMQ3PANui44fxsAhVZpC0D7G4jVt/+/AdzMvMv4z
	 oYyp010/XD09g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	Sunmin Jeong <s_min.jeong@samsung.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] f2fs: fix to migrate all curseg types during free_segment_range
Date: Fri, 11 Sep 2026 21:32:18 -0400
Message-ID: <20260912013218.1761900-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912013218.1761900-1-sashal@kernel.org>
References: <2026090947-whimsical-pleat-2344@gregkh>
 <20260912013218.1761900-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

[ Upstream commit 8ec06f50ddd8d201bd7e55b896ae28ed9d4cb7d1 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 3ce72db26fe68..0574cbe80b568 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2014,7 +2014,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
 
 	/* Move out cursegs from the target range */
-	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++) {
+	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++) {
 		err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
 		if (err)
 			goto out;
-- 
2.53.0

