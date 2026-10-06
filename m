Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3B6547072
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272547; cv=none; b=CNrwtrXWA2qq5S+gLYmAN3Cl6qR763/cMl5ao1TuFRNkDWwYcRfRcBnTT0KLNuKl9kkTVczC9LImXmCOPqKbmvi2dnIl8tfIyJlkKCAxepqsgKbsAUa7dqN85533bCP60t27ltvbQHQAyZauj73STjWrbjNSaYDAoRHxDpAtx+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272547; c=relaxed/simple;
	bh=nlHh6uHkZFu52NyurqZPF15mf4Ymv9OWRbzbiWtU1Es=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SrMHNmqftqyn3PQDQ5gyd292MiGAQfPtTtiwMd4PZJfUV3kp5IlGIaAspPqB12Dt1BD5rGIc/84DVp6qkq1eibI+gZw4Lu7Zg8kE6+YvP+F/oC4p5ccXGrq2B+C4khpetZ56bPpW4rKl0OvfF6oQ2SW48ENYTuhykZKbR4iv5fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RbyF+ezg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RbyF+ezg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3FB1F000FF;
	Tue,  6 Oct 2026 07:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791272545;
	bh=U1T9lvOg1xX3crO7SAkvBXL8z/RiZXGaonasi76Qq18=;
	h=Subject:To:Cc:From:Date;
	b=RbyF+ezgy62jxWb5940ezHFIIogPC4H7+vFJMnng+SfdaI98KEA0cC6+nt7dCm1nq
	 DAgg6V0bBY0N3NHgHbGa4X1avTUp48bfSyHvBFmcL/0+0LX3h0yjrjhIv9t3U9FfPU
	 eEWNOHtwDA8/eOvBW0w//7iVJr/zZQ92LoIPZtT8=
Subject: FAILED: patch "[PATCH] smb: client: only require read lease for size-extending" failed to apply to 7.2-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,brauner@kernel.org,dhowells@redhat.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:42:21 +0200
Message-ID: <2026100621-pecan-tartness-6f95@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x b5d59e7270d078ab28a9c4b4d11dc3eb24671988
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100621-pecan-tartness-6f95@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b5d59e7270d078ab28a9c4b4d11dc3eb24671988 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Sat, 26 Sep 2026 18:34:51 -0300
Subject: [PATCH] smb: client: only require read lease for size-extending
 preallocate

smb3_simple_falloc() refuses any fallocate that clears FALLOC_FL_KEEP_SIZE
with -EOPNOTSUPP whenever the inode is not read caching:

	/* if file not oplocked can't be sure whether asking to extend size */
	if (!CIFS_CACHE_READ(cifsi))
		if (!keep_size) {
			...
			return rc;
		}

As with smb3_zero_range(), the read lease is only needed to trust the
cached size when deciding whether the request extends the file. When it
is not held, the size can instead be fetched from the server, which is
authoritative, rather than refusing the request outright: after
flushing, query the server's end of file and take the larger of it and
the cached size for the interior-vs-extend decision. The larger of the
two is used because the server's end of file reflects another client's
growth while the cached size reflects this client's own writes that may
not have reached the server yet; using the server size alone would
wrongly treat an interior request as extending when a range flush left
an extending write unwritten.

smb3_simple_fallocate_range(), which performs the actual interior
emulation, decided whether the range already lies past EOF from its own
i_size_read(inode) rather than the old_eof computed above. In the
leaseless case, that is exactly the stale, undershooting size this
patch works around: a genuinely interior range can read as past EOF by
that stale count, which skips the FSCTL_QUERY_ALLOCATED_RANGES check
entirely and overwrites already-allocated server data with zeroes
instead of only filling the holes. Pass old_eof into
smb3_simple_fallocate_range() and use it for that comparison instead of
re-deriving a second, inconsistent one.

Rejecting interior requests is observed as generic/363 randomly failing
against Windows Server with

	do_preallocate: fallocate: Operation not supported

fsx issues an interior, non-KEEP_SIZE preallocate while the inode is
transiently not read caching: the server had just downgraded the file's
lease from RWH to RH after breaking the write caching, and the ensuing
handle reopen/revalidation left CIFS_CACHE_READ momentarily clear. The
range sat within the server's end of file, so no extend was needed, yet
it was refused and fsx aborted. This keeps the emulation correct even
when a genuine lease break from another client leaves the inode
without read caching -- the case the -EOPNOTSUPP guard turned into a
hard failure. The extra flush and round trip only happen when both
keep_size is false and no read lease is held; every other case is
unchanged.

