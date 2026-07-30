Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEE4409114;
	Thu, 30 Jul 2026 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785426856; cv=none; b=LNS7uXZofu9U92wZdvzCom/ZQMTWc+GeglQAdTznznTiBURLaGQrO4c2cP7Tlvd3qOmYK4/SBxM1BBvU9iwv1/+WEuPe9vMm/SuRa/K6cdpHETbltv5KofU54kOYmiYFVuiGzBHzr61RHU9/qLOmaVdsP3ZYiVha3iMVpLv2p+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785426856; c=relaxed/simple;
	bh=bmfBA5mRv8hn73jUW4quitx0Repbh0KXjCuOgOAf/ew=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JndAHINdOgwsQ3CKkOBIUo1JNOQ0OQR5tCzonCjZ3fA7Whqu/3X+RnjpOxJkNuIgRtaITbnBYiDlJpPBXIuKvqUKa7K+7R8GnmHff7+QzTYS7GCCjuXXQjZ1OVRm8ohKZdl7YwY1Lsh1lqFsH2gX9Ht2cnt1N4tbn8bAB8haxmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc; spf=pass smtp.mailfrom=steffen.cc; dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b=ABZbzREX; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b="ABZbzREX"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h9tzb1p9xzMlLY;
	Thu, 30 Jul 2026 17:54:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1785426843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zksK9+idUghCnssEho47J7vh5F4rjyXM/CYHhLvbBuI=;
	b=ABZbzREXVJlaEcXgHG6Q5/DFAD8yXognsvS9ozhwczAK4KfoCrR/A72xRMgHKDC8YIEHLe
	Xn9qtIxZSPiNPKquwlhB7/1Gk8XTwi+J/r4tMfnpBk8xvYMaNwPIfm5PordRc43ww97P00
	Jlrtk6YZxv7VAyXc4t/t4Of00EpMpJPiV1bC2yiM0VkDlHg5kd84sxdZjKKVFFm+ryM5F5
	gpZQ+9ahyq7YOxjG1mAXkh90nWU5n1iyir5FMhbDOuJ9g/if5fIUcTwCcw6hoKXwSm8boK
	9O+X6szUa5iUHT7GicwTLGH+AVMEvUXawnKwHceK1hVijvcn2WaBoaByTd+shQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=lists@steffen.cc
Message-ID: <555ea1d43a12c30a8f1eaf10c899b3790d728f33.camel@dirkwinkel.cc>
Subject: Re: [PATCH 0/5] x86/mm/pat: CPA fixes
From: Steffen Dirkwinkel <lists@steffen.cc>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Dave Hansen
	 <dave.hansen@linux.intel.com>, "Denis V. Lunev" <den@openvz.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski
 <luto@kernel.org>,  Borislav Petkov	 <bp@alien8.de>, David CARLIER
 <devnexen@gmail.com>, David Hildenbrand	 <david@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,  Juergen Gross
 <jgross@suse.com>, Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau
 <kas@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes
 <ljs@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,  "H. Peter Anvin"	
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Shakeel Butt	
 <shakeel.butt@linux.dev>, Suren Baghdasaryan <surenb@google.com>, Thomas
 Gleixner <tglx@kernel.org>, Toshi Kani <toshi.kani@hpe.com>, Vishal Moola
 <vishal.moola@gmail.com>,  Vlastimil Babka <vbabka@kernel.org>, Will Deacon
 <will@kernel.org>, iommu@lists.linux.dev, 	linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org, 	x86@kernel.org,
 syzbot@syzkaller.appspotmail.com
Date: Thu, 30 Jul 2026 17:53:50 +0200
In-Reply-To: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h9tzb1p9xzMlLY

Hello,


On Tue, 2026-07-28 at 16:07 +0300, Mike Rapoport (Microsoft) wrote:
> There are a couple of CPA fixes floating around:
>=20
> Denis Lunev fixed races between split and collapse of the large mappings:
>=20
> https://lore.kernel.org/all/20260715183453.2381141-1-den@openvz.org

