Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687491;
	b=d8r4qjzzZqxEO6xKtecW1Z1sYk+7aVUlmEar5SDwpG9JwgKk2VM8kTn5Jr1vdjnRwzbk
	 NVw1AOW4uO6ZXgyOxwuhxfSnU8Pjjb6uxajn7GdxYOtc8Xloe+5TwuCnNl2Z9cZVPBTsq
	 CanuuVM5y9Iv8px/Umd3oBwe3K2XrA8RnNWlil3sHVQ9civHOGr9I6kAKDfIb6cloq0fL
	 nRaX7GHnIjAJ8FvnRWjqwmSZC4hKBFBAh3GOyqTWgkUqDg5jaWS2Wb03J2ne+tfA1W8aE
	 pe9NpQvX+A8GOyHWFaZrHtMn+ssFuYqisQqSFAMGfn6yPRn6QUeh6mCk7kafpsLE6PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687491;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=vkgH7/1CsUWpFerkD8pe7z4GSs6lcDLx7Deh/tAsIzI=;
	b=vfwzcHWYRBk5T34k3oWSb0B51VzfZ0+gEUkPpI/lhxsPwWBJtYSH7hbRqNWJIqdC+2a0
	 fZHimDWM1wJFrEYvg4vxKQ2Z4NVcIqaZT7Nbyvm4BU/syU6EjBbBmKNGrYWcX78Nsy15g
	 bKeqEJV+yO1kqFFTxzV7Qw7oJv6jU/kgD0e0HsI7S3zZNbB6DowuAYjQQfzvjABFqzif5
	 kuuTFjPEeTM0YwIDe7WjMkdkNgZVGiUXmGU6SM1JqOhgCgodhmbkwE1fiOZWZLTkccLtQ
	 rtq9bPeDe5uvTWhAhubyxPuK1bBehmCiPxq2gToFtK+4xrvGuXWLaBl08YMK1T52Zwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.71
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8F3606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 16:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F8F3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-8468290b866so2945834a34.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792687490; x=1793292290;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vkgH7/1CsUWpFerkD8pe7z4GSs6lcDLx7Deh/tAsIzI=;
        b=KBgbzks/5DtSNDBXJYnoZ4acjkDGXfJ3x721R347vocIxZKF9A0jkvZuNu6njlTlCc
         wEqg+k7s871fkMj2k922QoeZ/0Yvu9ii/+7ISGsJhFQomf9XOdBXTWpR0iflyYxhLv7i
         6CiPe/eObDprJYqWur3UXkY3P9Kjh3Pou/Yxu3UZQycxG5cI5f9/CpEjlUR4Owv7FmN2
         W4i0jBpTMmV2N/Y+ZAtUH1Lyk4K8DTyjhhqc1t/Vt7FH1yXH87pdIUTE9xAZH5MkN+Bl
         se2uhflkXbO9v4WTP7OnmDdVt9Plo+2K8QZe4r/BOYJi/0tAUCG/8xcgzk21RMMR7c0s
         y3jA==
X-Forwarded-Encrypted: i=1; AKwUvBxOOgm0oobCAMvlVBQFy/9aEni6nr1vp/bz1vZoD24Voe0CwpyHU0HJFWqClSU4c1LGuXInupE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKCDBoJZh3yMN1gY5Z9nSRM49GC4JVkBB2zTWVmPA2updJ50vx
	gFNmbqdNUxwERVywuGBl+b22qJr9MgmR5yzlUQ9xBPmtDH5b6A4IAOEMbbcX0yMiJktbWm+gMa7
	LGOvJxJ/8xS5zM0YENs4golqeYrUWtMQcitvf7GCTDS9U3E5iWOzVvECD9w8=
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:150a:b0:52b:7641:33a6 with SMTP id
 5614622812f47-5535a66d1d5mr4259216b6e.14.1792687490640; Thu, 22 Oct 2026
 09:44:50 -0700 (PDT)
Date: Thu, 22 Oct 2026 09:44:50 -0700
In-Reply-To: <6aa9c7f8.a211d2ce.1a5198.02b5.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ada3d82.d1c214cc.659fa.00db.GAE@google.com>
Subject: Re: [syzbot] [netfilter?] WARNING in nf_flow_table_extend_ct_timeout
From: syzbot <syzbot+521f7e7e2b974abde99a@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	edumazet@kernel.org, fw@strlen.de, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, mike.michalo@gmail.com, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	phil@nwl.cc, stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    abeacca61eea Merge branch 'net-mlx5-hws-fix-modify-header-..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=111f4d0d580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4b098695335c89f
dashboard link: https://syzkaller.appspot.com/bug?extid=521f7e7e2b974abde99a
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1491e029580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=157d410d580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/22930d0e9391/disk-abeacca6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d2e18d51f288/vmlinux-abeacca6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69879bb16225/bzImage-abeacca6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+521f7e7e2b974abde99a@syzkaller.appspotmail.com

------------[ cut here ]------------
1
WARNING: net/netfilter/nf_flow_table_core.c:553 at nf_flow_table_extend_ct_timeout+0x1ee/0x2f0 net/netfilter/nf_flow_table_core.c:553, CPU#1: kworker/1:2/123
Modules linked in:
CPU: 1 UID: 0 PID: 123 Comm: kworker/1:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/07/2026
Workqueue: events_power_efficient nf_flow_offload_work_gc
RIP: 0010:nf_flow_table_extend_ct_timeout+0x1ee/0x2f0 net/netfilter/nf_flow_table_core.c:553
Code: 00 00 00 41 83 ff 06 0f 84 9a 00 00 00 41 83 ff 05 0f 85 b0 00 00 00 e8 e0 10 a9 f7 41 bf 30 75 00 00 eb 0f e8 d3 10 a9 f7 90 <0f> 0b 90 41 bf 01 00 00 00 48 c7 c0 80 f2 a0 8f 48 c1 e8 03 42 80
RSP: 0018:ffffc90002dcf930 EFLAGS: 00010293
RAX: ffffffff8a1effad RBX: ffff888027a52900 RCX: ffff88801ffa1f40
RDX: 0000000000000000 RSI: ffffffff912fa640 RDI: 000000000000002f
RBP: 0000000000000737 R08: ffff88801ffa1f40 R09: 0000000000000002
R10: 0000000000000011 R11: 0000000000000000 R12: dffffc0000000000
R13: 1ffff11004f4a538 R14: ffff888027a52948 R15: 000000000000002f
FS:  0000000000000000(0000) GS:ffff888123bbd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f926bd5bd3c CR3: 000000000fb48000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 nf_flow_offload_gc_step+0x5aa/0x840 net/netfilter/nf_flow_table_core.c:593
 nf_flow_table_iterate+0x13c/0x1f0 net/netfilter/nf_flow_table_core.c:459
 nf_flow_table_gc_run net/netfilter/nf_flow_table_core.c:616 [inline]
 nf_flow_offload_work_gc+0x22/0x70 net/netfilter/nf_flow_table_core.c:624
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
