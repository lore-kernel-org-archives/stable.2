Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826298;
	b=0jGPe4UHi6cfVvJfOUG5aqZY1y70CBFwhjZVtYXZUduspl5igYQ2d6idwNIEF7tUVATz
	 14fUWomwCB6It+0JuucYVQm8wcqM/EBHf1qXLUsOGp0vYuh7jhZVODpPP5JA6ylMjAvrc
	 o1eIDeN//wxJQJgj5kafCezkajUcINIsUvLOeEXN3vN+coylSBcJjTmV5X8hT0khgYJkX
	 /KQ/HXC0Qa3/gk1GIrCUVDd36n46uJyiA8Ig8XXaeihkFU0QFxkg0IyDMoHsHei/GiSQG
	 e8tGJxI1OMd4p6vhdD+CQ3lu6xW6KwKuhYm9lyqNxAg7X/qTkClGs4ZAZRldBbpvTMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826298;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4Ut9rj3j0uva36Cvif+dYnMzQWKQyPSkcJ7XkVDB+Jo=;
	b=lgrY91g4gSlg6LjMyr5Wcvzdr+oEYLCdBw7IL/FqecLYr33AfYJuaq2O1zTdJe4J1Bk7
	 drxktHH44pABM16KsITD0NjkiQnWEXLq3hAgYNpJguV4crjoQdd0aCsyG9bGKIt8UpTbT
	 PEPxQEY2VAUhofVgR0I6pQUYPm3fEQvVoVMDSqIMGbJBjMrXnZ1PQtkvNmRKq2pER3ehr
	 rTkdUBt/9Rv6qP98FwPbWOdptGKkdQeBIxn5BVZNLVICMiwB4jK9/lePU4YYHpIfMKlfO
	 kpKP9NCJZ/K3Y/Zj3IcV8eVnYDIgaVJKi0utKvdBI1PjHscIujtLz5PoXM0fknBKx4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NIhr1AqF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2416606D4E0
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NIhr1AqF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8161F000C1;
	Wed,  4 Nov 2026 21:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793826297;
	bh=4Ut9rj3j0uva36Cvif+dYnMzQWKQyPSkcJ7XkVDB+Jo=;
	h=Subject:To:Cc:From:Date;
	b=NIhr1AqFIPzjZfQnpwmPgsgee7BfjU7fgI7X24tKmiYfuDTB/8VecXl6K6yhDS/gy
	 ly/F9LqwR2YfKeif4/aMzNMldRqp2y5B7Yfd7aAkm3OEXhA9DCNiN+6cA4XmYPEuqs
	 yyQ1czFKnORfnBDXMqBE4HJxI/gYyTHSqefwPx8o=
Subject: FAILED: patch "[PATCH] ksmbd: look up stream size by exact xattr name" failed to apply to 6.12-stable tree
To: gael.blivet@gmail.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 16:04:45 -0500
Message-ID: <2026110444-overfull-uniformed-0087@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 10ea20d6584ecdaf2f7505855412a856a88d8934
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110444-overfull-uniformed-0087@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 10ea20d6584ecdaf2f7505855412a856a88d8934 Mon Sep 17 00:00:00 2001
From: Gael Blivet <gael.blivet@gmail.com>
Date: Mon, 14 Sep 2026 01:26:36 +0200
Subject: [PATCH] ksmbd: look up stream size by exact xattr name

get_file_stream_info() walks the xattr list from a single
ksmbd_vfs_listxattr() and sizes each stream it finds with
ksmbd_vfs_casexattr_len(), which matches with strncasecmp(). Linux
xattr names are case-sensitive, so two streams differing only in case
report each other's size.

The loop already holds the exact name, so query it directly with
ksmbd_vfs_xattr_len(), which is what casexattr_len() calls once its
search succeeds. Make it non-static and declare it in vfs.h, and drop
the comment above it, which describes a different bug and no longer
matches the code.

This also drops a full listing per stream: casexattr_len() runs its own
listxattr on every call, so enumerating a file with N xattrs cost N
listings instead of one.

Fixes: 689f1eb3719d ("ksmbd: report actual xattr value length in stream enumeration")
Signed-off-by: Gael Blivet <gael.blivet@gmail.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index f46a29ce118f..10bcd724343c 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6948,17 +6948,8 @@ static int get_file_stream_info(struct ksmbd_work *work,
 		streamlen *= 2;
 		kfree(stream_buf);
 		file_info->StreamNameLength = cpu_to_le32(streamlen);
-		/*
-		 * stream_name_len is the byte length of the xattr's *name*,
-		 * not its value -- same class of bug ksmbd_stream_eof()
-		 * (smb2pdu.c) already fixes for EndOfFile/AllocationSize on
-		 * a stream handle; this enumeration path needs the same
-		 * real xattr value length, not the name length reused as a
-		 * size.
-		 */
-		slen = ksmbd_vfs_casexattr_len(file_mnt_idmap(fp->filp),
-						path->dentry, stream_name,
-						strlen(stream_name) + 1);
+		slen = ksmbd_vfs_xattr_len(file_mnt_idmap(fp->filp),
+					   path->dentry, stream_name);
 		ssize = slen < 0 ? 0 : (loff_t)slen;
 		file_info->StreamSize = cpu_to_le64(ssize);
 		file_info->StreamAllocationSize = cpu_to_le64(ssize);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 0b03e0eec0a8..2e2c554bc2c1 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -842,8 +842,8 @@ ssize_t ksmbd_vfs_listxattr(struct dentry *dentry, char **list)
 	return size;
 }
 
-static ssize_t ksmbd_vfs_xattr_len(const struct mnt_idmap *idmap,
-				   struct dentry *dentry, char *xattr_name)
+ssize_t ksmbd_vfs_xattr_len(const struct mnt_idmap *idmap,
+			    struct dentry *dentry, char *xattr_name)
 {
 	return vfs_getxattr(idmap, dentry, xattr_name, NULL, 0);
 }
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index 12f3ce79b3c5..216c76291fc1 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -108,6 +108,8 @@ ssize_t ksmbd_vfs_getxattr(const struct mnt_idmap *idmap,
 			   struct dentry *dentry,
 			   char *xattr_name,
 			   char **xattr_buf);
+ssize_t ksmbd_vfs_xattr_len(const struct mnt_idmap *idmap,
+			    struct dentry *dentry, char *xattr_name);
 ssize_t ksmbd_vfs_getcasexattr(const struct mnt_idmap *idmap,
 			       struct dentry *dentry, char *attr_name,
 			       int attr_name_len, char **attr_value);

