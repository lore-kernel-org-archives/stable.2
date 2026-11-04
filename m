Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803063;
	b=tXcP7dBtrnod/FvVBB2YR5yJS4QuRbFnW0u9tFnjENlCm+Kf92bHzK7KcqYYyJ6Zbs/y
	 hjd9+ELpRMZRM1WNU/gSs7fJvAMaRp+WsT9FTnLu0iPNLVCdIIBgScN1ZMGU1tFg7UFR4
	 LA8Yl0FqYCgU7vpAMKgf1u5oaNkgxXjJjoKXd1jYPpv7bCK7GUbaTOUuj+lJDpHI+fWDm
	 q6WW9YrErREuNI6vHkXvolgRfvCGNz5gBnobOh71D8eiGCtveWeK39GLy8pRiZdZEgJ6b
	 3h8s7DyWEJOSzgdgws5uq0uzHxgk3yNjmJisZovVlM/AEtVUEQHRXqHNNyI3hBB6ibg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803063;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+p7rRy8wRybhO/rr6seTtChXXNsCuX/vEGO4d6gjKJQ=;
	b=ecf03rD2CPj7r/3Uib5QYEST+60TorzHsdi+KIqSuFZn5ewE1GIm50NYtlkbMJ266Vax
	 VCaNYjiJyGqKyUkcbs/gozMfmF8CDe/NvPE40lvzI7zoSf/Sp+Yi2E5Eix5DOlc4H6F1f
	 toUKODcGB5p5YZd+dazafjIOZDuD2Ic+vvBatE0JvKXNJYfR4qsNYUxbEDnnlDdccjqTM
	 JBTa6n4ObqnnI4m8Q7J3ANPjC5A5S6WcUng7DdjF75iKMfRhhqiJQssVMu2m7gFS/Mbpl
	 wpg+WPk4oVM8HI3BAbu6zYqkr6jI0kn6XyBxePRSw7sLTaHRBbU5mr86FnyDIIpNiZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hFrA43Qq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F3E606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hFrA43Qq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E23D1F00919;
	Wed,  4 Nov 2026 14:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793803063;
	bh=+p7rRy8wRybhO/rr6seTtChXXNsCuX/vEGO4d6gjKJQ=;
	h=Subject:To:Cc:From:Date;
	b=hFrA43QqtgIEoOIg210zSkFktbKJIlinGQkOJDxdQQMMs1CdZayrcvQJDLv2DVodJ
	 m/JLnBWiCl2RLzMb6owD1kZN725+VquWJKNaFzD8wg76u0Nhm5YaWhEqLhWysjD81B
	 5T/QzKyL+AUTld/5DG5vUNBH+lEXtjVxBXSuZzNc=
Subject: FAILED: patch "[PATCH] ovl: skip copy up of empty security.capability" failed to apply to 6.1-stable tree
To: amir73il@gmail.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:37:41 +0100
Message-ID: <2026110441-verbalize-sauna-b06f@gregkh>
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
git cherry-pick -x 50912a1715b8a7c614b654011a0db750e372b43e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110441-verbalize-sauna-b06f@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

