Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AED631F986
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 03:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788664010; cv=none; b=CyC6UnfQqOO4NQ2CujPCUb6ddQxAKCaAY4h0aOju3t0GMhXcYihA8K4txwxWqlmdcj3KEPoWVoPuspcf6iYd9z7TfMqwh4Fx6bEFMvV5lANuZzpTDOTEAN0y+hs7jhF6tezM067UkbLB1w8bBYQngxAqeZENsJ5mJjtDhsU7YpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788664010; c=relaxed/simple;
	bh=qneqbOtB91EMBafzj+ai2atQIwFrUwyLfeP3WpLSlkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMzEqnLKqY7h/fUkQW1693FgbMFlmrgdFJjWRHPXVai9KkbxHqA98bms8QwGkNqOlP9MyW/w08HBRE56jTpKHjvVJ6POsBNOjXEentfLZz9W676c5i/JxBLOw1rjB25Mro9MveRJ0gtNly+KNh0EEWk2o9aPXG2/XeVf5HDQ17o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=R+fMvkX7; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="R+fMvkX7"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-39b24d114d4so2400541a91.3
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 20:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1788664006; x=1789268806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Q3mxavjTKfNcr8CJEABrzLcot5aK8JH7YWi9DWCL4Q=;
        b=R+fMvkX7Dv/Uj0twLG9Xiq0ZyPCoXULNOhXhvqWNzlBeK6ylw5Tx/fC97cSIHK5/Cz
         kXiXQwt92R2gCQ5NeRwrnn2+YlMWz/wj/n3LhJtT4bM7NITYih7t0mj85YtS1i5DcQPH
         5Gv2MxPBnE6j/IfiFW/hmZlfxM5Zg5wz8Gba4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788664006; x=1789268806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Q3mxavjTKfNcr8CJEABrzLcot5aK8JH7YWi9DWCL4Q=;
        b=SLBXg1n5WyswzY93NuHTK1P0P/VXOZ/r6rgy1vxEOLSHIqfZsv60ogzm7tVbGBHnDM
         6AXzEYsgtCqU7OK+HzWXjKE03TiFA35YpuEulVhVKk69rA2TyrU2fvfxtwlUSvqL7SXi
         VIdfh0nZV+K4iRWNmFlAo/DUYduo914JiX7jXJhSlbsgwOoGsbYhJyCl2VsK38mPVYRF
         oailyvqcwGoXTeYuFLXcZZyXYiA1PdcK9NX68ZikYsAzJn/I24qJrc+J9/4jqf1CAsSm
         Z7C/p3nB/GqyfKEUw4o1Aj25j/OaULomOD27xyM1RO6oNZyTzs0x5hiauPhYlvosna6H
         uNNA==
X-Gm-Message-State: AFuF++kqR3joqyfrPytalgUmDn4AIgRgIctIylu1ey/yPvciIIcYnHcP
	rEdrVZxpMCBHzEl+iyLrJS+riOM765msUMssPeDfCMfBxRYZqZbo0KN6i7Id3IIaH6ZHJEl2Q7e
	liJG0YJE=
X-Gm-Gg: AYBFou2b5GmL/0XSzKt2Gcu2GZtjU1+Rg95J3XNJSWx4lQw/MlWHOQpOqoikoDIl02p
	2z+HuPA6k2uGLXrGC545rUO7bx1l5bcq6VB1k84H+zKp6Y1mxh/bP/+A3Iida6Q2YhKJMkH84rY
	9v+uMiJmGpY0jjA9GphUos25B8SqNjTVHnbXY9s7jdziXBt3IKXQDvAt6BNq2Z86QpyRh0W9hOb
	D4ZGbISlZGUvKdHikLMrvzN2gJ5zxlG2d3ghyZLZt1BV5ndAUdBvOuJoa9DQqds4AMKpDYHL0Sq
	760TPmiTfN6tg6YM6faetafGz1Sr2n+mjP0akHuC+xiI7YAWQNUK8MMj8yCjGKY79Mvz8JZYvAb
	gGkkK9gHar+pwM9qcs+e9lGubETqS7BlhsOLFiywYI8/0f+QbnXplir03PpxHVxLy8HTfYwx7QR
	C1n3ZxveWF37JMF5fYsg1v4wix4b1mOmwDeTgZxpUMl0W9mBGKf5W/hdGcKct4yy6a2o3jMQj9k
	db68+YT6Bt81N+0yqcUaw==
X-Received: by 2002:a17:90a:d644:b0:398:9c00:29ec with SMTP id 98e67ed59e1d1-39b26245cfcmr24799322a91.20.1788664006099;
        Sat, 05 Sep 2026 20:06:46 -0700 (PDT)
Received: from ziggs ([147.46.121.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08d0d845sm19392252a91.17.2026.09.05.20.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 20:06:45 -0700 (PDT)
From: Youngjae Kwon <yjkwon0026@snu.ac.kr>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Youngjae Kwon <yjkwon0026@snu.ac.kr>
Subject: [PATCH 6.12.y v2 2/2] fsnotify: Fix stale object mask after concurrent mark updates
Date: Sun,  6 Sep 2026 12:03:45 +0900
Message-ID: <20260906030345.3332040-2-yjkwon0026@snu.ac.kr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260906030345.3332040-1-yjkwon0026@snu.ac.kr>
References: <CAOQ4uxj0rAj+8S+E=fxiTxym5dRdEJgk9NHE=wJcancfnxLBLA@mail.gmail.com>
 <20260906030345.3332040-1-yjkwon0026@snu.ac.kr>
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
Signed-off-by: Youngjae Kwon <yjkwon0026@snu.ac.kr>
---
 fs/notify/fanotify/fanotify_user.c | 12 +++++++-----
 fs/notify/inotify/inotify_user.c   | 15 +--------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index b89ad128bf09..93472a48ceb3 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1141,16 +1141,18 @@ static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
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
index 657fc36df7ce..024be6cee849 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -539,7 +539,6 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 {
 	struct fsnotify_mark *fsn_mark;
 	struct inotify_inode_mark *i_mark;
-	__u32 old_mask, new_mask;
 	int replace = !(arg & IN_MASK_ADD);
 	int create = (arg & IN_MASK_CREATE);
 	int ret;
@@ -555,27 +554,15 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
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
-		int do_inode = (new_mask & ~READ_ONCE(inode->i_fsnotify_mask));
-
-		/* update the inode with this new fsn_mark */
-		if (dropped || do_inode)
-			fsnotify_recalc_mask(fsn_mark->connector);
-
-	}
+	fsnotify_recalc_mask(fsn_mark->connector);
 
 	/* return the wd */
 	ret = i_mark->wd;
-- 
2.50.1

