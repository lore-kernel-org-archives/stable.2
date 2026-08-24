Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8A445FFB6;
	Mon, 24 Aug 2026 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590148; cv=none; b=Zn6uDDuib9MZkzb+8dMNPT/+UIu31twOa3tZo00oEcuupBjySaR54e3+YksnD4i2bkNtcdps2t2yNNU6/eABuLSWwa4/Lgj8ClKDUPCy4Ic6IvOo8oT4cy2lm2bEV8aaen3cP5eyfgTDQkYOJaiI5FLJf+FNuR73W9itKX0mNnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590148; c=relaxed/simple;
	bh=ZdI1IRE2SFT4YHEIrJ1kj9oUUOrOqMVgD7VtBYgrs7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ki7PeM/XBggLKjUXkNuGEgJnSnGh9qYRCgcXMEgITIlZhIefU8qNQYXAdxu4qJn5jmKVMnsHog2nKv1abTG3+V0LWokV2o9aK060w9fyLkSlPg8k9KZQhjOrIiCl5JdgbrOS5GU3xTrOOT5x4rwEVIJJpj/TxI68JCiXuinrns4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Noe2Sp0k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Noe2Sp0k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D203A1F00A3A;
	Mon, 24 Aug 2026 16:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590147;
	bh=nxXK1daVFCLsfOaLTp9/6Q1wtfCLrNjyVmVJsnYVYoc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Noe2Sp0kL7UbbWR5qCZuLU/3x7LdInffzmabiMxJxAawthMvv82Y5bFgiyhzuShmx
	 snS130cDkN1GyWN3zxSfD/3qPl2Dl0P5nqvac4YVLiIK/O4JPmxjGqnOZ4nw2GLzmF
	 2N9o4BwjHEwOe9R5gF1tZxbcaJIRt5o+PFvaqrVN0WwRYc8tLvSj9NtzO/hYNzRY/G
	 qs7UAQRwqzPIFRxi5HWE8XKeCiX3v+FRwQVtbjHz7jWe3sjQh5obASyUbJjHRgIQjZ
	 qsgBJYaZIXHtyi+oVxGmIZmzfAX7nhYbTMCgVgQpzZmt1kj/nqWBXa13VIWrtcD/Ty
	 lSXmdCFeMLrXA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Aug 2026 18:48:29 +0200
Subject: [PATCH net 09/14] mptcp: remove unneeded READ_ONCE() annotation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-9-a92309d121ca@kernel.org>
References: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
In-Reply-To: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2207; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KQW5aTIKF3jtFxKldgeomGqGxKZHGluA+V34pVxNM+4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJ6Sh9XnlQRmiSxV9LOrHbe79PL5nLoqz5bnfq3UlTl7
 6y5OTXBHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABN5+46RYduGXbyhPtofJ3LX
 H133dslvs0VSJyfIz5vl2/6Cjbu+XIuRYcbGhAgt7qQLGUc21n2ubftyQE/uiVfRmdB79afvSyi
 7sAIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The subflow->fully_established flag is always written under the subflow
socket lock. Reading such value under the same lock does not require any
ONCE annotation.

Fixes: 581c8cbfa934 ("mptcp: annotate data-races around subflow->fully_established")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/options.c  | 4 ++--
 net/mptcp/protocol.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 92f27b9e087a..196a46e7467d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -530,7 +530,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		return false;
 
 	/* MPC/MPJ needed only on 3rd ack packet, DATA_FIN and TCP shutdown take precedence */
-	if (READ_ONCE(subflow->fully_established) || snd_data_fin_enable ||
+	if (subflow->fully_established || snd_data_fin_enable ||
 	    subflow->snd_isn != TCP_SKB_CB(skb)->seq ||
 	    sk->sk_state != TCP_ESTABLISHED)
 		return false;
@@ -981,7 +981,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	/* here we can process OoO, in-window pkts, only in-sequence 4th ack
 	 * will make the subflow fully established
 	 */
-	if (likely(READ_ONCE(subflow->fully_established))) {
+	if (likely(subflow->fully_established)) {
 		/* on passive sockets, check for 3rd ack retransmission
 		 * note that msk is always set by subflow_syn_recv_sock()
 		 * for mp_join subflows
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 23dde0b7144b..c7c8bb3b3e00 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3881,7 +3881,7 @@ static void schedule_3rdack_retransmission(struct sock *ssk)
 	struct tcp_sock *tp = tcp_sk(ssk);
 	unsigned long timeout;
 
-	if (READ_ONCE(mptcp_subflow_ctx(ssk)->fully_established))
+	if (mptcp_subflow_ctx(ssk)->fully_established)
 		return;
 
 	/* reschedule with a timeout above RTT, as we must look only for drop */

-- 
2.53.0

