Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476A2282F10
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 02:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788576432; cv=none; b=SEb2IsJNBKX3hkZjr1cuiddmO0Foni+8Fbfnm+k40IhF4nxaacJjeEmMdIOav2somTokv90GSLiPFYrUXUb4ATRefpjy+9IJ8sz4hY9NfgmftjFl3pbtU9YmDtnBQ+mSsM9mfRXgHOcluDicPPtDPl4iKNzEZ8qohES9UMTbxEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788576432; c=relaxed/simple;
	bh=VUyPBgA/PuEuv/BfriDlOr0mSMNOR947GXCBblDMj4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4Ozq4fvS/A+3zCTpFbWAABLmNoFc+iF1F8moPf6KdhSy0YBHzbQo63TWs1iwy/c2G2r46mrrymhLdZG8GbnvdZiHKqpiJ0PriJ/pgaxoioJEZ5zcHn1v/4ziby00xVSTqPqWmxlohudozgQjCvsyLIN+F9I5jchwoYsq2s/fSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=D839qn02; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="D839qn02"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c9e7391839cso1617967a12.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 19:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1788576429; x=1789181229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gjUEkxsbbAZyKS8ypaA4jfF8OljhBqLmyu+cfzQ1ubc=;
        b=D839qn02+441jnGrB8WXwxI+iQJjQO4/8D/nvUvjCcP0RRPctRRKS/3oimUkg99gRe
         5At7ge916h0EBxpCuGZZb3CsARrtK/ayvuYDnY8PqbqoLdDFhSt675YYMZAxB0X6Tklr
         COcY3IG/Log4uSVkln3gi1fLrauK7CzbfOjyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788576429; x=1789181229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gjUEkxsbbAZyKS8ypaA4jfF8OljhBqLmyu+cfzQ1ubc=;
        b=BR7NkXHcA+eoGYQsmeqNkYGmQ00TnnsjazwJ/JgzlBWrD44uBVLT6Bvdy1sUQi7yqv
         ikcXZ+6OCcmDGHYkmb8uzNLLC0nvOaon7Gra29budywjpkgERrbMjsASDK/C/SFyyZHE
         KqqNPN6hZ3uHccUaWh2fMoWEmFX+VgTlDAagjCBNWLoHxcHmOoWR0/IDauoL8QriHvFD
         OItLYpaPdA7IdB08lYEZWpZk5oRjbdQ3xreXqNLpuCUye9FbHE1exvTJ3djDBjc7i1gD
         KAvj5FX66wGtM4BXNbnPP7tjY228C/HtWjvkjsgRhh3uEjHkLFTAU6mkiJYPrV7yhhlv
         krTA==
X-Gm-Message-State: AFuF++k1QpEWwrUxtCpWWliiIzgs975+5qkGjDM0rsVGPJjF8bA5mt1K
	KzSinxnrPSapfLUogVS0UhaLNimNQ7qQ9pD7C423JHsSNDnPHyQB30D2HUuRvVzBagWhbd7t0oj
	NsSQWito=
X-Gm-Gg: AYBFou2XET80W1dJDxykGvA2DzjoETYjmwtPA9ocfpIIGYy/CC/F00UgIDx0k28Zp8Y
	GbH2jq3D4bjYkrkM31ON6gBdoWgj3GsY09jp0Ztw0nNpXZTomfJIhAVjzF6e0QYlPlfnViVNs95
	rfg7NKZ1QleOvKkmsGfxZEUCiC8nEyyc0Q9CAUUuYfXgbiYjAW1HeFH5wYDGyvp70bHaq+JyY3+
	nIBsBzxNwUrDbtUlX4CXltNf7fCf0flaM1slwwG7AM/0Rif0Aehg8AsNGNM1euKngTHzp6YgARX
	uJAjI2BU1z9e2R2n2M35E9nOekb1cYtGhJKnzIEVP/Ty6RMij3RYCiyXLVWC/liEarCMJDeTq6M
	fyPFKQGYXkgY4Pq3a1HGDu9NS9ws9YzV+5mDc2LpHAA2DNpmnTPWJUvOryR9vTpM8czg4wcCQj4
	qIPrbGKWOoVeDfZsy5EhnMgFFQcwiJ284CCgk8PNOXfy3A5SqbXCRuBX9cEnx10ycT+B6OFoWpX
	k2lwYlUhq8=
X-Received: by 2002:a17:90b:2e0e:b0:398:9be5:b419 with SMTP id 98e67ed59e1d1-39b2622bfecmr15237777a91.20.1788576429362;
        Fri, 04 Sep 2026 19:47:09 -0700 (PDT)
Received: from ziggs ([147.46.121.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b26127fddsm7017409a91.12.2026.09.04.19.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 19:47:07 -0700 (PDT)
From: Youngjae Kwon <yjkwon0026@snu.ac.kr>
To: stable@vger.kernel.org
Cc: Youngjae Kwon <yjkwon0026@snu.ac.kr>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 6.6.y] fsnotify: Fix stale object mask after concurrent mark updates
Date: Sat,  5 Sep 2026 11:46:42 +0900
Message-ID: <20260905024642.3937399-1-yjkwon0026@snu.ac.kr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026090336-dance-salaried-2815@gregkh>
References: <2026090336-dance-salaried-2815@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit e422777fdd4746de1109575c51e65038d4c5c1be ]

