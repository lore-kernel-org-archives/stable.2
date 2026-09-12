Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD07430F924
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 02:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789179739; cv=none; b=dxjzjo40Q7ajuXWgCDq+as7qyKO9NdAhT7UL4nWiCmmzE2tQDtudfqfVAQu1ASH3yNJBQYaz7dg9x5ExoIhh0N4SwggSU4riw8FGveweG1gYMwzjMqOLQekanHsyFeajGITsuIWzts1UQGBQpu6185Zp8rY1oaWfg+26pldkvD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789179739; c=relaxed/simple;
	bh=jdyx0zJ2DKOsbeNSolEtKsQd5mg+CXC18gPYetcUlXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsAYF/LQzQb/BXSgcusasPss26g7z9gy3scclXgWnbptn8BzB7RMjaQjvb+aDm2O3tH53m22c24107/NaiE+KhLxU0YV9XRp0xghziCAygYEgPcP3nhpfWz9hhOBwmCNiGxAiIzc9Qm3+HD3RASM0g/2HlqD9IuVZR0S38WNdLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbGDmyOC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbGDmyOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B381F000FF;
	Sat, 12 Sep 2026 02:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789179737;
	bh=vS9H0N9cFx1fLrtBa5P3TtEzcTMSK9fEqZNwvmygSfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dbGDmyOC6+ThsnEq2fZuLXPx90BN7zfSLAuQYTfRAHbkkD8D3Z8ncBZltpxt1GBua
	 3HdaHao4dGzrIeOC74ldcBmA0UDL4dl+5Ki8+bMaoiBSwhSM57d2FSLNlj3a0WLRG6
	 XG0YSGEFjlC9RPBENCjkvY7NkUqLTh0E1g0zOMCljABOyE/A9KDSabCgPWaz71h/dT
	 o6EAHfvV9/IrT61sbE1a6JXSaTTps3u347+Z1Vhe9ISE0blzwjCx4T6xwBkn54ECrU
	 boFJ4fw9e0chNWA+34o7DwFv27H/j4DsgIqwL4G7DHhu8nyLTswUOmVNLry1yzOTwl
	 VQSDl/23fDzlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	Sunmin Jeong <s_min.jeong@samsung.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] f2fs: accurately adjust free_sections during free_segment_range
Date: Fri, 11 Sep 2026 22:22:15 -0400
Message-ID: <20260912022215.1969281-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090936-revert-steersman-98a8@gregkh>
References: <2026090936-revert-steersman-98a8@gregkh>
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
index ac21950f53cd2..9de8ccad2212f 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2076,8 +2076,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
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
@@ -2086,6 +2087,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	MAIN_SECS(sbi) -= secs;
 	start = MAIN_SECS(sbi) * SEGS_PER_SEC(sbi);
 	end = MAIN_SEGS(sbi) - 1;
+	end_secno = GET_SEC_FROM_SEG(sbi, end);
 
 	mutex_lock(&DIRTY_I(sbi)->seglist_lock);
 	for (gc_mode = 0; gc_mode < MAX_GC_POLICY; gc_mode++)
@@ -2097,6 +2099,14 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
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
 	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++)
 		f2fs_allocate_segment_for_resize(sbi, type, start, end);
@@ -2118,6 +2128,9 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
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

