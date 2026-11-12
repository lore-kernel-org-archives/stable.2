Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794469843;
	b=zKAopXL6pozUGXcSFL4dDmPk8FSDR4HWweKJshX0sb18seHXmyf7rSE4EMA9HxyrXYRm
	 Msw1NLPwb7WuHl5cOqvVV60s7hWHIwTDETxa8XPPkMQc/HzHWUSiyW5sK94oo08HnoFqz
	 PvS9DfqPX5N+mTu9RSdQZTobUJIDA1hOmGVY5N7y/fkiUqcqMpfVn5XTrf3/1GJezaLyM
	 JS2E6PLmT8Xw0mhpZVFy15A1IB8GMqqAW1D7t73aPUMswT1wShchOhvwbvfoDqEwy+AWl
	 PECNMBOa4BRbTIU89GzTf2cXNJsyU6JK+VCoyBxdMl4u2+zkVmINNSbsCEqk8re/XlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469843;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=tjgKFT4/p+CvJU6by4XpSqkzIsRiw3CwVavlpfOjBZ4=;
	b=rfsjXg6+gaKJrN9PW1nIwi4+0fZj9g2FBSnuPmEu6rorGL9kk6TyEEXC1Vx8ZM8Ou3xe
	 55x3uROZwZqcGfjEApvZFpHNrJJPeqFybE2J9pgwehUs/+bmNqsaW6qF9dR0yPd4X5JuB
	 e/9vWck/8uO4C0iJCfFrW22M9QfJesFBI7fWyNhHfFACKHgU6kbZ/AriwlgxGgrwA3wdR
	 caBmm/Wh9aZrVjApAoxnV9BO7187XT6yNStSRWfNgZeZeWXdSCfKGqNtwbFiEG37ayiWN
	 3JLapIrPxPW5yfu7NQAlB/Sih3Keodv45Ay6bfbRCI6HhSaaZZJID+2EkadObxAs3Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D759F606A89B
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 07:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D759F606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4b26d8d2498so4603452b6e.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:50:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794469842; x=1795074642;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tjgKFT4/p+CvJU6by4XpSqkzIsRiw3CwVavlpfOjBZ4=;
        b=UMCqn6EDV/OBH8orPyRajczYe1r4eidtcom+0isGJqUtLQOXtqjepu51cZX0rwna2y
         v9xxvWJyvLQfWxrz0MqsMZxB/AqS9DcxgbdeQywp17sUl3CtHsWMoi0lXNokpVTu6sXf
         KP/WIfb9xpE/gQ4QTYp40HikvNJN25Si5kIbRaG3e+EGzxJt7iCa7oajmtf9W2pLyk2I
         0uqGGlnZRTEPRwh3wAToCM61rQ8Qi7iex1BboboYxJjNPctNR6SvHKyGKPc9KXSiODhm
         pMQgFZKYU5u++ViRO6z5dn9KwOtgDZno0W/dmFTZ2uyU59ZKua4N3AbcuUYMksy1/SzH
         KgQA==
X-Forwarded-Encrypted: i=1; AL+hErFGohPyxmdvcJs7GP7yYEVo8XilxB5BMnUt+74kqXkMhHTNA+iczKUtOEP0heaoyjZ54SUv9Dk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YRncOV+lChWQ7fu9LfchiW9+iiKiOh0m+Wd9E+sLDMvCCu4Ry
	sE9ON7E9uRfZekPmPrOYCzVE40dUD07ykTtJbO94mV+Ptj97RLm3S5dHG+BHogQJxzI3rBg4TqF
	GyWZTekF5nuVckqfa7EEC8SjUMJ2DnFRG6OnqJ4cydHiaU2NP1EcXDLTDcIg=
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6809:24a:10b0:56b:220d:cc5d with SMTP id
 5614622812f47-56b961943b0mr3349644b6e.10.1794469841906; Wed, 11 Nov 2026
 23:50:41 -0800 (PST)
Date: Wed, 11 Nov 2026 23:50:41 -0800
In-Reply-To: <6af3562b.17ff5aea.1b027f.0196.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af56fd1.7afbdece.117ea2.0026.GAE@google.com>
Subject: Re: [syzbot] [dm?] WARNING in integrity_commit
From: syzbot <syzbot+94dac3c75477e184f0b0@syzkaller.appspotmail.com>
To: agk@redhat.com, bmarzins@redhat.com, dm-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, mpatocka@redhat.com, sashiko-bot@kernel.org, 
	snitzer@kernel.org, stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    79eb6679ef6a Merge tag 'loongarch-fixes-7.4-1' of git://gi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1249a44d580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1cf189394a856f11
dashboard link: https://syzkaller.appspot.com/bug?extid=94dac3c75477e184f0b0
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12adb1a1580000

AI-generated root cause summary:
In drivers/md/dm-integrity.c, journal accounting variables (including
ic->free_sectors, ic->free_section, and section counts) are initialized
exclusively within replay_journal() rather than during target allocation in
dm_integrity_ctr(). When a dm-integrity target configured in journal mode ('J')
is resumed, dm_integrity_resume() checks whether the on-disk superblock was
modified while suspended; if superblock_changed() evaluates to true, it logs an
error and jumps to skip_writes, completely bypassing replay_journal(). When the
device is subsequently suspended or receives a flush bio, integrity_commit() is
scheduled and calls pad_uncommitted(), which validates that total journal
sections match the sum of uncommitted, committed, and free sectors; because
replay_journal() was skipped, these counters remain zero, causing the invariant
check to fail and trigger the WARN_ON.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=94dac3c75477e184f0b0

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+94dac3c75477e184f0b0@syzkaller.appspotmail.com

------------[ cut here ]------------
ic->journal_sections * ic->journal_section_entries != (ic->n_uncommitted_sections + ic->n_committed_sections) * ic->journal_section_entries + ic->free_sectors
WARNING: drivers/md/dm-integrity.c:2885 at pad_uncommitted drivers/md/dm-integrity.c:2885 [inline], CPU#1: kworker/1:2/1043
WARNING: drivers/md/dm-integrity.c:2885 at integrity_commit.cold+0x6/0x75 drivers/md/dm-integrity.c:2917, CPU#1: kworker/1:2/1043
Modules linked in:
CPU: 1 UID: 0 PID: 1043 Comm: kworker/1:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: dm-integrity-commit integrity_commit
RIP: 0010:pad_uncommitted drivers/md/dm-integrity.c:2885 [inline]
RIP: 0010:integrity_commit.cold+0x6/0x75 drivers/md/dm-integrity.c:2917
Code: ff e9 9d 9d 63 07 48 8b 7c 24 58 e8 11 a2 23 01 e9 e7 fe ff ff 48 8b 7c 24 40 e8 02 a2 23 01 e9 21 ff ff ff e8 88 48 a9 00 90 <0f> 0b 90 41 54 8b 8c 24 d0 00 00 00 89 da 44 89 f6 41 89 d9 45 89
RSP: 0018:ffffc90005497a68 EFLAGS: 00010093
RAX: 0000000000000000 RBX: 0000000000000050 RCX: 0000000000000001
RDX: ffff88802aa08000 RSI: ffffffff81653878 RDI: 0000000000000004
RBP: 0000000000000050 R08: 0000000000000050 R09: 0000000000000000
R10: 0000000000000003 R11: 000000000000776b R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 1ffff92000a92f6a
FS:  0000000000000000(0000) GS:ffff8880d4573000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8bc17ba008 CR3: 000000005652c000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3495
 process_scheduled_works kernel/workqueue.c:3578 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3659
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
