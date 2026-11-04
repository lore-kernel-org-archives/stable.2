Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803068;
	b=YC6fljCsG44MA/2+2nZ4m7IE6wY+pFjGcp3d9qnjCW1/xyhlZhvjcT8I6c24MHGfwf0P
	 cfsk5KUY6hxjQOkFq5xpe16rGMTjI+p/W+y7EX+CXwreyE9QOtqBi6CpSz1m2KXgGr8eM
	 PmvF0blQ0MxuPhiX1APg3kaJin4Ru+dyrDemCqWOXb4d/n3GkWT2BweFPcaEsIwscwnzW
	 hHnCgoe7IG5hOxxOrKkNQ6sjtvXNmKBwsOUbxXPuvlOl3zWe5byrvVjRZEcfDr7j/AQnR
	 OpBNlCXEHVooDz/fCBerIdP0tawS0J+Op7U9v+TZ8FkWbbpnMrF0IxwzvNAzjiYdOOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803068;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=S4gAP3sbj6zbJYQhmgqtJQpgAe61JqzniZpgx/xqez0=;
	b=fXM0Fbcirk6RvTTCK88fdGlhjB4pEipEe2mRGPKH6JzkkgUhJ95O7c5c9i/fYnCmSap8
	 D4WhtqkIjC/KsHJj16xjGgk4Mt/5kViT3dgcDqwaUR/loOKGtQ3eERDACG16VtlsLQyBU
	 47X8y+KxZy6+rGyRS/Nyi5z+F/p6zlouGatXuRLb7q3/Q3PbisNk1gjUz4WHIn4A3DG6a
	 ZVDa0qBxXzJRUdYFJbOtB/YAE14q4BwHs9gH9l5pGO7+udzc1Oo9ig2GmgcJOzt0CJ8cX
	 82HhU8EX87SIof+MKC2TzVPgLNI4EzkQVdnubJH7Qg34RE93ZmPjRI2fRoRNU5Td0rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZVDeLRnL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19117606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZVDeLRnL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF531F0093A;
	Wed,  4 Nov 2026 14:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793803068;
	bh=S4gAP3sbj6zbJYQhmgqtJQpgAe61JqzniZpgx/xqez0=;
	h=Subject:To:Cc:From:Date;
	b=ZVDeLRnLDCySiLMlD2vbmrRcAyiVzlsw7QJJ8EvMdg1cQ5iGuY+OO9dw8KtQiIpcz
	 r2YP8JV8HOSNrGakPeafkPuD1ZGFkS7rLYUJVymAySHaWX7BFxR8R0NJ0zjg/RlmYu
	 Kw24ktydsNSA9byhcEkRmnf60BRjyx2eqtPy38pI=
Subject: FAILED: patch "[PATCH] ovl: skip copy up of empty security.capability" failed to apply to 5.10-stable tree
To: amir73il@gmail.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:37:42 +0100
Message-ID: <2026110442-disparate-unshaven-1c46@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 50912a1715b8a7c614b654011a0db750e372b43e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110442-disparate-unshaven-1c46@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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
 

