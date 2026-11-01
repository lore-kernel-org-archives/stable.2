Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793530660;
	b=hC1Q9eo5KvYh+HBujdYUVa1PsbBYMgI5sUGc/j6clV5OWKaH7oeiT/0xhPsohu8vznzM
	 3ScgyjaqbC041tYZT8CC7/J+co+iEXlVP57Uv9Pleye1+7uAx5Kv/iCTnJgfg3rifR7Ji
	 zPDqKtK3PTjc6KK/rNS0kgnbd3YjD6YMcaA4UCIeomGrU+ydKpHSkSWumxiVysD0FnmHD
	 vQZGApSHOv1U03NonAO/ANFwPtx/CsL6KMF9CBJrdlb+fuB4MEZAr73jo2ftdE1HIvIKN
	 rmcKdcwvGgsg7IgIG0vy4Dj4QtwE+zqXL87nZGDBXvu3T96MAh0w/Xymd+9qZY2qxfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793530660;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=CaNbPm8GSlwcuwEQUeWdr27EY5F5E2f3iKAah0Gmz8U=;
	b=22jNYfBqIAK86wH11NCH/afxguYBTAgweYNIBxIvipSlLQazEZIs3+xaXplDx2H24mcv
	 mcJIvvKFZgEYOAJ4V0cSH1FEAjayqaBzdA2vgku/ZWch13sG3jFRF33pTqNB8EGV6VHpr
	 6PBCRnjQu0I+vzo/ucFHyLKuY73Cd6mEraJpn8CcMU4PvPZHeMuEAFkcpe6fvg4oV3mVX
	 q765fpdTGkUP/3gPWJpC1n3VKmk5X8XQUTbq/x9ZG9I8vhhCDS6eO/hTCkrSiDaXS7DMN
	 YWaIcLjZICdNAopxdWpX5ALuKGZr6iM2g9ZtPcmjPwB1HHLLdW2AblWQ5u7NT/6uDCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lMGqDiqX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3973606A325;
	Sun,  1 Nov 2026 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lMGqDiqX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226311F00919;
	Sun,  1 Nov 2026 10:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793530659;
	bh=CaNbPm8GSlwcuwEQUeWdr27EY5F5E2f3iKAah0Gmz8U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lMGqDiqXQuXH0k0dCXtjpgPN5dVNAO4HbpcAOxrOH85vU+oq8SNkUcmbjsrdXg9ju
	 nlLaFnPfTTSVCJzsE8qiYB17EVL41CuuFLE5PdB1xTMIr2feHmLcfqSTCyLMYQqlyJ
	 /CDAZ/F1aTPXIy/YveLNaCZywAQNcO9ocTbC67ExfxquLTLoWs7QJGoVBI4GjvJdxf
	 QPA27ngILYClU90K9vM9xvQDNlZbz0rjnIbtyqmoOuVYcxZjN1iWAkopr42NBcllEB
	 7c5jRHklOzZSMVGhl27o+KwfaixPBUmyIVNnuu2ApptngIOH1Ae2DlTUTcc+fq/uGy
	 uA3Q/RE5h41/w==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 01 Nov 2026 11:57:20 +0100
Subject: [PATCH v2 1/3] libfs: make i_rwsem the lock of the offset tree
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-work-libfs-offset_readdir-v2-1-c621125b56d1@kernel.org>
References: <20261101-work-libfs-offset_readdir-v2-0-c621125b56d1@kernel.org>
In-Reply-To: <20261101-work-libfs-offset_readdir-v2-0-c621125b56d1@kernel.org>
To: Chuck Lever <cel@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6479; i=brauner@kernel.org;
 h=from:subject:message-id; bh=l8quPRz6awv7vGP6uW0Cn/ymAyGI7LYomrzn8h0G4p4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9l5aN3FvGYnLlxKSo+l1zO7a8jqifXz59xeQ243V7H
 y+LuLNne0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBFVBgZWlx+LEzcNV39T+CF
 +G0fvYv3dS95GSXzMPuT+XL7T4FOMxl+s789mntRabvI/RabaWI3NvXertz43coq8f2tXQ1b90s
 mMAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The offset tree of a directory is only changed with the directory's
i_rwsem held exclusive and offset_readdir() walks it with i_rwsem held
shared. But the maple tree doesn't know that. It is set up with its
internal spinlock, which every mtree_*() helper takes, and readdir takes
rcu_read_lock() around each lookup.

The next patch makes readdir keep one ma_state across dir_emit(), which
can sleep. That is safe because no writer can run while readdir holds
i_rwsem. But the maple tree only allows keeping a ma_state across a
sleep if it is protected by the tree's lock. A reader that relies on
rcu_read_lock() has to mas_pause() before it drops it, and that means a
walk from the root for every entry again.

So tell the tree what protects it. Initialize it with
MT_FLAGS_LOCK_EXTERN and the directory's i_rwsem as its lock and switch
the writers from the mtree_*() helpers to the mas_*() api. They all run
with i_rwsem held exclusive already. With lockdep enabled the maple tree
now also checks that every writer holds i_rwsem exclusive.

Nothing can reach the offset tree anymore when the directory inode is
destroyed. So clear the external lock with mt_on_stack() and destroy the
tree with __mt_destroy() instead of taking i_rwsem in ->destroy_inode().

Cc: stable@vger.kernel.org # v6.14+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/libfs.c         | 46 +++++++++++++++++++++++++++++-----------------
 include/linux/fs.h |  2 +-
 mm/shmem.c         |  2 +-
 3 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 96a6e9b1535f..653ee8461a8f 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -263,17 +263,18 @@ static long dentry2offset(struct dentry *dentry)
 	return (long)dentry->d_fsdata;
 }
 
