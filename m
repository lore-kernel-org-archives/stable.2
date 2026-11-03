Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701331;
	b=P3KZUuoHNT4kjon0TwJsxEPvhaFpst9RRJnFQWpH2AmF4e0tmeywHRKS7slDj2b0RWeV
	 N7x5onDj0hqkLkhfecUlAqPhjIRKY4c0DLXsiyn3KqhfRzDbwe9pmMAQABjcnZt910+f/
	 AuOEnx1OD/unO61r2GidjyJX4V3iL5I1rP/bkkERlEWLhdjLH8Th7FSE69GH7Oa2BRCiq
	 VR1d1XzZ5PS3Sw5TukxYNnDUb2TlD5IH5/hacI7x2yrFDO/JdNbZq7UTkRw0OyxtrSW3G
	 FXC3CpUUymNQIKq43/Gg1DgtCN6pMqG1VWzBwCRkgqaaRNSH2kKAzxXE0iH2oWQWHqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701331;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sNuY8DTulgLMTK1UiGx8JGa0sRjk2fXBoLIANJ1oBvk=;
	b=dWgVSLeW9sLgAFkmhV7WD9/b3s3o+jz2WH/C9xS7Jc0KDDmG2Pto8a3j+9pe787AvO+A
	 z2grvL/LzDFyek6l5uK7yHUHzdMFk6550or2vN4/kU3Ax4AvJaQdrudDNjkIDzGz6uQ2E
	 HwF/haNNaj/rn6gmXI42k3QzKUlA+In+yHuyEpBJAFLV6LHXpeZJWfQ/P67YR2dom1t+i
	 UK1SU6DVdXwxymlyTtC9CW50pD8URlZQiN4zInUmVyX/cAnEX6YGEkrxaWbpmCEr2v/BX
	 W/PjcOgOrbFPRIboCsRq/dg3g0frTfT/zDwdUuCIw5pxjJl9fa83g47xgnFTZaiHmoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=E1pHPoMG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE5E606C55B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=E1pHPoMG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8DF1F000C1;
	Tue,  3 Nov 2026 10:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793701331;
	bh=sNuY8DTulgLMTK1UiGx8JGa0sRjk2fXBoLIANJ1oBvk=;
	h=Subject:To:Cc:From:Date;
	b=E1pHPoMG0sr3T3lBlZws3L/tFzU0a5UJ0byklNztU3Mm7EBrs7Y8Ex74C0ZF20oj4
	 EcwgfFQg4vy0BkFKEn+E71gbAApNng8TJMt7QTZfA2jF13JioJeTbum/qR2b7E1Ylr
	 fsmmrEL71f7eeGssi6NCVRPAlulIsC1MT1ErmsGM=
Subject: FAILED: patch "[PATCH] ksmbd: use the existing xattr name for a named stream" failed to apply to 6.18-stable tree
To: charsyam@gmail.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:21:58 +0100
Message-ID: <2026110358-jaywalker-relapse-2135@gregkh>
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
git cherry-pick -x a7d1d52748e0fe4d06fdb871fc9899904fbba93f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110358-jaywalker-relapse-2135@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a7d1d52748e0fe4d06fdb871fc9899904fbba93f Mon Sep 17 00:00:00 2001
From: DaeMyung Kang <charsyam@gmail.com>
Date: Fri, 9 Oct 2026 00:25:36 +0900
Subject: [PATCH] ksmbd: use the existing xattr name for a named stream

SMB stream names are case-insensitive, but ksmbd stores each named
stream in an xattr whose name is case-sensitive. Opening an existing
stream finds its xattr with a case-insensitive match, yet the handle
keeps the name as the client spelled it, and every later operation that
needs an exact name uses that spelling:

 - a WRITE or an end-of-file change creates a second xattr, so a stream
   created as "Foo" and written through "foo" ends up stored twice, and
   which value a later lookup returns depends on xattr list order;
 - delete-on-close and delete-pending removal can fail with -ENODATA,
   or remove only a case-variant copy and leave the original;
 - the share mode check compares stream names with strcmp(), so two
   opens of the same stream that differ only in case do not conflict.