Fixes: 9ccf3216238c ("Add support for original fallocate")
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
index 2d4cb54739ca..583ab4c4d773 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3747,7 +3747,8 @@ static int smb3_simple_fallocate_write_range(unsigned int xid,
 static int smb3_simple_fallocate_range(unsigned int xid,
 				       struct cifs_tcon *tcon,
 				       struct cifsFileInfo *cfile,
-				       loff_t off, loff_t len)
+				       loff_t off, loff_t len,
+				       loff_t old_eof)
 {
 	struct file_allocated_range_buffer in_data, *out_data = NULL, *tmp_data;
 	struct inode *inode = d_inode(cfile->dentry);
@@ -3763,7 +3764,7 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 		goto out;
 	}
 
-	if (off >= i_size_read(inode)) {
+	if (off >= old_eof) {
 		rc = smb3_simple_fallocate_write_range(xid, tcon, cfile,
 						       off, len, buf);
 		goto out;
@@ -3874,7 +3875,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 	struct cifsFileInfo *cfile = file->private_data;
 	long rc = -EOPNOTSUPP;
 	unsigned int xid;
-	loff_t old_eof, new_eof;
+	loff_t old_eof, new_eof, local_eof;
 	struct smb2_file_all_info file_inf;
 	u64 asize;
 	int qrc;
@@ -3883,18 +3884,37 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 
 	inode = d_inode(cfile->dentry);
 	cifsi = CIFS_I(inode);
-	old_eof = i_size_read(inode);
+	old_eof = local_eof = i_size_read(inode);
 
 	trace_smb3_falloc_enter(xid, cfile->fid.persistent_fid, tcon->tid,
 				tcon->ses->Suid, off, len);
-	/* if file not oplocked can't be sure whether asking to extend size */
-	if (!CIFS_CACHE_READ(cifsi))
-		if (!keep_size) {
+
+	if (!keep_size && !CIFS_CACHE_READ(cifsi)) {
+		unsigned long long server_eof;
+
+		rc = filemap_write_and_wait(inode->i_mapping);
+		if (rc) {
 			trace_smb3_falloc_err(xid, cfile->fid.persistent_fid,
 				tcon->tid, tcon->ses->Suid, off, len, rc);
 			free_xid(xid);
 			return rc;
 		}
+		netfs_wait_for_outstanding_io(inode);
+
+		rc = query_server_eof(xid, tcon, cfile, &server_eof);
+		if (rc) {
+			trace_smb3_falloc_err(xid, cfile->fid.persistent_fid,
+				tcon->tid, tcon->ses->Suid, off, len, rc);
+			free_xid(xid);
+			return rc;
+		}
+		/*
+		 * Only use the larger EOF to decide whether we're extending.
+		 * The pagecache zeroing below must still key off the local
+		 * i_size, so keep local_eof for that.
+		 */
+		old_eof = max_t(loff_t, old_eof, server_eof);
+	}
 
 	/*
 	 * Extending the file
@@ -3918,7 +3938,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 			}
 
 			rc = smb3_simple_fallocate_range(xid, tcon, cfile,
-							 off, len);
+							 off, len, old_eof);
 			if (rc) {
 				spin_lock(&inode->i_lock);
 				cifsi->time = 0;
@@ -3927,7 +3947,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 			}
 
 			new_eof = off + len;
-			cifs_resize_file_locked(inode, old_eof, new_eof);
+			cifs_resize_file_locked(inode, local_eof, new_eof);
 
 			qrc = SMB2_query_info(xid, tcon,
 					      cfile->fid.persistent_fid,
@@ -3975,7 +3995,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 		if (rc)
 			goto out;
 
-		cifs_resize_file_locked(inode, old_eof, new_eof);
+		cifs_resize_file_locked(inode, local_eof, new_eof);
 
 		qrc = SMB2_query_info(xid, tcon,
 				      cfile->fid.persistent_fid,
@@ -4020,7 +4040,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 		}
 	}
 
-	if ((keep_size == true) || (i_size_read(inode) >= off + len)) {
+	if (keep_size || old_eof >= off + len) {
 		/*
 		 * At this point, we are trying to fallocate an internal
 		 * regions of a sparse file. Since smb2 does not have a
@@ -4037,7 +4057,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 		 */
 		if (len <= 1024 * 1024) {
 			rc = smb3_simple_fallocate_range(xid, tcon, cfile,
-							 off, len);
+							 off, len, old_eof);
 			goto out;
 		}
 
@@ -4049,7 +4069,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 		 * ie potentially making a few extra pages at the beginning
 		 * or end of the file non-sparse via set_sparse is harmless.
 		 */
-		if ((off > 8192) || (off + len + 8192 < i_size_read(inode))) {
+		if (off > 8192 || off + len + 8192 < old_eof) {
 			rc = -EOPNOTSUPP;
 			goto out;
 		}

