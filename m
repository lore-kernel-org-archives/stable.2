Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795440338;
	b=k1VmPEI7g0x2YYW1PDH6pDH8VVPsVR+MDyHnpHHeK4K1EKUNroQ+yioLDkhHpmeCfKxr
	 BX3YkjYQjW6uli1qn7MfvE4yI9aiHX1W5AZj9lWlAgDqboVCZCrCWdJimopqv4q/yaHra
	 IUBCzTzb9LEc61MeqF03IGOvPyn9wo4kJRQK6OQH0NDyRaMHl7ijPkqtcaBt8JX+hguh9
	 JXSzTQCd/OV0CWUAX9splDZ41EY4Dug1dpEPFM6pp6kCsGSAIsgps7OGK0dKg29Nzj69N
	 3vEbhT4RjmTw68NfgtAw+W4jM6hiQFA3HOwYQC4Rg8YRRtmmCRFLMNYRn0Hxe2ydPbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440338;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=oy64PdZyhO4DtmF/zcDvZ3jcwcS/HhDwapf7h/PdNXg=;
	b=NY9xwx+w/XfbQhHhv76qIAI7cnBsmpE8cWKtdur3px9XnsPL1scsIFB4h/n5OSY/eSnp
	 ogbAbBeYkjoRW7rVFQLdu7WWstK3FCHzyZfD7UaYf/DV5w0/Iws8oO2vFNGtJMrE+pf9u
	 Lt5zQW9xdOLs6CVaH0RO1kEr3zdg7MoXxnJ+qugHR280ByMVPP9/mCEzT1Y9nsMgrWcqF
	 Z9jObN0j0BYIkQcDSEati68mEgvQmnQILuIs+03LXuvTA2A2bNOB80O4iAh3NXRkdG0Ap
	 S8vtmIFgIVca4i+yKrPP68NQmfld9DV7iYw790qYZSmWaVsXHXaUE5loQw++EVb4YZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zn4qLv5F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57561606A327;
	Mon, 23 Nov 2026 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zn4qLv5F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E0C1F0089E;
	Mon, 23 Nov 2026 13:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795440337;
	bh=oy64PdZyhO4DtmF/zcDvZ3jcwcS/HhDwapf7h/PdNXg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Zn4qLv5FdYdHJ94ANhkV1fjsIW6OFYteX7xUcBmxOSJvfZL8wkY8EwKBV2v/SqQIL
	 MAWkddx20l+KCYBqcQQhIUv7a2Bn7Lourtwx/1BfbFwyQ1UCownh2k6Z3iDqnc/I5J
	 LjPZr3NqtthkWxPP9eNGapWflCATW9cB7PPmcocEU8t1YPrHCd7YEcu3SHz1kXMm88
	 YpgDXobipHxjYAmEZc5YYuYI9a6sL2XtUlBuGZ3vBJ3boVCSKsIJYn1QITbHMzldI6
	 +/vROYvI30ieddzl0NFuPv90xO3VyaSCJc3Ya4AClMwq1ajkbJH1/agk07JEE7WpG8
	 42VXSpcgnPl/w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 23 Nov 2026 14:24:52 +0100
Subject: [PATCH net 04/10] mptcp: fix use-after-free of the subflow context
 on the delegated list
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-4-278042217e8d@kernel.org>
References: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-0-278042217e8d@kernel.org>
In-Reply-To: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-0-278042217e8d@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 Simon Horman <horms@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Christoph Paasch <cpaasch@openai.com>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Davide Caratti <dcaratti@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Hyunwoo Kim <imv4bel@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16707; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BfmlDaYNXU7G6mWiG3Vgi7hri1N3ZYChGlKVzTq4VH4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJZ7HZJTLyjeLpyxYKGZPlyKTnjQ3KLLulPby9Nj/gec
 fuG2ze+jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlYxzD8s1nzu0vqYmKx51KT
 lFD5df2uez7/DytffnWDko5Fb1qlCCPDBY+vcv8dz+5v5WRb1b3ntoSv9yEeu9ezhYtj/kh5GPR
 yAwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Hyunwoo Kim <imv4bel@gmail.com>

mptcp_subflow_delegate() links the subflow context into a per-CPU napi
list and takes a reference on the subflow socket. The context is a
separate allocation, reached through icsk_ulp_data, and the list holds
no reference to it.

