Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3393246D555
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791797318; cv=none; b=PG6p6k6iQYbwftV8XzeEDs8Ji+MmZ2CNW0G+XGL/6nk/85/aqphVsp8p/rZxhG7n9jFQHbOGe+e/Wg82FlZLuC/cBd04Yp6gPIioDKz5h2i/gdq5GyHnXggiYmBZYPjEKXWZqc0kOIhqCK0xXcub+/ILJyQpAEhTe/ASaz7YbAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791797318; c=relaxed/simple;
	bh=Hc5IqB/VGWVrLlg3554ibi6siDL3bjCd/j8xJddtpUw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=MHxmmHY5zH5FXpBsWTcXKws5mU6TFLjXM1UugdCj49413otYYaNiI+xlJ2j8dKzDKUmyQBwUZqWn00CQGzPUB/llCN9qEuf/iMqfBZ4BTyuTCroGJgXPxo1Dbm2s3cTsqNRCIJjH0DzmLEit3cNNWSpyDGeBeayOJwEbGmn2x4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-822121639b4so2861652a34.3
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 02:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791797316; x=1792402116;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=joKYai7R5O8PhQUhZxfJ4rVVG7ut68PsGeDc2YSwNI8=;
        b=h6mdI9zgTvX1VFaR7kpgMdd+dxQd+p4mR5HiyVVAQ97B0V1UK+VUZ4XFhLh38jVKsg
         CwnWBr6kKydFMrPhX5U1APF9Ya8bksV5jCH075dwlgeRO3tTiUg3Pnd5wX2OI7llbJFn
         /TZo+UsUB/NAHhHCOpJehatkBvz6r/tPQAUMmZ0YL6VXgIRRk+vk2hbsqxvJyUtEhF/y
         h/guIzzzSaNdiOsbA5E7/SS4L5SN+HKIB2Z8aG0ExnDb9ca+I2Y4YEaH8XGFme58KCLS
         Ny8IIrtHWnN+4D666q1CldGzA7ayAFL5PdtyC+PcunOfVHBYrVU9jUmZs9utxkO7Zdd2
         9x/A==
X-Forwarded-Encrypted: i=1; AKwUvBzmSW/4tAUKEMiwUaP8IfhC2buojisGsQS+7P3ht8hAoAidBX5uKPAFOjjI41EoZnPlBqAad+c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIn3nwyb6U/7wf7OyNF5jhrRDNUYnfU4M+IirJUYkK4PzZ0HLXK
	/KTT7WO6SU7R60+O1LCmHHDkSRd54djbK+YvkNoZ+2k+PxyIJDQ8Ac+G6x4A//Cka/0qC11EpCk
	OY+8xxwNvXK+nUzd08lENBp6ReSW5/lUEKM2n8/e2ijhhfpXzyWTiUODfngY=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6611:b0:4f5:59e4:a8b with SMTP id
 5614622812f47-50c55d7c357mr7109729b6e.58.1791797316091; Mon, 12 Oct 2026
 02:28:36 -0700 (PDT)
Date: Mon, 12 Oct 2026 02:28:36 -0700
In-Reply-To: <20261012044322.503949-1-dungvn2345@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6acca844.8cdf6287.1eb53.0122.GAE@google.com>
Subject: [syzbot ci] Re: net/sched: sch_netem: prevent packet length underflow
 with negative overhead
From: syzbot ci <syzbot+cid9cb71b48d5b38c3@syzkaller.appspotmail.com>
To: davem@davemloft.net, dungvn2345@gmail.com, edumazet@kernel.org, 
	hagen@jauu.net, horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, stable@vger.kernel.org, stephen@networkplumber.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v2] net/sched: sch_netem: prevent packet length underflow with negative overhead
https://lore.kernel.org/all/20261012044322.503949-1-dungvn2345@gmail.com
* [PATCH net v2] net/sched: sch_netem: prevent packet length underflow with negative overhead

and found the following issue:
divide error in netem_enqueue

Full report is available here:
https://ci.syzbot.org/series/eff5cc04-13f7-4a28-9b83-b6e0de530bc2

***

divide error in netem_enqueue

tree:      net
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
base:      af32da41b0327b9c6a37856ba82b6760d6c8d10e
arch:      amd64
compiler:  Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/bf12d8a1-2cda-46fc-9150-cadd809b1c71/config

Oops: divide error: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 17390 Comm: syz.0.2912 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:netem_enqueue+0x20f6/0x3300
Code: 8b 74 24 38 48 8b 44 24 50 42 80 3c 28 00 74 08 4c 89 f7 e8 cc f4 51 f8 49 8b 0e 4c 89 f8 48 f7 25 b7 9c 8b 04 48 89 4c 24 78 <48> f7 74 24 78 48 b9 ff ff ff ff ff ff ff 7f 48 39 c8 48 0f 42 c8
RSP: 0018:ffffc900082cf4b0 EFLAGS: 00010a07
RAX: 3599740d73380000 RBX: 0000005c44b22572 RCX: 000000000000002c
RDX: 0000000000000077 RSI: 00000000000001ed RDI: 00000000000001ee
RBP: ffff88810e973000 R08: ffffffff917a717f R09: 1ffffffff22f4e2f
R10: dffffc0000000000 R11: ffffffff81776d40 R12: ffff888026e62330
R13: dffffc0000000000 R14: ffff88810e9732b0 R15: 0000020000176c00
FS:  00007f87167196c0(0000) GS:ffff88818c4bf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8716718ff8 CR3: 000000002756e000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 netem_enqueue+0x16f1/0x3300
 dev_qdisc_enqueue+0x4e/0x260
 __dev_queue_xmit+0x1b6c/0x3920
 packet_sendmsg+0x3f11/0x51a0
 sock_sendmsg_nosec+0x13a/0x180
 __sys_sendto+0x408/0x5a0
 __x64_sys_sendto+0xde/0x100
 do_syscall_64+0x166/0x520
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f871579e1d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8716719028 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f8715a25fa0 RCX: 00007f871579e1d9
RDX: 00000000000005dc RSI: 0000200000000280 RDI: 0000000000000009
RBP: 00007f8715835888 R08: 0000200000000140 R09: 0000000000000014
R10: 0000000000004009 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8715a26038 R14: 00007f8715a25fa0 R15: 00007ffc85273198
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:netem_enqueue+0x20f6/0x3300
Code: 8b 74 24 38 48 8b 44 24 50 42 80 3c 28 00 74 08 4c 89 f7 e8 cc f4 51 f8 49 8b 0e 4c 89 f8 48 f7 25 b7 9c 8b 04 48 89 4c 24 78 <48> f7 74 24 78 48 b9 ff ff ff ff ff ff ff 7f 48 39 c8 48 0f 42 c8
RSP: 0018:ffffc900082cf4b0 EFLAGS: 00010a07
RAX: 3599740d73380000 RBX: 0000005c44b22572 RCX: 000000000000002c
RDX: 0000000000000077 RSI: 00000000000001ed RDI: 00000000000001ee
RBP: ffff88810e973000 R08: ffffffff917a717f R09: 1ffffffff22f4e2f
R10: dffffc0000000000 R11: ffffffff81776d40 R12: ffff888026e62330
R13: dffffc0000000000 R14: ffff88810e9732b0 R15: 0000020000176c00
FS:  00007f87167196c0(0000) GS:ffff88818c4bf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8716718ff8 CR3: 000000002756e000 CR4: 00000000000006f0


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
