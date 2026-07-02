Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FE72BEC2B
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007329; cv=none; b=FJNXMakklq4ZG9SeJCzL6Qun1KbzDWhNE3Gak3Xx3VrG+CAO1iPFinMX6MWdtUs4y3zcHRnOu6+IxWXG5AwCUEfNV299Q5dDJxtaP98P+xwtO1Tjmk/O9C+cVElqX0VWrGBk9bw9TI6ZYcaLsWutATPNXsC764akvCLf9T/DbW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007329; c=relaxed/simple;
	bh=GHe4f0gJmEY4HTStiVAVdP5FYbjDD0vlOpHVKNuxEy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A3+1EPRieyGRwX/2ueCmyHHR1R0N/+kZyQAL1GInJFIfxIbHj+kNqm1y3F56lEXc+aEdk4VQTwYlA/qy2oRm4GitaYVROQueC/44PmXugkHoEDXaBUag5hsL7878TzHcH3R6qwum2AHR+ihCNwxMuLlLkjpmz8e2/Q71RpDKaTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=nQFzvMGU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="nQFzvMGU"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-470174001a0so1462672f8f.0
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1783007326; x=1783612126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cKj12gt7daFFKUdXxcgEMCasVJqe5u0XDbVIMbqELsI=;
        b=nQFzvMGUQvQI6EZOe0f5vgqCjTjZ5zGyoHAouupznJn54kFGa+XSQanNNML1Q+prB7
         eh2OTzsy3DVO/c6MJrue4dsvXfZYMHlTYJHM1GNnxz5eCAdHR4PCC2XrUuWKLnnsFJdX
         m23pyJAui+jBLsB+hXtXNc2p0rDEP1H7rRuZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783007326; x=1783612126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKj12gt7daFFKUdXxcgEMCasVJqe5u0XDbVIMbqELsI=;
        b=NOsQqPVLAB2uRJh07Yy49MxJZV1YKT0Iiw8l56qloPFW4tma/Bnfxq6dOqzEW9O4Sg
         yYD5vPpBYwuFQI6CkbtEhKi922pbjxXYXeuKbe/Vy9QxMEmCQlodgMvkKssAEa/6I9aK
         LFw65/WsNM0yhPNEuwcZxtgMHZJA6+h7vqm1zJKHKb6+Jdf6k/rpVTRUsZV1HFqu0IQA
         y7Ied/NvRAZwESWY+FtK9puCREA5jj0wenJlOhVfCiK4Djjdnt2KX3tQsOjFlQ9Q5Hly
         NF1xO/PcmJIJ5IB4zab+f3e8xyesjt7aF1ICgLREto4fNVDIb21qJUx9aV/N8nuZRHEq
         DfaQ==
X-Gm-Message-State: AOJu0YwZLQjWRpIU+zKb9HPe/V407ggQgbG0bD+7yNSTgZALwCWIml9I
	OFHRHpD9FebVIx1gXG7km2vJd/iEws2yfNOEWB/hmYxsdCCsjO4LkjrTT0MPawYP86PjLYNVsnQ
	exMtDgjDc+g==
X-Gm-Gg: AfdE7clR3B6peHkm0fFafGsobIET94N8Q4B8LCzzfLAXF3Ot7C3yP0JBgfoLHp7CXRv
	Ntgfcu5Xr/GI1KysIlDZNuXrSwmsV5hNzJoR/K7OY9lKOGLd91oAs+aGPf7ZbRa8fXT2cj0TF6m
	x1tLIqaH6k39OnFv40CX/T1/m9nD+OEiTvC5IYPW6jDrRS2AXe0gwhrQCNm00FjBbnVqRDA/9DY
	XH+REfl0riv8BQ0saFau9k9v5if0mGHpQgLeEnzc6EtDoIYJJZLcHtevQqT7m4KuV6/S2bcvyj5
	DT+H6S12NHbWOPBC59cgl2jSpnw2SEqSvjquS527rY3IJGt7BSPTgBuCuWB1YeUX898MVe8N9dd
	CGzyhP3KUqRRsI02bUG3934FZz+sQ/18DZZmfNu+jtOxUFZIC/HV8oQQEXreHXgEryYwmSUGMDM
	0JrKxLAevviv4W6PtGSwO/JUCU5/RSp0jX3rrbUS2zubXUEx/AqDiYSTG+GK50FaXJs45K1GIDg
	8LlIh0+jSiNOdopY+dJAA+t9M/1
