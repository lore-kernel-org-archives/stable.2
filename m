Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665284;
	b=VLWNJbAMoCs4mSHvVxzyUdG0YW1OUgKjJOV+MO++uYgtn0lPmJ1+BjqgFPinixqs0M7T
	 uQcrsppqjEWhdBvz9nN7UPMQcoIdZAVQzW23Ex7ImW5C40rlyyPQS+HcaP4AGkLymL7VZ
	 KneS/wMUYiuyo7/vAwyzNK9WJIm9jb1wkMh5wxy1yTE8PrSvz1K6PLERhxSUitcOj/uTY
	 ICLWBCnK3AI3MzXTBjWOTXG1d6E3QmZHDDTRQWDabKYKYcWoMBPKLw1KxJ8oSjniG3eCw
	 3jX4dM7nKyXz+AiqMw0/Zq60HiA6uOihKIGhqPL9wUta1sKQlOIZCZKsh7QA88ChKQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665284;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BCbuiKPv9/wBv36OrXDAjpETXLEnMQG/K0UnBxY1B00=;
	b=pxsNGXBNOdkLbuL/IpyNOUBhZ4CFcdARle/4a1LrcZK8fP4I0fQDX47KGhwAuR5OXwsS
	 oL2a1vZK4Qub9mz9FiEKTCRZmPQ9g7i7Vr2T9FIFSj5dqGtwt3AEBhiwZ4ib2mJ0yZAej
	 qc6UUWrSjUReIIymoKH3mevpJ6RfGFima6f1i/v06nsq6Ecm0Zb5hzlhYUgA5641Vrdzp
	 iabfBsfpomTsdIG8TyWL5tJykCAogL9htnFmGsdGb9NDlg8y3h01M2A+TetZsYEe0OEDO
	 uxt6t+0rsTS4Gecrn8wmZSR/PHO3ZtOISlPUn1Ys9nqngtJ/yT5iT6dOwwNXh8GaFlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XrPa5zPH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CFD606A327
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XrPa5zPH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748611F000CF;
	Thu, 26 Nov 2026 03:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795665284;
	bh=BCbuiKPv9/wBv36OrXDAjpETXLEnMQG/K0UnBxY1B00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XrPa5zPHn7/5TotJauHXDU6ZL0V9gCjn/O+t3ODWBwYbQUFjkvSDMXX2C5jwQAhnp
	 WLQE9OSP2uOdFQIs6aqMmNylUUz86GmdVz30OEvxB5pG5HAQSpRJhswNJgclQ0SNQi
	 Ve2Q5mX1tFh/px3/7ZO5zvnUOabJMuc1jryoDUdv2tkurChoENkRPZdvDOvN+iXNi+
	 MnMn5X4hpGwC0YTZTCiXRAg+UGMO3mAHUb8LVVC60QLqYJGpUZvIJSdfdtDSKUgfJV
	 IQUFObzOebLerlgVvo03TtSdyEEY4InEyuGCtC0OlZIVpd2/ZbJeqkkAhQjKPhjuQl
	 xoE/qWLfB9lJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ovl: bump the impure dir version when linking a file with origin
Date: Wed, 25 Nov 2026 22:54:42 -0500
Message-ID: <20261126035416.1771600-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112548-unwatched-prevent-2781@gregkh>
References: <2026112548-unwatched-prevent-2781@gregkh>
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

From: Daejun Park <daejun7.park@samsung.com>

[ Upstream commit 86e2facd8630cc2fdec6ea80c53e370b26b441d9 ]

Linking a file with copy up origin into a non-merge impure dir does
not bump the dir version. readdir then reuses the impure dir cache
built before the link. It reports the upper inode number as d_ino of
the new link, not st_ino.

Pass whether the linked file has an origin to ovl_dir_modified(), as
rename and unlink do.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-98f207b6-3936-48e9-a40f-88f20be4db7b
Fixes: 4edb83bb1041 ("ovl: constant d_ino for non-merge dirs")
Cc: stable@vger.kernel.org
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[ sashal: Added a bool origin parameter to ovl_create_upper() and ovl_create_over_whiteout() and passed it from the direct calls in ovl_create_or_link(), since the upstream ovl_create_handle_whiteouts() wrapper doesn't exist here. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/dir.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 0ff5b4b54e0e8..38841e1b2f7b5 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -328,7 +328,7 @@ static bool ovl_type_origin(struct dentry *dentry)
 }
 
 static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
-			    struct ovl_cattr *attr)
+			    struct ovl_cattr *attr, bool origin)
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
@@ -351,7 +351,7 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 		ovl_set_opaque(dentry, newdentry);
 	}
 
-	ovl_dir_modified(dentry->d_parent, false);
+	ovl_dir_modified(dentry->d_parent, origin);
 	err = ovl_instantiate(dentry, inode, newdentry, !!attr->hardlink, NULL);
 	if (err)
 		goto out_cleanup;
@@ -450,7 +450,7 @@ static int ovl_set_upper_acl(struct ovl_fs *ofs, struct dentry *upperdentry,
 }
 
 static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
-				    struct ovl_cattr *cattr)
+				    struct ovl_cattr *cattr, bool origin)
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *workdir = ovl_workdir(dentry);
@@ -536,7 +536,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 		if (err)
 			goto out_cleanup;
 	}
-	ovl_dir_modified(dentry->d_parent, false);
+	ovl_dir_modified(dentry->d_parent, origin);
 	err = ovl_instantiate(dentry, inode, newdentry, hardlink, NULL);
 	if (err) {
 		ovl_cleanup(ofs, udir, newdentry);
@@ -622,9 +622,9 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 	}
 
 	if (!ovl_dentry_is_whiteout(dentry))
-		err = ovl_create_upper(dentry, inode, attr);
+		err = ovl_create_upper(dentry, inode, attr, origin);
 	else
-		err = ovl_create_over_whiteout(dentry, inode, attr);
+		err = ovl_create_over_whiteout(dentry, inode, attr, origin);
 
 out_revert_creds:
 	revert_creds(old_cred);
-- 
2.53.0

