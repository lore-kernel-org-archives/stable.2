Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795668602;
	b=kocbiLPDpKUislk+t2MeND56dUilxT84lNug4/57/CljlI5L+N9QHBEpgGG/KU3bmuqT
	 eurg/XbjfCSSjamvm1jjeeUQjp/7I6XOEbJOR1oP7qXEmcM1GKQN9z6vSnF4mlHpi/2ap
	 YVQcftZga/mkq09U29lcq/f0IzbJpoQqCtC5AJUZGxUPWcS+jS6YBL56+FLUOJJka4XNo
	 oyKGTa/x18vmubFlvlSDmfoaMQ4F3bEd4g0cnbEwa6wGchb1/0khDNbmXo/Lw+ak4Sp31
	 +KhFF4oGzJt1qZ46g3ITUGRw9SwHAaeonJ8TE3epDnvTaCuXjr5xvqPyJQfuCtHyXQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795668602;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1vVoJlNNeJacpyg+xHLEElhzmn3yXu4ReNrOE2b8W0g=;
	b=rCee+xKtMx1etih8G3BqFWyuOpzECtc7hH3PWQce4EWRI7L7jXxtFVbGQUemG5tSe8LX
	 mbXBB29zuISDewjUAOJMrQFNBhL+xET/QrugJy12hVTo2opCmliJJD49s20tWFNKgzE9Z
	 eznLfjIFH9y2YXQ5gpkoT+J2QzZEmnTLDYv4Yi+J5u5xxSgtNCiu4NMLd/6tP00p58pDB
	 rDvUzJxoDSH3ZF2x91WPogSchISPNHVwcE8mj/3eeVvkaEzA5DObEUmami/jiidMqttJR
	 ALkQhVTdE7wAylSWdJCuyLGSN+9C4i8n7dECykfslTKinOLu6Einsa2BG0XsgUCUq0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O63ohb42;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44322606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O63ohb42
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7901F000C4;
	Thu, 26 Nov 2026 04:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795668602;
	bh=1vVoJlNNeJacpyg+xHLEElhzmn3yXu4ReNrOE2b8W0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O63ohb42EC3ARHqGyLE78CKqL0I+Ml9gZoeTjOaOPp5nBOc4UFoKtHf2WAYBQHcOg
	 TJrnvG3VhT+IlqxKVDJqyhbsxfvsjtzgyP5lMz8PkLlDlWNypLQnNSGm2M3pzf8KSj
	 zy78k/JBpAlQcE4T/p3RtR9npYMeSP7DatkmVNxeEezbz+A/R0kBPoNQv7VcipUjST
	 sZroM5xsHD/vfwD55Y4tMTNEPVJoqUKvneUv+xozkp4xyngCJ1Jhq6LQcpIJ6qtULD
	 KrRVrrZGZS5yzl+SBcOJjdFJui/fC9LSS+/DZitjUfG0vKf1Uxc6ITp5Hhqy8ZNeWK
	 k6b1lYgCIv1gw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] smb: client: don't fail writeback preparation if the task is dying
Date: Wed, 25 Nov 2026 23:50:00 -0500
Message-ID: <20261126044921.2024643-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112554-backwater-proving-5a93@gregkh>
References: <2026112554-backwater-proving-5a93@gregkh>
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
[ sashal: Adapted the no-reopen flag to the older FIND_WR_* macro scheme, made a single call in cifs_begin_writeback(), dropped the tmpfile hunk, and moved cifs_writeback_dying() above cifs_prepare_write(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h |  1 +
 fs/smb/client/file.c     | 43 ++++++++++++++++++++++++++++++----------
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 27bdb50751852..4508f9294001a 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1815,6 +1815,7 @@ static inline bool is_replayable_error(int error)
 #define FIND_WR_ANY         0
 #define FIND_WR_FSUID_ONLY  1
 #define FIND_WR_WITH_DELETE 2
+#define FIND_WR_NO_REOPEN   4
 
 #define   MID_FREE 0
 #define   MID_REQUEST_ALLOCATED 1
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 4a62787891292..7baf55b0e7ffe 100644
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
@@ -63,12 +69,17 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
 	server = cifs_pick_channel(tlink_tcon(open_file->tlink)->ses);
 	wdata->server = server;
 
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
@@ -77,10 +88,17 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
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
@@ -97,12 +115,6 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
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
@@ -142,10 +154,15 @@ static void __cifs_issue_write(struct netfs_io_subrequest *subreq)
 
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
@@ -267,9 +284,11 @@ static void cifs_begin_writeback(struct netfs_io_request *wreq)
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
 
@@ -2581,6 +2600,10 @@ cifs_get_writable_file(struct cifsInodeInfo *cifs_inode, int flags,
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

