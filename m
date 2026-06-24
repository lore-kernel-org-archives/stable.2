Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FB61A3165
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782326145; cv=none; b=YCv4g8iZT+ESDna85VZ2MER+dw+VvlqkEdxUhmHri+UuKWob8QuQKJpuOwYke9rRcavlgYoZbOJ3h8VelmvuUkCxTWrP5pPYCI5EaLmfS/xlKO8qYk3ZY8yw1Mm8R5SMPT9QOUZ4y5cYtn9kYbnpTEoDnaE/sM/hLgzNrwB0Qdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782326145; c=relaxed/simple;
	bh=ZWTop5MIvONvn6LUykPB/avYD8xXyrmvd1137/JWVzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KGKEemdGuupmSwphEvhn+yHX+UeMyAz0rva1LbnqtesRXXsV79ZA49IItjnuyCEKK3Z2MdK6MXrpyGU3TjfD3fw6NcPHS3LZDfPTI8anUkIN+OWa6JFN0SzPNF0m2gPvfuZ4zlK2elMvJ+bv8GJbBZgILw6rHJWZwYDs6s/STvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Td9BuWB1; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Td9BuWB1"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8454fccf3b1so296282b3a.1
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 11:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782326142; x=1782930942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CkQrwyqUtbEBwCw+6J77RIBxcGN7JfNHmCCOvnM/ljo=;
        b=Td9BuWB1ehwzfEhEqHjmJ3dUaN7v83si+YvNgCX7Zv2rDqjDV+gbTTaUQBLN7I85pj
         lH5QDJ/fTTspw0J+MLeMSS5MWiAv3LqNRF3SJKS5DQoloEYcoRaXgM5bSRs8ywTiLsbp
         S4YOeot4328hsqa0R1/nZVvqkxLM1VuGElbMwGHHqvewOiybUboagOdIPtLP00DIovzM
         3x+kWfOD0ItDsoJRQ4KHxtALKTy6CZsy2AV1wVmV7+IlaZS/YoBG9TjNo7ePu6eTJL/R
         O44HMA8zueKGqPq6/3HoTrDNBUB4rBA8buSU9cDg4Vn0pB47aoqmKfUUc5BifCVaIPpp
         DYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782326142; x=1782930942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkQrwyqUtbEBwCw+6J77RIBxcGN7JfNHmCCOvnM/ljo=;
        b=Csvkj5F+aWjiDBbVuvx0nqW2edz1h6lkeg3glwqr19ZcB21E1cKeB6xLH8wzk3Ih1x
         pphkAD932gIItDIl7HMucFF4uqLUuUbo3bhy35ky2u6cmIfr40zSgSZOCPJdNyGwuOb+
         sVGxZgQiG+egMFI3BFoxLRp/Cwcbm0+ryq0pr2Ml+CX7viW7QOaSljuuEXrrQm0PNI+H
         ctxPw9if8ncbOplEFvJ+JkG/uIzk6tt3bA79rKFJ2kre7vjgB3cRkcogIw0FtDt8fjl5
         cau7g/Sx6aDM/ROElte8CzGRJHyASvEBzeULDCIJPFYz2VozCiTEc1cNCuzwyyuvv9Ve
         tMYw==
X-Forwarded-Encrypted: i=1; AHgh+Rp1C1/QC2xmQ0Evd2Nw+CpfsiXne0i9qG/Asl1ZJ9PThj0A6GsRacyCDWXe/xdIMRCn7Azff4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza/x2MnD45y8++/evifAJNcn+vto3lX+47FmA4d1g2AZJnk98B
	FNJCl0HY8fcODNVHyUEcllOWzWFeSodOrLVRgT1ojpEunbtWX5n194WJ
X-Gm-Gg: AfdE7ckxnUEgj0mZXLgj7ZiM+/nmHJnhaLA+IQ/5kySdLsujNulJnbVT1Ex+q5paDfq
	PQTnZqJ3FBi/38wGTQdciTl+U/l5blGrFTcqLb5bqePp1Qt1WaaIWeztAXrx9m5acJhEGm9li3V
	QlByK1R61b6KNChT5fpMhMvVy9Q0X3gJd6f6m2nfdIMEARfUCvhEFZp6acVfuGL3lGRgf0tOYMn
	Eu+E9chd+AGcUxXQKvzhSj1s+EFOf6lCxNgl1c1+6DLA7F7K2g4PPQ0nL/9SIJs7G3ifmvxQC9L
	oJriRfcO/ha8vB+AjTky4NIVffVPi6ujf6UjeyZgqBxrgt4UUx2QfvecYVanwjA+NcenCY90AyJ
	prD40DhSLHQzZguEMdE+TA3YztSoC7XOEvHX3aRq13DJuV6/0qxl7p3Y5iSll8lzNYUrJdDrBIA
	mQdrXJRuHd1k/NTbGX
