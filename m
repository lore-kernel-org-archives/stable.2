Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D723C3546DE
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 03:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788664151; cv=none; b=jKOFR4IR6Ox+LPtUQTkcPIehIuA3aqV1PK1Az91E8ymV428N/4aZ/a856cY3eMxWovjqn5kLxtp3OLTD5Tbrw+bhacmRy8BxR6gFIxBGriDkJI3abB90VO47BTiDwFKagw+9qo0THw+4P2wz/UeRB26ceyD4QWA/JYmz+qKHrtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788664151; c=relaxed/simple;
	bh=vidIAHeXpl9QOMbXuUtX1NygSTPKLRXJuiS9Olr8iDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqxUUTQdY+6JpRrxWvRoUqYoeadszVAgn/9xeWFrGX3ZFpW5f37pOJU6TkgLR4MhF1xRdEWS/9aitJzgZNJ8bXcfVPdRsdMZYrMuEOfPQxghqqN25dZ6XSWdqE3SqcEWFpcvXVLJDT4UAnWIhmrxszLSSwXnJS1xNcvzxPTSoqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=CP9hU3Ku; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="CP9hU3Ku"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-398a5aad413so1728160a91.3
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 20:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1788664145; x=1789268945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Atz3FFDWRZxYNGthEiGwcnpMx5ePzrna9csAK9pRABs=;
        b=CP9hU3KuQvx9QSoBoQeENZWzEuAmiJX92A5ApfeYvcK+q12caMZca0W/Vxy88ycCFv
         jV8rCzA8ZlPN1nGc1yfnvna0KeatPHdTkKvHK+62iMHoP9zOz2jd8aoWpWwY7shbo68J
         OvkO7//TDos2iF/oE71nQfkszhHEJ1xO5kzzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788664145; x=1789268945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Atz3FFDWRZxYNGthEiGwcnpMx5ePzrna9csAK9pRABs=;
        b=lnU9iOxolqvWrkeC2L6ZsEZH5RrOIzqZBlb0p+mcAncWw49UKrxT4H3pdToDwXRd7K
         aYCRqIWC/goqa4+6UluMwuLFefRQzPhgQAV0ioeW+LbBOeTlvNXVEWyXY+UzpU/zkDYY
         bjotnZE2dsaNCfEB8YRtXZWPBlsCEwh+8F3WT4Opstk7ydU7OC3TAZmYoANbqznDq2tG
         h7HFwC2Sb0AknNiWNqS94YJihPsCav0/7+BdPYCkTGcb78MEBmTEtGF3gSrR6o6UiCKx
         6FvBzHyq2BHgExpLzYXqG3v1yNrGiTwDNjt+awoMbv72/upR0C0/OVkwzl0QGkXfat1n
         z9Gw==
X-Gm-Message-State: AFuF++moAvAuVN2Qdq3doFicka7bLgAQKk5KlF6upw+KPARrJpDigt5l
	/RtLAu9FJSoj3tUREVsOxskMJStjH5jODhS/gsRWBJAU6yToezgQDjS38xQtQ+BJHgeNQlbGASH
	by9wh5FM=
X-Gm-Gg: AYBFou0x75g2lyHJ+lIFdE92NggY02FDSnEdkH+JdBhzpq07JzjClDZPisWcTU2REnB
	FhKwpX35jthIIDHV9kaKWJW9v38jIekBfc5svTX1Jag7Vc3uqUYFstlmqrXTIEBAJbeGC2nn57a
	wcpzbSRAQ7Qa57eP+wD4s6lhy4zvxG6SIrw34O3OUMMp8L6W6bz5on1GnK/1r7M5RP1skFyXDpi
	ibm2Pf0c3qWjmrkufgvg4y8EfPh3hRZfC404RNvY8WhJyXTbnYwa2z9nNLR+MHxdNiNCb+GlL0q
	OfEAJYn77tcOtA98i62eoDpDhHIBshms/zUgFVLuPk2wFkx1OE7pPd/qH0M7x1uspkMd1fmjj+v
	WYiEgDxwrbTbydeI4qRRXtaZjYR3PiTRFl9dSrJhTpRyuT4AtJdECKTZRbIGgSwFZODfiIPJ77e
	0r/IeOQAZqeqGLimO+73qkksJ29ok/FA3hNlosmavkl7QURUee/OGNfwFyx6IX2wpIyZFhK6/EU
	za9wRksoNyX
X-Received: by 2002:a17:90b:4e8f:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-39b261ba63bmr23759779a91.11.1788664145412;
        Sat, 05 Sep 2026 20:09:05 -0700 (PDT)
Received: from ziggs ([147.46.121.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcc081sm18959288a91.6.2026.09.05.20.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 20:09:04 -0700 (PDT)
From: Youngjae Kwon <yjkwon0026@snu.ac.kr>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Youngjae Kwon <yjkwon0026@snu.ac.kr>
Subject: [PATCH 6.18.y v2 2/2] fsnotify: Fix stale object mask after concurrent mark updates
Date: Sun,  6 Sep 2026 12:08:33 +0900
Message-ID: <20260906030833.3356045-2-yjkwon0026@snu.ac.kr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260906030833.3356045-1-yjkwon0026@snu.ac.kr>
References: <CAOQ4uxjNxYFJE2J3K=_Ur2LjvF2nnE2B626ef6YUWJwAoirB2w@mail.gmail.com>
 <20260906030833.3356045-1-yjkwon0026@snu.ac.kr>
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
index 905c27e9cd38..6eaf0d382eec 100644
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

