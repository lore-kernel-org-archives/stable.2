Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D3437DAD7
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 02:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788577180; cv=none; b=baATBzAyAe6TDE1gHFJYbThVLDPjCmJZ6yVGyu98fd68tFM3Rl/Y2ERtKav35lOfhBVkcU7d118Y7GDgEL3VIEvEPFq5Z9uKZA4mDQmFM0bZyf0MBPMwGsTtCHRobT9OK7PtJz93gVK04aXTl+mAYT3ClZVT1PSZ0Ub7svTP4KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788577180; c=relaxed/simple;
	bh=uqvr3x/4j3yoG+j8KtsOywutOn0JGXf13AfNdB4lq/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyiZf/IzvI8QZoNmcFFEErJcqsxFyLcxtZgRQaTDr3rbwL4fz4/1JXgqrsmDW6zY7y/naSn7Ac+/mQxOHOVZFFImJ1YL/1p3Gzyozexi4l9FckmGkP62o0R08TXCV8wZ5pp47wvkc4QNG2aPIlHU/sSvYyxhyY/+tlYo/uGKCX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=tQfvHNg5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="tQfvHNg5"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ceab75934dso15547785ad.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 19:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1788577177; x=1789181977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kk4O0VHGSJCrGtgBsAhx1zb3r1j7LGkzd6vjwM8Qoqs=;
        b=tQfvHNg5S4+7ilpW7pX+wj9N0kMlYP0uNydVSvGHuQXZqW3DLvcdDAN6YGkcqJnNOz
         clD5Sq0bBMbD4HFuUUyxL8yPZIJFbtbiilhW20UbeGnoxrSIH5eKSI+knnHxTFvfTQN/
         kNqstyQht3GQB4yQflGvFYsJ3TdBwGZbKehwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788577177; x=1789181977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kk4O0VHGSJCrGtgBsAhx1zb3r1j7LGkzd6vjwM8Qoqs=;
        b=bXnDkJ0PMrCQP2JQyRfnygWXDtSWC6zcB5n92E0oszkkzGlxdsR/3FGWriBMsJ4FzU
         KnC6+By0WLvQsfUFMiE6AthI0IrK0d529H3kBkhJBUUhxpLNByiKWit/mGC4PVfLQXO6
         Fh4ckNIceTQW0tEAW6nysUfMPt9CtuXzJLW1ZKpIzmROz8LELIZNVBODV5Dj9ElheFz6
         6KXMQnxu8cSiJqj/TGtKFt+VMOMyjVGIkt3mT0bDLKjNtnqkvd9No0Ivtri+wEaW9gNx
         tCPtTMuss8dpVfqeVOyQHm3qaoEn+1W48qqimUXvKlqobOmFv65Bu6zhO+8nRLY1STeN
         utng==
X-Gm-Message-State: AFuF++nIW6Q+/mA4KBc9oAs424pKHNxfRTAC52VtIUVRcz4/B32inzdA
	hmp2EoujxwAhYhTad7BvnRfs3NuGwtUy5FsCfZAnN+y9KSU3Fdx/20Y9nu/iU2D/mdPZgP1E/WH
	bRFgcYtk=
X-Gm-Gg: AYBFou0f4pmQ3+AY9tzP0Id3vGJTcwzatLxOOzWc86yhX0tZlyp5zn0+aufV/7yag/z
	FbWmPeyOAlS0ETQqSB+OVJjFpHsdgcewy81jP2uJd2cUV5HLtH84ScX807YvkIs4OQNu23CQ3Ed
	Y/MQiCTkXmP1kybCS40n+A7ty98R13RO+BMOJoDOSDELTfd7vtLCTCl/RtICebxj0jajD80kKgF
	2WPDyvHEUXd/yGNjTNx+OvjjmdaZovZw1DJBcnQ3NRMqTn3Q2W3/8DtuWfswxaU8CxKxc3ERXBR
	d8UrI/0faJaJKbYzYElkI1IzgmQROb7GrcUBVeH5t0H+2vd7EvmizWmwqFWVTDS+7rOIqnfBWc5
	B+3DMUnwZS5yu1rFwDTIc6dHjSeYIUGyUtjmpi+lobik+LIpU3xgPuRQOB94u89SO1aBcTD8YEo
	7C2kAxiyTG/duyZetXHzAhvVWBMzjABZLjoSp4g7RlECwEmp16bemjUceflK9KxTWABF39vZT6H
	iItLL/Uwu0=
X-Received: by 2002:a17:902:f64d:b0:2ca:e19c:986 with SMTP id d9443c01a7336-2db125c83dfmr152133115ad.1.1788577176814;
        Fri, 04 Sep 2026 19:59:36 -0700 (PDT)
Received: from ziggs ([147.46.121.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1495a0b2sm16273665ad.28.2026.09.04.19.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 19:59:36 -0700 (PDT)
From: Youngjae Kwon <yjkwon0026@snu.ac.kr>
To: stable@vger.kernel.org
Cc: Youngjae Kwon <yjkwon0026@snu.ac.kr>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 5.15.y] fsnotify: Fix stale object mask after concurrent mark updates
Date: Sat,  5 Sep 2026 11:59:13 +0900
Message-ID: <20260905025913.4000679-1-yjkwon0026@snu.ac.kr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026090337-tingly-mower-d4c9@gregkh>
References: <2026090337-tingly-mower-d4c9@gregkh>
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
index d93418f21386..1abbb30bd0d9 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1122,16 +1122,18 @@ static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
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
index fd5febf09ab0..9e46895269d8 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -532,7 +532,6 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 {
 	struct fsnotify_mark *fsn_mark;
 	struct inotify_inode_mark *i_mark;
-	__u32 old_mask, new_mask;
 	int replace = !(arg & IN_MASK_ADD);
 	int create = (arg & IN_MASK_CREATE);
 	int ret;
@@ -548,27 +547,15 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
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

