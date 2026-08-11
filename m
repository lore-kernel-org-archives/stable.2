Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5937632720C
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 11:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447063; cv=none; b=OSjYT5U8I+waN8K7CcLvfhhKXwPHoUapAEyx4tdOsi2glVC8vZkj6W60JVsP+qKC7r30jOKfZEiLksd2vUxVpXN0/bJcM4Q6OcG2kzw+yw+qZpR8rJjellxiRPteG7YCjAcNqLaPUbfrFWyn5O5HHG8nbpr6RtXO+H4Dkep0RA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447063; c=relaxed/simple;
	bh=eHrd4nCROh7Tnz3oDqv0IoboJyP6GzfH89dg3VQrYU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKf/2G0MoNOzjUmpStsXn/F1B8XnFGlBEpnYquMUIOw/GMW4V/rAYqzreXLodKzZY706eiUBVRKuzUXk+uzV3634eeN2ZvubSgR0tbOGDAI5O4k36FHFuePFxpO4LLxT90aehHyF3w7i3YJeaA5jrH72gsc4Vjcyep993TVv8qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bge97z3S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bge97z3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B12C1F00A3A;
	Tue, 11 Aug 2026 11:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786447062;
	bh=FCW4aGiyhDr78aSSlXKQBDxoZ7TR+HXJQzOmL7Mb0rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bge97z3SfQmSicpG30m34FaQ927ChlJ19z2w5kV+GlJifB55Z68bMuyMvZRLHmVbv
	 tGoAUvh/Ncrh8s6ZvFvOgXLdEPjoK0z3f5lwzuNXTYktPke5629K+i9Ny0QlC7vLvZ
	 QYObPlY7HEhlDvGtS/IHX0nwUVMaZbIwwHiUhAIJdpVU8Sa7vciFfxJHmg7WtXgLO1
	 WfCJvoqt1l7I5HUqjzqbwSoewJzPkLhHDGUND/z6dnFMQGhu+5L+1qoGUmhiXDcHPd
	 4vhW/2cKIeOTuG7LM9I7A+j+C9SSK2lHqIA4HhDPLGJdtKPavFHHhyWf06tFOh5Rb1
	 UMNFj8l2Pv26A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Runa Takemoto <takemotoruna223@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ksmbd: reject repeated SMB2 NEGOTIATE requests
Date: Tue, 11 Aug 2026 07:17:38 -0400
Message-ID: <20260811111738.2260355-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811111738.2260355-1-sashal@kernel.org>
References: <2026080542-stadium-unbaked-f538@gregkh>
 <20260811111738.2260355-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit cb469993b3a61a72653770856d37af616d72d05f ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/connection.h |  5 +++++
 fs/smb/server/smb2pdu.c    | 10 ++--------
 fs/smb/server/smb_common.c | 37 ++++++++++++++++++++++++++++++-------
 3 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
index 26e6204ef93e0..8728899d5e756 100644
--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -195,6 +195,11 @@ void ksmbd_conn_r_count_dec(struct ksmbd_conn *conn);
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
index 180ce5bd1e2a4..23f3d7e5915d5 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1101,6 +1101,8 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
  * smb2_handle_negotiate() - handler for smb2 negotiate command
  * @work:	smb work containing smb request buffer
  *
+ * The caller holds conn->srv_mutex.
+ *
  * Return:      0
  */
 int smb2_handle_negotiate(struct ksmbd_work *work)
@@ -1114,13 +1116,6 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 
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
@@ -1271,7 +1266,6 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 	ksmbd_conn_set_need_setup(conn);
 
 err_out:
-	ksmbd_conn_unlock(conn);
 	if (rc)
 		rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
 
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index a29c0494dccb4..f2fe8fc128d63 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -592,23 +592,46 @@ int ksmbd_smb_negotiate_common(struct ksmbd_work *work, unsigned int command)
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
-- 
2.53.0

