Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAD2370D4D;
	Tue, 30 Jun 2026 02:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782786792; cv=none; b=RevvudmqUvNSdRiMp7S1mDVo6hxHD5bbSl/y838Sran+XH7o7yMPhIbiybNH0PqnIlEExO2XZx3EWalP/2rfDlvUCYQWzQqbS0ysICgra4Ai+A0RMtvM3l/E8ld3WUTFQRCv/MtPyUDyNFhY5tIgeWlQN7/zTBSWl+4MMWe3oyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782786792; c=relaxed/simple;
	bh=kbVkmjzqwDMw7kAF3lk4g/gPYQIfYdBY5tbr4q2WdqA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SkgqnNmlQr9KuURkcnRHIx1BK4h0tANlvsW6noInHn+DZTC2SHn3n8aF0HZuu1JsXc2p/qEQkLYuYu03tBM30vAdpZMflz/Rtycu/FbhOdWTS/ugfuBd7aIgk/AkupK+gVe7PPnrna7uk/sFaGJu+g9sFXgzr9yTHmBNHlwW4zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=p0VlruP2; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="p0VlruP2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1782786790; x=1814322790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TKsFUV5qp+XrHBCgRXq67HsSENb74BgjsA7rBf0zMvE=;
  b=p0VlruP2orR148nC+C8ERRXcPIpasCUhVGf2OmrJ5/r1PCCrGCkb/sMD
   sH79ljuW9JJZxrR1LsTJ8VHOSr141NKTFK1BPU6oEcwfpj96qj6E0H6/1
   j7OuOadf3PO684M+wsFW5D2C7/q01JqcpvANv0I0fahmpxPAiGkJ0iMcg
   NwaAki5xFM7tZb+FVo3PMdSjDpAsGYzyvm+Im6iOjQnJsPPYn5SQfaLxv
   2hhiXep5Ql4gJQm3ByvkRnkLK0q8axBZSSSU6PhkWGd4jbeFXO0pgbhkF
   FcJks/2Ox0S93xfWw/fbxUIYq50hf0qF7DcnLNEEQoeMdXH78m3fwyyD9
   w==;
X-CSE-ConnectionGUID: rvFQ8aKiTo+0Jte1hSFUmw==
X-CSE-MsgGUID: 3mfdSpxwR7edq7d7ZzaJCg==
X-IronPort-AV: E=Sophos;i="6.24,233,1774310400"; 
   d="scan'208";a="22540181"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 02:33:09 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:27004]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.145:2525] with esmtp (Farcaster)
 id ea94de57-c677-4640-8c9d-d4de51d575ea; Tue, 30 Jun 2026 02:33:09 +0000 (UTC)
X-Farcaster-Flow-ID: ea94de57-c677-4640-8c9d-d4de51d575ea
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 30 Jun 2026 02:33:09 +0000
Received: from 6c7e67c92ceb.amazon.com (10.106.100.54) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 30 Jun 2026 02:33:08 +0000
From: Nathan Gao <zcgao@amazon.com>
To: <pbonzini@redhat.com>
CC: <bkov@amazon.com>, <doebel@amazon.de>, <fgriffo@amazon.co.uk>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <seanjc@google.com>,
	<stable@vger.kernel.org>, <zcgao@amazon.com>
Subject: Re: stable backports for "KVM: x86: Fix shadow paging use-after-free due to unexpected GFN"
Date: Mon, 29 Jun 2026 19:33:01 -0700
Message-ID: <20260630023301.99458-1-zcgao@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CABgObfawkiKRDz0to=oCjo1vygVAkHyZXAzpsLWT2GXwkszV_A@mail.gmail.com>
References: <CABgObfawkiKRDz0to=oCjo1vygVAkHyZXAzpsLWT2GXwkszV_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi Paolo,

We found a regression from the backported series. Below is the reproducing
steps and the data we captured is from kvm/kvm.git linux-5.10.y branch, HEAD commit
d3d0e6688c. 5.15 may also have the same issue but I haven't got chance to test yet.

Reproducer
----------
Launch kvm.git linux-5.10.y kernel build with qemu. Then inside the guest, 
launch another qemu:

  qemu-system-x86_64 \
    -smp 8 -m 4G -enable-kvm -cpu host,vmx=on \
    -machine q35,kernel-irqchip=split -display none \
    -kernel <any-bzImage> -initrd <any-initrd> \
    -nic user -serial mon:stdio -append "console=ttyS0 nokaslr"

