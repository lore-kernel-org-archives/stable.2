Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9333B3ACA57
	for <stable@vger.kernel.org>; Sat, 30 May 2026 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141694; cv=none; b=pLk0XNaeweXvGg/NGDF2gAWIKW5IcYcONue/PblVAt+toph2BtipvqSLKKI0w9UOoJ/lco+xpugWcw18osMKivFkEpRvbHpeoCoXglH+iU+PWcdUxV9SCmCZd4uZscNFKW+6ey6foOCe+NZmNw+iVIFMGSd7f9WZTQsgd0LlxVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141694; c=relaxed/simple;
	bh=zDGV9fySrM2x19cmUZs+cwdONh3pURd6nszoyXu0MRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJMd+2FwyXrgDuMwPvPgv0xHRH9W8H/4zh/PmBXHRC2kRhSMNu1mNiMAeIZTVsmSiTORuXnBAZ/2eUDAu1WpznjhenU2blN1QQ/nHSZOlicS5Pg8myS24pwVmyNbaCqfWHNDMGowzq97GYIOjAyEv8g38S9Ds+sm2BEiaU1oN34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ay3gCcFj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ay3gCcFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33181F0089D;
	Sat, 30 May 2026 11:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780141693;
	bh=6q7oduxN3QTbe2IvjnIlyVMDx6uEeHr4kAIAHKq2zNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ay3gCcFjCaydpAm3+eB27jbRPWoJVFGnRa0tEKrphoTbD7273YzpGM5L5l7WWmFmP
	 sUS360AIpLTWzGYc5aYp/Id58vRAQw6bLPhkG1Xlg3ssYkUx+jRvBInNUoXcwGko0f
	 X0Pv8jD8FQ0+Yn76JZCkWLOftImbxvMAs3WnlKYoKjRkKj/GCV3wiKgfGGeGE1VJQC
	 AQfWEleHFPJxSmNIIphATVvSx1KFK3v3X6zJmtbCCZJ4ZXiHVfc9Ec36OXdFeFsKGW
	 PG8RSj3xQZjtx5/Z0X/IEXh8Tq3SFsc6jlKWIiwKzTpR60VLO+Cg1CmMeBcIHt6v8g
	 wkeE1rvn9YWlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] mptcp: borrow forward memory from subflow
Date: Sat, 30 May 2026 07:48:09 -0400
Message-ID: <20260530114810.1965750-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530114810.1965750-1-sashal@kernel.org>
References: <2026052835-evident-dutiful-f601@gregkh>
 <20260530114810.1965750-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 9db5b3cec4ec1c0cd3239689f5c8653d691a1754 ]

In the MPTCP receive path, we release the subflow allocated fwd
memory just to allocate it again shortly after for the msk.

That could increases the failures chances, especially when we will
add backlog processing, with other actions could consume the just
released memory before the msk socket has a chance to do the
rcv allocation.

Replace the skb_orphan() call with an open-coded variant that
explicitly borrows, the fwd memory from the subflow socket instead
of releasing it.

The borrowed memory does not have PAGE_SIZE granularity; rounding to
the page size will make the fwd allocated memory higher than what is
strictly required and could make the incoming subflow fwd mem
consistently negative. Instead, keep track of the accumulated frag and
borrow the full page at subflow close time.

