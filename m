Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046378;
	b=eWArxgqGXtGMezF0oyFtGFdf4+DGGg/69WwdSbQv7DFeOnNB0mcwYaPh+3lipmPj6Zvh
	 yYx9sxaa72busSEzRKSZ7UAoI8gZU5JpjsbVsZTsY7dVYDu6bDsTZxfR9IW+q+bHgxjhC
	 4zT69KCK0+0IvbrLj5ZUyGUxIatJY9KdF/xxLkq9RZCHuUaxTpRnkDD/ljzxb6oFvtVMe
	 j4uwudBHt2t7mnUMeRMfRYbbrLtiBYUYsYuJMCFyo/IQzuxZ1d6k4ddrwVAadyxnixE1J
	 8zQKbhI22wpJthrSPbbbeBUlMt79NMQd/8PIe7572JRKnRxC2Gwo1HjwQNX3xaF4cwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046378;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yeJ/cbpgQplQRcUAyuZlpjA7AqA7et0ru9c47XsR0ps=;
	b=RyjHtPc0y827JfebHzBf0NvdOIe58YuLmtn6gQKTpJh+fRxNMAbbCmucKU3kgwfvFz5t
	 OHg7fGBdISLX0Nag0FSvdoVDXvDK9Eme8s0Wgcj20gR++EflgZ5gNLcMFMr2OfnsVY/cU
	 RQoteyiwwLnY6tqvWpmnEdJtSkc4jCqX1VwWXxNFvbIzLgYjYxxWGNQN/3BDR51ZvZMwy
	 mLPzeI89sJp8s+ZKpT9B811IAjAQO9fP5bG2XyD9qznxVNECIPrnPHpO5KsOaq/3SuX4t
	 AgRRRgnafTwPW2wbr3OgTFfd7rzAtNCnYQAzPFUphtgPNk8fbkzHHKMkglSzVqRr2sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VsKhpeby;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B191606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VsKhpeby
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4E81F0089F;
	Sat,  7 Nov 2026 10:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046378;
	bh=yeJ/cbpgQplQRcUAyuZlpjA7AqA7et0ru9c47XsR0ps=;
	h=From:To:Cc:Subject:Date;
	b=VsKhpebyuSQFMNocgv5UeJbsG38dwVS6+KPys9GWis4sgzLB0w6KfVVZgfCPhkiLp
	 Bu8mPQxOt9II6YfmwVMmy+Oaz3Tnc4KuAvyhewDsm1LTvbjI5MvljZclH2H7P1BPqE
	 Lv3ErCGZ3WRsCTNWs5xfiEfo+WXmXEzgadfg14BQVgMzDdok82e+F3tacSKjym/Jlb
	 3ZGIrENY+GB8kMHFQ5mBW8X9y1N/KiEw0jMNYkkSTgbERBjw3VS99Av69fvqyHINlG
	 8QKyOu5mJr5s9fWVDapVG5uHf0LIErlqlsQf+kUGKew9CmEkz0fJF1geEe20+yxaW5
	 ut+EsHfcxe6zg==
From: Sasha Levin <sashal@kernel.org>
To: zenghongling@kylinos.cn,
	hyc.lee@gmail.com,
	liubaolin@kylinos.cn,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ntfs: fail remount on sync errors and keep the dirty bit on SB_FORCE" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:12:56 -0500
Message-ID: <20261107051256-failed-6.18-17a1edda75fd@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 17a1edda75fd371f36085b1568e0b70baff99969
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051256-failed-6.18-17a1edda75fd@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




