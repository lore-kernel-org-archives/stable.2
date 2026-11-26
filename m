Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664454;
	b=Ywxnr5FUhHMxeCEk287gP8QTsl2dwxlyQCUkyiccWBjzP5Z7V4RY/VlfM9nP7LvTgVXM
	 o9vH7Ruh7csQIJksvf7F9J92rw6JQCGl9JGD+nBFG0vecypm0P5Ft2KftcB3GM8wu+6mW
	 +6mEcadEChsFWYo0ZhPGP80GZkfzaCOsogjEKnOCQj773k3je0GxyqFdvWxJB4v6tnBPf
	 WfRYEHuTntvaw6x0WhP8mjLkjqnPXNTDZ6zaIrSbnbsutgtqT28Dlrao8Av9KgJ4B/5wS
	 oiCvqwdUigHUUNeN8wLfSkQYmRQO1RnV8neRPbdNxZvOUJ2I02qFbF/xs+VKVB2OQCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664454;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=hiie43vbQhgwO+8bh43IQ1x0kI3W2gj1GivBQN/aU18=;
	b=B/c67zpUNVuBkGyMxA99xjErLAE3dnc8UDgwo76U0ThIIJbY77cyMlKiMCHVrtwrPE4b
	 gbwhAxYZHd7paiAZ2eoZpQA5PoHdiQGbdzCrVS0okyCq6jQt11hEV5jX+OWCK24CtwfDf
	 0wYH323CaVDxHD/sCI6D9PwaHdQx+M+rJdLIhcSYxrAYg9R4eosWVyNL40aRfg7nD5OsB
	 QdzgiLv654ipCky3AYQPpByQrY23Rm0MTjEt5+e+7TKrbNrZ4t3q85DeUYd7cCikc66d7
	 PZ6f9K3hGccF+1cWF7jU9u/ZiAfGdH0OTYVzWlvKMHn27LJ6x+UVrvpudgAF7QN9YzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JE7aJRv9;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014F7606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 014F7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JE7aJRv9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID; bh=hiie43vbQhgwO+8
	bh43IQ1x0kI3W2gj1GivBQN/aU18=; b=JE7aJRv9pTU0SQsrcqef0NIAG0YI1g2
	arnPca8Z7FobHPK+iSAMS0PzgYjMgFYqUn8yQ91vW6A42ZlMhIURfJLpuz68UlJr
	+P8jWky24yjh//I9tut2DZVZZZNjwOmszDQ1iSQdGg8h8hLcLORAKy/vnV8/0MnU
	5/GeDT/rr0IM=
From: shaos <shawnq1@163.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
    ntfs@lists.linux.dev, stable@vger.kernel.org
Subject: [PATCH] ntfs: avoid re-locking the parent for stream timestamps
Date: Thu, 26 Nov 2026 03:40:27 GMT
Message-ID: <179566442733.1993761.5390442849622005459@163.com>
X-CM-TRANSID:PygvCgCH74QrqgdrvLbtIA--.60447S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxtr43tF48uw48tFWDAw4ktFb_yoW3CFy7pr
	ZFk3yfKwnrtF1Igwn3tws09ryF9r1kCw42gry7Xa1xAws0qw1rtF40kr1kCFWftrZ5Wr45
	ZF4Ygw13ur1UXrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jO3kAUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbCzwxSYGsHqixvPwAA3L
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

Hello,

The VFS holds a directory's i_rwsem while calling ->create() and
->unlink(). A legacy NTFS named-stream path can use that same directory
as the stream's base inode. Creating or removing the stream then calls
ntfs_stream_update_base_time(), which attempts to acquire the already
held i_rwsem and leaves the caller blocked in down_write_nested().

Pass the VFS-locked parent to the timestamp update path. When the base
inode is that parent, update its timestamps under the lock already
held. Other callers retain the existing lock and update behavior.

A crafted NTFS directory entry reproduces both create and unlink
deadlocks as uid 65534. The same operations complete with this change.
The unlink harness also emits a lockdep circular-dependency warning
during stream setup on both the vulnerable and fixed kernels. That
warning is separate from the reproduced self-deadlock and is not
claimed to be fixed here.

