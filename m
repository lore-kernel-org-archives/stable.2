Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794532341;
	b=WzHsO589nkJ/VoLrpyGG8Vb3haAYtPJxYS7kXncifUy4YgARAXxLzRH8dKKqC53Sv5bz
	 21KePNF7uFzoyZiP3J+xWfUt8rlujGn5BaBvCyykyt1wPurOAEeFpg/ZW61CmITlf0v5e
	 vvxH/e5TjWlWFs4zzBwUzRnww5+HyZ+IkUqy/NHZvzUp64sERiPajvWKTOriZf2WM+KqM
	 TG99ZbmO1YA8f1sHq3QdSc7OmCVDsMUSLOibwDkuZ0JOC96kpFVdmyYfrWh8lwVPdmINH
	 RBKj8VxQlriOC0iouCP05qtPjaI2DfUWWxs8FMabKCVwBx69p5pm+jkIbGADhh/UQ+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794532341;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gOIoi0IDFWsIP0FDvoLZZLEqXs4XCuTzk7nLDVnqPmM=;
	b=3H0YD8dPX3uFPP40+2OhwnpMRY8+IGiM0rDiZrZPczjc6PB3KkbVbKm+04cYgUISmws6
	 E2E7FKRm16n8VG18Rhi0dQSr6TSW5YzynJNeqLftbiUrP6xPIlOupxWTafAeTOuH5ZSUh
	 O5IXSkl1zhbMhNY1r9iz3BQuq/qO+1l1uafkdg15tsZskokdqrC2xbwBnl+kLpBlEHw8L
	 1KNJgryonPnTSnBJQNfBkPmW2D+bsfadSAYR/gPPAwVu6oS7UjpOVOSGtvkNbZKHu0UZE
	 /131KyxWrVT3ViUqq0B0CUv7Cj6k7TaHI240ZqWukKYshO9GUWN3Tr1I/MzrO7EnNIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqU5Qc2z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87842606A321
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqU5Qc2z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051FA1F000C4;
	Fri, 13 Nov 2026 01:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794532341;
	bh=gOIoi0IDFWsIP0FDvoLZZLEqXs4XCuTzk7nLDVnqPmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kqU5Qc2zB5cUC/T/CMwDlAyxP8H6H2krQaTpVh5jB+gzA5qMGYjfaVl5PAYoHFdzT
	 yzQY/+u6e1ukBhNHG+xOAD3ZVdgIT/4t8KRjI+aJYK1vBg6kuUWE2QaT8CSq10Nlwr
	 ajfgrjL6nHGcMXEmTFCyYVwTQMaL3+wIyjTcELATQIbrf6teUJlrFt58jaIjwjGIRT
	 lr64JkjjPpZg0fsEN38BdOMQho2chB3DYP+4vvtu+AQNRQmkpU61jpa2XNw3TJIC+m
	 YDczLbA9CZnYWSqyn/l0VPfNKhyBAaQoF03IGJWAU6sxwBTLIIODGOLgE+Vb461NTQ
	 NtHPW+FQ/N9zg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Joseph Qi <jiangqi903@gmail.com>,
	Changwei Ge <gechangwei@live.cn>,
	Gang He <ghe@suse.com>,
	Jun Piao <piaojun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] ocfs2: constify struct ocfs2_lock_res_ops
Date: Thu, 12 Nov 2026 20:12:17 -0500
Message-ID: <20261113011204.583671-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202711-failed-5.10-5b4696e0bfc3@kernel.org>
References: <20261109202711-failed-5.10-5b4696e0bfc3@kernel.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 3ebe69c0c3ae3ef5ecd1ad86aa98a3b7cbe3c7e9 ]

"struct ocfs2_lock_res_ops" are not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

In order to do it, "struct ocfs2_lock_res" also needs to be adjusted to
this new const qualifier.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  83038	   2632	    400	  86070	  15036	fs/ocfs2/dlmglue.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  83806	   1992	    272	  86070	  15036	fs/ocfs2/dlmglue.o

