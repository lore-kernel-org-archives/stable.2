Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645F03290BD
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786468541; cv=none; b=f7dEdynTJs+GSa8C4giYmdruYPBKEUI06MLditsHw0HyICasolNj1WimS01pqaQbjK2mJXqwTnJxQeJ4ZUuDA8EPXrIPiUAqmbGmgLPczAm2KMhK977CJFzif5718FLqjsnLTy+L1ZtB6bAzHBoiNmzemnljXvF28XvTjMmSo9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786468541; c=relaxed/simple;
	bh=/x32w0Hja9RlNZOcUcoRgqHfpwQXYYrR89y4IoyHyEM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MHk6q1BsydNh6RFHIYVTvw/v7gycDo7BXWPTg4DZDRmS7DDLUZz9uvqnNcsu+D4N8f4mTR5q4dEmU5YMHq6IZIYzQw2lnf6k8bzpSnD8zogds5dPR/t1eRPtymVVcTuwuu0Q/m1PjrjzjDMWcGMZMxjT+W6m2M6udEI9bN6sNRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4a45b3f0bdfso82782b6e.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 10:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786468538; x=1787073338;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AXfLTBt3QiphfYH21Xgm1enb28mlAdxrrXg76S/tXaY=;
        b=JvGZqTLFbBXNiPtl/OpAmFY43Akd/qRr5Kx3oBM/8dzYZ/5F5fYQCInXQovUddfv8z
         ANlF2a/dnaTEzylW57uR5aOdR8Azw6PAw7u5HpiIJ+vc4JtMtEjn61gGYnPj10Xt2EFR
         OhVGNcX0dzmtHKNakXmuEy1f/UQWRfpsu72q6eUT8iak9UVKTCRf+CVYdTq3Y1qaOXyX
         87SyK7aYQAupCKDfmezNpOGPTDVlCwJVMJTeDZ7S+1pcxM9TSsIbJa6OuaVPXUXXuYi3
         e47hyHnpbmLCv19o0sElu3J895mhsfJ24ITxVFnBBt49YVoxG3ACrr9tXhEruST1pfEa
         Gniw==
X-Forwarded-Encrypted: i=1; AHgh+RqY2Q3I3U3EE49WYfOE1jCn07kVWhjV+BtHgEjmokIQbUOoM1rvpkc0+gLqEpOaJ9k87lmes/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOuCKBR5Fuk1hyxeH3Qxy/HJtmJwIje08tqCTzhP4s2JCplOfe
	6AxXOTV1XOAGEdBoZsMKLXeHPxjHJY8gXJI7IPEHCkANo9sXYHCroFF+XhFGQRrNDVGUePbZr4Q
	1k9oy7bdD/QuFkDddNjYv4V4DiasaXIgopXnnkmySCgDlun/eG+0RP1fOhpA=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c1aa:b0:4a3:ec8e:2052 with SMTP id
 5614622812f47-4b1fd67318bmr3873936b6e.8.1786468538231; Tue, 11 Aug 2026
 10:15:38 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:15:38 -0700
In-Reply-To: <6a791c94.01d0871a.3a0d52.009b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7b58ba.ac361c09.22ff0a.0045.GAE@google.com>
Subject: Re: [syzbot] [mtd?] divide error in block2mtd_setup2
From: syzbot <syzbot+b320a4d5f65a61dbbf89@syzkaller.appspotmail.com>
To: fabf@skynet.be, joern@barelysecure.org, joern@lazybastard.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
	miquel.raynal@bootlin.com, richard@nod.at, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, vigneshr@ti.com, xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f5bbbfec59b4 Merge tag 'probes-fixes-v7.2-rc7' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a31079580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c44651ea7dd2f307
dashboard link: https://syzkaller.appspot.com/bug?extid=b320a4d5f65a61dbbf89
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b76149580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b320a4d5f65a61dbbf89@syzkaller.appspotmail.com

