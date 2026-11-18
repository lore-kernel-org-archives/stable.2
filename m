Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006285;
	b=vytgJoOyI5RXSdqAysDLj1dm4Tqyn0mQ+nsIH1Bc4Ok4Cq/cnvbmmPeS/qZZp04K74Ze
	 q4VB57vHXkvgJAbP012m7cdfLY0O2Z+qJ7pYFurdR1sH2cZMWMibqHmYN7JZjLEydP3kf
	 8EF9jka9mj3tPc/xkvzkQYSiU1dIakuwV90gPM8IXqlaDtWXEVplIZexTFwqcHDOB7SUN
	 LGCam5zhbetpxrrF678HiRgbNJ8KwjXncU5Gauq51kTV+hZnZLr9caQqHXad/y1xxULmL
	 rtnXf9LwryJz10pTX+/v2wvZ6kPpc7B4f871vuu4MA8ex0fizmPRnVJGK+cfoPtUhqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006285;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=nYuOjm8xQJMsBWaOOrKGxnekKQWVnD5kRNJ5Ku24pwI=;
	b=0RGuaeBhbvMUBzau+AECql5LmZxm8TAFCDH21n6r83gM/DCUFZ4S6GDNh/OH4u42RsYX
	 tSnS4QxUEBz4+kfDlKJWrjICr0QyP/6UjPLB9pEEv4ruVdRAx8Z0SFEuSXAIEzF/pLb5C
	 dKXSBXbRFg0N1SJb+AY7nEc7okTbQ6ELR+fhitVwcKhKVRwbT4GrqPLiSIDZex5SO2PSB
	 VNLVcL1SiRTzYDnlYwjWrcbu3URc95CbdFiKGRZQBqiSjIvYUyS2pTOYvOCsvcQqRCw/S
	 4+BP6xR8BOgcP9uULDJr+AHjHomZO4TliNO+QhlkNtwAlnDmkvd1Q6rTMDOlCziqlWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IVNLBgFz;
	arc=none smtp.remote-ip=91.218.175.13
Received: from mta0.migadu.com (out-13.mta0.migadu.com [91.218.175.13])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EED606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48EED606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IVNLBgFz
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=S4tIs0eXTP8/ESlTI3EDlKJDy7qEJ4aWifgLG6CtFzY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795006282; v=1; x=1795611082;
 b=IVNLBgFzmRuyK7s18N4RsxnDzheqIxrl0fZ9T2nZNi5FOD5Q9zBdnc2YDgdZY1E336446/ny
 +jBxgZoZAumntV9/mRzfLpWHoVOkIwt0E11iG2oJdfRGPXzqgM/Nkarlc/ya/b+WRxKRVdBT0hB
 aOo+87CphSW7QQyhCTwb1vKk=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f2a36f7fe13e4e18;
	Wed, 18 Nov 2026 12:51:22 +0000
X-Mizu-Trace-ID: f2a36f7fe13e4e18
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	stable@vger.kernel.org,
	pabeni@redhat.com
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y v1 0/1] minimal mptcp UAF fix for 5.15
Date: Wed, 18 Nov 2026 20:50:30 +0800
Message-ID: <20261118125032.200934-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
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

We encountered an MPTCP-associated use-after-free in kernel 5.15. The
affected applications do not enable MPTCP on purpose: Go turns MPTCP on
for listening sockets by default, so any Go service that calls Listen()
ends up with an MPTCP listener without the application opting in, and even
when the client speaks plain TCP.

In mptcp_close() the listener subflow is orphaned (marked SOCK_DEAD) before
__tcp_close() -> inet_csk_listen_stop() runs on it. A connection whose 3-way
handshake completes in that window is cloned from the already SOCK_DEAD
listener subflow and inherits SOCK_DEAD; a following RST then frees that child
via tcp_done() -> inet_csk_destroy_sock() while it is still linked in the
listener accept queue, and inet_csk_listen_stop() later walks onto the freed
socket.


time line:
close(listen_fd):                            3-way handshake & rst (plain TCP client)

mptcp_close
  // mark ssk as SOCK_DEAD
  sock_orphan(ssk);
  __mptcp_destroy_sock
    // ssk in conn_list is listen sk
    __mptcp_close_ssk
                                             // in 3-way handshake
                                             tcp_v4_syn_recv_sock
                                               // inherit SOCK_DEAD state from listen ssk
                                               inet_csk_clone_lock
                                             // process RST
                                             tcp_reset
                                               tcp_done
                                               // sk is SOCK_DEAD
                                               inet_csk_destroy_sock
                                                   sock_put(sk); // freed
      __tcp_close(ssk, 0)
        // free child
        inet_csk_listen_stop()
            process child        <==== process freed sk




Upstream closed this window with commit 57fc0f1ceaa40 ("mptcp: ensure listener
is unhashed before updating the sk status"), so that would be the one to
backport. But it does not fit 5.15 well:

1. It calls mptcp_subflow_queue_clean() and mptcp_event_pm_listener(), which
   are not in 5.15.
2. Its mptcp_disconnect() hunk relies on commit b29fcfb54cd7 ("mptcp: full
   disconnect implementation"), which is not in 5.15 either. Without it,
   shutdown(SHUT_RD) on a listener leaves the msk in TCP_LISTEN with the
   subflow already in TCP_CLOSE, and the WARN_ON_ONCE() in
   mptcp_check_listen_stop() fires on close().
3. It needs the follow-up commit 3fffa15bfef4 ("mptcp: ensure subflow is
   unhashed before cleaning the backlog") to get the unhash order right.

The simplest fix for 5.15 is this patch: in mptcp_close(), unhash the listener
subflow and drain its accept queue before it is orphaned. A better backport is
welcome.

This may become much easier to hit once services move to a newer Go.

A reproducer (written by an LLM) is at:
https://gist.github.com/mrpre/053f1849b5accec13c0fe9c569739fd7


------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 59 PID: 404175 at lib/refcount.c:25 refcount_warn_saturate+0x12e/0x150
RIP: 0010:refcount_warn_saturate+0x12e/0x150
RSP: 0018:ffffad3c8a2d7b68 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffad3c8a2d7b70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88f3421c2300
R13: ffff88d43e13b508 R14: ffff88f3421c26f0 R15: ffff88d3df5d4900
FS:  0000000000000000(0000) GS:ffff89127fd40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c04e5f8000 CR3: 00000005dfaba004 CR4: 00000000007706e0
PKRU: 55555554
Call Trace:
 <TASK>
 inet_csk_listen_stop+0x3e1/0x530
 __tcp_close+0x3bc/0x440
 __mptcp_close_ssk+0xb9/0x210
 __mptcp_destroy_sock+0x11c/0x280
 mptcp_close+0x25d/0x3b0
 inet_release+0x44/0x90
 __sock_release+0x42/0xb0
 __fput+0x98/0x270
 ____fput+0xe/0x20
 task_work_run+0x6d/0xb0
 do_exit+0x1e7/0x3c0
 do_group_exit+0x3b/0xb0
 get_signal+0x17a/0x940
 arch_do_signal_or_restart+0xba/0x130
 exit_to_user_mode_loop+0xae/0x160
 exit_to_user_mode_prepare+0xad/0xc0
 irqentry_exit_to_user_mode+0x9/0x20
 irqentry_exit+0x21/0x40
 exc_page_fault+0x93/0x190
 asm_exc_page_fault+0x27/0x30


Jiayuan Chen (1):
  mptcp: fix UAF of child socket on listener close

 net/mptcp/protocol.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.43.0

