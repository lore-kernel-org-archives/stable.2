Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E887081E
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 02:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788576471; cv=none; b=akavOSFIbPGx73pKj5H2vS7LreJ1Vd3HVoy7vXP43RSwGHF4qYgrqNJ2HC+NBK1B9ogJSHTKenDc/1QiKzFUc4bC93NpawZXk+krhJKgWLe3l8f4kPwZEOPxvR59QiBEikAJow6kPHR4QrgCdJpJEHNvt3d4Wd3gRxd/qlUc8bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788576471; c=relaxed/simple;
	bh=UR5nyWNx4/u+KVnS394BM1TY4kOP1DcWuU3r6ORRGAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVa9UHEy8xbnaEULNxRPKwCOG1JgZYz9Gv0MlzYBay5FNdXoH1frxQ8xEdQkw7rd9KxG9SpLCT96sfM1qzAjC4yxycITtLNnvILqEbiQaFtLkYjV2HWv5lNjwOyn1qToEv+lbcyOwlbqQjpp1M+kRWiDIb52DvO0piJ/2uM1QdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=AVVNAEmN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="AVVNAEmN"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d6fe26ef1cso17547005ad.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 19:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1788576467; x=1789181267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jNzIKzBTYlJMNMoBuQvtVuLLYIxpaC1RgMxibk7J9fo=;
        b=AVVNAEmNK+bOVzaPgWhuvHILtjh7FvmHYNTg5ILizGABfpbOIPxSKpeBs3VMgLIBwr
         wCkDlbjZqBVIixprC3h11wtReGOGaQy0SP/X3YbBPW8UUevmfM3mWlADb1hX7M2DCPgm
         mjdiWr7tTSxrh13JJpGoN6Bijt2c5ONOH49Tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788576467; x=1789181267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jNzIKzBTYlJMNMoBuQvtVuLLYIxpaC1RgMxibk7J9fo=;
        b=UboyiTwm2jA7zUwUfq+NM84XTpi1xnNJ/fbEjN0Gg/Z5CbMnqZVCzMVrvOigAVGxAN
         05u4Vp+vmRTgsHzuwQ4D4bSLS6C1jp0YxI6eglPgSBvgAdRC7zPR3C3LRQezKkGUmDvo
         IF7SeR2h/649OfBxTHom9uUue51vWlu143nd744+aw+HmkFXH1cWWH8qdkvjFI9XbwqH
         ytogMVpmcMK3FJ340JCUVENm5iSPLx9f+3LIDoU6u3kXVugqWfTFd7TzUKy/fWoKs0Y5
         N35mHCVQWou7NuYxNBf2BXPvMH1tCbMxmnwmZSONUn866dfDNDduQ6LZv7P0QfCglLsK
         LZGg==
X-Gm-Message-State: AFuF++nM0/fEFOjSVlcaiEiTJlnC4HSBH9f+ubFLV8uqgDeiV0srJINc
	aIVx2QnsnXZK2yyQZMwfBehrnqtpUagrjYmp4immb9EqqX21aKepJUc6yn9lB29CpVlIWDnDXV3
	NySTMI34=
X-Gm-Gg: AYBFou02BlfoM2ZQHz+nWTFweFN+LUQcR0z4962mhcNc+BvfOc0Or+FvU9csEmdnYw1
	I8O1tsRRCUEJ2vefsqvWemHqQmbUX3Lg+bD6oMtJ2QSHcmPqrYY8NGp0cMfY3CsqSMwYIcpEKSJ
	MDeYo7OsUwKyyHFyTntoXusDXpz1EeoJGXyjZaYoFzpDC6p3mYiVANY9TRkxX48HQAXOc6fyYT4
	SU0uwaQXtiQQCbddpDJ3+eD+Goz5ulWkgWeahOrDihDBeh85d6A0od8B7q0SSG0U1tm58IrRN/+
	IiEAm2OcBg6ZBjJadhXpR2v1Nxyk/F77VNKeY2o3ETkCDXFNsy7V+C5aotmotjNfKFlA5fzdXUk
	XasSjssFnpLBtS2/IK+mMkNDocmdtoZud6s43YqSTCnZ0O7026Po6jqKzctjlzhfJBRpU8yXrOa
	tky8NjbJWMROHtyo5vLHMS+IZwgSBKwWbu6lOpqGipGJwgd3VncoKqqLqKBD8ws77b0eWC9ET7i
	O9ajJXjcFE=
X-Received: by 2002:a17:90b:2781:b0:398:9c00:29ee with SMTP id 98e67ed59e1d1-39b26289136mr15778574a91.22.1788576467543;
        Fri, 04 Sep 2026 19:47:47 -0700 (PDT)
Received: from ziggs ([147.46.121.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08c397b1sm13269606a91.8.2026.09.04.19.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 19:47:46 -0700 (PDT)
From: Youngjae Kwon <yjkwon0026@snu.ac.kr>
To: stable@vger.kernel.org
Cc: Youngjae Kwon <yjkwon0026@snu.ac.kr>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 6.12.y] fsnotify: Fix stale object mask after concurrent mark updates
Date: Sat,  5 Sep 2026 11:47:33 +0900
Message-ID: <20260905024734.3941984-1-yjkwon0026@snu.ac.kr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026090335-magnetism-tipping-5204@gregkh>
References: <2026090335-magnetism-tipping-5204@gregkh>
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
index 0ea4e99dc449..e5ccd5572beb 100644
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

