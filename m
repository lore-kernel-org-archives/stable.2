Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3973C8719
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791362761; cv=none; b=bMAjkg5IUzfSaBOspLxMiusYIFtOQ5ks/gO4e1PvI4MSIf7+N8EAnr/TZxXUqXhsEkDnmcmUne9KqCV/RTajCAjBjbJ2oH6l0C7BpTT58PPtKqLKt/4JXYeHaSwJ7MuVYGZ8iSB6VpLjn53WerNyZLtc9DvFcSBOd/Ln/D0uId0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791362761; c=relaxed/simple;
	bh=bVsJXuvmyV5vu7Y2unC7jCESYbV2RjL3XvNbNnA2axM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5LtoRjMFf/TnxuPlZFX/pM1B7LvOiF/jzTH2iXdtWEGKC6JMyFwJI3JJKzFTuBsEXEXaM3f1hbt9H+Ak7BSXRv2H/zwNJrjn4FQTU8UKh7yQzS/Nc0v5xJwPO24x5piWC8cM6jzVvufYc4Nd0Fi5vCrlmofa6goQ/DtKGgubqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvnrpQDe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvnrpQDe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A261F0089B;
	Wed,  7 Oct 2026 08:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791362759;
	bh=5kUDB48eD8+CKCzhFlfZ10Tztlyoz2KlATn/URuZhlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MvnrpQDelRp7U6x9uIxS5Xy+XbxakkorthJzQv5fQxJJUER8dl79wQASB5/yr5g33
	 z0NjwMN4CbvHJSy7+fG4wK1IMO1iXEpFth8iEeKOL3rv06yd5tQmQtL2wxf2Gwf0Vr
	 FNeNQ7Tzp/CILFjCqMWxw0LqW0dBoe6G79ffllPdF9Vabn42ydnQZCYUc4OtjT5sYj
	 atTZaB4cNDloOY6GT6k8RHoBfR3Ex/hVHQmZv+Qcq7JY1MP8IvpKuO5t/EvmulU1nR
	 F9TR1jrr67BcffxXkuflX2stbOcp6e9PJL4gf/QZjh5Ae8MvRo77Jys3d3ifl2p7P6
	 kJox5xSzsVkNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] smb: client: only require read lease for size-extending preallocate
Date: Wed,  7 Oct 2026 04:45:55 -0400
Message-ID: <20261007083718.1750244-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100623-excavate-prune-c97d@gregkh>
References: <2026100623-excavate-prune-c97d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit b5d59e7270d078ab28a9c4b4d11dc3eb24671988 ]

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
[ sashal: Replaced query_server_eof() with an inline SMB2_query_info() call. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2ops.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 887ffa77aa183..4aadebec00143 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3536,28 +3536,46 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 	struct cifsFileInfo *cfile = file->private_data;
 	long rc = -EOPNOTSUPP;
 	unsigned int xid;
-	loff_t new_eof;
+	loff_t old_eof, new_eof;
 
 	xid = get_xid();
 
 	inode = d_inode(cfile->dentry);
 	cifsi = CIFS_I(inode);
+	old_eof = i_size_read(inode);
 
 	trace_smb3_falloc_enter(xid, cfile->fid.persistent_fid, tcon->tid,
 				tcon->ses->Suid, off, len);
-	/* if file not oplocked can't be sure whether asking to extend size */
-	if (!CIFS_CACHE_READ(cifsi))
-		if (keep_size == false) {
+
+	if (!keep_size && !CIFS_CACHE_READ(cifsi)) {
+		struct smb2_file_all_info file_inf = {};
+		unsigned long long server_eof;
+
+		rc = filemap_write_and_wait(inode->i_mapping);
+		if (rc) {
+			trace_smb3_falloc_err(xid, cfile->fid.persistent_fid,
+				tcon->tid, tcon->ses->Suid, off, len, rc);
+			free_xid(xid);
+			return rc;
+		}
+
+		rc = SMB2_query_info(xid, tcon, cfile->fid.persistent_fid,
+				     cfile->fid.volatile_fid, &file_inf);
+		if (rc) {
 			trace_smb3_falloc_err(xid, cfile->fid.persistent_fid,
 				tcon->tid, tcon->ses->Suid, off, len, rc);
 			free_xid(xid);
 			return rc;
 		}
+		server_eof = le64_to_cpu(file_inf.EndOfFile);
+		/* Only use the larger EOF to decide whether we're extending. */
+		old_eof = max_t(loff_t, old_eof, server_eof);
+	}
 
 	/*
 	 * Extending the file
 	 */
-	if ((keep_size == false) && i_size_read(inode) < off + len) {
+	if (!keep_size && old_eof < off + len) {
 		rc = inode_newsize_ok(inode, off + len);
 		if (rc)
 			goto out;
@@ -3605,7 +3623,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 		}
 	}
 
-	if ((keep_size == true) || (i_size_read(inode) >= off + len)) {
+	if (keep_size || old_eof >= off + len) {
 		/*
 		 * At this point, we are trying to fallocate an internal
 		 * regions of a sparse file. Since smb2 does not have a
@@ -3634,7 +3652,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 		 * ie potentially making a few extra pages at the beginning
 		 * or end of the file non-sparse via set_sparse is harmless.
 		 */
-		if ((off > 8192) || (off + len + 8192 < i_size_read(inode))) {
+		if (off > 8192 || off + len + 8192 < old_eof) {
 			rc = -EOPNOTSUPP;
 			goto out;
 		}
-- 
2.53.0

