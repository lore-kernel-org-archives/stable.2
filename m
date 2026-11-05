Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=95.168.196.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793919725;
	b=hFEwXXlg7qMaZPlC48jC8JXwI+mO7jglO5c/JItdZkQ+bymhRl/vxrmb7KJAM4TIidLm
	 GnD3AHXAUw14bCLDZBYP96Ts/RECarzSEQ22I4AEpLdmsgjIKU9cAkDuOrqgmdxp5JwjY
	 1Db0vFHtx+R1DhjfZJqoJc5jZE05Li54wT01wx0BFwVHuR7vtEBxgCI0122NAWjJKJGrn
	 MjdVhXgFfTsX4RcmdDZpnEAdoaLgwSNz1RH1iMpevXTpSl0TdweNHjeczPWfUwdgNJMB0
	 3rzwTchDNqMgEBnjT6NCRB5gG/yf918rhXaUuclYaIH80R7l9Fqwv3kiU5puOE3FBxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793919725;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:To:Content-Language:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding;
	bh=nFHu/TlZZs1BneDlNj6NXiK+WB40Jp5wWfhWo/Vu9Ag=;
	b=ZqKuo0bLfnsiS2XxV/UC/nAW0xvFIe0aayLeM1kL6/lRDQmbiW2G9qUgrRTXnYBJ6sv4
	 b+fvaCEgmOCvGJvmtcfcDqPbYNiDfPaoDX8PME2J2HSNIVpGdfVYxAcowiLZvkfh+Vea3
	 on32WsEJj5vunLsbCgQb91l18MDQnB5DcT8KQX6oTHdALzYaeTDUNi6UnBKN+8Y9WLuvV
	 VxdznogXRAlYr2R3B6qxFjPPnmCK0H5G+0cY/OtcaXk4E8BKj37hPf8RF5dbzK18y6j/9
	 GTdhungKuZaPwWyrgp86sqV/cwT3uakVNXDqgKgHBqqhofnJetEXh+umw+fWem+vyxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sh.cz;
	spf=pass smtp.mailfrom=sh.cz;
	dkim=pass header.d=sh.cz header.i=@sh.cz header.a=rsa-sha256 header.s=mail header.b=23kIa+JQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=95.168.196.40
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F07606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 23:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7F07606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sh.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sh.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sh.cz header.i=@sh.cz header.a=rsa-sha256 header.s=mail header.b=23kIa+JQ
ARC-Seal: i=1; a=rsa-sha256; t=1793919711; cv=none; d=sh.cz; s=mail;
   b=CwyM6VqHLuYGWvslljOb3cbJ4FgeT4I0kKhPYvN932eW07uoHJe+7J0cQaKUMsXTDDb+rRv4ndOAbq4Y+f0KWg9r+Z8vk/lddkUYoJ+z3XXqvpvkMM4ZIHWv3jWyV719CwaE5OCB7nR/WVgXVCsYervSUJNNWVsdbQfY0RjF+OKrsnuRIFGM0ZNp7J8Do69gqoGKaSLe+llsVwdvq8wn14QxFluPBhndUENpROatxytYVQpccpgMcG3Ju0ZuAnpu6k/p6nBVXK9vj7vyL2RzJH5abYfTlzQXrwFC5zZAR5rDNrvB31SgR2G/g9ZNnfLWOJk+G3qG+ceVBpOO7P5i7g==
ARC-Message-Signature: i=1; a=rsa-sha256; s=mail; d=sh.cz; c=relaxed/relaxed; bh=nFHu/TlZZs1BneDlNj6NXiK+WB40Jp5wWfhWo/Vu9Ag=; h=to:from:subject:message-id:date:mime-version:dkim-signature;
   b=9Y/xOOTsfWKMAuy1mKlQCDlcRscnPvtXOPVlY1dF8XMCr8lujm2sNCxHpY36p12zaglinrbZ8Xfwv4GZ9ISHfZY7yh/wNVttyBKU4Rb4+MFQzfYr9/tznK/dLmmSHJOWWceGC2LGrDExqPgC6UgIEdLl4jhf8TJ+h1sdHpZNHbesW5p8bsUMLKBN6W4eyyaPia+WmFWLsvDGlNovGPNnFXhhj72dJ4RP/vlpN2W1Cqlfr2gUSVUKuKjfHxZcVqL/U10v5lKHemDYsJUFNo3G2JirtrRSq4nB0psrCn3dFSml3uWunI+h7nWQbUj435KBAZs67Fb0Yff1iu85jNfL/A==
