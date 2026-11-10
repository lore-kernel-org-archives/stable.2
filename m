Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326551;
	b=Pdh3Wfia2id5bkR3Hefsir/Gy1d6mCPwnYxu+AzJG/uxgDh6BV7aG4x2OIIS/gWsK15v
	 Cswo/18kMBaH42UnyAtU/dubOG95cU2khkUIkg19VbM9sKbWg7jQT2P/itwUDUhaRpaPc
	 baPiPLhMCXoZAFyTvIGQh8h7RKYO/hUL8wPAR9FQ1h2xIF4LzLRNLoo+Gpqj6UfnIzEmG
	 3uTk69c14eUkyh4Lt/T1PCty3W9/tY8ReiIlnOFvc7XFjqrHNXOBGpq//r6CiS3zSrds0
	 OaCfXCUX88ZNI688EBlxvevJCrgxgkrOMsM5rB7hnQKGc1oVtxYmo+MCveWdPdP3zlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326551;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5zlBQsCEdTTul3aN3PEWw7tbbm8ClwVf24QzTH8myhA=;
	b=ZoUOVbfZrGZ1fhY++G0gYGNHZVZk/ssbH6iWCH8bK28AYys/7z9P2fVcCvrn9U682iYK
	 l8E0jYQjmH4buQNJPr+aJhzjdO8ygM4RISE+vbw1KiRT/ccsbRMG4ykIlob3Nj7Mz53PC
	 yRM2jtSn2Kr+gdtLCYISI2ysP3ltDpwAbkqMZXtxNEBg2sZ/yNBvg5FKAWKES1IsuFopg
	 auFQoIN6fSup70YEW7UH6lOOeWkUNCGZdSoYCCSJHvjaTD7hRHvZCODaD+7fzfT6dzfPh
	 Wwz/KcASZdvhBK2HfCOp7Ti9wAndXs3r03HPwYwZF7hQlN7qivh6uNZrcLZOc0HJ/bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZuZlAWs2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3489B606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZuZlAWs2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B80E1F008A2;
	Tue, 10 Nov 2026 16:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326548;
	bh=5zlBQsCEdTTul3aN3PEWw7tbbm8ClwVf24QzTH8myhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZuZlAWs2xGJwYy3w3ApKDoiunglrdfZtZCVVbTZ2GJFq/l5LhsTp+2/JjQt+4LIOu
	 w/hm0Y2Z0TD95OY4NXoLgpF6Iu0S9F67/vUNyvXzkAOiOiD8y6Y6mASo7glD8UqW4y
	 jqNtefpNt8ulg08yZq42A/IlLm4X5YhK1S73ATHjxms28IUD7PGmPl9WzmxOjFrVTq
	 BqcLzDaQ0IX+RQtI0WERdgcnH8FEeFu7T7ARMnEkFsM3dK/zjc4GLUTIAkLVPVYIip
	 vkiGLdQq5IrfAQS1uRBM/5vANDkhYg0dFpExOyvBXBsv+B+aBebPPiFwhHP3V3bwcX
	 l22HLqbx5aYgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] sctp: re-point retained control chunks on association migration
Date: Tue, 10 Nov 2026 11:02:25 -0500
Message-ID: <20261110160216.2383568-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110160216.2383568-1-sashal@kernel.org>
References: <20261107052316-failed-6.12-52ffeaa358d1@kernel.org>
 <20261110160216.2383568-1-sashal@kernel.org>
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

From: Jun Yang <junvyyang@tencent.com>

[ Upstream commit 52ffeaa358d1f3d91aa87a26ad90d77769cff74b ]

sctp_sock_migrate() transfers DATA chunk ownership but leaves retained
control chunks pointing at the old socket. A later retransmission can
therefore access the socket after it has been freed.

Extend the migration walk to cover retained control chunks and use
sctp_control_set_owner_w() to assign their new owner. Reuse the DATA
ownership check so each chunk is processed once per pass, even when it
is reachable through multiple lists or retained pointers.

Preserve a control chunk's existing authentication key across migration
so its final release can still generate SCTP_AUTH_FREE_KEY when needed.

Fixes: d04adf1b3551 ("sctp: reset owner sk for data chunks on out queues when migrating a sock")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Signed-off-by: Jun Yang <junvyyang@tencent.com>
Acked-by: Xin Long <lucien.xin@gmail.com>
Link: https://patch.msgid.link/20261009074244.3718-3-juny24602@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sctp/sm.h    |  1 +
 net/sctp/sm_make_chunk.c |  5 ++--
 net/sctp/socket.c        | 53 ++++++++++++++++++++++++++++++----------
 3 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/include/net/sctp/sm.h b/include/net/sctp/sm.h
index 64c42bd56bb24..84e71381e19bc 100644
--- a/include/net/sctp/sm.h
+++ b/include/net/sctp/sm.h
@@ -253,6 +253,7 @@ struct sctp_chunk *sctp_make_fwdtsn(const struct sctp_association *asoc,
 				    struct sctp_fwdtsn_skip *skiplist);
 struct sctp_chunk *sctp_make_auth(const struct sctp_association *asoc,
 				  __u16 key_id);