We saw the error below and I was wondering if it might be related to these =
fixes
or a similar case that's unfixed still. Seems to have happened during concu=
rrent
kernel module loading of kvm and i915 (similar to the case in the patch fro=
m
Denis Lunev). But we got it without KASAN and the stack looks a little
different. I was not able to reproduce this with a ~16 hour concurrent modu=
le
load unload loop so far.

Kernel: v7.1.5, PREEMPT_RT, tainted because of /dev/msr access
CPU: Elkhart Lake Atom X6214RE, 2 cores, isolcpus=3D1-N

------------[ cut here ]------------
kernel BUG at arch/x86/kernel/alternative.c:2644!
Oops: invalid opcode: 0000 [#1] SMP NOPTI
CPU: 0 UID: 0 PID: 559 Comm: (udev-worker) Tainted: G S                  7.=
1.5-
rt1-bhf-369933-f1a4ee1dd787 #1 PREEMPT_{RT,(lazy)}=20
Tainted: [S]=3DCPU_OUT_OF_SPEC
Hardware name: Beckhoff Automation GmbH & Co. KG MC6015-0030/MC15083, BIOS =
Bxx83
- 0.11a PxeFailTst4.2 01/07/2026
RIP: 0010:__text_poke+0x356/0x3d0
Code: 00 10 00 00 77 26 48 85 c0 0f 85 74 fd ff ff e9 2d ff ff ff 48 89 ea =
4c 89
f6 48 89 df e8 22 0a 33 01 85 c0 0f 84 90 fe ff ff <0f> 0b>
RSP: 0018:ffffa8bb010afa70 EFLAGS: 00010006
RAX: 0000000000000088 RBX: ffffffffc07402b9 RCX: 0000000000000000
RDX: 0000000000000004 RSI: ffffffffb793166b RDI: ffffffffc07402b9
RBP: 0000000000000004 R08: 0000000000000033 R09: 8000000000000063
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffffb435e470
R13: 00004b8f944092b9 R14: ffffffffb793166b R15: 00000000000002bd
FS:  00007f205444c9c0(0000) GS:ffff9964b8518000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc66a0ed18 CR3: 0000000106551000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 smp_text_poke_batch_finish+0x1aa/0x3a0
 ? vmx_switch_vmcs+0xc8/0xd0 [kvm_intel]
 __static_call_transform+0xfa/0x1f0
 ? vmx_switch_vmcs+0xc8/0xd0 [kvm_intel]
 ? __pfx_preempt_schedule_thunk+0x10/0x10
 arch_static_call_transform+0x57/0xa0
 ? vmx_switch_vmcs+0xc8/0xd0 [kvm_intel]
 __static_call_init+0x1aa/0x230
 ? __SCT__tp_func_kvm_mmu_split_huge_page+0x8/0x8
 ? __SCT__tp_func_kvm_mmu_split_huge_page+0x8/0x8
 static_call_module_notify+0x11f/0x150
 notifier_call_chain+0x60/0xe0
 blocking_notifier_call_chain_robust+0x64/0xc0
 load_module+0x1bc7/0x2000
 ? security_kernel_post_read_file+0x46/0x110
 ? kernel_read_file+0x2e5/0x2f0
 init_module_from_file+0xc8/0xe0
 idempotent_init_module+0xfe/0x2f0
 __x64_sys_finit_module+0x71/0xe0
 do_syscall_64+0xa6/0x690
 ? clear_bhb_loop+0x30/0x80
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f2054faa7b9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 =
48 89
d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d>
RSP: 002b:00007ffc66a14c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000055f431ad34a0 RCX: 00007f2054faa7b9
RDX: 0000000000000000 RSI: 00007f205375b44d RDI: 0000000000000021
RBP: 0000000000000000 R08: 0000000000000000 R09: 000055f431a72e60
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f205375b44d
R13: 0000000000020000 R14: 000055f431ad01b0 R15: 0000000000000000
 </TASK>
Modules linked in: kvm_intel(+) i915(+) drm_buddy drm_client_lib ttm
drm_display_helper drm_kms_helper cfg80211 cec nft_ct nf_conntrack nf_>
---[ end trace 0000000000000000 ]---
RIP: 0010:__text_poke+0x356/0x3d0
Code: 00 10 00 00 77 26 48 85 c0 0f 85 74 fd ff ff e9 2d ff ff ff 48 89 ea =
4c 89
f6 48 89 df e8 22 0a 33 01 85 c0 0f 84 90 fe ff ff <0f> 0b>
RSP: 0018:ffffa8bb010afa70 EFLAGS: 00010006
RAX: 0000000000000088 RBX: ffffffffc07402b9 RCX: 0000000000000000
RDX: 0000000000000004 RSI: ffffffffb793166b RDI: ffffffffc07402b9
RBP: 0000000000000004 R08: 0000000000000033 R09: 8000000000000063
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffffb435e470
R13: 00004b8f944092b9 R14: ffffffffb793166b R15: 00000000000002bd
FS:  00007f205444c9c0(0000) GS:ffff9964b8518000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc66a0ed18 CR3: 0000000106551000 CR4: 0000000000350ef0
note: (udev-worker)[559] exited with irqs disabled


Best Regards
Steffen

>=20
> Lorenzo Stoakes fixed UAF caused by races between CPA and ptdump:
>=20
> https://lore.kernel.org/all/20260723-series-vmap-race-fix-v6-0-8cc77dcc00=
18@kernel.org
>=20
> and an issue with stale page tables in IOMMU:
>=20
> https://lore.kernel.org/all/20260721-fix-cpa-kernel-pagetables-v2-1-2b255=
deed710@kernel.org
>=20
> Mike Rapoport fixed a check of RW attribute in lookup_address_in_pgd_attr=
()
> used for the verification of RWX:
>=20
> https://lore.kernel.org/all/20260715144519.934289-1-rppt@kernel.org
>=20
> Some of the fixes got merged into x86 tree, some of them got merged into =
mm
> tree and some are still hanging in the air.
>=20
> Beside the fixes there was a supposed simplification of cpa_lock locking=
=20
> that looked like removal of an optimization for DEBUG_PAGEALLOC, but it
> turned out that it was not an optimization but rather a correctness
> guard because with DEBUG_PAGEALLOC the locks could be taken in an atomic
> context and couldn't use plain spin_lock()/spin_unlock().
>=20
> The changes here are collected from all these fixes into a sinlge coheren=
t
> set on top of tip/x86/mm:
> =20
> * update to cpa_lock handling with DEBUG_PAGEALLOC
> * fix for races between CPA and ptdumpi causing UAF
> * fix for stale page tables in IOMMU
> * update to the fix of the race between split and collapse of large
>   mappings
> * fix for effective RW computation in lookup_address_in_pgd_attr()
>=20
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
> Lorenzo Stoakes (ARM) (3):
>       x86/mm/pat: acquire init_mm write lock on collapse to avoid UAF
>       x86/mm/pat: acquire init_mm read lock on attribute change to avoid =
UAF
>       x86/mm/pat: allocate split page tables as kernel page tables
>=20
> Mike Rapoport (Microsoft) (2):
>       x86/mm/pat: introcude cpa_lock() and cpa_unlock()
>       x86/mm/pat: fix effective RW computation in lookup_address_in_pgd_a=
ttr()
>=20
>  arch/x86/mm/pat/set_memory.c | 95 +++++++++++++++++++++++++++++++-------=
------
>  include/linux/mmap_lock.h    |  2 +
>  2 files changed, 70 insertions(+), 27 deletions(-)
> ---
> base-commit: a5a162fe1ae130e3d2ceefef3f43afe3773c1d56
> change-id: 20260727-cpa-fixes-d3c73c075672
>=20
> --
> Sincerely yours,
> Mike.
