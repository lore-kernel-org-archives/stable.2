Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163534CDA3C;
	Thu, 24 Sep 2026 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281407; cv=none; b=g02Jma+DkIzIf4YdLJenM6fUS7a4DpcE1P1ODLGN9ArrIZPxnfXW7hpNylGaCx4nY0wUfczCPuATCHoR8rxzT6dkD2L1kJzYU/VBtf4qGIRhOQ6glQUqz402T9uyZyTxVV2oNFsXtPNOwF4cR7e1QyNU7wNtW6ZmuV47cuvqaus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281407; c=relaxed/simple;
	bh=k+a/7EFIKGPdvgGWpF/4YPgmMhIbNIbdtJXUaqgz+9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F3PzmIbjLmTt9kWYijWVJiw6R3jHUM2APEANDp2M20wseypHQkt05GhhVGvgQCOZYz4BMbjfFKC15jSJIDUYZ4FCviw8mowV5nyGwpXM5d9q/sNYT9UkNbn0S9cWWUErrOGKH75We/LdNUWGZgVBJeh66WYQpltR+BELiQA0f3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qwr1MFJz; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qwr1MFJz"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 632754E41060;
	Thu, 24 Sep 2026 20:23:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3766060738;
	Thu, 24 Sep 2026 20:23:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 30BBA10329539;
	Thu, 24 Sep 2026 22:23:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790281392; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nIPlIKuRqxfztPDmnAMxiI/IBeEw2JynXIaSK2xboSc=;
	b=Qwr1MFJzkwzyhUxcNauhKkeSRsGSVzIsFfx/oto0G1GLgsgnyNMpbq+9zUPoVlDNPeBHk2
	rgxBQchvhSQ1zftkZ6B76Mq5+IK0ab1MVp/JlUREzPtft2NG+YRv59Fsd6MaRRd/P9YDnd
	SfdBc3jQ/dHJm7/Zk8QLquX9Ve6ZvaPdJJGm60yppFHWOzai+CrKJ52oSrJrd8ynGOoNmr
	SzIHRD4aR7G434rJ6UAQIgcgDiNzKl3GBAde2YQwxTFiUp+HN5aNxAuF/rigja+qAjei+s
	022uxaaNRQrUqoix5z0uJTnbkR3GTa7U5PlItZMmSquYBq7O/Xe4Gv2AQHlj4A==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Thu, 24 Sep 2026 22:22:44 +0200
Subject: [PATCH 5.10.y 3/3] net: preserve skb_end_offset() in
 skb_unclone_keeptruesize()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-cve-2022-49142-v1-3-0bfea684c11b@bootlin.com>
References: <20260924-cve-2022-49142-v1-0-0bfea684c11b@bootlin.com>
In-Reply-To: <20260924-cve-2022-49142-v1-0-0bfea684c11b@bootlin.com>
To: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, 
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Marco Elver <elver@google.com>, 
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Benjamin Robin <benjamin.robin@bootlin.com>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>, 
 syzbot <syzkaller@googlegroups.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790281368; l=6294;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=tkkv9VY7HMCC4aTIdr9Smcy7lneqoDWyQ65a18sdRBM=;
 b=9xd2dWAmKYYBDVmdTG4AfOOa1ZR/TlnIWSGCzyo7CPbNvCREhbDSJUecBuTxl4/raiHOxG2m7
 GFYkorCknOwCQBHstJjWfGiEFCphv1gEH66RJHyOixVHVTSk7YmMYlM
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Eric Dumazet <edumazet@google.com>

commit 2b88cba55883eaafbc9b7cbff0b2c7cdba71ed01 upstream.

syzbot found another way to trigger the infamous WARN_ON_ONCE(delta < len)
in skb_try_coalesce() [1]

I was able to root cause the issue to kfence.

When kfence is in action, the following assertion is no longer true:

int size = xxxx;
void *ptr1 = kmalloc(size, gfp);
void *ptr2 = kmalloc(size, gfp);

if (ptr1 && ptr2)
	ASSERT(ksize(ptr1) == ksize(ptr2));

We attempted to fix these issues in the blamed commits, but forgot
that TCP was possibly shifting data after skb_unclone_keeptruesize()
has been used, notably from tcp_retrans_try_collapse().

So we not only need to keep same skb->truesize value,
we also need to make sure TCP wont fill new tailroom
that pskb_expand_head() was able to get from a
addr = kmalloc(...) followed by ksize(addr)

Split skb_unclone_keeptruesize() into two parts:

1) Inline skb_unclone_keeptruesize() for the common case,
   when skb is not cloned.

2) Out of line __skb_unclone_keeptruesize() for the 'slow path'.

