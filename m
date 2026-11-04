Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803033;
	b=syl1g9kOf6jc948PPbgMpsM+DtzBYApjXgM+5q5AmIxQHdOSTedHT8d8fudBLdcxr/IJ
	 oSzDUZE4D1ylMBpszSZv3ymxf+VM3V6DWixG/cMCznFhu7ZEUaf28r4uYpTdahXfaveOX
	 49WamFJcDbC6eyHbuKD4TW1WrmtTOgSHkWbwsDcP2o1RQAtZ+wj55ker01qZe20uvcXSK
	 VYzdNFrnFRpDCTmsnTUb2enMhZrkPegL1f3LyiJZILVocvOjrar5LfoAXO1bc4bs5P3wa
	 ysD3IuyZ45rmyh25m65QtrCzFWgXJHccdceXcTUlTuMh9J8DjGPSrWRV7vB51+TEvlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803033;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7sJsRpa/I8dG3zEOAfn0PY332Ob5L5S4JyeVgDzhIQo=;
	b=b6rgS/BY0yVfCDC1wQQ2LUGFxkvBkgz6+WI4wJGQ1Bg98RQ5wAaxxTbAX9C9s8BJ3AIn
	 CHI3NW/ZHRPyoyGWV42V2fLEusV4aze7rp2K9tgy4uXY4y+Sx9/ozxPg3pg+BGwh+4kvG
	 JkXjH0YI7acSHnYcmcK+5KZ31y4wq75LUrln3K+kypZNRRe4H1gZajiJCKFsLoij/41Sk
	 ZJO/WnwfFrePzA0/fjd9Anb8QzKNvl3YtyKiBbaMu8EB7u1voOtmGtamGt3gt0EKcacSv
	 Yq5drKr7/ycT8aIyFZ+DIbyXSediq9kDPC1sljJVV4LTM9cHmPzOnsTxy7NIGnPWd7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MP3hhVJM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ABD606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MP3hhVJM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617C01F000C1;
	Wed,  4 Nov 2026 14:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793803032;
	bh=7sJsRpa/I8dG3zEOAfn0PY332Ob5L5S4JyeVgDzhIQo=;
	h=Subject:To:Cc:From:Date;
	b=MP3hhVJMts2haInrgncQHY6z733W0y41Kxxsoe0DIGJ4pjF6HzhDOqP53J7RmRwW6
	 P9eN+wggHkqVB9br5xCgLces6Z3K2EnJfOP4Z7cudOyBlW9hEITkvyFcOBtF2sxFfK
	 0kTm8DIkem6mPtBT/MALZglgI/7qzyM1hX5Amtgw=
Subject: FAILED: patch "[PATCH] ovl: fortify ovl_copy_xattr() against underlying layer" failed to apply to 5.15-stable tree
To: amir73il@gmail.com,fahad@codepure.com,miklos@szeredi.hu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:37:01 +0100
Message-ID: <2026110401-avatar-tapioca-21c6@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e6b9117076fb4c0ff4a670efa9c876d9a50d79ab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110401-avatar-tapioca-21c6@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e6b9117076fb4c0ff4a670efa9c876d9a50d79ab Mon Sep 17 00:00:00 2001
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 16 Oct 2026 09:33:58 +0200
Subject: [PATCH] ovl: fortify ovl_copy_xattr() against underlying layer
 modifications

Adapt ovl_getxattr_value() to be used from ovl_copy_xattr(), by
allowing to pass it a pre-allocated buffer, which can be resized
and by handling the ENODATA/EOPNOTSUPP return codes in the caller.

This replaces the retry loop in ovl_copy_xattr() with a single retry
after resizing the buffer. If the value changed again by then, the
underlying layer was modified, so return -EIO instead of retrying.

As a side effect, ovl_copy_up_meta_inode_data() now returns -EIO instead
of -ERANGE in this case of underlying xattr size changes.