X-Received: by 2002:a05:6000:2507:b0:473:975c:4fd1 with SMTP id ffacd0b85a97d-477b3d5c5bfmr8449841f8f.25.1783007326422;
        Thu, 02 Jul 2026 08:48:46 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00c56cc01f8c3c1c95.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:c56c:c01f:8c3c:1c95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477de3dc77bsm10042468f8f.33.2026.07.02.08.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 08:48:46 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: stable@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Theodore Ts'o <tytso@mit.edu>,
	Yoann Congal <yoann.congal@smile.fr>,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: [PATCH 6.6.y] ext4: get rid of ppath in get_ext_path()
Date: Thu,  2 Jul 2026 17:48:10 +0200
Message-ID: <20260702154810.3435236-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 6b854d552711aa33f59eda334e6d94a00d8825bb ]

The use of path and ppath is now very confusing, so to make the code more
readable, pass path between functions uniformly, and get rid of ppath.

After getting rid of ppath in get_ext_path(), its caller may pass an error
pointer to ext4_free_ext_path(), so it needs to teach ext4_free_ext_path()
and ext4_ext_drop_refs() to skip the error pointer. No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/20240822023545.1994557-13-libaokun@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 fs/ext4/extents.c     |  5 +++--
 fs/ext4/move_extent.c | 34 +++++++++++++++++-----------------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index a94798e23c1af..9c2d23958146b 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -114,7 +114,7 @@ static void ext4_ext_drop_refs(struct ext4_ext_path *path)
 {
 	int depth, i;
 
-	if (!path)
+	if (IS_ERR_OR_NULL(path))
 		return;
 	depth = path->p_depth;
 	for (i = 0; i <= depth; i++, path++) {
@@ -125,6 +125,8 @@ static void ext4_ext_drop_refs(struct ext4_ext_path *path)
 
 void ext4_free_ext_path(struct ext4_ext_path *path)
 {
+	if (IS_ERR_OR_NULL(path))
+		return;
 	ext4_ext_drop_refs(path);
 	kfree(path);
 }
@@ -4242,7 +4244,6 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	path = ext4_find_extent(inode, map->m_lblk, NULL, 0);
 	if (IS_ERR(path)) {
 		err = PTR_ERR(path);
-		path = NULL;
 		goto out;
 	}
 
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index d5636a2a718a8..96a84de321690 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -17,27 +17,23 @@
  * get_ext_path() - Find an extent path for designated logical block number.
  * @inode:	inode to be searched
  * @lblock:	logical block number to find an extent path
- * @ppath:	pointer to an extent path pointer (for output)
+ * @path:	pointer to an extent path
  *
- * ext4_find_extent wrapper. Return 0 on success, or a negative error value
- * on failure.
+ * ext4_find_extent wrapper. Return an extent path pointer on success,
+ * or an error pointer on failure.
  */
-static inline int
+static inline struct ext4_ext_path *
 get_ext_path(struct inode *inode, ext4_lblk_t lblock,
-		struct ext4_ext_path **ppath)
+	     struct ext4_ext_path *path)
 {
-	struct ext4_ext_path *path = *ppath;
-
-	*ppath = NULL;
 	path = ext4_find_extent(inode, lblock, path, EXT4_EX_NOCACHE);
 	if (IS_ERR(path))
-		return PTR_ERR(path);
+		return path;
 	if (path[ext_depth(inode)].p_ext == NULL) {
 		ext4_free_ext_path(path);
-		return -ENODATA;
+		return ERR_PTR(-ENODATA);
 	}
-	*ppath = path;
-	return 0;
+	return path;
 }
 
 /**
@@ -95,9 +91,11 @@ mext_check_coverage(struct inode *inode, ext4_lblk_t from, ext4_lblk_t count,
 	int ret = 0;
 	ext4_lblk_t last = from + count;
 	while (from < last) {
-		*err = get_ext_path(inode, from, &path);
-		if (*err)
-			goto out;
+		path = get_ext_path(inode, from, path);
+		if (IS_ERR(path)) {
+			*err = PTR_ERR(path);
+			return ret;
+		}
 		ext = path[ext_depth(inode)].p_ext;
 		if (unwritten != ext4_ext_is_unwritten(ext))
 			goto out;
@@ -634,9 +632,11 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 		int offset_in_page;
 		int unwritten, cur_len;
 
-		ret = get_ext_path(orig_inode, o_start, &path);
-		if (ret)
+		path = get_ext_path(orig_inode, o_start, path);
+		if (IS_ERR(path)) {
+			ret = PTR_ERR(path);
 			goto out;
+		}
 		ex = path[path->p_depth].p_ext;
 		cur_blk = le32_to_cpu(ex->ee_block);
 		cur_len = ext4_ext_get_actual_len(ex);