inet_csk_destroy_sock() runs sk_prot->destroy() regardless of the
outstanding references. That path ends in tcp_cleanup_ulp(), which calls
subflow_ulp_release(). subflow_ulp_release() frees the context with
kfree_rcu() but does not remove it from the list. Once the grace period
elapses and the context is actually freed, the next mptcp_napi_poll()
dequeues that entry and mptcp_subflow_delegated_next() writes to the
freed context with list_del_init(). That is the use-after-free.

The decoded KASAN trace is:

 ==================================================================
 BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report (lib/list_debug.c:49)
 Read of size 8 at addr ffff88800cc13cc8 by task poc/88

 CPU: 3 UID: 65534 PID: 88 Comm: poc Not tainted 7.2.0-rc7 #1 PREEMPT(lazy)
 Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 Call Trace:
  <IRQ>
  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
  ? __pfx__raw_spin_lock_irqsave (include/asm-generic/qrwlock.h:122 (discriminator 4))
  ? __list_del_entry_valid_or_report (lib/list_debug.c:49)
  kasan_report (mm/kasan/report.c:595)
  ? __list_del_entry_valid_or_report (lib/list_debug.c:49)
  __list_del_entry_valid_or_report (lib/list_debug.c:49)
  mptcp_napi_poll (include/linux/list.h:132 include/linux/list.h:246 include/linux/list.h:318 net/mptcp/protocol.h:787 net/mptcp/protocol.c:4620)
  ? call_timer_fn (kernel/time/timer.c:1748)
  __napi_poll (net/core/dev.c:7735)
  ? __pfx_delayed_work_timer_fn (include/linux/list.h:404 (discriminator 2))
  net_rx_action (net/core/dev.c:7798 net/core/dev.c:7955)
  ? __pfx_net_rx_action (include/net/gro.h:525)
  ? _raw_spin_lock_irq (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:1301 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:143 kernel/locking/spinlock.c:174)
  ? __pfx__raw_spin_lock_irq (kernel/locking/spinlock.c:183)
  ? try_to_wake_up (include/linux/spinlock.h:571 kernel/sched/core.c:4292)
  handle_softirqs (kernel/softirq.c:622)
  ? __pfx_handle_softirqs (include/linux/wait_bit.h:77)
  ? __hrtimer_rearm_deferred (kernel/time/hrtimer.c:707 kernel/time/hrtimer.c:2141 kernel/time/hrtimer.c:2161)
  do_softirq (kernel/softirq.c:523 (discriminator 20) kernel/softirq.c:510 (discriminator 20))
  </IRQ>
  <TASK>
  __local_bh_enable_ip (kernel/softirq.c:450)
  inet_stream_connect (net/ipv4/af_inet.c:756)
  __sys_connect (net/socket.c:2154)
  ? __pfx___sys_connect (net/socket.c:2136)
  ? __sys_setsockopt (include/linux/file.h:63 include/linux/file.h:83 net/socket.c:2385)
  __x64_sys_connect (net/socket.c:2160 net/socket.c:2157 net/socket.c:2157)
  ? fpregs_assert_state_consistent (include/linux/instrumented.h:82 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:133 arch/x86/kernel/fpu/core.c:912)
  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
 RIP: 0033:0x4216eb
 Code: 48 89 e5 48 83 ec 10 89 55 f8 48 89 75 f0 89 7d fc e8 b9 ec 02 00 8b 55 f8 48 8b 75 f0 41 89 c0 8b 7d fc b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2d 44 89 c7 89 45 fc e8 12 ed 02 00 8b 45 fc
