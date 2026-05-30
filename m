Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C582E06EF
	for <stable@vger.kernel.org>; Sat, 30 May 2026 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780150775; cv=none; b=TzedgPVXoR1Xr+wJTG3hV/SaRU9T+lQ1NkVMP1tD/m2pd777jwc+3wUEdEKP9gW7PIUWx2UF1L7BMf6Fx6V8DQGgePiEkdjEAl4AfhCnvueJvxskQokNxDZL2Vbrf9epUBEEJn2w/KW9epIDAozz97/ja42JpOePH7tXI3C8UMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780150775; c=relaxed/simple;
	bh=yHweQrbOprmIlO8Ev1UzYhYZupflm7ZNBfvOBQ+C43o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knKb5LhLWB7tjPhef+xQCvX4ZV/wBkUUT1Pn/LBjjOc6D9cbDZ0okqEjWCht2RjE0eofxqZbN2IRr4YNreCyeMzOew+s5faJb8Gh3N5dkpbRzucVTFpN6cWIICrGEq3eUYHjOV95nwMk/+6BNEYyjV1FAq7gOzvAMpxqfzsrutQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAry+mAt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAry+mAt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982921F00893;
	Sat, 30 May 2026 14:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780150774;
	bh=gCwWxffmH0ffnNQteI21dtVgXQBFo6co+5Ae1R27Uo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KAry+mAtZgmHJ1sgpKo46THei00cXtLDEdISdLlE3KK2lFYnPmDp9otYsTZlfGnJE
	 Vf8HGON5KUsRWre0JDEkBbJ31NJwevB4/v0jkMD4PlD0I9sAdjWYoQ6q/nEG1S35Kt
	 9Ja1RLBu3UwxIaEp96ZJmwkEVLALZoTrC9fD1HNpf8We0RAEdEuBGvxxRK9ehjGe64
	 y897AGExN+8hRD8YctBuw9C6XVWz/K+t5qxpWr/3S78K9b5/v2EdXYC2BNkwoHZwi/
	 VLL6fmu6COI2vTMlTM+CwVd+wPpz72gssgLc+VylNhIolbAf/1zDIj3u6mXdc/4AGt
	 JZ1ft1AxHLlig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] mptcp: introduce the mptcp_init_skb helper
Date: Sat, 30 May 2026 10:19:30 -0400
Message-ID: <20260530141932.2407122-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052836-subscript-earache-630d@gregkh>
References: <2026052836-subscript-earache-630d@gregkh>
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
index 7dbb666c72c30..4fdce559a2235 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -321,7 +321,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	mptcp_set_owner_r(skb, sk);
 }
 
-static bool mptcp_rmem_schedule(struct sock *sk, struct sock *ssk, int size)
+static bool mptcp_rmem_schedule(struct sock *sk, int size)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	int amt, amount;
@@ -339,27 +339,11 @@ static bool mptcp_rmem_schedule(struct sock *sk, struct sock *ssk, int size)
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
@@ -371,6 +355,25 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
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
@@ -391,7 +394,6 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
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

