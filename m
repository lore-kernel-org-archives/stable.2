Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AA347CC69
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261069; cv=none; b=rIIRKkR1i1RuyDfISMIe0AIJb426e1bdtrznudyxZ+CW4a7K9llYIBtgKXyg3uVPhjmqGmL14vVOvblumN1jIo9Vhk6meqOtYnIs/W7okEcI8zD7tOzpfSMDXEEzPPIWyBPKAZPFVNsn+WDDTF0uxtI3HTUC/bSsKHO4JZGrhgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261069; c=relaxed/simple;
	bh=N2MoyBygp87+Z+NIDiAMWXLDR+LZmdoNUaOgOhHks5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Df8yD3FiBIzwmeogqP1aPGWCmepeGXQ4271ivjdYuEWvCYHKm+oMU11IHC14VxhXWq6RzFm7YaUDgWVgjAaAg3GR+UucDsRdskMSU8DqxnZOAdOKJRAToCJI2RwbdR+2YiEV+EGv92t3X/a8XGRJhQpRrL1m1VQi3ojKm2lAdMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeq3PS5z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeq3PS5z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4901F00A3E;
	Tue,  1 Sep 2026 11:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788261064;
	bh=zMZRUrOisQ40LTXfqy79z/aZ8xo27jnrhzPmjIrvQRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oeq3PS5zdjT9QWhklBacSxzFmCh4gY54X2wJmcmbN2I/nHYZIRn2OFubSqUZLCaCy
	 cAB8n6q638qoi7kAU4lTxlYVwOijHRyZFBigx8L7wIFmWDLOH2+JL0EjcT+u5S3iVI
	 xPbjH9fsr0yA43KiKEe39foTEalkXz31kvSZfLKPSZ8ELqCRMeW8zB+hctlDd4eMwZ
	 eQ+lbZCQwxUwSWBlfSpxcxqmJvNIsQQrfLOv7E9Pc+1BeQdlQL5OHv8MWz18+xHAfX
	 TQt9rZn2jalb3azHVLatjg749X3TFubhgqQ3h0f4kWXsM+NgCC4aA1LII8SgZ+Sosy
	 Xk6iFCL/LFmwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yong Wang <edragain@163.com>,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 6/6] tcp: clamp route advmss to TCP_MIN_MSS
Date: Tue,  1 Sep 2026 07:10:41 -0400
Message-ID: <20260901111041.4174429-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901111041.4174429-1-sashal@kernel.org>
References: <2026083105-defuse-publisher-6b6c@gregkh>
 <20260901111041.4174429-1-sashal@kernel.org>
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
index 1cc25e0b3bdea..e027de99d48c5 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1560,6 +1560,11 @@ static inline int tcp_full_space(const struct sock *sk)
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
index 4d2debf02cce7..bf52dfb153073 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1800,7 +1800,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	tcp_ca_openreq_child(newsk, dst);
 
 	tcp_sync_mss(newsk, dst4_mtu(dst));
-	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
+	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), tcp_dst_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
 
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 7149ddb098409..b04c0cea7093f 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -422,7 +422,7 @@ void tcp_openreq_init_rwin(struct request_sock *req,
 	u32 rcv_wnd;
 	int mss;
 
-	mss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
+	mss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 	window_clamp = READ_ONCE(tp->window_clamp);
 	/* Set this up on the first call only */
 	req->rsk_window_clamp = window_clamp ? : dst_metric(dst, RTAX_WINDOW);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 296102ed4a96a..4e23991c797c0 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -127,7 +127,7 @@ static __u16 tcp_advertise_mss(struct sock *sk)
 	int mss = tp->advmss;
 
 	if (dst) {
-		unsigned int metric = dst_metric_advmss(dst);
+		unsigned int metric = tcp_dst_advmss(dst);
 
 		if (metric < mss) {
 			mss = metric;
@@ -3764,7 +3764,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	}
 	skb_dst_set(skb, dst);
 
-	mss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
+	mss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 
 	memset(&opts, 0, sizeof(opts));
 	now = tcp_clock_ns();
@@ -3918,7 +3918,7 @@ static void tcp_connect_init(struct sock *sk)
 
 	if (!tp->window_clamp)
 		WRITE_ONCE(tp->window_clamp, dst_metric(dst, RTAX_WINDOW));
-	tp->advmss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
+	tp->advmss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 
 	tcp_initialize_rcv_mss(sk);
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index b6190f09551d5..57b98ba0d9adf 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1502,7 +1502,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	tcp_ca_openreq_child(newsk, dst);
 
 	tcp_sync_mss(newsk, dst6_mtu(dst));
-	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
+	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), tcp_dst_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
 
-- 
2.53.0

