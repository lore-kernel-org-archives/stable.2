Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604589;
	b=TPgUZlRrURJuBWgmPcGodKXk2ZH5PxcCdyA+GPVyqlLNN1uwISOgaNHndjC9lbLtDaC6
	 qniOdJhOeWpzMG3Xal9FRTut79gl54AMN2DomDcyQIhP0BfCjwCAagC0rHm1bXh7iLk6S
	 2YtQyCEhASXDaBzK1iA7233OyUmdub9Auc5fTN5xNQfS0OO6L0fIrJTMYelt76/cWybr1
	 dfwnkVZk6oMGmnVXp0kaH6yN+MQkIUugOf/4+UdNBK7WQrK5RNVFn7EPeImkJq6ky08T2
	 ZXeHOGon6sMhVrsiOibKAGBK83PSHpQybBAtCy3MSYCYOJVg+PBFMajGD20jE7+6Dig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604589;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PlBHwCZN9chE1oae94WIbSAnzUKcWgbTseqAsNGa/0w=;
	b=2jk/YyD2BfmMIDLK4IiE5T7r5oZDQZCIiyTL/VoxuSUbE9yYirigXz3fSXwEYc0ue3aj
	 DrpheEy/76yHlujWBDshMxzadfme7b5A8RKETprKyzgN2F6ArsBEV7Abv7FZkLgjbzOBq
	 YX/xTUMRZraqBTGQ05osplW0Hm/FLkfHx3EkabBjzHtL/sHPu/cvON75YQWcEAvW0twMu
	 Xwz62rJn1LpV8vuFzy8isdLhTmn/dhPwWOKMdExECKI1JDvTmw3BZmPFT/GlmMbWL3eWX
	 tGK9nycUP6owtPSvtjW9K100MYgiTpDGMivSVRlMAK2rKWZ022b7TbkuqwpKyAoJyDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ORgwZIVY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A832A606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ORgwZIVY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDB41F000C0;
	Wed, 25 Nov 2026 11:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795604589;
	bh=PlBHwCZN9chE1oae94WIbSAnzUKcWgbTseqAsNGa/0w=;
	h=Subject:To:Cc:From:Date;
	b=ORgwZIVYx7I2xh+/5SirXtgSREdkn4qPunaX4xzqUvrfsajQge3fGw9YEvlWw74W7
	 I/GDX9deWTCEUl6hndbv//FlReD4PMAKjfuNJ7X9a4eveCSVDIgSzNrwbllbpcSWeM
	 Iktc+zr+bcDzuR+PJIYXyt3blti6ZRUKcZggGslA=
Subject: FAILED: patch "[PATCH] ovl: bump the impure dir version when linking a file with" failed to apply to 6.1-stable tree
To: daejun7.park@samsung.com,amir73il@gmail.com,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:44:49 +0100
Message-ID: <2026112549-spearhead-donor-ab3f@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 86e2facd8630cc2fdec6ea80c53e370b26b441d9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112549-spearhead-donor-ab3f@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 86e2facd8630cc2fdec6ea80c53e370b26b441d9 Mon Sep 17 00:00:00 2001
From: Daejun Park <daejun7.park@samsung.com>
Date: Thu, 12 Nov 2026 12:58:09 +0900
Subject: [PATCH] ovl: bump the impure dir version when linking a file with
 origin

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

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index e0a164e22d67..8fec18dc5fc7 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -368,7 +368,7 @@ static bool ovl_type_origin(struct dentry *dentry)
 }
 
 static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
-			    struct ovl_cattr *attr)
+			    struct ovl_cattr *attr, bool origin)
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
@@ -393,7 +393,7 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 		ovl_set_opaque(dentry, newdentry);
 	}
 
-	ovl_dir_modified(dentry->d_parent, false);
+	ovl_dir_modified(dentry->d_parent, origin);
 	err = ovl_instantiate(dentry, inode, newdentry, !!attr->hardlink, NULL);
 	if (err)
 		goto out_cleanup;
@@ -491,7 +491,7 @@ static int ovl_set_upper_acl(struct ovl_fs *ofs, struct dentry *upperdentry,
 }
 
 static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
-				    struct ovl_cattr *cattr)
+				    struct ovl_cattr *cattr, bool origin)
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *workdir = ovl_workdir(dentry);
@@ -582,7 +582,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 		if (err)
 			goto out_cleanup_unlocked;
 	}
-	ovl_dir_modified(dentry->d_parent, false);
+	ovl_dir_modified(dentry->d_parent, origin);
 	err = ovl_instantiate(dentry, inode, newdentry, hardlink, NULL);
 	if (err) {
 		ovl_cleanup(ofs, upperdir, newdentry);
@@ -647,12 +647,12 @@ DEFINE_CLASS(ovl_override_creator_creds,
 
 static int ovl_create_handle_whiteouts(struct dentry *dentry,
 				       struct inode *inode,
-				       struct ovl_cattr *attr)
+				       struct ovl_cattr *attr, bool origin)
 {
 	if (!ovl_dentry_is_whiteout(dentry))
-		return ovl_create_upper(dentry, inode, attr);
+		return ovl_create_upper(dentry, inode, attr, origin);
 
-	return ovl_create_over_whiteout(dentry, inode, attr);
+	return ovl_create_over_whiteout(dentry, inode, attr, origin);
 }
 
 static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
@@ -687,12 +687,14 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 		 */
 
 		if (attr->hardlink)
-			return ovl_create_handle_whiteouts(dentry, inode, attr);
+			return ovl_create_handle_whiteouts(dentry, inode, attr,
+							   origin);
 
 		scoped_class(ovl_override_creator_creds, cred, original_creds, dentry, inode, attr->mode) {
 			if (IS_ERR(cred))
 				return PTR_ERR(cred);
-			return ovl_create_handle_whiteouts(dentry, inode, attr);
+			return ovl_create_handle_whiteouts(dentry, inode, attr,
+							   origin);
 		}
 	}
 	return err;

