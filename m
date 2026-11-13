Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531508;
	b=pHeOodrKGHsFKZzvXW+nvReacpu4lGGLiDwiU6a1eUu8Az44IaSdbb7vzCXV44vwBhYR
	 jvYUp9wn/gTfVbm2SHgEXHA4F8xowdpOch4OjFRCbQRBLqryebb5ijFfkJO4Ayp6KBwYy
	 CQsmN9sZXx5NkyBmy7WxS3PCpXkyqpers5gec155XGB6aJFiQLyeILqUK1yVg3WyQIeZZ
	 lM0XFoBJkDSz1inycLlcE90RUCsF2Dgkrh7GSg88PrL+DVxvM4AtPbhviMSeEw78VMvxQ
	 c1uXhPaneRnndxydDvSBhm43dGqWxFTS6svUPjd8DuU8s4Gba3n6SV6AcXl9xBaqdrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531508;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=R54T62tZ/uSaDwmRZZeNQYALU/EGOhBv/c/AJZ1GenQ=;
	b=oIh6k6ZMeeMHUfIKBpUEakSZuiXTjWp8jr7SJs8Xb/BV9fVTF4HkfxbC9ZmqboB28qOC
	 T+1WNVEmDF4UiRJuIV+hlQCFyiDXWwBObErvpMZc8ufejrYiFcAQzmfbmvr2YcBRwqaH1
	 CwsFVajVVTKnNiF9QB+1OL8Y99fzvtrah0l/7fwMZ9lp4e8ZJTte+azsbaXZ1xYh3YRBu
	 821IOfJD1t3EOqGVze2WRuvVYHuE+7HuuXYyOm/p0SkvjB4s6GMDiRqUZFMQ8JoG8nBD1
	 dKqHER2syRShXZ0KUaIToEw5mEeoJkR1ce3F8k6RPjLJBM2vOWRzXvIQXSoAEGAUEfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfWMisTI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F93606A33A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 00:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfWMisTI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692D61F000C6;
	Fri, 13 Nov 2026 00:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531508;
	bh=R54T62tZ/uSaDwmRZZeNQYALU/EGOhBv/c/AJZ1GenQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bfWMisTIZg2fipy1HjV/IA64GvkrITYPDAjnddcl/aPppd7sFQ7WdwxhZKpl36uI5
	 gvpkwzAE7h/mw/o8vql9x5LV4gAHll4mAeHFKZwMqx/rGSMwmaXjBTAhScAB37I2AL
	 sDuRqzY9CslUMtQbzlaCHligAwrzuB1ZBf+UCKEoqPf0JeVmJVGkSvuYyBQyjgan1X
	 KnHwqTcL9p5Bs8oH1t8s64wl88GyBio12uzsnWZUbhPRBuNK27kzubyXXUiNdU2qzF
	 gx0lc+D48+oHHSbtELUKHwlvUWviXi2SYEzewanivGRtGGqaYKkKpSmZuiL/gR7ORC
	 Fah/bpQ55Gd4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cen Zhang <zzzccc427@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Heming Zhao <heming.zhao@suse.com>,
	Jia-Ju Bai <baijiaju1990@gmail.com>,
	jjzuming@gmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] ocfs2: cache the mount context for dentry lock callbacks
Date: Thu, 12 Nov 2026 19:58:24 -0500
Message-ID: <20261113005810.435609-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113005810.435609-1-sashal@kernel.org>
References: <20261109201247-failed-6.6-5b4696e0bfc3@kernel.org>
 <20261113005810.435609-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cen Zhang <zzzccc427@gmail.com>

[ Upstream commit 5b4696e0bfc358619adaeab25ad35b4979af8331 ]

ocfs2_drop_dentry_lock() drops the inode reference before releasing the
DENTRY lock.  This lets inode eviction release the local inode and open
locks before a remote unlink can proceed past the DENTRY lock.

A DLM callback can still arrive before the DENTRY lock has been dropped.
ocfs2_get_dentry_osb() obtains the mount context through dl_inode->i_sb,
which can access a freed inode when the downconvert thread drops the
last inode reference in its post-unlock callback:

  Downconvert thread                     DLM callback thread
  ------------------                     -------------------
  ocfs2_process_blocked_lock()
    ocfs2_dentry_post_unlock()
      ocfs2_dentry_lock_put()
        ocfs2_drop_dentry_lock()
          iput(dl->dl_inode)
          [inode reclaimed after RCU]
                                         ocfs2_blocking_ast()
                                           ocfs2_get_dentry_osb()
                                             dl->dl_inode->i_sb
          ocfs2_simple_drop_lockres()

Store the mount context in the DENTRY lock resource's l_priv field and use
the default mount-context lookup.  Recover the containing dentry lock with
container_of(), as already done for refcount locks, and remove
ocfs2_get_dentry_osb().  ocfs2_dismount_volume() shuts down the DLM before
freeing the mount context, so callbacks can use it without accessing the
inode.  Preserve the existing iput-before-unlock order to avoid delaying
local inode and open lock release until after the DENTRY lock is released.

