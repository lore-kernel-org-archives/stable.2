Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD343F54CB
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404084; cv=none; b=s60gohSTwbD7ncwVqlTmwhPwXiY8D87CbjGrN04S8MXLsrfmV7ZuWM+uQAf4Pmg1gbOmjAciHi/eOwRRLbyKviP85OkDlSSw+jI41DdazOPg5QNK64SGVUNdiBdMpH4KgMz8awXY9qMS/m6L8ZgBUnwwWw3imkHxOzRzqSS7qJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404084; c=relaxed/simple;
	bh=avRMGojD1+s3r5OUQc77VRYmI/vGRgV7TywQBS2w5PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVAc9LeNbx0V/K+u3BNsvF3YjvyZ2TgqnxqCI4HPqCt9ClXENcpMWbLxLkQmGKG06cdmMbXBItAZ8VJPZqYDqLvcjK4bncfhm1tz+6LFYhkNQ3vVL0u+vBjotXIpdRrDuuPKwwIk0+qPPeJoHeF/N/7Q7u/FBlyv0a/G+lZ1kAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6NGAodp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6NGAodp"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47df43bfb07so747587f8f.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785404081; x=1786008881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sRL7igMRN2frdQ4TUoBRJ2S42DYWVqFHtsOwdDR/oWY=;
        b=a6NGAodpbwCv1r1PVwJk/mS3fkBn5RX7ZTkFUXB/xsuZJwMtbNc1s5DdI9fioovgM2
         w0XYceYSz4MBfn1iBnWoyyM2xA+CYPj6C919hLFh+Ht91BgE6Lk2HITyBIh5gJN7GXif
         /0z1zFGsdlXDuV2n+F+JSmPxAdxqAHzd2DNf//eOTc8qP7vnfnIoFzQUtfJkFHboUMV1
         luezJEx+qbidwOzsUoP0h8tJrr9w6al0CUwxvffaLtsPtTHF7uAxCWY2E1Txg/9Ydvkz
         SPGsmAwgH+A4a+fBwBJuUyynhoWH0Um7e9PJyrtxTE9lPcaQN7wLnFgkQQkrWNcWbXWG
         4kPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785404081; x=1786008881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sRL7igMRN2frdQ4TUoBRJ2S42DYWVqFHtsOwdDR/oWY=;
        b=mzGz5hk7DzxmlqlwPvxb/vMn+o999kpACrp/zTaAkQtUhhzqKqpSN6ZtV0H4ZgtY8q
         DdeD8lhWP+fQc5dA/QugPAb2PFRynpAoMGILI4bCEqVN+Wsety6bP2/wf9E4EZyH38s0
         MevG0XQndIj1Xl7L52WEFXTOMaV9u5hHiTzTJfkeY3s2i7uDqPK8dGtGYGQFCQe9Gs/i
         abJoytGEvlpdKUFHw++NUESnqG2kj+pKPwmCa+bZVKBXaGk5PDQ2b3aJU4z05NjpMkbA
         bYcIwXcaGuS8paztvIWCYrrjBrLBXWLxit3Kjk923G+3+/XUaYTwDhG8uD88Yz5rKzBx
         Obrg==
X-Forwarded-Encrypted: i=1; AHgh+RruN6cdMhzntMXuG97SQJ1tGcfMgV7VSIP4yv7/cebMRlL4n5dP+GasNLO/e+d+PW+xKKuUbNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWtBxGzlpy65CxDqocKlXpmGn2wg149CkgdAhsUq2sVVp+hS7N
	T8vmou9W986t8C4TkwksG2BfP7TnnA4ipFp76l5VvHkNCpZ280NFAekr
X-Gm-Gg: AR+sD13Wju2cpq/sY5aXJC0ObyHvFP4R4jJSJdouJ5ImmSeYN0vfbjHnvkJI7KHx4+W
	1pDHdEt9kgF//cDvrHAOCDZsAF/eI8lLb3+zRga3WL5zNaVGfoU4Dy+nsZbSmKER+2iwU1N+T/3
	ZVHQ6tXpJFS1jmdYOxYuTQy3xRVyB3AaHJAzmpA6RFTClt+0Xp4KtDyIZPooMLnov2hw+L/TckR
	2OBYe6SRtaMkgoIuBnJMQdiUz9uZE9g/wkm9kkzQJokJIJRp0ibldpE0gbZGscdcwPI8GZbE/Wh
	EKUxId7Jr7LpvmX03/MN0ksuYLb6hdBPw1gDxbS7FjsJjJnYLakHFea3L39hL52yGHzTF0U0bl2
	DCeZiXRxg0kuyIzhYuk0y05YU4rZeEqupwsp/ZkZbdfbgZ0JmsKh2qgdjtD/Aky2HGmXR9tKq4t
	z42MoXbwJnyJ2XYWY9EyzoHyW0glLRR45c1Iw9jaGtEhK3JyTeqcv5wUcSq7BjnuzwGASj3mRY5
	ECO+7cBc+NJofkhBN8NNutFvaO++UI9lMf4OmEh8+NiegMJnU1q7t7wPm+VpKdJLABP
