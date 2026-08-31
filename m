Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463A0408014
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180807; cv=none; b=Ty1gLN3hfSiovYT676oT5RBkIOwEiuEaPRqzflDzQ7QXlKdk91gSaUIoVjEXyPBUXb1QXF3liK1W2oNxFv//FW8/UXJAST9O0I+XY6BENCcWNYNGyrdpg4a+dCke5xO7znqkaHmoDm15ZR/KZWZNZbWiQxuacVSP0inxVgNJbVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180807; c=relaxed/simple;
	bh=w0y2Mbqjw4ZONA2z90mSu0qIOeMuha0ciBsTxcONw6s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AsRcQZmO4odBzFSsvi4gLIp/NWlYWDu8fHgddanXBOVZlVMoR8Xbk9KYjYtOQOElNXFJbejAf++EhW/twOAfkhfgi7NXmjLqAZIXpmr1Sd/X9LLPtFkf29C3W6OuH1hYD9xQDm81mlNue7lqjOcTqX1eiYxK/jN76xQVu2FECdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ItHH3lW6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ItHH3lW6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C83E1F00A3D;
	Mon, 31 Aug 2026 12:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788180799;
	bh=54DGzPYjb5CTtakUjsaAumfx0Q0WsE+8GUZ4Emm859c=;
	h=Subject:To:Cc:From:Date;
	b=ItHH3lW6IL9AKWg7j/ybqYT3Z9TE5+jx+K9JMKmGyvcCqxwyZR5My5e5DVWSN7m3x
	 i/YHUhGBhUjhSsDfb5hUqDzVi4z9FgA9sDPgPswnlTLIiG459bfgnrgmiJatl1nqwV
	 bIsViKSiHtauhuMDX7whG2yyhlGsDIgKdD292gqo=
Subject: FAILED: patch "[PATCH] tcp: clamp route advmss to TCP_MIN_MSS" failed to apply to 6.12-stable tree
To: edragain@163.com,kuba@kernel.org,vega@nebusec.ai,weir@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 14:53:05 +0200
Message-ID: <2026083105-defuse-publisher-6b6c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 870a9e42ecc6fe1b8c25d87af043cb0d9c178fe1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083105-defuse-publisher-6b6c@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 870a9e42ecc6fe1b8c25d87af043cb0d9c178fe1 Mon Sep 17 00:00:00 2001
From: Yong Wang <edragain@163.com>
Date: Wed, 19 Aug 2026 23:22:04 +0800
Subject: [PATCH] tcp: clamp route advmss to TCP_MIN_MSS

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

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2c5b889530b5..670c20876f26 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1782,6 +1782,11 @@ static inline int tcp_full_space(const struct sock *sk)
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
index 190c7af4cf92..9f053eb8b46e 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1736,7 +1736,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	tcp_ca_openreq_child(newsk, dst);
 
 	tcp_sync_mss(newsk, dst4_mtu(dst));
-	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
+	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), tcp_dst_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
 
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 12254e6eb2f3..f3fa0b18eda0 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -440,7 +440,7 @@ void tcp_openreq_init_rwin(struct request_sock *req,
 	u32 rcv_wnd;
 	int mss;
 
-	mss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
+	mss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 	window_clamp = READ_ONCE(tp->window_clamp);
 	/* Set this up on the first call only */
 	req->rsk_window_clamp = window_clamp ? : dst_metric(dst, RTAX_WINDOW);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index fcaa04e65189..f2709d585edb 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -143,7 +143,7 @@ static __u16 tcp_advertise_mss(struct sock *sk)
 	int mss = tp->advmss;
 
 	if (dst) {
-		unsigned int metric = dst_metric_advmss(dst);
+		unsigned int metric = tcp_dst_advmss(dst);
 
 		if (metric < mss) {
 			mss = metric;
@@ -3972,7 +3972,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	}
 	skb_dst_set(skb, dst);
 
-	mss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
+	mss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 
 	memset(&opts, 0, sizeof(opts));
 	now = tcp_clock_ns();
@@ -4128,7 +4128,7 @@ static void tcp_connect_init(struct sock *sk)
 
 	if (!tp->window_clamp)
 		WRITE_ONCE(tp->window_clamp, dst_metric(dst, RTAX_WINDOW));
-	tp->advmss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
+	tp->advmss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 
 	tcp_initialize_rcv_mss(sk);
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 9e9155b1b3aa..df9c29eb5c1f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1487,7 +1487,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	tcp_ca_openreq_child(newsk, dst);
 
 	tcp_sync_mss(newsk, dst6_mtu(dst));
-	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
+	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), tcp_dst_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
 

