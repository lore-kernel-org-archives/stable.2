Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5E9EEC0
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 02:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788576493; cv=none; b=nBhTdSj4ufNrNoVtO9cW0ccQaxf7e9K7nro03FY/40X+k0YVgiSw2mOGBmOmFKDsn1su0PMak1eLe7ddRWYX6KXow4CFmoCTuQ9eHzVJUGpictQ6m7rlKIdhOyKCqtP4AA9DFjxYpX+d6zuP6ay/Ki7WCbCp9RixM/f7B1ORcb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788576493; c=relaxed/simple;
	bh=BmSwsU22/kjBiXKutOpQcuP0jzyzpovRlSwRpkpH/do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/sjMfzP+u3BSVSrxLnSSyzAGt05r5bTi9vB8ME1pcLTsxFpCV6kFlwe6xZhol4tMkQtv9w+iv1ZsnE9HYvHi+KEmSNK5QXJeZnanoo0AxVtQLLi0otSMqWDEVkU8Y4oqDIRj7etNZW178gHLxETJnUZDPKKkYe20aCGczClL0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=GuqXWHH/; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="GuqXWHH/"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-853c07a76adso1541939b3a.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 19:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1788576491; x=1789181291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RfRWvHDmaNYtFFjotZ1A3nKWk2LABJIZWZfBVKyUIls=;
        b=GuqXWHH/hpXGLzkAfSTXEtuQKnM7tZO+6fqSes5xsNykC43SsDhUIHkLztQk4TpwZ9
         UHjoZWEzVy7kivhL857Xgm3e4FpD3D6zSiW0YgsDJaHe/5PgnikBe7m32XJHiOykAC+w
         eSiTNo8SCSP8nOk51eDmcWL7MJFUpS/kTZcbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788576491; x=1789181291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RfRWvHDmaNYtFFjotZ1A3nKWk2LABJIZWZfBVKyUIls=;
        b=Ykg/OeQef1fL+XRNbCUVi/hbKeHX+/S9bVF+YCzrWtcq6C1xbI89E7gDZvRCtPKyPR
         nPb1NksalIyqLvFPg854cqIS4Hkb2HrKuxEFaoiAIN1eZuLAPaEDnq5Nf/PqqZWYaEe0
         W55C9daUkctyyM7tUfQ5NAfavd1WX9JnzUeJQIB9VARJ7TKtJto72BxsABWHoVVCP/nT
         pvjTZYTB0L9osFUNnIdRe9wkGcEGMZ1xsW8oG3fh2IswZ3AKlHyY2d7EMCj1prs5NItN
         EHCVeGRxXYwSsrqwqSVLHr0IN7ojCqP2Ha7jeUbX2FDWV5CaVJ0oI0UThJbZ+crEj7Tm
         0VQg==
X-Gm-Message-State: AFuF++npiqQyFe5XglxWiFKXLu+D6iUrO94lT23kMu5uj3hjEthaidxW
	794o93vFkqkr5jMAcv+B8y45TyzM0LWGJHXdsi+YrV8m7dijHki1eFOhihfztPhya0kDlbcW+t6
	rmnTVKY8=
X-Gm-Gg: AYBFou1JFCSliU83R6CEkI3HNupfAFbAsC7fq+Ak3cE3fCIvD2lFgNAPGU/p8RnuARx
	mHF4IMYoS7oiaUcxLcKAeprpF5KApAjPgAUrriATnFTMduhwujDZIo4FNBMgDgWYt4sokXHqAbM
	uUJZtFiCSS8H04qnw3SPpmEga4FAGxj6hxm66c3sRHMCp+gNCWiWt++8+mMbYoUIRySIpEzr3GS
	JO8YI3SO32l4OOx2T6tU0bsSyj3RfBg2xSIV2UZVL9iWjmzsbk7F3OP5+mPeDKcQoX7lSoGpZ3U
	PtA7Zq9O9PAnfP/ZU9YPspmTqId2grWB9yuH8tZmXcjWO1rtXT429Eow3OG8mvLBsXvGnGgsHLi
	LFzJxUuCbTms38egdsGXI3la83S5VXgaP1Yti9LIjpdqxnuf6nzMhX9yM91zBCDKSJrL32pt726
	CHBoqHmQ/nnZuZ9mmUiD+tYF7p/oVIv8wkPLUHYg0o751DDJpTMmz/xqBSYU61+z2wq1d51Y/Q2
	w8tZg2LQJ4=
X-Received: by 2002:a05:6a00:4305:b0:845:cf73:c1d8 with SMTP id d2e1a72fcca58-861684928f1mr13559167b3a.14.1788576490822;
        Fri, 04 Sep 2026 19:48:10 -0700 (PDT)
Received: from ziggs ([147.46.121.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8614f872269sm1825058b3a.6.2026.09.04.19.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 19:48:10 -0700 (PDT)
From: Youngjae Kwon <yjkwon0026@snu.ac.kr>
To: stable@vger.kernel.org
Cc: Youngjae Kwon <yjkwon0026@snu.ac.kr>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 6.18.y] fsnotify: Fix stale object mask after concurrent mark updates
Date: Sat,  5 Sep 2026 11:48:00 +0900
Message-ID: <20260905024800.3944249-1-yjkwon0026@snu.ac.kr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026090335-leotard-duffel-dd93@gregkh>
References: <2026090335-leotard-duffel-dd93@gregkh>
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
lacks 4520b96b8136 ("fsnotify: inotify: pass mark connector to
fsnotify_recalc_mask()"). The surrounding conditional is deleted by
this patch, so that commit is not a prerequisite for this fix.]
Signed-off-by: Youngjae Kwon <yjkwon0026@snu.ac.kr>
---
 fs/notify/fanotify/fanotify_user.c | 12 +++++++-----
 fs/notify/inotify/inotify_user.c   | 15 +--------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 5c30f4d8c7c1..e0a0f67b1350 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1327,16 +1327,18 @@ static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
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
index 0d813c52ff9c..2a8a83d8f4a7 100644
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
-			fsnotify_recalc_mask(inode->i_fsnotify_marks);
-
-	}
+	fsnotify_recalc_mask(inode->i_fsnotify_marks);
 
 	/* return the wd */
 	ret = i_mark->wd;
-- 
2.50.1

