Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95DF331ED0;
	Sun, 11 Oct 2026 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734184; cv=none; b=JMg/wnllMkp4dYbTAqYhJvG3RtIJmvb1c4FOfjOxWKxicqldCIRxbmBDm8ubTwsbLEKktqmg1kbzg9fOCCTEyexRv3F9wq2BDdM2kvzYq2AQ/WVHZn+mKgEtDt2uiPqixsnxWNC6y0sug4NDGBM77nI6qKFVrm8GhRSRohbOcjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734184; c=relaxed/simple;
	bh=MqD2L7NJoHdPxojaPnlleUpF2pjg9HwkK0bsxy2EjRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EHqTQuMvk56cXeYBi8xIgbUlFrMjPgqU9ddqbceeNt4mk3JoM0DN8Z9gd2/iLWXNw7nXoOTVK+ibwpw4PhSimciSOtTWJQL2wWytKZLI2him0k2RMnMJm8DLDvyeIYfTMno3bRiSjrgLz0GdJRDMSycoNE3EDls0QyLhaYKkGH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBSYNyAE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBSYNyAE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E1E1F0089B;
	Sun, 11 Oct 2026 15:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791734181;
	bh=WIqUX9NwcPVXnto5mbfZgBba7AXG1I/DT74eN0FdPdw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nBSYNyAE/11WKMBK5xz5U2xg+XGGtQQIpn0hprHMZMt16scgnziE9wRatgwqU1wiF
	 L894hhYaC80aT07KzVAjooH2wPQr9pkkzpNOICsnPh57VOKykgQ5VIl3bGvlKf9MZc
	 RJtoWTxWpQpQ1UwdAIpasmWcMsPEjk7Pv98slOCGZHd969BnTWwFqQg9jqs/WD0f6x
	 fqlDET3snxQ/r3qRYPuc4wq9pSvu+0dsERiXzYK6MX55GabpBZefD+qx3VUF47aMK5
	 jqxQLSTtLtvRKjh9KRBkweYzXb0EX/wXnnQNrNEI2v6EbqbR+YCPKE1NETfoAnLGEL
	 GvtSHSkZdzMKg==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 11 Oct 2026 17:56:03 +0200
Subject: [PATCH 03/15] quota: really wait for the thaw in quotactl_block()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-work-super-fixes-core-v1-3-c727176c5b53@kernel.org>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
In-Reply-To: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5173; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MqD2L7NJoHdPxojaPnlleUpF2pjg9HwkK0bsxy2EjRM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd3jj72Y6COHfHA0sORt2/fuqHqmT9HZmkvwkr4tmUd
 dZOnLo8uaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi3V8YGRad4dP7ePuh+Bz/
 sOLv5sFLBZbnBeRL1vY0zPn5Y2WguAcjw7yD0+M6NhivmyfrttTIh/nQsaqvgfXrvJeZmMcL2rI
 y8AEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

