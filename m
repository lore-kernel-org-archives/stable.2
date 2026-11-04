Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817587;
	b=l0BR8mNqO1gmQi6pOrFxIpcaRTbkVWeN7ev1m41Tt0DKW047rXPI8smqaoh3lkiRV/b8
	 oBtWyspHxAcJb8s9hwhlwcesQgJ9u9uTfQ7hsCdSnK9PKczEjgSTxy2A0wQXU22vU4EYl
	 U8cY3Pp6a4Ye8/jdMVtFLI51DYJBYGyJktn8pif/XVhYApeqHOxq1+DTRC4/7JS+YS1BE
	 cMm/S8J3mlZhIZsd15Tq/wY7vinZw980XjSE4darC8Oo+b4JBq5kXf6JKhFdztXYkdkvU
	 cq0NqMeg2JrF/ZjbxrpipxGuPpO0Zk7bGMmiLDnmfaoErk1fx6PoCQId9bpzkWderxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817587;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qwj3NOyfPcVA+oSlFyY3f0geL/6xHCMBUWibfJbXNc8=;
	b=Qs2dM3i2NUawccNCWptFoffvsTQE7hzvdUtm8N1AZSHv6l+piRXl45lxxQv8+QP7n2QA
	 ctqNeyQ6468PTkYigU3wkxACemTgFlLHpL56yd66VrWFydLaAl3tMZXd+dFuTdINudeYz
	 KG8fq7aqzIL0Xv7Fn78flBOHTjaL3CUCiZ3W/N2c3STrDhsD8lIp71eYyyrz7IZ4GxNpy
	 OvJjX6SFlmT/3EQMWjG698LMgg3jZ2ygEAouMU3iHCb0Qq+SLXF6KPRw/Aj4DaQeoJCw+
	 wizTugWkm1xmcei6ZvW7CYw5WBA2Y3wXFJyOkZv6B3jCtlCOmwMhN4qoo+voN/A+7Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Dsf0N8a1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A214606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Dsf0N8a1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB401F0093A;
	Wed,  4 Nov 2026 18:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817587;
	bh=qwj3NOyfPcVA+oSlFyY3f0geL/6xHCMBUWibfJbXNc8=;
	h=Subject:To:Cc:From:Date;
	b=Dsf0N8a1bTNrkIhtJ9RzBkCnOXnD1hvUBh+wV5OTaJy8NSZ9zyJM7HGqzWs6aNKlA
	 HI57PFz9AsV41Nh7ybmuGA0UbHaQ34NDZ2waU2Y0WtPveqXXOKw0RvC4t5Tpu5v2YK
	 LUaPCjsKfe+Qh2FiDboQCcqBKR013hBar5Z0UR+4=
Subject: FAILED: patch "[PATCH] smb: client: fix OOB read in the SMB_FIND_FILE_UNIX name scan" failed to apply to 6.6-stable tree
To: diego@bynar.io,dhowells@redhat.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:39:44 -0500
Message-ID: <2026110444-gratified-gooey-9a8e@gregkh>
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
git cherry-pick -x fa0c2f082946917c3f07d2475c8ce73a8c96d0e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110444-gratified-gooey-9a8e@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa0c2f082946917c3f07d2475c8ce73a8c96d0e2 Mon Sep 17 00:00:00 2001
From: Diego Oliva <diego@bynar.io>
Date: Tue, 29 Sep 2026 10:16:33 +0100
Subject: [PATCH] smb: client: fix OOB read in the SMB_FIND_FILE_UNIX name scan

cifs_fill_dirent_unix() finds the length of an SMB_FIND_FILE_UNIX
entry name by scanning for its terminating NUL, over up to PATH_MAX + 1
UTF-16 units in cifs_unicode_bytelen() or PATH_MAX bytes in strnlen().
Neither scan knows where the response ends. cifs_fill_dirent() only
requires the fixed part of the entry to fit, so the name can start
exactly at the end of the received data, and a name that holds no
terminator is then scanned for 8194 bytes, or 4096 bytes without
unicode, past the end of the received data. SendReceive() copies at
most 16468 bytes into the 16588-byte cifs_request allocation, so for a
response of that length up to 8074 of the bytes scanned lie past the
end of the allocation. Before the preceding patches bounded where the
entry starts, the entry itself could start up to 820 bytes past the
end of the allocation at the default CIFSMaxBufSize, and its name 928
bytes past it, so all 8194 scanned bytes would lie outside.
cifs_fill_dirent() rejects the name afterwards because it extends past
the end of the response, so nothing of what was read is used, but the
out-of-bounds read itself remains.

SMB_FIND_FILE_UNIX is only used with SMB1 servers that offer the Unix
extensions; SMB1 is not negotiated by default and requires an explicit
vers=1.0 mount.