WARNs fire during boot on kvm_page_track_flush_slot. Sending SIGKILL to the
qemu process afterward triggers another WARN on kvm_mmu_notifier_release.
The timing requirement is low. 1 or 2 try will produce the issue. 

The issue does NOT reproduce on the pre-backport baseline
(v5.10.254).

Traces (5.10.254+, kvm/kvm.git linux-5.10.y)
---------------------------------------------

1. During boot:

[   27.638425] ------------[ cut here ]------------
[   27.639115] WARNING: CPU: 14 PID: 2193 at arch/x86/kvm/mmu/mmu.c:5471 kvm_mmu_zap_all_fast+0x12e/0x180
[   27.640421] Modules linked in:
[   27.640869] CPU: 14 PID: 2193 Comm: qemu-system-x86 Not tainted 5.10.254+ #5
[   27.641884] Hardware name: Red Hat KVM, BIOS 1.11.0-2.amzn2 04/01/2014
[   27.642808] RIP: 0010:kvm_mmu_zap_all_fast+0x12e/0x180
[   27.643536] Code: e8 47 fb ff ff 44 03 6c 24 04 84 c0 0f 85 47 ff ff ff 48 89 e8 48 89 eb 48 8b 6d 08 4c 39 f8 0f 85 45 ff ff ff e9 54 ff ff ff <0f> 0b eb e4 65 8b 05 af ad fa 7e 89 c0 48 0f a3 05 4d fe 2f 02 0f
[   27.646159] RSP: 0018:ffffc900006dbbc8 EFLAGS: 00010202
[   27.646900] RAX: 0000000000000000 RBX: ffff8881060dcb28 RCX: 0000000000000000
[   27.647910] RDX: 0000000000000000 RSI: 0000000000000010 RDI: ffff888101f716b8
[   27.648888] RBP: ffff8881060dc7e0 R08: 00000009d5d7051e R09: ffff888101f716b0
[   27.649907] R10: ffffc900006dbc18 R11: 0000000000000008 R12: ffffc90000691000
[   27.650910] R13: 0000000000000000 R14: ffffc90000699a80 R15: ffffc90000699a70
[   27.651921] FS:  00007f8aa4a3a700(0000) GS:ffff888627d80000(0000) knlGS:0000000000000000
[   27.653028] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.653852] CR2: 00007f8a9c40b000 CR3: 000000010709c003 CR4: 0000000000772ee0
[   27.654858] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   27.655856] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   27.656837] PKRU: 55555554
[   27.657219] Call Trace:
[   27.657578]  kvm_page_track_flush_slot+0x51/0x90
[   27.658270]  kvm_set_memslot+0x179/0x660
[   27.658831]  kvm_delete_memslot+0x68/0xe0
[   27.659403]  __kvm_set_memory_region+0x391/0x560
[   27.660066]  ? rcuwait_wake_up+0x22/0x30
[   27.660611]  ? kvm_vcpu_wake_up+0x15/0x40
[   27.661169]  ? kvm_vcpu_kick+0xf/0x60
[   27.661718]  ? __check_object_size+0x73/0x1b0
[   27.662342]  ? _copy_to_user+0x1c/0x30
[   27.662879]  kvm_set_memory_region+0x26/0x40
[   27.663489]  kvm_vm_ioctl+0x7e5/0xb80
[   27.664020]  ? handle_mm_fault+0x1113/0x1730
[   27.664616]  __x64_sys_ioctl+0x8f/0xd0
[   27.665145]  do_syscall_64+0x33/0x40
[   27.665691]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[   27.666419] RIP: 0033:0x7f8aaa70f9a7
[   27.666932] Code: 00 00 90 48 8b 05 d9 04 2c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a9 04 2c 00 f7 d8 64 89 01 48
[   27.669508] RSP: 002b:00007f8aa4a39248 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   27.670600] RAX: ffffffffffffffda RBX: 000055abe9c26eb0 RCX: 00007f8aaa70f9a7
[   27.671604] RDX: 00007f8aa4a392b0 RSI: 000000004020ae46 RDI: 000000000000000b
[   27.672598] RBP: 000055abe9c24980 R08: 0000000000000007 R09: fffffffffffffe78
[   27.673577] R10: 00007f8a9c41e600 R11: 0000000000000246 R12: 00007f8aa4a392b0
[   27.674701] R13: 0000000001000000 R14: 0000000000000000 R15: 0000000000000000
[   27.675703] ---[ end trace ff19449f37382c4a ]---

