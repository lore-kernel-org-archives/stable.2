Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AC536894D
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 03:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787542483; cv=none; b=dVz1LXYX8vSsnivzvSkta5ijRHtvlhlN/Mh6DLAis7IiZAoIL4bIn2fqylxs9R9OLG8zuv8bCcJtWsBrMAmJyyyk4EhKQrxNUKo75yv+OZTIFc5bPorIazKkBtfWXXBveOhsYiGFSN7EYOaiz7S08awXjTaIFv6lo4k9avawlC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787542483; c=relaxed/simple;
	bh=1Rvyp0xy3Ragc0E9ZWd9WCRPxmJ4/WJmfFVSVWG1dfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8R8IJUeW13e5juYClTDc5bily4ddH3Xg8w1mIFk5QGTE470Jlj7J0zeeG8lLkZWOg2XvCuYVmM6BfDAYd/ciduISXP4NzIBxbHmy8rtpJ4RWxl13mGcpcJXJAeIlVQDhUB4GG4t4N1Ejk0bYrKYlTvS+kBi/qmmW06h3s+l5Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qPG3jJv5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPG3jJv5"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cace91f112so33359425ad.0
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 20:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787542481; x=1788147281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aOYu1j3wk0HoiBBxP9GSyUREhQRtNv0dyeHn1pEGiXc=;
        b=qPG3jJv5/RrWQmUQZeL6Sc8NbZjMvCCRfGdqxQNwwNUyhoQFiDJb0DLWJY2u9SPXxp
         RTWrrm7JNcke0mM7P2SblSsY/FByFDFgGCqd3BmOb8+I095nAlh/gk1iq4QW9c8RrZTm
         pCo5ibQ5GsWBbnyBU+f/EdXx1loPKKp/ns45Nprmfkbp1oHehOukYsEbmDJrqM5zYv/9
         5IeO6woME+I0LGOIJy8kKJ0+kjEMwjFbKxbpg6KWdSbr69Ai0J0ikEcXDJVopK62UUbo
         rzqcCBQxWK5XF4w5SvRRK9Gw6vyEXdNO2GCLj0X+i6f5oRZdLZziK4aoGyEL2fuTRXoU
         DSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787542481; x=1788147281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aOYu1j3wk0HoiBBxP9GSyUREhQRtNv0dyeHn1pEGiXc=;
        b=oD/1Z3gbFsoWZL2vHEeyVWkCp7wzlzUVlKe9RuxY7Ia8PR6TGGm9dQiGBabMI6pJVk
         mPnqN3V0juGBpJ5VuG65fakWGOvbNhpFX1cg/XpsnmcQgRul9ISXkbn1IT1EeAXglVbv
         vlatkAp5WVdoJDkdha6c54YIQA2MMDN+0KZ5By6bFC3rQkUfjpmYnPQQfLnxorNtCj1H
         RZMEFAqVlX2JFhJISEzzdXJmwbmPpEpzv2Xdw61pr0hAYuEuhA/mVyllBD/O0RppQErA
         Era7anpplZEDoIlAvLWUhH6yRoiUKD5+jSZxuWFX9b9jJI5mbCk1XCelUjQjuqfpiuf0
         DW2g==
X-Forwarded-Encrypted: i=1; AHgh+RrN4gLl7zlAs6kWiuyY1CGbeDBiUBYMb3//8bRAvuaHgr0rW2Muz6WzLawm4q23URUoWrFJLZI=@vger.kernel.org
X-Gm-Message-State: AFuF++mieSdR3VKjnjtoKkhlAsa/JnQ2A6GQfmr0I5hwkAkUwDIci2WA
	+ut6Lf4rv/xK7X7zTJD8p5cHeU/tmgfzyzKMMtsur0AGZV6mJ2lFqVXN
X-Gm-Gg: AR+sD10QlWzRGWld0fonyGC3DX1rLf3DtoVzq9YjN41NCIS+7NplU7KDSm8/wqu3upS
	0CHN3ihO1kKeKTnWWxJqH+dp+TAauj4HXoqODpPMZuY0JC3SYlMZrb9Q627RGX0H0D6OvjnNNO/
	IfLSiAtaf9UMwS0fRF5QhpFQ8LoYjSnJUknDMH0ORPcBwR8hzYGBi2g66o5tCbhQB+OdFLSMWey
	z0XXp0GDf6/or+0g2tBAxzQSu/wDf3Tq2t0QGpwcOGX8luYntZSoqTK+UaStNEoEfg/gTTwG0Dz
	P5mckQOKShP8RqB40nrKLhTNJvXYvmibYAa5vTy2SoEHqq4f8qnzspnl+5+lff/s09azkpM/Iu6
	ZO18+FrHXCbJgPkCJrcC2uAOvsll69bRKat5LxmZfVZrwQGsRlg19RTajBPeyVJf46ZQq0hukLZ
	7CqURWv8TgdHytIlR7Th2dwSzsCBAGP4u08/VI/7mCdweLkfa9pIPp6uVbKbAD5DFQNWeRRFnW0
	GRhZovL5xM=
