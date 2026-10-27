Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793083086;
	b=ClkUspuq3QbSXEAsXeCy+REXxDX5xnGNCGBZQaeDR5yuow7MN5Fg3IAKDe639Op+n5P0
	 q1H/1WhYn1vNbvJnmu3qDiavuPRO1sAsLFwMwtzb48kuVMGof971MNHlP4AfqKCYG1i1i
	 +3naBEf1iEfs0hPbljbOIbeRN+8RQCHm1pcsvH0ISObJp2S+hnnb/Zlmn0BmMUYCuoeH0
	 YtdzRKr7QUfby8Kt+bXjTiiEsYXAWXImONNngppRKXXFzGUPs5yuThPpBIolp60ucs0gE
	 sYWVCUHJuDzQkH60eDi5FGWkDeMV0sgubhJhyq1gXbFFSal3SC0nJqNt7XexFcowLkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793083086;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=UfWeCC1cXiMyZmL5ZON3N4tkEgqbhUErtax5qaYCUl8=;
	b=3VYd+t9dxU38kIB7b8FHju2S7dzXE8ws+cUf0QiQlAIk0xnlrgaaskZCcm+A6ebNs3uF
	 W6iSHbq3OnAinik4RN6NSzzK0mislhNMQzzbWYlsFfvEXqZriChPnbsBZcxRkEbGYibN4
	 hWRo1rwYLo/hoDIThOuqj/HAXgykEpmQD8dtRXLnwxRCxX2WY5o4q51z0Ugz0OmAs0lUU
	 RbyEocYlwhsBSoifVLuFKs79GWy7f6RicDePWqSAyvwYxW5jb7ucvdahbVAgwNuXVZuVf
	 20GS893SriRMjBmlG+IkyZyahbTwBMyhrFnnqBEhSr9/aK9e0EqaA5ekFASNQUE6WdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=SmLFoREr;
	arc=none smtp.remote-ip=117.135.210.8
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2674606A31A;
	Tue, 27 Oct 2026 06:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2674606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=SmLFoREr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Uf
	WeCC1cXiMyZmL5ZON3N4tkEgqbhUErtax5qaYCUl8=; b=SmLFoREru1truqnH8E
	KM8s/4F3rTWPlVTTIYfQTGsPpSiRPlz4NetqIosnFbAbxK8BzEZ78Hirz/o8SD+z
	wIcfqDzy6tNSv/BgStlBtr4wEfhy5IR1KVR1GPbArXXU0Wnxh+L3oqZR1JJyL50G
	N9owfErk+zjiAhvvRqoquMkfY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3V++YRuBq7ZKjCA--.30661S2;
	Tue, 27 Oct 2026 14:37:14 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	gnault@redhat.com,
	kuniyu@google.com,
	michael.bommarito@gmail.com,
	alice.kernel@fastmail.im
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net] l2tp: fix use-after-free in l2tp_udp_encap_recv()
Date: Tue, 27 Oct 2026 14:36:57 +0800
Message-Id: <20261027063657.1359170-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wD3V++YRuBq7ZKjCA--.30661S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXrWfAr4UXFW3urWUZw4UCFg_yoW5Cw43pF
	yUGrWDGryDKr1UJr48Xay8Xa4Y9rWSvr4rCF98G3Wjkwnxu3srtay5Ar4Sya4DJr4vka1Y
	gF1vqwn8JF4DtrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U2g4hUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlRqKYWrgRponQgAA3X

From: Linkui Xiao <xiaolinkui@kylinos.cn>

l2tp_udp_encap_recv() derives the tunnel pointer from the session it has
just looked up, so the reference taken by l2tp_v2_session_get() or
l2tp_v3_session_get() is the only thing that keeps the tunnel alive:
l2tp_session_free() drops the tunnel reference, and l2tp_tunnel_free()
hands the tunnel to kfree_rcu().  Both error paths of that function drop
the reference before jumping to the invalid label, which still uses the
tunnel:

	tunnel = session->tunnel;

	if (version != tunnel->version) {
		l2tp_session_put(session);
		goto invalid;
	}
	...
invalid:
	atomic_long_inc(&tunnel->stats.rx_invalid);

If the session is torn down concurrently, such a put can be the last
one, and the statistics update then writes into a freed tunnel.

The frees are RCU deferred, which hides the bug on the regular path
because __udp4_lib_rcv() holds rcu_read_lock().  It does not hide it on
the backlog path: __release_sock() drops sk_lock before invoking
sk_backlog_rcv(), takes no RCU read lock and may cond_resched() between
packets, so a grace period can complete before the statistics update.

Account the packet first and move the put to the invalid label, which
can only be reached while the reference is still held, so the put is
not applied twice.

The put on the version mismatch path came later, with commit
4d10edfd1475 ("l2tp: Fix memleak in l2tp_udp_encap_recv()."), which
plugged a session leak without accounting for the tunnel going away
with the session.

Found by inspection; no reproducer.  Hitting the window needs a session
teardown racing a packet on the backlog path, and the RCU deferred frees
mean KASAN is only likely to report it with CONFIG_RCU_STRICT_GRACE_PERIOD.

Fixes: ff6a2ac23cb0 ("l2tp: refactor udp recv to lookup to not use sk_user_data")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 net/l2tp/l2tp_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 7e042a3e648c..36804743c761 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1083,16 +1083,12 @@ int l2tp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	tunnel = session->tunnel;
 
 	/* Check protocol version */
-	if (version != tunnel->version) {
-		l2tp_session_put(session);
+	if (version != tunnel->version)
 		goto invalid;
-	}
 
 	if (version == L2TP_HDR_VER_3 &&
-	    l2tp_v3_ensure_opt_in_linear(session, skb, &ptr, &optr)) {
-		l2tp_session_put(session);
+	    l2tp_v3_ensure_opt_in_linear(session, skb, &ptr, &optr))
 		goto invalid;
-	}
 
 	l2tp_recv_common(session, skb, ptr, optr, hdrflags, length);
 	l2tp_session_put(session);
@@ -1100,7 +1096,11 @@ int l2tp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 invalid:
+	/* The session reference is the only thing keeping the tunnel alive
+	 * here, so account the invalid packet before dropping it.
+	 */
 	atomic_long_inc(&tunnel->stats.rx_invalid);
+	l2tp_session_put(session);
 
 pass:
 	/* Put UDP header back */
-- 
2.25.1

