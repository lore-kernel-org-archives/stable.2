Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155DC3546F6
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 02:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788403267; cv=none; b=VOXCH55b2U7aQVDURTY9rmLzvfjAC7Hx04ffpTNFH0tmTYXEtDy4NLqQSvTBRFv5olXD4oQc5HU7kJZEDol6X2SLhsHYCrQtI14Qffi86RFYHqAZ3S6p6WJxmi8neEmWW9haO1JJh4LSOtiv0OgQF+M9BZIaro4KwDV7HE/r0Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788403267; c=relaxed/simple;
	bh=lr0aR1UY7uIm1dLJJqyF/T2lElAnVVpA0WzNuk3EPMI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JTqczoZ3LBvi4aoWSbDQxD8006v1Y2iWXepdI4pzXV9l1cPqTsv4a2MARx/cqt7qFfA7hhVbG07/wfVPBX3z3ZtFUpRHc4CT/jciz81JMMEnds1R/VAh4WIFbpgPujVfwB+WuMtCjOEeJqeyHe0C2xw+sDHCMeqW1kgY9i3drcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6b13d095a33so1584782eaf.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 19:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788403265; x=1789008065;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iRtqUWnllCctgJmjQTfsRI6sPQicPo1I015+mx/n+3o=;
        b=Sy7a2rahLTt8rU5d5swImbpKbDZgwh0cSMmTwBNj/307qkViTP82Z3Oji8OfbUu2zJ
         AfHJlqs+/zx1TcEOEqqFC7M5OgaJ7hz/tzkcM0L7jRIdsQ2KS0ztcw4S563bHVCIMGkU
         LUB9m5M9wTMEYTkMUNqk+J/uwmMMB7sKnEe4eWYTqSnhDX6x8uO11z4e6jwb5nClUWnI
         LR2bvCHvO66pzRBG4vB+yTosmpJDa6qK2rmYeAGY/nhgwKh6tgjzYciAChMLKN8Gkcw3
         LsJoG9YAN9W0N6dWByXbwPvP4tBNJnnuPTpbysdrF4Bgv+Rvdy0GoiOcNMlZIWxsAkZy
         wUOg==
X-Forwarded-Encrypted: i=1; AKwUvBwhlS0vjluHAr6ipGTZtTwUfGF/X3mJn+KueIm9LYo0g41ciPkCNKr86GvBoDBOorZC3CcaZOM=@vger.kernel.org
X-Gm-Message-State: AFuF++l91jKD9SFTi/qf4BLw4ocrUQ+TWhRB46PGByxcGubPPCJ9D89A
	vA2fCeNYlYEzfZHva8YcRd7+/SvVaB9DtYdD8AxhSsdfNsMV/afp4UpcR4mT5T6bXAoKpdrlEFi
	/PArooLGs3ZtP31tTy317YE3i3cjV3t0bhwo5Y0/ackIOmkcC9cdvrHGmZao=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2918:b0:6b0:4199:3cc4 with SMTP id
 006d021491bc7-6b48173f922mr8898596eaf.27.1788403265029; Wed, 02 Sep 2026
 19:41:05 -0700 (PDT)
Date: Wed, 02 Sep 2026 19:41:05 -0700
In-Reply-To: <20260903022452.111316-2-adrianox@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a98de41.9266084e.bf0d7.0015.GAE@google.com>
Subject: Re: [syzbot] [usb?] general protection fault in keyspan_break_ctl
From: syzbot <syzbot+473d7477c523b41d4046@syzkaller.appspotmail.com>
To: adrianox@gmail.com, johan@kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in keyspan_break_ctl

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000013: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000098-0x000000000000009f]
CPU: 3 UID: 0 PID: 6463 Comm: syz.3.20 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:keyspan_break_ctl+0x8e/0xe0 drivers/usb/serial/keyspan.c:608
Code: ff ff ff e8 24 67 42 fa 83 fb ff 48 b8 00 00 00 00 00 fc ff df 49 8d bc 24 9c 00 00 00 0f 94 c3 48 89 fa 0f b6 db 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 1d 41
RSP: 0018:ffffc9000334fca8 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff87c9835c
RDX: 0000000000000013 RSI: 00000000ffffffff RDI: 000000000000009c
RBP: ffff888059412000 R08: 0000000000000005 R09: 00000000ffffffff
R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000000000
R13: ffff888038a76e00 R14: ffff88802aef6020 R15: ffff88802aef60c8
FS:  00007f62980d46c0(0000) GS:ffff8880d5e61000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f41412c8d58 CR3: 0000000025cea000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 serial_break+0xcb/0x160 drivers/usb/serial/usb-serial.c:538
 send_break drivers/tty/tty_io.c:2456 [inline]
 send_break+0x194/0x3b0 drivers/tty/tty_io.c:2442
 tty_ioctl+0xa2f/0x1640 drivers/tty/tty_io.c:2737
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f629719e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f62980d4028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6297425fa0 RCX: 00007f629719e0d9
RDX: 0000000000000000 RSI: 0000000000005425 RDI: 0000000000000004
RBP: 00007f6297235024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6297426038 R14: 00007f6297425fa0 R15: 00007ffcf04a40e8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:keyspan_break_ctl+0x8e/0xe0 drivers/usb/serial/keyspan.c:608
Code: ff ff ff e8 24 67 42 fa 83 fb ff 48 b8 00 00 00 00 00 fc ff df 49 8d bc 24 9c 00 00 00 0f 94 c3 48 89 fa 0f b6 db 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 1d 41
RSP: 0018:ffffc9000334fca8 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff87c9835c
RDX: 0000000000000013 RSI: 00000000ffffffff RDI: 000000000000009c
RBP: ffff888059412000 R08: 0000000000000005 R09: 00000000ffffffff
R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000000000
R13: ffff888038a76e00 R14: ffff88802aef6020 R15: ffff88802aef60c8
FS:  00007f62980d46c0(0000) GS:ffff8880d5d61000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055aeb7ddb480 CR3: 0000000025cea000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	ff                   	ljmp   (bad)
   1:	e8 24 67 42 fa       	call   0xfa42672a
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


Tested on:

commit:         940de590 Merge tag 'hardening-v7.3-rc2' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10641f79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=473d7477c523b41d4046
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10f81f79580000

