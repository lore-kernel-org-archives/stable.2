Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047074;
	b=kbX/PDhMSx0KXHmwifmv9TyXadf11k46ZzUQtLkTuLfBHFBLDv+ofTyIP93AR68VO91f
	 yMZkTbEWN52otF/r2gWMdnqaLjchHZmFYkw4K7ShiIhyIxx0x/qVo8BIqDP7toyrMnZDM
	 hjjmg+jVOR1ihzY1b2gnCc54RhxX8Il1ee3ZAAZtNkpbPqh/Xl2fp3iwuieMgH0F9dPWB
	 v6bdA5N99ZHkKPlifKN56pW+8cZ3+MD/cpLioVkQnEk7h8wVHYmnH+71Gz/HssXbHjsoh
	 rO2dAezed5jbqQ/hUTCYcQQyVJwyDVx49BsLla6VMukOVeNBBvSZ1iSKEJ1V7j/v4fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047074;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CFwjvWM7oTCgiGDC4+w5LEulmk+uOGXZiK5PMhsCcKw=;
	b=HW4/8O12IGjqmPXeQgfh1rctBGnsVjTv5akTMQzveMkNjVrbbWPtMpjx/V9m5S3BZ+SD
	 tJDTTbvTEzZkuUnpXw8cK6MGK2wwRxQoMMsp2JFOgU/KqFJZAqrfa/J3lAXqHwHfx20Us
	 Y9xvlpWR9kJunA+4jV+7HZtrjz1Faye4Q3KAxjIgA2H094lHB9tpUA8PYI7ExT3Fvee1r
	 FNPon0v8s2wsXu3bzRXYYCT1AQB84K/MlY0QmIfhT4auLVl+tKcyNpxIDGnBkw4GLybkh
	 CzWtN905omWblJhuwvIUoQyC9CzOdag20GkzA6FKvE+eVYuUboIbvLXsBFGWrOsDrfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oq+cF3lQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DD9606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oq+cF3lQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0911F0089F;
	Sat,  7 Nov 2026 10:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047073;
	bh=CFwjvWM7oTCgiGDC4+w5LEulmk+uOGXZiK5PMhsCcKw=;
	h=From:To:Cc:Subject:Date;
	b=oq+cF3lQ0jXHsaCMHTXT7GtDVpIhXwQ1KCQus5oo2VHGNUV6pF7tPfCVhjuGTcB61
	 4IKKgXEaw4Malvh6R66zootV7sf4qfoehCV9bdKX2byIU20wed56XFtna47bpNSiSJ
	 xuxxP+UU3WWkiJZgN2/++6UdlVCvBPlo/xa9nhKfgnB0ImmMWu+JxwErnGheDRwNq0
	 vvnXQsiSLfp5lkSeqpSaywF1GElqC6SoJJ2RANj5Iq5hedlAhpHYam+3pzWdy8ol3k
	 u2gbBh3KyIx7GH9or/BZRRucHkVDjH/4j24C4hKLlWtjogBBeqB6BShVdP/FFDjfum
	 6ZhzwucsxLrtg==
From: Sasha Levin <sashal@kernel.org>
To: zenghongling@kylinos.cn,
	hyc.lee@gmail.com,
	liubaolin@kylinos.cn,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ntfs: fail remount on sync errors and keep the dirty bit on SB_FORCE" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:24:32 -0500
Message-ID: <20261107052432-failed-6.12-17a1edda75fd@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 17a1edda75fd371f36085b1568e0b70baff99969
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052432-failed-6.12-17a1edda75fd@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




