Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794333927;
	b=1nchxU8vnZc9CuUbZFQlZ2Ttxpr6ekquGkADS2GPSrDONnMKgcgrb/VodCjXkDBkOo8B
	 JxDmI/1pTjq4lbQ28xdrDCH96Q0W5IMLizbSHdWQH0+wI5zXjQPN9CEhFP9uTW5c6ySXA
	 IgtXVlGJ1tu1QdSNePYznubS65vAzOApyAt4HcQNHiRHuv8j5o33pD7wBUwrKtOotuc8I
	 xvu4vpt7Nw1JE4RwlYsx+DiDLqyh8/+ommI8oM2u0/rc6tA4Z0zHTNTa76pSvdWnODP4a
	 QiBQBFePS55Cx1L9wYEEkFj/tBGkA9WLJ8JfIO6rn7cbT4FpD2fgxA4/PAbwXREZQDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333927;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=tSAXF3FGGUofDubO2GoV4mhTDglOYXAQd0Tz1tbGk+g=;
	b=kcIuadJmjR7Nonl99Ps901Mdqdn+JlSRrH5SEpyT+66+BOQRebA9lAc64Odeehg/99qt
	 bxog41WJo9rvcIFTfoZ8rW4WfdzmX71DdUpQ2eWE18XVImRPcfA+4HG1wXKGLpYBrOY1G
	 Va31DYGW7R6c2aRJy8UY/PX4539usJnK0uTJHTDQxxfCKgwZxiIM9FoEIctNhDIzyaUcI
	 MgpCq1M7RJ5jd/d+eAR2NkpVgi1W26y1+G1RA5Hcjodg/4a99hnMOxKqF3Vimghuqo776
	 bCn+hQKC2loQVKbkNhNYRkcECz3fV9ohP+TbduveibOVikk/hIGEyArVT+UozHrFiWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=a8NEUJV1;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=OycgAZic;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.82
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491CD606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 491CD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=a8NEUJV1;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=OycgAZic
ARC-Seal: i=1; a=rsa-sha256; t=1794333910; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KnRBOaSPzQ+jrtxAHQ6PcBpzWr18Vm1u5cu/0641rDMcdlw9I6EcC9WVVxRQ3Ft7bm
    1Z17L3e2aDQIenfGvXTMcbMSNMBV22qPLAfx82xz9IfqMv5X5fSHyWlFWgAfsGyX9SyB
    SvhCgBUgPAfQ5DKYFoG/T5T3N1iy6vQxYMK88yBhmmnvQN1Lg1uWQLW5JlKgc7oXrrhA
    HJQ4i+m0hWbEHi1CI5llN2OC3MEbmWv1FOjNJ/4jhxiXp2DqnPwveCshzHwyf26c4nGo
    6we4NY3f7ad95YibWfw5jzYowgEYBoWsaJVb86wsuGvIPw5nB2CZVes9C20JvPHI6DTn
    88jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333910;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tSAXF3FGGUofDubO2GoV4mhTDglOYXAQd0Tz1tbGk+g=;
    b=mKTOLyEUpWvF61rQ6gytSD2ar8Sags/7nYc4AADYQ8KUHN5FXjYXF3TEU52rYNSFi3
    L7BxVZ+2rrukr+3wsNwJDTiVCT/3WcSsY7ccuiM5R1JGOLolrlTuYD8T1XL4VOjgnuNA
    yysFAzce/iAoHepUONsFhz+tRqrMw0vcDmdtIpPAlzDZBHMg0IHs89AMVjoHVnbU4aif
    yE/nmu1LFYlWRiXGT2Pe5wz29I2ENho1oyec+84rI/GD8rPjzaYUC9TfnZXDXKtBlATO
    eCxVHzEkF6uarUIsaF00dM1M3f2co0unXcU16nxLDtImJr6X4g5n9ZbtKOAy9TlYtQKK
    bnww==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333910;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tSAXF3FGGUofDubO2GoV4mhTDglOYXAQd0Tz1tbGk+g=;
    b=a8NEUJV1sojSNzxH/+8UJW6JjYna/o4oUy6RfCXEN7y0hsn0uv1uii81fHeqVbNKFB
    lBiliLiDFMT332Zzgd9+ttWN6c8u1iLQxcSfUPCpUpBPS2nnEjcsrR+4keYSJFc2hO7r
    1LcqvCRq8IrQj5aQAXhiF8INS2zj8oCdZf7Y0bY/Pn51RPAi1Wfcs/Dx2kUQ0awzMOha
    hszMV0APKoCyCoJo9jISmkMUlxrPDE2pIZrA851Yf/Yp/1frSkoQku++NRTnharvLiJC
    9qTOCiiJvwGYlYvCg9E9Ety/4v1n2+JTcWmucYcBFEOd/habrLLXwyr1UDaXwalPJIlR
    uRWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794333910;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tSAXF3FGGUofDubO2GoV4mhTDglOYXAQd0Tz1tbGk+g=;
    b=OycgAZicC+/HWPjc4gncBwwojDisJkk+m3LhjYf18HyIAY2Add1cENLKquKY8YikvV
    xMTb4c+MbOKktCaDlKAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AAI5A1db
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 10 Nov 2026 19:05:10 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 5.10.y 2/4] can: raw: fix lockdep issue in raw_release()
Date: Tue, 10 Nov 2026 19:04:54 +0100
Message-ID: <20261110180456.792270-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110180456.792270-1-socketcan@hartkopp.net>
References: <20261109202741-failed-5.10-962947b69589@kernel.org>
 <20261110180456.792270-1-socketcan@hartkopp.net>
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
Content-Type: text/plain; charset="us-ascii"

