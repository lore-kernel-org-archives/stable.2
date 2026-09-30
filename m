Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA3C489FC7
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790810049; cv=none; b=anwGk/RwwqSXzt2DrY489gLSkJytRNtWt+WiTogHG1ZWB81L077QprgUgKIJ7yTYUT/vk9q1r6jqKSiJi1Zkggr0x1izqzjz3nugy8oDB81qy2wTiloLOZG4QtIdfXypCjO4+MZrPi6oiw9Af5jEPYX9koWz9C0wNaIxWM6vOuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790810049; c=relaxed/simple;
	bh=ldJuZrkBukxeVXGSwh5VYrG2vuFeoMrqRtrDXHGnq04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvcDKJ7DlUMDuFST7U2VxqvTLOM5y4owjCDueuj29JmB3oEDkg+dxvhVyyI02Z7BG1GwR/VqcEc6Q0LffrS7flC5qEaXL3iX657O3wQuKbOuR2m4s7vLlH0q2o0om08SOjePAeYQS3ymAcMoqeZSdZpOMwGEHyi3zfYU8eDPrxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8c7SH/f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8c7SH/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8631F1F000FF;
	Wed, 30 Sep 2026 23:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790810039;
	bh=Mom0QZHK8bcO27Gk0qAjg8e43Gvg7uUGxCEdSfwuNlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q8c7SH/fKUzPA1y2y6lsv0T0cpD/2VZ090fBcoEUg6mMEQ++t6lGRn3vKq4UXb24K
	 YTi4f9/w43Hdwo5sJ5mL4Fzbn48AmUw2QgszJQZpzZYmL3i155oFFl1LFlr04JYo5D
	 GNZciK3byl6ORb2/+VMl6efD139byWyRgEmPxrHzi09pFhXcanWKj4dPyS0DeonuXS
	 Y49M2NflH8wYC1h6xHuP/oqhQYQpsWY1jjPqMaGwZWqTzBS6Ipd/Y/wpAoGwVtai1I
	 KBc6Ajp8wYbq4Hv3fyBmrPScWXQRBkimsTYUzEctWZkltE/DuSKtGUlJ3tR1V7W1mW
	 w71TEhCjsXE2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Frank Sorenson <sorenson@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: close completed creates on compound wait errors
Date: Wed, 30 Sep 2026 19:13:56 -0400
Message-ID: <20260930231356.593615-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092949-marsupial-detention-0d9e@gregkh>
References: <2026092949-marsupial-detention-0d9e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

[ Upstream commit 6c5c547f037bc18f0b8d0b5db5a648f8f630ce85 ]

compound_send_recv() waits for responses in order. If a later wait is
interrupted, or if a later MID fails during response synchronization, an
earlier CREATE may already have opened a remote handle. The earlier mid
is then released without invoking handle_cancelled_mid(), leaving the
remote handle open because no FID was copied to the caller.

Mark completed earlier mids as cancelled when a compound wait or MID
synchronization aborts. Keep their response buffers attached while the
MIDs are synchronized, and transfer them only after synchronization of
the processed responses, so the release path can inspect successful
CREATE responses and queue SMB2_close() after a later failure. Account for
a remote open only after the close work is allocated and before it is
queued, since the caller has not yet updated num_remote_opens. Mark the
create+close compound used by smb2_unlink() so it is not closed again.
Non-CREATE responses and compounds that already include a close keep their
existing behavior.

