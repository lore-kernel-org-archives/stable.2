Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2143B2FF8
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179212; cv=none; b=NYFHd02P/3RGqZHhEXIXqq+cKcOyLNb36ckEtrq8zQtHevtxiRTDCCM3VY5D1NVGT3NajCIDjz0vkEOBSkWZQ1tJopvGah3RdOCbbXW/BbEgw5BrUGPs5SGkGegYBq/ATzsXClR8/TPWx4c1RiQnG8SfApOhkMH81SohMFQn+wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179212; c=relaxed/simple;
	bh=Ma3cnSY3HnE/umYsOyFbQ5RiZpPOqnl0cXxY5JLV3vw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L3hW84FZgq8eN5ODxDHn7UC9tEf2haFW5VNuRjWrfVJm4UiZSmt++rMGNtEA+2TSkprNfDs5xJ+Z+lwqJQN1hjq4zStM5P7iNCk0lOz5t9kAPG04iIIme+BnKua8y+i7nERa6gsRSKBnpqgACo5HlEiM9lidsaDZXfjCC9ruveA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K2zRVEGN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K2zRVEGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2681F000E9;
	Mon, 31 Aug 2026 12:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788179211;
	bh=cfam7ZFxqJZibA8U11I6n1IOO2EZr1/a5tFDK10U0Fk=;
	h=Subject:To:Cc:From:Date;
	b=K2zRVEGNRtvD86Ov5LvpbBnycmLgsVGzOPVmbzbx81ekX04GcVhaAOPHLCnx2b/hL
	 hcp/kPxHQHNxjGwScuzBw7wOWtpnLxA7ipFZaHMzY3ZFGj/tnScbBU5G351tvjdnWH
	 SJZsxTvaJFuTl0gJpDSFIX2FDHmDtmf6fv8WTawk=
Subject: FAILED: patch "[PATCH] tls: device: fix out-of-bounds write in tls_append_frag()" failed to apply to 5.10-stable tree
To: jiayuan.chen@linux.dev,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 14:26:39 +0200
Message-ID: <2026083139-catnap-donator-d5bc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b17cf742eaad70ae29ac558cefb3aa9bbeea03d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083139-catnap-donator-d5bc@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b17cf742eaad70ae29ac558cefb3aa9bbeea03d4 Mon Sep 17 00:00:00 2001
From: Jiayuan Chen <jiayuan.chen@linux.dev>
Date: Sun, 23 Aug 2026 16:47:56 +0800
Subject: [PATCH] tls: device: fix out-of-bounds write in tls_append_frag()

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

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 37bb06a8e8f5..f11d0528fc43 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -531,7 +531,8 @@ static int tls_push_data(struct sock *sk,
 		if (!size) {
 last_record:
 			tls_push_record_flags = flags;
-			if (flags & MSG_MORE) {
+			if ((flags & MSG_MORE) &&
+			    record->num_frags < MAX_SKB_FRAGS - 1) {
 				more = true;
 				break;
 			}

