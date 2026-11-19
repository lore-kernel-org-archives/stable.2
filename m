Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071601;
	b=URW/7DwJDPxHfzHp4NK3Z1JJm/z+vxBw5i73gGVQfwMlZVfvVUzUK4CjZV2XfCsHuaUR
	 Bldk/+Hv8A1fx7wEG/uulJ4znibhp7H39FklI20TPmjWpKiboB4i0I+8CSvaaRYnUlWBV
	 oSAk9ECSrx34W41qdnregTsoRkNz0fcJyPuXRRqixl92fqxisSvC9K5lQSJgtOYOt292x
	 RT3lRyA0g5ZzpHbTFQHo/AOawtxaPg1KEfsUcMF0eGHDKJ6NUxYwJOTdbISKl6OrEUPoZ
	 JWUTcPpyrVMjhZYQe3PQQCXR/GSAV2+77JSVQKvPZY7T7I2bE7jGmfbMbjOJzjhKtAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071601;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=N5eSPNBlwV7KKPmI6DqqlrxRRkqVZeqqeoXHkxOFY4E=;
	b=29CKMQFXLND0dQnqHNzUN/NHHUjo5bpf8K8Cc9OTtCq4PzI0XaD4WhIGWeRfEjLsXnE8
	 xbm1ujJ/9Gdv/GRaf2MmiBfKVsSSDl3pplTojVqGrEGJc6m4fna5wUCmA8j36YCGyl3lo
	 RGGXCLaz+b+vYep8eszSUq4Yd43XX2TUM1DeJQy+SM+kV2rl3+0IheUCB+Tqitvp0gPSS
	 qjK3CTPUeRfbLJIOE0ajvOCZ/zFBaTGvzdZCFi3+vcOpWixHefGGXrITrYMUAxhjqNwLG
	 tvE+sPkrYgm+M2lJc62jz+EXsbEjEFkk5QBlJxPN3jG8nqZGtFLxcxp8ZEucO/cwUNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245B1606A332
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 07:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 245B1606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4b26d8d2498so2023479b6e.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 23:00:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795071600; x=1795676400;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N5eSPNBlwV7KKPmI6DqqlrxRRkqVZeqqeoXHkxOFY4E=;
        b=nVSO5lrpRxopMa+MAs84BWdFKW1U5WDQsHvbHCNUqgUoGUD0BlX2M6jwk6p2nPXq9q
         ClOENU83M1zHwm0ifpPbeDu9uJqkIJRhQdQ3GYTUuCnLzp5najiJ9uWVnTUgR/dOGjYZ
         KDnICWE+8or9ockpyz2Ujn5YppoPBv7hCWXwcsCtQ/j0QgGkgrrQ3XQrR5p+1fL77UZr
         rt0IqkZjU32U7bXEoxgvFkeMqW3NAFn+f8qgsit7D4a6UgKNwmFqy/7cbjF0OHp3rWw1
         rQ/3L930QOyQ9iFDERwqljZ9sfdijvBiZAiPrG9rh6IonjrYFHP1ofCh2mLenSgWsowW
         z/ZA==
X-Forwarded-Encrypted: i=1; AL+hErE8rzJtHVm8b8UFIo5ulTsmViljaPfjIPT1HU9i3lgSSmbYPKnTpi0zoqbTnwuzD0m9lq946hQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9R7iKwB9Hqm3rOBGtBFFhq1TZnKtoTdW3v1w+PCF6TlHjFFytc
	aU3m9gxeOXgYDXIMqDgFJojq8dJzFl/g+EuiSPzUrZJ7rcy/gMRRjdwtNwhVEQAVM5GbMi4ANkG
	KFQPjXMm1nnpc03KDYOhWfSugNAIKZFFkti5G1Mq5vM90ZQ50EF8fouAoXjc=
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1992:b0:567:bfc4:c94f with SMTP id
 5614622812f47-577422121bdmr6168455b6e.67.1795071600207; Wed, 18 Nov 2026
 23:00:00 -0800 (PST)
Date: Wed, 18 Nov 2026 23:00:00 -0800
In-Reply-To: <20261115121722.206-1-enscrpt@pm.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6afe9e70.902182b0.170f33.0005.GAE@google.com>
Subject: [syzbot ci] Re: keys: serialise instantiation against keyctl_chown_key
From: syzbot ci <syzbot+ci69a2f6975b022dfa@syzkaller.appspotmail.com>
To: dhowells@redhat.com, enscrpt@pm.me, jarkko@kernel.org, jmorris@namei.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	stable@vger.kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] keys: serialise instantiation against keyctl_chown_key
https://lore.kernel.org/all/20261115121722.206-1-enscrpt@pm.me
* [PATCH] keys: serialise instantiation against keyctl_chown_key

and found the following issue:
possible deadlock in key_move

Full report is available here:
https://ci.syzbot.org/series/51455b74-3344-42d0-9ba7-b64be2ff0b40

***

