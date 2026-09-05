Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FAD23E33D
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 02:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788576281; cv=none; b=lvt7686lp+zw76MxDW4LPbsqkN71h0+jQKO+UF1IU1GYDiyjg3uhTBsY0H3Q1/KR9iT3eB9NAxIRsA3Hr/asH84ZRQmACddJBxsFQBD2osZCm6kxVtnUPO1AfPlHkSvFiALLgWnJ1MJH9dWX6Yfx3J/Y7CFiEivGyJRAXGgdYMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788576281; c=relaxed/simple;
	bh=bVnUZO/8yx+gKV4daQs+yveS2fj36ifI9KVFI5Ole7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XftgiOWkvK+1lh/9JufPg/mPeT2eqrheouy5YB8wGSjyqc4iap/zDfUjYJcbbcxPMTHUAisoaleOuNNqY59B3dlK29sj2/6v3W6S3P8mHRlrCxOWZoG2HN3HGxmAZJHraNT6wAOntgX7AdvWFk2VYLsObL9tFiZN1jQN1arYyyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=QXbvmee4; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="QXbvmee4"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1653004a91.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 19:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1788576278; x=1789181078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VvIi1WHc8Cr7dpWUwouq4h2cevlveUMCG3EPgAoYduc=;
        b=QXbvmee4xq0TYERSWNJj3oEqQZrsKgY0/kHcw/MhT92ZmEvprffLkhwe6ZdIutfCa3
         dvPbMJHWku4yxULZbPaIlksuAuFcRBkkvmOWuaQ3GjjT1C2aEd1nix8/+Zsi1XR1Z6p+
         sp5PG09iRsC6uxvrYQuq2sjARWbkN2CFBXreo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788576278; x=1789181078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VvIi1WHc8Cr7dpWUwouq4h2cevlveUMCG3EPgAoYduc=;
        b=etK3+p/sSuJPpniL6wXAaZZ+84pglM4raw05BfwHobOqnVChDaUzI3CXj/jgvMKfHn
         KObvdn5MXSu0JXDoVzX1elmkXdqBFKqxW7AcsxPX+zs/dlhEBTnFLjVxtZVzCTS37qlx
         6rPOtm/jJ2FHXzZ0Z3HXsQTMA86ROTRjzYVdrKj27s9Rf0VN+qWm1qXjRrK86/GxPDI4
         z3q56M/+ZJYWMzfovIQ/CVGPpbOQ2+fRJ9VO6g9EtNtN+rv/uRRsPa2yzB51OxAjn6nE
         29lTrIjATsNnindBJp37QhTRN8LgP4dmSwIlFohaop8nrInI7zCQVup/P55LUAQ/7FPi
         cg7g==
X-Gm-Message-State: AFuF++n8/pZm+0h6EV1mAxADdTDzpnLIjR40zeXzwx+7wqyGwaGyOlBP
	h/mlH0cvgtJFnA8/ZIgy6NZwFrTEHVEstDq4d0h5zH7VRemCBrRlmxsJjVO2ZT1y8TCh6YMmZn6
	SJ1ToPgY=
X-Gm-Gg: AYBFou20dCLgn2TcvTEUdDnJCi0g2cNXuURekw+du0G+osyCvgR8IKKPhO2FN6HXQTs
	j18hkx/cJb1hI6YMumkInRYF2RTvCuzwM8lhQcMRYtZef8H1kEVwdkyOKsphy//TdI8JkJVDDI1
	OPmEZxjImNy2xcJ8a0oGH4oQUhc/vPFH5QfnyAjlvAcUD3ogfXm7dXGfprUnP26GUaElRgJ6+JP
	thfrWON6laVHiRpNgGN3QO1Jtnax82ggPGABgMBrHJFiiowmSXwUHY8GJlqy5V+St9hkjCFVBiS
	xMFlCy5v3G8YRDLHkJFewzTNd88YGzrC0Ic0GHb2CeOSaTQwrPxkUKbGlLMcc4AeO1GoFgbr07A
	g1Jkc/ik6bvBSpTFSlRAUSU5i36BHKGihK95qQuVGIUP/I97AkvlKhXYVvGwmtyricRW5wVWaPY
	Twf2E+wyqKS5g+n6CSBFw38R3tk7wJIGv31xy7riOdNs8RkYt52hu79Wopwh7DQ/piS1oVXnsjz
	EmgoVZtnxU=
X-Received: by 2002:a17:90b:4fd1:b0:398:bd37:6a49 with SMTP id 98e67ed59e1d1-39b261cfd8cmr14618921a91.12.1788576277649;
        Fri, 04 Sep 2026 19:44:37 -0700 (PDT)
Received: from ziggs ([147.46.121.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08ce4221sm15682346a91.14.2026.09.04.19.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 19:44:37 -0700 (PDT)
From: Youngjae Kwon <yjkwon0026@snu.ac.kr>
To: stable@vger.kernel.org
Cc: Youngjae Kwon <yjkwon0026@snu.ac.kr>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 5.10.y] fsnotify: Fix stale object mask after concurrent mark updates
Date: Sat,  5 Sep 2026 11:44:22 +0900
Message-ID: <20260905024422.3925571-1-yjkwon0026@snu.ac.kr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026090338-buffoon-phony-d532@gregkh>
References: <2026090338-buffoon-phony-d532@gregkh>
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
index 5302313f28be..634de85a2f03 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1114,16 +1114,18 @@ static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
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
index 0b439051951c..40343a15aeb9 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -527,7 +527,6 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 {
 	struct fsnotify_mark *fsn_mark;
 	struct inotify_inode_mark *i_mark;
-	__u32 old_mask, new_mask;
 	int replace = !(arg & IN_MASK_ADD);
 	int create = (arg & IN_MASK_CREATE);
 	int ret;
@@ -543,27 +542,15 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
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