Oops: divide error: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 6029 Comm: syz-executor518 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:add_device drivers/mtd/devices/block2mtd.c:296 [inline]
RIP: 0010:block2mtd_setup2.isra.0+0x3c8/0xc70 drivers/mtd/devices/block2mtd.c:459
Code: 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 2b 08 00 00 48 8b 6d 08 31 ff 48 89 e8 48 c1 e0 09 48 99 <49> f7 ff 48 89 d6 48 89 54 24 10 e8 98 d5 4d fb 48 8b 54 24 10 48
RSP: 0018:ffffc90004ccf9f0 EFLAGS: 00010206
RAX: 0000000000100000 RBX: 1ffff92000999f41 RCX: ffffffff86bc9838
RDX: 0000000000000000 RSI: ffffffff86bc984a RDI: 0000000000000000
RBP: 0000000000000800 R08: 0000000000000005 R09: 000000000000001f
R10: 0000000000000007 R11: 0000000000000000 R12: ffffc90004ccfaa8
R13: 0000000000000000 R14: ffff8880254fe000 R15: 0000000000000000
FS:  000055558148e400(0000) GS:ffff8880d5dec000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a8208cda78 CR3: 000000003ad58000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 block2mtd_setup+0xbd/0xd0 drivers/mtd/devices/block2mtd.c:476
 param_attr_store+0x199/0x300 kernel/params.c:589
 module_attr_store+0x58/0x80 kernel/params.c:904
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0b39a14737
Code: 48 89 fa 4c 89 df e8 98 1d 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffdcc22a9a0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000055558148e400 RCX: 00007f0b39a14737
RDX: 000000000000000c RSI: 00007ffdcc22aa50 RDI: 0000000000000004
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffdcc22aa50
R13: 00007ffdcc22aa10 R14: 00007ffdcc22a9f0 R15: 0000000000000002
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:add_device drivers/mtd/devices/block2mtd.c:296 [inline]
RIP: 0010:block2mtd_setup2.isra.0+0x3c8/0xc70 drivers/mtd/devices/block2mtd.c:459
Code: 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 2b 08 00 00 48 8b 6d 08 31 ff 48 89 e8 48 c1 e0 09 48 99 <49> f7 ff 48 89 d6 48 89 54 24 10 e8 98 d5 4d fb 48 8b 54 24 10 48
RSP: 0018:ffffc90004ccf9f0 EFLAGS: 00010206
RAX: 0000000000100000 RBX: 1ffff92000999f41 RCX: ffffffff86bc9838
RDX: 0000000000000000 RSI: ffffffff86bc984a RDI: 0000000000000000
RBP: 0000000000000800 R08: 0000000000000005 R09: 000000000000001f
R10: 0000000000000007 R11: 0000000000000000 R12: ffffc90004ccfaa8
R13: 0000000000000000 R14: ffff8880254fe000 R15: 0000000000000000
FS:  000055558148e400(0000) GS:ffff8880d5dec000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a8208cda78 CR3: 000000003ad58000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
   7:	fc ff df
   a:	48 89 fa             	mov    %rdi,%rdx
   d:	48 c1 ea 03          	shr    $0x3,%rdx
  11:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  15:	0f 85 2b 08 00 00    	jne    0x846
  1b:	48 8b 6d 08          	mov    0x8(%rbp),%rbp
  1f:	31 ff                	xor    %edi,%edi
  21:	48 89 e8             	mov    %rbp,%rax
  24:	48 c1 e0 09          	shl    $0x9,%rax
  28:	48 99                	cqto
* 2a:	49 f7 ff             	idiv   %r15 <-- trapping instruction
  2d:	48 89 d6             	mov    %rdx,%rsi
  30:	48 89 54 24 10       	mov    %rdx,0x10(%rsp)
  35:	e8 98 d5 4d fb       	call   0xfb4dd5d2
  3a:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
  3f:	48                   	rex.W


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
