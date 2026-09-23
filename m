Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3BA486402
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201149; cv=none; b=i8OS1AOwdjIq0G1LQAbQ/NSlD+5K54I50sctkpBJzhon2V9+sQZO93dxdnc2CbrHXZrJgfFSKjCpXKXIs+W0J5f+fWDbFBqmx+P3jFblwvogW9vFiyaKe2jFUiUg1/XFpXLjaKKikvLiVaazNlZEg47bSNgsEfn9RqIJaqO0KV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201149; c=relaxed/simple;
	bh=PyFNC6XHZzNX/q+vlGbrk6OpW57bpF7VIFVHuDNodp8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lrOKgWwtYqusdUO+PIpDdknTFaM6iDM+8wMrsRODICKd+JlT5Ot/Gir0e0uBEXPi2/jonle0FRgeSw5Ej05Ag5OSDyANPxNg2DGWwf6IC1FL7ExS1vxrvPOCoLnhU4qBhAxc68Ab272F8tsq6RtQfTOg6Mf49tPOXPAH8n5urM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=qolTWGut; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="qolTWGut"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-32ba4885063so927774eec.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 15:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1790201147; x=1790805947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l0J7HKPZ44b2qHvPUkOMh3XQqO7D9FYamMp/EJCmpgg=;
        b=qolTWGut0Nr10hWUFp+Rnzc3Ox/ke0Mquw/b314TA7nATKy17VWDlGkjrSPKSTIEli
         A1tLVwKrN7H5TF8Y86zx5veg10dOD4JbgptOOjVhuMSoQ0lTw9RDmjmDPdOZvJukUMGC
         JvlRwXu0e2V1e6i6ZuYv8bECMk9j1ttMrvr+khaitYt8j4wGDTmCUueGl9FUJ3lQGV1M
         eFG1tj+xAVZBT2PpoVC5z4AQdxlKKIQ6r8nOb55zb5iyzevPD6mbQ1P9L2jjOQqmZkff
         1H5hLA56XFd8v2xaGVflHVG133Mr6M0jbcz2VcyRUcm5hf0PQkDkvsORMF9ZGAEh+Esn
         iWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790201147; x=1790805947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l0J7HKPZ44b2qHvPUkOMh3XQqO7D9FYamMp/EJCmpgg=;
        b=ePXI2a2Mc1ifTy71cRFf6OptegA8p8CM0YgPdHf3dPrRqNAim81MWh6NjiDYmS+ubq
         kocy1almtKuFdaYz3ZrC9xH6lZHr0/Ij9g/oWiqL1t5Sbbx0f4nlWUK5Bj4VuuQgvHF2
         o+QmidksI/10fOAWnEhWYpjniHA/s5GHFpdP717GehgbNco3Eh78uK1JYo8dSG1hc0Om
         7yoYSFwIcbkH95G5Ql32BWeutHdw/WoG6cecU3UxC0XSpJflaKXlBegUHlfHkVPQwolM
         l59yLQ/rEAC7cCQcFfyXsQmaT/ZzslAV+A9GuE6OEr5Ugnlrv+pp6nJuKL//ZKWVF2Dv
         o6kQ==
X-Forwarded-Encrypted: i=1; AKwUvByBjSLyjuHgaHIwsL4Oi2TBpXgf1B5t5Bm8mM8/hIKkp5izPFyL06xfXPEYxGLK+GEesT72Cwo=@vger.kernel.org
X-Gm-Message-State: AFuF++nEQK8JtFuKS4a4N0IpxWJQXv0oYG5z3w0DUIuxjS0hdFoaj0Cu
	vRWAVfIBnOQJ6OCxZtd/Al69ujEfQSHSFBUwkBgTkaJlV/9U2XLHv2P7wmmJj34pqNY=
X-Gm-Gg: AYBFou0UOVoNnB9ED/2qIcx5Sm3W1WIOo5WGXRghx6SXciGTzRos24VA23L8yKY1l7N
	oQ/C4evxkSzbrABs2vziPet6h6iPTm6Pp1wo/A2nD3pz4l19b8C+3CHNDmy7J9bz+Iyt94teBz1
	xUSLF0LXUbaGAfWNIXqaoLZ/J9MVlkd769BfgiCWw+iwDreSzAHGlZCyWr9xxxYcWKjMkPrtkyd
	IiPrwMGWuOQnMnQHYNvK1A9uNv6cq4D27dIvGya7ZTFgOK9lvOyKIxusjF8etcVKWw3KrdCe38c
	e2Q0t+0ovT31lg81NxGo0YhB9hIoT6Ivi/8r3tUQOST8a08E6z0ht7C1uDpkaE2DIcWzAHfRDho
	QqEBeqiC7VFwZnbpN/NxMm/E7dnBTX1qbixxOP+XogY5LrJPsG35vyWTzGMc2JYMN5O/9vZROd5
	//cCaQrqSJEWIYvPn3cFeKS7P8Zy6V134C6t9v/GivYa2pFgUBHmHYQ602Ao5alYfApi0816JeV
	iL+yTeer5Qppl5KGlh5UaWttgjcA528HhU=
