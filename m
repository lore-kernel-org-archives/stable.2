Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516194;
	b=Rl7aXr6Hm+XAaBK2rjBxpzDgcCbmukc8MbpjgzMP1YZJxHp7/MN1ALsttUTZUb2FSNJn
	 lylXCvyDOJet9+RqI+0idyRpqKqV7WHhnDDS8a/a/4sN1B1XuoHT0UkmeBiLUq0zxJXV9
	 GgQ2QfBIk26vQTkD5yA05uVSM5wyYxJ37JpYV86nVR78PkGFaef+PcfbMOhYYUHobsXoo
	 /Q4o9sML8kzMzkXYJ0pLNvmD8aYViBGOKSPYzl/og1StAwvINUj1AkBXmKnZxJPYssZFm
	 5vR47gPl+MBnyvWcsfuB+F5zm98GOtKSadUHN1NoK9q83S9qn9UwX0305EIWutOUE7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516194;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uXwXjqcsDzkJx5tOGNO4BGkZ4DbbosgT5s3MRdWYA88=;
	b=3CR6XY3+Fw3ZFWH98/emYabRnoPHF9gQ+s77wY+lybB7wdcaq/AiB+6zEsZzM1pPPBg2
	 kz1JvYb0MClXPgLj7+U6iCVly7Lpzyp7BPPQ1m5NY1aiZXdeZ8rDi4sjMeNABFR6gG2Jd
	 P7ky5Ad0p+tDA1v9xAuK/j0eHwxdNK0siDBVvOHu2Um3WEO/GlptIcFSy+w7zYxepACRk
	 qHGGjt1ef9smjXtaTM0OiDdxjm2zyvrHlQgtSPcOsaxQLVU6cj23MxZwYCG8dVdhmxJ9d
	 gveAn/Ba5ba+8WUvA2GYNPgmyHbDTKti9Rk5DRGXbSudmzj7EhnBxYlRZUW+eWhRjIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0OKusye;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30369606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0OKusye
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2411F000C7;
	Thu, 12 Nov 2026 20:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794516194;
	bh=uXwXjqcsDzkJx5tOGNO4BGkZ4DbbosgT5s3MRdWYA88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H0OKusyeHW/OLaRQ3gXydp7I/wVG9s7ZSd84sPqAltBwlIhd07qZHEs7aoxK14heM
	 i0GFfA3pIsBwh6Wdh+qXYtvLlesMeaRjGVX0RG5Pk7YgCmVD+BbDV/Phs/qzOo5GU0
	 oNaNnjAPEt3tqgEVo5u9hMmw1izGYD7r7ZXrDkWkleDXuRONNmiX6WnyzlAEzzdghW
	 o8D6PT0ozV5jBKg/Z6K6+u4P9B8hE+fk+5HO4L0+miTXhZcc5GuwEa25Q7g5MUT4va
	 0DbiVlndVcQJvJUVpSa3ivqbzKbXwnDugza2fMJWzIVnSmalmU449JGzcbwqRQfdjB
	 hqFIWEj8g09rA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Nirmoy Das <nirmoyd@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] ovl: add assertions in dir cache code
Date: Thu, 12 Nov 2026 15:43:11 -0500
Message-ID: <20261112203246.3570016-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200159-failed-7.3-9ff338af0e00@kernel.org>
References: <20261109200159-failed-7.3-9ff338af0e00@kernel.org>
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

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit ba227ed05b385926094741e2d566789525c36085 ]

Overlayfs may keep two different types of directory cache
merged (refcounted) and impure (not refcounted) in the inode.

They are mutually exclusive and an overlayfs directory is never
expected to switch between merged and impure modes.

Nevertheless it is hard to prove that races in the code are not
possible, so add assertions to fortify the code accessing the
directory cache to make sure it does not free the unexpected
cache type.

If an assertion fires the code may leak dir cache memory
but it will not access freed cache memory.

Suggested-by: Nirmoy Das <nirmoyd@nvidia.com>
Link: https://lore.kernel.org/r/20260511062057.2365769-1-nirmoyd@nvidia.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Stable-dep-of: 9ff338af0e00 ("ovl: inherit FMODE_NONOTIFY when reading directory layers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/readdir.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index e23331212a29b..5d21a328fad46 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -36,6 +36,7 @@ struct ovl_cache_entry {
 struct ovl_dir_cache {
 	long refcount;
 	u64 version;
+	bool is_refcounted;
 	struct list_head entries;
 	struct rb_root root;
 };
@@ -479,13 +480,31 @@ static void ovl_seek_cursor(struct ovl_dir_file *od, loff_t pos)
 	od->cursor = p;
 }
 
+/*
+ * Merged (refcounted) and impure (not refcounted) caches are never
+ * expected to be mixed. On mismatch, detach the cache from the inode
+ * and leak it rather than misuse it. A merged cache is still freed by
+ * its last ovl_cache_put().
+ */
+static struct ovl_dir_cache *ovl_dir_cache_check(struct inode *inode,
+						 bool is_refcounted)
+{
+	struct ovl_dir_cache *cache = ovl_dir_cache(inode);
+
+	if (cache && WARN_ON(cache->is_refcounted != is_refcounted)) {
+		ovl_set_dir_cache(inode, NULL);
+		return NULL;
+	}
+	return cache;
+}
+
 static struct ovl_dir_cache *ovl_cache_get(struct dentry *dentry)
 {
 	int res;
 	struct ovl_dir_cache *cache;
 	struct inode *inode = d_inode(dentry);
 
-	cache = ovl_dir_cache(inode);
+	cache = ovl_dir_cache_check(inode, true);
 	if (cache && ovl_inode_version_get(inode) == cache->version) {
 		WARN_ON(!cache->refcount);
 		cache->refcount++;
@@ -498,6 +517,7 @@ static struct ovl_dir_cache *ovl_cache_get(struct dentry *dentry)
 		return ERR_PTR(-ENOMEM);
 
 	cache->refcount = 1;
+	cache->is_refcounted = true;
 	INIT_LIST_HEAD(&cache->entries);
 	cache->root = RB_ROOT;
 
@@ -698,7 +718,7 @@ static struct ovl_dir_cache *ovl_cache_get_impure(const struct path *path)
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct ovl_dir_cache *cache;
 
-	cache = ovl_dir_cache(inode);
+	cache = ovl_dir_cache_check(inode, false);
 	if (cache && ovl_inode_version_get(inode) == cache->version)
 		return cache;
 
@@ -710,6 +730,7 @@ static struct ovl_dir_cache *ovl_cache_get_impure(const struct path *path)
 	if (!cache)
 		return ERR_PTR(-ENOMEM);
 
+	cache->is_refcounted = false;
 	res = ovl_dir_read_impure(path, &cache->entries, &cache->root);
 	if (res) {
 		ovl_cache_free(&cache->entries);
-- 
2.53.0