quotactl_block() makes commands that modify quota wait for a frozen
superblock to be thawed. Since 576215cffdef ("fs: Drop wait_unfrozen
wait queue") it does that by taking and dropping s_writers via
sb_start_write() and sb_end_write() and retrying until the superblock
isn't frozen anymore.

But freeze_super() doesn't take s_writers for a read-only superblock. So
sb_start_write() never waits and quotactl_block() spins until the
superblock is thawed. The loop doesn't check for fatal signals and the
permission checks only happen after quotactl_block() returned. So any
user that can resolve the device node of a frozen read-only filesystem
can make a task burn a cpu without being killable until someone thaws
the filesystem.

Wait for the thaw with wait_var_event_killable() on s_writers.frozen
instead. freeze_super() and thaw_super() already wake waiters on it for
wait_for_partially_frozen(). That waiter only ever waits for the
superblock to leave SB_FREEZE_WRITE and gets away without a barrier
between the store to s_writers.frozen and wake_up_var() because
percpu_down_write() executes a full barrier after the store that moves
it out of SB_FREEZE_WRITE. That doesn't cover a waiter for SB_UNFROZEN.
So add the barrier wake_up_var() requires to all of these wakeups.

The cond_resched() that 77449e453dfc ("quota: fix livelock between
quotactl and freeze_super") added to the loop goes away with the
spinning. As a side-effect waiting for a read-write superblock is
killable now as well.

Fixes: 576215cffdef ("fs: Drop wait_unfrozen wait queue")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/quota/quota.c | 12 ++++++++----
 fs/super.c       | 19 +++++++++++++------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 33bacd707580..d55ef08de833 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -894,11 +894,15 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
 			up_write(&sb->s_umount);
 		else
 			up_read(&sb->s_umount);
-		/* Wait for sb to unfreeze */
-		sb_start_write(sb);
-		sb_end_write(sb);
+		/*
+		 * Wait for sb to unfreeze. A read-only superblock is frozen
+		 * without taking s_writers so sb_start_write() won't wait.
+		 */
+		error = wait_var_event_killable(&sb->s_writers.frozen,
+				READ_ONCE(sb->s_writers.frozen) == SB_UNFROZEN);
 		put_super(sb);
-		cond_resched();
+		if (error)
+			return ERR_PTR(error);
 		goto retry;
 	}
 	return sb;
diff --git a/fs/super.c b/fs/super.c
index 4e8f7f48540c..2dc4ec2e8014 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -2068,6 +2068,13 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
 		percpu_up_write(sb->s_writers.rw_sem + level);
 }
 
+static inline void sb_freeze_wake(struct super_block *sb)
+{
+	/* wake_up_var() needs a full barrier after storing s_writers.frozen. */
+	smp_mb();
+	wake_up_var(&sb->s_writers.frozen);
+}
+
 static int wait_for_partially_frozen(struct super_block *sb)
 {
 	int ret = 0;
@@ -2293,7 +2300,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who, const void *fre
 		WARN_ON_ONCE(freeze_inc(sb, who) > 1);
 		sb->s_writers.freeze_owner = freeze_owner;
 		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
-		wake_up_var(&sb->s_writers.frozen);
+		sb_freeze_wake(sb);
 		super_unlock_excl(sb);
 		return 0;
 	}
@@ -2313,7 +2320,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who, const void *fre
 	if (ret) {
 		sb->s_writers.frozen = SB_UNFROZEN;
 		sb_freeze_unlock(sb, SB_FREEZE_PAGEFAULT);
-		wake_up_var(&sb->s_writers.frozen);
+		sb_freeze_wake(sb);
 		deactivate_locked_super(sb);
 		return ret;
 	}
@@ -2329,7 +2336,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who, const void *fre
 				"VFS:Filesystem freeze failed\n");
 			sb->s_writers.frozen = SB_UNFROZEN;
 			sb_freeze_unlock(sb, SB_FREEZE_FS);
-			wake_up_var(&sb->s_writers.frozen);
+			sb_freeze_wake(sb);
 			deactivate_locked_super(sb);
 			return ret;
 		}
@@ -2341,7 +2348,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who, const void *fre
 	WARN_ON_ONCE(freeze_inc(sb, who) > 1);
 	sb->s_writers.freeze_owner = freeze_owner;
 	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
-	wake_up_var(&sb->s_writers.frozen);
+	sb_freeze_wake(sb);
 	lockdep_sb_freeze_release(sb);
 	super_unlock_excl(sb);
 	return 0;
@@ -2378,7 +2385,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
 	if (sb_rdonly(sb)) {
 		sb->s_writers.frozen = SB_UNFROZEN;
 		sb->s_writers.freeze_owner = NULL;
-		wake_up_var(&sb->s_writers.frozen);
+		sb_freeze_wake(sb);
 		goto out_deactivate;
 	}
 
@@ -2396,7 +2403,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
 
 	sb->s_writers.frozen = SB_UNFROZEN;
 	sb->s_writers.freeze_owner = NULL;
-	wake_up_var(&sb->s_writers.frozen);
+	sb_freeze_wake(sb);
 	sb_freeze_unlock(sb, SB_FREEZE_FS);
 out_deactivate:
 	deactivate_locked_super(sb);

-- 
2.53.0

