Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327483;
	b=Ow4jXNeSj5QglE+7AGjyyezKHN6WQGaHyAvdaUsEPU6fWA1mNmxm/L2Nzl2OcUrvCSzL
	 CV6d2o7MNiHJdXP464Rfgb9VR6e3o7qPd8LiTdGjVGKpvPWCZICcRUcu+cTb1A9MGtwpG
	 i2Jgqio5gQI1RsuxIUzNY5m9jyxom3AvDxlMBJ0zQbkLa6JjrbRnhpbde5gs0fk022NJV
	 wLipMJpqZDxkuZHX4Khh7x69p9lMpBcB1jMqKV/A8Dzs/ERIWVfd0JdRB6tNTFzH+CMEY
	 mOE6vy74FHhGaZHoJrNsitk+CdEWOwkHBr92PjJlAe3NEVJ6C+guqQV0UYkwXhZnC7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327483;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HhpLu8eWf+ICJ9bh4uJ6YZbGT2bSYXGUTLkSlY6c4js=;
	b=wzIMlZ9jvEKj5v8VMbVmkABAMkOmJ/zZ39YZwOHyweL7TKHWDaHAbCzcw8C0/e+PTD9X
	 Ox/Sa+JzRCpdm1W7nRisxkS+x6KT7dyZTKzfYFKXxJV4jTMY/yoRR7yHOqsoJi6UPYXKj
	 C7bfLEvAoh47M2hm+cuQI260AG7U5x9nrB+HLCmU2loFVs8bFKz2TqNsZu+MKFGZa+bpC
	 +gC8GGPdoVBsuN2Suy+QSq7WzraL1TEaIUm5ehous+S68zdDbOB6fZkx9k2ANzdLO3x/v
	 l6h+3winbK+9S93abrPrRxmrjdDdiQDaH8KdToudXBOzWTxbRzry9XZ080GMuskvqjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=clcHaKci;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24DA606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=clcHaKci
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5C91F008A2;
	Tue, 10 Nov 2026 16:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327481;
	bh=HhpLu8eWf+ICJ9bh4uJ6YZbGT2bSYXGUTLkSlY6c4js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=clcHaKci6+IDAgaNdyqR/tdo4pO98BkWFdrtXyy3AF9GAD7cwiU2+Qh1lI/1nHIMw
	 F1fwBVskpv73LsN3UGJAvJB93UGWGZaq8DXLjje4OVSNyLPWaBAl8hkfGpW3XlgXYF
	 5EdX1IuJkxnzp6zfRQoXTPE7oRsyOuOIOyuPEQLKhujGSAT79eaKp6E1WLJKxbh5yh
	 VFCd3etBi5xKm8nGq5ZjLyMN5E984q60PyrRKncPLd3M11I7ylZ+xgwqcOeSJ1I4Mj
	 ud8MORZh5NykHjoN9PUux0pyGWDqifL2uyGXtzJfemKP5fdWy6ctV9qAKBmhEwv1Km
	 1wi8RSxIbDAIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] sctp: re-point retained control chunks on association migration
Date: Tue, 10 Nov 2026 11:17:58 -0500
Message-ID: <20261110161751.2477980-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110161751.2477980-1-sashal@kernel.org>
References: <20261107060725-failed-5.15-52ffeaa358d1@kernel.org>
 <20261110161751.2477980-1-sashal@kernel.org>
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
index f37c7a558d6dd..0355dbef9881d 100644
--- a/include/net/sctp/sm.h
+++ b/include/net/sctp/sm.h
@@ -256,6 +256,7 @@ struct sctp_chunk *sctp_make_fwdtsn(const struct sctp_association *asoc,
 				    struct sctp_fwdtsn_skip *skiplist);
 struct sctp_chunk *sctp_make_auth(const struct sctp_association *asoc,
 				  __u16 key_id);
+void sctp_control_set_owner_w(struct sctp_chunk *chunk);
 struct sctp_chunk *sctp_make_strreset_req(const struct sctp_association *asoc,
 					  __u16 stream_num, __be16 *stream_list,
 					  bool out, bool in);
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index cedf3006ee823..c15d62ad24754 100644
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
index 7cc3f146b1fcf..cb2c201520957 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -154,9 +154,24 @@ static void sctp_clear_owner_w(struct sctp_chunk *chunk)
 
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
@@ -164,17 +179,14 @@ do {				\
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
@@ -197,6 +209,21 @@ static void sctp_for_each_tx_datachunk(struct sctp_association *asoc,
 
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
@@ -9706,9 +9733,9 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
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

