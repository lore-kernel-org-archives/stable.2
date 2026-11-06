Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955375;
	b=b53qldcv5RUT9Vbe3nuZFayB3sAcLZjT8W11XeZR8rxpBvrgfOtG8d7mwZPviccMRUfC
	 qVUz6f6zUvMGb56RyViZw8JieebK6PxP94PJHUcnzpBVWC4P/lj7ABzt7WfqGll9sc5hk
	 ctIRF7j3QSkXRmJDFtEQsytWVEd7LDhx773TwZyNJHZ1fIjzOun2yD+8qFvCe5kEvYUBr
	 7kQ44nwj2eBRylB5wQ2bbibkz+bIiWrJDQvwqhuvx8LSuvYH1tUh+ICmaCL4LNLOL8+w6
	 nlzb4id/DjO014fdG4/qc4TP4r7KbjJG65lsW2r7qXsTdHZrcaPkQXEpCuIF2o8lu8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=1KvSywno3zvw2xlVVsbViw+H+QqK4pYdi2f2DUSowoo=;
	b=PqrZzhDgg7xHrcdAd6fvAATY8WEfSWprN4WuBR1q17BVY9RQyNQ9sgSVVnWKj9s+JOUX
	 HlH4VbUMHfOWk5ROjqNJ6thWFk+jelgB5CoMRnGBktpTRJ8UgWLBZo1yBCVbucdT92v2o
	 0J+gRsv1rmaK/TcFiFLyDQmYQfBhq2aYSyDMLMggYhHhOO4dRBvtx3J8zaWc1+vHctzpv
	 QaLMCsMm8mhNE17kvn7T6+Gntc7T3vLkS1T88oiudgxXLldOI4aKOv9JOipQV+sLgT+4H
	 aMqX5BQo40oOoaEk//zj360lz3CVMy20zU0f8EZx7lEFguozfgP7a8r86QsNOVW5kzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J6oJW51v;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D64606A328
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 08:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55D64606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J6oJW51v
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdab938dc83so161314a12.3
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 00:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793955375; x=1794560175; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1KvSywno3zvw2xlVVsbViw+H+QqK4pYdi2f2DUSowoo=;
        b=J6oJW51vFLKMEVeXgsneWKUDqdBaRj5KddqEL91Owa7K/E+9uV9n3VkU9NI2zcmXuJ
         jAPM2Cs+oIt1juZpcthA5BH75Vvod96fCDpcNli4NWZ4Wi9hpUCXpeGL3GqMlXzPLpbi
         n5DoEFSEsIf0DVO7zGlYhVCqZIkIEhh6bvLM6ZMgCINKBM+WfrJUapVnL1t5/0liNvuo
         laIMOVK8R28F/nh2iYF1GcfUZZT5feUFo12vX869e8tGoqyxWnqUdiH3bSgWQCGpLbRd
         M/65DdOjN5CHoPTSatATVx/GNfj8et+XcoyJ1xCxE+BpeMWDREM6ZaPTzGawUq5+67Dm
         RXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793955375; x=1794560175;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1KvSywno3zvw2xlVVsbViw+H+QqK4pYdi2f2DUSowoo=;
        b=xRwzcceJVWb4meG2y9/vjAe+CjxVddhnqKp5pQUD6oSDoucUiPxU4KoM/b3xeHlzJe
         ZU3SCG7nh9IhWQaWaxisIAPI3VsQpZT9tG1Q9et6b8Hs6njRcQ7KE7Wsz1s+sA/AyqW4
         NLBgBRMRHG9KeN4Wx/stACSWIWIOtpdO5Ck7KclbH99yEXAcmlBzNMYRhauqVuZSJjea
         e9lVLQaWEH4XifYeCZ3U2waLhVZIm/nUyizjrIR7kAM0fMpfLfAQ3MsYNCxz8B4ZzOk9
         kYKMeNK1MCDlqeXtEVbF3VcnYBitKJcx/MJK/wXcVKKbwtCb39kB4z6W03SGGqDG6mft
         JTlA==
X-Gm-Message-State: APuU4Z9o6jarGCfslROqL6WaXJz5oe+WGDnifJWaZvoHGO55N1GKe+hP
	xXFFejbPhPZPE3QoWLI6LSaPodfLIdYBhe4a+MTf8dgdMY4kik3ltqdGhyMowg==
