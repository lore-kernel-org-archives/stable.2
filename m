Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EC11A262A
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787916449; cv=none; b=BO0wCcdCI8hp10lmJpyFl+o29dE2N7eZH/0AEf3kJCLYLlUeojgowAC4SNF65/bu4TLYKSOuySyB0LAGgw7SxFTUHCZ+Pv+oPLBrGkMJvH3HPMbkFGyOgB7wd/rS6c6vdREFvDT49qbMjkaRAd/eCPtHKPcno4E9L/okNo9y9bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787916449; c=relaxed/simple;
	bh=5xtlgA5vHCXpabX1E6ApXm9OLw17V/cAeGETIc9pLmU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WD+IxN7OtQD4Zsd2eFobbZpuOMebqplztv4zf8wEYtsRUNTYgc+F32fXJ9VARAwN3GTDqn+CgCUVQxn5RbpnAQpeL+pxrmYit+7Qd0RZhQsVjLOALqvU87xJ/8VqTS+WKxRPIlYxFb1CEsxrz72IXryHwtrUKa95KDNX/8y0FQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4ab4f652f9bso525930b6e.0
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 04:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787916447; x=1788521247;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AkRz50F5kxQk8r1w8lTDqf7Ji8sdF1ZuHE2PMMhiBaA=;
        b=PWmzkX0D8CFzco6fNGC93lJGhpVD/xw4JGzF8P7ncHwyhITdAXiP9yybFacoAZADPL
         N+wHJouEHhYLHluvUls+WGcKPM2JrmLryW2keyN+Jyj/v+ts2yV6UTpJRw1DGN+flA8J
         zVBkHkYUFSnOETc2C0WCtK7EYAVlg+fN7Ok/0ETk1h8mL9KCvdakSYng3MJYAaLBSeDV
         BgMjD4VB3gq+5mLnHNho0b+YmtAOzYXj+NkK82ptELV3/2Dk19bi1lRsZ+yBc9T24+Pv
         WPS2c2Lsia9QhOFqrkXMINops+/gtbSO/tJ/VkQ20CSOllGbmhi7pAlpasqchpN2WG83
         FzmQ==
X-Forwarded-Encrypted: i=1; AHgh+RrOUKefsSUA7AE+1euwg5LHU/01jHyUO6N2nRNE0ZllnqDrbeYShrbS8KUNh98vdwZN5Qk6eL0=@vger.kernel.org
X-Gm-Message-State: AFuF++nFwZIZviCqMYDPlEEvLtfbg/DHa+kMsDEqDbiFJDzSAYISCZOy
	jmaqBGR+kqEcbw9f0InSA7wU9f6uMsNQreqmYpwHCV0gijUdGdfjkyXaQnECaZqGOEA6SxiwK5J
	tRmfcKOxWEyRQhefHCxdmQa71gZcIlHQ9c81DGgabpm+Db82Lu7S6glnLNAI=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f0b:b0:4ab:318c:6b38 with SMTP id
 5614622812f47-4b397f71712mr6006346b6e.1.1787916447328; Fri, 28 Aug 2026
 04:27:27 -0700 (PDT)
Date: Fri, 28 Aug 2026 04:27:27 -0700
In-Reply-To: <6a8c13ee.91706f20.16b6e3.02d5.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a91709f.4d659fcc.734b4.001c.GAE@google.com>
Subject: Re: [syzbot] [fs?] [trace?] WARNING in eventfs_create_events_dir
From: syzbot <syzbot+3ef80b4ed02226d04a06@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, kartikey406@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	rostedt@kernel.org, sh_def@163.com, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, vdonnefort@google.com, vulab@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    818bebeb63dd drm/xe: Don't hand out the flat CCS storage a..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16eddd49580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccca94d2c01b9e78
dashboard link: https://syzkaller.appspot.com/bug?extid=3ef80b4ed02226d04a06
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17986d79580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ef80b4ed02226d04a06@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000202 R12: 00007fae2ca35a9f
R13: 00007fae2ca35adb R14: 00007fae2ca5ccc0 R15: 0000000000000002
 </TASK>
