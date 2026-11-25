Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606045;
	b=3RiS1gOFSc0xafJmTtLfOFAfFeagZKVxx7ga/+LzCeYOzN6lNBPqWv/vZjOue/9XxMQa
	 GpQdWYp/KdIIwybmDDGPKoAvitO05LHFvuY/2N0kSs2Jb2rVltbOQPT/yTL5/B8bz3nrn
	 tpEG1hSLD1XAlBLn87goQEMXXVvf8n0ODNE2/CPZslNUCw/5X9aPB2nwbS5pxf4Vb5Vqq
	 PINqIx385oxwnt8+aN9F3ywDP0Zg07Z0rSq3KDGixGYSLTN13zNN94mGc2gy+QjHR2mE0
	 JSilxy9ZiDQGasIJK5morPsEHesCA+4LpecKUQbDt8EA1Rbj8wDipWiqG0xxMISzwaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606045;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dl8jWiLOngNrDSJSrc03hWl/5Arz+65Sb+s/2AgdWdM=;
	b=Wa/HUsO55TfWdms/yOmsftCLavO+4aNipqScRlkV1x8TfMf2Lz6x1ClLYFzkZU+OSqYs
	 lUEviBewL5dzkKgiGTg0xhYrzfOaY1++m6q3pE5GW5/ugURP6xL8b4Zb+/eXjvKMI3DI+
	 /HFLGo4Q2vs6hhwK8Z1rxY63Sw/wFcfrJ7M9CpPa+aJmKWiMrZXzklRYptRYDc6kl54J2
	 iwyy1D51+OOeDsaKMg36HYAqBRuQEJEWk+iPqRitsknxyhDrhVJrRc4lxaeaoWvQYpHZb
	 Kx72YBYwWpAto5L4PNmcqQjB4Lld231tHkrldbn3U/YrKeqZbYHRUfn2tOlb18HSSqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=AaKB17Ho;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43186606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=AaKB17Ho
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173BA1F000D0;
	Wed, 25 Nov 2026 11:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606044;
	bh=dl8jWiLOngNrDSJSrc03hWl/5Arz+65Sb+s/2AgdWdM=;
	h=Subject:To:Cc:From:Date;
	b=AaKB17HoWOusmwijWT1Uey2fMXIWrx0+a8AhYYLbaqxvM46zl5j74OdooKUqVzcBi
	 sNXUFn6RC6TRkPtoOenGbG3snbtMXv7RoK04KB2Asd8TeH+pI6y6VivAn69tolqoIl
	 T/fRlwYOafhTDMAR2/EX6Sr03hECpvuYaFweYa9E=
Subject: FAILED: patch "[PATCH] smb: client: don't write back through O_DIRECT handles" failed to apply to 6.1-stable tree
To: pc@manguebit.org,dhowells@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:14:13 +0100
Message-ID: <2026112513-overspend-human-342b@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0e85145af984f7cae2aadaa694cb8612009027ac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112513-overspend-human-342b@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0e85145af984f7cae2aadaa694cb8612009027ac Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Sun, 1 Nov 2026 13:02:11 -0300
Subject: [PATCH] smb: client: don't write back through O_DIRECT handles

Writeback uses the first writable handle of the inode, which may have
been opened with O_DIRECT.  Such handles are opened with
FILE_NO_INTERMEDIATE_BUFFERING, for which Windows rejects any unaligned
I/O with STATUS_INVALID_PARAMETER.  Writeback of partly dirty pages and
of the unaligned tail of a file through one of them fails, so netfs ends
it with the folios clean and the data never reaches the server.

xfstests generic/051, where fsstress mixes both kinds of opens, loses
about 1% of its writes this way:

  smb3_write_err: ... offset=0xde90d7 len=0xbd0b rc=-22

All the rejected writes in a network capture were unaligned writes on a
no-buffering handle; none of the aligned ones, and none of the unaligned
ones on regular handles, were.

Prefer a handle that was not opened with O_DIRECT, and use one that was
only if there is no other.

Fixes: 1013e760d10e ("SMB3: Don't ignore O_SYNC/O_DSYNC and O_DIRECT flags")
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: stable@vger.kernel.org

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index d3ca688b6aba..dbf980fcf05b 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1891,6 +1891,7 @@ enum cifs_find_flags {
 	FIND_WITH_DELETE	= (1U << 1),
 	FIND_NO_PENDING_DELETE	= (1U << 2),
 	FIND_OPEN_FLAGS		= (1U << 3),
+	FIND_NO_DIRECT		= (1U << 4),
 };
 
 #define   MID_FREE 0
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 0767eb5f4687..aa2d09dac44c 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -255,9 +255,15 @@ static void cifs_begin_writeback(struct netfs_io_request *wreq)
 	struct cifs_io_request *req = container_of(wreq, struct cifs_io_request, rreq);
 	int ret;
 
-	ret = cifs_get_writable_file(CIFS_I(wreq->inode), FIND_ANY, &req->cfile);
+	ret = cifs_get_writable_file(CIFS_I(wreq->inode), FIND_NO_DIRECT,
+				     &req->cfile);
 	if (ret) {
-		cifs_dbg(VFS, "No writable handle in writepages ret=%d\n", ret);
+		ret = cifs_get_writable_file(CIFS_I(wreq->inode), FIND_ANY,
+					     &req->cfile);
+	}
+	if (ret) {
+		cifs_dbg(VFS, "%s: couldn't find writable handle: %d\n",
+			 __func__, ret);
 		return;
 	}
 
@@ -2722,7 +2728,7 @@ int __cifs_get_writable_file(struct cifsInodeInfo *cifs_inode,
 	}
 
 	if (test_bit(CIFS_INO_TMPFILE, &cifs_inode->flags))
-		find_flags = FIND_ANY;
+		find_flags &= FIND_NO_DIRECT;
 
 	cifs_sb = CIFS_SB(cifs_inode);
 
@@ -2752,6 +2758,9 @@ int __cifs_get_writable_file(struct cifsInodeInfo *cifs_inode,
 		    !open_flags_match(cifs_inode, open_flags,
 				      open_file->f_flags))
 			continue;
+		if ((find_flags & FIND_NO_DIRECT) &&
+		    (open_file->f_flags & O_DIRECT))
+			continue;
 		if (OPEN_FMODE(open_file->f_flags) & FMODE_WRITE) {
 			if (!open_file->invalidHandle) {
 				/* found a good writable file */

