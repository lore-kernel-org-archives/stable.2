Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826286;
	b=Bh8d8Tzbz+ZPNQRTNqbCOzB7+HdlzKyDcSTR9Ncrg7pt40eZDyyAz+BcfyXE8OXAiYPv
	 lWhicGo9mQ9Y2ZCg3H/R2BR9CYJxSK28YXePLdrFpeK+4McBm8VgQ58JlHtHWckReCmg0
	 eyo/YDUjrg8beGZlLBXqWtF4pTpu8OW48oOMTxDJDKJlmq6oNHfK1rFS36aJbz8/C2goJ
	 KvpiCO03O7UW5IVPcDKq0p/49H0Y8/AN7gN5K/4GOOnRiwX7P4npvXrhxdhv06x3I8kdx
	 ZGg72lOPrjHcibqvoGprvaWWf0wKzM1gOcdN6yg+bw18dwujz9Wde0g7qfpJL0AlG0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826286;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RsihQdT4egIDZrzmcCZO6haUhy9KDf27AGdG/nP+mGw=;
	b=oYsz/CP7/f4qgr51c8tYSXaghCQgFG0+jRCegi6NHIt1T/lExwa9W58JTOIimGToV0aj
	 IBEOY4oOyHuW0Q4k9qumNo3TJsxh/j3445pOMY7eqBS2ezynVEMUYM4+UStide9SonnLO
	 tGhkVgdRNXYMW9EzS9nLCJKbrxXqp3TRQRtp7nU5fAIMPl4dj+FSOLosVfJlSV5By0jok
	 9ivsLmf+HdGZgq8cDiF7tqsq9zEGHvSbTnotu+jc5IKOURSx4Hejyogn7iFSgy2GW3MXZ
	 wcoQfb94QlR12dubnEG3euFKolhTqqK45taCJUG7EPoheLsaUGQMo0MKX0Ca+/iFdkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KvfPq5Mr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B49606D4C2
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 21:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KvfPq5Mr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2341F000C1;
	Wed,  4 Nov 2026 21:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793826286;
	bh=RsihQdT4egIDZrzmcCZO6haUhy9KDf27AGdG/nP+mGw=;
	h=Subject:To:Cc:From:Date;
	b=KvfPq5MrVfR0Iu3qR4H2lBPbv0xtPHCJNQsKIjuycuL2MTU5ZB/Itj0+2BAie+9wZ
	 k9pXPI6d2/HAGMQMrTO4eBbfkOV6i2ohLMEbCs/l07eQykeoZGYMmmBELJp/s9H53M
	 1ZixQIVx73RRlbMEcwkol0AJzLaysHl6RKzs4dNg=
Subject: FAILED: patch "[PATCH] ksmbd: look up stream size by exact xattr name" failed to apply to 6.18-stable tree
To: gael.blivet@gmail.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 16:04:44 -0500
Message-ID: <2026110444-union-header-f23a@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 10ea20d6584ecdaf2f7505855412a856a88d8934
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110444-union-header-f23a@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