X-Received: by 2002:a05:693c:69c1:b0:32e:e250:85ef with SMTP id 5a478bee46e88-33ffe74cd01mr350661eec.1.1790201146853;
        Wed, 23 Sep 2026 15:05:46 -0700 (PDT)
Received: from guest1.. (charm.ics.uci.edu. [128.195.4.118])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e96946d0csm9038456eec.21.2026.09.23.15.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:05:46 -0700 (PDT)
From: Priya Bala Govindasamy <pgovind2@uci.edu>
To: a.hindborg@kernel.org,
	ojeda@kernel.org
Cc: boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org,
	ardalan@uci.edu,
	zhiyunq@cs.ucr.edu,
	dzueck@uci.edu,
	pgovind2@uci.edu
Subject: [PATCH 0/1] rust: configfs: Fix incorrect subsystem root check in `get_group_data`
Date: Wed, 23 Sep 2026 22:05:44 +0000
Message-Id: <cover.1789770689.git.pgovind2@uci.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear Linux kernel maintainers,

We are developing a tool called FerroLens to detect potential 
unsound behavior in Rust code in the Linux kernel. The tool 
internally uses an LLM to detect bugs.
We then perform manual analysis to verify these reports. 
FerroLens reported the following bug in rust/kernel/configfs.rs:

