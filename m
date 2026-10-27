Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793090069;
	b=poZm6Ao65V4IrqMd5CG/kBUaa2ye6bJKfaACkMNrDrjH1w4B6GJKHvz4eOVqBuNDvI2D
	 d70o9piTLJKsGva9o7NhE8vKG3xDzwgiCoDYQ20CTR/frPELKLxOqbQQec/uaG7ibCq0U
	 VigJFUlMbDyZ1hz4H1dB86Ii+vTGoJXEin5n/VZi67Angd/rMM5yXqTTs1YXodFuBr1x+
	 y6uRNfJ6hISEs4e81HnwZNH6nOdSDQdtty+W0fe+69Kp+R/YABx4FCeUIQzsniuytjA+i
	 /ojvAUY9RLEzemxoFRlL+rVQKa3/OG469k/nsB7NLmyWNFwYwGfdJbtcqbvOSxvVn+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090069;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=Tqtx97Mqlim2ETCdbAWzFT1K6COkig+THJDQuWiLO7A=;
	b=NOExC8E8W+UVdsenfTLRqNzAwq+hifM4KGpPDXWS0C0Kuhd5+GcEqHKCiXnl7d4NWNXZ
	 feEmx3hB4nSfuBLz+HULwJzE1epkYI4GFgzJQWtgQLg6WyePN+LcxeZBpr+cK0Vj8ndvF
	 h8jiHygo03tuBjQkFbHjEd6wVag1oMH6Uzo4UqkU0PAQ/aM+4z7br++j5dkJ7ySTmNs3h
	 XS3wdPwYoS+Btk6oKwSYE+NT9jnVjIQ1jx4FhK9264/zn2YWa7NXBXJI6W5M4rt+yDzZY
	 TIQvxHYRiBwNV4tk3HX4DV20IvCrUioKF7c5j/HusXaVQ2goVxtoY8fruyLnpmppLRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64218606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 08:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64218606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4ab260600easo1003489b6e.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 01:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793090068; x=1793694868;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Tqtx97Mqlim2ETCdbAWzFT1K6COkig+THJDQuWiLO7A=;
        b=CDcISE2EI4vuMqi/Jh+Bigk+4sr+1WeMZFVEgd51wBRBwORqY4NSZ9v8jLsCXNF8CC
         EBtM7TgsGsJksxMdgpwgjAeO51YbB1sezDSQ4pDqpuLiaqBtz0cZRVih/uGUZ68HWkpr
         qXd57TQGp+wPJa10xqbr+Wgi8zEpM4JcJ1qLevp10P/p02BvWBXyB5DVHe5lgVYS2EyB
         Sl8TbIdzgbycF+gHXJsA3eFhtl+SGar6p7b0bR86JIdqXRSCjgSOc8bGbTV0mH1AcT6L
         QrejjA3FirzqVeaqKJDXtKPqXSxdguiE5CAdPoalq1KHmokJxg3la7+EG0yd02irbeme
         vqIA==
X-Forwarded-Encrypted: i=1; AKwUvBwGKcNO05Bhj4BDFaeMbByV2YG4K3cgUDMQjeDqvwCy3lo9yImCf4MjdjzkRXVCBisHVWhnA1U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJt3KD4Syv2F/wWLbFgVSlfqJu8lKIv6wkDqLeePE83qY2blGdK
	VKoC285YPLiSE/s0ANRSM9PMA1gOtAsPlKdvDqLPNRA0RSHvPCTvu16kLUVctmmkV03v+++7hu2
	3I46hn7GNQLCh4Z/muTiAl938cAS1mmmipYwh1mznBITVeUNZ3zGhgL5fdI0=
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:14d4:b0:4c2:e32c:1ee2 with SMTP id
 5614622812f47-55f7ef3ce97mr958316b6e.22.1793090068498; Tue, 27 Oct 2026
 01:34:28 -0700 (PDT)
Date: Tue, 27 Oct 2026 01:34:28 -0700
In-Reply-To: <20261026-gs_usb-fixes-v3-0-3a68f1f62813@pengutronix.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae06214.6200f071.51519.0f44.GAE@google.com>
Subject: [syzbot ci] Re: gs_usb: fixes
From: syzbot ci <syzbot+ci0e4b58e5e6ed7fb1@syzkaller.appspotmail.com>
To: eric@evenchick.com, kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mailhol@kernel.org, max@schneidersoft.net, 
	mkl@pengutronix.de, pfink@christ-es.de, stable@vger.kernel.org, 
	wg@grandegger.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v3] gs_usb: fixes
https://lore.kernel.org/all/20261026-gs_usb-fixes-v3-0-3a68f1f62813@pengutronix.de
* [PATCH v3 1/4] can: gs_usb: gs_can_start_xmit(): don't leak uninitialized memory over USB
* [PATCH v3 2/4] can: gs_usb: gs_usb_probe(): init netdev completely before register_candev()
* [PATCH v3 3/4] can: gs_usb: gs_usb_receive_bulk_callback(): check for overflow flag if SKB allocation fails
* [PATCH v3 4/4] can: gs_usb: gs_usb_receive_bulk_callback(): add missing call to can_rx_offload_irq_finish

and found the following issue:
general protection fault in can_rx_offload_del

