Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793567687;
	b=O3W4EwKjd3ZhJnDYNgEVg1qSw478EbuHDifwqcycHXXqKN69QObZynWnypP6ohUsaWp+
	 ybOvktkJVPUJd3Q6ABWEhpK8pFxiiuScMoTlsIwx9UwAjiX1aCvBQUiAV6wbcPWGlrG3w
	 OEFcpcezaWONcYiZkd5U6uqlfv6lxKO7Yun2U5Yqf/oeJmP9/JTx7Dpg1UW1lPRqYwOqY
	 KmNmIEwwDt4a2T8kUPLm7IzmtqAOwNZjnkcxsnY9Fl4SMoWtuMcq5toExFpPDuG61nCIo
	 sHuveBzwIUqmGJkZt1jiVJZdL8p1Rw+an/MP3oQPax7HG+symt1J2i0Jm21khzh/afQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793567687;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=AvHAhlRhkPgLrmgjNSyRuNLh9GxQ9LIIjKdvXbwFnMA=;
	b=B4zGXF+RNP+BAtpgT6583CmH/mz0Mf7EQAW4Hq9MCWyT2/WlFUMZ6UTbgqGb7oDk8HiT
	 PzFrE6BQXpJGqtVsYjVLUBVi9IHNrKvrLVnlVuHEoBxC0s3WtNdTwZLdcglY30ZR3HOY8
	 2ZRBpZYyj6z839my37e9YSWfKcMs1F3qgL5u1WJ4jDdEq3Pael57ubMkDxZmMMsS6KTcq
	 0p+I3P4lwSwF6SFB8xCiQ6/zZ0SsOUb+r1e3smc781Fv7GniZZvGPdZNpvKM2yb2jvpl6
	 dfGXS36p/q04gPVLqB6F2PxGivG8RSOTkHdg34W7GbeYvMjfrMRL2PScw6ueU+t1w9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6867606A326
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 21:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6867606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4f8281066c4so3328994b6e.2
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 13:14:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793567686; x=1794172486;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AvHAhlRhkPgLrmgjNSyRuNLh9GxQ9LIIjKdvXbwFnMA=;
        b=zC0h7vRuPlw+MI1u4SHUNH+qH07sYR8Kjfz5IGgZlYme+3TIzXHWwUz+lv/e8PSUNs
         MYTx8907IkG4fyaUKCfrE5OoGR4o8iXHx9Fc36d4HJYMVjcTW9f9XSysDGefD5sE7zxF
         L3qKnt6s3dgqhg6nQ3MtKm0cjR1h6GzEIKI6EDP3jq9CWKdb0sECzSBbACYdQOkFeXfC
         8Z4ZUhGkkQ1+ogM2GZN1BXmL7oM/euVPJSRGWLz2I+ZhGzzVCBf+NtMScTqFksfCL/+I
         0cvLF2xDEijxNDswyXA8ktk6cVBHXLVyHoSa0z0tb9ILPY+lkEq7RgrxdT3e7SNi0+t1
         aKpw==
X-Forwarded-Encrypted: i=1; AKwUvBzUBA+uRLLOjIf2paHj2Ya3lxc0pDu46AlNYhfrwIqRsBn1SUM8c/pCG3xfNGL1gJvVLNSZqr0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKncrHMiBg8UDeOlQQZApZ2vgrmIwBfSeuQ+aFqNVe1VfG3Mzw3
	KYgkIm+lNonGKljYOwDgEyZ426EmdPQT/buhhLK/6MxuKdv5MiTbUHUtxRX09coXALMaFS+vozp
	DIDjk+vTxvJxX+U/OdnJ7gA7LS7tCDlZhEVHFjHGwDswbsrYProb8t+IxrBI=
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:11cb:b0:55b:f88d:6ebb with SMTP id
 5614622812f47-5640df0a2eemr5490383b6e.54.1793567685852; Sun, 01 Nov 2026
 13:14:45 -0800 (PST)
Date: Sun, 01 Nov 2026 13:14:45 -0800
In-Reply-To: <20261031204723.1415-1-drifabdelmalekmohamedsaid@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae7abc5.64e51036.15cf6a.001d.GAE@google.com>
Subject: [syzbot ci] Re: media: em28xx: fix v4l2 use-after-free after failed init
From: syzbot ci <syzbot+ci612f2c3be50482a3@syzkaller.appspotmail.com>
To: drifabdelmalekmohamedsaid@gmail.com, hverkuil@kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-usb@vger.kernel.org, mchehab@kernel.org, stable@vger.kernel.org, 
	syzbot@syzkaller.appspotmail.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] media: em28xx: fix v4l2 use-after-free after failed init
