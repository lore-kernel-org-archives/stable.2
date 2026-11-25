Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596693;
	b=dZfTIRAviv/O4bWkmvQ6V1Dtow+hfQXXrdTD4nuF1wVItRf3UjZBVYgyUaG8yH5DsDN7
	 TTWJLst5BRqFFve3RAVLZ3329+Xg8tlfZH97WGbi9HGkALNUScF3doiUtpOQhgw8bNs/y
	 ihJ6IeCBGnYkFr1LUKmUUuRwuMmCYwZYoo+aYBj+ycXvZWQU1dJZU9GRLdUyfWZLtOVTS
	 sc0u+QVrhfJYM2Fj1Clp7I02UT2uTMTTolc2vYuFXF2muOWHeZmDz+Rj2aa+JtPBVg6Vz
	 aOewPZOtKTN9SXWgbHfGKMeGD2x0GuVuUNXIZBErp8RQ/eQUEp8DNPBqGwmX+vSrjaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596693;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=th/Jb5XW8S7DE4xTVbkbqKw7SeZ6R1lXcypd7dZCO3s=;
	b=gV89FCSKcVMqKuIftMBF1N75ItKqjrjX0YryC0AhwKFgwgwW5C9VoLsu39AYr6Aaed10
	 +BgAh2BTgcHrQLOTdvcax3P7Lrky/vKi4OnN+7l91HO16jZp2vVq5boHDvCdPgCRppBBL
	 6bMIPLuXsJa1VBNSbOD/e+u4niIbU19CmXP+RVY1wJl0uy6OabUqA6bFEfTBF6T9jJCck
	 V9l72G5C3E4t3xF6Vhdc/Y7Sdv2JsjjmbqbfNQhWBdINtOW+5yiBYcano7sirbpacrmoj
	 AnhsWF5nCV8XXGNq9Fv8/GQU7ufrVsFrnl4Dk5pFlaPjBuXLpN1Aag7g8qUvk8LkuHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="MkR9A/Bc";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93839606A332
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MkR9A/Bc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF8A1F000D3;
	Wed, 25 Nov 2026 08:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795596693;
	bh=th/Jb5XW8S7DE4xTVbkbqKw7SeZ6R1lXcypd7dZCO3s=;
	h=Subject:To:Cc:From:Date;
	b=MkR9A/BcJ8nP9eyg4DfeiGEqQ4a3/zQJ0ILZTyTSHCqb7azwLToLmQZjnMZ0LW8V3
	 a5NOPM6yJq75guPdpXqkDKX+LFObUsv6EoI/YzTxkZwNZgD740mUjd5YM/ECszUOJs
	 F70PUoF7HewjbmKmxuzy8JvP4sabf4BO6J6TNbKk=
Subject: FAILED: patch "[PATCH] tcp: do not coalesce segments after FIN" failed to apply to 6.1-stable tree
To: imv4bel@gmail.com,edumazet@kernel.org,kuba@kernel.org,kuniyu@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 09:48:55 +0100
Message-ID: <2026112555-figure-unmindful-3e90@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1c46780dec48893b8c25fd5e33a3127e8dc39dd4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112555-figure-unmindful-3e90@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1c46780dec48893b8c25fd5e33a3127e8dc39dd4 Mon Sep 17 00:00:00 2001
From: Hyunwoo Kim <imv4bel@gmail.com>
Date: Fri, 6 Nov 2026 21:25:21 +0900
Subject: [PATCH] tcp: do not coalesce segments after FIN

A FIN consumes a sequence number. If another FIN segment is coalesced
into an skb that already carries FIN, end_seq advances to account for
the additional FIN, but tcp_flags still contains only one FIN bit.

When the preceding gap is filled and tcp_ofo_queue() processes the
coalesced skb, rcv_nxt advances to the skb's end_seq. When the receive
path consumes all data in the skb, copied_seq advances by the data
length and one sequence number for FIN. If three or more FIN segments
have been coalesced into one skb, tcp_inq() can still return a positive
value after the receive queue becomes empty and the SOCK_DONE adjustment
is applied.

