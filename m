Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820E251C042
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790887482; cv=none; b=OkBlu1zcOVv+XCAXk36YVBFlgJL6EWQYjEsmryiDraGumnZUt0AResJ/PIU0vKTG2AcWbY7yvh0DfSU01Yj+3TsGWHqm1hwVjbtUnl8OPXt9Gff7hOYqXm9Xg3ruYDHIocQ0KAV93Rr5468TK9uOBseJoTpPFeit64bl5O7lXyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790887482; c=relaxed/simple;
	bh=KJn0QhtEtLoJch6pEICL6WI3sI1z1uRT4P4EyjWUbLc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=mgvGuVF0uaTi9xMeFjeTzYRTTf+D4r8vCl8zyu8QCsYEAZAfbU60WpPLCIf6tU8N6bc8eMNfQjRJFhnDw55kY3kiaEaW4P+dcP1dmuoEmWm7Ma6CCmhIrOzA0FwqEnDQf3BGsxkk4O4P7FpGJTd8VJHjegM4GMTlBuMDCrI4/EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4c55ba309c2so12078826b6e.1
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 13:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790887479; x=1791492279;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Mz37xzZPmzC/x5l9vHJH36dpPP1odnZmnV3cNoLfw7k=;
        b=qlRM+3aSQJP6q8zaYkggPp8H2PctXYGWxvJL8Aiq5d9Otk05kaUs4G+jEmP0tNa7Ap
         P3yw/u/WBKtpkqzIu+sO3BLqGmyCV3viggqjCVfAZ9tpMUfTPQzaDsWSeJOjXk2BCTNZ
         TsKvJ4WrsqDmpLyKKWeoLkwY99qFuLz/1M0KqGIucCPCFwsOZC2Yi/TpFzSGgIBg/I7Z
         RO98ixrasur/MR2Eqf/yJXvnaNHetObPs8ggBez0OEaD8tEOlXRzHDoCRE1fHWp0tJrD
         dHKpawb7AoenHDBYHgKEb29PCvgNtD6k5FVkZVDO5+hGQpsikh994WVXDzoXBamTwf90
         5cVw==
X-Forwarded-Encrypted: i=1; AKwUvBxrso3R5C5dxA7KVhzWkh/W/Fjl39v54ea5Uuzxm0Vsk9U861vhOb0Ct4WMc82NSpco0xzG5ms=@vger.kernel.org
X-Gm-Message-State: AFuF++ln9eEJzoVmIIzAFJ8x+d+LZqitEJBMj1NJkl+mh2SXapYkfhCR
	wJYglJQ59ZSXLpGukjSs6ZWPdkZ4mTdD1q47BfRCDT5Gx+AOer36jEL1keFf3HOcj0H7qR9nuI7
	7IFo7jSw+XIZcugaVL/JnTK5pmrULttc5SMesoYnXP+oekUyAFezBywlAtWo=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:bc6:b0:4d6:90f4:48b1 with SMTP id
 5614622812f47-4f52b3b8911mr376388b6e.51.1790887479547; Thu, 01 Oct 2026
 13:44:39 -0700 (PDT)
Date: Thu, 01 Oct 2026 13:44:39 -0700
In-Reply-To: <20260930152229.1453929-1-hengyul@cs.unc.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6abec637.7503fbd6.2d3f6.000c.GAE@google.com>
Subject: [syzbot ci] Re: ipv6: route: fix adding routes via the loopback device
From: syzbot ci <syzbot+cidbf3efe2a5ca243b@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@kernel.org, 
	hengyul@cs.unc.edu, horms@kernel.org, idosch@nvidia.com, 
	jiayuan.chen@linux.dev, jiayuan.chen@shopee.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org, 
	stable@vger.kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] ipv6: route: fix adding routes via the loopback device
https://lore.kernel.org/all/20260930152229.1453929-1-hengyul@cs.unc.edu
* [PATCH net 1/2] ipv6: route: do not validate nexthop of routes promoted to reject routes
* [PATCH net 2/2] selftests: net: fib_tests: add tests for IPv6 routes via loopback device

and found the following issue:
WARNING in nsim_fib_event_nb

Full report is available here:
https://ci.syzbot.org/series/7c566bff-eca1-4b49-90ae-6537c6011730

***

WARNING in nsim_fib_event_nb