All code
========
   0:	48 89 e5             	mov    %rsp,%rbp
   3:	48 83 ec 10          	sub    $0x10,%rsp
   7:	89 55 f8             	mov    %edx,-0x8(%rbp)
   a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   e:	89 7d fc             	mov    %edi,-0x4(%rbp)
  11:	e8 b9 ec 02 00       	call   0x2eccf
  16:	8b 55 f8             	mov    -0x8(%rbp),%edx
  19:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  1d:	41 89 c0             	mov    %eax,%r8d
  20:	8b 7d fc             	mov    -0x4(%rbp),%edi
  23:	b8 2a 00 00 00       	mov    $0x2a,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 2d                	ja     0x5f
  32:	44 89 c7             	mov    %r8d,%edi
  35:	89 45 fc             	mov    %eax,-0x4(%rbp)
  38:	e8 12 ed 02 00       	call   0x2ed4f
  3d:	8b 45 fc             	mov    -0x4(%rbp),%eax

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 2d                	ja     0x35
   8:	44 89 c7             	mov    %r8d,%edi
   b:	89 45 fc             	mov    %eax,-0x4(%rbp)
   e:	e8 12 ed 02 00       	call   0x2ed25
  13:	8b 45 fc             	mov    -0x4(%rbp),%eax
 RSP: 002b:00007fbe0147b1d0 EFLAGS: 00000293 ORIG_RAX: 000000000000002a
 RAX: ffffffffffffffda RBX: 000000000000000a RCX: 00000000004216eb
 RDX: 0000000000000010 RSI: 00007fbe0147b200 RDI: 000000000000000a
 RBP: 00007fbe0147b1e0 R08: 0000000000000000 R09: 0000000000000000
 R10: 00007fbe0147b1f8 R11: 0000000000000293 R12: 00007fbe0147b1f8
 R13: 00007fbe0157b678 R14: 00007fbe0147b1f4 R15: 00007fffd4bc16c0
  </TASK>

 Allocated by task 90:
  kasan_save_stack (mm/kasan/common.c:57)
  kasan_save_track (mm/kasan/common.c:78)
  __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
  __kmalloc_cache_noprof (include/linux/kasan.h:263 mm/slub.c:5489)
  subflow_create_ctx (include/linux/slab.h:988 include/linux/slab.h:1309 net/mptcp/subflow.c:1845)
  subflow_ulp_init (net/mptcp/subflow.c:1977)
  tcp_set_ulp (net/ipv4/tcp_ulp.c:146 net/ipv4/tcp_ulp.c:167)
  mptcp_subflow_create_socket (net/mptcp/subflow.c:1806)
  __mptcp_nmpc_sk.part.0 (net/mptcp/protocol.c:111 net/mptcp/protocol.c:143)
  mptcp_connect (net/mptcp/protocol.c:139 net/mptcp/protocol.c:4009)
  __inet_stream_connect (net/ipv4/af_inet.c:684)
  inet_stream_connect (net/ipv4/af_inet.c:755)
  __sys_connect (net/socket.c:2154)
  __x64_sys_connect (net/socket.c:2160 net/socket.c:2157 net/socket.c:2157)
  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

 Freed by task 22:
  kasan_save_stack (mm/kasan/common.c:57)
  kasan_save_track (mm/kasan/common.c:78)
  kasan_save_free_info (mm/kasan/generic.c:584)
  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
  kvfree_rcu_cb (include/linux/kasan.h:235 mm/slub.c:2677 mm/slub.c:6377 mm/slub.c:6662)
  rcu_core (kernel/rcu/tree.c:2645 kernel/rcu/tree.c:2897)
  handle_softirqs (kernel/softirq.c:622)
  run_ksoftirqd (kernel/softirq.c:1076 kernel/softirq.c:1068)
  smpboot_thread_fn (kernel/smpboot.c:160)
  kthread (kernel/kthread.c:436)
  ret_from_fork (arch/x86/kernel/process.c:158)
  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

 Last potentially related work creation:
  kasan_save_stack (mm/kasan/common.c:57)
  kasan_record_aux_stack (mm/kasan/generic.c:556)
  __call_rcu_common.constprop.0 (kernel/rcu/tree.c:3159)
  tcp_cleanup_ulp (net/ipv4/tcp_ulp.c:124)
  tcp_v4_destroy_sock (net/ipv4/tcp_ipv4.c:2437)
  inet_csk_destroy_sock (net/ipv4/inet_connection_sock.c:1282)
  __tcp_close (net/ipv4/tcp.c:3299)
  __mptcp_close_ssk (net/mptcp/protocol.c:2648)
  mptcp_destroy_common (net/mptcp/protocol.c:3442 (discriminator 1))
  mptcp_destroy (net/mptcp/protocol.c:3651)
  __mptcp_destroy_sock (net/mptcp/protocol.c:3284)
  __mptcp_close (net/mptcp/protocol.c:3386)
  mptcp_close (net/mptcp/protocol.c:3401)
  inet_release (net/ipv4/af_inet.c:442)
  __sock_release (net/socket.c:710)
  sock_close (net/socket.c:1501 (discriminator 1))
  __fput (fs/file_table.c:512)
  fput_close_sync (fs/file_table.c:617)
  __x64_sys_close (fs/open.c:1511 fs/open.c:1496 fs/open.c:1496)
  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

 Second to last potentially related work creation:
  kasan_save_stack (mm/kasan/common.c:57)
  kasan_record_aux_stack (mm/kasan/generic.c:556)
  kvfree_call_rcu (mm/slab_common.c:1288)
  tcp_cleanup_ulp (net/ipv4/tcp_ulp.c:124)
  tcp_v4_destroy_sock (net/ipv4/tcp_ipv4.c:2437)
  inet_csk_destroy_sock (net/ipv4/inet_connection_sock.c:1282)
  __tcp_close (net/ipv4/tcp.c:3299)
  __mptcp_close_ssk (net/mptcp/protocol.c:2648)
  mptcp_destroy_common (net/mptcp/protocol.c:3442 (discriminator 1))
  mptcp_destroy (net/mptcp/protocol.c:3651)
  __mptcp_destroy_sock (net/mptcp/protocol.c:3284)
  __mptcp_close (net/mptcp/protocol.c:3386)
  mptcp_close (net/mptcp/protocol.c:3401)
  inet_release (net/ipv4/af_inet.c:442)
  __sock_release (net/socket.c:710)
  sock_close (net/socket.c:1501 (discriminator 1))
  __fput (fs/file_table.c:512)
  fput_close_sync (fs/file_table.c:617)
  __x64_sys_close (fs/open.c:1511 fs/open.c:1496 fs/open.c:1496)
  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

 The buggy address belongs to the object at ffff88800cc13c00
  which belongs to the cache kmalloc-512 of size 512
 The buggy address is located 200 bytes inside of
  freed 512-byte region [ffff88800cc13c00, ffff88800cc13e00)

 The buggy address belongs to the physical page:
 page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xcc10
 head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
 flags: 0x100000000000040(head|node=0|zone=1)
 page_type: f5(slab)
 raw: 0100000000000040 ffff888007042c80 dead000000000100 dead000000000122
 raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
 head: 0100000000000040 ffff888007042c80 dead000000000100 dead000000000122
 head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
 head: 0100000000000002 ffffffffffffff01 00000000ffffffff 00000000ffffffff
 head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffff88800cc13b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88800cc13c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 >ffff88800cc13c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                               ^
  ffff88800cc13d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88800cc13d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ==================================================================