2. On SIGKILL:

[   47.572967] ------------[ cut here ]------------
[   47.573762] WARNING: CPU: 13 PID: 2192 at arch/x86/kvm/mmu/mmu.c:5785 kvm_mmu_zap_all+0x82/0xf0
[   47.575104] Modules linked in:
[   47.575583] CPU: 13 PID: 2192 Comm: qemu-system-x86 Tainted: G        W         5.10.254+ #5
[   47.576851] Hardware name: Red Hat KVM, BIOS 1.11.0-2.amzn2 04/01/2014
[   47.577902] RIP: 0010:kvm_mmu_zap_all+0x82/0xf0
[   47.578596] Code: ef e8 f2 7f ff ff 84 c0 75 db 48 89 ef e8 b6 18 0d 00 85 c0 75 cf 48 89 d8 48 89 de 48 8b 1b 49 39 c5 74 16 f6 46 35 08 74 cc <0f> 0b 48 89 d8 48 89 de 48 8b 1b 49 39 c5 75 ea 48 8b 44 24 08 4c
[   47.581340] RSP: 0018:ffffc90000827c20 EFLAGS: 00010202
[   47.582173] RAX: ffff8881084be930 RBX: ffff8881084be690 RCX: 0000000000000000
[   47.583232] RDX: 0000000080000000 RSI: ffff8881084be930 RDI: ffffc90000691000
[   47.584293] RBP: ffffc90000691000 R08: 000000000003d0e0 R09: ffff888101f71848
[   47.585364] R10: ffff8881070c8c10 R11: ffff8881070c8800 R12: ffffc90000827c28
[   47.586436] R13: ffffc90000699a70 R14: ffff8881020c4bb8 R15: ffff888101436078
[   47.587476] FS:  0000000000000000(0000) GS:ffff888627d40000(0000) knlGS:0000000000000000
[   47.588629] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.589456] CR2: 00007f91360231a0 CR3: 000000010709c004 CR4: 0000000000772ee0
[   47.590527] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   47.591548] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   47.592574] PKRU: 55555554
[   47.592973] Call Trace:
[   47.593346]  kvm_mmu_notifier_release+0x26/0x60
[   47.594046]  __mmu_notifier_release+0x6e/0x1c0
[   47.594706]  exit_mmap+0x14c/0x190
[   47.595221]  ? __ksm_exit+0x112/0x1b0
[   47.595752]  ? kmem_cache_free+0x39c/0x400
[   47.596342]  ? kmem_cache_free+0x39c/0x400
[   47.596931]  ? __ksm_exit+0x112/0x1b0
[   47.597463]  mmput+0x50/0x130
[   47.597938]  do_exit+0x31b/0xb70
[   47.598418]  ? __remove_hrtimer+0x39/0x70
[   47.599005]  ? hrtimer_try_to_cancel+0xb2/0xf0
[   47.599649]  do_group_exit+0x3a/0xa0
[   47.600199]  get_signal+0x145/0x890
[   47.600722]  arch_do_signal_or_restart+0xad/0x270
[   47.601415]  exit_to_user_mode_prepare+0x115/0x190
[   47.602150]  syscall_exit_to_user_mode+0x22/0x140
[   47.602831]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[   47.603556] RIP: 0033:0x7f8aaa70f9a7
[   47.604078] Code: Unable to access opcode bytes at RIP 0x7f8aaa70f97d.
[   47.605051] RSP: 002b:00007f8aa523a6c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   47.606191] RAX: fffffffffffffffc RBX: 0000000000000001 RCX: 00007f8aaa70f9a7
[   47.607200] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000000000000000c
[   47.608208] RBP: 000055abc42a5220 R08: 0000000000000000 R09: 000055abc42a9410
[   47.609212] R10: 0000000000000001 R11: 0000000000000246 R12: 000055abe9c36d5e
[   47.610267] R13: 0000000000000000 R14: 00007f8ab0169000 R15: 000055abe9c36cc0
[   47.611299] ---[ end trace ff19449f37382c4e ]---



I am withdrawing my earlier Tested-by after this finding.
The KVM selftests and kvm-unit-tests are limited, which is why they did not catch it.

Please let me know if there is additional information I can provide,
or if you would like me to test a v2.

Thanks,
Nathan
