Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A5A212F89
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 06:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785564030; cv=none; b=tmo0+MxfOuBcpr7BqYcDV3m0zCG5yGZTXY4QJthWzvvgCQYZS43GGjnz0wrLFv+Wa+0gYRwxQbVonxIWz0WLd/+G+TNNt9lzoNCP1WQeRvIFSS1siObR5HauO6v0cX5gDWtI5s+Uu5exn45qyMJJYDoSnvHasRHHDFXFcpFpTVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785564030; c=relaxed/simple;
	bh=IyndYiFNrUnOpyjXZQ4HtCPSP8eKEsszOmjL+5Pda0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9jh56X/tBpgT79NgHCvTVQnFYSSIrTQYieE0rA6TdFfE7W2SAKBJ/EJTR2p+jjWemzzAJeWvOsnmUzLj1n+TEzpZburyi/r9a0hm95sfCE1tZiS1nhlrQr3z4t3kjzXBtj/RgQx7GoufOUsnJEb88JFnQctq5RgvFeURwrB9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=SURDHwFG; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="SURDHwFG"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso1510694b3a.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 23:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1785564025; x=1786168825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oh6eLSi8ec38jOBysNvV8YK8OPay/4QImPnp8jUP+UM=;
        b=SURDHwFGnNt2EPxsUL0H3SXYsIaBTsNVpUO9/FpW6xXNuxdDW8NkXf8m+sxt1sCHjW
         pGdfevofm0/WCyZUcz5zqZrrdxbCi/IcGWSNuXUcA1Mkz/j35RgfDPv8XICVKMpw4epQ
         roaNFLSH61TEiEc/iw4hE+bz3yX8zV0vFTH40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785564025; x=1786168825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Oh6eLSi8ec38jOBysNvV8YK8OPay/4QImPnp8jUP+UM=;
        b=QLiQs3aR3iwlxY0T4YCG90ign0ve9EfG/nszd69s6CV+fBTpN4L5YHgSDb21ICspIw
         aEQYWG8ciTbWEgcFWaq5epkNJl8X1XDbvrZBTF5RQDrE1plfWgVyBt117Ua96Ox6j/BX
         FpP3BScOCo9DRc0/RezDg7qPac61wfu+YLm+RspgVq4A8D7OxnAe4+UojJdWqdqB0UOS
         +47KqKN97bUKDWgugoxutBezV/hDgbNNvvF7e8S3p09TbJezKKuXycTfQypUrTo65pP/
         Mz7Fv15q3a6ZnATQIPcPoK0aLig8f0mqEGW78kpDY9woA1mkTUZvwtxH9+qj4GgK3ytV
         4GOg==
X-Forwarded-Encrypted: i=1; AHgh+RqhiVk+S2Zr4l9U1IIAkqHr8wdyvlUTA8Q56qm0KF76MoGi7F7GdcnDrXo4rqRcPmvB8ZUkZdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza2DsOcNTM53K4uq0iz91WZgPAG6aRuMH7YrXSgF1AcdrzrDrj
	exM+coxEKopAO3CuxfOVxT4jOh/MmsFYneM4Ko1E+qqTjZBFwvGBrMpNd4bwXiwtdmShlUFbkBU
	Ma+/pSik=
X-Gm-Gg: AR+sD12j2u/y8S3StDvQDDR9vbLiTIk4vuNJeXtw77qmkDGZdlvMzH+gCLth7h7a6sV
	zRDGaHTLQ39fAHO3K7uka5up32hwyA/9HCkcrwKYbSmAOs0PHyEqvmxfarGF2bo7lSxGGUB2Nnu
	msB5fZ2yczrEw1H5QYK21XfXlm+Vh/sBojb7eDTDu9QrEYHv8jzeMnoZym8g21Cie1vj76dWyW/
	Ls4ZwzfsTv/lJTL0Ud5JzFAG69aKdi648roZIj+9kOTJhibqy20Tkqj+S7/rBZR4FS2eq0DRcho
	8SrCdzfQ9S/Oi6oZ0CBApP+sWVbAT+1qwyRziBhA9BHkxLKhxhb0VxunuWhaAk9fN29hoOtxWoj
	RRwpOTNMwKYKHW2Yo7SsvvMsO8Kbu6w48bjeVNp4aLN7sX46uVGeQWYQD1b7b0hXpLki8yNjXwM
	v4vux0Waz6TjJlXCguAIiKJWBotMHEQUA4pSm8vJKjVWbu1D3K5D03QrDepohPM+wvX10jVV8P7
	Qwc24v6jb2BQ+vfgHgYFw==
X-Received: by 2002:a05:6a00:3986:b0:848:4809:51cc with SMTP id d2e1a72fcca58-84ed74c1c21mr3635850b3a.32.1785564024475;
        Fri, 31 Jul 2026 23:00:24 -0700 (PDT)
