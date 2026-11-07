Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048718;
	b=FOiMBlUc10K5YT91EcsVeJ7BPDmgLsG1Ow1569Uj9Fy/r46Lo8H1Fxuf+SUbZ7SOSPMQ
	 PfzFul6vnBKw1CdMlDT4oaLYhB6hjJHxtYdIg+eU1TRNC5iL0Tmu+KMgJylo2MNqawD35
	 aPhpClgG/hiBxjBrPupirGsV/wsPpV7B/sm/WpKXcrs9UdWG0TerKzwhHl4xRAwDjD7Bd
	 pVp3NJKINQrxNil5cmDYinKaUSNuevr5DMee38BxNSWg4HSxwXrHIUD1E8GksFFGcBM47
	 y7P3HAJaSGmNJkrzKaVY4Xv4BfzPC8mZ+u/q+o5VDwzPbfiSn4qCvWQAmMSlfJL3rdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048718;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eCg5Drzv4XZ82MRap8C+3/ywhTAWbL9Hyzn8vaL7om0=;
	b=ahK3W/fhrV5wm/GuVPRuKe/7qRYhpdkE9P+6vpMyaru9LndkKj1IQIvlENmG3VQI6WaJ
	 1iMFjzO5Bb9PjZ46ssWBTj90T9ymm8Nstz91CktHUbXzYiGqR1kNGllPxzGAyRoOOH+it
	 NRJ7LL46sp83v3pPQQMM5UW1R9LQPQC0W7sB3CmHAhtZknpGcZ6n6p8P9NPnC2Q/shOkg
	 F66D4X3dDmGuMJ4c6UmBEaH4KfwZ8sZIn6+ahiYyIZsmGw/gH/e0yNwM4JVoROgvWY8Wc
	 AqTOR9dRO9l+wQD8BihvhpAI34z3xWQq8SiWlxhp+1eF827ADi3pUmH/5J3ifiVDjoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=erissgkK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1496E606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=erissgkK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EA91F0089F;
	Sat,  7 Nov 2026 10:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048717;
	bh=eCg5Drzv4XZ82MRap8C+3/ywhTAWbL9Hyzn8vaL7om0=;
	h=From:To:Cc:Subject:Date;
	b=erissgkKHQqEy4PN26E7WI6+xVfszk8WLqbZ+3TtQfiiwcUwpyDW+0pOvQhZmbZba
	 yj466gqJyLDsEyouVpzPlibouZ97/j/prfC3Nyl6foOC1EwEtQKqeDEd1isY5uiptT
	 Hs36ZWAJEcjvQUXQCiA8xKwAdkqM+a18TToPT2Xa2yVnBmmICTR30b6xV4y8ASxZ3R
	 dxRNhu/la6OZLHjaJ4BflEj+zQJL9khYVFdvkP7BidFvSQZ+ev9fM7xPoUTMCcbCAE
	 fNY3VIqiEukZuuRcucSB2aihusnRrS4hzSs98G4NnVshy/OOzCFlyt8RyDH/cIKAlw
	 qhr/6ZLK0JInA==
From: Sasha Levin <sashal@kernel.org>
To: zenghongling@kylinos.cn,
	hyc.lee@gmail.com,
	liubaolin@kylinos.cn,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ntfs: fail remount on sync errors and keep the dirty bit on SB_FORCE" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:51:55 -0500
Message-ID: <20261107055155-failed-6.1-17a1edda75fd@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 17a1edda75fd371f36085b1568e0b70baff99969
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055155-failed-6.1-17a1edda75fd@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 17a1edda75fd371f36085b1568e0b70baff99969 Mon Sep 17 00:00:00 2001
From: Hongling Zeng <zenghongling@kylinos.cn>
Date: Tue, 15 Sep 2026 16:32:52 +0800
Subject: [PATCH] ntfs: fail remount on sync errors and keep the dirty bit on
 SB_FORCE

ntfs_reconfigure() currently ignores sync_filesystem() errors, allowing
a regular read-only remount to succeed even when dirty data was not
synced. Check the error and fail regular remounts, leaving the
superblock read-write so ntfs_put_super() can retry at unmount.

SB_FORCE does not wait for writers already in progress, so it must not
clear the on-disk dirty bit. Warn and continue on sync errors for
SB_FORCE. A forced remount updates the dirty state only when errors
have been recorded, and never clears the dirty bit. Skip the commit if
that state update fails, since the in-memory flags may be inconsistent.

Reported-by: Hyunchul Lee <hyc.lee@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/super.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 0ec4d2ddf6219..6a107ec0d0f68 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -273,7 +273,13 @@ static int ntfs_reconfigure(struct fs_context *fc)
 
 	ntfs_debug("Entering with remount");
 
-	sync_filesystem(sb);
+	err = sync_filesystem(sb);
+	if (err) {
+		ntfs_warning(sb, "Failed to sync the filesystem.");
+		/* A forced remount must still turn the superblock read-only. */
+		if (!(fc->sb_flags & SB_FORCE))
+			return err;
+	}
 
 	/*
 	 * For the read-write compiled driver, if we are remounting read-write,
@@ -336,11 +342,20 @@ static int ntfs_reconfigure(struct fs_context *fc)
 		 * or flush fails the remount, leaving the superblock
 		 * read-write so ntfs_put_super() retries at unmount.
 		 */
-		err = ntfs_sync_volume_dirty_state(vol);
-		if (err) {
-			ntfs_warning(sb,
-				"Failed to update dirty bit in volume information flags.  Run chkdsk.");
-			return err;
+		/*
+		 * A forced remount does not drain writers in progress,
+		 * so one may still be modifying metadata when the flags
+		 * are committed: never clear the dirty bit then; if
+		 * errors have been recorded, the update preserves or
+		 * sets it; otherwise, skip the update entirely.
+		 */
+		if (!(fc->sb_flags & SB_FORCE) || NVolErrors(vol)) {
+			err = ntfs_sync_volume_dirty_state(vol);
+			if (err) {
+				ntfs_warning(sb,
+					"Failed to update dirty bit in volume information flags.  Run chkdsk.");
+				return err;
+			}
 		}
 		if (NInoDirty(NTFS_I(vol->vol_ino))) {
 			/* ntfs_commit_inode() would discard the error. */
-- 
2.53.0




