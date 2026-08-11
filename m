Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81143C872C
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469275; cv=pass; b=tWxpn1eeVl9S5a9zR3Q6Wjy2+ChVb83qzsNot8z/0sIYuO8L0WvhQbJvMNglGNiFsGt57C8IuIjjZJGNHSL4ICu1Ed2hqMCIawmWjmaWt4s/T+QOaBCVd+S7MM4vBcIxatVh67b2Wto+oAYqueSzU15HjkxxK8UrUAlkS9CASAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469275; c=relaxed/simple;
	bh=i09sJbHoR5VpdzRu+F5q6mk3W5jHaRhhLorlS89BdYU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Akas7AvweOn3CuXofC+gXEMiZ76VXO6HsMnD0xEc3c36C6UbGn8n0paoYIMO/4FyQ+2o1OkHDbZF0dj4YTG3W98vX1lFQzkzKFgvaATOjTeet+wYcnT6Nmt5i3V9c1+9tw7enzet0HPldUQgnM1eBntFjvMOLqji+AEzDa5bpzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com; spf=pass smtp.mailfrom=zadarastorage.com; dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b=IHWdbxoH; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zadarastorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b="IHWdbxoH"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso118579b3a.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 10:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786469273; cv=none;
        d=google.com; s=arc-20260327;
        b=EIoFXHVTKmWdPPcc0I6yWSIm0J+L6QSqB+HTVamObKK3Qgm+X6JLwMhAG9B7WeoWI0
         uhscMV9mumpcvT/KKZlSDX+gVo68xhWD/eHvdkT2x/3HbMXxrTsQIwn+phtJUNIsCjlH
         WU75wGclkfae8vDKHLjipEHJsdUBcQsvcKKi+WqZWIGE7LbXndsUArPVvgegicXGu4Xu
         unHjx0I6YzRz5AkuNGkOQaxVfNqQ4FZJp4h/f0Wb09X0a+/hIO8xanb9/ejZui0r+kbw
         78OhiTSwM1H24HmHpEncMgBqsl962YV3Z6+AzdmzxeQKRtt7HPj22knZfSCMYQv+cQ6F
         JN9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=i09sJbHoR5VpdzRu+F5q6mk3W5jHaRhhLorlS89BdYU=;
        fh=RvEWwL4CdzthXqFPrJY1v5EhszSUJtREhzms1oh7XMQ=;
        b=jTWznUe+o9uFTnSAG6pfSdYmDgzTbMDG0Ka+a1AZMOZDBFyKHlDjpc2ED5R1keRMR6
         1UC6VwPa7hT/aEq+W67es1N+dlOx6reGtzOX+yk1cxzeuapkDSANZfXc488RXACRD5HJ
         LfC49ItSFYpyTQmySI25GMraoI/pzYgOiEhFomLryWlxQ5NarOdvjeS/iCof/rfeOyy9
         MtCVbvw8wnoqhgrQFOzlKrOuSU/QzhmZ646gJjSTRL6ZNP9UyfqNx5sk1HIkU7fQa8Ti
         +pmFtTFF5T3LGbCRZg0sUkv47hpjD/RBSR1bfCztbHwdsnyo1IfZM+oncVaSM4XuWKFA
         +fwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara.com; s=google; t=1786469273; x=1787074073; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=i09sJbHoR5VpdzRu+F5q6mk3W5jHaRhhLorlS89BdYU=;
        b=IHWdbxoHSloDFMpu7CTgRsyToccKxH2tUwaTBx+GEHKMlgQbs55vnml0V+Leg+eeIe
         iJuTBurHVk0cab1WwyljU/dL8XVHAix/Oo7HilRBVM1CArp7qmUwYk5Djlf6L78+Joto
         CaoJQNZQmkzDRcVnAeRNrG+MOggaVpMchVDPa9gnhzV4Vpxp+6yhICaXfMenOEdVbKvx
         sToPuU5PAiPUMryZelHK3zXKLn4MTwp/SjEfpWUpbNS79HGCWR3uvnA/IWkyzFamUQfb
         BqXp9ATgjtqC8x6YSkNvOtSMzvelo16YqXU77kRUHhcH72ysi8sfy6DMbo1Ce9h4msNg
         LFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786469273; x=1787074073;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i09sJbHoR5VpdzRu+F5q6mk3W5jHaRhhLorlS89BdYU=;
        b=C2ICSqVkF/tMPEcOmsML+B9Bkj/76jNlto6VFPCgFTe7hNkiuB+7QJV2OzydTtvCAh
         RD+yfW1rEqXQWiQyDpDMi+qO2OK8mZmZM5COA9S9pQdv2C5QKS7FCKbyTCap5fewBQ2w
         rHbekE5ghydIZjW/g3G3OpHW1BJgB8ultUsZoVRrBM0qAHPPyoZWPEoF7H/bTG+bs0yR
         QZ7fH0Cg7/5GHhGXNLJSWKIy+3zWewsa5SKO1l5HCnO3E7CQoH1yQu3GpfrTP8sFC6oS
         +4hmFauGZ1ufszHcnWjThIUSSpH005gmpV39LrlbF6nIztjNTmbsvOOwGD03A3k6WNOo
         NSTg==
