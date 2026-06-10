Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E473B42D6;
	Wed, 10 Jun 2026 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081539; cv=none; b=tXDjEFF9GDFm6Xjft11H8aMSQ2sOTWpyBFbEzxMxJuq9LEar8EKTR8QXRnP+K/p7bVXj5h0S4D3PGa8KfjjeMQIWA9BJ5hz4OuCTt9JU3GI4yBeq2pXnOPdXfThy6zG+gl+6tiYEzZ1vDLZK/pkDJikNBQpgqcMUmyO+8dBNtG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081539; c=relaxed/simple;
	bh=00shp9O2W4CBAedypET+fYW4rnRjJsFBkEY0OXMSj4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k2PHwMmsazCrtKe29VsDspqbVFO6VltVkwKRUxS6ahqRjDkiKhLPrsMXqRwrwjqTyRRs0kWQh0QQL9DesKnyOy2RP6lalzjWLRxeNkpjZIy53At8BGkRgsPoHZCH6wI7YPwrT/7eJXhJ+mAFMpGOPzUW9srwJHFY16NwnxP/xS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=rtfkIZFw; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="rtfkIZFw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1781081531;
	bh=00shp9O2W4CBAedypET+fYW4rnRjJsFBkEY0OXMSj4Y=;
	h=From:To:Cc:Subject:Date:From;
	b=rtfkIZFwe2LhqeHq/9U9V+xKWOWnCMDDrdiD0tDPf3Tp2yxWY8kS57HMiUBdHUivM
	 qgr/6fcEamRDqGpgnfdT4+gLNQe49UUEMEQ9bBXGTbIv9MPyatYb4BQcLydsoSHH1c
	 QecnWnUOnAP0cqtJocLxKwj5N1SUZ5+YEtjjDWvcAUD4MGObSObnM1+aIlmzT2GHXJ
	 vnK4fwjaf1O8qCJDpkvrw5vFlJEUbBxIgHDxerOOLRID+peg6o13B4zyr9R3sfO+TJ
	 4uZrLUA+jv6xgf6+EiC46s8PJF2dDiis7ciOgqnlxHtldwfnx8b3wGSniA7S3POILs
	 h1QYG0j1Rl/jQ==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id C59671F46A;
	Wed, 10 Jun 2026 11:52:11 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Wed, 10 Jun 2026 11:52:10 +0300 (MSK)
Received: from rbta-msk-lt-156703.astralinux.ru (unknown [10.198.54.246])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4gZzzt1cv8zwQDH;
	Wed, 10 Jun 2026 11:52:10 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Panov <apanov@astralinux.ru>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Edward Lo <loyuantsung@gmail.com>
