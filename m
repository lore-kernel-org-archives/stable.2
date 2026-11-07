Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049649;
	b=IEXClNmZ+Zx+0zcIhbX8hyO7LGLN1HO2rwACMyhZydNsBivdBqOjWf5PCSOW8NalaJjS
	 fj5NuLoSRDgszdOiYR0j49IKoZhh1opYHb9yhQQcRHZlCM05O5r4bBR7eTSJjMcNYOk6p
	 pYXy6xkYM8RTSKrjlQPcYQogv4AWGwpQMQM8n1VXAoxS0W2CqApiwnjxjNV6LnWyeU2EF
	 +F8VktiwCDs/MlHpY2jWUzyAaQv0KtIDilt2l8rc3E5Wt3HnfCXKjemu2xWPm6dXHjdpC
	 QHmKt4gqY2xgGyVq0pywHnTu9ClipRWIQzvXs4oQ5xeqgJsYgRlh3jNXDVCVqow2v0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049649;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+mFAEuDhKYM2KTGZdM2frFk/rvHR8Lu7rV17cPz1YPc=;
	b=5BXs0PRupPWE//wyXmSp0DJciIsml2aZMCx3dzY8U2rCZYnrX6I6TDcV/XzUnG3Z4/La
	 XcsC2b6vLtL7+tPFWEQCRHD/s5HLcHmzGs59A+tK9j1zTL46dPR8/L3c2y81lNfJzKowg
	 NsmKXLGWLVhgYrPgzAQmVvapcTWApZpAZwvhBghwGoi6vsNnHPmgnbkAeKW9tNgwD6ILA
	 KKkxs3ZFgHn6ah61NCDALByBWlyZEox//a8A3MUj+XaDzrqxtDBbYxru0NPtKOJ7PUfZ9
	 Y9GuiBIt6Xpj2yoLsTKtCMMacLiXtdaqlQook5hG+E2jUwkfYvmMjN5U9I0Mg+EQ1mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJD96SaV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A840D606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJD96SaV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E630F1F0089F;
	Sat,  7 Nov 2026 11:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049647;
	bh=+mFAEuDhKYM2KTGZdM2frFk/rvHR8Lu7rV17cPz1YPc=;
	h=From:To:Cc:Subject:Date;
	b=lJD96SaV9gjy0fWDgq9cAgvwvw1LG8xGKssrXtkSTUl5/XkWNKGuD4PvhC3Ckq1Ri
	 UfZ4uHwH62HsqflgDONWZbjs5sMvteME19s+1Wq1tgIHG8g65PAv5ToI4kqreyx/A3
	 FkExe5Hl9QYlaZ2G54knzPS1ITKRh+8f2WTMzvWFn84Ya66NfjDvqRCW6h/BodKo4N
	 zZWvGL1hDN2gLS7LOI4bWVjd/Jq8/onFDqfwF7dh0Lp91pULAy0VGNio/XJducXfBA
	 /XRmvmi4XyvdMFkAiVhREHq1G5NCgK+Al9c9DF0G8nhmSXTQ+cR0eP7188YrAe1MfE
	 yc+CCgh+jXtdg==
From: Sasha Levin <sashal@kernel.org>
To: junvyyang@tencent.com,
	corvus@tencent.com,
	lucien.xin@gmail.com,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] sctp: re-point retained control chunks on association migration" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:07:25 -0500
Message-ID: <20261107060725-failed-5.15-52ffeaa358d1@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 52ffeaa358d1f3d91aa87a26ad90d77769cff74b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060725-failed-5.15-52ffeaa358d1@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 52ffeaa358d1f3d91aa87a26ad90d77769cff74b Mon Sep 17 00:00:00 2001
From: Jun Yang <junvyyang@tencent.com>
Date: Fri, 9 Oct 2026 15:42:32 +0800
Subject: [PATCH] sctp: re-point retained control chunks on association
 migration

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
---
 include/net/sctp/sm.h    |  1 +
 net/sctp/sm_make_chunk.c |  5 ++--
 net/sctp/socket.c        | 53 ++++++++++++++++++++++++++++++----------
 3 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/include/net/sctp/sm.h b/include/net/sctp/sm.h
index 3bfd261a53cc9..76605d1ee8391 100644
--- a/include/net/sctp/sm.h
+++ b/include/net/sctp/sm.h
@@ -252,6 +252,7 @@ struct sctp_chunk *sctp_make_fwdtsn(const struct sctp_association *asoc,
 				    struct sctp_fwdtsn_skip *skiplist);
 struct sctp_chunk *sctp_make_auth(const struct sctp_association *asoc,
 				  __u16 key_id);
+void sctp_control_set_owner_w(struct sctp_chunk *chunk);
 struct sctp_chunk *sctp_make_strreset_req(const struct sctp_association *asoc,
 					  __u16 stream_num, __be16 *stream_list,
 					  bool out, bool in);
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 84a4c97d0f755..ddc31a5dbad32 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -94,7 +94,7 @@ static void sctp_control_release_owner(struct sk_buff *skb)
 	}
 }
 
-static void sctp_control_set_owner_w(struct sctp_chunk *chunk)
+void sctp_control_set_owner_w(struct sctp_chunk *chunk)
 {
 	struct sctp_association *asoc = chunk->asoc;
 	struct sk_buff *skb = chunk->skb;
@@ -107,7 +107,8 @@ static void sctp_control_set_owner_w(struct sctp_chunk *chunk)
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
index 696e679362512..8cf3e955ae180 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -155,9 +155,24 @@ static void sctp_clear_owner_w(struct sctp_chunk *chunk)
 
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
@@ -165,17 +180,14 @@ do {				\
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
@@ -198,6 +210,21 @@ static void sctp_for_each_tx_datachunk(struct sctp_association *asoc,
 
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
@@ -9645,9 +9672,9 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
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