This allow removing the last drop in the TCP to MPTCP transition and
the associated, now unused, MIB.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251121-net-next-mptcp-memcg-backlog-imp-v1-12-1f34b6c1e0b1@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 50c2d91c5dfa ("mptcp: do not drop partial packets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/fastopen.c |  4 +++-
 net/mptcp/mib.c      |  1 -
 net/mptcp/mib.h      |  1 -
 net/mptcp/protocol.c | 23 +++++++++++++++--------
 net/mptcp/protocol.h | 28 ++++++++++++++++++++++++++++
 5 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index c8aa5426f1af9..082c46c0f50ee 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -33,7 +33,8 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	/* dequeue the skb from sk receive queue */
 	__skb_unlink(skb, &ssk->sk_receive_queue);
 	skb_ext_reset(skb);
-	skb_orphan(skb);
+
+	mptcp_subflow_lend_fwdmem(subflow, skb);
 
 	/* We copy the fastopen data, but that don't belong to the mptcp sequence
 	 * space, need to offset it in the subflow sequence, see mptcp_subflow_get_map_offset()
@@ -52,6 +53,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	mptcp_data_lock(sk);
 	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
 
+	mptcp_borrow_fwdmem(sk, skb);
 	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
 	mptcp_sk(sk)->bytes_received += skb->len;
diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 1716438150765..f23fda0c55a72 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -71,7 +71,6 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPFastcloseRx", MPTCP_MIB_MPFASTCLOSERX),
 	SNMP_MIB_ITEM("MPRstTx", MPTCP_MIB_MPRSTTX),
 	SNMP_MIB_ITEM("MPRstRx", MPTCP_MIB_MPRSTRX),
-	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
 	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
 	SNMP_MIB_ITEM("SndWndShared", MPTCP_MIB_SNDWNDSHARED),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index a1d3e9369fbb5..812218b5ed2bf 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -70,7 +70,6 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPFASTCLOSERX,	/* Received a MP_FASTCLOSE */
 	MPTCP_MIB_MPRSTTX,		/* Transmit a MP_RST */
 	MPTCP_MIB_MPRSTRX,		/* Received a MP_RST */
-	MPTCP_MIB_RCVPRUNED,		/* Incoming packet dropped due to memory limit */
 	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
 	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after being stale */
 	MPTCP_MIB_SNDWNDSHARED,		/* Subflow snd wnd is overridden by msk's one */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0dde73543da0f..13a787605630e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -352,7 +352,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 			   int copy_len)
 {
-	const struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
 	/* the skb map_seq accounts for the skb offset:
@@ -377,11 +377,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *tail;
 
-	/* try to fetch required memory from subflow */
-	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
-		goto drop;
-	}
+	mptcp_borrow_fwdmem(sk, skb);
 
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
@@ -403,7 +399,6 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	 * will retransmit as needed, if needed.
 	 */
 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
-drop:
 	mptcp_drop(sk, skb);
 	return false;
 }
@@ -704,7 +699,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 			size_t len = skb->len - offset;
 
 			mptcp_init_skb(ssk, skb, offset, len);
-			skb_orphan(skb);
+			mptcp_subflow_lend_fwdmem(subflow, skb);
 			ret = __mptcp_move_skb(sk, skb) || ret;
 			seq += len;
 
@@ -2454,6 +2449,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool dispose_it, need_push = false;
+	int fwd_remaining;
 
 	/* Do not pass RX data to the msk, even if the subflow socket is not
 	 * going to be freed (i.e. even for the first subflow on graceful
@@ -2462,6 +2458,17 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 	subflow->closing = 1;
 
+	/* Borrow the fwd allocated page left-over; fwd memory for the subflow
+	 * could be negative at this point, but will be reach zero soon - when
+	 * the data allocated using such fragment will be freed.
+	 */
+	if (subflow->lent_mem_frag) {
+		fwd_remaining = PAGE_SIZE - subflow->lent_mem_frag;
+		sk_forward_alloc_add(sk, fwd_remaining);
+		sk_forward_alloc_add(ssk, -fwd_remaining);
+		subflow->lent_mem_frag = 0;
+	}
+
 	/* If the first subflow moved to a close state before accept, e.g. due
 	 * to an incoming reset or listener shutdown, the subflow socket is
 	 * already deleted by inet_child_forget() and the mptcp socket can't
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index feacb1feab476..df35dade0280b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -548,6 +548,7 @@ struct mptcp_subflow_context {
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	bool	fully_established;  /* path validated */
+	u32	lent_mem_frag;
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
@@ -647,6 +648,33 @@ mptcp_send_active_reset_reason(struct sock *sk)
 	tcp_send_active_reset(sk, GFP_ATOMIC, reason);
 }
 
+/* Made the fwd mem carried by the given skb available to the msk,
+ * To be paired with a previous mptcp_subflow_lend_fwdmem() before freeing
+ * the skb or setting the skb ownership.
+ */
+static inline void mptcp_borrow_fwdmem(struct sock *sk, struct sk_buff *skb)
+{
+	struct sock *ssk = skb->sk;
+
+	/* The subflow just lend the skb fwd memory, and we know that the skb
+	 * is only accounted on the incoming subflow rcvbuf.
+	 */
+	DEBUG_NET_WARN_ON_ONCE(skb->destructor);
+	skb->sk = NULL;
+	sk_forward_alloc_add(sk, skb->truesize);
+	atomic_sub(skb->truesize, &ssk->sk_rmem_alloc);
+}
+
+static inline void
+mptcp_subflow_lend_fwdmem(struct mptcp_subflow_context *subflow,
+			  struct sk_buff *skb)
+{
+	int frag = (subflow->lent_mem_frag + skb->truesize) & (PAGE_SIZE - 1);
+
+	skb->destructor = NULL;
+	subflow->lent_mem_frag = frag;
+}
+
 static inline u64
 mptcp_subflow_get_map_offset(const struct mptcp_subflow_context *subflow)
 {
-- 
2.53.0

