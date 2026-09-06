Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8142D22126C
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 03:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788663876; cv=none; b=sQvnAPUbxr1FuZmLZGSQHyaDzy0kYaFaLfvkG1tyxuctGH0+sYtOcUM242c3IYOvxOgLInwqdmSBm3txwOnfEgl2IN8x/4FioPLnEeKhdYhCHNPavtlwhZqDmGxUFzh0LP8p+X48HXXS7uNKRsVRYBX9jVSov43+Vc8AWz5ZoHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788663876; c=relaxed/simple;
	bh=G4GRjeZ7ZuoicUEADUkv/wpoQdlO4Nb1xEV5wlPJtDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q1d1RV1SO3jX/4hcgIHOvUL48GP9pGjzpJv/6vE07yPEPkTVLKAmRPDcKtumGDeKhmrCFWBoBS2SiNLC4HE5YzINjWqv8OkJXaWY8hvhKnV67hoq6b83K3zYnhq6RX7OBk4rHqNL65glx2rLrfT1mxG3wFdPNUXW9SQF/l3KpHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=ploXi4lL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="ploXi4lL"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d94c868ea5so24298065ad.3
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 20:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1788663873; x=1789268673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MRZI0fpRvwpo1rk6Yx6qBeQUKH3Q/bkR9HOdevrf27c=;
        b=ploXi4lLxCo3J+wV8CR95cZmee7gy8eVm3sgEwigbFUe6ByNHjo9N6L9OOC7ou1rIq
         n+lhWH41a+jFm7dCkSmImkP3CkuiuqVvBocZEvQZ97iMs3AcdXZC577so68uQ7aMx0nx
         kuGy18oOOmSjVev83G8uEBqm67ZLql7gk4aTSDb1IUBhO3t1LnLFi4nXd8Ow2pMWZyPn
         73E+zl2mMKDYJDv6OP0h2h56lnzyqDco2ZXHq2fkrRhdS38C1WAFYu+Qh7Wfdn+xPDYU
         uRK2ye9veXNNGGFNgz4ebD7P5jvJXj2iGIfG+/qbOnZexdFHa/jdtb3WziNBgXvMNaxv
         rXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788663873; x=1789268673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MRZI0fpRvwpo1rk6Yx6qBeQUKH3Q/bkR9HOdevrf27c=;
        b=WxIl2YLXiIqNSuWU9mrqrY89ZM6Lq3Cwj9tlVT+jNakwMpm9/mrxNAqBzzgcZVTHsU
         aWoUpZ1itCOYbLX7RX+u06S7U7xhqwFww0oXw1q+zKEA/y/jYLRMNGaKkDDyF2LnlzbN
         712Jf7sEJilNzqoSwDcd/ejnKRwzT7OyWYa9a6REz40LKskJVUvJ/ge+OedoyLdvsxmc
         GCZQvifsu3ahBlW+drFvKhqvJa7ec9CXYDdA+Pf25rngZQSy1Po6BXeVEtbCNWA9Maa5
         oOKdK4yAz+NMUBUdr+WQnkKkVCKp95wcYKTunpwczkgeGkKN36lyvwAnm7PgzkbXvUoA
         JOoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwBtUc1v6nOptz8uUZU7C8LlIBMwGAJxQyr5J7LdV7omVdZHmFh/pCNQ9sH9wBzgQ7FVFxUHas=@vger.kernel.org
X-Gm-Message-State: AFuF++nEfu+4bBfxl62+6MKYdrOX6XRv1sWNzHF4Dar2vSnr5po0K/en
	5eqqheMKs0HmINCVndYHU9vDGumTqaMEkpx+v+HeUxKjp03RvwkDfhX+4Z6jDNK1Ow==
X-Gm-Gg: AYBFou0UvBmCLGbsDie+SR5y5rg2yXBfWjslMiaQVAPkTgRyLxVzAzy6g3TG52aL28t
	/l/zHAR2eJ6NxpI6sZdH7GClLuRckQqktJrCKpEJ8MyaXTWffbkZUOpiooops81gPQ3R1HjQ2WX
	3BMCz585zV33Fp9MrzLzlqyVGvjcKxPQ8fsCE0cw+GaxbQ6ipa85mBnfVcL2by0NH+VJk6q6ryU
	8J3D7hTk6GY+q34tncxmg+883Ubj+ZHJ6WS8pEp96vn86QoJUzuDaHrBJCe0XTRbtSBbjUFubTX
	SGJEGeusCjQ8lM9vzQBeK2kQgk1O19N71VOCEXknClA1WXMxcD9dAe8p8rHPy5bZow6UKvTVl05
	Tbhtpxd+Jb0GPeVWY5IYFDRyLn8oUD8IjxVNIvl3QOcTkHEIZcjHZm0cP+j56SI4zaRN2Qxx16j
	q3yEe6bh2NhPS52DD5da6U1qHAlDGkpFNOv0Jd/zChORPRYQoeLgO/TdDVmaILvGmBtLKpV7xvt
	b+MJj1KJeOlcOIcRtqZpKZp
X-Received: by 2002:a17:902:ccca:b0:2c9:aae1:a61a with SMTP id d9443c01a7336-2db127cc2afmr230738585ad.14.1788663872960;
        Sat, 05 Sep 2026 20:04:32 -0700 (PDT)