X-Received: by 2002:a17:90b:28c5:b0:38e:75f3:ad4d with SMTP id 98e67ed59e1d1-395df11a0damr28694326a91.7.1787542481551;
        Sun, 23 Aug 2026 20:34:41 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c8fd34d9sm4227256a91.1.2026.08.23.20.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 20:34:41 -0700 (PDT)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	kuniyu@google.com,
	horms@kernel.org,
	willemb@google.com,
	andrew+netdev@lunn.ch,
	kees@kernel.org,
	jiayuan.chen@linux.dev
Cc: kerneljasonxing@gmail.com,
	ij@kernel.org,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imv4bel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v2 6/8] tcp: fix use-after-free in the lockless listener path
Date: Mon, 24 Aug 2026 12:32:50 +0900
Message-ID: <20260824033331.1084971-7-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824033331.1084971-1-imv4bel@gmail.com>
References: <20260824033331.1084971-1-imv4bel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_v{4,6}_rcv() calls tcp_v{4,6}_do_rcv() without holding the socket
lock when sk->sk_state is TCP_LISTEN. Every other path into
tcp_v{4,6}_do_rcv() holds it.

tcp_v{4,6}_do_rcv() and tcp_rcv_state_process() below it read
sk->sk_state again. A listener can leave TCP_LISTEN through
connect(AF_UNSPEC), and if that happens in between, the second read
returns a different state.

tcp_rcv_established() or tcp_rcv_state_process() then runs without the
lock. If the second read returns TCP_SYN_SENT, the incoming SYN is
treated as a crossed SYN and reaches tcp_send_synack(). When the SYN skb
at the head of the retransmit queue is skb_cloned(), that function
replaces it with a copy and releases the original with
tcp_rtx_queue_unlink_and_free().

The original is the skb that a thread on another CPU is transmitting
right now in __tcp_transmit_skb(). skb_cloned() is true because the
clone made for that transmit is still alive. Once the transmit returns,
tcp_update_skb_after_send() calls list_move_tail() on the skb's
tcp_tsorted_anchor.

In short:

  socket(AF_INET) -> bind() -> listen()   // the socket that changes state
  socket(AF_INET) -> bind() -> listen()   // the peer

  Several threads keep opening new sockets and connecting to the first
  socket's address.

  Another thread repeats this on the first socket:
    connect(AF_UNSPEC)      // TCP_LISTEN -> TCP_CLOSE
    connect(peer address)   // TCP_CLOSE -> TCP_SYN_SENT
                            // another CPU still sees a listener, handles
                            // one of those SYNs without the lock and
                            // releases the SYN skb that this connect()
                            // is transmitting
                            // -> use-after-free
    connect(AF_UNSPEC)
    listen()                // TCP_LISTEN again

KASAN log:

  BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report+0x14/0x140
  Read of size 8 at addr ffff88800a5d1460 by task poc/125
  ...
  Call Trace:
   __list_del_entry_valid_or_report+0x14/0x140
   tcp_update_skb_after_send+0x62/0x170
   __tcp_transmit_skb+0xe33/0x1e40
   tcp_connect+0x1b67/0x2490
   tcp_v4_connect+0x998/0xab0
   __inet_stream_connect+0x22c/0x700
   inet_stream_connect+0x48/0x70
   __sys_connect+0x101/0x130
  ...
  Allocated by task 125:
   __alloc_skb+0xd1/0x370
   tcp_stream_alloc_skb+0x2d/0x2b0
   tcp_connect+0x72d/0x2490
   tcp_v4_connect+0x998/0xab0
   __inet_stream_connect+0x22c/0x700
   inet_stream_connect+0x48/0x70
   __sys_connect+0x101/0x130
  ...
  The buggy address belongs to the object at ffff88800a5d1400
   which belongs to the cache skbuff_fclone_cache of size 472

