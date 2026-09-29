Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B78651992E
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682721; cv=none; b=PDJGaL1zXIv973VvQoLsUjL8HKyFAwYK5iupiXMhLq3b6aC1qCHj8lHPlVGRnZpcrpj1X6Gsm5Cz8xSLH8nXBXrilXLJOOdw2UYggceX5D+s3ouWVcUCbjxHTHCagW1LIeQi3JmFItgXSTXDQaHk8laBEWN+54kasmqNWRcDJzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682721; c=relaxed/simple;
	bh=0Ngl8BXT0eC7JTHEq5oL5EUPZtMFg/8IFHCsN1zrln4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dihP236GDRGI9Qqx9TEs7VnCq5CGrl4encO/6/+qRAebq3agaFenvHn9Nr8txHiAqmZdMNQqqinP7T87TGnq4b2zIzsFEp7WN0Gme11sYg/tymhqoa45VAn4J5JoTenMEcO4EtTvWWt9XHdiKVuSciLCR0fVgVNKKql91d7cQIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uPvppqdN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uPvppqdN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45751F000FF;
	Tue, 29 Sep 2026 11:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682719;
	bh=suZRWOjtvNiLKr4mC3LwNSqREfBuHfJQ+8ynaKW6rEM=;
	h=Subject:To:Cc:From:Date;
	b=uPvppqdNcArlbmyHWWoSTI3y+LX7gCZEzkDB28YIIy6PiBoE30YDKgg6klSMEjpS6
	 xXX/5mpSmyLUc1S1lgePPMpfk6ei0Mk7MsKA6q5xrm2RWqzVdNw3zNYHi4ieevtSTC
	 BdTFyYzbuE9yCadE0pdSVGJHRuMlyJ4kXyL+D24M=
Subject: FAILED: patch "[PATCH] smb: client: close completed creates on compound wait errors" failed to apply to 6.1-stable tree
To: zihanx@nebusec.ai,pc@manguebit.org,root@tr0jan.top,sorenson@redhat.com,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:51:48 +0200
Message-ID: <2026092948-timid-gravel-59a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 6c5c547f037bc18f0b8d0b5db5a648f8f630ce85
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092948-timid-gravel-59a7@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6c5c547f037bc18f0b8d0b5db5a648f8f630ce85 Mon Sep 17 00:00:00 2001
From: Zihan Xi <zihanx@nebusec.ai>
Date: Wed, 16 Sep 2026 15:29:28 +0000
Subject: [PATCH] smb: client: close completed creates on compound wait errors

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

diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 13fe8e3b48f3..ecd7a65cab08 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -1121,7 +1121,7 @@ smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 	struct kvec close_iov;
 	int resp_buftype[2];
 	struct cifs_fid fid;
-	int flags = 0;
+	int flags = CIFS_CP_CREATE_CLOSE_OP;
 	__u8 oplock;
 	int rc;
 
diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index 0cfe60ae42c3..5e5cf92d1eb3 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -834,7 +834,8 @@ smb2_cancelled_close_fid(struct work_struct *work)
  */
 static int
 __smb2_handle_cancelled_cmd(struct cifs_tcon *tcon, __u16 cmd, __u64 mid,
-			    __u64 persistent_fid, __u64 volatile_fid)
+			    __u64 persistent_fid, __u64 volatile_fid,
+			    bool account_remote_open)
 {
 	struct close_cancelled_open *cancelled;
 
@@ -848,6 +849,8 @@ __smb2_handle_cancelled_cmd(struct cifs_tcon *tcon, __u16 cmd, __u64 mid,
 	cancelled->cmd = cmd;
 	cancelled->mid = mid;
 	INIT_WORK(&cancelled->work, smb2_cancelled_close_fid);
+	if (account_remote_open)
+		atomic_inc(&tcon->num_remote_opens);
 	WARN_ON(queue_work(cifsiod_wq, &cancelled->work) == false);
 
 	return 0;
@@ -884,7 +887,7 @@ smb2_handle_cancelled_close(struct cifs_tcon *tcon, __u64 persistent_fid,
 	spin_unlock(&tcon->tc_lock);
 
 	rc = __smb2_handle_cancelled_cmd(tcon, SMB2_CLOSE_HE, 0,
-					 persistent_fid, volatile_fid);
+					 persistent_fid, volatile_fid, false);
 	if (rc)
 		cifs_put_tcon(tcon, netfs_trace_tcon_ref_put_cancelled_close);
 
@@ -912,7 +915,7 @@ smb2_handle_cancelled_mid(struct mid_q_entry *mid, struct TCP_Server_Info *serve
 					 le16_to_cpu(hdr->Command),
 					 le64_to_cpu(hdr->MessageId),
 					 rsp->PersistentFileId,
-					 rsp->VolatileFileId);
+					 rsp->VolatileFileId, true);
 	if (rc)
 		cifs_put_tcon(tcon, netfs_trace_tcon_ref_put_cancelled_mid);
 
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 7df5b3447aea..6e21b5f8754a 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -805,6 +805,18 @@ cifs_cancelled_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	release_mid(server, mid);
 }
 