The freeing path cannot dequeue the entry itself: the list is per-CPU
and only the CPU that queued the subflow may touch it, as
tcp_release_cb_override() already notes.

Delay the free instead. Add MPTCP_DELEGATE_DEAD.
mptcp_subflow_free_ctx() sets it and frees the context only if the
subflow is not scheduled, while mptcp_napi_poll() frees it if the dead
bit is set when it clears the scheduled bit. Either
mptcp_subflow_free_ctx() gets there first, sees the scheduled bit and
leaves the free to mptcp_napi_poll(), or mptcp_napi_poll() gets there
first, does not see the dead bit and mptcp_subflow_free_ctx() does the
free.

Also skip mptcp_subflow_process_delegated() once the dead bit is set.
subflow_ulp_release() has already dropped the msk reference by then, so
the pending actions must not run.

Finally, move delegated_status out of struct_group(reset).
mptcp_subflow_ctx_reset() clears that group on disconnect, and clearing
the scheduled bit while the entry is still queued would let
mptcp_subflow_free_ctx() free a context the napi list still points to.
delegated_node is already outside the group.

Fixes: b19bc2945b40 ("mptcp: implement delegated actions")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 13 ++++++++++---
 net/mptcp/protocol.h | 18 ++++++++++++++++--
 net/mptcp/subflow.c  |  4 ++--
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 50c294d925b0..23d35f43b566 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2708,7 +2708,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	 */
 	if (!inet_csk(ssk)->icsk_ulp_ops) {
 		WARN_ON_ONCE(!sock_flag(ssk, SOCK_DEAD));
-		kfree_rcu(subflow, rcu);
+		mptcp_subflow_free_ctx(subflow);
 	} else {
 		/* otherwise tcp will dispose of the ssk and subflow ctx */
 		__tcp_close(ssk, 0);
@@ -4803,10 +4803,13 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
 	delegated = container_of(napi, struct mptcp_delegated_action, napi);
 	while ((subflow = mptcp_subflow_delegated_next(delegated)) != NULL) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		long status;
 
 		bh_lock_sock_nested(ssk);
 		if (!sock_owned_by_user(ssk)) {
-			mptcp_subflow_process_delegated(ssk, xchg(&subflow->delegated_status, 0));
+			status = xchg(&subflow->delegated_status, 0);
+			if (!(status & BIT(MPTCP_DELEGATE_DEAD)))
+				mptcp_subflow_process_delegated(ssk, status);
 		} else {
 			/* tcp_release_cb_override already processed
 			 * the action or will do at next release_sock().
@@ -4814,11 +4817,15 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
 			 * CPU that scheduled it.
 			 */
 			smp_wmb();
-			clear_bit(MPTCP_DELEGATE_SCHEDULED, &subflow->delegated_status);
+			status = set_mask_bits(&subflow->delegated_status,
+					       BIT(MPTCP_DELEGATE_SCHEDULED), 0);
 		}
 		bh_unlock_sock(ssk);
 		sock_put(ssk);
 
+		if (status & BIT(MPTCP_DELEGATE_DEAD))
+			kfree_rcu(subflow, rcu);
+
 		if (++work_done == budget)
 			return budget;
 	}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7d226ee38315..7644651f01a8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -553,8 +553,10 @@ DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 #define MPTCP_DELEGATE_SEND		1
 #define MPTCP_DELEGATE_ACK		2
 #define MPTCP_DELEGATE_SNDBUF		3