X-Received: by 2002:a17:903:b0e:b0:2c4:397:dd7a with SMTP id d9443c01a7336-2c7bf1a5354mr52776825ad.4.1782326142285;
        Wed, 24 Jun 2026 11:35:42 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f63b2bd7sm3348575ad.48.2026.06.24.11.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 11:35:41 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH] drm/amdgpu/discovery: fix OOB read via unchecked die_offset in IP discovery parsing
Date: Wed, 24 Jun 2026 14:34:09 -0400
Message-ID: <20260624183409.1079288-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three call sites in amdgpu_discovery.c dereference firmware-controlled
die_offset values without validating them against adev->discovery.size:

  amdgpu_discovery_read_harvest_bit_per_ip() line 776-777
  amdgpu_discovery_sysfs_init()              line 1298-1299
  amdgpu_discovery_reg_base_init()           line 1524-1525

In all three sites the pattern is:

  die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
  dhdr = (struct die_header *)(discovery_bin + die_offset);

die_offset is a firmware-controlled u16 (max 65535). The discovery
binary is allocated as adev->discovery.size bytes (DISCOVERY_TMR_SIZE
= 10240 by default). No bounds check exists between the le16_to_cpu()
call and the pointer cast, so a crafted blob with die_offset >= 10240
produces a pointer past the end of the allocation. The subsequent reads
of dhdr->die_id and dhdr->num_ips are then slab-out-of-bounds reads.

The ip_offset advancement inside the inner loop also uses
struct_size(ip, base_address, ip->num_base_address) where
num_base_address is firmware-controlled, enabling unbounded advancement
past the allocation on each iteration.

ASAN report (kernel 7.1.0+, QEMU/x86_64, nokaslr, slub_debug=FZPUA):

==================================================================
BUG: KASAN: slab-out-of-bounds in poc_init+0x453/0x1000 [amd_oob_harness]
Read of size 2 at addr ffff88800318a801 by task insmod/22

CPU: 0 UID: 0 PID: 22 Comm: insmod Tainted: G           O        7.1.0+ #26 PREEMPTLAZY
Tainted: [O]=OOT_MODULE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x2b/0x40
 print_report+0x14f/0x4d0
 ? wake_up_klogd_work_func+0x70/0x70
 ? poc_exit+0xfc0/0xfc0 [amd_oob_harness]
 kasan_report+0xd4/0x100
 ? poc_init+0x453/0x1000 [amd_oob_harness]
 ? poc_init+0x453/0x1000 [amd_oob_harness]
 poc_init+0x453/0x1000 [amd_oob_harness]
 ? poc_exit+0xfc0/0xfc0 [amd_oob_harness]
 ? poc_exit+0xfc0/0xfc0 [amd_oob_harness]
 do_one_initcall+0xb0/0x230
 ? initcall_blacklisted+0x150/0x150
 ? kasan_unpoison+0x40/0x60
 do_init_module+0x263/0x810
 ? kasan_save_free_info+0x37/0x50
 ? free_module+0x300/0x300
 ? kfree+0xf1/0x390
 load_module+0x3e12/0x51e0
 ? sysvec_apic_timer_interrupt+0xa/0x80
 ? asm_sysvec_apic_timer_interrupt+0x16/0x20
 ? module_frob_arch_sections+0x20/0x20
 ? kernel_read_file+0x4d9/0x790
 ? kernel_read_file+0x36c/0x790
 init_module_from_file+0x136/0x150
 ? __do_sys_init_module+0x180/0x180
 ? do_sys_openat2+0xeb/0x140
 ? fdget+0x64/0x200
 __x64_sys_finit_module+0x39f/0x7a0
 ? __x64_sys_init_module+0xc0/0xc0
 ? __x64_sys_open+0x180/0x180
 do_syscall_64+0x56/0x3f0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x4d1259
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffb68052f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004d1259
RDX: 0000000000000000 RSI: 000000000a529cf0 RDI: 0000000000000003
RBP: 000000000a529cf0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000a528dd0
R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3188
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4000000000000040(head|zone=1)
page_type: f8(unknown)
raw: 4000000000000040 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000f8000000 0000000000000000
head: 4000000000000040 0000000000000000 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000f8000000 0000000000000000
head: 4000000000000002 ffffea00000c6201 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88800318a700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88800318a780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88800318a800: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                   ^
 ffff88800318a880: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff88800318a900: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================