TCP_ZEROCOPY_RECEIVE is another consumer affected by this state.
tcp_zerocopy_receive() takes its length from tcp_inq() and follows
skb->next without checking for the end of the receive queue.

Software kTLS receive is one consumer affected by this state. When
strp->copy_mode is false, tls_strp_msg_consume() calls the TCP helper
tcp_read_done() to consume the current TLS record. In the reproducer,
tcp_read_done() consumed the record data and one FIN before freeing the
receive skb.

When kTLS looked for the next record, tcp_inq() reported at least
TLS_HEADER_SIZE bytes even though the receive queue was empty.
tcp_recv_skb() returned NULL, so tls_strp_load_anchor_with_queue() hit
WARN_ON_ONCE() and returned without updating the anchor.

Since tcp_inq() had reported at least TLS_HEADER_SIZE,
tls_strp_read_sock() proceeded to tls_strp_check_queue_ok().
skb_shinfo(strp->anchor)->frag_list still pointed to the freed receive
skb. tls_strp_check_queue_ok() then read TCP_SKB_CB(first)->seq through
the stale pointer, causing a use-after-free.

The reproducer followed this call path:

  tls_rx_rec_done()
    tls_strp_msg_consume()
      tcp_read_done()                       // frees the receive skb
    tls_strp_check_rcv()
      tls_strp_read_sock()
        tls_strp_load_anchor_with_queue()   // returns after WARN_ON_ONCE()
          tcp_recv_skb() == NULL
        tls_strp_check_queue_ok()
          TCP_SKB_CB(first)->seq            // reads the freed receive skb

KASAN reported:

  BUG: KASAN: slab-use-after-free in tls_strp_check_queue_ok.isra.0+0x5f/0x100
  Read of size 4 at addr ffff888103169ca8 by task ktls-server/71
  ...
  Call Trace:
   <TASK>
   ...
   tls_strp_check_queue_ok.isra.0+0x5f/0x100
   tls_strp_check_rcv+0x2a9/0x400
   ...
   tls_sw_recvmsg+0x3ce/0xa10
   ...
   sock_recvmsg+0xea/0x100
   __sys_recvfrom+0x142/0x1f0
   ...
   __x64_sys_recvfrom+0x76/0x90
   do_syscall_64+0xdd/0x4a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   ...
   </TASK>
  ...
  Freed by task 71:
   ...
   napi_skb_cache_put+0x24/0xf0
   skb_attempt_defer_free+0x183/0x3b0
   tcp_read_done+0x2d4/0x340
   tls_strp_msg_consume+0x45/0x80
   tls_sw_recvmsg+0x3c4/0xa10
   ...

In tcp_try_coalesce(), skip coalescing when the destination skb already
carries FIN. tcp_add_backlog() calls skb_try_coalesce() directly instead
of using this helper, so add the same check there. Since both paths check
only the destination skb, a final segment carrying data and FIN can still
be coalesced into an skb without FIN when the other coalescing checks pass.

Fixes: e93a0435f809 ("tcp: allow segment with FIN in tcp_try_coalesce()")
Fixes: 4f693b55c3d2 ("tcp: implement coalescing on backlog queue")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/au3HMfqNW3_DRMqS@v4bel
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e971947083af..9963337efae1 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5290,6 +5290,10 @@ static bool tcp_try_coalesce(struct sock *sk,
 	if (!tcp_skb_can_collapse_rx(to, from))
 		return false;
 
+	/* Nothing follows a FIN. */
+	if (unlikely(TCP_SKB_CB(to)->tcp_flags & TCPHDR_FIN))
+		return false;
+
 	if (!skb_try_coalesce(to, from, fragstolen, &delta))
 		return false;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 0dc3b087665d..23a63a34a6fd 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1957,6 +1957,8 @@ enum skb_drop_reason tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 	    ((TCP_SKB_CB(tail)->tcp_flags ^
 	      TCP_SKB_CB(skb)->tcp_flags) &
 	     (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)) ||
+	    /* Nothing follows a FIN, see tcp_try_coalesce() */
+	    (TCP_SKB_CB(tail)->tcp_flags & TCPHDR_FIN) ||
 	    !tcp_skb_can_collapse_rx(tail, skb) ||
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)) ||