When a mark gets a new event bit, fanotify and inotify may avoid
recalculating the object mask if the cached aggregate already contains that
bit. This is racy with a recalculation triggered by a concurrent update to
another mark on the same connector.

The concurrent scan can read the mark before the new bit is added, while
the updater reads the old aggregate before that scan publishes its result.
The updater then skips recalculation and the scan publishes a mask without
the bit, leaving the object mask stale after both updates complete.

This can be reproduced with two fanotify groups watching the same inode:
one thread removes FAN_MODIFY from one existing mark while another thread
adds FAN_MODIFY to the other mark. After both fanotify_mark() calls return,
writes can fail to produce FAN_MODIFY for the group whose mark now contains
the bit. This was reproduced on an unmodified v6.12.95 kernel. The
equivalent inotify interleaving loses IN_MODIFY events.

For normal fanotify additions, recalculate whenever the raw mark mask
changes. The normal mask is not cleared asynchronously, so an unchanged
addition cannot introduce missing interest. Always recalculate ignore-mask
updates because FS_MODIFY handling may clear the ignore mask without taking
mark->lock, making snapshot comparisons unreliable.

Always recalculate after updating an existing inotify watch. Its replace
path temporarily sets mark->mask to zero, so a concurrent scan can observe
zero even when the old and final masks are equal. Assigning the replacement
mask directly would avoid the transient zero, but existing-watch updates
are infrequent, so unconditional recalculation is simpler.

Link: https://lore.kernel.org/all/CACwKKmCZdiZDoFuYm6LZhQ=XvHPk0fNKH=X3LmoXMqakYqJaNw@mail.gmail.com/
Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
Fixes: 912ee3946c5e ("fanotify: do not call fanotify_update_object_mask in fanotify_add_mark")
Cc: stable@vger.kernel.org # needs adjustments for <= 7.0
Suggested-by: Jan Kara <jack@suse.cz>
Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Youngjae Kwon <yjkwon0026@snu.ac.kr>
Link: https://patch.msgid.link/20260802015801.2426818-1-yjkwon0026@snu.ac.kr
Signed-off-by: Jan Kara <jack@suse.cz>
(cherry picked from commit e422777fdd4746de1109575c51e65038d4c5c1be)
[yjkwon0026: Resolve the inotify conflict by retaining the branch-native
inode->i_fsnotify_marks argument to fsnotify_recalc_mask(). This tree
lacks 35ceae44742e ("fsnotify: Avoid data race between
fsnotify_recalc_mask() and fsnotify_object_watched()") and
4520b96b8136 ("fsnotify: inotify: pass mark connector to
fsnotify_recalc_mask()"). The differing READ_ONCE() line and connector
call are in the conditional deleted by this patch, so neither commit is
a prerequisite for this fix.]
Signed-off-by: Youngjae Kwon <yjkwon0026@snu.ac.kr>
---
 fs/notify/fanotify/fanotify_user.c | 12 +++++++-----
 fs/notify/inotify/inotify_user.c   | 15 +--------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index f4798d613dc2..763ca835d8fd 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1186,16 +1186,18 @@ static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
 static bool fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
 				      __u32 mask, unsigned int fan_flags)
 {
+	__u32 old_mask;
 	bool recalc;
 
 	spin_lock(&fsn_mark->lock);
-	if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS))
+	if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS)) {
+		old_mask = fsn_mark->mask;
 		fsn_mark->mask |= mask;
-	else
+		recalc = old_mask != fsn_mark->mask;
+	} else {
 		fsn_mark->ignore_mask |= mask;
-
-	recalc = fsnotify_calc_mask(fsn_mark) &
-		~fsnotify_conn_mask(fsn_mark->connector);
+		recalc = true;
+	}
 
 	recalc |= fanotify_mark_update_flags(fsn_mark, fan_flags);
 	spin_unlock(&fsn_mark->lock);
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 804af9d6078b..b2c75477f549 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -540,7 +540,6 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 {
 	struct fsnotify_mark *fsn_mark;
 	struct inotify_inode_mark *i_mark;
-	__u32 old_mask, new_mask;
 	int replace = !(arg & IN_MASK_ADD);
 	int create = (arg & IN_MASK_CREATE);
 	int ret;
@@ -556,27 +555,15 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 	i_mark = container_of(fsn_mark, struct inotify_inode_mark, fsn_mark);
 
 	spin_lock(&fsn_mark->lock);
-	old_mask = fsn_mark->mask;
 	if (replace) {
 		fsn_mark->mask = 0;
 		fsn_mark->flags &= ~INOTIFY_MARK_FLAGS;
 	}
 	fsn_mark->mask |= inotify_arg_to_mask(inode, arg);
 	fsn_mark->flags |= inotify_arg_to_flags(arg);
-	new_mask = fsn_mark->mask;
 	spin_unlock(&fsn_mark->lock);
 
-	if (old_mask != new_mask) {
-		/* more bits in old than in new? */
-		int dropped = (old_mask & ~new_mask);
-		/* more bits in this fsn_mark than the inode's mask? */
-		int do_inode = (new_mask & ~inode->i_fsnotify_mask);
-
-		/* update the inode with this new fsn_mark */
-		if (dropped || do_inode)
-			fsnotify_recalc_mask(inode->i_fsnotify_marks);
-
-	}
+	fsnotify_recalc_mask(inode->i_fsnotify_marks);
 
 	/* return the wd */
 	ret = i_mark->wd;
-- 
2.50.1