+void sctp_control_set_owner_w(struct sctp_chunk *chunk);
 struct sctp_chunk *sctp_make_strreset_req(const struct sctp_association *asoc,
 					  __u16 stream_num, __be16 *stream_list,
 					  bool out, bool in);
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 6d0df43e08a86..6dae9831613ab 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -95,7 +95,7 @@ static void sctp_control_release_owner(struct sk_buff *skb)
 	}
 }
 
-static void sctp_control_set_owner_w(struct sctp_chunk *chunk)
+void sctp_control_set_owner_w(struct sctp_chunk *chunk)
 {
 	struct sctp_association *asoc = chunk->asoc;
 	struct sk_buff *skb = chunk->skb;
@@ -108,7 +108,8 @@ static void sctp_control_set_owner_w(struct sctp_chunk *chunk)
 	 *  For now don't do anything for now.
 	 */
 	if (chunk->auth) {
-		chunk->shkey = asoc->shkey;
+		if (!chunk->shkey)
+			chunk->shkey = asoc->shkey;
 		sctp_auth_shkey_hold(chunk->shkey);
 	}
 	skb->sk = asoc ? asoc->base.sk : NULL;
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 3d45188488b97..7734ca92335aa 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -157,9 +157,24 @@ static void sctp_clear_owner_w(struct sctp_chunk *chunk)
 
 static void sctp_set_owner_w_migrate(struct sctp_chunk *chunk)
 {
-	sctp_set_owner_w(chunk);
-	if (chunk->shkey)
-		sctp_auth_shkey_release(chunk->shkey);
+	struct sctp_shared_key *shkey = chunk->shkey;
+
+	if (chunk->msg)
+		sctp_set_owner_w(chunk);
+	else
+		sctp_control_set_owner_w(chunk);
+
+	if (shkey)
+		sctp_auth_shkey_release(shkey);
+}
+
+static void sctp_process_tx_chunk(struct sctp_association *asoc,
+				  struct sctp_chunk *chunk, bool clear,
+				  void (*cb)(struct sctp_chunk *))
+{
+	if ((clear && asoc->base.sk == chunk->skb->sk) ||
+	    (!clear && asoc->base.sk != chunk->skb->sk))
+		cb(chunk);
 }
 
 #define traverse_and_process()	\
@@ -167,17 +182,14 @@ do {				\
 	msg = chunk->msg;	\
 	if (msg == prev_msg)	\
 		continue;	\
-	list_for_each_entry(c, &msg->chunks, frag_list) {	\
-		if ((clear && asoc->base.sk == c->skb->sk) ||	\
-		    (!clear && asoc->base.sk != c->skb->sk))	\
-			cb(c);	\
-	}			\
+	list_for_each_entry(c, &msg->chunks, frag_list)	\
+		sctp_process_tx_chunk(asoc, c, clear, cb);	\
 	prev_msg = msg;		\
 } while (0)
 
-static void sctp_for_each_tx_datachunk(struct sctp_association *asoc,
-				       bool clear,
-				       void (*cb)(struct sctp_chunk *))
+static void sctp_for_each_tx_chunk(struct sctp_association *asoc,
+				   bool clear,
+				   void (*cb)(struct sctp_chunk *))
 
 {
 	struct sctp_datamsg *msg, *prev_msg = NULL;
@@ -200,6 +212,21 @@ static void sctp_for_each_tx_datachunk(struct sctp_association *asoc,
 
 	list_for_each_entry(chunk, &q->out_chunk_list, list)
 		traverse_and_process();
+
+	list_for_each_entry(chunk, &q->control_chunk_list, list)
+		sctp_process_tx_chunk(asoc, chunk, clear, cb);
+
+	list_for_each_entry(chunk, &asoc->asconf_ack_list, transmitted_list)
+		sctp_process_tx_chunk(asoc, chunk, clear, cb);
+
+	list_for_each_entry(chunk, &asoc->addip_chunk_list, list)
+		sctp_process_tx_chunk(asoc, chunk, clear, cb);
+
+	if (asoc->strreset_chunk)
+		sctp_process_tx_chunk(asoc, asoc->strreset_chunk, clear, cb);
+
+	if (asoc->addip_last_asconf)
+		sctp_process_tx_chunk(asoc, asoc->addip_last_asconf, clear, cb);
 }
 
 static void sctp_for_each_rx_skb(struct sctp_association *asoc, struct sock *sk,
@@ -9715,9 +9742,9 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
 	 * paths won't try to lock it and then oldsk.
 	 */
 	lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
-	sctp_for_each_tx_datachunk(assoc, true, sctp_clear_owner_w);
+	sctp_for_each_tx_chunk(assoc, true, sctp_clear_owner_w);
 	sctp_assoc_migrate(assoc, newsk);
-	sctp_for_each_tx_datachunk(assoc, false, sctp_set_owner_w_migrate);
+	sctp_for_each_tx_chunk(assoc, false, sctp_set_owner_w_migrate);
 
 	/* If the association on the newsk is already closed before accept()
 	 * is called, set RCV_SHUTDOWN flag.
-- 
2.53.0