https://lore.kernel.org/all/20261031204723.1415-1-drifabdelmalekmohamedsaid@gmail.com
* [PATCH] media: em28xx: fix v4l2 use-after-free after failed init

and found the following issue:
possible deadlock in em28xx_release_resources

Full report is available here:
https://ci.syzbot.org/series/92e27f7a-9ca9-4693-ad76-730262f6efd0

***

possible deadlock in em28xx_release_resources

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      cbbddb6b08cc9900a87cccaa9b22bbe06aa4f50a
arch:      amd64
compiler:  Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/5e867cfe-3c44-46f3-be9a-3394e10312c7/config
syz repro: https://ci.syzbot.org/findings/de514af7-755a-455f-9075-91732cf09a76/syz_repro

em28xx 1-1:1.0: Closing video extension
em28xx 1-1:1.0: Closing input extension
============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
kworker/0:3/5059 is trying to acquire lock:
ffff88801cd25cf0 (&dev->lock#3){+.+.}-{4:4}, at: em28xx_release_resources+0x75/0x240 drivers/media/usb/em28xx/em28xx-cards.c:3796

but task is already holding lock:
ffff88801cd25cf0 (&dev->lock#3){+.+.}-{4:4}, at: em28xx_v4l2_fini+0xb7/0x3f0 drivers/media/usb/em28xx/em28xx-video.c:2431

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&dev->lock#3);
  lock(&dev->lock#3);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

locks held by kworker/0:3/5059: 6, last CPU#0:
 #0: ffff8881032cb948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff8881032cb948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff8881032cb948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3460 [inline]
 #0: ffff8881032cb948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3578
 #1: ffffc900036cfc40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc900036cfc40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc900036cfc40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3460 [inline]
 #1: ffffc900036cfc40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3578
 #2: ffff88816eeb71d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1109 [inline]
 #2: ffff88816eeb71d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x184/0x4d30 drivers/usb/core/hub.c:5917
 #3: ffff88801cdfc1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1109 [inline]
 #3: ffff88801cdfc1d8 (&dev->mutex){....}-{4:4}, at: usb_disconnect+0xfc/0x9a0 drivers/usb/core/hub.c:2346
 #4: ffff88801ce5a1a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1109 [inline]
 #4: ffff88801ce5a1a0 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1046 [inline]
 #4: ffff88801ce5a1a0 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xa9/0x7d0 drivers/base/dd.c:1377
 #5: ffff88801cd25cf0 (&dev->lock#3){+.+.}-{4:4}, at: em28xx_v4l2_fini+0xb7/0x3f0 drivers/media/usb/em28xx/em28xx-video.c:2431

stack backtrace:
CPU: 0 UID: 0 PID: 5059 Comm: kworker/0:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_deadlock_bug+0x27a/0x290 kernel/locking/lockdep.c:3085
 check_deadlock kernel/locking/lockdep.c:3137 [inline]
 validate_chain kernel/locking/lockdep.c:3939 [inline]
 __lock_acquire+0x25db/0x2de0 kernel/locking/lockdep.c:5288
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
 em28xx_release_resources+0x75/0x240 drivers/media/usb/em28xx/em28xx-cards.c:3796
 em28xx_usb_disconnect+0x19f/0x2f0 drivers/media/usb/em28xx/em28xx-cards.c:4493
 usb_unbind_interface+0x295/0x9c0 drivers/usb/core/driver.c:460
 device_remove drivers/base/dd.c:619 [inline]
 __device_release_driver drivers/base/dd.c:1357 [inline]
 device_release_driver_internal+0x48d/0x7d0 drivers/base/dd.c:1380
 bus_remove_device+0x444/0x560 drivers/base/bus.c:678
 device_del+0x524/0x8f0 drivers/base/core.c:3967
 usb_disable_device+0x3d4/0x8d0 drivers/usb/core/message.c:1484
 usb_disconnect+0x346/0x9a0 drivers/usb/core/hub.c:2355
 hub_port_connect drivers/usb/core/hub.c:5425 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5725 [inline]
 port_event drivers/usb/core/hub.c:5889 [inline]
 hub_event+0x1bbb/0x4d30 drivers/usb/core/hub.c:5971
 process_one_work kernel/workqueue.c:3495 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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