Subject: [PATCH 5.15/6.1] fs/ntfs3: Return error for inconsistent extended attributes
Date: Wed, 10 Jun 2026 11:52:04 +0300
Message-Id: <20260610085204.21142-1-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: apanov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 107 0.3.107 575e75fe8e3b9d45c142d144823c5de38605099e, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 203772 [Jun 10 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/06/10 05:37:00 #28226291
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Edward Lo <loyuantsung@gmail.com>

commit c9db0ff04649aa0b45f497183c957fe260f229f6 upstream.

ntfs_read_ea is called when we want to read extended attributes. There
are some sanity checks for the validity of the EAs. However, it fails to
return a proper error code for the inconsistent attributes, which might
lead to unpredicted memory accesses after return.

[  138.916927] BUG: KASAN: use-after-free in ntfs_set_ea+0x453/0xbf0
[  138.923876] Write of size 4 at addr ffff88800205cfac by task poc/199
[  138.931132]
[  138.933016] CPU: 0 PID: 199 Comm: poc Not tainted 6.2.0-rc1+ #4
[  138.938070] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[  138.947327] Call Trace:
[  138.949557]  <TASK>
[  138.951539]  dump_stack_lvl+0x4d/0x67
[  138.956834]  print_report+0x16f/0x4a6
[  138.960798]  ? ntfs_set_ea+0x453/0xbf0
[  138.964437]  ? kasan_complete_mode_report_info+0x7d/0x200
[  138.969793]  ? ntfs_set_ea+0x453/0xbf0
[  138.973523]  kasan_report+0xb8/0x140
[  138.976740]  ? ntfs_set_ea+0x453/0xbf0
[  138.980578]  __asan_store4+0x76/0xa0
[  138.984669]  ntfs_set_ea+0x453/0xbf0
[  138.988115]  ? __pfx_ntfs_set_ea+0x10/0x10
[  138.993390]  ? kernel_text_address+0xd3/0xe0
[  138.998270]  ? __kernel_text_address+0x16/0x50
[  139.002121]  ? unwind_get_return_address+0x3e/0x60
[  139.005659]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[  139.010177]  ? arch_stack_walk+0xa2/0x100
[  139.013657]  ? filter_irq_stacks+0x27/0x80
[  139.017018]  ntfs_setxattr+0x405/0x440
[  139.022151]  ? __pfx_ntfs_setxattr+0x10/0x10
[  139.026569]  ? kvmalloc_node+0x2d/0x120
[  139.030329]  ? kasan_save_stack+0x41/0x60
[  139.033883]  ? kasan_save_stack+0x2a/0x60
[  139.037338]  ? kasan_set_track+0x29/0x40
[  139.040163]  ? kasan_save_alloc_info+0x1f/0x30
[  139.043588]  ? __kasan_kmalloc+0x8b/0xa0
[  139.047255]  ? __kmalloc_node+0x68/0x150
[  139.051264]  ? kvmalloc_node+0x2d/0x120
[  139.055301]  ? vmemdup_user+0x2b/0xa0
[  139.058584]  __vfs_setxattr+0x121/0x170
[  139.062617]  ? __pfx___vfs_setxattr+0x10/0x10
[  139.066282]  __vfs_setxattr_noperm+0x97/0x300
[  139.070061]  __vfs_setxattr_locked+0x145/0x170
[  139.073580]  vfs_setxattr+0x137/0x2a0
[  139.076641]  ? __pfx_vfs_setxattr+0x10/0x10
[  139.080223]  ? __kasan_check_write+0x18/0x20
[  139.084234]  do_setxattr+0xce/0x150
[  139.087768]  setxattr+0x126/0x140
[  139.091250]  ? __pfx_setxattr+0x10/0x10
[  139.094948]  ? __virt_addr_valid+0xcb/0x140
[  139.097838]  ? __call_rcu_common.constprop.0+0x1c7/0x330
[  139.102688]  ? debug_smp_processor_id+0x1b/0x30
[  139.105985]  ? kasan_quarantine_put+0x5b/0x190
[  139.109980]  ? putname+0x84/0xa0
[  139.113886]  ? __kasan_slab_free+0x11e/0x1b0
[  139.117961]  ? putname+0x84/0xa0
[  139.121316]  ? preempt_count_sub+0x1c/0xd0
[  139.124427]  ? __mnt_want_write+0xae/0x100
[  139.127836]  ? mnt_want_write+0x8f/0x150
[  139.130954]  path_setxattr+0x164/0x180
[  139.133998]  ? __pfx_path_setxattr+0x10/0x10
[  139.137853]  ? __pfx_ksys_pwrite64+0x10/0x10
[  139.141299]  ? debug_smp_processor_id+0x1b/0x30
[  139.145714]  ? fpregs_assert_state_consistent+0x6b/0x80
[  139.150796]  __x64_sys_setxattr+0x71/0x90
[  139.155407]  do_syscall_64+0x3f/0x90
[  139.159035]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  139.163843] RIP: 0033:0x7f108cae4469
[  139.166481] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 088
[  139.183764] RSP: 002b:00007fff87588388 EFLAGS: 00000286 ORIG_RAX: 00000000000000bc
[  139.190657] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f108cae4469
[  139.196586] RDX: 00007fff875883b0 RSI: 00007fff875883d1 RDI: 00007fff875883b6
[  139.201716] RBP: 00007fff8758c530 R08: 0000000000000001 R09: 00007fff8758c618
[  139.207940] R10: 0000000000000006 R11: 0000000000000286 R12: 00000000004004c0
[  139.214007] R13: 00007fff8758c610 R14: 0000000000000000 R15: 0000000000000000

Signed-off-by: Edward Lo <loyuantsung@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Alexey Panov <apanov@astralinux.ru>
---
Backport fix for CVE-2023-54125
 fs/ntfs3/xattr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 2e4eea854bda..7dc650b0b832 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -140,6 +140,7 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 
 	memset(Add2Ptr(ea_p, size), 0, add_bytes);
 
+	err = -EINVAL;
 	/* Check all attributes for consistency. */
 	for (off = 0; off < size; off += ea_size) {
 		const struct EA_FULL *ef = Add2Ptr(ea_p, off);
-- 
2.47.3