From: Eric Dumazet <edumazet@google.com>

commit 11c9027c983e9e4b408ee5613b6504d24ebd85be upstream.

syzbot complained about a lockdep issue [1]

Since raw_bind() and raw_setsockopt() first get RTNL
before locking the socket, we must adopt the same order in raw_release()

[1]
WARNING: possible circular locking dependency detected
6.5.0-rc1-syzkaller-00192-g78adb4bcf99e #0 Not tainted
------------------------------------------------------
syz-executor.0/14110 is trying to acquire lock:
ffff88804e4b6130 (sk_lock-AF_CAN){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1708 [inline]
ffff88804e4b6130 (sk_lock-AF_CAN){+.+.}-{0:0}, at: raw_bind+0xb1/0xab0 net/can/raw.c:435

but task is already holding lock:
ffffffff8e3df368 (rtnl_mutex){+.+.}-{3:3}, at: raw_bind+0xa7/0xab0 net/can/raw.c:434

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (rtnl_mutex){+.+.}-{3:3}:
__mutex_lock_common kernel/locking/mutex.c:603 [inline]
__mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
raw_release+0x1c6/0x9b0 net/can/raw.c:391
__sock_release+0xcd/0x290 net/socket.c:654
sock_close+0x1c/0x20 net/socket.c:1386
__fput+0x3fd/0xac0 fs/file_table.c:384
task_work_run+0x14d/0x240 kernel/task_work.c:179
resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
__syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (sk_lock-AF_CAN){+.+.}-{0:0}:
check_prev_add kernel/locking/lockdep.c:3142 [inline]
check_prevs_add kernel/locking/lockdep.c:3261 [inline]
validate_chain kernel/locking/lockdep.c:3876 [inline]
__lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5144
lock_acquire kernel/locking/lockdep.c:5761 [inline]
lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
lock_sock_nested+0x3a/0xf0 net/core/sock.c:3492
lock_sock include/net/sock.h:1708 [inline]
raw_bind+0xb1/0xab0 net/can/raw.c:435
__sys_bind+0x1ec/0x220 net/socket.c:1792
__do_sys_bind net/socket.c:1803 [inline]
__se_sys_bind net/socket.c:1801 [inline]
__x64_sys_bind+0x72/0xb0 net/socket.c:1801
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Possible unsafe locking scenario:

CPU0 CPU1
---- ----
lock(rtnl_mutex);
        lock(sk_lock-AF_CAN);
        lock(rtnl_mutex);
lock(sk_lock-AF_CAN);

*** DEADLOCK ***

1 lock held by syz-executor.0/14110:

stack backtrace:
CPU: 0 PID: 14110 Comm: syz-executor.0 Not tainted 6.5.0-rc1-syzkaller-00192-g78adb4bcf99e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
check_noncircular+0x311/0x3f0 kernel/locking/lockdep.c:2195
check_prev_add kernel/locking/lockdep.c:3142 [inline]
check_prevs_add kernel/locking/lockdep.c:3261 [inline]
validate_chain kernel/locking/lockdep.c:3876 [inline]
__lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5144
lock_acquire kernel/locking/lockdep.c:5761 [inline]
lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
lock_sock_nested+0x3a/0xf0 net/core/sock.c:3492
lock_sock include/net/sock.h:1708 [inline]
raw_bind+0xb1/0xab0 net/can/raw.c:435
__sys_bind+0x1ec/0x220 net/socket.c:1792
__do_sys_bind net/socket.c:1803 [inline]
__se_sys_bind net/socket.c:1801 [inline]
__x64_sys_bind+0x72/0xb0 net/socket.c:1801
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd89007cb29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd890d2a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 00007fd89019bf80 RCX: 00007fd89007cb29
RDX: 0000000000000010 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007fd8900c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fd89019bf80 R15: 00007ffebf8124f8
</TASK>

Fixes: ee8b94c8510c ("can: raw: fix receiver memory leak")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Ziyang Xuan <william.xuanziyang@huawei.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: stable@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Link: https://lore.kernel.org/all/20230720114438.172434-1-edumazet@google.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Stable-dep-of: 962947b69589 ("can: replace ARPHRD_CAN type checks with can_get_ml_priv()")
[ backport to 5.10: Adapt the raw_release() context as
  free_percpu(ro->uniq) has already been moved out of raw_release() in
  this tree. ]
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/raw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 7df3086e9f91..c9513dca8fc9 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -393,9 +393,9 @@ static int raw_release(struct socket *sock)
 	list_del(&ro->notifier);
 	spin_unlock(&raw_notifier_lock);
 
+	rtnl_lock();
 	lock_sock(sk);
 
-	rtnl_lock();
 	/* remove current filters & unregister */
 	if (ro->bound) {
 		if (ro->dev)
@@ -411,12 +411,13 @@ static int raw_release(struct socket *sock)
 	ro->bound = 0;
 	ro->dev = NULL;
 	ro->count = 0;
-	rtnl_unlock();
 
 	sock_orphan(sk);
 	sock->sk = NULL;
 
 	release_sock(sk);
+	rtnl_unlock();
+
 	sock_put(sk);
 
 	return 0;
