Received: from mail-244118.protonmail.ch (mail-244118.protonmail.ch [109.224.244.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7B730F52B
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827120; cv=none; b=SxrIp3bVNwCe2Fn9bsMrY2p/YQ8ktwsNaAhf+vTifao9W9OTKQPPQ02whTYLxwnWnnU4rCnUGbScNO2qNemg3hDsSs3f6UTFycEX3eDBpFXIw3qFowmlqs0+LKvWhiB/F7Z2ZoAn7cXF+Y2zV9+PheOYfkttTj/FybmqxzLKLKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827120; c=relaxed/simple;
	bh=C54OY5GzuVBuHhF+jYzCcp+gzXQpK2S++b9Bgz6WC3Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKlz4AwCcSAuHGl8F3jfnmpdm6sfsC5KNhGg41Q2o0opnCf3rLEQtzH4N6JetS0+6nlBEQpbaTPkL5xSFH8izQrdx75OomPNL1PbMq9MaoUSeQglKIf5urTbxOWQ1+K8YDLUgEhioBPN3XJ8wq2hhB9+cDAFwZy3Sak7D9XlQWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=k5CICHh+; arc=none smtp.client-ip=109.224.244.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="k5CICHh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1780827108; x=1781086308;
	bh=i3TYIe8/Ow7zioV2ZC5qSbM5g9az2F76wDh0anX9xpA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=k5CICHh+kGsHHudQ8B1tUK+NLyoxJAze+1Y5JOyPPQgXUD+1l2eWs7O5zv5V4YNab
	 fH8S079/QNac86qI1Yw7gPYuP0KaVJwsz/X87aioPfjV6OIduqTI/J1KT0u/0tE0dQ
	 Py9BCzWAX2FHNRDFmhKrS3I00NTCKXtCKUIguXQRNDsohpGR9R/Hhn5jlnUFFMvVqm
	 3fP1FH9ROxj1RkqbIyjWRIiXpVvE1CkvUnFXI8u0MnM2/3Rakmq9nTnVYpZmBqD2/x
	 lP9j/E7KM5L4MvTJIbKLlhC6btH1MgTPcMV+poE4VOetWgBHwXnLSQTYAmGn7+UO0h
	 5bRHWCx+meJjQ==
Date: Sun, 07 Jun 2026 10:11:42 +0000
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
From: Paul Moses <p@1g4.org>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, bpf@vger.kernel.org, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, houtao1@huawei.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: Validate BTF repeated field counts before expansion
Message-ID: <E0xEdilT0Z6figMeDAyw03ex29iX0RfOAUXuh4aTJxUrKHK2Bg5N8lKCHNvQoQQ1UzndFFqDJ_zmAMYHLqSgSfF1menSW7C9VKDSBhYrTT0=@1g4.org>
In-Reply-To: <DJ2OZSCSEVEI.3APUCE7ML9X4Q@gmail.com>
References: <20260605234301.1109063-1-p@1g4.org> <DJ2OZSCSEVEI.3APUCE7ML9X4Q@gmail.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: f632fae0f54ebee434c0cfe12a0f59654585aeb1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>=20
> Do you have an example where this actually occurred in practice?
>=20

Yes.=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   10.633105] BUG: KASAN: vmalloc-out-of-bounds in btf_repeat_fields+0x194=
/0x3c0 kernel/bpf/btf.c:3697
[   10.633833] Write of size 240 at addr ffa000000094ffd8 by task runner/86
[   10.633998]
[   10.634698] CPU: 1 UID: 0 PID: 86 Comm: runner Not tainted 7.1.0-rc5-g8d=
9c51eac648 #3 PREEMPT(lazy)
[   10.634859] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   10.635067] Call Trace:
[   10.635143]  <TASK>
[   10.635240]  __dump_stack+0x21/0x30
[   10.635389]  dump_stack_lvl+0x77/0xa0
[   10.635457]  print_address_description+0x7b/0x200
[   10.635527]  print_report+0x5b/0x70
[   10.635585]  kasan_report+0x134/0x170
[   10.635633]  ? btf_repeat_fields+0x194/0x3c0 kernel/bpf/btf.c:3697
[   10.635691]  kasan_check_range+0x270/0x2d0
[   10.635735]  ? btf_repeat_fields+0x194/0x3c0 kernel/bpf/btf.c:3697
[   10.635782]  __asan_memcpy+0x48/0x80
[   10.635839]  btf_repeat_fields+0x194/0x3c0 kernel/bpf/btf.c:3697
[   10.635892]  btf_find_field_one+0x101c/0x1200
[   10.635952]  btf_parse_fields+0x772/0x24e0
[   10.636168]  </TASK>
[   10.636271]
[   10.637213]
[   10.637291] The buggy address belongs to a vmalloc virtual mapping
[   10.637573] The buggy address belongs to the physical page:
[   10.637951] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0=
x0 pfn:0x105f0f
[   10.638190] flags: 0x200000000000000(node=3D0|zone=3D2)
[   10.638912] raw: 0200000000000000 ffd400000417c3c8 ffd400000417c3c8 0000=
000000000000
[   10.639076] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000=
000000000000
[   10.639256] page dumped because: kasan: bad access detected
[   10.639361]
[   10.639443] Memory state around the buggy address:
[   10.639664]  ffa000000094ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00
[   10.639818]  ffa000000094ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00
[   10.639963] >ffa0000000950000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8=
 f8 f8
