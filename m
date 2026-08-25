Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9571C33EB17
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 01:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787622789; cv=none; b=Gq6QUtTLkCY86vJVKkbfr+euXuQ77kMyZxa3nALOsw6dj5VX73O3PO7Fl99ZkzK5PV4wPTviKhJ6/x02qf9d8vytOYmhWz9CdJ+YN8J3amsNz9Dyj2ClZHY/cBk+YaKNc4obuxqi0RgiGAi6giDfetr+VZVt7Sr7sdd6u4t4qlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787622789; c=relaxed/simple;
	bh=jXDGijM1as3n6zotAUrKe6KiqlZyTL1tQUlOYk/3aq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hj6yE0xv4tI6iyZMKvcV5FqOYIFLO04sqfzcAVrr1paOnb6DfngVv949rjnI2vqP5+ITielPnlPW5Cl2PQ+F5NaX8V+GUZClMCJfMAVfLPdm/B3WiDy4eCEVkIxsCZJJEbpxbLWx+TZ+5CnDNJGO7Q/lSVDDUEG02dBvrPXAgzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nytisMmG; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nytisMmG"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3900e39d935so4519488a91.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 18:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787622788; x=1788227588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ksJHKJAw5R8WRBPibc1ESESDe+ccf9OaKGAn1jN9/4=;
        b=nytisMmGbONt73itc1dkw8JS4BhlLGYPHf7HKQdkR89iyE9Lx0/JtdvhsM41btnsm4
         ow5zuHR2R6Ux177rIN/phzo1I5b5tu344f62T2QcJ8itLgXJm/AYv8aagHcByN3Ri/qJ
         K9G8DOlYa0Off3IusVaU9OFVVH4/5jBVexSBHhCFpZgj/rhheSnY6XoGR5vqJ8S6vaCJ
         30+EPb9GpIX7Gv7E7driYsgqHqLKnKJtVWefNywf0BGjXhnbQXLOWLBKQjqw8CpuypxY
         qSm9cSgrTiu0VIQJLJAjuIEvuZ/7WbYUFuglpOLzVxXZM7K6wT0qA2ivHFuH9coZtkd6
         +BoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787622788; x=1788227588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ksJHKJAw5R8WRBPibc1ESESDe+ccf9OaKGAn1jN9/4=;
        b=YGEjFE4M91cjKEOVKXpqxBk/Ni2I5K6PvI3T4Qdr9/FIQFLNA4eGEGIfUVjt57nemr
         es07pL41L8sQpfHxsTgDvIItgtefZ7EVDFVJ94StwmskN5/S098aDigZL0tj5V02MZyu
         hfDGO9Se2ZbdP8Pxzg1VwaIM+a4HDqZl8xh1n+7uos0OtR0kDVo0LAyWwuy1XrbtPShq
         2MSM+ZI8kutMMWRe3o/QyWLadQlB7WdbCtr1o9hzZjuZigJ1R+PGXvJ0RD0u6DYknUaR
         jBTUNggPIr+wzd34dLF/YTEFWtMSPmt7/ui7d097y8F3aECBBGNEePyS9T98R1kq9s7q
         03xg==
X-Forwarded-Encrypted: i=1; AHgh+RqI1lEcJlavWR+sC+6LPSdSwelHw5Chg0Q29I9DnCy1JCQLNPIs/LtcV/qo9l6Jp9/XDwCSxN8=@vger.kernel.org
X-Gm-Message-State: AFuF++lT2fAUAZylPtLm+s1rwtx6oigjghrfSPT4ncgiKyI8bmwhx3Ya
	r45E5aadS6umQqRTJIJo4VcZVBWNzyolsK+CP8VX56OXi/G0tPLyEF8P
X-Gm-Gg: AR+sD11FBHzrdLB6GQ336fnTdYyQ9j7+aqr/vkfzarrVUqKc3Fdn8900DzyExzxH4f6
	MCQdPd/cm/ChGGODRJCmEA6xRKaCfNT6RtaigE7XOR8EPsZguZc2o/oNnGxgrwS6tikabQxPj7Q
	16Pt+IMeHPRp2uGnkEFxII3rUQ/CQQZG7W42mgDSf9cJ/C712cue2ywhFMtv8zZPvTJKHvPtwcm
	D2d1q0I9osHMHtGcdfxNlwTPAyNrWSNL9nPFJS0Y5KuW91OeidwNivMj5Ow/uHqaSGu7bAhKsXT
	Ez9zPqKTVvIhfOwpq12ysv7qk9mSr/pf8cTilk6/673u8NuuF5pOKHqtkPbnLOP+AwiASZWKkKK
	epVI0XdxUVBaNCZEtPQfG6aGaaI+e6pf4qQAWQB9pBtI4IzRcURWxzrGLSqSKIfd7eq+MK6oUzB
	s0ThO42lfYOD9F3jnKuDdZ2SGjC5aibV1c3GZkoP6ymz3+byC/CUAXX2tS/XCf620nmjtmsNFLc
	7lRCCPYiYZUjpkKtzCo+thY7OmLtOyjBNHtb4mtAXruTlUqFRM/uO2Dqjb4QUTv3g8gj+EZU9jl
	qlawHZ5PU8TC
X-Received: by 2002:a17:90b:3911:b0:38e:2860:253f with SMTP id 98e67ed59e1d1-395df2926d9mr39684897a91.12.1787622787801;
        Mon, 24 Aug 2026 18:53:07 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e7c:8:8d79:bdf4:eb94:2cab])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f9236166sm30514662eec.28.2026.08.24.18.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 18:53:06 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>,
	stable@vger.kernel.org,
	Sunmin Jeong <s_min.jeong@samsung.com>
Subject: [PATCH v2] f2fs: accurately adjust free_sections during free_segment_range
Date: Mon, 24 Aug 2026 18:53:03 -0700
Message-ID: <20260825015303.2082221-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

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
---
v2: elaborate on the issue in the commit message.
---
 fs/f2fs/gc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 787133ee2eb2..f3a6fc6d08ae 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2200,8 +2200,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
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
@@ -2210,6 +2211,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	MAIN_SECS(sbi) -= secs;
 	start = MAIN_SECS(sbi) * SEGS_PER_SEC(sbi);
 	end = MAIN_SEGS(sbi) - 1;
+	end_secno = GET_SEC_FROM_SEG(sbi, end);
 
 	mutex_lock(&DIRTY_I(sbi)->seglist_lock);
 	for (gc_mode = 0; gc_mode < MAX_GC_POLICY; gc_mode++)
@@ -2221,6 +2223,14 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
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
@@ -2245,6 +2255,9 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
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
2.55.0.860.g4b6b3295ed-goog