Fixes: e0bba0b85481 ("cifs: add compound_send_recv()")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Tested-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ adapted MID cancellation to use MID_WAIT_CANCELLED with GlobalMid_Lock. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2misc.c  |  9 ++++---
 fs/cifs/transport.c | 62 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index c8171dc04bf43..40c7e4fac055c 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -787,7 +787,8 @@ smb2_cancelled_close_fid(struct work_struct *work)
  */
 static int
 __smb2_handle_cancelled_cmd(struct cifs_tcon *tcon, __u16 cmd, __u64 mid,
-			    __u64 persistent_fid, __u64 volatile_fid)
+			    __u64 persistent_fid, __u64 volatile_fid,
+			    bool account_remote_open)
 {
 	struct close_cancelled_open *cancelled;
 
@@ -801,6 +802,8 @@ __smb2_handle_cancelled_cmd(struct cifs_tcon *tcon, __u16 cmd, __u64 mid,
 	cancelled->cmd = cmd;
 	cancelled->mid = mid;
 	INIT_WORK(&cancelled->work, smb2_cancelled_close_fid);
+	if (account_remote_open)
+		atomic_inc(&tcon->num_remote_opens);
 	WARN_ON(queue_work(cifsiod_wq, &cancelled->work) == false);
 
 	return 0;
@@ -837,7 +840,7 @@ smb2_handle_cancelled_close(struct cifs_tcon *tcon, __u64 persistent_fid,
 	spin_unlock(&cifs_tcp_ses_lock);
 
 	rc = __smb2_handle_cancelled_cmd(tcon, SMB2_CLOSE_HE, 0,
-					 persistent_fid, volatile_fid);
+					 persistent_fid, volatile_fid, false);
 	if (rc)
 		cifs_put_tcon(tcon, netfs_trace_tcon_ref_put_cancelled_close);
 
@@ -865,7 +868,7 @@ smb2_handle_cancelled_mid(struct mid_q_entry *mid, struct TCP_Server_Info *serve
 					 le16_to_cpu(hdr->Command),
 					 le64_to_cpu(hdr->MessageId),
 					 rsp->PersistentFileId,
-					 rsp->VolatileFileId);
+					 rsp->VolatileFileId, true);
 	if (rc)
 		cifs_put_tcon(tcon, netfs_trace_tcon_ref_put_cancelled_mid);
 
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index 65a225a9c6cf8..3fd6576be7ff3 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -1065,6 +1065,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		   int *resp_buf_type, struct kvec *resp_iov)
 {
 	int i, j, optype, rc = 0;
+	int num_processed = 0;
 	struct mid_q_entry *midQ[MAX_COMPOUND];
 	bool cancelled_mid[MAX_COMPOUND] = {false};
 	struct cifs_credits credits[MAX_COMPOUND] = {
@@ -1198,6 +1199,17 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 			break;
 	}
 	if (rc != 0) {
+		/*
+		 * A completed CREATE earlier in the compound chain may have
+		 * opened a remote handle even though a later wait was
+		 * interrupted. Mark it cancelled so _cifs_mid_q_entry_release()
+		 * invokes the existing unmatched-open cleanup.
+		 */
+		spin_lock(&GlobalMid_Lock);
+		for (j = 0; j < i; j++)
+			midQ[j]->mid_flags |= MID_WAIT_CANCELLED;
+		spin_unlock(&GlobalMid_Lock);
+
 		for (; i < num_rqst; i++) {
 			cifs_server_dbg(FYI, "Cancelling wait for mid %llu cmd: %d\n",
 				 midQ[i]->mid, le16_to_cpu(midQ[i]->command));
@@ -1220,6 +1232,17 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 
 		rc = cifs_sync_mid_result(midQ[i], server);
 		if (rc != 0) {
+			/*
+			 * A previous CREATE may have completed before this
+			 * response failed. Mark it cancelled so its remote
+			 * handle is closed when the mid is released.
+			 */
+			spin_lock(&GlobalMid_Lock);
+			for (j = 0; j < i; j++)
+				midQ[j]->mid_flags |= MID_WAIT_CANCELLED;
+			spin_unlock(&GlobalMid_Lock);
+			/* Keep their response buffers for cancelled-mid cleanup. */
+			num_processed = 0;
 			/* mark this mid as cancelled to not free it below */
 			cancelled_mid[i] = true;
 			goto out;
@@ -1229,9 +1252,26 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		    midQ[i]->mid_state != MID_RESPONSE_READY) {
 			rc = -EIO;
 			cifs_dbg(FYI, "Bad MID state?\n");
+			spin_lock(&GlobalMid_Lock);
+			for (j = 0; j < i; j++)
+				midQ[j]->mid_flags |= MID_WAIT_CANCELLED;
+			spin_unlock(&GlobalMid_Lock);
+			num_processed = 0;
 			goto out;
 		}
 
+		rc = server->ops->check_receive(midQ[i], server,
+						     flags & CIFS_LOG_ERROR);
+		num_processed = i + 1;
+	}
+
+out:
+	/*
+	 * Delay moving response buffers out of their mids until response
+	 * synchronization completes. This lets cancelled-mid cleanup inspect
+	 * an earlier CREATE response if a later MID fails.
+	 */
+	for (i = 0; i < num_processed; i++) {
 		buf = (char *)midQ[i]->resp_buf;
 		resp_iov[i].iov_base = buf;
 		resp_iov[i].iov_len = midQ[i]->resp_buf_size +
@@ -1242,9 +1282,6 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		else
 			resp_buf_type[i] = CIFS_SMALL_BUFFER;
 
-		rc = server->ops->check_receive(midQ[i], server,
-						     flags & CIFS_LOG_ERROR);
-
 		/* mark it so buf will not be freed by cifs_delete_mid */
 		if ((flags & CIFS_NO_RSP_BUF) == 0)
 			midQ[i]->resp_buf = NULL;
@@ -1254,17 +1291,18 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	/*
 	 * Compounding is never used during session establish.
 	 */
-	if ((ses->status == CifsNew) || (optype & CIFS_NEG_OP) || (optype & CIFS_SESS_OP)) {
-		struct kvec iov = {
-			.iov_base = resp_iov[0].iov_base,
-			.iov_len = resp_iov[0].iov_len
-		};
-		mutex_lock(&server->srv_mutex);
-		smb311_update_preauth_hash(ses, &iov, 1);
-		mutex_unlock(&server->srv_mutex);
+	if (num_processed == num_rqst) {
+		if ((ses->status == CifsNew) || (optype & CIFS_NEG_OP) || (optype & CIFS_SESS_OP)) {
+			struct kvec iov = {
+				.iov_base = resp_iov[0].iov_base,
+				.iov_len = resp_iov[0].iov_len
+			};
+			mutex_lock(&server->srv_mutex);
+			smb311_update_preauth_hash(ses, &iov, 1);
+			mutex_unlock(&server->srv_mutex);
+		}
 	}
 
-out:
 	/*
 	 * This will dequeue all mids. After this it is important that the
 	 * demultiplex_thread will not process any of these mids any futher.
-- 
2.53.0

