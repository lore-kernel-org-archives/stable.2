Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4CC477992
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346437; cv=none; b=sXjwbxaJa8oKZJnfeq8aKmvOMLUjN5XUnK7oZh+B/4l3at1GU9iRyAx08XIkeuYZlENCRb+dnX63GS9LvAEZfBg3J+88W+2pS2Lgn1HjSQHc/kQDgdhKtVFi8FnoNguHdgso6AxtKSDFphn4HV8yfJE1W3BYgazA+zVyH21vmL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346437; c=relaxed/simple;
	bh=zEhY4Z0LB/iWP50XrF0by+ncOMGQQxnZ/J1yLhUD1nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ndri5VV+3+TVKKX3QLc5Lpk5m7DmW6eHZ8Gx42KSo9pQySBAKFWmrWDczOkH9+IeltYdntO3+kW/x7ruxuKPXAxLO6E27oXOebp5U7PHGaSkgzjJsRAPL6SRHKR/ADWbNsSwqXWzu37HY/XPY2VhR93Gjnjj9suEKFyErBWG/9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4QK1OXD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4QK1OXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCC51F0155C;
	Wed,  2 Sep 2026 10:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788346419;
	bh=j7eXSwYfycpZ2VxMJrvgLQqt+9Fb3OhKcbZVYTD9l2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S4QK1OXDeWcC18D9XwcRkhy1wGQHClraN5fLHkrQj2V/WDqqU4a1VGyxyVznTSGf7
	 5fnWGhl2chd2PAvLO/jWIfAp11tTrTFtCGxWtKLGmO4A5ElX0jFm3on5SaOvKZ+zDz
	 Oocfz3GfX+om6fcvPnrMKMdwyB2w3efjo6WTzv/kBnfRcrxmrn8xNxoH2bPPfXVklr
	 9L93dpxtvj5hKnJzqaOW5jG2oXhBFHzfRGNJddQsUv+bBn50BUrxSgNd/GLgC8/Q/q
	 CHu6N+42C8UzLrvKzUvNsPSUJEHvsJ7EbjVVF38TahqUWKWs4RSR1MpznvdDewRh/M
	 Xy/TS+pmh+wrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yong Wang <edragain@163.com>,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/5] tcp: clamp route advmss to TCP_MIN_MSS
Date: Wed,  2 Sep 2026 06:53:32 -0400
Message-ID: <20260902105332.2048804-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902105332.2048804-1-sashal@kernel.org>
References: <2026083106-glisten-superhero-188c@gregkh>
 <20260902105332.2048804-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yong Wang <edragain@163.com>

[ Upstream commit 870a9e42ecc6fe1b8c25d87af043cb0d9c178fe1 ]

tcp_select_initial_window() assumes that callers never pass an MSS
smaller than 1, but route-derived advmss values can violate that
assumption.

A too-small explicit RTAX_ADVMSS is one way to get there, but it is not
the only one. The same divide-by-zero can also be reached through the
"default advmss" path when RTAX_ADVMSS is left at 0 and the effective
advmss is later driven down by route MTU and min_adv_mss.

Introduce a tcp_dst_advmss() helper that clamps route advmss to
TCP_MIN_MSS before TCP consumes it, and use it in the TCP paths that
derive advmss from dst metrics. This keeps the effective MSS from
dropping to zero before tcp_select_initial_window() rounds the receive
window.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Yong Wang <edragain@163.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
Link: https://patch.msgid.link/251eaf8277fa7c66364c9815c5da01662d269181.1787074852.git.edragain@163.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ dropped unrelated ssthresh helpers and kept plain window_clamp assignment instead of WRITE_ONCE due to missing context in the 5.10 tree ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h        | 5 +++++
 net/ipv4/tcp_ipv4.c      | 2 +-
 net/ipv4/tcp_minisocks.c | 2 +-
 net/ipv4/tcp_output.c    | 6 +++---
 net/ipv6/tcp_ipv6.c      | 2 +-
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4c87936a33d6d..ae14aede37621 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1425,6 +1425,11 @@ static inline int tcp_full_space(const struct sock *sk)
 	return tcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf));
 }
 
+static inline u32 tcp_dst_advmss(const struct dst_entry *dst)
+{
+	return max_t(u32, dst_metric_advmss(dst), TCP_MIN_MSS);
+}
+
 void tcp_cleanup_rbuf(struct sock *sk, int copied);
 
 /* We provision sk_rcvbuf around 200% of sk_rcvlowat.
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 502365adc4fab..a1c57976b6832 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1593,7 +1593,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	tcp_ca_openreq_child(newsk, dst);
 
 	tcp_sync_mss(newsk, dst4_mtu(dst));
-	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
+	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), tcp_dst_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
 
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 866055e1b8014..ea63b6da8cbb4 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -369,7 +369,7 @@ void tcp_openreq_init_rwin(struct request_sock *req,
 	u32 rcv_wnd;
 	int mss;
 
-	mss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
+	mss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 	window_clamp = READ_ONCE(tp->window_clamp);
 	/* Set this up on the first call only */
 	req->rsk_window_clamp = window_clamp ? : dst_metric(dst, RTAX_WINDOW);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 67491c2d00476..a1277f1059d1f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -125,7 +125,7 @@ static __u16 tcp_advertise_mss(struct sock *sk)
 	int mss = tp->advmss;
 
 	if (dst) {
-		unsigned int metric = dst_metric_advmss(dst);
+		unsigned int metric = tcp_dst_advmss(dst);
 
 		if (metric < mss) {
 			mss = metric;
@@ -3596,7 +3596,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	}
 	skb_dst_set(skb, dst);
 
-	mss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
+	mss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 
 	memset(&opts, 0, sizeof(opts));
 	now = tcp_clock_ns();
@@ -3712,7 +3712,7 @@ static void tcp_connect_init(struct sock *sk)
 
 	if (!tp->window_clamp)
 		tp->window_clamp = dst_metric(dst, RTAX_WINDOW);
-	tp->advmss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
+	tp->advmss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 
 	tcp_initialize_rcv_mss(sk);
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 89b53801660c6..af9227f12f447 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1379,7 +1379,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	tcp_ca_openreq_child(newsk, dst);
 
 	tcp_sync_mss(newsk, dst6_mtu(dst));
-	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
+	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), tcp_dst_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
 
-- 
2.53.0