HEAD commit:    8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
Git tree:       fe970b05333fb8e41da21e9e289f652abcc7cba7
Source version: Linux 7.4.0-rc4
Compiler:       gcc 11.4.0, GNU ld 2.38
Test runtime:   QEMU 6.2.0, x86-64 TCG

The evidence, create and unlink PoCs, and image/initramfs helpers are
in this unlisted Gist:

https://gist.github.com/shaos26/eb846131f7945b8541b2f1b99fd5c34e

Console output:
https://gist.githubusercontent.com/shaos26/eb846131f7945b8541b2f1b99fd5c34e/raw/c9b6fcec4363c6b1ea2f168f12a2b4918dd29af3/console-output.txt
Kernel config:
https://gist.githubusercontent.com/shaos26/eb846131f7945b8541b2f1b99fd5c34e/raw/c9b6fcec4363c6b1ea2f168f12a2b4918dd29af3/kernel-config.txt
Create PoC:
https://gist.githubusercontent.com/shaos26/eb846131f7945b8541b2f1b99fd5c34e/raw/c9b6fcec4363c6b1ea2f168f12a2b4918dd29af3/poc.c
Unlink PoC:
https://gist.githubusercontent.com/shaos26/eb846131f7945b8541b2f1b99fd5c34e/raw/c9b6fcec4363c6b1ea2f168f12a2b4918dd29af3/unlink-poc.c

The reproduction script needs QEMU and the ntfs-3g tools mkntfs,
ntfscp, and ntfsinfo. It builds the test kernel and initramfs, creates
fresh crafted images, and runs create, unlink, and normal-image control
cases:

    git clone https://gist.github.com/eb846131f7945b8541b2f1b99fd5c34e.git repro
    git -C repro checkout c9b6fcec4363c6b1ea2f168f12a2b4918dd29af3
    chmod +x repro/*.sh
    ./repro/reproduce.sh

The vulnerable create runs reached D state in down_write_nested() with
ntfs_stream_update_base_time() on the stack. On the patched kernel,
create returned instead of hanging; unlink completed with rc=0. The
normal-image control also completed. The unlink logs retain the
independent lockdep warning described above.

Fixes: 3f11c48d4f94 ("ntfs: add pathname access for named streams")
Cc: stable@vger.kernel.org
Signed-off-by: shaos <shawnq1@163.com>

---
 fs/ntfs/named_stream.c | 47 +++++++++++++++++++++++++++++++++++-------
 fs/ntfs/stream.h       |  3 ++-
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/fs/ntfs/named_stream.c b/fs/ntfs/named_stream.c
index 70c5892077133..8bae9a9f53047 100644
--- a/fs/ntfs/named_stream.c
+++ b/fs/ntfs/named_stream.c
@@ -82,6 +82,13 @@ void ntfs_stream_inode_refresh(struct inode *vi)
 	vi->i_generation = base_vi->i_generation;
 }
 
+/* Caller must hold the base inode's i_rwsem. */
+static void ntfs_stream_set_base_time(struct inode *base_vi)
+{
+	inode_set_mtime_to_ts(base_vi, inode_set_ctime_current(base_vi));
+	mark_inode_dirty(base_vi);
+}
+
 /*
  * ntfs_stream_update_base_time() - Update base timestamps after a stream change
  * @base_ni: base inode containing the stream attribute
@@ -94,11 +101,32 @@ void ntfs_stream_update_base_time(struct ntfs_inode *base_ni)
 	struct inode *base_vi = VFS_I(base_ni);
 
 	inode_lock_nested(base_vi, I_MUTEX_PARENT);
-	inode_set_mtime_to_ts(base_vi, inode_set_ctime_current(base_vi));
-	mark_inode_dirty(base_vi);
+	ntfs_stream_set_base_time(base_vi);
 	inode_unlock(base_vi);
 }
 
+/*
+ * ntfs_update_base_time_for_dir() - Update base timestamps from
+ * a directory operation
+ * @base_ni: base inode containing the stream attribute
+ * @locked_dir: parent directory locked by the VFS, or NULL
+ *
+ * The VFS already holds @locked_dir's i_rwsem for create and unlink. Avoid
+ * recursively acquiring it when the base inode is that directory itself.
+ */
+static void ntfs_update_base_time_for_dir(struct ntfs_inode *base_ni,
+					  struct inode *locked_dir)
+{
+	struct inode *base_vi = VFS_I(base_ni);
+
+	if (base_vi != locked_dir) {
+		ntfs_stream_update_base_time(base_ni);
+		return;
+	}
+
+	ntfs_stream_set_base_time(base_vi);
+}
+
 /*
  * ntfs_stream_inode_validate() - Validate a named-stream inode
  * @vi: stream inode to validate
@@ -653,7 +681,7 @@ struct inode *ntfs_create_named_stream(const struct mnt_idmap *idmap,
 		}
 		mutex_unlock(&base_ni->mrec_lock);
 		if (stream_created)
-			ntfs_stream_update_base_time(base_ni);
+			ntfs_update_base_time_for_dir(base_ni, dir);
 		if (!IS_ERR(stream_vi))
 			iput(stream_vi);
 		if (rollback_vi)
@@ -663,7 +691,7 @@ struct inode *ntfs_create_named_stream(const struct mnt_idmap *idmap,
 	}
 	mutex_unlock(&base_ni->mrec_lock);
 	if (stream_created)
-		ntfs_stream_update_base_time(base_ni);
+		ntfs_update_base_time_for_dir(base_ni, dir);
 	iput(base_vi);
 	return stream_vi;
 
@@ -720,7 +748,7 @@ int ntfs_unlink_named_stream(struct inode *dir, struct dentry *dentry)
 	 * file write access. The shared helper enforces NTFS delete restrictions.
 	 */
 	err = ntfs_remove_named_stream(NTFS_I(base_vi), stream_name,
-			stream_len, dentry->d_inode);
+			stream_len, dentry->d_inode, dir);
 
 out_iput:
 	iput(base_vi);
