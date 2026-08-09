Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC7A306741
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 04:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786249233; cv=none; b=Cbo7rrMGH8XRJLDQE2irEVVMXE3CZHE7p/HmReG5Jol3GTyz/2xgCBffd6g4o1/wTbPGyaNYnSuMWbvB2ee9+R9/gdMLRgMpVdexP2COAzJPiVTNpuE/UvAuk3GQnEg61Z4Tm2s71Us5gBGTRqKJa6VXDl7dUB6h9vglVb9FE/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786249233; c=relaxed/simple;
	bh=6du9b7Zw1DpD1MKD6hM+fA2qty5dwna7Oe3aM+zqq1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OiPgfzaEVGaK8d8UuSS0BnI9NrUgQcNpQ2YaC7UH3sGihSw4JP+julliLR9udhKJ+Sz951Q/55TGrylnWLkmmcMN6XRyyIWj2CCD2IijiheTms5ClvYksBF5s24PtJ9IPNueck27hVo0PR/eHo0NmJV6PPqv5HsPPq7+8MvcP8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7XUm8iC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7XUm8iC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D391F000E9;
	Sun,  9 Aug 2026 04:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786249232;
	bh=zD3yygLD9gO24fsRHP3OuTCgw9SezO2CptBSSNV6Wp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g7XUm8iC2Zy44uKdBkNGP3e4cqI0XD7i6wmFBuDTEh+e3yij2vDY/bz5LHjm3jHD4
	 kRSo+WwV+44N/029Ir2EhDSOjdZbJJc+NfJ+jL6d59R9YQm89uOZ4w9bz8ZL/1fcy8
	 mf1/Ypb/sn+XJ2wQKyaNZh5+I5+Bc6S9pHQnyDOKynus63oSgDjTm24UMyYp26FVs4
	 GUyX03Ih9X5Y5O24kbwKUAxONhkM4ZTbfkUogPtVvlU8sd0xGPkW+UPagCbunmK69J
	 7AV7P0ll9UTNI/XfSUo8IS9Hy3GJBgU3bmN6C2xYhZi4U3iG6k03XZCLsZc7IJ8IiE
	 3/2+B/oGyyOhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] tcp: fast path functions later
Date: Sun,  9 Aug 2026 00:20:26 -0400
Message-ID: <20260809042028.1093837-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809042028.1093837-1-sashal@kernel.org>
References: <2026072944-maritime-sulfide-d951@gregkh>
 <20260809042028.1093837-1-sashal@kernel.org>
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
index e57b03bc3fa88..f0ad16496f0f9 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -768,33 +768,6 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
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
@@ -1743,6 +1716,33 @@ static inline bool tcp_paws_reject(const struct tcp_options_received *rx_opt,
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

