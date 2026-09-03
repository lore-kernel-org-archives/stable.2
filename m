Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63554BB815
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447355; cv=none; b=fyc23dAIjzZkKXILMqEaN2+BwDoKWrU1kgcrJKdgEs4B1ZlOMwLhTj1fi96mQsuU/hg5NEI89V6M8RivOuiL1ihBmDEfUZ1ipOI9JZuJCi6nSM9gtjpZ4xRdP1cozJh7bzFC+uV2DpBaATGj2iOF0MLUIjUpU06ceT5ScSMgNzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447355; c=relaxed/simple;
	bh=CoRlB6gAX6V1ReavRH4xaLpkAo6ffNhn7w18OCM60bI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IdXlR8d3g49rvzH28b78eAFjAq2OO1NlwP/0JNggV9QEQrFXYycOGywR2Waj5LeeFJ3PpgbncLbPnvWyDb9AvR+LwtL00Hi/j9Q6cs3EziK4/zdha/e7klR8NZ/BVw9NY7Wkte9f5iIZxfaPmK9WnV3qYfGSHtrXXyHjsoebhKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-6b163fddf0aso1111984eaf.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 07:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788447353; x=1789052153;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Yh2JriY1HIYvSoqEosp4VpGCVknWxb4Ip0izbJulw+c=;
        b=XHAGwr2p7GKlVJNyYhVG95lxU/L+FOht5Pb0vfzGrb65ibhX2U9ZwfkqSyW9QKpzuR
         z2lhKtx8e4vK49Ot0gC3xqlZDT0FjNyFOE/w0y9MyVZDfKpH/tNbPWUXnyCQQcqVTBqD
         FBpBJGEgklpqQB5wigSImXyc/Zks0bk93D3CHQVnPZcGqY23DxZcA+KSatbLPIPllCuR
         dSZK/+igri3GZBvQi1vjw4HPcWavooyHnUkFQdf8dyS9VeI6cYGcEeGOXrDFvwa1DjfH
         g7IWL18Ta+nDhi03RZqoOBCl2ovBImJC4/+xFVdlqsi7lyxi6L8bsHjgyHoIFbsEahLs
         1TEA==
X-Forwarded-Encrypted: i=1; AKwUvBy9udAMSRdKKiv/gJZnq2a/X9KAbK1f1WHN/KSTurOCmjJeUVaxOntF5pYh0mAvSr4uR0nQ4v4=@vger.kernel.org
X-Gm-Message-State: AFuF++nqqIJBKmECJXiLuW0iAjyCvmojfy4WEwUa1aCTrniVBrhRkfRE
	AsiyAShcev5oglQO8i5pyQUaGBGJnczQLkZPJXheFzimzELspuzcVnSok8trqNAhSMmuTZSDfDq
	jVjG5DP+cDUIbBnA/PGP92BS/vUHt4Ss39GIh5WcXxFqbd0uoi+N+Bz0hADA=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:16ac:b0:6b5:ec2f:3572 with SMTP id
 006d021491bc7-6b5ec2f3690mr1539470eaf.35.1788447352818; Thu, 03 Sep 2026
 07:55:52 -0700 (PDT)