X-Gm-Message-State: AOJu0YziPrXr42jtoEZrT00CCjg7qGuEVMlzI6T8a7dlA2RM7pMYKOTg
	K/2Kdc3RAZXr/QJOnNawchGkVVl+pk/SNPlfVbMVS32NM5DwTMrqHiTIAEQlNKXGAi11myku9fr
	LHMG2xg7yX5fys2H1U9PthqzKj6rQxYk3g8Em/7f/Y6SQVFuH3RTK+ipR/w==
X-Gm-Gg: AR+sD10zYK7oSYCUOZKpjb2rcjrtRJhAoxNukyLT7z1oXacrwG0aQVO9LkbqbTdlcZl
	X/C2Y8p47c2fTpqEkeRVjidrxFDtglRz+iJJND+NhmmCuFDlki1ieKQoCy9MxAKR4UrmqVQP5mq
	WM1EqQTHPBzBsJxSR5vawv+TQ83brwfzSpjLD/MO1YaylkseLTs7qIPrnjb11KPDP7UQQNHYkNt
	u2KlnZDEyeqTveQ0T283EehQUY4d1453pQs8rDZ0CU1uF8xnj6En8EHQaY3IbAvWivbGFThzd1c
	KC0AgxDIinAzL0m9JSBSL1VD77J4CubMeCihoVnaICI=
X-Received: by 2002:a05:6a00:b83:b0:84e:244a:98e8 with SMTP id
 d2e1a72fcca58-84fa88633b7mr4905667b3a.30.1786469272585; Tue, 11 Aug 2026
 10:27:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alex Lyakas <alex.lyakas@zadara.com>
Date: Tue, 11 Aug 2026 20:27:42 +0300
X-Gm-Features: AUfX_mwINBAeIiGiLOUCnAhpAC8CqM6Oy3VwUa7fZRMlCojXDsq8ki34oYIzCE8
Message-ID: <CAOcd+r2bxm_T5ZzYGfrYUjsbY8Kj=OgeCcdg1c4Msi01A0imdQ@mail.gmail.com>
Subject: linux 6.6.146: NULL pointer dereference in update_curr+0x149
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Greetings,

We hit the following kernel panic in stable kernel 6.6.146 [1].

Any help appreciated.

Thanks,
Alex.


[1]

