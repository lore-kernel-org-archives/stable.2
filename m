Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795668572;
	b=TgRgvawmOqc+FR2fDR1VOIbkqVnhrq/zhGbgAoZQ3P5u+IP6mvcymYp1Jl/VJ3VT2jd/
	 Gh8m0XSc8hboDP2wDrkKomGWnItCL24Q228QmXAS3i0m0ZgikqtI/e+GpvQnjYAIUe/38
	 FBZlg7Wa5XMbpuCKHUjbmA0xzlq8txnLEmOdEx4XSFg5xIWETeYfFGuxeBF5hRTI6YviJ
	 74I8yreY9uWfgTqGbgytW0NrBy3CN+u7SZ0BCb7I1QxXd45mXaxdINk56JMAkPNXJE4Ff
	 xjzMiD+/GRulFJ4ldzMaRq4/Lt+J1am8wFvOXBnucR5TqITyREyEDtjc99GCmfWkNWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795668572;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BdauTFr6cQCWgerOT3g5u3DAiAP8M5FP+7qP8q+hzCc=;
	b=o+mkpGSHbLyeaIjvy6OOf7Oa2Vhj8x/EfrEholrLwjUnIwRHKOrZwNrnGuD5bwgSv1et
	 zHpCGn8xDALrXIfMCerxMl0XQAEwrZ1vsuG4YxTV9SBSY+gqTe6iSEtQc4W7B+2zDFLVP
	 KibGUfuNJa9zvQesQ7dK7S8C/1C0Ug5RYh/5uqSni07pDsiaat5Qvb9DQ+KXMqaqA7owS
	 3d8ljTYntOvybD3n8hUiIDhF5eO7u/Hn6tshdFoXSPFI8sN9XDLfVUWjgy4s+9tAf6mkX
	 Ru0XJuqyt5qqvitvM265O31O96u3YibCQJj+gPW/FOfEkyBvQBDvTZPlhPNruzx2Zmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ckhtb7NE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82652606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ckhtb7NE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF4B1F000CF;
	Thu, 26 Nov 2026 04:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795668571;
	bh=BdauTFr6cQCWgerOT3g5u3DAiAP8M5FP+7qP8q+hzCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ckhtb7NEB6/OgTjNH3RbmkWx5ylzDWUhZHX5bRRNowbi+aDkz/t2YLpZmbYAWWFpN
	 Xj29WbdJVvrI6DJhss7Bo3lAN1YkpIbVykZuSzBbkwiwF/UoKLdszbobFKXrp+qm5r
	 qRMeiPClNnLBs5FYIGVHXlHKCa32Mq4yM3smlzg9SOyRmjdteqCC5TzjC8p+FAcohS
	 fel4eJfm3ka1ICGn26hfq1dBX6vTYPHnFvh0LscWZJxd52hX3MSggF5KSoenCIEkMa
	 jOFmlL2VxZoRA7kDNZ4UgXcPGjrKpK1RcDrCE3JD7FwzHf/Lq7Tu8eDQ0Wd/Mo5fD5
	 dYYbRPGAALUBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] smb: client: don't fail writeback preparation if the task is dying
Date: Wed, 25 Nov 2026 23:49:29 -0500
Message-ID: <20261126044611.2007466-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112554-overeater-dividend-3be2@gregkh>
References: <2026112554-overeater-dividend-3be2@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit 29ead886deaa1344a43ab68b1ea305ea2c86c378 ]

cifs_prepare_write() may need to reopen an invalidated handle and to wait
for credits, both from the context of the task doing writeback.  A dying
task gets the reopen refused at send time and the killable credit wait
interrupted, so the subrequest is failed and, as with refused sends, its
folios end writeback clean and the data is lost.

For writeback in a dying task, skip both and prepare a credit-less
subrequest capped at SMB2_MAX_BUFFER_SIZE, as already done when the
server is low on credits.  It gets issued from cifswritebackd, which
reopens the handle if needed and takes a single credit when sending,
neither of which can be interrupted there.  Do the same when the reopen
or credit wait fails because a fatal signal arrived meanwhile.

cifs_begin_writeback() reopens the handle too when all the writable ones
got invalidated, e.g. by a reconnect.  If that fails, there is no
upload stream, so netfs ends writeback of every folio clean with no
error recorded.  Take an invalidated handle as is there and leave
reopening it to cifs_prepare_write().  If there is no writable handle at
all, record -EIO for the mapping, so that the loss gets reported.

Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: stable@vger.kernel.org
[ sashal: Replaced the missing FIND_NO_DIRECT two-step lookup with a single call using a new FIND_WR_NO_REOPEN flag, and dropped the TMPFILE find_flags mask that doesn't exist here. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h |  1 +
 fs/smb/client/file.c     | 43 ++++++++++++++++++++++++++++++----------
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index ea6533d057acf..93ea0b4b0f524 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1868,6 +1868,7 @@ enum cifs_writable_file_flags {
 	FIND_WR_FSUID_ONLY		= (1U << 0),
 	FIND_WR_WITH_DELETE		= (1U << 1),
 	FIND_WR_NO_PENDING_DELETE	= (1U << 2),
+	FIND_WR_NO_REOPEN		= (1U << 3),
 };
 
 #define   MID_FREE 0
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 652206fead33c..8da5c9ab13589 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -40,6 +40,12 @@
 
 static int cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush);
 
