Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793310174;
	b=GYEJAjDPSbB0dTuXrvsr+IhBo11Zsw92Uufm0pedBT8EZtozcZiV8g0hA1fMNUDGDXqD
	 F9tLHe3TPKaHSCvJO80aI+jH6HN+oI0WH55Eh/XdPr9LOoUo8Qpq2bFRp/ReTjoVT4/VW
	 MKez6zXdxHA01YVC8xcvjOhzPF/Zikdei9ziT4ijAL7A1h/yeeNaY3m3AnSXJf+HKd8ay
	 It6ZaSAvnLut0eRuqinqpQ3C8vIIEZ5T435cC1Zu08cLxfz/1rbDhkqnr13Wz5qYpndNv
	 TtzlUnze28zagEymJyVUL0BWR8gluv2FZ4MENQSH+Dj39yL9Opjgw2M9kO7gRqR4E8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793310174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eAyiA9QgZobT3nd5rhdF+PimiZpaHhPWsTkdT9gIFqs=;
	b=rPie8Y71jdKrIhA+R9JYqGGJlY1tKBSOdhZbityTotcDOypPpl+B2t8/F2ZlTz/xeu+w
	 YAPGNQcC9rMivv6y7FNZPJ6C/PcqrXrQdIcBJQjc3R/xYvL/7ereGwPrUMKQzk8OKwmnF
	 CQk2JEpayKNO1zbiTVvcb56B5KFCWH+28mmFjBWteVRji2t3ekfYBBFeinq1EMQKta2Eq
	 GY0vXHm4Skituk+v56EHxp0NSqVs0QBPVlF8BiPYdw3DSwtTN64Pe1qEKTo/xz/Mx/6E7
	 ePHzP7jF/bybi+owAXWpc+5uECDy6xz3/JjNFi8QTbTU2yQmTUfYw6Vw9oMZisEuW9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xE8JnwZn;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECD1606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ECD1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xE8JnwZn
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so9254a12.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793310173; x=1793914973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eAyiA9QgZobT3nd5rhdF+PimiZpaHhPWsTkdT9gIFqs=;
        b=xE8JnwZnhMszbBNQGvN2By5StdF2vpqbgDis5c3NtEFAqxYm5zIPnQiYXRJsAg1B5k
         V576iS2ugJ9cwzdqgliRDiQ+S2+lDqNOJtH98IKh2JddCS+jcVyt7AyXbXxW0lf3+DWZ
         qYx13txjGgLkqxO1TsgPUWY5oRfqach+mCfsxiue9LStAe59LurbNluy+Aj4U8Z34Kc4
         LT4q0tRqebYDhqIu/+pEzhmplZoBVOihE4rod/QQp+LBeftgqZqQ/OiKjozG7Lsd+jP9
         INhbxD1VhX+ayeLEfjYR5xutpw+IcemFY9sDZO7Gwqf7H0MBq768QLKvUWur39GUGU8i
         NdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793310173; x=1793914973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eAyiA9QgZobT3nd5rhdF+PimiZpaHhPWsTkdT9gIFqs=;
        b=aNv9g5XOgHO2tegVEwJxkFUU7WgJ+1yi4eqlWoUeCLPm99kDLJvvnN0RLrkuyNoAYL
         fGLp4bzl9ZvflBkip8BRg3qKs127tv6s7/KYx5FoCZ3lFnFcJ0Iflh27GuApzUPLA2lq
         CUR1pGzqf0vvsWvT0cMEGAUlw4R/GDUoooSn+rrpuKhgSuL2wkuwe5yrr6AWiTBKcGh6
         JnCcvYTREk8Z1ZRh71W2fXdUr9eGc0ySh3mfOaclg8qf9Rv1LogS37JyJSBegp7Q6dBd
         NX1WAohfOZOPaEfHJNjioQc45QbS5Sr4SHOqC0tBJ/BW5E8vySY2c889GIePtacOZF9Z
         hjTw==
X-Forwarded-Encrypted: i=1; AKwUvBzkdlVI7rlaBHA14OwAwjV3N9ASYowWUOsnk3yFZFdhvrX7oI4kFUrvD6IuW1DWB7np8M1H2bE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ38GtCh0T1c+Bezo8FsC1i7zv1tO/2NYxvyl86QHFFRMbhdTOA
	FwVKh5AzbiYMyxhNt1XSxSf8EUhafr0HB+WLmdCDWHZKTE/n6DUC6Znm