ARC-Authentication-Results: i=1; mail.sh.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; t=1793919711; x=1794524511; s=mail; d=sh.cz; c=relaxed/relaxed; bh=nFHu/TlZZs1BneDlNj6NXiK+WB40Jp5wWfhWo/Vu9Ag=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
   b=23kIa+JQRcND47wJGvFW0KMQ3JEfRpHq7cCXnjUMdSdynEGX5psS0ePiXljCDQrxo5As7Ym+tGyO41OAnZhNnLoZ3bWVCAMtXalNdsGs85fW8y5Zs66DEkvXZZ5xUP/6nj+qzIZ6QtKvlchCwniMpx/GOM57GRgPDptgaPNf9gziKpG64cyJswwYNaLlheNtrKi+TE8IArdNrDhny1XRO6Wu4SFEAit7CHqluJfyHthasJVukz3LDyhi1iIqfUCcNPv5tI7hYCELblUqcKUO4RSXF59d0PjQt9VvTZQ9eYBFxfSR405P4VHCaXa8r+jpL49wY60xQRhGXX/wH1FdVA==
Received: from [10.18.2.106] ([80.250.18.198])
        by mail.sh.cz (14.3.0 build 12 ) with ASMTP (SSL) id 202611060001508662;
        Fri, 06 Nov 2026 00:01:50 +0100
Message-ID: <3af016db-ce2d-4ed6-8f9a-13f31eb3ea9d@sh.cz>
Date: Fri, 6 Nov 2026 00:01:50 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: stable@vger.kernel.org
Content-Language: en-GB
Cc: regressions@lists.linux.dev
From: Marek Becka <marek.becka@sh.cz>
Subject: [REGRESSION] NULL pointer dereference in ext4_mb_load_buddy_gfp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

After updating from 6.1.190 to 6.1.191 we are expecting an NULL pointer 
dereference in function ext4_mb_load_buddy_gfp on multiple servers. It 
looks like folio_test_uptodate is called with NULL folio pointer in 
fs/ext4/mballoc.c:1536 .


There is an example of this crash:

