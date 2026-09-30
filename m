Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCD365192
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791930; cv=none; b=J7hzZriwCFbOLY8iNHiTGS6m0vUUH8MntGAB2eidlHBuwsPVHIhLY7K18kutQVyFtYLFUpbRBiftEKwauEx4tNWeeJszYrmKxxbdCw2jAiPPFkEPufBtpobBRugK2ScAAfXWbp3wFjPwyS5dWumrh8YYOFKHJLyss0BSkut72UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791930; c=relaxed/simple;
	bh=owhhts90lhWd2+KEpecKboqpm3bsKYyM0jex3Dz97xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbM8SkLIYUoo42sQz8bhs7QihoTo+z2zWA0rqO/RIVfh1Dn1ZBHnk/LPIzqu1lEcfl9HaGK0uxLlrcq5lbbiul2lZnvHiL4Oi3i9367Lf8+r+WZYFh+XCN3YVaHDHsiw0GS0z7T6wDETzjb94UuuoFdnL9NuRXLrI0ur1caTvn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyIhmpAa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyIhmpAa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D826B1F00898;
	Wed, 30 Sep 2026 18:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790791928;
	bh=tz7Q+RB1gF9Ii56MCZi7OzqPhFXXwz7IMjn062gok7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oyIhmpAaw9ft0jCE8LbvyH6mrJwKScHGqEcuTlBnK+waC+Ty2GgNpPOLVW7p+pM/r
	 kgBGlNG39H2glqjIpCG3L+1XZ2M2mNtMZW7bASc5mCeN5DddpZBAhohkCL6wExt6hu
	 l7iUWQd33ispGUfHRmywi2hLkcFJPt8z+NWnXfZMcNTpfUebHr3DyOsnyIUhu96WDD
	 YWKMdZVTkALcHMV0F+Qv7LvPlylqgX75wKJes2/vHU8GsdB9yxITtxwYula3mg/YtX
	 dWcVIDhWEa+CyvvKpFt/5DMVddiyDO57Ab9zVlRUUNkMYl/DIgc4wTGqY1vVz7ZRQu
	 H+0ntIuLdh+Qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Frank Sorenson <sorenson@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] smb: client: close completed creates on compound wait errors
