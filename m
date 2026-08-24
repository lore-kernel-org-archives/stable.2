Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E162A223702
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 03:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787542478; cv=none; b=gxYUsYU77FfJC/SX0KD4P5K9t1KhYDBJGgsjKaaIwtbP2zriip404enO4pLTWUy94fXA+nBpSHrW2pmI+699KXJf1CQ4IGIpFY0G7GEV9umyVAZRkgBYLAw8nusijTivJv7Jkg00WFG2SDUNIz4SmbQePNB+j/C/d48DTtjnrQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787542478; c=relaxed/simple;
	bh=iKlmSYal/we//DbFxdnR+qq4NS2r621URuMIi6uUWaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGxJrMgnP2jUxZzYH+o6ifpDIVpsmKhgDSMQSxWdoXfxONglzpkcrLiXEMIT99kSmsVlVKzeNUCU9kadXgJD8BS2zjUf968OpUH7sCCQtQ0Rbkqa8PeyjIva1j5W1deKh6kJ501Eyskas8zdJOvgH99DQPGgYMua4gy/EhLCLMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKaJC2df; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKaJC2df"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so2138387a91.0
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 20:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787542476; x=1788147276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F7loPKjk85S1XKwGILHvPGhD2hPmSAD1/re7dQ/3iUc=;
        b=GKaJC2dfS09SwGoGo9Dsv4oZdaaydJdk03fu2ZJHwxCbiq5r2AFDDf4vfFcRodeArt
         smuEfj49loWgVB1I44xGBQ0f3sG/D2gxJ3ASBx/x8ixrSdxZODdIS2lJDQttR9COhqMb
         CU7yeHkEtpSnqIhUHU8jXBImS1csD2JFjewXwFyhAezWtMeafmp5loNPEqTvBy1QSVCe
         9Isq10WjIIHnx0c8jL/roME67dAE+eMmRSc4TNkkCetV33pKHv3aiiUdQ3+Y9/+vHlYB
         FmjHidnAj+1z+UzDyI+M0w6z/qTfHJuROq9mDti2q4tCj8xDxn/SXB0bo84UehD/bfU2
         diyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787542476; x=1788147276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F7loPKjk85S1XKwGILHvPGhD2hPmSAD1/re7dQ/3iUc=;
        b=RQDwc4C1Co7flVrZa35VRIH/4btbN/1sVEq0Ma/TcUX9brHkj7eWVhrD2J5fXUHjQb
         4s4slvujx45Aa7d5kgAl3rvrbLKyfbEsQtd/BVLhqP0FLoUpfefBzrT1BGt94tLsxMK8
         foVBYyGYCwqEg6e+BxabGB06qV137Neqr41qH/RKCRLHioTJrNlaeflHxbQcvON+sOtT
         VFP6kUZctrdVKpWYcd8cP/h8i95v4p1kvcewEf73SZ+/0TeLcMDjIJ8mXKfhgl0OvxZf
         PGYYtJRE5kiydwqcsrhciO60RKqXQN71KkDkrGU08dRsvzOaJru14v7PQLAXfFTDhU8r
         X/EA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3t0gD+tnui+Y9w5fs74ZViHjYxYaF/zmpehK22BIbYx6CPS0UcLOZRLFY5KTPwRlrWJIaQvI=@vger.kernel.org
X-Gm-Message-State: AFuF++ndThJxVcv1G+4bObGAGtqe9dNHk6NUSSoKHwfiv0pAR2/NHfIu
	u5tT5kyZ4/pyT2zGvpkxSccyOHP7+0Jl+TTrRtCKFsSMUH62oi5zIiBg
X-Gm-Gg: AR+sD12SeTdGLCH5ReC0QbZWDEOFIU3bdqph+m1Ar2invDu8bDzxxK9NGameHSxa/Ce
	2LmtceJZiCHSdOBERlLL92RMOmWPBsdr5LP8JZnwc7gG2fzZ1A/JZesIqzP6bvTBL8/ieaGCb4E
	48svu4mnudTm1bqpMlT2o920ZTQZTJPjTY1Qeir6JgeSvyIXEcIShu84QDnIJhyjGneMoNNiY8W
	KUwgWIrZRS2p7KaD9rwDfxcWfCOQrQKgantonWcSokmOkNWxLd7gfpQdjzr4F4YMKL3Z1IiY0s7
	bWFbHIaV9JJgPLGHHhpZJD4r10SfHv9MDVAFUwZQF5+r7h1M0yjLh4GHTqMYuIxQ+hn4iq9gVme
	O2KblUQoqsEum1x1bwwLaNy8AFlhy4+yYKYQWEzmVsGSAMXlBQu3FbxUuzs2q7NZ7qLc23/qFLh
	hoWqyKl+JSBQ1kVdZQtKE1xYMTNlhwTxwkkWBq/SesWDpm4S+bfj6Fr9E1WPst+ehxQ/+t/GcvW
	yQoadF8gq0=
