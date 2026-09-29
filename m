Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A533DC87A
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697043; cv=none; b=OZUY1gZWdejvOAxaBqoEKuw/3gAkE1zaNmu47J4QeZ9IeRKPcGA5S7uHNghl24DQiILGW6e0nCvVLoC6F0PPbj9WiIRKm+nXp13NlWZ+B08E3wZQZefOrcSlLPwbMygbkg3lezql4n+QxXgqqqkcs65E3jf3BucRoPy/KV8AmyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697043; c=relaxed/simple;
	bh=Xh+moQKQuKCyci9PfXHlUesVvgzjNV2ecBzDQWSNsa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlRVhu4epbK9lvhc4g1MX1K8tVJWWQYBI4PjZ91OeEz1++gkmxpRDtpvIgvDwHP8IvVhivBAan9IyH655BRiBdWfbiQHphKHVYhY9UA80TuqSO7RQ6rgNNm3O6639EX8mVIGzweG/2fcSFN8Nx4XYw9OgANNCy4E+7ez7CF6uTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brltPj9B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brltPj9B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794851F000FF;
	Tue, 29 Sep 2026 15:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790697042;
	bh=S94JJM9lwcoc/BxtZnIS7SLZQMz4Uctu94JAs5fC+gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=brltPj9Bmh7rrXpPOq26lSYowGunok38RIb3EETEv7pH8ziX0Cv4Zte1l4n+yybS0
	 M2f7APmiQyNVc3WUaUWgO6Rv4MRofiwccQAKdkr+WxxYNjRUIK8RY3CYdZ83lQKHWd
	 LP73gC1tIATBe6PQHMdXfthhDX44KzJmls/j8HN5Qs9QTlfJsu4lvD7U1QgCa3GVqb
	 P9hnKb65mxLbb7aZOAmtK/y+XZ7SNAxnhZGau0OQ+h42fjf00Bw/2tWAF6ePUuGr7/
	 mg2jso2k4KBSB0hXhkpz8/cRhJaDuOrHhmzZ8sQE8jPDI3F8lswExmyw4gMUTMQ1h+
	 /srnWfoST4ABw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] tcp: prevent collapsing skbs across boundary in rtx queue
Date: Tue, 29 Sep 2026 11:50:40 -0400
Message-ID: <20260929155040.4095790-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092926-blot-handyman-a633@gregkh>
References: <2026092926-blot-handyman-a633@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit fc6d80eb504458d6416b75a94188b268c95c6533 ]

tcp_write_collapse_fence() sets TCP_SKB_CB(skb)->eor = 1 on
tcp_write_queue_tail(sk) to prevent skbs queued after a switch to
device encryption from being collapsed into earlier skbs.

The fence is a no-op if all earlier data has already been transmitted
when the switch happens: sk->sk_write_queue is empty. The not yet
acknowledged earlier skbs wait in sk->tcp_rtx_queue with eor 0.

On a subsequent retransmit or SACK shift, tcp_retrans_try_collapse() or
tcp_shift_skb_data() can then merge an skb queued after the switch into
one queued before it.

Both users of the fence are affected:

- psp: devices only encrypt skbs with skb->decrypted set. The merged skb
  keeps decrypted = 0 from the earlier skb, so merged data sent after
  psp_sock_assoc_set_tx() is retransmitted in cleartext.

- tls device offload: the merged skb straddles the start marker set in
  tls_set_device_offload(). The software fallback (fill_sg_in() returns
  -EINVAL) and the mlx5, nfp and funeth drivers cannot handle such an
  skb and drop it. Every retransmit rebuilds the same skb, so the
  connection stalls.

Fix this in two places, for defense in depth:

1. Fall back to tcp_rtx_queue_tail(sk) in tcp_write_collapse_fence()
   when tcp_write_queue_tail(sk) is NULL.

2. Check !skb_cmp_decrypted(to, from) in tcp_skb_can_collapse(), as
   tcp_skb_can_collapse_rx() does on receive. skb_shift(), which both
   collapse paths call, already has a DEBUG_NET_WARN_ON_ONCE() for this
   condition.

Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
Link: https://patch.msgid.link/20260924154427.953800-1-willemdebruijn.kernel@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Applied tcp_write_collapse_fence() changes directly to the existing TLS code blocks because the helper is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h    | 1 +
 net/tls/tls_device.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index c75d12e5156db..3fe0c1d928407 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -985,6 +985,7 @@ static inline bool tcp_skb_can_collapse(const struct sk_buff *to,
 {
 	return likely(tcp_skb_can_collapse_to(to) &&
 		      mptcp_skb_can_collapse(to, from) &&
+		      !skb_cmp_decrypted(to, from) &&
 		      skb_pure_zcopy_same(to, from));
 }
 
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 34d321ff11980..bb7057aa828e1 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -239,7 +239,7 @@ static void tls_device_resync_tx(struct sock *sk, struct tls_context *tls_ctx,
 	int err = 0;
 	u8 *rcd_sn;
 
-	skb = tcp_write_queue_tail(sk);
+	skb = tcp_write_queue_tail(sk) ?: tcp_rtx_queue_tail(sk);
 	if (skb)
 		TCP_SKB_CB(skb)->eor = 1;
 
@@ -1157,7 +1157,7 @@ int tls_set_device_offload(struct sock *sk, struct tls_context *ctx)
 	 * SKBs where only part of the payload needs to be encrypted.
 	 * So mark the last skb in the write queue as end of record.
 	 */
-	skb = tcp_write_queue_tail(sk);
+	skb = tcp_write_queue_tail(sk) ?: tcp_rtx_queue_tail(sk);
 	if (skb)
 		TCP_SKB_CB(skb)->eor = 1;
 
-- 
2.53.0

