Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F983A4F47
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359473; cv=none; b=h58Uf5xgbo8nJAq2wwOQiwZhkQWC3PcHU9bnIOMy0YVuBWbmKQjPmJS7qk8LYLM0XJFgpS6W0eCtkR2kDikaAcUgDmXsZhAAYeKbnqiK/UwmSu/xZEnrceYGBAQB/gNvANWL/r+M76sG6gKqVqlhBhPnc0sM3rHLu/aiQoC9oxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359473; c=relaxed/simple;
	bh=X/FLnkK1Od0bxL0kCZwmIuceQOXEMhKjIJ8kNViQWh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLjtiwlGuQXH1Tl20dzAsA3Xw32xGG4Mapi3qgk+3nGb4V6s6jq9MZctGGi7jwM1fwI+OF+W5pkdAxcGAjWBseUuRAXmm97OrRCszn4lSpMFuEvMBDJP3DVT7u1HqEwCYtOZ/sV17DT38JAFlj685UTVgdvy2WNxMJFs6UuNJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAhbTMKg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAhbTMKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B3B1F00A3A;
	Mon, 10 Aug 2026 10:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786359471;
	bh=9pXO+iPEgThg7LRxeNjYdJn4EzuzotqVMvGoJcZ+9R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fAhbTMKgw3PJpuaZm28RRuxJ+IAmGZOcBN0sqUEu1CcFUeTwuGAob/SBvOTJlBgpV
	 7GDJjW3xhoSKtJk4vd3UANNNMVLr9wEe2nODfL5c8rmLEySHS2LSK4JL57Qa/pgsxF
	 LEDbbZE75tdm41HZO7JAHGHPOm5ZX+YKFOMRG9Jls9LIq6uA3S28oohQ7ZWbTGQ5Qy
	 Em/ETyfNz1ulsEo/wuaCoJkFsEOqE6ldAjZBjr2jttyzj4zNbjlCa7UCio7ALBvu9/
	 KkiVQf8m8Ob6CYEIjOm3hPsFoHi+KssrPoGjKL5pjMjT9RiJrdCTU9DaVbW9DjrYle
	 XGXhPa+YpbL1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>,
	Jia Zhu <zhujia.zj@bytedance.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] erofs: maintain cookies of share domain in self-contained list
Date: Mon, 10 Aug 2026 06:57:46 -0400
Message-ID: <20260810105747.578969-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810105747.578969-1-sashal@kernel.org>
References: <2026080538-tartly-varying-5d75@gregkh>
 <20260810105747.578969-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jingbo Xu <jefflexu@linux.alibaba.com>

[ Upstream commit 2dfb8c3b122fad4504a92c34ba68f2fe4444b3f6 ]

We'd better not touch sb->s_inodes list and inode->i_count directly.
Let's maintain cookies of share domain in a self-contained list in erofs.

Besides, relinquish cookie with the mutex held.  Otherwise if a cookie
is registered when the old cookie with the same name in the same domain
has been removed from the list but not relinquished yet, fscache may
complain "Duplicate cookie detected".

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
Link: https://lore.kernel.org/r/20230209063913.46341-3-jefflexu@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Stable-dep-of: c9b47e6b2311 ("erofs: cap LZMA stream pool size")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/fscache.c  | 44 ++++++++++++++++++++------------------------
 fs/erofs/internal.h |  4 ++++
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index c8ecf168ff258..9e24009dc098b 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -9,6 +9,7 @@
 static DEFINE_MUTEX(erofs_domain_list_lock);
 static DEFINE_MUTEX(erofs_domain_cookies_lock);
 static LIST_HEAD(erofs_domain_list);
+static LIST_HEAD(erofs_domain_cookies_list);
 static struct vfsmount *erofs_pseudo_mnt;
 
 static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space *mapping,