+#define MPTCP_DELEGATE_DEAD		4
 
-#define MPTCP_DELEGATE_ACTIONS_MASK	(~BIT(MPTCP_DELEGATE_SCHEDULED))
+#define MPTCP_DELEGATE_ACTIONS_MASK	(~(BIT(MPTCP_DELEGATE_SCHEDULED) | \
+					   BIT(MPTCP_DELEGATE_DEAD)))
 /* MPTCP subflow context */
 struct mptcp_subflow_context {
 	struct	list_head node;/* conn_list of subflows */
@@ -628,11 +630,11 @@ struct mptcp_subflow_context {
 
 	u32	subflow_id;
 
-	long	delegated_status;
 	unsigned long	fail_tout;
 
 	);
 
+	long	delegated_status;
 	struct	list_head delegated_node;   /* link into delegated_action, protected by local BH */
 
 	u32	setsockopt_seq;
@@ -671,6 +673,8 @@ mptcp_subflow_ctx_reset(struct mptcp_subflow_context *subflow)
 	memset(&subflow->reset, 0, sizeof(subflow->reset));
 	subflow->request_mptcp = 1;
 	WRITE_ONCE(subflow->local_id, -1);
+	set_mask_bits(&subflow->delegated_status,
+		      MPTCP_DELEGATE_ACTIONS_MASK, 0);
 }
 
 /* Convert reset reasons in MPTCP to enum sk_rst_reason type */
@@ -808,6 +812,16 @@ mptcp_subflow_delegated_next(struct mptcp_delegated_action *delegated)
 	return ret;
 }
 
+static inline void mptcp_subflow_free_ctx(struct mptcp_subflow_context *subflow)
+{
+	long old = set_mask_bits(&subflow->delegated_status, 0,
+				 BIT(MPTCP_DELEGATE_DEAD));
+
+	/* a scheduled subflow is owned by mptcp_napi_poll(), which will free it */
+	if (!(old & BIT(MPTCP_DELEGATE_SCHEDULED)))
+		kfree_rcu(subflow, rcu);
+}
+
 void __mptcp_inherit_memcg(struct sock *sk, struct sock *ssk, gfp_t gfp);
 void __mptcp_inherit_cgrp_data(struct sock *sk, struct sock *ssk);
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6f07544bfe40..20d506235074 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -832,7 +832,7 @@ void mptcp_subflow_drop_ctx(struct sock *ssk)
 			sock_put(ctx->conn);
 	}
 
-	kfree_rcu(ctx, rcu);
+	mptcp_subflow_free_ctx(ctx);
 }
 
 void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
@@ -2098,7 +2098,7 @@ static void subflow_ulp_release(struct sock *ssk)
 
 	mptcp_subflow_ops_undo_override(ssk);
 	if (release)
-		kfree_rcu(ctx, rcu);
+		mptcp_subflow_free_ctx(ctx);
 }
 
 static void subflow_ulp_clone(const struct request_sock *req,

-- 
2.55.0