Date: Thu, 03 Sep 2026 07:55:52 -0700
In-Reply-To: <6a9087a4.4d659fcc.734b4.0013.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a998a78.e7659fcc.146146.000a.GAE@google.com>
Subject: Re: [syzbot] [usb?] general protection fault in keyspan_break_ctl
From: syzbot <syzbot+473d7477c523b41d4046@syzkaller.appspotmail.com>
To: adrianox@gmail.com, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	johan@kernel.org, kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    940de590b839 Merge tag 'hardening-v7.3-rc2' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13537c15580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85bc5cc2fc7394d9
dashboard link: https://syzkaller.appspot.com/bug?extid=473d7477c523b41d4046
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f19f79580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ed50f9580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-940de590.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f3f674f98efb/vmlinux-940de590.xz
kernel image: https://storage.googleapis.com/syzbot-assets/132222426e71/bzImage-940de590.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+473d7477c523b41d4046@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000013: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000098-0x000000000000009f]
CPU: 0 UID: 0 PID: 6007 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:keyspan_break_ctl+0x8e/0xe0 drivers/usb/serial/keyspan.c:608
Code: ff ff ff e8 74 88 43 fa 83 fb ff 48 b8 00 00 00 00 00 fc ff df 49 8d bc 24 9c 00 00 00 0f 94 c3 48 89 fa 0f b6 db 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 1d 41
RSP: 0018:ffffc900067ffc50 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff87c7ae2c
RDX: 0000000000000013 RSI: 00000000ffffffff RDI: 000000000000009c
RBP: ffff888013d9a000 R08: 0000000000000005 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88804a94d020 R14: ffff88804a94d0c8 R15: 0000000000000007
FS:  0000000000000000(0000) GS:ffff888096967000(0063) knlGS:0000000056ebd480
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000ffdb3ff0 CR3: 00000000529f7000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 serial_break+0xcb/0x160 drivers/usb/serial/usb-serial.c:538
 send_break drivers/tty/tty_io.c:2458 [inline]
 send_break+0x2ec/0x370 drivers/tty/tty_io.c:2441
 tty_ioctl+0xa2c/0x1640 drivers/tty/tty_io.c:2733
 tty_compat_ioctl+0x87/0x420 drivers/tty/tty_io.c:2931
 __do_compat_sys_ioctl fs/ioctl.c:695 [inline]
 __se_compat_sys_ioctl fs/ioctl.c:638 [inline]
 __ia32_compat_sys_ioctl+0x2cf/0x360 fs/ioctl.c:638
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 __do_fast_syscall_32+0x13a/0x8b0 arch/x86/entry/syscall_32.c:291
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:316
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf702efec
Code: Unable to access opcode bytes at 0xf702efc2.
RSP: 002b:00000000ff93915c EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000005425
RDX: 0000000000000007 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:keyspan_break_ctl+0x8e/0xe0 drivers/usb/serial/keyspan.c:608
Code: ff ff ff e8 74 88 43 fa 83 fb ff 48 b8 00 00 00 00 00 fc ff df 49 8d bc 24 9c 00 00 00 0f 94 c3 48 89 fa 0f b6 db 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 1d 41
RSP: 0018:ffffc900067ffc50 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff87c7ae2c
RDX: 0000000000000013 RSI: 00000000ffffffff RDI: 000000000000009c
RBP: ffff888013d9a000 R08: 0000000000000005 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88804a94d020 R14: ffff88804a94d0c8 R15: 0000000000000007
FS:  0000000000000000(0000) GS:ffff888096a67000(0063) knlGS:0000000056ebd480
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f7349bcc CR3: 00000000529f7000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	ff                   	ljmp   (bad)
   1:	e8 74 88 43 fa       	call   0xfa43887a
   6:	83 fb ff             	cmp    $0xffffffff,%ebx
   9:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  10:	fc ff df
  13:	49 8d bc 24 9c 00 00 	lea    0x9c(%r12),%rdi
  1a:	00
  1b:	0f 94 c3             	sete   %bl
  1e:	48 89 fa             	mov    %rdi,%rdx
  21:	0f b6 db             	movzbl %bl,%ebx
  24:	48 c1 ea 03          	shr    $0x3,%rdx
* 28:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx <-- trapping instruction
  2c:	48 89 f8             	mov    %rdi,%rax
  2f:	83 e0 07             	and    $0x7,%eax
  32:	83 c0 03             	add    $0x3,%eax
  35:	38 d0                	cmp    %dl,%al
  37:	7c 04                	jl     0x3d
  39:	84 d2                	test   %dl,%dl
  3b:	75 1d                	jne    0x5a
  3d:	41                   	rex.B


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