BUG: KASAN: slab-out-of-bounds in poc_init+0x4b3/0x1000 [amd_oob_harness]
Read of size 2 at addr ffff88800318a803 by task insmod/22

CPU: 0 UID: 0 PID: 22 Comm: insmod Tainted: G    B      O        7.1.0+ #26 PREEMPTLAZY
Tainted: [B]=BAD_PAGE, [O]=OOT_MODULE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x2b/0x40
 print_report+0x14f/0x4d0
 ? add_taint+0x50/0x70
 kasan_report+0xd4/0x100
 ? poc_init+0x4b3/0x1000 [amd_oob_harness]
 ? poc_init+0x4b3/0x1000 [amd_oob_harness]
 poc_init+0x4b3/0x1000 [amd_oob_harness]
 ? poc_exit+0xfc0/0xfc0 [amd_oob_harness]
 ? poc_exit+0xfc0/0xfc0 [amd_oob_harness]
 do_one_initcall+0xb0/0x230
 ? initcall_blacklisted+0x150/0x150
 ? kasan_unpoison+0x40/0x60
 do_init_module+0x263/0x810
 ? kasan_save_free_info+0x37/0x50
 ? free_module+0x300/0x300
 ? kfree+0xf1/0x390
 load_module+0x3e12/0x51e0
 ? sysvec_apic_timer_interrupt+0xa/0x80
 ? asm_sysvec_apic_timer_interrupt+0x16/0x20
 ? module_frob_arch_sections+0x20/0x20
 ? kernel_read_file+0x4d9/0x790
 ? kernel_read_file+0x36c/0x790
 init_module_from_file+0x136/0x150
 ? __do_sys_init_module+0x180/0x180
 ? do_sys_openat2+0xeb/0x140
 ? fdget+0x64/0x200
 __x64_sys_finit_module+0x39f/0x7a0
 ? __x64_sys_init_module+0xc0/0xc0
 ? __x64_sys_open+0x180/0x180
 do_syscall_64+0x56/0x3f0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x4d1259
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffb68052f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000007ffff0 RDI: 0000000000000003
RBP: 000000000a529cf0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000a528dd0
R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3188
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4000000000000040(head|zone=1)
page_type: f8(unknown)
raw: 4000000000000040 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000f8000000 0000000000000000
head: 4000000000000040 0000000000000000 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000f8000000 0000000000000000
head: 4000000000000002 ffffea00000c6201 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88800318a700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88800318a780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88800318a800: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                   ^
 ffff88800318a880: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff88800318a900: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================

Fix by adding a bounds check on die_offset against adev->discovery.size
before the pointer cast in all three sites.

Fixes: d0c647a6aae2 ("drm/amdgpu/discovery: support new discovery binary header")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index be5069642..41ca01e2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -774,6 +774,11 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
 	/* scan harvest bit of all IP data structures */
 	for (i = 0; i < num_dies; i++) {
 		die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
+		if (die_offset + sizeof(*dhdr) > adev->discovery.size) {
+			dev_err(adev->dev, "invalid die_offset %u in harvest table\n",
+				die_offset);
+			return;
+		}
 		dhdr = (struct die_header *)(discovery_bin + die_offset);
 		num_ips = le16_to_cpu(dhdr->num_ips);
 		ip_offset = die_offset + sizeof(*dhdr);
@@ -1296,6 +1301,11 @@ static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
 		struct ip_die_entry *ip_die_entry;
 
 		die_offset = le16_to_cpu(ihdr->die_info[ii].die_offset);
+		if (die_offset + sizeof(*dhdr) > adev->discovery.size) {
+			dev_err(adev->dev, "invalid die_offset %u in sysfs init\n",
+				die_offset);
+			return -EINVAL;
+		}
 		dhdr = (struct die_header *)(discovery_bin + die_offset);
 		num_ips = le16_to_cpu(dhdr->num_ips);
 		ip_offset = die_offset + sizeof(*dhdr);
@@ -1522,6 +1532,11 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 
 	for (i = 0; i < num_dies; i++) {
 		die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
+		if (die_offset + sizeof(*dhdr) > adev->discovery.size) {
+			dev_err(adev->dev, "invalid die_offset %u in reg base init\n",
+				die_offset);
+			return -EINVAL;
+		}
 		dhdr = (struct die_header *)(discovery_bin + die_offset);
 		num_ips = le16_to_cpu(dhdr->num_ips);
 		ip_offset = die_offset + sizeof(*dhdr);
-- 
2.53.0