@@ -1076,6 +1104,7 @@ int ntfs_stream_put(struct inode *vi)
  * @uname: UTF-16LE stream name
  * @uname_len: length of @uname in UTF-16 code units
  * @expected_vi: expected cached stream inode, or NULL
+ * @locked_dir: parent directory locked by the VFS, or NULL
  *
  * Refuse removal while the stream is open. If @expected_vi is non-NULL, it
  * must be the inode currently associated with the named attribute.
@@ -1084,7 +1113,8 @@ int ntfs_stream_put(struct inode *vi)
  * errno.
  */
 int ntfs_remove_named_stream(struct ntfs_inode *ni, __le16 *uname,
-		u32 uname_len, struct inode *expected_vi)
+		u32 uname_len, struct inode *expected_vi,
+		struct inode *locked_dir)
 {
 	struct inode *attr_vi;
 	struct ntfs_inode *attr_ni;
@@ -1137,7 +1167,7 @@ int ntfs_remove_named_stream(struct ntfs_inode *ni, __le16 *uname,
 
 	err = ntfs_stream_finish_remove(attr_vi);
 	if (!err)
-		ntfs_stream_update_base_time(ni);
+		ntfs_update_base_time_for_dir(ni, locked_dir);
 	iput(attr_vi);
 	return err;
 
@@ -1444,7 +1474,8 @@ static long ntfs_ioctl_stream(struct file *filp, unsigned long arg,
 		err = mnt_want_write_file(filp);
 		if (err)
 			goto out_free;
-		err = ntfs_remove_named_stream(base_ni, sname, sname_len, NULL);
+		err = ntfs_remove_named_stream(base_ni, sname,
+					       sname_len, NULL, NULL);
 		mnt_drop_write_file(filp);
 		goto out_free;
 	}
diff --git a/fs/ntfs/stream.h b/fs/ntfs/stream.h
index 76b6c9cca5cc0..18b20e7d7ff48 100644
--- a/fs/ntfs/stream.h
+++ b/fs/ntfs/stream.h
@@ -46,7 +46,8 @@ bool ntfs_stream_unlinked(struct ntfs_inode *base_ni,
 		const __le16 *name, u32 name_len);
 int ntfs_stream_put(struct inode *inode);
 int ntfs_remove_named_stream(struct ntfs_inode *ni, __le16 *name,
-		u32 name_len, struct inode *expected_inode);
+		u32 name_len, struct inode *expected_inode,
+		struct inode *locked_dir);
 
 int ntfs_stream_validate_for_mutation(struct inode *inode, bool nowait);
 long ntfs_ioctl_stream_read(struct file *file, unsigned long arg);
-- 
2.34.1

