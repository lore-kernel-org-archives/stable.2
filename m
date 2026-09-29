Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B2296BCF
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664098; cv=none; b=VAe4F8xwebyUZHL7uHwPzBPQhHcAAzVxswK4u4wj9kdkWdo3coLZaO91G0SmOlAIygcy5KTkmoQVPmvJsaxX5KBp7U4hvrGLVNZeUGbU1U6oW0z92TNP5q5pECyOLbiggunB1fbcajgJQMyrRYO4NnW7588Keif0drVBb+ottjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664098; c=relaxed/simple;
	bh=K/UfZvZeqecyeBKyjhB+0jLA0Fx8maLjnxfVsNkD0NQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZFeSKjDwzwCfxc4+GIQbOSu8hh8jPRIvN3gAJs6LE0A8SGKgxPg0LvcYIHE67LJsc6mU7w/0yGVQvyT+IP3Em47iinK7HLeZZVvU6edbnk4U/NaasLKVhRMfzDhMGkp5fWI9ycQp5AWWRfOBOmqHNKCTmd2sogw7g1LEuGAQgB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jkwxLZyJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jkwxLZyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A371F000FF;
	Tue, 29 Sep 2026 06:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790664097;
	bh=Q5txVPZFK/5jZfy5MK7KOQwCZ/pJz2xeRIRBnQgM6TM=;
	h=Subject:To:Cc:From:Date;
	b=jkwxLZyJyhqL/6wlBsXXfuyRgjSQZRsaY8nt94bWeXJnkjvmJPlIJ79QalRCfQ5c1
	 +4el6AptvRowLmbNWxHFepq+Tw7Vi4WAnNcn/du+RUws6EbuUfAGjVfLqnHy73ft9w
	 yysjBV+iL6ZePzrpsWEHwju0FB+ZCfwyC5ZlNVKE=
Subject: FAILED: patch "[PATCH] tcp: prevent collapsing skbs across boundary in rtx queue" failed to apply to 5.15-stable tree
To: willemb@google.com,daniel.zahka@gmail.com,edumazet@google.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 08:41:27 +0200
Message-ID: <2026092927-online-drilling-740b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x fc6d80eb504458d6416b75a94188b268c95c6533
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092927-online-drilling-740b@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