+static bool cifs_writeback_dying(struct netfs_io_subrequest *subreq)
+{
+	return subreq->rreq->origin == NETFS_WRITEBACK &&
+		fatal_signal_pending(current);
+}
+
 /*
  * Prepare a subrequest to upload to the server.  We need to allocate credits
  * so that we know the maximum amount of data that we can include in it.
@@ -68,12 +74,17 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
 		cifs_negotiate_wsize(server, cifs_sb->ctx,
 				     tlink_tcon(req->cfile->tlink));
 
+	if (cifs_writeback_dying(subreq))
+		goto defer;
+
 retry:
 	if (open_file->invalidHandle) {
 		rc = cifs_reopen_file(open_file, false);
 		if (rc < 0) {
 			if (rc == -EAGAIN)
 				goto retry;
+			if (cifs_writeback_dying(subreq))
+				goto defer;
 			subreq->error = rc;
 			return netfs_prepare_write_failed(subreq);
 		}
@@ -82,10 +93,17 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
 	rc = server->ops->wait_mtu_credits(server, wsize, &stream->sreq_max_len,
 					   &wdata->credits);
 	if (rc < 0) {
+		if (cifs_writeback_dying(subreq))
+			goto defer;
 		subreq->error = rc;
 		return netfs_prepare_write_failed(subreq);
 	}
+	goto out;
 
+defer:
+	wdata->credits = (struct cifs_credits){};
+	stream->sreq_max_len = min_t(size_t, wsize, SMB2_MAX_BUFFER_SIZE);
+out:
 	wdata->credits.rreq_debug_id = subreq->rreq->debug_id;
 	wdata->credits.rreq_debug_index = subreq->debug_index;
 	wdata->credits.in_flight_check = 1;
@@ -106,12 +124,6 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
 #endif
 }
 
-static bool cifs_writeback_dying(struct netfs_io_subrequest *subreq)
-{
-	return subreq->rreq->origin == NETFS_WRITEBACK &&
-		fatal_signal_pending(current);
-}
-
 /*
  * Issue a subrequest to upload to the server.
  */
@@ -153,10 +165,15 @@ static void __cifs_issue_write(struct netfs_io_subrequest *subreq)
 
 static void cifs_issue_write_worker(struct work_struct *work)
 {
-	struct netfs_io_subrequest *subreq;
+	struct cifs_io_subrequest *wdata;
+	struct cifsFileInfo *cfile;
 
-	subreq = container_of(work, struct netfs_io_subrequest, work);
-	__cifs_issue_write(subreq);
+	wdata = container_of(work, struct cifs_io_subrequest, subreq.work);
+	cfile = wdata->req->cfile;
+	while (cfile->invalidHandle &&
+	       cifs_reopen_file(cfile, false) == -EAGAIN)
+		;
+	__cifs_issue_write(&wdata->subreq);
 }
 
 static void cifs_issue_write(struct netfs_io_subrequest *subreq)
@@ -282,9 +299,11 @@ static void cifs_begin_writeback(struct netfs_io_request *wreq)
 	struct cifs_io_request *req = container_of(wreq, struct cifs_io_request, rreq);
 	int ret;
 
-	ret = cifs_get_writable_file(CIFS_I(wreq->inode), FIND_WR_ANY, &req->cfile);
+	ret = cifs_get_writable_file(CIFS_I(wreq->inode), FIND_WR_NO_REOPEN,
+				     &req->cfile);
 	if (ret) {
 		cifs_dbg(VFS, "No writable handle in writepages ret=%d\n", ret);
+		mapping_set_error(wreq->mapping, -EIO);
 		return;
 	}
 
@@ -2696,6 +2715,10 @@ cifs_get_writable_file(struct cifsInodeInfo *cifs_inode, int flags,
 	spin_unlock(&cifs_inode->open_file_lock);
 
 	if (inv_file) {
+		if (flags & FIND_WR_NO_REOPEN) {
+			*ret_file = inv_file;
+			return 0;
+		}
 		rc = cifs_reopen_file(inv_file, false);
 		if (!rc) {
 			*ret_file = inv_file;
-- 
2.53.0