Reported-by: Fahad Alharbi <fahad@codepure.com>
Tested-by: Fahad Alharbi <fahad@codepure.com>
Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Link: https://lore.kernel.org/linux-fsdevel/CAJfpegsVoUyqy0dYkTvBGRZvgdv_nmzmCw_uF+LP-Vq3EhEkSg@mail.gmail.com/
Fixes: e4ad29fa0d22 ("ovl: use a minimal buffer in ovl_copy_xattr")
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index c220cb5d0b70..eee22581b14f 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -72,6 +72,9 @@ static int ovl_copy_acl(struct ovl_fs *ofs, const struct path *path,
 	return err;
 }
 
+static ssize_t ovl_getxattr_value(const struct path *path, char *name,
+				  char **value, ssize_t *value_size);
+
 int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct dentry *new)
 {
 	struct dentry *old = oldpath->dentry;
@@ -129,34 +132,12 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
 			break;
 		}
 
-retry:
-		size = ovl_do_getxattr(oldpath, name, value, value_size);
-		if (size == -ERANGE) {
-			size = ovl_do_getxattr(oldpath, name, NULL, 0);
-			/* Nothing was read into value, so it must not be used */
-			if (size >= 0 && size <= value_size)
-				size = -EIO;
-		}
-
+		size = ovl_getxattr_value(oldpath, name, &value, &value_size);
 		if (size < 0) {
 			error = size;
 			break;
 		}
 
-		if (size > value_size) {
-			void *new;
-
-			new = kvmalloc(size, GFP_KERNEL);
-			if (!new) {
-				error = -ENOMEM;
-				break;
-			}
-			kvfree(value);
-			value = new;
-			value_size = size;
-			goto retry;
-		}
-
 		error = ovl_do_setxattr(OVL_FS(sb), new, name, value, size, 0);
 		if (error) {
 			if (error != -EOPNOTSUPP || ovl_must_copy_xattr(name))
@@ -1059,26 +1040,39 @@ static bool ovl_need_meta_copy_up(struct dentry *dentry, umode_t mode,
 	return true;
 }
 
-static ssize_t ovl_getxattr_value(const struct path *path, char *name, char **value)
+static ssize_t ovl_getxattr_value(const struct path *path, char *name,
+				  char **value, ssize_t *value_size)
 {
 	ssize_t res;
 	char *buf;
 
-	res = ovl_do_getxattr(path, name, NULL, 0);
-	if (res == -ENODATA || res == -EOPNOTSUPP)
-		res = 0;
+	res = ovl_do_getxattr(path, name, *value, *value_size);
+	if (res == -ERANGE) {
+		res = ovl_do_getxattr(path, name, NULL, 0);
+		/* Xattr changed underneath us? */
+		if (res >= 0 && res <= *value_size)
+			return -EIO;
+	}
 
-	if (res > 0) {
-		buf = kzalloc(res, GFP_KERNEL);
+	if (res > *value_size) {
+		buf = kvmalloc(res, GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
 
 		res = ovl_do_getxattr(path, name, buf, res);
-		if (res < 0)
-			kfree(buf);
-		else
-			*value = buf;
+		if (res < 0) {
+			kvfree(buf);
+			/* Xattr changed underneath us? */
+			if (res == -ERANGE)
+				return -EIO;
+			return res;
+		}
+
+		kvfree(*value);
+		*value = buf;
+		*value_size = res;
 	}
+
 	return res;
 }
 
@@ -1089,7 +1083,7 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 	struct path upperpath;
 	int err;
 	char *capability = NULL;
-	ssize_t cap_size;
+	ssize_t cap_size = 0;
 
 	ovl_path_upper(c->dentry, &upperpath);
 	if (WARN_ON(upperpath.dentry == NULL))
@@ -1097,7 +1091,9 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 
 	if (c->stat.size) {
 		err = cap_size = ovl_getxattr_value(&upperpath, XATTR_NAME_CAPS,
-						    &capability);
+						    &capability, &cap_size);
+		if (cap_size == -ENODATA || cap_size == -EOPNOTSUPP)
+			cap_size = 0;
 		if (cap_size < 0)
 			goto out;
 	}
@@ -1127,7 +1123,7 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 	ovl_clear_flag(OVL_VERIFIED_DIGEST, d_inode(c->dentry));
 	ovl_set_upperdata(d_inode(c->dentry));
 out_free:
-	kfree(capability);
+	kvfree(capability);
 out:
 	return err;
 }