Link: https://lore.kernel.org/pm-ocfs2-objects-candidate-0012-v9-eeb9084fb29577971229@gmail.com
Fixes: 8ed6b23709b3 ("ocfs2: revert iput deferring code in ocfs2_drop_dentry_lock")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Assisted-by: LLM
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Heming Zhao <heming.zhao@suse.com>
Cc: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: <jjzuming@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/dcache.h  |  5 ++---
 fs/ocfs2/dlmglue.c | 16 ++++------------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/fs/ocfs2/dcache.h b/fs/ocfs2/dcache.h
index 7f246c5692d82..046ab9a807692 100644
--- a/fs/ocfs2/dcache.h
+++ b/fs/ocfs2/dcache.h
@@ -17,9 +17,8 @@ struct ocfs2_dentry_lock {
 	u64			dl_parent_blkno;
 
 	/*
-	 * The ocfs2_dentry_lock keeps an inode reference until
-	 * dl_lockres has been destroyed. This is usually done in
-	 * ->d_iput() anyway, so there should be minimal impact.
+	 * The inode reference is dropped before dl_lockres is unlocked.
+	 * Callbacks must not use it to find the mount context during teardown.
 	 */
 	struct inode		*dl_inode;
 	struct ocfs2_lock_res	dl_lockres;
diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 06fa76950b31d..bd187a6624513 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -56,7 +56,6 @@ struct ocfs2_mask_waiter {
 #endif
 };
 
-static struct ocfs2_super *ocfs2_get_dentry_osb(struct ocfs2_lock_res *lockres);
 static struct ocfs2_super *ocfs2_get_inode_osb(struct ocfs2_lock_res *lockres);
 static struct ocfs2_super *ocfs2_get_file_osb(struct ocfs2_lock_res *lockres);
 static struct ocfs2_super *ocfs2_get_qinfo_osb(struct ocfs2_lock_res *lockres);
@@ -256,7 +255,6 @@ static const struct ocfs2_lock_res_ops ocfs2_orphan_scan_lops = {
 };
 
 static const struct ocfs2_lock_res_ops ocfs2_dentry_lops = {
-	.get_osb	= ocfs2_get_dentry_osb,
 	.post_unlock	= ocfs2_dentry_post_unlock,
 	.downconvert_worker = ocfs2_dentry_convert_worker,
 	.flags		= 0,
@@ -307,7 +305,7 @@ static inline struct ocfs2_dentry_lock *ocfs2_lock_res_dl(struct ocfs2_lock_res
 {
 	BUG_ON(lockres->l_type != OCFS2_LOCK_TYPE_DENTRY);
 
-	return (struct ocfs2_dentry_lock *)lockres->l_priv;
+	return container_of(lockres, struct ocfs2_dentry_lock, dl_lockres);
 }
 
 static inline struct ocfs2_mem_dqinfo *ocfs2_lock_res_qinfo(struct ocfs2_lock_res *lockres)
@@ -608,13 +606,6 @@ static __u64 ocfs2_get_dentry_lock_ino(struct ocfs2_lock_res *lockres)
 	return be64_to_cpu(inode_blkno_be);
 }
 
-static struct ocfs2_super *ocfs2_get_dentry_osb(struct ocfs2_lock_res *lockres)
-{
-	struct ocfs2_dentry_lock *dl = lockres->l_priv;
-
-	return OCFS2_SB(dl->dl_inode->i_sb);
-}
-
 void ocfs2_dentry_lock_res_init(struct ocfs2_dentry_lock *dl,
 				u64 parent, struct inode *inode)
 {
@@ -622,6 +613,7 @@ void ocfs2_dentry_lock_res_init(struct ocfs2_dentry_lock *dl,
 	u64 inode_blkno = OCFS2_I(inode)->ip_blkno;
 	__be64 inode_blkno_be = cpu_to_be64(inode_blkno);
 	struct ocfs2_lock_res *lockres = &dl->dl_lockres;
+	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 
 	ocfs2_lock_res_init_once(lockres);
 
@@ -650,9 +642,9 @@ void ocfs2_dentry_lock_res_init(struct ocfs2_dentry_lock *dl,
 	memcpy(&lockres->l_name[OCFS2_DENTRY_LOCK_INO_START], &inode_blkno_be,
 	       sizeof(__be64));
 
-	ocfs2_lock_res_init_common(OCFS2_SB(inode->i_sb), lockres,
+	ocfs2_lock_res_init_common(osb, lockres,
 				   OCFS2_LOCK_TYPE_DENTRY, &ocfs2_dentry_lops,
-				   dl);
+				   osb);
 }
 
 static void ocfs2_super_lock_res_init(struct ocfs2_lock_res *res,
-- 
2.53.0