tree:      net
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
base:      e23a64eb244356ee47c0620f0722d51bd88db522
arch:      amd64
compiler:  Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/ef50b46f-5dab-4a9c-943a-321047ec0627/config
syz repro: https://ci.syzbot.org/findings/96331068-e137-4de8-85a3-65ac3caafea0/syz_repro

------------[ cut here ]------------
i != fen6_info->nsiblings
WARNING: drivers/net/netdevsim/fib.c:831 at nsim_fib6_event_init drivers/net/netdevsim/fib.c:831 [inline], CPU#1: syz.2.19/5834
WARNING: drivers/net/netdevsim/fib.c:831 at nsim_fib6_prepare_event drivers/net/netdevsim/fib.c:947 [inline], CPU#1: syz.2.19/5834
WARNING: drivers/net/netdevsim/fib.c:831 at nsim_fib_event_schedule_work drivers/net/netdevsim/fib.c:1003 [inline], CPU#1: syz.2.19/5834
WARNING: drivers/net/netdevsim/fib.c:831 at nsim_fib_event_nb+0x1029/0x11d0 drivers/net/netdevsim/fib.c:1043, CPU#1: syz.2.19/5834
Modules linked in:
CPU: 1 UID: 0 PID: 5834 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:nsim_fib6_event_init drivers/net/netdevsim/fib.c:831 [inline]
RIP: 0010:nsim_fib6_prepare_event drivers/net/netdevsim/fib.c:947 [inline]
RIP: 0010:nsim_fib_event_schedule_work drivers/net/netdevsim/fib.c:1003 [inline]
RIP: 0010:nsim_fib_event_nb+0x1029/0x11d0 drivers/net/netdevsim/fib.c:1043
Code: eb 0d 4d 89 fd e8 97 75 6e fa be 01 00 00 00 48 89 df e8 aa db 85 fd 4d 89 ef 4c 8b 6c 24 20 e9 4a f3 ff ff e8 78 75 6e fa 90 <0f> 0b 90 e9 db fa ff ff 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c df f0
RSP: 0018:ffffc9000388f030 EFLAGS: 00010293
RAX: ffffffff87596688 RBX: 0000000000000001 RCX: ffff88816f738000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000388f1c0 R08: ffff88816ecf302f R09: 1ffff1102dd9e605
R10: dffffc0000000000 R11: ffffed102dd9e606 R12: dffffc0000000000
R13: 0000000000000001 R14: 0000000000000000 R15: ffff8881be596000
FS:  00007f94438b96c0(0000) GS:ffff8882a8cca000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f94429eb840 CR3: 000000016e632000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
 atomic_notifier_call_chain+0xda/0x180 kernel/notifier.c:223
 call_fib_notifiers+0x31/0x60 net/core/fib_notifier.c:36
 call_fib6_multipath_entry_notifiers+0xf5/0x160 net/ipv6/ip6_fib.c:428
 ip6_route_multipath_add net/ipv6/route.c:5591 [inline]
 inet6_rtm_newroute+0x14f5/0x1a30 net/ipv6/route.c:5713
 rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7137
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2575
 netlink_unicast_kernel net/netlink/af_netlink.c:1338 [inline]
 netlink_unicast+0x7bd/0x940 net/netlink/af_netlink.c:1364
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
 __sock_sendmsg net/socket.c:815 [inline]
 ____sys_sendmsg+0x54e/0x850 net/socket.c:2713
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2767
 __sys_sendmsg net/socket.c:2799 [inline]
 __do_sys_sendmsg net/socket.c:2804 [inline]
 __se_sys_sendmsg net/socket.c:2802 [inline]
 __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2802
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f944299e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f94438b9028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f9442c25fa0 RCX: 00007f944299e159
RDX: 0000000004000040 RSI: 0000200000000000 RDI: 0000000000000003
RBP: 00007f9442a3506b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9442c26038 R14: 00007f9442c25fa0 R15: 00007ffdb2cbb968
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a fix for this bug, please reply with `#syz test`
(on a separate line) and attach the patch to the email.

Notes:
- The patch will be applied on top of the tested series (as an
  incremental fix).
- To test a new version of the whole series, please send it directly
  to syzbot@lists.linux.dev.
- Arguments like custom git repos and branches are not supported.
