Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795760628;
	b=KhY4rEZA5PpI2vyQEOSy1GTfndQc72rbXG7ccez4FhnBE+0FkFzO59atyDt/6yQvLXcT
	 RfBIp5aojGT9Hdfv7EIdEVB4iD9214hiO3C9Ha6QNAvzBrKfTa7lzRVrzi0qI5SXkOgom
	 PBnFvnyBDJ873CaMOUhoYDYgDedBWR78048YQamt+MZ4YYuTBK0Pt+zP4F6Zx5mFEX7gT
	 V3P1BXml/bynOeBMagTF5DALNoheZTe+VsPdwKYKV7J5rdTHuj6aFMoS50+sw4u08ZbkL
	 Sugz62dVri0kbQ/jQe3FbJ4W5sXyVAsXsFx2bG7e+7bnXnE/OqIZcloeP2tU3YO+K3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795760628;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=xYgQga9u8hUjdEXzpEX9HRImBpLpNALqvIW917WJ9ec=;
	b=HnaNgKjU6bULrQy9yi+mjpIJsYEI5W9HMttErtBit/zV9hOSeeA7oLu8MWu7MzRmIMs8
	 LbhwqD8SXbfmvOUigFQ7IpbyGKr4pjMtfo97jwDjbXQ8sZHBuXCBqipS9nkRsn/wNzFjP
	 X+CuciRxLMhkglm7Wp90Lb1F7R0ZaV3Apq/3A+/Yqni12jkz5v+6fobogPXkzKJxDG4mR
	 b9fJvSH0kMOMRIuEFVDo8jrOUeLo2p8fa2aD5hxtKj5NYbQFbJ+czBTDw7HpV92XM/1SN
	 obiHQpjAaIrNOqPyzYUDlvx5imZAYp0cVYso75gv64b0/XtEjiaANOGXiJLHYVgMvKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B33606A323
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 06:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00B33606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-55bf11583d9so7582139b6e.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 22:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795760627; x=1796365427;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xYgQga9u8hUjdEXzpEX9HRImBpLpNALqvIW917WJ9ec=;
        b=rsHwT/0NP0dHYHh3pefH5JJqK+L/ytKk/96u1tnBxZZ1UcTE/q8Mgf2pPbpxZiCIap
         ZNKAr463AK1VPe8+XANQs+25tdlIqwhMGNu4A2wo4KzZpFgwYZBHH7oN6uQv4C3KTyHA
         BaBSg8DAkIn08hwR4H6wpE54s8EbGkQNHiEELOu716KTSeewychneGcDrwr3NnmHFGVc
         pTQVE3TivFbULPNdfXoUXg0DxnT0HU10FnagW9xrGd4/ZxX0WWB9JKI3wHrxR0m+g7UP
         uz+7EBc6rshVPLoKiVAGk54aHPYpmKW2iTaY9wVlsSb8xT20oW+H5CuQ8i73T6ywlO7o
         qAOA==
X-Forwarded-Encrypted: i=1; AL+hErFktqsg04S2SQWsj5CfjIrn0nUUiJOJUvC3Gx9YHRRnmqdHQ9zRHXhosKTaDbF3Af6BBC6BvYo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lLNo5x5RgMOYl6as8atidJ18zCI/nwTa+FalTmD5yTRyRJf74
	vRHdK5SZ0ib0Jz6FE1M3WGgLFWLeag/IG8TPh9evwj25pCnLShC0zvUfuQ7MCNcj8N6I7NSPnQn
	GTKOsC6cXECMBY3+FnZFULI3ybY1+QDUp28OAGhcz2ZBwBItSVMbVYr3Wrws=
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4441:b0:568:195a:3ba8 with SMTP id
 5614622812f47-5797d0b44dbmr19422730b6e.29.1795760627077; Thu, 26 Nov 2026
 22:23:47 -0800 (PST)
Date: Thu, 26 Nov 2026 22:23:47 -0800
In-Reply-To: <20261122090454.6217-1-25031212351@stu.xidian.edu.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6b0921f3.1492ceaa.187240.0078.GAE@google.com>
Subject: [syzbot ci] Re: ALSA: line6: Stop URBs synchronously via sync_stop callback
From: syzbot ci <syzbot+ci4a0a685a2ad8288a@syzkaller.appspotmail.com>
To: 25031212351@stu.xidian.edu.cn, byu@xidian.edu.cn, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	stable@vger.kernel.org, tiwai@suse.de, wencheng@xidian.edu.cn
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v4] ALSA: line6: Stop URBs synchronously via sync_stop callback
https://lore.kernel.org/all/20261122090454.6217-1-25031212351@stu.xidian.edu.cn
* [PATCH v4] ALSA: line6: Stop URBs synchronously via sync_stop callback

and found the following issue:
general protection fault in line6_kill_audio_urbs

Full report is available here:
https://ci.syzbot.org/series/142062cf-1e2f-45f6-889f-e755c6f0dfc7

***