[   10.640090]                    ^
[   10.640252]  ffa0000000950080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8=
 f8 f8
[   10.640403]  ffa0000000950100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8=
 f8 f8
[   10.640556] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   10.640944] Disabling lock debugging due to kernel taint
[   10.641139] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   10.641252] BUG: KASAN: vmalloc-out-of-bounds in btf_repeat_fields+0x2dc=
/0x3c0 kernel/bpf/btf.c:3699
[   10.641389] Read of size 4 at addr ffa000000095000c by task runner/86
[   10.641500]
[   10.641716] CPU: 1 UID: 0 PID: 86 Comm: runner Tainted: G    B          =
     7.1.0-rc5-g8d9c51eac648 #3 PREEMPT(lazy)
[   10.641833] Tainted: [B]=3DBAD_PAGE
[   10.641863] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   10.641893] Call Trace:
[   10.641911]  <TASK>
[   10.641930]  __dump_stack+0x21/0x30
[   10.642002]  dump_stack_lvl+0x77/0xa0
[   10.642068]  print_address_description+0x7b/0x200
[   10.642135]  print_report+0x5b/0x70
[   10.642196]  kasan_report+0x134/0x170
[   10.642241]  ? btf_repeat_fields+0x2dc/0x3c0 kernel/bpf/btf.c:3699
[   10.642299]  __asan_report_load4_noabort+0x18/0x20
[   10.642356]  btf_repeat_fields+0x2dc/0x3c0 kernel/bpf/btf.c:3699
[   10.642410]  btf_find_field_one+0x101c/0x1200
[   10.642470]  btf_parse_fields+0x772/0x24e0
[   10.642675]  </TASK>
[   10.642693]
[   10.643500] The buggy address belongs to a vmalloc virtual mapping
[   10.643639] Memory state around the buggy address:
[   10.643736]  ffa000000094ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00
[   10.643851]  ffa000000094ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00
[   10.643961] >ffa0000000950000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8=
 f8 f8
[   10.644064]                       ^
[   10.644141]  ffa0000000950080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8=
 f8 f8
[   10.644251]  ffa0000000950100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8=
 f8 f8