X-Received: by 2002:a17:90b:3e8d:b0:38e:9ca8:e99 with SMTP id 98e67ed59e1d1-395c4fa444bmr13960149a91.5.1787542476163;
        Sun, 23 Aug 2026 20:34:36 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c8fd34d9sm4227256a91.1.2026.08.23.20.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 20:34:35 -0700 (PDT)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	kuniyu@google.com,
	horms@kernel.org,
	willemb@google.com,
	andrew+netdev@lunn.ch,
	kees@kernel.org,
	jiayuan.chen@linux.dev
Cc: kerneljasonxing@gmail.com,
	ij@kernel.org,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imv4bel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v2 5/8] tcp: do not inherit out_of_order_queue from parent
Date: Mon, 24 Aug 2026 12:32:49 +0900
Message-ID: <20260824033331.1084971-6-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824033331.1084971-1-imv4bel@gmail.com>
References: <20260824033331.1084971-1-imv4bel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A child gets a copy of the parent's out_of_order_queue, which can be non
empty when/if parent morphs from listener to active session. Parent and
child then point at the same rbtree.

The parent is no longer a listener, so inet_csk_reqsk_queue_add() forgets
the child immediately, and tcp_disconnect() frees the skbs the parent
still owns. The parent's own root and ooo_last_skb are left alone, so it
keeps using those skbs. That is a use-after-free, and the parent frees
them a second time when it closes.

In short:

  peers                               the socket owner

                                      socket(AF_INET6)
                                      setsockopt(TCP_DEFER_ACCEPT, 30)
                                      bind(), listen()
  connect(the listener)
      // bare ACK deferred, the request stays
                                      connect(AF_UNSPEC)
                                      connect(the new peer)
  send(the new connection)
      // it starts one byte past rcv_nxt, so it lands out of order
      tcp_data_queue()
        tcp_data_queue_ofo()  // the parent's queue fills up
  send(the old connection)
      tcp_check_req()
        tcp_v6_syn_recv_sock()
          tcp_create_openreq_child()  // the child gets the same rbtree
        inet_csk_complete_hashdance()
          inet_csk_reqsk_queue_add()
            inet_child_forget()
              tcp_disconnect()
                skb_rbtree_purge()  // the parent's skbs are freed
  send(the new connection)
      tcp_data_queue()
        tcp_data_queue_ofo()
          rb_link_node()  // use-after-free write

KASAN log:

  BUG: KASAN: slab-use-after-free in tcp_data_queue+0x1708/0x1df0
  Write of size 8 at addr ffff888012ad5408 by task repro/135
  ...
  Call Trace:
   <IRQ>
   tcp_data_queue+0x1708/0x1df0
   tcp_rcv_established+0x441/0x1830
   tcp_v4_do_rcv+0x47e/0x730
   tcp_v4_rcv+0x171c/0x2040
   ip_protocol_deliver_rcu+0x5c/0x280
   ip_local_deliver_finish+0x15a/0x2e0
   ip_local_deliver+0x107/0x370
   ip_rcv+0x3b1/0x3d0
  ...
  Allocated by task 135:
   __alloc_skb+0xd0/0x370
   alloc_skb_with_frags+0x7d/0x330
   sock_alloc_send_pskb+0x490/0x4e0
   raw_sendmsg+0xd52/0x1850
  ...
  Freed by task 133:
   kmem_cache_free+0x26f/0x5f0
   skb_rbtree_purge+0x73/0x90
   tcp_disconnect+0x1be/0xd60
   inet_child_forget+0x41/0x140
   inet_csk_complete_hashdance+0x4d0/0x520
   tcp_check_req+0x9f9/0xff0
   tcp_v6_rcv+0xb9f/0x1e90
  ...
  The buggy address belongs to the object at ffff888012ad5400
   which belongs to the cache skbuff_head_cache of size 232
  The buggy address is located 8 bytes inside of
   freed 232-byte region [ffff888012ad5400, ffff888012ad54e8)

We need to make sure this can not happen, by initializing the queue after
socket cloning.

Very similar to commit 8b485ce69876 ("tcp: do not inherit fastopen_req
from parent")

Fixes: 9f5afeae5152 ("tcp: use an RB tree for ooo receive queue")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Add the trigger sequence and the KASAN log to the commit message.
- v1: https://lore.kernel.org/all/20260817090319.3897799-4-imv4bel@gmail.com/
---
 net/ipv4/tcp_minisocks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 0c3b35a381e327..7fe318d9e0aed2 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -591,6 +591,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	newtp->total_retrans = req->num_retrans;
 
 	tcp_init_xmit_timers(newsk);
+	newtp->out_of_order_queue = RB_ROOT;
 	WRITE_ONCE(newtp->write_seq, newtp->pushed_seq = treq->snt_isn + 1);
 
 	if (sock_flag(newsk, SOCK_KEEPOPEN))
-- 
2.43.0