+static void
+cifs_mark_compound_mids_cancelled(struct mid_q_entry **mid, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		spin_lock(&mid[i]->mid_lock);
+		mid[i]->wait_cancelled = true;
+		spin_unlock(&mid[i]->mid_lock);
+	}
+}
+
 /*
  * cifs_pick_channel - pick an eligible channel for network operations
  *
@@ -865,6 +877,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		   int *resp_buf_type, struct kvec *resp_iov)
 {
 	int i, j, optype, rc = 0;
+	int num_processed = 0;
 	struct mid_q_entry *mid[MAX_COMPOUND];
 	bool cancelled_mid[MAX_COMPOUND] = {false};
 	struct cifs_credits credits[MAX_COMPOUND] = {
@@ -1015,6 +1028,14 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 			break;
 	}
 	if (rc != 0) {
+		/*
+		 * A completed CREATE earlier in the compound chain may have
+		 * opened a remote handle even though a later wait was
+		 * interrupted. Mark it cancelled so __release_mid() invokes
+		 * the existing unmatched-open cleanup.
+		 */
+		cifs_mark_compound_mids_cancelled(mid, i);
+
 		for (; i < num_rqst; i++) {
 			cifs_server_dbg(FYI, "Cancelling wait for mid %llu cmd: %d\n",
 				 mid[i]->mid, le16_to_cpu(mid[i]->command));
@@ -1037,6 +1058,14 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 
 		rc = cifs_sync_mid_result(mid[i], server);
 		if (rc != 0) {
+			/*
+			 * A previous CREATE may have completed before this
+			 * response failed. Mark it cancelled so its remote
+			 * handle is closed when the mid is released.
+			 */
+			cifs_mark_compound_mids_cancelled(mid, i);
+			/* Keep their response buffers for cancelled-mid cleanup. */
+			num_processed = 0;
 			/* mark this mid as cancelled to not free it below */
 			cancelled_mid[i] = true;
 			goto out;
@@ -1046,13 +1075,24 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		    mid[i]->mid_state != MID_RESPONSE_READY) {
 			rc = smb_EIO1(smb_eio_trace_rx_mid_unready, mid[i]->mid_state);
 			cifs_dbg(FYI, "Bad MID state?\n");
+			cifs_mark_compound_mids_cancelled(mid, i);
+			num_processed = 0;
 			goto out;
 		}
 
 		rc = server->ops->check_receive(mid[i], server,
 						flags & CIFS_LOG_ERROR);
+		num_processed = i + 1;
+	}
 
-		if (resp_iov) {
+out:
+	/*
+	 * Delay moving response buffers out of their mids until response
+	 * synchronization completes. This lets cancelled-mid cleanup inspect
+	 * an earlier CREATE response if a later MID fails.
+	 */
+	if (resp_iov) {
+		for (i = 0; i < num_processed; i++) {
 			buf = (char *)mid[i]->resp_buf;
 			resp_iov[i].iov_base = buf;
 			resp_iov[i].iov_len = mid[i]->resp_buf_size;
@@ -1071,21 +1111,22 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
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
 	 * demultiplex_thread will not process any of these mids any further.

