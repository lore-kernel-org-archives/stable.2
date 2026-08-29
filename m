Received: from mail-oa2-f11.google.com (mail-oa2-f11.google.com [74.125.231.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DC7342539
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 18:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788027152; cv=none; b=YHI/A1JRSZ3HadUZR+DIXATXFxQ9MjYtwed2l6qDJsxY7Ao0rqVSszog5XWH/iuwXFI/WkTGBjq42BQHfu0YT7R/VJ4h3CkGFVVfs7/qDGXo+5zaRX+O722UD6/BqrJDdtnZWGHP2ShuqC+q5SbmW6EkKkb9AN9HGoKWDp4G9J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788027152; c=relaxed/simple;
	bh=JoCX3fnSCShZjp0GSA5kQJjw14vfli5MDAi6+QzeUxo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hOi+4ythf962FyKZ9Mree1LSJ2eU91C2brUeCydgtpQ1luD3kvN6znBjLKDVEnHxIi4SxwfV2dU/RiD5mJsRRX4sJ8bIEgWtR9yxo5pPDV7/2QlOxOnX88HOXEnWfYUN6WAh1PLWnVrbdNJAG210ijQAbhH8B/MuBb0MF7rYBII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f11.google.com with SMTP id 586e51a60fabf-45e2c1e33e1so898616fac.1
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 11:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788027149; x=1788631949;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pHsLquJqNRAjRm+7ZW66khh06nIsTIk5CmRuM7gIIu4=;
        b=BUWPDgVdMVzWkbKcbMXomoYWPSPp3tg8oZZ9Czx6IRlAoYJcvM4VdclZg2RzEFWgPp
         zqReeQKsNxHGPmKN49o5QP8tE/MEpOCzuhXEueCIgCXJ/gsy304yZMdU1coS5v7yQPez
         F0YPnskYBZv/q5xFwF+PLIn7ZDnMRWAapsCpQYOGQmNPI4kbThMy6nbX00W970XsKSp3
         2W2k7Cl2F4MDC4Bz9CRbRnEWJ3FwuIInQZwyIrrLN2VtnVFgw14e39lPGBY3I3czPIEn
         OlIIoAvTt/h6m7nvTbCBEvrGpA++Ir+RpiIEC7G597Q1SqLpfY2beF8QM3UALbhQ9IMK
         E7zg==
X-Forwarded-Encrypted: i=1; AHgh+RoABP9JqtKXfed7ZxXIuNQ35YUaR0DDP3y6UriE79Hx/yAx04vtgUp3264w4/HViklclK8Tk4o=@vger.kernel.org
X-Gm-Message-State: AFuF++lXR+Jrubn2vgeZoVzRAYo+tuyHIS31g6Q9Jaaw6gCOSl4pSri2
	xVIXFNnKJ1q4V43krokL3qCcuPOEpGixNNHzTOur9nBFS8WClRENsMNxaoZrG8ulqhTVqdccTaG
	B5WX8DzH8Iwf31+L7H1J06NUTuxAc+hv2FYEVyt+2+B2hZ8yvQtdxrPr80bU=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c1e8:b0:4b3:3e1:4999 with SMTP id
 5614622812f47-4b398434703mr16842286b6e.15.1788027149515; Sat, 29 Aug 2026
 11:12:29 -0700 (PDT)
Date: Sat, 29 Aug 2026 11:12:29 -0700
In-Reply-To: <6a8f89e5.1d9ded08.62e62.00bf.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a93210d.4d659fcc.734b4.002c.GAE@google.com>
Subject: Re: [syzbot] [audit?] BUG: unable to handle kernel paging request in integrity_audit_message
From: syzbot <syzbot+5ebeb3089ea6439c37be@syzkaller.appspotmail.com>
To: audit@vger.kernel.org, brads@mainlining.org, eparis@redhat.com, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    cf72cbb39da8 Merge tag 'io_uring-7.3-20260828' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e7cc15580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85bc5cc2fc7394d9
dashboard link: https://syzkaller.appspot.com/bug?extid=5ebeb3089ea6439c37be
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159ebd79580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123d1d79580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-cf72cbb3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/755d053ff703/vmlinux-cf72cbb3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0837738ba281/bzImage-cf72cbb3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5ebeb3089ea6439c37be@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffffffffffffdc
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD eb99067 P4D eb99067 PUD eb9b067 PMD 0 
Oops: Oops: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5921 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:strlen+0x30/0xa0 lib/string.c:402
Code: 00 00 00 00 00 fc ff df 55 48 89 fa 48 89 fd 53 48 c1 ea 03 48 83 ec 08 0f b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 50 <80> 7d 00 00 74 3d 48 bb 00 00 00 00 00 fc ff df 48 89 e8 48 83 c0
RSP: 0018:ffffc90002eb7920 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffffffffffdc RCX: 0000000000000000
RDX: 0000000000000004 RSI: ffffffff82081bc1 RDI: ffffffffffffffdc
RBP: ffffffffffffffdc R08: 0000000000000004 R09: 00000000000000a9
R10: 00000000000006c0 R11: 0000000000000001 R12: ffff888027be0e40
R13: 0000000000000007 R14: 00000000fffffff3 R15: ffffffffffffffdc
FS:  0000000000000000(0000) GS:ffff888096967000(0063) knlGS:000000005783f480
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: ffffffffffffffdc CR3: 0000000055e55000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __fortify_strlen include/linux/fortify-string.h:218 [inline]
 audit_log_untrustedstring+0x19/0x30 kernel/audit.c:2203
 integrity_audit_message+0x366/0x4f0 security/integrity/integrity_audit.c:60
 integrity_audit_msg+0x41/0x60 security/integrity/integrity_audit.c:32
 validate_hash_algo security/integrity/ima/ima_appraise.c:752 [inline]
 ima_inode_setxattr+0x512/0x5f0 security/integrity/ima/ima_appraise.c:775
 security_inode_setxattr+0x299/0x560 security/security.c:1940
 __vfs_setxattr_locked+0xad/0x2b0 fs/xattr.c:309
 vfs_setxattr+0x14a/0x390 fs/xattr.c:344
 do_setxattr+0x145/0x180 fs/xattr.c:662
 file_setxattr fs/xattr.c:672 [inline]
 file_setxattr+0x139/0x1b0 fs/xattr.c:666
 path_setxattrat+0x335/0x3b0 fs/xattr.c:732
 __do_sys_fsetxattr fs/xattr.c:782 [inline]
 __se_sys_fsetxattr fs/xattr.c:779 [inline]
 __ia32_sys_fsetxattr+0xc4/0x140 fs/xattr.c:779
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 __do_fast_syscall_32+0x13a/0x8b0 arch/x86/entry/syscall_32.c:291
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:316
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7fb7fec
Code: Unable to access opcode bytes at 0xf7fb7fc2.
RSP: 002b:00000000fffd97bc EFLAGS: 00000296 ORIG_RAX: 00000000000000e4
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000080000080
RDX: 0000000080001080 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: ffffffffffffffdc
---[ end trace 0000000000000000 ]---
RIP: 0010:strlen+0x30/0xa0 lib/string.c:402
Code: 00 00 00 00 00 fc ff df 55 48 89 fa 48 89 fd 53 48 c1 ea 03 48 83 ec 08 0f b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 50 <80> 7d 00 00 74 3d 48 bb 00 00 00 00 00 fc ff df 48 89 e8 48 83 c0
RSP: 0018:ffffc90002eb7920 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffffffffffdc RCX: 0000000000000000
RDX: 0000000000000004 RSI: ffffffff82081bc1 RDI: ffffffffffffffdc
RBP: ffffffffffffffdc R08: 0000000000000004 R09: 00000000000000a9
R10: 00000000000006c0 R11: 0000000000000001 R12: ffff888027be0e40
R13: 0000000000000007 R14: 00000000fffffff3 R15: ffffffffffffffdc
FS:  0000000000000000(0000) GS:ffff888096967000(0063) knlGS:000000005783f480
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f7fb8000 CR3: 0000000055e55000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	00 fc                	add    %bh,%ah
   6:	ff                   	lcall  (bad)
   7:	df 55 48             	fists  0x48(%rbp)
   a:	89 fa                	mov    %edi,%edx
   c:	48 89 fd             	mov    %rdi,%rbp
   f:	53                   	push   %rbx
  10:	48 c1 ea 03          	shr    $0x3,%rdx
  14:	48 83 ec 08          	sub    $0x8,%rsp
  18:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  1c:	48 89 fa             	mov    %rdi,%rdx
  1f:	83 e2 07             	and    $0x7,%edx
  22:	38 d0                	cmp    %dl,%al
  24:	7f 04                	jg     0x2a
  26:	84 c0                	test   %al,%al
  28:	75 50                	jne    0x7a
* 2a:	80 7d 00 00          	cmpb   $0x0,0x0(%rbp) <-- trapping instruction
  2e:	74 3d                	je     0x6d
  30:	48 bb 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbx
  37:	fc ff df
  3a:	48 89 e8             	mov    %rbp,%rax
  3d:	48                   	rex.W
  3e:	83                   	.byte 0x83
  3f:	c0                   	.byte 0xc0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
