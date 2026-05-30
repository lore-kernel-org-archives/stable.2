Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EFD2F6596
	for <stable@vger.kernel.org>; Sat, 30 May 2026 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780153664; cv=none; b=fJlB4aw1kqz9DhHBqEMJuB87ye9TPBaNHVr/rcAbTh/KXGzSpX1cA2x+l0p6cUxiErf2Om6Njb37axaNhCe65YpIivUvK8V7L++iN/8PBWInejRoIghhU7pLu6QG+9Va2TeVaDq5lGX1sBKYCp49vAVUjufQ7Mddhic/ExPZezU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780153664; c=relaxed/simple;
	bh=EvGFHurK4ACmfYQC1CIYoT7FlKt5T4gUUQfbYWIRdF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tthlCV4+XCq9PNevKE9wYmK4wOAQFu2kXzz04xtoxsaQQhR8pWIYvK8rHPuA5z78NQwLI56oDg4L+RGgIynqwvBVCNcPe0zLqydY+20CYEjZkmO2bGXZqk9d0dBoUAsPgtiVI0paccm62NoNoaPYqCOerbJGmftWyN7zRDHHSBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8RB2+nZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8RB2+nZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322F61F00893;
	Sat, 30 May 2026 15:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780153662;
	bh=sdPk35DNv7apOKv1mj6X1oxt4+33CI4rBW3dwRTQbv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E8RB2+nZm4FnVVjgYTwr1EMpFrk3NdVnPU38xbE2ZevdfhGwSXtJEczeJw5RCsdNW
	 DUUv1OmLbJ+XIHlNdlL5fqhAYfax68ihfvdqwDym35GCkI1HsviRordhPuE2ohftx0
	 SktRPlSFaOwJXLwP3sZORABPij4fYX7h8KwRtZA7IMwubpRCxP6p2wYwwlhnIn1hhR
	 FeefW+Dfiq3Gg7RYoNdleb+DR4JDDusKgaG9wenMUWrU4xFXtURfpERO9LO3Hwilbh
	 r/VJNSVxvLX1cX1hCHg0S44yD0Zn1Y+4rSDnoLfPnaP3ZnxRXmZi60MiN07fjJSY5L
	 ygpc318Qu5Ywg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] mptcp: introduce the mptcp_init_skb helper
Date: Sat, 30 May 2026 11:07:38 -0400
Message-ID: <20260530150740.2598142-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052837-repave-immovable-cfa4@gregkh>
References: <2026052837-repave-immovable-cfa4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 9a0afe0db46720ce1a009c7dac168aa0584bd732 ]

Factor out all the skb initialization step in a new helper and
use it. Note that this change moves the MPTCP CB initialization
earlier: we can do such step as soon as the skb leaves the
subflow socket receive queues.

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250927-net-next-mptcp-rcv-path-imp-v1-4-5da266aa9c1a@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 50c2d91c5dfa ("mptcp: do not drop partial packets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 50 ++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index aed6c04c7de67..1c30bb369498a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -323,7 +323,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	mptcp_set_owner_r(skb, sk);
 }
 
-static bool mptcp_rmem_schedule(struct sock *sk, struct sock *ssk, int size)
+static bool mptcp_rmem_schedule(struct sock *sk, int size)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	int amt, amount;
@@ -341,27 +341,11 @@ static bool mptcp_rmem_schedule(struct sock *sk, struct sock *ssk, int size)
 	return true;
 }
 
-static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
-			     struct sk_buff *skb, unsigned int offset,
-			     size_t copy_len)
+static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
+			   int copy_len)
 {
-	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-	struct sock *sk = (struct sock *)msk;
-	struct sk_buff *tail;
-	bool has_rxtstamp;
-
-	__skb_unlink(skb, &ssk->sk_receive_queue);
-
-	skb_ext_reset(skb);
-	skb_orphan(skb);
-
-	/* try to fetch required memory from subflow */
-	if (!mptcp_rmem_schedule(sk, ssk, skb->truesize)) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
-		goto drop;
-	}
-
-	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
+	const struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
 	/* the skb map_seq accounts for the skb offset:
 	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
@@ -373,6 +357,25 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 	MPTCP_SKB_CB(skb)->cant_coalesce = 0;
 
+	__skb_unlink(skb, &ssk->sk_receive_queue);
+
+	skb_ext_reset(skb);
+	skb_dst_drop(skb);
+}
+
+static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
+{
+	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *tail;
+
+	/* try to fetch required memory from subflow */
+	if (!mptcp_rmem_schedule(sk, skb->truesize)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+		mptcp_drop(sk, skb);
+		return false;
+	}
+
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
 		msk->bytes_received += copy_len;
@@ -393,7 +396,6 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	 * will retransmit as needed, if needed.
 	 */
 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
-drop:
 	mptcp_drop(sk, skb);
 	return false;
 }
@@ -720,7 +722,9 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 			if (tp->urg_data)
 				done = true;
 
-			if (__mptcp_move_skb(msk, ssk, skb, offset, len))
+			mptcp_init_skb(ssk, skb, offset, len);
+			skb_orphan(skb);
+			if (__mptcp_move_skb(sk, skb))
 				moved += len;
 			seq += len;
 
-- 
2.53.0