X-Gm-Gg: AYBFou23wW2Vu8nGuzQ3SnEwkZ3mxNI0vIubkJUYDHeZaoQndCmlTa7mvCDfOO/WjhX
	u6hoYhv3c4CYKVQs2iCUWWpYvt+JI+KVVqLisE2qgmjyK2OpFAf7HWNSK9p5BtiU+p3YcNF8Y4m
	+ozX04lZ2g99+WV5NtQD+E2vQfOaIFF+HiYVRw24LkCRHRexjeARc9xEpgdOonWMKwzxNt32ltV
	h0dKa8ksK2rX9On1riES6h5L10GVdZmoQg5VazIhZ7an7zVqE3alcvLV6xc7RgueKP9TJgkOTg5
	q3vGQbcF8eYMHfXq8eiwSF9Rn5wIHDkrSLm8jFBszTMC9bFlus9odPB3/sY79I48+Iw1hZ+tFcm
	S5/8PolIFII8BT5aBi2jn6Z/Vk7H0WYj4OjTPaSVwtIQsICqr3AH7FOKluTORBt4C2TSnOXmuPv
	5BsZUy17LLJr3mCNxZKYPTJd+qtMgTokJreBinuAzk5veNLi1hskHCsVDUYR9Bxs492yqn1+/LW
	+AFoTLB+3o0Sera9rzgjqMkT/eh3qDhtlG2m5Z1SZkRSRJdqwxvwIhUZ9jnaWobppOEWZdxVelj
	Se7/w8++RAB/BmAMorLz6ZcuQ55IiK66pHqy1IZSSmlJ3qk=
X-Received: by 2002:a17:90b:3811:b0:3b0:9976:c1c6 with SMTP id 98e67ed59e1d1-3b0db7019d5mr1725794a91.66.1793955374610;
        Fri, 06 Nov 2026 00:56:14 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7c8a3d9sm3179698a91.10.2026.11.06.00.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 00:56:14 -0800 (PST)
Date: Fri, 6 Nov 2026 17:56:11 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>, imv4bel@gmail.com
Subject: [PATCH 5.15.y] inet: reject unhashed sockets during established
 lookups
Message-ID: <au2WK6rhgkDcs8eu@v4bel>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[ Upstream commit 4e2b3ef19e0e04adca38442f07dd6bc93c712bf1 ]

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
Link: https://patch.msgid.link/20261029214219.1035176-2-imv4bel@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Hyunwoo Kim: Keep the pre-rename INET_MATCH() function name used by
  5.15.y. ]
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/ipv4/inet_connection_sock.c | 10 +++++++---
 net/ipv4/inet_hashtables.c      |  5 +++--
 net/ipv4/syncookies.c           |  2 ++
 net/ipv4/tcp_input.c            |  4 +++-
 net/ipv6/inet6_hashtables.c     |  4 +++-
 5 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index ac9f18861aa7..3bf75aa16dcb 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -939,10 +939,14 @@ static void reqsk_timer_handler(struct timer_list *t)
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
@@ -1226,7 +1230,7 @@ struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
 
 			__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQFAILURE);
 			reqsk_migrate_reset(nreq);
-			__reqsk_free(nreq);
+			reqsk_put(nreq);
 		} else if (inet_csk_reqsk_queue_add(sk, req, child)) {
 			return child;
 		}
@@ -1282,7 +1286,7 @@ void inet_csk_listen_stop(struct sock *sk)
 					__NET_INC_STATS(sock_net(nsk),
 							LINUX_MIB_TCPMIGRATEREQFAILURE);
 					reqsk_migrate_reset(nreq);
-					__reqsk_free(nreq);
+					reqsk_put(nreq);
 				}
 				rcu_read_unlock();
 
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index a7d11b82fe64..e7c7b24011d7 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -383,8 +383,9 @@ struct sock *__inet_lookup_established(struct net *net,
 		if (likely(INET_MATCH(net, sk, acookie, ports, dif, sdif))) {
 			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
 				goto out;
-			if (unlikely(!INET_MATCH(net, sk, acookie,
-						 ports, dif, sdif))) {
+			if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
+				     !INET_MATCH(net, sk, acookie, ports, dif,
+						 sdif))) {
 				sock_gen_put(sk);
 				goto begin;
 			}
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 5a61f9a364ad..941d1629c7ad 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -217,6 +217,8 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 
 		bh_unlock_sock(child);
 		sock_put(child);
+		reqsk_put(req);
+		return NULL;
 	}
 	__reqsk_free(req);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4a481dd4579b..8b8c892810ee 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7069,7 +7069,9 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 		if (!inet_csk_reqsk_queue_add(sk, req, fastopen_sk)) {
 			bh_unlock_sock(fastopen_sk);
 			sock_put(fastopen_sk);
-			goto drop_and_free;
+			/* tcp_disconnect() already dropped one reqsk ref. */
+			reqsk_put(req);
+			goto drop;
 		}
 		sk->sk_data_ready(sk);
 		bh_unlock_sock(fastopen_sk);
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 869173f176cc..dd64191db364 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -77,7 +77,9 @@ struct sock *__inet6_lookup_established(struct net *net,
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

