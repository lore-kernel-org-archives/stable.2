Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955268;
	b=jccC8M++FXXbIndUkjW2XYY86zeoYTcd1rBW92KdDNKuhhx5B1beYjRQ1Vr3rnT6nFJ3
	 BeITuZbPFDMKmbPxyoCx8f65/O6r3NsWmdrQBKeluy/g5OSQf4GCBHTDxAyhIlgIj4kOq
	 Wsnj7ssCqPEaiqGC27S7JLii+QpSGH1EYwDECqVJvs8aRHIXLImEu5Tz7on3z6hLOfNz6
	 xtuwCqS8Afc5xWyYvGJRAycZ3SHoquNaBmCNqgqI4GiEhnjgApwicXPISZsRPQMhTmx+v
	 k3v8DGw1nMAFJANnVZ8bI0mSLg67qkYN3FFVWex/DSQ9SjsFUoWKTqEbetN/HoHpWNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=sUzcAlOh1tDnLyf378WJT7o2uJV2q4YP9q2EG+2XQHQ=;
	b=XM/LA5pdJAJ8EER5PFwbpFKViYkwvSeRKYN8jkJq4dDL/YStTJaVVeXULR1GjT2EC3dL
	 I+cnOIwY4BhSS5WOV/37pAw39eHQwZortaQYTMOI/EC4Qzf9/zxdaoDcka+iZ27k4kDZy
	 w/qZta5JSxiWe0Jbtg7Z+WYNcGjlPSWvLsRh+qvYh/ExrqNRX1agUnjEuWuzZJH98ljau
	 yQ9C+ofpbu4564+SE8TmvUg6qxw1PV+kTt/XOIiiq8QhrOfF6OLE3nFSjBlvW7I95Vq7c
	 sn/9/WSd8R0Wpsn7YsbyYV977vGURSLhqg1LXlKpJkdGxYaF1mYYqta8e7Kf07pDIpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qvcPuqaQ;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716A2606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 08:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 716A2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qvcPuqaQ
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ea138a3497so2235515ad.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 00:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793955268; x=1794560068; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sUzcAlOh1tDnLyf378WJT7o2uJV2q4YP9q2EG+2XQHQ=;
        b=qvcPuqaQznkzhKYZ2ctsJE2BEM/GBHUKzR7e9wY55jJznRyirGQR4w0JXCk2VTZEo/
         EQVKcTrUxXMkAwKlbIX+7JLnsJROPP5Q7XYcTWO8NqCrXYOiIiOVQVcU/3glmNClsxFC
         GWQSh52U3DFDz4j8LSj1NEoygD4THPZaBR54Orlq+FWL3ZeiSi+ykquSCTB4Qbn1jK76
         OhIF946rTmZfI24ccWa0lAtyx/UR8H/q13rq/Gt0nU2yZQ1OR6sxidGPNCA+fa8QyobB
         cWy5jgZuINr8lf+A99wo/aqyZPzYnJ+DToUqHShanCOAwGX011xr0U0zFN+ATfo6jU4c
         I+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793955268; x=1794560068;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sUzcAlOh1tDnLyf378WJT7o2uJV2q4YP9q2EG+2XQHQ=;
        b=ILgRAr8FV0lGDIycHu2CZo9jISBKoaXZNZbYS3mtFhWAPS017o66ThISIehfRprma0
         18nPsGnk/2PpgiPV5QsiwqvdRWbvObV3Nlh57PMIfvA0B4hkrg96oR24afu9g6Uic7l1
         A586QoKW2TKyU6PhI3ImIa9bqEC+Z4sv9VzLhaI1Qnur149Zwm/VFj8OBhqqahLHd5Wn
         oA4XR5c0y9meNeC/9TSPGvUMiMx/EREUe16bZ4zrDix23w4zCc/14eQ9N8TP7GZQaMC+
         dI2erq59ACseuI/Lwai0ie2krQOljZ5T9+WHN8S5/P902TdbeySEYbAdy4/QcBM6bNQq
         0EpQ==
X-Gm-Message-State: APuU4Z/yseGvcxzeUgjBT8d4IpultHnGD0dM5TnvhOVuQkDOGEQMUeoQ
	aFiQdLfBKBbBIu8Ya6e4MD/OwdpujV9rFd3jnTTX7mI5xLLQ5Pnr3KhcEjTF8Q==
X-Gm-Gg: AYBFou3BE+LGIBPlKwtSlFIOSeveJEOSgGFhjheKQfso264rMBKn76PRH3fFJ6Q55+r
	1wfLMUgQaOwWaI+iCMmnJnIEXqqBR/r57t9nAQTNT+S4w1eK2b8dyIFLHFWk9F9iBl33SUuAHCW
	ajQcWlcoaK1i5jw4EyriCpUvlh1KGyh/2EEwD+hJGBWr9o22Kz1E115m0imB8DxIx3YmJiYhoSs
	NecVlhHDfBrj2PJ/RbD5HQmSaE+UEjj89rdzh0QrE3LYmidOazrUMn9hEKc9bP0Zus/wnXeEQVG
	c16Q9D0B4Hhoe6JD0oy/1Zvj4Nhhxi+ExOnwm3k9pnn3rwHoQnbEESAkPEyp0uvvGZ6frUoj4Nq
	jQnN06PzO2pCqrZOvXO3XLBMw7HxdXdjqWLhzpLEJb51/1lBZw3/BnevB3xPDAeiIWZd5BtlxHv
	5Ws2Xtt93owlOxnkTDAZKWUaAN9NFEO3ZiZbrMVD/8hQAjng6qEFk3VSjv5i9nOyp8Q6X2k60XE
	/ATDAprznfHN2M+A9qMwa1o56pB29mDd4Ww3ZaEox+6z0tLGVj9W9Zf39bNvQDgwlwZzTzCe9ot
	BABJerrPh4JwlQyHuswQUOVEtAB3ojXICOwsb+SlUbAJEPXUX85sx2kU9UkmQ+59O95r
X-Received: by 2002:a17:902:e842:b0:2e9:8510:6acf with SMTP id d9443c01a7336-2ed40bda58emr24299815ad.25.1793955267572;
        Fri, 06 Nov 2026 00:54:27 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d3fd77sm3227575ad.27.2026.11.06.00.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 00:54:27 -0800 (PST)
Date: Fri, 6 Nov 2026 17:54:24 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>, imv4bel@gmail.com
Subject: [PATCH 5.10.y] inet: reject unhashed sockets during established
 lookups
Message-ID: <au2VwORvjv7XG64y@v4bel>
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
[ Hyunwoo Kim: Request migration is not present in 5.10.y, so omit the
  net/ipv4/inet_connection_sock.c changes. Keep the pre-rename
  INET_MATCH() function name used by 5.10.y. ]
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/ipv4/inet_hashtables.c  | 5 +++--
 net/ipv4/syncookies.c       | 2 ++
 net/ipv4/tcp_input.c        | 4 +++-
 net/ipv6/inet6_hashtables.c | 4 +++-
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 9b7c84524527..ff5c972d7dea 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -420,8 +420,9 @@ struct sock *__inet_lookup_established(struct net *net,
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
index 29fb93cb3228..c9eed9bb4b15 100644
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
index 111d582dbba3..58e92af1398e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7009,7 +7009,9 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
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
index 21b4fc835487..69aefbae1712 100644
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

