Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5151C3E7639
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336373; cv=none; b=fqKEKL/Du7a9QL/JMw/CDvaWtnufK3eeGg6Nkmm9JaJ/kLNwD4gLQKAfAsKzE16mXjeRa87ZRVnkVq/A2bnxPfna5T42EruapNe6aSDmN7YQU9VI6EBiYLHg3uwLt6cdossUV404OA+C0vgrxFsTOz1xHjLqFy6yQ6rKvvxBppk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336373; c=relaxed/simple;
	bh=sHMwzA8uo9tE8Pjjgd9lAbbWx8teZZ19CE3XSzFSnd4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uYNO/KXfOfGg8GJauS9t97eAletFLuOHDYNvZO3jvu/8Vr9u2m5ih/8NLAZej/4/3GaX5pYoiAC/8Af+jHRf//oaeP0Rx9P0jZR9rHDix8qRItviiJMs8Sh1xf6rEFcDmLXIfBjG1rxA/9wKyotYcALeMTnJMwH2n0kFuSv8d7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EhW8RVkf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EhW8RVkf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECBB1F000E9;
	Wed, 29 Jul 2026 14:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785336372;
	bh=OVBfSq08Wj7zzPHJrExdIcHJrR5+HFNiLWfziwa6/ow=;
	h=Subject:To:Cc:From:Date;
	b=EhW8RVkfIajm3/K9AsQsJlokJYMvJECVNRueI/F5iK26J4KiOTcBZfRTpiwphxTXY
	 MHVtsyBK7S+l9GsuhD0IMuEhlPd9e1ZQgx7+x2Elgj9l7nhJS+3r0JHxZc1ov0An25
	 /TlhlkxLL154mXxH7O7qOKDGlZu5N7qf7tk58Skw=
Subject: FAILED: patch "[PATCH] tcp: challenge ACK for non-exact RST in SYN-RECEIVED" failed to apply to 5.10-stable tree
To: yangyx22@mails.tsinghua.edu.cn,edumazet@google.com,fengxw06@126.com,kuba@kernel.org,qli01@tsinghua.edu.cn,wangao@seu.edu.cn,xuke@tsinghua.edu.cn,zhaoyz24@mails.tsinghua.edu.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 16:45:46 +0200
Message-ID: <2026072946-try-probe-3f92@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a28c4fcbf774e23b4779cae468e3497a5ad1f4a1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072946-try-probe-3f92@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a28c4fcbf774e23b4779cae468e3497a5ad1f4a1 Mon Sep 17 00:00:00 2001
From: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Date: Fri, 17 Jul 2026 08:14:42 +0000
Subject: [PATCH] tcp: challenge ACK for non-exact RST in SYN-RECEIVED

The SYN-RECEIVED request-socket path in tcp_check_req() accepts an
in-window RST without requiring SEG.SEQ to exactly match RCV.NXT.  A
non-exact RST therefore removes the request instead of eliciting a
challenge ACK.

RFC 9293 section 3.10.7.4 applies the RFC 5961 reset check in
SYN-RECEIVED: an exact RST resets the connection, while a non-exact
in-window RST must trigger a challenge ACK and be dropped.

Apply that check before the ACK-field validation, following the RFC
sequence-number, RST, then ACK processing order.  Factor the per-netns
challenge ACK quota out of tcp_send_challenge_ack() so request sockets
can share it.  Use the request socket's send_ack() callback and its own
out-of-window ACK timestamp to send and rate-limit the response.

Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Fixes: 282f23c6ee34 ("tcp: implement RFC 5961 3.2")
Cc: stable@vger.kernel.org
Signed-off-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260717081443.809393-2-yangyx22@mails.tsinghua.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6d376ea4d1c0..2c5b889530b5 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1974,6 +1974,8 @@ static inline void tcp_fast_path_check(struct sock *sk)
 
 bool tcp_oow_rate_limited(struct net *net, const struct sk_buff *skb,
 			  int mib_idx, u32 *last_oow_ack_time);
+void tcp_reqsk_send_challenge_ack(struct sock *sk, struct sk_buff *skb,
+				  struct request_sock *req);
 
 static inline void tcp_mib_init(struct net *net)
 {
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 61045a8886e4..daff93d51342 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4038,24 +4038,17 @@ static void tcp_send_ack_reflect_ect(struct sock *sk, bool accecn_reflector)
 	__tcp_send_ack(sk, tp->rcv_nxt, flags);
 }
 