Link: https://lkml.kernel.org/r/43d3e2ae3a97d3cbe93d6ba6ce48ae5ec04d7526.1718382288.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Joseph Qi <jiangqi903@gmail.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Gang He <ghe@suse.com>
Cc: Jun Piao <piaojun@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 5b4696e0bfc3 ("ocfs2: cache the mount context for dentry lock callbacks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/dlmglue.c | 28 ++++++++++++++--------------
 fs/ocfs2/ocfs2.h   |  2 +-
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 63c5312a5ed58..6338ee9fc5a47 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -223,12 +223,12 @@ struct ocfs2_lock_res_ops {
  */
 #define LOCK_TYPE_USES_LVB		0x2
 
-static struct ocfs2_lock_res_ops ocfs2_inode_rw_lops = {
+static const struct ocfs2_lock_res_ops ocfs2_inode_rw_lops = {
 	.get_osb	= ocfs2_get_inode_osb,
 	.flags		= 0,
 };
 
-static struct ocfs2_lock_res_ops ocfs2_inode_inode_lops = {
+static const struct ocfs2_lock_res_ops ocfs2_inode_inode_lops = {
 	.get_osb	= ocfs2_get_inode_osb,
 	.check_downconvert = ocfs2_check_meta_downconvert,
 	.set_lvb	= ocfs2_set_meta_lvb,
@@ -236,50 +236,50 @@ static struct ocfs2_lock_res_ops ocfs2_inode_inode_lops = {
 	.flags		= LOCK_TYPE_REQUIRES_REFRESH|LOCK_TYPE_USES_LVB,
 };
 
-static struct ocfs2_lock_res_ops ocfs2_super_lops = {
+static const struct ocfs2_lock_res_ops ocfs2_super_lops = {
 	.flags		= LOCK_TYPE_REQUIRES_REFRESH,
 };
 
-static struct ocfs2_lock_res_ops ocfs2_rename_lops = {
+static const struct ocfs2_lock_res_ops ocfs2_rename_lops = {
 	.flags		= 0,
 };
 
-static struct ocfs2_lock_res_ops ocfs2_nfs_sync_lops = {
+static const struct ocfs2_lock_res_ops ocfs2_nfs_sync_lops = {
 	.flags		= 0,
 };
 
-static struct ocfs2_lock_res_ops ocfs2_trim_fs_lops = {
+static const struct ocfs2_lock_res_ops ocfs2_trim_fs_lops = {
 	.flags		= LOCK_TYPE_REQUIRES_REFRESH|LOCK_TYPE_USES_LVB,
 };
 
-static struct ocfs2_lock_res_ops ocfs2_orphan_scan_lops = {
+static const struct ocfs2_lock_res_ops ocfs2_orphan_scan_lops = {
 	.flags		= LOCK_TYPE_REQUIRES_REFRESH|LOCK_TYPE_USES_LVB,
 };
 
-static struct ocfs2_lock_res_ops ocfs2_dentry_lops = {
+static const struct ocfs2_lock_res_ops ocfs2_dentry_lops = {
 	.get_osb	= ocfs2_get_dentry_osb,
 	.post_unlock	= ocfs2_dentry_post_unlock,
 	.downconvert_worker = ocfs2_dentry_convert_worker,
 	.flags		= 0,
 };
 
-static struct ocfs2_lock_res_ops ocfs2_inode_open_lops = {
+static const struct ocfs2_lock_res_ops ocfs2_inode_open_lops = {
 	.get_osb	= ocfs2_get_inode_osb,
 	.flags		= 0,
 };
 
-static struct ocfs2_lock_res_ops ocfs2_flock_lops = {
+static const struct ocfs2_lock_res_ops ocfs2_flock_lops = {
 	.get_osb	= ocfs2_get_file_osb,
 	.flags		= 0,
 };
 
-static struct ocfs2_lock_res_ops ocfs2_qinfo_lops = {
+static const struct ocfs2_lock_res_ops ocfs2_qinfo_lops = {
 	.set_lvb	= ocfs2_set_qinfo_lvb,
 	.get_osb	= ocfs2_get_qinfo_osb,
 	.flags		= LOCK_TYPE_REQUIRES_REFRESH | LOCK_TYPE_USES_LVB,
 };
 
-static struct ocfs2_lock_res_ops ocfs2_refcount_block_lops = {
+static const struct ocfs2_lock_res_ops ocfs2_refcount_block_lops = {
 	.check_downconvert = ocfs2_check_refcount_downconvert,
 	.downconvert_worker = ocfs2_refcount_convert_worker,
 	.flags		= 0,
@@ -512,7 +512,7 @@ static inline void ocfs2_init_start_time(struct ocfs2_mask_waiter *mw)
 static void ocfs2_lock_res_init_common(struct ocfs2_super *osb,
 				       struct ocfs2_lock_res *res,
 				       enum ocfs2_lock_type type,
-				       struct ocfs2_lock_res_ops *ops,
+				       const struct ocfs2_lock_res_ops *ops,
 				       void *priv)
 {
 	res->l_type          = type;
@@ -555,7 +555,7 @@ void ocfs2_inode_lock_res_init(struct ocfs2_lock_res *res,
 			       unsigned int generation,
 			       struct inode *inode)
 {
-	struct ocfs2_lock_res_ops *ops;
+	const struct ocfs2_lock_res_ops *ops;
 
 	switch(type) {
 		case OCFS2_LOCK_TYPE_RW:
diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
index f046edf129a43..c6905a75d692b 100644
--- a/fs/ocfs2/ocfs2.h
+++ b/fs/ocfs2/ocfs2.h
@@ -156,7 +156,7 @@ struct ocfs2_lock_stats {
 
 struct ocfs2_lock_res {
 	void                    *l_priv;
-	struct ocfs2_lock_res_ops *l_ops;
+	const struct ocfs2_lock_res_ops *l_ops;
 
 
 	struct list_head         l_blocked_list;
-- 
2.53.0