Instead of taking the lock, keep the lockless path from reading
sk->sk_state again to decide how to process the packet. Move the
TCP_LISTEN handling out of tcp_rcv_state_process() into
tcp_rcv_listen_state_process(), and let the TCP_LISTEN branch of
tcp_v{4,6}_rcv() call a new tcp_v{4,6}_rcv_listen(). Listener processing
does not change. The TCP_LISTEN arm of tcp_v{4,6}_do_rcv() is left
alone, because a socket can finish listen() after the state check and a
backlogged skb is then processed there.

Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 include/net/tcp.h    |  2 ++
 net/ipv4/tcp_input.c | 64 +++++++++++++++++++++++++-------------------
 net/ipv4/tcp_ipv4.c  | 44 ++++++++++++++++++++++++++++--
 net/ipv6/tcp_ipv6.c  | 44 ++++++++++++++++++++++++++++--
 4 files changed, 123 insertions(+), 31 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2c5b889530b556..add438d6561be5 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -392,6 +392,8 @@ void tcp_write_timer_handler(struct sock *sk);
 void tcp_delack_timer_handler(struct sock *sk);
 int tcp_ioctl(struct sock *sk, int cmd, int *karg);
 enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
+enum skb_drop_reason tcp_rcv_listen_state_process(struct sock *sk,
+						  struct sk_buff *skb);
 void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
 void tcp_rcvbuf_grow(struct sock *sk, u32 newval);
 void tcp_rcv_space_adjust(struct sock *sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 0f60a1dbf92746..77af18fba66b4d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7141,6 +7141,42 @@ static void tcp_rcv_synrecv_state_fastopen(struct sock *sk)
 	tcp_rearm_rto(sk);
 }
 