possible deadlock in key_move

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
arch:      amd64
compiler:  Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/309e9321-2f31-411e-ac93-724f183b5510/config
syz repro: https://ci.syzbot.org/findings/89658ad2-f692-4500-bd4e-ef9d90dc18e5/syz_repro

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.17/5852 is trying to acquire lock:
ffffffff908c1a40 (keyring_serialise_link_lock){+.+.}-{4:4}, at: __key_move_lock security/keys/keyring.c:1305 [inline]
ffffffff908c1a40 (keyring_serialise_link_lock){+.+.}-{4:4}, at: key_move+0x1d3/0x7b0 security/keys/keyring.c:1634

but task is already holding lock:
ffff888104aa1290 (&type->lock_class/1){+.+.}-{4:4}, at: __key_move_lock security/keys/keyring.c:-1 [inline]
ffff888104aa1290 (&type->lock_class/1){+.+.}-{4:4}, at: key_move+0x16a/0x7b0 security/keys/keyring.c:1634

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&type->lock_class/1){+.+.}-{4:4}:
       down_write_nested+0x98/0x200 kernel/locking/rwsem.c:1757
       __key_instantiate_and_link+0x9d/0x4d0 security/keys/key.c:451
       key_instantiate_and_link+0x331/0x4b0 security/keys/key.c:549
       keyring_alloc+0x6f/0xb0 security/keys/keyring.c:541
       system_trusted_keyring_init+0x67/0x120 certs/system_keyring.c:231
       do_one_initcall+0x250/0x870 init/main.c:1419
       do_initcall_level+0x10a/0x1a0 init/main.c:1481
       do_initcalls+0x59/0xa0 init/main.c:1497
       kernel_init_freeable+0x29d/0x3e0 init/main.c:1732
       kernel_init+0x22/0x1d0 init/main.c:1622
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (key_construction_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       __key_instantiate_and_link+0x8f/0x4d0 security/keys/key.c:443
       key_instantiate_and_link+0x466/0x4b0 security/keys/key.c:549
       keyring_alloc+0x6f/0xb0 security/keys/keyring.c:541
       look_up_user_keyrings+0x376/0x670 security/keys/process_keys.c:116
       do_one_initcall+0x250/0x870 init/main.c:1419
       do_initcall_level+0x10a/0x1a0 init/main.c:1481
       do_initcalls+0x59/0xa0 init/main.c:1497
       kernel_init_freeable+0x29d/0x3e0 init/main.c:1732
       kernel_init+0x22/0x1d0 init/main.c:1622
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (keyring_serialise_link_lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3209 [inline]
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       __key_move_lock security/keys/keyring.c:1305 [inline]
       key_move+0x1d3/0x7b0 security/keys/keyring.c:1634
       keyctl_keyring_move+0xd6/0x110 security/keys/keyctl.c:618
       __do_sys_keyctl security/keys/keyctl.c:2023 [inline]
       __se_sys_keyctl+0x85a/0xbc0 security/keys/keyctl.c:1885
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  keyring_serialise_link_lock --> key_construction_mutex --> &type->lock_class/1

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&type->lock_class/1);
                               lock(key_construction_mutex);
                               lock(&type->lock_class/1);
  lock(keyring_serialise_link_lock);

 *** DEADLOCK ***

locks held by syz.0.17/5852: 2, on CPU#0:
 #0: ffff888104aa1090 (&type->lock_class#2){+.+.}-{4:4}, at: __key_move_lock security/keys/keyring.c:-1 [inline]
 #0: ffff888104aa1090 (&type->lock_class#2){+.+.}-{4:4}, at: key_move+0x159/0x7b0 security/keys/keyring.c:1634
 #1: ffff888104aa1290 (&type->lock_class/1){+.+.}-{4:4}, at: __key_move_lock security/keys/keyring.c:-1 [inline]
 #1: ffff888104aa1290 (&type->lock_class/1){+.+.}-{4:4}, at: key_move+0x16a/0x7b0 security/keys/keyring.c:1634

stack backtrace:
CPU: 0 UID: 0 PID: 5852 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2087
 check_noncircular+0x12f/0x150 kernel/locking/lockdep.c:2219
 check_prev_add kernel/locking/lockdep.c:3209 [inline]
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
 __key_move_lock security/keys/keyring.c:1305 [inline]
 key_move+0x1d3/0x7b0 security/keys/keyring.c:1634
 keyctl_keyring_move+0xd6/0x110 security/keys/keyctl.c:618
 __do_sys_keyctl security/keys/keyctl.c:2023 [inline]
 __se_sys_keyctl+0x85a/0xbc0 security/keys/keyctl.c:1885
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f417a9a8fd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f417b7c9028 EFLAGS: 00000246 ORIG_RAX: 00000000000000fa
RAX: ffffffffffffffda RBX: 00007f417ac25fa0 RCX: 00007f417a9a8fd9
RDX: fffffffffffffffe RSI: 00000000326b97d4 RDI: 000000000000001e
RBP: 00007f417aa37fed R08: 0000000000000000 R09: 0000000000000000
R10: 00000000326b97d4 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f417ac26038 R14: 00007f417ac25fa0 R15: 00007ffc44b5b118
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.
