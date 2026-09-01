Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C89EECB
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788262788; cv=none; b=JM31XtxCRQzVOrt+BFfIh32PaPFFU5x1ekZ8mUSE+iz0nWz7YJab5dGs/nWiEDJT4u+aX3hohgowtUErsAMSM/ffz3+yunqTA5yD8HvfYyrz43pXQdMSPGEHxfNInTCBK2WIYA6RgWQVhT2ByH0Kog3UragTiRSesD1tzEpwbzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788262788; c=relaxed/simple;
	bh=/cOidgSQJgLvYoTR/VT5T2lORqXN49unB/J99ZI5J5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5ZEwfdAcIWXK+30Fgnd3D+7UuXrvmqSOUwvFIh8CP1O6VfhFzMRfMT1RMIyXQi6bpYtxSxhFZ0BwTGWbr1pdD7TVCndN8ZGh6ct0G/PSyjwaQCGApnhUUNy9QVgzFi/RLWsJYs4G45NV6QAAzBWqFhnFyjIgbfHqyUQzV8TtOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIbug+ZZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIbug+ZZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88091F000E9;
	Tue,  1 Sep 2026 11:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788262787;
	bh=xVeXAj6HwTvtj/lGC7imFo+/Zb76jFdnbkEbCM1qVDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aIbug+ZZCkXdBMms7T+Opoq84PhEjFBbLZzQoNCEFSRdOFyS8EK8oEgsNdsuFNY3y
	 aA9a+ctere7jVdYnNFQ8r17PY3mkOOv7JNhAx4kmV0zUZhhPRK9PRP3v0L3CN2kVaj
	 gOdNiKbLOyFnHqxPb7l6snq2q9EW1aFWoeFWDoCBvyy9jc3ZIXI+Wh4MDn5dvwe7ai
	 5HcxTHfKywz/sdYVjwAL9e/X9WgRodsmM99O6FHw55w6XJ1E4PAUcBpFkWZmsSzOL7
	 X8hwWrVbWcWuRY99wvjjxCOYH4m5D31RVxkwKSccUgiBipG1Xz0r3LQcWWC252O9sz
	 wmRzykTexj3jw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tls: device: fix out-of-bounds write in tls_append_frag()
Date: Tue,  1 Sep 2026 07:39:45 -0400
Message-ID: <20260901113945.240701-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083139-catnap-donator-d5bc@gregkh>
References: <2026083139-catnap-donator-d5bc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <jiayuan.chen@linux.dev>

[ Upstream commit b17cf742eaad70ae29ac558cefb3aa9bbeea03d4 ]

Found with syzkaller and a local syzbot instance running on top of a
netdevsim TLS offload emulation; tls_device.c is otherwise only reachable
on a machine with a NIC that implements the offload.

tls_push_data() only checks whether the open record still has room for
another frag at the bottom of its loop, and the MSG_MORE early break
skips that check.  The record survives to the next syscall with the frag
count it already had, and tls_append_frag() does not check either, so
with TLS_TX_ZEROCOPY_RO every splice(SPLICE_F_MORE) of a byte or two adds
a non-coalescing pipe page and num_frags walks off the end of
tls_record_info.frags[MAX_SKB_FRAGS].  Once the record is pushed,
tls_push_record() runs the same index over sg_tx_data[MAX_SKB_FRAGS] and
the sg_set_page() writes land on the destruct_work that follows it, which
the workqueue then calls.

The byte limit is fine because copy drops to 0 and the loop falls through
to the same check; the frag count has no such feedback.

Push the record rather than keep a full one open, which is what a plain
TCP socket does - tcp_sendmsg_locked() uses tcp_mark_push() and
new_segment in both the copy and the MSG_SPLICE_PAGES paths, and tls_sw
already sets full_record when the sk_msg ring fills up, MSG_MORE or not.

  BUG: KASAN: slab-out-of-bounds in tls_append_frag ( net/tls/tls_device.c:269)
  Write of size 8 at addr ffff8881104d1530 by task tls_oob/450

  CPU: 2 UID: 0 PID: 450 Comm: tls_oob Not tainted 7.2.0-rc7+ #329 PREEMPT
  Call Trace:
   <TASK>
   dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
   print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
   kasan_report (mm/kasan/report.c:595)
   tls_append_frag (net/tls/tls_device.c:269)
   tls_push_data (net/tls/tls_device.c:518)
   tls_device_sendmsg (net/tls/tls_device.c:583)
   inet_sendmsg (net/ipv4/af_inet.c:865)
   sock_sendmsg (net/socket.c:775 net/socket.c:790 net/socket.c:813)
   splice_to_socket (fs/splice.c:884)
   do_splice (fs/splice.c:936 fs/splice.c:1349)
   __do_splice (fs/splice.c:1431)
   __x64_sys_splice (fs/splice.c:1634 fs/splice.c:1616)
   do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
   </TASK>

and, once the record is pushed:

  UBSAN: array-index-out-of-bounds in net/tls/tls_device.c:300:24
  index 18 is out of range for type 'skb_frag_t [17]'
  UBSAN: array-index-out-of-bounds in net/tls/tls_device.c:301:41
  index 18 is out of range for type 'scatterlist [17]'
  UBSAN: array-index-out-of-bounds in net/tls/tls_device.c:302:39
  index 18 is out of range for type 'scatterlist [17]'
  UBSAN: array-index-out-of-bounds in net/tls/tls_device.c:307:38
  index 26 is out of range for type 'scatterlist [17]'

  kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
  BUG: unable to handle page fault for address: ffffea000411a680
  #PF: supervisor instruction fetch in kernel mode
  #PF: error_code(0x0011) - permissions violation
  Oops: Oops: 0011 [#1] SMP KASAN PTI
  Workqueue: ktls_device_destruct 0xffffea000411a680
  RIP: 0010:0xffffea000411a680
  Call Trace:
   <TASK>
   worker_thread (kernel/workqueue.c:3405 kernel/workqueue.c:3486)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
   </TASK>

Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://patch.msgid.link/20260823084758.20936-1-jiayuan.chen@linux.dev
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 6118859b2a515..d5fdea2af423b 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -497,7 +497,8 @@ static int tls_push_data(struct sock *sk,
 		if (!size) {
 last_record:
 			tls_push_record_flags = flags;
-			if (flags & (MSG_SENDPAGE_NOTLAST | MSG_MORE)) {
+			if ((flags & (MSG_SENDPAGE_NOTLAST | MSG_MORE)) &&
+			    record->num_frags < MAX_SKB_FRAGS - 1) {
 				more = true;
 				break;
 			}
-- 
2.53.0