-static struct lock_class_key simple_offset_lock_class;
-
 /**
  * simple_offset_init - initialize an offset_ctx
  * @octx: directory offset map to be initialized
+ * @dir: the directory @octx belongs to
  *
+ * The directory's i_rwsem is the lock of the offset map. Writers hold it
+ * exclusive, offset_readdir() holds it shared.
  */
-void simple_offset_init(struct offset_ctx *octx)
+void simple_offset_init(struct offset_ctx *octx, struct inode *dir)
 {
-	mt_init_flags(&octx->mt, MT_FLAGS_ALLOC_RANGE);
-	lockdep_set_class(&octx->mt.ma_lock, &simple_offset_lock_class);
+	mt_init_flags(&octx->mt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN);
+	mt_set_external_lock(&octx->mt, &dir->i_rwsem);
 	octx->next_offset = DIR_OFFSET_MIN;
 }
 
@@ -290,12 +291,13 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
 	unsigned long offset;
 	int ret;
 
+	MA_STATE(mas, &octx->mt, 0, 0);
+
 	if (dentry2offset(dentry) != 0)
 		return -EBUSY;
 
-	ret = mtree_alloc_cyclic(&octx->mt, &offset, dentry, DIR_OFFSET_MIN,
-				 DIR_OFFSET_MAX, &octx->next_offset,
-				 GFP_KERNEL);
+	ret = mas_alloc_cyclic(&mas, &offset, dentry, DIR_OFFSET_MIN,
+			       DIR_OFFSET_MAX, &octx->next_offset, GFP_KERNEL);
 	if (unlikely(ret < 0))
 		return ret == -EBUSY ? -ENOSPC : ret;
 
@@ -308,7 +310,9 @@ static int simple_offset_replace(struct offset_ctx *octx, struct dentry *dentry,
 {
 	int ret;
 
-	ret = mtree_store(&octx->mt, offset, dentry, GFP_KERNEL);
+	MA_STATE(mas, &octx->mt, offset, offset);
+
+	ret = mas_store_gfp(&mas, dentry, GFP_KERNEL);
 	if (ret)
 		return ret;
 	offset_set(dentry, offset);
@@ -323,13 +327,14 @@ static int simple_offset_replace(struct offset_ctx *octx, struct dentry *dentry,
  */
 void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
 {
-	long offset;
+	long offset = dentry2offset(dentry);
+
+	MA_STATE(mas, &octx->mt, offset, offset);
 
-	offset = dentry2offset(dentry);
 	if (offset == 0)
 		return;
 
-	mtree_erase(&octx->mt, offset);
+	mas_erase(&mas);
 	offset_set(dentry, 0);
 }
 
@@ -387,16 +392,20 @@ int simple_offset_rename_exchange(struct inode *old_dir,
 	long new_index = dentry2offset(new_dentry);
 	int ret;
 
+	MA_STATE(old_mas, &old_ctx->mt, old_index, old_index);
+	MA_STATE(new_mas, &new_ctx->mt, new_index, new_index);
+
 	if (WARN_ON(!old_index || !new_index))
 		return -EINVAL;
 
-	ret = mtree_store(&new_ctx->mt, new_index, old_dentry, GFP_KERNEL);
+	ret = mas_store_gfp(&new_mas, old_dentry, GFP_KERNEL);
 	if (WARN_ON(ret))
 		return ret;
 
-	ret = mtree_store(&old_ctx->mt, old_index, new_dentry, GFP_KERNEL);
+	ret = mas_store_gfp(&old_mas, new_dentry, GFP_KERNEL);
 	if (WARN_ON(ret)) {
-		mtree_store(&new_ctx->mt, new_index, new_dentry, GFP_KERNEL);
+		mas_set(&new_mas, new_index);
+		mas_store_gfp(&new_mas, new_dentry, GFP_KERNEL);
 		return ret;
 	}
 
@@ -411,11 +420,14 @@ int simple_offset_rename_exchange(struct inode *old_dir,
  * @octx: directory offset ctx that is about to be destroyed
  *
  * During fs teardown (eg. umount), a directory's offset map might still
- * contain entries. xa_destroy() cleans out anything that remains.
+ * contain entries. __mt_destroy() cleans out anything that remains.
+ * Nothing can reach the map of a directory that is being destroyed, so
+ * this runs without the directory's i_rwsem.
  */
 void simple_offset_destroy(struct offset_ctx *octx)
 {
-	mtree_destroy(&octx->mt);
+	mt_on_stack(octx->mt);
+	__mt_destroy(&octx->mt);
 }
 
 /**
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b5485f2c1f2b..a2046718e839 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3330,7 +3330,7 @@ struct offset_ctx {
 	unsigned long		next_offset;
 };
 
-void simple_offset_init(struct offset_ctx *octx);
+void simple_offset_init(struct offset_ctx *octx, struct inode *dir);
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry);
 void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry);
 void simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
diff --git a/mm/shmem.c b/mm/shmem.c
index 0d891ade18b5..24e2b9510c7c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3089,7 +3089,7 @@ static struct inode *__shmem_get_inode(const struct mnt_idmap *idmap,
 		inode->i_size = 2 * BOGO_DIRENT_SIZE;
 		inode->i_op = &shmem_dir_inode_operations;
 		inode->i_fop = &simple_offset_dir_operations;
-		simple_offset_init(shmem_get_offset_ctx(inode));
+		simple_offset_init(shmem_get_offset_ctx(inode), inode);
 		break;
 	case S_IFLNK:
 		/*

-- 
2.53.0

