Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FE63559F2
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 12:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117235; cv=none; b=KWceWc8Rf+7wsZtW1q69vGx0P0bBYtmAKAYsZi8rSU5iIyUyA2mlYactgc31aVj8Gnw9u8L6d/xd1gak/WNd2k3Nz4OG9w14lcRD9S9CbDKNs3JswuEHYmyL6OeAJrET09vcTZKx6oD1kw03RoC8QI4Y+sJ81L4uboQ+Bcf0sN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117235; c=relaxed/simple;
	bh=iDYDSgr0CAoeWpKdzqYpe0GvsjIfU10xvCfCO8oFEq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eDUbYJ86hF+ym7k1p31jdU09qVSVKxkDZv+oykGH1mz8tKGjE2fTEW5o1VVOLqmFoDSQRbfXGmWwA+T6p4Xcjm0kwYM8S3IQFtDz/5QbB2oOx4iGIj7+9Obb0XlkPUCNESzK2HKJQu3ZD/hKRb+fk1td9rErqrPGmsZhZJsCZf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=LFU2mATC; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="LFU2mATC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=LuK1HKc1hrlFuwJVBC01An15H8zC71Cdk1G1Ug/JvnI=; b=LFU2mATCGr2U1E5CGhFK+YMGmc
	mtrYGgoZ/TZj1g9UngR1Oi6/HkLhDnfjfoLDpaRu72PpQ67VCn6lkc8rkZWzbuc1tC3uhbDg6/Nlw
	U/7oWPa5x7z86hZ7CaCcg1xxxg4OgebKfhATlDlRqQMLdzXoqe/vABBmvsmgZxflyI1RcPIe3adtE
	hTbu8VwJigwkX2t7Dm9WXm2CprEAw17HgllUW8FzoZ/A74zGESCS69F9xLd7Q6j7RVOvDXglXM5HY
	uDd5yp/wvJO+nNzzeIB03cYn4ntXn1mPbWYitUVjhGluTp1WD008RihgPt2ybLETSO0KWImXUYkKV
	SK+i+5aQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: stable@vger.kernel.org
Cc: heiko@sntech.de,
	quentin.schulz@cherry.de,
	Kuniyuki Iwashima <kuniyu@google.com>,
	syzbot+e809069bc15f26300526@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 6.12.y] tcp: Add preempt_{disable,enable}_nested() in reqsk_queue_hash_req().
Date: Wed, 15 Jul 2026 14:07:04 +0200
Message-ID: <20260715120704.1950127-1-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit e10902df24488ca722303133acfc82490f7d59ad ]

syzbot reported a weird reqsk->rsk_refcnt underflow in
__inet_csk_reqsk_queue_drop().

The captured reqsk_put() in __inet_csk_reqsk_queue_drop()
is called only when it successfully removes reqsk from ehash.

Moreover, reqsk_timer_handler() calls another reqsk_put()
after that.

This indicates that the reqsk was missing both refcnts for
ehash and the timer itself.

Since all the syzbot reports had PREEMPT_RT enabled, the only
possible scenario is that reqsk_queue_hash_req() is preempted
after mod_timer() and before refcount_set(), and then the timer
triggered after 1s aborts the reqsk due to its listener's close().

Let's wrap mod_timer() and refcount_set() with
preempt_disable_nested() and preempt_enable_nested().

Note that inet_ehash_insert() holds the normal spin_lock()
(mutex in PREEMPT_RT), so it must be called outside of
preempt_disable_nested(), but this is fine.

The lookup path just ignores 0 sk_refcnt entries in ehash
and tries to create another reqsk, but this will fail at
inet_ehash_insert().

[0]:
refcount_t: underflow; use-after-free.
WARNING: lib/refcount.c:28 at refcount_warn_saturate+0xb2/0x110 lib/refcount.c:28, CPU#0: ktimers/0/16
Modules linked in:
CPU: 0 UID: 0 PID: 16 Comm: ktimers/0 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)}
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:refcount_warn_saturate+0xb2/0x110 lib/refcount.c:28
Code: e4 7d d1 0a 67 48 0f b9 3a eb 4a e8 38 3d 23 fd 48 8d 3d e1 7d d1 0a 67 48 0f b9 3a eb 37 e8 25 3d 23 fd 48 8d 3d de 7d d1 0a <67> 48 0f b9 3a eb 24 e8 12 3d 23 fd 48 8d 3d db 7d d1 0a 67 48 0f
RSP: 0000:ffffc90000157948 EFLAGS: 00010246
RAX: ffffffff84a1301b RBX: 0000000000000003 RCX: ffff88801ca98000
RDX: 0000000000000100 RSI: 0000000000000000 RDI: ffffffff8f72ae00
RBP: ffffffff99ae3b01 R08: ffff88801ca98000 R09: 0000000000000005
R10: 0000000000000100 R11: 0000000000000004 R12: ffff8880425ef568
R13: ffff8880425ef4f8 R14: ffff8880425ef578 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888126386000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7b46710e9c CR3: 000000000dbb6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:400 [inline]
 __refcount_dec_and_test include/linux/refcount.h:432 [inline]
 refcount_dec_and_test include/linux/refcount.h:450 [inline]
 reqsk_put include/net/request_sock.h:136 [inline]
 __inet_csk_reqsk_queue_drop+0x3ce/0x440 net/ipv4/inet_connection_sock.c:1007
 reqsk_timer_handler+0x651/0xdf0 net/ipv4/inet_connection_sock.c:1137
 call_timer_fn+0x192/0x5e0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x6a3/0x9f0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0x67/0x170 kernel/time/timer.c:2403
 handle_softirqs+0x1de/0x6d0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 run_ktimerd+0x69/0x100 kernel/softirq.c:1151
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
Reported-by: syzbot+e809069bc15f26300526@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a1a7bcf.0a9e871e.332604.000b.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://patch.msgid.link/20260601182101.3183993-1-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[updated to not require timeout changes from
 commit 3ce5dd8161ec ("tcp: Remove timeout arg from reqsk_queue_hash_req()")
 DCCP was retired by commit 2a63dd0edf38 ("net: Retire DCCP socket.") after
 the release of 6.12, so the shared inet_csk_reqsk_queue_hash_add still
 requires the timout argument]
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 net/ipv4/inet_connection_sock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index dd39cabb3900..5ff45bc85442 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1186,6 +1186,9 @@ static bool reqsk_queue_hash_req(struct request_sock *req,
 
 	/* The timer needs to be setup after a successful insertion. */
 	timer_setup(&req->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
+
+	preempt_disable_nested();
+
 	mod_timer(&req->rsk_timer, jiffies + timeout);
 
 	/* before letting lookups find us, make sure all req fields
@@ -1193,6 +1196,9 @@ static bool reqsk_queue_hash_req(struct request_sock *req,
 	 */
 	smp_wmb();
 	refcount_set(&req->rsk_refcnt, 2 + 1);
+
+	preempt_enable_nested();
+
 	return true;
 }
 
-- 
2.53.0