+enum skb_drop_reason tcp_rcv_listen_state_process(struct sock *sk,
+						  struct sk_buff *skb)
+{
+	const struct tcphdr *th = tcp_hdr(skb);
+	SKB_DR(reason);
+
+	if (th->ack)
+		return SKB_DROP_REASON_TCP_FLAGS;
+
+	if (th->rst) {
+		SKB_DR_SET(reason, TCP_RESET);
+		goto discard;
+	}
+	if (th->syn) {
+		if (th->fin) {
+			SKB_DR_SET(reason, TCP_FLAGS);
+			goto discard;
+		}
+		/* It is possible that we process SYN packets from backlog,
+		 * so we need to make sure to disable BH and RCU right there.
+		 */
+		rcu_read_lock();
+		local_bh_disable();
+		inet_csk(sk)->icsk_af_ops->conn_request(sk, skb);
+		local_bh_enable();
+		rcu_read_unlock();
+
+		consume_skb(skb);
+		return 0;
+	}
+	SKB_DR_SET(reason, TCP_FLAGS);
+discard:
+	tcp_drop_reason(sk, skb, reason);
+	return 0;
+}
+
 /*
  *	This function implements the receiving procedure of RFC 793 for
  *	all states except ESTABLISHED and TIME_WAIT.
@@ -7152,7 +7188,6 @@ enum skb_drop_reason
 tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
-	struct inet_connection_sock *icsk = inet_csk(sk);
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct request_sock *req;
 	int queued = 0;
@@ -7164,32 +7199,7 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		goto discard;
 
 	case TCP_LISTEN:
-		if (th->ack)
-			return SKB_DROP_REASON_TCP_FLAGS;
-
-		if (th->rst) {
-			SKB_DR_SET(reason, TCP_RESET);
-			goto discard;
-		}
-		if (th->syn) {
-			if (th->fin) {
-				SKB_DR_SET(reason, TCP_FLAGS);
-				goto discard;
-			}
-			/* It is possible that we process SYN packets from backlog,
-			 * so we need to make sure to disable BH and RCU right there.
-			 */
-			rcu_read_lock();
-			local_bh_disable();
-			icsk->icsk_af_ops->conn_request(sk, skb);
-			local_bh_enable();
-			rcu_read_unlock();
-
-			consume_skb(skb);
-			return 0;
-		}
-		SKB_DR_SET(reason, TCP_FLAGS);
-		goto discard;
+		return tcp_rcv_listen_state_process(sk, skb);
 
 	case TCP_SYN_SENT:
 		tp->rx_opt.saw_tstamp = 0;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 302afe8ebcbcc3..2fa8958380a5b9 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1828,7 +1828,7 @@ u16 tcp_v4_get_syncookie(struct sock *sk, struct iphdr *iph,
 INDIRECT_CALLABLE_DECLARE(struct dst_entry *ipv4_dst_check(struct dst_entry *,
 							   u32));
 /* The socket must have it's spinlock held when we get
- * here, unless it is a TCP_LISTEN socket.
+ * here.
  *
  * We have a potential double-lock case here, so even when
  * doing backlog processing we use the BH locking scheme.
@@ -1906,6 +1906,46 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	goto discard;
 }
 
+/* @sk is not locked here and can leave TCP_LISTEN; do not test sk_state. */
+static noinline int tcp_v4_rcv_listen(struct sock *sk, struct sk_buff *skb)
+{
+	enum skb_drop_reason reason;
+	struct sock *nsk;
+
+	reason = psp_sk_rx_policy_check(sk, skb);
+	if (reason)
+		goto err_discard;
+
+	if (tcp_checksum_complete(skb))
+		goto csum_err;
+
+	nsk = tcp_v4_cookie_check(sk, skb);
+	if (!nsk)
+		return 0;
+
+	if (nsk != sk) {
+		reason = tcp_child_process(sk, nsk, skb);
+		sock_put(nsk);
+	} else {
+		reason = tcp_rcv_listen_state_process(sk, skb);
+	}
+	if (!reason)
+		return 0;
+
+	tcp_v4_send_reset(sk, skb, sk_rst_convert_drop_reason(reason));
+discard:
+	sk_skb_reason_drop(sk, skb, reason);
+	return 0;
+
+csum_err:
+	reason = SKB_DROP_REASON_TCP_CSUM;
+	trace_tcp_bad_csum(skb);
+	TCP_INC_STATS(sock_net(sk), TCP_MIB_CSUMERRORS);
+err_discard:
+	TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
+	goto discard;
+}
+
 enum skb_drop_reason tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 {
 	u32 tail_gso_size, tail_gso_segs;
@@ -2243,7 +2283,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	skb->dev = NULL;
 
 	if (sk->sk_state == TCP_LISTEN) {
-		ret = tcp_v4_do_rcv(sk, skb);
+		ret = tcp_v4_rcv_listen(sk, skb);
 		goto put_and_return;
 	}
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 9e9155b1b3aa75..a2deda9a4258bc 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1556,7 +1556,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 INDIRECT_CALLABLE_DECLARE(struct dst_entry *ipv4_dst_check(struct dst_entry *,
 							   u32));
 /* The socket must have it's spinlock held when we get
- * here, unless it is a TCP_LISTEN socket.
+ * here.
  *
  * We have a potential double-lock case here, so even when
  * doing backlog processing we use the BH locking scheme.
@@ -1704,6 +1704,46 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
+/* @sk is not locked here and can leave TCP_LISTEN; do not test sk_state. */
+static noinline int tcp_v6_rcv_listen(struct sock *sk, struct sk_buff *skb)
+{
+	enum skb_drop_reason reason;
+	struct sock *nsk;
+
+	reason = psp_sk_rx_policy_check(sk, skb);
+	if (reason)
+		goto err_discard;
+
+	if (tcp_checksum_complete(skb))
+		goto csum_err;
+
+	nsk = tcp_v6_cookie_check(sk, skb);
+	if (!nsk)
+		return 0;
+
+	if (nsk != sk) {
+		reason = tcp_child_process(sk, nsk, skb);
+		sock_put(nsk);
+	} else {
+		reason = tcp_rcv_listen_state_process(sk, skb);
+	}
+	if (!reason)
+		return 0;
+
+	tcp_v6_send_reset(sk, skb, sk_rst_convert_drop_reason(reason));
+discard:
+	sk_skb_reason_drop(sk, skb, reason);
+	return 0;
+
+csum_err:
+	reason = SKB_DROP_REASON_TCP_CSUM;
+	trace_tcp_bad_csum(skb);
+	TCP_INC_STATS(sock_net(sk), TCP_MIB_CSUMERRORS);
+err_discard:
+	TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
+	goto discard;
+}
+
 static void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hdr,
 			   const struct tcphdr *th)
 {
@@ -1891,7 +1931,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	skb->dev = NULL;
 
 	if (sk->sk_state == TCP_LISTEN) {
-		ret = tcp_v6_do_rcv(sk, skb);
+		ret = tcp_v6_rcv_listen(sk, skb);
 		goto put_and_return;
 	}
 
-- 
2.43.0

