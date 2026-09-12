Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B8433ADA7
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 02:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789178867; cv=none; b=jKPs7WSoVFuHp+KS1ghOqAEbHvL+BPV2DKjhJ6J6Mz92+SsfaQ6WgjwwpRTtSxPDWuibz/Z2IrZ7zywZFvfR6sIs3IrTc4vPQ2C2Cy48DCczYKNHfMOzm6/VaAx03qUxvnPRjlG+V20yevso8BOBjdJk7VJ5a7O9zxvo37a//Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789178867; c=relaxed/simple;
	bh=EQ4FHCe9Zox099VDU/793c5IJbsuozFqjoCnIpA2Vo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQrKPFNxXiZ09+Nk4FxeYSyuZ+QPuaOBSQGmKkZNDZbafOGjlIU4xoPZhGR8VLmf+p8qudSGI5slapwtdhoy9YF+qIYzwBQ0r1HERcw8LgJNrm2QEz5LfOPWlz2uyEz1/2LV3FxRrw6dZtqUht2M51M7K+d0BvU9E+OCqZvvM8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGZRHG+I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGZRHG+I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6821F000FF;
	Sat, 12 Sep 2026 02:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789178865;
	bh=gpfXTgpiUDlFhMTroNsCCyQtT0wJR8C92JjWS+sTgTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IGZRHG+ILgfFHj4z7ncNedn3CIo1rhh12PAK9jtPe4aSdTKeLK+FJvWOje+p2az5s
	 eHJWER2yjqNnhmPjl1MX03EvI6JCO7dMqpGFiRbaMq+JkLu174Yq9ihDAD857i1icH
	 CfPVixhbAJnJrd7v/yhlicT9w+PEdu2tW63Ds8aRLQQc3k09Ht9FuJTOWXT+otGF4Q
	 3v7bvcmx9FH1cYlE4hXurPCkZzsHxTH4AJxcMc0npPVNLYXNVllU4N5A87Y5dgyAbr
	 fEyEF70oqPEhtlLIkk0hr+B1VWW7WGK1IzV9vejT2yBnatcIE/u8MFILOsBoxTkqb9
	 MGExOMxM56ePA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	Sunmin Jeong <s_min.jeong@samsung.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] f2fs: accurately adjust free_sections during free_segment_range
Date: Fri, 11 Sep 2026 22:07:43 -0400
Message-ID: <20260912020743.1949179-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090936-harmonica-dagger-40f3@gregkh>
References: <2026090936-harmonica-dagger-40f3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

[ Upstream commit 8c963d1738fdca400082ff5f9d99e083de4f4e70 ]

In free_segment_range(), MAIN_SECS(sbi) is temporarily reduced by `secs`
to restrict block allocation to the safe remaining main area while valid
blocks in the truncated range are evacuated by GC.

However, FREE_I(sbi)->free_sections tracks the total number of free
sections across the whole filesystem. If any sections within the
truncated range were already free upon entering free_segment_range(),
failing to deduct them from free_sections causes the filesystem to
overestimate available free sections in the active, reduced main area.
This leads to inconsistent free section accounting during GC data
migration and can trigger unexpected allocation failures or assertion
errors when space is tight.

Fix this by calculating the number of already-free sections in the
truncated range, deducting them from free_sections upon entering
free_segment_range(), and restoring them on exit.

Fixes: b4b10061ef98 ("f2fs: refactor resize_fs to avoid meta updates in progress")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ retained gc_mode and gc_type declarations needed by the older inline GC reset logic. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 429fc5bd4ae0d..268a31ec87c81 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2170,8 +2170,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 static int free_segment_range(struct f2fs_sb_info *sbi,
 				unsigned int secs, bool dry_run)
 {
-	unsigned int next_inuse, start, end;
+	unsigned int secno, next_inuse, start, end, end_secno;
 	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
+	unsigned int freed_secs = 0;
 	int gc_mode, gc_type;
 	int err = 0;
 	int type;
@@ -2180,6 +2181,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	MAIN_SECS(sbi) -= secs;
 	start = MAIN_SECS(sbi) * SEGS_PER_SEC(sbi);
 	end = MAIN_SEGS(sbi) - 1;
+	end_secno = GET_SEC_FROM_SEG(sbi, end);
 
 	mutex_lock(&DIRTY_I(sbi)->seglist_lock);
 	for (gc_mode = 0; gc_mode < MAX_GC_POLICY; gc_mode++)
@@ -2191,6 +2193,14 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 			sbi->next_victim_seg[gc_type] = NULL_SEGNO;
 	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
 
+	spin_lock(&FREE_I(sbi)->segmap_lock);
+	for (secno = MAIN_SECS(sbi); secno <= end_secno; secno++) {
+		if (!test_bit(secno, FREE_I(sbi)->free_secmap))
+			freed_secs++;
+	}
+	FREE_I(sbi)->free_sections -= freed_secs;
+	spin_unlock(&FREE_I(sbi)->segmap_lock);
+
 	/* Move out cursegs from the target range */
 	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++) {
 		err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
@@ -2215,6 +2225,9 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 		f2fs_bug_on(sbi, 1);
 	}
 out:
+	spin_lock(&FREE_I(sbi)->segmap_lock);
+	FREE_I(sbi)->free_sections += freed_secs;
+	spin_unlock(&FREE_I(sbi)->segmap_lock);
 	MAIN_SECS(sbi) += secs;
 	return err;
 }
-- 
2.53.0

