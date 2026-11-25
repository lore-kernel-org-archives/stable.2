Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617542;
	b=icdEU5/R4bgedKKNm2nqrv67mUIbDJs3o304x1eUthcPiisgkYioh3uvktWPqg2K1P3U
	 A5BhkfHDOFgj9MApmEKpFg6jlVI78lK9UglR4LJI3TBaf/12P+mAmnec/rsDO5Jkml5Oz
	 rtE9Qs9PgOGONxwhyhK0Wlkr6bH33JLhpP7bmqhvyVTMKCFejP+NYMMhOrRCP2X1M3Jsj
	 salPkI5aHrecB/8NTjwcfi2EuaPgUAoTn0qVSutYrbcNH4AIluB8+AHtDv78rjRoMVolr
	 hfgQ+AnGP36HVBUaKWJY8rxoqP53d1wSiHZr+FD6vCEiHJErpaq0BQUOaNEy1XooReg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617542;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cx1qystNteFQjRNTYE11WzhB1nr+1KwKc8Aihb3dhrM=;
	b=0q6jj0b4XOGdlRQkSUKZ8O/+UqiC53heYMELQI6wsBuBOtCVizfHtVPdeM+XaIZGG8md
	 6uA0nkFsTTROHCja0FTLr6xvRmmamaQMuTnKQPiv8pb686+HHk/5tGuO7KVIyvAJUtfoW
	 FAvfoZB9mWrie5ZZP9brNa/8O/H3fuikPcw/SjUUPb+biXbcoBjOd/ZqpKt1BWWlIV155
	 L7KhEFcBVGXAdzx+exwrd/VttRxJiQhFVGTdJlZjUL4ps0ulguZf3tgWuOnZ7bY4lGgQX
	 UAZu5tUtDZpV4SL6z2j/cbXhLyUFhyPk/W6tY+MX1AzlUC8/xQBT9tZbhJgJw7UASZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LC0F078Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF98606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LC0F078Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82AB1F000C6;
	Wed, 25 Nov 2026 14:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795617541;
	bh=cx1qystNteFQjRNTYE11WzhB1nr+1KwKc8Aihb3dhrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LC0F078Y9zjEcRcCrCHWX7VIfod9STgqMY6xa8KTjsK6xzYRp4SL+s/F1xNZhH2cz
	 hsB9noNUG3v76NHtqG32hzDCMOq+D4XW8r28u8kE+rwEMZoT8qPijLCZ6u6cLBAr5O
	 04jg27lENpWVX29D1jPqZo5zrNiQ4vRn0xDJuWDNuNrs99mxNRFnO/qP5Axmnm0/iL
	 eF+8Tg8mML8VFOA0PvqdQPMKaOayP8K0Pz0Jk6Th+77py9H65KyeT8DtC3TMcHMkp4
	 zTqWP/0MoB2V/Ub06VsQnEEiQJOA8bwjc7/oq/4BFy82jrGLblzjXGZe1MTAj+UW5Z
	 TyvkoC20Rec0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] tcp: do not coalesce segments after FIN
Date: Wed, 25 Nov 2026 09:38:55 -0500
Message-ID: <20261125143848.4131839-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125143848.4131839-1-sashal@kernel.org>
References: <2026112553-cresting-chimp-b365@gregkh>
 <20261125143848.4131839-1-sashal@kernel.org>
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

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit 1c46780dec48893b8c25fd5e33a3127e8dc39dd4 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_input.c | 4 ++++
 net/ipv4/tcp_ipv4.c  | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index eb8f824254866..7784ef49037ba 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4943,6 +4943,10 @@ static bool tcp_try_coalesce(struct sock *sk,
 	if (!tcp_skb_can_collapse_rx(to, from))
 		return false;
 
+	/* Nothing follows a FIN. */
+	if (unlikely(TCP_SKB_CB(to)->tcp_flags & TCPHDR_FIN))
+		return false;
+
 	if (!skb_try_coalesce(to, from, fragstolen, &delta))
 		return false;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 52e5dc438999e..ab4a42b88996e 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2061,6 +2061,8 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	    ((TCP_SKB_CB(tail)->tcp_flags ^
 	      TCP_SKB_CB(skb)->tcp_flags) &
 	     (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)) ||
+	    /* Nothing follows a FIN, see tcp_try_coalesce() */
+	    (TCP_SKB_CB(tail)->tcp_flags & TCPHDR_FIN) ||
 	    !tcp_skb_can_collapse_rx(tail, skb) ||
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
-- 
2.53.0