Before the preceding patches, an entry placed past the buffer left the
scan out of bounds from its first read. They bound where the entry
starts, but nothing bounds the scan, so a name that holds no
terminator still runs off the end of the allocation. Reproduced on
the unpatched tree with KASAN enabled, for an entry that starts
inside the response, which is the case the preceding patches leave
open:

 ==================================================================
 BUG: KASAN: slab-out-of-bounds in cifs_save_resume_key.isra.0+0x75c/0x7f0
 Read of size 2 at addr ffff88807ee640cc by task ls/84

 CPU: 0 UID: 0 PID: 84 Comm: ls Not tainted 7.3.0-rc4-00457-gf14572c203d5 #69 PREEMPT(lazy)
 Call Trace:
  <TASK>
  kasan_report+0xdf/0x1a0
  cifs_save_resume_key.isra.0+0x75c/0x7f0
  cifs_readdir+0x1ed6/0x29c0
  iterate_dir+0x1c0/0x570
  __x64_sys_getdents64+0x133/0x270
  do_syscall_64+0x109/0x5d0
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  </TASK>

 Allocated by task 84 on cpu 1 at 15.751078s:
  cifs_buf_get+0x36/0x90
  smb_init+0x4f/0x110
  CIFSFindNext+0xf7/0x14c0
  cifs_readdir+0xf51/0x29c0

 The buggy address belongs to the object at ffff88807ee60000
  which belongs to the cache cifs_request of size 16588
 The buggy address is located 0 bytes to the right of
  allocated 16588-byte region [ffff88807ee60000, ffff88807ee640cc)
 ==================================================================

The two bytes read there are one UTF-16 unit of the scan, at the first
byte past the end of the object. The scan carries on from there,
reported again 2, 4 and 6 bytes to the right.

Pass the number of bytes that follow the fixed part of the entry to
cifs_fill_dirent_unix() and stop both scans there. A scan that reaches
the end of the response without finding a terminator now fails: it
returns a name that ends exactly at the end of the response and would
otherwise pass the bound, so cifs_fill_dirent() requires the position
of the terminator of an SMB_FIND_FILE_UNIX name to lie inside the
response as well. Accepting such a name truncated at the end of the
response would turn a malformed entry into a directory entry, or a
resume name, that no server sent. A name longer than the PATH_MAX cap
of the scans is still truncated there, as before, when the response
extends past the cap. The message cifs_unicode_bytelen() logs when it
finds no terminator now covers both limits.

This patch depends on "smb: client: fix OOB read of the resume name
sent in TRANS2_FIND_NEXT2", which adds the end argument of
cifs_fill_dirent() and the length it derives from it; the backport
note in that patch applies to this one as well.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Bynario AI
Signed-off-by: Diego Oliva <diego@bynar.io>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 441cafcdc889..1667bba40e44 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -456,17 +456,20 @@ initiate_cifs_search(const unsigned int xid, struct file *file,
 }
 
 /* return length of unicode string in bytes */
-static int cifs_unicode_bytelen(const char *str)
+static size_t cifs_unicode_bytelen(const char *str, size_t maxlen)
 {
-	int len;
 	const __le16 *ustr = (const __le16 *)str;
+	size_t len;
 
-	for (len = 0; len <= PATH_MAX; len++) {
+	maxlen = umin(PATH_MAX + 1, maxlen / sizeof(__le16));
+	for (len = 0; len < maxlen; len++) {
 		if (ustr[len] == 0)
-			return len << 1;
+			return len * sizeof(__le16);
 	}
-	cifs_dbg(FYI, "Unicode string longer than PATH_MAX found\n");
-	return len << 1;
+	len *= sizeof(__le16);
+	cifs_dbg(FYI, "%s: Unicode string not terminated within %zu bytes\n",
+		 __func__, len);
+	return len;
 }
 
 static char *nxt_dir_entry(char *old_entry, char *end_of_smb, int level)
@@ -532,13 +535,13 @@ static void cifs_fill_dirent_posix(struct cifs_dirent *de,
 }
 
 static void cifs_fill_dirent_unix(struct cifs_dirent *de,
-		const FILE_UNIX_INFO *info, bool is_unicode)
+		const FILE_UNIX_INFO *info, bool is_unicode, size_t maxlen)
 {
 	de->name = &info->FileName[0];
 	if (is_unicode)
-		de->namelen = cifs_unicode_bytelen(de->name);
+		de->namelen = cifs_unicode_bytelen(de->name, maxlen);
 	else
-		de->namelen = strnlen(de->name, PATH_MAX);
+		de->namelen = strnlen(de->name, min_t(size_t, maxlen, PATH_MAX));
 	de->resume_key = info->ResumeKey;
 	de->ino = le64_to_cpu(info->basic.UniqueId);
 }
@@ -589,6 +592,7 @@ static int cifs_fill_dirent(struct cifs_dirent *de, const void *info,
 			    const char *end, u16 level, bool is_unicode)
 {
 	size_t len = end > (const char *)info ? end - (const char *)info : 0;
+	size_t nul_len = 0;
 
 	memset(de, 0, sizeof(*de));
 
@@ -601,7 +605,9 @@ static int cifs_fill_dirent(struct cifs_dirent *de, const void *info,
 	case SMB_FIND_FILE_UNIX:
 		if (len < offsetof(FILE_UNIX_INFO, FileName))
 			goto too_short;
-		cifs_fill_dirent_unix(de, info, is_unicode);
+		cifs_fill_dirent_unix(de, info, is_unicode,
+				      len - offsetof(FILE_UNIX_INFO, FileName));
+		nul_len = is_unicode ? sizeof(__le16) : sizeof(__u8);
 		break;
 	case SMB_FIND_FILE_DIRECTORY_INFO:
 		if (len < offsetof(FILE_DIRECTORY_INFO, FileName))
@@ -634,7 +640,8 @@ static int cifs_fill_dirent(struct cifs_dirent *de, const void *info,
 	}
 
 	if (de->name &&
-	    (end < de->name || (size_t)(end - de->name) < de->namelen)) {
+	    (end < de->name ||
+	     (size_t)(end - de->name) < de->namelen + nul_len)) {
 		cifs_dbg(VFS, "%s: search entry name extends past end of SMB\n",
 			 __func__);
 		return -EINVAL;

