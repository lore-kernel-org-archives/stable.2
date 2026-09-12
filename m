Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF3D46EF77
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211798; cv=none; b=Y/WvlNwIEkrkwg63F/NG/lfTDgoECoRDZOe+TlD+Cvvj9U15WkFlORiF5XziTmRjbPN4y5nxn/cPECj0NCo4KlFSrXXPkUfd9z/8isZ9a0k4EWJawsiADXxFcuKo4IDo1TCliWo+VHstq4ARtLVgjD4K+Ak3v9yf1yyFfOTcNJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211798; c=relaxed/simple;
	bh=wpozvOp9P6Uvp/L5bzGQtEYzXOD3t6kPeizd0OJJu/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKSIqVoTX/bdc4qMoL+9DudaOM4kpoRbbPV3T+E+TQvnap7f3RZDBFrkbPUhtH7W+5ISbJs7Okohu8Lhn6g0z5iEzl8ZDzPkCzAcR4qVIEMNQXfOQY6uIpKmmQ/j6poIt6O25X2Jtn0Un3nfofXKjKNu1W1esNq1IxkCnPt+cpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCVrQrv3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCVrQrv3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C7F1F00893;
	Sat, 12 Sep 2026 11:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789211797;
	bh=nM7fHFHRKCp9NhCqMslUkcXzZfoZJ2bLmMrBLQG63zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UCVrQrv30BPW0fc18/ij4QmVpNkdfvPXfS99EuSNRHQBwvGlb81/194bzj5DnuVOL
	 aKmmezmz+6FWJNAO1elCVPqvPdRVtyJ7x5NOmXZ+enDvTuf56ePBDyKSnPr0nHedmQ
	 uV972sfBcMMuT3hjdkwyOxSAxPXQglk3TBvnkrKy9ODmarvrVNLg3xVfu1om2Hs5/N
	 T+L/+okEM9rFCP8ajgThGNQnbNWR/nhVbvegt/leuivU1eFwEWe2ADWMbvSWywef1k
	 bUkvrGHWQrRMtg2RSnCRu4taRmymxzOv5pbaqwCZvlOLfBRYL4uZrH+PHbtDut7qGB
	 prvK13AvqHrBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	Sunmin Jeong <s_min.jeong@samsung.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] f2fs: accurately adjust free_sections during free_segment_range
Date: Sat, 12 Sep 2026 07:16:34 -0400
Message-ID: <20260912111634.2264257-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912111634.2264257-1-sashal@kernel.org>
References: <2026090937-monsoon-alias-8907@gregkh>
 <20260912111634.2264257-1-sashal@kernel.org>
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
[ retained the segno declaration required by the older inline GC loop in free_segment_range(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 687b2ce82c854..bdf9941e8b422 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1992,8 +1992,9 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
 static int free_segment_range(struct f2fs_sb_info *sbi,
 				unsigned int secs, bool gc_only)
 {
-	unsigned int segno, next_inuse, start, end;
+	unsigned int segno, secno, next_inuse, start, end, end_secno;
 	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
+	unsigned int freed_secs = 0;
 	int gc_mode, gc_type;
 	int err = 0;
 	int type;
@@ -2002,6 +2003,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	MAIN_SECS(sbi) -= secs;
 	start = MAIN_SECS(sbi) * sbi->segs_per_sec;
 	end = MAIN_SEGS(sbi) - 1;
+	end_secno = GET_SEC_FROM_SEG(sbi, end);
 
 	mutex_lock(&DIRTY_I(sbi)->seglist_lock);
 	for (gc_mode = 0; gc_mode < MAX_GC_POLICY; gc_mode++)
@@ -2013,6 +2015,14 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
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
@@ -2050,6 +2060,9 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
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