------------[ cut here ]------------
!list_empty(&ei->children)
WARNING: fs/tracefs/event_inode.c:128 at free_ei fs/tracefs/event_inode.c:128 [inline], CPU#0: syz-executor340/6037
WARNING: fs/tracefs/event_inode.c:128 at cleanup_ei fs/tracefs/event_inode.c:150 [inline], CPU#0: syz-executor340/6037
WARNING: fs/tracefs/event_inode.c:128 at cleanup_ei fs/tracefs/event_inode.c:145 [inline], CPU#0: syz-executor340/6037
WARNING: fs/tracefs/event_inode.c:128 at eventfs_create_events_dir+0xa3d/0xbe0 fs/tracefs/event_inode.c:838, CPU#0: syz-executor340/6037
Modules linked in:
CPU: 0 UID: 0 PID: 6037 Comm: syz-executor340 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:free_ei fs/tracefs/event_inode.c:128 [inline]
RIP: 0010:cleanup_ei fs/tracefs/event_inode.c:150 [inline]
RIP: 0010:cleanup_ei fs/tracefs/event_inode.c:145 [inline]
RIP: 0010:eventfs_create_events_dir+0xa3d/0xbe0 fs/tracefs/event_inode.c:838
Code: 00 e8 e7 82 fa 00 e9 ab fb ff ff e8 1d 4e e1 fd 48 8b 7c 24 10 be 03 00 00 00 e8 ce 82 fa 00 e9 c2 fd ff ff e8 04 4e e1 fd 90 <0f> 0b 90 e9 59 fe ff ff e8 e6 21 54 fe e9 4b f7 ff ff 48 89 44 24
RSP: 0018:ffffc90005867b88 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888045883028 RCX: 0000000000000000
RDX: ffff88802ecd2580 RSI: ffffffff8429b3cc RDI: ffffffff8e69c920
RBP: ffff888030052f10 R08: 00000000ffffffff R09: fffffbfff1dff612
R10: ffffffff8effb093 R11: 0000000000000001 R12: ffff888030052f50
R13: 0000000000000003 R14: ffff888030052f4c R15: ffff888030052f00
FS:  000055555739d400(0000) GS:ffff8880d5ba2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c8902f3204 CR3: 0000000022b49000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 create_event_toplevel_files+0x12d/0x1a0 kernel/trace/trace_events.c:4709
 event_trace_add_tracer+0x72/0x260 kernel/trace/trace_events.c:4740
 trace_array_create_dir+0x8e/0x210 kernel/trace/trace.c:8550
 trace_array_create_systems+0x8b3/0xc30 kernel/trace/trace.c:8641
 trace_array_create kernel/trace/trace.c:8668 [inline]
 instance_mkdir+0xca/0x140 kernel/trace/trace.c:8683
 tracefs_syscall_mkdir+0x10e/0x180 fs/tracefs/inode.c:121
 vfs_mkdir+0x364/0x850 fs/namei.c:5410
 filename_mkdirat+0x48b/0x5e0 fs/namei.c:5443
 __do_sys_mkdir fs/namei.c:5470 [inline]
 __se_sys_mkdir fs/namei.c:5467 [inline]
 __x64_sys_mkdir+0x6b/0x90 fs/namei.c:5467
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fae2c9d8ec7
Code: 77 01 c3 48 c7 c2 d8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 53 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 d8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffcc38a20c8 EFLAGS: 00000202 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007fae2c9d8ec7
RDX: 0000000000000000 RSI: 00000000000001ed RDI: 00007ffcc38a2160
RBP: 00007ffcc38a2160 R08: 0000000000000001 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000202 R12: 00007fae2ca35a9f
R13: 00007fae2ca35adb R14: 00007fae2ca5ccc0 R15: 0000000000000002
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
