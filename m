Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A15533593
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954308; cv=none; b=Kw8hKBA2Tv0Dtpag/YrhfzTQNzCa0NR0ZjMAl8JNSi6cKNzC7W23y/ltj+RlRWfUSVpaOAXULYBtZZWIl0uHEcxyqr8iecGcYWckrZVe2z5SHgZ118gC/+5R4q4pe5TjAVuF2Xz8IDDN13yBoMh6ggsbQ3T5wDxND3DvtgiyhyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954308; c=relaxed/simple;
	bh=xNrAYV7mwiblDyKyY6LiNG/USbkESZnDi39KxbsOHkw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=agvASxmRAGeyIIF/4hhPzbMCzEL3dNbbNP+hKRxeZ+en57rmcmkikiZGWQ483v6+4t3aKNWH1GdGrAt141dCHUS3bpeNU9cvWFi5UEcNwkVuETv+OcaMVW2+MZtHIAbH2MVjVV/MB3i81bVfGtvxZLWtyuLwpY/YF5FjfAjWi5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mLvj6Ij3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mLvj6Ij3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342951F00A3A;
	Wed,  9 Sep 2026 11:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954306;
	bh=YgutB+Dp3FVe8aKqLC9rHZE++lr95OZKLCBsHIXx1/A=;
	h=Subject:To:Cc:From:Date;
	b=mLvj6Ij3+DX/rN6rJJvabpGe8waucDztSalqmHrETDp5Bl4Fp8whnJCHoQ2OpYUS9
	 hy7kytAKiC9qHIRKH9B4YAi/15TWnuZa7XZUqaGDe3/H1QEzXYcfVh7db1VUlmJWv5
	 d74Co98L9HjX2FcXd94wbwVHyWgkqq5SoRwTYFKc=
Subject: FAILED: patch "[PATCH] f2fs: accurately adjust free_sections during" failed to apply to 6.1-stable tree
To: daehojeong@google.com,chao@kernel.org,jaegeuk@kernel.org,s_min.jeong@samsung.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:28:37 +0200
Message-ID: <2026090937-monsoon-alias-8907@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8c963d1738fdca400082ff5f9d99e083de4f4e70
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090937-monsoon-alias-8907@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8c963d1738fdca400082ff5f9d99e083de4f4e70 Mon Sep 17 00:00:00 2001
From: Daeho Jeong <daehojeong@google.com>
Date: Mon, 24 Aug 2026 18:53:03 -0700
Subject: [PATCH] f2fs: accurately adjust free_sections during
 free_segment_range

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

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 0c17038fcfd7..0a00180c21dc 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2231,17 +2231,27 @@ void f2fs_reset_gc_victim_resource(struct f2fs_sb_info *sbi,
 static int free_segment_range(struct f2fs_sb_info *sbi,
 				unsigned int secs, bool dry_run)
 {
-	unsigned int next_inuse, start, end;
+	unsigned int secno, next_inuse, start, end, end_secno;
 	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
+	unsigned int freed_secs = 0;
 	int err = 0;
 	int type;
 
 	MAIN_SECS(sbi) -= secs;
 	start = MAIN_SECS(sbi) * SEGS_PER_SEC(sbi);
 	end = MAIN_SEGS(sbi) - 1;
+	end_secno = GET_SEC_FROM_SEG(sbi, end);
 
 	f2fs_reset_gc_victim_resource(sbi, start, end);
 
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
@@ -2266,6 +2276,9 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 		f2fs_bug_on(sbi, 1);
 	}
 out:
+	spin_lock(&FREE_I(sbi)->segmap_lock);
+	FREE_I(sbi)->free_sections += freed_secs;
+	spin_unlock(&FREE_I(sbi)->segmap_lock);
 	MAIN_SECS(sbi) += secs;
 	return err;
 }

