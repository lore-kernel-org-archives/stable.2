Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F8E379C21
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784744411; cv=none; b=NCvN2exppA0D3L1Dw6GJ3UZ1/lizV/ZDljBnJdnTOlGeOJ18eVsJ23AfBa8yG0yIrw+DbVTHcBCky7QoYGOFQH+a6QKQvwBIPK8rJoV23yVUxG7Jv32vkRB0I4XRkiafscRVwQi1bx9Ugl13qanyu56is5XtrulM7+zf2+UY554=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784744411; c=relaxed/simple;
	bh=cg4gEcbAOdL4vQJ3nX2S70+IR6gWhBCxkGObZfuFok8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8XlJokrFINAnBk/w1sJoDZhA1GwprEdqTWZ6JJZyHTaRgaav2vOuUkARSNmQgZ9jciUR7GnNrltsyPFMFu0+cY0A/UppDUrXz/+9/QEBe3B7Y8YdqNm1oaFGN7d3qQjYhXhhFviM6oyB8VNzYGh7bC7d9VD6zpL8rEqGBCZu3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQkBlyEm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQkBlyEm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB831F000E9;
	Wed, 22 Jul 2026 18:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784744409;
	bh=7f1CM59BhXAp3QIyrJZ9rJvGppIjOmufp3lGYbWwO6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oQkBlyEmQrlNsGA3hnjBCTe7nMjFsXAZM2hcG++xbwEiwYMGPYgv4Cmgns6Ik1hjW
	 gr0yH/kLU+8KlkWUiSLBsRNPM1A70W/0MzKEYKNrpef++Swn6F6nFDYgiCAsj4qlzv
	 nihOAv/QjUwnfl8Ta8HCBCnh6NGmd88darBEmwB6jN+zzcLvO4HpDTZiX0KBZod/Xc
	 otvDlbEtu3+xS7dqt5m+A0KVlt/8UR/UkRRLZdkq/AIOdirfOBxp44OkTJosKCnmu0
	 x4o/FTp77JpEL8FjeiiVXc6trytlEGRAghJP1qBoyIAnTLRq9ZS3RI6bjzIajKv0Ws
	 lD1VItpDQO5UQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Xiasong <lixiasong1@huawei.com>,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tipc: restrict socket queue dumps in enqueue tracepoints
Date: Wed, 22 Jul 2026 14:20:07 -0400
Message-ID: <20260722182007.2242819-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072051-ploy-disbelief-f80b@gregkh>
References: <2026072051-ploy-disbelief-f80b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Xiasong <lixiasong1@huawei.com>

[ Upstream commit acd7df8d955480a6f6e5bb809da67b1500cc3cf4 ]

tipc_sk_enqueue() runs with sk->sk_lock.slock held while the socket is
owned by user context. The spinlock protects the backlog queue in this
path, but it does not serialize against the socket owner consuming or
purging sk_receive_queue.

KASAN reported:

  CPU: 14 UID: 0 PID: 1050 Comm: tipc3 Not tainted 7.1.0-rc6+ #126 PREEMPT(lazy)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
  Call Trace:
    <TASK>
    dump_stack_lvl+0x76/0xa0 lib/dump_stack.c:123
    print_report+0xce/0x5b0 mm/kasan/report.c:482
    kasan_report+0xc6/0x100 mm/kasan/report.c:597
    __asan_report_load4_noabort+0x14/0x30 mm/kasan/report_generic.c:380
    tipc_skb_dump+0x1327/0x16f0 net/tipc/trace.c:73
    tipc_list_dump+0x208/0x2e0 net/tipc/trace.c:187
    tipc_sk_dump+0xaf6/0xd60 net/tipc/socket.c:3996
    trace_event_raw_event_tipc_sk_class+0x312/0x5a0 net/tipc/trace.h:188
    tipc_sk_rcv+0xb1d/0x1d50 net/tipc/socket.c:2497
    tipc_node_xmit+0x1c3/0x1440 net/tipc/node.c:1689
    __tipc_sendmsg+0x97a/0x1440 net/tipc/socket.c:1512
    tipc_sendmsg+0x52/0x80 net/tipc/socket.c:1400
    sock_sendmsg+0x2f6/0x3e0 net/socket.c:825
    splice_to_socket+0x7f9/0x1010 fs/splice.c:884
    do_splice+0xe21/0x2330 fs/splice.c:936
    __do_splice+0x153/0x260 fs/splice.c:1431
    __x64_sys_splice+0x150/0x230 fs/splice.c:1616
    x64_sys_call+0xeb5/0x2790 arch/x86/entry/syscall_64.c:41
    do_syscall_64+0xf3/0x620 arch/x86/entry/syscall_64.c:63
    entry_SYSCALL_64_after_hwframe+0x76/0x7e arch/x86/entry/entry_64.S:130
  RIP: 0033:0x71624e8aafe2
  Code: 08 0f 85 71 3a ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
  RSP: 002b:0000716157ffed68 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
  RAX: ffffffffffffffda RBX: 0000716157fff6c0 RCX: 000071624e8aafe2
  RDX: 000000000000005f RSI: 0000000000000000 RDI: 0000000000000066
  RBP: 0000716157ffed90 R08: 0000000000008000 R09: 0000000000000001
  R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffff00
  R13: 0000000000000021 R14: 0000000000000000 R15: 00007fff89799c40
    </TASK>

The TIPC_DUMP_ALL tracepoints in tipc_sk_enqueue() also dump
sk_receive_queue and can therefore dereference skbs that the socket
owner has already dequeued or freed. Restrict these dumps to
TIPC_DUMP_SK_BKLGQ, which matches the queue protected by the held
spinlock.

Keep the change limited to the enqueue path, where the unsafe queue dump
is reachable while the socket is owned by user context.

Fixes: 01e661ebfbad ("tipc: add trace_events for tipc socket")
Cc: stable@vger.kernel.org
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Link: https://patch.msgid.link/20260611135647.3666727-1-lixiasong1@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/socket.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 5adfd0d854a2b2..cf435dfbfa8163 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2451,17 +2451,17 @@ static void tipc_sk_enqueue(struct sk_buff_head *inputq, struct sock *sk,
 			atomic_set(dcnt, 0);
 		lim = rcvbuf_limit(sk, skb) + atomic_read(dcnt);
 		if (likely(!sk_add_backlog(sk, skb, lim))) {
-			trace_tipc_sk_overlimit1(sk, skb, TIPC_DUMP_ALL,
+			trace_tipc_sk_overlimit1(sk, skb, TIPC_DUMP_SK_BKLGQ,
 						 "bklg & rcvq >90% allocated!");
 			continue;
 		}
 
-		trace_tipc_sk_dump(sk, skb, TIPC_DUMP_ALL, "err_overload!");
+		trace_tipc_sk_dump(sk, skb, TIPC_DUMP_SK_BKLGQ, "err_overload!");
 		/* Overload => reject message back to sender */
 		onode = tipc_own_addr(sock_net(sk));
 		atomic_inc(&sk->sk_drops);
 		if (tipc_msg_reverse(onode, &skb, TIPC_ERR_OVERLOAD)) {
-			trace_tipc_sk_rej_msg(sk, skb, TIPC_DUMP_ALL,
+			trace_tipc_sk_rej_msg(sk, skb, TIPC_DUMP_SK_BKLGQ,
 					      "@sk_enqueue!");
 			__skb_queue_tail(xmitq, skb);
 		}
-- 
2.53.0

