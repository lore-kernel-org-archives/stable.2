Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D64B41D4F4
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664090; cv=none; b=TyGkew1p6zp/jlL+FCo7TWa205m6FNkzzHoKqFHIWEgdRhO/tQzH8rvldexOofcdEU6iUIoLZYgctOjm+2SDL6TB/rajdueclPb9mQNQ+9+GFyURvN7NcwBjm+UzUXg4h7lWi8aA7cLbszqaXuNM9oVgPyRBeyvlG+5LwmWuHZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664090; c=relaxed/simple;
	bh=4QgU7JslHw8e2lGr0ToHz/+N+py/bp2NTRuK2my8FFQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qzT7Wzjgd0HzVoiJQgsWuOCGTNLKgyu5xdNPCTTKa3u0qFzc4xVLJxkbw8u2TK7UXS/OzhTyoaTgHzFJgvTNUvJ3MmhL0cj46Amg0cnjuPzhEXgc3yyz6NzN0D0vSMbFwLr7lbzgXMu6qtBoYTFKrHeCPCoim4AOyZNfwhc6Vck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y2IpU4yr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y2IpU4yr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711C21F000FF;
	Tue, 29 Sep 2026 06:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790664089;
	bh=x+bWay6t4WrryrTzESi/PtFCSObJf3Vx3RaPY/YCAgU=;
	h=Subject:To:Cc:From:Date;
	b=y2IpU4yruSFCQuyEEgnzxHeaHLYwNeO/JOKnhJHceRxyNbZIVksoFUEjTQ3vDXQZx
	 MfnoyG5n/UXe97vDZ38WKbk7AtnW/13B/SuOMu0EwPWHphILqTq6M4CGrfXVIL5wF7
	 KUG4gj5PBO7CtIr2Hlb7FoTOpahC3DXLdH4+EjHs=
Subject: FAILED: patch "[PATCH] tcp: prevent collapsing skbs across boundary in rtx queue" failed to apply to 6.6-stable tree
To: willemb@google.com,daniel.zahka@gmail.com,edumazet@google.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 08:41:26 +0200
Message-ID: <2026092926-blot-handyman-a633@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x fc6d80eb504458d6416b75a94188b268c95c6533
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092926-blot-handyman-a633@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fc6d80eb504458d6416b75a94188b268c95c6533 Mon Sep 17 00:00:00 2001
From: Willem de Bruijn <willemb@google.com>
Date: Thu, 24 Sep 2026 11:44:12 -0400
Subject: [PATCH] tcp: prevent collapsing skbs across boundary in rtx queue

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

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 436495ff2271..4416cdf9bf30 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1232,9 +1232,9 @@ static inline bool tcp_skb_can_collapse_to(const struct sk_buff *skb)
 static inline bool tcp_skb_can_collapse(const struct sk_buff *to,
 					const struct sk_buff *from)
 {
-	/* skb_cmp_decrypted() not needed, use tcp_write_collapse_fence() */
 	return likely(tcp_skb_can_collapse_to(to) &&
 		      mptcp_skb_can_collapse(to, from) &&
+		      !skb_cmp_decrypted(to, from) &&
 		      skb_pure_zcopy_same(to, from) &&
 		      skb_frags_readable(to) == skb_frags_readable(from));
 }
@@ -2327,7 +2327,7 @@ static inline void tcp_rtx_queue_unlink_and_free(struct sk_buff *skb, struct soc
 
 static inline void tcp_write_collapse_fence(struct sock *sk)
 {
-	struct sk_buff *skb = tcp_write_queue_tail(sk);
+	struct sk_buff *skb = tcp_write_queue_tail(sk) ?: tcp_rtx_queue_tail(sk);
 
 	if (skb)
 		TCP_SKB_CB(skb)->eor = 1;

