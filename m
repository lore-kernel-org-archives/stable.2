Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD65C357CE0
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 22:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164032; cv=none; b=paH1BY+c4cj/T/DJb7j5UxvoA7/Mtwn/+QEIl2TFJUPuXqHR2yw79uGI/zraBi+ffXIfexqp125GqTyCr638TFQWkDdW4UNra64J9ClFAjtFT7PHei277nYAKv5hPN6/l+N3QWZe9mp00Z+BwpYY+gKzV36hLCeKkyhsYLL+NMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164032; c=relaxed/simple;
	bh=lJ1lYqw6ZK05sdDI0vNfIMfLuC3kmT5V1OzEJX2N9tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOZ8YUR2wnnH3EL5z9sDKza4ZH1mZzOemPdTMkwrTaGoeFVt3k8fF3H1KETmrW2HwxXuonrYHH3XK6ppE6CH878VcoBFmD83ymvF4GkUw5N7ZRjsxiaZDq4CcCkmurFVtNxUXc/RIyXzqfnJVIiBBpcHHxg/QL7WufYx80BFR4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfIUIB9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfIUIB9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBABA1F0089C;
	Fri, 11 Sep 2026 22:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789164030;
	bh=La17p5oxq8xNbXofbuaLhNBa0BEtM+DReBYYpPumGRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GfIUIB9xsxLE9czRfVyDxzFixrjrMJ5/2PjDWAMAF1FBqkrzvK8/8sSNaOKdePLWl
	 +riBIuFN/RI7wPLNK6UAlxFW7n2imeCDby1GfX0eY8+P5rBIi5tf0T/bcrlrsX4WU3
	 wW4HvIM5gPh4lpZuc2453iJynyxRXzPlZmcm41pcexyZomlWFC9YvNopaYJ+oS7Lw6
	 4UuzqdZhRc1upRoq7sVsgkdLXPNWqPAyH34WugUEyb0L8nmQpWmeOXlPFbUGQqQd9k
	 L/SCCp8arUCWuq5FOIGlh2BUHWk0kWjQuHfEZODmD3kvKktmFd9zaKsM1mLm2Upg4g
	 KMsvbT2uMKLmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	Sunmin Jeong <s_min.jeong@samsung.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] f2fs: fix to migrate all curseg types during free_segment_range
Date: Fri, 11 Sep 2026 18:00:25 -0400
Message-ID: <20260911220025.1624949-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911220025.1624949-1-sashal@kernel.org>
References: <2026090946-clumsily-stuck-0ea2@gregkh>
 <20260911220025.1624949-1-sashal@kernel.org>
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
index 115b6d6c6bc7a..edeb111c47569 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2103,7 +2103,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
 
 	/* Move out cursegs from the target range */
-	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++) {
+	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++) {
 		err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
 		if (err)
 			goto out;
-- 
2.53.0

