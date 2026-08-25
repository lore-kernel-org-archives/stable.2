Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0096719005E
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787629423; cv=none; b=RltzMf7TLbQ11m1uZuSnEjVYT+aYUdXNR3OExIc1kPXpoIo9es5Srs0Lz7gGAPLRBS14LbUn1GiVgqyT7dqNysYhYdrAXKdA+tqrUGZVcdzK6KReRD2l1+1QhL/GjASnBGOw9L7SVynGstSxVkxTAHq3WHIrS8AELTjsGU3oLJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787629423; c=relaxed/simple;
	bh=Q0tS7aUlqWs1+Sv1rMy8/xQ7sdBcjXYL5fPPpYfKWnM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tdrWjSrIZGaOamMcSXkt4/YuVdICKZbLJSj2loCORUeSceYYFkxaGUgV42MzaoOXDO/dftFG8jpoFAl0L/UoS3+6h11VbOha6V09NUzM/lImREKrxjxdmd5ZOJPnpy/qmdfurIhoksdpgMxm6Q/UTqGpPfLBtdbKJiWmBP055eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f10.google.com with SMTP id 46e09a7af769-7f193d62888so630026a34.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 20:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787629420; x=1788234220;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZjpD2FQJ+/ueSJRioL530ZfyPsRnYCZF2fy/pO8aPtQ=;
        b=J9CbXse2XxWvt9nt0t+eZYKylYavaLBEBrmQBuuY3rURFL7gMaJc1KlmPt1Unzgov0
         AiCBZwwlLWDAKFXBeVfhN/ojJ2GDJNPOiOGQa+YlYJXdDNo2Zi7gfsRGGbeyBf1SeqYu
         RtzLUMYqVNJc98ytdXbjN2cX9iJfV9aTv0Fmuga32eA1gd5k34g75E6mmyDcnL/QImO0
         DgHlvOfrbX3dfEaQUM/NZ/9Lf+xjhalul/K/a5KT4P/jqSBy6Iq55BWKTUfA+Y6MOhwp
         ZZ5aTA7Wb+HZvQX7tXDT1ekIPVKlzJ88McfWfI1tuyRl2By3DW+he3yh4Ixf0Iwcc0tX
         nx3A==
X-Forwarded-Encrypted: i=1; AHgh+Rp3/Y1TXHI3Oxz8HUE6P7UyYGF3/JumJZZhVfs45RyQrATrNr7eLH5yslv5X1NdLSCUfrWXKVA=@vger.kernel.org
X-Gm-Message-State: AFuF++npe4ty2kfyFBmmWz/5JvdhBqaQs4OF8zKFjnW5zlTEO2CRJWEU
	vUPHzcvqQTiQruQm0DyuABopgTDHouk+wBgMdFYUWY7xSm/g0keUIA88YI/gF+CANekdJvBrS5l
	mgC5Pg0iC0Z9J0zHCaRyvZhwmvD75Lt0PFVaX/Pd1MBJ6tb8njbu6/cRHqNI=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4c89:b0:6b1:5b3e:13a3 with SMTP id
 006d021491bc7-6b16b42654emr20396820eaf.30.1787629420739; Mon, 24 Aug 2026
 20:43:40 -0700 (PDT)
Date: Mon, 24 Aug 2026 20:43:40 -0700
In-Reply-To: <6a88012e.dbb3a75c.13dd47.0007.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8d0f6c.dbb3a75c.7844.001d.GAE@google.com>
Subject: Re: [syzbot] [usb?] general protection fault in wcove_typec_probe
From: syzbot <syzbot+1a01783ea233350598b5@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, 
	jeffinphilip14@gmail.com, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, mika.westerberg@linux.intel.com, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    66498c75b4f8 Merge tag 'dmaengine-7.3-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1253719e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e64b1bf01d830ed
dashboard link: https://syzkaller.appspot.com/bug?extid=1a01783ea233350598b5
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17491979580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-66498c75.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5ce4685e13ba/vmlinux-66498c75.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6a32d8e997a7/bzImage-66498c75.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a01783ea233350598b5@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 UID: 0 PID: 5912 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:wcove_typec_probe+0xdb/0x780 drivers/usb/typec/tcpm/wcove.c:621
Code: 48 c1 ea 03 80 3c 02 00 0f 85 af 05 00 00 48 8d 7d 08 4d 89 af 88 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 7f 05 00 00 49 8d bf 90 00 00 00 48 8b 6d 08 48
RSP: 0018:ffffc90002f6faf8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8880226c1000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000001 RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000004 R09: 0000000000000000
R10: ffff888014243883 R11: 000000000000001f R12: ffffffff904a7ea8
R13: ffff8880226c1010 R14: ffff8880142438c0 R15: ffff888014243838
FS:  0000000000000000(0000) GS:ffff888096982000(0063) knlGS:00000000f67e5b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000032e24008 CR3: 000000004e2f1000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 platform_probe+0x106/0x1d0 drivers/base/platform.c:1507
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x210/0x460 drivers/base/dd.c:868
 device_driver_attach+0xd1/0x220 drivers/base/dd.c:1203
 bind_store+0xf4/0x190 drivers/base/bus.c:267
 drv_attr_store+0x74/0xb0 drivers/base/bus.c:125
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6af/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 __do_fast_syscall_32+0x13a/0x8b0 arch/x86/entry/syscall_32.c:291
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:316
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf6feefec
Code: Unable to access opcode bytes at 0xf6feefc2.
RSP: 002b:00000000f67e550c EFLAGS: 00000292 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000080000400
RDX: 0000000000000007 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:wcove_typec_probe+0xdb/0x780 drivers/usb/typec/tcpm/wcove.c:621
Code: 48 c1 ea 03 80 3c 02 00 0f 85 af 05 00 00 48 8d 7d 08 4d 89 af 88 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 7f 05 00 00 49 8d bf 90 00 00 00 48 8b 6d 08 48
RSP: 0018:ffffc90002f6faf8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8880226c1000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000001 RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000004 R09: 0000000000000000
R10: ffff888014243883 R11: 000000000000001f R12: ffffffff904a7ea8
R13: ffff8880226c1010 R14: ffff8880142438c0 R15: ffff888014243838
FS:  0000000000000000(0000) GS:ffff888096a82000(0063) knlGS:00000000f67e5b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00007f45dd833708 CR3: 000000004e2f1000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 af 05 00 00    	jne    0x5bd
   e:	48 8d 7d 08          	lea    0x8(%rbp),%rdi
  12:	4d 89 af 88 00 00 00 	mov    %r13,0x88(%r15)
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 7f 05 00 00    	jne    0x5b3
  34:	49 8d bf 90 00 00 00 	lea    0x90(%r15),%rdi
  3b:	48 8b 6d 08          	mov    0x8(%rbp),%rbp
  3f:	48                   	rex.W


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
