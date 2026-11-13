Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531507;
	b=AXtXxv8mclEjh9pn3TlnwNPEtaueB7MBsOMthLQ8DmCRWn0hwo0/zj3Lle2v7WZGx9Gn
	 VK7Lu3FsWjRJ7pfIZaNeGbgU9vga1YY9+mCEwNYprLfh95h8YMBRwK8cTYKTEghvqcHdr
	 aYR7hYuTUAoyDwz7ojMs6ExwTR6BrHr5a0eRtp4SfZy7Xo15UrQvZJN5jxbiGHWzYavuK
	 90EKkOH+SO490WFvvSRoHx1l+iT7dw4olxg0PrVpbQUbzTvtcFcteTwFNrIGEXW0vjGA4
	 QBLQhufYQLisD/WjbKAjWZUuSyRetN0KpxAW6E9LSDxnD3MJgLhYU2bXSUPhEiXmkgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531507;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=B3RuW3vP2amvRH4gcgBm81h0BIu74AriWKIy2KZyS6E=;
	b=LUK6k9C+cCKnGJH9H6jo4+c5uRgAyH+E806UySCBlULLX/f2mrQdm4Bou3YA3p8NXbXC
	 ZjZGD8Axm1iwFP/oS/3jl0rPJyK6gNyLbU0/SkpavDNyRmxWDsyeCEXzilNgO3GZ9Hlg3
	 A9Nf/8xfE4dSLrpdmR7CZbJfmw0PF5WKQyvT+qCSkjL8jumtrds0bdBtlN8McQL7pczzZ
	 GQiLfrD5uBSOvFr3kIz36/hXf2g5mkKayHyWpPqGPshdD3UO2bnZceII5RCPWWs2psP8v
	 m422jSqFmnHH8hGJPaCExk/ueC58ci6LNUkRHGuwRSjtUN6KbyaINyZYsCUnxG2Wplg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iHM/sKfl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976C0606A32A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 00:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHM/sKfl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FAB1F000C4;
	Fri, 13 Nov 2026 00:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531507;
	bh=B3RuW3vP2amvRH4gcgBm81h0BIu74AriWKIy2KZyS6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iHM/sKflLBrfsyVuvzjXhHacfl5qu67a4P4ZGPuFmRJkFXEIYIfRmzlSBcOUsgEQb
	 891SW/mRHv4WEd1mNc6pD3tM9XmZQLhhNZql6nGr+/P4JxJcGstoOAxy2+VQA03WLc
	 xXurrDOH6BArqTbRbm+0xG0adh6q7qj1wPlc7ailiEozPel1ifMbWM52x8DUUhnsPw
	 qwefr5vcDwdo5blpqFDgtzTitYPIKsnPulODXcVv250mt23pPJFySdGQLpOs2i9Zfa
	 lOZ8DVhf/y95/HRETgooWWAZ8fgd6SNmoK3q22NAHGXWb1FAU2KxMU7R+WXX9US1wE
	 f0ofEn2wwZTow==
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
Subject: [PATCH 6.6.y 1/2] ocfs2: constify struct ocfs2_lock_res_ops
Date: Thu, 12 Nov 2026 19:58:23 -0500
Message-ID: <20261113005810.435609-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201247-failed-6.6-5b4696e0bfc3@kernel.org>
References: <20261109201247-failed-6.6-5b4696e0bfc3@kernel.org>
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
index 6ff52ebe9fa3c..06fa76950b31d 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -222,12 +222,12 @@ struct ocfs2_lock_res_ops {
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
@@ -235,50 +235,50 @@ static struct ocfs2_lock_res_ops ocfs2_inode_inode_lops = {
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
@@ -511,7 +511,7 @@ static inline void ocfs2_init_start_time(struct ocfs2_mask_waiter *mw)
 static void ocfs2_lock_res_init_common(struct ocfs2_super *osb,
 				       struct ocfs2_lock_res *res,
 				       enum ocfs2_lock_type type,
-				       struct ocfs2_lock_res_ops *ops,
+				       const struct ocfs2_lock_res_ops *ops,
 				       void *priv)
 {
 	res->l_type          = type;
@@ -554,7 +554,7 @@ void ocfs2_inode_lock_res_init(struct ocfs2_lock_res *res,
 			       unsigned int generation,
 			       struct inode *inode)
 {
-	struct ocfs2_lock_res_ops *ops;
+	const struct ocfs2_lock_res_ops *ops;
 
 	switch(type) {
 		case OCFS2_LOCK_TYPE_RW:
diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
index e8b8262026c8a..8bdeea60742af 100644
--- a/fs/ocfs2/ocfs2.h
+++ b/fs/ocfs2/ocfs2.h
@@ -154,7 +154,7 @@ struct ocfs2_lock_stats {
 
 struct ocfs2_lock_res {
 	void                    *l_priv;
-	struct ocfs2_lock_res_ops *l_ops;
+	const struct ocfs2_lock_res_ops *l_ops;
 
 
 	struct list_head         l_blocked_list;
-- 
2.53.0

