Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.63.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941312;
	b=5COrXGNvzrZFwa+ZBJ6FqGsZ8ptlVUYeaF1GChcKsZj7lQkrcmBU4qNzShFluDMHE7EB
	 BkTLln6PdVfj1GpbckfohXW9H12MUngUoE8MeBw8hFDOhUe6DoyyNgGlIZV3qWFOCU9BA
	 18c5CIjQr45uGuMWcTLDOzS9mL/++GUPYmzsPHevSHAF87VrgWIW+9WwiyE8cOsYLEbtk
	 0XSEJJRtsR1TGgBA2mxs1fgKdICU2Z5cem6fx9x0DQT3h5rK9X0sZ/UHlNSHCC2/qKwGg
	 RSdIvtuOH3vQAUNueNHEOnQ/dLAMuV/rTzSfvuFJ9VOp56OtmkDOlm2ysfFvduaocsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941312;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-NC-CID;
	bh=Y0AUU5E7/+rCxN0vdJ7as9H6oMmR7pe5wklE24oi3Ww=;
	b=vWA0OpFZrpvr3dk0//l1wlM0k7hoX4I+FaUmXSwOeX1z/gp6GNgqc3WHolaWQaeAzIOV
	 yEYoLxMicba89VphGAVkPpUiAxbjT4gcFVUVohejERgu55KkVXgJJaMjVc4tPTYYy1XlF
	 p+WNn727cR82POXNd0nV0ya/Gi4TIuPMBMpj8Fs46j26ga/jw00aoP8TNa8MdHbBlpPM1
	 TWQfAvxq3ahnWwGti5nfDroIZd9VmKqQYj+b1eeNlbrWASspMx+5x/9WPc9V3grm1NFCu
	 VR7aQiO+jmk84HGJrB+CwlyD2E9u1K7N9orZbOaF0Th4gss+mwP4lVl0Z3qCLwN2EsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=RLrzxMft;
	arc=none smtp.remote-ip=188.68.63.102
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E70606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 05:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75E70606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=RLrzxMft
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4jLRqB2Ngtz6J7C;
	Fri,  6 Nov 2026 06:01:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1793941302;
	bh=7qQnouvD+JAdZNOi6Kwdiln3omcULuDZkHSCg1KBGu4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RLrzxMftgd0UUqqTRx6cTwLfp5Vzry9TWyQSMrYwKszSReiHRGi2fTuR5CTTjvDZM
	 9j9nB6hh02TQkZRZnDy1hwdBcxSBlFZYbL64VVAxwx6uHxYBGM9xpzEr8Uw6cyYY9i
	 hlBaEqebkrT8l1NCl3xLwOvR4opzA0Wef7v8Ji1TluuOkCqfJCAzCB2llx9TH+ErNi
	 JICmrUtvD+lLlqBnWGaNAVBgHlbA7SU9v3QsWJfquW7VKF7qczcTJq1SgsXXQAH0vg
	 ACDN5q65y5iYRqCY40sDKPlpVM36So3ipddE8VuoBtU0vafqlGc1fmE6FkzCwDeGm4
	 tLJT1HgzIhvLA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4jLRqB1fkvz4xXG;
	Fri,  6 Nov 2026 06:01:42 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4jLRq959rbz8sgW;
	Fri,  6 Nov 2026 06:01:41 +0100 (CET)
Received: from [192.168.44.188] (unknown [185.238.219.126])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 792215FA05;
	Fri,  6 Nov 2026 06:01:32 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 185.238.219.126) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[192.168.44.188]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <afd31f34-5669-4d65-ad74-caaca5b7c176@leemhuis.info>
Date: Fri, 6 Nov 2026 06:01:31 +0100
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
Subject: Re: [REGRESSION] NULL pointer dereference in ext4_mb_load_buddy_gfp
To: Marek Becka <marek.becka@sh.cz>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev
References: <3af016db-ce2d-4ed6-8f9a-13f31eb3ea9d@sh.cz>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <3af016db-ce2d-4ed6-8f9a-13f31eb3ea9d@sh.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179394129276.378571.17530318651233681891@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 792215FA05
X-NC-CID: c7kBoASD3dW7g/tci+B1BH5TOUJ/UWmpALO/uSnIhftwEBMlGkY=