Received: from p1.. (129-219-8-31.nat.asu.edu. [129.219.8.31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33688cfc714sm1493584eec.20.2026.09.05.20.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 20:04:32 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Salam Noureddine <noureddine@arista.com>,
	David Ahern <dsahern@kernel.org>,
	co+2c72469dbbec34af@bugs.sh,
	stable@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v2] net/tcp-ao: don't dereference NULL current_key/rnext_key
Date: Sat,  5 Sep 2026 20:04:28 -0700
Message-ID: <20260906030429.2085375-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TCP_AO_DEL_KEY with del_async=1 is accepted in TCP_LISTEN and NULLs
current_key and rnext_key; tcp_ao_connect_init() clears them on a
reconnect.  Five readers dereference them without a check.

tcp_ao_time_wait() leaves tp->ao_info pointing at the tcp_ao_info it
hands the TIME_WAIT socket, and tcp_done() skips inet_csk_destroy_sock()
on the tcp_fin() FIN_WAIT2 path, so the full socket stays in TCP_CLOSE
with its fd open, sharing that object.  An unprivileged
connect(AF_UNSPEC) + listen() then clears rnext_key while the TIME_WAIT
socket reads it from softirq, and tcp_v4_timewait_ack() dereferences it.
The segment need not be authenticated: tcp_v4_rcv()'s do_time_wait: path
skips tcp_inbound_hash().

Check both fields and drop the segment when the key is gone; without one
no valid signature can be produced.  In tcp_inbound_ao_hash() this must
be a drop rather than a fallthrough to the keyid lookup, which would let
the peer pick the verification key that rnext_key pins.

This removes the dereferences only; the two sockets still share one
mutable tcp_ao_info, leaving snd_sne, lisn and sk_omem_alloc racy.  The
first Fixes: is where the unchecked read came from, not the sharing.

  Oops: general protection fault, probably for non-canonical address
    0xdffffc0000000010: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000080-0x0000000000000087]
  RIP: 0010:tcp_v4_rcv (net/ipv4/tcp_ipv4.c:1055 net/ipv4/tcp_ipv4.c:2333)
  Call Trace:
   <IRQ>
   ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207)
   ip_local_deliver (net/ipv4/ip_input.c:262)
   ip_rcv (net/ipv4/ip_input.c:612)
   __netif_receive_skb_one_core (net/core/dev.c:6264)
   process_backlog (net/core/dev.c:6728)
   net_rx_action (net/core/dev.c:8007)
   handle_softirqs (kernel/softirq.c:645)
   </IRQ>
  Kernel panic - not syncing: Fatal exception in interrupt

Fixes: decde2586b34 ("net/tcp: Add TCP-AO sign to twsk")
Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
Cc: stable@vger.kernel.org
Reported-by: co+2c72469dbbec34af@bugs.sh
Closes: https://lore.kernel.org/all/YG9s0PiBKJZcXAKld3MToa1IVRJOUoKiaA57%40bugs.sh/
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: drop the incomplete v1 fix; adding missing checks to avoid null-deref

 net/ipv4/tcp_ao.c   | 6 ++++++
 net/ipv4/tcp_ipv4.c | 4 ++++
 net/ipv6/tcp_ipv6.c | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index bb7bbc20ba3f..9c2e5c8c8fe3 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -857,6 +857,8 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 			return -ENOENT;
 		*traffic_key = snd_other_key(*key);
 		rnext_key = READ_ONCE(ao_info->rnext_key);
+		if (!rnext_key)
+			return -ENOENT;
 		*keyid = rnext_key->rcvid;
 		*sne = tcp_ao_compute_sne(READ_ONCE(ao_info->snd_sne),
 					  snd_basis, seq);
@@ -1026,6 +1028,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 		 * matching the rcvid in the mkt.
 		 */
 		key = READ_ONCE(info->rnext_key);
+		if (!key)
+			goto key_not_found;
 		if (key->rcvid != aoh->keyid) {
 			key = tcp_ao_established_key(sk, info, -1, aoh->keyid);
 			if (!key)
@@ -1045,6 +1049,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 		if (err)
 			return err;
 		current_key = READ_ONCE(info->current_key);
+		if (!current_key)
+			return SKB_DROP_REASON_TCP_AOFAILURE;
 		/* Key rotation: the peer asks us to use new key (RNext) */
 		if (unlikely(aoh->rnext_keyid != current_key->sndid)) {
 			trace_tcp_ao_rnext_request(sk, skb, current_key->sndid,
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 9f053eb8b46e..93e073065b1b 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1052,6 +1052,10 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb,
 		key.traffic_key = snd_other_key(key.ao_key);
 		key.sne = READ_ONCE(ao_info->snd_sne);
 		rnext_key = READ_ONCE(ao_info->rnext_key);
+		if (!rnext_key) {
+			inet_twsk_put(tw);
+			return;
+		}
 		key.rcv_next = rnext_key->rcvid;
 		key.type = TCP_KEY_AO;
 #else
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index df9c29eb5c1f..0fb75d139430 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1182,6 +1182,8 @@ static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb,
 		key.traffic_key = snd_other_key(key.ao_key);
 		/* rcv_next switches to our rcv_next */
 		rnext_key = READ_ONCE(ao_info->rnext_key);
+		if (!rnext_key)
+			goto out;
 		key.rcv_next = rnext_key->rcvid;
 		key.sne = READ_ONCE(ao_info->snd_sne);
 		key.type = TCP_KEY_AO;
-- 
2.43.0

