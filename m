Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795418154;
	b=nAHixhGhYjzbuO8H2Cyr3DkuAZETciti9GPpnSd0Jw2CTVORR9Fv6fexItwmD8Bmmbni
	 ItDFzMIP5Teh9vTpO2oLEe45k4/fEQdX96S/+gC0gnk2/VPcLKGXOHrBq7agKmg8HIAXM
	 obhZvVhxo8H3lQFOxxspSHY5JNy1pQui9rQRLRZKuYpipS0v0xO1LkMhp+Po936smkW7R
	 b9NYRAC0r+yLlycj9JWmkEgS2/GSVja6tEjdgWFlpV67d4PRP3xNfqMSQbn8XbX0jdQ1t
	 lqxqzxYqup5Z/4HpCRKQGg9OVg4DcnlWK3eUevxClik+y/5EOUgtW2yrnqj4xL1XmfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795418154;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=629g86cRTauZQlhr9Wri/E7+EASS87C5XJjWnCiTchI=;
	b=T/XJIQ9Qi60vazBx8gMBL5ZZxKdMi69ces/GJBUpmZqYrhHy0TqTTBnqPY7CZnbVnPSY
	 V5WHh0CFwNSOD+/CaYF3kxVQYDGjuQ/33aBUtFJhue046cpxT/ycQkmT0BVwoNQCdzwsB
	 6/v94Kc5QI5KnREB1RjAZFGv7c08zTISUPsmzYT+ukGxHS4kKb0Q0hAhncTMc92hzWb1R
	 HJGF/psbLq2xojFYUA4/ZxcyFwQDd5EN44E8q/1JYpGVqIt6nd0ZO/fEdtvZN74sTPZte
	 /pivTqY6nUyaIIt7GTC15VK5UjygUS3v9XKMV29yeYoqFcKwq+A2RkEuisuyvq376Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.71
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC6D606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 07:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DC6D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-84c4dce8182so3499787a34.2
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 23:15:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795418153; x=1796022953;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=629g86cRTauZQlhr9Wri/E7+EASS87C5XJjWnCiTchI=;
        b=2C8Ce5FTObrFwCk/MUkxgWMY2Tt0+2oYsC1B42kVzNDNA6ptJcO5R2DACTrRh18zEx
         Cb3XwYfJlSvxzVoTBT1R9V4Vj4ZFaotTeGDgqlbecbsVa47QyfxDYVHO3jXVpICZkgI+
         PkUC1oiGJanKqnw58nISaoMCHxiYp6zOO28fcocEJVzwwtZViWtvr64u7Z5befKJ00BU
         4xpIvJ0BF0nbGTtOtVt7UfL53wzXXlvESrL/Pb8ZrmPBN26Lx574vyhZlfBbbvhAUE+f
         327dwmrE9OJUtkdYDek9n6JCUGFuP4AeFoVJlkeIVMKw9aAKanR1Z6Hvw9I0YkubBL/G
         nR/A==
X-Forwarded-Encrypted: i=1; AL+hErGTOHvi5X59aOtB7cp+KMof4GtlpBzfjw4O3URg0mmgQLBhWWTEzdWtI+6FzbF99tbYhcJpecw=@vger.kernel.org
X-Gm-Message-State: APuU4Z94vG4SeET7hap65ahFtWRsoNqecCoEadWjFIFseYMxwxfYnpgw
	eGkQfa2meN098kIGAmu+OJdppm3ET0G70tuLqHSJU4EZoiT2yQY1IXeOgLgBgNx9hld+pMczy8f
	fuzQvmXCvvZcCMsocONwnLDJNvTd5HZFHt8luMaNlkVkpcIVJONIaAIzWG4Q=
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:198f:b0:573:7a6b:f33d with SMTP id
 5614622812f47-57a0ab2f9c8mr12792402b6e.42.1795418153219; Sun, 22 Nov 2026
 23:15:53 -0800 (PST)
Date: Sun, 22 Nov 2026 23:15:53 -0800
In-Reply-To: <20261118132710.29751-1-suruurism@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6b03e829.a481e175.27cf24.0019.GAE@google.com>
Subject: [syzbot ci] Re: ntfs3: clear VMA_MAYWRITE on read-only
 compressed-file mmap
From: syzbot ci <syzbot+cie4518cb24e7c0c99@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev, 
	stable@vger.kernel.org, suruurism@gmail.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] ntfs3: clear VMA_MAYWRITE on read-only compressed-file mmap
https://lore.kernel.org/all/20261118132710.29751-1-suruurism@gmail.com
* [PATCH] ntfs3: clear VMA_MAYWRITE on read-only compressed-file mmap

and found the following issue:
WARNING in mmap_validate

Full report is available here:
https://ci.syzbot.org/series/2cf8a8c7-bfcc-4bcc-bfda-dccd333a025d

***

WARNING in mmap_validate

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      b3f1631d362539cfe14571ccfd7db919ffbc08c7
arch:      amd64
compiler:  Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/92ccdff0-04ed-4a0e-80d7-77102143beb7/config
syz repro: https://ci.syzbot.org/findings/189d2e19-2002-455d-a0ed-c3a015048eaa/syz_repro

loop0: detected capacity change from 0 to 4096
ntfs3(loop0): Failed to load $Extend (-22).
ntfs3(loop0): Failed to initialize $Extend.
------------[ cut here ]------------
was_maywrite && !is_maywrite
WARNING: mm/vma.c:2872 at mmap_validate+0x1c3/0x1e0 mm/vma.c:2872, CPU#1: syz.0.17/5893
Modules linked in:
CPU: 1 UID: 0 PID: 5893 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:mmap_validate+0x1c3/0x1e0 mm/vma.c:2872
Code: 5c 41 5d 41 5e 41 5f 5d e9 1a 34 d8 09 cc e8 e4 8a 98 ff 90 0f 0b 90 eb 1f e8 d9 8a 98 ff 90 0f 0b 90 eb 14 e8 ce 8a 98 ff 90 <0f> 0b 90 eb 09 e8 c3 8a 98 ff 90 0f 0b 90 41 be ea ff ff ff eb bb
RSP: 0018:ffffc900041ef428 EFLAGS: 00010293
RAX: ffffffff82309662 RBX: ffffc900041ef9a0 RCX: ffff8881686c3c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000200000000001 R08: ffffc900041ef9a7 R09: 1ffff9200083df34
R10: dffffc0000000000 R11: fffff5200083df35 R12: dffffc0000000000
R13: 1ffff9200083df34 R14: 0000000000000001 R15: 0000000000000001
FS:  00007fb956e196c0(0000) GS:ffff8882a7809000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb955e71a20 CR3: 00000001baeae000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 call_mmap_prepare mm/vma.c:2975 [inline]
 __mmap_region mm/vma.c:3075 [inline]
 mmap_region+0x12d8/0x2800 mm/vma.c:3173
 do_mmap+0xe0a/0x1300 mm/mmap.c:573
 vm_mmap_pgoff+0x27a/0x520 mm/util.c:581
 ksys_mmap_pgoff+0x4dc/0x760 mm/mmap.c:619
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x16a/0x530 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb955fa8fd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb956e19028 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007fb956225fa0 RCX: 00007fb955fa8fd9
RDX: 0000000000000001 RSI: 0000000000400000 RDI: 0000200000000000
RBP: 00007fb956037fed R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000010012 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb956226038 R14: 00007fb956225fa0 R15: 00007ffcdbaed6f8
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.