Received: from ziggs ([147.46.121.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d6652sm1253873b3a.44.2026.07.31.23.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 23:00:23 -0700 (PDT)
From: Youngjae Kwon <yjkwon0026@snu.ac.kr>
To: jack@suse.cz
Cc: amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org,
	Youngjae Kwon <yjkwon0026@snu.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH v2] fsnotify: Fix stale object mask after concurrent mark updates
Date: Sat,  1 Aug 2026 14:57:04 +0900
Message-ID: <20260801055704.2663156-1-yjkwon0026@snu.ac.kr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260730150407.328731-1-yjkwon0026@snu.ac.kr>
References: <20260730150407.328731-1-yjkwon0026@snu.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a mark gets a new event bit, fanotify and inotify avoid recalculating
the object mask if the cached aggregate already contains that bit. This is
racy with a recalculation triggered by a concurrent update to another mark
on the same connector.

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

Always recalculate the connector mask after successfully updating an
existing fanotify mark or inotify watch. In fanotify, FS_MODIFY handling
may clear ignore_mask concurrently without taking mark->lock, so
calculated mask snapshots are not reliable. In inotify, replacing a watch
temporarily sets mark->mask to zero, so a concurrent scan can observe zero
even when the old and final masks are equal. Mark updates are expected to
be infrequent, so avoid these racy optimizations.

Link: https://lore.kernel.org/all/CACwKKmCZdiZDoFuYm6LZhQ=XvHPk0fNKH=X3LmoXMqakYqJaNw@mail.gmail.com/
Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
Fixes: 912ee3946c5e ("fanotify: do not call fanotify_update_object_mask in fanotify_add_mark")
Cc: stable@vger.kernel.org # needs adjustments for <= 7.0
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Youngjae Kwon <yjkwon0026@snu.ac.kr>
---
Changes in v2:
- Always recalculate after a successful fanotify mark add/update or update of
  an existing inotify watch.
- Drop the fanotify calculated-mask and cached-aggregate checks; neither can
  close the race with concurrent ignore-mask clearing.
- Make fanotify_mark_update_flags() return void; its recalculation
  bookkeeping and the now-redundant first-time guard are no longer needed.
- Drop the inotify old/new mask check because the replace path can expose a
  temporary zero mask even when the old and final masks are equal.

I will send backports for stable kernels through 7.0.y after this lands.

 fs/notify/fanotify/fanotify_user.c | 35 ++++++++----------------------
 fs/notify/inotify/inotify_user.c   | 15 +------------
 2 files changed, 10 insertions(+), 40 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9ee373ff5..a3648cec5 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1276,12 +1276,11 @@ static int fanotify_remove_mark(struct fsnotify_group *group,
 	return 0;
 }
 
-static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
+static void fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
 				       unsigned int fan_flags)
 {
 	bool want_iref = !(fan_flags & FAN_MARK_EVICTABLE);
 	unsigned int ignore = fan_flags & FANOTIFY_MARK_IGNORE_BITS;
-	bool recalc = false;
 
 	/*
 	 * When using FAN_MARK_IGNORE for the first time, mark starts using
@@ -1293,20 +1292,15 @@ static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
 		fsn_mark->flags |= FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS;
 
 	/*
-	 * Setting FAN_MARK_IGNORED_SURV_MODIFY for the first time may lead to
-	 * the removal of the FS_MODIFY bit in calculated mask if it was set
-	 * because of an ignore mask that is now going to survive FS_MODIFY.
+	 * Setting FAN_MARK_IGNORED_SURV_MODIFY may remove FS_MODIFY from the
+	 * calculated mask if it was included only to clear the ignore mask.
 	 */
-	if (ignore && (fan_flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
-	    !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)) {
+	if (ignore && (fan_flags & FAN_MARK_IGNORED_SURV_MODIFY))
 		fsn_mark->flags |= FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY;
-		if (!(fsn_mark->mask & FS_MODIFY))
-			recalc = true;
-	}
 
 	if (fsn_mark->connector->type != FSNOTIFY_OBJ_TYPE_INODE ||
 	    want_iref == !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF))
-		return recalc;
+		return;
 
 	/*
 	 * NO_IREF may be removed from a mark, but not added.
@@ -1314,28 +1308,19 @@ static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
 	 */
 	WARN_ON_ONCE(!want_iref);
 	fsn_mark->flags &= ~FSNOTIFY_MARK_FLAG_NO_IREF;
-
-	return true;
 }
 
-static bool fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
+static void fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
 				      __u32 mask, unsigned int fan_flags)
 {
-	bool recalc;
-
 	spin_lock(&fsn_mark->lock);
 	if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS))
 		fsn_mark->mask |= mask;
 	else
 		fsn_mark->ignore_mask |= mask;
 
-	recalc = fsnotify_calc_mask(fsn_mark) &
-		~fsnotify_conn_mask(fsn_mark->connector);
-
-	recalc |= fanotify_mark_update_flags(fsn_mark, fan_flags);
+	fanotify_mark_update_flags(fsn_mark, fan_flags);
 	spin_unlock(&fsn_mark->lock);
-
-	return recalc;
 }
 
 struct fan_fsid {
@@ -1502,7 +1487,6 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 			     struct fan_fsid *fsid)
 {
 	struct fsnotify_mark *fsn_mark;
-	bool recalc;
 	int ret = 0;
 
 	fsnotify_group_lock(group);
@@ -1534,9 +1518,8 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 			goto out;
 	}
 
-	recalc = fanotify_mark_add_to_mask(fsn_mark, mask, fan_flags);
-	if (recalc)
-		fsnotify_recalc_mask(fsn_mark->connector);
+	fanotify_mark_add_to_mask(fsn_mark, mask, fan_flags);
+	fsnotify_recalc_mask(fsn_mark->connector);
 
 out:
 	fsnotify_group_unlock(group);
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index ed37491c1..5f19c24ec 100644
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