[   10.644355] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   10.645473] BUG: unable to handle page fault for address: ffa00000009500=
0c
[   10.645715] #PF: supervisor read access in kernel mode
[   10.645828] #PF: error_code(0x0000) - not-present page
[   10.646124] PGD 100000067 P4D 100229067 PUD 100232067 PMD 104b92067 PTE =
0
[   10.646621] Oops: Oops: 0000 [#1] SMP KASAN NOPTI
[   10.646772] CPU: 1 UID: 0 PID: 86 Comm: runner Tainted: G    B          =
     7.1.0-rc5-g8d9c51eac648 #3 PREEMPT(lazy)
[   10.646944] Tainted: [B]=3DBAD_PAGE
[   10.647016] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   10.647206] RIP: 0010:btf_repeat_fields+0x230/0x3c0
[   10.647397] Code: 00 00 44 01 3b 41 8d 45 02 89 c0 48 8d 04 40 49 8d 1c =
c4 48 83 c3 04 48 89 d8 48 c1 e8 03 0f b6 04 10 84 c0 0f 85 94 00 00 00 <44=
> 01 3b 41 8d 45 03 89 c0 48 8d 04 40 49 8d 1c c4 48 83 c3 04 48
[   10.647693] RSP: 0018:ffa000000094f8e8 EFLAGS: 00010296
[   10.647878] RAX: ff11000105f19901 RBX: ffa000000095000c RCX: ff11000105f=
199c0
[   10.648021] RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffffffff868=
12e20
[   10.648161] RBP: ffa000000094f940 R08: ffffffff86812e27 R09: 1ffffffff0d=
025c4
[   10.648297] R10: dffffc0000000000 R11: fffffbfff0d025c5 R12: ffa00000009=
4fb28
[   10.648438] R13: 0000000000000032 R14: 0000000000000004 R15: 00000000000=
00028
[   10.648605] FS:  000000000020a2b8(0000) GS:ff110001d3d55000(0000) knlGS:=
0000000000000000
[   10.648759] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.648879] CR2: ffa000000095000c CR3: 0000000105dc4000 CR4: 00000000007=
51ef0
[   10.649050] PKRU: 55555554
[   10.649197] Call Trace:
[   10.649337]  <TASK>
[   10.649419]  btf_find_field_one+0x101c/0x1200
[   10.649549]  btf_parse_fields+0x772/0x24e0
[   10.649819]  </TASK>
[   10.649911] Modules linked in:
[   10.650186] CR2: ffa000000095000c
[   10.650727] ---[ end trace 0000000000000000 ]---
[   10.651049] RIP: 0010:btf_repeat_fields+0x230/0x3c0
[   10.651179] Code: 00 00 44 01 3b 41 8d 45 02 89 c0 48 8d 04 40 49 8d 1c =
c4 48 83 c3 04 48 89 d8 48 c1 e8 03 0f b6 04 10 84 c0 0f 85 94 00 00 00 <44=
> 01 3b 41 8d 45 03 89 c0 48 8d 04 40 49 8d 1c c4 48 83 c3 04 48
[   10.651376] RSP: 0018:ffa000000094f8e8 EFLAGS: 00010296
[   10.651493] RAX: ff11000105f19901 RBX: ffa000000095000c RCX: ff11000105f=
199c0
[   10.651603] RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffffffff868=
12e20
[   10.651712] RBP: ffa000000094f940 R08: ffffffff86812e27 R09: 1ffffffff0d=
025c4
[   10.651819] R10: dffffc0000000000 R11: fffffbfff0d025c5 R12: ffa00000009=
4fb28
[   10.651925] R13: 0000000000000032 R14: 0000000000000004 R15: 00000000000=
00028
[   10.652031] FS:  000000000020a2b8(0000) GS:ff110001d3d55000(0000) knlGS:=
0000000000000000
[   10.652151] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.652253] CR2: ffa000000095000c CR3: 0000000105dc4000 CR4: 00000000007=
51ef0
[   10.652363] PKRU: 55555554
[   10.652644] Kernel panic - not syncing: Fatal exception
[   10.653804] Kernel Offset: disabled
[   10.654081] ---[ end Kernel panic - not syncing: Fatal exception ]---
---------------------------------------------------------------------------=
-----------------------------------------