Full report is available here:
https://ci.syzbot.org/series/0c1fc4c5-6a50-43da-a45c-fbc3a8685c3d

***

general protection fault in can_rx_offload_del

tree:      axboe
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/axboe/linux.git
base:      734bef548a96e8774d6eef5dfa2026c6edc4e80b
arch:      amd64
compiler:  Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/03f4b948-ccf7-4d18-8177-b9847267246c/config
syz repro: https://ci.syzbot.org/findings/e4142ca3-3d98-40ef-95df-e6f3ad59fd4e/syz_repro

gs_usb 1-1:0.0: Couldn't get bit timing const for channel 0 (-EPROTO)
Oops: general protection fault, probably for non-canonical address 0xdffffc000000005f: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000002f8-0x00000000000002ff]
CPU: 1 UID: 0 PID: 5651 Comm: kworker/1:4 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: usb_hub_wq hub_event
RIP: 0010:__netif_napi_del include/linux/netdevice.h:3007 [inline]
RIP: 0010:netif_napi_del include/linux/netdevice.h:3026 [inline]
RIP: 0010:can_rx_offload_del+0x3c/0x1e0 drivers/net/can/dev/rx-offload.c:423
Code: 48 89 fb 48 bd 00 00 00 00 00 fc ff df e8 9c 5f fc fa 4c 8d a3 d0 00 00 00 49 89 dd 4c 8d b3 00 01 00 00 4c 89 f3 48 c1 eb 03 <80> 3c 2b 00 74 08 4c 89 f7 e8 26 57 6d fb 41 bf 38 0e 00 00 49 8b
RSP: 0018:ffffc90006a4eb30 EFLAGS: 00010206
RAX: ffffffff86cbe694 RBX: 000000000000005f RCX: ffff8881ba5cbc00
RDX: 0000000000000000 RSI: 000000000000009e RDI: 00000000000001f9
RBP: dffffc0000000000 R08: ffffc90006a4e6c7 R09: 1ffff92000d49cd8
R10: dffffc0000000000 R11: fffff52000d49cd9 R12: 00000000000002c9
R13: 00000000000001f9 R14: 00000000000002f9 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8882a7ca4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd875c71220 CR3: 0000000115016000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 gs_destroy_candev drivers/net/can/usb/gs_usb.c:1510 [inline]
 gs_usb_probe+0x2201/0x2730 drivers/net/can/usb/gs_usb.c:1639
 usb_probe_interface+0x788/0xe50 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:503
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:623
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_set_configuration+0x1bb5/0x2260 drivers/usb/core/message.c:2274
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c3/0x3b0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:503
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:623
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_new_device+0x9aa/0x1690 drivers/usb/core/hub.c:2713
 hub_port_connect drivers/usb/core/hub.c:5585 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5725 [inline]
 port_event drivers/usb/core/hub.c:5889 [inline]
 hub_event+0x28e8/0x4d30 drivers/usb/core/hub.c:5971
 process_one_work kernel/workqueue.c:3495 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__netif_napi_del include/linux/netdevice.h:3007 [inline]
RIP: 0010:netif_napi_del include/linux/netdevice.h:3026 [inline]
RIP: 0010:can_rx_offload_del+0x3c/0x1e0 drivers/net/can/dev/rx-offload.c:423
Code: 48 89 fb 48 bd 00 00 00 00 00 fc ff df e8 9c 5f fc fa 4c 8d a3 d0 00 00 00 49 89 dd 4c 8d b3 00 01 00 00 4c 89 f3 48 c1 eb 03 <80> 3c 2b 00 74 08 4c 89 f7 e8 26 57 6d fb 41 bf 38 0e 00 00 49 8b
RSP: 0018:ffffc90006a4eb30 EFLAGS: 00010206
RAX: ffffffff86cbe694 RBX: 000000000000005f RCX: ffff8881ba5cbc00
RDX: 0000000000000000 RSI: 000000000000009e RDI: 00000000000001f9
RBP: dffffc0000000000 R08: ffffc90006a4e6c7 R09: 1ffff92000d49cd8
R10: dffffc0000000000 R11: fffff52000d49cd9 R12: 00000000000002c9
R13: 00000000000001f9 R14: 00000000000002f9 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8882a7ca4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f58953fcfe0 CR3: 000000000fb48000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	48 89 fb             	mov    %rdi,%rbx
   3:	48 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbp
   a:	fc ff df
   d:	e8 9c 5f fc fa       	call   0xfafc5fae
  12:	4c 8d a3 d0 00 00 00 	lea    0xd0(%rbx),%r12
  19:	49 89 dd             	mov    %rbx,%r13
  1c:	4c 8d b3 00 01 00 00 	lea    0x100(%rbx),%r14
  23:	4c 89 f3             	mov    %r14,%rbx
  26:	48 c1 eb 03          	shr    $0x3,%rbx
* 2a:	80 3c 2b 00          	cmpb   $0x0,(%rbx,%rbp,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 f7             	mov    %r14,%rdi
  33:	e8 26 57 6d fb       	call   0xfb6d575e
  38:	41 bf 38 0e 00 00    	mov    $0xe38,%r15d
  3e:	49                   	rex.WB
  3f:	8b                   	.byte 0x8b


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
