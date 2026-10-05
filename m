Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8914AAC73
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213314; cv=none; b=ePVnQtnOjkAJSjlS6DEcDOIJkPimwfgzulTF4zF7IojFoKv1PB52X0SMj7ApDeCI+zBxwyrXb8076CHp7vh5W0hv+AJu/tXNRQYHZ+x3opxqjW5iIy3g95m17XF+JS31S3ggsfQKR2glJp3NO5VppU2XOF/pVrW+E7uhHL8zfBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213314; c=relaxed/simple;
	bh=itz8aP/pYpSe7D6EXqcGebawntbzV5vJZTEAAI+RN1I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cBGw7+kavBAFAi3fAu5SIg8QEYaIpGDi/Vp5fsEzTFYcVfZXDGHjcIfob5C5j+FyUC2cwfsw8eSAsWk1csz2x5Aujr6O41Z2IZ9Mys6lSfBcGJ/8dyey+JdkAlMy2lOimN5lgGeYFjCZ8S6UPtuJ7CU6NLGWBTgtMv85LmrxH4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z/MOUFDz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z/MOUFDz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778A51F000FF;
	Mon,  5 Oct 2026 15:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791213313;
	bh=Ctleh9aSW7nAsSCtoJ3jpY691VRCBPvYQzjOLHltDnY=;
	h=Subject:To:Cc:From:Date;
	b=z/MOUFDzrTH1pCkyqe5zZSoMEInJnchdH7n/92ghsX0ulu2CejfuGnxSUbbzegOjb
	 Mvu1+MOrYVIeaF7/erfw7z/xDDGYzLqBDX5xG6vCzk9ryAwNA0Aw1OESfl0p6unyeZ
	 9pPyl+p0WALLI9YUZAhwAQnWs8TUbwA4zTBjOWYk=
Subject: FAILED: patch "[PATCH] smb: client: only require read lease for size-extending zero" failed to apply to 6.12-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,brauner@kernel.org,dhowells@redhat.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 17:11:50 +0200
Message-ID: <2026100550-refusal-approval-95d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x fafc68cccf8a00ed0a1f47c1413a3f16ce4dcdfa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100550-refusal-approval-95d8@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fafc68cccf8a00ed0a1f47c1413a3f16ce4dcdfa Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Sat, 26 Sep 2026 17:15:47 -0300
Subject: [PATCH] smb: client: only require read lease for size-extending zero
 range

smb3_zero_range() refuses any FALLOC_FL_ZERO_RANGE that clears
FALLOC_FL_KEEP_SIZE with -EOPNOTSUPP whenever the inode is not read
caching:

	/* if file not oplocked can't be sure whether asking to extend size */
	rc = -EOPNOTSUPP;
	if (keep_size == false && !CIFS_CACHE_READ(cifsi))
		goto zero_range_exit;

The read lease is only needed to trust the cached i_size when deciding
whether the range extends the file. When it is not held, the size can
instead be fetched from the server, which is authoritative, rather than
refusing the request outright: query the server's end of file and take
the larger of it and the cached size for the interior-vs-extend
decision. The larger of the two is used because the server's end of
file reflects another client's growth while the cached size reflects
this client's own writes that may not have reached the server yet;
using the server size alone would wrongly shrink the file when the
range flush above left an extending write unwritten.

The query isn't lease-protected either, so its result is only trusted to
confirm the range is interior, never to justify extending: if it still
shows the range going past EOF, refuse with -EOPNOTSUPP instead of
calling SMB2_set_eof(), which could otherwise shrink the file if another
client extended it further between the query and the call.  For the same
reason, take the larger of the already-computed i_size and a fresh
i_size_read(inode) right before that call, instead of relying on either
alone: the local variable carries the query's result, which is never
written back to the inode, while a concurrent write on this client can
still extend the cached i_size during the flush, the query, or the
zero-data round trip that happen in between.

Rejecting interior ranges is observed as generic/363 randomly failing
against Windows Server with

	do_zero_range: fallocate: Operation not supported

fsx issues an interior, non-KEEP_SIZE zero range while the inode is
transiently not read caching: the server had just downgraded the file's
lease from RWH to RH after breaking the write caching, and the ensuing
handle reopen/revalidation left CIFS_CACHE_READ momentarily clear. The
range sat well within the server's end of file, so no extend was
needed, yet the range was refused and fsx aborted. This keeps the
emulation correct even when a genuine lease break from another client
leaves the inode without read caching -- the case the -EOPNOTSUPP guard
turned into a hard failure. The extra round trip only happens on the
no-lease path; the common cached case is unchanged.

Fixes: 30175628bf7f ("[SMB3] Enable fallocate -z support for SMB3 mounts")
Reviewed-by: David Howells <dhowells@redhat.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index a0fcb564e7a3..2d4cb54739ca 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3522,6 +3522,21 @@ static long smb3_zero_data(struct file *file, struct cifs_tcon *tcon,
 			  0, NULL, NULL);
 }
 
+static long query_server_eof(const unsigned int xid,
+			     struct cifs_tcon *tcon,
+			     struct cifsFileInfo *cfile,
+			     unsigned long long *eof)
+{
+	struct smb2_file_all_info file_inf = {};
+	long rc;
+
+	rc = SMB2_query_info(xid, tcon, cfile->fid.persistent_fid,
+			     cfile->fid.volatile_fid, &file_inf);
+	if (!rc)
+		*eof = le64_to_cpu(file_inf.EndOfFile);
+	return rc;
+}
+
 static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
 			    unsigned long long offset, unsigned long long len,
 			    bool keep_size)
@@ -3565,10 +3580,16 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
 	truncate_pagecache_range(inode, min(offset, i_size), offset + len - 1);
 	netfs_wait_for_outstanding_io(inode);
 
-	/* if file not oplocked can't be sure whether asking to extend size */
-	rc = -EOPNOTSUPP;
-	if (keep_size == false && !CIFS_CACHE_READ(cifsi))
-		goto zero_range_exit;
+	if (!keep_size && !CIFS_CACHE_READ(cifsi)) {
+		rc = query_server_eof(xid, tcon, cfile, &remote_i_size);
+		if (rc)
+			goto zero_range_exit;
+		i_size = max(i_size, remote_i_size);
+		if (i_size < new_size) {
+			rc = -EOPNOTSUPP;
+			goto zero_range_exit;
+		}
+	}
 
 	fscache_invalidate(cifs_inode_cookie(inode), NULL,
 			   i_size_read(inode), 0);
@@ -3580,7 +3601,7 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
 	/*
 	 * do we also need to change the size of the file?
 	 */
-	if (keep_size == false && (unsigned long long)i_size_read(inode) < new_size) {
+	if (!keep_size && umax(i_size, i_size_read(inode)) < new_size) {
 		rc = SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
 				  cfile->fid.volatile_fid, cfile->pid, new_size);
 		if (rc >= 0) {

