Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F8A4F798F;
	Wed, 30 Sep 2026 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775180; cv=none; b=kOtPj9ZAED4O9fT5IP/HmK0tqciPe4Ri9Np8GG4kjxgotWL6uKLtDrjUpY+fAlrEJVVAac6WvT/FGKl3zrgsqKCCPLY1KthbP4XZnDwk0QxO8UY+jiClmbRYpBkyo2ui+5upSghE75MgFmbbf3w9R0WLd/za5fVTPyOq3TTpuFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775180; c=relaxed/simple;
	bh=xjaJpu71wtxZPaffO2t2mAezyGOcyI3WnNFVHcEk+cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qscx+tJBDvH/uSbdOBmGneW9eZd2jXO1cfLOQaa5fugUOigv9KZ4X83mvPsmwmI84cj0NTw/OLLJJN1u3t4WH25KVPL9gIxzuBcPCnahWWfb4+8CFqwf2pgiokpTzLWtIbPktDoiRIx6JAJXx+fpMbBUNXOyGmQ9VyZb2MYT42g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SltihyvJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SltihyvJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117CF1F000FF;
	Wed, 30 Sep 2026 13:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775154;
	bh=Pv8aJ6WqYmcV1tWSgDtF3teD9TFSCiQrJlufI+kzIh4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SltihyvJqAkJna52Dga7eW795xyn+r0T0mwU/oqKzMqW1Uocij4aNQ8nPYjnRgvsA
	 exjCEzoqJnSNSkg12GDMT4x19sTsg1ludHGo5XSKK1SBij6KXncl+PsW2IGyL2Z3OL
	 heykTIjxPADwF4bume6mPe/SsglIME49Jjx4A8x2gcuQa3K7YbFTS8RWtGAWgp+rm9
	 JORWvNTGTHjHF1/R06J/WjxyjOu7mbAu5k7S07D2R+oWDMlrTctorS49fLTBT9lt6G
	 MrV/igt/3fXPd9l0nycin44ayt69IegjFkDrBylXTB9zee2NKzwTcaY8ehFGipipfN
	 EmbtrpwF6dIsA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 30 Sep 2026 15:32:03 +0200
Subject: [PATCH 11/17] namespace: don't reconfigure internal superblocks
 via remount and umount
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-work-mount-fixes-3-v1-11-be34c83956ae@kernel.org>
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
In-Reply-To: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Chris Mason <mason@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, Amir Goldstein <amir73il@gmail.com>, 
 bpf@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2162; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xjaJpu71wtxZPaffO2t2mAezyGOcyI3WnNFVHcEk+cc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt5ffXaf7JFva8yOuG8XJ/vrXxsze87fL8vjtAXXd1x
 YlmY8bdHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZ1svwz0BxnY7W8QbVKCZN
 xrN+eyPPveR26HKQnmTBkROSxHN1LSPDLnazrd4f2cx+7eY5ta1m1vvOnKOKoUWin/zZpzBLec3
 lAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Commit 02587a4af82a ("fs: refuse fspick() on internal superblocks")
blocked fspick() on SB_NOUSER superblocks. But that's not the only way
to reconfigure_super(). mount(MS_REMOUNT) and umount() of the caller's
root without MNT_DETACH. The root of an empty mount namespace is a
nullfs mount and all mount namespaces share that superblock:

  nullfs: fspick: FAIL errno=22 (Invalid argument)
  nullfs: mount(MS_REMOUNT|MS_RDONLY): ok(0)
  nullfs after remount: statfs(/): magic=0x4e554c4c flags=0x21 RDONLY
  nullfs: umount2("/", 0): ok(0)

Refuse both like fspick() does. Only root in the initial user namespace
can do this and nullfs is empty and immutable so the flags don't buy
anything. But they show up in statfs() for the root of every mount
namespace on the host.

Fixes: 9d4e752a24f7 ("namespace: allow creating empty mount namespaces")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/fs_context.c | 4 ++++
 fs/fsopen.c     | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 23ad66cd94e1..a50584df97be 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -315,6 +315,10 @@ struct fs_context *fs_context_for_reconfigure(struct dentry *dentry,
 					unsigned int sb_flags,
 					unsigned int sb_flags_mask)
 {
+	/* kernel-internal superblocks are nobody's to reconfigure */
+	if (dentry->d_sb->s_flags & SB_NOUSER)
+		return ERR_PTR(-EINVAL);
+
 	return alloc_fs_context(dentry->d_sb->s_type, dentry, sb_flags,
 				sb_flags_mask, FS_CONTEXT_FOR_RECONFIGURE);
 }
diff --git a/fs/fsopen.c b/fs/fsopen.c
index 9d5a7a22b529..ae19e5136598 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -190,9 +190,6 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
 	ret = -EINVAL;
 	if (target.mnt->mnt_root != target.dentry)
 		goto err_path;
-	/* kernel-internal superblocks are nobody's to reconfigure */
-	if (target.dentry->d_sb->s_flags & SB_NOUSER)
-		goto err_path;
 
 	fc = fs_context_for_reconfigure(target.dentry, 0, 0);
 	if (IS_ERR(fc)) {

-- 
2.53.0

