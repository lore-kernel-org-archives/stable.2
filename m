Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0C44B203B
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444338; cv=none; b=a0BN942lTkw8YTFK5bHZCxSGzik32oT/hsO+br5b5F17z+L2HwygwSf7XLQASgoIhv4G950EWgdMQrdX9cn0ge7guvsv5UHpyGdHN22F3ADZRiWGRXA8lSHp1txtCXHAJ6DBWCBx/EKpP5Qk4U3jAgSW98KHMFMxD2LBUA5znzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444338; c=relaxed/simple;
	bh=8ezL5TvRjhGkEVs46caEmzDU7/5q4MmT4i4iDychwfY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mXNPL35nTYkOUGDfUIuI85HU6dvMyme+OsriW6eH8ucPa+xPSrQ210igpoisBea5kO1lKT5akq2pQDbGu843NnEdumomC8c8VMQl2G7n44T5j86uJEMAR/8Rr45A0SQKEnHx6bx6J7C2O3kgxPitEVOYLektn8TYxS41viDP2Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K/usHadO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K/usHadO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240AC1F00AC4;
	Thu,  3 Sep 2026 14:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444323;
	bh=uV4N67fT54bk5GXPsSBFjdJWH91oRzSs40SauE3S9Mo=;
	h=Subject:To:Cc:From:Date;
	b=K/usHadOnsa9dI4aIzVdbeDaD8RbC+XD8UiOcwESWyn/ZmHoDNOcydus9nvXv7uQy
	 SRJ6OpdPG6/95IaeE7yJhI/EFt3sZBYIgl9c0rOXAO03gW6dl9xHxycKvUdeTKCcWE
	 zyzH9COti+WOBBMZdWshO2zwSxm75rgZk6+fJ6XM=
Subject: FAILED: patch "[PATCH] fsnotify: Fix stale object mask after concurrent mark updates" failed to apply to 6.6-stable tree
To: yjkwon0026@snu.ac.kr,amir73il@gmail.com,jack@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:42:36 +0200
Message-ID: <2026090336-dance-salaried-2815@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e422777fdd4746de1109575c51e65038d4c5c1be
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090336-dance-salaried-2815@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e422777fdd4746de1109575c51e65038d4c5c1be Mon Sep 17 00:00:00 2001
From: Youngjae Kwon <yjkwon0026@snu.ac.kr>
Date: Sun, 2 Aug 2026 10:58:00 +0900
Subject: [PATCH] fsnotify: Fix stale object mask after concurrent mark updates

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

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 463495a78693..a32c6634d592 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1321,16 +1321,18 @@ static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
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
index ed37491c1618..5f19c24ec187 100644
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