X-Gm-Gg: AYBFou3SxUauSrvXt/gBT8DzS+69A+ebKtPw/EcaG88ptsg6Ok3ydsgKs2n0VAXaQFU
	yjfFCWUbQ5Zv3x52u/5cx8VjaBe67MoBoaceqswUH4dDg4K3ogGhlVbCFJoQN2tRiz4LoW0O/At
	o8oWAo9IDsfPkmOSDS2Uh1rion5F2drrVZT4x5XbT6jdoVZ87Lbp7joFGDEI+1n0+80KU1sKQ4R
	uRlM6rzG9vo+EBBnfkqtmqSRy6QW5iHjX5GHscbDzN9votAJ0/Wsgx1jOA5g5g/dQ9Y27Rru1z/
	P32czA0wS4bEq9VuKBNKjQTrtAxQFTZvJ2RTVP/n1Qzhc8bqwCSij3a6FLKrVqqbqPD2YBmI+rQ
	1HkqHzKtEX0YhUX0lmAA0+zAEwYEoACYzH2xKqlaEH6sEzh1T8kW1iGfU/pDULK3JideV0CJ4Xp
	n8wyrMNh8ZDD6csysiLiDSxrqTO7ejgVZ3p+fiyq2xM6zExmXyTGlqmZhSwSb4DaD235sQZVFIC
	+OzUQvXUzWtPTnnIMoovhGngvHXfYIxnY4v6cai3dWJkynJB3LQW6WpP7devQgAYmlE1PYhwCod
	ii0pAvpqx3eL3z7VMkrOkfyCWw7A2O9WoGgd/1yxz7o6/WKviWn/ya25gyQQSPy7ZlrXPKB9
X-Received: by 2002:a17:90b:17c5:b0:3ac:7c52:faf6 with SMTP id 98e67ed59e1d1-3ae89574d7emr206950a91.1.1793310172632;
        Thu, 29 Oct 2026 14:42:52 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845ecaf5sm1122486a91.16.2026.10.29.14.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:42:52 -0700 (PDT)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	martin.lau@linux.dev,
	john.fastabend@gmail.com,
	weiwan@google.com,
	sd@queasysnail.net,
	jiayuan.chen@linux.dev,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v5 1/2] inet: reject unhashed sockets during established lookups
Date: Fri, 30 Oct 2026 06:42:16 +0900
Message-ID: <20261029214219.1035176-2-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029214219.1035176-1-imv4bel@gmail.com>
References: <20261029214219.1035176-1-imv4bel@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TCP established ehash lookups are lockless. The socket caches involved
use SLAB_TYPESAFE_BY_RCU, so memory can be reused before an RCU reader
that retained its old address has finished.

After a tuple match, __inet_lookup_established() and
__inet6_lookup_established() acquire a reference and repeat the tuple
check. They do not check whether the new object is hashed. If the
address is reused for a socket with the same tuple, the lookup can
acquire a reference to the new object and return it while its nulls node
is unhashed.

A PoC that drives reuse with a SYN cookie request socket reproduced the
crash. The new request socket is unhashed and has a NULL rsk_listener.
A lookup that had loaded the address of the old request socket acquired
the reference published by tcp_get_cookie_sock() and returned the new
object. tcp_v4_rcv() then read sk_state through the NULL listener.

