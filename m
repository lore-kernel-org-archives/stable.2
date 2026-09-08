Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C45560AD1;
	Tue,  8 Sep 2026 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876906; cv=none; b=YBKzveWTJzHFdIdV4bbBxJYNYcmpG9/k5PoT4OnDdd4WapDH+F+Hnnd9/LOPdZX6j+ZYhR8VqeSOhHIM5MDiVwfzVMgKHV5Qzlxd6oPiPQ/WeQfOfQ/XOE+7hwp+yqJz49f3bL33NoWQ89qnV7gQL7IZy8RI4HzDrhFkYa+4S/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876906; c=relaxed/simple;
	bh=0Rf2YJvFhUDulQQ7AgAE1+fJavvfDKv+b2h+us/wCR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g8Sebb1f6ybfWm6fVyJY98ql+65ltaRFnF48CHg4675Ah5UOlO8eAShtF53mkN5GtrnnfhhdY8TuvUoA885uP7xm7pV2Ns5lcnLKjJcdeamW/2YP+W3yHyrrgj/Yj/Bas4jNAc/UQJH0dwUED8aMuVGKmxup1zoxhsY6xkJyKnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDurLrOp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDurLrOp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2CD1F00ACF;
	Tue,  8 Sep 2026 14:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788876892;
	bh=9bNTr4YfhaISPP5ozmhB/lHfD4lozn0E+c2Bf6a8CwY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SDurLrOpJyGC8/0PKcQ7GYENjdzagDAAxEURGEqCGIjYzo2dB1pTvoP3TXYewP3GN
	 SKQP8P0JNyY6AtrbTYqaMnV5M4nF3FkZP1qwO3XI7ygTprSCvVHfEf2L39DZ/DP79T
	 m/K8YCqNXJL1KqLhJcesNFauyhviEtJ4S8P72fOIf9boa3UvqEwgsAVsVlK5tstFLU
	 a9ChIJ6X+PtHP/In7n884g5Bc659IsK0hLuGTP2m2PJfM3754rVP8Ih1FKBH3vv4qW
	 HTR6hs9/tgFKfXo65faakowSOfRcCD0SH1TfKyGNGJkvTVoCL29w3PRYhVceTCuHma
	 mCyhvrg095zEw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 08 Sep 2026 16:07:20 +0200
Subject: [PATCH net v2 15/15] mptcp: avoid pruning for OoW data
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-15-df1de70348b6@kernel.org>
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
In-Reply-To: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1473; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=A8xR/5LxV2W9rnK/z18vuygkRh9g+bXMpiu5CeK5OhQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIWSBg5zmtmLOzW9U3+EMLjdDQ9jVulZWp2QvgNITfG+
 kdBx9Z0lLIwiHExyIopski3RebPfF7FW+LlZwEzh5UJZAgDF6cATKRyCsM/ZXWWZ/XHXR9e33hf
 p3S5N8+rqYlfnuk++8oq0Oqa2r7vFCPD8Yx7T1rqu5asWHx6a0/T7ygNsQXLlhZp3bZ6NbXacPU
 qVgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Pruning is expansive and destructive, do it only when we expect
to accept the skb triggering the cleanup.

Fixes: e468d371180d ("mptcp: implemented OoO queue pruning")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4309fca6b119..0098e2830931 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -313,12 +313,6 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	u64 seq, end_seq, max_seq;
 	struct sk_buff *skb1;
 
-	if (!mptcp_try_rmem_schedule(sk, skb)) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
-		mptcp_drop(sk, skb);
-		return;
-	}
-
 	seq = MPTCP_SKB_CB(skb)->map_seq;
 	end_seq = MPTCP_SKB_CB(skb)->end_seq;
 	max_seq = atomic64_read(&msk->rcv_wnd_sent);
@@ -335,6 +329,12 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 		return;
 	}
 
+	if (!mptcp_try_rmem_schedule(sk, skb)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+		mptcp_drop(sk, skb);
+		return;
+	}
+
 	p = &msk->out_of_order_queue.rb_node;
 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOQUEUE);
 	if (RB_EMPTY_ROOT(&msk->out_of_order_queue)) {

-- 
2.55.0

