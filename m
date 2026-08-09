Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D07379C24
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786283691; cv=none; b=e3bsykhBFaKvLYod/3GI1THZII55jPw92cC+NeCn+/bvSqXZlRmWg8sWQK5LTxf2HEVS5Ldsb+gVamMqAGdwiINYQ4cgGNN2Wpkm3nC2h6eHNm+gsZjyXjDcgnFgqvwF0SpMo7Uky7fDK5qJ4EZInU4c8qGOTbzCbajp0dsuPwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786283691; c=relaxed/simple;
	bh=WXqF5oZ3GZYhs8CV8PTy26SoT2ZtYNKaXBEZe4QNC70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWIH+/p+lgixdkG+15AT0AjQzFC/rHi+kJ2S2pv833LImLlTQ99zHkJTENXRsG2y4D61U069RNlzF4z3tZEOYgjnSPy3YuzMQWhLw8SUrMoc8Uiq9UXQGWLAP2FbYqKBgD9/rm/0NfmOL5XkckV0FZL5bItJ3u34Da0ogoCR7c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gce+kIzj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gce+kIzj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8236A1F00A3E;
	Sun,  9 Aug 2026 13:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786283689;
	bh=f8BGM9sGwYD+mbECZFrUuTMwNrPzpl3qnnBdz+ljWqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gce+kIzjryx5fKTCxgoRHqhnhhYD9eUFtcqNr3u+4Ylpiipvik+rQVkAYhoJaCE9A
	 a99aNIus2Yp9E6CGig/+lQMnNNEI6ru2q5Wk42nCCLj75UgT6F9mgu0ergjnOSPCWa
	 ZjoaZQohu7OsEBPe7VG+MSTlhY96XHBqcitn1mFf1Jo+9gMTx5V5SraE1Zq/ekl230
	 YRPqfyKfgZb4LoNAOwt1xpkPDmXfdZKHqhsCRzyYhz9ktzUZiA3m7fu1h02aoFMyZ2
	 YvmblhKL9wVg4KJNnxfJVknYbDje7RFndtoH1bSKBWQ7GM0686C0AfWJ4GizR2z/TO
	 Ugx78cN8G3e0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] tcp: fast path functions later
Date: Sun,  9 Aug 2026 09:54:44 -0400
Message-ID: <20260809135445.1507611-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809135445.1507611-1-sashal@kernel.org>
References: <2026072945-service-serpent-1ee6@gregkh>
 <20260809135445.1507611-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ij@kernel.org>

[ Upstream commit 61b2f7baa9779b12a7bf1b9800a3f2a2549a1315 ]

The following patch will use tcp_ecn_mode_accecn(),
TCP_ACCECN_CEP_INIT_OFFSET, TCP_ACCECN_CEP_ACE_MASK in
__tcp_fast_path_on() to make new flag for AccECN.

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250911110642.87529-3-chia-yu.chang@nokia-bell-labs.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: a28c4fcbf774 ("tcp: challenge ACK for non-exact RST in SYN-RECEIVED")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h | 54 +++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4ce70767474f3..18a1fa7633bae 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -714,33 +714,6 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
 	return usecs_to_jiffies((tp->srtt_us >> 3) + tp->rttvar_us);
 }
 
-static inline void __tcp_fast_path_on(struct tcp_sock *tp, u32 snd_wnd)
-{
-	/* mptcp hooks are only on the slow path */
-	if (sk_is_mptcp((struct sock *)tp))
-		return;
-
-	tp->pred_flags = htonl((tp->tcp_header_len << 26) |
-			       ntohl(TCP_FLAG_ACK) |
-			       snd_wnd);
-}
-
-static inline void tcp_fast_path_on(struct tcp_sock *tp)
-{
-	__tcp_fast_path_on(tp, tp->snd_wnd >> tp->rx_opt.snd_wscale);
-}
-
-static inline void tcp_fast_path_check(struct sock *sk)
-{
-	struct tcp_sock *tp = tcp_sk(sk);
-
-	if (RB_EMPTY_ROOT(&tp->out_of_order_queue) &&
-	    tp->rcv_wnd &&
-	    atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf &&
-	    !tp->urg_data)
-		tcp_fast_path_on(tp);
-}
-
 u32 tcp_delack_max(const struct sock *sk);
 
 /* Compute the actual rto_min value */
@@ -1657,6 +1630,33 @@ static inline bool tcp_paws_reject(const struct tcp_options_received *rx_opt,
 	return true;
 }
 
+static inline void __tcp_fast_path_on(struct tcp_sock *tp, u32 snd_wnd)
+{
+	/* mptcp hooks are only on the slow path */
+	if (sk_is_mptcp((struct sock *)tp))
+		return;
+
+	tp->pred_flags = htonl((tp->tcp_header_len << 26) |
+			       ntohl(TCP_FLAG_ACK) |
+			       snd_wnd);
+}
+
+static inline void tcp_fast_path_on(struct tcp_sock *tp)
+{
+	__tcp_fast_path_on(tp, tp->snd_wnd >> tp->rx_opt.snd_wscale);
+}
+
+static inline void tcp_fast_path_check(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (RB_EMPTY_ROOT(&tp->out_of_order_queue) &&
+	    tp->rcv_wnd &&
+	    atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf &&
+	    !tp->urg_data)
+		tcp_fast_path_on(tp);
+}
+
 bool tcp_oow_rate_limited(struct net *net, const struct sk_buff *skb,
 			  int mib_idx, u32 *last_oow_ack_time);
 
-- 
2.53.0

