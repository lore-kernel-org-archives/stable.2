Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795668427;
	b=RJpbRdDYv8sqtiF5/U5Pe4KRTGnUNbMU7+ThTH3eeiPuxKeEtqWrw9ifEXQDZQHS8CGg
	 wzwbjH6QOodULvm+svElKMNAxv+cSI+9gc3XJD/99XjzkIeLW2QzPtPlMZtsebjM+ChHr
	 I04Yol+plG4LlX2mnybmY526mvUOYhuCg5VMJLX2q42mtfKWnXPZ6aXIZJUVG6q9Uc1RF
	 yB0t2Bc9Z8S3vC+CNXKOF9NLkMpuGh7Cpp5OfH1J+xsPOWNW33aQ2KyzAUjQPUb1+NgSw
	 xQcfgu7a0XbN60/phFvNyibJK44KtrppPiXHyWc8HE3nhrt4j8V6ZuKAkQYFKre/rvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795668427;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Y00TdBClThxfKz5YJ+JjvLCIiLTKxNpZWItFoctBUZU=;
	b=U94JTQ2EnLmK0CwTfN4kj2E9L6mu4wTC9cGvKCdNKKk1KYFHyJZlrpo8cmSxwfQnMyHK
	 iiHNhDK0w7ZrqfVkLfLhjlQ1vfT4OHKmYNb8gfSuPDj5yHShDslYHMTRMM0WGxtX5QgXY
	 9SLCes9UckXCT2vzFxgQsS1Na2GpwvCX2NBhF34BqWejzp77DBsOm0Pulxa8Lho11pmsl
	 EmA/mGXNFoyVUoIJi0CV3HhOW30Dl0OLk2SIabERBSbBOZ/5/VDmI4VVUC1Xr6q7QOzcz
	 0FhwgFmbFGfDnmC8mk6IAdYj+ddiVWPAPaefM+xc4gCSTuktGuNvO6TOfcK8rnTsahA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gGcu5db1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F501606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gGcu5db1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8456C1F000C6;
	Thu, 26 Nov 2026 04:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795668427;
	bh=Y00TdBClThxfKz5YJ+JjvLCIiLTKxNpZWItFoctBUZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gGcu5db1T6hR7A0F1RdrSchctRbv2Wd7WT5NwnZUCJMG6Tov06VU28vkFqcYZksHL
	 c0d8L7aN6QiCVc4n3JPIIzIFpheQXODQa0cKU+9iztVsHYNkSWNQOTPNL1zg8I6PAP
	 1rVJUQwCWaODm8uZETYkr9LDcK0d76Kqk2eUaBduwq4wlc11fJ4pFXrBWWv0td+qN7
	 fPA0LvRCkTYJU33FEAUzR6obqSN52V+H4ZwtqQmOTj0nH09tbIhPoO2POXbxLJcErl
	 bfkPn6vgIOkgZnDKaSCXNiJ+g+oaIyVsf4ev4Fq89GicASYLzco4zdAZhhHLOY6hTp
	 JqRNXUhCjMTlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/5] smb: client: don't fail writeback preparation if the task is dying
Date: Wed, 25 Nov 2026 23:46:59 -0500
Message-ID: <20261126044608.1960941-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126044608.1960941-1-sashal@kernel.org>
References: <2026112529-flatly-mammal-3d12@gregkh>
 <20261126044608.1960941-1-sashal@kernel.org>
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
Stable-dep-of: 9bd8ee0c1614 ("smb: client: don't replay handle reopens inside SMB2_open()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h |  1 +
 fs/smb/client/file.c     | 37 ++++++++++++++++++++++++++++++-------
 2 files changed, 31 insertions(+), 7 deletions(-)

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
index 4da53f84196f1..2246716ced9db 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -129,12 +129,17 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
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
@@ -143,10 +148,17 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
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