@@ -389,8 +390,6 @@ const struct address_space_operations erofs_fscache_access_aops = {
 
 static void erofs_fscache_domain_put(struct erofs_domain *domain)
 {
-	if (!domain)
-		return;
 	mutex_lock(&erofs_domain_list_lock);
 	if (refcount_dec_and_test(&domain->ref)) {
 		list_del(&domain->list);
@@ -505,6 +504,8 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
+	INIT_LIST_HEAD(&ctx->node);
+	refcount_set(&ctx->ref, 1);
 
 	cookie = fscache_acquire_cookie(volume, FSCACHE_ADV_WANT_CACHE_SIZE,
 					name, strlen(name), NULL, 0, 0);
@@ -550,6 +551,7 @@ static void erofs_fscache_relinquish_cookie(struct erofs_fscache *ctx)
 	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
 	fscache_relinquish_cookie(ctx->cookie, false);
 	iput(ctx->inode);
+	iput(ctx->anon_inode);
 	kfree(ctx->name);
 	kfree(ctx);
 }
@@ -582,6 +584,7 @@ struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
 
 	ctx->domain = domain;
 	ctx->anon_inode = inode;
+	list_add(&ctx->node, &erofs_domain_cookies_list);
 	inode->i_private = ctx;
 	refcount_inc(&domain->ref);
 	return ctx;
@@ -595,29 +598,23 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
 						   char *name,
 						   unsigned int flags)
 {
-	struct inode *inode;
 	struct erofs_fscache *ctx;
 	struct erofs_domain *domain = EROFS_SB(sb)->domain;
-	struct super_block *psb = erofs_pseudo_mnt->mnt_sb;
 
 	mutex_lock(&erofs_domain_cookies_lock);
-	spin_lock(&psb->s_inode_list_lock);
-	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
-		ctx = inode->i_private;
-		if (!ctx || ctx->domain != domain || strcmp(ctx->name, name))
+	list_for_each_entry(ctx, &erofs_domain_cookies_list, node) {
+		if (ctx->domain != domain || strcmp(ctx->name, name))
 			continue;
 		if (!(flags & EROFS_REG_COOKIE_NEED_NOEXIST)) {
-			igrab(inode);
+			refcount_inc(&ctx->ref);
 		} else {
 			erofs_err(sb, "%s already exists in domain %s", name,
 				  domain->domain_id);
 			ctx = ERR_PTR(-EEXIST);
 		}
-		spin_unlock(&psb->s_inode_list_lock);
 		mutex_unlock(&erofs_domain_cookies_lock);
 		return ctx;
 	}
-	spin_unlock(&psb->s_inode_list_lock);
 	ctx = erofs_fscache_domain_init_cookie(sb, name, flags);
 	mutex_unlock(&erofs_domain_cookies_lock);
 	return ctx;
@@ -634,23 +631,22 @@ struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
 
 void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
 {
-	bool drop;
-	struct erofs_domain *domain;
+	struct erofs_domain *domain = NULL;
 
 	if (!ctx)
 		return;
-	domain = ctx->domain;
-	if (domain) {
-		mutex_lock(&erofs_domain_cookies_lock);
-		drop = atomic_read(&ctx->anon_inode->i_count) == 1;
-		iput(ctx->anon_inode);
-		mutex_unlock(&erofs_domain_cookies_lock);
-		if (!drop)
-			return;
-	}
+	if (!ctx->domain)
+		return erofs_fscache_relinquish_cookie(ctx);
 
-	erofs_fscache_relinquish_cookie(ctx);
-	erofs_fscache_domain_put(domain);
+	mutex_lock(&erofs_domain_cookies_lock);
+	if (refcount_dec_and_test(&ctx->ref)) {
+		domain = ctx->domain;
+		list_del(&ctx->node);
+		erofs_fscache_relinquish_cookie(ctx);
+	}
+	mutex_unlock(&erofs_domain_cookies_lock);
+	if (domain)
+		erofs_fscache_domain_put(domain);
 }
 
 int erofs_fscache_register_fs(struct super_block *sb)
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4709c869a7431..3607bd4327633 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -108,7 +108,11 @@ struct erofs_fscache {
 	struct fscache_cookie *cookie;
 	struct inode *inode;
 	struct inode *anon_inode;
+
+	/* used for share domain mode */
 	struct erofs_domain *domain;
+	struct list_head node;
+	refcount_t ref;
 	char *name;
 };
 
-- 
2.53.0