[ 1678.841763] BUG: kernel NULL pointer dereference, address: 
0000000000000000
[ 1678.841821] #PF: supervisor read access in kernel mode
[ 1678.841854] #PF: error_code(0x0000) - not-present page
[ 1678.841877] PGD 0 P4D 0
[ 1678.841896] Oops: 0000 [#1] PREEMPT SMP PTI
[ 1678.841918] CPU: 11 PID: 10142 Comm: kworker/u82:2 Not tainted 6.1.191 #1
[ 1678.841946] Hardware name: Supermicro Super Server/X10DRW-E, BIOS 
2.0b 07/26/2016
[ 1678.841973] Workqueue: writeback wb_workfn (flush-253:4)
[ 1678.842006] RIP: 0010:ext4_mb_load_buddy_gfp+0xb5/0x370 [ext4]
[ 1678.842105] Code: c9 89 e8 99 f7 3c 24 4c 63 e8 89 54 24 0c ba 01 00 
00 00 4c 89 ee e8 4a e3 0d cf 49 89 c6 48 3d 00 f0 ff ff 0f 87 1f 01 00 
00 <48> 8b 00 a8 04 0f 84 09 01 00 00 49 8b 06 a8 01 0f 85 fe 00 00 00
[ 1678.842160] RSP: 0018:ffffd28d64597620 EFLAGS: 00010207
[ 1678.842184] RAX: 0000000000000000 RBX: ffffd28d64597700 RCX: 
0001a00330001005
[ 1678.842210] RDX: ffff8e100065f908 RSI: 0001a00330001005 RDI: 
ffff8e10208a6600
[ 1678.842236] RBP: 0000000000000064 R08: 0000000000000001 R09: 
ffff8e104df781a0
[ 1678.842261] R10: ffff8e100065f908 R11: 0000000000000090 R12: 
ffff8e008cde8800
[ 1678.842287] R13: 0000000000000064 R14: 0000000000000000 R15: 
ffff8e0094e062f0
[ 1678.842311] FS:  0000000000000000(0000) GS:ffff8e1fbf840000(0000) 
knlGS:0000000000000000
[ 1678.842340] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1678.842362] CR2: 0000000000000000 CR3: 0000000154c10001 CR4: 
00000000003706e0
[ 1678.842387] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 1678.842413] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[ 1678.842438] Call Trace:
[ 1678.842454]  <TASK>
[ 1678.842471]  ext4_mb_find_by_goal+0x91/0x260 [ext4]
[ 1678.842551]  ? __ext4_handle_dirty_metadata+0x5c/0x1b0 [ext4]
[ 1678.842620]  ext4_mb_regular_allocator+0x93/0xcc0 [ext4]
[ 1678.842705]  ext4_mb_new_blocks+0x7ba/0x1060 [ext4]
[ 1678.842792]  ? ext4_find_extent+0x18e/0x480 [ext4]
[ 1678.842864]  ext4_ext_map_blocks+0x951/0x18d0 [ext4]
[ 1678.842938]  ? release_pages+0x15a/0x490
[ 1678.842967]  ? __pagevec_release+0x1b/0x60
[ 1678.842992]  ext4_map_blocks+0x1b1/0x5c0 [ext4]
[ 1678.843073]  ext4_writepages+0x87e/0x1150 [ext4]
[ 1678.843162]  do_writepages+0x6e/0x1d0
[ 1678.843186]  __writeback_single_inode+0x41/0x350
[ 1678.843213]  writeback_sb_inodes+0x1ed/0x4c0
[ 1678.843239]  __writeback_inodes_wb+0x4c/0xf0
[ 1678.843263]  wb_writeback+0x172/0x2f0
[ 1678.843286]  wb_workfn+0x2b1/0x510
[ 1678.843310]  process_one_work+0x1d1/0x3a0
[ 1678.843334]  worker_thread+0x4d/0x380
[ 1678.843354]  ? process_one_work+0x3a0/0x3a0
[ 1678.843374]  kthread+0xda/0x100
[ 1678.843396]  ? kthread_complete_and_exit+0x20/0x20
[ 1678.844048]  ret_from_fork+0x22/0x30
[ 1678.844673]  </TASK>
[ 1678.845285] Modules linked in: netconsole binfmt_misc tcp_diag 
inet_diag 8021q garp stp mrp llc ipt_REJECT nf_reject_ipv4 xt_multiport 
xt_comment xt_tcpudp xt_u32 nft_compat nf_tables nfnetlink xfs 
intel_rapl_msr intel_rapl_common intel_uncore_frequency 
intel_uncore_frequency_common sb_edac x86_pkg_temp_thermal 
intel_powerclamp coretemp ipmi_ssif kvm_intel bfq kvm irqbypass 
ghash_clmulni_intel sha512_ssse3 sha512_generic sha256_ssse3 sha1_ssse3 
ast drm_vram_helper aesni_intel crypto_simd cryptd snd_pcm mei_me 
snd_timer drm_ttm_helper iTCO_wdt intel_pmc_bxt snd sg ttm 
iTCO_vendor_support joydev evdev rapl soundcore intel_cstate 
drm_kms_helper pcspkr ioatdma watchdog intel_uncore mei acpi_ipmi 
ipmi_si ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter button 
mii bonding tls drm configfs fuse ip_tables x_tables autofs4 ext4 crc16 
mbcache jbd2 raid10 raid456 async_raid6_recov async_memcpy async_pq 
async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid0 multipath 
linear
[ 1678.845432]  hid_generic usbhid hid dm_mod raid1 md_mod sd_mod t10_pi 
crc64_rocksoft crc64 crc_t10dif crct10dif_generic ahci libahci xhci_pci 
xhci_hcd libata ehci_pci ehci_hcd crct10dif_pclmul crct10dif_common 
crc32_pclmul crc32c_intel usbcore scsi_mod igb i2c_i801 lpc_ich 
i2c_smbus i2c_algo_bit scsi_common usb_common dca wmi
[ 1678.853096] CR2: 0000000000000000
[ 1678.853796] ---[ end trace 0000000000000000 ]---
[ 1678.911623] RIP: 0010:ext4_mb_load_buddy_gfp+0xb5/0x370 [ext4]
[ 1678.912558] Code: c9 89 e8 99 f7 3c 24 4c 63 e8 89 54 24 0c ba 01 00 
00 00 4c 89 ee e8 4a e3 0d cf 49 89 c6 48 3d 00 f0 ff ff 0f 87 1f 01 00 
00 <48> 8b 00 a8 04 0f 84 09 01 00 00 49 8b 06 a8 01 0f 85 fe 00 00 00
[ 1678.913921] RSP: 0018:ffffd28d64597620 EFLAGS: 00010207
[ 1678.914622] RAX: 0000000000000000 RBX: ffffd28d64597700 RCX: 
0001a00330001005
[ 1678.915341] RDX: ffff8e100065f908 RSI: 0001a00330001005 RDI: 
ffff8e10208a6600
[ 1678.916048] RBP: 0000000000000064 R08: 0000000000000001 R09: 
ffff8e104df781a0
[ 1678.916747] R10: ffff8e100065f908 R11: 0000000000000090 R12: 
ffff8e008cde8800
[ 1678.917449] R13: 0000000000000064 R14: 0000000000000000 R15: 
ffff8e0094e062f0
[ 1678.918153] FS:  0000000000000000(0000) GS:ffff8e1fbf840000(0000) 
knlGS:0000000000000000
[ 1678.918860] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1678.919574] CR2: 0000000000000000 CR3: 0000000154c10001 CR4: 
00000000003706e0
[ 1678.920297] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 1678.921018] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[ 1678.921736] note: kworker/u82:2[10142] exited with irqs disabled
[ 1678.922508] ------------[ cut here ]------------


