Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134E7395AEE
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194557; cv=none; b=OtkLHLCj+f95Ctf26nizYwQhtKZH+CWLyLIdgKIGpmBq+UUmQohaZf06hNgv7HJgBdLEzz+WscuQvqh5Pe3Bg0H6hgD3b8krkBss9vUu+Xc11E+qiGdFmsHoOttiKcPKkkDdUsgX/IWQyiFYriCsyRcY28kX6pWKkiai0rfcBoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194557; c=relaxed/simple;
	bh=cx2qflHw6C4M4RY90ItuEe017sHOEZ5NnTaU/Zxi+us=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=HyUy9BzZH28b1keBDAHk4CN2ZZPVzfFsbY0HUfWpown67fbutdkY2fSZgxJn4JqYu+Y+q9P2GHdsIXCOxKEjXk5omEPrg3GUQWi4nC/6skWbQ052V6YzdOooFS9yU/dX6k0nT1rKPcnJD2FxUrGxK7eK8xmgMIuxjruJoRgXNyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0532a6588so249925ad.0
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 09:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781194555; x=1781799355;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0lM2grzrB5nVp/LDdwf5++oZa/eGINgQ46KeI9aLB8w=;
        b=LIhZGq4+QaZwTqvW0FkvxkpXYahByoA0mTaCvAwSMrqWM4vP2cwmPYQ+HS7wAxQhBI
         8mAFGRN7ryxz1xKq1fz6r1w0ZOfLFV7VUMH6qxNiEmCD0ScXGc+VqPWi2gZ8osJsawpH
         xqEgscmjpH38WnyUj4ZeV1NKTBaoQULRsOmI3PjRAGabMwaa1OXWNLEMg2OjRjcUrtLB
         9Z7+R0YfXgpOxXyvGfUi5QwSxluf2c53AgmlG0AYlL4XhSPS1UD0z7LqJCSZ106HG3bQ
         b49zwkZ5hEh6YAVpriV2Igxo2N853z1kurn02T7p6iaZoYWn506971GitX5dmxJ/k//C
         37HQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7vnz/5IbYbRM/qKfXgWtBZKGQsBJeNyBu7LxdSlD2DJmgIueAYkDbpkJ/misU0Nd2LYZnAj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGAxKuOGVPtsCfUa6rYdWDGJ4C4fr913CKM9yBhZX5CcF131j5
	Pe5WxYJ3MpeaMrCAcWOm5BMIOzVq8E20a/2RChGJ01f8IqBaPhPtdyK5KsFUAOOrA2mlj5oSyp/
	uTHv90+VN7hu3MVwI6amlN8SX3meRdTgSw28FkMIoDkBicM7Dv8x9c8jg6Jc=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:1112:b0:2c0:c14c:bf38 with SMTP id
 d9443c01a7336-2c2f229cf4dmr41104675ad.24.1781194555490; Thu, 11 Jun 2026
 09:15:55 -0700 (PDT)
Date: Thu, 11 Jun 2026 09:15:55 -0700
In-Reply-To: <20260610214523.2905255-2-clopez@suse.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a2adf3b.3b0a2d4e.8c8d1.0012.GAE@google.com>
Subject: [syzbot ci] Re: KVM: x86: Unconditionally recompute CR8 intercept on
 PPR update
From: syzbot ci <syzbot+ci493c6d734b63e050@syzkaller.appspotmail.com>
To: bp@alien8.de, clopez@suse.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	osteffen@redhat.com, pbonzini@redhat.com, rkagan@virtuozzo.com, 
	seanjc@google.com, sgarzare@redhat.com, stable@vger.kernel.org, 
	tglx@kernel.org, x86@kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v2] KVM: x86: Unconditionally recompute CR8 intercept on PPR update
https://lore.kernel.org/all/20260610214523.2905255-2-clopez@suse.de
* [PATCH v2] KVM: x86: Unconditionally recompute CR8 intercept on PPR update

and found the following issue:
WARNING in vmx_update_cr8_intercept

Full report is available here:
https://ci.syzbot.org/series/d94aebb2-8082-4777-ab08-5c3a0d680bed

***

WARNING in vmx_update_cr8_intercept

tree:      linux-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
base:      c1f7303302927f9cbf4efedf70f0512cde168c65
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/8f417377-50a6-450a-8ce0-a83de33b8c6d/config
syz repro: https://ci.syzbot.org/findings/62a660e6-a9b1-42ca-9cf0-7aadd2f5d292/syz_repro

------------[ cut here ]------------
debug_locks && !(lock_is_held(&(&vcpu->mutex)->dep_map) || !refcount_read(&vcpu->kvm->users_count))
WARNING: arch/x86/kvm/vmx/nested.h:61 at get_vmcs12 arch/x86/kvm/vmx/nested.h:60 [inline], CPU#0: syz.2.19/5879
WARNING: arch/x86/kvm/vmx/nested.h:61 at vmx_update_cr8_intercept+0x3de/0x4e0 arch/x86/kvm/vmx/vmx.c:6879, CPU#0: syz.2.19/5879
Modules linked in:
CPU: 0 UID: 0 PID: 5879 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:get_vmcs12 arch/x86/kvm/vmx/nested.h:60 [inline]
RIP: 0010:vmx_update_cr8_intercept+0x3de/0x4e0 arch/x86/kvm/vmx/vmx.c:6879
Code: 0b 90 e9 f1 fe ff ff e8 30 12 69 00 90 0f 0b 90 e9 59 fe ff ff e8 22 12 69 00 e8 ad 86 d6 ff e9 ca fe ff ff e8 13 12 69 00 90 <0f> 0b 90 e9 fc fc ff ff e8 05 12 69 00 e8 90 86 d6 ff eb a7 48 c7
RSP: 0018:ffffc9000271f758 EFLAGS: 00010293
RAX: ffffffff815d048d RBX: ffff888113380000 RCX: ffff8881142b8000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 00000000ffffffff R08: ffff8881114d9703 R09: 1ffff1102229b2e0
R10: dffffc0000000000 R11: ffffed102229b2e1 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff888116d0bca0 R15: 0000000000000001
FS:  00007ff34d6b86c0(0000) GS:ffff88818dc9b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc75e78ae8 CR3: 000000010c609000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 apic_update_ppr arch/x86/kvm/lapic.c:984 [inline]
 kvm_lapic_reset+0x1c24/0x2980 arch/x86/kvm/lapic.c:3023
 kvm_vcpu_reset+0x44c/0x1bf0 arch/x86/kvm/x86.c:12986
 kvm_arch_vcpu_create+0x746/0x8b0 arch/x86/kvm/x86.c:12847
 kvm_vm_ioctl_create_vcpu+0x428/0x930 virt/kvm/kvm_main.c:4201
 kvm_vm_ioctl+0x893/0xd50 virt/kvm/kvm_main.c:5159
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff34c79ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff34d6b8028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff34ca15fa0 RCX: 00007ff34c79ce59
RDX: 0000000000000002 RSI: 000000000000ae41 RDI: 0000000000000004
RBP: 00007ff34c832d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff34ca16038 R14: 00007ff34ca15fa0 R15: 00007ffe4bc28aa8
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.
