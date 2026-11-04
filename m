Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803065;
	b=RMUxFCs8H0jjZBnWKeA39PdsdpV+l5T6Wq2unXfLnIFP8+AV1F0N4RfeESy33UrmYMOa
	 FZMlHH5zcc5LtZaMMjwqRSCXiaNJX7S5eyej2GfxOZqe+YHVU1auFgdU8k8kU0TnEDZ0I
	 LlAtYcU4mJu12bQO3HX6EWylbCnAJRQO0ehEC+01arLghNbu0q7unrvrAW/EguPFTi3dB
	 SNBhbF0KvbjcHZQdPJL7RRp9I1P96jIR/GNisdT9LlfM27oWtlB/h93p/RuwokrsRi1OZ
	 Kp6jdTE9o+JyvzCvvFsEgUDhaE0rD92BzfWNn06eh7e/pq+ao1TecAIrA4ppra1kh7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803065;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YUcNk40fKt9ZQJhhKay4qF3rZIuqi2F/jK5Y/CfOxUw=;
	b=DKBRw4NySaVdlRB4nS8z1IAcjluwGKBUIIsJIakG0Drn3tugdF6slikL+zbTjgm3q9Zc
	 qwEW6+4IW7oU4wL4XCVTSZM+OIsFLl+woUD4N9H8I1i8V8Tf+9JaJa4o8vzGm/6thI5RX
	 jEDetwY3IwNqRtjNjwWp7iJGHtxT/7xw/bGlO7QttYPiLS56GqtMFIAIe1pelecL6l5ZC
	 LN3l3gFV+1+cIkpp718NxD+Sby+HU0fkllu+12evuixXVMtWh7zxQZLOH0ET6cxvJO1Gi
	 5pgnbt2r7EqtlBHNCuK0AQ85zlQ4ONNOd9BpGlnJwM2vVSVneqJrl8p+JY92EJxQxUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=DPSrmHnh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A44606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=DPSrmHnh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699B51F000C1;
	Wed,  4 Nov 2026 14:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793803064;
	bh=YUcNk40fKt9ZQJhhKay4qF3rZIuqi2F/jK5Y/CfOxUw=;
	h=Subject:To:Cc:From:Date;
	b=DPSrmHnhjNrtCoUTAY8dsimkBAiYEIXNz+3H2qEBpxxc4rYocRZ1W3DaJFcc2eeqc
	 S/3fLXtlO4ZybaWGV6upeZuJOe2jTWbLH+mbwLQkZGBWgpKel9P9G9XVIWu5ahvPcl
	 krFmfjV1AhlP8Ke8Y8KHAii0va6sgYZTdw/Wnr2M=
Subject: FAILED: patch "[PATCH] ovl: skip copy up of empty security.capability" failed to apply to 5.15-stable tree
To: amir73il@gmail.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:37:42 +0100
Message-ID: <2026110442-emote-irritably-d734@gregkh>
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
git cherry-pick -x 50912a1715b8a7c614b654011a0db750e372b43e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110442-emote-irritably-d734@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 50912a1715b8a7c614b654011a0db750e372b43e Mon Sep 17 00:00:00 2001
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 18 Oct 2026 11:52:52 +0200
Subject: [PATCH] ovl: skip copy up of empty security.capability

ovl_copy_xattr() gives up if it can't read an attribute that
listxattr() has named.  An empty security.capability, which anybody has
been able to store on any file for a long time, is such a case: it is
listed, and getxattr() has nothing to return for it.  A file in a lower
layer that carries one can't be copied up: it can't be written to,
renamed or have its mode changed.

There is nothing to copy if there are no data.  Go on with the next
one.

Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: treat -EINVAL as no capability too, and do the same in
 ovl_copy_up_meta_inode_data()]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 286978d47ef7..0cd76ca5b8d7 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -75,6 +75,15 @@ static int ovl_copy_acl(struct ovl_fs *ofs, const struct path *path,
 static ssize_t ovl_getxattr_value(const struct path *path, char *name,
 				  char **value, ssize_t *value_size);
 
+/*
+ * Any user can store an empty security.capability, which fails to read with
+ * -EINVAL.  It grants no capability, so treat it as none, like no xattr.
+ */
+static bool ovl_no_fscap(ssize_t err)
+{
+	return err == -ENODATA || err == -EOPNOTSUPP || err == -EINVAL;
+}
+
 int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct dentry *new)
 {
 	struct dentry *old = oldpath->dentry;
@@ -134,6 +143,10 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
 
 		size = ovl_getxattr_value(oldpath, name, &value, &value_size);
 		if (size < 0) {
+			if (!strcmp(name, XATTR_NAME_CAPS) && ovl_no_fscap(size)) {
+				error = 0;
+				continue;
+			}
 			error = size;
 			break;
 		}
@@ -1099,9 +1112,9 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 	if (c->stat.size) {
 		err = cap_size = ovl_getxattr_value(&upperpath, XATTR_NAME_CAPS,
 						    &capability, &cap_size);
-		if (cap_size == -ENODATA || cap_size == -EOPNOTSUPP)
+		if (ovl_no_fscap(cap_size))
 			cap_size = 0;
-		if (cap_size < 0)
+		else if (cap_size < 0)
 			goto out;
 	}
 

