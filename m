Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CC134F48F;
	Sat, 29 Aug 2026 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788028049; cv=none; b=pvbrJxhmmFcyHh2cfObsbuDSufr5heobrbcOK96bc/g0sZzHAql1S9IsXdJBsHevphvu+toZEHoFjvtJfpDZYKkVZ4BX0AdUnDqqt3dabys3GyO1/Lx7dZ4dCUNI9z+zYIlEU6iBMRz0oqiJni2kepji2n0GFirDvGl8z+xh/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788028049; c=relaxed/simple;
	bh=LivnsdYaAsMQGMsE2ie4eqMcE/yWP8ruqgVpFntbrIQ=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ARkPlf9zl9OOvHMF422JaH9Ngm6O/wff4Z8xhPTb8PjudLX4JhrxMvRfqiBZYGjImYurdAb2EZ2skZ03A+oo07O+pPw3X64YS6gg76+F1MEKgBXbVApPHvQCIx3ou/TTrdv8VkHwdPalnbQmpZbUVKKgFzM2FKL3ViIIuqjtagA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=bJgjYnm4; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=HE8CFLfy; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="bJgjYnm4";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="HE8CFLfy"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788027726; bh=xDAuqtB5MiI9SXqWj0T58s5
	SFUyYrKShuk4bdDdV7TU=; b=bJgjYnm4Zc43/Xco7Z4ZR3NZKElYUBwD1wPGU1YeULQ3fb9RRJ
	Kdnmwev4VyPWaZgMB3cpdqyuzGZCaUsNs60l7PAcsp7wdZqZXu7BLETlCp7od2r8EkJNF7ALaUh
	YsroqiGoseJa/jaa6Rcr8+7+uICY66sx+rtqWMSjXuEKILU2fWKSWW8onJ/t2L93Etj6yV/G4sv
	cODBOutsVACaI9dCNwOwVS84H+fwieAN/lIHOG5TWmGTHSP4SV7PAn1H8p9+Fzrfs+aEjD07rkP
	AXqliKv1SQxKizfPd3pDGWnIBoxmFHSYVpOFfNWR2nB4M01lTjA6iT8Dt/hh0aWaZCA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788027726; bh=xDAuqtB5MiI9SXqWj0T58s5
	SFUyYrKShuk4bdDdV7TU=; b=HE8CFLfy5wwx/eD1vlkwP9AtYL9ijJtpOVU0hj/8K6ugN3obiz
	clx9c+KemaBbj89JkIVZl/fdIWhJkr3LUkCQ==;
Date: Sat, 29 Aug 2026 19:22:07 +0100
From: Bradley Morgan <brads@mainlining.org>
To: syzbot <syzbot+5ebeb3089ea6439c37be@syzkaller.appspotmail.com>,
 audit@vger.kernel.org, eparis@redhat.com, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 paul@paul-moore.com, roberto.sassu@huawei.com, stable@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com
Subject: =?US-ASCII?Q?Re=3A_=5Bsyzbot=5D_=5Baudit=3F=5D_BUG=3A_unable_to_handle_ke?=
 =?US-ASCII?Q?rnel_paging_request_in_integrity=5Faudit=5Fmessage?=
In-Reply-To: <6a93210d.4d659fcc.734b4.002c.GAE@google.com>
References: <6a93210d.4d659fcc.734b4.002c.GAE@google.com>
Message-ID: <2A2D4D25-BB50-40A5-AF2F-956EBDB07876@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 29 August 2026 19:12:29 BST, syzbot
<syzbot+5ebeb3089ea6439c37be@syzkaller.appspotmail.com> wrote:
>syzbot has found a reproducer for the following issue on:
>

#syz test: dentry_path() returns ERR_PTR(-ENAMETOOLONG) when the path
exceeds the
buffer. validate_hash_algo() passes the result straight to
integrity_audit_msg() without checking. ERR_PTR is not NULL, so
integrity_audit_message() sees a valid pointer and calls strlen() on
it, which faults:

    BUG: unable to handle page fault for address: ffffffffffffffdc
    RIP: 0010:strlen+0x30/0xa0
    Call Trace:
     audit_log_untrustedstring+0x19/0x30
     integrity_audit_message+0x366/0x4f0
     ima_inode_setxattr+0x512/0x5f0