-/* RFC 5961 7 [ACK Throttling] */
-static void tcp_send_challenge_ack(struct sock *sk, bool accecn_reflector)
+/* Consume one slot from the per-netns RFC 5961 challenge ACK quota.
+ * Returns true if a challenge ACK may be sent.
+ */
+static bool tcp_challenge_ack_allowed(struct net *net)
 {
-	struct tcp_sock *tp = tcp_sk(sk);
-	struct net *net = sock_net(sk);
 	u32 count, now, ack_limit;
 
-	/* First check our per-socket dupack rate limit. */
-	if (__tcp_oow_rate_limited(net,
-				   LINUX_MIB_TCPACKSKIPPEDCHALLENGE,
-				   &tp->last_oow_ack_time))
-		return;
-
 	ack_limit = READ_ONCE(net->ipv4.sysctl_tcp_challenge_ack_limit);
 	if (ack_limit == INT_MAX)
-		goto send_ack;
+		return true;
 
-	/* Then check host-wide RFC 5961 rate limit. */
 	now = jiffies / HZ;
 	if (now != READ_ONCE(net->ipv4.tcp_challenge_timestamp)) {
 		u32 half = (ack_limit + 1) >> 1;
@@ -4067,12 +4060,49 @@ static void tcp_send_challenge_ack(struct sock *sk, bool accecn_reflector)
 	count = READ_ONCE(net->ipv4.tcp_challenge_count);
 	if (count > 0) {
 		WRITE_ONCE(net->ipv4.tcp_challenge_count, count - 1);
-send_ack:
+		return true;
+	}
+	return false;
+}
+
+/* RFC 5961 7 [ACK Throttling] */
+static void tcp_send_challenge_ack(struct sock *sk, bool accecn_reflector)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct net *net = sock_net(sk);
+
+	/* First check our per-socket dupack rate limit. */
+	if (__tcp_oow_rate_limited(net,
+				   LINUX_MIB_TCPACKSKIPPEDCHALLENGE,
+				   &tp->last_oow_ack_time))
+		return;
+
+	/* Then check the per-netns RFC 5961 rate limit. */
+	if (tcp_challenge_ack_allowed(net)) {
 		NET_INC_STATS(net, LINUX_MIB_TCPCHALLENGEACK);
 		tcp_send_ack_reflect_ect(sk, accecn_reflector);
 	}
 }
 
+/* Send a challenge ACK from a SYN-RECEIVED request socket. Uses
+ * __tcp_oow_rate_limited() directly so that an RST carrying payload
+ * cannot bypass the per-request rate limit.
+ */
+void tcp_reqsk_send_challenge_ack(struct sock *sk, struct sk_buff *skb,
+				  struct request_sock *req)
+{
+	struct net *net = sock_net(sk);
+
+	if (__tcp_oow_rate_limited(net, LINUX_MIB_TCPACKSKIPPEDCHALLENGE,
+				   &tcp_rsk(req)->last_oow_ack_time))
+		return;
+
+	if (tcp_challenge_ack_allowed(net)) {
+		NET_INC_STATS(net, LINUX_MIB_TCPCHALLENGEACK);
+		req->rsk_ops->send_ack(sk, skb, req);
+	}
+}
+
 static void tcp_store_ts_recent(struct tcp_sock *tp)
 {
 	tp->rx_opt.ts_recent = tp->rx_opt.rcv_tsval;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index ddc4b17a826b..6ab3e3a0b431 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -833,7 +833,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	 * elsewhere and is checked directly against the child socket rather
 	 * than req because user data may have been sent out.
 	 */
-	if ((flg & TCP_FLAG_ACK) && !fastopen &&
+	if ((flg & TCP_FLAG_ACK) && !(flg & TCP_FLAG_RST) && !fastopen &&
 	    (TCP_SKB_CB(skb)->ack_seq !=
 	     tcp_rsk(req)->snt_isn + 1))
 		return sk;
@@ -872,6 +872,16 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		flg &= ~TCP_FLAG_SYN;
 	}
 
+	/* RFC 5961 section 3.2, as clarified by RFC 9293 section
+	 * 3.10.7.4, requires a challenge ACK for a non-exact
+	 * in-window RST in SYN-RECEIVED.
+	 */
+	if ((flg & TCP_FLAG_RST) &&
+	    TCP_SKB_CB(skb)->seq != tcp_rsk(req)->rcv_nxt) {
+		tcp_reqsk_send_challenge_ack(sk, skb, req);
+		return NULL;
+	}
+
 	/* RFC793: "second check the RST bit" and
 	 *	   "fourth, check the SYN bit"
 	 */