[ T4534] BUG: kernel NULL pointer dereference, address: 0000000000000001
[ T4534] #PF: supervisor write access in kernel mode
[ T4534] #PF: error_code(0x0002) - not-present page
[ T4534] PGD 0 P4D 0
[ T4534] Oops: 0002 [#1] PREEMPT SMP PTI
[ T4534] CPU: 8 PID: 4534 Comm: zadara_osm Kdump: loaded Tainted: G OE
6.6.146+zadara1 #1
[ T4534] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.10.2-1ubuntu1 04/01/2014
[ T4534] RIP: 0010:update_curr+0x149/0x1d0
[ T4534] Code: 00 00 48 8b 78 78 48 83 bf c0 00 00 00 00 0f 84 42 ff
ff ff 4c 89 e6 e8 65 67 0b 00 e9 35 ff ff ff 48 89 de 48 89 c7 e8 35
ca <ff> ff 48 03 43 68 48 89 43 68 49 89 c5 48 3b 43 28 0f 88 03 ff ff
[ T4534] RSP: 0018:ffffd07502bb7c50 EFLAGS: 00010002
[ T4534] RAX: 0000000000001ba2 RBX: ffff8c23087cda00 RCX: 0000000000000001
[ T4534] RDX: 00004a4f0bf51420 RSI: ffff8c23087cda00 RDI: 00004a4f0bf51421
[ T4534] RBP: ffff8c2df8433440 R08: ffff8c23087c7700 R09: 0000000000000145
[ T4534] R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000001ba2
[ T4534] R13: ffff8c23087cda00 R14: 0000000000000000 R15: 0000000000000009
[ T4534] FS: 00007f290affe6c0(0000) GS:ffff8c2df8400000(0000)
knlGS:0000000000000000
[ T4534] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ T4534] CR2: 0000000000000001 CR3: 000000010ee1a003 CR4: 00000000003706e0
[ T4534] Call Trace:
[ T4534] <TASK>
[ T4534] reweight_entity+0x1b9/0x210
[ T4534] dequeue_task_fair+0x13c/0x3a0
[ T4534] __schedule+0x691/0xb10
[ T4534] schedule+0x5e/0xd0
[ T4534] futex_wait_queue+0x63/0x90
[ T4534] futex_wait+0x189/0x270
[ T4534] ? __pfx_hrtimer_wakeup+0x10/0x10
[ T4534] do_futex+0xc6/0x190
[ T4534] __x64_sys_futex+0x129/0x1e0
[ T4534] do_syscall_64+0x39/0x90
[ T4534] entry_SYSCALL_64_after_hwframe+0x78/0xe2
[ T4534] RIP: 0033:0x7f2938c98e51
[ T4534] Code: 48 89 4d c8 e8 00 f8 ff ff 4c 8b 55 c8 8b 75 dc 45 31
c0 41 89 c5 48 8b 7d d0 41 b9 ff ff ff ff 44 89 e2 b8 ca 00 00 00 0f
05 <44> 89 ef 48 89 c3 e8 54 f8 ff ff e9 65 ff ff ff 0f 1f 80 00 00 00
[ T4534] RSP: 002b:00007f290affc130 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
[ T4534] RAX: ffffffffffffffda RBX: 00007f290ea97bc0 RCX: 00007f2938c98e51
[ T4534] RDX: 0000000000000000 RSI: 0000000000000189 RDI: 00007f290ea97be8
[ T4534] RBP: 00007f290affc170 R08: 0000000000000000 R09: 00000000ffffffff
[ T4534] R10: 00007f290affc2a0 R11: 0000000000000246 R12: 0000000000000000
[ T4534] R13: 0000000000000000 R14: 00007f290ea97b80 R15: 00007f290ea97be8
[ T4534] </TASK>
[ T4534] Modules linked in: algif_hash af_alg xfs(OE) sd_mod sg
ib_iser(OE) libiscsi(OE) 8021q garp mrp scsi_transport_iscsi(OE)
bonding xfrm_user xfrm_algo xt_set ip_set xt_addrtype nf_tables
nls_iso8859_1 ip_vs xt_CHECKSUM xt_MASQUERADE dm_crypt(OE)
xt_conntrack raid456(OE) async_raid6_recov async_memcpy async_pq
async_xor async_tx ipt_REJECT xor nf_reject_ipv4 xt_tcpudp raid6_pq
raid1(OE) md_mod(OE) ip6table_mangle ip6table_nat ip6table_filter
ip6_tables iptable_mangle iptable_nat nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_filter bridge stp llc
dm_iostat(OE) dm_zerror(OE) overlay zadara_utils(OE) sch_fq_codel
rdma_ucm(OE) nvme(OE) nvme_rdma(OE) rdma_cm(OE) iw_cm(OE) ib_cm(OE)
nvme_fabrics(OE) nvme_core(OE) t10_pi crc64_rocksoft_generic
crc64_rocksoft crc64 mlx5_ib(OE) ib_uverbs(OE) ib_core(OE)
mlx5_fwctl(OE) macsec fwctl(OE) intel_rapl_msr intel_rapl_common
kvm_intel kvm irqbypass crct10dif_pclmul ghash_clmulni_intel
sha512_ssse3 sha256_ssse3 sha1_ssse3 aesni_intel crypto_simd cryptd
[ T4534] input_leds joydev i2c_piix4 mac_hid serio_raw sunrpc
binfmt_misc mlx5_core(OE) mlxdevm(OE) mlxfw(OE) mlx_compat(OE) psample
tls ptp pps_core pci_hyperv_intf msr i6300esb efi_pstore dm_mod(OE)
nfnetlink dmi_sysfs qemu_fw_cfg ip_tables x_tables autofs4 ata_generic
pata_acpi drm_shmem_helper drm_kms_helper ata_piix libata drm
crc32_pclmul virtio_net psmouse scsi_mod(OE) net_failover virtio_blk
failover scsi_common
[ T4534] CR2: 0000000000000001