general protection fault in line6_kill_audio_urbs

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      9437ee8b6cf607e883b36e44bd755968daaebd48
arch:      amd64
compiler:  Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/fa7bddbf-e0c4-41e2-9f96-995d29f44c33/config
syz repro: https://ci.syzbot.org/findings/3b9dd218-32a8-4b85-8604-77328ada3c3e/syz_repro

snd_usb_toneport 1-1:0.0: cannot get proper max packet size
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 994 Comm: kworker/0:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: usb_hub_wq hub_event
RIP: 0010:line6_kill_audio_urbs+0x1eb/0x320 sound/usb/line6/pcm.c:133
Code: 4c 8b 24 24 4c 89 e5 48 c1 ed 03 42 80 7c 35 00 00 74 08 4c 89 e7 e8 d4 96 92 f8 4d 8b 24 24 4a 8d 3c 23 48 89 f8 48 c1 e8 03 <42> 80 3c 30 00 74 05 e8 b9 96 92 f8 4d 8b 24 1c 4d 85 e4 74 0f e8
RSP: 0018:ffffc9000632ec10 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88810d8e0000 RSI: 0000000000000010 RDI: 0000000000000000
RBP: 1ffff11023131427 R08: ffffffff91be37bf R09: 1ffffffff237c6f7
R10: dffffc0000000000 R11: fffffbfff237c6f8 R12: 0000000000000000
R13: 0000000000000001 R14: dffffc0000000000 R15: ffff88811898a000
FS:  0000000000000000(0000) GS:ffff88818bdf6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055bf9470d0a0 CR3: 0000000117d14000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 line6_pcm_disconnect+0x1c/0x30 sound/usb/line6/pcm.c:515
 line6_disconnect+0x166/0x260 sound/usb/line6/driver.c:844
 line6_probe+0x9f5/0xcd0 sound/usb/line6/driver.c:818
 usb_probe_interface+0x751/0xe00 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:707
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:869
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:899
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1027
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2bd/0x430 drivers/base/dd.c:1131
 device_initial_probe+0x9c/0x100 drivers/base/dd.c:1190
 __bus_probe_device+0x126/0x220 drivers/base/bus.c:614
 device_add+0x7d7/0xb80 drivers/base/core.c:3778
 usb_set_configuration+0x1bb5/0x2260 drivers/usb/core/message.c:2280
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c3/0x3b0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:707
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:869
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:899
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1027
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2bd/0x430 drivers/base/dd.c:1131
 device_initial_probe+0x9c/0x100 drivers/base/dd.c:1190
 __bus_probe_device+0x126/0x220 drivers/base/bus.c:614
 device_add+0x7d7/0xb80 drivers/base/core.c:3778
 usb_new_device+0x9aa/0x1690 drivers/usb/core/hub.c:2713
 hub_port_connect drivers/usb/core/hub.c:5585 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5725 [inline]
 port_event drivers/usb/core/hub.c:5889 [inline]
 hub_event+0x28e8/0x4d30 drivers/usb/core/hub.c:5971
 process_one_work kernel/workqueue.c:3497 [inline]
 process_scheduled_works+0xc5d/0x1650 kernel/workqueue.c:3580
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3661
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:line6_kill_audio_urbs+0x1eb/0x320 sound/usb/line6/pcm.c:133
Code: 4c 8b 24 24 4c 89 e5 48 c1 ed 03 42 80 7c 35 00 00 74 08 4c 89 e7 e8 d4 96 92 f8 4d 8b 24 24 4a 8d 3c 23 48 89 f8 48 c1 e8 03 <42> 80 3c 30 00 74 05 e8 b9 96 92 f8 4d 8b 24 1c 4d 85 e4 74 0f e8
RSP: 0018:ffffc9000632ec10 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88810d8e0000 RSI: 0000000000000010 RDI: 0000000000000000
RBP: 1ffff11023131427 R08: ffffffff91be37bf R09: 1ffffffff237c6f7
R10: dffffc0000000000 R11: fffffbfff237c6f8 R12: 0000000000000000
R13: 0000000000000001 R14: dffffc0000000000 R15: ffff88811898a000
FS:  0000000000000000(0000) GS:ffff88818bdf6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055bf9470d0a0 CR3: 0000000117d14000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	4c 8b 24 24          	mov    (%rsp),%r12
   4:	4c 89 e5             	mov    %r12,%rbp
   7:	48 c1 ed 03          	shr    $0x3,%rbp
   b:	42 80 7c 35 00 00    	cmpb   $0x0,0x0(%rbp,%r14,1)
  11:	74 08                	je     0x1b
  13:	4c 89 e7             	mov    %r12,%rdi
  16:	e8 d4 96 92 f8       	call   0xf89296ef
  1b:	4d 8b 24 24          	mov    (%r12),%r12
  1f:	4a 8d 3c 23          	lea    (%rbx,%r12,1),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 05                	je     0x36
  31:	e8 b9 96 92 f8       	call   0xf89296ef
  36:	4d 8b 24 1c          	mov    (%r12,%rbx,1),%r12
  3a:	4d 85 e4             	test   %r12,%r12
  3d:	74 0f                	je     0x4e
  3f:	e8                   	.byte 0xe8


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.