Also, I still haven't made the connection between the CI failure and
my patch. I produced what looks like the tcg variation of the same=20
failure as a oneoff while testing an (functionally) unpatched kernel.=20
I'm not even sure it's the kernel at all and not some weirdness
between clang and qemu. Seems low frequency intermittent from what=20
I've seen so far. Any ideas appreciated.

[    0.000000] Linux version 7.1.0-rc5-g8d9c51eac648-dirty (me@localhost) (=
clang version 22.1.7, LLD 22.1.7) #7 SMP PREEMPT_DYNAMIC Sun Jun  7 07:30:5=
4 UTC 2026
...
[    0.002022] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    0.002117] BUG: KASAN: wild-memory-access in do_raw_spin_lock+0xd4/0x27=
0
[    0.002117] Write of size 4 at addr ff110001001164b8 by task swapper/0/0
[    0.002117]=20
[    0.002117] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.1.0-rc5-g=
8d9c51eac648-dirty #7 PREEMPT(full)=20
[    0.002117] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    0.002117] Call Trace:
[    0.002117]  <IRQ>
[    0.002117]  __dump_stack+0x21/0x30
[    0.002117]  dump_stack_lvl+0x7a/0xb0
[    0.002117]  print_report+0x4e/0x70
[    0.002117]  kasan_report+0x134/0x170
[    0.002117]  ? do_raw_spin_lock+0xd4/0x270
[    0.002117]  kasan_check_range+0x270/0x2d0
[    0.002117]  __kasan_check_write+0x18/0x20
[    0.002117]  do_raw_spin_lock+0xd4/0x270
[    0.002117]  _raw_spin_lock+0x3f/0x50
[    0.002117]  handle_edge_irq+0x3c/0x870
[    0.002117]  __common_interrupt+0xe0/0x160
[    0.002117]  common_interrupt+0x8a/0xa0
[    0.002117]  </IRQ>
[    0.002117]  <TASK>
[    0.002117]  asm_common_interrupt+0x2b/0x40
[    0.002117] RIP: 0010:identify_cpu+0x463/0x3730
[    0.002117] Code: 48 8b 7d d0 0f 84 f6 00 00 00 41 80 3e 00 74 1a 49 8d =
bf 80 13 27 86 e8 0b 80 9f 00 48 8b 7d d0 48 be 00 00 00 00 00 fc ff df <49=
> 8b 9f 80 13 27 86 48 85 db 0f 84 c6 00 00 00 4c 8d 63 08 4c 89
[    0.002117] RSP: 0000:ffffffff84c07dc8 EFLAGS: 00010246
[    0.002117] RAX: ffffffff85a2cdd0 RBX: 0000000000000040 RCX: 00000000000=
00000
[    0.002117] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffffffff85a=
2ccb8
[    0.002117] RBP: ffffffff84c07ea8 R08: 0000000000000004 R09: 00000000000=
00004
[    0.002117] R10: ffffffff85a2ccc4 R11: fffffbfff0b4599b R12: 00000000000=
00006
[    0.002117] R13: ffffffff85a2cdf8 R14: fffffbfff0c4e270 R15: 00000000000=
00000
[    0.002117]  ? identify_cpu+0x398/0x3730
[    0.002117]  identify_boot_cpu+0x11/0xe0
[    0.002117]  arch_cpu_finalize_init+0x28/0x1f0
[    0.002117]  start_kernel+0x323/0x3e0
[    0.002117]  x86_64_start_reservations+0x28/0x30
[    0.002117]  x86_64_start_kernel+0x105/0x110
[    0.002117]  common_startup_64+0x12c/0x137
[    0.002117]  </TASK>
[    0.002117] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