The resulting crash was:

  BUG: kernel NULL pointer dereference, address: 0000000000000012
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  ...
  Oops: Oops: 0000 [#1] SMP NOPTI
  CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Not tainted 7.3.0-00591-g0e135910deec #1 PREEMPT(lazy)
  ...
  RIP: 0010:tcp_v4_rcv+0x44e/0x1280
  ...
  R10: 0000000000000001 R11: 00000000024ca8c0 R12: 0000000000000000
  ...
  CR2: 0000000000000012 CR3: 0000000103d50004 CR4: 0000000000770ef0
  ...
  Call Trace:
   <IRQ>
   ? raw_local_deliver+0xae/0x240
   ip_protocol_deliver_rcu+0x2d/0x180
   ip_local_deliver_finish+0x84/0x100
   ip_sublist_rcv_finish+0x5f/0x70
   ip_sublist_rcv+0x12a/0x1d0
   ip_list_rcv+0xfd/0x130
   __netif_receive_skb_list_core+0x223/0x250
   netif_receive_skb_list_internal+0x1d2/0x2c0
   ? try_fill_recv+0x39/0x7b0
   napi_complete_done+0x74/0x170
   virtnet_poll+0x445/0x600
   __napi_poll+0x27/0x1e0
   net_rx_action+0x2fe/0x3b0
   handle_softirqs+0xc2/0x2c0
   __irq_exit_rcu+0x74/0xd0
   common_interrupt+0x7f/0x90
   </IRQ>
  ...
  Kernel panic - not syncing: Fatal exception in interrupt

After taking a reference, check whether the nulls node is unhashed in
both IPv4 and IPv6 established lookups. If it is unhashed or the tuple
no longer matches, drop the reference and restart the lookup.

Lookups racing with the TIME_WAIT hashdance, or with a request being
replaced by its child, now restart and find the new socket instead of
returning the old one.

Request sockets that were never inserted into ehash can have a nonzero
refcount, and a stale lookup can hold a transient reference. Therefore,
when SYN cookie, Fast Open, and request migration paths fail after
setting a nonzero refcount, release the references held by those paths
with reqsk_put() instead of freeing the request directly.

Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash table")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/inet_connection_sock.c | 10 +++++++---
 net/ipv4/inet_hashtables.c      |  5 +++--
 net/ipv4/syncookies.c           |  2 ++
 net/ipv4/tcp_input.c            |  4 +++-
 net/ipv6/inet6_hashtables.c     |  4 +++-
 5 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6a30f11384547..bd0bad96c93c3 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1136,10 +1136,14 @@ static void reqsk_timer_handler(struct timer_list *t)
 	 */
 	if (nreq) {
 		__NET_INC_STATS(net, LINUX_MIB_TCPMIGRATEREQFAILURE);
+		/* The timer was not armed, drop its reference here. */
+		reqsk_put(nreq);
 no_ownership:
 		reqsk_migrate_reset(nreq);
 		reqsk_queue_removed(queue, nreq);
-		__reqsk_free(nreq);
+		/* Drop the temporary reference and the one reserved for ehash. */
+		reqsk_put(nreq);
+		reqsk_put(nreq);
 	}
 
 drop:
@@ -1447,7 +1451,7 @@ struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
 
 			__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQFAILURE);
 			reqsk_migrate_reset(nreq);
-			__reqsk_free(nreq);
+			reqsk_put(nreq);
 		} else if (inet_csk_reqsk_queue_add(sk, req, child)) {
 			return child;
 		}
@@ -1502,7 +1506,7 @@ void inet_csk_listen_stop(struct sock *sk)
 					__NET_INC_STATS(sock_net(nsk),
 							LINUX_MIB_TCPMIGRATEREQFAILURE);
 					reqsk_migrate_reset(nreq);
-					__reqsk_free(nreq);
+					reqsk_put(nreq);
 				}
 				rcu_read_unlock();
 
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ba0faa9ae2bb3..58d54965036a2 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -552,8 +552,9 @@ struct sock *__inet_lookup_established(const struct net *net,
 		if (likely(inet_match(net, sk, acookie, ports, dif, sdif))) {
 			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
 				goto out;
-			if (unlikely(!inet_match(net, sk, acookie,
-						 ports, dif, sdif))) {
+			if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
+				     !inet_match(net, sk, acookie, ports, dif,
+						 sdif))) {
 				sock_gen_put(sk);
 				goto begin;
 			}
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 73e1297681847..6440305615378 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -218,6 +218,8 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 
 		bh_unlock_sock(child);
 		sock_put(child);
+		reqsk_put(req);
+		return NULL;
 	}
 	__reqsk_free(req);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 99baf14afdfd8..3583867487d7f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7777,7 +7777,9 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 		if (!inet_csk_reqsk_queue_add(sk, req, fastopen_sk)) {
 			bh_unlock_sock(fastopen_sk);
 			sock_put(fastopen_sk);
-			goto drop_and_free;
+			/* tcp_disconnect() already dropped one reqsk ref. */
+			reqsk_put(req);
+			goto drop;
 		}
 		READ_ONCE(sk->sk_data_ready)(sk);
 		bh_unlock_sock(fastopen_sk);
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index b111b51d69fc9..aa5fa1dd062f7 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -108,7 +108,9 @@ struct sock *__inet6_lookup_established(const struct net *net,
 		if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
 			goto out;
 
-		if (unlikely(!inet6_match(net, sk, saddr, daddr, ports, dif, sdif))) {
+		if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
+			     !inet6_match(net, sk, saddr, daddr, ports, dif,
+					  sdif))) {
 			sock_gen_put(sk);
 			goto begin;
 		}
-- 
2.43.0