On 11/6/26 00:01, Marek Becka wrote:
> After updating from 6.1.190 to 6.1.191 we are expecting an NULL pointer
> dereference in function ext4_mb_load_buddy_gfp on multiple servers. It
> looks like folio_test_uptodate is called with NULL folio pointer in fs/
> ext4/mballoc.c:1536 .

From a very quick look this seems to be the problem that was reported
here earlier:
https://lore.kernel.org/linux-ext4/20261102-ext4-ntfs3-null-folio-v1-0-4fd91ee23a4a@elliotjb.com/

A fix for that is queued.

If it's a different problem, please speak up.

Ciao, Thorsten

> There is an example of this crash:
> 
> [ 1678.841763] BUG: kernel NULL pointer dereference, address:
> 0000000000000000
> [ 1678.841821] #PF: supervisor read access in kernel mode
> [ 1678.841854] #PF: error_code(0x0000) - not-present page
> [ 1678.841877] PGD 0 P4D 0
> [ 1678.841896] Oops: 0000 [#1] PREEMPT SMP PTI
> [ 1678.841918] CPU: 11 PID: 10142 Comm: kworker/u82:2 Not tainted
> 6.1.191 #1
> [ 1678.841946] Hardware name: Supermicro Super Server/X10DRW-E, BIOS
> 2.0b 07/26/2016
> [ 1678.841973] Workqueue: writeback wb_workfn (flush-253:4)
> [ 1678.842006] RIP: 0010:ext4_mb_load_buddy_gfp+0xb5/0x370 [ext4]
> [ 1678.842105] Code: c9 89 e8 99 f7 3c 24 4c 63 e8 89 54 24 0c ba 01 00
> 00 00 4c 89 ee e8 4a e3 0d cf 49 89 c6 48 3d 00 f0 ff ff 0f 87 1f 01 00
> 00 <48> 8b 00 a8 04 0f 84 09 01 00 00 49 8b 06 a8 01 0f 85 fe 00 00 00
> [ 1678.842160] RSP: 0018:ffffd28d64597620 EFLAGS: 00010207
> [ 1678.842184] RAX: 0000000000000000 RBX: ffffd28d64597700 RCX:
> 0001a00330001005
> [ 1678.842210] RDX: ffff8e100065f908 RSI: 0001a00330001005 RDI:
> ffff8e10208a6600
> [ 1678.842236] RBP: 0000000000000064 R08: 0000000000000001 R09:
> ffff8e104df781a0
> [ 1678.842261] R10: ffff8e100065f908 R11: 0000000000000090 R12:
> ffff8e008cde8800
> [ 1678.842287] R13: 0000000000000064 R14: 0000000000000000 R15:
> ffff8e0094e062f0
> [ 1678.842311] FS:  0000000000000000(0000) GS:ffff8e1fbf840000(0000)
> knlGS:0000000000000000
> [ 1678.842340] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1678.842362] CR2: 0000000000000000 CR3: 0000000154c10001 CR4:
> 00000000003706e0
> [ 1678.842387] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [ 1678.842413] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [ 1678.842438] Call Trace:
> [ 1678.842454]  <TASK>
> [ 1678.842471]  ext4_mb_find_by_goal+0x91/0x260 [ext4]
> [ 1678.842551]  ? __ext4_handle_dirty_metadata+0x5c/0x1b0 [ext4]
> [ 1678.842620]  ext4_mb_regular_allocator+0x93/0xcc0 [ext4]
> [ 1678.842705]  ext4_mb_new_blocks+0x7ba/0x1060 [ext4]
> [ 1678.842792]  ? ext4_find_extent+0x18e/0x480 [ext4]
> [ 1678.842864]  ext4_ext_map_blocks+0x951/0x18d0 [ext4]
> [ 1678.842938]  ? release_pages+0x15a/0x490
> [ 1678.842967]  ? __pagevec_release+0x1b/0x60
> [ 1678.842992]  ext4_map_blocks+0x1b1/0x5c0 [ext4]
> [ 1678.843073]  ext4_writepages+0x87e/0x1150 [ext4]
> [ 1678.843162]  do_writepages+0x6e/0x1d0
> [ 1678.843186]  __writeback_single_inode+0x41/0x350
> [ 1678.843213]  writeback_sb_inodes+0x1ed/0x4c0
> [ 1678.843239]  __writeback_inodes_wb+0x4c/0xf0
> [ 1678.843263]  wb_writeback+0x172/0x2f0
> [ 1678.843286]  wb_workfn+0x2b1/0x510
> [ 1678.843310]  process_one_work+0x1d1/0x3a0
> [ 1678.843334]  worker_thread+0x4d/0x380
> [ 1678.843354]  ? process_one_work+0x3a0/0x3a0
> [ 1678.843374]  kthread+0xda/0x100
> [ 1678.843396]  ? kthread_complete_and_exit+0x20/0x20
> [ 1678.844048]  ret_from_fork+0x22/0x30
> [ 1678.844673]  </TASK>
> [ 1678.845285] Modules linked in: netconsole binfmt_misc tcp_diag
> inet_diag 8021q garp stp mrp llc ipt_REJECT nf_reject_ipv4 xt_multiport
> xt_comment xt_tcpudp xt_u32 nft_compat nf_tables nfnetlink xfs
> intel_rapl_msr intel_rapl_common intel_uncore_frequency
> intel_uncore_frequency_common sb_edac x86_pkg_temp_thermal
> intel_powerclamp coretemp ipmi_ssif kvm_intel bfq kvm irqbypass
> ghash_clmulni_intel sha512_ssse3 sha512_generic sha256_ssse3 sha1_ssse3
> ast drm_vram_helper aesni_intel crypto_simd cryptd snd_pcm mei_me
> snd_timer drm_ttm_helper iTCO_wdt intel_pmc_bxt snd sg ttm
> iTCO_vendor_support joydev evdev rapl soundcore intel_cstate
> drm_kms_helper pcspkr ioatdma watchdog intel_uncore mei acpi_ipmi
> ipmi_si ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter button
> mii bonding tls drm configfs fuse ip_tables x_tables autofs4 ext4 crc16
> mbcache jbd2 raid10 raid456 async_raid6_recov async_memcpy async_pq
> async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid0 multipath
> linear
> [ 1678.845432]  hid_generic usbhid hid dm_mod raid1 md_mod sd_mod t10_pi
> crc64_rocksoft crc64 crc_t10dif crct10dif_generic ahci libahci xhci_pci
> xhci_hcd libata ehci_pci ehci_hcd crct10dif_pclmul crct10dif_common
> crc32_pclmul crc32c_intel usbcore scsi_mod igb i2c_i801 lpc_ich
> i2c_smbus i2c_algo_bit scsi_common usb_common dca wmi
> [ 1678.853096] CR2: 0000000000000000
> [ 1678.853796] ---[ end trace 0000000000000000 ]---
> [ 1678.911623] RIP: 0010:ext4_mb_load_buddy_gfp+0xb5/0x370 [ext4]
> [ 1678.912558] Code: c9 89 e8 99 f7 3c 24 4c 63 e8 89 54 24 0c ba 01 00
> 00 00 4c 89 ee e8 4a e3 0d cf 49 89 c6 48 3d 00 f0 ff ff 0f 87 1f 01 00
> 00 <48> 8b 00 a8 04 0f 84 09 01 00 00 49 8b 06 a8 01 0f 85 fe 00 00 00
> [ 1678.913921] RSP: 0018:ffffd28d64597620 EFLAGS: 00010207
> [ 1678.914622] RAX: 0000000000000000 RBX: ffffd28d64597700 RCX:
> 0001a00330001005
> [ 1678.915341] RDX: ffff8e100065f908 RSI: 0001a00330001005 RDI:
> ffff8e10208a6600
> [ 1678.916048] RBP: 0000000000000064 R08: 0000000000000001 R09:
> ffff8e104df781a0
> [ 1678.916747] R10: ffff8e100065f908 R11: 0000000000000090 R12:
> ffff8e008cde8800
> [ 1678.917449] R13: 0000000000000064 R14: 0000000000000000 R15:
> ffff8e0094e062f0
> [ 1678.918153] FS:  0000000000000000(0000) GS:ffff8e1fbf840000(0000)
> knlGS:0000000000000000
> [ 1678.918860] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1678.919574] CR2: 0000000000000000 CR3: 0000000154c10001 CR4:
> 00000000003706e0
> [ 1678.920297] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [ 1678.921018] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [ 1678.921736] note: kworker/u82:2[10142] exited with irqs disabled
> [ 1678.922508] ------------[ cut here ]------------