Check for IS_ERR() and use NULL instead, which makes the audit message
skip the name= field instead of crashing.

Fixes: 4f2946aa0c45 ("IMA: introduce a new policy option func=SETXATTR_CHECK")
Cc: stable@vger.kernel.org
Reported-by: syzbot+5ebeb3089ea6439c37be@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/6a8f89e5.1d9ded08.62e62.00bf.GAE@google.com/
Signed-off-by: Bradley Morgan <brads@mainlining.org>
 security/integrity/ima/ima_appraise.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index ced2e131b061..b280488e15fc 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -748,6 +748,8 @@ static int validate_hash_algo(struct dentry *dentry,
 		return -EACCES;
 
 	path = dentry_path(dentry, pathbuf, PATH_MAX);
+	if (IS_ERR(path))
+		path = NULL;
 
 	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry), path,
 			    "set_data", errmsg, -EACCES, 0);
-- 
2.47.3

>HEAD commit:    cf72cbb39da8 Merge tag 'io_uring-7.3-20260828' of
>git://gi..
>git tree:       upstream
>console output: https://syzkaller.appspot.com/x/log.txt?x=16e7cc15580000
>kernel config:  https://syzkaller.appspot.com/x/.config?x=85bc5cc2fc7394d9
>dashboard link:
>https://syzkaller.appspot.com/bug?extid=5ebeb3089ea6439c37be
>compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
>userspace arch: i386
>syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159ebd79580000
>C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123d1d79580000
>
>Downloadable assets:
>disk image (non-bootable):
>https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-cf72cbb3.raw.xz
>vmlinux: https://storage.googleapis.com/syzbot-assets/755d053ff703/vmlinux-cf72cbb3.xz
>kernel image:
>https://storage.googleapis.com/syzbot-assets/0837738ba281/bzImage-cf72cbb3.xz
>
>IMPORTANT: if you fix the issue, please add the following tag to the commit:
>Reported-by: syzbot+5ebeb3089ea6439c37be@syzkaller.appspotmail.com
>
>BUG: unable to handle page fault for address: ffffffffffffffdc
>#PF: supervisor read access in kernel mode
>#PF: error_code(0x0000) - not-present page
>PGD eb99067 P4D eb99067 PUD eb9b067 PMD 0 
>Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>CPU: 0 UID: 0 PID: 5921 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
>Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>1.16.3-debian-1.16.3-2 04/01/2014
>RIP: 0010:strlen+0x30/0xa0 lib/string.c:402
>Code: 00 00 00 00 00 fc ff df 55 48 89 fa 48 89 fd 53 48 c1 ea 03 48 83 ec 08 0f b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 50 <80> 7d 00 00 74 3d 48 bb 00 00 00 00 00 fc ff df 48 89 e8 48 83 c0
>RSP: 0018:ffffc90002eb7920 EFLAGS: 00010246
>RAX: 0000000000000000 RBX: ffffffffffffffdc RCX: 0000000000000000
>RDX: 0000000000000004 RSI: ffffffff82081bc1 RDI: ffffffffffffffdc
>RBP: ffffffffffffffdc R08: 0000000000000004 R09: 00000000000000a9
>R10: 00000000000006c0 R11: 0000000000000001 R12: ffff888027be0e40
>R13: 0000000000000007 R14: 00000000fffffff3 R15: ffffffffffffffdc
>FS:  0000000000000000(0000) GS:ffff888096967000(0063) knlGS:000000005783f480
>CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
>CR2: ffffffffffffffdc CR3: 0000000055e55000 CR4: 0000000000352ef0
>Call Trace:
> <TASK>
> __fortify_strlen include/linux/fortify-string.h:218 [inline]
> audit_log_untrustedstring+0x19/0x30 kernel/audit.c:2203
> integrity_audit_message+0x366/0x4f0
> security/integrity/integrity_audit.c:60
> integrity_audit_msg+0x41/0x60 security/integrity/integrity_audit.c:32
> validate_hash_algo security/integrity/ima/ima_appraise.c:752 [inline]
> ima_inode_setxattr+0x512/0x5f0 security/integrity/ima/ima_appraise.c:775
> security_inode_setxattr+0x299/0x560 security/security.c:1940
> __vfs_setxattr_locked+0xad/0x2b0 fs/xattr.c:309
> vfs_setxattr+0x14a/0x390 fs/xattr.c:344
> do_setxattr+0x145/0x180 fs/xattr.c:662
> file_setxattr fs/xattr.c:672 [inline]
> file_setxattr+0x139/0x1b0 fs/xattr.c:666
> path_setxattrat+0x335/0x3b0 fs/xattr.c:732
> __do_sys_fsetxattr fs/xattr.c:782 [inline]
> __se_sys_fsetxattr fs/xattr.c:779 [inline]
> __ia32_sys_fsetxattr+0xc4/0x140 fs/xattr.c:779
> do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
> __do_fast_syscall_32+0x13a/0x8b0 arch/x86/entry/syscall_32.c:291
> do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:316
> entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>RIP: 0023:0xf7fb7fec
>Code: Unable to access opcode bytes at 0xf7fb7fc2.
>RSP: 002b:00000000fffd97bc EFLAGS: 00000296 ORIG_RAX: 00000000000000e4
>RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000080000080
>RDX: 0000000080001080 RSI: 0000000000000002 RDI: 0000000000000000
>RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> </TASK>
>Modules linked in:
>CR2: ffffffffffffffdc
>---[ end trace 0000000000000000 ]---
>RIP: 0010:strlen+0x30/0xa0 lib/string.c:402
>Code: 00 00 00 00 00 fc ff df 55 48 89 fa 48 89 fd 53 48 c1 ea 03 48 83 ec 08 0f b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 50 <80> 7d 00 00 74 3d 48 bb 00 00 00 00 00 fc ff df 48 89 e8 48 83 c0
>RSP: 0018:ffffc90002eb7920 EFLAGS: 00010246
>RAX: 0000000000000000 RBX: ffffffffffffffdc RCX: 0000000000000000
>RDX: 0000000000000004 RSI: ffffffff82081bc1 RDI: ffffffffffffffdc
>RBP: ffffffffffffffdc R08: 0000000000000004 R09: 00000000000000a9
>R10: 00000000000006c0 R11: 0000000000000001 R12: ffff888027be0e40
>R13: 0000000000000007 R14: 00000000fffffff3 R15: ffffffffffffffdc
>FS:  0000000000000000(0000) GS:ffff888096967000(0063) knlGS:000000005783f480
>CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
>CR2: 00000000f7fb8000 CR3: 0000000055e55000 CR4: 0000000000352ef0
>----------------
>Code disassembly (best guess):
>   0:	00 00                	add    %al,(%rax)
>   2:	00 00                	add    %al,(%rax)
>   4:	00 fc                	add    %bh,%ah
>   6:	ff                   	lcall  (bad)
>   7:	df 55 48             	fists  0x48(%rbp)
>   a:	89 fa                	mov    %edi,%edx
>   c:	48 89 fd             	mov    %rdi,%rbp
>   f:	53                   	push   %rbx
>  10:	48 c1 ea 03          	shr    $0x3,%rdx
>  14:	48 83 ec 08          	sub    $0x8,%rsp
>  18:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
>  1c:	48 89 fa             	mov    %rdi,%rdx
>  1f:	83 e2 07             	and    $0x7,%edx
>  22:	38 d0                	cmp    %dl,%al
>  24:	7f 04                	jg     0x2a
>  26:	84 c0                	test   %al,%al
>  28:	75 50                	jne    0x7a
>* 2a:	80 7d 00 00          	cmpb   $0x0,0x0(%rbp) <-- trapping instruction
>  2e:	74 3d                	je     0x6d
>  30:	48 bb 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbx
>  37:	fc ff df
>  3a:	48 89 e8             	mov    %rbp,%rax
>  3d:	48                   	rex.W
>  3e:	83                   	.byte 0x83
>  3f:	c0                   	.byte 0xc0
>
>
>---
>If you want syzbot to run the reproducer, reply with:
>#syz test: git://repo/address.git branch-or-commit-hash
>If you attach or paste a git patch, syzbot will apply it before testing.
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