X-Received: by 2002:a05:6000:40c8:b0:47f:959f:f6a6 with SMTP id ffacd0b85a97d-47fc82064c7mr2796716f8f.54.1785404080978;
        Thu, 30 Jul 2026 02:34:40 -0700 (PDT)
Received: from valmpani.fritz.box (cgn-195-14-216-95.nc.de. [195.14.216.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88d985csm4897793f8f.1.2026.07.30.02.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:34:40 -0700 (PDT)
From: Vasileios Almpanis <vasilisalmpanis@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+6b16e3d085833cbf3e25@syzkaller.appspotmail.com
Subject: [PATCH 1/2] configfs: pin the symlink target's dirent instead of chasing ->ci_dentry
Date: Thu, 30 Jul 2026 11:30:24 +0200
Message-ID: <20260730093435.195441-2-vasilisalmpanis@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260730093435.195441-1-vasilisalmpanis@gmail.com>
References: <20260730093435.195441-1-vasilisalmpanis@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

create_link() reads the target's configfs_dirent from
item->ci_dentry->d_fsdata, relying on the item reference taken by
get_target().  That reference pins the item, not its dentry: the dentry is
pinned by DCACHE_PERSISTENT, which configfs_remove_dir() releases via
simple_rmdir() while the item is still alive.  A symlink racing with rmdir
of its target can therefore find ->ci_dentry freed and its dirent
released, triggering WARN_ON(!atomic_read(&sd->s_count)) in configfs_get().

Take the dirent in get_target() as well, under ->d_lock and atomically
with the item reference, and pass it down to create_link().  A hashed
dentry has not been killed yet, so its ->d_fsdata reference keeps the
dirent alive there.

Cc: stable@vger.kernel.org
Fixes: 7063fbf22611 ("[PATCH] configfs: User-driven configuration filesystem")
Signed-off-by: Vasileios Almpanis <vasilisalmpanis@gmail.com>
---
 fs/configfs/symlink.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index 31eb28b27309..3b31c714400f 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -76,9 +76,9 @@ static int configfs_get_target_path(struct config_item *item,
 
 static int create_link(struct config_item *parent_item,
 		       struct config_item *item,
+		       struct configfs_dirent *target_sd,
 		       struct dentry *dentry)
 {
-	struct configfs_dirent *target_sd = item->ci_dentry->d_fsdata;
 	char *body;
 	int ret;
 
@@ -115,6 +115,7 @@ static int create_link(struct config_item *parent_item,
 
 
 static int get_target(const char *symname, struct config_item **target,
+		      struct configfs_dirent **target_sd,
 		      struct super_block *sb)
 {
 	struct path path __free(path_put) = {};
@@ -125,7 +126,20 @@ static int get_target(const char *symname, struct config_item **target,
 		return ret;
 	if (path.dentry->d_sb != sb)
 		return -EPERM;
-	*target = configfs_get_config_item(path.dentry);
+	/*
+	 * A hashed dentry guarantees that neither the item nor the dirent
+	 * have been released yet, as removals unhash before dropping.
+	 * Grab both references here. An item reference alone would not keep
+	 * ->ci_dentry alive.
+	 */
+	spin_lock(&path.dentry->d_lock);
+	if (!d_unhashed(path.dentry)) {
+		struct configfs_dirent *sd = path.dentry->d_fsdata;
+
+		*target = config_item_get(sd->s_element);
+		*target_sd = configfs_get(sd);
+	}
+	spin_unlock(&path.dentry->d_lock);
 	if (!*target)
 		return -ENOENT;
 	return 0;
@@ -139,6 +153,7 @@ int configfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	struct configfs_dirent *sd;
 	struct config_item *parent_item;
 	struct config_item *target_item = NULL;
+	struct configfs_dirent *target_sd = NULL;
 	const struct config_item_type *type;
 
 	sd = dentry->d_parent->d_fsdata;
@@ -182,7 +197,7 @@ int configfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	 *  AV, a thoroughly annoyed bastard.
 	 */
 	inode_unlock(dir);
-	ret = get_target(symname, &target_item, dentry->d_sb);
+	ret = get_target(symname, &target_item, &target_sd, dentry->d_sb);
 	inode_lock(dir);
 	if (ret)
 		goto out_put;
@@ -196,13 +211,14 @@ int configfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		ret = type->ct_item_ops->allow_link(parent_item, target_item);
 	if (!ret) {
 		mutex_lock(&configfs_symlink_mutex);
-		ret = create_link(parent_item, target_item, dentry);
+		ret = create_link(parent_item, target_item, target_sd, dentry);
 		mutex_unlock(&configfs_symlink_mutex);
 		if (ret && type->ct_item_ops->drop_link)
 			type->ct_item_ops->drop_link(parent_item,
 						     target_item);
 	}
 
+	configfs_put(target_sd);
 	config_item_put(target_item);
 
 out_put:
-- 
2.47.3

