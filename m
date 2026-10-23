Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733192;
	b=WFF7QGkZJtvHYnswppZgjxUDkRnfxoSjCEGWoUyiL2XhnLxzPDu5qzwTuOpAoj0H5XsT
	 jzgj70tNeuL5sCldNL4Y3yc8nCYnqFuFc3UYtBlQIY4Nu2W2h/xogo/uwdChHutI5PKAu
	 t3pbA4+Us1ztNC2sijgppt/wu49/0wA+779YW0K5seArqNVIe+sfIyawu1uPA1Rmbtkws
	 kqMG6mCb/5b68zTgtSjk+PjtNYXH+lQVaKB6uRvJ73sLs/eK9RB+T3eQzT/XRlPj8hb4s
	 +1cf3X9Ge4qyohrFoBtlcKX/1wd3ZlTCW6Yz/tWYFkdVjhKtjtELztyK0LVQ5mP3F8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DYRpzX03doBjGv7jHtksL3nee5Jdp9ptv1S4kZpfi8A=;
	b=yQ4hKB2L3/cpNRWbK3eXfswiAiHdMhR36dysJtyoc2MIOWeASEGqhJ4xmHzP7h/PgNtC
	 fgjidHcTkgXp8IbCxqun+Dd+JROWWuWmq4czyNKtIbsjqaN4dlrsz6cjLvNRsTMF6oY0T
	 R66KYAJezcWu1Y07AvaDxbgCPZ3orC4GKFwUWEt4G7y1pLXXPGV8TF0yDcpDh/xWbTJRx
	 xlPm2idyd7KvHT9BgFksY262YFFG41+YEfJh6UhJgUex+ZsF9Mp1jdE7R7MTNiz01e/YT
	 lv7hRdhy2id4V5YFZ8o633BZ6DeY1Sf4Q0a5ndKkTQcN477gSK2FtM1QHnUO1NZUy5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mlkb73w1;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DA6606A319
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 05:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0DA6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mlkb73w1
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3a4cdc9025bso301036a91.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 22:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792733191; x=1793337991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DYRpzX03doBjGv7jHtksL3nee5Jdp9ptv1S4kZpfi8A=;
        b=mlkb73w1/MRE+o7wyXDGjmIywPB6+MogUPLqg859YAtoYmSBn6V5YeBhnPSiELCmVg
         zD0tva58FWkzcAYsHjm9rXxwHgCegk4gaeNApi5E7uPbp6cFYc9B/w8tnQHpH769zZ0F
         fBCWMh/XcNQGZcnNDu0w+3uXH94DGPiITDjy7cZLyjG1VBChdMjYtkWycU7Vv1OWX+dJ
         JyPxevkM9WAmL9Hec73TZTfEZh87p8YAtxd0Z/6Ra2DojpOW4adbIk/DgyYtYAr19eE5
         eAZrPES/nMTHA0t+qNvxe+RiKhGGs3xvz4N9hc3R0is/tUjgaLknBiSoyb9NoEnqf/oR
         Subg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792733191; x=1793337991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DYRpzX03doBjGv7jHtksL3nee5Jdp9ptv1S4kZpfi8A=;
        b=aaMlaCNmafWdkAaHfoltt4ewDjKA4H1jycH2e9TTZWoynJV73DCpclNxNHg4up76hv
         UqCNH5aVmYmayHyAdsojkovK4UE6T1WWtckMe9n6ETBpn1ezOj+lVCTDLtDRXNd5PjpJ
         C9Y3XcOHipuUmR9kfoHSe/bQK/wZfF0N5seYd5kmvtukWNViQLgzh0od2MmqbyH5qHn/
         uWZBzkRrwL3PsTka+xspbfoHtt0s2U2vzLYY1JBzZ5mAEYVW1k4cjNnMK1YIoJyXYS9Y
         2q9kkq3N3Qo16//f5tmoaTgiH5e832QW9Yb+adilfrM59sTSaxReM0SadfYUEvaBClJ0
         BlXA==
X-Forwarded-Encrypted: i=1; AKwUvBxd9oOh8EIyscs66zaKk8B2Vp2PKgiL1daK1OdfzWpj+QmSOyx9lKy21sKfUAzDLn6fEhMJKwg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKa/1nepQgPSL03YblsJFAQdOGCijYtw0C41HHqapUjVe4PEvfx
	EMPKMctqqmFtvK7NgXQjbeK2JcjLFQ/S6IOYk7FJNzBg80WM+8DSb72/
X-Gm-Gg: AYBFou01XtJcj3MYOwL2W/V52tEyI4eWtkR3Qu+Gbywuzy0FOF91kLuq80n5p7Q/kML
	tfdIPp1OX6c/VGKPrKU89ZJ5WLClnABCrA5jIcUROn674BtdWjtbmknnss+KEce8TPNiYvVIej7
	YkJcNA15yi9A4gYbXCcV1r9uTWPIYUry5nDKD3NBYYEB8wHXL193hAV+Gn/U+smAqjP6CETIXD1
	bHRrSRC3pqlTFOI1iQlylDgESYlYUCQ5mW650STp+PVoTk7CDvw8QZYPWzcIzLUiP1E7nz4E6ql
	Mpkp90kf01SX6Y7P5G4dPPylaWuBQI+38/42TMlyBJa35/7R/LVQ48Flar6l0sFSCBv2cAPtYd4
	0mmRZ36Z8D3+lfj0w23xeCnBC4+qD5XQSVtSHbAU3RMjgHC6lnGWrLgHjMc9hIu/pZerQaWgmoB
	io2tv8xjPIIWYES45SdvItuKwRKZr5t1FhpTyO8AA/VrqapZN2MPm1gD1R4vFY+fQ/d805IdgDX
	GISYfjjyZdlvKy7XSE2bu5C6jDHfEsJXnKTRJZbbhh5illwmhLxsTE4xcW36m30MrfhY7s2FlJI
	yA==
X-Received: by 2002:a17:90b:35cb:b0:3ac:7874:639e with SMTP id 98e67ed59e1d1-3adce45ef04mr868308a91.46.1792733190475;
        Thu, 22 Oct 2026 22:26:30 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4890c56sm7379785a91.2.2026.10.22.22.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 22:26:29 -0700 (PDT)
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
Subject: [PATCH net v2 1/2] inet: reject unhashed sockets during established lookups
Date: Fri, 23 Oct 2026 14:24:35 +0900
Message-ID: <20261023052542.3505250-2-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023052542.3505250-1-imv4bel@gmail.com>
References: <20261023052542.3505250-1-imv4bel@gmail.com>
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
---
 net/ipv4/inet_connection_sock.c | 10 +++++++---
 net/ipv4/inet_hashtables.c      |  5 +++--
 net/ipv4/syncookies.c           |  2 ++
 net/ipv4/tcp_input.c            |  4 +++-
 net/ipv6/inet6_hashtables.c     |  4 +++-
 5 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6a30f1138454..cff02f4c5ac8 100644
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
+		/* Drop the ehash and temporary references. */
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
index ba0faa9ae2bb..58d54965036a 100644
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
index 73e129768184..644030561537 100644
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
index 99baf14afdfd..3583867487d7 100644
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
index b111b51d69fc..aa5fa1dd062f 100644
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

