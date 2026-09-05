Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882B9337688
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 02:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788576086; cv=none; b=s2GoWAJJC3BzkLFzXPTiqIxI6z5ZnYtfVN5xsk1v7YDlkNyTLTIzfBjXm9q8duEMpDIFc7cG6Fcj8frgJ/fTd7H1RSjiT/IHaI+jadjq3F2JNCUez6rJouXkpgTsIpPwTdkYIOY9NbnnZOOCIPVUXCLrZY3QGJF6EG6ZZE45tBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788576086; c=relaxed/simple;
	bh=uqvr3x/4j3yoG+j8KtsOywutOn0JGXf13AfNdB4lq/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YGKPFiXyWjc/mpqE+WVc8ICRxqeBjWnf977Dk/X50fb0gReH5DH+0yQ+tsAi1jUXlhhyJC8GIFrLAFLnigwBQlLf+Jkd4DOY1fTCLbDZFc7H1XCQtLs/8r+bwI76wecHiYg7Rj7xvbIbtpR0OGjM9JGQa7Ma3D0wh27C5rMxgxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=kAk4o92Q; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="kAk4o92Q"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso1553870a12.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 19:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1788576080; x=1789180880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kk4O0VHGSJCrGtgBsAhx1zb3r1j7LGkzd6vjwM8Qoqs=;
        b=kAk4o92QWL38LKTXcOn8xfb+nm04uxaAfLJurgkugABxyDoZW059lgcz/KwcTvee9S
         DLnBVFsHodPDBfQ++mTgNopKhvWb61x2dMM1n29Pna2141MCpdkldM3FsO6Gz5BqQvOE
         xwq2nRwqRoi5t3g3yxjBnmlnf++O/y39yEjcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788576080; x=1789180880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kk4O0VHGSJCrGtgBsAhx1zb3r1j7LGkzd6vjwM8Qoqs=;
        b=I8fWI0PcdN/lxG0Zf6bN+yMm1aVOH2oSS5bFu7HhHgXYYnM7ly9NTGUAAuaUYv3LgJ
         /POJ3Bx+Yteei78GjLTr+/gu+fHmkZlsPZQkc6xcowzGbM065ZSf6vo809uMTcWdmkHI
         BtL82e/WYtDMuemaOeGDRXJ1hOZj3dD2lMH8cG0Pox2RxaYUhJCXugWjzstt79nth1Sh
         HQssgchwBAIWmmNPuac143aXgfCCp2Nn79O4Y8CGkATF3P769WcM4zaG6iHhDLJ/F5r0
         aJdQVmtiFEOLxHGyaW0SdoFKPSlgk7MRev+F9RoahXNk0e0tFcSz/2CHRjer9a2gVLPS
         OfrQ==
X-Gm-Message-State: AFuF++mavpCiL46cLXoqgn+bXa1h3CoYBfGhftIjWe8hIBm+3Trj/sWD
	QSv3VGvl8u+q7wYs2sYA/FIqXga67CGPac52EyLO4IsqhIRyiAe9VOskYy14vrqRJwpyW8jw81R
	mn5TUhDU=
X-Gm-Gg: AYBFou118e76St1BTLyj8ZSetUE3APBSyFHLM0YbFGgA8q9NxQGvGpAss3cg98jjAzY
	cOGO8OMHLbfaWNYzODUx3ALPRpKkS1EvgLgrZAeW0FZ4J0NGE3GTh0XRJxx2nz7TjuWV+yx0iXr
	0P1xLRpvg37YCphyX3CG1TZguPqS/5qkBpQN8uAkZPBWDxBeR2JrDpFM3mGgWz/TeGO8aiGYTji
	Y9x6PqM7v4aNDPC3ImT6SCcRzKJJpDiHSA6vMRnsVRyxLoL7XWxbF1g2wjZAslrARmrIZ/lB/Fm
	iwoiHdCvAATPCVomOErC8II7NL/bNxISAGkj8fh6ySbZiIcyJm2jQoO7Z6rVXUN8ZUTO0/c5Zn1
	zNWdskDIq7vQ90TB29wPBRJqgypfJ6R3FredJusgEKoARNBhNU0Wv67Vn4+Wl5fG1BU6YuAajdI
	TaNyXPtm/4yugLLwz9tkpFX75dLbRAFlpazKYYrs0kCbmTJQNKI4t+OjlMqDJ90mI9iVTioGa7Q
	PGEzn8hBZQ=
X-Received: by 2002:a17:90b:4fcb:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-39b26100e5dmr13796615a91.4.1788576079851;
        Fri, 04 Sep 2026 19:41:19 -0700 (PDT)
Received: from ziggs ([147.46.121.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcd243sm13675328a91.5.2026.09.04.19.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 19:41:19 -0700 (PDT)
From: Youngjae Kwon <yjkwon0026@snu.ac.kr>
To: yjkwon0026@snu.ac.kr
Cc: stable@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 5.15.y] fsnotify: Fix stale object mask after concurrent mark updates
Date: Sat,  5 Sep 2026 11:40:15 +0900
Message-ID: <20260905024015.3904717-1-yjkwon0026@snu.ac.kr>
X-Mailer: git-send-email 2.50.1
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

