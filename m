Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619238;
	b=xv98OXcndSApcHM+/iEDJmYPbN5TUsJUMHPf9l8mFTLSTn63FTl2a++SRRWEZ5kDTkuq
	 +Zn4RWdx2U6gzIIFQCxG5MxpOtbllfA/IXoKAIaXclv4WZGcCr27c5rTScpIn4IMFeRwi
	 zXCgGgKfsJmMTsmR1FBIpqcsvkQV2Il4NeV4QJK1X1M0go7+q4KE0OJsknSJcAAgyXOAY
	 WkArDAhl30mHRbXGM4kCU86jCKR1HJar3joiHF7nO6Yqo0jeLIYMRfX5TZHIw/5mD4BCH
	 NkBhcumRtnYTu2Hgi3MyQg4c81tumFnS7cvkdrIcM8f/BTQp6hRKzQSmk7Dl96m6gnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619238;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=36jb89SBhcODIeCX58BMHMBIPrwBHQNOCYUR8FNG5YE=;
	b=LPZGpfjsPF8TgeAvOGj6bZ+QMhpEUrt4F8y6EZFnAC/xOdTOZOEaXDRbIzIlGmRPNJ18
	 i4/u5hTDgwdnn9Ger0fvEWRg4QA1G8fk+MAKUtVO7V/9LM5mrb9mLX4ew1bNzAOHpzbzd
	 uxkytryAcFhW7dy2Uxa0DrAIU9aFbdV0DdNV1xaYt7VRV7yEik1LRHncnu3FQolJTgqss
	 x3tig5LqGGLWaH6cCMBJBRXUwgC5t/FE/tZhYjvY+h8ZrR+cQcycprCf5ICOE1bRBc28s
	 0wswE8eWMER0NN7RMUZdp+Gf8YCd29y1unjwudDZIQIMIEXFN+I8T6DrtKsOVUWzZWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BEWTdXEP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E5D606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BEWTdXEP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A901F000D1;
	Wed, 25 Nov 2026 15:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795619237;
	bh=36jb89SBhcODIeCX58BMHMBIPrwBHQNOCYUR8FNG5YE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BEWTdXEPKkagzkkiadTDKsIfHL5KTznik2i1Dfdklwk+E1llnfBBxsvbc4GW18YsS
	 aNZEFD5TX6gOBGLZH9h+uJEQqBpiV5n9ylEXT4Fe0RZCxTsbPEMJgzvYhw7G2UJ8+H
	 fiUfoB89YCRCmMzji+8cxCM3nYhM6xgTsLfKbT+q2sbTGwmO5O9Y5rQkPa/JNZePTT
	 rRlHCxDcLQy8/6GR+1CAja5B54iPS9KOqxVEbIFrkN5oZwarh4SpGRH1cBOsRmVaEG
	 rsSgFTCn2TL9okLfduS4jokcNjRrGyzc9oMT+STJDtxGjM+kXo8vVjHomvox57LeV0
	 WnxN5yZCeOUkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tcp: do not coalesce segments after FIN
Date: Wed, 25 Nov 2026 10:07:15 -0500
Message-ID: <20261125150655.24930-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112555-unlikable-figurine-6408@gregkh>
References: <2026112555-unlikable-figurine-6408@gregkh>
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
[ sashal: Adapted the guard to the older code: the FIN check sits after the #endif of the TLS-device block, and the backlog check goes before mptcp_skb_can_collapse() instead of tcp_skb_can_collapse_rx(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_input.c | 4 ++++
 net/ipv4/tcp_ipv4.c  | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 54e30bc368ca5..a8eb63bd68622 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4771,6 +4771,10 @@ static bool tcp_try_coalesce(struct sock *sk,
 		return false;
 #endif
 
+	/* Nothing follows a FIN. */
+	if (unlikely(TCP_SKB_CB(to)->tcp_flags & TCPHDR_FIN))
+		return false;
+
 	if (!skb_try_coalesce(to, from, fragstolen, &delta))
 		return false;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 3a4dce8ea95cf..892703f05359a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1875,6 +1875,8 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 #ifdef CONFIG_TLS_DEVICE
 	    tail->decrypted != skb->decrypted ||
 #endif
+	    /* Nothing follows a FIN, see tcp_try_coalesce() */
+	    (TCP_SKB_CB(tail)->tcp_flags & TCPHDR_FIN) ||
 	    !mptcp_skb_can_collapse(tail, skb) ||
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
-- 
2.53.0

