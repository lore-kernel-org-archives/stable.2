Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665685;
	b=yLkz3WFOg8vLNLY3ATDmUWRWze4510OsiXxiGhZWb7ghFf/IVcN9uVk1CAsVMUeUFws3
	 q1snVbXtNitnfTzAHLgdrSWGtYZ0wH/ZNULnJLHUJ0kOpRhXPeTxGzHUgh2t1QKdjN95N
	 XFyUqrA76rQaUZoON8fdmEh1D9EtKF3IfmBH35cSyifE6htzziOM8xYAkt3M0XzAvlCfC
	 ruNdqQFkF7lNwA9RZktRopGWFo5qOwL4lNrzqCVttG+6iwutDEX5yMgqBjSOQJiKl3gux
	 LDlv/i5smum0QhEWLVndmv6T8/7zbxo8kgKu55WaJ2Rfj59m16tgLgC0mpkzq2stRdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665685;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=R6ec2oekWgB7vNcSapvnvzrJiJu6tiI4e5JpHFwzPxc=;
	b=tGhxk5zLz/1bFVwB5AR2nwgPJwM+aRX75W9QjttVT1fcW6u/mDK1cbmLHu60vYMpYrID
	 DqF60p3ugT/u46lY5e6mdN1TZIZoyTbnvecd/gT1n+LZWsEHsRMdG0yZ9XOl3qexFhbwg
	 QPEGh2Q1T1VqeaEvRpmu0MXcrUjbkxeihHEkvGHCoNBlhkDViskllNbvbv7hFL66PWeI5
	 bQ1hprsEhdDIjM221flXbPdxmp8a4mA9g/jiXZ84azsHpvePhH8IJTXVJAZvl5ne/gJ2g
	 pdQ5nmgoYhJhX/4oKgJiKR0++PRVZiiNHEou8GDhnm02XO+sXUNDBLtiScI3YZJzYeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldCyODkY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D767606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldCyODkY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12221F000C4;
	Thu, 26 Nov 2026 04:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795665684;
	bh=R6ec2oekWgB7vNcSapvnvzrJiJu6tiI4e5JpHFwzPxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ldCyODkYXVzTlvKq1eJsmKlDgtQucPKaKQfvG4iaKSzIc58u2WsqA5C7pBVFe7lr+
	 COC/IiRPcVHrIxhNg9hDMEc9D1BqcfB3/ye4pMQw65hQebNmAFJ+ZKENylkbNHyH/n
	 YXQ7bFKslxYwGWuctdPaDAQ2yYBopfeUjF9xO8qXfvozsXb1sLNzx7JA1zSSe23bXs
	 0q1AwXWA0XMM/EafTdmEHyilRG4PFC4KIk8JdxX1ln6dsuM/yJ89VHWWm882vgCrt9
	 C3drYN871/Ff15YWELHNPJQvJh4/QpBtdsD5L+s/PINFivj+zWQS2+QHKr4+xeLmPH
	 nwFOeeBxWfh7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ovl: bump the impure dir version when linking a file with origin
Date: Wed, 25 Nov 2026 23:01:22 -0500
Message-ID: <20261126040109.1870238-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112548-glamorous-playroom-3ca9@gregkh>
References: <2026112548-glamorous-playroom-3ca9@gregkh>
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
[ sashal: Threaded the existing origin argument through the two create helpers into ovl_instantiate(), since this tree has no ovl_create_handle_whiteouts() and ovl_dir_modified() is called inside ovl_instantiate(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/dir.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 3bf306330a8c2..0e1531dbeaec6 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -260,14 +260,14 @@ static int ovl_set_opaque(struct dentry *dentry, struct dentry *upperdentry)
  * may not use to instantiate the new dentry.
  */
 static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
-			   struct dentry *newdentry, bool hardlink)
+			   struct dentry *newdentry, bool hardlink, bool origin)
 {
 	struct ovl_inode_params oip = {
 		.upperdentry = newdentry,
 		.newinode = inode,
 	};
 
-	ovl_dir_modified(dentry->d_parent, false);
+	ovl_dir_modified(dentry->d_parent, origin);
 	ovl_dentry_set_upper_alias(dentry);
 
 	if (!hardlink) {
@@ -325,7 +325,7 @@ static bool ovl_type_origin(struct dentry *dentry)
 }
 
 static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
-			    struct ovl_cattr *attr)
+			    struct ovl_cattr *attr, bool origin)
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
@@ -348,7 +348,8 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 		ovl_set_opaque(dentry, newdentry);
 	}
 
-	err = ovl_instantiate(dentry, inode, newdentry, !!attr->hardlink);
+	err = ovl_instantiate(dentry, inode, newdentry, !!attr->hardlink,
+			      origin);
 	if (err)
 		goto out_cleanup;
 out_unlock:
@@ -446,7 +447,7 @@ static int ovl_set_upper_acl(struct ovl_fs *ofs, struct dentry *upperdentry,
 }
 
 static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
-				    struct ovl_cattr *cattr)
+				    struct ovl_cattr *cattr, bool origin)
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *workdir = ovl_workdir(dentry);
@@ -532,7 +533,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 		if (err)
 			goto out_cleanup;
 	}
-	err = ovl_instantiate(dentry, inode, newdentry, hardlink);
+	err = ovl_instantiate(dentry, inode, newdentry, hardlink, origin);
 	if (err) {
 		ovl_cleanup(ofs, udir, newdentry);
 		dput(newdentry);
@@ -610,9 +611,9 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
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

