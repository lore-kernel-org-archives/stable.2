Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284BE31B101
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222065; cv=none; b=re6x/Hnva3wmwsOP6EXXlTYgWpa7nFR2MJ5EDQuYWvNu1rjaATB7CjnfLJHpy1WXHrsSSd4wO7Vv0R1wNXxaNf0AaxzxNYcJGs3umskAnQNn3TfsoUySI7K/MvkK+iZ4u4xA4yaWnPJjrsVLuHpLlOrBt4JuvbfjTKE2euGHbtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222065; c=relaxed/simple;
	bh=uhINTRuo7cuiM6pTH2MQA0l6Lhj0b2UNkGn8ADS/fDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuG80H1g/QxB33K29T5vQVTNXOLFMtZYkNN95I1nSeyfJSWVRrIZcW3hhyxpGc2CBQ9ic9rKf3WLouhxlHxUJBVZUtsQ742xBk66rmyD1DdOe7UIec6LvJr8PH9cLdTRfyh/IiWb6iqNfJPwsmJPCavtB60zBLWcCvccttdkdQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb8Lamyb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb8Lamyb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0111F000E9;
	Tue,  1 Sep 2026 00:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788222064;
	bh=R29Xf+eZ+h4qDqq+bwyDbb4VefyrNNjdFt2ZadlsFh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qb8LamybVSWtE6fieY8Pos/eu3QAVX31V8bHXMDopc6tWDISEOe0BBBvvot5fQmJI
	 PYhAmVZUJK2vSZ2I6gACHyiICIN54ITz3UTz1z7jqT8EgaA4M/UXz3nQBNLKTzQfeL
	 cJ+Z7y5UMtFaAhhwPSfURB4/qxoIOdJuiCSbO6HijVCPfYU9V+BtUL6e9ybj4WimFl
	 YgHpWYIAbiPIdosySQ+hkMJLHld5go8XwQ7h49rfmUOj+o6NgffaE2UCW1zlI+WEKP
	 yk+tEzIVbnkkHrtvhBtIDjooknlwedwUU0jUvIeI8qyo/TFyiMIPIiMzn4U+LNJEwX
	 1ObOJ3xnpACNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yong Wang <edragain@163.com>,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 6/6] tcp: clamp route advmss to TCP_MIN_MSS
Date: Mon, 31 Aug 2026 20:20:57 -0400
Message-ID: <20260901002057.2024614-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901002057.2024614-1-sashal@kernel.org>
References: <2026083104-huddle-balancing-d57b@gregkh>
 <20260901002057.2024614-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h        | 5 +++++
 net/ipv4/tcp_ipv4.c      | 2 +-
 net/ipv4/tcp_minisocks.c | 2 +-
 net/ipv4/tcp_output.c    | 6 +++---
 net/ipv6/tcp_ipv6.c      | 2 +-
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index c9439e7f3e7b8..25bb67e28ad47 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1686,6 +1686,11 @@ static inline int tcp_full_space(const struct sock *sk)
 	return tcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf));
 }
 
+static inline u32 tcp_dst_advmss(const struct dst_entry *dst)
+{
+	return max_t(u32, dst_metric_advmss(dst), TCP_MIN_MSS);
+}
+
 static inline void __tcp_adjust_rcv_ssthresh(struct sock *sk, u32 new_ssthresh)
 {
 	int unused_mem = sk_unused_reserved_mem(sk);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6f8d27035b6fe..dcd7c9f12c253 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1817,7 +1817,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	tcp_ca_openreq_child(newsk, dst);
 
 	tcp_sync_mss(newsk, dst4_mtu(dst));
-	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
+	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), tcp_dst_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
 
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 4ac30573f233f..a496c26737fde 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -445,7 +445,7 @@ void tcp_openreq_init_rwin(struct request_sock *req,
 	u32 rcv_wnd;
 	int mss;
 
-	mss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
+	mss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 	window_clamp = READ_ONCE(tp->window_clamp);
 	/* Set this up on the first call only */
 	req->rsk_window_clamp = window_clamp ? : dst_metric(dst, RTAX_WINDOW);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 479be2f242627..efa533a362e37 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -129,7 +129,7 @@ static __u16 tcp_advertise_mss(struct sock *sk)
 	int mss = tp->advmss;
 
 	if (dst) {
-		unsigned int metric = dst_metric_advmss(dst);
+		unsigned int metric = tcp_dst_advmss(dst);
 
 		if (metric < mss) {
 			mss = metric;
@@ -3906,7 +3906,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	}
 	skb_dst_set(skb, dst);
 
-	mss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
+	mss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 
 	memset(&opts, 0, sizeof(opts));
 	now = tcp_clock_ns();
@@ -4062,7 +4062,7 @@ static void tcp_connect_init(struct sock *sk)
 
 	if (!tp->window_clamp)
 		WRITE_ONCE(tp->window_clamp, dst_metric(dst, RTAX_WINDOW));
-	tp->advmss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
+	tp->advmss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 
 	tcp_initialize_rcv_mss(sk);
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index cedfdf728cd41..9e1db70c20943 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1501,7 +1501,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	tcp_ca_openreq_child(newsk, dst);
 
 	tcp_sync_mss(newsk, dst6_mtu(dst));
-	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
+	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), tcp_dst_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
 
-- 
2.53.0

