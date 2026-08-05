Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AED3BBFA4
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923286; cv=none; b=mmjFamyntpIlZmo7WFzK9CwATfItNeMtJJX/wxbxsvoaEOK+9/yO76WWk9DhHh+JunT7gFpnPoBwwYFQvviVQM9eFfbY1MVH/wWkounUmTc8eS+2d0no4AoP+lqrAS3gjm8ubI1jaTGBQa1WtDYQbwg8oKM1IvRFH4tVz4VAY7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923286; c=relaxed/simple;
	bh=ibwRjHdef3PM4dUI9Q5w1+TAZE+r+Hk1RvzCT/GGV9Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=R9QGEXiWUWEVug1U/P4+Z1XA9S4lG4/XW58yvWZCypkww/DHlOephKM/VGU1RTnl//aTr2c05SCnVdtH4/cgLNmUn6HK4zo3GlWtuhSZoAB1qCs2X+Q3YGLOmMOsr2iyQYTdk438/CRqD2T6DVgCgvCgxJE4ydL5czbYejaFfSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RQUHk4/+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RQUHk4/+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBF91F000E9;
	Wed,  5 Aug 2026 09:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785923285;
	bh=rmTQXX4TCTS6ZvtLLF7e/CW/xJ89LMxJGxvjA8uI39c=;
	h=Subject:To:Cc:From:Date;
	b=RQUHk4/+CU7dSKUumaiNTyIOpzVYShV6yKAEP3ZnmJuzH672QgfzyGpJsGysjsDPj
	 kPHNbuBZkDpK1hR7tFGaq1rae4rZy87KDiMK8/XM2E6WXGPUkfYhhLSK4NtJs1Nutq
	 qj+GLEL1o5U45IQodOgPfb/KGjn5BwgktWzNpeYk=
Subject: FAILED: patch "[PATCH] ksmbd: reject repeated SMB2 NEGOTIATE requests" failed to apply to 6.6-stable tree
To: linkinjeon@kernel.org,stfrench@microsoft.com,takemotoruna223@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:47:43 +0200
Message-ID: <2026080543-praising-unhappy-8689@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x cb469993b3a61a72653770856d37af616d72d05f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080543-praising-unhappy-8689@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cb469993b3a61a72653770856d37af616d72d05f Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 23 Jul 2026 23:07:14 +0900
Subject: [PATCH] ksmbd: reject repeated SMB2 NEGOTIATE requests

Unauthenticated client can send multiple successful SMB2 NEGOTIATE
requests on one connection before SESSION_SETUP. While the connection is
in KSMBD_SESS_NEED_SETUP, smb2_handle_negotiate() accepts another
SMB3.1.1 NEGOTIATE and overwrites conn->preauth_info with a new allocation.
Only the final allocation is freed when the connection is released, leaking
one object for every additional successful request.

A repeated SMB2 NEGOTIATE after a dialect has been selected is a protocol
violation. MS-SMB2 section 3.3.5.4 requires the server to disconnect
without replying in this case. Set the connection exiting when rejecting
the request, in addition to suppressing the response.

Reject SMB2 NEGOTIATE unless the connection is new or is waiting for the
SMB2 NEGOTIATE that follows an SMB1 multi-protocol negotiate. Serialize
both SMB1 and SMB2 negotiation paths under conn->srv_mutex, since they
update connection-wide dialect and negotiation state.

Move the locking contract to ksmbd_smb_negotiate_common(), where the state
and dialect are selected, and add ksmbd_conn_new() for consistent state
access.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Reported-by: Runa Takemoto <takemotoruna223@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
index ec75633b7da0..2a194ee36fb4 100644
--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -200,6 +200,11 @@ void ksmbd_conn_r_count_dec(struct ksmbd_conn *conn);
  * This is a hack. We will move status to a proper place once we land
  * a multi-sessions support.
  */