Have ksmbd_vfs_casexattr_len() copy the matching xattr's name into the
handle when the stream is opened, so later operations use the name
already on disk. The match must have the same length as the name it
replaces; the stream lookup passes a length that includes the
terminating NUL, which already guarantees that, and the check makes the
copy safe for any caller. A stream that does not exist yet keeps the
client's spelling, as before.

smb2_rename() compares and looks up fp->stream.name case-insensitively,
so it behaves the same with either spelling.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 0154c0deaf8b..79b0a9aee860 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3341,7 +3341,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 						     path->dentry,
 						     attr_name,
 						     XATTR_USER_PREFIX_LEN +
-						     eabuf->EaNameLength);
+						     eabuf->EaNameLength, NULL);
 
 			/* delete the EA only when it exits */
 			if (rc > 0) {
@@ -3413,11 +3413,11 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 	fp->stream.name = xattr_stream_name;
 	fp->stream.size = xattr_stream_size;
 
-	/* Check if there is stream prefix in xattr space */
+	/* Keep the existing xattr's case for subsequent writes and removal. */
 	rc = ksmbd_vfs_casexattr_len(idmap,
 				     path->dentry,
 				     xattr_stream_name,
-				     xattr_stream_size);
+				     xattr_stream_size, xattr_stream_name);
 	if (rc >= 0)
 		return 0;
 
@@ -3469,7 +3469,7 @@ static loff_t ksmbd_stream_eof(struct ksmbd_file *fp)
 	ssize_t slen = ksmbd_vfs_casexattr_len(file_mnt_idmap(fp->filp),
 					       fp->filp->f_path.dentry,
 					       fp->stream.name,
-					       fp->stream.size);
+					       fp->stream.size, NULL);
 	return slen < 0 ? 0 : (loff_t)slen;
 }
 
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 02ee73d8d631..eb0212e9a5f4 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1956,7 +1956,7 @@ int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
 
 ssize_t ksmbd_vfs_casexattr_len(const struct mnt_idmap *idmap,
 				struct dentry *dentry, char *attr_name,
-				int attr_name_len)
+				int attr_name_len, char *actual_name)
 {
 	char *name, *xattr_list = NULL;
 	ssize_t value_len = -ENOENT, xattr_list_len;
@@ -1970,8 +1970,13 @@ ssize_t ksmbd_vfs_casexattr_len(const struct mnt_idmap *idmap,
 		ksmbd_debug(VFS, "%s, len %zd\n", name, strlen(name));
 		if (strncasecmp(attr_name, name, attr_name_len))
 			continue;
+		if (actual_name && strlen(name) + 1 != attr_name_len)
+			continue;
 
 		value_len = ksmbd_vfs_xattr_len(idmap, dentry, name);
+		/* The caller provides attr_name_len bytes for the actual name. */
+		if (value_len >= 0 && actual_name)
+			memcpy(actual_name, name, attr_name_len);
 		break;
 	}
 
@@ -2126,7 +2131,7 @@ int ksmbd_vfs_copy_file_ranges(struct ksmbd_work *work,
 		src_file_size = ksmbd_vfs_casexattr_len(
 				file_mnt_idmap(src_fp->filp),
 				src_fp->filp->f_path.dentry,
-				src_fp->stream.name, src_fp->stream.size);
+				src_fp->stream.name, src_fp->stream.size, NULL);
 		revert_creds(saved_cred);
 		if (src_file_size < 0)
 			return src_file_size;
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index 7e545d13a3ff..21b0d29a3db0 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -116,7 +116,7 @@ ssize_t ksmbd_vfs_getcasexattr(const struct mnt_idmap *idmap,
 			       int attr_name_len, char **attr_value);
 ssize_t ksmbd_vfs_casexattr_len(const struct mnt_idmap *idmap,
 				struct dentry *dentry, char *attr_name,
-				int attr_name_len);
+				int attr_name_len, char *actual_name);
 int ksmbd_vfs_setxattr(const struct mnt_idmap *idmap,
 		       const struct path *path, const char *attr_name,
 		       void *attr_value, size_t attr_size, int flags,

