Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90263CB2C7
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699687; cv=none; b=sBVXbwS60YjXiqGwnSjEm9HYp9eCT0JU+pyuBvthXGxWckzPBxnM531sg3WQoUUkZAMtUb9/IeupDLMcfakkLFoKqREKAKwAs4H7CT/FO605o0gFVV+x3/CUdeybHK3bu809XMGeRApYXXEhuqalnwxoNmX+4xr/7UDefE+8OYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699687; c=relaxed/simple;
	bh=WHF4s9FyORFI0/QRZ8ne1c//RPNgr9zGpZ3RSdLaTnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmnBz0w3AdMvCmKXYKVfepZandn/mOqH5WulJ/XoeCmoq6S+rYAu/qNNltIR83sd6GZz1L7wd9OfIo94MJg7GDNbdkMdjeLel7eoTQOcSoDtZ3pHBUxVL1rIUBrj0Y3EEKxwiO/zR3epPfL3K8tfzK0zyO5ZrtETwLyzNeBN5/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1/k33wP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1/k33wP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99DF1F00893;
	Tue, 29 Sep 2026 16:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790699685;
	bh=M71o+mHA/S5p1pwiSJFidG/o3nS2qBQuu5mNhVD1HJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f1/k33wPL2+Iw52S94ekzBLfnKYxdZ4ngOBBrCbp1E+7j8zfyNUENZXP8SvupJc5J
	 F7ElQfGBVBVbzn5tyeC+sO//QZXV+ONaxVAJlI2bfj579o+zF5QS0eWOP0B/8xemBL
	 ZDRKq0d8NDsk2Zos57HLEnhFJvcDJKTyYRZD6a8eI0TmLF9fe1Ox9m7kaKHFu925A7
	 dBtakJObKs+TlNubI8ta+x5UAF7ama79qJHNDc3B933kwwzlARe3lvgUvbKxBBjM4f
	 QKKgmLvZ4c+aDKj7HW7BxiodqiaiqoMIo5RT+tZkyY86NHC8yxi4ilFXXtzteOYj4F
	 IFllHqupc55FQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tcp: prevent collapsing skbs across boundary in rtx queue
Date: Tue, 29 Sep 2026 12:34:43 -0400
Message-ID: <20260929163443.85594-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092928-skewer-abiding-df9a@gregkh>
References: <2026092928-skewer-abiding-df9a@gregkh>
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
[ inlined logic for missing skb_cmp_decrypted() and tcp_write_collapse_fence() helpers into existing functions. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h    | 4 ++++
 net/tls/tls_device.c | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2bd38e319c201..d5a8843587535 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -988,6 +988,10 @@ static inline bool tcp_skb_can_collapse_to(const struct sk_buff *skb)
 static inline bool tcp_skb_can_collapse(const struct sk_buff *to,
 					const struct sk_buff *from)
 {
+#ifdef CONFIG_TLS_DEVICE
+	if (from->decrypted != to->decrypted)
+		return false;
+#endif
 	return likely(tcp_skb_can_collapse_to(to) &&
 		      mptcp_skb_can_collapse(to, from));
 }
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 6118859b2a515..7cc2a287d330c 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -225,7 +225,7 @@ static void tls_device_resync_tx(struct sock *sk, struct tls_context *tls_ctx,
 	int err = 0;
 	u8 *rcd_sn;
 
-	skb = tcp_write_queue_tail(sk);
+	skb = tcp_write_queue_tail(sk) ?: tcp_rtx_queue_tail(sk);
 	if (skb)
 		TCP_SKB_CB(skb)->eor = 1;
 
@@ -1118,7 +1118,7 @@ int tls_set_device_offload(struct sock *sk, struct tls_context *ctx)
 	 * SKBs where only part of the payload needs to be encrypted.
 	 * So mark the last skb in the write queue as end of record.
 	 */
-	skb = tcp_write_queue_tail(sk);
+	skb = tcp_write_queue_tail(sk) ?: tcp_rtx_queue_tail(sk);
 	if (skb)
 		TCP_SKB_CB(skb)->eor = 1;
 
-- 
2.53.0