+static inline bool ksmbd_conn_new(struct ksmbd_conn *conn)
+{
+	return READ_ONCE(conn->status) == KSMBD_SESS_NEW;
+}
+
 static inline bool ksmbd_conn_good(struct ksmbd_conn *conn)
 {
 	return READ_ONCE(conn->status) == KSMBD_SESS_GOOD;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index c1ba5e01aa7f..404a4203f7da 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1325,6 +1325,8 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
  * smb2_handle_negotiate() - handler for smb2 negotiate command
  * @work:	smb work containing smb request buffer
  *
+ * The caller holds conn->srv_mutex.
+ *
  * Return:      0
  */
 int smb2_handle_negotiate(struct ksmbd_work *work)
@@ -1338,13 +1340,6 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 
 	ksmbd_debug(SMB, "Received negotiate request\n");
 	conn->need_neg = false;
-	if (ksmbd_conn_good(conn)) {
-		pr_err("conn->tcp_status is already in CifsGood State\n");
-		work->send_no_response = 1;
-		return rc;
-	}
-
-	ksmbd_conn_lock(conn);
 	smb2_buf_len = get_rfc1002_len(work->request_buf);
 	smb2_neg_size = offsetof(struct smb2_negotiate_req, Dialects);
 	if (smb2_neg_size > smb2_buf_len) {
@@ -1495,7 +1490,6 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 	ksmbd_conn_set_need_setup(conn);
 
 err_out:
-	ksmbd_conn_unlock(conn);
 	if (rc)
 		rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
 
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index 7de73223189a..080fbc9eb470 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -608,23 +608,46 @@ int ksmbd_smb_negotiate_common(struct ksmbd_work *work, unsigned int command)
 	struct ksmbd_conn *conn = work->conn;
 	int ret;
 
-	conn->dialect =
-		ksmbd_negotiate_smb_dialect(work->request_buf);
-	ksmbd_debug(SMB, "conn->dialect 0x%x\n", conn->dialect);
-
 	if (command == SMB2_NEGOTIATE_HE) {
+		/*
+		 * An SMB2 NEGOTIATE is valid for a new connection, or after an
+		 * SMB1 multi-protocol negotiate has selected SMB2. Do not allow
+		 * a second SMB2 NEGOTIATE to replace connection-wide state
+		 * while a session setup is pending. KSMBD_SESS_NEED_RECONNECT
+		 * is a transient session state and does not restart transport
+		 * negotiation.
+		 */
+		ksmbd_conn_lock(conn);
+		if (!ksmbd_conn_new(conn) &&
+		    !ksmbd_conn_need_negotiate(conn)) {
+			work->send_no_response = 1;
+			ksmbd_conn_set_exiting(conn);
+			ksmbd_conn_unlock(conn);
+			return 0;
+		}
+
+		conn->dialect =
+			ksmbd_negotiate_smb_dialect(work->request_buf);
+		ksmbd_debug(SMB, "conn->dialect 0x%x\n", conn->dialect);
 		ret = smb2_handle_negotiate(work);
+		ksmbd_conn_unlock(conn);
 		return ret;
 	}
 
 	if (command == SMB_COM_NEGOTIATE) {
+		ksmbd_conn_lock(conn);
+		conn->dialect =
+			ksmbd_negotiate_smb_dialect(work->request_buf);
+		ksmbd_debug(SMB, "conn->dialect 0x%x\n", conn->dialect);
 		if (__smb2_negotiate(conn)) {
 			init_smb3_11_server(conn);
-			init_smb2_neg_rsp(work);
+			ret = init_smb2_neg_rsp(work);
 			ksmbd_debug(SMB, "Upgrade to SMB2 negotiation\n");
-			return 0;
+		} else {
+			ret = smb_handle_negotiate(work);
 		}
-		return smb_handle_negotiate(work);
+		ksmbd_conn_unlock(conn);
+		return ret;
 	}
 
 	pr_err("Unknown SMB negotiation command: %u\n", command);

