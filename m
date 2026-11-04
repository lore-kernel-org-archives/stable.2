Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826295;
	b=DFPTpUbin31KbcO+e6x3zL80BPGUQ8xkjNs4WYSNI9n2S4bHoIgg0+GP2RaoiaV/Af0Z
	 fViSvM9W/62CAvgH/QK+QVnOACQDjDyu08WpydYu4qPiUQ3GgLFM2oBwDM2AKyjzCbh9j
	 AS9k+M9OQd4N3QuVLvqErMJtJ9QjR9+rHtxUSdS4t6SdSJ3qKmFKqYlUrlu3342EG0EOg
	 025p8OwajIkLtO+zz0GengEMxrffyfGBrp8IxRBfO4W8X63DDFhyBY8H+eQNoloRj5gTF
	 8hh2ALGSBnkFYEhMBml8lhCo8BhKOVPwRXeHvbYQ3cVDbptYNjfP2qSresAthQezl9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826295;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9YyaYpG5Bv+3e6SPkfHYAXDDq2PxdCZEQjKLfpdVehA=;
	b=NOUX2WQTX7DflfXy+p3/qezYT/CxTnUWmnHfTv6llde6B1rEOaeBzpTVDtZIn1IIzKHK
	 HCcK6s9wVKVodkivENWqd/3P8OmtFKOsmMM0Ew85NfJuTRhaRXPxVOE2wxuY/WHurrapn
	 DiAEQ80A4KRiezT421YTsar+Ji3pArTkoq7A4rH7QzSY8pudb/Jwww6WLVzo/mLec3KTz
	 LNvC31IAA6PaARzROdbhrE9XNDCSYX6A8ma3VpyleY55i9F3Vi/F2+02gCwj1Iqb46nbR
	 C0YKoHlV6BPjwThZ+Btj3ud1ZcFMol1w7V4rGwPlVFfoq/0bsqfQ2KDNzV5NP3+VaEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xcGWogjJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAE7606D4DE
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xcGWogjJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31781F0093A;
	Wed,  4 Nov 2026 21:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793826295;
	bh=9YyaYpG5Bv+3e6SPkfHYAXDDq2PxdCZEQjKLfpdVehA=;
	h=Subject:To:Cc:From:Date;
	b=xcGWogjJdCzzuiFlSlUqh+84YkQZ8rGiheIQmcHgDvnBkAiY2gMuQ9b4s5wj1Ciyl
	 rwYM2nap4/elj3IJSvZ3NmCTleIb2h9t2z8vOSe6ohFcpwKEnfhurDXWAyvdLZ+hKq
	 YWwoDEZzosQiSZ0XJZN9r3rw/KFaZCtczmkpaYeo=
Subject: FAILED: patch "[PATCH] ksmbd: look up stream size by exact xattr name" failed to apply to 6.6-stable tree
To: gael.blivet@gmail.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 16:04:45 -0500
Message-ID: <2026110445-either-jimmy-6232@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 10ea20d6584ecdaf2f7505855412a856a88d8934
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110445-either-jimmy-6232@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

