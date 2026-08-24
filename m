Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1947126D;
	Mon, 24 Aug 2026 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590161; cv=none; b=J6EFyWCMD1+MTRqab1B+vld1wY4+XPOrBBxLTeyWgIOlnlhEFvwqthioZFCUB93ja/zwLfxLZa89hX/QV2j5h/Z/bdv6+hQKMjMyx/IVg8K8QS5ykK6/w2caLA7TmNlbQnIgyo7iLEfOpppSNvLi4CgsZE0oyz7UYxxhuFrDhYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590161; c=relaxed/simple;
	bh=m62Sm5zsSGQmKpn0Ji7keLrY8G/l7KNlTM+gNCjrpIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kqd3DzF4RZ5x6LgYuPcwUq28k9xWD5zZbOlOwvHb8xaTmuRh7Iw5AR2eQSZNqEhUCEdvPGjg4+EpQtYa8JNglPswm3o072kc2inhJJgjWepe3IDSkdJurZZD5E0LuWmObdtD7sFgZ4tY32aVmPH8nnJP2zlWZ6obwQE+K1ZEhmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TO9v0YBg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TO9v0YBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCF61F000E9;
	Mon, 24 Aug 2026 16:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590160;
	bh=2CY9/h6bPYd37mUpBWNnX4vDgsBq4zadcxpSS7We6yk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TO9v0YBgPF30FEM0lHL/DLQXLw20GMgTk6Wns4R32ijxJmLOG1hSOKQAHV6Wia+R1
	 ID1aEc3LuC4bm1c8sgFLWaeQ6SGjA4nXmlbsKuT6JbtvXGEslJu0ppK1B12qim3KBt
	 PrB2shhBd4mUkuhMmyM5TN7lTb17tHTZPg50Q2g8/Qov1sHKSxBx1iVtBWMuGT4RFs
	 pNdjCF/bJk/Zv6a6f5Ohngo2lVlTBswV47LSSLLXPwLsjUO+YFJQna7ImN0YPE3csm
	 VUGIFU72iGmolyc6c5ny2M+yJlmBp2Dc2zp/Eu9iSuFgRPQnJ9M4U1k10xAxOvgGkX
	 2jwhW5bT+XrGQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Aug 2026 18:48:34 +0200
Subject: [PATCH net 14/14] mptcp: avoid pruning for OoW data
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-14-a92309d121ca@kernel.org>
References: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
In-Reply-To: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1473; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=vn/+T+fXbkpwPKwvL+UwDd6h1lgOJiFXr8yi5+YYNd0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJ6Sp/xuv6pnTuh1OSZ6ZM5jxaaHFW4cP/VrGvHogP/b
 d+xc8794x2lLAxiXAyyYoos0m2R+TOfV/GWePlZwMxhZQIZwsDFKQATsZRg+GfArPZG2Er+WoTv
 exYJ4YY9L/ivL8zcd+T0ze9r+3nWaKgz/BXgLa+//eXy8ejlnYwL7q5c5rN39vzGCE7TIwbbE1y
 O5jACAA==
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
index be59ffa4bd31..b26a8d560612 100644
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
2.53.0

