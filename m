Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050752;
	b=XUPhUk37xkuxghTGhjRb0n607FQ9l8ISVFFGOgISHqSIXMzDX/qOs4zRlRoKNt2u6un6
	 vawgYv8WP3dfce/8OdyYSDnT2MfPSdgx13WShfjMCS7TGaCZyVV8PeeHf9EgezXyHtU5u
	 lkq9rtNQ9KCNB4Df6ZTMnq2zuB89JAfPQSJxGyQULOl204JbCnR9n9m0A9eTe7HZdTpys
	 QUZU/yFpjBz5lG3EhxMez9jbPSJAVBMtGkRv06eS8Hl1kimqFitp+H1Toqcc8A+xagbdK
	 c8mjYNd3HK8bm2DlcLwbjyW7+YDgavNzkl4WAchcwCYI4SUpCbF1hcgXrxfkFqf13+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050752;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Ua5SAeA+zY5Ncjjy9weFvA2q4EAApPJ8pCCWbKMefq4=;
	b=oVYgyeGNazO6kM6bwi0A/lPSO0NZ/n/DsClb9tERprqmMadyEeNmFILkDmz8VBWCl01y
	 tH8phpg6ofKxesf4vEJbOQeuIuSz6FLuUcGA4HWSzTYlok61jCg+OvdU527de5hvEVdkX
	 ng0qetnDbIxaQtI07cMJogK27P2l+SJddsFyKnIp78VmrhtEBuew8J9C2EVZBj1eSG0nd
	 ljzHc3GMWNEcMtybp2GVoDCkFtdCktEshMxkpeYtM0snBYKwkXMk+juyABvKCxcBF32/K
	 Lkegn1vDqCchkj3rLKtf7yRyRzHD/IGHPVglbkDTIptzPJL/Fg2N79+avG3PEG609IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZjLqxP3W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F60B606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZjLqxP3W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5981F0089F;
	Sat,  7 Nov 2026 11:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050752;
	bh=Ua5SAeA+zY5Ncjjy9weFvA2q4EAApPJ8pCCWbKMefq4=;
	h=From:To:Cc:Subject:Date;
	b=ZjLqxP3WeCFmWEhiH8u1DihLXJpPOq0bqrcoY9keuZ/VlrLy3L/m13idz2D88xg/r
	 Ut3jPQDK90pOhs/4+3D3EQ6GxeNxWUNa9SLm3U6IQHmc60ttVFO3Ok6wtyJkR6nBCl
	 h8mw3F96O6XAC8IH8/cvd4RXMAtbGXJ7XXk0vJy24kCNCINVMYjUvG+AuqTzMPRMQh
	 7oVVxk+OJdzMRDsNbz5BI4acq2GrQPUK6gCG12qUkbRopINk3Hyb/mvAK1OGR6mxhV
	 8V8jWW/X3oXZ+Vh3hk27YWs8i/VE6bZJBvED8psGUlMgCoJYaV8RYjfp1YWyd+wwKb
	 EEW3TqlAdE5lQ==
From: Sasha Levin <sashal@kernel.org>
To: zenghongling@kylinos.cn,
	hyc.lee@gmail.com,
	liubaolin@kylinos.cn,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ntfs: fail remount on sync errors and keep the dirty bit on SB_FORCE" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:25:50 -0500
Message-ID: <20261107062550-failed-5.10-17a1edda75fd@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 17a1edda75fd371f36085b1568e0b70baff99969
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062550-failed-5.10-17a1edda75fd@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




