Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795667561;
	b=5dvFhlW2xh2Evrfu/Q7lLCecQpc2IJawkC3AImCfd0plJg6Jj26N2dyrSXzHtLsHDBQ4
	 NTbKqBopnUpH+a1Heq9xvY32YQQtbLZJnsZYp29VcjgeImuoLCPIRAAwS8U09JJzlNJp7
	 G7r33aZ01MjDikRy2x1tldquWnBpGkvfr1eDV4qTEX6hhQpRIvrWUCR1HTeWMFQ1CbuM6
	 MSVfJhnRgm8S1uTmvQKnyzY93gLTagWhzoXHnhBg+35xZy40IbSaKdpYqKBazc9xwPTqo
	 w9y4tbQFLvj8pbwDU8gzKEiwYt/FEC1mE42w+aq8pXXqj33D8LPJejn61nA5h0BE0lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795667561;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8WlPbEWJWt9mukd8pvKhqtwl/T5nk/QxP0Whf/iCqE0=;
	b=ui4J5ck6n00HGjzDvDQ6K5Wm2VjfN9TXamyqRlx+ZNxatY0hll1oeiSeMXITuE2vL5cm
	 iOf2/DMqf/kv19AO6p+o4gs+yE8k+xrWmwxlHfkHW/DklzgLS6g/qPYbhXdfVvscNqFKc
	 TqBfo+cKNDUWRw4DSU4k6q5MlzT9UkPEmMGvMKIRCXipowvRba1L++2MveEQfehGCmGsv
	 nfjqIInOAVqQtO4cAdIcPgydwRAyeF3Z4ILPlBxneqvz1Ch6sHvrGtw5EDAaWyd421jyT
	 5h5Bn0dOm3oGiCfpE+ahxzBmWfWThqupL1hMmNYYJR8SDLCGnLUAXn4tv4Iq+HFVNRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Q1BhT/4r";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCB4606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q1BhT/4r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B031F000C6;
	Thu, 26 Nov 2026 04:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795667560;
	bh=8WlPbEWJWt9mukd8pvKhqtwl/T5nk/QxP0Whf/iCqE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q1BhT/4rTripfMREWZrKroO4lDSi2orVcrD19VrEpgORWhxmfwCxqLcbCEg04li73
	 hpcuAmYQZcmyA17sKX8N+/EIBLdHq8Uj0lMnRlr3+1qu/uz7jrXvYJBK2+t/ODwbrg
	 DNV0jJPWvqlbmfbK5eTY0ZYTNDUCSRP3l74KHcQ0l+PodIBYGzcNccXMsWcJUCSBGk
	 JXjLMuQ6l1otBtkWZdNOy6djrfFA2uqVN9ObB+Is5b1RXai0v5hwamu4v++4zWJEBz
	 Rzq3MWxRtNFEVeMWJXaCoDm6S3XXX1hxQIbfENyyri6slQO9Jez8X5o5llJNBSA2+h
	 jqiwUHrXurlMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] smb: client: don't fail writeback preparation if the task is dying
Date: Wed, 25 Nov 2026 23:32:38 -0500
Message-ID: <20261126043217.1960487-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112518-brim-hatchet-6280@gregkh>
References: <2026112518-brim-hatchet-6280@gregkh>
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
[ sashal: moved cifs_writeback_dying() above cifs_prepare_write() so the new calls compile, because the earlier backport had left it after that function. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h |  1 +
 fs/smb/client/file.c     | 49 +++++++++++++++++++++++++++++-----------
 2 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 68f56547ef721..c70c214ac7cc6 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1898,6 +1898,7 @@ enum cifs_find_flags {
 	FIND_NO_PENDING_DELETE	= (1U << 2),
 	FIND_OPEN_FLAGS		= (1U << 3),
 	FIND_NO_DIRECT		= (1U << 4),
+	FIND_NO_REOPEN		= (1U << 5),
 };
 
 #define   MID_FREE 0
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 4da53f84196f1..e999d94ac44fb 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -94,6 +94,12 @@ static bool cifs_io_aborted(struct cifs_io_subrequest *subreq)
 	       tcon->need_reconnect;
 }
 
+static bool cifs_writeback_dying(struct netfs_io_subrequest *subreq)
+{
+	return subreq->rreq->origin == NETFS_WRITEBACK &&
+		fatal_signal_pending(current);
+}
+
 /*
  * Prepare a subrequest to upload to the server.  We need to allocate credits
  * so that we know the maximum amount of data that we can include in it.
@@ -129,12 +135,17 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
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
@@ -143,10 +154,17 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
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
@@ -167,12 +185,6 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
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
@@ -221,10 +233,15 @@ static void __cifs_issue_write(struct netfs_io_subrequest *subreq)
 
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
@@ -362,15 +379,17 @@ static void cifs_begin_writeback(struct netfs_io_request *wreq)
 	struct cifs_io_request *req = container_of(wreq, struct cifs_io_request, rreq);
 	int ret;
 
-	ret = cifs_get_writable_file(CIFS_I(wreq->inode), FIND_NO_DIRECT,
+	ret = cifs_get_writable_file(CIFS_I(wreq->inode),
+				     FIND_NO_REOPEN | FIND_NO_DIRECT,
 				     &req->cfile);
 	if (ret) {
-		ret = cifs_get_writable_file(CIFS_I(wreq->inode), FIND_ANY,
-					     &req->cfile);
+		ret = cifs_get_writable_file(CIFS_I(wreq->inode),
+					     FIND_NO_REOPEN, &req->cfile);
 	}
 	if (ret) {
 		cifs_dbg(VFS, "%s: couldn't find writable handle: %d\n",
 			 __func__, ret);
+		mapping_set_error(wreq->mapping, -EIO);
 		return;
 	}
 
@@ -2841,7 +2860,7 @@ int __cifs_get_writable_file(struct cifsInodeInfo *cifs_inode,
 	}
 
 	if (test_bit(CIFS_INO_TMPFILE, &cifs_inode->flags))
-		find_flags &= FIND_NO_DIRECT;
+		find_flags &= FIND_NO_REOPEN | FIND_NO_DIRECT;
 
 	cifs_sb = CIFS_SB(cifs_inode);
 
@@ -2901,6 +2920,10 @@ int __cifs_get_writable_file(struct cifsInodeInfo *cifs_inode,
 	spin_unlock(&cifs_inode->open_file_lock);
 
 	if (inv_file) {
+		if (find_flags & FIND_NO_REOPEN) {
+			*ret_file = inv_file;
+			return 0;
+		}
 		rc = cifs_reopen_file(inv_file, false);
 		if (!rc) {
 			*ret_file = inv_file;
-- 
2.53.0