WARNING: CPU: 1 PID: 6490 at net/core/skbuff.c:5295 skb_try_coalesce+0x1235/0x1560 net/core/skbuff.c:5295
Modules linked in:
CPU: 1 PID: 6490 Comm: syz-executor161 Not tainted 5.17.0-rc4-syzkaller-00229-g4f12b742eb2b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:skb_try_coalesce+0x1235/0x1560 net/core/skbuff.c:5295
Code: bf 01 00 00 00 0f b7 c0 89 c6 89 44 24 20 e8 62 24 4e fa 8b 44 24 20 83 e8 01 0f 85 e5 f0 ff ff e9 87 f4 ff ff e8 cb 20 4e fa <0f> 0b e9 06 f9 ff ff e8 af b2 95 fa e9 69 f0 ff ff e8 95 b2 95 fa
RSP: 0018:ffffc900063af268 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000ffffffd5 RCX: 0000000000000000
RDX: ffff88806fc05700 RSI: ffffffff872abd55 RDI: 0000000000000003
RBP: ffff88806e675500 R08: 00000000ffffffd5 R09: 0000000000000000
R10: ffffffff872ab659 R11: 0000000000000000 R12: ffff88806dd554e8
R13: ffff88806dd9bac0 R14: ffff88806dd9a2c0 R15: 0000000000000155
FS:  00007f18014f9700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002000 CR3: 000000006be7a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tcp_try_coalesce net/ipv4/tcp_input.c:4651 [inline]
 tcp_try_coalesce+0x393/0x920 net/ipv4/tcp_input.c:4630
 tcp_queue_rcv+0x8a/0x6e0 net/ipv4/tcp_input.c:4914
 tcp_data_queue+0x11fd/0x4bb0 net/ipv4/tcp_input.c:5025
 tcp_rcv_established+0x81e/0x1ff0 net/ipv4/tcp_input.c:5947
 tcp_v4_do_rcv+0x65e/0x980 net/ipv4/tcp_ipv4.c:1719
 sk_backlog_rcv include/net/sock.h:1037 [inline]
 __release_sock+0x134/0x3b0 net/core/sock.c:2779
 release_sock+0x54/0x1b0 net/core/sock.c:3311
 sk_wait_data+0x177/0x450 net/core/sock.c:2821
 tcp_recvmsg_locked+0xe28/0x1fd0 net/ipv4/tcp.c:2457
 tcp_recvmsg+0x137/0x610 net/ipv4/tcp.c:2572
 inet_recvmsg+0x11b/0x5e0 net/ipv4/af_inet.c:850
 sock_recvmsg_nosec net/socket.c:948 [inline]
 sock_recvmsg net/socket.c:966 [inline]
 sock_recvmsg net/socket.c:962 [inline]
 ____sys_recvmsg+0x2c4/0x600 net/socket.c:2632
 ___sys_recvmsg+0x127/0x200 net/socket.c:2674
 __sys_recvmsg+0xe2/0x1a0 net/socket.c:2704
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Fixes: c4777efa751d ("net: add and use skb_unclone_keeptruesize() helper")
Fixes: 097b9146c0e2 ("net: fix up truesize of cloned skb in skb_prepare_for_shift()")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Marco Elver <elver@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/skbuff.h | 18 +++++++++---------
 net/core/skbuff.c      | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 34b6a7e3af8d..0a7b1a7f1ae1 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1655,19 +1655,19 @@ static inline int skb_unclone(struct sk_buff *skb, gfp_t pri)
 	return 0;
 }
 
-/* This variant of skb_unclone() makes sure skb->truesize is not changed */
+/* This variant of skb_unclone() makes sure skb->truesize
+ * and skb_end_offset() are not changed, whenever a new skb->head is needed.
+ *
+ * Indeed there is no guarantee that ksize(kmalloc(X)) == ksize(kmalloc(X))
+ * when various debugging features are in place.
+ */
+int __skb_unclone_keeptruesize(struct sk_buff *skb, gfp_t pri);
 static inline int skb_unclone_keeptruesize(struct sk_buff *skb, gfp_t pri)
 {
 	might_sleep_if(gfpflags_allow_blocking(pri));
 
-	if (skb_cloned(skb)) {
-		unsigned int save = skb->truesize;
-		int res;
-
-		res = pskb_expand_head(skb, 0, 0, pri);
-		skb->truesize = save;
-		return res;
-	}
+	if (skb_cloned(skb))
+		return __skb_unclone_keeptruesize(skb, pri);
 	return 0;
 }
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 8118cd4e1b31..84fe9cdd16c3 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1737,6 +1737,38 @@ struct sk_buff *skb_realloc_headroom(struct sk_buff *skb, unsigned int headroom)
 }
 EXPORT_SYMBOL(skb_realloc_headroom);
 
+int __skb_unclone_keeptruesize(struct sk_buff *skb, gfp_t pri)
+{
+	unsigned int saved_end_offset, saved_truesize;
+	struct skb_shared_info *shinfo;
+	int res;
+
+	saved_end_offset = skb_end_offset(skb);
+	saved_truesize = skb->truesize;
+
+	res = pskb_expand_head(skb, 0, 0, pri);
+	if (res)
+		return res;
+
+	skb->truesize = saved_truesize;
+
+	if (likely(skb_end_offset(skb) == saved_end_offset))
+		return 0;
+
+	shinfo = skb_shinfo(skb);
+
+	/* We are about to change back skb->end,
+	 * we need to move skb_shinfo() to its new location.
+	 */
+	memmove(skb->head + saved_end_offset,
+		shinfo,
+		offsetof(struct skb_shared_info, frags[shinfo->nr_frags]));
+
+	skb_set_end_offset(skb, saved_end_offset);
+
+	return 0;
+}
+
 /**
  *	skb_expand_head - reallocate header of &sk_buff
  *	@skb: buffer to reallocate

-- 
2.55.0