Date: Wed, 30 Sep 2026 14:12:06 -0400
Message-ID: <20260930181206.4113309-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092948-ethically-applause-6d04@gregkh>
References: <2026092948-ethically-applause-6d04@gregkh>
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
[ replaced the upstream cancellation helper with inline loops using midQ and MID_WAIT_CANCELLED under server->mid_lock. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2misc.c  |  9 +++--
 fs/smb/client/transport.c | 69 ++++++++++++++++++++++++++++++---------
 2 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index 6fa23cf7a529e..e37fe2d3b4092 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -818,7 +818,8 @@ smb2_cancelled_close_fid(struct work_struct *work)
  */
 static int
 __smb2_handle_cancelled_cmd(struct cifs_tcon *tcon, __u16 cmd, __u64 mid,
-			    __u64 persistent_fid, __u64 volatile_fid)
+			    __u64 persistent_fid, __u64 volatile_fid,
+			    bool account_remote_open)
 {
 	struct close_cancelled_open *cancelled;
 
@@ -832,6 +833,8 @@ __smb2_handle_cancelled_cmd(struct cifs_tcon *tcon, __u16 cmd, __u64 mid,
 	cancelled->cmd = cmd;
 	cancelled->mid = mid;
 	INIT_WORK(&cancelled->work, smb2_cancelled_close_fid);
+	if (account_remote_open)
+		atomic_inc(&tcon->num_remote_opens);
 	WARN_ON(queue_work(cifsiod_wq, &cancelled->work) == false);
 
 	return 0;
@@ -868,7 +871,7 @@ smb2_handle_cancelled_close(struct cifs_tcon *tcon, __u64 persistent_fid,
 	spin_unlock(&tcon->tc_lock);
 
 	rc = __smb2_handle_cancelled_cmd(tcon, SMB2_CLOSE_HE, 0,
-					 persistent_fid, volatile_fid);
+					 persistent_fid, volatile_fid, false);
 	if (rc)
 		cifs_put_tcon(tcon, netfs_trace_tcon_ref_put_cancelled_close);
 
@@ -896,7 +899,7 @@ smb2_handle_cancelled_mid(struct mid_q_entry *mid, struct TCP_Server_Info *serve
 					 le16_to_cpu(hdr->Command),
 					 le64_to_cpu(hdr->MessageId),
 					 rsp->PersistentFileId,
-					 rsp->VolatileFileId);
+					 rsp->VolatileFileId, true);
 	if (rc)
 		cifs_put_tcon(tcon, netfs_trace_tcon_ref_put_cancelled_mid);
 
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index a47242a0f5c6d..1f5174bd27408 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1081,6 +1081,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		   int *resp_buf_type, struct kvec *resp_iov)
 {
 	int i, j, optype, rc = 0;
+	int num_processed = 0;
 	struct mid_q_entry *midQ[MAX_COMPOUND];
 	bool cancelled_mid[MAX_COMPOUND] = {false};
 	struct cifs_credits credits[MAX_COMPOUND] = {
@@ -1223,6 +1224,17 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 			break;
 	}
 	if (rc != 0) {
+		/*
+		 * A completed CREATE earlier in the compound chain may have
+		 * opened a remote handle even though a later wait was
+		 * interrupted. Mark it cancelled so __release_mid() invokes
+		 * the existing unmatched-open cleanup.
+		 */
+		spin_lock(&server->mid_lock);
+		for (j = 0; j < i; j++)
+			midQ[j]->mid_flags |= MID_WAIT_CANCELLED;
+		spin_unlock(&server->mid_lock);
+
 		for (; i < num_rqst; i++) {
 			cifs_server_dbg(FYI, "Cancelling wait for mid %llu cmd: %d\n",
 				 midQ[i]->mid, le16_to_cpu(midQ[i]->command));
@@ -1245,6 +1257,17 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 
 		rc = cifs_sync_mid_result(midQ[i], server);
 		if (rc != 0) {
+			/*
+			 * A previous CREATE may have completed before this
+			 * response failed. Mark it cancelled so its remote
+			 * handle is closed when the mid is released.
+			 */
+			spin_lock(&server->mid_lock);
+			for (j = 0; j < i; j++)
+				midQ[j]->mid_flags |= MID_WAIT_CANCELLED;
+			spin_unlock(&server->mid_lock);
+			/* Keep their response buffers for cancelled-mid cleanup. */
+			num_processed = 0;
 			/* mark this mid as cancelled to not free it below */
 			cancelled_mid[i] = true;
 			goto out;
@@ -1254,9 +1277,26 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		    midQ[i]->mid_state != MID_RESPONSE_READY) {
 			rc = -EIO;
 			cifs_dbg(FYI, "Bad MID state?\n");
+			spin_lock(&server->mid_lock);
+			for (j = 0; j < i; j++)
+				midQ[j]->mid_flags |= MID_WAIT_CANCELLED;
+			spin_unlock(&server->mid_lock);
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
@@ -1267,33 +1307,30 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		else
 			resp_buf_type[i] = CIFS_SMALL_BUFFER;
 
-		rc = server->ops->check_receive(midQ[i], server,
-						     flags & CIFS_LOG_ERROR);
-
 		/* mark it so buf will not be freed by delete_mid */
 		if ((flags & CIFS_NO_RSP_BUF) == 0)
 			midQ[i]->resp_buf = NULL;
-
 	}
 
 	/*
 	 * Compounding is never used during session establish.
 	 */
-	spin_lock(&ses->ses_lock);
-	if ((ses->ses_status == SES_NEW) || (optype & CIFS_NEG_OP) || (optype & CIFS_SESS_OP)) {
-		struct kvec iov = {
-			.iov_base = resp_iov[0].iov_base,
-			.iov_len = resp_iov[0].iov_len
-		};
-		spin_unlock(&ses->ses_lock);
-		cifs_server_lock(server);
-		smb311_update_preauth_hash(ses, server, &iov, 1);
-		cifs_server_unlock(server);
+	if (num_processed == num_rqst) {
 		spin_lock(&ses->ses_lock);
+		if ((ses->ses_status == SES_NEW) || (optype & CIFS_NEG_OP) || (optype & CIFS_SESS_OP)) {
+			struct kvec iov = {
+				.iov_base = resp_iov[0].iov_base,
+				.iov_len = resp_iov[0].iov_len
+			};
+			spin_unlock(&ses->ses_lock);
+			cifs_server_lock(server);
+			smb311_update_preauth_hash(ses, server, &iov, 1);
+			cifs_server_unlock(server);
+			spin_lock(&ses->ses_lock);
+		}
+		spin_unlock(&ses->ses_lock);
 	}
-	spin_unlock(&ses->ses_lock);
 
-out:
 	/*
 	 * This will dequeue all mids. After this it is important that the
 	 * demultiplex_thread will not process any of these mids any futher.
-- 
2.53.0