In `get_group_data` to determine whether `this` is 
subsystem root, the following check is performed:
`(*this).cg_subsys.is_null()
`get_group_data` then tries to read the `data` field of either
`Group` or `Subsystem` structs depending on the result of the check.

But the check always evaluates to false in `get_group_data`, since
`link_group` in C always populates `group->cg_subsys` with a valid, 
non-null pointer.
Thus, if `this` points to a group representing the subsytem root,
the incorrect branch in `get_group_data` may be taken, 
leading to attempting to access `Subsystem.data` as `Group.data`.
This is type confusion that can lead to data corruption.

If the `data` fields of both structs are placed at the same offset,
we will not observe this issue, since the attempt to access the 
`data` field will be valid regardless of the type. But this layout 
is not guaranteed by the compiler.

In particular, if the kernel is built with a randomized layout 
(e.g with KRUSTFLAGS='-Zrandomize-layout=yes -Zlayout-seed=1'), 
We observe incorrect behavior when using the rust_configfs 
module from samples.

$ sudo insmod samples/rust/rust_configfs.ko
$ sudo cat /sys/kernel/config/rust_configfs/message
Segmentation fault (core dumped)

[  365.684128] rust_kernel: panicked at samples/rust/rust_configfs.rs:97:13:
               range end index 18446744072104944063 out of range for slice of length 4096
[  365.684458] ------------[ cut here ]------------
[  365.684468] kernel BUG at rust/helpers/bug.c:7!
[  365.684525] Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
[  365.690063] CPU: 10 UID: 0 PID: 4686 Comm: cat Tainted: G            E    N  7.3.0-rc3+ #54 PREEMPT(lazy) 
[  365.691501] Tainted: [E]=UNSIGNED_MODULE, [N]=TEST
[  365.692323] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  365.693700] RIP: 0010:rust_helper_BUG+0x8/0x10
[  365.694437] Code: ff 5d c3 cc cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 48 89 e5 <0f> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 9090 90 90 90 90 90
[  365.697372] RSP: 0018:ffff88810fc4fad8 EFLAGS: 00010286
[  365.698177] RAX: 0000000000000088 RBX: ffff88810fc4fb00 RCX: 79cfa39b35b7ef00
[  365.699252] RDX: 0000000000000001 RSI: 0000000000000004 RDI: 00000000ffffffff
[  365.700371] RBP: ffff88810fc4fad8 R08: ffff8883ad7fd553 R09: 1ffff11075affaaa
[  365.701440] R10: dffffc0000000000 R11: ffffed1075affaab R12: dffffc0000000000
[  365.702524] R13: ffffffffa07400c0 R14: dffffc0000000000 R15: ffffffffa05ba190
[  365.703642] FS:  00007f30f23c3740(0000) GS:ffff888426a46000(0000) knlGS:0000000000000000
[  365.704994] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  365.705890] CR2: 00007f30f23a1000 CR3: 00000002b2d16001 CR4: 0000000000372ef0
[  365.707001] Call Trace:
[  365.707404]  <TASK>
[  365.707797]  _RNvCsGIExRX8pES_7___rustc17rust_begin_unwind+0x8b/0x90
[  365.708795]  ? __pfx__RNvXs6_NtCsbuTvttuFvbr_6kernel3fmtINtB5_7AdapterRRNtNtNtCsjYlAz7NZ3Sw_4core5panic10panic_info9PanicInfoENtNtBS_3fmt7Display3fmtB7_+0x10/0x10
[  365.711020]  _RNvNtCsjYlAz7NZ3Sw_4core9panicking9panic_fmt+0x5a/0x60
[  365.712125]  ? vpanic+0x6c1/0x710
[  365.712635]  _RNvNtNtCsjYlAz7NZ3Sw_4core5slice5index16slice_index_fail+0x1cc/0x1d0
[  365.713776]  ? __pfx__RNvXsi_NtNtNtCsjYlAz7NZ3Sw_4core3fmt3num3impjNtB9_7Display3fmt+0x10/0x10
[  365.715149]  ? __pfx__RNvXsi_NtNtNtCsjYlAz7NZ3Sw_4core3fmt3num3impjNtB9_7Display3fmt+0x10/0x10
[  365.716487]  ? _RNvMs4_NtCsbuTvttuFvbr_6kernel8configfsINtB5_21GroupOperationsVTableNtCs1nKPhsfELFc_13rust_configfs13ConfigurationNtB16_5ChildE9drop_itemB16_+0x1f/0x20 [rust_configfs]
[  365.718991]  ? _RNvMs4_NtCsbuTvttuFvbr_6kernel8configfsINtB5_21GroupOperationsVTableNtCs1nKPhsfELFc_13rust_configfs13ConfigurationNtB16_5ChildE9drop_itemB16_+0x1f/0x20 [rust_configfs]
[  365.721617]  _RNvMs9_NtCsbuTvttuFvbr_6kernel8configfsINtB5_9AttributeKy0_NtCs1nKPhsfELFc_13rust_configfs13ConfigurationBV_E4showBX_+0xf1/0x110 [rust_configfs]
[  365.723789]  configfs_read_iter+0x285/0x580
[  365.724621]  ? __pfx__RNvMs9_NtCsbuTvttuFvbr_6kernel8configfsINtB5_9AttributeKy0_NtCs1nKPhsfELFc_13rust_configfs13ConfigurationBV_E4showBX_+0x10/0x10 [rust_configfs]
[  365.726836]  vfs_read+0x6e0/0x8e0
[  365.727402]  ksys_read+0xbc/0x170
[  365.728049]  __x64_sys_read+0x7f/0x90
[  365.728644]  x64_sys_call+0x2180/0x2600
[  365.729255]  do_syscall_64+0x11c/0x3f0
[  365.729848]  ? __this_cpu_preempt_check+0x17/0x20
[  365.730565]  ? debug_smp_processor_id+0x1b/0x30
[  365.731251]  ? debug_smp_processor_id+0x1b/0x30
[  365.732026]  ? rcu_is_watching+0x1a/0xc0
[  365.732646]  ? trace_irq_disable+0x3c/0x130
[  365.733302]  ? do_syscall_64+0x6d/0x3f0
[  365.733876]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  365.734657]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  365.735401] RIP: 0033:0x7f30f2114932
[  365.736044] Code: c0 e9 b2 fe ff ff 50 48 8d 3d 5a b3 0c 00 e8 e5 1c 02 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83ec 28 48 89 54 24
[  365.738750] RSP: 002b:00007ffc90983bb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[  365.739953] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f30f2114932
[  365.741121] RDX: 0000000000020000 RSI: 00007f30f23a2000 RDI: 0000000000000003
[  365.742409] RBP: 00007f30f23a2000 R08: 00007f30f23a1010 R09: 00007f30f23a1010
[  365.743448] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000022000
[  365.744690] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000
[  365.745771]  </TASK>
[  365.746104] Modules linked in: rust_configfs(E) binfmt_misc intel_rapl_msr intel_rapl_common kvm_intel kvm rapl joydev i2c_piix4 e1000 i2c_smbus floppy qemu_fw_cfg sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr efi_pstore autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq raid1 raid0 aesni_intel gf128mul psmouse input_leds serio_raw mac_hid pata_acpi
[  365.751834] ---[ end trace 0000000000000000 ]---
[  365.752720] RIP: 0010:rust_helper_BUG+0x8/0x10
[  365.752746] Code: ff 5d c3 cc cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 48 89 e5 <0f> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 9090 90 90 90 90 90
[  365.752751] RSP: 0018:ffff88810fc4fad8 EFLAGS: 00010286
[  365.752759] RAX: 0000000000000088 RBX: ffff88810fc4fb00 RCX: 79cfa39b35b7ef00
[  365.752763] RDX: 0000000000000001 RSI: 0000000000000004 RDI: 00000000ffffffff
[  365.752765] RBP: ffff88810fc4fad8 R08: ffff8883ad7fd553 R09: 1ffff11075affaaa
[  365.752768] R10: dffffc0000000000 R11: ffffed1075affaab R12: dffffc0000000000
[  365.752770] R13: ffffffffa07400c0 R14: dffffc0000000000 R15: ffffffffa05ba190
[  365.752773] FS:  00007f30f23c3740(0000) GS:ffff888426a46000(0000) knlGS:0000000000000000
[  365.752776] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  365.752778] CR2: 00007f30f23a1000 CR3: 00000002b2d16001 CR4: 0000000000372ef0


Priya Bala Govindasamy (1):
  rust: configfs: Fix incorrect subsystem root check in `get_group_data`

 rust/kernel/configfs.rs | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

-- 
2.34.1

